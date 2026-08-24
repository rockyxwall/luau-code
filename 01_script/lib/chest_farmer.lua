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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
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
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({41,82,90},28)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({52,86,83,92,77,81,77,88,93,52,86,83,81,84,88},28)) then
local action = v.ActionText or ""
if action:find(_d({52,73,80,77,4,39,76,73,87,88},28)) then
local part = v.Parent
if part and part:IsA(_d({38,69,87,73,52,69,86,88},28)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({12,9,18,20,74,16,4,9,18,20,74,16,4,9,18,20,74,13},28), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,55,88,83,84,84,73,72,18},28))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,55,88,69,86,88,73,72,4,71,76,73,87,88,4,74,69,86,81,18,4,56,69,86,75,73,88,4,52,73,80,77,30,4},28) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({63,39,76,73,87,88,42,69,86,81,73,86,65,4,50,83,4,71,76,73,87,88,87,4,74,83,89,82,72,18,4,59,69,77,88,77,82,75,4,22,20,4,87,73,71,83,82,72,87,4,74,83,86,4,87,84,69,91,82,18,18,18},28))
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
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
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
_d({39,76,73,87,88,42,69,86,81,73,86},28),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()