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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
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
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({33,74,82},36)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({44,78,75,84,69,73,69,80,85,44,78,75,73,76,80},36)) then
local action = v.ActionText or ""
if action:find(_d({44,65,72,69,252,31,68,65,79,80},36)) then
local part = v.Parent
if part and part:IsA(_d({30,61,79,65,44,61,78,80},36)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({4,1,10,12,66,8,252,1,10,12,66,8,252,1,10,12,66,5},36), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({55,31,68,65,79,80,34,61,78,73,65,78,57,252,47,80,61,78,80,65,64,252,63,68,65,79,80,252,66,61,78,73,10,252,48,61,78,67,65,80,252,44,65,72,69,22,252},36) .. tostring(targetPeli))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({55,31,68,65,79,80,34,61,78,73,65,78,57,252,42,75,252,63,68,65,79,80,79,252,66,75,81,74,64,10,252,51,61,69,80,69,74,67,252,14,12,252,79,65,63,75,74,64,79,252,66,75,78,252,79,76,61,83,74,10,10,10},36))
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
print(string.format(_d({55,31,68,65,79,80,34,61,78,73,65,78,57,252,34,75,81,74,64,252,1,64,252,63,68,65,79,80,79,10,252,34,61,78,73,69,74,67,252,74,65,61,78,65,79,80,252,66,69,78,79,80,10,10,10},36), #chests))
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
print(_d({55,31,68,65,79,80,34,61,78,73,65,78,57,252,48,78,61,82,65,72,69,74,67,252,80,75,252,63,68,65,79,80,252,61,80,252},36) .. chest.label)
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
print(_d({55,31,68,65,79,80,34,61,78,73,65,78,57,252,29,78,78,69,82,65,64,10,252,43,76,65,74,69,74,67,252,63,68,65,79,80,10,10,10},36))
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