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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({21,22,18,76,85,84,20,81,78,71,20,72,84,87,74,19,81,90,70},27)) then
Core = loadstring(readfile(_d({21,22,18,76,85,84,20,81,78,71,20,72,84,87,74,19,81,90,70},27)))()
else
Core = loadstring(game:HttpGet(_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,72,84,87,74,19,81,90,70},27)))()
end
end)
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.0,   4.1, -12190.0),
Vector3.new(1836.0, -86.0, -12190.0),
Vector3.new(1836.0, -86.0, -12213.0),
Vector3.new(1770.0, -86.0, -12213.0),
Vector3.new(1767.0, -86.0, -12213.0),
Vector3.new(1767.0, -86.0, -12222.0),
Vector3.new(1767.0, -78.0, -12222.0),
Vector3.new(1767.0, -78.0, -12226.0),
Vector3.new(1767.0, -86.0, -12228.0),
Vector3.new(1790.0, -86.0, -12230.0),
Vector3.new(1790.0, -86.0, -12246.0),
Vector3.new(1780.0, -86.0, -12246.0),
Vector3.new(1780.0, -86.0, -12278.0),
Vector3.new(1810.0, -86.0, -12278.0),
Vector3.new(1810.0, -86.0, -12280.0),
Vector3.new(1810.0, -86.0, -12300.0),
Vector3.new(1846.0, -86.0, -12300.0),
Vector3.new(1846.0, -86.0, -12308.0),
Vector3.new(1822.0, -86.0, -12308.0),
Vector3.new(1822.0, -86.0, -12320.0),
Vector3.new(1822.0, -78.0, -12320.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -86.0, -12325.0),
Vector3.new(1822.0, -86.0, -12328.0),
Vector3.new(1796.0, -86.0, -12328.0),
Vector3.new(1793.7, -86.0, -12329.0),
}
function FishmanMaze.Travel(hrp, isRunning)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({21,22,18,76,85,84,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27), _d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,81,78,71,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27))
if not EasyTravel then warn(_d({64,43,78,88,77,82,70,83,5,50,70,95,74,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,42,70,88,94,57,87,70,91,74,81,6},27)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({64,43,78,88,77,82,70,83,5,50,70,95,74,66,5,56,89,70,87,89,78,83,76,5,42,70,88,94,57,87,70,91,74,81,18,71,70,88,74,73,5,82,70,95,74,5,89,87,70,91,74,87,88,70,81,19,19,19},27))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({39,70,88,74,53,70,87,89},27)) then
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
print(_d({64,43,78,88,77,82,70,83,5,50,70,95,74,66,5,40,84,82,85,81,74,89,74,19},27))
end
return FishmanMaze
end)()