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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
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
if isfile and readfile and isfile(_d({250,251,247,49,58,57,249,54,51,44,249,45,57,60,47,248,54,63,43},54)) then
Core = loadstring(readfile(_d({250,251,247,49,58,57,249,54,51,44,249,45,57,60,47,248,54,63,43},54)))()
else
Core = loadstring(game:HttpGet(_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,54,63,43,63,247,45,57,46,47,249,55,43,51,56,249,250,251,41,61,45,60,51,58,62,249,54,51,44,249,45,57,60,47,248,54,63,43},54)))()
end
end)
if not Core then warn(_d({37,13,57,60,47,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,235},54)); return end
local Safeguard = Core.GetSafeguard()
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
function ChestFarmer.Stop()
ChestFarmer.Running = false
for _, conn in ipairs(ChestFarmer.Connections) do conn:Disconnect() end
ChestFarmer.Connections = {}
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,29,62,57,58,58,47,46,248},54))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,29,62,43,60,62,47,46,234,45,50,47,61,62,234,48,43,60,55,248,234,30,43,60,49,47,62,234,26,47,54,51,4,234},54) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({250,251,247,49,58,57,249,54,51,44,249,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54), _d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,54,63,43,63,247,45,57,46,47,249,55,43,51,56,249,250,251,41,61,45,60,51,58,62,249,54,51,44,249,47,43,61,67,41,62,60,43,64,47,54,248,54,63,43},54))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({37,13,50,47,61,62,16,43,60,55,47,60,39,234,24,57,234,45,50,47,61,62,61,234,48,57,63,56,46,248,234,33,43,51,62,51,56,49,234,252,250,234,61,47,45,57,56,46,61,234,48,57,60,234,61,58,43,65,56,248,248,248},54))
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
if not Safeguard then warn(_d({37,29,43,48,47,49,63,43,60,46,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,235},54)); return end
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
_d({13,50,47,61,62,16,43,60,55,47,60},54),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()