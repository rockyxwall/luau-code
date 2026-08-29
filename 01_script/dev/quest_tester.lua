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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
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
Core.Import(_d({10,11,7,65,74,73,9,70,67,60,9,75,79,63,77,78,57,66,59,72,62,70,63,76,8,70,79,59},38), _d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,70,79,59,79,7,61,73,62,63,9,71,59,67,72,9,10,11,57,77,61,76,67,74,78,9,70,67,60,9,75,79,63,77,78,57,66,59,72,62,70,63,76,8,70,79,59},38))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({47,74,74,63,76,46,73,76,77,73},38))
local prompt = torso and torso:FindFirstChild(_d({42,76,73,71,74,78},38))
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
print(_d({53,43,79,63,77,78,250,46,63,77,78,63,76,55,250,35,72,80,73,69,67,72,65,250,77,66,59,76,63,62,250,43,79,63,77,78,34,59,72,62,70,63,76,250,64,73,76,250,40,42,29,20,250},38) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({53,43,79,63,77,78,250,46,63,77,78,63,76,55,250,32,67,72,67,77,66,63,62,250,77,63,75,79,63,72,61,63,8,250,44,63,77,79,70,78,20,250},38) .. tostring(success))
else
warn(_d({53,43,79,63,77,78,250,46,63,77,78,63,76,55,250,31,44,44,41,44,20,250,43,79,63,77,78,34,59,72,62,70,63,76,250,70,67,60,76,59,76,83,250,61,73,79,70,62,250,72,73,78,250,60,63,250,70,73,59,62,63,62,251},38))
end
else
print(_d({53,43,79,63,77,78,250,46,63,77,78,63,76,55,250,40,73,250,75,79,63,77,78,250,40,42,29,250,64,73,79,72,62,250,81,67,78,66,67,72,250,11,12,250,77,78,79,62,77,8},38))
end
end)()