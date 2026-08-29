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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
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
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({18,39,46,43},62))
if not (peliValueObj and peliValueObj:IsA(_d({24,35,46,55,39,4,35,53,39},62))) then
local nested = statsFolder:FindFirstChild(_d({21,54,35,54,53},62))
peliValueObj = nested and nested:FindFirstChild(_d({18,39,46,43},62))
end
levelValueObj = statsFolder:FindFirstChild(_d({14,39,56,39,46},62))
if not (levelValueObj and levelValueObj:IsA(_d({24,35,46,55,39,4,35,53,39},62))) then
local nested = statsFolder:FindFirstChild(_d({21,54,35,54,53},62))
levelValueObj = nested and nested:FindFirstChild(_d({14,39,56,39,46},62))
end
staminaValueObj = statsFolder:FindFirstChild(_d({21,54,35,47,43,48,35},62))
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
local hum = char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38},62))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
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
print("[" .. tostring(name) .. _d({31,226,21,54,35,48,38,35,46,49,48,39,226,15,49,38,39,252,226,18,52,39,53,53,226,233},62) .. toggleKey.Name .. _d({233,226,54,49,226,54,49,41,41,46,39,240},62))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({12,45,244,12,13,22,3,13,5,40},62),
TeleportLocation = _d({243,53,54,21,39,35},62)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({8,43,52,53,54,226,21,39,35,226,10,49,47,39,53,37,52,39,39,48,226,241,226,15,35,43,48,226,15,39,48,55},62),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({53,54,52,43,48,41},62) and code ~= "" then
print(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,12,49,43,48,43,48,41,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,226,233,231,53,233,240,240,240},62), code))
task.spawn(function()
local rs = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local reservedRemote = rs:WaitForChild(_d({7,56,39,48,54,53},62)):WaitForChild(_d({52,39,53,39,52,56,39,38},62))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({20,39,47,49,54,39,7,56,39,48,54},62)) and (v.Name == _d({20,39,47,49,54,39,7,56,39,48,54},62) or v.Name == _d({54,39,46,39},62) or v.Name == _d({22,39,46,39,50,49,52,54},62)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,8,43,52,43,48,41,226,54,39,46,39,50,49,52,54,226,52,39,47,49,54,39,252,226},62) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,5,49,55,46,38,226,48,49,54,226,40,43,48,38,226,20,39,47,49,54,39,7,56,39,48,54,226,43,48,226,48,43,46,240,226,18,52,43,48,54,43,48,41,226,35,46,46,226,20,39,47,49,54,39,7,56,39,48,54,53,226,43,48,226,48,43,46,252},62))
for _,v in next, getnilinstances() do
if v:IsA(_d({20,39,47,49,54,39,7,56,39,48,54},62)) then
print(_d({226,239,226,16,35,47,39,252},62), v.Name)
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
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,41,35,47,39,226,55,48,43,56,39,52,53,39,227,226,21,37,52,43,50,54,226,43,53,226,49,48,46,59,226,40,49,52,226,9,18,17,240},62))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,21,37,52,43,50,54,226,39,58,39,37,55,54,43,49,48,226,36,46,49,37,45,39,38,226,49,48,252,226},62) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,22,39,46,39,50,49,52,54,43,48,41,226,54,49,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,240,240,240,226,18,46,39,35,53,39,226,57,35,43,54,240},62))
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,18,52,43,56,35,54,39,21,39,52,56,39,52,5,49,38,39,226,43,53,226,48,49,54,226,53,39,54,240,226,5,35,48,48,49,54,226,35,55,54,49,239,44,49,43,48,240},62))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,41,35,47,39,226,55,48,43,56,39,52,53,39,227,226,21,37,52,43,50,54,226,43,53,226,49,48,46,59,226,40,49,52,226,9,18,17,240},62))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,27,49,55,226,35,52,39,226,49,48,226,54,42,39,226,10,49,47,39,53,37,52,39,39,48,240,226,21,37,52,43,50,54,226,52,39,51,55,43,52,39,53,226,231,53,240},62), name or _d({35,226,53,50,39,37,43,40,43,37,226,50,46,35,37,39},62)))
if Safeguard.JoinPrivateServer() then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,22,39,46,39,50,49,52,54,43,48,41,226,54,49,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,240,240,240,226,18,46,39,35,53,39,226,57,35,43,54,240},62))
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,18,52,43,56,35,54,39,21,39,52,56,39,52,5,49,38,39,226,43,53,226,48,49,54,226,53,39,54,240,226,5,35,48,48,49,54,226,35,55,54,49,239,44,49,43,48,240},62))
end
return false
end
warn(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,50,46,35,37,39,227,226,20,39,51,55,43,52,39,38,252,226,231,53,226,234,231,38,235,238,226,5,55,52,52,39,48,54,252,226,231,38},62), name or _d({23,48,45,48,49,57,48},62), placeId, game.PlaceId))
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
Vector3.new(1836.00,   4.1, -12190.00),
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
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({242,243,239,41,50,49,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62), _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,46,55,35,55,239,37,49,38,39,241,47,35,43,48,241,242,243,33,53,37,52,43,50,54,241,46,43,36,241,39,35,53,59,33,54,52,35,56,39,46,240,46,55,35},62))
if not EasyTravel then warn(_d({29,8,43,53,42,47,35,48,226,15,35,60,39,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,7,35,53,59,22,52,35,56,39,46,227},62)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({29,8,43,53,42,47,35,48,226,15,35,60,39,31,226,21,54,35,52,54,43,48,41,226,7,35,53,59,22,52,35,56,39,46,239,36,35,53,39,38,226,47,35,60,39,226,54,52,35,56,39,52,53,35,46,240,240,240},62))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({4,35,53,39,18,35,52,54},62)) then
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
if isRunning and not isRunning() then break end
RunService.Heartbeat:Wait()
end
if isRunning and not isRunning() then break end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({29,8,43,53,42,47,35,48,226,15,35,60,39,31,226,5,49,47,50,46,39,54,39,240},62))
end
return FishmanMaze
end)()