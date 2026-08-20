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
local npcsFolder = workspace:FindFirstChild(_d({25,27,14,62},53))
if not npcsFolder then
print(_d({38,25,27,14,235,16,67,59,58,61,63,48,61,40,235,242,25,27,14,62,242,235,49,58,55,47,48,61,235,57,58,63,235,49,58,64,57,47,235,52,57,235,66,58,61,54,62,59,44,46,48,236},53))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({24,58,47,48,55},53)) and npc.Name ~= "" then
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
error(_d({14,55,52,59,45,58,44,61,47,235,49,64,57,46,63,52,58,57,235,57,58,63,235,62,64,59,59,58,61,63,48,47,235,45,68,235,63,51,52,62,235,48,67,48,46,64,63,58,61,249},53))
end
end)
if success then
print(_d({38,25,27,14,235,16,67,59,58,61,63,48,61,40,235,30,64,46,46,48,62,62,49,64,55,55,68,235,46,58,59,52,48,47,235},53) .. #npcList .. _d({235,64,57,52,60,64,48,235,25,27,14,235,57,44,56,48,62,235,63,58,235,68,58,64,61,235,46,55,52,59,45,58,44,61,47,236},53))
print("NPCs found:\n" .. outputText)
else
warn(_d({38,25,27,14,235,16,67,59,58,61,63,48,61,40,235,17,44,52,55,48,47,235,63,58,235,46,58,59,68,235,63,58,235,46,55,52,59,45,58,44,61,47,5,235},53) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()