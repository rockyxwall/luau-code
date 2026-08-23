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
local npcsFolder = workspace:FindFirstChild(_d({32,34,21,69},46))
if not npcsFolder then
print(_d({45,32,34,21,242,23,74,66,65,68,70,55,68,47,242,249,32,34,21,69,249,242,56,65,62,54,55,68,242,64,65,70,242,56,65,71,64,54,242,59,64,242,73,65,68,61,69,66,51,53,55,243},46))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({31,65,54,55,62},46)) and npc.Name ~= "" then
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
error(_d({21,62,59,66,52,65,51,68,54,242,56,71,64,53,70,59,65,64,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,70,58,59,69,242,55,74,55,53,71,70,65,68,0},46))
end
end)
if success then
print(_d({45,32,34,21,242,23,74,66,65,68,70,55,68,47,242,37,71,53,53,55,69,69,56,71,62,62,75,242,53,65,66,59,55,54,242},46) .. #npcList .. _d({242,71,64,59,67,71,55,242,32,34,21,242,64,51,63,55,69,242,70,65,242,75,65,71,68,242,53,62,59,66,52,65,51,68,54,243},46))
print("NPCs found:\n" .. outputText)
else
warn(_d({45,32,34,21,242,23,74,66,65,68,70,55,68,47,242,24,51,59,62,55,54,242,70,65,242,53,65,66,75,242,70,65,242,53,62,59,66,52,65,51,68,54,12,242},46) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()