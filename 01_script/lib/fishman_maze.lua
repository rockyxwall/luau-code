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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
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
local EasyTravel = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43))
if not EasyTravel then warn(_d({48,27,62,72,61,66,54,67,245,34,54,79,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,245,26,54,72,78,41,71,54,75,58,65,246},43)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({48,27,62,72,61,66,54,67,245,34,54,79,58,50,245,40,73,54,71,73,62,67,60,245,26,54,72,78,41,71,54,75,58,65,2,55,54,72,58,57,245,66,54,79,58,245,73,71,54,75,58,71,72,54,65,3,3,3},43))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({23,54,72,58,37,54,71,73},43)) then
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
print(_d({48,27,62,72,61,66,54,67,245,34,54,79,58,50,245,24,68,66,69,65,58,73,58,3},43))
end
return FishmanMaze
end)()