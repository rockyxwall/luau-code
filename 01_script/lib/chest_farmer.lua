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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
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
if isfile and readfile and isfile(_d({1,2,254,56,65,64,0,61,58,51,0,52,64,67,54,255,61,70,50},47)) then
Core = loadstring(readfile(_d({1,2,254,56,65,64,0,61,58,51,0,52,64,67,54,255,61,70,50},47)))()
else
Core = loadstring(game:HttpGet(_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,61,70,50,70,254,52,64,53,54,0,62,50,58,63,0,1,2,48,68,52,67,58,65,69,0,61,58,51,0,52,64,67,54,255,61,70,50},47)))()
end
end)
if not Core then warn(_d({44,20,64,67,54,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,242},47)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({22,63,71},47)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({33,67,64,73,58,62,58,69,74,33,67,64,62,65,69},47)) then
local action = v.ActionText or ""
if action:find(_d({33,54,61,58,241,20,57,54,68,69},47)) then
local part = v.Parent
if part and part:IsA(_d({19,50,68,54,33,50,67,69},47)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({249,246,255,1,55,253,241,246,255,1,55,253,241,246,255,1,55,250},47), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({44,20,57,54,68,69,23,50,67,62,54,67,46,241,36,69,64,65,65,54,53,255},47))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({44,20,57,54,68,69,23,50,67,62,54,67,46,241,36,69,50,67,69,54,53,241,52,57,54,68,69,241,55,50,67,62,255,241,37,50,67,56,54,69,241,33,54,61,58,11,241},47) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({1,2,254,56,65,64,0,61,58,51,0,54,50,68,74,48,69,67,50,71,54,61,255,61,70,50},47), _d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,61,70,50,70,254,52,64,53,54,0,62,50,58,63,0,1,2,48,68,52,67,58,65,69,0,61,58,51,0,54,50,68,74,48,69,67,50,71,54,61,255,61,70,50},47))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({44,20,57,54,68,69,23,50,67,62,54,67,46,241,31,64,241,52,57,54,68,69,68,241,55,64,70,63,53,255,241,40,50,58,69,58,63,56,241,3,1,241,68,54,52,64,63,53,68,241,55,64,67,241,68,65,50,72,63,255,255,255},47))
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
if not Safeguard then warn(_d({44,36,50,55,54,56,70,50,67,53,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,242},47)); return end
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
_d({20,57,54,68,69,23,50,67,62,54,67},47),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()