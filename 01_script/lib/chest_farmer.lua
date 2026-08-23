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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
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
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({13,54,62},56)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({24,58,55,64,49,53,49,60,65,24,58,55,53,56,60},56)) then
local action = v.ActionText or ""
if action:find(_d({24,45,52,49,232,11,48,45,59,60},56)) then
local part = v.Parent
if part and part:IsA(_d({10,41,59,45,24,41,58,60},56)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({240,237,246,248,46,244,232,237,246,248,46,244,232,237,246,248,46,241},56), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({35,11,48,45,59,60,14,41,58,53,45,58,37,232,27,60,41,58,60,45,44,232,43,48,45,59,60,232,46,41,58,53,246,232,28,41,58,47,45,60,232,24,45,52,49,2,232},56) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({35,11,48,45,59,60,14,41,58,53,45,58,37,232,22,55,232,43,48,45,59,60,59,232,46,55,61,54,44,246,232,31,41,49,60,49,54,47,232,250,248,232,59,45,43,55,54,44,59,232,46,55,58,232,59,56,41,63,54,246,246,246},56))
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
print(string.format(_d({35,11,48,45,59,60,14,41,58,53,45,58,37,232,14,55,61,54,44,232,237,44,232,43,48,45,59,60,59,246,232,14,41,58,53,49,54,47,232,54,45,41,58,45,59,60,232,46,49,58,59,60,246,246,246},56), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({35,11,48,45,59,60,14,41,58,53,45,58,37,232,28,58,41,62,45,52,49,54,47,232,60,55,232,43,48,45,59,60,232,41,60,232},56) .. chest.label)
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
print(_d({35,11,48,45,59,60,14,41,58,53,45,58,37,232,9,58,58,49,62,45,44,246,232,23,56,45,54,49,54,47,232,43,48,45,59,60,246,246,246},56))
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