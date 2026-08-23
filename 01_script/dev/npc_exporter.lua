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
local npcsFolder = workspace:FindFirstChild(_d({48,50,37,85},30))
if not npcsFolder then
print(_d({61,48,50,37,2,39,90,82,81,84,86,71,84,63,2,9,48,50,37,85,9,2,72,81,78,70,71,84,2,80,81,86,2,72,81,87,80,70,2,75,80,2,89,81,84,77,85,82,67,69,71,3},30))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({47,81,70,71,78},30)) and npc.Name ~= "" then
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
error(_d({37,78,75,82,68,81,67,84,70,2,72,87,80,69,86,75,81,80,2,80,81,86,2,85,87,82,82,81,84,86,71,70,2,68,91,2,86,74,75,85,2,71,90,71,69,87,86,81,84,16},30))
end
end)
if success then
print(_d({61,48,50,37,2,39,90,82,81,84,86,71,84,63,2,53,87,69,69,71,85,85,72,87,78,78,91,2,69,81,82,75,71,70,2},30) .. #npcList .. _d({2,87,80,75,83,87,71,2,48,50,37,2,80,67,79,71,85,2,86,81,2,91,81,87,84,2,69,78,75,82,68,81,67,84,70,3},30))
print("NPCs found:\n" .. outputText)
else
warn(_d({61,48,50,37,2,39,90,82,81,84,86,71,84,63,2,40,67,75,78,71,70,2,86,81,2,69,81,82,91,2,86,81,2,69,78,75,82,68,81,67,84,70,28,2},30) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()