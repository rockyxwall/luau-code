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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
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
Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,57,61,45,59,60,39,48,41,54,44,52,45,58,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,57,61,45,59,60,39,48,41,54,44,52,45,58,246,52,61,41},56))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({22,24,11,59},56))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({29,56,56,45,58,28,55,58,59,55},56))
local prompt = torso and torso:FindFirstChild(_d({24,58,55,53,56,60},56))
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
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,17,54,62,55,51,49,54,47,232,59,48,41,58,45,44,232,25,61,45,59,60,16,41,54,44,52,45,58,232,46,55,58,232,22,24,11,2,232},56) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,14,49,54,49,59,48,45,44,232,59,45,57,61,45,54,43,45,246,232,26,45,59,61,52,60,2,232},56) .. tostring(success))
else
warn(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,13,26,26,23,26,2,232,25,61,45,59,60,16,41,54,44,52,45,58,232,52,49,42,58,41,58,65,232,43,55,61,52,44,232,54,55,60,232,42,45,232,52,55,41,44,45,44,233},56))
end
else
print(_d({35,25,61,45,59,60,232,28,45,59,60,45,58,37,232,22,55,232,57,61,45,59,60,232,22,24,11,232,46,55,61,54,44,232,63,49,60,48,49,54,232,249,250,232,59,60,61,44,59,246},56))
end
end)()