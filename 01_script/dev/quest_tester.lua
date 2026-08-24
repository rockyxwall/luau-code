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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
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
Core.Import(_d({240,241,237,39,48,47,239,44,41,34,239,49,53,37,51,52,31,40,33,46,36,44,37,50,238,44,53,33},64), _d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,44,53,33,53,237,35,47,36,37,239,45,33,41,46,239,240,241,31,51,35,50,41,48,52,239,44,41,34,239,49,53,37,51,52,31,40,33,46,36,44,37,50,238,44,53,33},64))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({14,16,3,51},64))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({21,48,48,37,50,20,47,50,51,47},64))
local prompt = torso and torso:FindFirstChild(_d({16,50,47,45,48,52},64))
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
print(_d({27,17,53,37,51,52,224,20,37,51,52,37,50,29,224,9,46,54,47,43,41,46,39,224,51,40,33,50,37,36,224,17,53,37,51,52,8,33,46,36,44,37,50,224,38,47,50,224,14,16,3,250,224},64) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({27,17,53,37,51,52,224,20,37,51,52,37,50,29,224,6,41,46,41,51,40,37,36,224,51,37,49,53,37,46,35,37,238,224,18,37,51,53,44,52,250,224},64) .. tostring(success))
else
warn(_d({27,17,53,37,51,52,224,20,37,51,52,37,50,29,224,5,18,18,15,18,250,224,17,53,37,51,52,8,33,46,36,44,37,50,224,44,41,34,50,33,50,57,224,35,47,53,44,36,224,46,47,52,224,34,37,224,44,47,33,36,37,36,225},64))
end
else
print(_d({27,17,53,37,51,52,224,20,37,51,52,37,50,29,224,14,47,224,49,53,37,51,52,224,14,16,3,224,38,47,53,46,36,224,55,41,52,40,41,46,224,241,242,224,51,52,53,36,51,238},64))
end
end)()