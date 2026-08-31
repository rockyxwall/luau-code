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

        local EasyTravel = (function()
            
--[[
    ================================================================================
    EASY TRAVEL V2 (Horizontal Whisker Engine + Stuck Vertical Climb Fallback)
    ================================================================================
    Primary: 2D horizontal whisker deflection with anti-oscillation turn memory.
    Fallback: Automatic vertical stepped-climb over obstacles ONLY when stuck.
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

-- Configurations
local HEIGHT_OFFSET = 4.0
local SEA_LEVEL_Y = -2.63
local HOVER_LIFT_GAIN = 20.0
local SCAN_DIST = 18.0

-- Internal State
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

local function findClearHeading(origin, desiredDir, char)
    if EasyTravel.DisableRaycasting or desiredDir.Magnitude < 0.01 then
        return desiredDir
    end

    local rayParams = getRayParams(char)
    local rayOrigin = origin + Vector3.new(0, 0.5, 0)

    -- 1. Direct forward raycast
    local fwdHit = Workspace:Raycast(rayOrigin, desiredDir * SCAN_DIST, rayParams)
    if not fwdHit then
        return desiredDir
    end

    -- 2. Whisker sweep with turn-memory latch
    local angles = { 35, 70, 95 }
    local signs = lastTurnSign >= 0 and { 1, -1 } or { -1, 1 }

    for _, deg in ipairs(angles) do
        local rad = math.rad(deg)
        for _, sign in ipairs(signs) do
            local probeDir = rotateXZ(desiredDir, rad * sign)
            local hit = Workspace:Raycast(rayOrigin, probeDir * SCAN_DIST, rayParams)
            if not hit then
                lastTurnSign = sign
                return probeDir
            end
        end
    end

    return desiredDir
end

-- Stepped vertical climb scan from legacy engine (triggered strictly when stuck)
local function findVerticalClimbY(origin, moveUnit, char)
    local rayParams = getRayParams(char)
    local heightOffset = 4
    local scanDist = 25
    local clearanceY = nil

    while heightOffset <= 80 do
        local scanOrigin = origin + Vector3.new(0, heightOffset, 0)
        local scanHit = Workspace:Raycast(scanOrigin, moveUnit * scanDist, rayParams)

        if not scanHit then
            clearanceY = scanOrigin.Y
            local secondaryHit = Workspace:Raycast(scanOrigin + moveUnit * 8, moveUnit * 12, rayParams)
            if secondaryHit then
                scanDist = scanDist + 10
            else
                break
            end
        end
        heightOffset = heightOffset + 4
    end

    return clearanceY
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

    local stuckFrames = 0
    local isClimbingStuck = false
    local climbTargetY = 0

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

            if dist > 1.5 then
                local rawDir = flatDiff.Unit
                moveDir = findClearHeading(currentPos, rawDir, c)
                curSpeed = math.min(EasyTravel.Speed, math.max(dist * 12, 10))
            else
                moveDir = Vector3.zero
                curSpeed = 0
            end
            desiredY = EasyTravel.TargetPosition.Y
        else
            -- Base surface height tracking
            desiredY = EasyTravel.GetSurfaceY(currentPos, c) + HEIGHT_OFFSET

            -- Manual WASD steering relative to camera
            if not EasyTravel.DisableKeyboard then
                local camera = Workspace.CurrentCamera
                if camera then
                    local look = camera.CFrame.LookVector
                    local right = camera.CFrame.RightVector
                    local forwardFlat = Vector3.new(look.X, 0, look.Z)
                    local rightFlat = Vector3.new(right.X, 0, right.Z)
                    if forwardFlat.Magnitude > 0 then
                        forwardFlat = forwardFlat.Unit
                    end
                    if rightFlat.Magnitude > 0 then
                        rightFlat = rightFlat.Unit
                    end

                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                        moveDir = moveDir + forwardFlat
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                        moveDir = moveDir - forwardFlat
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                        moveDir = moveDir + rightFlat
                    end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                        moveDir = moveDir - rightFlat
                    end

                    if moveDir.Magnitude > 0 then
                        moveDir = findClearHeading(currentPos, moveDir.Unit, c)
                    end
                end
            end
        end

        -- Stuck tracking: If attempting to move but actual velocity is blocked
        local isMoving = moveDir.Magnitude > 0.05
        local speedMag = currentRoot.AssemblyLinearVelocity.Magnitude

        if isMoving and speedMag < 3.0 then
            stuckFrames = stuckFrames + 1
        else
            stuckFrames = math.max(0, stuckFrames - 1)
        end

        -- If stuck for > 0.35s (20 frames), trigger vertical climb
        if stuckFrames >= 20 and not isClimbingStuck and isMoving then
            local climbY = findVerticalClimbY(currentPos, moveDir.Unit, c)
            if climbY then
                isClimbingStuck = true
                climbTargetY = climbY + HEIGHT_OFFSET
            end
        end

        -- Apply stuck climb altitude if active
        if isClimbingStuck then
            desiredY = math.max(desiredY, climbTargetY)
            if currentPos.Y >= climbTargetY - 1 or speedMag > 15.0 then
                isClimbingStuck = false
                stuckFrames = 0
            end
        end

        local yError = desiredY - currentPos.Y
        local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -EasyTravel.Speed, EasyTravel.Speed)
        local hVelocity = moveDir * curSpeed

        force.VectorVelocity = Vector3.new(hVelocity.X, verticalVel, hVelocity.Z)
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

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel V2", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


        end)()
        if not EasyTravel then
            error("[OpenChests] Failed to load easy_travel.lua")
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
