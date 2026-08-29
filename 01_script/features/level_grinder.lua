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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({21,42,49,46},59))
if not (peliValueObj and peliValueObj:IsA(_d({27,38,49,58,42,7,38,56,42},59))) then
local nested = statsFolder:FindFirstChild(_d({24,57,38,57,56},59))
peliValueObj = nested and nested:FindFirstChild(_d({21,42,49,46},59))
end
levelValueObj = statsFolder:FindFirstChild(_d({17,42,59,42,49},59))
if not (levelValueObj and levelValueObj:IsA(_d({27,38,49,58,42,7,38,56,42},59))) then
local nested = statsFolder:FindFirstChild(_d({24,57,38,57,56},59))
levelValueObj = nested and nested:FindFirstChild(_d({17,42,59,42,49},59))
end
staminaValueObj = statsFolder:FindFirstChild(_d({24,57,38,50,46,51,38},59))
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
local hum = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41},59))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
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
print("[" .. tostring(name) .. _d({34,229,24,57,38,51,41,38,49,52,51,42,229,18,52,41,42,255,229,21,55,42,56,56,229,236},59) .. toggleKey.Name .. _d({236,229,57,52,229,57,52,44,44,49,42,243},59))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({15,48,247,15,16,25,6,16,8,43},59),
TeleportLocation = _d({246,56,57,24,42,38},59)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({11,46,55,56,57,229,24,42,38,229,13,52,50,42,56,40,55,42,42,51,229,244,229,18,38,46,51,229,18,42,51,58},59),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({56,57,55,46,51,44},59) and code ~= "" then
print(string.format(_d({32,24,38,43,42,44,58,38,55,41,34,229,15,52,46,51,46,51,44,229,21,55,46,59,38,57,42,229,24,42,55,59,42,55,229,236,234,56,236,243,243,243},59), code))
task.spawn(function()
local rs = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local reservedRemote = rs:WaitForChild(_d({10,59,42,51,57,56},59)):WaitForChild(_d({55,42,56,42,55,59,42,41},59))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({23,42,50,52,57,42,10,59,42,51,57},59)) and (v.Name == _d({23,42,50,52,57,42,10,59,42,51,57},59) or v.Name == _d({57,42,49,42},59) or v.Name == _d({25,42,49,42,53,52,55,57},59)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,46,55,46,51,44,229,57,42,49,42,53,52,55,57,229,55,42,50,52,57,42,255,229},59) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,8,52,58,49,41,229,51,52,57,229,43,46,51,41,229,23,42,50,52,57,42,10,59,42,51,57,229,46,51,229,51,46,49,243,229,21,55,46,51,57,46,51,44,229,38,49,49,229,23,42,50,52,57,42,10,59,42,51,57,56,229,46,51,229,51,46,49,255},59))
for _,v in next, getnilinstances() do
if v:IsA(_d({23,42,50,52,57,42,10,59,42,51,57},59)) then
print(_d({229,242,229,19,38,50,42,255},59), v.Name)
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
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,28,55,52,51,44,229,44,38,50,42,229,58,51,46,59,42,55,56,42,230,229,24,40,55,46,53,57,229,46,56,229,52,51,49,62,229,43,52,55,229,12,21,20,243},59))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,24,40,55,46,53,57,229,42,61,42,40,58,57,46,52,51,229,39,49,52,40,48,42,41,229,52,51,255,229},59) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({32,24,38,43,42,44,58,38,55,41,34,229,25,42,49,42,53,52,55,57,46,51,44,229,57,52,229,21,55,46,59,38,57,42,229,24,42,55,59,42,55,243,243,243,229,21,49,42,38,56,42,229,60,38,46,57,243},59))
else
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,21,55,46,59,38,57,42,24,42,55,59,42,55,8,52,41,42,229,46,56,229,51,52,57,229,56,42,57,243,229,8,38,51,51,52,57,229,38,58,57,52,242,47,52,46,51,243},59))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,28,55,52,51,44,229,44,38,50,42,229,58,51,46,59,42,55,56,42,230,229,24,40,55,46,53,57,229,46,56,229,52,51,49,62,229,43,52,55,229,12,21,20,243},59))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({32,24,38,43,42,44,58,38,55,41,34,229,30,52,58,229,38,55,42,229,52,51,229,57,45,42,229,13,52,50,42,56,40,55,42,42,51,243,229,24,40,55,46,53,57,229,55,42,54,58,46,55,42,56,229,234,56,243},59), name or _d({38,229,56,53,42,40,46,43,46,40,229,53,49,38,40,42},59)))
if Safeguard.JoinPrivateServer() then
print(_d({32,24,38,43,42,44,58,38,55,41,34,229,25,42,49,42,53,52,55,57,46,51,44,229,57,52,229,21,55,46,59,38,57,42,229,24,42,55,59,42,55,243,243,243,229,21,49,42,38,56,42,229,60,38,46,57,243},59))
else
warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,21,55,46,59,38,57,42,24,42,55,59,42,55,8,52,41,42,229,46,56,229,51,52,57,229,56,42,57,243,229,8,38,51,51,52,57,229,38,58,57,52,242,47,52,46,51,243},59))
end
return false
end
warn(string.format(_d({32,24,38,43,42,44,58,38,55,41,34,229,28,55,52,51,44,229,53,49,38,40,42,230,229,23,42,54,58,46,55,42,41,255,229,234,56,229,237,234,41,238,241,229,8,58,55,55,42,51,57,255,229,234,41},59), name or _d({26,51,48,51,52,60,51},59), placeId, game.PlaceId))
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
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,24,57,52,53,53,42,41,243},59))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,6,49,55,42,38,41,62,229,55,58,51,51,46,51,44,230},59)); return end
if not Safeguard then warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
if not Safeguard.RequirePlace(3978370137, _d({11,46,55,56,57,229,24,42,38},59)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59), 10)
local hum = char:WaitForChild(_d({13,58,50,38,51,52,46,41},59), 10)
local stats = ReplicatedStorage:WaitForChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({21,42,49,46},59), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59)) or (char and char:FindFirstChild(_d({23,46,43,49,42},59)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,8,58,55,55,42,51,57,229,21,42,49,46,229,40,45,42,40,48,255},59), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,19,52,57,229,38,57,229,25,52,60,51,229,52,43,229,7,42,44,46,51,51,46,51,44,56,243,229,21,49,42,38,56,42,229,57,55,38,59,42,49,229,57,45,42,55,42,229,57,52,229,43,38,55,50,229,40,45,42,56,57,56,229,60,45,46,49,42,229,60,38,46,57,46,51,44,229,43,52,55,229,23,46,43,49,42,243},59))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,40,45,42,56,57,36,43,38,55,50,42,55,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,45,42,56,57,36,43,38,55,50,42,55,243,49,58,38},59))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,38,55,50,46,51,44,229,40,45,42,56,57,56,229,58,51,57,46,49,229,248,245,245,229,21,42,49,46,243,243,243,229,237,8,58,55,55,42,51,57,255,229},59) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({21,42,49,46},59))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59)) or (c and c:FindFirstChild(_d({23,46,43,49,42},59))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({7,58,62,38,39,49,42,14,57,42,50,56},59))
local shopItem = buyables and buyables:FindFirstChild(_d({23,46,43,49,42},59))
local shopPart = shopItem and shopItem:FindFirstChild(_d({24,45,52,53,21,38,55,57},59))
if EasyTravel and shopPart and hrp then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,25,55,38,59,42,49,46,51,44,229,57,52,229,23,46,43,49,42,229,56,45,52,53,229,59,46,38,229,10,38,56,62,25,55,38,59,42,49,243,243,243},59))
local nocollide = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({10,59,42,51,57,56},59)) and ReplicatedStorage.Events:FindFirstChild(_d({24,45,52,53},59))
if shopEvent and shopEvent:IsA(_d({23,42,50,52,57,42,11,58,51,40,57,46,52,51},59)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,10,54,58,46,53,53,46,51,44,229,23,46,43,49,42,243,243,243},59))
local args = {
[1] = _d({42,54,58,46,53},59),
[2] = _d({23,46,43,49,42},59)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({10,59,42,51,57,56},59)) and ReplicatedStorage.Events:FindFirstChild(_d({25,52,52,49,56},59))
if toolsEvent and toolsEvent:IsA(_d({23,42,50,52,57,42,11,58,51,40,57,46,52,51},59)) then
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
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41},59))
local hrp = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,49,62,46,51,44,229,57,52,229,11,46,56,45,50,38,51,229,8,38,59,42,243,243,243},59))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,10,56,40,38,53,46,51,44,229,56,45,52,53,229,46,51,57,42,55,46,52,55,229,39,62,229,43,49,62,46,51,44,229,56,57,55,38,46,44,45,57,229,58,53,243,243,243},59))
local nocollide = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then break end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700 and distPos.X <= 1973 and distPos.Z >= -12403 and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,49,62,46,51,44,229,57,52,229,11,46,56,45,50,38,51,229,8,38,59,42,243,243,243},59))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,43,46,56,45,50,38,51,36,50,38,63,42,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,43,46,56,45,50,38,51,36,50,38,63,42,243,49,58,38},59))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,38,46,49,42,41,229,57,52,229,46,50,53,52,55,57,229,11,46,56,45,50,38,51,18,38,63,42,229,49,46,39,55,38,55,62,230},59))
end
else
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,20,58,57,56,46,41,42,229,11,46,56,45,50,38,51,229,8,38,59,42,229,39,52,58,51,41,56,241,229,56,48,46,53,53,46,51,44,229,50,38,63,42,243},59))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({17,42,59,42,49,229,12,55,46,51,41,42,55},59),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()