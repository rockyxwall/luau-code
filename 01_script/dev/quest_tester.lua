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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
if not _G.QuestHandler then
importLib(_d({69,66,59,8,74,78,62,76,77,56,65,58,71,61,69,62,75,7,69,78,58},39), _d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,74,78,62,76,77,56,65,58,71,61,69,62,75,7,69,78,58},39))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({46,73,73,62,75,45,72,75,76,72},39))
local prompt = torso and torso:FindFirstChild(_d({41,75,72,70,73,77},39))
if prompt then
local dist = (torso.Position - myRoot.Position).Magnitude
if dist < minDist then
minDist = dist
nearest = npc
end
end
end
return nearest
end
local npc = getNearestNPC()
if npc then
if _G.QuestHandler then
print(_d({52,42,78,62,76,77,249,45,62,76,77,62,75,54,249,34,71,79,72,68,66,71,64,249,76,65,58,75,62,61,249,42,78,62,76,77,33,58,71,61,69,62,75,249,63,72,75,249,39,41,28,19,249},39) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({52,42,78,62,76,77,249,45,62,76,77,62,75,54,249,31,66,71,66,76,65,62,61,249,76,62,74,78,62,71,60,62,7,249,43,62,76,78,69,77,19,249},39) .. tostring(success))
else
warn(_d({52,42,78,62,76,77,249,45,62,76,77,62,75,54,249,30,43,43,40,43,19,249,42,78,62,76,77,33,58,71,61,69,62,75,249,69,66,59,75,58,75,82,249,60,72,78,69,61,249,71,72,77,249,59,62,249,69,72,58,61,62,61,250},39))
end
else
print(_d({52,42,78,62,76,77,249,45,62,76,77,62,75,54,249,39,72,249,74,78,62,76,77,249,39,41,28,249,63,72,78,71,61,249,80,66,77,65,66,71,249,10,11,249,76,77,78,61,76,7},39))
end
end)()