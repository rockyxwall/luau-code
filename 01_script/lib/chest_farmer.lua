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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
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
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({43,84,92},26)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({54,88,85,94,79,83,79,90,95,54,88,85,83,86,90},26)) then
local action = v.ActionText or ""
if action:find(_d({54,75,82,79,6,41,78,75,89,90},26)) then
local part = v.Parent
if part and part:IsA(_d({40,71,89,75,54,71,88,90},26)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({14,11,20,22,76,18,6,11,20,22,76,18,6,11,20,22,76,15},26), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({65,41,78,75,89,90,44,71,88,83,75,88,67,6,57,90,71,88,90,75,74,6,73,78,75,89,90,6,76,71,88,83,20,6,58,71,88,77,75,90,6,54,75,82,79,32,6},26) .. tostring(targetPeli))
if not _G.EasyTravel then
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(_d({82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26)) then
local content = readfile(_d({82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26))
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26)))()
end)
end
end
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({65,41,78,75,89,90,44,71,88,83,75,88,67,6,52,85,6,73,78,75,89,90,89,6,76,85,91,84,74,20,6,61,71,79,90,79,84,77,6,24,22,6,89,75,73,85,84,74,89,6,76,85,88,6,89,86,71,93,84,20,20,20},26))
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
print(string.format(_d({65,41,78,75,89,90,44,71,88,83,75,88,67,6,44,85,91,84,74,6,11,74,6,73,78,75,89,90,89,20,6,44,71,88,83,79,84,77,6,84,75,71,88,75,89,90,6,76,79,88,89,90,20,20,20},26), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({65,41,78,75,89,90,44,71,88,83,75,88,67,6,58,88,71,92,75,82,79,84,77,6,90,85,6,73,78,75,89,90,6,71,90,6},26) .. chest.label)
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
print(_d({65,41,78,75,89,90,44,71,88,83,75,88,67,6,39,88,88,79,92,75,74,20,6,53,86,75,84,79,84,77,6,73,78,75,89,90,20,20,20},26))
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