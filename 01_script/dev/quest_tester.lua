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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
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
Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,85,89,73,87,88,67,76,69,82,72,80,73,86,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,85,89,73,87,88,67,76,69,82,72,80,73,86,18,80,89,69},28))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({57,84,84,73,86,56,83,86,87,83},28))
local prompt = torso and torso:FindFirstChild(_d({52,86,83,81,84,88},28))
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
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,45,82,90,83,79,77,82,75,4,87,76,69,86,73,72,4,53,89,73,87,88,44,69,82,72,80,73,86,4,74,83,86,4,50,52,39,30,4},28) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,42,77,82,77,87,76,73,72,4,87,73,85,89,73,82,71,73,18,4,54,73,87,89,80,88,30,4},28) .. tostring(success))
else
warn(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,41,54,54,51,54,30,4,53,89,73,87,88,44,69,82,72,80,73,86,4,80,77,70,86,69,86,93,4,71,83,89,80,72,4,82,83,88,4,70,73,4,80,83,69,72,73,72,5},28))
end
else
print(_d({63,53,89,73,87,88,4,56,73,87,88,73,86,65,4,50,83,4,85,89,73,87,88,4,50,52,39,4,74,83,89,82,72,4,91,77,88,76,77,82,4,21,22,4,87,88,89,72,87,18},28))
end
end)()