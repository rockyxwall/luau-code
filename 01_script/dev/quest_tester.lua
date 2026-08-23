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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
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
importLib(_d({78,75,68,17,83,87,71,85,86,65,74,67,80,70,78,71,84,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,83,87,71,85,86,65,74,67,80,70,78,71,84,16,78,87,67},30))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({48,50,37,85},30))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({55,82,82,71,84,54,81,84,85,81},30))
local prompt = torso and torso:FindFirstChild(_d({50,84,81,79,82,86},30))
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
print(_d({61,51,87,71,85,86,2,54,71,85,86,71,84,63,2,43,80,88,81,77,75,80,73,2,85,74,67,84,71,70,2,51,87,71,85,86,42,67,80,70,78,71,84,2,72,81,84,2,48,50,37,28,2},30) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({61,51,87,71,85,86,2,54,71,85,86,71,84,63,2,40,75,80,75,85,74,71,70,2,85,71,83,87,71,80,69,71,16,2,52,71,85,87,78,86,28,2},30) .. tostring(success))
else
warn(_d({61,51,87,71,85,86,2,54,71,85,86,71,84,63,2,39,52,52,49,52,28,2,51,87,71,85,86,42,67,80,70,78,71,84,2,78,75,68,84,67,84,91,2,69,81,87,78,70,2,80,81,86,2,68,71,2,78,81,67,70,71,70,3},30))
end
else
print(_d({61,51,87,71,85,86,2,54,71,85,86,71,84,63,2,48,81,2,83,87,71,85,86,2,48,50,37,2,72,81,87,80,70,2,89,75,86,74,75,80,2,19,20,2,85,86,87,70,85,16},30))
end
end)()