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
local npcsFolder = workspace:FindFirstChild(_d({35,37,24,72},43))
if not npcsFolder then
print(_d({48,35,37,24,245,26,77,69,68,71,73,58,71,50,245,252,35,37,24,72,252,245,59,68,65,57,58,71,245,67,68,73,245,59,68,74,67,57,245,62,67,245,76,68,71,64,72,69,54,56,58,246},43))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({34,68,57,58,65},43)) and npc.Name ~= "" then
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
error(_d({24,65,62,69,55,68,54,71,57,245,59,74,67,56,73,62,68,67,245,67,68,73,245,72,74,69,69,68,71,73,58,57,245,55,78,245,73,61,62,72,245,58,77,58,56,74,73,68,71,3},43))
end
end)
if success then
print(_d({48,35,37,24,245,26,77,69,68,71,73,58,71,50,245,40,74,56,56,58,72,72,59,74,65,65,78,245,56,68,69,62,58,57,245},43) .. #npcList .. _d({245,74,67,62,70,74,58,245,35,37,24,245,67,54,66,58,72,245,73,68,245,78,68,74,71,245,56,65,62,69,55,68,54,71,57,246},43))
print("NPCs found:\n" .. outputText)
else
warn(_d({48,35,37,24,245,26,77,69,68,71,73,58,71,50,245,27,54,62,65,58,57,245,73,68,245,56,68,69,78,245,73,68,245,56,65,62,69,55,68,54,71,57,15,245},43) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()