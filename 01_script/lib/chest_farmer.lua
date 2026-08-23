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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
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
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({45,86,94},24)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24)) then
local action = v.ActionText or ""
if action:find(_d({56,77,84,81,8,43,80,77,91,92},24)) then
local part = v.Parent
if part and part:IsA(_d({42,73,91,77,56,73,90,92},24)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({16,13,22,24,78,20,8,13,22,24,78,20,8,13,22,24,78,17},24), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({67,43,80,77,91,92,46,73,90,85,77,90,69,8,59,92,73,90,92,77,76,8,75,80,77,91,92,8,78,73,90,85,22,8,60,73,90,79,77,92,8,56,77,84,81,34,8},24) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({67,43,80,77,91,92,46,73,90,85,77,90,69,8,54,87,8,75,80,77,91,92,91,8,78,87,93,86,76,22,8,63,73,81,92,81,86,79,8,26,24,8,91,77,75,87,86,76,91,8,78,87,90,8,91,88,73,95,86,22,22,22},24))
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
print(string.format(_d({67,43,80,77,91,92,46,73,90,85,77,90,69,8,46,87,93,86,76,8,13,76,8,75,80,77,91,92,91,22,8,46,73,90,85,81,86,79,8,86,77,73,90,77,91,92,8,78,81,90,91,92,22,22,22},24), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({67,43,80,77,91,92,46,73,90,85,77,90,69,8,60,90,73,94,77,84,81,86,79,8,92,87,8,75,80,77,91,92,8,73,92,8},24) .. chest.label)
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
print(_d({67,43,80,77,91,92,46,73,90,85,77,90,69,8,41,90,90,81,94,77,76,22,8,55,88,77,86,81,86,79,8,75,80,77,91,92,22,22,22},24))
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