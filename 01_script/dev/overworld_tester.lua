--[[
    ================================================================================
    CUPID DUNGEON ENGINE - OVERWORLD TESTER
    ================================================================================
    Instructions:
    1. Spawns a GUI to test the EXACT physics, rate-limited Geppo, and combat mechanics 
       used in cupid-v2.lua, but without place guards or dungeon step requirements.
    2. "Target Hover": Finds the nearest Character (NPC or Player) and hovers/CF-locks
       10.3 studs above them (like the main bot does in combat).
    3. "Dodge Jump (70 studs)": Flies 70 studs in the air and holds (simulates the Queen dodge).
    4. "Stop": Disables flight and cleans up forces.
    5. Death Detection: If you die while active, it auto-disables.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace

local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = "idle" -- "idle" | "hover" | "dodge"

local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5 -- Rate-limited to avoid remote bans

local HOVER_OFFSET = 10.3
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5

local currentHoverOffset = HOVER_OFFSET
local currentDodgeHeight = 70

local function debug(...)
    print("[OverworldTester]", ...)
end

local function getHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildWhichIsA("Humanoid")
end

-- ========================= GEPPO RATE-LIMITER =========================
local function invokeGeppo()
    local now = tick()
    if now - lastGeppoTime < GEPPO_COOLDOWN then
        return
    end
    lastGeppoTime = now

    local ok, err = pcall(function()
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
        if not statsFolder then
            return
        end
        local style = statsFolder.Stats.FightingStyle.Value
        local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
        local args = { char = char, cf = cf }
        if style == "Rokushiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("Geppo", args)
        elseif style == "BlackLeg" then
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk", args)
        elseif style == "Kamishiki" then
            ReplicatedStorage.Events.Skill:InvokeServer("KamishikiGeppo", args)
        else
            ReplicatedStorage.Events.Skill:InvokeServer("Sky Walk2", args)
        end
        debug("Fired Geppo Remote")
    end)
    if not ok then
        debug("invokeGeppo error:", err)
    end
end

-- ========================= FORCE ENGINE =========================
local function getOrCreateForce(root)
    local ok, result = pcall(function()
        local att = root:FindFirstChild("__TestHoverAtt") or Instance.new("Attachment")
        att.Name = "__TestHoverAtt"
        att.Parent = root
        local force = root:FindFirstChild("__TestHoverForce")
        if not force then
            force = Instance.new("LinearVelocity")
            force.Name = "__TestHoverForce"
            force.Attachment0 = att
            force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
            force.RelativeTo = Enum.ActuatorRelativeTo.World
            force.MaxForce = 1000000
            force.VectorVelocity = Vector3.new(0, 0, 0)
            force.Parent = root
        end
        return force
    end)
    if ok then
        return result
    end
    return nil
end

local function cleanupForce()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then
            return
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then
            return
        end
        local force = root:FindFirstChild("__TestHoverForce")
        local att = root:FindFirstChild("__TestHoverAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end)
end

-- ========================= WALK TO POINT =========================
local VIM = game:GetService("VirtualInputManager")

local function walkToPoint(pos, timeout)
    timeout = timeout or 30
    local root = Core.GetRoot(LocalPlayer)
    if not root then
        return
    end

    debug("Walking to:", pos)
    cleanupForce()

    -- Press W
    local ok, err = pcall(function()
        VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
    end)
    if not ok then
        debug("walkToPoint W down error:", err)
    end

    local startT = tick()
    local lastDash = 0
    local dashCooldown = 3

    while enabled and (tick() - startT < timeout) do
        local currentRoot = Core.GetRoot(LocalPlayer)
        if not currentRoot then
            break
        end

        local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
        if dist < 5 then
            debug("Arrived at:", pos)
            break
        end

        -- Aim camera and body
        pcall(function()
            local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
            Workspace.CurrentCamera.CFrame = CFrame.lookAt(
                Workspace.CurrentCamera.CFrame.Position,
                currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
            )
        end)

        -- Dash
        if tick() - lastDash >= dashCooldown then
            pcall(function()
                VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
            end)
            lastDash = tick()
        end

        task.wait()
    end

    -- Release W
    pcall(function()
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
    end)
end

-- ========================= NEAREST TARGET =========================
local function getNearestTarget()
    local root = Core.GetRoot(LocalPlayer)
    if not root then
        return nil
    end
    local nearest, nearestDist = nil, math.huge
    for _, item in ipairs(Workspace:GetDescendants()) do
        if
            item:IsA("Model")
            and item:FindFirstChild("HumanoidRootPart")
            and item:FindFirstChildWhichIsA("Humanoid")
        then
            if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA("Humanoid").Health > 0 then
                local dist = (item.HumanoidRootPart.Position - root.Position).Magnitude
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = item
                end
            end
        end
    end
    return nearest
end

local function computeLookDownCFrame(root, targetPos)
    local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
    if horiz.Magnitude < 0.5 then
        local fwd = root.CFrame.LookVector
        local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
        if fwdFlat.Magnitude < 0.01 then
            fwdFlat = Vector3.new(0, 0, 1)
        end
        horiz = fwdFlat.Unit * 5
    end
    local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
    return CFrame.lookAt(root.Position, lookPoint)
end

-- ========================= DISABLE/ENABLE =========================
local function disableBot()
    if not enabled then
        return
    end
    enabled = false
    mode = "idle"
    if navConn then
        navConn:Disconnect()
        navConn = nil
    end
    cleanupForce()
    debug("Tester Disabled")
end

local function enableBot(targetMode)
    if enabled then
        disableBot()
    end
    enabled = true
    mode = targetMode
    debug("Tester Enabled. Mode:", mode)

    local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
    local climbStart = tick()

    navConn = RunService.Heartbeat:Connect(function()
        local root = Core.GetRoot(LocalPlayer)
        if not root then
            return
        end

        -- Stop on Death Check
        local hum = getHumanoid()
        if hum and hum.Health <= 0 then
            debug("Player died! Disabling bot.")
            disableBot()
            return
        end

        local aim, face = nil, nil

        if mode == "hover" then
            -- Hover X studs above nearest character
            local targetChar = getNearestTarget()
            if targetChar then
                aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
                face = targetChar.HumanoidRootPart.Position
            end
        elseif mode == "dodge" then
            -- Simulate dodge jump (X studs up)
            aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
            face = initialPos

            -- Call rate-limited Geppo to justify staying in air during dodge
            invokeGeppo()
        elseif mode == "square_dodge" then
            -- Let walkToPoint handle everything in its loop, so we exit this heartbeat logic early
            return
        end

        if not aim then
            aim = lastAim or root.Position
            face = lastFace or aim
        end
        lastAim = aim
        lastFace = face

        local pos = root.Position
        local yErr = aim.Y - pos.Y
        local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
        local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
        local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60)) or Vector3.zero

        local force = getOrCreateForce(root)
        if force then
            local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
            force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
        end

        -- Lock CFrame orientation and snap position if close (Combat Snapping)
        if xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
            pcall(function()
                root.CFrame = computeLookDownCFrame(root, face) + (aim - root.Position)
            end)
        else
            -- Normal orientation face while moving
            pcall(function()
                root.CFrame = computeLookDownCFrame(root, face)
            end)

            -- Call rate-limited Geppo if we are climbing up
            if yErr > 5 then
                invokeGeppo()
            end
        end
    end)
end

-- ========================= SAFE UI =========================
local function CreateUI()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui", 10)
    if not playerGui then
        return
    end

    local existingGui = playerGui:FindFirstChild("OverworldTestGui")
    if existingGui then
        existingGui:Destroy()
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "OverworldTestGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 240, 0, 230)
    frame.Position = UDim2.new(0.05, 0, 0.4, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 8)
    uiCorner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -20, 0, 30)
    title.Position = UDim2.new(0, 10, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = "🛡️ Cupid Engine Overworld Test"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -20, 0, 20)
    statusLabel.Position = UDim2.new(0, 10, 0, 35)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Status: Idle"
    statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    statusLabel.Font = Enum.Font.GothamMedium
    statusLabel.TextSize = 11
    statusLabel.Parent = frame

    local function createInputBtn(text, defaultVal, pos, callback, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.65, -10, 0, 30)
        btn.Position = pos
        btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
        btn.Text = text
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.Parent = frame
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local input = Instance.new("TextBox")
        input.Size = UDim2.new(0.35, -10, 0, 30)
        input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
        input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
        input.TextColor3 = Color3.new(1, 1, 1)
        input.Text = tostring(defaultVal)
        input.Font = Enum.Font.GothamMedium
        input.TextSize = 11
        input.Parent = frame
        Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

        btn.MouseButton1Click:Connect(function()
            local val = tonumber(input.Text) or defaultVal
            callback(val)
        end)
    end

    createInputBtn("Hover Above Target", 10.3, UDim2.new(0, 10, 0, 65), function(val)
        currentHoverOffset = val
        enableBot("hover")
        statusLabel.Text = "Status: Hovering " .. val .. " studs up"
    end)

    createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
        currentDodgeHeight = val
        enableBot("dodge")
        statusLabel.Text = "Status: Dodge-holding (" .. val .. " studs)"
    end)

    createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
        enableBot("square_dodge")
        statusLabel.Text = "Status: Square Walking (" .. val .. " studs)"
        task.spawn(function()
            local root = Core.GetRoot(LocalPlayer)
            if not root then
                return
            end
            local center = root.Position
            local d = val
            local corners = {
                center + Vector3.new(d, 0, d),
                center + Vector3.new(-d, 0, d),
                center + Vector3.new(-d, 0, -d),
                center + Vector3.new(d, 0, -d),
            }
            local startT = tick()
            local cornerIdx = 1
            while enabled and mode == "square_dodge" and (tick() - startT) < 30 do
                walkToPoint(corners[cornerIdx], 5)
                cornerIdx = (cornerIdx % 4) + 1
            end
            if mode == "square_dodge" then
                disableBot()
                statusLabel.Text = "Status: Idle (Square dodge done)"
            end
        end)
    end)

    local stopBtn = Instance.new("TextButton")
    stopBtn.Size = UDim2.new(1, -20, 0, 30)
    stopBtn.Position = UDim2.new(0, 10, 0, 185)
    stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
    stopBtn.Text = "EMERGENCY STOP"
    stopBtn.TextColor3 = Color3.new(1, 1, 1)
    stopBtn.Font = Enum.Font.GothamBlack
    stopBtn.TextSize = 13
    stopBtn.Parent = frame
    Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
    stopBtn.MouseButton1Click:Connect(function()
        disableBot()
        statusLabel.Text = "Status: STOPPED (Idle)"
        local VIM = game:GetService("VirtualInputManager")
        VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
    end)
end

CreateUI()
print("[OverworldTester] Loaded successfully.")
