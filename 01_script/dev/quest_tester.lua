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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
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
Core.Import(_d({6,7,3,61,70,69,5,66,63,56,5,71,75,59,73,74,53,62,55,68,58,66,59,72,4,66,75,55},42), _d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,71,75,59,73,74,53,62,55,68,58,66,59,72,4,66,75,55},42))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({43,70,70,59,72,42,69,72,73,69},42))
local prompt = torso and torso:FindFirstChild(_d({38,72,69,67,70,74},42))
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
print(_d({49,39,75,59,73,74,246,42,59,73,74,59,72,51,246,31,68,76,69,65,63,68,61,246,73,62,55,72,59,58,246,39,75,59,73,74,30,55,68,58,66,59,72,246,60,69,72,246,36,38,25,16,246},42) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({49,39,75,59,73,74,246,42,59,73,74,59,72,51,246,28,63,68,63,73,62,59,58,246,73,59,71,75,59,68,57,59,4,246,40,59,73,75,66,74,16,246},42) .. tostring(success))
else
warn(_d({49,39,75,59,73,74,246,42,59,73,74,59,72,51,246,27,40,40,37,40,16,246,39,75,59,73,74,30,55,68,58,66,59,72,246,66,63,56,72,55,72,79,246,57,69,75,66,58,246,68,69,74,246,56,59,246,66,69,55,58,59,58,247},42))
end
else
print(_d({49,39,75,59,73,74,246,42,59,73,74,59,72,51,246,36,69,246,71,75,59,73,74,246,36,38,25,246,60,69,75,68,58,246,77,63,74,62,63,68,246,7,8,246,73,74,75,58,73,4},42))
end
end)()