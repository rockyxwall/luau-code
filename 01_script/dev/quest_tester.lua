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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
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
Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,55,59,43,57,58,37,46,39,52,42,50,43,56,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,55,59,43,57,58,37,46,39,52,42,50,43,56,244,50,59,39},58))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({27,54,54,43,56,26,53,56,57,53},58))
local prompt = torso and torso:FindFirstChild(_d({22,56,53,51,54,58},58))
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
print(_d({33,23,59,43,57,58,230,26,43,57,58,43,56,35,230,15,52,60,53,49,47,52,45,230,57,46,39,56,43,42,230,23,59,43,57,58,14,39,52,42,50,43,56,230,44,53,56,230,20,22,9,0,230},58) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({33,23,59,43,57,58,230,26,43,57,58,43,56,35,230,12,47,52,47,57,46,43,42,230,57,43,55,59,43,52,41,43,244,230,24,43,57,59,50,58,0,230},58) .. tostring(success))
else
warn(_d({33,23,59,43,57,58,230,26,43,57,58,43,56,35,230,11,24,24,21,24,0,230,23,59,43,57,58,14,39,52,42,50,43,56,230,50,47,40,56,39,56,63,230,41,53,59,50,42,230,52,53,58,230,40,43,230,50,53,39,42,43,42,231},58))
end
else
print(_d({33,23,59,43,57,58,230,26,43,57,58,43,56,35,230,20,53,230,55,59,43,57,58,230,20,22,9,230,44,53,59,52,42,230,61,47,58,46,47,52,230,247,248,230,57,58,59,42,57,244},58))
end
end)()