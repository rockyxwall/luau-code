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
Vector3.new(1836.0, 4.1, -12190.0),
Vector3.new(1836.0, -92.5, -12190.0),
Vector3.new(1836.0, -92.5, -12192.0),
Vector3.new(1836.0, -92.5, -12194.0),
Vector3.new(1836.0, -92.5, -12196.0),
Vector3.new(1836.0, -92.5, -12198.0),
Vector3.new(1836.0, -92.5, -12200.0),
Vector3.new(1836.0, -92.5, -12202.0),
Vector3.new(1836.0, -92.5, -12204.0),
Vector3.new(1836.0, -92.5, -12206.0),
Vector3.new(1836.0, -92.5, -12208.0),
Vector3.new(1836.0, -92.5, -12210.0),
Vector3.new(1836.0, -92.5, -12212.0),
Vector3.new(1836.0, -92.5, -12214.0),
Vector3.new(1834.0, -92.5, -12214.0),
Vector3.new(1832.0, -92.5, -12214.0),
Vector3.new(1830.0, -92.5, -12214.0),
Vector3.new(1828.0, -92.5, -12214.0),
Vector3.new(1826.0, -92.5, -12214.0),
Vector3.new(1824.0, -92.5, -12214.0),
Vector3.new(1822.0, -92.5, -12214.0),
Vector3.new(1820.0, -92.5, -12214.0),
Vector3.new(1818.0, -92.5, -12214.0),
Vector3.new(1816.0, -92.5, -12214.0),
Vector3.new(1814.0, -92.5, -12214.0),
Vector3.new(1812.0, -92.5, -12214.0),
Vector3.new(1810.0, -92.5, -12214.0),
Vector3.new(1808.0, -92.5, -12214.0),
Vector3.new(1806.0, -92.5, -12214.0),
Vector3.new(1804.0, -92.5, -12214.0),
Vector3.new(1802.0, -92.5, -12214.0),
Vector3.new(1800.0, -92.5, -12214.0),
Vector3.new(1798.0, -92.5, -12214.0),
Vector3.new(1798.0, -92.5, -12216.0),
Vector3.new(1798.0, -92.5, -12218.0),
Vector3.new(1798.0, -92.5, -12220.0),
Vector3.new(1798.0, -92.5, -12222.0),
Vector3.new(1796.0, -92.5, -12222.0),
Vector3.new(1794.0, -92.5, -12222.0),
Vector3.new(1792.0, -92.5, -12222.0),
Vector3.new(1790.0, -92.5, -12222.0),
Vector3.new(1788.0, -92.5, -12222.0),
Vector3.new(1786.0, -92.5, -12222.0),
Vector3.new(1784.0, -92.5, -12222.0),
Vector3.new(1782.0, -92.5, -12222.0),
Vector3.new(1780.0, -92.5, -12222.0),
Vector3.new(1778.0, -92.5, -12222.0),
Vector3.new(1776.0, -92.5, -12222.0),
Vector3.new(1774.0, -92.5, -12222.0),
Vector3.new(1772.0, -92.5, -12222.0),
Vector3.new(1770.0, -92.5, -12222.0),
Vector3.new(1770.0, -81.0, -12224.0),
Vector3.new(1770.0, -81.0, -12226.0),
Vector3.new(1770.0, -92.5, -12228.0),
Vector3.new(1770.0, -92.5, -12230.0),
Vector3.new(1772.0, -92.5, -12230.0),
Vector3.new(1774.0, -92.5, -12230.0),
Vector3.new(1776.0, -92.5, -12230.0),
Vector3.new(1778.0, -92.5, -12230.0),
Vector3.new(1780.0, -92.5, -12230.0),
Vector3.new(1782.0, -92.5, -12230.0),
Vector3.new(1784.0, -92.5, -12230.0),
Vector3.new(1786.0, -92.5, -12230.0),
Vector3.new(1788.0, -92.5, -12230.0),
Vector3.new(1790.0, -92.5, -12230.0),
Vector3.new(1790.0, -92.5, -12232.0),
Vector3.new(1790.0, -92.5, -12234.0),
Vector3.new(1790.0, -92.5, -12236.0),
Vector3.new(1790.0, -92.5, -12238.0),
Vector3.new(1790.0, -92.5, -12240.0),
Vector3.new(1790.0, -92.5, -12242.0),
Vector3.new(1790.0, -92.5, -12244.0),
Vector3.new(1790.0, -92.5, -12246.0),
Vector3.new(1788.0, -92.5, -12246.0),
Vector3.new(1786.0, -92.5, -12246.0),
Vector3.new(1784.0, -92.5, -12246.0),
Vector3.new(1782.0, -92.5, -12246.0),
Vector3.new(1782.0, -92.5, -12248.0),
Vector3.new(1782.0, -92.5, -12250.0),
Vector3.new(1782.0, -92.5, -12252.0),
Vector3.new(1782.0, -92.5, -12254.0),
Vector3.new(1782.0, -92.5, -12256.0),
Vector3.new(1782.0, -92.5, -12258.0),
Vector3.new(1782.0, -92.5, -12260.0),
Vector3.new(1782.0, -92.5, -12262.0),
Vector3.new(1782.0, -92.5, -12264.0),
Vector3.new(1782.0, -92.5, -12266.0),
Vector3.new(1782.0, -92.5, -12268.0),
Vector3.new(1782.0, -92.5, -12270.0),
Vector3.new(1782.0, -92.5, -12272.0),
Vector3.new(1782.0, -92.5, -12274.0),
Vector3.new(1782.0, -92.5, -12276.0),
Vector3.new(1782.0, -92.5, -12278.0),
Vector3.new(1784.0, -92.5, -12278.0),
Vector3.new(1786.0, -92.5, -12278.0),
Vector3.new(1788.0, -92.5, -12278.0),
Vector3.new(1790.0, -92.5, -12278.0),
Vector3.new(1792.0, -92.5, -12278.0),
Vector3.new(1794.0, -92.5, -12278.0),
Vector3.new(1796.0, -92.5, -12278.0),
Vector3.new(1798.0, -92.5, -12278.0),
Vector3.new(1800.0, -92.5, -12278.0),
Vector3.new(1802.0, -92.5, -12278.0),
Vector3.new(1802.0, -92.5, -12280.0),
Vector3.new(1804.0, -92.5, -12280.0),
Vector3.new(1806.0, -92.5, -12280.0),
Vector3.new(1808.0, -92.5, -12280.0),
Vector3.new(1810.0, -92.5, -12280.0),
Vector3.new(1810.0, -92.5, -12282.0),
Vector3.new(1810.0, -92.5, -12284.0),
Vector3.new(1810.0, -92.5, -12286.0),
Vector3.new(1810.0, -92.5, -12288.0),
Vector3.new(1810.0, -92.5, -12290.0),
Vector3.new(1810.0, -92.5, -12292.0),
Vector3.new(1810.0, -92.5, -12294.0),
Vector3.new(1810.0, -92.5, -12296.0),
Vector3.new(1810.0, -92.5, -12298.0),
Vector3.new(1810.0, -92.5, -12300.0),
Vector3.new(1812.0, -92.5, -12300.0),
Vector3.new(1814.0, -92.5, -12300.0),
Vector3.new(1816.0, -92.5, -12300.0),
Vector3.new(1818.0, -92.5, -12300.0),
Vector3.new(1820.0, -92.5, -12300.0),
Vector3.new(1822.0, -92.5, -12300.0),
Vector3.new(1824.0, -92.5, -12300.0),
Vector3.new(1826.0, -92.5, -12300.0),
Vector3.new(1828.0, -92.5, -12300.0),
Vector3.new(1830.0, -92.5, -12300.0),
Vector3.new(1832.0, -92.5, -12300.0),
Vector3.new(1834.0, -92.5, -12300.0),
Vector3.new(1836.0, -92.5, -12300.0),
Vector3.new(1838.0, -92.5, -12300.0),
Vector3.new(1840.0, -92.5, -12300.0),
Vector3.new(1842.0, -92.5, -12300.0),
Vector3.new(1844.0, -92.5, -12300.0),
Vector3.new(1846.0, -92.5, -12300.0),
Vector3.new(1846.0, -92.5, -12302.0),
Vector3.new(1846.0, -92.5, -12304.0),
Vector3.new(1846.0, -92.5, -12306.0),
Vector3.new(1846.0, -92.5, -12308.0),
Vector3.new(1844.0, -92.5, -12308.0),
Vector3.new(1842.0, -92.5, -12308.0),
Vector3.new(1840.0, -92.5, -12308.0),
Vector3.new(1838.0, -92.5, -12308.0),
Vector3.new(1836.0, -92.5, -12308.0),
Vector3.new(1834.0, -92.5, -12308.0),
Vector3.new(1832.0, -92.5, -12308.0),
Vector3.new(1830.0, -92.5, -12308.0),
Vector3.new(1828.0, -92.5, -12308.0),
Vector3.new(1826.0, -92.5, -12308.0),
Vector3.new(1824.0, -92.5, -12308.0),
Vector3.new(1822.0, -92.5, -12308.0),
Vector3.new(1822.0, -92.5, -12310.0),
Vector3.new(1822.0, -92.5, -12312.0),
Vector3.new(1822.0, -92.5, -12314.0),
Vector3.new(1822.0, -92.5, -12316.0),
Vector3.new(1822.0, -92.5, -12318.0),
Vector3.new(1822.0, -92.5, -12320.0),
Vector3.new(1822.0, -78.0, -12322.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -92.5, -12326.0),
Vector3.new(1822.0, -92.5, -12328.0),
Vector3.new(1820.0, -92.5, -12328.0),
Vector3.new(1818.0, -92.5, -12328.0),
Vector3.new(1816.0, -92.5, -12328.0),
Vector3.new(1814.0, -92.5, -12328.0),
Vector3.new(1812.0, -92.5, -12328.0),
Vector3.new(1810.0, -92.5, -12328.0),
Vector3.new(1808.0, -92.5, -12328.0),
Vector3.new(1806.0, -92.5, -12328.0),
Vector3.new(1804.0, -92.5, -12328.0),
Vector3.new(1802.0, -92.5, -12328.0),
Vector3.new(1800.0, -92.5, -12328.0),
Vector3.new(1798.0, -92.5, -12328.0),
Vector3.new(1796.0, -92.5, -12328.0),
Vector3.new(1793.7, -92.5, -12330.5)
}
function FishmanMaze.Travel(hrp)
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
RunService.Heartbeat:Wait()
end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({52,31,66,76,65,70,58,71,249,38,58,83,62,54,249,28,72,70,73,69,62,77,62,7},39))
end
return FishmanMaze
end)()