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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
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
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({37,78,86},32)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({48,82,79,88,73,77,73,84,89,48,82,79,77,80,84},32)) then
local action = v.ActionText or ""
if action:find(_d({48,69,76,73,0,35,72,69,83,84},32)) then
local part = v.Parent
if part and part:IsA(_d({34,65,83,69,48,65,82,84},32)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({8,5,14,16,70,12,0,5,14,16,70,12,0,5,14,16,70,9},32), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,51,84,65,82,84,69,68,0,67,72,69,83,84,0,70,65,82,77,14,0,52,65,82,71,69,84,0,48,69,76,73,26,0},32) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,46,79,0,67,72,69,83,84,83,0,70,79,85,78,68,14,0,55,65,73,84,73,78,71,0,18,16,0,83,69,67,79,78,68,83,0,70,79,82,0,83,80,65,87,78,14,14,14},32))
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
print(string.format(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,38,79,85,78,68,0,5,68,0,67,72,69,83,84,83,14,0,38,65,82,77,73,78,71,0,78,69,65,82,69,83,84,0,70,73,82,83,84,14,14,14},32), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,52,82,65,86,69,76,73,78,71,0,84,79,0,67,72,69,83,84,0,65,84,0},32) .. chest.label)
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
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,33,82,82,73,86,69,68,14,0,47,80,69,78,73,78,71,0,67,72,69,83,84,14,14,14},32))
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