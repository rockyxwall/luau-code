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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
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
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({16,57,65},53)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({27,61,58,67,52,56,52,63,68,27,61,58,56,59,63},53)) then
local action = v.ActionText or ""
if action:find(_d({27,48,55,52,235,14,51,48,62,63},53)) then
local part = v.Parent
if part and part:IsA(_d({13,44,62,48,27,44,61,63},53)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({243,240,249,251,49,247,235,240,249,251,49,247,235,240,249,251,49,244},53), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,30,63,44,61,63,48,47,235,46,51,48,62,63,235,49,44,61,56,249,235,31,44,61,50,48,63,235,27,48,55,52,5,235},53) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,25,58,235,46,51,48,62,63,62,235,49,58,64,57,47,249,235,34,44,52,63,52,57,50,235,253,251,235,62,48,46,58,57,47,62,235,49,58,61,235,62,59,44,66,57,249,249,249},53))
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
print(string.format(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,17,58,64,57,47,235,240,47,235,46,51,48,62,63,62,249,235,17,44,61,56,52,57,50,235,57,48,44,61,48,62,63,235,49,52,61,62,63,249,249,249},53), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,31,61,44,65,48,55,52,57,50,235,63,58,235,46,51,48,62,63,235,44,63,235},53) .. chest.label)
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
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,12,61,61,52,65,48,47,249,235,26,59,48,57,52,57,50,235,46,51,48,62,63,249,249,249},53))
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