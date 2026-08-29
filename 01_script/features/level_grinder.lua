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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
end
end)
if not Core then warn(_d({48,24,68,71,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,40,73,68,69,69,58,57,3},43))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,22,65,71,58,54,57,78,245,71,74,67,67,62,67,60,246},43)); return end
if not Safeguard then warn(_d({48,40,54,59,58,60,74,54,71,57,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
if not Safeguard.RequirePlace(3978370137, _d({27,62,71,72,73,245,40,58,54},43)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43), 10)
local hum = char:WaitForChild(_d({29,74,66,54,67,68,62,57},43), 10)
local stats = ReplicatedStorage:WaitForChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({37,58,65,62},43), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43)) or (char and char:FindFirstChild(_d({39,62,59,65,58},43)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,24,74,71,71,58,67,73,245,37,58,65,62,245,56,61,58,56,64,15},43), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,35,68,73,245,54,73,245,41,68,76,67,245,68,59,245,23,58,60,62,67,67,62,67,60,72,3,245,37,65,58,54,72,58,245,73,71,54,75,58,65,245,73,61,58,71,58,245,73,68,245,59,54,71,66,245,56,61,58,72,73,72,245,76,61,62,65,58,245,76,54,62,73,62,67,60,245,59,68,71,245,39,62,59,65,58,3},43))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,56,61,58,72,73,52,59,54,71,66,58,71,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,61,58,72,73,52,59,54,71,66,58,71,3,65,74,54},43))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,54,71,66,62,67,60,245,56,61,58,72,73,72,245,74,67,73,62,65,245,8,5,5,245,37,58,65,62,3,3,3,245,253,24,74,71,71,58,67,73,15,245},43) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({37,58,65,62},43))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43)) or (c and c:FindFirstChild(_d({39,62,59,65,58},43))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({23,74,78,54,55,65,58,30,73,58,66,72},43))
local shopItem = buyables and buyables:FindFirstChild(_d({39,62,59,65,58},43))
local shopPart = shopItem and shopItem:FindFirstChild(_d({40,61,68,69,37,54,71,73},43))
if EasyTravel and shopPart and hrp then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,41,71,54,75,58,65,62,67,60,245,73,68,245,39,62,59,65,58,245,72,61,68,69,245,75,62,54,245,26,54,72,78,41,71,54,75,58,65,3,3,3},43))
local nocollide = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({23,54,72,58,37,54,71,73},43)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({26,75,58,67,73,72},43)) and ReplicatedStorage.Events:FindFirstChild(_d({40,61,68,69},43))
if shopEvent and shopEvent:IsA(_d({39,58,66,68,73,58,27,74,67,56,73,62,68,67},43)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,26,70,74,62,69,69,62,67,60,245,39,62,59,65,58,3,3,3},43))
local args = {
[1] = _d({58,70,74,62,69},43),
[2] = _d({39,62,59,65,58},43)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({26,75,58,67,73,72},43)) and ReplicatedStorage.Events:FindFirstChild(_d({41,68,68,65,72},43))
if toolsEvent and toolsEvent:IsA(_d({39,58,66,68,73,58,27,74,67,56,73,62,68,67},43)) then
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
local hum = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57},43))
local hrp = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,65,78,62,67,60,245,73,68,245,27,62,72,61,66,54,67,245,24,54,75,58,3,3,3},43))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,26,72,56,54,69,62,67,60,245,72,61,68,69,245,62,67,73,58,71,62,68,71,245,55,78,245,59,65,78,62,67,60,245,72,73,71,54,62,60,61,73,245,74,69,3,3,3},43))
local nocollide = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({23,54,72,58,37,54,71,73},43)) then
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
local runService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
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
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,65,78,62,67,60,245,73,68,245,27,62,72,61,66,54,67,245,24,54,75,58,3,3,3},43))
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
local FishmanMaze = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,59,62,72,61,66,54,67,52,66,54,79,58,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,59,62,72,61,66,54,67,52,66,54,79,58,3,65,74,54},43))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,54,62,65,58,57,245,73,68,245,62,66,69,68,71,73,245,27,62,72,61,66,54,67,34,54,79,58,245,65,62,55,71,54,71,78,246},43))
end
else
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,36,74,73,72,62,57,58,245,27,62,72,61,66,54,67,245,24,54,75,58,245,55,68,74,67,57,72,1,245,72,64,62,69,69,62,67,60,245,66,54,79,58,3},43))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({33,58,75,58,65,245,28,71,62,67,57,58,71},43),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()