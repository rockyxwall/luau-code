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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
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
importLib(_d({47,44,37,242,52,56,40,54,55,34,43,36,49,39,47,40,53,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,52,56,40,54,55,34,43,36,49,39,47,40,53,241,47,56,36},61))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({24,51,51,40,53,23,50,53,54,50},61))
local prompt = torso and torso:FindFirstChild(_d({19,53,50,48,51,55},61))
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
print(_d({30,20,56,40,54,55,227,23,40,54,55,40,53,32,227,12,49,57,50,46,44,49,42,227,54,43,36,53,40,39,227,20,56,40,54,55,11,36,49,39,47,40,53,227,41,50,53,227,17,19,6,253,227},61) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({30,20,56,40,54,55,227,23,40,54,55,40,53,32,227,9,44,49,44,54,43,40,39,227,54,40,52,56,40,49,38,40,241,227,21,40,54,56,47,55,253,227},61) .. tostring(success))
else
warn(_d({30,20,56,40,54,55,227,23,40,54,55,40,53,32,227,8,21,21,18,21,253,227,20,56,40,54,55,11,36,49,39,47,40,53,227,47,44,37,53,36,53,60,227,38,50,56,47,39,227,49,50,55,227,37,40,227,47,50,36,39,40,39,228},61))
end
else
print(_d({30,20,56,40,54,55,227,23,40,54,55,40,53,32,227,17,50,227,52,56,40,54,55,227,17,19,6,227,41,50,56,49,39,227,58,44,55,43,44,49,227,244,245,227,54,55,56,39,54,241},61))
end
end)()