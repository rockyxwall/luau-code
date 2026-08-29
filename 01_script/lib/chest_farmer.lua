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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local UserInputService = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
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
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({27,48,55,52},53))
if not (peliValueObj and peliValueObj:IsA(_d({33,44,55,64,48,13,44,62,48},53))) then
local nested = statsFolder:FindFirstChild(_d({30,63,44,63,62},53))
peliValueObj = nested and nested:FindFirstChild(_d({27,48,55,52},53))
end
levelValueObj = statsFolder:FindFirstChild(_d({23,48,65,48,55},53))
if not (levelValueObj and levelValueObj:IsA(_d({33,44,55,64,48,13,44,62,48},53))) then
local nested = statsFolder:FindFirstChild(_d({30,63,44,63,62},53))
levelValueObj = nested and nested:FindFirstChild(_d({23,48,65,48,55},53))
end
staminaValueObj = statsFolder:FindFirstChild(_d({30,63,44,56,52,57,44},53))
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
local hum = char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47},53))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
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
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({40,235,30,63,44,57,47,44,55,58,57,48,235,24,58,47,48,5,235,27,61,48,62,62,235,242},53) .. toggleKey.Name .. _d({242,235,63,58,235,63,58,50,50,55,48,249},53))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({21,54,253,21,22,31,12,22,14,49},53),
TeleportLocation = _d({252,62,63,30,48,44},53)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({17,52,61,62,63,235,30,48,44,235,19,58,56,48,62,46,61,48,48,57,235,250,235,24,44,52,57,235,24,48,57,64},53),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({62,63,61,52,57,50},53) and code ~= "" then
print(string.format(_d({38,30,44,49,48,50,64,44,61,47,40,235,21,58,52,57,52,57,50,235,27,61,52,65,44,63,48,235,30,48,61,65,48,61,235,242,240,62,242,249,249,249},53), code))
task.spawn(function()
local rs = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local reservedRemote = rs:WaitForChild(_d({16,65,48,57,63,62},53)):WaitForChild(_d({61,48,62,48,61,65,48,47},53))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({29,48,56,58,63,48,16,65,48,57,63},53)) and (v.Name == _d({29,48,56,58,63,48,16,65,48,57,63},53) or v.Name == _d({63,48,55,48},53) or v.Name == _d({31,48,55,48,59,58,61,63},53)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({38,30,44,49,48,50,64,44,61,47,40,235,17,52,61,52,57,50,235,63,48,55,48,59,58,61,63,235,61,48,56,58,63,48,5,235},53) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,14,58,64,55,47,235,57,58,63,235,49,52,57,47,235,29,48,56,58,63,48,16,65,48,57,63,235,52,57,235,57,52,55,249,235,27,61,52,57,63,52,57,50,235,44,55,55,235,29,48,56,58,63,48,16,65,48,57,63,62,235,52,57,235,57,52,55,5},53))
for _,v in next, getnilinstances() do
if v:IsA(_d({29,48,56,58,63,48,16,65,48,57,63},53)) then
print(_d({235,248,235,25,44,56,48,5},53), v.Name)
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
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,34,61,58,57,50,235,50,44,56,48,235,64,57,52,65,48,61,62,48,236,235,30,46,61,52,59,63,235,52,62,235,58,57,55,68,235,49,58,61,235,18,27,26,249},53))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,30,46,61,52,59,63,235,48,67,48,46,64,63,52,58,57,235,45,55,58,46,54,48,47,235,58,57,5,235},53) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({38,30,44,49,48,50,64,44,61,47,40,235,31,48,55,48,59,58,61,63,52,57,50,235,63,58,235,27,61,52,65,44,63,48,235,30,48,61,65,48,61,249,249,249,235,27,55,48,44,62,48,235,66,44,52,63,249},53))
else
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,27,61,52,65,44,63,48,30,48,61,65,48,61,14,58,47,48,235,52,62,235,57,58,63,235,62,48,63,249,235,14,44,57,57,58,63,235,44,64,63,58,248,53,58,52,57,249},53))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,34,61,58,57,50,235,50,44,56,48,235,64,57,52,65,48,61,62,48,236,235,30,46,61,52,59,63,235,52,62,235,58,57,55,68,235,49,58,61,235,18,27,26,249},53))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({38,30,44,49,48,50,64,44,61,47,40,235,36,58,64,235,44,61,48,235,58,57,235,63,51,48,235,19,58,56,48,62,46,61,48,48,57,249,235,30,46,61,52,59,63,235,61,48,60,64,52,61,48,62,235,240,62,249},53), name or _d({44,235,62,59,48,46,52,49,52,46,235,59,55,44,46,48},53)))
if Safeguard.JoinPrivateServer() then
print(_d({38,30,44,49,48,50,64,44,61,47,40,235,31,48,55,48,59,58,61,63,52,57,50,235,63,58,235,27,61,52,65,44,63,48,235,30,48,61,65,48,61,249,249,249,235,27,55,48,44,62,48,235,66,44,52,63,249},53))
else
warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,27,61,52,65,44,63,48,30,48,61,65,48,61,14,58,47,48,235,52,62,235,57,58,63,235,62,48,63,249,235,14,44,57,57,58,63,235,44,64,63,58,248,53,58,52,57,249},53))
end
return false
end
warn(string.format(_d({38,30,44,49,48,50,64,44,61,47,40,235,34,61,58,57,50,235,59,55,44,46,48,236,235,29,48,60,64,52,61,48,47,5,235,240,62,235,243,240,47,244,247,235,14,64,61,61,48,57,63,5,235,240,47},53), name or _d({32,57,54,57,58,66,57},53), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({251,252,248,50,59,58,250,55,52,45,250,62,44,49,48,50,64,44,61,47,249,55,64,44},53), _d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,55,64,44,64,248,46,58,47,48,250,56,44,52,57,250,251,252,42,62,46,61,52,59,63,250,55,52,45,250,62,44,49,48,50,64,44,61,47,249,55,64,44},53))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,55,64,44,64,248,46,58,47,48,250,56,44,52,57,250,251,252,42,62,46,61,52,59,63,250,55,52,45,250,46,58,61,48,249,55,64,44},53)))()
end)
end
if not Core then warn(_d({38,14,58,61,48,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,236},53)); return end
local Safeguard = Core.GetSafeguard()
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({16,57,65},53)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({27,61,58,67,52,56,52,63,68,27,61,58,56,59,63},53)) then
local action = v.ActionText or ""
if action:find(_d({27,48,55,52,235,14,51,48,62,63},53)) then
local part = v.Parent
if part and part:IsA(_d({13,44,62,48,27,44,61,63},53)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({243,240,249,251,49,247,235,240,249,251,49,247,235,240,249,251,49,244},53), part.Position.X, part.Position.Y, part.Position.Z)
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
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,30,63,58,59,59,48,47,249},53))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,30,63,44,61,63,48,47,235,46,51,48,62,63,235,49,44,61,56,249,235,31,44,61,50,48,63,235,27,48,55,52,5,235},53) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({251,252,248,50,59,58,250,55,52,45,250,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44},53), _d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,55,64,44,64,248,46,58,47,48,250,56,44,52,57,250,251,252,42,62,46,61,52,59,63,250,55,52,45,250,48,44,62,68,42,63,61,44,65,48,55,249,55,64,44},53))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({38,14,51,48,62,63,17,44,61,56,48,61,40,235,25,58,235,46,51,48,62,63,62,235,49,58,64,57,47,249,235,34,44,52,63,52,57,50,235,253,251,235,62,48,46,58,57,47,62,235,49,58,61,235,62,59,44,66,57,249,249,249},53))
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
if not Safeguard then warn(_d({38,30,44,49,48,50,64,44,61,47,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,236},53)); return end
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
_d({14,51,48,62,63,17,44,61,56,48,61},53),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()