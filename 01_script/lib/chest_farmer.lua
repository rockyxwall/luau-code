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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({61,82,89,86},19))
if not (peliValueObj and peliValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
peliValueObj = nested and nested:FindFirstChild(_d({61,82,89,86},19))
end
levelValueObj = statsFolder:FindFirstChild(_d({57,82,99,82,89},19))
if not (levelValueObj and levelValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
levelValueObj = nested and nested:FindFirstChild(_d({57,82,99,82,89},19))
end
staminaValueObj = statsFolder:FindFirstChild(_d({64,97,78,90,86,91,78},19))
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
local hum = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81},19))
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
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
print("[" .. tostring(name) .. _d({74,13,64,97,78,91,81,78,89,92,91,82,13,58,92,81,82,39,13,61,95,82,96,96,13,20},19) .. toggleKey.Name .. _d({20,13,97,92,13,97,92,84,84,89,82,27},19))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({55,88,31,55,56,65,46,56,48,83},19),
TeleportLocation = _d({30,96,97,64,82,78},19),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({51,86,95,96,97,13,64,82,78,13,53,92,90,82,96,80,95,82,82,91,13,28,13,58,78,86,91,13,58,82,91,98},19),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({96,97,95,86,91,84},19) and code ~= "" then
print(string.format(_d({72,64,78,83,82,84,98,78,95,81,74,13,55,92,86,91,86,91,84,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,13,20,18,96,20,27,27,27},19), code))
task.spawn(function()
local rs = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local reservedRemote = rs:WaitForChild(_d({50,99,82,91,97,96},19)):WaitForChild(_d({95,82,96,82,95,99,82,81},19))
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
v:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) and (v.Name == _d({63,82,90,92,97,82,50,99,82,91,97},19) or v.Name == _d({97,82,89,82},19) or v.Name == _d({65,82,89,82,93,92,95,97},19))
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
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,86,95,86,91,84,13,97,82,89,82,93,92,95,97,13,95,82,90,92,97,82,39,13},19) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,63,82,90,92,97,82,50,99,82,91,97,13,86,91,13,91,86,89,27,13,61,95,86,91,97,86,91,84,13,78,89,89,13,63,82,90,92,97,82,50,99,82,91,97,96,13,86,91,13,91,86,89,39},19))
for _, v in next, getnilinstances() do
if v:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) then
print(_d({13,26,13,59,78,90,82,39},19), v.Name)
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
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,84,78,90,82,13,98,91,86,99,82,95,96,82,14,13,64,80,95,86,93,97,13,86,96,13,92,91,89,102,13,83,92,95,13,52,61,60,27},19))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,64,80,95,86,93,97,13,82,101,82,80,98,97,86,92,91,13,79,89,92,80,88,82,81,13,92,91,39,13},19) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,65,82,89,82,93,92,95,97,86,91,84,13,97,92,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,27,27,27,13,61,89,82,78,96,82,13,100,78,86,97,27},19))
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,61,95,86,99,78,97,82,64,82,95,99,82,95,48,92,81,82,13,86,96,13,91,92,97,13,96,82,97,27,13,48,78,91,91,92,97,13,78,98,97,92,26,87,92,86,91,27},19))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,84,78,90,82,13,98,91,86,99,82,95,96,82,14,13,64,80,95,86,93,97,13,86,96,13,92,91,89,102,13,83,92,95,13,52,61,60,27},19))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({72,64,78,83,82,84,98,78,95,81,74,13,70,92,98,13,78,95,82,13,92,91,13,97,85,82,13,53,92,90,82,96,80,95,82,82,91,27,13,64,80,95,86,93,97,13,95,82,94,98,86,95,82,96,13,18,96,27},19), name or _d({78,13,96,93,82,80,86,83,86,80,13,93,89,78,80,82},19)))
if Safeguard.JoinPrivateServer() then
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,65,82,89,82,93,92,95,97,86,91,84,13,97,92,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,27,27,27,13,61,89,82,78,96,82,13,100,78,86,97,27},19))
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,61,95,86,99,78,97,82,64,82,95,99,82,95,48,92,81,82,13,86,96,13,91,92,97,13,96,82,97,27,13,48,78,91,91,92,97,13,78,98,97,92,26,87,92,86,91,27},19))
end
return false
end
warn(
string.format(
_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,93,89,78,80,82,14,13,63,82,94,98,86,95,82,81,39,13,18,96,13,21,18,81,22,25,13,48,98,95,95,82,91,97,39,13,18,81},19),
name or _d({66,91,88,91,92,100,91},19),
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
local env = workspace:FindFirstChild(_d({50,91,99},19)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({61,95,92,101,86,90,86,97,102,61,95,92,90,93,97},19)) then
local action = v.ActionText or ""
if action:find(_d({61,82,89,86,13,48,85,82,96,97},19)) then
local part = v.Parent
if part and part:IsA(_d({47,78,96,82,61,78,95,97},19)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({21,18,27,29,83,25,13,18,27,29,83,25,13,18,27,29,83,22},19), part.Position.X, part.Position.Y, part.Position.Z),
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
print(_d({72,48,85,82,96,97,51,78,95,90,82,95,74,13,64,97,92,93,93,82,81,27},19))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({72,48,85,82,96,97,51,78,95,90,82,95,74,13,64,97,78,95,97,82,81,13,80,85,82,96,97,13,83,78,95,90,27,13,65,78,95,84,82,97,13,61,82,89,86,39,13},19) .. tostring(targetPeli))
local EasyTravel = (function()
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({61,82,89,86},19))
if not (peliValueObj and peliValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
peliValueObj = nested and nested:FindFirstChild(_d({61,82,89,86},19))
end
levelValueObj = statsFolder:FindFirstChild(_d({57,82,99,82,89},19))
if not (levelValueObj and levelValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
levelValueObj = nested and nested:FindFirstChild(_d({57,82,99,82,89},19))
end
staminaValueObj = statsFolder:FindFirstChild(_d({64,97,78,90,86,91,78},19))
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
local hum = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81},19))
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
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
print("[" .. tostring(name) .. _d({74,13,64,97,78,91,81,78,89,92,91,82,13,58,92,81,82,39,13,61,95,82,96,96,13,20},19) .. toggleKey.Name .. _d({20,13,97,92,13,97,92,84,84,89,82,27},19))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({55,88,31,55,56,65,46,56,48,83},19),
TeleportLocation = _d({30,96,97,64,82,78},19),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({51,86,95,96,97,13,64,82,78,13,53,92,90,82,96,80,95,82,82,91,13,28,13,58,78,86,91,13,58,82,91,98},19),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({96,97,95,86,91,84},19) and code ~= "" then
print(string.format(_d({72,64,78,83,82,84,98,78,95,81,74,13,55,92,86,91,86,91,84,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,13,20,18,96,20,27,27,27},19), code))
task.spawn(function()
local rs = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local reservedRemote = rs:WaitForChild(_d({50,99,82,91,97,96},19)):WaitForChild(_d({95,82,96,82,95,99,82,81},19))
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
v:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) and (v.Name == _d({63,82,90,92,97,82,50,99,82,91,97},19) or v.Name == _d({97,82,89,82},19) or v.Name == _d({65,82,89,82,93,92,95,97},19))
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
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,86,95,86,91,84,13,97,82,89,82,93,92,95,97,13,95,82,90,92,97,82,39,13},19) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,63,82,90,92,97,82,50,99,82,91,97,13,86,91,13,91,86,89,27,13,61,95,86,91,97,86,91,84,13,78,89,89,13,63,82,90,92,97,82,50,99,82,91,97,96,13,86,91,13,91,86,89,39},19))
for _, v in next, getnilinstances() do
if v:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) then
print(_d({13,26,13,59,78,90,82,39},19), v.Name)
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
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,84,78,90,82,13,98,91,86,99,82,95,96,82,14,13,64,80,95,86,93,97,13,86,96,13,92,91,89,102,13,83,92,95,13,52,61,60,27},19))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,64,80,95,86,93,97,13,82,101,82,80,98,97,86,92,91,13,79,89,92,80,88,82,81,13,92,91,39,13},19) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,65,82,89,82,93,92,95,97,86,91,84,13,97,92,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,27,27,27,13,61,89,82,78,96,82,13,100,78,86,97,27},19))
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,61,95,86,99,78,97,82,64,82,95,99,82,95,48,92,81,82,13,86,96,13,91,92,97,13,96,82,97,27,13,48,78,91,91,92,97,13,78,98,97,92,26,87,92,86,91,27},19))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,84,78,90,82,13,98,91,86,99,82,95,96,82,14,13,64,80,95,86,93,97,13,86,96,13,92,91,89,102,13,83,92,95,13,52,61,60,27},19))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({72,64,78,83,82,84,98,78,95,81,74,13,70,92,98,13,78,95,82,13,92,91,13,97,85,82,13,53,92,90,82,96,80,95,82,82,91,27,13,64,80,95,86,93,97,13,95,82,94,98,86,95,82,96,13,18,96,27},19), name or _d({78,13,96,93,82,80,86,83,86,80,13,93,89,78,80,82},19)))
if Safeguard.JoinPrivateServer() then
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,65,82,89,82,93,92,95,97,86,91,84,13,97,92,13,61,95,86,99,78,97,82,13,64,82,95,99,82,95,27,27,27,13,61,89,82,78,96,82,13,100,78,86,97,27},19))
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,61,95,86,99,78,97,82,64,82,95,99,82,95,48,92,81,82,13,86,96,13,91,92,97,13,96,82,97,27,13,48,78,91,91,92,97,13,78,98,97,92,26,87,92,86,91,27},19))
end
return false
end
warn(
string.format(
_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,93,89,78,80,82,14,13,63,82,94,98,86,95,82,81,39,13,18,96,13,21,18,81,22,25,13,48,98,95,95,82,91,97,39,13,18,81},19),
name or _d({66,91,88,91,92,100,91},19),
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
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
return char, char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)), char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19)
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
local force = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19))
local att = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19))
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
local cave = Workspace.Islands:FindFirstChild(_d({51,86,96,85,90,78,91,13,48,78,99,82},19))
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
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19))
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
print(_d({72,50,78,96,102,13,65,95,78,99,82,89,74,13,51,89,86,84,85,97,13,82,91,78,79,89,82,81,27},19))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({72,50,78,96,102,13,65,95,78,99,82,89,74,13,51,89,86,84,85,97,13,81,86,96,78,79,89,82,81,27},19))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({50,78,96,102,13,65,95,78,99,82,89},19), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({72,48,85,82,96,97,51,78,95,90,82,95,74,13,59,92,13,80,85,82,96,97,96,13,83,92,98,91,81,27,13,68,78,86,97,86,91,84,13,31,29,13,96,82,80,92,91,81,96,13,83,92,95,13,96,93,78,100,91,27,27,27},19))
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
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19))
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
Core.SetupStandalone(ChestFarmer, _d({48,85,82,96,97,51,78,95,90,82,95},19), ChestFarmer.Start, ChestFarmer.Stop, function()
return ChestFarmer.Running
end)
return ChestFarmer
end)()