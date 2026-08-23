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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
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
importLib(_d({63,60,53,2,68,72,56,70,71,50,59,52,65,55,63,56,69,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,68,72,56,70,71,50,59,52,65,55,63,56,69,1,63,72,52},45))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({33,35,22,70},45))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({40,67,67,56,69,39,66,69,70,66},45))
local prompt = torso and torso:FindFirstChild(_d({35,69,66,64,67,71},45))
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
print(_d({46,36,72,56,70,71,243,39,56,70,71,56,69,48,243,28,65,73,66,62,60,65,58,243,70,59,52,69,56,55,243,36,72,56,70,71,27,52,65,55,63,56,69,243,57,66,69,243,33,35,22,13,243},45) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({46,36,72,56,70,71,243,39,56,70,71,56,69,48,243,25,60,65,60,70,59,56,55,243,70,56,68,72,56,65,54,56,1,243,37,56,70,72,63,71,13,243},45) .. tostring(success))
else
warn(_d({46,36,72,56,70,71,243,39,56,70,71,56,69,48,243,24,37,37,34,37,13,243,36,72,56,70,71,27,52,65,55,63,56,69,243,63,60,53,69,52,69,76,243,54,66,72,63,55,243,65,66,71,243,53,56,243,63,66,52,55,56,55,244},45))
end
else
print(_d({46,36,72,56,70,71,243,39,56,70,71,56,69,48,243,33,66,243,68,72,56,70,71,243,33,35,22,243,57,66,72,65,55,243,74,60,71,59,60,65,243,4,5,243,70,71,72,55,70,1},45))
end
end)()