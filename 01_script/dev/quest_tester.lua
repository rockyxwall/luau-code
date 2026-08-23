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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
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
importLib(_d({54,51,44,249,59,63,47,61,62,41,50,43,56,46,54,47,60,248,54,63,43},54), _d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,54,63,43,63,247,45,57,46,47,249,55,43,51,56,249,250,251,41,61,45,60,51,58,62,249,54,51,44,249,59,63,47,61,62,41,50,43,56,46,54,47,60,248,54,63,43},54))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({31,58,58,47,60,30,57,60,61,57},54))
local prompt = torso and torso:FindFirstChild(_d({26,60,57,55,58,62},54))
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
print(_d({37,27,63,47,61,62,234,30,47,61,62,47,60,39,234,19,56,64,57,53,51,56,49,234,61,50,43,60,47,46,234,27,63,47,61,62,18,43,56,46,54,47,60,234,48,57,60,234,24,26,13,4,234},54) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({37,27,63,47,61,62,234,30,47,61,62,47,60,39,234,16,51,56,51,61,50,47,46,234,61,47,59,63,47,56,45,47,248,234,28,47,61,63,54,62,4,234},54) .. tostring(success))
else
warn(_d({37,27,63,47,61,62,234,30,47,61,62,47,60,39,234,15,28,28,25,28,4,234,27,63,47,61,62,18,43,56,46,54,47,60,234,54,51,44,60,43,60,67,234,45,57,63,54,46,234,56,57,62,234,44,47,234,54,57,43,46,47,46,235},54))
end
else
print(_d({37,27,63,47,61,62,234,30,47,61,62,47,60,39,234,24,57,234,59,63,47,61,62,234,24,26,13,234,48,57,63,56,46,234,65,51,62,50,51,56,234,251,252,234,61,62,63,46,61,248},54))
end
end)()