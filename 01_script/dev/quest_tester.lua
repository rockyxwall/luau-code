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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
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
importLib(_d({65,62,55,4,70,74,58,72,73,52,61,54,67,57,65,58,71,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,70,74,58,72,73,52,61,54,67,57,65,58,71,3,65,74,54},43))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({35,37,24,72},43))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({42,69,69,58,71,41,68,71,72,68},43))
local prompt = torso and torso:FindFirstChild(_d({37,71,68,66,69,73},43))
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
print(_d({48,38,74,58,72,73,245,41,58,72,73,58,71,50,245,30,67,75,68,64,62,67,60,245,72,61,54,71,58,57,245,38,74,58,72,73,29,54,67,57,65,58,71,245,59,68,71,245,35,37,24,15,245},43) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({48,38,74,58,72,73,245,41,58,72,73,58,71,50,245,27,62,67,62,72,61,58,57,245,72,58,70,74,58,67,56,58,3,245,39,58,72,74,65,73,15,245},43) .. tostring(success))
else
warn(_d({48,38,74,58,72,73,245,41,58,72,73,58,71,50,245,26,39,39,36,39,15,245,38,74,58,72,73,29,54,67,57,65,58,71,245,65,62,55,71,54,71,78,245,56,68,74,65,57,245,67,68,73,245,55,58,245,65,68,54,57,58,57,246},43))
end
else
print(_d({48,38,74,58,72,73,245,41,58,72,73,58,71,50,245,35,68,245,70,74,58,72,73,245,35,37,24,245,59,68,74,67,57,245,76,62,73,61,62,67,245,6,7,245,72,73,74,57,72,3},43))
end
end)()