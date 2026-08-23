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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
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
importLib(_d({92,89,82,31,97,101,85,99,100,79,88,81,94,84,92,85,98,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,97,101,85,99,100,79,88,81,94,84,92,85,98,30,92,101,81},16))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({62,64,51,99},16))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({69,96,96,85,98,68,95,98,99,95},16))
local prompt = torso and torso:FindFirstChild(_d({64,98,95,93,96,100},16))
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
print(_d({75,65,101,85,99,100,16,68,85,99,100,85,98,77,16,57,94,102,95,91,89,94,87,16,99,88,81,98,85,84,16,65,101,85,99,100,56,81,94,84,92,85,98,16,86,95,98,16,62,64,51,42,16},16) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({75,65,101,85,99,100,16,68,85,99,100,85,98,77,16,54,89,94,89,99,88,85,84,16,99,85,97,101,85,94,83,85,30,16,66,85,99,101,92,100,42,16},16) .. tostring(success))
else
warn(_d({75,65,101,85,99,100,16,68,85,99,100,85,98,77,16,53,66,66,63,66,42,16,65,101,85,99,100,56,81,94,84,92,85,98,16,92,89,82,98,81,98,105,16,83,95,101,92,84,16,94,95,100,16,82,85,16,92,95,81,84,85,84,17},16))
end
else
print(_d({75,65,101,85,99,100,16,68,85,99,100,85,98,77,16,62,95,16,97,101,85,99,100,16,62,64,51,16,86,95,101,94,84,16,103,89,100,88,89,94,16,33,34,16,99,100,101,84,99,30},16))
end
end)()