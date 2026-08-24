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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local UserInputService = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
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
if isfile and readfile and isfile(_d({4,5,1,59,68,67,3,64,61,54,3,55,67,70,57,2,64,73,53},44)) then
Core = loadstring(readfile(_d({4,5,1,59,68,67,3,64,61,54,3,55,67,70,57,2,64,73,53},44)))()
else
Core = loadstring(game:HttpGet(_d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,70,67,55,63,77,76,75,53,64,64,3,64,73,53,73,1,55,67,56,57,3,65,53,61,66,3,4,5,51,71,55,70,61,68,72,3,64,61,54,3,55,67,70,57,2,64,73,53},44)))()
end
end)
if not Core then warn(_d({47,23,67,70,57,49,244,26,53,61,64,57,56,244,72,67,244,64,67,53,56,245},44)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({25,66,74},44)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({36,70,67,76,61,65,61,72,77,36,70,67,65,68,72},44)) then
local action = v.ActionText or ""
if action:find(_d({36,57,64,61,244,23,60,57,71,72},44)) then
local part = v.Parent
if part and part:IsA(_d({22,53,71,57,36,53,70,72},44)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({252,249,2,4,58,0,244,249,2,4,58,0,244,249,2,4,58,253},44), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({47,23,60,57,71,72,26,53,70,65,57,70,49,244,39,72,67,68,68,57,56,2},44))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({47,23,60,57,71,72,26,53,70,65,57,70,49,244,39,72,53,70,72,57,56,244,55,60,57,71,72,244,58,53,70,65,2,244,40,53,70,59,57,72,244,36,57,64,61,14,244},44) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({4,5,1,59,68,67,3,64,61,54,3,57,53,71,77,51,72,70,53,74,57,64,2,64,73,53},44), _d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,70,67,55,63,77,76,75,53,64,64,3,64,73,53,73,1,55,67,56,57,3,65,53,61,66,3,4,5,51,71,55,70,61,68,72,3,64,61,54,3,57,53,71,77,51,72,70,53,74,57,64,2,64,73,53},44))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({47,23,60,57,71,72,26,53,70,65,57,70,49,244,34,67,244,55,60,57,71,72,71,244,58,67,73,66,56,2,244,43,53,61,72,61,66,59,244,6,4,244,71,57,55,67,66,56,71,244,58,67,70,244,71,68,53,75,66,2,2,2},44))
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
if not Safeguard then warn(_d({47,39,53,58,57,59,73,53,70,56,49,244,26,53,61,64,57,56,244,72,67,244,64,67,53,56,245},44)); return end
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
_d({23,60,57,71,72,26,53,70,65,57,70},44),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()