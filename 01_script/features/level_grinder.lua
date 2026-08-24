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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({25,26,22,80,89,88,24,85,82,75,24,76,88,91,78,23,85,94,74},23)) then
Core = loadstring(readfile(_d({25,26,22,80,89,88,24,85,82,75,24,76,88,91,78,23,85,94,74},23)))()
else
Core = loadstring(game:HttpGet(_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,76,88,91,78,23,85,94,74},23)))()
end
end)
if not Core then warn(_d({68,44,88,91,78,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,10},23)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,60,93,88,89,89,78,77,23},23))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,42,85,91,78,74,77,98,9,91,94,87,87,82,87,80,10},23)); return end
if not Safeguard then warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,10},23)); return end
if not Safeguard.RequirePlace(3978370137, _d({47,82,91,92,93,9,60,78,74},23)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23), 10)
local hum = char:WaitForChild(_d({49,94,86,74,87,88,82,77},23), 10)
local stats = ReplicatedStorage:WaitForChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({57,78,85,82},23), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or (char and char:FindFirstChild(_d({59,82,79,85,78},23)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,44,94,91,91,78,87,93,9,57,78,85,82,9,76,81,78,76,84,35},23), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,55,88,93,9,74,93,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,23,9,57,85,78,74,92,78,9,93,91,74,95,78,85,9,93,81,78,91,78,9,93,88,9,79,74,91,86,9,76,81,78,92,93,92,9,96,81,82,85,78,9,96,74,82,93,82,87,80,9,79,88,91,9,59,82,79,85,78,23},23))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({25,26,22,80,89,88,24,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,47,74,91,86,82,87,80,9,76,81,78,92,93,92,9,94,87,93,82,85,9,28,25,25,9,57,78,85,82,23,23,23,9,17,44,94,91,91,78,87,93,35,9},23) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({57,78,85,82},23))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or (c and c:FindFirstChild(_d({59,82,79,85,78},23))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({25,26,22,80,89,88,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
_G.DisableStandalone = old
end
local buyables = workspace:FindFirstChild(_d({43,94,98,74,75,85,78,50,93,78,86,92},23))
local shopItem = buyables and buyables:FindFirstChild(_d({59,82,79,85,78},23))
local shopPart = shopItem and shopItem:FindFirstChild(_d({60,81,88,89,57,74,91,93},23))
if EasyTravel and shopPart and hrp then
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,61,91,74,95,78,85,82,87,80,9,93,88,9,59,82,79,85,78,9,92,81,88,89,9,95,82,74,9,46,74,92,98,61,91,74,95,78,85,23,23,23},23))
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({46,95,78,87,93,92},23)) and ReplicatedStorage.Events:FindFirstChild(_d({60,81,88,89},23))
if shopEvent and shopEvent:IsA(_d({59,78,86,88,93,78,47,94,87,76,93,82,88,87},23)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,46,90,94,82,89,89,82,87,80,9,59,82,79,85,78,23,23,23},23))
local args = {
[1] = _d({78,90,94,82,89},23),
[2] = _d({59,82,79,85,78},23)
}
pcall(function()
game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23)):WaitForChild(_d({46,95,78,87,93,92},23)):WaitForChild(_d({61,88,88,85,92},23)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77},23))
local hrp = char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,47,85,98,82,87,80,9,93,88,9,47,82,92,81,86,74,87,9,44,74,95,78,23,23,23},23))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({25,26,22,80,89,88,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
_G.DisableStandalone = old
end
if EasyTravel then
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 50 then break end
task.wait(1)
end
pcall(EasyTravel.Stop)
end
LevelGrinder.Stop()
end)
end
if not _G.DisableStandalone then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if LevelGrinder.Running then
LevelGrinder.Stop()
else
LevelGrinder.Start()
end
end
end))
LevelGrinder.Start()
print(_d({68,53,78,95,78,85,9,48,91,82,87,77,78,91,70,9,60,93,74,87,77,74,85,88,87,78,9,54,88,77,78,35,9,57,91,78,92,92,9,16,57,16,9,93,88,9,93,88,80,80,85,78,23},23))
end
return LevelGrinder
end)()