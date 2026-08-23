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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
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
importLib(_d({79,76,69,18,84,88,72,86,87,66,75,68,81,71,79,72,85,17,79,88,68},29), _d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,79,76,69,18,84,88,72,86,87,66,75,68,81,71,79,72,85,17,79,88,68},29))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({56,83,83,72,85,55,82,85,86,82},29))
local prompt = torso and torso:FindFirstChild(_d({51,85,82,80,83,87},29))
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
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,44,81,89,82,78,76,81,74,3,86,75,68,85,72,71,3,52,88,72,86,87,43,68,81,71,79,72,85,3,73,82,85,3,49,51,38,29,3},29) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,41,76,81,76,86,75,72,71,3,86,72,84,88,72,81,70,72,17,3,53,72,86,88,79,87,29,3},29) .. tostring(success))
else
warn(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,40,53,53,50,53,29,3,52,88,72,86,87,43,68,81,71,79,72,85,3,79,76,69,85,68,85,92,3,70,82,88,79,71,3,81,82,87,3,69,72,3,79,82,68,71,72,71,4},29))
end
else
print(_d({62,52,88,72,86,87,3,55,72,86,87,72,85,64,3,49,82,3,84,88,72,86,87,3,49,51,38,3,73,82,88,81,71,3,90,76,87,75,76,81,3,20,21,3,86,87,88,71,86,17},29))
end
end)()