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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local function importLib(localPath, rawUrl)
local loaded = false
local result = nil
local oldLazyHub = _G.lazyhub
_G.lazyhub = true
if isfile and readfile then
pcall(function()
if isfile(localPath) then
result = loadstring(readfile(localPath))()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(rawUrl))() end)
end
_G.lazyhub = oldLazyHub
return result
end
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,67,100,95,96,96,85,84,30},16))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,49,92,98,85,81,84,105,16,98,101,94,94,89,94,87,17},16)); return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16), 10)
local hum = char:WaitForChild(_d({56,101,93,81,94,95,89,84},16), 10)
ReplicatedStorage:WaitForChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name, 30)
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16)) or char:FindFirstChild(_d({66,89,86,92,85},16))
if hasRifle then break end
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,62,95,100,16,81,100,16,68,95,103,94,16,95,86,16,50,85,87,89,94,94,89,94,87,99,30,16,64,92,85,81,99,85,16,100,98,81,102,85,92,16,100,88,85,98,85,16,100,95,16,86,81,98,93,16,83,88,85,99,100,99,16,103,88,89,92,85,16,103,81,89,100,89,94,87,16,86,95,98,16,66,89,86,92,85,30},16))
task.wait(2)
continue
end
if not ChestFarmer then
ChestFarmer = importLib(_d({92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16))
end
if ChestFarmer then
print(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,54,81,98,93,89,94,87,16,83,88,85,99,100,99,16,101,94,100,89,92,16,66,89,86,92,85,16,89,99,16,85,97,101,89,96,96,85,84,30,30,30},16))
ChestFarmer.FarmUntilPeli(9999999, function() return 0 end, function()
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16)) or char:FindFirstChild(_d({66,89,86,92,85},16)))
end)
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,54,92,105,89,94,87,16,100,95,16,54,89,99,88,93,81,94,16,51,81,102,85,30,30,30},16))
if not EasyTravel then
EasyTravel = importLib(_d({92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16))
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
if not _G.lazyhub then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
print(_d({75,60,85,102,85,92,16,55,98,89,94,84,85,98,77,16,67,100,81,94,84,81,92,95,94,85,16,61,95,84,85,42,16,64,98,85,99,99,16,23,77,23,16,100,95,16,99,100,95,96,30},16))
end
return LevelGrinder
end)()