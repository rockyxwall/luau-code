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
local npcsFolder = workspace:FindFirstChild(_d({62,64,51,99},16))
if not npcsFolder then
print(_d({75,62,64,51,16,53,104,96,95,98,100,85,98,77,16,23,62,64,51,99,23,16,86,95,92,84,85,98,16,94,95,100,16,86,95,101,94,84,16,89,94,16,103,95,98,91,99,96,81,83,85,17},16))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({61,95,84,85,92},16)) and npc.Name ~= "" then
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
error(_d({51,92,89,96,82,95,81,98,84,16,86,101,94,83,100,89,95,94,16,94,95,100,16,99,101,96,96,95,98,100,85,84,16,82,105,16,100,88,89,99,16,85,104,85,83,101,100,95,98,30},16))
end
end)
if success then
print(_d({75,62,64,51,16,53,104,96,95,98,100,85,98,77,16,67,101,83,83,85,99,99,86,101,92,92,105,16,83,95,96,89,85,84,16},16) .. #npcList .. _d({16,101,94,89,97,101,85,16,62,64,51,16,94,81,93,85,99,16,100,95,16,105,95,101,98,16,83,92,89,96,82,95,81,98,84,17},16))
print("NPCs found:\n" .. outputText)
else
warn(_d({75,62,64,51,16,53,104,96,95,98,100,85,98,77,16,54,81,89,92,85,84,16,100,95,16,83,95,96,105,16,100,95,16,83,92,89,96,82,95,81,98,84,42,16},16) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()