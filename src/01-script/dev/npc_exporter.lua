-- NPC Exporter Utility
-- Scans workspace.NPCs, finds unique NPC names, and copies them to your clipboard.

local npcsFolder = workspace:FindFirstChild("NPCs")
if not npcsFolder then
    print("[NPC Exporter] 'NPCs' folder not found in workspace!")
    return
end

local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
    if npc:IsA("Model") and npc.Name ~= "" then
        uniqueNPCs[npc.Name] = true
    end
end

local npcList = {}
for name, _ in pairs(uniqueNPCs) do
    table.insert(npcList, name)
end
table.sort(npcList)

local outputText = table.concat(npcList, "\n")

-- Attempt to write to clipboard using standard executor functions
local success, err = pcall(function()
    if setclipboard then
        setclipboard(outputText)
    elseif toclipboard then
        toclipboard(outputText)
    else
        error("Clipboard function not supported by this executor.")
    end
end)

if success then
    print("[NPC Exporter] Successfully copied " .. #npcList .. " unique NPC names to your clipboard!")
    print("NPCs found:\n" .. outputText)
else
    warn("[NPC Exporter] Failed to copy to clipboard: " .. tostring(err))
    print("NPCs found (Manually copy from console):\n" .. outputText)
end
