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
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({9,10,6,64,73,72,8,69,66,59,8,60,72,75,62,7,69,78,58},39)) then
Core = loadstring(readfile(_d({9,10,6,64,73,72,8,69,66,59,8,60,72,75,62,7,69,78,58},39)))()
else
Core = loadstring(game:HttpGet(_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,60,72,75,62,7,69,78,58},39)))()
end
end)
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.00,   4.1, -12190.00),
Vector3.new(1836.00, -86.0, -12190.00),
Vector3.new(1836.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12222.00),
Vector3.new(1767.20, -78.0, -12224.00),
Vector3.new(1767.20, -78.0, -12226.00),
Vector3.new(1767.20, -86.0, -12228.00),
Vector3.new(1790.00, -86.0, -12228.50),
Vector3.new(1791.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12320.00),
Vector3.new(1819.20, -78.0, -12322.00),
Vector3.new(1819.20, -78.0, -12324.00),
Vector3.new(1819.20, -86.0, -12326.00),
Vector3.new(1819.20, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12330.50),
}
function FishmanMaze.Travel(hrp, isRunning)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({9,10,6,64,73,72,8,69,66,59,8,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58},39), _d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,62,58,76,82,56,77,75,58,79,62,69,7,69,78,58},39))
if not EasyTravel then warn(_d({52,31,66,76,65,70,58,71,249,38,58,83,62,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,30,58,76,82,45,75,58,79,62,69,250},39)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({52,31,66,76,65,70,58,71,249,38,58,83,62,54,249,44,77,58,75,77,66,71,64,249,30,58,76,82,45,75,58,79,62,69,6,59,58,76,62,61,249,70,58,83,62,249,77,75,58,79,62,75,76,58,69,7,7,7},39))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({27,58,76,62,41,58,75,77},39)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
EasyTravel.Speed = 25
for i, target in ipairs(mazePath) do
EasyTravel.TargetPosition = target
pcall(EasyTravel.Start)
while (hrp.Position - target).Magnitude > 4 do
if isRunning and not isRunning() then break end
RunService.Heartbeat:Wait()
end
if isRunning and not isRunning() then break end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({52,31,66,76,65,70,58,71,249,38,58,83,62,54,249,28,72,70,73,69,62,77,62,7},39))
end
return FishmanMaze
end)()