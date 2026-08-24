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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
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
if isfile and readfile and isfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)) then
Core = loadstring(readfile(_d({242,243,239,41,50,49,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
else
Core = loadstring(game:HttpGet(_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,37,49,52,39,240,46,55,35},62)))()
end
end)
if not Core then warn(_d({29,5,49,52,39,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({7,48,56},62)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62)) then
local action = v.ActionText or ""
if action:find(_d({18,39,46,43,226,5,42,39,53,54},62)) then
local part = v.Parent
if part and part:IsA(_d({4,35,53,39,18,35,52,54},62)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({234,231,240,242,40,238,226,231,240,242,40,238,226,231,240,242,40,235},62), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({29,5,42,39,53,54,8,35,52,47,39,52,31,226,21,54,49,50,50,39,38,240},62))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({29,5,42,39,53,54,8,35,52,47,39,52,31,226,21,54,35,52,54,39,38,226,37,42,39,53,54,226,40,35,52,47,240,226,22,35,52,41,39,54,226,18,39,46,43,252,226},62) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({242,243,239,41,50,49,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({29,5,42,39,53,54,8,35,52,47,39,52,31,226,16,49,226,37,42,39,53,54,53,226,40,49,55,48,38,240,226,25,35,43,54,43,48,41,226,244,242,226,53,39,37,49,48,38,53,226,40,49,52,226,53,50,35,57,48,240,240,240},62))
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
if not Safeguard then warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,227},62)); return end
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
_d({5,42,39,53,54,8,35,52,47,39,52},62),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()