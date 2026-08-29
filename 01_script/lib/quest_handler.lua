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

    if module and module.Connections then
        table.insert(module.Connections, connection)
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
