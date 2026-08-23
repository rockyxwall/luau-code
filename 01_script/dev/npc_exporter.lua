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
local npcsFolder = workspace:FindFirstChild(_d({30,32,19,67},48))
if not npcsFolder then
print(_d({43,30,32,19,240,21,72,64,63,66,68,53,66,45,240,247,30,32,19,67,247,240,54,63,60,52,53,66,240,62,63,68,240,54,63,69,62,52,240,57,62,240,71,63,66,59,67,64,49,51,53,241},48))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({29,63,52,53,60},48)) and npc.Name ~= "" then
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
error(_d({19,60,57,64,50,63,49,66,52,240,54,69,62,51,68,57,63,62,240,62,63,68,240,67,69,64,64,63,66,68,53,52,240,50,73,240,68,56,57,67,240,53,72,53,51,69,68,63,66,254},48))
end
end)
if success then
print(_d({43,30,32,19,240,21,72,64,63,66,68,53,66,45,240,35,69,51,51,53,67,67,54,69,60,60,73,240,51,63,64,57,53,52,240},48) .. #npcList .. _d({240,69,62,57,65,69,53,240,30,32,19,240,62,49,61,53,67,240,68,63,240,73,63,69,66,240,51,60,57,64,50,63,49,66,52,241},48))
print("NPCs found:\n" .. outputText)
else
warn(_d({43,30,32,19,240,21,72,64,63,66,68,53,66,45,240,22,49,57,60,53,52,240,68,63,240,51,63,64,73,240,68,63,240,51,60,57,64,50,63,49,66,52,10,240},48) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()