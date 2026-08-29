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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {},
}
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do
conn:Disconnect()
end
LevelGrinder.Connections = {}
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,22,55,50,51,51,40,39,241},61))
end
function LevelGrinder.Start()
if LevelGrinder.Running then
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,4,47,53,40,36,39,60,227,53,56,49,49,44,49,42,228},61))
return
end
if not Safeguard then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
return
end
if not Safeguard.RequirePlace(3978370137, _d({9,44,53,54,55,227,22,40,36},61)) then
return
end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61), 10)
local hum = char:WaitForChild(_d({11,56,48,36,49,50,44,39},61), 10)
local stats = ReplicatedStorage:WaitForChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({19,40,47,44},61), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61)) or (char and char:FindFirstChild(_d({21,44,41,47,40},61)))
if hasRifle then
break
end
local peli = Core.GetPeli()
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,6,56,53,53,40,49,55,227,19,40,47,44,227,38,43,40,38,46,253},61), peli)
local inTown = hrp
and hrp.Position.X >= -889
and hrp.Position.X <= -156
and hrp.Position.Z >= -3706
and hrp.Position.Z <= -3087
if not inTown then
warn(
_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,17,50,55,227,36,55,227,23,50,58,49,227,50,41,227,5,40,42,44,49,49,44,49,42,54,241,227,19,47,40,36,54,40,227,55,53,36,57,40,47,227,55,43,40,53,40,227,55,50,227,41,36,53,48,227,38,43,40,54,55,54,227,58,43,44,47,40,227,58,36,44,55,44,49,42,227,41,50,53,227,21,44,41,47,40,241},61)
)
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = (function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local env = workspace:FindFirstChild(_d({8,49,57},61)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({19,53,50,59,44,48,44,55,60,19,53,50,48,51,55},61)) then
local action = v.ActionText or ""
if action:find(_d({19,40,47,44,227,6,43,40,54,55},61)) then
local part = v.Parent
if part and part:IsA(_d({5,36,54,40,19,36,53,55},61)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({235,232,241,243,41,239,227,232,241,243,41,239,227,232,241,243,41,236},61), part.Position.X, part.Position.Y, part.Position.Z),
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
print(_d({30,6,43,40,54,55,9,36,53,48,40,53,32,227,22,55,50,51,51,40,39,241},61))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({30,6,43,40,54,55,9,36,53,48,40,53,32,227,22,55,36,53,55,40,39,227,38,43,40,54,55,227,41,36,53,48,241,227,23,36,53,42,40,55,227,19,40,47,44,253,227},61) .. tostring(targetPeli))
local EasyTravel = (function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
return char, char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)), char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61))
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
local cave = Workspace.Islands:FindFirstChild(_d({9,44,54,43,48,36,49,227,6,36,57,40},61))
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
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
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,40,49,36,37,47,40,39,241},61))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,39,44,54,36,37,47,40,39,241},61))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({8,36,54,60,227,23,53,36,57,40,47},61), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({30,6,43,40,54,55,9,36,53,48,40,53,32,227,17,50,227,38,43,40,54,55,54,227,41,50,56,49,39,241,227,26,36,44,55,44,49,42,227,245,243,227,54,40,38,50,49,39,54,227,41,50,53,227,54,51,36,58,49,241,241,241},61))
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
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
Core.SetupStandalone(ChestFarmer, _d({6,43,40,54,55,9,36,53,48,40,53},61), ChestFarmer.Start, ChestFarmer.Stop, function()
return ChestFarmer.Running
end)
return ChestFarmer
end)()
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,36,53,48,44,49,42,227,38,43,40,54,55,54,227,56,49,55,44,47,227,246,243,243,227,19,40,47,44,241,241,241,227,235,6,56,53,53,40,49,55,253,227},61) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({19,40,47,44},61))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running
and not (LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61)) or (c and c:FindFirstChild(_d({21,44,41,47,40},61))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = (function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
return char, char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)), char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61))
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
local cave = Workspace.Islands:FindFirstChild(_d({9,44,54,43,48,36,49,227,6,36,57,40},61))
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
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
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,40,49,36,37,47,40,39,241},61))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,39,44,54,36,37,47,40,39,241},61))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({8,36,54,60,227,23,53,36,57,40,47},61), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({5,56,60,36,37,47,40,12,55,40,48,54},61))
local shopItem = buyables and buyables:FindFirstChild(_d({21,44,41,47,40},61))
local shopPart = shopItem and shopItem:FindFirstChild(_d({22,43,50,51,19,36,53,55},61))
if EasyTravel and shopPart and hrp then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,23,53,36,57,40,47,44,49,42,227,55,50,227,21,44,41,47,40,227,54,43,50,51,227,57,44,36,227,8,36,54,60,23,53,36,57,40,47,241,241,241},61))
local nocollide = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then
break
end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({8,57,40,49,55,54},61))
and ReplicatedStorage.Events:FindFirstChild(_d({22,43,50,51},61))
if shopEvent and shopEvent:IsA(_d({21,40,48,50,55,40,9,56,49,38,55,44,50,49},61)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,8,52,56,44,51,51,44,49,42,227,21,44,41,47,40,241,241,241},61))
local args = {
[1] = _d({40,52,56,44,51},61),
[2] = _d({21,44,41,47,40},61),
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({8,57,40,49,55,54},61))
and ReplicatedStorage.Events:FindFirstChild(_d({23,50,50,47,54},61))
if toolsEvent and toolsEvent:IsA(_d({21,40,48,50,55,40,9,56,49,38,55,44,50,49},61)) then
pcall(function()
toolsEvent:InvokeServer(unpack(args))
end)
end
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then
return
end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
local hrp = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61))
if rifle and hum then
hum:EquipTool(rifle)
end
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,47,60,44,49,42,227,55,50,227,9,44,54,43,48,36,49,227,6,36,57,40,241,241,241},61))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = (function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
return char, char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)), char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61))
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
local cave = Workspace.Islands:FindFirstChild(_d({9,44,54,43,48,36,49,227,6,36,57,40},61))
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
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
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,40,49,36,37,47,40,39,241},61))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,39,44,54,36,37,47,40,39,241},61))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({8,36,54,60,227,23,53,36,57,40,47},61), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889
and hrp.Position.X <= -156
and hrp.Position.Z >= -3706
and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,8,54,38,36,51,44,49,42,227,54,43,50,51,227,44,49,55,40,53,44,50,53,227,37,60,227,41,47,60,44,49,42,227,54,55,53,36,44,42,43,55,227,56,51,241,241,241},61))
local nocollide = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then
break
end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700
and distPos.X <= 1973
and distPos.Z >= -12403
and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,47,60,44,49,42,227,55,50,227,9,44,54,43,48,36,49,227,6,36,57,40,241,241,241},61))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then
break
end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = (function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local LocalPlayer = Players.LocalPlayer
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({19,40,47,44},61))
if not (peliValueObj and peliValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
peliValueObj = nested and nested:FindFirstChild(_d({19,40,47,44},61))
end
levelValueObj = statsFolder:FindFirstChild(_d({15,40,57,40,47},61))
if not (levelValueObj and levelValueObj:IsA(_d({25,36,47,56,40,5,36,54,40},61))) then
local nested = statsFolder:FindFirstChild(_d({22,55,36,55,54},61))
levelValueObj = nested and nested:FindFirstChild(_d({15,40,57,40,47},61))
end
staminaValueObj = statsFolder:FindFirstChild(_d({22,55,36,48,44,49,36},61))
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
print("[" .. tostring(name) .. _d({32,227,22,55,36,49,39,36,47,50,49,40,227,16,50,39,40,253,227,19,53,40,54,54,227,234},61) .. toggleKey.Name .. _d({234,227,55,50,227,55,50,42,42,47,40,241},61))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({13,46,245,13,14,23,4,14,6,41},61),
TeleportLocation = _d({244,54,55,22,40,36},61),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({9,44,53,54,55,227,22,40,36,227,11,50,48,40,54,38,53,40,40,49,227,242,227,16,36,44,49,227,16,40,49,56},61),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({54,55,53,44,49,42},61) and code ~= "" then
print(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,13,50,44,49,44,49,42,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,227,234,232,54,234,241,241,241},61), code))
task.spawn(function()
local rs = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local reservedRemote = rs:WaitForChild(_d({8,57,40,49,55,54},61)):WaitForChild(_d({53,40,54,40,53,57,40,39},61))
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
v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) and (v.Name == _d({21,40,48,50,55,40,8,57,40,49,55},61) or v.Name == _d({55,40,47,40},61) or v.Name == _d({23,40,47,40,51,50,53,55},61))
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
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,44,53,44,49,42,227,55,40,47,40,51,50,53,55,227,53,40,48,50,55,40,253,227},61) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,21,40,48,50,55,40,8,57,40,49,55,227,44,49,227,49,44,47,241,227,19,53,44,49,55,44,49,42,227,36,47,47,227,21,40,48,50,55,40,8,57,40,49,55,54,227,44,49,227,49,44,47,253},61))
for _, v in next, getnilinstances() do
if v:IsA(_d({21,40,48,50,55,40,8,57,40,49,55},61)) then
print(_d({227,240,227,17,36,48,40,253},61), v.Name)
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,22,38,53,44,51,55,227,40,59,40,38,56,55,44,50,49,227,37,47,50,38,46,40,39,227,50,49,253,227},61) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,42,36,48,40,227,56,49,44,57,40,53,54,40,228,227,22,38,53,44,51,55,227,44,54,227,50,49,47,60,227,41,50,53,227,10,19,18,241},61))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({30,22,36,41,40,42,56,36,53,39,32,227,28,50,56,227,36,53,40,227,50,49,227,55,43,40,227,11,50,48,40,54,38,53,40,40,49,241,227,22,38,53,44,51,55,227,53,40,52,56,44,53,40,54,227,232,54,241},61), name or _d({36,227,54,51,40,38,44,41,44,38,227,51,47,36,38,40},61)))
if Safeguard.JoinPrivateServer() then
print(_d({30,22,36,41,40,42,56,36,53,39,32,227,23,40,47,40,51,50,53,55,44,49,42,227,55,50,227,19,53,44,57,36,55,40,227,22,40,53,57,40,53,241,241,241,227,19,47,40,36,54,40,227,58,36,44,55,241},61))
else
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,19,53,44,57,36,55,40,22,40,53,57,40,53,6,50,39,40,227,44,54,227,49,50,55,227,54,40,55,241,227,6,36,49,49,50,55,227,36,56,55,50,240,45,50,44,49,241},61))
end
return false
end
warn(
string.format(
_d({30,22,36,41,40,42,56,36,53,39,32,227,26,53,50,49,42,227,51,47,36,38,40,228,227,21,40,52,56,44,53,40,39,253,227,232,54,227,235,232,39,236,239,227,6,56,53,53,40,49,55,253,227,232,39},61),
name or _d({24,49,46,49,50,58,49},61),
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
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
return char, char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)), char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,8,36,54,60,23,53,36,57,40,47,4,55,55},61))
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
local cave = Workspace.Islands:FindFirstChild(_d({9,44,54,43,48,36,49,227,6,36,57,40},61))
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
warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61))
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
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,40,49,36,37,47,40,39,241},61))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({30,8,36,54,60,227,23,53,36,57,40,47,32,227,9,47,44,42,43,55,227,39,44,54,36,37,47,40,39,241},61))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({8,36,54,60,227,23,53,36,57,40,47},61), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
if not EasyTravel then
warn(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,8,36,54,60,23,53,36,57,40,47,228},61))
return
end
if EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
print(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,22,55,36,53,55,44,49,42,227,8,36,54,60,23,53,36,57,40,47,240,37,36,54,40,39,227,48,36,61,40,227,55,53,36,57,40,53,54,36,47,241,241,241},61))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
print(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,6,50,48,51,47,40,55,40,241},61))
end
return FishmanMaze
end)()
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function()
return LevelGrinder.Running
end)
end)
else
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,36,44,47,40,39,227,55,50,227,44,48,51,50,53,55,227,9,44,54,43,48,36,49,16,36,61,40,227,47,44,37,53,36,53,60,228},61))
end
else
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,18,56,55,54,44,39,40,227,9,44,54,43,48,36,49,227,6,36,57,40,227,37,50,56,49,39,54,239,227,54,46,44,51,51,44,49,42,227,48,36,61,40,241},61))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(LevelGrinder, _d({15,40,57,40,47,227,10,53,44,49,39,40,53},61), LevelGrinder.Start, LevelGrinder.Stop, function()
return LevelGrinder.Running
end)
return LevelGrinder
end)()