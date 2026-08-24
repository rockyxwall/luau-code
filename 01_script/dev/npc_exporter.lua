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
local npcsFolder = workspace:FindFirstChild(_d({60,62,49,97},18))
if not npcsFolder then
print(_d({73,60,62,49,14,51,102,94,93,96,98,83,96,75,14,21,60,62,49,97,21,14,84,93,90,82,83,96,14,92,93,98,14,84,93,99,92,82,14,87,92,14,101,93,96,89,97,94,79,81,83,15},18))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({59,93,82,83,90},18)) and npc.Name ~= "" then
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
error(_d({49,90,87,94,80,93,79,96,82,14,84,99,92,81,98,87,93,92,14,92,93,98,14,97,99,94,94,93,96,98,83,82,14,80,103,14,98,86,87,97,14,83,102,83,81,99,98,93,96,28},18))
end
end)
if success then
print(_d({73,60,62,49,14,51,102,94,93,96,98,83,96,75,14,65,99,81,81,83,97,97,84,99,90,90,103,14,81,93,94,87,83,82,14},18) .. #npcList .. _d({14,99,92,87,95,99,83,14,60,62,49,14,92,79,91,83,97,14,98,93,14,103,93,99,96,14,81,90,87,94,80,93,79,96,82,15},18))
print("NPCs found:\n" .. outputText)
else
warn(_d({73,60,62,49,14,51,102,94,93,96,98,83,96,75,14,52,79,87,90,83,82,14,98,93,14,81,93,94,103,14,98,93,14,81,90,87,94,80,93,79,96,82,40,14},18) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()