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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local LocalPlayer = Players.LocalPlayer
local Core = (function()
local Core = {}
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({20,41,48,45},60))
if not (peliValueObj and peliValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
peliValueObj = nested and nested:FindFirstChild(_d({20,41,48,45},60))
end
levelValueObj = statsFolder:FindFirstChild(_d({16,41,58,41,48},60))
if not (levelValueObj and levelValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
levelValueObj = nested and nested:FindFirstChild(_d({16,41,58,41,48},60))
end
staminaValueObj = statsFolder:FindFirstChild(_d({23,56,37,49,45,50,37},60))
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
local hum = char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40},60))
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
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
print("[" .. tostring(name) .. _d({33,228,23,56,37,50,40,37,48,51,50,41,228,17,51,40,41,254,228,20,54,41,55,55,228,235},60) .. toggleKey.Name .. _d({235,228,56,51,228,56,51,43,43,48,41,242},60))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({14,47,246,14,15,24,5,15,7,42},60),
TeleportLocation = _d({245,55,56,23,41,37},60),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({10,45,54,55,56,228,23,41,37,228,12,51,49,41,55,39,54,41,41,50,228,243,228,17,37,45,50,228,17,41,50,57},60),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({55,56,54,45,50,43},60) and code ~= "" then
print(string.format(_d({31,23,37,42,41,43,57,37,54,40,33,228,14,51,45,50,45,50,43,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,228,235,233,55,235,242,242,242},60), code))
task.spawn(function()
local rs = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local reservedRemote = rs:WaitForChild(_d({9,58,41,50,56,55},60)):WaitForChild(_d({54,41,55,41,54,58,41,40},60))
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
v:IsA(_d({22,41,49,51,56,41,9,58,41,50,56},60)) and (v.Name == _d({22,41,49,51,56,41,9,58,41,50,56},60) or v.Name == _d({56,41,48,41},60) or v.Name == _d({24,41,48,41,52,51,54,56},60))
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
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,10,45,54,45,50,43,228,56,41,48,41,52,51,54,56,228,54,41,49,51,56,41,254,228},60) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,7,51,57,48,40,228,50,51,56,228,42,45,50,40,228,22,41,49,51,56,41,9,58,41,50,56,228,45,50,228,50,45,48,242,228,20,54,45,50,56,45,50,43,228,37,48,48,228,22,41,49,51,56,41,9,58,41,50,56,55,228,45,50,228,50,45,48,254},60))
for _, v in next, getnilinstances() do
if v:IsA(_d({22,41,49,51,56,41,9,58,41,50,56},60)) then
print(_d({228,241,228,18,37,49,41,254},60), v.Name)
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
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,43,37,49,41,228,57,50,45,58,41,54,55,41,229,228,23,39,54,45,52,56,228,45,55,228,51,50,48,61,228,42,51,54,228,11,20,19,242},60))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,23,39,54,45,52,56,228,41,60,41,39,57,56,45,51,50,228,38,48,51,39,47,41,40,228,51,50,254,228},60) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,24,41,48,41,52,51,54,56,45,50,43,228,56,51,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,242,242,242,228,20,48,41,37,55,41,228,59,37,45,56,242},60))
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,20,54,45,58,37,56,41,23,41,54,58,41,54,7,51,40,41,228,45,55,228,50,51,56,228,55,41,56,242,228,7,37,50,50,51,56,228,37,57,56,51,241,46,51,45,50,242},60))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,43,37,49,41,228,57,50,45,58,41,54,55,41,229,228,23,39,54,45,52,56,228,45,55,228,51,50,48,61,228,42,51,54,228,11,20,19,242},60))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({31,23,37,42,41,43,57,37,54,40,33,228,29,51,57,228,37,54,41,228,51,50,228,56,44,41,228,12,51,49,41,55,39,54,41,41,50,242,228,23,39,54,45,52,56,228,54,41,53,57,45,54,41,55,228,233,55,242},60), name or _d({37,228,55,52,41,39,45,42,45,39,228,52,48,37,39,41},60)))
if Safeguard.JoinPrivateServer() then
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,24,41,48,41,52,51,54,56,45,50,43,228,56,51,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,242,242,242,228,20,48,41,37,55,41,228,59,37,45,56,242},60))
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,20,54,45,58,37,56,41,23,41,54,58,41,54,7,51,40,41,228,45,55,228,50,51,56,228,55,41,56,242,228,7,37,50,50,51,56,228,37,57,56,51,241,46,51,45,50,242},60))
end
return false
end
warn(
string.format(
_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,52,48,37,39,41,229,228,22,41,53,57,45,54,41,40,254,228,233,55,228,236,233,40,237,240,228,7,57,54,54,41,50,56,254,228,233,40},60),
name or _d({25,50,47,50,51,59,50},60),
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
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.00, 4.1, -12190.00),
Vector3.new(1836.00, -86.0, -12190.00),
Vector3.new(1836.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12222.00),
Vector3.new(1767.20, -78.0, -12224.00),
Vector3.new(1767.20, -78.0, -12226.00),
Vector3.new(1767.20, -86.0, -12228.00),
Vector3.new(1790.00, -86.0, -12228.50),
Vector3.new(1791.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12320.00),
Vector3.new(1819.20, -78.0, -12322.00),
Vector3.new(1819.20, -78.0, -12324.00),
Vector3.new(1819.20, -86.0, -12326.00),
Vector3.new(1819.20, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12330.50),
}
function FishmanMaze.Travel(hrp, isRunning)
if not hrp or not Core then
return
end
local EasyTravel = (function()
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({20,41,48,45},60))
if not (peliValueObj and peliValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
peliValueObj = nested and nested:FindFirstChild(_d({20,41,48,45},60))
end
levelValueObj = statsFolder:FindFirstChild(_d({16,41,58,41,48},60))
if not (levelValueObj and levelValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
levelValueObj = nested and nested:FindFirstChild(_d({16,41,58,41,48},60))
end
staminaValueObj = statsFolder:FindFirstChild(_d({23,56,37,49,45,50,37},60))
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
local hum = char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40},60))
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
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
print("[" .. tostring(name) .. _d({33,228,23,56,37,50,40,37,48,51,50,41,228,17,51,40,41,254,228,20,54,41,55,55,228,235},60) .. toggleKey.Name .. _d({235,228,56,51,228,56,51,43,43,48,41,242},60))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({14,47,246,14,15,24,5,15,7,42},60),
TeleportLocation = _d({245,55,56,23,41,37},60),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({10,45,54,55,56,228,23,41,37,228,12,51,49,41,55,39,54,41,41,50,228,243,228,17,37,45,50,228,17,41,50,57},60),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({55,56,54,45,50,43},60) and code ~= "" then
print(string.format(_d({31,23,37,42,41,43,57,37,54,40,33,228,14,51,45,50,45,50,43,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,228,235,233,55,235,242,242,242},60), code))
task.spawn(function()
local rs = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local reservedRemote = rs:WaitForChild(_d({9,58,41,50,56,55},60)):WaitForChild(_d({54,41,55,41,54,58,41,40},60))
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
v:IsA(_d({22,41,49,51,56,41,9,58,41,50,56},60)) and (v.Name == _d({22,41,49,51,56,41,9,58,41,50,56},60) or v.Name == _d({56,41,48,41},60) or v.Name == _d({24,41,48,41,52,51,54,56},60))
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
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,10,45,54,45,50,43,228,56,41,48,41,52,51,54,56,228,54,41,49,51,56,41,254,228},60) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,7,51,57,48,40,228,50,51,56,228,42,45,50,40,228,22,41,49,51,56,41,9,58,41,50,56,228,45,50,228,50,45,48,242,228,20,54,45,50,56,45,50,43,228,37,48,48,228,22,41,49,51,56,41,9,58,41,50,56,55,228,45,50,228,50,45,48,254},60))
for _, v in next, getnilinstances() do
if v:IsA(_d({22,41,49,51,56,41,9,58,41,50,56},60)) then
print(_d({228,241,228,18,37,49,41,254},60), v.Name)
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
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,43,37,49,41,228,57,50,45,58,41,54,55,41,229,228,23,39,54,45,52,56,228,45,55,228,51,50,48,61,228,42,51,54,228,11,20,19,242},60))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,23,39,54,45,52,56,228,41,60,41,39,57,56,45,51,50,228,38,48,51,39,47,41,40,228,51,50,254,228},60) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,24,41,48,41,52,51,54,56,45,50,43,228,56,51,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,242,242,242,228,20,48,41,37,55,41,228,59,37,45,56,242},60))
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,20,54,45,58,37,56,41,23,41,54,58,41,54,7,51,40,41,228,45,55,228,50,51,56,228,55,41,56,242,228,7,37,50,50,51,56,228,37,57,56,51,241,46,51,45,50,242},60))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,43,37,49,41,228,57,50,45,58,41,54,55,41,229,228,23,39,54,45,52,56,228,45,55,228,51,50,48,61,228,42,51,54,228,11,20,19,242},60))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({31,23,37,42,41,43,57,37,54,40,33,228,29,51,57,228,37,54,41,228,51,50,228,56,44,41,228,12,51,49,41,55,39,54,41,41,50,242,228,23,39,54,45,52,56,228,54,41,53,57,45,54,41,55,228,233,55,242},60), name or _d({37,228,55,52,41,39,45,42,45,39,228,52,48,37,39,41},60)))
if Safeguard.JoinPrivateServer() then
print(_d({31,23,37,42,41,43,57,37,54,40,33,228,24,41,48,41,52,51,54,56,45,50,43,228,56,51,228,20,54,45,58,37,56,41,228,23,41,54,58,41,54,242,242,242,228,20,48,41,37,55,41,228,59,37,45,56,242},60))
else
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,20,54,45,58,37,56,41,23,41,54,58,41,54,7,51,40,41,228,45,55,228,50,51,56,228,55,41,56,242,228,7,37,50,50,51,56,228,37,57,56,51,241,46,51,45,50,242},60))
end
return false
end
warn(
string.format(
_d({31,23,37,42,41,43,57,37,54,40,33,228,27,54,51,50,43,228,52,48,37,39,41,229,228,22,41,53,57,45,54,41,40,254,228,233,55,228,236,233,40,237,240,228,7,57,54,54,41,50,56,254,228,233,40},60),
name or _d({25,50,47,50,51,59,50},60),
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
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)), char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60)) or Instance.new(_d({5,56,56,37,39,44,49,41,50,56},60))
att.Name = _d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60)
att.Parent = root
local force = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60))
if not force then
force = Instance.new(_d({16,45,50,41,37,54,26,41,48,51,39,45,56,61},60))
force.Name = _d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 10000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local _, _, root = getCharacterComponents()
if root then
local force = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60))
local att = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
local direction = Vector3.new(0, -checkDepth, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
end
local function runRaycastLoop()
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
local moveDir = Vector3.zero
if EasyTravel.DisableRaycasting then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
task.wait(RAYCAST_COOLDOWN)
continue
end
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({10,45,55,44,49,37,50,228,7,37,58,41},60))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
if hit then
hitCave = true
end
end
EasyTravel.HitCave = hitCave
if hitCave or inRoughWaters then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
continue
end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if forwardHit then
distanceToWall = forwardHit.Distance
local clearanceY = nil
local currentScanDist = FORWARD_SCAN_DISTANCE
local heightOffset = 4
while heightOffset <= 100 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
local secondaryOrigin = scanOrigin + moveUnit * 10
local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
if secondaryHit then
currentScanDist = currentScanDist + 15
else
break
end
end
heightOffset = heightOffset + 4
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,229},60))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({31,9,37,55,61,228,24,54,37,58,41,48,33,228,10,48,45,43,44,56,228,41,50,37,38,48,41,40,242},60))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({31,9,37,55,61,228,24,54,37,58,41,48,33,228,10,48,45,43,44,56,228,40,45,55,37,38,48,41,40,242},60))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({9,37,55,61,228,24,54,37,58,41,48},60), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
if not EasyTravel then
warn(_d({31,10,45,55,44,49,37,50,228,17,37,62,41,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,9,37,55,61,24,54,37,58,41,48,229},60))
return
end
if EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
print(_d({31,10,45,55,44,49,37,50,228,17,37,62,41,33,228,23,56,37,54,56,45,50,43,228,9,37,55,61,24,54,37,58,41,48,241,38,37,55,41,40,228,49,37,62,41,228,56,54,37,58,41,54,55,37,48,242,242,242},60))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({6,37,55,41,20,37,54,56},60)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
EasyTravel.Speed = 25
for i, target in ipairs(mazePath) do
EasyTravel.TargetPosition = target
pcall(EasyTravel.Start)
while (hrp.Position - target).Magnitude > 4 do
if isRunning and not isRunning() then
break
end
RunService.Heartbeat:Wait()
end
if isRunning and not isRunning() then
break
end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({31,10,45,55,44,49,37,50,228,17,37,62,41,33,228,7,51,49,52,48,41,56,41,242},60))
end
return FishmanMaze
end)()