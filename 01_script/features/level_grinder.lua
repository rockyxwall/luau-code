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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)) then
Core = loadstring(readfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
else
Core = loadstring(game:HttpGet(_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
end
end)
if not Core then warn(_d({39,15,59,62,49,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,31,64,59,60,60,49,48,250},52))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237},52)); return end
if not Safeguard then warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
if not Safeguard.RequirePlace(3978370137, _d({18,53,62,63,64,236,31,49,45},52)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52), 10)
local hum = char:WaitForChild(_d({20,65,57,45,58,59,53,48},52), 10)
local stats = ReplicatedStorage:WaitForChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({28,49,56,53},52), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52)) or (char and char:FindFirstChild(_d({30,53,50,56,49},52)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,15,65,62,62,49,58,64,236,28,49,56,53,236,47,52,49,47,55,6},52), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,26,59,64,236,45,64,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,250,236,28,56,49,45,63,49,236,64,62,45,66,49,56,236,64,52,49,62,49,236,64,59,236,50,45,62,57,236,47,52,49,63,64,63,236,67,52,53,56,49,236,67,45,53,64,53,58,51,236,50,59,62,236,30,53,50,56,49,250},52))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({252,253,249,51,60,59,251,56,53,46,251,47,52,49,63,64,43,50,45,62,57,49,62,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,47,52,49,63,64,43,50,45,62,57,49,62,250,56,65,45},52))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,45,62,57,53,58,51,236,47,52,49,63,64,63,236,65,58,64,53,56,236,255,252,252,236,28,49,56,53,250,250,250,236,244,15,65,62,62,49,58,64,6,236},52) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({28,49,56,53},52))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52)) or (c and c:FindFirstChild(_d({30,53,50,56,49},52))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({252,253,249,51,60,59,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({14,65,69,45,46,56,49,21,64,49,57,63},52))
local shopItem = buyables and buyables:FindFirstChild(_d({30,53,50,56,49},52))
local shopPart = shopItem and shopItem:FindFirstChild(_d({31,52,59,60,28,45,62,64},52))
if EasyTravel and shopPart and hrp then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,32,62,45,66,49,56,53,58,51,236,64,59,236,30,53,50,56,49,236,63,52,59,60,236,66,53,45,236,17,45,63,69,32,62,45,66,49,56,250,250,250},52))
local nocollide = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({17,66,49,58,64,63},52)) and ReplicatedStorage.Events:FindFirstChild(_d({31,52,59,60},52))
if shopEvent and shopEvent:IsA(_d({30,49,57,59,64,49,18,65,58,47,64,53,59,58},52)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,17,61,65,53,60,60,53,58,51,236,30,53,50,56,49,250,250,250},52))
local args = {
[1] = _d({49,61,65,53,60},52),
[2] = _d({30,53,50,56,49},52)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({17,66,49,58,64,63},52)) and ReplicatedStorage.Events:FindFirstChild(_d({32,59,59,56,63},52))
if toolsEvent and toolsEvent:IsA(_d({30,49,57,59,64,49,18,65,58,47,64,53,59,58},52)) then
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
local hrp = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,56,69,53,58,51,236,64,59,236,18,53,63,52,57,45,58,236,15,45,66,49,250,250,250},52))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({252,253,249,51,60,59,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,49,45,63,69,43,64,62,45,66,49,56,250,56,65,45},52))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,17,63,47,45,60,53,58,51,236,63,52,59,60,236,53,58,64,49,62,53,59,62,236,46,69,236,50,56,69,53,58,51,236,63,64,62,45,53,51,52,64,236,65,60,250,250,250},52))
local nocollide = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
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
local runService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
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
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,56,69,53,58,51,236,64,59,236,18,53,63,52,57,45,58,236,15,45,66,49,250,250,250},52))
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
local FishmanMaze = Core.Import(_d({252,253,249,51,60,59,251,56,53,46,251,50,53,63,52,57,45,58,43,57,45,70,49,250,56,65,45},52), _d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,50,53,63,52,57,45,58,43,57,45,70,49,250,56,65,45},52))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,53,57,60,59,62,64,236,18,53,63,52,57,45,58,25,45,70,49,236,56,53,46,62,45,62,69,237},52))
end
else
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,27,65,64,63,53,48,49,236,18,53,63,52,57,45,58,236,15,45,66,49,236,46,59,65,58,48,63,248,236,63,55,53,60,60,53,58,51,236,57,45,70,49,250},52))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({24,49,66,49,56,236,19,62,53,58,48,49,62},52),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()