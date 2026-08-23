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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
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
importLib(_d({61,58,51,0,66,70,54,68,69,48,57,50,63,53,61,54,67,255,61,70,50},47), _d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,61,70,50,70,254,52,64,53,54,0,62,50,58,63,0,1,2,48,68,52,67,58,65,69,0,61,58,51,0,66,70,54,68,69,48,57,50,63,53,61,54,67,255,61,70,50},47))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({31,33,20,68},47))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({38,65,65,54,67,37,64,67,68,64},47))
local prompt = torso and torso:FindFirstChild(_d({33,67,64,62,65,69},47))
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
print(_d({44,34,70,54,68,69,241,37,54,68,69,54,67,46,241,26,63,71,64,60,58,63,56,241,68,57,50,67,54,53,241,34,70,54,68,69,25,50,63,53,61,54,67,241,55,64,67,241,31,33,20,11,241},47) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({44,34,70,54,68,69,241,37,54,68,69,54,67,46,241,23,58,63,58,68,57,54,53,241,68,54,66,70,54,63,52,54,255,241,35,54,68,70,61,69,11,241},47) .. tostring(success))
else
warn(_d({44,34,70,54,68,69,241,37,54,68,69,54,67,46,241,22,35,35,32,35,11,241,34,70,54,68,69,25,50,63,53,61,54,67,241,61,58,51,67,50,67,74,241,52,64,70,61,53,241,63,64,69,241,51,54,241,61,64,50,53,54,53,242},47))
end
else
print(_d({44,34,70,54,68,69,241,37,54,68,69,54,67,46,241,31,64,241,66,70,54,68,69,241,31,33,20,241,55,64,70,63,53,241,72,58,69,57,58,63,241,2,3,241,68,69,70,53,68,255},47))
end
end)()