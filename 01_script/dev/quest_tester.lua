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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
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
importLib(_d({49,46,39,244,54,58,42,56,57,36,45,38,51,41,49,42,55,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,54,58,42,56,57,36,45,38,51,41,49,42,55,243,49,58,38},59))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({26,53,53,42,55,25,52,55,56,52},59))
local prompt = torso and torso:FindFirstChild(_d({21,55,52,50,53,57},59))
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
print(_d({32,22,58,42,56,57,229,25,42,56,57,42,55,34,229,14,51,59,52,48,46,51,44,229,56,45,38,55,42,41,229,22,58,42,56,57,13,38,51,41,49,42,55,229,43,52,55,229,19,21,8,255,229},59) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({32,22,58,42,56,57,229,25,42,56,57,42,55,34,229,11,46,51,46,56,45,42,41,229,56,42,54,58,42,51,40,42,243,229,23,42,56,58,49,57,255,229},59) .. tostring(success))
else
warn(_d({32,22,58,42,56,57,229,25,42,56,57,42,55,34,229,10,23,23,20,23,255,229,22,58,42,56,57,13,38,51,41,49,42,55,229,49,46,39,55,38,55,62,229,40,52,58,49,41,229,51,52,57,229,39,42,229,49,52,38,41,42,41,230},59))
end
else
print(_d({32,22,58,42,56,57,229,25,42,56,57,42,55,34,229,19,52,229,54,58,42,56,57,229,19,21,8,229,43,52,58,51,41,229,60,46,57,45,46,51,229,246,247,229,56,57,58,41,56,243},59))
end
end)()