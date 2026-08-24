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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,35,68,63,64,64,53,52,254},48))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241},48)); return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.RequirePlace(3978370137, _d({22,57,66,67,68,240,35,53,49},48)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48), 10)
local hum = char:WaitForChild(_d({24,69,61,49,62,63,57,52},48), 10)
local stats = ReplicatedStorage:WaitForChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({32,53,60,57},48), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (char and char:FindFirstChild(_d({34,57,54,60,53},48)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,19,69,66,66,53,62,68,240,32,53,60,57,240,51,56,53,51,59,10},48), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,30,63,68,240,49,68,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,254,240,32,60,53,49,67,53,240,68,66,49,70,53,60,240,68,56,53,66,53,240,68,63,240,54,49,66,61,240,51,56,53,67,68,67,240,71,56,57,60,53,240,71,49,57,68,57,62,55,240,54,63,66,240,34,57,54,60,53,254},48))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,49,66,61,57,62,55,240,51,56,53,67,68,67,240,69,62,68,57,60,240,3,0,0,240,32,53,60,57,254,254,254,240,248,19,69,66,66,53,62,68,10,240},48) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({32,53,60,57},48))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (c and c:FindFirstChild(_d({34,57,54,60,53},48))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({18,69,73,49,50,60,53,25,68,53,61,67},48))
local shopItem = buyables and buyables:FindFirstChild(_d({34,57,54,60,53},48))
local shopPart = shopItem and shopItem:FindFirstChild(_d({35,56,63,64,32,49,66,68},48))
if EasyTravel and shopPart and hrp then
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,36,66,49,70,53,60,57,62,55,240,68,63,240,34,57,54,60,53,240,67,56,63,64,240,70,57,49,240,21,49,67,73,36,66,49,70,53,60,254,254,254},48))
local nocollide = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({18,49,67,53,32,49,66,68},48)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({21,70,53,62,68,67},48)) and ReplicatedStorage.Events:FindFirstChild(_d({35,56,63,64},48))
if shopEvent and shopEvent:IsA(_d({34,53,61,63,68,53,22,69,62,51,68,57,63,62},48)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,21,65,69,57,64,64,57,62,55,240,34,57,54,60,53,254,254,254},48))
local args = {
[1] = _d({53,65,69,57,64},48),
[2] = _d({34,57,54,60,53},48)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({21,70,53,62,68,67},48)) and ReplicatedStorage.Events:FindFirstChild(_d({36,63,63,60,67},48))
if toolsEvent and toolsEvent:IsA(_d({34,53,61,63,68,53,22,69,62,51,68,57,63,62},48)) then
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
local hum = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52},48))
local hrp = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,60,73,57,62,55,240,68,63,240,22,57,67,56,61,49,62,240,19,49,70,53,254,254,254},48))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,21,67,51,49,64,57,62,55,240,67,56,63,64,240,57,62,68,53,66,57,63,66,240,50,73,240,54,60,73,57,62,55,240,67,68,66,49,57,55,56,68,240,69,64,254,254,254},48))
local nocollide = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({18,49,67,53,32,49,66,68},48)) then
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
local runService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
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
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,60,73,57,62,55,240,68,63,240,22,57,67,56,61,49,62,240,19,49,70,53,254,254,254},48))
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
local FishmanMaze = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,54,57,67,56,61,49,62,47,61,49,74,53,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,54,57,67,56,61,49,62,47,61,49,74,53,254,60,69,49},48))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,49,57,60,53,52,240,68,63,240,57,61,64,63,66,68,240,22,57,67,56,61,49,62,29,49,74,53,240,60,57,50,66,49,66,73,241},48))
end
else
warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,31,69,68,67,57,52,53,240,22,57,67,56,61,49,62,240,19,49,70,53,240,50,63,69,62,52,67,252,240,67,59,57,64,64,57,62,55,240,61,49,74,53,254},48))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({28,53,70,53,60,240,23,66,57,62,52,53,66},48),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()