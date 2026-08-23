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
local ChestFarmer = {}
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local LocalPlayer = Players.LocalPlayer
local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({32,73,81},37)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({43,77,74,83,68,72,68,79,84,43,77,74,72,75,79},37)) then
local action = v.ActionText or ""
if action:find(_d({43,64,71,68,251,30,67,64,78,79},37)) then
local part = v.Parent
if part and part:IsA(_d({29,60,78,64,43,60,77,79},37)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({3,0,9,11,65,7,251,0,9,11,65,7,251,0,9,11,65,4},37), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({54,30,67,64,78,79,33,60,77,72,64,77,56,251,46,79,60,77,79,64,63,251,62,67,64,78,79,251,65,60,77,72,9,251,47,60,77,66,64,79,251,43,64,71,68,21,251},37) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({54,30,67,64,78,79,33,60,77,72,64,77,56,251,41,74,251,62,67,64,78,79,78,251,65,74,80,73,63,9,251,50,60,68,79,68,73,66,251,13,11,251,78,64,62,74,73,63,78,251,65,74,77,251,78,75,60,82,73,9,9,9},37))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then
return true
end
end
else
local root = getRoot()
if root then
local startPos = root.Position
table.sort(chests, function(a, b)
return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
end)
end
print(string.format(_d({54,30,67,64,78,79,33,60,77,72,64,77,56,251,33,74,80,73,63,251,0,63,251,62,67,64,78,79,78,9,251,33,60,77,72,68,73,66,251,73,64,60,77,64,78,79,251,65,68,77,78,79,9,9,9},37), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({54,30,67,64,78,79,33,60,77,72,64,77,56,251,47,77,60,81,64,71,68,73,66,251,79,74,251,62,67,64,78,79,251,60,79,251},37) .. chest.label)
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
end
local elapsed = 0
local reached = false
while isRunningCallback() and elapsed < 20 do
task.wait(0.1)
elapsed = elapsed + 0.1
local myRoot = getRoot()
if myRoot then
local dist = (myRoot.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
reached = true
break
end
else
task.wait(1)
end
end
if reached and isRunningCallback() then
print(_d({54,30,67,64,78,79,33,60,77,72,64,77,56,251,28,77,77,68,81,64,63,9,251,42,75,64,73,68,73,66,251,62,67,64,78,79,9,9,9},37))
if _G.EasyTravel then
local myRoot = getRoot()
if myRoot then
_G.EasyTravel.TargetPosition = myRoot.Position
end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
task.wait(2.5)
end
end
end
end
task.wait(0.2)
end
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
return getPeliCallback() >= targetPeli
end
_G.ChestFarmer = ChestFarmer
return ChestFarmer
end)()