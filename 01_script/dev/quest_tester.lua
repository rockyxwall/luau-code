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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
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
Core.Import(_d({33,34,30,88,97,96,32,93,90,83,32,98,102,86,100,101,80,89,82,95,85,93,86,99,31,93,102,82},15), _d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,93,102,82,102,30,84,96,85,86,32,94,82,90,95,32,33,34,80,100,84,99,90,97,101,32,93,90,83,32,98,102,86,100,101,80,89,82,95,85,93,86,99,31,93,102,82},15))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({70,97,97,86,99,69,96,99,100,96},15))
local prompt = torso and torso:FindFirstChild(_d({65,99,96,94,97,101},15))
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
print(_d({76,66,102,86,100,101,17,69,86,100,101,86,99,78,17,58,95,103,96,92,90,95,88,17,100,89,82,99,86,85,17,66,102,86,100,101,57,82,95,85,93,86,99,17,87,96,99,17,63,65,52,43,17},15) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({76,66,102,86,100,101,17,69,86,100,101,86,99,78,17,55,90,95,90,100,89,86,85,17,100,86,98,102,86,95,84,86,31,17,67,86,100,102,93,101,43,17},15) .. tostring(success))
else
warn(_d({76,66,102,86,100,101,17,69,86,100,101,86,99,78,17,54,67,67,64,67,43,17,66,102,86,100,101,57,82,95,85,93,86,99,17,93,90,83,99,82,99,106,17,84,96,102,93,85,17,95,96,101,17,83,86,17,93,96,82,85,86,85,18},15))
end
else
print(_d({76,66,102,86,100,101,17,69,86,100,101,86,99,78,17,63,96,17,98,102,86,100,101,17,63,65,52,17,87,96,102,95,85,17,104,90,101,89,90,95,17,34,35,17,100,101,102,85,100,31},15))
end
end)()