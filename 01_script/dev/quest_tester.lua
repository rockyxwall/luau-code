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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
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
importLib(_d({59,56,49,254,64,68,52,66,67,46,55,48,61,51,59,52,65,253,59,68,48},49), _d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,59,68,48,68,252,50,62,51,52,254,60,48,56,61,254,255,0,46,66,50,65,56,63,67,254,59,56,49,254,64,68,52,66,67,46,55,48,61,51,59,52,65,253,59,68,48},49))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({29,31,18,66},49))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({36,63,63,52,65,35,62,65,66,62},49))
local prompt = torso and torso:FindFirstChild(_d({31,65,62,60,63,67},49))
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
print(_d({42,32,68,52,66,67,239,35,52,66,67,52,65,44,239,24,61,69,62,58,56,61,54,239,66,55,48,65,52,51,239,32,68,52,66,67,23,48,61,51,59,52,65,239,53,62,65,239,29,31,18,9,239},49) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({42,32,68,52,66,67,239,35,52,66,67,52,65,44,239,21,56,61,56,66,55,52,51,239,66,52,64,68,52,61,50,52,253,239,33,52,66,68,59,67,9,239},49) .. tostring(success))
else
warn(_d({42,32,68,52,66,67,239,35,52,66,67,52,65,44,239,20,33,33,30,33,9,239,32,68,52,66,67,23,48,61,51,59,52,65,239,59,56,49,65,48,65,72,239,50,62,68,59,51,239,61,62,67,239,49,52,239,59,62,48,51,52,51,240},49))
end
else
print(_d({42,32,68,52,66,67,239,35,52,66,67,52,65,44,239,29,62,239,64,68,52,66,67,239,29,31,18,239,53,62,68,61,51,239,70,56,67,55,56,61,239,0,1,239,66,67,68,51,66,253},49))
end
end)()