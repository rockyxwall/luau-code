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
local npcsFolder = workspace:FindFirstChild(_d({61,63,50,98},17))
if not npcsFolder then
print(_d({74,61,63,50,15,52,103,95,94,97,99,84,97,76,15,22,61,63,50,98,22,15,85,94,91,83,84,97,15,93,94,99,15,85,94,100,93,83,15,88,93,15,102,94,97,90,98,95,80,82,84,16},17))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({60,94,83,84,91},17)) and npc.Name ~= "" then
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
error(_d({50,91,88,95,81,94,80,97,83,15,85,100,93,82,99,88,94,93,15,93,94,99,15,98,100,95,95,94,97,99,84,83,15,81,104,15,99,87,88,98,15,84,103,84,82,100,99,94,97,29},17))
end
end)
if success then
print(_d({74,61,63,50,15,52,103,95,94,97,99,84,97,76,15,66,100,82,82,84,98,98,85,100,91,91,104,15,82,94,95,88,84,83,15},17) .. #npcList .. _d({15,100,93,88,96,100,84,15,61,63,50,15,93,80,92,84,98,15,99,94,15,104,94,100,97,15,82,91,88,95,81,94,80,97,83,16},17))
print("NPCs found:\n" .. outputText)
else
warn(_d({74,61,63,50,15,52,103,95,94,97,99,84,97,76,15,53,80,88,91,84,83,15,99,94,15,82,94,95,104,15,99,94,15,82,91,88,95,81,94,80,97,83,41,15},17) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()