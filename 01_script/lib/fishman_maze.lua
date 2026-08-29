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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({43,64,71,68},37))
if not (peliValueObj and peliValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
peliValueObj = nested and nested:FindFirstChild(_d({43,64,71,68},37))
end
levelValueObj = statsFolder:FindFirstChild(_d({39,64,81,64,71},37))
if not (levelValueObj and levelValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
levelValueObj = nested and nested:FindFirstChild(_d({39,64,81,64,71},37))
end
staminaValueObj = statsFolder:FindFirstChild(_d({46,79,60,72,68,73,60},37))
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
local hum = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63},37))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
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
print("[" .. tostring(name) .. _d({56,251,46,79,60,73,63,60,71,74,73,64,251,40,74,63,64,21,251,43,77,64,78,78,251,2},37) .. toggleKey.Name .. _d({2,251,79,74,251,79,74,66,66,71,64,9},37))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({37,70,13,37,38,47,28,38,30,65},37),
TeleportLocation = _d({12,78,79,46,64,60},37)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({33,68,77,78,79,251,46,64,60,251,35,74,72,64,78,62,77,64,64,73,251,10,251,40,60,68,73,251,40,64,73,80},37),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({78,79,77,68,73,66},37) and code ~= "" then
print(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,37,74,68,73,68,73,66,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,251,2,0,78,2,9,9,9},37), code))
task.spawn(function()
local rs = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local reservedRemote = rs:WaitForChild(_d({32,81,64,73,79,78},37)):WaitForChild(_d({77,64,78,64,77,81,64,63},37))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) and (v.Name == _d({45,64,72,74,79,64,32,81,64,73,79},37) or v.Name == _d({79,64,71,64},37) or v.Name == _d({47,64,71,64,75,74,77,79},37)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,68,77,68,73,66,251,79,64,71,64,75,74,77,79,251,77,64,72,74,79,64,21,251},37) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,30,74,80,71,63,251,73,74,79,251,65,68,73,63,251,45,64,72,74,79,64,32,81,64,73,79,251,68,73,251,73,68,71,9,251,43,77,68,73,79,68,73,66,251,60,71,71,251,45,64,72,74,79,64,32,81,64,73,79,78,251,68,73,251,73,68,71,21},37))
for _,v in next, getnilinstances() do
if v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) then
print(_d({251,8,251,41,60,72,64,21},37), v.Name)
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
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,46,62,77,68,75,79,251,64,83,64,62,80,79,68,74,73,251,61,71,74,62,70,64,63,251,74,73,21,251},37) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,52,74,80,251,60,77,64,251,74,73,251,79,67,64,251,35,74,72,64,78,62,77,64,64,73,9,251,46,62,77,68,75,79,251,77,64,76,80,68,77,64,78,251,0,78,9},37), name or _d({60,251,78,75,64,62,68,65,68,62,251,75,71,60,62,64},37)))
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
warn(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,75,71,60,62,64,252,251,45,64,76,80,68,77,64,63,21,251,0,78,251,3,0,63,4,7,251,30,80,77,77,64,73,79,21,251,0,63},37), name or _d({48,73,70,73,74,82,73},37), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,78,60,65,64,66,80,60,77,63,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,78,60,65,64,66,80,60,77,63,9,71,80,60},37))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,62,74,77,64,9,71,80,60},37)))()
end)
end
if not Core then warn(_d({54,30,74,77,64,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37)); return end
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
local EasyTravel = Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
if not EasyTravel then warn(_d({54,33,68,78,67,72,60,73,251,40,60,85,64,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,32,60,78,84,47,77,60,81,64,71,252},37)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({54,33,68,78,67,72,60,73,251,40,60,85,64,56,251,46,79,60,77,79,68,73,66,251,32,60,78,84,47,77,60,81,64,71,8,61,60,78,64,63,251,72,60,85,64,251,79,77,60,81,64,77,78,60,71,9,9,9},37))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
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
print(_d({54,33,68,78,67,72,60,73,251,40,60,85,64,56,251,30,74,72,75,71,64,79,64,9},37))
end
return FishmanMaze
end)()