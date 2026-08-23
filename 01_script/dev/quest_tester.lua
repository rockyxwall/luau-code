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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
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
importLib(_d({82,79,72,21,87,91,75,89,90,69,78,71,84,74,82,75,88,20,82,91,71},26), _d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,87,91,75,89,90,69,78,71,84,74,82,75,88,20,82,91,71},26))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({59,86,86,75,88,58,85,88,89,85},26))
local prompt = torso and torso:FindFirstChild(_d({54,88,85,83,86,90},26))
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
print(_d({65,55,91,75,89,90,6,58,75,89,90,75,88,67,6,47,84,92,85,81,79,84,77,6,89,78,71,88,75,74,6,55,91,75,89,90,46,71,84,74,82,75,88,6,76,85,88,6,52,54,41,32,6},26) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({65,55,91,75,89,90,6,58,75,89,90,75,88,67,6,44,79,84,79,89,78,75,74,6,89,75,87,91,75,84,73,75,20,6,56,75,89,91,82,90,32,6},26) .. tostring(success))
else
warn(_d({65,55,91,75,89,90,6,58,75,89,90,75,88,67,6,43,56,56,53,56,32,6,55,91,75,89,90,46,71,84,74,82,75,88,6,82,79,72,88,71,88,95,6,73,85,91,82,74,6,84,85,90,6,72,75,6,82,85,71,74,75,74,7},26))
end
else
print(_d({65,55,91,75,89,90,6,58,75,89,90,75,88,67,6,52,85,6,87,91,75,89,90,6,52,54,41,6,76,85,91,84,74,6,93,79,90,78,79,84,6,23,24,6,89,90,91,74,89,20},26))
end
end)()