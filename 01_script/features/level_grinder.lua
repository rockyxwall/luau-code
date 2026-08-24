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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({246,247,243,45,54,53,245,50,47,40,245,41,53,56,43,244,50,59,39},58)) then
Core = loadstring(readfile(_d({246,247,243,45,54,53,245,50,47,40,245,41,53,56,43,244,50,59,39},58)))()
else
Core = loadstring(game:HttpGet(_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,41,53,56,43,244,50,59,39},58)))()
end
end)
if not Core then warn(_d({33,9,53,56,43,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,231},58)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,25,58,53,54,54,43,42,244},58))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,7,50,56,43,39,42,63,230,56,59,52,52,47,52,45,231},58)); return end
if not Safeguard then warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,231},58)); return end
if not Safeguard.RequirePlace(3978370137, _d({12,47,56,57,58,230,25,43,39},58)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58), 10)
local hum = char:WaitForChild(_d({14,59,51,39,52,53,47,42},58), 10)
local stats = ReplicatedStorage:WaitForChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({22,43,50,47},58), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58)) or (char and char:FindFirstChild(_d({24,47,44,50,43},58)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,9,59,56,56,43,52,58,230,22,43,50,47,230,41,46,43,41,49,0},58), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,20,53,58,230,39,58,230,26,53,61,52,230,53,44,230,8,43,45,47,52,52,47,52,45,57,244,230,22,50,43,39,57,43,230,58,56,39,60,43,50,230,58,46,43,56,43,230,58,53,230,44,39,56,51,230,41,46,43,57,58,57,230,61,46,47,50,43,230,61,39,47,58,47,52,45,230,44,53,56,230,24,47,44,50,43,244},58))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,41,46,43,57,58,37,44,39,56,51,43,56,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,41,46,43,57,58,37,44,39,56,51,43,56,244,50,59,39},58))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,39,56,51,47,52,45,230,41,46,43,57,58,57,230,59,52,58,47,50,230,249,246,246,230,22,43,50,47,244,244,244,230,238,9,59,56,56,43,52,58,0,230},58) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({22,43,50,47},58))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58)) or (c and c:FindFirstChild(_d({24,47,44,50,43},58))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({8,59,63,39,40,50,43,15,58,43,51,57},58))
local shopItem = buyables and buyables:FindFirstChild(_d({24,47,44,50,43},58))
local shopPart = shopItem and shopItem:FindFirstChild(_d({25,46,53,54,22,39,56,58},58))
if EasyTravel and shopPart and hrp then
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,26,56,39,60,43,50,47,52,45,230,58,53,230,24,47,44,50,43,230,57,46,53,54,230,60,47,39,230,11,39,57,63,26,56,39,60,43,50,244,244,244},58))
local nocollide = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({8,39,57,43,22,39,56,58},58)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({11,60,43,52,58,57},58)) and ReplicatedStorage.Events:FindFirstChild(_d({25,46,53,54},58))
if shopEvent and shopEvent:IsA(_d({24,43,51,53,58,43,12,59,52,41,58,47,53,52},58)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,11,55,59,47,54,54,47,52,45,230,24,47,44,50,43,244,244,244},58))
local args = {
[1] = _d({43,55,59,47,54},58),
[2] = _d({24,47,44,50,43},58)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({11,60,43,52,58,57},58)) and ReplicatedStorage.Events:FindFirstChild(_d({26,53,53,50,57},58))
if toolsEvent and toolsEvent:IsA(_d({24,43,51,53,58,43,12,59,52,41,58,47,53,52},58)) then
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
local hum = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42},58))
local hrp = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,50,63,47,52,45,230,58,53,230,12,47,57,46,51,39,52,230,9,39,60,43,244,244,244},58))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,11,57,41,39,54,47,52,45,230,57,46,53,54,230,47,52,58,43,56,47,53,56,230,40,63,230,44,50,63,47,52,45,230,57,58,56,39,47,45,46,58,230,59,54,244,244,244},58))
local nocollide = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({8,39,57,43,22,39,56,58},58)) then
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
local runService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
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
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,50,63,47,52,45,230,58,53,230,12,47,57,46,51,39,52,230,9,39,60,43,244,244,244},58))
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
local FishmanMaze = Core.Import(_d({246,247,243,45,54,53,245,50,47,40,245,44,47,57,46,51,39,52,37,51,39,64,43,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,44,47,57,46,51,39,52,37,51,39,64,43,244,50,59,39},58))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,39,47,50,43,42,230,58,53,230,47,51,54,53,56,58,230,12,47,57,46,51,39,52,19,39,64,43,230,50,47,40,56,39,56,63,231},58))
end
else
warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,21,59,58,57,47,42,43,230,12,47,57,46,51,39,52,230,9,39,60,43,230,40,53,59,52,42,57,242,230,57,49,47,54,54,47,52,45,230,51,39,64,43,244},58))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({18,43,60,43,50,230,13,56,47,52,42,43,56},58),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()