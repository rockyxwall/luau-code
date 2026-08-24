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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function Core.Import(localPath, rawUrl)
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
Core.Import(_d({241,242,238,40,49,48,240,45,42,35,240,50,54,38,52,53,32,41,34,47,37,45,38,51,239,45,54,34},63), _d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,45,54,34,54,238,36,48,37,38,240,46,34,42,47,240,241,242,32,52,36,51,42,49,53,240,45,42,35,240,50,54,38,52,53,32,41,34,47,37,45,38,51,239,45,54,34},63))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({22,49,49,38,51,21,48,51,52,48},63))
local prompt = torso and torso:FindFirstChild(_d({17,51,48,46,49,53},63))
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
print(_d({28,18,54,38,52,53,225,21,38,52,53,38,51,30,225,10,47,55,48,44,42,47,40,225,52,41,34,51,38,37,225,18,54,38,52,53,9,34,47,37,45,38,51,225,39,48,51,225,15,17,4,251,225},63) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({28,18,54,38,52,53,225,21,38,52,53,38,51,30,225,7,42,47,42,52,41,38,37,225,52,38,50,54,38,47,36,38,239,225,19,38,52,54,45,53,251,225},63) .. tostring(success))
else
warn(_d({28,18,54,38,52,53,225,21,38,52,53,38,51,30,225,6,19,19,16,19,251,225,18,54,38,52,53,9,34,47,37,45,38,51,225,45,42,35,51,34,51,58,225,36,48,54,45,37,225,47,48,53,225,35,38,225,45,48,34,37,38,37,226},63))
end
else
print(_d({28,18,54,38,52,53,225,21,38,52,53,38,51,30,225,15,48,225,50,54,38,52,53,225,15,17,4,225,39,48,54,47,37,225,56,42,53,41,42,47,225,242,243,225,52,53,54,37,52,239},63))
end
end)()