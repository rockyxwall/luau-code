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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local UserInputService = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
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
if isfile and readfile and isfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)) then
Core = loadstring(readfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
else
Core = loadstring(game:HttpGet(_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
end
end)
if not Core then warn(_d({49,25,69,72,59,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,247},42)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({27,68,76},42)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({38,72,69,78,63,67,63,74,79,38,72,69,67,70,74},42)) then
local action = v.ActionText or ""
if action:find(_d({38,59,66,63,246,25,62,59,73,74},42)) then
local part = v.Parent
if part and part:IsA(_d({24,55,73,59,38,55,72,74},42)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({254,251,4,6,60,2,246,251,4,6,60,2,246,251,4,6,60,255},42), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({49,25,62,59,73,74,28,55,72,67,59,72,51,246,41,74,69,70,70,59,58,4},42))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({49,25,62,59,73,74,28,55,72,67,59,72,51,246,41,74,55,72,74,59,58,246,57,62,59,73,74,246,60,55,72,67,4,246,42,55,72,61,59,74,246,38,59,66,63,16,246},42) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({6,7,3,61,70,69,5,66,63,56,5,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55},42), _d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55},42))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({49,25,62,59,73,74,28,55,72,67,59,72,51,246,36,69,246,57,62,59,73,74,73,246,60,69,75,68,58,4,246,45,55,63,74,63,68,61,246,8,6,246,73,59,57,69,68,58,73,246,60,69,72,246,73,70,55,77,68,4,4,4},42))
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
if not Safeguard then warn(_d({49,41,55,60,59,61,75,55,72,58,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,247},42)); return end
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
if not _G.DisableStandalone then
table.insert(ChestFarmer.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if ChestFarmer.Running then
ChestFarmer.Stop()
else
ChestFarmer.Start()
end
end
end))
ChestFarmer.Start()
print(_d({49,25,62,59,73,74,28,55,72,67,59,72,51,246,41,74,55,68,58,55,66,69,68,59,246,35,69,58,59,16,246,38,72,59,73,73,246,253,38,253,246,74,69,246,74,69,61,61,66,59,4},42))
end
return ChestFarmer
end)()