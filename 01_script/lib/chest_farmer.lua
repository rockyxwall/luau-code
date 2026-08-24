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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
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
if isfile and readfile and isfile(_d({13,14,10,68,77,76,12,73,70,63,12,64,76,79,66,11,73,82,62},35)) then
Core = loadstring(readfile(_d({13,14,10,68,77,76,12,73,70,63,12,64,76,79,66,11,73,82,62},35)))()
else
Core = loadstring(game:HttpGet(_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,64,76,79,66,11,73,82,62},35)))()
end
end)
if not Core then warn(_d({56,32,76,79,66,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,254},35)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({34,75,83},35)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({45,79,76,85,70,74,70,81,86,45,79,76,74,77,81},35)) then
local action = v.ActionText or ""
if action:find(_d({45,66,73,70,253,32,69,66,80,81},35)) then
local part = v.Parent
if part and part:IsA(_d({31,62,80,66,45,62,79,81},35)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({5,2,11,13,67,9,253,2,11,13,67,9,253,2,11,13,67,6},35), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({56,32,69,66,80,81,35,62,79,74,66,79,58,253,48,81,76,77,77,66,65,11},35))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({56,32,69,66,80,81,35,62,79,74,66,79,58,253,48,81,62,79,81,66,65,253,64,69,66,80,81,253,67,62,79,74,11,253,49,62,79,68,66,81,253,45,66,73,70,23,253},35) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({13,14,10,68,77,76,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({56,32,69,66,80,81,35,62,79,74,66,79,58,253,43,76,253,64,69,66,80,81,80,253,67,76,82,75,65,11,253,52,62,70,81,70,75,68,253,15,13,253,80,66,64,76,75,65,80,253,67,76,79,253,80,77,62,84,75,11,11,11},35))
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
if not Safeguard then warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,254},35)); return end
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
_d({32,69,66,80,81,35,62,79,74,66,79},35),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()