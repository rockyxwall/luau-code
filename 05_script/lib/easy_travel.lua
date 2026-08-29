--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds 'P' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 100.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = 6.0
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil

local function getCharacterComponents()
    local char = LocalPlayer.Character
    if not char then
        return nil, nil, nil
    end
    return char, char:FindFirstChildWhichIsA("Humanoid"), char:FindFirstChild("HumanoidRootPart")
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

function EasyTravel.GetSurfaceY(position, character)
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
    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position

        local moveDir = Vector3.zero
        if EasyTravel.DisableRaycasting then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            task.wait(RAYCAST_COOLDOWN)
            continue
        end

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - root.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = EasyTravel.TargetPosition.Y
                continue
            end
        else
            local camera = Workspace.CurrentCamera
            local look = camera.CFrame.LookVector
            local right = camera.CFrame.RightVector
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

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
                    currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
                end
            else
                distanceToWall = 999
                isClimbing = false
                local groundY = EasyTravel.GetSurfaceY(currentPos, char)
                local aheadPos = currentPos + moveUnit * 4
                local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
                currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
            end
        else
            distanceToWall = 999
            isClimbing = false
            currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
        end
    end
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    EasyTravel.Enabled = true
    cleanupForce()
    local char, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function(dt)
        local char, _, currentRoot = getCharacterComponents()
        if not currentRoot or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local camera = Workspace.CurrentCamera
        local look = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        local moveDir = Vector3.zero
        local finalTargetY = isClimbing and climbTargetY or currentTargetY

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentRoot.Position
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            end
        else
            if not EasyTravel.DisableKeyboard then
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
                end
            end
        end

        local yError = finalTargetY - currentRoot.Position.Y
        local targetVelocity = Vector3.zero
        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        if moveDir.Magnitude > 0 then
            currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
        end
    end)
    print("[Easy Travel] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel] Flight disabled.")
end

-- Completely shutdown everything
function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then
        return
    end
    if input.KeyCode == Enum.KeyCode.P then
        if EasyTravel.Enabled then
            EasyTravel.Stop()
        else
            EasyTravel.Start()
        end
    end
end)

return EasyTravel
