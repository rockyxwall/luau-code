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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
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
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({6,47,55},63)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({17,51,48,57,42,46,42,53,58,17,51,48,46,49,53},63)) then
local action = v.ActionText or ""
if action:find(_d({17,38,45,42,225,4,41,38,52,53},63)) then
local part = v.Parent
if part and part:IsA(_d({3,34,52,38,17,34,51,53},63)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({233,230,239,241,39,237,225,230,239,241,39,237,225,230,239,241,39,234},63), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({28,4,41,38,52,53,7,34,51,46,38,51,30,225,20,53,34,51,53,38,37,225,36,41,38,52,53,225,39,34,51,46,239,225,21,34,51,40,38,53,225,17,38,45,42,251,225},63) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({28,4,41,38,52,53,7,34,51,46,38,51,30,225,15,48,225,36,41,38,52,53,52,225,39,48,54,47,37,239,225,24,34,42,53,42,47,40,225,243,241,225,52,38,36,48,47,37,52,225,39,48,51,225,52,49,34,56,47,239,239,239},63))
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
print(string.format(_d({28,4,41,38,52,53,7,34,51,46,38,51,30,225,7,48,54,47,37,225,230,37,225,36,41,38,52,53,52,239,225,7,34,51,46,42,47,40,225,47,38,34,51,38,52,53,225,39,42,51,52,53,239,239,239},63), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({28,4,41,38,52,53,7,34,51,46,38,51,30,225,21,51,34,55,38,45,42,47,40,225,53,48,225,36,41,38,52,53,225,34,53,225},63) .. chest.label)
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
print(_d({28,4,41,38,52,53,7,34,51,46,38,51,30,225,2,51,51,42,55,38,37,239,225,16,49,38,47,42,47,40,225,36,41,38,52,53,239,239,239},63))
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