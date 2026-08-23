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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
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
importLib(_d({68,65,58,7,73,77,61,75,76,55,64,57,70,60,68,61,74,6,68,77,57},40), _d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,68,77,57,77,5,59,71,60,61,7,69,57,65,70,7,8,9,55,75,59,74,65,72,76,7,68,65,58,7,73,77,61,75,76,55,64,57,70,60,68,61,74,6,68,77,57},40))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({45,72,72,61,74,44,71,74,75,71},40))
local prompt = torso and torso:FindFirstChild(_d({40,74,71,69,72,76},40))
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
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,33,70,78,71,67,65,70,63,248,75,64,57,74,61,60,248,41,77,61,75,76,32,57,70,60,68,61,74,248,62,71,74,248,38,40,27,18,248},40) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,30,65,70,65,75,64,61,60,248,75,61,73,77,61,70,59,61,6,248,42,61,75,77,68,76,18,248},40) .. tostring(success))
else
warn(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,29,42,42,39,42,18,248,41,77,61,75,76,32,57,70,60,68,61,74,248,68,65,58,74,57,74,81,248,59,71,77,68,60,248,70,71,76,248,58,61,248,68,71,57,60,61,60,249},40))
end
else
print(_d({51,41,77,61,75,76,248,44,61,75,76,61,74,53,248,38,71,248,73,77,61,75,76,248,38,40,27,248,62,71,77,70,60,248,79,65,76,64,65,70,248,9,10,248,75,76,77,60,75,6},40))
end
end)()