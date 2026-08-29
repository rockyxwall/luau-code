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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({12,13,9,67,76,75,11,72,69,62,11,63,75,78,65,10,72,81,61},36)) then
Core = loadstring(readfile(_d({12,13,9,67,76,75,11,72,69,62,11,63,75,78,65,10,72,81,61},36)))()
else
Core = loadstring(game:HttpGet(_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,75,78,65,10,72,81,61},36)))()
end
end)
if not Core then warn(_d({55,31,75,78,65,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,47,80,75,76,76,65,64,10},36))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253},36)); return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.RequirePlace(3978370137, _d({34,69,78,79,80,252,47,65,61},36)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36), 10)
local hum = char:WaitForChild(_d({36,81,73,61,74,75,69,64},36), 10)
local stats = ReplicatedStorage:WaitForChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({44,65,72,69},36), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (char and char:FindFirstChild(_d({46,69,66,72,65},36)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,31,81,78,78,65,74,80,252,44,65,72,69,252,63,68,65,63,71,22},36), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,42,75,80,252,61,80,252,48,75,83,74,252,75,66,252,30,65,67,69,74,74,69,74,67,79,10,252,44,72,65,61,79,65,252,80,78,61,82,65,72,252,80,68,65,78,65,252,80,75,252,66,61,78,73,252,63,68,65,79,80,79,252,83,68,69,72,65,252,83,61,69,80,69,74,67,252,66,75,78,252,46,69,66,72,65,10},36))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,61,78,73,69,74,67,252,63,68,65,79,80,79,252,81,74,80,69,72,252,15,12,12,252,44,65,72,69,10,10,10,252,4,31,81,78,78,65,74,80,22,252},36) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({44,65,72,69},36))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (c and c:FindFirstChild(_d({46,69,66,72,65},36))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({30,81,85,61,62,72,65,37,80,65,73,79},36))
local shopItem = buyables and buyables:FindFirstChild(_d({46,69,66,72,65},36))
local shopPart = shopItem and shopItem:FindFirstChild(_d({47,68,75,76,44,61,78,80},36))
if EasyTravel and shopPart and hrp then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,48,78,61,82,65,72,69,74,67,252,80,75,252,46,69,66,72,65,252,79,68,75,76,252,82,69,61,252,33,61,79,85,48,78,61,82,65,72,10,10,10},36))
local nocollide = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({33,82,65,74,80,79},36)) and ReplicatedStorage.Events:FindFirstChild(_d({47,68,75,76},36))
if shopEvent and shopEvent:IsA(_d({46,65,73,75,80,65,34,81,74,63,80,69,75,74},36)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,33,77,81,69,76,76,69,74,67,252,46,69,66,72,65,10,10,10},36))
local args = {
[1] = _d({65,77,81,69,76},36),
[2] = _d({46,69,66,72,65},36)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({33,82,65,74,80,79},36)) and ReplicatedStorage.Events:FindFirstChild(_d({48,75,75,72,79},36))
if toolsEvent and toolsEvent:IsA(_d({46,65,73,75,80,65,34,81,74,63,80,69,75,74},36)) then
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
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
local hrp = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,72,85,69,74,67,252,80,75,252,34,69,79,68,73,61,74,252,31,61,82,65,10,10,10},36))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,33,79,63,61,76,69,74,67,252,79,68,75,76,252,69,74,80,65,78,69,75,78,252,62,85,252,66,72,85,69,74,67,252,79,80,78,61,69,67,68,80,252,81,76,10,10,10},36))
local nocollide = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
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
local runService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
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
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,72,85,69,74,67,252,80,75,252,34,69,79,68,73,61,74,252,31,61,82,65,10,10,10},36))
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
local FishmanMaze = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,66,69,79,68,73,61,74,59,73,61,86,65,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,66,69,79,68,73,61,74,59,73,61,86,65,10,72,81,61},36))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,61,69,72,65,64,252,80,75,252,69,73,76,75,78,80,252,34,69,79,68,73,61,74,41,61,86,65,252,72,69,62,78,61,78,85,253},36))
end
else
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,43,81,80,79,69,64,65,252,34,69,79,68,73,61,74,252,31,61,82,65,252,62,75,81,74,64,79,8,252,79,71,69,76,76,69,74,67,252,73,61,86,65,10},36))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({40,65,82,65,72,252,35,78,69,74,64,65,78},36),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()