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
local npcsFolder = workspace:FindFirstChild(_d({24,26,13,61},54))
if not npcsFolder then
print(_d({37,24,26,13,234,15,66,58,57,60,62,47,60,39,234,241,24,26,13,61,241,234,48,57,54,46,47,60,234,56,57,62,234,48,57,63,56,46,234,51,56,234,65,57,60,53,61,58,43,45,47,235},54))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({23,57,46,47,54},54)) and npc.Name ~= "" then
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
error(_d({13,54,51,58,44,57,43,60,46,234,48,63,56,45,62,51,57,56,234,56,57,62,234,61,63,58,58,57,60,62,47,46,234,44,67,234,62,50,51,61,234,47,66,47,45,63,62,57,60,248},54))
end
end)
if success then
print(_d({37,24,26,13,234,15,66,58,57,60,62,47,60,39,234,29,63,45,45,47,61,61,48,63,54,54,67,234,45,57,58,51,47,46,234},54) .. #npcList .. _d({234,63,56,51,59,63,47,234,24,26,13,234,56,43,55,47,61,234,62,57,234,67,57,63,60,234,45,54,51,58,44,57,43,60,46,235},54))
print("NPCs found:\n" .. outputText)
else
warn(_d({37,24,26,13,234,15,66,58,57,60,62,47,60,39,234,16,43,51,54,47,46,234,62,57,234,45,57,58,67,234,62,57,234,45,54,51,58,44,57,43,60,46,4,234},54) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()