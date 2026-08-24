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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
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
Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,63,67,51,65,66,45,54,47,60,50,58,51,64,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,63,67,51,65,66,45,54,47,60,50,58,51,64,252,58,67,47},50))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({35,62,62,51,64,34,61,64,65,61},50))
local prompt = torso and torso:FindFirstChild(_d({30,64,61,59,62,66},50))
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
print(_d({41,31,67,51,65,66,238,34,51,65,66,51,64,43,238,23,60,68,61,57,55,60,53,238,65,54,47,64,51,50,238,31,67,51,65,66,22,47,60,50,58,51,64,238,52,61,64,238,28,30,17,8,238},50) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({41,31,67,51,65,66,238,34,51,65,66,51,64,43,238,20,55,60,55,65,54,51,50,238,65,51,63,67,51,60,49,51,252,238,32,51,65,67,58,66,8,238},50) .. tostring(success))
else
warn(_d({41,31,67,51,65,66,238,34,51,65,66,51,64,43,238,19,32,32,29,32,8,238,31,67,51,65,66,22,47,60,50,58,51,64,238,58,55,48,64,47,64,71,238,49,61,67,58,50,238,60,61,66,238,48,51,238,58,61,47,50,51,50,239},50))
end
else
print(_d({41,31,67,51,65,66,238,34,51,65,66,51,64,43,238,28,61,238,63,67,51,65,66,238,28,30,17,238,52,61,67,60,50,238,69,55,66,54,55,60,238,255,0,238,65,66,67,50,65,252},50))
end
end)()