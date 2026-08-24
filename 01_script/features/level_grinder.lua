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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
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
print(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,44,77,72,73,73,62,61,7},39))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,26,69,75,62,58,61,82,249,75,78,71,71,66,71,64,250},39)) return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39), 10)
local hum = char:WaitForChild(_d({33,78,70,58,71,72,66,61},39), 10)
ReplicatedStorage:WaitForChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name, 30)
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({43,66,63,69,62},39)) or char:FindFirstChild(_d({43,66,63,69,62},39))
if hasRifle then break end
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,39,72,77,249,58,77,249,45,72,80,71,249,72,63,249,27,62,64,66,71,71,66,71,64,76,7,249,41,69,62,58,76,62,249,77,75,58,79,62,69,249,77,65,62,75,62,249,77,72,249,63,58,75,70,249,60,65,62,76,77,76,249,80,65,66,69,62,249,80,58,66,77,66,71,64,249,63,72,75,249,43,66,63,69,62,7},39))
task.wait(2)
continue
end
if not ChestFarmer then
ChestFarmer = importLib(_d({69,66,59,8,60,65,62,76,77,56,63,58,75,70,62,75,7,69,78,58},39), _d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,60,65,62,76,77,56,63,58,75,70,62,75,7,69,78,58},39))
end
if ChestFarmer then
print(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,31,58,75,70,66,71,64,249,60,65,62,76,77,76,249,78,71,77,66,69,249,43,66,63,69,62,249,66,76,249,62,74,78,66,73,73,62,61,7,7,7},39))
ChestFarmer.FarmUntilPeli(9999999, function() return 0 end, function()
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({43,66,63,69,62},39)) or char:FindFirstChild(_d({43,66,63,69,62},39)))
end)
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({43,66,63,69,62},39))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,31,69,82,66,71,64,249,77,72,249,31,66,76,65,70,58,71,249,28,58,79,62,7,7,7},39))
if not EasyTravel then
EasyTravel = importLib(_d({69,66,59,8,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58},39), _d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58},39))
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
print(_d({52,37,62,79,62,69,249,32,75,66,71,61,62,75,54,249,44,77,58,71,61,58,69,72,71,62,249,38,72,61,62,19,249,41,75,62,76,76,249,0,54,0,249,77,72,249,76,77,72,73,7},39))
end
return LevelGrinder
end)()