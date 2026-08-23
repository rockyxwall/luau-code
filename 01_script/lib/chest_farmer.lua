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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
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
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({15,56,64},54)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({26,60,57,66,51,55,51,62,67,26,60,57,55,58,62},54)) then
local action = v.ActionText or ""
if action:find(_d({26,47,54,51,234,13,50,47,61,62},54)) then
local part = v.Parent
if part and part:IsA(_d({12,43,61,47,26,43,60,62},54)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({242,239,248,250,48,246,234,239,248,250,48,246,234,239,248,250,48,243},54), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,29,62,43,60,62,47,46,234,45,50,47,61,62,234,48,43,60,55,248,234,30,43,60,49,47,62,234,26,47,54,51,4,234},54) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,24,57,234,45,50,47,61,62,61,234,48,57,63,56,46,248,234,33,43,51,62,51,56,49,234,252,250,234,61,47,45,57,56,46,61,234,48,57,60,234,61,58,43,65,56,248,248,248},54))
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
print(string.format(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,16,57,63,56,46,234,239,46,234,45,50,47,61,62,61,248,234,16,43,60,55,51,56,49,234,56,47,43,60,47,61,62,234,48,51,60,61,62,248,248,248},54), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,30,60,43,64,47,54,51,56,49,234,62,57,234,45,50,47,61,62,234,43,62,234},54) .. chest.label)
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
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,11,60,60,51,64,47,46,248,234,25,58,47,56,51,56,49,234,45,50,47,61,62,248,248,248},54))
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