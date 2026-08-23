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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
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
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({14,55,63},55)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55)) then
local action = v.ActionText or ""
if action:find(_d({25,46,53,50,233,12,49,46,60,61},55)) then
local part = v.Parent
if part and part:IsA(_d({11,42,60,46,25,42,59,61},55)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({241,238,247,249,47,245,233,238,247,249,47,245,233,238,247,249,47,242},55), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({36,12,49,46,60,61,15,42,59,54,46,59,38,233,28,61,42,59,61,46,45,233,44,49,46,60,61,233,47,42,59,54,247,233,29,42,59,48,46,61,233,25,46,53,50,3,233},55) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({36,12,49,46,60,61,15,42,59,54,46,59,38,233,23,56,233,44,49,46,60,61,60,233,47,56,62,55,45,247,233,32,42,50,61,50,55,48,233,251,249,233,60,46,44,56,55,45,60,233,47,56,59,233,60,57,42,64,55,247,247,247},55))
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
print(string.format(_d({36,12,49,46,60,61,15,42,59,54,46,59,38,233,15,56,62,55,45,233,238,45,233,44,49,46,60,61,60,247,233,15,42,59,54,50,55,48,233,55,46,42,59,46,60,61,233,47,50,59,60,61,247,247,247},55), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({36,12,49,46,60,61,15,42,59,54,46,59,38,233,29,59,42,63,46,53,50,55,48,233,61,56,233,44,49,46,60,61,233,42,61,233},55) .. chest.label)
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
print(_d({36,12,49,46,60,61,15,42,59,54,46,59,38,233,10,59,59,50,63,46,45,247,233,24,57,46,55,50,55,48,233,44,49,46,60,61,247,247,247},55))
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