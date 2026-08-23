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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
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
importLib(_d({51,48,41,246,56,60,44,58,59,38,47,40,53,43,51,44,57,245,51,60,40},57), _d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,51,60,40,60,244,42,54,43,44,246,52,40,48,53,246,247,248,38,58,42,57,48,55,59,246,51,48,41,246,56,60,44,58,59,38,47,40,53,43,51,44,57,245,51,60,40},57))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({21,23,10,58},57))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({28,55,55,44,57,27,54,57,58,54},57))
local prompt = torso and torso:FindFirstChild(_d({23,57,54,52,55,59},57))
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
print(_d({34,24,60,44,58,59,231,27,44,58,59,44,57,36,231,16,53,61,54,50,48,53,46,231,58,47,40,57,44,43,231,24,60,44,58,59,15,40,53,43,51,44,57,231,45,54,57,231,21,23,10,1,231},57) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({34,24,60,44,58,59,231,27,44,58,59,44,57,36,231,13,48,53,48,58,47,44,43,231,58,44,56,60,44,53,42,44,245,231,25,44,58,60,51,59,1,231},57) .. tostring(success))
else
warn(_d({34,24,60,44,58,59,231,27,44,58,59,44,57,36,231,12,25,25,22,25,1,231,24,60,44,58,59,15,40,53,43,51,44,57,231,51,48,41,57,40,57,64,231,42,54,60,51,43,231,53,54,59,231,41,44,231,51,54,40,43,44,43,232},57))
end
else
print(_d({34,24,60,44,58,59,231,27,44,58,59,44,57,36,231,21,54,231,56,60,44,58,59,231,21,23,10,231,45,54,60,53,43,231,62,48,59,47,48,53,231,248,249,231,58,59,60,43,58,245},57))
end
end)()