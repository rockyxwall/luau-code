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
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
TeleportLocation = _d({30,96,97,64,82,78},19)
}
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
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({63,82,90,92,97,82,50,99,82,91,97},19)) and (v.Name == _d({63,82,90,92,97,82,50,99,82,91,97},19) or v.Name == _d({97,82,89,82},19) or v.Name == _d({65,82,89,82,93,92,95,97},19)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,86,95,86,91,84,13,97,82,89,82,93,92,95,97,13,95,82,90,92,97,82,39,13},19) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,63,82,90,92,97,82,50,99,82,91,97,13,86,91,13,91,86,89,27,13,61,95,86,91,97,86,91,84,13,78,89,89,13,63,82,90,92,97,82,50,99,82,91,97,96,13,86,91,13,91,86,89,39},19))
for _,v in next, getnilinstances() do
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
warn(string.format(_d({72,64,78,83,82,84,98,78,95,81,74,13,68,95,92,91,84,13,93,89,78,80,82,14,13,63,82,94,98,86,95,82,81,39,13,18,96,13,21,18,81,22,25,13,48,98,95,95,82,91,97,39,13,18,81},19), name or _d({66,91,88,91,92,100,91},19), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,96,78,83,82,84,98,78,95,81,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,96,78,83,82,84,98,78,95,81,27,89,98,78},19))
end
return Core
end)()