--[[
    ============================================================
    DEV TEST HARNESS: Chest Farmer
    ============================================================
    Tests the pure chest_farmer.lua library in Town of Beginnings.
    Press ']' (RightBracket) to toggle chest farm on / off.
    ============================================================
--]]

local UserInputService = game:GetService("UserInputService")

local ChestFarmer = (function()
    
--[[
    ============================================================
    LIBRARY: Peli Chest Farmer — Town of Beginnings
    ============================================================
    Provides reusable functions to farm chests within the XZ
    bounds of Town of Beginnings.
    If run standalone, farms chests indefinitely.
    ============================================================
--]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ChestFarmer = {
    Running = false,
    Connections = {},
}

local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4

local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087

local function isInsideTownOfBeginnings(pos)
    return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end

local EasyTravel = (function()
    
--[[
    ================================================================================
    EASY TRAVEL V2 (Hybrid Main Climb + <14 Stud Whisker Precision Engine)
    ================================================================================
    Main Navigation (>14 studs): Legacy 3-Ray obstacle-climbing flight engine.
    Close Navigation (<=14 studs): V2 2D Horizontal Whisker evasion with strict
    altitude ceiling cap (prevents >15 stud elevation) and proportional arrival decel.
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    Enabled = false,
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 50.0,
    DisableRaycasting = false,
    DisableWallTouch = false,
    HitCave = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 4.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local WHISKER_SCAN_DIST = 14.0
local CLOSE_PROXIMITY_DIST = 14.0

-- Internal State
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local lastTurnSign = 1

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
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
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

local function rotateXZ(vec, rad)
    local cosA = math.cos(rad)
    local sinA = math.sin(rad)
    return Vector3.new(vec.X * cosA - vec.Z * sinA, 0, vec.X * sinA + vec.Z * cosA).Unit
end

local function getRayParams(char)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.IgnoreWater = true
    if char then
        params.FilterDescendantsInstances = { char }
    end
    return params
end

-- V2 Whisker Heading (Used in close proximity <=14 studs)
local function findClearWhiskerHeading(origin, desiredDir, char)
    if EasyTravel.DisableRaycasting or desiredDir.Magnitude < 0.01 then
        return desiredDir
    end

    local rayParams = getRayParams(char)
    local rayOrigin = origin + Vector3.new(0, 0.5, 0)

    local fwdHit = Workspace:Raycast(rayOrigin, desiredDir * WHISKER_SCAN_DIST, rayParams)
    if not fwdHit then
        return desiredDir
    end

    local angles = { 35, 70, 95 }
    local signs = lastTurnSign >= 0 and { 1, -1 } or { -1, 1 }

    for _, deg in ipairs(angles) do
        local rad = math.rad(deg)
        for _, sign in ipairs(signs) do
            local probeDir = rotateXZ(desiredDir, rad * sign)
            local hit = Workspace:Raycast(rayOrigin, probeDir * WHISKER_SCAN_DIST, rayParams)
            if not hit then
                lastTurnSign = sign
                return probeDir
            end
        end
    end

    return desiredDir
end

-- Main Long-Distance Raycast Background Loop (>14 studs)
local function runRaycastLoop()
    local startTime = tick()
    local stuckFrames = 0

    while EasyTravel.Enabled do
        task.wait(RAYCAST_COOLDOWN)
        local char, _, root = getCharacterComponents()
        if not char or not root then
            continue
        end

        local currentPos = root.Position
        local target = EasyTravel.TargetPosition
        local distToTarget = target and (target - currentPos).Magnitude or 999

        -- When within close proximity, bypass vertical climbing
        if target and distToTarget <= CLOSE_PROXIMITY_DIST then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = target.Y
            continue
        end

        -- Velocity-based stuck detection
        local isMovingToTarget = target ~= nil and distToTarget > 8 and (tick() - startTime) > 0.5
        if isMovingToTarget and root.AssemblyLinearVelocity.Magnitude < 2.5 then
            stuckFrames = stuckFrames + 1
        else
            stuckFrames = 0
        end
        local isStuck = stuckFrames >= 3

        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

        local moveDir = Vector3.zero
        local skipRaycast = EasyTravel.DisableRaycasting or (inRoughWaters and not isStuck)

        if skipRaycast then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = target and target.Y or currentPos.Y
            continue
        end

        if target then
            local diff = target - currentPos
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 2 then
                moveDir = flatDiff.Unit
            else
                isClimbing = false
                currentTargetY = target.Y
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

        local hitCave = false
        local cave = Workspace.Islands:FindFirstChild("Fishman Cave")
        if cave and moveDir and moveDir.Magnitude > 0 then
            local caveRayParams = RaycastParams.new()
            caveRayParams.FilterType = Enum.RaycastFilterType.Include
            caveRayParams.FilterDescendantsInstances = { cave }
            local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
            if hit then
                hitCave = true
            end
        end
        EasyTravel.HitCave = hitCave

        if hitCave or inRoughWaters then
            isClimbing = false
            distanceToWall = 999
            currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
            continue
        end

        local rayParams = getRayParams(char)

        if moveDir.Magnitude > 0 then
            local moveUnit = moveDir.Unit
            local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit

            local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, rayParams)
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, rayParams)
            end
            if not forwardHit then
                forwardHit =
                    Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, rayParams)
            end

            if forwardHit or isStuck then
                distanceToWall = forwardHit and forwardHit.Distance or 0
                local clearanceY = nil
                local currentScanDist = FORWARD_SCAN_DISTANCE
                local heightOffset = 4

                while heightOffset <= 100 do
                    local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
                    local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, rayParams)

                    if not scanHit then
                        clearanceY = scanOrigin.Y
                        local secondaryOrigin = scanOrigin + moveUnit * 10
                        local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, rayParams)
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
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end

    local _, hum, root = getCharacterComponents()
    if not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    cleanupForce()

    local char = LocalPlayer.Character
    currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
    isClimbing = false

    task.spawn(runRaycastLoop)

    loopConnection = RunService.Heartbeat:Connect(function()
        local c, h, currentRoot = getCharacterComponents()
        if not currentRoot or not h or not EasyTravel.Enabled then
            if loopConnection then
                loopConnection:Disconnect()
                loopConnection = nil
            end
            cleanupForce()
            return
        end

        local force = getOrCreateForce(currentRoot)
        local currentPos = currentRoot.Position
        local moveDir = Vector3.zero
        local curSpeed = EasyTravel.Speed
        local desiredY = currentPos.Y

        if EasyTravel.TargetPosition then
            local diff = EasyTravel.TargetPosition - currentPos
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            local dist = flatDiff.Magnitude

            if dist <= CLOSE_PROXIMITY_DIST then
                -- Close Precision (<=14 studs): V2 2D Whisker Engine + Proportional Deceleration
                if dist > 1.5 then
                    local rawDir = flatDiff.Unit
                    moveDir = findClearWhiskerHeading(currentPos, rawDir, c)
                    curSpeed = math.min(EasyTravel.Speed, math.max(dist * 12, 10))
                else
                    moveDir = Vector3.zero
                    curSpeed = 0
                end
                -- Strict altitude cap: Never exceed target altitude by >1 stud, completely preventing climbing to 15+ studs
                desiredY = EasyTravel.TargetPosition.Y
            else
                -- Long-Distance (>14 studs): Main climbing engine
                if flatDiff.Magnitude > 2 then
                    moveDir = flatDiff.Unit
                end
                desiredY = isClimbing and climbTargetY or currentTargetY
            end
        else
            -- Manual camera flight
            desiredY = isClimbing and climbTargetY or currentTargetY
            if not EasyTravel.DisableKeyboard then
                local camera = Workspace.CurrentCamera
                if camera then
                    local look = camera.CFrame.LookVector
                    local right = camera.CFrame.RightVector
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
        end

        local yError = desiredY - currentPos.Y
        local targetVelocity = Vector3.zero

        if moveDir.Magnitude > 0 then
            local speedMultiplier = 1
            if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
                speedMultiplier = 0
            end
            targetVelocity = moveDir.Unit * (curSpeed * speedMultiplier)
        end

        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -EasyTravel.Speed, EasyTravel.Speed)
        force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)

        currentRoot.AssemblyAngularVelocity = Vector3.zero
    end)
    print("[Easy Travel V2] Flight enabled.")
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    cleanupForce()
    print("[Easy Travel V2] Flight disabled.")
end

function EasyTravel.Cleanup()
    EasyTravel.Stop()
    for _, conn in ipairs(EasyTravel.Connections) do
        conn:Disconnect()
    end
    EasyTravel.Connections = {}
end

return EasyTravel


end)()

function ChestFarmer.CollectChests()
    local chests = {}
    local env = workspace:FindFirstChild("Env") or workspace
    for _, v in ipairs(env:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local action = v.ActionText or ""
            if action:find("Peli Chest") then
                local part = v.Parent
                if part and part:IsA("BasePart") and isInsideTownOfBeginnings(part.Position) then
                    table.insert(chests, {
                        prompt = v,
                        position = part.Position,
                        label = string.format("(%.0f, %.0f, %.0f)", part.Position.X, part.Position.Y, part.Position.Z),
                    })
                end
            end
        end
    end
    return chests
end

function ChestFarmer.Stop()
    ChestFarmer.Running = false
    for _, conn in ipairs(ChestFarmer.Connections) do
        conn:Disconnect()
    end
    ChestFarmer.Connections = {}
    print("[ChestFarmer] Stopped.")
end

function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
    print("[ChestFarmer] Started chest farm. Target Peli: " .. tostring(targetPeli))

    while isRunningCallback() and getPeliCallback() < targetPeli do
        local chests = ChestFarmer.CollectChests()

        if #chests == 0 then
            print("[ChestFarmer] No chests found. Waiting 20 seconds for spawn...")
            local waited = 0
            while isRunningCallback() and waited < 20 do
                task.wait(1)
                waited = waited + 1
                if getPeliCallback() >= targetPeli then
                    return true
                end
            end
        else
            local root = Core.GetRoot(LocalPlayer)
            if root then
                local startPos = root.Position
                table.sort(chests, function(a, b)
                    return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
                end)
            end

            for _, chest in ipairs(chests) do
                if not isRunningCallback() or getPeliCallback() >= targetPeli then
                    break
                end

                if EasyTravel then
                    EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
                    if not EasyTravel.Enabled then
                        pcall(EasyTravel.Start)
                    end
                end

                local elapsed = 0
                local reached = false
                while isRunningCallback() and elapsed < 20 do
                    task.wait(0.1)
                    elapsed = elapsed + 0.1

                    local myRoot = Core.GetRoot(LocalPlayer)
                    if myRoot then
                        local dist = (myRoot.Position - chest.position).Magnitude
                        if dist <= ARRIVE_DIST then
                            reached = true
                            break
                        end
                    else
                        task.wait(1)
                    end
                end

                if reached and isRunningCallback() then
                    if EasyTravel then
                        local myRoot = Core.GetRoot(LocalPlayer)
                        if myRoot then
                            EasyTravel.TargetPosition = myRoot.Position
                        end
                    end

                    if chest.prompt and chest.prompt.Parent then
                        local holdTime = chest.prompt.HoldDuration or 0
                        if holdTime > 0 then
                            task.wait(holdTime + 0.1)
                        end
                        if fireproximityprompt then
                            pcall(fireproximityprompt, chest.prompt)
                        else
                            pcall(function()
                                chest.prompt.Triggered:Fire(LocalPlayer)
                            end)
                        end
                        task.wait(2.5)
                    end
                end
            end
        end
        task.wait(0.2)
    end

    if EasyTravel then
        EasyTravel.TargetPosition = nil
        pcall(EasyTravel.Stop)
    end

    return getPeliCallback() >= targetPeli
end

function ChestFarmer.Start(targetPeli, getPeliCallback)
    if ChestFarmer.Running then
        return
    end
    ChestFarmer.Running = true
    targetPeli = targetPeli or 9999999
    getPeliCallback = getPeliCallback or function()
        return 0
    end
    task.spawn(function()
        ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, function()
            return ChestFarmer.Running
        end)
    end)
end

return ChestFarmer


end)()

if not ChestFarmer then
    warn("[Test ChestFarmer] ERROR: Failed to load chest_farmer library!")
    return
end

local function toggle()
    if ChestFarmer.Running then
        ChestFarmer.Stop()
        print("[Test ChestFarmer] 🔴 Chest farm STOPPED. Press ']' to start.")
    else
        ChestFarmer.Start()
        print("[Test ChestFarmer] 🟢 Chest farm STARTED. Press ']' to stop.")
    end
end

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then
        return
    end
    if input.KeyCode == Enum.KeyCode.RightBracket then
        toggle()
    end
end)

print("[Test ChestFarmer] Loaded! Press ']' (Right Bracket) to toggle chest farm.")
