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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
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
Core.Import(_d({249,250,246,48,57,56,248,53,50,43,248,58,62,46,60,61,40,49,42,55,45,53,46,59,247,53,62,42},55), _d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,53,50,43,248,58,62,46,60,61,40,49,42,55,45,53,46,59,247,53,62,42},55))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({30,57,57,46,59,29,56,59,60,56},55))
local prompt = torso and torso:FindFirstChild(_d({25,59,56,54,57,61},55))
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
print(_d({36,26,62,46,60,61,233,29,46,60,61,46,59,38,233,18,55,63,56,52,50,55,48,233,60,49,42,59,46,45,233,26,62,46,60,61,17,42,55,45,53,46,59,233,47,56,59,233,23,25,12,3,233},55) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({36,26,62,46,60,61,233,29,46,60,61,46,59,38,233,15,50,55,50,60,49,46,45,233,60,46,58,62,46,55,44,46,247,233,27,46,60,62,53,61,3,233},55) .. tostring(success))
else
warn(_d({36,26,62,46,60,61,233,29,46,60,61,46,59,38,233,14,27,27,24,27,3,233,26,62,46,60,61,17,42,55,45,53,46,59,233,53,50,43,59,42,59,66,233,44,56,62,53,45,233,55,56,61,233,43,46,233,53,56,42,45,46,45,234},55))
end
else
print(_d({36,26,62,46,60,61,233,29,46,60,61,46,59,38,233,23,56,233,58,62,46,60,61,233,23,25,12,233,47,56,62,55,45,233,64,50,61,49,50,55,233,250,251,233,60,61,62,45,60,247},55))
end
end)()