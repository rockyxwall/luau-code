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
local npcsFolder = workspace:FindFirstChild(_d({51,53,40,88},27))
if not npcsFolder then
print(_d({64,51,53,40,5,42,93,85,84,87,89,74,87,66,5,12,51,53,40,88,12,5,75,84,81,73,74,87,5,83,84,89,5,75,84,90,83,73,5,78,83,5,92,84,87,80,88,85,70,72,74,6},27))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({50,84,73,74,81},27)) and npc.Name ~= "" then
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
error(_d({40,81,78,85,71,84,70,87,73,5,75,90,83,72,89,78,84,83,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,89,77,78,88,5,74,93,74,72,90,89,84,87,19},27))
end
end)
if success then
print(_d({64,51,53,40,5,42,93,85,84,87,89,74,87,66,5,56,90,72,72,74,88,88,75,90,81,81,94,5,72,84,85,78,74,73,5},27) .. #npcList .. _d({5,90,83,78,86,90,74,5,51,53,40,5,83,70,82,74,88,5,89,84,5,94,84,90,87,5,72,81,78,85,71,84,70,87,73,6},27))
print("NPCs found:\n" .. outputText)
else
warn(_d({64,51,53,40,5,42,93,85,84,87,89,74,87,66,5,43,70,78,81,74,73,5,89,84,5,72,84,85,94,5,89,84,5,72,81,78,85,71,84,70,87,73,31,5},27) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()