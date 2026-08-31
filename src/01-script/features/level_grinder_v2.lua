--[[
    ================================================================================
    Level Grinder V2 - Sea Serpent / G-1 Progression (Rifle -> Boat -> G-1 Spawn)
    ================================================================================
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local LevelGrinderV2 = {
    Running = false,
    Connections = {},
}

local Core = (function()
    
--[[
    Core Utility Library
    Provides standardized module loading and common helpers.
]]
local Core = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil

local function getStats()
    if statsFolder and statsFolder.Parent then
        return statsFolder
    end
    statsFolder = ReplicatedStorage:FindFirstChild("Stats" .. LocalPlayer.Name)
    if statsFolder then
        -- Find Peli
        peliValueObj = statsFolder:FindFirstChild("Peli")
        if not (peliValueObj and peliValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            peliValueObj = nested and nested:FindFirstChild("Peli")
        end
        -- Find Level
        levelValueObj = statsFolder:FindFirstChild("Level")
        if not (levelValueObj and levelValueObj:IsA("ValueBase")) then
            local nested = statsFolder:FindFirstChild("Stats")
            levelValueObj = nested and nested:FindFirstChild("Level")
        end
        -- Find Stamina
        staminaValueObj = statsFolder:FindFirstChild("Stamina")
    else
        peliValueObj = nil
        levelValueObj = nil
        staminaValueObj = nil
    end
    return statsFolder
end

function Core.GetPeli()
    getStats()
    return peliValueObj and peliValueObj.Value or 0
end

function Core.GetLevel()
    getStats()
    return levelValueObj and levelValueObj.Value or 1
end

function Core.GetStamina()
    getStats()
    if staminaValueObj then
        return staminaValueObj.Value, staminaValueObj.MaxValue
    end
    return 0, 0
end

function Core.GetHealth()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        return hum.Health, hum.MaxHealth
    end
    return 0, 0
end

function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
    if _G.DisableStandalone then
        return
    end
    toggleKey = toggleKey or Enum.KeyCode.P

    local cleanKey = "__Clean_" .. tostring(name)
    if _G[cleanKey] then
        pcall(_G[cleanKey])
    end

    local UserInputService = game:GetService("UserInputService")
    local connection = UserInputService.InputBegan:Connect(function(input, processed)
        if processed then
            return
        end
        if input.KeyCode == toggleKey then
            if checkCallback() then
                stopCallback()
            else
                startCallback()
            end
        end
    end)

    _G[cleanKey] = function()
        pcall(stopCallback)
        if connection and connection.Connected then
            connection:Disconnect()
        end
    end

    if not noAutoStart then
        task.spawn(function()
            if not game:IsLoaded() then
                game.Loaded:Wait()
            end
            startCallback()
        end)
    end

    print("[" .. tostring(name) .. "] Standalone Mode: Press '" .. toggleKey.Name .. "' to toggle.")
end

function Core.GetRoot(player)
    local char = player and player.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local Safeguard = (function()
    
local Safeguard = {
    Config = {
        PrivateServerCode = "Jk2JKTAKCf", -- Set your PS code here to auto-join from homescreen
        TeleportLocation = "1stSea", -- "1stSea", "2ndSea", "TradeHub", "UniversalHub", "FishHub"
    },
}

local GPO_UNIVERSE_ID = 648454481

-- List of places where scripts should NEVER run
local BANNED_PLACES = {
    [1730877806] = "First Sea Homescreen / Main Menu",
    -- Add Second Sea homescreen here when known
}

function Safeguard.JoinPrivateServer()
    local code = Safeguard.Config.PrivateServerCode

    if type(code) == "string" and code ~= "" then
        print(string.format("[Safeguard] Joining Private Server '%s'...", code))
        task.spawn(function()
            -- 1. Submit the private server code
            local rs = game:GetService("ReplicatedStorage")
            local reservedRemote = rs:WaitForChild("Events"):WaitForChild("reserved")

            task.spawn(function()
                pcall(function()
                    reservedRemote:InvokeServer(code)
                end)
            end)

            -- Wait for UI to load and remote to appear
            local teleRemote = nil
            for i = 1, 20 do
                task.wait(0.5)
                for _, v in next, getnilinstances() do
                    if
                        v:IsA("RemoteEvent") and (v.Name == "RemoteEvent" or v.Name == "tele" or v.Name == "Teleport")
                    then
                        teleRemote = v
                        break
                    end
                end
                if teleRemote then
                    break
                end
            end

            if teleRemote then
                print("[Safeguard] Firing teleport remote: " .. teleRemote.Name)
                teleRemote:FireServer(true)
            else
                warn("[Safeguard] Could not find RemoteEvent in nil. Printing all RemoteEvents in nil:")
                for _, v in next, getnilinstances() do
                    if v:IsA("RemoteEvent") then
                        print(" - Name:", v.Name)
                    end
                end
            end
        end)
        return true
    end
    return false
end

function Safeguard.IsSafe()
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if BANNED_PLACES[game.PlaceId] then
        warn("[Safeguard] Script execution blocked on: " .. BANNED_PLACES[game.PlaceId])

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    return true
end

function Safeguard.RequirePlace(placeId, name)
    if game.GameId ~= GPO_UNIVERSE_ID then
        warn("[Safeguard] Wrong game universe! Script is only for GPO.")
        return false
    end

    if game.PlaceId == placeId then
        return true
    end

    if BANNED_PLACES[game.PlaceId] then
        warn(string.format("[Safeguard] You are on the Homescreen. Script requires %s.", name or "a specific place"))

        if Safeguard.JoinPrivateServer() then
            print("[Safeguard] Teleporting to Private Server... Please wait.")
        else
            warn("[Safeguard] PrivateServerCode is not set. Cannot auto-join.")
        end
        return false
    end

    warn(
        string.format(
            "[Safeguard] Wrong place! Required: %s (%d), Current: %d",
            name or "Unknown",
            placeId,
            game.PlaceId
        )
    )
    return false
end

return Safeguard


end)()

function Core.GetSafeguard()
    return Safeguard
end

return Core


end)()
local Safeguard = Core.GetSafeguard()

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

local QuestHandler = (function()
    
--[[
    ================================================================================
    QUEST HANDLER LIBRARY - SHARED NPC INTERACTION MODULE
    ================================================================================
    Handles proximity prompt execution and dialogue click sequencing safely.
    ================================================================================
--]]

local Players = game:GetService("Players")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer

local QuestHandler = {}

function QuestHandler.AcceptQuest(npcName)
    local npcsFolder = Workspace:FindFirstChild("NPCs")
    local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
    local torso = npc and npc:FindFirstChild("UpperTorso")
    local prompt = torso and torso:FindFirstChild("Prompt")

    if not prompt then
        warn("[Quest Handler] No prompt found for NPC: " .. tostring(npcName))
        return false
    end

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then
        return false
    end

    -- Safe proximity check (e.g. within 12 studs)
    local dist = (torso.Position - myRoot.Position).Magnitude
    if dist > 12 then
        warn("[Quest Handler] Player too far from NPC: " .. tostring(npcName) .. " (Dist: " .. tostring(dist) .. ")")
        return false
    end

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")

    -- ONLY trigger proximity prompt if the dialogue GUI is NOT already open
    if not (chatGui and chatGui.Enabled) then
        local holdTime = prompt.HoldDuration or 0
        if holdTime > 0 then
            task.wait(holdTime + 0.1)
        end

        if fireproximityprompt then
            pcall(fireproximityprompt, prompt)
        else
            warn("[Quest Handler] fireproximityprompt not supported by executor!")
            return false
        end
        task.wait(0.8)
    end

    -- Handle dialogue progression
    chatGui = playerGui:FindFirstChild("NPCCHAT")
    if chatGui and chatGui.Enabled then
        local tries = 0
        -- Increased tries to 15 to prevent prematurely exiting dialogues on laggy servers
        while chatGui.Enabled and tries < 15 do
            tries = tries + 1
            local frame = chatGui:FindFirstChild("Frame")
            local goBtn = frame and frame:FindFirstChild("go")
            local endChatBtn = frame and frame:FindFirstChild("endChat")

            if goBtn and goBtn.Visible and goBtn.Text ~= "" then
                if getconnections then
                    -- Fire both Activated and MouseButton1Click to ensure the click registers
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
                    -- Fire both Activated and MouseButton1Click to ensure the click registers
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

return QuestHandler


end)()

if EasyTravel and EasyTravel.Cleanup then
    pcall(EasyTravel.Cleanup)
end

local function getCharRoot()
    local c = LocalPlayer.Character
    return c, c and c:FindFirstChild("HumanoidRootPart")
end

local function hasRifle()
    local c = LocalPlayer.Character
    return LocalPlayer.Backpack:FindFirstChild("Rifle") ~= nil or (c and c:FindFirstChild("Rifle") ~= nil)
end

local function hasBoat()
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    local names = { "wooden boat", "rowboat", "caravel", "galleon", "boat", "ship" }
    local function check(parent)
        if not parent then
            return false
        end
        for _, item in ipairs(parent:GetChildren()) do
            local l = item.Name:lower()
            for _, kw in ipairs(names) do
                if l:find(kw) then
                    return true
                end
            end
        end
        return false
    end
    return check(backpack) or check(char)
end

local function findBuyableBoat()
    local buyables = workspace:FindFirstChild("BuyableItems")
    if not buyables then
        return nil
    end
    local preferred = { "Wooden Boat", "Rowboat", "Caravel", "Boat" }
    for _, name in ipairs(preferred) do
        local item = buyables:FindFirstChild(name)
        if item then
            return item
        end
    end
    for _, item in ipairs(buyables:GetChildren()) do
        local l = item.Name:lower()
        if l:find("boat") or l:find("caravel") or l:find("ship") then
            return item
        end
    end
    return nil
end

local function travelTo(targetPos, reachDist)
    if not EasyTravel then
        return false
    end
    reachDist = reachDist or 6

    EasyTravel.TargetPosition = targetPos
    pcall(EasyTravel.Start)

    while LevelGrinderV2.Running do
        local _, hrp = getCharRoot()
        if hrp and (hrp.Position - targetPos).Magnitude <= reachDist then
            break
        end
        task.wait(0.2)
    end

    pcall(EasyTravel.Stop)
    return LevelGrinderV2.Running
end

local function setSpawnAtG1()
    print("[Level Grinder V2] Locating Spawn Setter at Marine Base G-1...")
    local npcs = workspace:FindFirstChild("NPCs")
    local targetNpc = nil
    local targetPrompt = nil

    if npcs then
        for _, npc in ipairs(npcs:GetChildren()) do
            local l = npc.Name:lower()
            if l:find("spawn") or l:find("setter") or l:find("marine") then
                local root = npc:FindFirstChild("HumanoidRootPart")
                    or npc:FindFirstChild("UpperTorso")
                    or npc:FindFirstChild("Torso")
                if root and (root.Position - Vector3.new(-6038, 20, -11329)).Magnitude < 1000 then
                    targetNpc = npc
                    break
                end
            end
        end
    end

    if not targetNpc then
        for _, desc in ipairs(workspace:GetDescendants()) do
            if desc:IsA("ProximityPrompt") then
                local text = (desc.ActionText .. " " .. desc.ObjectText):lower()
                if text:find("spawn") or text:find("set") then
                    local pPart = desc.Parent
                    if
                        pPart
                        and pPart:IsA("BasePart")
                        and (pPart.Position - Vector3.new(-6038, 20, -11329)).Magnitude < 1000
                    then
                        targetPrompt = desc
                        break
                    end
                end
            end
        end
    end

    if targetNpc then
        local root = targetNpc:FindFirstChild("HumanoidRootPart")
            or targetNpc:FindFirstChild("UpperTorso")
            or targetNpc:FindFirstChild("Torso")
        if root then
            travelTo(root.Position + Vector3.new(0, 0, 3), 6)
            task.wait(0.5)
            if QuestHandler and QuestHandler.AcceptQuest then
                QuestHandler.AcceptQuest(targetNpc.Name)
            else
                local prompt = targetNpc:FindFirstChildWhichIsA("ProximityPrompt", true)
                if prompt and fireproximityprompt then
                    fireproximityprompt(prompt)
                end
            end
        end
    elseif targetPrompt then
        local pPart = targetPrompt.Parent
        if pPart and pPart:IsA("BasePart") then
            travelTo(pPart.Position + Vector3.new(0, 0, 3), 6)
            task.wait(0.5)
            if fireproximityprompt then
                fireproximityprompt(targetPrompt)
            end
        end
    else
        warn("[Level Grinder V2] Spawn NPC/Prompt not found at G-1; standing at base coordinates.")
    end
end

function LevelGrinderV2.Stop()
    LevelGrinderV2.Running = false
    for _, conn in ipairs(LevelGrinderV2.Connections) do
        conn:Disconnect()
    end
    LevelGrinderV2.Connections = {}
    if EasyTravel then
        pcall(EasyTravel.Stop)
    end
    print("[Level Grinder V2] Stopped.")
end

function LevelGrinderV2.Start()
    if LevelGrinderV2.Running then
        warn("[Level Grinder V2] Already running!")
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.RequirePlace(3978370137, "First Sea") then
        return
    end
    LevelGrinderV2.Running = true

    task.spawn(function()
        if not game:IsLoaded() then
            game.Loaded:Wait()
        end

        local events = ReplicatedStorage:WaitForChild("Events", 10)
        local shopEvent = events and events:FindFirstChild("Shop")
        local toolsEvent = events and events:FindFirstChild("Tools")

        -- Phase 1: Obtain Rifle
        while LevelGrinderV2.Running and not hasRifle() do
            local _, hrp = getCharRoot()
            local inTown = hrp
                and hrp.Position.X >= -889
                and hrp.Position.X <= -156
                and hrp.Position.Z >= -3706
                and hrp.Position.Z <= -3087

            if not inTown then
                warn("[Level Grinder V2] Not at Town of Beginnings. Please travel there to farm chests for Rifle.")
                task.wait(2)
                continue
            end

            local peli = Core.GetPeli()
            if peli < 375 and ChestFarmer then
                print(
                    "[Level Grinder V2] Farming chests until 375 Peli (Rifle + Boat)... (Current: "
                        .. tostring(peli)
                        .. ")"
                )
                ChestFarmer.FarmUntilPeli(375, Core.GetPeli, function()
                    return LevelGrinderV2.Running and not hasRifle()
                end)
            else
                local buyables = workspace:FindFirstChild("BuyableItems")
                local shopItem = buyables and buyables:FindFirstChild("Rifle")
                local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")

                if shopPart and travelTo(shopPart.Position, 8) then
                    task.wait(0.5)
                    if shopEvent and shopEvent:IsA("RemoteFunction") then
                        pcall(function()
                            shopEvent:InvokeServer(shopItem, 1)
                        end)
                    end
                    task.wait(1)

                    if toolsEvent and toolsEvent:IsA("RemoteFunction") then
                        pcall(function()
                            toolsEvent:InvokeServer("equip", "Rifle")
                        end)
                    end
                    task.wait(1)
                end
            end
            task.wait(1)
        end

        if not LevelGrinderV2.Running then
            return
        end

        -- Equip Rifle
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChild("Humanoid")
        local rifle = LocalPlayer.Backpack:FindFirstChild("Rifle")
        if rifle and hum then
            hum:EquipTool(rifle)
        end

        -- Phase 2: Obtain Boat
        while LevelGrinderV2.Running and not hasBoat() do
            local boatItem = findBuyableBoat()
            if not boatItem then
                print("[Level Grinder V2] No buyable boat found in BuyableItems, proceeding.")
                break
            end

            local peli = Core.GetPeli()
            if peli < 75 and ChestFarmer then
                print("[Level Grinder V2] Farming chests for Boat (75 Peli)...")
                ChestFarmer.FarmUntilPeli(75, Core.GetPeli, function()
                    return LevelGrinderV2.Running and not hasBoat()
                end)
            else
                local shopPart = boatItem:FindFirstChild("ShopPart") or boatItem:FindFirstChildWhichIsA("BasePart")
                if shopPart and travelTo(shopPart.Position, 8) then
                    task.wait(0.5)
                    if shopEvent and shopEvent:IsA("RemoteFunction") then
                        pcall(function()
                            shopEvent:InvokeServer(boatItem, 1)
                        end)
                    end
                    task.wait(1)
                end
                break
            end
            task.wait(1)
        end

        if not LevelGrinderV2.Running then
            return
        end

        -- Phase 3: Escape shop interior if in town
        local _, hrp = getCharRoot()
        if hrp then
            local wasAtShop = hrp.Position.X >= -889
                and hrp.Position.X <= -156
                and hrp.Position.Z >= -3706
                and hrp.Position.Z <= -3087
            if wasAtShop then
                print("[Level Grinder V2] Escaping shop interior...")
                travelTo(Vector3.new(hrp.Position.X, hrp.Position.Y + 15, hrp.Position.Z), 2)
            end
        end

        -- Phase 4: Fly to Marine Base G-1 (Raycasting active, stuck prevention active)
        print("[Level Grinder V2] Flying to Marine Base G-1...")
        travelTo(Vector3.new(-6038, 50, -11329), 12)

        -- Phase 5: Set Spawn at Marine Base G-1
        setSpawnAtG1()

        print("[Level Grinder V2] Reached Marine Base G-1 and completed spawn set sequence.")
        LevelGrinderV2.Stop()
    end)
end

Core.SetupStandalone(LevelGrinderV2, "Level Grinder V2", LevelGrinderV2.Start, LevelGrinderV2.Stop, function()
    return LevelGrinderV2.Running
end)

return LevelGrinderV2
