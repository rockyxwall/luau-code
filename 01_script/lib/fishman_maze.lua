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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({2,3,255,57,66,65,1,62,59,52,1,53,65,68,55,0,62,71,51},46)) then
Core = loadstring(readfile(_d({2,3,255,57,66,65,1,62,59,52,1,53,65,68,55,0,62,71,51},46)))()
else
Core = loadstring(game:HttpGet(_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,62,71,51,71,255,53,65,54,55,1,63,51,59,64,1,2,3,49,69,53,68,59,66,70,1,62,59,52,1,53,65,68,55,0,62,71,51},46)))()
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
function FishmanMaze.Travel(hrp)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({2,3,255,57,66,65,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46), _d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,62,71,51,71,255,53,65,54,55,1,63,51,59,64,1,2,3,49,69,53,68,59,66,70,1,62,59,52,1,55,51,69,75,49,70,68,51,72,55,62,0,62,71,51},46))
if not EasyTravel then warn(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,23,51,69,75,38,68,51,72,55,62,243},46)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,37,70,51,68,70,59,64,57,242,23,51,69,75,38,68,51,72,55,62,255,52,51,69,55,54,242,63,51,76,55,242,70,68,51,72,55,68,69,51,62,0,0,0},46))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({20,51,69,55,34,51,68,70},46)) then
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
RunService.Heartbeat:Wait()
end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({45,24,59,69,58,63,51,64,242,31,51,76,55,47,242,21,65,63,66,62,55,70,55,0},46))
end
return FishmanMaze
end)()