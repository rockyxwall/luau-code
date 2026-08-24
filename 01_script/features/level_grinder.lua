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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({13,14,10,68,77,76,12,73,70,63,12,64,76,79,66,11,73,82,62},35)) then
Core = loadstring(readfile(_d({13,14,10,68,77,76,12,73,70,63,12,64,76,79,66,11,73,82,62},35)))()
else
Core = loadstring(game:HttpGet(_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,64,76,79,66,11,73,82,62},35)))()
end
end)
if not Core then warn(_d({56,32,76,79,66,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,254},35)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,48,81,76,77,77,66,65,11},35))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254},35)); return end
if not Safeguard then warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,254},35)); return end
if not Safeguard.RequirePlace(3978370137, _d({35,70,79,80,81,253,48,66,62},35)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35), 10)
local hum = char:WaitForChild(_d({37,82,74,62,75,76,70,65},35), 10)
local stats = ReplicatedStorage:WaitForChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({45,66,73,70},35), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35)) or (char and char:FindFirstChild(_d({47,70,67,73,66},35)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,32,82,79,79,66,75,81,253,45,66,73,70,253,64,69,66,64,72,23},35), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,43,76,81,253,62,81,253,49,76,84,75,253,76,67,253,31,66,68,70,75,75,70,75,68,80,11,253,45,73,66,62,80,66,253,81,79,62,83,66,73,253,81,69,66,79,66,253,81,76,253,67,62,79,74,253,64,69,66,80,81,80,253,84,69,70,73,66,253,84,62,70,81,70,75,68,253,67,76,79,253,47,70,67,73,66,11},35))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({13,14,10,68,77,76,12,73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,35,62,79,74,70,75,68,253,64,69,66,80,81,80,253,82,75,81,70,73,253,16,13,13,253,45,66,73,70,11,11,11,253,5,32,82,79,79,66,75,81,23,253},35) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({45,66,73,70},35))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35)) or (c and c:FindFirstChild(_d({47,70,67,73,66},35))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({13,14,10,68,77,76,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
_G.DisableStandalone = old
end
local buyables = workspace:FindFirstChild(_d({31,82,86,62,63,73,66,38,81,66,74,80},35))
local shopItem = buyables and buyables:FindFirstChild(_d({47,70,67,73,66},35))
local shopPart = shopItem and shopItem:FindFirstChild(_d({48,69,76,77,45,62,79,81},35))
if EasyTravel and shopPart and hrp then
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,49,79,62,83,66,73,70,75,68,253,81,76,253,47,70,67,73,66,253,80,69,76,77,253,83,70,62,253,34,62,80,86,49,79,62,83,66,73,11,11,11},35))
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({34,83,66,75,81,80},35)) and ReplicatedStorage.Events:FindFirstChild(_d({48,69,76,77},35))
if shopEvent and shopEvent:IsA(_d({47,66,74,76,81,66,35,82,75,64,81,70,76,75},35)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,34,78,82,70,77,77,70,75,68,253,47,70,67,73,66,11,11,11},35))
local args = {
[1] = _d({66,78,82,70,77},35),
[2] = _d({47,70,67,73,66},35)
}
pcall(function()
game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35)):WaitForChild(_d({34,83,66,75,81,80},35)):WaitForChild(_d({49,76,76,73,80},35)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65},35))
local hrp = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,35,73,86,70,75,68,253,81,76,253,35,70,80,69,74,62,75,253,32,62,83,66,11,11,11},35))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({13,14,10,68,77,76,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
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
Core.SetupStandalone(
LevelGrinder,
_d({41,66,83,66,73,253,36,79,70,75,65,66,79},35),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()