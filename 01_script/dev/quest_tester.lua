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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
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
Core.Import(_d({7,8,4,62,71,70,6,67,64,57,6,72,76,60,74,75,54,63,56,69,59,67,60,73,5,67,76,56},41), _d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,67,64,57,6,72,76,60,74,75,54,63,56,69,59,67,60,73,5,67,76,56},41))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
local prompt = torso and torso:FindFirstChild(_d({39,73,70,68,71,75},41))
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
print(_d({50,40,76,60,74,75,247,43,60,74,75,60,73,52,247,32,69,77,70,66,64,69,62,247,74,63,56,73,60,59,247,40,76,60,74,75,31,56,69,59,67,60,73,247,61,70,73,247,37,39,26,17,247},41) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({50,40,76,60,74,75,247,43,60,74,75,60,73,52,247,29,64,69,64,74,63,60,59,247,74,60,72,76,60,69,58,60,5,247,41,60,74,76,67,75,17,247},41) .. tostring(success))
else
warn(_d({50,40,76,60,74,75,247,43,60,74,75,60,73,52,247,28,41,41,38,41,17,247,40,76,60,74,75,31,56,69,59,67,60,73,247,67,64,57,73,56,73,80,247,58,70,76,67,59,247,69,70,75,247,57,60,247,67,70,56,59,60,59,248},41))
end
else
print(_d({50,40,76,60,74,75,247,43,60,74,75,60,73,52,247,37,70,247,72,76,60,74,75,247,37,39,26,247,61,70,76,69,59,247,78,64,75,63,64,69,247,8,9,247,74,75,76,59,74,5},41))
end
end)()