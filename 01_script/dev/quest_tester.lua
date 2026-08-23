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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
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
importLib(_d({71,68,61,10,76,80,64,78,79,58,67,60,73,63,71,64,77,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,76,80,64,78,79,58,67,60,73,63,71,64,77,9,71,80,60},37))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({48,75,75,64,77,47,74,77,78,74},37))
local prompt = torso and torso:FindFirstChild(_d({43,77,74,72,75,79},37))
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
print(_d({54,44,80,64,78,79,251,47,64,78,79,64,77,56,251,36,73,81,74,70,68,73,66,251,78,67,60,77,64,63,251,44,80,64,78,79,35,60,73,63,71,64,77,251,65,74,77,251,41,43,30,21,251},37) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({54,44,80,64,78,79,251,47,64,78,79,64,77,56,251,33,68,73,68,78,67,64,63,251,78,64,76,80,64,73,62,64,9,251,45,64,78,80,71,79,21,251},37) .. tostring(success))
else
warn(_d({54,44,80,64,78,79,251,47,64,78,79,64,77,56,251,32,45,45,42,45,21,251,44,80,64,78,79,35,60,73,63,71,64,77,251,71,68,61,77,60,77,84,251,62,74,80,71,63,251,73,74,79,251,61,64,251,71,74,60,63,64,63,252},37))
end
else
print(_d({54,44,80,64,78,79,251,47,64,78,79,64,77,56,251,41,74,251,76,80,64,78,79,251,41,43,30,251,65,74,80,73,63,251,82,68,79,67,68,73,251,12,13,251,78,79,80,63,78,9},37))
end
end)()