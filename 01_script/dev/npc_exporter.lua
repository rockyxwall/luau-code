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
local npcsFolder = workspace:FindFirstChild(_d({29,31,18,66},49))
if not npcsFolder then
print(_d({42,29,31,18,239,20,71,63,62,65,67,52,65,44,239,246,29,31,18,66,246,239,53,62,59,51,52,65,239,61,62,67,239,53,62,68,61,51,239,56,61,239,70,62,65,58,66,63,48,50,52,240},49))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({28,62,51,52,59},49)) and npc.Name ~= "" then
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
error(_d({18,59,56,63,49,62,48,65,51,239,53,68,61,50,67,56,62,61,239,61,62,67,239,66,68,63,63,62,65,67,52,51,239,49,72,239,67,55,56,66,239,52,71,52,50,68,67,62,65,253},49))
end
end)
if success then
print(_d({42,29,31,18,239,20,71,63,62,65,67,52,65,44,239,34,68,50,50,52,66,66,53,68,59,59,72,239,50,62,63,56,52,51,239},49) .. #npcList .. _d({239,68,61,56,64,68,52,239,29,31,18,239,61,48,60,52,66,239,67,62,239,72,62,68,65,239,50,59,56,63,49,62,48,65,51,240},49))
print("NPCs found:\n" .. outputText)
else
warn(_d({42,29,31,18,239,20,71,63,62,65,67,52,65,44,239,21,48,56,59,52,51,239,67,62,239,50,62,63,72,239,67,62,239,50,59,56,63,49,62,48,65,51,9,239},49) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()