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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({254,255,251,53,62,61,253,58,55,48,253,49,61,64,51,252,58,67,47},50)) then
Core = loadstring(readfile(_d({254,255,251,53,62,61,253,58,55,48,253,49,61,64,51,252,58,67,47},50)))()
else
Core = loadstring(game:HttpGet(_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,49,61,64,51,252,58,67,47},50)))()
end
end)
if not Core then warn(_d({41,17,61,64,51,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,33,66,61,62,62,51,50,252},50))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,15,58,64,51,47,50,71,238,64,67,60,60,55,60,53,239},50)); return end
if not Safeguard then warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50)); return end
if not Safeguard.RequirePlace(3978370137, _d({20,55,64,65,66,238,33,51,47},50)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50), 10)
local hum = char:WaitForChild(_d({22,67,59,47,60,61,55,50},50), 10)
local stats = ReplicatedStorage:WaitForChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({30,51,58,55},50), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50)) or (char and char:FindFirstChild(_d({32,55,52,58,51},50)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,17,67,64,64,51,60,66,238,30,51,58,55,238,49,54,51,49,57,8},50), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,28,61,66,238,47,66,238,34,61,69,60,238,61,52,238,16,51,53,55,60,60,55,60,53,65,252,238,30,58,51,47,65,51,238,66,64,47,68,51,58,238,66,54,51,64,51,238,66,61,238,52,47,64,59,238,49,54,51,65,66,65,238,69,54,55,58,51,238,69,47,55,66,55,60,53,238,52,61,64,238,32,55,52,58,51,252},50))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,49,54,51,65,66,45,52,47,64,59,51,64,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,49,54,51,65,66,45,52,47,64,59,51,64,252,58,67,47},50))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,20,47,64,59,55,60,53,238,49,54,51,65,66,65,238,67,60,66,55,58,238,1,254,254,238,30,51,58,55,252,252,252,238,246,17,67,64,64,51,60,66,8,238},50) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({30,51,58,55},50))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50)) or (c and c:FindFirstChild(_d({32,55,52,58,51},50))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({16,67,71,47,48,58,51,23,66,51,59,65},50))
local shopItem = buyables and buyables:FindFirstChild(_d({32,55,52,58,51},50))
local shopPart = shopItem and shopItem:FindFirstChild(_d({33,54,61,62,30,47,64,66},50))
if EasyTravel and shopPart and hrp then
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,34,64,47,68,51,58,55,60,53,238,66,61,238,32,55,52,58,51,238,65,54,61,62,238,68,55,47,238,19,47,65,71,34,64,47,68,51,58,252,252,252},50))
local nocollide = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({16,47,65,51,30,47,64,66},50)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({19,68,51,60,66,65},50)) and ReplicatedStorage.Events:FindFirstChild(_d({33,54,61,62},50))
if shopEvent and shopEvent:IsA(_d({32,51,59,61,66,51,20,67,60,49,66,55,61,60},50)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,19,63,67,55,62,62,55,60,53,238,32,55,52,58,51,252,252,252},50))
local args = {
[1] = _d({51,63,67,55,62},50),
[2] = _d({32,55,52,58,51},50)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({19,68,51,60,66,65},50)) and ReplicatedStorage.Events:FindFirstChild(_d({34,61,61,58,65},50))
if toolsEvent and toolsEvent:IsA(_d({32,51,59,61,66,51,20,67,60,49,66,55,61,60},50)) then
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
local hum = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50},50))
local hrp = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,20,58,71,55,60,53,238,66,61,238,20,55,65,54,59,47,60,238,17,47,68,51,252,252,252},50))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,19,65,49,47,62,55,60,53,238,65,54,61,62,238,55,60,66,51,64,55,61,64,238,48,71,238,52,58,71,55,60,53,238,65,66,64,47,55,53,54,66,238,67,62,252,252,252},50))
local nocollide = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({16,47,65,51,30,47,64,66},50)) then
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
local runService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
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
print(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,20,58,71,55,60,53,238,66,61,238,20,55,65,54,59,47,60,238,17,47,68,51,252,252,252},50))
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
local FishmanMaze = Core.Import(_d({254,255,251,53,62,61,253,58,55,48,253,52,55,65,54,59,47,60,45,59,47,72,51,252,58,67,47},50), _d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,58,55,48,253,52,55,65,54,59,47,60,45,59,47,72,51,252,58,67,47},50))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,20,47,55,58,51,50,238,66,61,238,55,59,62,61,64,66,238,20,55,65,54,59,47,60,27,47,72,51,238,58,55,48,64,47,64,71,239},50))
end
else
warn(_d({41,26,51,68,51,58,238,21,64,55,60,50,51,64,43,238,29,67,66,65,55,50,51,238,20,55,65,54,59,47,60,238,17,47,68,51,238,48,61,67,60,50,65,250,238,65,57,55,62,62,55,60,53,238,59,47,72,51,252},50))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({26,51,68,51,58,238,21,64,55,60,50,51,64},50),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()