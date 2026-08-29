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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local LocalPlayer = Players.LocalPlayer
local ChestFarmer = {
Running = false,
Connections = {}
}
local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({48,69,76,73},32))
if not (peliValueObj and peliValueObj:IsA(_d({54,65,76,85,69,34,65,83,69},32))) then
local nested = statsFolder:FindFirstChild(_d({51,84,65,84,83},32))
peliValueObj = nested and nested:FindFirstChild(_d({48,69,76,73},32))
end
levelValueObj = statsFolder:FindFirstChild(_d({44,69,86,69,76},32))
if not (levelValueObj and levelValueObj:IsA(_d({54,65,76,85,69,34,65,83,69},32))) then
local nested = statsFolder:FindFirstChild(_d({51,84,65,84,83},32))
levelValueObj = nested and nested:FindFirstChild(_d({44,69,86,69,76},32))
end
staminaValueObj = statsFolder:FindFirstChild(_d({51,84,65,77,73,78,65},32))
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
local hum = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68},32))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
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
print("[" .. tostring(name) .. _d({61,0,51,84,65,78,68,65,76,79,78,69,0,45,79,68,69,26,0,48,82,69,83,83,0,7},32) .. toggleKey.Name .. _d({7,0,84,79,0,84,79,71,71,76,69,14},32))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({42,75,18,42,43,52,33,43,35,70},32),
TeleportLocation = _d({17,83,84,51,69,65},32)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({38,73,82,83,84,0,51,69,65,0,40,79,77,69,83,67,82,69,69,78,0,15,0,45,65,73,78,0,45,69,78,85},32),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({83,84,82,73,78,71},32) and code ~= "" then
print(string.format(_d({59,51,65,70,69,71,85,65,82,68,61,0,42,79,73,78,73,78,71,0,48,82,73,86,65,84,69,0,51,69,82,86,69,82,0,7,5,83,7,14,14,14},32), code))
task.spawn(function()
local rs = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local reservedRemote = rs:WaitForChild(_d({37,86,69,78,84,83},32)):WaitForChild(_d({82,69,83,69,82,86,69,68},32))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({50,69,77,79,84,69,37,86,69,78,84},32)) and (v.Name == _d({50,69,77,79,84,69,37,86,69,78,84},32) or v.Name == _d({84,69,76,69},32) or v.Name == _d({52,69,76,69,80,79,82,84},32)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,73,82,73,78,71,0,84,69,76,69,80,79,82,84,0,82,69,77,79,84,69,26,0},32) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,35,79,85,76,68,0,78,79,84,0,70,73,78,68,0,50,69,77,79,84,69,37,86,69,78,84,0,73,78,0,78,73,76,14,0,48,82,73,78,84,73,78,71,0,65,76,76,0,50,69,77,79,84,69,37,86,69,78,84,83,0,73,78,0,78,73,76,26},32))
for _,v in next, getnilinstances() do
if v:IsA(_d({50,69,77,79,84,69,37,86,69,78,84},32)) then
print(_d({0,13,0,46,65,77,69,26},32), v.Name)
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
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,55,82,79,78,71,0,71,65,77,69,0,85,78,73,86,69,82,83,69,1,0,51,67,82,73,80,84,0,73,83,0,79,78,76,89,0,70,79,82,0,39,48,47,14},32))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,51,67,82,73,80,84,0,69,88,69,67,85,84,73,79,78,0,66,76,79,67,75,69,68,0,79,78,26,0},32) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({59,51,65,70,69,71,85,65,82,68,61,0,52,69,76,69,80,79,82,84,73,78,71,0,84,79,0,48,82,73,86,65,84,69,0,51,69,82,86,69,82,14,14,14,0,48,76,69,65,83,69,0,87,65,73,84,14},32))
else
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,48,82,73,86,65,84,69,51,69,82,86,69,82,35,79,68,69,0,73,83,0,78,79,84,0,83,69,84,14,0,35,65,78,78,79,84,0,65,85,84,79,13,74,79,73,78,14},32))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,55,82,79,78,71,0,71,65,77,69,0,85,78,73,86,69,82,83,69,1,0,51,67,82,73,80,84,0,73,83,0,79,78,76,89,0,70,79,82,0,39,48,47,14},32))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({59,51,65,70,69,71,85,65,82,68,61,0,57,79,85,0,65,82,69,0,79,78,0,84,72,69,0,40,79,77,69,83,67,82,69,69,78,14,0,51,67,82,73,80,84,0,82,69,81,85,73,82,69,83,0,5,83,14},32), name or _d({65,0,83,80,69,67,73,70,73,67,0,80,76,65,67,69},32)))
if Safeguard.JoinPrivateServer() then
print(_d({59,51,65,70,69,71,85,65,82,68,61,0,52,69,76,69,80,79,82,84,73,78,71,0,84,79,0,48,82,73,86,65,84,69,0,51,69,82,86,69,82,14,14,14,0,48,76,69,65,83,69,0,87,65,73,84,14},32))
else
warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,48,82,73,86,65,84,69,51,69,82,86,69,82,35,79,68,69,0,73,83,0,78,79,84,0,83,69,84,14,0,35,65,78,78,79,84,0,65,85,84,79,13,74,79,73,78,14},32))
end
return false
end
warn(string.format(_d({59,51,65,70,69,71,85,65,82,68,61,0,55,82,79,78,71,0,80,76,65,67,69,1,0,50,69,81,85,73,82,69,68,26,0,5,83,0,8,5,68,9,12,0,35,85,82,82,69,78,84,26,0,5,68},32), name or _d({53,78,75,78,79,87,78},32), placeId, game.PlaceId))
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
local env = workspace:FindFirstChild(_d({37,78,86},32)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({48,82,79,88,73,77,73,84,89,48,82,79,77,80,84},32)) then
local action = v.ActionText or ""
if action:find(_d({48,69,76,73,0,35,72,69,83,84},32)) then
local part = v.Parent
if part and part:IsA(_d({34,65,83,69,48,65,82,84},32)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({8,5,14,16,70,12,0,5,14,16,70,12,0,5,14,16,70,9},32), part.Position.X, part.Position.Y, part.Position.Z)
})
end
end
end
end
return chests
end
function ChestFarmer.Stop()
ChestFarmer.Running = false
for _, conn in ipairs(ChestFarmer.Connections) do conn:Disconnect() end
ChestFarmer.Connections = {}
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,51,84,79,80,80,69,68,14},32))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,51,84,65,82,84,69,68,0,67,72,69,83,84,0,70,65,82,77,14,0,52,65,82,71,69,84,0,48,69,76,73,26,0},32) .. tostring(targetPeli))
local EasyTravel = Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32))
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({59,35,72,69,83,84,38,65,82,77,69,82,61,0,46,79,0,67,72,69,83,84,83,0,70,79,85,78,68,14,0,55,65,73,84,73,78,71,0,18,16,0,83,69,67,79,78,68,83,0,70,79,82,0,83,80,65,87,78,14,14,14},32))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then return true end
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
if not isRunningCallback() or getPeliCallback() >= targetPeli then break end
if EasyTravel then
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not EasyTravel.Enabled then pcall(EasyTravel.Start) end
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
if myRoot then EasyTravel.TargetPosition = myRoot.Position end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then task.wait(holdTime + 0.1) end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function() chest.prompt.Triggered:Fire(LocalPlayer) end)
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
if ChestFarmer.Running then return end
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.IsSafe() then return end
ChestFarmer.Running = true
task.spawn(function()
ChestFarmer.FarmUntilPeli(
9999999,
function() return 0 end,
function() return ChestFarmer.Running end
)
end)
end
Core.SetupStandalone(
ChestFarmer,
_d({35,72,69,83,84,38,65,82,77,69,82},32),
ChestFarmer.Start,
ChestFarmer.Stop,
function() return ChestFarmer.Running end
)
return ChestFarmer
end)()