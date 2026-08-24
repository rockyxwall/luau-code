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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
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
importLib(_d({88,85,78,27,93,97,81,95,96,75,84,77,90,80,88,81,94,26,88,97,77},20), _d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,88,97,77,97,25,79,91,80,81,27,89,77,85,90,27,28,29,75,95,79,94,85,92,96,27,88,85,78,27,93,97,81,95,96,75,84,77,90,80,88,81,94,26,88,97,77},20))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({65,92,92,81,94,64,91,94,95,91},20))
local prompt = torso and torso:FindFirstChild(_d({60,94,91,89,92,96},20))
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
print(_d({71,61,97,81,95,96,12,64,81,95,96,81,94,73,12,53,90,98,91,87,85,90,83,12,95,84,77,94,81,80,12,61,97,81,95,96,52,77,90,80,88,81,94,12,82,91,94,12,58,60,47,38,12},20) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({71,61,97,81,95,96,12,64,81,95,96,81,94,73,12,50,85,90,85,95,84,81,80,12,95,81,93,97,81,90,79,81,26,12,62,81,95,97,88,96,38,12},20) .. tostring(success))
else
warn(_d({71,61,97,81,95,96,12,64,81,95,96,81,94,73,12,49,62,62,59,62,38,12,61,97,81,95,96,52,77,90,80,88,81,94,12,88,85,78,94,77,94,101,12,79,91,97,88,80,12,90,91,96,12,78,81,12,88,91,77,80,81,80,13},20))
end
else
print(_d({71,61,97,81,95,96,12,64,81,95,96,81,94,73,12,58,91,12,93,97,81,95,96,12,58,60,47,12,82,91,97,90,80,12,99,85,96,84,85,90,12,29,30,12,95,96,97,80,95,26},20))
end
end)()