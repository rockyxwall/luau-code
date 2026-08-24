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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({243,244,240,42,51,50,242,47,44,37,242,38,50,53,40,241,47,56,36},61)) then
Core = loadstring(readfile(_d({243,244,240,42,51,50,242,47,44,37,242,38,50,53,40,241,47,56,36},61)))()
else
Core = loadstring(game:HttpGet(_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,38,50,53,40,241,47,56,36},61)))()
end
end)
if not Core then warn(_d({30,6,50,53,40,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,22,55,50,51,51,40,39,241},61))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,4,47,53,40,36,39,60,227,53,56,49,49,44,49,42,228},61)); return end
if not Safeguard then warn(_d({30,22,36,41,40,42,56,36,53,39,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,228},61)); return end
if not Safeguard.RequirePlace(3978370137, _d({9,44,53,54,55,227,22,40,36},61)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61), 10)
local hum = char:WaitForChild(_d({11,56,48,36,49,50,44,39},61), 10)
local stats = ReplicatedStorage:WaitForChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({19,40,47,44},61), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61)) or (char and char:FindFirstChild(_d({21,44,41,47,40},61)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,6,56,53,53,40,49,55,227,19,40,47,44,227,38,43,40,38,46,253},61), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,17,50,55,227,36,55,227,23,50,58,49,227,50,41,227,5,40,42,44,49,49,44,49,42,54,241,227,19,47,40,36,54,40,227,55,53,36,57,40,47,227,55,43,40,53,40,227,55,50,227,41,36,53,48,227,38,43,40,54,55,54,227,58,43,44,47,40,227,58,36,44,55,44,49,42,227,41,50,53,227,21,44,41,47,40,241},61))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({243,244,240,42,51,50,242,47,44,37,242,38,43,40,54,55,34,41,36,53,48,40,53,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,38,43,40,54,55,34,41,36,53,48,40,53,241,47,56,36},61))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,36,53,48,44,49,42,227,38,43,40,54,55,54,227,56,49,55,44,47,227,246,243,243,227,19,40,47,44,241,241,241,227,235,6,56,53,53,40,49,55,253,227},61) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({19,40,47,44},61))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61)) or (c and c:FindFirstChild(_d({21,44,41,47,40},61))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({243,244,240,42,51,50,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({5,56,60,36,37,47,40,12,55,40,48,54},61))
local shopItem = buyables and buyables:FindFirstChild(_d({21,44,41,47,40},61))
local shopPart = shopItem and shopItem:FindFirstChild(_d({22,43,50,51,19,36,53,55},61))
if EasyTravel and shopPart and hrp then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,23,53,36,57,40,47,44,49,42,227,55,50,227,21,44,41,47,40,227,54,43,50,51,227,57,44,36,227,8,36,54,60,23,53,36,57,40,47,241,241,241},61))
local nocollide = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({8,57,40,49,55,54},61)) and ReplicatedStorage.Events:FindFirstChild(_d({22,43,50,51},61))
if shopEvent and shopEvent:IsA(_d({21,40,48,50,55,40,9,56,49,38,55,44,50,49},61)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,8,52,56,44,51,51,44,49,42,227,21,44,41,47,40,241,241,241},61))
local args = {
[1] = _d({40,52,56,44,51},61),
[2] = _d({21,44,41,47,40},61)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({8,57,40,49,55,54},61)) and ReplicatedStorage.Events:FindFirstChild(_d({23,50,50,47,54},61))
if toolsEvent and toolsEvent:IsA(_d({21,40,48,50,55,40,9,56,49,38,55,44,50,49},61)) then
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
local hum = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39},61))
local hrp = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,47,60,44,49,42,227,55,50,227,9,44,54,43,48,36,49,227,6,36,57,40,241,241,241},61))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({243,244,240,42,51,50,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,8,54,38,36,51,44,49,42,227,54,43,50,51,227,44,49,55,40,53,44,50,53,227,37,60,227,41,47,60,44,49,42,227,54,55,53,36,44,42,43,55,227,56,51,241,241,241},61))
local nocollide = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
local runService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
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
print(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,47,60,44,49,42,227,55,50,227,9,44,54,43,48,36,49,227,6,36,57,40,241,241,241},61))
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
local FishmanMaze = Core.Import(_d({243,244,240,42,51,50,242,47,44,37,242,41,44,54,43,48,36,49,34,48,36,61,40,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,41,44,54,43,48,36,49,34,48,36,61,40,241,47,56,36},61))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,9,36,44,47,40,39,227,55,50,227,44,48,51,50,53,55,227,9,44,54,43,48,36,49,16,36,61,40,227,47,44,37,53,36,53,60,228},61))
end
else
warn(_d({30,15,40,57,40,47,227,10,53,44,49,39,40,53,32,227,18,56,55,54,44,39,40,227,9,44,54,43,48,36,49,227,6,36,57,40,227,37,50,56,49,39,54,239,227,54,46,44,51,51,44,49,42,227,48,36,61,40,241},61))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({15,40,57,40,47,227,10,53,44,49,39,40,53},61),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()