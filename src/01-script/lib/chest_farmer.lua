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
