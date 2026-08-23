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
local npcsFolder = workspace:FindFirstChild(_d({57,59,46,94},21))
if not npcsFolder then
print(_d({70,57,59,46,11,48,99,91,90,93,95,80,93,72,11,18,57,59,46,94,18,11,81,90,87,79,80,93,11,89,90,95,11,81,90,96,89,79,11,84,89,11,98,90,93,86,94,91,76,78,80,12},21))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({56,90,79,80,87},21)) and npc.Name ~= "" then
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
error(_d({46,87,84,91,77,90,76,93,79,11,81,96,89,78,95,84,90,89,11,89,90,95,11,94,96,91,91,90,93,95,80,79,11,77,100,11,95,83,84,94,11,80,99,80,78,96,95,90,93,25},21))
end
end)
if success then
print(_d({70,57,59,46,11,48,99,91,90,93,95,80,93,72,11,62,96,78,78,80,94,94,81,96,87,87,100,11,78,90,91,84,80,79,11},21) .. #npcList .. _d({11,96,89,84,92,96,80,11,57,59,46,11,89,76,88,80,94,11,95,90,11,100,90,96,93,11,78,87,84,91,77,90,76,93,79,12},21))
print("NPCs found:\n" .. outputText)
else
warn(_d({70,57,59,46,11,48,99,91,90,93,95,80,93,72,11,49,76,84,87,80,79,11,95,90,11,78,90,91,100,11,95,90,11,78,87,84,91,77,90,76,93,79,37,11},21) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()