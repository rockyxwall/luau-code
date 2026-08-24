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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
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
Core.Import(_d({27,28,24,82,91,90,26,87,84,77,26,92,96,80,94,95,74,83,76,89,79,87,80,93,25,87,96,76},21), _d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,92,96,80,94,95,74,83,76,89,79,87,80,93,25,87,96,76},21))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({57,59,46,94},21))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({64,91,91,80,93,63,90,93,94,90},21))
local prompt = torso and torso:FindFirstChild(_d({59,93,90,88,91,95},21))
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
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,52,89,97,90,86,84,89,82,11,94,83,76,93,80,79,11,60,96,80,94,95,51,76,89,79,87,80,93,11,81,90,93,11,57,59,46,37,11},21) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,49,84,89,84,94,83,80,79,11,94,80,92,96,80,89,78,80,25,11,61,80,94,96,87,95,37,11},21) .. tostring(success))
else
warn(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,48,61,61,58,61,37,11,60,96,80,94,95,51,76,89,79,87,80,93,11,87,84,77,93,76,93,100,11,78,90,96,87,79,11,89,90,95,11,77,80,11,87,90,76,79,80,79,12},21))
end
else
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,57,90,11,92,96,80,94,95,11,57,59,46,11,81,90,96,89,79,11,98,84,95,83,84,89,11,28,29,11,94,95,96,79,94,25},21))
end
end)()