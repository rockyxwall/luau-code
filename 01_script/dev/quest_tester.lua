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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
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
importLib(_d({74,71,64,13,79,83,67,81,82,61,70,63,76,66,74,67,80,12,74,83,63},34), _d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,79,83,67,81,82,61,70,63,76,66,74,67,80,12,74,83,63},34))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({44,46,33,81},34))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({51,78,78,67,80,50,77,80,81,77},34))
local prompt = torso and torso:FindFirstChild(_d({46,80,77,75,78,82},34))
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
print(_d({57,47,83,67,81,82,254,50,67,81,82,67,80,59,254,39,76,84,77,73,71,76,69,254,81,70,63,80,67,66,254,47,83,67,81,82,38,63,76,66,74,67,80,254,68,77,80,254,44,46,33,24,254},34) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({57,47,83,67,81,82,254,50,67,81,82,67,80,59,254,36,71,76,71,81,70,67,66,254,81,67,79,83,67,76,65,67,12,254,48,67,81,83,74,82,24,254},34) .. tostring(success))
else
warn(_d({57,47,83,67,81,82,254,50,67,81,82,67,80,59,254,35,48,48,45,48,24,254,47,83,67,81,82,38,63,76,66,74,67,80,254,74,71,64,80,63,80,87,254,65,77,83,74,66,254,76,77,82,254,64,67,254,74,77,63,66,67,66,255},34))
end
else
print(_d({57,47,83,67,81,82,254,50,67,81,82,67,80,59,254,44,77,254,79,83,67,81,82,254,44,46,33,254,68,77,83,76,66,254,85,71,82,70,71,76,254,15,16,254,81,82,83,66,81,12},34))
end
end)()