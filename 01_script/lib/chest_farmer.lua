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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
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
if isfile and readfile and isfile(_d({254,255,251,53,62,61,253,58,55,48,253,49,61,64,51,252,58,67,47},50)) then
Core = loadstring(readfile(_d({254,255,251,53,62,61,253,58,55,48,253,49,61,64,51,252,58,67,47},50)))()
else
Core = loadstring(game:HttpGet(_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,49,61,64,51,252,58,67,47},50)))()
end
end)
if not Core then warn(_d({41,17,61,64,51,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({19,60,68},50)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({30,64,61,70,55,59,55,66,71,30,64,61,59,62,66},50)) then
local action = v.ActionText or ""
if action:find(_d({30,51,58,55,238,17,54,51,65,66},50)) then
local part = v.Parent
if part and part:IsA(_d({16,47,65,51,30,47,64,66},50)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({246,243,252,254,52,250,238,243,252,254,52,250,238,243,252,254,52,247},50), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({41,17,54,51,65,66,20,47,64,59,51,64,43,238,33,66,61,62,62,51,50,252},50))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({41,17,54,51,65,66,20,47,64,59,51,64,43,238,33,66,47,64,66,51,50,238,49,54,51,65,66,238,52,47,64,59,252,238,34,47,64,53,51,66,238,30,51,58,55,8,238},50) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({41,17,54,51,65,66,20,47,64,59,51,64,43,238,28,61,238,49,54,51,65,66,65,238,52,61,67,60,50,252,238,37,47,55,66,55,60,53,238,0,254,238,65,51,49,61,60,50,65,238,52,61,64,238,65,62,47,69,60,252,252,252},50))
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
if not Safeguard then warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50)); return end
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
_d({17,54,51,65,66,20,47,64,59,51,64},50),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()