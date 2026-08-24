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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({24,25,21,79,88,87,23,84,81,74,23,75,87,90,77,22,84,93,73},24)) then
Core = loadstring(readfile(_d({24,25,21,79,88,87,23,84,81,74,23,75,87,90,77,22,84,93,73},24)))()
else
Core = loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,75,87,90,77,22,84,93,73},24)))()
end
end)
if not Core then warn(_d({67,43,87,90,77,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,9},24)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,59,92,87,88,88,77,76,22},24))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,41,84,90,77,73,76,97,8,90,93,86,86,81,86,79,9},24)); return end
if not Safeguard then warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,9},24)); return end
if not Safeguard.RequirePlace(3978370137, _d({46,81,90,91,92,8,59,77,73},24)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24), 10)
local hum = char:WaitForChild(_d({48,93,85,73,86,87,81,76},24), 10)
local stats = ReplicatedStorage:WaitForChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({56,77,84,81},24), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24)) or (char and char:FindFirstChild(_d({58,81,78,84,77},24)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,43,93,90,90,77,86,92,8,56,77,84,81,8,75,80,77,75,83,34},24), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,54,87,92,8,73,92,8,60,87,95,86,8,87,78,8,42,77,79,81,86,86,81,86,79,91,22,8,56,84,77,73,91,77,8,92,90,73,94,77,84,8,92,80,77,90,77,8,92,87,8,78,73,90,85,8,75,80,77,91,92,91,8,95,80,81,84,77,8,95,73,81,92,81,86,79,8,78,87,90,8,58,81,78,84,77,22},24))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,46,73,90,85,81,86,79,8,75,80,77,91,92,91,8,93,86,92,81,84,8,27,24,24,8,56,77,84,81,22,22,22,8,16,43,93,90,90,77,86,92,34,8},24) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({56,77,84,81},24))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24)) or (c and c:FindFirstChild(_d({58,81,78,84,77},24))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({42,93,97,73,74,84,77,49,92,77,85,91},24))
local shopItem = buyables and buyables:FindFirstChild(_d({58,81,78,84,77},24))
local shopPart = shopItem and shopItem:FindFirstChild(_d({59,80,87,88,56,73,90,92},24))
if EasyTravel and shopPart and hrp then
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,60,90,73,94,77,84,81,86,79,8,92,87,8,58,81,78,84,77,8,91,80,87,88,8,94,81,73,8,45,73,91,97,60,90,73,94,77,84,22,22,22},24))
local nocollide = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({45,94,77,86,92,91},24)) and ReplicatedStorage.Events:FindFirstChild(_d({59,80,87,88},24))
if shopEvent and shopEvent:IsA(_d({58,77,85,87,92,77,46,93,86,75,92,81,87,86},24)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,45,89,93,81,88,88,81,86,79,8,58,81,78,84,77,22,22,22},24))
local args = {
[1] = _d({77,89,93,81,88},24),
[2] = _d({58,81,78,84,77},24)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({45,94,77,86,92,91},24)) and ReplicatedStorage.Events:FindFirstChild(_d({60,87,87,84,91},24))
if toolsEvent and toolsEvent:IsA(_d({58,77,85,87,92,77,46,93,86,75,92,81,87,86},24)) then
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
local hum = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76},24))
local hrp = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,46,84,97,81,86,79,8,92,87,8,46,81,91,80,85,73,86,8,43,73,94,77,22,22,22},24))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,45,91,75,73,88,81,86,79,8,91,80,87,88,8,81,86,92,77,90,81,87,90,8,74,97,8,78,84,97,81,86,79,8,91,92,90,73,81,79,80,92,8,93,88,22,22,22},24))
local nocollide = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, 60, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= 58 then break end
task.wait(0.5)
end
nocollide:Disconnect()
local runService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
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
print(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,46,84,97,81,86,79,8,92,87,8,46,81,91,80,85,73,86,8,43,73,94,77,22,22,22},24))
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
local FishmanMaze = Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,78,81,91,80,85,73,86,71,85,73,98,77,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,78,81,91,80,85,73,86,71,85,73,98,77,22,84,93,73},24))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,81,85,88,87,90,92,8,46,81,91,80,85,73,86,53,73,98,77,8,84,81,74,90,73,90,97,9},24))
end
else
warn(_d({67,52,77,94,77,84,8,47,90,81,86,76,77,90,69,8,55,93,92,91,81,76,77,8,46,81,91,80,85,73,86,8,43,73,94,77,8,74,87,93,86,76,91,20,8,91,83,81,88,88,81,86,79,8,85,73,98,77,22},24))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({52,77,94,77,84,8,47,90,81,86,76,77,90},24),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()