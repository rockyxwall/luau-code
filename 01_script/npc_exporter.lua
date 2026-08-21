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
local npcsFolder = workspace:FindFirstChild(_d({39,41,28,76},39))
if not npcsFolder then
print(_d({52,39,41,28,249,30,81,73,72,75,77,62,75,54,249,0,39,41,28,76,0,249,63,72,69,61,62,75,249,71,72,77,249,63,72,78,71,61,249,66,71,249,80,72,75,68,76,73,58,60,62,250},39))
return
end
local uniqueNPCs = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc:IsA(_d({38,72,61,62,69},39)) and npc.Name ~= "" then
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
error(_d({28,69,66,73,59,72,58,75,61,249,63,78,71,60,77,66,72,71,249,71,72,77,249,76,78,73,73,72,75,77,62,61,249,59,82,249,77,65,66,76,249,62,81,62,60,78,77,72,75,7},39))
end
end)
if success then
print(_d({52,39,41,28,249,30,81,73,72,75,77,62,75,54,249,44,78,60,60,62,76,76,63,78,69,69,82,249,60,72,73,66,62,61,249},39) .. #npcList .. _d({249,78,71,66,74,78,62,249,39,41,28,249,71,58,70,62,76,249,77,72,249,82,72,78,75,249,60,69,66,73,59,72,58,75,61,250},39))
print("NPCs found:\n" .. outputText)
else
warn(_d({52,39,41,28,249,30,81,73,72,75,77,62,75,54,249,31,58,66,69,62,61,249,77,72,249,60,72,73,82,249,77,72,249,60,69,66,73,59,72,58,75,61,19,249},39) .. tostring(err))
print("NPCs found (Manually copy from console):\n" .. outputText)
end
end)()