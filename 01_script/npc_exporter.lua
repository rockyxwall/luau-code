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
local npcsFolder = workspace:FindFirstChild(_d({31,33,20,68},47))
if not npcsFolder then
print(_d({44,31,33,20,241,22,73,65,64,67,69,54,67,46,241,248,31,33,20,68,248,241,55,64,61,53,54,67,241,63,64,69,241,55,64,70,63,53,241,58,63,241,72,64,67,60,68,65,50,52,54,242},47))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({30,64,53,54,61},47)) and npc.Name ~= "" then
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
error(_d({20,61,58,65,51,64,50,67,53,241,55,70,63,52,69,58,64,63,241,63,64,69,241,68,70,65,65,64,67,69,54,53,241,51,74,241,69,57,58,68,241,54,73,54,52,70,69,64,67,255},47))
end
end)
if success then
print(_d({44,31,33,20,241,22,73,65,64,67,69,54,67,46,241,36,70,52,52,54,68,68,55,70,61,61,74,241,52,64,65,58,54,53,241},47) .. #npcList .. _d({241,70,63,58,66,70,54,241,31,33,20,241,63,50,62,54,68,241,69,64,241,74,64,70,67,241,52,61,58,65,51,64,50,67,53,242},47))
print("NPCs found:\n" .. outputText)
else
warn(_d({44,31,33,20,241,22,73,65,64,67,69,54,67,46,241,23,50,58,61,54,53,241,69,64,241,52,64,65,74,241,69,64,241,52,61,58,65,51,64,50,67,53,11,241},47) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()