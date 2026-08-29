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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({63,84,91,88},17))
if not (peliValueObj and peliValueObj:IsA(_d({69,80,91,100,84,49,80,98,84},17))) then
local nested = statsFolder:FindFirstChild(_d({66,99,80,99,98},17))
peliValueObj = nested and nested:FindFirstChild(_d({63,84,91,88},17))
end
levelValueObj = statsFolder:FindFirstChild(_d({59,84,101,84,91},17))
if not (levelValueObj and levelValueObj:IsA(_d({69,80,91,100,84,49,80,98,84},17))) then
local nested = statsFolder:FindFirstChild(_d({66,99,80,99,98},17))
levelValueObj = nested and nested:FindFirstChild(_d({59,84,101,84,91},17))
end
staminaValueObj = statsFolder:FindFirstChild(_d({66,99,80,92,88,93,80},17))
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
local hum = char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83},17))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
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
print("[" .. tostring(name) .. _d({76,15,66,99,80,93,83,80,91,94,93,84,15,60,94,83,84,41,15,63,97,84,98,98,15,22},17) .. toggleKey.Name .. _d({22,15,99,94,15,99,94,86,86,91,84,29},17))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({57,90,33,57,58,67,48,58,50,85},17),
TeleportLocation = _d({32,98,99,66,84,80},17)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({53,88,97,98,99,15,66,84,80,15,55,94,92,84,98,82,97,84,84,93,15,30,15,60,80,88,93,15,60,84,93,100},17),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({98,99,97,88,93,86},17) and code ~= "" then
print(string.format(_d({74,66,80,85,84,86,100,80,97,83,76,15,57,94,88,93,88,93,86,15,63,97,88,101,80,99,84,15,66,84,97,101,84,97,15,22,20,98,22,29,29,29},17), code))
task.spawn(function()
local rs = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local reservedRemote = rs:WaitForChild(_d({52,101,84,93,99,98},17)):WaitForChild(_d({97,84,98,84,97,101,84,83},17))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({65,84,92,94,99,84,52,101,84,93,99},17)) and (v.Name == _d({65,84,92,94,99,84,52,101,84,93,99},17) or v.Name == _d({99,84,91,84},17) or v.Name == _d({67,84,91,84,95,94,97,99},17)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({74,66,80,85,84,86,100,80,97,83,76,15,53,88,97,88,93,86,15,99,84,91,84,95,94,97,99,15,97,84,92,94,99,84,41,15},17) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,50,94,100,91,83,15,93,94,99,15,85,88,93,83,15,65,84,92,94,99,84,52,101,84,93,99,15,88,93,15,93,88,91,29,15,63,97,88,93,99,88,93,86,15,80,91,91,15,65,84,92,94,99,84,52,101,84,93,99,98,15,88,93,15,93,88,91,41},17))
for _,v in next, getnilinstances() do
if v:IsA(_d({65,84,92,94,99,84,52,101,84,93,99},17)) then
print(_d({15,28,15,61,80,92,84,41},17), v.Name)
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
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,70,97,94,93,86,15,86,80,92,84,15,100,93,88,101,84,97,98,84,16,15,66,82,97,88,95,99,15,88,98,15,94,93,91,104,15,85,94,97,15,54,63,62,29},17))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,66,82,97,88,95,99,15,84,103,84,82,100,99,88,94,93,15,81,91,94,82,90,84,83,15,94,93,41,15},17) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({74,66,80,85,84,86,100,80,97,83,76,15,67,84,91,84,95,94,97,99,88,93,86,15,99,94,15,63,97,88,101,80,99,84,15,66,84,97,101,84,97,29,29,29,15,63,91,84,80,98,84,15,102,80,88,99,29},17))
else
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,63,97,88,101,80,99,84,66,84,97,101,84,97,50,94,83,84,15,88,98,15,93,94,99,15,98,84,99,29,15,50,80,93,93,94,99,15,80,100,99,94,28,89,94,88,93,29},17))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,70,97,94,93,86,15,86,80,92,84,15,100,93,88,101,84,97,98,84,16,15,66,82,97,88,95,99,15,88,98,15,94,93,91,104,15,85,94,97,15,54,63,62,29},17))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({74,66,80,85,84,86,100,80,97,83,76,15,72,94,100,15,80,97,84,15,94,93,15,99,87,84,15,55,94,92,84,98,82,97,84,84,93,29,15,66,82,97,88,95,99,15,97,84,96,100,88,97,84,98,15,20,98,29},17), name or _d({80,15,98,95,84,82,88,85,88,82,15,95,91,80,82,84},17)))
if Safeguard.JoinPrivateServer() then
print(_d({74,66,80,85,84,86,100,80,97,83,76,15,67,84,91,84,95,94,97,99,88,93,86,15,99,94,15,63,97,88,101,80,99,84,15,66,84,97,101,84,97,29,29,29,15,63,91,84,80,98,84,15,102,80,88,99,29},17))
else
warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,63,97,88,101,80,99,84,66,84,97,101,84,97,50,94,83,84,15,88,98,15,93,94,99,15,98,84,99,29,15,50,80,93,93,94,99,15,80,100,99,94,28,89,94,88,93,29},17))
end
return false
end
warn(string.format(_d({74,66,80,85,84,86,100,80,97,83,76,15,70,97,94,93,86,15,95,91,80,82,84,16,15,65,84,96,100,88,97,84,83,41,15,20,98,15,23,20,83,24,27,15,50,100,97,97,84,93,99,41,15,20,83},17), name or _d({68,93,90,93,94,102,93},17), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({31,32,28,86,95,94,30,91,88,81,30,98,80,85,84,86,100,80,97,83,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,98,80,85,84,86,100,80,97,83,29,91,100,80},17))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,82,94,97,84,29,91,100,80},17)))()
end)
end
if not Core then warn(_d({74,50,94,97,84,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,16},17)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,66,99,94,95,95,84,83,29},17))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,48,91,97,84,80,83,104,15,97,100,93,93,88,93,86,16},17)); return end
if not Safeguard then warn(_d({74,66,80,85,84,86,100,80,97,83,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,16},17)); return end
if not Safeguard.RequirePlace(3978370137, _d({53,88,97,98,99,15,66,84,80},17)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17), 10)
local hum = char:WaitForChild(_d({55,100,92,80,93,94,88,83},17), 10)
local stats = ReplicatedStorage:WaitForChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({63,84,91,88},17), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or (char and char:FindFirstChild(_d({65,88,85,91,84},17)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,50,100,97,97,84,93,99,15,63,84,91,88,15,82,87,84,82,90,41},17), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,61,94,99,15,80,99,15,67,94,102,93,15,94,85,15,49,84,86,88,93,93,88,93,86,98,29,15,63,91,84,80,98,84,15,99,97,80,101,84,91,15,99,87,84,97,84,15,99,94,15,85,80,97,92,15,82,87,84,98,99,98,15,102,87,88,91,84,15,102,80,88,99,88,93,86,15,85,94,97,15,65,88,85,91,84,29},17))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({31,32,28,86,95,94,30,91,88,81,30,82,87,84,98,99,78,85,80,97,92,84,97,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,82,87,84,98,99,78,85,80,97,92,84,97,29,91,100,80},17))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,53,80,97,92,88,93,86,15,82,87,84,98,99,98,15,100,93,99,88,91,15,34,31,31,15,63,84,91,88,29,29,29,15,23,50,100,97,97,84,93,99,41,15},17) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({63,84,91,88},17))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or (c and c:FindFirstChild(_d({65,88,85,91,84},17))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({31,32,28,86,95,94,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({49,100,104,80,81,91,84,56,99,84,92,98},17))
local shopItem = buyables and buyables:FindFirstChild(_d({65,88,85,91,84},17))
local shopPart = shopItem and shopItem:FindFirstChild(_d({66,87,94,95,63,80,97,99},17))
if EasyTravel and shopPart and hrp then
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,67,97,80,101,84,91,88,93,86,15,99,94,15,65,88,85,91,84,15,98,87,94,95,15,101,88,80,15,52,80,98,104,67,97,80,101,84,91,29,29,29},17))
local nocollide = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({49,80,98,84,63,80,97,99},17)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({52,101,84,93,99,98},17)) and ReplicatedStorage.Events:FindFirstChild(_d({66,87,94,95},17))
if shopEvent and shopEvent:IsA(_d({65,84,92,94,99,84,53,100,93,82,99,88,94,93},17)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,52,96,100,88,95,95,88,93,86,15,65,88,85,91,84,29,29,29},17))
local args = {
[1] = _d({84,96,100,88,95},17),
[2] = _d({65,88,85,91,84},17)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({52,101,84,93,99,98},17)) and ReplicatedStorage.Events:FindFirstChild(_d({67,94,94,91,98},17))
if toolsEvent and toolsEvent:IsA(_d({65,84,92,94,99,84,53,100,93,82,99,88,94,93},17)) then
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
local hum = char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83},17))
local hrp = char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,53,91,104,88,93,86,15,99,94,15,53,88,98,87,92,80,93,15,50,80,101,84,29,29,29},17))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({31,32,28,86,95,94,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,84,80,98,104,78,99,97,80,101,84,91,29,91,100,80},17))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,52,98,82,80,95,88,93,86,15,98,87,94,95,15,88,93,99,84,97,88,94,97,15,81,104,15,85,91,104,88,93,86,15,98,99,97,80,88,86,87,99,15,100,95,29,29,29},17))
local nocollide = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({49,80,98,84,63,80,97,99},17)) then
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
local runService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
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
print(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,53,91,104,88,93,86,15,99,94,15,53,88,98,87,92,80,93,15,50,80,101,84,29,29,29},17))
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
local FishmanMaze = Core.Import(_d({31,32,28,86,95,94,30,91,88,81,30,85,88,98,87,92,80,93,78,92,80,105,84,29,91,100,80},17), _d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,91,100,80,100,28,82,94,83,84,30,92,80,88,93,30,31,32,78,98,82,97,88,95,99,30,91,88,81,30,85,88,98,87,92,80,93,78,92,80,105,84,29,91,100,80},17))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,53,80,88,91,84,83,15,99,94,15,88,92,95,94,97,99,15,53,88,98,87,92,80,93,60,80,105,84,15,91,88,81,97,80,97,104,16},17))
end
else
warn(_d({74,59,84,101,84,91,15,54,97,88,93,83,84,97,76,15,62,100,99,98,88,83,84,15,53,88,98,87,92,80,93,15,50,80,101,84,15,81,94,100,93,83,98,27,15,98,90,88,95,95,88,93,86,15,92,80,105,84,29},17))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({59,84,101,84,91,15,54,97,88,93,83,84,97},17),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()