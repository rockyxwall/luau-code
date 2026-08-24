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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local LocalPlayer = Players.LocalPlayer
local ChestFarmer = {
Running = false,
Connections = {}
}
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
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({21,22,18,76,85,84,20,81,78,71,20,72,84,87,74,19,81,90,70},27)) then
Core = loadstring(readfile(_d({21,22,18,76,85,84,20,81,78,71,20,72,84,87,74,19,81,90,70},27)))()
else
Core = loadstring(game:HttpGet(_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,72,84,87,74,19,81,90,70},27)))()
end
end)
if not Core then warn(_d({64,40,84,87,74,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,6},27)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({42,83,91},27)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({53,87,84,93,78,82,78,89,94,53,87,84,82,85,89},27)) then
local action = v.ActionText or ""
if action:find(_d({53,74,81,78,5,40,77,74,88,89},27)) then
local part = v.Parent
if part and part:IsA(_d({39,70,88,74,53,70,87,89},27)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({13,10,19,21,75,17,5,10,19,21,75,17,5,10,19,21,75,14},27), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.Stop()
ChestFarmer.Running = false
for _, conn in ipairs(ChestFarmer.Connections) do conn:Disconnect() end
ChestFarmer.Connections = {}
print(_d({64,40,77,74,88,89,43,70,87,82,74,87,66,5,56,89,84,85,85,74,73,19},27))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({64,40,77,74,88,89,43,70,87,82,74,87,66,5,56,89,70,87,89,74,73,5,72,77,74,88,89,5,75,70,87,82,19,5,57,70,87,76,74,89,5,53,74,81,78,31,5},27) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({21,22,18,76,85,84,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({64,40,77,74,88,89,43,70,87,82,74,87,66,5,51,84,5,72,77,74,88,89,88,5,75,84,90,83,73,19,5,60,70,78,89,78,83,76,5,23,21,5,88,74,72,84,83,73,88,5,75,84,87,5,88,85,70,92,83,19,19,19},27))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then return true end
end
else
local root = Core.GetRoot(LocalPlayer)
if root then
local startPos = root.Position
table.sort(chests, function(a, b)
return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
end)
end
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then break end
if EasyTravel then
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not EasyTravel.Enabled then pcall(EasyTravel.Start) end
end
local elapsed = 0
local reached = false
while isRunningCallback() and elapsed < 20 do
task.wait(0.1)
elapsed = elapsed + 0.1
local myRoot = Core.GetRoot(LocalPlayer)
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
if EasyTravel then
local myRoot = Core.GetRoot(LocalPlayer)
if myRoot then EasyTravel.TargetPosition = myRoot.Position end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then task.wait(holdTime + 0.1) end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function() chest.prompt.Triggered:Fire(LocalPlayer) end)
end
task.wait(2.5)
end
end
end
end
task.wait(0.2)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
return getPeliCallback() >= targetPeli
end
function ChestFarmer.Start()
if ChestFarmer.Running then return end
if not Safeguard then warn(_d({64,56,70,75,74,76,90,70,87,73,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,6},27)); return end
if not Safeguard.IsSafe() then return end
ChestFarmer.Running = true
task.spawn(function()
ChestFarmer.FarmUntilPeli(
9999999,
function() return 0 end,
function() return ChestFarmer.Running end
)
end)
end
Core.SetupStandalone(
ChestFarmer,
_d({40,77,74,88,89,43,70,87,82,74,87},27),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()