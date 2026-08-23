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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
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
importLib(_d({76,73,66,15,81,85,69,83,84,63,72,65,78,68,76,69,82,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,81,85,69,83,84,63,72,65,78,68,76,69,82,14,76,85,65},32))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({53,80,80,69,82,52,79,82,83,79},32))
local prompt = torso and torso:FindFirstChild(_d({48,82,79,77,80,84},32))
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
print(_d({59,49,85,69,83,84,0,52,69,83,84,69,82,61,0,41,78,86,79,75,73,78,71,0,83,72,65,82,69,68,0,49,85,69,83,84,40,65,78,68,76,69,82,0,70,79,82,0,46,48,35,26,0},32) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({59,49,85,69,83,84,0,52,69,83,84,69,82,61,0,38,73,78,73,83,72,69,68,0,83,69,81,85,69,78,67,69,14,0,50,69,83,85,76,84,26,0},32) .. tostring(success))
else
warn(_d({59,49,85,69,83,84,0,52,69,83,84,69,82,61,0,37,50,50,47,50,26,0,49,85,69,83,84,40,65,78,68,76,69,82,0,76,73,66,82,65,82,89,0,67,79,85,76,68,0,78,79,84,0,66,69,0,76,79,65,68,69,68,1},32))
end
else
print(_d({59,49,85,69,83,84,0,52,69,83,84,69,82,61,0,46,79,0,81,85,69,83,84,0,46,48,35,0,70,79,85,78,68,0,87,73,84,72,73,78,0,17,18,0,83,84,85,68,83,14},32))
end
end)()