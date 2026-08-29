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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local LocalPlayer = Players.LocalPlayer
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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({37,70,51,70,69},46) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({34,55,62,59},46))
if not (peliValueObj and peliValueObj:IsA(_d({40,51,62,71,55,20,51,69,55},46))) then
local nested = statsFolder:FindFirstChild(_d({37,70,51,70,69},46))
peliValueObj = nested and nested:FindFirstChild(_d({34,55,62,59},46))
end
levelValueObj = statsFolder:FindFirstChild(_d({30,55,72,55,62},46))
if not (levelValueObj and levelValueObj:IsA(_d({40,51,62,71,55,20,51,69,55},46))) then
local nested = statsFolder:FindFirstChild(_d({37,70,51,70,69},46))
levelValueObj = nested and nested:FindFirstChild(_d({30,55,72,55,62},46))
end
staminaValueObj = statsFolder:FindFirstChild(_d({37,70,51,63,59,64,51},46))
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
local hum = char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54},46))
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
local UserInputService = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
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
print("[" .. tostring(name) .. _d({47,242,37,70,51,64,54,51,62,65,64,55,242,31,65,54,55,12,242,34,68,55,69,69,242,249},46) .. toggleKey.Name .. _d({249,242,70,65,242,70,65,57,57,62,55,0},46))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({28,61,4,28,29,38,19,29,21,56},46),
TeleportLocation = _d({3,69,70,37,55,51},46),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({24,59,68,69,70,242,37,55,51,242,26,65,63,55,69,53,68,55,55,64,242,1,242,31,51,59,64,242,31,55,64,71},46),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({69,70,68,59,64,57},46) and code ~= "" then
print(string.format(_d({45,37,51,56,55,57,71,51,68,54,47,242,28,65,59,64,59,64,57,242,34,68,59,72,51,70,55,242,37,55,68,72,55,68,242,249,247,69,249,0,0,0},46), code))
task.spawn(function()
local rs = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local reservedRemote = rs:WaitForChild(_d({23,72,55,64,70,69},46)):WaitForChild(_d({68,55,69,55,68,72,55,54},46))
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
v:IsA(_d({36,55,63,65,70,55,23,72,55,64,70},46)) and (v.Name == _d({36,55,63,65,70,55,23,72,55,64,70},46) or v.Name == _d({70,55,62,55},46) or v.Name == _d({38,55,62,55,66,65,68,70},46))
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
print(_d({45,37,51,56,55,57,71,51,68,54,47,242,24,59,68,59,64,57,242,70,55,62,55,66,65,68,70,242,68,55,63,65,70,55,12,242},46) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,21,65,71,62,54,242,64,65,70,242,56,59,64,54,242,36,55,63,65,70,55,23,72,55,64,70,242,59,64,242,64,59,62,0,242,34,68,59,64,70,59,64,57,242,51,62,62,242,36,55,63,65,70,55,23,72,55,64,70,69,242,59,64,242,64,59,62,12},46))
for _, v in next, getnilinstances() do
if v:IsA(_d({36,55,63,65,70,55,23,72,55,64,70},46)) then
print(_d({242,255,242,32,51,63,55,12},46), v.Name)
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
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,41,68,65,64,57,242,57,51,63,55,242,71,64,59,72,55,68,69,55,243,242,37,53,68,59,66,70,242,59,69,242,65,64,62,75,242,56,65,68,242,25,34,33,0},46))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,37,53,68,59,66,70,242,55,74,55,53,71,70,59,65,64,242,52,62,65,53,61,55,54,242,65,64,12,242},46) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({45,37,51,56,55,57,71,51,68,54,47,242,38,55,62,55,66,65,68,70,59,64,57,242,70,65,242,34,68,59,72,51,70,55,242,37,55,68,72,55,68,0,0,0,242,34,62,55,51,69,55,242,73,51,59,70,0},46))
else
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,34,68,59,72,51,70,55,37,55,68,72,55,68,21,65,54,55,242,59,69,242,64,65,70,242,69,55,70,0,242,21,51,64,64,65,70,242,51,71,70,65,255,60,65,59,64,0},46))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,41,68,65,64,57,242,57,51,63,55,242,71,64,59,72,55,68,69,55,243,242,37,53,68,59,66,70,242,59,69,242,65,64,62,75,242,56,65,68,242,25,34,33,0},46))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({45,37,51,56,55,57,71,51,68,54,47,242,43,65,71,242,51,68,55,242,65,64,242,70,58,55,242,26,65,63,55,69,53,68,55,55,64,0,242,37,53,68,59,66,70,242,68,55,67,71,59,68,55,69,242,247,69,0},46), name or _d({51,242,69,66,55,53,59,56,59,53,242,66,62,51,53,55},46)))
if Safeguard.JoinPrivateServer() then
print(_d({45,37,51,56,55,57,71,51,68,54,47,242,38,55,62,55,66,65,68,70,59,64,57,242,70,65,242,34,68,59,72,51,70,55,242,37,55,68,72,55,68,0,0,0,242,34,62,55,51,69,55,242,73,51,59,70,0},46))
else
warn(_d({45,37,51,56,55,57,71,51,68,54,47,242,34,68,59,72,51,70,55,37,55,68,72,55,68,21,65,54,55,242,59,69,242,64,65,70,242,69,55,70,0,242,21,51,64,64,65,70,242,51,71,70,65,255,60,65,59,64,0},46))
end
return false
end
warn(
string.format(
_d({45,37,51,56,55,57,71,51,68,54,47,242,41,68,65,64,57,242,66,62,51,53,55,243,242,36,55,67,71,59,68,55,54,12,242,247,69,242,250,247,54,251,254,242,21,71,68,68,55,64,70,12,242,247,54},46),
name or _d({39,64,61,64,65,73,64},46),
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
local EasyTravel = Core.Import(
_d({2,3,255,57,66,65,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46),
_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,62,71,51,71,255,53,65,54,55,1,63,51,59,64,1,2,3,49,69,53,68,59,66,70,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46)
)
if not EasyTravel then
warn(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,23,51,69,75,38,68,51,72,55,62,243},46))
return
end
if EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
print(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,37,70,51,68,70,59,64,57,242,23,51,69,75,38,68,51,72,55,62,255,52,51,69,55,54,242,63,51,76,55,242,70,68,51,72,55,68,69,51,62,0,0,0},46))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({20,51,69,55,34,51,68,70},46)) then
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
print(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,21,65,63,66,62,55,70,55,0},46))
end
return FishmanMaze
end)()