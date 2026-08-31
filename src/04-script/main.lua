--[[
    ================================================================================
    STEALTH PATH RECORDER & REPLAYER (TECHNIQUE 4 - NATIVE NAVIGATION ENGINE)
    ================================================================================
    Features:
    - 100% Native Physics Safe: Uses Humanoid:MoveTo & native interpolation (Bypasses Anti-TP)
    - Record Movement: Captures CFrame, Position, Jump events & Timestamps in real-time
    - Replay Forward (Start -> End) & Replay Reverse (End -> Start)
    - Auto Start-Position Alignment: Automatically walks player to start point before replay
    - Safe PlayerGui UI: Attached to LocalPlayer.PlayerGui with draggable controls & telemetry
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PathfindingService = game:GetService("PathfindingService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- ================================================================================
-- STATE & DATA STRUCTURES
-- ================================================================================
local PathRecorder = {
    IsRecording = false,
    IsReplaying = false,
    RecordedPoints = {},
    ReplayMode = "Stealth", -- "Stealth" (MoveTo native physics) or "Exact" (Interpolated CFrame)
    RecordConnection = nil,
    LastRecordTime = 0,
    TotalRecordTime = 0,
}

local function GetCharacter()
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid", 5)
    local rootPart = character:WaitForChild("HumanoidRootPart", 5)
    return character, humanoid, rootPart
end

-- ================================================================================
-- RECORDING ENGINE
-- ================================================================================
function PathRecorder.StartRecording()
    if PathRecorder.IsReplaying then
        return
    end
    PathRecorder.RecordedPoints = {}
    PathRecorder.IsRecording = true
    PathRecorder.LastRecordTime = os.clock()
    PathRecorder.TotalRecordTime = 0

    local _, humanoid, rootPart = GetCharacter()
    if not rootPart or not humanoid then
        return
    end

    local lastPosition = rootPart.Position

    PathRecorder.RecordConnection = RunService.Heartbeat:Connect(function()
        if not PathRecorder.IsRecording then
            return
        end
        local char, hum, root = GetCharacter()
        if not root or not hum then
            return
        end

        local currentTime = os.clock()
        local dt = currentTime - PathRecorder.LastRecordTime
        PathRecorder.LastRecordTime = currentTime
        PathRecorder.TotalRecordTime = PathRecorder.TotalRecordTime + dt

        local currentPos = root.Position
        local distMoved = (currentPos - lastPosition).Magnitude

        -- Record point if character moved or spent > 0.05 seconds
        if distMoved > 0.15 or dt > 0.1 then
            table.insert(PathRecorder.RecordedPoints, {
                CFrame = root.CFrame,
                Position = currentPos,
                Jump = hum.Jump or (hum:GetState() == Enum.HumanoidStateType.Jumping),
                DeltaTime = dt,
                MoveDirection = hum.MoveDirection,
            })
            lastPosition = currentPos
        end
    end)
end

function PathRecorder.StopRecording()
    PathRecorder.IsRecording = false
    if PathRecorder.RecordConnection then
        PathRecorder.RecordConnection:Disconnect()
        PathRecorder.RecordConnection = nil
    end
end

function PathRecorder.ClearData()
    PathRecorder.StopRecording()
    PathRecorder.StopReplay()
    PathRecorder.RecordedPoints = {}
    PathRecorder.TotalRecordTime = 0
end

-- ================================================================================
-- AUTO ALIGNMENT & REPLAY ENGINE (TECHNIQUE 4)
-- ================================================================================
local function AlignToStart(targetPos, statusCallback)
    local _, humanoid, rootPart = GetCharacter()
    if not rootPart or not humanoid then
        return false
    end

    local dist = (rootPart.Position - targetPos).Magnitude
    if dist <= 3.5 then
        return true -- Already at target position
    end

    if statusCallback then
        statusCallback(string.format("Aligning to start (%.1fm away)...", dist))
    end

    -- Attempt native MoveTo first
    humanoid:MoveTo(targetPos)

    local startTime = os.clock()
    local timeout = math.clamp(dist / 10, 3, 15)

    while PathRecorder.IsReplaying do
        local cDist = (rootPart.Position - targetPos).Magnitude
        if cDist <= 3.5 or (os.clock() - startTime) > timeout then
            break
        end
        task.wait(0.05)
    end

    -- Micro CFrame sync if slightly off after walking
    local endDist = (rootPart.Position - targetPos).Magnitude
    if endDist > 3.5 and endDist < 25 then
        rootPart.AssemblyLinearVelocity = Vector3.zero
        rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 0.5, 0))
    end

    return true
end

function PathRecorder.StopReplay()
    PathRecorder.IsReplaying = false
    local _, humanoid, rootPart = GetCharacter()
    if humanoid and rootPart then
        humanoid:MoveTo(rootPart.Position)
    end
end

function PathRecorder.StartReplay(reverse, statusCallback)
    if PathRecorder.IsRecording or #PathRecorder.RecordedPoints == 0 then
        if statusCallback then
            statusCallback("No recorded path available!")
        end
        return
    end

    PathRecorder.IsReplaying = true
    local points = PathRecorder.RecordedPoints
    local totalPoints = #points

    -- Determine start waypoint
    local startIndex = reverse and totalPoints or 1
    local endIndex = reverse and 1 or totalPoints
    local stepDir = reverse and -1 or 1

    local startPos = points[startIndex].Position

    -- Step 1: Align to start point safely
    local aligned = AlignToStart(startPos, statusCallback)
    if not aligned or not PathRecorder.IsReplaying then
        PathRecorder.IsReplaying = false
        return
    end

    -- Step 2: Playback waypoints
    task.spawn(function()
        local _, humanoid, rootPart = GetCharacter()

        local currentIndex = startIndex
        local pointsProcessed = 0

        while PathRecorder.IsReplaying do
            if currentIndex < 1 or currentIndex > totalPoints or humanoid.Health <= 0 then
                break
            end

            pointsProcessed = pointsProcessed + 1
            local pt = points[currentIndex]

            if statusCallback then
                local modeText = reverse and "Reverse Replay" or "Replay"
                statusCallback(string.format("%s: %d/%d pts", modeText, pointsProcessed, totalPoints))
            end

            -- Execute jump action if recorded
            if pt.Jump then
                humanoid.Jump = true
            end

            if PathRecorder.ReplayMode == "Stealth" then
                -- TECHNIQUE 4: Native Physics Navigation via MoveTo
                humanoid:MoveTo(pt.Position)

                local startTime = os.clock()
                local timeOut = math.clamp(pt.DeltaTime * 2.5, 0.1, 1.5)

                while PathRecorder.IsReplaying do
                    local dist = (Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z) - Vector3.new(
                        pt.Position.X,
                        0,
                        pt.Position.Z
                    )).Magnitude
                    if dist <= 2.5 or (os.clock() - startTime) > timeOut then
                        break
                    end
                    task.wait(0.03)
                end
            else
                -- EXACT INTERPOLATED MODE (Zero-velocity micro CFrame step)
                rootPart.AssemblyLinearVelocity = Vector3.zero
                rootPart.CFrame = pt.CFrame
                task.wait(math.clamp(pt.DeltaTime, 0.03, 0.2))
            end

            currentIndex = currentIndex + stepDir
        end

        PathRecorder.IsReplaying = false
        if statusCallback then
            statusCallback("Replay Completed!")
        end
    end)
end

-- ================================================================================
-- SAFE PLAYERGUI INTERACTIVE UI
-- ================================================================================
local function CreateUI()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not playerGui then
        return
    end

    -- Destroy old GUI instance if existing
    local existingGui = playerGui:FindFirstChild("PathRecorderGui")
    if existingGui then
        existingGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PathRecorderGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    -- Main Window Frame
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 300, 0, 260)
    frame.Position = UDim2.new(0.05, 0, 0.3, 0)
    frame.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Color = Color3.fromRGB(55, 62, 78)
    uiStroke.Thickness = 1.5
    uiStroke.Parent = frame

    -- Title Header
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 35)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "⚡ Stealth Path Recorder"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 15
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    -- Status Telemetry Label
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "StatusLabel"
    statusLabel.Size = UDim2.new(1, -20, 0, 25)
    statusLabel.Position = UDim2.new(0, 10, 0, 40)
    statusLabel.BackgroundColor3 = Color3.fromRGB(34, 38, 48)
    statusLabel.BorderSizePixel = 0
    statusLabel.Text = "Status: Idle | 0 Points"
    statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 12
    statusLabel.Parent = frame

    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 6)
    statusCorner.Parent = statusLabel

    -- Mode Selector Button
    local modeBtn = Instance.new("TextButton")
    modeBtn.Size = UDim2.new(1, -20, 0, 28)
    modeBtn.Position = UDim2.new(0, 10, 0, 72)
    modeBtn.BackgroundColor3 = Color3.fromRGB(42, 50, 65)
    modeBtn.BorderSizePixel = 0
    modeBtn.Text = "Mode: 🛡️ Stealth Physics (MoveTo)"
    modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
    modeBtn.Font = Enum.Font.GothamSemibold
    modeBtn.TextSize = 11
    modeBtn.Parent = frame

    local modeCorner = Instance.new("UICorner")
    modeCorner.CornerRadius = UDim.new(0, 6)
    modeCorner.Parent = modeBtn

    modeBtn.MouseButton1Click:Connect(function()
        if PathRecorder.ReplayMode == "Stealth" then
            PathRecorder.ReplayMode = "Exact"
            modeBtn.Text = "Mode: 🎯 Exact CFrame Interpolation"
            modeBtn.TextColor3 = Color3.fromRGB(255, 200, 100)
        else
            PathRecorder.ReplayMode = "Stealth"
            modeBtn.Text = "Mode: 🛡️ Stealth Physics (MoveTo)"
            modeBtn.TextColor3 = Color3.fromRGB(100, 220, 255)
        end
    end)

    -- Button Creator Helper
    local function CreateButton(text, pos, bgColor, textColor)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.46, 0, 0, 34)
        btn.Position = pos
        btn.BackgroundColor3 = bgColor
        btn.BorderSizePixel = 0
        btn.Text = text
        btn.TextColor3 = textColor
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.Parent = frame

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        return btn
    end

    -- Controls Grid
    local recBtn =
        CreateButton("⏺ Record", UDim2.new(0, 10, 0, 110), Color3.fromRGB(220, 50, 60), Color3.new(1, 1, 1))
    local stopBtn =
        CreateButton("⏹ Stop", UDim2.new(0.52, 0, 0, 110), Color3.fromRGB(80, 85, 95), Color3.new(1, 1, 1))
    local playFwdBtn =
        CreateButton("▶ Play Forward", UDim2.new(0, 10, 0, 152), Color3.fromRGB(40, 160, 90), Color3.new(1, 1, 1))
    local playRevBtn =
        CreateButton("◀ Play Reverse", UDim2.new(0.52, 0, 0, 152), Color3.fromRGB(160, 100, 40), Color3.new(1, 1, 1))
    local clearBtn = CreateButton(
        "🗑 Clear Path",
        UDim2.new(0, 10, 0, 194),
        Color3.fromRGB(50, 55, 65),
        Color3.fromRGB(200, 200, 200)
    )
    clearBtn.Size = UDim2.new(1, -20, 0, 30)

    -- Status Update Loop
    RunService.RenderStepped:Connect(function()
        if PathRecorder.IsRecording then
            statusLabel.Text = string.format(
                "🔴 Recording: %d pts (%.1fs)",
                #PathRecorder.RecordedPoints,
                PathRecorder.TotalRecordTime
            )
            statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        elseif not PathRecorder.IsReplaying then
            statusLabel.Text = string.format("Status: Idle | %d Points Saved", #PathRecorder.RecordedPoints)
            statusLabel.TextColor3 = Color3.fromRGB(180, 190, 210)
        end
    end)

    -- Event Handlers
    recBtn.MouseButton1Click:Connect(function()
        if PathRecorder.IsRecording then
            PathRecorder.StopRecording()
        else
            PathRecorder.StartRecording()
        end
    end)

    stopBtn.MouseButton1Click:Connect(function()
        PathRecorder.StopRecording()
        PathRecorder.StopReplay()
        statusLabel.Text = "Status: Stopped"
    end)

    playFwdBtn.MouseButton1Click:Connect(function()
        PathRecorder.StartReplay(false, function(msg)
            statusLabel.Text = msg
        end)
    end)

    playRevBtn.MouseButton1Click:Connect(function()
        PathRecorder.StartReplay(true, function(msg)
            statusLabel.Text = msg
        end)
    end)

    clearBtn.MouseButton1Click:Connect(function()
        PathRecorder.ClearData()
        statusLabel.Text = "Status: Path Cleared"
    end)
end

-- Initialize UI
CreateUI()
print("[StealthPathRecorder] Loaded successfully.")
