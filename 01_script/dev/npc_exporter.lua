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
local npcsFolder = workspace:FindFirstChild(_d({50,52,39,87},28))
if not npcsFolder then
print(_d({63,50,52,39,4,41,92,84,83,86,88,73,86,65,4,11,50,52,39,87,11,4,74,83,80,72,73,86,4,82,83,88,4,74,83,89,82,72,4,77,82,4,91,83,86,79,87,84,69,71,73,5},28))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({49,83,72,73,80},28)) and npc.Name ~= "" then
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
error(_d({39,80,77,84,70,83,69,86,72,4,74,89,82,71,88,77,83,82,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,88,76,77,87,4,73,92,73,71,89,88,83,86,18},28))
end
end)
if success then
print(_d({63,50,52,39,4,41,92,84,83,86,88,73,86,65,4,55,89,71,71,73,87,87,74,89,80,80,93,4,71,83,84,77,73,72,4},28) .. #npcList .. _d({4,89,82,77,85,89,73,4,50,52,39,4,82,69,81,73,87,4,88,83,4,93,83,89,86,4,71,80,77,84,70,83,69,86,72,5},28))
print("NPCs found:\n" .. outputText)
else
warn(_d({63,50,52,39,4,41,92,84,83,86,88,73,86,65,4,42,69,77,80,73,72,4,88,83,4,71,83,84,93,4,88,83,4,71,80,77,84,70,83,69,86,72,30,4},28) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()