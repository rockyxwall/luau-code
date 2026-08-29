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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local LocalPlayer = Players.LocalPlayer
local OpenChests = {
Running = false,
Connections = {},
}
local ARRIVE_DIST = 6
local TIMEOUT_PER_CHEST = 20
local OPEN_WAIT = 2.5
local TRAVEL_HEIGHT = 4
local CHECK_HZ = 0.1
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(position)
return position.X >= ISLAND_MIN_X
and position.X <= ISLAND_MAX_X
and position.Z >= ISLAND_MIN_Z
and position.Z <= ISLAND_MAX_Z
end
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55)) then
local action = v.ActionText or ""
if action:find(_d({25,46,53,50,233,12,49,46,60,61},55)) then
local part = v.Parent
if part and part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({241,238,247,249,47,245,233,238,247,249,47,245,233,238,247,249,47,242},55), part.Position.X, part.Position.Y, part.Position.Z),
})
end
end
end
end
return chests
end
local function waitForRoot(timeout)
local t = 0
while t < timeout do
local r = Core.GetRoot(LocalPlayer)
if r then
return r
end
task.wait(0.1)
t = t + 0.1
end
return nil
end
local Core = (function()
local Core = {}
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({25,46,53,50},55))
if not (peliValueObj and peliValueObj:IsA(_d({31,42,53,62,46,11,42,60,46},55))) then
local nested = statsFolder:FindFirstChild(_d({28,61,42,61,60},55))
peliValueObj = nested and nested:FindFirstChild(_d({25,46,53,50},55))
end
levelValueObj = statsFolder:FindFirstChild(_d({21,46,63,46,53},55))
if not (levelValueObj and levelValueObj:IsA(_d({31,42,53,62,46,11,42,60,46},55))) then
local nested = statsFolder:FindFirstChild(_d({28,61,42,61,60},55))
levelValueObj = nested and nested:FindFirstChild(_d({21,46,63,46,53},55))
end
staminaValueObj = statsFolder:FindFirstChild(_d({28,61,42,54,50,55,42},55))
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
local hum = char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45},55))
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
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
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
print("[" .. tostring(name) .. _d({38,233,28,61,42,55,45,42,53,56,55,46,233,22,56,45,46,3,233,25,59,46,60,60,233,240},55) .. toggleKey.Name .. _d({240,233,61,56,233,61,56,48,48,53,46,247},55))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({19,52,251,19,20,29,10,20,12,47},55),
TeleportLocation = _d({250,60,61,28,46,42},55),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({15,50,59,60,61,233,28,46,42,233,17,56,54,46,60,44,59,46,46,55,233,248,233,22,42,50,55,233,22,46,55,62},55),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({60,61,59,50,55,48},55) and code ~= "" then
print(string.format(_d({36,28,42,47,46,48,62,42,59,45,38,233,19,56,50,55,50,55,48,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,233,240,238,60,240,247,247,247},55), code))
task.spawn(function()
local rs = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local reservedRemote = rs:WaitForChild(_d({14,63,46,55,61,60},55)):WaitForChild(_d({59,46,60,46,59,63,46,45},55))
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
v:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) and (v.Name == _d({27,46,54,56,61,46,14,63,46,55,61},55) or v.Name == _d({61,46,53,46},55) or v.Name == _d({29,46,53,46,57,56,59,61},55))
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
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,15,50,59,50,55,48,233,61,46,53,46,57,56,59,61,233,59,46,54,56,61,46,3,233},55) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,27,46,54,56,61,46,14,63,46,55,61,233,50,55,233,55,50,53,247,233,25,59,50,55,61,50,55,48,233,42,53,53,233,27,46,54,56,61,46,14,63,46,55,61,60,233,50,55,233,55,50,53,3},55))
for _, v in next, getnilinstances() do
if v:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) then
print(_d({233,246,233,23,42,54,46,3},55), v.Name)
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
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,48,42,54,46,233,62,55,50,63,46,59,60,46,234,233,28,44,59,50,57,61,233,50,60,233,56,55,53,66,233,47,56,59,233,16,25,24,247},55))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,28,44,59,50,57,61,233,46,65,46,44,62,61,50,56,55,233,43,53,56,44,52,46,45,233,56,55,3,233},55) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,29,46,53,46,57,56,59,61,50,55,48,233,61,56,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,247,247,247,233,25,53,46,42,60,46,233,64,42,50,61,247},55))
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,25,59,50,63,42,61,46,28,46,59,63,46,59,12,56,45,46,233,50,60,233,55,56,61,233,60,46,61,247,233,12,42,55,55,56,61,233,42,62,61,56,246,51,56,50,55,247},55))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,48,42,54,46,233,62,55,50,63,46,59,60,46,234,233,28,44,59,50,57,61,233,50,60,233,56,55,53,66,233,47,56,59,233,16,25,24,247},55))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({36,28,42,47,46,48,62,42,59,45,38,233,34,56,62,233,42,59,46,233,56,55,233,61,49,46,233,17,56,54,46,60,44,59,46,46,55,247,233,28,44,59,50,57,61,233,59,46,58,62,50,59,46,60,233,238,60,247},55), name or _d({42,233,60,57,46,44,50,47,50,44,233,57,53,42,44,46},55)))
if Safeguard.JoinPrivateServer() then
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,29,46,53,46,57,56,59,61,50,55,48,233,61,56,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,247,247,247,233,25,53,46,42,60,46,233,64,42,50,61,247},55))
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,25,59,50,63,42,61,46,28,46,59,63,46,59,12,56,45,46,233,50,60,233,55,56,61,233,60,46,61,247,233,12,42,55,55,56,61,233,42,62,61,56,246,51,56,50,55,247},55))
end
return false
end
warn(
string.format(
_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,57,53,42,44,46,234,233,27,46,58,62,50,59,46,45,3,233,238,60,233,241,238,45,242,245,233,12,62,59,59,46,55,61,3,233,238,45},55),
name or _d({30,55,52,55,56,64,55},55),
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
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do
conn:Disconnect()
end
OpenChests.Connections = {}
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,28,61,56,57,57,46,45,247},55))
end
function OpenChests.Start()
if OpenChests.Running then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,59,46,42,45,66,233,59,62,55,55,50,55,48,234},55))
return
end
if not Safeguard then
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,234},55))
return
end
if not Safeguard.IsSafe() then
return
end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,56,62,55,45,233,238,45,233,25,46,53,50,233,12,49,46,60,61,60,233,61,56,61,42,53,233,50,55,233,64,56,59,52,60,57,42,44,46,247},55), #allChests))
if #allChests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,44,49,46,60,61,60,233,47,56,62,55,45,233,171,73,93,233,42,59,46,233,66,56,62,233,50,55,233,61,49,46,233,59,50,48,49,61,233,42,59,46,42,8},55))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,44,49,42,59,42,44,61,46,59,233,59,56,56,61,234,233,10,43,56,59,61,50,55,48,247},55))
OpenChests.Stop()
return
end
local playerStartPos = startRoot.Position
local playerStartY = playerStartPos.Y
local filtered = {}
local skippedIsland = 0
local skippedY = 0
for _, c in ipairs(allChests) do
if not isInsideTownOfBeginnings(c.position) then
skippedIsland = skippedIsland + 1
elseif c.position.Y > playerStartY + 20 then
skippedY = skippedY + 1
else
table.insert(filtered, c)
end
end
table.sort(filtered, function(a, b)
return (a.position - playerStartPos).Magnitude < (b.position - playerStartPos).Magnitude
end)
local chests = filtered
print(
string.format(
_d({36,24,57,46,55,12,49,46,60,61,60,38,233,238,45,233,44,49,46,60,61,60,233,58,62,46,62,46,45,233,69,233,238,45,233,56,62,61,60,50,45,46,233,50,60,53,42,55,45,233,69,233,238,45,233,61,56,56,233,49,50,48,49,247},55),
#chests,
skippedIsland,
skippedY
)
)
if #chests == 0 then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,23,56,233,59,46,42,44,49,42,43,53,46,233,44,49,46,60,61,60,233,42,47,61,46,59,233,47,50,53,61,46,59,50,55,48,247},55))
OpenChests.Stop()
return
end
local EasyTravel = (function()
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({25,46,53,50},55))
if not (peliValueObj and peliValueObj:IsA(_d({31,42,53,62,46,11,42,60,46},55))) then
local nested = statsFolder:FindFirstChild(_d({28,61,42,61,60},55))
peliValueObj = nested and nested:FindFirstChild(_d({25,46,53,50},55))
end
levelValueObj = statsFolder:FindFirstChild(_d({21,46,63,46,53},55))
if not (levelValueObj and levelValueObj:IsA(_d({31,42,53,62,46,11,42,60,46},55))) then
local nested = statsFolder:FindFirstChild(_d({28,61,42,61,60},55))
levelValueObj = nested and nested:FindFirstChild(_d({21,46,63,46,53},55))
end
staminaValueObj = statsFolder:FindFirstChild(_d({28,61,42,54,50,55,42},55))
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
local hum = char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45},55))
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
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
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
print("[" .. tostring(name) .. _d({38,233,28,61,42,55,45,42,53,56,55,46,233,22,56,45,46,3,233,25,59,46,60,60,233,240},55) .. toggleKey.Name .. _d({240,233,61,56,233,61,56,48,48,53,46,247},55))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({19,52,251,19,20,29,10,20,12,47},55),
TeleportLocation = _d({250,60,61,28,46,42},55),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({15,50,59,60,61,233,28,46,42,233,17,56,54,46,60,44,59,46,46,55,233,248,233,22,42,50,55,233,22,46,55,62},55),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({60,61,59,50,55,48},55) and code ~= "" then
print(string.format(_d({36,28,42,47,46,48,62,42,59,45,38,233,19,56,50,55,50,55,48,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,233,240,238,60,240,247,247,247},55), code))
task.spawn(function()
local rs = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local reservedRemote = rs:WaitForChild(_d({14,63,46,55,61,60},55)):WaitForChild(_d({59,46,60,46,59,63,46,45},55))
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
v:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) and (v.Name == _d({27,46,54,56,61,46,14,63,46,55,61},55) or v.Name == _d({61,46,53,46},55) or v.Name == _d({29,46,53,46,57,56,59,61},55))
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
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,15,50,59,50,55,48,233,61,46,53,46,57,56,59,61,233,59,46,54,56,61,46,3,233},55) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,27,46,54,56,61,46,14,63,46,55,61,233,50,55,233,55,50,53,247,233,25,59,50,55,61,50,55,48,233,42,53,53,233,27,46,54,56,61,46,14,63,46,55,61,60,233,50,55,233,55,50,53,3},55))
for _, v in next, getnilinstances() do
if v:IsA(_d({27,46,54,56,61,46,14,63,46,55,61},55)) then
print(_d({233,246,233,23,42,54,46,3},55), v.Name)
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
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,48,42,54,46,233,62,55,50,63,46,59,60,46,234,233,28,44,59,50,57,61,233,50,60,233,56,55,53,66,233,47,56,59,233,16,25,24,247},55))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,28,44,59,50,57,61,233,46,65,46,44,62,61,50,56,55,233,43,53,56,44,52,46,45,233,56,55,3,233},55) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,29,46,53,46,57,56,59,61,50,55,48,233,61,56,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,247,247,247,233,25,53,46,42,60,46,233,64,42,50,61,247},55))
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,25,59,50,63,42,61,46,28,46,59,63,46,59,12,56,45,46,233,50,60,233,55,56,61,233,60,46,61,247,233,12,42,55,55,56,61,233,42,62,61,56,246,51,56,50,55,247},55))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,48,42,54,46,233,62,55,50,63,46,59,60,46,234,233,28,44,59,50,57,61,233,50,60,233,56,55,53,66,233,47,56,59,233,16,25,24,247},55))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({36,28,42,47,46,48,62,42,59,45,38,233,34,56,62,233,42,59,46,233,56,55,233,61,49,46,233,17,56,54,46,60,44,59,46,46,55,247,233,28,44,59,50,57,61,233,59,46,58,62,50,59,46,60,233,238,60,247},55), name or _d({42,233,60,57,46,44,50,47,50,44,233,57,53,42,44,46},55)))
if Safeguard.JoinPrivateServer() then
print(_d({36,28,42,47,46,48,62,42,59,45,38,233,29,46,53,46,57,56,59,61,50,55,48,233,61,56,233,25,59,50,63,42,61,46,233,28,46,59,63,46,59,247,247,247,233,25,53,46,42,60,46,233,64,42,50,61,247},55))
else
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,25,59,50,63,42,61,46,28,46,59,63,46,59,12,56,45,46,233,50,60,233,55,56,61,233,60,46,61,247,233,12,42,55,55,56,61,233,42,62,61,56,246,51,56,50,55,247},55))
end
return false
end
warn(
string.format(
_d({36,28,42,47,46,48,62,42,59,45,38,233,32,59,56,55,48,233,57,53,42,44,46,234,233,27,46,58,62,50,59,46,45,3,233,238,60,233,241,238,45,242,245,233,12,62,59,59,46,55,61,3,233,238,45},55),
name or _d({30,55,52,55,56,64,55},55),
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
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
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
return char, char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)), char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({40,40,14,42,60,66,29,59,42,63,46,53,10,61,61},55)) or Instance.new(_d({10,61,61,42,44,49,54,46,55,61},55))
att.Name = _d({40,40,14,42,60,66,29,59,42,63,46,53,10,61,61},55)
att.Parent = root
local force = root:FindFirstChild(_d({40,40,14,42,60,66,29,59,42,63,46,53,15,56,59,44,46},55))
if not force then
force = Instance.new(_d({21,50,55,46,42,59,31,46,53,56,44,50,61,66},55))
force.Name = _d({40,40,14,42,60,66,29,59,42,63,46,53,15,56,59,44,46},55)
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
local force = root:FindFirstChild(_d({40,40,14,42,60,66,29,59,42,63,46,53,15,56,59,44,46},55))
local att = root:FindFirstChild(_d({40,40,14,42,60,66,29,59,42,63,46,53,10,61,61},55))
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
local cave = Workspace.Islands:FindFirstChild(_d({15,50,60,49,54,42,55,233,12,42,63,46},55))
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
warn(_d({36,28,42,47,46,48,62,42,59,45,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,234},55))
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
print(_d({36,14,42,60,66,233,29,59,42,63,46,53,38,233,15,53,50,48,49,61,233,46,55,42,43,53,46,45,247},55))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({36,14,42,60,66,233,29,59,42,63,46,53,38,233,15,53,50,48,49,61,233,45,50,60,42,43,53,46,45,247},55))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({14,42,60,66,233,29,59,42,63,46,53},55), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
if not EasyTravel then
error(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55))
end
EasyTravel.Start()
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,14,42,60,66,233,29,59,42,63,46,53,233,60,61,42,59,61,46,45,247},55))
for i, chest in ipairs(chests) do
if not OpenChests.Running then
break
end
print(string.format(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,36,238,45,248,238,45,38,233,29,59,42,63,46,53,53,50,55,48,233,61,56,233,44,49,46,60,61,233,42,61,233,238,60},55), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,21,56,60,61,233,44,49,42,59,42,44,61,46,59,233,171,73,93,233,57,42,62,60,50,55,48,247},55))
task.wait(1)
root = waitForRoot(5)
if not root then
break
end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
break
end
end
if not OpenChests.Running then
break
end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then
EasyTravel.TargetPosition = currentRoot.Position
end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function()
fireproximityprompt(chest.prompt)
end)
if not ok then
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
end
task.wait(OPEN_WAIT)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
if OpenChests.Running then
print(_d({36,24,57,46,55,12,49,46,60,61,60,38,233,10,53,53,233,44,49,46,60,61,60,233,57,59,56,44,46,60,60,46,45,234},55))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(OpenChests, _d({24,57,46,55,12,49,46,60,61,60},55), OpenChests.Start, OpenChests.Stop, function()
return OpenChests.Running
end)
return OpenChests
end)()