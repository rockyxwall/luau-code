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
local npcsFolder = workspace:FindFirstChild(_d({55,57,44,92},23))
if not npcsFolder then
print(_d({68,55,57,44,9,46,97,89,88,91,93,78,91,70,9,16,55,57,44,92,16,9,79,88,85,77,78,91,9,87,88,93,9,79,88,94,87,77,9,82,87,9,96,88,91,84,92,89,74,76,78,10},23))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({54,88,77,78,85},23)) and npc.Name ~= "" then
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
error(_d({44,85,82,89,75,88,74,91,77,9,79,94,87,76,93,82,88,87,9,87,88,93,9,92,94,89,89,88,91,93,78,77,9,75,98,9,93,81,82,92,9,78,97,78,76,94,93,88,91,23},23))
end
end)
if success then
print(_d({68,55,57,44,9,46,97,89,88,91,93,78,91,70,9,60,94,76,76,78,92,92,79,94,85,85,98,9,76,88,89,82,78,77,9},23) .. #npcList .. _d({9,94,87,82,90,94,78,9,55,57,44,9,87,74,86,78,92,9,93,88,9,98,88,94,91,9,76,85,82,89,75,88,74,91,77,10},23))
print("NPCs found:\n" .. outputText)
else
warn(_d({68,55,57,44,9,46,97,89,88,91,93,78,91,70,9,47,74,82,85,78,77,9,93,88,9,76,88,89,98,9,93,88,9,76,85,82,89,75,88,74,91,77,35,9},23) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()