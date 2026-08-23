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
local npcsFolder = workspace:FindFirstChild(_d({21,23,10,58},57))
if not npcsFolder then
print(_d({34,21,23,10,231,12,63,55,54,57,59,44,57,36,231,238,21,23,10,58,238,231,45,54,51,43,44,57,231,53,54,59,231,45,54,60,53,43,231,48,53,231,62,54,57,50,58,55,40,42,44,232},57))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({20,54,43,44,51},57)) and npc.Name ~= "" then
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
error(_d({10,51,48,55,41,54,40,57,43,231,45,60,53,42,59,48,54,53,231,53,54,59,231,58,60,55,55,54,57,59,44,43,231,41,64,231,59,47,48,58,231,44,63,44,42,60,59,54,57,245},57))
end
end)
if success then
print(_d({34,21,23,10,231,12,63,55,54,57,59,44,57,36,231,26,60,42,42,44,58,58,45,60,51,51,64,231,42,54,55,48,44,43,231},57) .. #npcList .. _d({231,60,53,48,56,60,44,231,21,23,10,231,53,40,52,44,58,231,59,54,231,64,54,60,57,231,42,51,48,55,41,54,40,57,43,232},57))
print("NPCs found:\n" .. outputText)
else
warn(_d({34,21,23,10,231,12,63,55,54,57,59,44,57,36,231,13,40,48,51,44,43,231,59,54,231,42,54,55,64,231,59,54,231,42,51,48,55,41,54,40,57,43,1,231},57) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()