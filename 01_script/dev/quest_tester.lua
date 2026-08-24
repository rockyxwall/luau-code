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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
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
Core.Import(_d({23,24,20,78,87,86,22,83,80,73,22,88,92,76,90,91,70,79,72,85,75,83,76,89,21,83,92,72},25), _d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,88,92,76,90,91,70,79,72,85,75,83,76,89,21,83,92,72},25))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({60,87,87,76,89,59,86,89,90,86},25))
local prompt = torso and torso:FindFirstChild(_d({55,89,86,84,87,91},25))
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
print(_d({66,56,92,76,90,91,7,59,76,90,91,76,89,68,7,48,85,93,86,82,80,85,78,7,90,79,72,89,76,75,7,56,92,76,90,91,47,72,85,75,83,76,89,7,77,86,89,7,53,55,42,33,7},25) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({66,56,92,76,90,91,7,59,76,90,91,76,89,68,7,45,80,85,80,90,79,76,75,7,90,76,88,92,76,85,74,76,21,7,57,76,90,92,83,91,33,7},25) .. tostring(success))
else
warn(_d({66,56,92,76,90,91,7,59,76,90,91,76,89,68,7,44,57,57,54,57,33,7,56,92,76,90,91,47,72,85,75,83,76,89,7,83,80,73,89,72,89,96,7,74,86,92,83,75,7,85,86,91,7,73,76,7,83,86,72,75,76,75,8},25))
end
else
print(_d({66,56,92,76,90,91,7,59,76,90,91,76,89,68,7,53,86,7,88,92,76,90,91,7,53,55,42,7,77,86,92,85,75,7,94,80,91,79,80,85,7,24,25,7,90,91,92,75,90,21},25))
end
end)()