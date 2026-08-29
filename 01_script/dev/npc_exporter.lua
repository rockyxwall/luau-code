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
local npcsFolder = workspace:FindFirstChild(_d({63,65,52,100},15))
if not npcsFolder then
print(_d({76,63,65,52,17,54,105,97,96,99,101,86,99,78,17,24,63,65,52,100,24,17,87,96,93,85,86,99,17,95,96,101,17,87,96,102,95,85,17,90,95,17,104,96,99,92,100,97,82,84,86,18},15))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({62,96,85,86,93},15)) and npc.Name ~= "" then
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
error(_d({52,93,90,97,83,96,82,99,85,17,87,102,95,84,101,90,96,95,17,95,96,101,17,100,102,97,97,96,99,101,86,85,17,83,106,17,101,89,90,100,17,86,105,86,84,102,101,96,99,31},15))
end
end)
if success then
print(_d({76,63,65,52,17,54,105,97,96,99,101,86,99,78,17,68,102,84,84,86,100,100,87,102,93,93,106,17,84,96,97,90,86,85,17},15) .. #npcList .. _d({17,102,95,90,98,102,86,17,63,65,52,17,95,82,94,86,100,17,101,96,17,106,96,102,99,17,84,93,90,97,83,96,82,99,85,18},15))
print("NPCs found:\n" .. outputText)
else
warn(_d({76,63,65,52,17,54,105,97,96,99,101,86,99,78,17,55,82,90,93,86,85,17,101,96,17,84,96,97,106,17,101,96,17,84,93,90,97,83,96,82,99,85,43,17},15) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()