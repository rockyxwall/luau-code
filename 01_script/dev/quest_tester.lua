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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
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
importLib(_d({75,72,65,14,80,84,68,82,83,62,71,64,77,67,75,68,81,13,75,84,64},33), _d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,80,84,68,82,83,62,71,64,77,67,75,68,81,13,75,84,64},33))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({52,79,79,68,81,51,78,81,82,78},33))
local prompt = torso and torso:FindFirstChild(_d({47,81,78,76,79,83},33))
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
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,40,77,85,78,74,72,77,70,255,82,71,64,81,68,67,255,48,84,68,82,83,39,64,77,67,75,68,81,255,69,78,81,255,45,47,34,25,255},33) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,37,72,77,72,82,71,68,67,255,82,68,80,84,68,77,66,68,13,255,49,68,82,84,75,83,25,255},33) .. tostring(success))
else
warn(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,36,49,49,46,49,25,255,48,84,68,82,83,39,64,77,67,75,68,81,255,75,72,65,81,64,81,88,255,66,78,84,75,67,255,77,78,83,255,65,68,255,75,78,64,67,68,67,0},33))
end
else
print(_d({58,48,84,68,82,83,255,51,68,82,83,68,81,60,255,45,78,255,80,84,68,82,83,255,45,47,34,255,69,78,84,77,67,255,86,72,83,71,72,77,255,16,17,255,82,83,84,67,82,13},33))
end
end)()