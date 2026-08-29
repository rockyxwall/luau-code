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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local LocalPlayer = Players.LocalPlayer
local OpenChests = {
Running = false,
Connections = {}
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
return position.X >= ISLAND_MIN_X and position.X <= ISLAND_MAX_X
and position.Z >= ISLAND_MIN_Z and position.Z <= ISLAND_MAX_Z
end
local function collectChests()
local chests = {}
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA(_d({44,78,75,84,69,73,69,80,85,44,78,75,73,76,80},36)) then
local action = v.ActionText or ""
if action:find(_d({44,65,72,69,252,31,68,65,79,80},36)) then
local part = v.Parent
if part and part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({4,1,10,12,66,8,252,1,10,12,66,8,252,1,10,12,66,5},36), part.Position.X, part.Position.Y, part.Position.Z)
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
if r then return r end
task.wait(0.1)
t = t + 0.1
end
return nil
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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({44,65,72,69},36))
if not (peliValueObj and peliValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
peliValueObj = nested and nested:FindFirstChild(_d({44,65,72,69},36))
end
levelValueObj = statsFolder:FindFirstChild(_d({40,65,82,65,72},36))
if not (levelValueObj and levelValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
levelValueObj = nested and nested:FindFirstChild(_d({40,65,82,65,72},36))
end
staminaValueObj = statsFolder:FindFirstChild(_d({47,80,61,73,69,74,61},36))
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
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
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
print("[" .. tostring(name) .. _d({57,252,47,80,61,74,64,61,72,75,74,65,252,41,75,64,65,22,252,44,78,65,79,79,252,3},36) .. toggleKey.Name .. _d({3,252,80,75,252,80,75,67,67,72,65,10},36))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
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
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,79,61,66,65,67,81,61,78,64,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,79,61,66,65,67,81,61,78,64,10,72,81,61},36))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,75,78,65,10,72,81,61},36)))()
end)
end
if not Core then warn(_d({55,31,75,78,65,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
local Safeguard = Core.GetSafeguard()
function OpenChests.Stop()
OpenChests.Running = false
for _, conn in ipairs(OpenChests.Connections) do conn:Disconnect() end
OpenChests.Connections = {}
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,47,80,75,76,76,65,64,10},36))
end
function OpenChests.Start()
if OpenChests.Running then warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253},36)); return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.IsSafe() then return end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,34,75,81,74,64,252,1,64,252,44,65,72,69,252,31,68,65,79,80,79,252,80,75,80,61,72,252,69,74,252,83,75,78,71,79,76,61,63,65,10},36), #allChests))
if #allChests == 0 then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,42,75,252,63,68,65,79,80,79,252,66,75,81,74,64,252,190,92,112,252,61,78,65,252,85,75,81,252,69,74,252,80,68,65,252,78,69,67,68,80,252,61,78,65,61,27},36))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,63,68,61,78,61,63,80,65,78,252,78,75,75,80,253,252,29,62,75,78,80,69,74,67,10},36))
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
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,1,64,252,63,68,65,79,80,79,252,77,81,65,81,65,64,252,88,252,1,64,252,75,81,80,79,69,64,65,252,69,79,72,61,74,64,252,88,252,1,64,252,80,75,75,252,68,69,67,68,10},36), #chests, skippedIsland, skippedY))
if #chests == 0 then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,42,75,252,78,65,61,63,68,61,62,72,65,252,63,68,65,79,80,79,252,61,66,80,65,78,252,66,69,72,80,65,78,69,74,67,10},36))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
if not EasyTravel then
error(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
end
EasyTravel.Start()
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,33,61,79,85,252,48,78,61,82,65,72,252,79,80,61,78,80,65,64,10},36))
for i, chest in ipairs(chests) do
if not OpenChests.Running then break end
print(string.format(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,55,1,64,11,1,64,57,252,48,78,61,82,65,72,72,69,74,67,252,80,75,252,63,68,65,79,80,252,61,80,252,1,79},36), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,40,75,79,80,252,63,68,61,78,61,63,80,65,78,252,190,92,112,252,76,61,81,79,69,74,67,10},36))
task.wait(1)
root = waitForRoot(5)
if not root then break end
end
local dist = (root.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then break end
end
if not OpenChests.Running then break end
local currentRoot = Core.GetRoot(LocalPlayer)
if currentRoot then EasyTravel.TargetPosition = currentRoot.Position end
if chest.prompt and chest.prompt.Parent then
local ok, err = pcall(function() fireproximityprompt(chest.prompt) end)
if not ok then
pcall(function() chest.prompt.Triggered:Fire(LocalPlayer) end)
end
end
task.wait(OPEN_WAIT)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
if OpenChests.Running then
print(_d({55,43,76,65,74,31,68,65,79,80,79,57,252,29,72,72,252,63,68,65,79,80,79,252,76,78,75,63,65,79,79,65,64,253},36))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(
OpenChests,
_d({43,76,65,74,31,68,65,79,80,79},36),
OpenChests.Start,
OpenChests.Stop,
function() return OpenChests.Running end
)
return OpenChests
end)()