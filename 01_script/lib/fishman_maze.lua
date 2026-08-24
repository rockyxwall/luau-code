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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.0, 4.1, -12190.0),
Vector3.new(1836.0, -95.0, -12190.0),
Vector3.new(1836.0, -95.0, -12214.0),
Vector3.new(1770.0, -95.0, -12214.0),
Vector3.new(1770.0, -95.0, -12222.0),
Vector3.new(1770.0, -81.0, -12224.0),
Vector3.new(1770.0, -81.0, -12226.0),
Vector3.new(1770.0, -95.0, -12228.0),
Vector3.new(1770.0, -95.0, -12230.0),
Vector3.new(1790.0, -95.0, -12230.0),
Vector3.new(1790.0, -95.0, -12246.0),
Vector3.new(1782.0, -95.0, -12246.0),
Vector3.new(1782.0, -95.0, -12278.0),
Vector3.new(1802.0, -95.0, -12278.0),
Vector3.new(1802.0, -95.0, -12280.0),
Vector3.new(1810.0, -95.0, -12280.0),
Vector3.new(1810.0, -95.0, -12300.0),
Vector3.new(1846.0, -95.0, -12300.0),
Vector3.new(1846.0, -95.0, -12308.0),
Vector3.new(1822.0, -95.0, -12308.0),
Vector3.new(1822.0, -95.0, -12320.0),
Vector3.new(1822.0, -78.0, -12322.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -95.0, -12326.0),
Vector3.new(1822.0, -95.0, -12328.0),
Vector3.new(1796.0, -95.0, -12328.0),
Vector3.new(1793.7, -95.0, -12330.5)
}
function FishmanMaze.Travel(hrp)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
if not EasyTravel then warn(_d({43,22,57,67,56,61,49,62,240,29,49,74,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,21,49,67,73,36,66,49,70,53,60,241},48)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({43,22,57,67,56,61,49,62,240,29,49,74,53,45,240,35,68,49,66,68,57,62,55,240,21,49,67,73,36,66,49,70,53,60,253,50,49,67,53,52,240,61,49,74,53,240,68,66,49,70,53,66,67,49,60,254,254,254},48))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({18,49,67,53,32,49,66,68},48)) then
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
print(_d({43,22,57,67,56,61,49,62,240,29,49,74,53,45,240,19,63,61,64,60,53,68,53,254},48))
end
return FishmanMaze
end)()