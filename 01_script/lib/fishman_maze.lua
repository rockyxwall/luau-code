--[[
    ================================================================================
    Fishman Maze Suite - EasyTravel-Powered Point-to-Point Traversal
    ================================================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

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

    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, processed)
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

local FishmanMaze = {}

-- Fishman Cave mazePath — corrected for player hitbox (agent radius = 2 studs, Roblox default)
-- Original scan treated the player as a single point/ray, so several waypoints sat AT or PAST
-- a wall (0 or negative clearance). Fixed points use true corridor-center math instead.
-- ⚠ = pinch point with ≤1 stud clearance per side even after centering — move slow/exact there.
local mazePath = {
    Vector3.new(1836.00, 4.1, -12190.00), -- Surface descent
    Vector3.new(1836.00, -86.0, -12190.00), -- Cave floor
    Vector3.new(1836.00, -86.0, -12212.00), -- Turn 1  [FIX: was -12214, true center]
    Vector3.new(1770.00, -86.0, -12212.00), -- Turn 2
    Vector3.new(1770.00, -86.0, -12222.00), -- Elev1 approach
    Vector3.new(1767.20, -78.0, -12224.00), -- Elev1 top      [FIX: was X=1770, clipped east wall]
    Vector3.new(1767.20, -78.0, -12226.00), -- Elev1 top cont [FIX]
    Vector3.new(1767.20, -86.0, -12228.00), -- Elev1 exit     [FIX]
    Vector3.new(1790.00, -86.0, -12228.50), -- Turn 3  [FIX: was -12230, true center]
    Vector3.new(1791.25, -86.0, -12243.50), -- Turn 4  [FIX: X true center; Z pulled off south wall]
    Vector3.new(1777.25, -86.0, -12243.50), -- Turn 5  [MAJOR FIX: was X=1782 → only 1.2 studs to
    --  east wall, i.e. NEGATIVE clearance for a 2-stud-
    --  radius body. True center of the pinch is 1777.25]
    Vector3.new(1777.25, -86.0, -12275.50), -- Turn 6  [FIX: Z = true center of the SEG7 pinch]
    Vector3.new(1802.00, -86.0, -12275.50), -- Turn 7  ⚠ corridor is only 4 studs wide here —
    --  ZERO clearance either side even dead-center
    Vector3.new(1802.00, -86.0, -12280.00), -- junction (open, no wall data)
    Vector3.new(1811.20, -86.0, -12280.00), -- Turn 8  [X snapped to true center early]
    Vector3.new(1811.20, -86.0, -12297.05), -- Turn 9  [MAJOR FIX: was Z=-12300 → that is PAST the
    --  south wall (-12298.5), i.e. embedded in geometry]
    Vector3.new(1846.00, -86.0, -12297.05), -- Turn 10 ⚠ corridor here is only ~2.9 studs wide —
    --  narrower than a standard player; no line-up avoids
    --  clipping, only true noclip gets through clean
    Vector3.new(1846.00, -86.0, -12305.55), -- Turn 11 [MAJOR FIX: was Z=-12308, past south wall]
    Vector3.new(1821.20, -86.0, -12305.55), -- Turn 12 [X true center]
    Vector3.new(1821.20, -86.0, -12320.00), -- Elev2 approach
    Vector3.new(1819.20, -78.0, -12322.00), -- Elev2 top      [MAJOR FIX: was X=1822, only 1.2
    Vector3.new(1819.20, -78.0, -12324.00), -- Elev2 top cont --  studs to east wall → negative clr]
    Vector3.new(1819.20, -86.0, -12326.00), -- Elev2 exit     [FIX]
    Vector3.new(1819.20, -86.0, -12327.75), -- Final corridor start [Z true center]
    Vector3.new(1793.70, -86.0, -12327.75), -- Final run
    Vector3.new(1793.70, -86.0, -12330.50), -- END ORB
}

function FishmanMaze.Travel(hrp, isRunning)
    if not hrp or not Core then
        return
    end

    local EasyTravel = (function()
        
--[[
    ================================================================================
    EASY TRAVEL SUITE - WASD GROUND-FOLLOWING & HYPOTENUSE WALL-CLIMBING FLIGHT
    ================================================================================
    Provides coordinate-based flight (Start/Stop).
    If run standalone (not loaded via hub or importLib), binds ']' to toggle flight.
    ================================================================================
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

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

    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, processed)
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

local UserInputService = game:GetService("UserInputService")
local Workspace = workspace

local LocalPlayer = Players.LocalPlayer

local EasyTravel = {
    TargetPosition = nil,
    DisableKeyboard = false,
    Speed = 70.0,
    Enabled = false,
    DisableRaycasting = false,
    DisableWallTouch = false,
    Connections = {},
}

-- Configurations
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
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
        local inRoughWaters = currentPos.X >= 1002.01
            and currentPos.X <= 3049.91
            and currentPos.Z >= -11748.53
            and currentPos.Z <= -9700.63

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
    if not Safeguard then
        warn("[Safeguard] Failed to load!")
        return
    end
    if not Safeguard.IsSafe() then
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
Core.SetupStandalone(EasyTravel, "Easy Travel", EasyTravel.Start, EasyTravel.Stop, function()
    return EasyTravel.Enabled
end, Enum.KeyCode.P, true)

return EasyTravel


    end)()
    if not EasyTravel then
        warn("[Fishman Maze] Failed to load EasyTravel!")
        return
    end
    if EasyTravel.Cleanup then
        pcall(EasyTravel.Cleanup)
    end

    print("[Fishman Maze] Starting EasyTravel-based maze traversal...")

    local nocollide = RunService.Stepped:Connect(function()
        local c = LocalPlayer.Character
        if c then
            for _, part in ipairs(c:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)

    EasyTravel.DisableRaycasting = true
    EasyTravel.DisableWallTouch = true
    EasyTravel.Speed = 25 -- Safe movement velocity

    for i, target in ipairs(mazePath) do
        EasyTravel.TargetPosition = target
        pcall(EasyTravel.Start)

        while (hrp.Position - target).Magnitude > 4 do
            if isRunning and not isRunning() then
                break
            end
            RunService.Heartbeat:Wait()
        end
        if isRunning and not isRunning() then
            break
        end
    end

    pcall(EasyTravel.Stop)
    EasyTravel.DisableRaycasting = false
    EasyTravel.DisableWallTouch = false
    nocollide:Disconnect()
    print("[Fishman Maze] Complete.")
end

return FishmanMaze
