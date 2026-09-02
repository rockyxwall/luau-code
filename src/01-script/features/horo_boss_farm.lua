--[[
    Horo Horo Z-Skill Loop Farm - v0.0.4
    Automates skills on a selected boss using reliable camera alignment and humanized inputs.
    Headless module compatible with hub or standalone execution.
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local HoroFarm = {
    Running = false,
    Config = {
        SelectedBoss = "Juzo the Diamondback", -- Default boss
        UseE = true,
        UseZ = true,
        UseC = true,
        UseR = true,
        CameraHeight = 30.0,
        LoopDelay = 10.5,
    },
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

local lastC = 0
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = "HoroCameraLock"

local function pressKey(key, hold)
    hold = hold or (0.05 + math.random() * 0.03)
    VIM:SendKeyEvent(true, key, false, game)
    task.wait(hold)
    VIM:SendKeyEvent(false, key, false, game)
end

local function humanWait(base, jitter)
    task.wait(base + math.random() * (jitter or 0.04))
end

local function equipHoroTool()
    local char = LocalPlayer.Character
    if not char then
        return nil
    end

    local tool = char:FindFirstChild("Horo-Horo")
    if tool then
        return tool
    end

    local bp = LocalPlayer:FindFirstChild("Backpack")
    tool = bp and bp:FindFirstChild("Horo-Horo")
    if tool then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum:EquipTool(tool)
        end
    end
    return tool
end

local function isAlive(model)
    if not model or not model.Parent then
        return false
    end
    local hum = model:FindFirstChildWhichIsA("Humanoid")
    return hum and hum.Health > 0
end

local function getBossPart(name)
    local npcs = Workspace:FindFirstChild("NPCs")
    if not npcs then
        return nil
    end

    if name and name ~= "" then
        local boss = npcs:FindFirstChild(name)
        if boss and isAlive(boss) then
            return boss:FindFirstChild("HumanoidRootPart")
        end
    end

    -- Fallback: any alive boss (MaxHealth > 1000)
    for _, npc in ipairs(npcs:GetChildren()) do
        if isAlive(npc) then
            local hum = npc:FindFirstChildWhichIsA("Humanoid")
            local root = npc:FindFirstChild("HumanoidRootPart")
            if root and hum.MaxHealth > 1000 then
                return root
            end
        end
    end
    return nil
end

local function aimAt(targetPos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(targetPos)
    if onScreen then
        local jitterX = screenPos.X + math.random(-2, 2)
        local jitterY = screenPos.Y + math.random(-2, 2)
        VIM:SendMouseMoveEvent(jitterX, jitterY, game)
    end
end

local function lockCameraToBoss(targetRoot)
    if not savedCameraCF then
        savedCameraCF = Camera.CFrame
        savedCameraType = Camera.CameraType
    end

    if not cameraBound then
        cameraBound = true
        Camera.CameraType = Enum.CameraType.Scriptable

        RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
            if targetRoot and isAlive(targetRoot.Parent) then
                local bossPos = targetRoot.Position
                local camPos = bossPos + Vector3.new(0, HoroFarm.Config.CameraHeight, 0)
                Camera.CFrame = CFrame.lookAt(camPos, bossPos)
            else
                HoroFarm.UnlockCamera()
            end
        end)
    end
end

function HoroFarm.UnlockCamera()
    if cameraBound then
        pcall(function()
            RunService:UnbindFromRenderStep(BIND_NAME)
        end)
        cameraBound = false
    end
    if savedCameraType and savedCameraCF then
        Camera.CameraType = savedCameraType
        Camera.CFrame = savedCameraCF
        savedCameraType = nil
        savedCameraCF = nil
    else
        Camera.CameraType = Enum.CameraType.Custom
    end
end

function HoroFarm.Stop()
    HoroFarm.Running = false
    HoroFarm.UnlockCamera()
    print("[HoroFarm] Stopped.")
end

function HoroFarm.Start()
    if HoroFarm.Running then
        return
    end
    if Safeguard and not Safeguard.IsSafe() then
        return
    end

    HoroFarm.Running = true
    print("[HoroFarm] Started targeting: " .. tostring(HoroFarm.Config.SelectedBoss))

    task.spawn(function()
        while HoroFarm.Running do
            local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
            if not targetRoot then
                HoroFarm.UnlockCamera()
                task.wait(3 + math.random())
            else
                lockCameraToBoss(targetRoot)
                local tool = equipHoroTool()

                if tool and isAlive(targetRoot.Parent) then
                    local comboStart = tick()
                    local hollowsAttached = false

                    -- Step 1: Attach Hollows (C or Z)
                    if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
                        aimAt(targetRoot.Position)
                        pressKey(Enum.KeyCode.C)
                        lastC = tick()
                        hollowsAttached = true
                    elseif HoroFarm.Config.UseZ then
                        -- Summon hollows
                        pressKey(Enum.KeyCode.Z)
                        humanWait(0.3, 0.05)

                        -- Aim & fire hollows
                        if isAlive(targetRoot.Parent) then
                            aimAt(targetRoot.Position)
                            humanWait(0.08, 0.03)
                            pressKey(Enum.KeyCode.Z)
                            hollowsAttached = true
                        end
                    end

                    -- Step 2: Stun (E)
                    if HoroFarm.Config.UseE and isAlive(targetRoot.Parent) then
                        humanWait(0.18, 0.04)
                        aimAt(targetRoot.Position)
                        pressKey(Enum.KeyCode.E)
                    end

                    -- Step 3: Detonation (R)
                    if HoroFarm.Config.UseR and hollowsAttached and isAlive(targetRoot.Parent) then
                        humanWait(1.95, 0.1)
                        pressKey(Enum.KeyCode.R)
                    end

                    local baseCD = HoroFarm.Config.UseE and 17 or HoroFarm.Config.LoopDelay
                    local elapsed = tick() - comboStart
                    local finalSleep = math.max(baseCD - elapsed, 1) + (math.random() * 0.3)
                    task.wait(finalSleep)
                else
                    task.wait(1)
                end
            end
        end
        HoroFarm.UnlockCamera()
    end)
end

-- ============================================================
-- STANDALONE BEHAVIOR
-- ============================================================
Core.SetupStandalone(HoroFarm, "HoroFarm", HoroFarm.Start, HoroFarm.Stop, function()
    return HoroFarm.Running
end)

return HoroFarm
