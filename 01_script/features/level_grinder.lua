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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,55,88,83,84,84,73,72,18},28))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,37,80,86,73,69,72,93,4,86,89,82,82,77,82,75,5},28)); return end
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
if not Safeguard.RequirePlace(3978370137, _d({42,77,86,87,88,4,55,73,69},28)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28), 10)
local hum = char:WaitForChild(_d({44,89,81,69,82,83,77,72},28), 10)
local stats = ReplicatedStorage:WaitForChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({52,73,80,77},28), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28)) or (char and char:FindFirstChild(_d({54,77,74,80,73},28)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,39,89,86,86,73,82,88,4,52,73,80,77,4,71,76,73,71,79,30},28), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,50,83,88,4,69,88,4,56,83,91,82,4,83,74,4,38,73,75,77,82,82,77,82,75,87,18,4,52,80,73,69,87,73,4,88,86,69,90,73,80,4,88,76,73,86,73,4,88,83,4,74,69,86,81,4,71,76,73,87,88,87,4,91,76,77,80,73,4,91,69,77,88,77,82,75,4,74,83,86,4,54,77,74,80,73,18},28))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,71,76,73,87,88,67,74,69,86,81,73,86,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,76,73,87,88,67,74,69,86,81,73,86,18,80,89,69},28))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,42,69,86,81,77,82,75,4,71,76,73,87,88,87,4,89,82,88,77,80,4,23,20,20,4,52,73,80,77,18,18,18,4,12,39,89,86,86,73,82,88,30,4},28) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({52,73,80,77},28))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28)) or (c and c:FindFirstChild(_d({54,77,74,80,73},28))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28))
_G.DisableStandalone = old
end
local buyables = workspace:FindFirstChild(_d({38,89,93,69,70,80,73,45,88,73,81,87},28))
local shopItem = buyables and buyables:FindFirstChild(_d({54,77,74,80,73},28))
local shopPart = shopItem and shopItem:FindFirstChild(_d({55,76,83,84,52,69,86,88},28))
if EasyTravel and shopPart and hrp then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,56,86,69,90,73,80,77,82,75,4,88,83,4,54,77,74,80,73,4,87,76,83,84,4,90,77,69,4,41,69,87,93,56,86,69,90,73,80,18,18,18},28))
local nocollide = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({38,69,87,73,52,69,86,88},28)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({41,90,73,82,88,87},28)) and ReplicatedStorage.Events:FindFirstChild(_d({55,76,83,84},28))
if shopEvent and shopEvent:IsA(_d({54,73,81,83,88,73,42,89,82,71,88,77,83,82},28)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,41,85,89,77,84,84,77,82,75,4,54,77,74,80,73,18,18,18},28))
local args = {
[1] = _d({73,85,89,77,84},28),
[2] = _d({54,77,74,80,73},28)
}
pcall(function()
game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28)):WaitForChild(_d({41,90,73,82,88,87},28)):WaitForChild(_d({56,83,83,80,87},28)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72},28))
local hrp = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,42,80,93,77,82,75,4,88,83,4,42,77,87,76,81,69,82,4,39,69,90,73,18,18,18},28))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28))
_G.DisableStandalone = old
end
if EasyTravel and hrp then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,41,87,71,69,84,77,82,75,4,87,76,83,84,4,77,82,88,73,86,77,83,86,4,70,93,4,74,80,93,77,82,75,4,87,88,86,69,77,75,76,88,4,89,84,18,18,18},28))
local nocollide = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({38,69,87,73,52,69,86,88},28)) then
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
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,42,80,93,77,82,75,4,88,83,4,42,77,87,76,81,69,82,4,39,69,90,73,18,18,18},28))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 50 then break end
task.wait(1)
end
pcall(EasyTravel.Stop)
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({48,73,90,73,80,4,43,86,77,82,72,73,86},28),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()