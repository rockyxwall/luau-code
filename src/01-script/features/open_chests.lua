--[[
    ============================================================
    FEATURE: Auto Open Peli Chests — Town of Beginnings
    ============================================================
    Uses easy_travel.lua to fly to each Peli Chest and fires
    the ProximityPrompt to open them automatically.
    Headless module compatible with lazyhub or standalone execution.
    ============================================================
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local OpenChests = {
    Running = false,
    Connections = {},
}

local ARRIVE_DIST = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT = 2.5
local TRAVEL_HEIGHT = 4
local CHECK_HZ = 0.1

local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087

local function isInsideTownOfBeginnings(position)
    return position.X >= ISLAND_MIN_X
        and position.X <= ISLAND_MAX_X
        and position.Z >= ISLAND_MIN_Z
        and position.Z <= ISLAND_MAX_Z
end

local function collectChests()
    local chests = {}
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local action = v.ActionText or ""
            if action:find("Peli Chest") then
                local part = v.Parent
                if part and part:IsA("BasePart") then
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

local function waitForRoot(timeout)
    local t = 0
    while t < timeout do
        local r = Core.GetRoot(LocalPlayer)
        if r then
            return r
        end
        task.wait(0.1)
        t = t + 0.1
    end
    return nil
end

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
local HEIGHT_OFFSET = 6.0
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

function OpenChests.Stop()
    OpenChests.Running = false
    for _, conn in ipairs(OpenChests.Connections) do
        conn:Disconnect()
    end
    OpenChests.Connections = {}
    print("[OpenChests] Stopped.")
end

function OpenChests.Start()
    if OpenChests.Running then
        warn("[OpenChests] Already running!")
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    OpenChests.Running = true

    task.spawn(function()
        local allChests = collectChests()
        print(string.format("[OpenChests] Found %d Peli Chests total in workspace.", #allChests))

        if #allChests == 0 then
            warn("[OpenChests] No chests found — are you in the right area?")
            OpenChests.Stop()
            return
        end

        local startRoot = waitForRoot(5)
        if not startRoot then
            warn("[OpenChests] Could not find character root! Aborting.")
            OpenChests.Stop()
            return
        end

        local playerStartPos = startRoot.Position
        local playerStartY = playerStartPos.Y
        local filtered = {}
        local skippedIsland = 0
        local skippedY = 0

        for _, c in ipairs(allChests) do
            if not isInsideTownOfBeginnings(c.position) then
                skippedIsland = skippedIsland + 1
            elseif c.position.Y > playerStartY + 20 then
                skippedY = skippedY + 1
            else
                table.insert(filtered, c)
            end
        end

        table.sort(filtered, function(a, b)
            return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
        end)

        local chests = filtered
        print(
            string.format(
                "[OpenChests] %d chests queued | %d outside island | %d too high.",
                #chests,
                skippedIsland,
                skippedY
            )
        )

        if #chests == 0 then
            warn("[OpenChests] No reachable chests after filtering.")
            OpenChests.Stop()
            return
        end

        if not EasyTravel then
            error("[OpenChests] Failed to load easy_travel_v2.lua")
        end

        EasyTravel.Start()
        print("[OpenChests] Easy Travel started.")

        for i, chest in ipairs(chests) do
            if not OpenChests.Running then
                break
            end
            print(string.format("[OpenChests] [%d/%d] Travelling to chest at %s", i, #chests, chest.label))

            EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)

            local elapsed = 0
            while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
                task.wait(CHECK_HZ)
                elapsed = elapsed + CHECK_HZ

                local root = Core.GetRoot(LocalPlayer)
                if not root then
                    warn("[OpenChests] Lost character — pausing.")
                    task.wait(1)
                    root = waitForRoot(5)
                    if not root then
                        break
                    end
                end

                local dist = (root.Position - chest.position).Magnitude
                if dist <= ARRIVE_DIST then
                    break
                end
            end

            if not OpenChests.Running then
                break
            end

            local currentRoot = Core.GetRoot(LocalPlayer)
            if currentRoot then
                EasyTravel.TargetPosition = currentRoot.Position
            end

            if chest.prompt and chest.prompt.Parent then
                local ok, err = pcall(function()
                    fireproximityprompt(chest.prompt)
                end)
                if not ok then
                    pcall(function()
                        chest.prompt.Triggered:Fire(LocalPlayer)
                    end)
                end
            end

            task.wait(OPEN_WAIT)
        end

        if EasyTravel then
            EasyTravel.TargetPosition = nil
            pcall(EasyTravel.Stop)
        end

        if OpenChests.Running then
            print("[OpenChests] All chests processed!")
            OpenChests.Stop()
        end
    end)
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(OpenChests, "OpenChests", OpenChests.Start, OpenChests.Stop, function()
    return OpenChests.Running
end)

return OpenChests
