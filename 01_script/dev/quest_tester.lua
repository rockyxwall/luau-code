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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
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
importLib(_d({85,82,75,24,90,94,78,92,93,72,81,74,87,77,85,78,91,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,90,94,78,92,93,72,81,74,87,77,85,78,91,23,85,94,74},23))
end
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if not myRoot then return nil end
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
if not npcsFolder then return nil end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({62,89,89,78,91,61,88,91,92,88},23))
local prompt = torso and torso:FindFirstChild(_d({57,91,88,86,89,93},23))
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
print(_d({68,58,94,78,92,93,9,61,78,92,93,78,91,70,9,50,87,95,88,84,82,87,80,9,92,81,74,91,78,77,9,58,94,78,92,93,49,74,87,77,85,78,91,9,79,88,91,9,55,57,44,35,9},23) .. npc.Name)
local success = _G.QuestHandler.AcceptQuest(npc.Name)
print(_d({68,58,94,78,92,93,9,61,78,92,93,78,91,70,9,47,82,87,82,92,81,78,77,9,92,78,90,94,78,87,76,78,23,9,59,78,92,94,85,93,35,9},23) .. tostring(success))
else
warn(_d({68,58,94,78,92,93,9,61,78,92,93,78,91,70,9,46,59,59,56,59,35,9,58,94,78,92,93,49,74,87,77,85,78,91,9,85,82,75,91,74,91,98,9,76,88,94,85,77,9,87,88,93,9,75,78,9,85,88,74,77,78,77,10},23))
end
else
print(_d({68,58,94,78,92,93,9,61,78,92,93,78,91,70,9,55,88,9,90,94,78,92,93,9,55,57,44,9,79,88,94,87,77,9,96,82,93,81,82,87,9,26,27,9,92,93,94,77,92,23},23))
end
end)()