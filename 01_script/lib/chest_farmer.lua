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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
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
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({9,50,58},60)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({20,54,51,60,45,49,45,56,61,20,54,51,49,52,56},60)) then
local action = v.ActionText or ""
if action:find(_d({20,41,48,45,228,7,44,41,55,56},60)) then
local part = v.Parent
if part and part:IsA(_d({6,37,55,41,20,37,54,56},60)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({236,233,242,244,42,240,228,233,242,244,42,240,228,233,242,244,42,237},60), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({31,7,44,41,55,56,10,37,54,49,41,54,33,228,23,56,37,54,56,41,40,228,39,44,41,55,56,228,42,37,54,49,242,228,24,37,54,43,41,56,228,20,41,48,45,254,228},60) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({31,7,44,41,55,56,10,37,54,49,41,54,33,228,18,51,228,39,44,41,55,56,55,228,42,51,57,50,40,242,228,27,37,45,56,45,50,43,228,246,244,228,55,41,39,51,50,40,55,228,42,51,54,228,55,52,37,59,50,242,242,242},60))
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
print(string.format(_d({31,7,44,41,55,56,10,37,54,49,41,54,33,228,10,51,57,50,40,228,233,40,228,39,44,41,55,56,55,242,228,10,37,54,49,45,50,43,228,50,41,37,54,41,55,56,228,42,45,54,55,56,242,242,242},60), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({31,7,44,41,55,56,10,37,54,49,41,54,33,228,24,54,37,58,41,48,45,50,43,228,56,51,228,39,44,41,55,56,228,37,56,228},60) .. chest.label)
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
print(_d({31,7,44,41,55,56,10,37,54,49,41,54,33,228,5,54,54,45,58,41,40,242,228,19,52,41,50,45,50,43,228,39,44,41,55,56,242,242,242},60))
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