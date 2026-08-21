(function()
local _char = string.char
local _concat = table.concat
local function _d(b, k)
local t = {}
for i = 1, #b do
t[i] = _char((b[i] + k) % 256)
end
return _concat(t)
end
local npcsFolder = workspace:FindFirstChild(_d({15,17,4,52},63))
if not npcsFolder then
print(_d({28,15,17,4,225,6,57,49,48,51,53,38,51,30,225,232,15,17,4,52,232,225,39,48,45,37,38,51,225,47,48,53,225,39,48,54,47,37,225,42,47,225,56,48,51,44,52,49,34,36,38,226},63))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({14,48,37,38,45},63)) and npc.Name ~= "" then
uniqueNPCs[npc.Name] = true
end
end
local npcList = {}
for name, _ in pairs(uniqueNPCs) do
table.insert(npcList, name)
end
table.sort(npcList)
local outputText = table.concat(npcList, "\n")
local success, err = pcall(function()
if setclipboard then
setclipboard(outputText)
elseif toclipboard then
toclipboard(outputText)
else
error(_d({4,45,42,49,35,48,34,51,37,225,39,54,47,36,53,42,48,47,225,47,48,53,225,52,54,49,49,48,51,53,38,37,225,35,58,225,53,41,42,52,225,38,57,38,36,54,53,48,51,239},63))
end
end)
if success then
print(_d({28,15,17,4,225,6,57,49,48,51,53,38,51,30,225,20,54,36,36,38,52,52,39,54,45,45,58,225,36,48,49,42,38,37,225},63) .. #npcList .. _d({225,54,47,42,50,54,38,225,15,17,4,225,47,34,46,38,52,225,53,48,225,58,48,54,51,225,36,45,42,49,35,48,34,51,37,226},63))
print("NPCs found:\n" .. outputText)
else
warn(_d({28,15,17,4,225,6,57,49,48,51,53,38,51,30,225,7,34,42,45,38,37,225,53,48,225,36,48,49,58,225,53,48,225,36,45,42,49,35,48,34,51,37,251,225},63) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()