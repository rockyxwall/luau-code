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
local npcsFolder = workspace:FindFirstChild(_d({52,54,41,89},26))
if not npcsFolder then
print(_d({65,52,54,41,6,43,94,86,85,88,90,75,88,67,6,13,52,54,41,89,13,6,76,85,82,74,75,88,6,84,85,90,6,76,85,91,84,74,6,79,84,6,93,85,88,81,89,86,71,73,75,7},26))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({51,85,74,75,82},26)) and npc.Name ~= "" then
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
error(_d({41,82,79,86,72,85,71,88,74,6,76,91,84,73,90,79,85,84,6,84,85,90,6,89,91,86,86,85,88,90,75,74,6,72,95,6,90,78,79,89,6,75,94,75,73,91,90,85,88,20},26))
end
end)
if success then
print(_d({65,52,54,41,6,43,94,86,85,88,90,75,88,67,6,57,91,73,73,75,89,89,76,91,82,82,95,6,73,85,86,79,75,74,6},26) .. #npcList .. _d({6,91,84,79,87,91,75,6,52,54,41,6,84,71,83,75,89,6,90,85,6,95,85,91,88,6,73,82,79,86,72,85,71,88,74,7},26))
print("NPCs found:\n" .. outputText)
else
warn(_d({65,52,54,41,6,43,94,86,85,88,90,75,88,67,6,44,71,79,82,75,74,6,90,85,6,73,85,86,95,6,90,85,6,73,82,79,86,72,85,71,88,74,32,6},26) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()