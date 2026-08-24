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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
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
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getEasyTravel()
local loaded = false
local result = nil
local oldLazyHub = _G.lazyhub
_G.lazyhub = true
if isfile and readfile then
pcall(function()
local content = readfile(_d({63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
if content and content ~= "" then result = loadstring(content)(); loaded = true end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45)))() end)
end
_G.lazyhub = oldLazyHub
return result
end
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({24,65,73},45)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({35,69,66,75,60,64,60,71,76,35,69,66,64,67,71},45)) then
local action = v.ActionText or ""
if action:find(_d({35,56,63,60,243,22,59,56,70,71},45)) then
local part = v.Parent
if part and part:IsA(_d({21,52,70,56,35,52,69,71},45)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({251,248,1,3,57,255,243,248,1,3,57,255,243,248,1,3,57,252},45), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({46,22,59,56,70,71,25,52,69,64,56,69,48,243,38,71,66,67,67,56,55,1},45))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({46,22,59,56,70,71,25,52,69,64,56,69,48,243,38,71,52,69,71,56,55,243,54,59,56,70,71,243,57,52,69,64,1,243,39,52,69,58,56,71,243,35,56,63,60,13,243},45) .. tostring(targetPeli))
local EasyTravel = getEasyTravel()
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({46,22,59,56,70,71,25,52,69,64,56,69,48,243,33,66,243,54,59,56,70,71,70,243,57,66,72,65,55,1,243,42,52,60,71,60,65,58,243,5,3,243,70,56,54,66,65,55,70,243,57,66,69,243,70,67,52,74,65,1,1,1},45))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then return true end
end
else
local root = getRoot()
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
local myRoot = getRoot()
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
local myRoot = getRoot()
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
ChestFarmer.Running = true
task.spawn(function()
ChestFarmer.FarmUntilPeli(
9999999,
function() return 0 end,
function() return ChestFarmer.Running end
)
end)
end
if not _G.lazyhub then
table.insert(ChestFarmer.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
ChestFarmer.Stop()
end
end))
ChestFarmer.Start()
print(_d({46,22,59,56,70,71,25,52,69,64,56,69,48,243,38,71,52,65,55,52,63,66,65,56,243,32,66,55,56,13,243,35,69,56,70,70,243,250,48,250,243,71,66,243,70,71,66,67,1},45))
end
return ChestFarmer
end)()