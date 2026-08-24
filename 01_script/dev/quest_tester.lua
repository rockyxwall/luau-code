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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
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
Core.Import(_d({13,14,10,68,77,76,12,73,70,63,12,78,82,66,80,81,60,69,62,75,65,73,66,79,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,78,82,66,80,81,60,69,62,75,65,73,66,79,11,73,82,62},35))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({50,77,77,66,79,49,76,79,80,76},35))
local prompt = torso and torso:FindFirstChild(_d({45,79,76,74,77,81},35))
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
print(_d({56,46,82,66,80,81,253,49,66,80,81,66,79,58,253,38,75,83,76,72,70,75,68,253,80,69,62,79,66,65,253,46,82,66,80,81,37,62,75,65,73,66,79,253,67,76,79,253,43,45,32,23,253},35) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({56,46,82,66,80,81,253,49,66,80,81,66,79,58,253,35,70,75,70,80,69,66,65,253,80,66,78,82,66,75,64,66,11,253,47,66,80,82,73,81,23,253},35) .. tostring(success))
else
warn(_d({56,46,82,66,80,81,253,49,66,80,81,66,79,58,253,34,47,47,44,47,23,253,46,82,66,80,81,37,62,75,65,73,66,79,253,73,70,63,79,62,79,86,253,64,76,82,73,65,253,75,76,81,253,63,66,253,73,76,62,65,66,65,254},35))
end
else
print(_d({56,46,82,66,80,81,253,49,66,80,81,66,79,58,253,43,76,253,78,82,66,80,81,253,43,45,32,253,67,76,82,75,65,253,84,70,81,69,70,75,253,14,15,253,80,81,82,65,80,11},35))
end
end)()