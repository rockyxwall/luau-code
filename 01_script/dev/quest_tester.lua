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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
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
importLib(_d({56,53,46,251,61,65,49,63,64,43,52,45,58,48,56,49,62,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,61,65,49,63,64,43,52,45,58,48,56,49,62,250,56,65,45},52))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({33,60,60,49,62,32,59,62,63,59},52))
local prompt = torso and torso:FindFirstChild(_d({28,62,59,57,60,64},52))
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
print(_d({39,29,65,49,63,64,236,32,49,63,64,49,62,41,236,21,58,66,59,55,53,58,51,236,63,52,45,62,49,48,236,29,65,49,63,64,20,45,58,48,56,49,62,236,50,59,62,236,26,28,15,6,236},52) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({39,29,65,49,63,64,236,32,49,63,64,49,62,41,236,18,53,58,53,63,52,49,48,236,63,49,61,65,49,58,47,49,250,236,30,49,63,65,56,64,6,236},52) .. tostring(success))
else
warn(_d({39,29,65,49,63,64,236,32,49,63,64,49,62,41,236,17,30,30,27,30,6,236,29,65,49,63,64,20,45,58,48,56,49,62,236,56,53,46,62,45,62,69,236,47,59,65,56,48,236,58,59,64,236,46,49,236,56,59,45,48,49,48,237},52))
end
else
print(_d({39,29,65,49,63,64,236,32,49,63,64,49,62,41,236,26,59,236,61,65,49,63,64,236,26,28,15,236,50,59,65,58,48,236,67,53,64,52,53,58,236,253,254,236,63,64,65,48,63,250},52))
end
end)()