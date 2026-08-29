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
local npcsFolder = workspace:FindFirstChild(_d({53,55,42,90},25))
if not npcsFolder then
print(_d({66,53,55,42,7,44,95,87,86,89,91,76,89,68,7,14,53,55,42,90,14,7,77,86,83,75,76,89,7,85,86,91,7,77,86,92,85,75,7,80,85,7,94,86,89,82,90,87,72,74,76,8},25))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({52,86,75,76,83},25)) and npc.Name ~= "" then
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
error(_d({42,83,80,87,73,86,72,89,75,7,77,92,85,74,91,80,86,85,7,85,86,91,7,90,92,87,87,86,89,91,76,75,7,73,96,7,91,79,80,90,7,76,95,76,74,92,91,86,89,21},25))
end
end)
if success then
print(_d({66,53,55,42,7,44,95,87,86,89,91,76,89,68,7,58,92,74,74,76,90,90,77,92,83,83,96,7,74,86,87,80,76,75,7},25) .. #npcList .. _d({7,92,85,80,88,92,76,7,53,55,42,7,85,72,84,76,90,7,91,86,7,96,86,92,89,7,74,83,80,87,73,86,72,89,75,8},25))
print("NPCs found:\n" .. outputText)
else
warn(_d({66,53,55,42,7,44,95,87,86,89,91,76,89,68,7,45,72,80,83,76,75,7,91,86,7,74,86,87,96,7,91,86,7,74,83,80,87,73,86,72,89,75,33,7},25) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()