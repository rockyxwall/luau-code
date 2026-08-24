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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({3,4,0,58,67,66,2,63,60,53,2,54,66,69,56,1,63,72,52},45)) then
Core = loadstring(readfile(_d({3,4,0,58,67,66,2,63,60,53,2,54,66,69,56,1,63,72,52},45)))()
else
Core = loadstring(game:HttpGet(_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,54,66,69,56,1,63,72,52},45)))()
end
end)
if not Core then warn(_d({46,22,66,69,56,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,244},45)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,38,71,66,67,67,56,55,1},45))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,20,63,69,56,52,55,76,243,69,72,65,65,60,65,58,244},45)); return end
if not Safeguard then warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,244},45)); return end
if not Safeguard.RequirePlace(3978370137, _d({25,60,69,70,71,243,38,56,52},45)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45), 10)
local hum = char:WaitForChild(_d({27,72,64,52,65,66,60,55},45), 10)
local stats = ReplicatedStorage:WaitForChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({35,56,63,60},45), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({37,60,57,63,56},45)) or (char and char:FindFirstChild(_d({37,60,57,63,56},45)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,22,72,69,69,56,65,71,243,35,56,63,60,243,54,59,56,54,62,13},45), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,33,66,71,243,52,71,243,39,66,74,65,243,66,57,243,21,56,58,60,65,65,60,65,58,70,1,243,35,63,56,52,70,56,243,71,69,52,73,56,63,243,71,59,56,69,56,243,71,66,243,57,52,69,64,243,54,59,56,70,71,70,243,74,59,60,63,56,243,74,52,60,71,60,65,58,243,57,66,69,243,37,60,57,63,56,1},45))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,54,59,56,70,71,50,57,52,69,64,56,69,1,63,72,52},45))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,25,52,69,64,60,65,58,243,54,59,56,70,71,70,243,72,65,71,60,63,243,6,3,3,243,35,56,63,60,1,1,1,243,251,22,72,69,69,56,65,71,13,243},45) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({35,56,63,60},45))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({37,60,57,63,56},45)) or (c and c:FindFirstChild(_d({37,60,57,63,56},45))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({21,72,76,52,53,63,56,28,71,56,64,70},45))
local shopItem = buyables and buyables:FindFirstChild(_d({37,60,57,63,56},45))
local shopPart = shopItem and shopItem:FindFirstChild(_d({38,59,66,67,35,52,69,71},45))
if EasyTravel and shopPart and hrp then
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,39,69,52,73,56,63,60,65,58,243,71,66,243,37,60,57,63,56,243,70,59,66,67,243,73,60,52,243,24,52,70,76,39,69,52,73,56,63,1,1,1},45))
local nocollide = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({21,52,70,56,35,52,69,71},45)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({24,73,56,65,71,70},45)) and ReplicatedStorage.Events:FindFirstChild(_d({38,59,66,67},45))
if shopEvent and shopEvent:IsA(_d({37,56,64,66,71,56,25,72,65,54,71,60,66,65},45)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,24,68,72,60,67,67,60,65,58,243,37,60,57,63,56,1,1,1},45))
local args = {
[1] = _d({56,68,72,60,67},45),
[2] = _d({37,60,57,63,56},45)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({24,73,56,65,71,70},45)) and ReplicatedStorage.Events:FindFirstChild(_d({39,66,66,63,70},45))
if toolsEvent and toolsEvent:IsA(_d({37,56,64,66,71,56,25,72,65,54,71,60,66,65},45)) then
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
local hum = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55},45))
local hrp = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({37,60,57,63,56},45))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,25,63,76,60,65,58,243,71,66,243,25,60,70,59,64,52,65,243,22,52,73,56,1,1,1},45))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,56,52,70,76,50,71,69,52,73,56,63,1,63,72,52},45))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,24,70,54,52,67,60,65,58,243,70,59,66,67,243,60,65,71,56,69,60,66,69,243,53,76,243,57,63,76,60,65,58,243,70,71,69,52,60,58,59,71,243,72,67,1,1,1},45))
local nocollide = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({21,52,70,56,35,52,69,71},45)) then
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
local runService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
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
print(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,25,63,76,60,65,58,243,71,66,243,25,60,70,59,64,52,65,243,22,52,73,56,1,1,1},45))
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
local FishmanMaze = Core.Import(_d({3,4,0,58,67,66,2,63,60,53,2,57,60,70,59,64,52,65,50,64,52,77,56,1,63,72,52},45), _d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,63,72,52,72,0,54,66,55,56,2,64,52,60,65,2,3,4,50,70,54,69,60,67,71,2,63,60,53,2,57,60,70,59,64,52,65,50,64,52,77,56,1,63,72,52},45))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,60,64,67,66,69,71,243,25,60,70,59,64,52,65,32,52,77,56,243,63,60,53,69,52,69,76,244},45))
end
else
warn(_d({46,31,56,73,56,63,243,26,69,60,65,55,56,69,48,243,34,72,71,70,60,55,56,243,25,60,70,59,64,52,65,243,22,52,73,56,243,53,66,72,65,55,70,255,243,70,62,60,67,67,60,65,58,243,64,52,77,56,1},45))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({31,56,73,56,63,243,26,69,60,65,55,56,69},45),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()