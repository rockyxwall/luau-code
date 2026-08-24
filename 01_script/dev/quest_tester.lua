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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
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
Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,94,98,82,96,97,76,85,78,91,81,89,82,95,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,94,98,82,96,97,76,85,78,91,81,89,82,95,27,89,98,78},19))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({66,93,93,82,95,65,92,95,96,92},19))
local prompt = torso and torso:FindFirstChild(_d({61,95,92,90,93,97},19))
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
print(_d({72,62,98,82,96,97,13,65,82,96,97,82,95,74,13,54,91,99,92,88,86,91,84,13,96,85,78,95,82,81,13,62,98,82,96,97,53,78,91,81,89,82,95,13,83,92,95,13,59,61,48,39,13},19) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({72,62,98,82,96,97,13,65,82,96,97,82,95,74,13,51,86,91,86,96,85,82,81,13,96,82,94,98,82,91,80,82,27,13,63,82,96,98,89,97,39,13},19) .. tostring(success))
else
warn(_d({72,62,98,82,96,97,13,65,82,96,97,82,95,74,13,50,63,63,60,63,39,13,62,98,82,96,97,53,78,91,81,89,82,95,13,89,86,79,95,78,95,102,13,80,92,98,89,81,13,91,92,97,13,79,82,13,89,92,78,81,82,81,14},19))
end
else
print(_d({72,62,98,82,96,97,13,65,82,96,97,82,95,74,13,59,92,13,94,98,82,96,97,13,59,61,48,13,83,92,98,91,81,13,100,86,97,85,86,91,13,30,31,13,96,97,98,81,96,27},19))
end
end)()