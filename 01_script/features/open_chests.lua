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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
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
if v:IsA(_d({62,96,93,102,87,91,87,98,103,62,96,93,91,94,98},18)) then
local action = v.ActionText or ""
if action:find(_d({62,83,90,87,14,49,86,83,97,98},18)) then
local part = v.Parent
if part and part:IsA(_d({48,79,97,83,62,79,96,98},18)) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({22,19,28,30,84,26,14,19,28,30,84,26,14,19,28,30,84,23},18), part.Position.X, part.Position.Y, part.Position.Z),
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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({62,83,90,87},18))
if not (peliValueObj and peliValueObj:IsA(_d({68,79,90,99,83,48,79,97,83},18))) then
local nested = statsFolder:FindFirstChild(_d({65,98,79,98,97},18))
peliValueObj = nested and nested:FindFirstChild(_d({62,83,90,87},18))
end
levelValueObj = statsFolder:FindFirstChild(_d({58,83,100,83,90},18))
if not (levelValueObj and levelValueObj:IsA(_d({68,79,90,99,83,48,79,97,83},18))) then
local nested = statsFolder:FindFirstChild(_d({65,98,79,98,97},18))
levelValueObj = nested and nested:FindFirstChild(_d({58,83,100,83,90},18))
end
staminaValueObj = statsFolder:FindFirstChild(_d({65,98,79,91,87,92,79},18))
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
local hum = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82},18))
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
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
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
print("[" .. tostring(name) .. _d({75,14,65,98,79,92,82,79,90,93,92,83,14,59,93,82,83,40,14,62,96,83,97,97,14,21},18) .. toggleKey.Name .. _d({21,14,98,93,14,98,93,85,85,90,83,28},18))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({56,89,32,56,57,66,47,57,49,84},18),
TeleportLocation = _d({31,97,98,65,83,79},18),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({52,87,96,97,98,14,65,83,79,14,54,93,91,83,97,81,96,83,83,92,14,29,14,59,79,87,92,14,59,83,92,99},18),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({97,98,96,87,92,85},18) and code ~= "" then
print(string.format(_d({73,65,79,84,83,85,99,79,96,82,75,14,56,93,87,92,87,92,85,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,14,21,19,97,21,28,28,28},18), code))
task.spawn(function()
local rs = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local reservedRemote = rs:WaitForChild(_d({51,100,83,92,98,97},18)):WaitForChild(_d({96,83,97,83,96,100,83,82},18))
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
v:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) and (v.Name == _d({64,83,91,93,98,83,51,100,83,92,98},18) or v.Name == _d({98,83,90,83},18) or v.Name == _d({66,83,90,83,94,93,96,98},18))
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
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,52,87,96,87,92,85,14,98,83,90,83,94,93,96,98,14,96,83,91,93,98,83,40,14},18) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,64,83,91,93,98,83,51,100,83,92,98,14,87,92,14,92,87,90,28,14,62,96,87,92,98,87,92,85,14,79,90,90,14,64,83,91,93,98,83,51,100,83,92,98,97,14,87,92,14,92,87,90,40},18))
for _, v in next, getnilinstances() do
if v:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) then
print(_d({14,27,14,60,79,91,83,40},18), v.Name)
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
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,85,79,91,83,14,99,92,87,100,83,96,97,83,15,14,65,81,96,87,94,98,14,87,97,14,93,92,90,103,14,84,93,96,14,53,62,61,28},18))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,65,81,96,87,94,98,14,83,102,83,81,99,98,87,93,92,14,80,90,93,81,89,83,82,14,93,92,40,14},18) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,66,83,90,83,94,93,96,98,87,92,85,14,98,93,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,28,28,28,14,62,90,83,79,97,83,14,101,79,87,98,28},18))
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,62,96,87,100,79,98,83,65,83,96,100,83,96,49,93,82,83,14,87,97,14,92,93,98,14,97,83,98,28,14,49,79,92,92,93,98,14,79,99,98,93,27,88,93,87,92,28},18))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,85,79,91,83,14,99,92,87,100,83,96,97,83,15,14,65,81,96,87,94,98,14,87,97,14,93,92,90,103,14,84,93,96,14,53,62,61,28},18))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({73,65,79,84,83,85,99,79,96,82,75,14,71,93,99,14,79,96,83,14,93,92,14,98,86,83,14,54,93,91,83,97,81,96,83,83,92,28,14,65,81,96,87,94,98,14,96,83,95,99,87,96,83,97,14,19,97,28},18), name or _d({79,14,97,94,83,81,87,84,87,81,14,94,90,79,81,83},18)))
if Safeguard.JoinPrivateServer() then
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,66,83,90,83,94,93,96,98,87,92,85,14,98,93,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,28,28,28,14,62,90,83,79,97,83,14,101,79,87,98,28},18))
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,62,96,87,100,79,98,83,65,83,96,100,83,96,49,93,82,83,14,87,97,14,92,93,98,14,97,83,98,28,14,49,79,92,92,93,98,14,79,99,98,93,27,88,93,87,92,28},18))
end
return false
end
warn(
string.format(
_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,94,90,79,81,83,15,14,64,83,95,99,87,96,83,82,40,14,19,97,14,22,19,82,23,26,14,49,99,96,96,83,92,98,40,14,19,82},18),
name or _d({67,92,89,92,93,101,92},18),
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
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,65,98,93,94,94,83,82,28},18))
end
function OpenChests.Start()
if OpenChests.Running then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,47,90,96,83,79,82,103,14,96,99,92,92,87,92,85,15},18))
return
end
if not Safeguard then
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,15},18))
return
end
if not Safeguard.IsSafe() then
return
end
OpenChests.Running = true
task.spawn(function()
local allChests = collectChests()
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,52,93,99,92,82,14,19,82,14,62,83,90,87,14,49,86,83,97,98,97,14,98,93,98,79,90,14,87,92,14,101,93,96,89,97,94,79,81,83,28},18), #allChests))
if #allChests == 0 then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,60,93,14,81,86,83,97,98,97,14,84,93,99,92,82,14,208,110,130,14,79,96,83,14,103,93,99,14,87,92,14,98,86,83,14,96,87,85,86,98,14,79,96,83,79,45},18))
OpenChests.Stop()
return
end
local startRoot = waitForRoot(5)
if not startRoot then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,81,86,79,96,79,81,98,83,96,14,96,93,93,98,15,14,47,80,93,96,98,87,92,85,28},18))
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
_d({73,61,94,83,92,49,86,83,97,98,97,75,14,19,82,14,81,86,83,97,98,97,14,95,99,83,99,83,82,14,106,14,19,82,14,93,99,98,97,87,82,83,14,87,97,90,79,92,82,14,106,14,19,82,14,98,93,93,14,86,87,85,86,28},18),
#chests,
skippedIsland,
skippedY
)
)
if #chests == 0 then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,60,93,14,96,83,79,81,86,79,80,90,83,14,81,86,83,97,98,97,14,79,84,98,83,96,14,84,87,90,98,83,96,87,92,85,28},18))
OpenChests.Stop()
return
end
local EasyTravel = Core.Import(
_d({30,31,27,85,94,93,29,90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18),
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,90,99,79,99,27,81,93,82,83,29,91,79,87,92,29,30,31,77,97,81,96,87,94,98,29,90,87,80,29,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18)
)
if not EasyTravel then
error(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,83,79,97,103,77,98,96,79,100,83,90,28,90,99,79},18))
end
EasyTravel.Start()
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,51,79,97,103,14,66,96,79,100,83,90,14,97,98,79,96,98,83,82,28},18))
for i, chest in ipairs(chests) do
if not OpenChests.Running then
break
end
print(string.format(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,73,19,82,29,19,82,75,14,66,96,79,100,83,90,90,87,92,85,14,98,93,14,81,86,83,97,98,14,79,98,14,19,97},18), i, #chests, chest.label))
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
local elapsed = 0
while OpenChests.Running and elapsed < TIMEOUT_PER_CHEST do
task.wait(CHECK_HZ)
elapsed = elapsed + CHECK_HZ
local root = Core.GetRoot(LocalPlayer)
if not root then
warn(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,58,93,97,98,14,81,86,79,96,79,81,98,83,96,14,208,110,130,14,94,79,99,97,87,92,85,28},18))
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
print(_d({73,61,94,83,92,49,86,83,97,98,97,75,14,47,90,90,14,81,86,83,97,98,97,14,94,96,93,81,83,97,97,83,82,15},18))
OpenChests.Stop()
end
end)
end
Core.SetupStandalone(OpenChests, _d({61,94,83,92,49,86,83,97,98,97},18), OpenChests.Start, OpenChests.Stop, function()
return OpenChests.Running
end)
return OpenChests
end)()