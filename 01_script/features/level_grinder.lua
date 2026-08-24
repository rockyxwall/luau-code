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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({11,12,8,66,75,74,10,71,68,61,10,62,74,77,64,9,71,80,60},37)) then
Core = loadstring(readfile(_d({11,12,8,66,75,74,10,71,68,61,10,62,74,77,64,9,71,80,60},37)))()
else
Core = loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,62,74,77,64,9,71,80,60},37)))()
end
end)
if not Core then warn(_d({54,30,74,77,64,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,46,79,74,75,75,64,63,9},37))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,28,71,77,64,60,63,84,251,77,80,73,73,68,73,66,252},37)); return end
if not Safeguard then warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,252},37)); return end
if not Safeguard.RequirePlace(3978370137, _d({33,68,77,78,79,251,46,64,60},37)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37), 10)
local hum = char:WaitForChild(_d({35,80,72,60,73,74,68,63},37), 10)
local stats = ReplicatedStorage:WaitForChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({43,64,71,68},37), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({45,68,65,71,64},37)) or (char and char:FindFirstChild(_d({45,68,65,71,64},37)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,30,80,77,77,64,73,79,251,43,64,71,68,251,62,67,64,62,70,21},37), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,41,74,79,251,60,79,251,47,74,82,73,251,74,65,251,29,64,66,68,73,73,68,73,66,78,9,251,43,71,64,60,78,64,251,79,77,60,81,64,71,251,79,67,64,77,64,251,79,74,251,65,60,77,72,251,62,67,64,78,79,78,251,82,67,68,71,64,251,82,60,68,79,68,73,66,251,65,74,77,251,45,68,65,71,64,9},37))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,62,67,64,78,79,58,65,60,77,72,64,77,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,62,67,64,78,79,58,65,60,77,72,64,77,9,71,80,60},37))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,33,60,77,72,68,73,66,251,62,67,64,78,79,78,251,80,73,79,68,71,251,14,11,11,251,43,64,71,68,9,9,9,251,3,30,80,77,77,64,73,79,21,251},37) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({43,64,71,68},37))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({45,68,65,71,64},37)) or (c and c:FindFirstChild(_d({45,68,65,71,64},37))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({29,80,84,60,61,71,64,36,79,64,72,78},37))
local shopItem = buyables and buyables:FindFirstChild(_d({45,68,65,71,64},37))
local shopPart = shopItem and shopItem:FindFirstChild(_d({46,67,74,75,43,60,77,79},37))
if EasyTravel and shopPart and hrp then
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,47,77,60,81,64,71,68,73,66,251,79,74,251,45,68,65,71,64,251,78,67,74,75,251,81,68,60,251,32,60,78,84,47,77,60,81,64,71,9,9,9},37))
local nocollide = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({32,81,64,73,79,78},37)) and ReplicatedStorage.Events:FindFirstChild(_d({46,67,74,75},37))
if shopEvent and shopEvent:IsA(_d({45,64,72,74,79,64,33,80,73,62,79,68,74,73},37)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,32,76,80,68,75,75,68,73,66,251,45,68,65,71,64,9,9,9},37))
local args = {
[1] = _d({64,76,80,68,75},37),
[2] = _d({45,68,65,71,64},37)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({32,81,64,73,79,78},37)) and ReplicatedStorage.Events:FindFirstChild(_d({47,74,74,71,78},37))
if toolsEvent and toolsEvent:IsA(_d({45,64,72,74,79,64,33,80,73,62,79,68,74,73},37)) then
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
local hum = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63},37))
local hrp = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({45,68,65,71,64},37))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,33,71,84,68,73,66,251,79,74,251,33,68,78,67,72,60,73,251,30,60,81,64,9,9,9},37))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,32,78,62,60,75,68,73,66,251,78,67,74,75,251,68,73,79,64,77,68,74,77,251,61,84,251,65,71,84,68,73,66,251,78,79,77,60,68,66,67,79,251,80,75,9,9,9},37))
local nocollide = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
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
local runService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
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
print(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,33,71,84,68,73,66,251,79,74,251,33,68,78,67,72,60,73,251,30,60,81,64,9,9,9},37))
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
local FishmanMaze = Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,65,68,78,67,72,60,73,58,72,60,85,64,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,65,68,78,67,72,60,73,58,72,60,85,64,9,71,80,60},37))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,33,60,68,71,64,63,251,79,74,251,68,72,75,74,77,79,251,33,68,78,67,72,60,73,40,60,85,64,251,71,68,61,77,60,77,84,252},37))
end
else
warn(_d({54,39,64,81,64,71,251,34,77,68,73,63,64,77,56,251,42,80,79,78,68,63,64,251,33,68,78,67,72,60,73,251,30,60,81,64,251,61,74,80,73,63,78,7,251,78,70,68,75,75,68,73,66,251,72,60,85,64,9},37))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({39,64,81,64,71,251,34,77,68,73,63,64,77},37),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()