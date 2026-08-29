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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({16,37,44,41},64))
if not (peliValueObj and peliValueObj:IsA(_d({22,33,44,53,37,2,33,51,37},64))) then
local nested = statsFolder:FindFirstChild(_d({19,52,33,52,51},64))
peliValueObj = nested and nested:FindFirstChild(_d({16,37,44,41},64))
end
levelValueObj = statsFolder:FindFirstChild(_d({12,37,54,37,44},64))
if not (levelValueObj and levelValueObj:IsA(_d({22,33,44,53,37,2,33,51,37},64))) then
local nested = statsFolder:FindFirstChild(_d({19,52,33,52,51},64))
levelValueObj = nested and nested:FindFirstChild(_d({12,37,54,37,44},64))
end
staminaValueObj = statsFolder:FindFirstChild(_d({19,52,33,45,41,46,33},64))
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
local hum = char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36},64))
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
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
print("[" .. tostring(name) .. _d({29,224,19,52,33,46,36,33,44,47,46,37,224,13,47,36,37,250,224,16,50,37,51,51,224,231},64) .. toggleKey.Name .. _d({231,224,52,47,224,52,47,39,39,44,37,238},64))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({10,43,242,10,11,20,1,11,3,38},64),
TeleportLocation = _d({241,51,52,19,37,33},64),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({6,41,50,51,52,224,19,37,33,224,8,47,45,37,51,35,50,37,37,46,224,239,224,13,33,41,46,224,13,37,46,53},64),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({51,52,50,41,46,39},64) and code ~= "" then
print(string.format(_d({27,19,33,38,37,39,53,33,50,36,29,224,10,47,41,46,41,46,39,224,16,50,41,54,33,52,37,224,19,37,50,54,37,50,224,231,229,51,231,238,238,238},64), code))
task.spawn(function()
local rs = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local reservedRemote = rs:WaitForChild(_d({5,54,37,46,52,51},64)):WaitForChild(_d({50,37,51,37,50,54,37,36},64))
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
v:IsA(_d({18,37,45,47,52,37,5,54,37,46,52},64)) and (v.Name == _d({18,37,45,47,52,37,5,54,37,46,52},64) or v.Name == _d({52,37,44,37},64) or v.Name == _d({20,37,44,37,48,47,50,52},64))
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
print(_d({27,19,33,38,37,39,53,33,50,36,29,224,6,41,50,41,46,39,224,52,37,44,37,48,47,50,52,224,50,37,45,47,52,37,250,224},64) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,3,47,53,44,36,224,46,47,52,224,38,41,46,36,224,18,37,45,47,52,37,5,54,37,46,52,224,41,46,224,46,41,44,238,224,16,50,41,46,52,41,46,39,224,33,44,44,224,18,37,45,47,52,37,5,54,37,46,52,51,224,41,46,224,46,41,44,250},64))
for _, v in next, getnilinstances() do
if v:IsA(_d({18,37,45,47,52,37,5,54,37,46,52},64)) then
print(_d({224,237,224,14,33,45,37,250},64), v.Name)
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
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,23,50,47,46,39,224,39,33,45,37,224,53,46,41,54,37,50,51,37,225,224,19,35,50,41,48,52,224,41,51,224,47,46,44,57,224,38,47,50,224,7,16,15,238},64))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,19,35,50,41,48,52,224,37,56,37,35,53,52,41,47,46,224,34,44,47,35,43,37,36,224,47,46,250,224},64) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({27,19,33,38,37,39,53,33,50,36,29,224,20,37,44,37,48,47,50,52,41,46,39,224,52,47,224,16,50,41,54,33,52,37,224,19,37,50,54,37,50,238,238,238,224,16,44,37,33,51,37,224,55,33,41,52,238},64))
else
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,16,50,41,54,33,52,37,19,37,50,54,37,50,3,47,36,37,224,41,51,224,46,47,52,224,51,37,52,238,224,3,33,46,46,47,52,224,33,53,52,47,237,42,47,41,46,238},64))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,23,50,47,46,39,224,39,33,45,37,224,53,46,41,54,37,50,51,37,225,224,19,35,50,41,48,52,224,41,51,224,47,46,44,57,224,38,47,50,224,7,16,15,238},64))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({27,19,33,38,37,39,53,33,50,36,29,224,25,47,53,224,33,50,37,224,47,46,224,52,40,37,224,8,47,45,37,51,35,50,37,37,46,238,224,19,35,50,41,48,52,224,50,37,49,53,41,50,37,51,224,229,51,238},64), name or _d({33,224,51,48,37,35,41,38,41,35,224,48,44,33,35,37},64)))
if Safeguard.JoinPrivateServer() then
print(_d({27,19,33,38,37,39,53,33,50,36,29,224,20,37,44,37,48,47,50,52,41,46,39,224,52,47,224,16,50,41,54,33,52,37,224,19,37,50,54,37,50,238,238,238,224,16,44,37,33,51,37,224,55,33,41,52,238},64))
else
warn(_d({27,19,33,38,37,39,53,33,50,36,29,224,16,50,41,54,33,52,37,19,37,50,54,37,50,3,47,36,37,224,41,51,224,46,47,52,224,51,37,52,238,224,3,33,46,46,47,52,224,33,53,52,47,237,42,47,41,46,238},64))
end
return false
end
warn(
string.format(
_d({27,19,33,38,37,39,53,33,50,36,29,224,23,50,47,46,39,224,48,44,33,35,37,225,224,18,37,49,53,41,50,37,36,250,224,229,51,224,232,229,36,233,236,224,3,53,50,50,37,46,52,250,224,229,36},64),
name or _d({21,46,43,46,47,55,46},64),
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