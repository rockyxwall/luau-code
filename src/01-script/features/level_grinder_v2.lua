--[[
    ================================================================================
    Level Grinder V2 - Sea Serpent / G-1 Progression (Rifle -> Boat -> G-1 Spawn)
    ================================================================================
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
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

local oldStandalone = _G.DisableStandalone
_G.DisableStandalone = true

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

-- Import helper to avoid globals

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

    local EasyTravel = (function()
        
--[[
    ================================================================================
    EASY TRAVEL LIBRARY (Ponytail Optimized)
    ================================================================================
    High-speed LinearVelocity travel engine with raycast obstacle climbing.
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
    DisableRaycasting = false,
    DisableKeyboard = false,
    Speed = 150,
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

local SEA_LEVEL_Y = -8.5
local BASE_HEIGHT_OFFSET = 10
local FORWARD_SCAN_DIST = 35

local loopConnection = nil
local raycastParams = nil
local targetY = SEA_LEVEL_Y + BASE_HEIGHT_OFFSET

local function getCharRoot()
    local c = LocalPlayer.Character
    local hum = c and c:FindFirstChildWhichIsA("Humanoid")
    local root = c and c:FindFirstChild("HumanoidRootPart")
    return c, hum, root
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce") or Instance.new("LinearVelocity")
    force.Name = "__EasyTravelForce"
    force.Attachment0 = att
    force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    force.RelativeTo = Enum.ActuatorRelativeTo.World
    force.MaxForce = 1000000
    force.VectorVelocity = Vector3.zero
    force.Parent = root

    return force
end

local function destroyForce(root)
    if not root then
        return
    end
    local force = root:FindFirstChild("__EasyTravelForce")
    if force then
        force:Destroy()
    end
    local att = root:FindFirstChild("__EasyTravelAtt")
    if att then
        att:Destroy()
    end
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end

function EasyTravel.Cleanup()
    local _, hum, root = getCharRoot()
    if hum then
        hum.PlatformStand = false
    end
    destroyForce(root)
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    EasyTravel.Cleanup()
end

local function updateRaycast(root, currentPos, moveDir)
    if EasyTravel.DisableRaycasting then
        targetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
        return
    end

    if not raycastParams then
        raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.IgnoreWater = true
    end
    local c = LocalPlayer.Character
    raycastParams.FilterDescendantsInstances = c and { c } or {}

    -- 1. Ground detection under character
    local downHit = Workspace:Raycast(currentPos + Vector3.new(0, 2, 0), Vector3.new(0, -60, 0), raycastParams)
    local floorY = downHit and downHit.Position.Y or SEA_LEVEL_Y
    local baseTargetY = math.max(floorY, SEA_LEVEL_Y) + BASE_HEIGHT_OFFSET

    if EasyTravel.TargetPosition then
        baseTargetY = math.max(baseTargetY, EasyTravel.TargetPosition.Y)
    end

    -- 2. Forward obstacle detection & automatic clearance elevation
    if moveDir.Magnitude > 0.1 then
        local forwardHit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DIST, raycastParams)
        if forwardHit then
            -- Scan upward in 5-stud increments for clearance over the obstacle
            local clearanceY = forwardHit.Position.Y + BASE_HEIGHT_OFFSET
            for offset = 4, 100, 5 do
                local scanOrigin = currentPos + Vector3.new(0, offset, 0)
                local hit = Workspace:Raycast(scanOrigin, moveDir.Unit * FORWARD_SCAN_DIST, raycastParams)
                if not hit then
                    clearanceY = scanOrigin.Y + BASE_HEIGHT_OFFSET
                    break
                end
            end
            baseTargetY = math.max(baseTargetY, clearanceY)
        end
    end

    targetY = baseTargetY
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard or not Safeguard.IsSafe() then
        return
    end

    local char, hum, root = getCharRoot()
    if not char or not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    local force = getOrCreateForce(root)
    targetY = root.Position.Y

    local lastRaycastTick = 0

    loopConnection = RunService.Heartbeat:Connect(function()
        local c, h, r = getCharRoot()
        if not r or not h or not EasyTravel.Enabled then
            EasyTravel.Stop()
            return
        end

        h.PlatformStand = true

        local currentPos = r.Position
        local moveDir = Vector3.zero
        local target = EasyTravel.TargetPosition

        if target then
            local diff = target - currentPos
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 1.5 then
                moveDir = flatDiff.Unit
            end
        elseif not EasyTravel.DisableKeyboard then
            local cam = Workspace.CurrentCamera
            if cam then
                local look = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector
                local forwardFlat = Vector3.new(look.X, 0, look.Z).Unit
                local rightFlat = Vector3.new(right.X, 0, right.Z).Unit

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
                    moveDir = moveDir.Unit
                end
            end
        end

        -- Periodic obstacle / terrain raycast (every 0.05s)
        local now = tick()
        if now - lastRaycastTick >= 0.05 then
            lastRaycastTick = now
            updateRaycast(r, currentPos, moveDir)
        end

        -- Proportional vertical smoothing toward targetY
        local yDiff = targetY - currentPos.Y
        local yVelocity = math.clamp(yDiff * 15, -EasyTravel.Speed, EasyTravel.Speed)
        local hVelocity = moveDir * EasyTravel.Speed

        force.VectorVelocity = Vector3.new(hVelocity.X, yVelocity, hVelocity.Z)
    end)
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.RightBracket, true)

return EasyTravel


    end)()

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

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
function ChestFarmer.Start()
    if ChestFarmer.Running then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    ChestFarmer.Running = true
    task.spawn(function()
        ChestFarmer.FarmUntilPeli(9999999, function()
            return 0
        end, function()
            return ChestFarmer.Running
        end)
    end)
end

Core.SetupStandalone(ChestFarmer, "ChestFarmer", ChestFarmer.Start, ChestFarmer.Stop, function()
    return ChestFarmer.Running
end)

return ChestFarmer


end)()

local EasyTravel = (function()
    
--[[
    ================================================================================
    EASY TRAVEL LIBRARY (Ponytail Optimized)
    ================================================================================
    High-speed LinearVelocity travel engine with raycast obstacle climbing.
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
    DisableRaycasting = false,
    DisableKeyboard = false,
    Speed = 150,
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

local SEA_LEVEL_Y = -8.5
local BASE_HEIGHT_OFFSET = 10
local FORWARD_SCAN_DIST = 35

local loopConnection = nil
local raycastParams = nil
local targetY = SEA_LEVEL_Y + BASE_HEIGHT_OFFSET

local function getCharRoot()
    local c = LocalPlayer.Character
    local hum = c and c:FindFirstChildWhichIsA("Humanoid")
    local root = c and c:FindFirstChild("HumanoidRootPart")
    return c, hum, root
end

local function getOrCreateForce(root)
    local att = root:FindFirstChild("__EasyTravelAtt") or Instance.new("Attachment")
    att.Name = "__EasyTravelAtt"
    att.Parent = root

    local force = root:FindFirstChild("__EasyTravelForce") or Instance.new("LinearVelocity")
    force.Name = "__EasyTravelForce"
    force.Attachment0 = att
    force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
    force.RelativeTo = Enum.ActuatorRelativeTo.World
    force.MaxForce = 1000000
    force.VectorVelocity = Vector3.zero
    force.Parent = root

    return force
end

local function destroyForce(root)
    if not root then
        return
    end
    local force = root:FindFirstChild("__EasyTravelForce")
    if force then
        force:Destroy()
    end
    local att = root:FindFirstChild("__EasyTravelAtt")
    if att then
        att:Destroy()
    end
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
end

function EasyTravel.Cleanup()
    local _, hum, root = getCharRoot()
    if hum then
        hum.PlatformStand = false
    end
    destroyForce(root)
end

function EasyTravel.Stop()
    EasyTravel.Enabled = false
    if loopConnection then
        loopConnection:Disconnect()
        loopConnection = nil
    end
    EasyTravel.Cleanup()
end

local function updateRaycast(root, currentPos, moveDir)
    if EasyTravel.DisableRaycasting then
        targetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
        return
    end

    if not raycastParams then
        raycastParams = RaycastParams.new()
        raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        raycastParams.IgnoreWater = true
    end
    local c = LocalPlayer.Character
    raycastParams.FilterDescendantsInstances = c and { c } or {}

    -- 1. Ground detection under character
    local downHit = Workspace:Raycast(currentPos + Vector3.new(0, 2, 0), Vector3.new(0, -60, 0), raycastParams)
    local floorY = downHit and downHit.Position.Y or SEA_LEVEL_Y
    local baseTargetY = math.max(floorY, SEA_LEVEL_Y) + BASE_HEIGHT_OFFSET

    if EasyTravel.TargetPosition then
        baseTargetY = math.max(baseTargetY, EasyTravel.TargetPosition.Y)
    end

    -- 2. Forward obstacle detection & automatic clearance elevation
    if moveDir.Magnitude > 0.1 then
        local forwardHit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DIST, raycastParams)
        if forwardHit then
            -- Scan upward in 5-stud increments for clearance over the obstacle
            local clearanceY = forwardHit.Position.Y + BASE_HEIGHT_OFFSET
            for offset = 4, 100, 5 do
                local scanOrigin = currentPos + Vector3.new(0, offset, 0)
                local hit = Workspace:Raycast(scanOrigin, moveDir.Unit * FORWARD_SCAN_DIST, raycastParams)
                if not hit then
                    clearanceY = scanOrigin.Y + BASE_HEIGHT_OFFSET
                    break
                end
            end
            baseTargetY = math.max(baseTargetY, clearanceY)
        end
    end

    targetY = baseTargetY
end

function EasyTravel.Start()
    if EasyTravel.Enabled then
        return
    end
    if not Safeguard or not Safeguard.IsSafe() then
        return
    end

    local char, hum, root = getCharRoot()
    if not char or not root or not hum then
        return
    end

    EasyTravel.Enabled = true
    local force = getOrCreateForce(root)
    targetY = root.Position.Y

    local lastRaycastTick = 0

    loopConnection = RunService.Heartbeat:Connect(function()
        local c, h, r = getCharRoot()
        if not r or not h or not EasyTravel.Enabled then
            EasyTravel.Stop()
            return
        end

        h.PlatformStand = true

        local currentPos = r.Position
        local moveDir = Vector3.zero
        local target = EasyTravel.TargetPosition

        if target then
            local diff = target - currentPos
            local flatDiff = Vector3.new(diff.X, 0, diff.Z)
            if flatDiff.Magnitude > 1.5 then
                moveDir = flatDiff.Unit
            end
        elseif not EasyTravel.DisableKeyboard then
            local cam = Workspace.CurrentCamera
            if cam then
                local look = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector
                local forwardFlat = Vector3.new(look.X, 0, look.Z).Unit
                local rightFlat = Vector3.new(right.X, 0, right.Z).Unit

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
                    moveDir = moveDir.Unit
                end
            end
        end

        -- Periodic obstacle / terrain raycast (every 0.05s)
        local now = tick()
        if now - lastRaycastTick >= 0.05 then
            lastRaycastTick = now
            updateRaycast(r, currentPos, moveDir)
        end

        -- Proportional vertical smoothing toward targetY
        local yDiff = targetY - currentPos.Y
        local yVelocity = math.clamp(yDiff * 15, -EasyTravel.Speed, EasyTravel.Speed)
        local hVelocity = moveDir * EasyTravel.Speed

        force.VectorVelocity = Vector3.new(hVelocity.X, yVelocity, hVelocity.Z)
    end)
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.RightBracket, true)

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

local QuestHandler = {
    Connections = {},
    Running = false,
    TargetNPC = "Bomi", -- Default NPC for standalone testing
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

function QuestHandler.Start()
    if QuestHandler.Running then
        return
    end
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
        return
    end
    QuestHandler.Running = true
    task.spawn(function()
        print("[Quest Handler] Attempting to talk to test NPC:", QuestHandler.TargetNPC)
        QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
        QuestHandler.Running = false
    end)
end

function QuestHandler.Stop()
    QuestHandler.Running = false
    print("[Quest Handler] Stopped.")
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(QuestHandler, "Quest Handler", QuestHandler.Start, QuestHandler.Stop, function()
    return QuestHandler.Running
end, Enum.KeyCode.P, true)

_G.QuestHandler = QuestHandler
return QuestHandler


end)()

_G.DisableStandalone = oldStandalone

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

local function travelTo(targetPos, reachDist, noCollide)
    if not EasyTravel then
        return false
    end
    reachDist = reachDist or 8
    local conn = nil
    if noCollide then
        conn = RunService.Stepped:Connect(function()
            local c = LocalPlayer.Character
            if c then
                for _, part in ipairs(c:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end

    EasyTravel.DisableRaycasting = false
    EasyTravel.DisableWallTouch = false
    EasyTravel.TargetPosition = targetPos
    pcall(EasyTravel.Start)

    while LevelGrinderV2.Running do
        local _, hrp = getCharRoot()
        if hrp and (hrp.Position - targetPos).Magnitude <= reachDist then
            break
        end
        task.wait(0.3)
    end

    EasyTravel.TargetPosition = nil
    if EasyTravel.Cleanup then
        pcall(EasyTravel.Cleanup)
    else
        pcall(EasyTravel.Stop)
    end
    if conn then
        conn:Disconnect()
    end
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
            travelTo(root.Position + Vector3.new(0, 0, 3), 6, true)
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
            travelTo(pPart.Position + Vector3.new(0, 0, 3), 6, true)
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

                if shopPart and travelTo(shopPart.Position, 8, true) then
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
                if shopPart and travelTo(shopPart.Position, 8, true) then
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
                travelTo(Vector3.new(hrp.Position.X, hrp.Position.Y + 15, hrp.Position.Z), 2, true)
            end
        end

        -- Phase 4: Fly to Marine Base G-1 (Raycasting active, stuck prevention active)
        print("[Level Grinder V2] Flying to Marine Base G-1...")
        travelTo(Vector3.new(-6038, 50, -11329), 12, false)

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
