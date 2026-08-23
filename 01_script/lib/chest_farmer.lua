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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
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
return char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({26,67,75},43)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({37,71,68,77,62,66,62,73,78,37,71,68,66,69,73},43)) then
local action = v.ActionText or ""
if action:find(_d({37,58,65,62,245,24,61,58,72,73},43)) then
local part = v.Parent
if part and part:IsA(_d({23,54,72,58,37,54,71,73},43)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({253,250,3,5,59,1,245,250,3,5,59,1,245,250,3,5,59,254},43), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({48,24,61,58,72,73,27,54,71,66,58,71,50,245,40,73,54,71,73,58,57,245,56,61,58,72,73,245,59,54,71,66,3,245,41,54,71,60,58,73,245,37,58,65,62,15,245},43) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({48,24,61,58,72,73,27,54,71,66,58,71,50,245,35,68,245,56,61,58,72,73,72,245,59,68,74,67,57,3,245,44,54,62,73,62,67,60,245,7,5,245,72,58,56,68,67,57,72,245,59,68,71,245,72,69,54,76,67,3,3,3},43))
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
print(string.format(_d({48,24,61,58,72,73,27,54,71,66,58,71,50,245,27,68,74,67,57,245,250,57,245,56,61,58,72,73,72,3,245,27,54,71,66,62,67,60,245,67,58,54,71,58,72,73,245,59,62,71,72,73,3,3,3},43), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({48,24,61,58,72,73,27,54,71,66,58,71,50,245,41,71,54,75,58,65,62,67,60,245,73,68,245,56,61,58,72,73,245,54,73,245},43) .. chest.label)
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
print(_d({48,24,61,58,72,73,27,54,71,66,58,71,50,245,22,71,71,62,75,58,57,3,245,36,69,58,67,62,67,60,245,56,61,58,72,73,3,3,3},43))
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