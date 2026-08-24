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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({249,250,246,48,57,56,248,53,50,43,248,44,56,59,46,247,53,62,42},55)) then
Core = loadstring(readfile(_d({249,250,246,48,57,56,248,53,50,43,248,44,56,59,46,247,53,62,42},55)))()
else
Core = loadstring(game:HttpGet(_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,53,50,43,248,44,56,59,46,247,53,62,42},55)))()
end
end)
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.0,   4.1, -12190.0),
Vector3.new(1836.0, -86.0, -12190.0),
Vector3.new(1836.0, -86.0, -12214.0),
Vector3.new(1770.0, -86.0, -12214.0),
Vector3.new(1770.0, -86.0, -12222.0),
Vector3.new(1770.0, -78.0, -12224.0),
Vector3.new(1770.0, -78.0, -12226.0),
Vector3.new(1770.0, -86.0, -12228.0),
Vector3.new(1790.0, -86.0, -12230.0),
Vector3.new(1790.0, -86.0, -12246.0),
Vector3.new(1782.0, -86.0, -12246.0),
Vector3.new(1782.0, -86.0, -12278.0),
Vector3.new(1802.0, -86.0, -12278.0),
Vector3.new(1810.0, -86.0, -12280.0),
Vector3.new(1810.0, -86.0, -12300.0),
Vector3.new(1846.0, -86.0, -12300.0),
Vector3.new(1846.0, -86.0, -12308.0),
Vector3.new(1822.0, -86.0, -12308.0),
Vector3.new(1822.0, -86.0, -12320.0),
Vector3.new(1822.0, -78.0, -12322.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -86.0, -12326.0),
Vector3.new(1822.0, -86.0, -12328.0),
Vector3.new(1796.0, -86.0, -12328.0),
Vector3.new(1793.7, -86.0, -12330.5),
}
function FishmanMaze.Travel(hrp, isRunning)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({249,250,246,48,57,56,248,53,50,43,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55), _d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,53,50,43,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55))
if not EasyTravel then warn(_d({36,15,50,60,49,54,42,55,233,22,42,67,46,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,14,42,60,66,29,59,42,63,46,53,234},55)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({36,15,50,60,49,54,42,55,233,22,42,67,46,38,233,28,61,42,59,61,50,55,48,233,14,42,60,66,29,59,42,63,46,53,246,43,42,60,46,45,233,54,42,67,46,233,61,59,42,63,46,59,60,42,53,247,247,247},55))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
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
print(_d({36,15,50,60,49,54,42,55,233,22,42,67,46,38,233,12,56,54,57,53,46,61,46,247},55))
end
return FishmanMaze
end)()