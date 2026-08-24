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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
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
if isfile and readfile and isfile(_d({15,16,12,70,79,78,14,75,72,65,14,66,78,81,68,13,75,84,64},33)) then
Core = loadstring(readfile(_d({15,16,12,70,79,78,14,75,72,65,14,66,78,81,68,13,75,84,64},33)))()
else
Core = loadstring(game:HttpGet(_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,66,78,81,68,13,75,84,64},33)))()
end
end)
if not Core then warn(_d({58,34,78,81,68,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,0},33)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({36,77,85},33)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({47,81,78,87,72,76,72,83,88,47,81,78,76,79,83},33)) then
local action = v.ActionText or ""
if action:find(_d({47,68,75,72,255,34,71,68,82,83},33)) then
local part = v.Parent
if part and part:IsA(_d({33,64,82,68,47,64,81,83},33)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({7,4,13,15,69,11,255,4,13,15,69,11,255,4,13,15,69,8},33), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({58,34,71,68,82,83,37,64,81,76,68,81,60,255,50,83,78,79,79,68,67,13},33))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({58,34,71,68,82,83,37,64,81,76,68,81,60,255,50,83,64,81,83,68,67,255,66,71,68,82,83,255,69,64,81,76,13,255,51,64,81,70,68,83,255,47,68,75,72,25,255},33) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({15,16,12,70,79,78,14,75,72,65,14,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64},33), _d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,68,64,82,88,62,83,81,64,85,68,75,13,75,84,64},33))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({58,34,71,68,82,83,37,64,81,76,68,81,60,255,45,78,255,66,71,68,82,83,82,255,69,78,84,77,67,13,255,54,64,72,83,72,77,70,255,17,15,255,82,68,66,78,77,67,82,255,69,78,81,255,82,79,64,86,77,13,13,13},33))
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
if not Safeguard then warn(_d({58,50,64,69,68,70,84,64,81,67,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,0},33)); return end
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
_d({34,71,68,82,83,37,64,81,76,68,81},33),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()