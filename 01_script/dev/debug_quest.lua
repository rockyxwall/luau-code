--[[
    ================================================================================
    DEBUG QUEST TESTER - COMBINED FLIGHT & QUEST INTERACTION SCRIPT
    ================================================================================
    Combines easy_travel and quest_handler code to perform a single automated task:
    1. Flight-navigate directly to the level 1 quest giver (Daph).
    2. Land on the ground and trigger dialogue.
    3. Accept the quest, print results, and stop.
    ================================================================================
--]]

_G.EasyTravelHelperMode = true

-- ============================================================================
-- 1. EMBEDDED EASY TRAVEL LIBRARY CODE
-- ============================================================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer

if _G.EasyTravelCleanup then
    pcall(_G.EasyTravelCleanup)
end

local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil

_G.EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = true,
    Speed = FLIGHT_SPEED,
    Enabled = false,
}

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    return char, hum, root
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce")
    if not force then
        force = Instance.new("LinearVelocity")
        force.Name = "__EasyTravelForce"
        force.Attachment0 = att
        force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        force.RelativeTo = Enum.ActuatorRelativeTo.World
        force.MaxForce = 10000000
        force.VectorVelocity = Vector3.zero
        force.Parent = root
    end
    return force
end

local function cleanupForce()
    local _, _, root = getCharacterComponents()
    if root then
        local force = root:FindFirstChild("__EasyTravelForce")
        local att = root:FindFirstChild("__EasyTravelAtt")
        if force then
            force:Destroy()
        end
        if att then
            att:Destroy()
        end
    end
end

local function getSurfaceY(position, character)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { character }
    raycastParams.IgnoreWater = true

    local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
    local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
    local direction = Vector3.new(0, -checkDepth, 0)

    local result = Workspace:Raycast(startPos, direction, raycastParams)
    local groundY = result and result.Position.Y or -100
    return math.max(groundY, SEA_LEVEL_Y)
end

local function runRaycastLoop()
    while flightEnabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        if _G.EasyTravel and _G.EasyTravel.TargetPosition then
            isClimbing = false
            currentTargetY = _G.EasyTravel.TargetPosition.Y
            continue
        end

        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero

        local currentPos = root.Position
        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = { char }
        raycastParams.IgnoreWater = true

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
            end

            if forwardHit then
                distanceToWall = forwardHit.Distance
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)

                        if secondaryHit then
                            currentScanDist = currentScanDist + 15
                        else
                            break
                        end
                    end
                    heightOffset = heightOffset + 4
                end

                if clearanceY then
                    isClimbing = true
                    climbTargetY = clearanceY + HEIGHT_OFFSET
                else
                    isClimbing = false
                    currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = getSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = getSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

local function startFlight()
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    flightEnabled = true
    _G.EasyTravel.Enabled = true
    currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local char, currentHum, currentRoot = getCharacterComponents()
        if not currentRoot or not flightEnabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local moveDir = Vector3.zero
        local finalTargetY = currentTargetY

        if _G.EasyTravel and _G.EasyTravel.TargetPosition then
            local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
            finalTargetY = _G.EasyTravel.TargetPosition.Y
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
        if moveDir.Magnitude > 0 then
            targetVelocity = moveDir.Unit * currentSpeed
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
end

local function stopFlight()
    flightEnabled = false
    _G.EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
end

_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
_G.EasyTravel.GetSurfaceY = getSurfaceY

_G.EasyTravelCleanup = function()
    stopFlight()
    _G.EasyTravel = nil
    _G.EasyTravelCleanup = nil
end

-- ============================================================================
-- 2. EMBEDDED QUEST HANDLER CODE
-- ============================================================================
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
    local torso = npc and npc:FindFirstChild("UpperTorso")
    local prompt = torso and torso:FindFirstChild("Prompt")

    if not prompt then
        print("[Quest Handler] No prompt found for NPC: " .. tostring(npcName))
        return false
    end

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then
        return false
    end

    local dist = (torso.Position - myRoot.Position).Magnitude
    if dist > 12 then
        print("[Quest Handler] Player too far (Dist: " .. tostring(dist) .. ")")
        return false
    end

    local holdTime = prompt.HoldDuration or 0
    if holdTime > 0 then
        task.wait(holdTime + 0.1)
    end

    if fireproximityprompt then
        pcall(fireproximityprompt, prompt)
    else
        print("[Quest Handler] fireproximityprompt not supported!")
        return false
    end
    task.wait(0.8)

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")
    if chatGui and chatGui.Enabled then
        local tries = 0
        while chatGui.Enabled and tries < 6 do
            tries = tries + 1
            local frame = chatGui:FindFirstChild("Frame")
            local goBtn = frame and frame:FindFirstChild("go")
            local endChatBtn = frame and frame:FindFirstChild("endChat")

            if goBtn and goBtn.Visible and goBtn.Text ~= "" then
                if getconnections then
                    for _, conn in ipairs(getconnections(goBtn.Activated)) do
                        pcall(function()
                            conn:Fire()
                        end)
                    end
                    for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
                        pcall(function()
                            conn:Fire()
                        end)
                    end
                end
            elseif endChatBtn and endChatBtn.Visible then
                if getconnections then
                    for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
                        pcall(function()
                            conn:Fire()
                        end)
                    end
                    for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
                        pcall(function()
                            conn:Fire()
                        end)
                    end
                end
            end
            task.wait(0.8)
        end
    end
    return true
end

_G.QuestHandler = QuestHandler

-- ============================================================================
-- 3. ONE-TIME EXECUTION TASK
-- ============================================================================
task.spawn(function()
    local npcName = "Daph"
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
    local torso = npc and npc:FindFirstChild("UpperTorso")

    if not torso then
        print("[Debug Quest] ERROR: Daph NPC not found in Workspace.NPCs!")
        return
    end

    print("[Debug Quest] Starting flight towards " .. npcName .. "...")
    startFlight()

    -- Target position relative to the NPC
    local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
    _G.EasyTravel.TargetPosition = targetPos

    -- Wait loop to check proximity
    local reached = false
    for i = 1, 100 do
        task.wait(0.2)
        local _, _, myRoot = getCharacterComponents()
        if myRoot then
            local dist = (targetPos - myRoot.Position).Magnitude
            if dist <= 3.5 then
                reached = true
                break
            end
        end
    end

    if reached then
        print("[Debug Quest] Reached destination. Stopping flight & taking quest...")
        _G.EasyTravel.TargetPosition = nil
        stopFlight()
        task.wait(1.0) -- wait a second to fully settle

        local success = QuestHandler.AcceptQuest(npcName)
        print("[Debug Quest] AcceptQuest sequence executed. Result: " .. tostring(success))
    else
        print("[Debug Quest] Timeout: Could not reach NPC.")
        stopFlight()
    end
end)
