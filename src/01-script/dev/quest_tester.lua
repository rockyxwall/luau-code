--[[
    NPC Dialog & Quest-Taking Tester (Library-based)
    Stand next to any quest NPC (like Daph, Sarah, or Ronny) and run this script.
    It loads the shared quest_handler.lua library and accepts the quest for the nearest NPC.
--]]

local Players = game:GetService("Players")
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer

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

local function getNearestNPC()
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then
        return nil
    end

    local npcsFolder = Workspace:FindFirstChild("NPCs")
    if not npcsFolder then
        return nil
    end

    local nearest, minDist = nil, 12
    for _, npc in ipairs(npcsFolder:GetChildren()) do
        local torso = npc:FindFirstChild("UpperTorso")
        local prompt = torso and torso:FindFirstChild("Prompt")
        if prompt then
            local dist = (torso.Position - myRoot.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = npc
            end
        end
    end
    return nearest
end

local npc = getNearestNPC()
if npc then
    if QuestHandler then
        print("[Quest Tester] Invoking shared QuestHandler for NPC: " .. npc.Name)
        local success = QuestHandler.AcceptQuest(npc.Name)
        print("[Quest Tester] Finished sequence. Result: " .. tostring(success))
    else
        warn("[Quest Tester] ERROR: QuestHandler library could not be loaded!")
    end
else
    print("[Quest Tester] No quest NPC found within 12 studs.")
end
