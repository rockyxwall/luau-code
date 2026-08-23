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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
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
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({41,82,90},28)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({52,86,83,92,77,81,77,88,93,52,86,83,81,84,88},28)) then
local action = v.ActionText or ""
if action:find(_d({52,73,80,77,4,39,76,73,87,88},28)) then
local part = v.Parent
if part and part:IsA(_d({38,69,87,73,52,69,86,88},28)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({12,9,18,20,74,16,4,9,18,20,74,16,4,9,18,20,74,13},28), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,55,88,69,86,88,73,72,4,71,76,73,87,88,4,74,69,86,81,18,4,56,69,86,75,73,88,4,52,73,80,77,30,4},28) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,50,83,4,71,76,73,87,88,87,4,74,83,89,82,72,18,4,59,69,77,88,77,82,75,4,22,20,4,87,73,71,83,82,72,87,4,74,83,86,4,87,84,69,91,82,18,18,18},28))
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
print(string.format(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,42,83,89,82,72,4,9,72,4,71,76,73,87,88,87,18,4,42,69,86,81,77,82,75,4,82,73,69,86,73,87,88,4,74,77,86,87,88,18,18,18},28), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,56,86,69,90,73,80,77,82,75,4,88,83,4,71,76,73,87,88,4,69,88,4},28) .. chest.label)
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
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,37,86,86,77,90,73,72,18,4,51,84,73,82,77,82,75,4,71,76,73,87,88,18,18,18},28))
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