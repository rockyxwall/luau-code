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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
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
importLib(_d({91,88,81,30,96,100,84,98,99,78,87,80,93,83,91,84,97,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,96,100,84,98,99,78,87,80,93,83,91,84,97,29,91,100,80},17))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({61,63,50,98},17))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({68,95,95,84,97,67,94,97,98,94},17))
local prompt = torso and torso:FindFirstChild(_d({63,97,94,92,95,99},17))
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
print(_d({74,64,100,84,98,99,15,67,84,98,99,84,97,76,15,56,93,101,94,90,88,93,86,15,98,87,80,97,84,83,15,64,100,84,98,99,55,80,93,83,91,84,97,15,85,94,97,15,61,63,50,41,15},17) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({74,64,100,84,98,99,15,67,84,98,99,84,97,76,15,53,88,93,88,98,87,84,83,15,98,84,96,100,84,93,82,84,29,15,65,84,98,100,91,99,41,15},17) .. tostring(success))
else
warn(_d({74,64,100,84,98,99,15,67,84,98,99,84,97,76,15,52,65,65,62,65,41,15,64,100,84,98,99,55,80,93,83,91,84,97,15,91,88,81,97,80,97,104,15,82,94,100,91,83,15,93,94,99,15,81,84,15,91,94,80,83,84,83,16},17))
end
else
print(_d({74,64,100,84,98,99,15,67,84,98,99,84,97,76,15,61,94,15,96,100,84,98,99,15,61,63,50,15,85,94,100,93,83,15,102,88,99,87,88,93,15,32,33,15,98,99,100,83,98,29},17))
end
end)()