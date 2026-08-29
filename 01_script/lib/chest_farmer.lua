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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local LocalPlayer = Players.LocalPlayer
local ChestFarmer = {
Running = false,
Connections = {},
}
local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({17,58,66},52)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({28,62,59,68,53,57,53,64,69,28,62,59,57,60,64},52)) then
local action = v.ActionText or ""
if action:find(_d({28,49,56,53,236,15,52,49,63,64},52)) then
local part = v.Parent
if part and part:IsA(_d({14,45,63,49,28,45,62,64},52)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({244,241,250,252,50,248,236,241,250,252,50,248,236,241,250,252,50,245},52), part.Position.X, part.Position.Y, part.Position.Z),
})
end
end
end
end
return chests
end
function ChestFarmer.Stop()
ChestFarmer.Running = false
for _, conn in ipairs(ChestFarmer.Connections) do
conn:Disconnect()
end
ChestFarmer.Connections = {}
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,31,64,59,60,60,49,48,250},52))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,31,64,45,62,64,49,48,236,47,52,49,63,64,236,50,45,62,57,250,236,32,45,62,51,49,64,236,28,49,56,53,6,236},52) .. tostring(targetPeli))
local EasyTravel = Core.Import(
_d({252,253,249,51,60,59,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52),
_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52)
)
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,26,59,236,47,52,49,63,64,63,236,50,59,65,58,48,250,236,35,45,53,64,53,58,51,236,254,252,236,63,49,47,59,58,48,63,236,50,59,62,236,63,60,45,67,58,250,250,250},52))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then
return true
end
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
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
if EasyTravel then
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not EasyTravel.Enabled then
pcall(EasyTravel.Start)
end
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
if myRoot then
EasyTravel.TargetPosition = myRoot.Position
end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
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
if ChestFarmer.Running then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
ChestFarmer.Running = true
task.spawn(function()
ChestFarmer.FarmUntilPeli(9999999, function()
return 0
end, function()
return ChestFarmer.Running
end)
end)
end
Core.SetupStandalone(ChestFarmer, _d({15,52,49,63,64,18,45,62,57,49,62},52), ChestFarmer.Start, ChestFarmer.Stop, function()
return ChestFarmer.Running
end)
return ChestFarmer
end)()