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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({14,15,11,69,78,77,13,74,71,64,13,65,77,80,67,12,74,83,63},34)) then
Core = loadstring(readfile(_d({14,15,11,69,78,77,13,74,71,64,13,65,77,80,67,12,74,83,63},34)))()
else
Core = loadstring(game:HttpGet(_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,65,77,80,67,12,74,83,63},34)))()
end
end)
if not Core then warn(_d({57,33,77,80,67,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,255},34)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,49,82,77,78,78,67,66,12},34))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,31,74,80,67,63,66,87,254,80,83,76,76,71,76,69,255},34)); return end
if not Safeguard then warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,255},34)); return end
if not Safeguard.RequirePlace(3978370137, _d({36,71,80,81,82,254,49,67,63},34)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34), 10)
local hum = char:WaitForChild(_d({38,83,75,63,76,77,71,66},34), 10)
local stats = ReplicatedStorage:WaitForChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({46,67,74,71},34), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({48,71,68,74,67},34)) or (char and char:FindFirstChild(_d({48,71,68,74,67},34)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,33,83,80,80,67,76,82,254,46,67,74,71,254,65,70,67,65,73,24},34), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,44,77,82,254,63,82,254,50,77,85,76,254,77,68,254,32,67,69,71,76,76,71,76,69,81,12,254,46,74,67,63,81,67,254,82,80,63,84,67,74,254,82,70,67,80,67,254,82,77,254,68,63,80,75,254,65,70,67,81,82,81,254,85,70,71,74,67,254,85,63,71,82,71,76,69,254,68,77,80,254,48,71,68,74,67,12},34))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({14,15,11,69,78,77,13,74,71,64,13,65,70,67,81,82,61,68,63,80,75,67,80,12,74,83,63},34), _d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,65,70,67,81,82,61,68,63,80,75,67,80,12,74,83,63},34))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,36,63,80,75,71,76,69,254,65,70,67,81,82,81,254,83,76,82,71,74,254,17,14,14,254,46,67,74,71,12,12,12,254,6,33,83,80,80,67,76,82,24,254},34) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({46,67,74,71},34))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({48,71,68,74,67},34)) or (c and c:FindFirstChild(_d({48,71,68,74,67},34))))
end)
else
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,44,63,84,71,69,63,82,71,76,69,254,82,77,254,64,83,87,254,48,71,68,74,67,12,12,12},34))
local buyables = workspace:FindFirstChild(_d({32,83,87,63,64,74,67,39,82,67,75,81},34))
local shopItem = buyables and buyables:FindFirstChild(_d({48,71,68,74,67},34))
local shopPart = shopItem and shopItem:FindFirstChild(_d({49,70,77,78,46,63,80,82},34))
if shopPart and hrp then
hrp.CFrame = shopPart.CFrame * CFrame.new(0, 3, 0)
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({35,84,67,76,82,81},34)) and ReplicatedStorage.Events:FindFirstChild(_d({49,70,77,78},34))
if shopEvent and shopEvent:IsA(_d({48,67,75,77,82,67,36,83,76,65,82,71,77,76},34)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,35,79,83,71,78,78,71,76,69,254,48,71,68,74,67,12,12,12},34))
local args = {
[1] = _d({67,79,83,71,78},34),
[2] = _d({48,71,68,74,67},34)
}
pcall(function()
game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34)):WaitForChild(_d({35,84,67,76,82,81},34)):WaitForChild(_d({50,77,77,74,81},34)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66},34))
local hrp = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({48,71,68,74,67},34))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,36,74,87,71,76,69,254,82,77,254,36,71,81,70,75,63,76,254,33,63,84,67,12,12,12},34))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({14,15,11,69,78,77,13,74,71,64,13,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63},34), _d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,67,63,81,87,61,82,80,63,84,67,74,12,74,83,63},34))
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
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
if LevelGrinder.Running then
print(_d({57,42,67,84,67,74,254,37,80,71,76,66,67,80,59,254,49,82,63,76,66,63,74,77,76,67,254,43,77,66,67,24,254,46,80,67,81,81,254,5,59,5,254,82,77,254,81,82,77,78,12},34))
end
end
return LevelGrinder
end)()