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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
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
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({12,53,61},57)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({23,57,54,63,48,52,48,59,64,23,57,54,52,55,59},57)) then
local action = v.ActionText or ""
if action:find(_d({23,44,51,48,231,10,47,44,58,59},57)) then
local part = v.Parent
if part and part:IsA(_d({9,40,58,44,23,40,57,59},57)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({239,236,245,247,45,243,231,236,245,247,45,243,231,236,245,247,45,240},57), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({34,10,47,44,58,59,13,40,57,52,44,57,36,231,26,59,40,57,59,44,43,231,42,47,44,58,59,231,45,40,57,52,245,231,27,40,57,46,44,59,231,23,44,51,48,1,231},57) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({34,10,47,44,58,59,13,40,57,52,44,57,36,231,21,54,231,42,47,44,58,59,58,231,45,54,60,53,43,245,231,30,40,48,59,48,53,46,231,249,247,231,58,44,42,54,53,43,58,231,45,54,57,231,58,55,40,62,53,245,245,245},57))
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
print(string.format(_d({34,10,47,44,58,59,13,40,57,52,44,57,36,231,13,54,60,53,43,231,236,43,231,42,47,44,58,59,58,245,231,13,40,57,52,48,53,46,231,53,44,40,57,44,58,59,231,45,48,57,58,59,245,245,245},57), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({34,10,47,44,58,59,13,40,57,52,44,57,36,231,27,57,40,61,44,51,48,53,46,231,59,54,231,42,47,44,58,59,231,40,59,231},57) .. chest.label)
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
print(_d({34,10,47,44,58,59,13,40,57,52,44,57,36,231,8,57,57,48,61,44,43,245,231,22,55,44,53,48,53,46,231,42,47,44,58,59,245,245,245},57))
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