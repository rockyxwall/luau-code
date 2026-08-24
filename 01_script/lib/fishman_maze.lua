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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({26,27,23,81,90,89,25,86,83,76,25,77,89,92,79,24,86,95,75},22)) then
Core = loadstring(readfile(_d({26,27,23,81,90,89,25,86,83,76,25,77,89,92,79,24,86,95,75},22)))()
else
Core = loadstring(game:HttpGet(_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,86,95,75,95,23,77,89,78,79,25,87,75,83,88,25,26,27,73,93,77,92,83,90,94,25,86,83,76,25,77,89,92,79,24,86,95,75},22)))()
end
end)
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.0, 4.1, -12190.0),
Vector3.new(1836.0, -95.0, -12190.0),
Vector3.new(1836.0, -95.0, -12192.0),
Vector3.new(1836.0, -95.0, -12194.0),
Vector3.new(1836.0, -95.0, -12196.0),
Vector3.new(1836.0, -95.0, -12198.0),
Vector3.new(1836.0, -95.0, -12200.0),
Vector3.new(1836.0, -95.0, -12202.0),
Vector3.new(1836.0, -95.0, -12204.0),
Vector3.new(1836.0, -95.0, -12206.0),
Vector3.new(1836.0, -95.0, -12208.0),
Vector3.new(1836.0, -95.0, -12210.0),
Vector3.new(1836.0, -95.0, -12212.0),
Vector3.new(1836.0, -95.0, -12214.0),
Vector3.new(1834.0, -95.0, -12214.0),
Vector3.new(1832.0, -95.0, -12214.0),
Vector3.new(1830.0, -95.0, -12214.0),
Vector3.new(1828.0, -95.0, -12214.0),
Vector3.new(1826.0, -95.0, -12214.0),
Vector3.new(1824.0, -95.0, -12214.0),
Vector3.new(1822.0, -95.0, -12214.0),
Vector3.new(1820.0, -95.0, -12214.0),
Vector3.new(1818.0, -95.0, -12214.0),
Vector3.new(1816.0, -95.0, -12214.0),
Vector3.new(1814.0, -95.0, -12214.0),
Vector3.new(1812.0, -95.0, -12214.0),
Vector3.new(1810.0, -95.0, -12214.0),
Vector3.new(1808.0, -95.0, -12214.0),
Vector3.new(1806.0, -95.0, -12214.0),
Vector3.new(1804.0, -95.0, -12214.0),
Vector3.new(1802.0, -95.0, -12214.0),
Vector3.new(1800.0, -95.0, -12214.0),
Vector3.new(1798.0, -95.0, -12214.0),
Vector3.new(1798.0, -95.0, -12216.0),
Vector3.new(1798.0, -95.0, -12218.0),
Vector3.new(1798.0, -95.0, -12220.0),
Vector3.new(1798.0, -95.0, -12222.0),
Vector3.new(1796.0, -95.0, -12222.0),
Vector3.new(1794.0, -95.0, -12222.0),
Vector3.new(1792.0, -95.0, -12222.0),
Vector3.new(1790.0, -95.0, -12222.0),
Vector3.new(1788.0, -95.0, -12222.0),
Vector3.new(1786.0, -95.0, -12222.0),
Vector3.new(1784.0, -95.0, -12222.0),
Vector3.new(1782.0, -95.0, -12222.0),
Vector3.new(1780.0, -95.0, -12222.0),
Vector3.new(1778.0, -95.0, -12222.0),
Vector3.new(1776.0, -95.0, -12222.0),
Vector3.new(1774.0, -95.0, -12222.0),
Vector3.new(1772.0, -95.0, -12222.0),
Vector3.new(1770.0, -95.0, -12222.0),
Vector3.new(1770.0, -81.0, -12224.0),
Vector3.new(1770.0, -81.0, -12226.0),
Vector3.new(1770.0, -95.0, -12228.0),
Vector3.new(1770.0, -95.0, -12230.0),
Vector3.new(1772.0, -95.0, -12230.0),
Vector3.new(1774.0, -95.0, -12230.0),
Vector3.new(1776.0, -95.0, -12230.0),
Vector3.new(1778.0, -95.0, -12230.0),
Vector3.new(1780.0, -95.0, -12230.0),
Vector3.new(1782.0, -95.0, -12230.0),
Vector3.new(1784.0, -95.0, -12230.0),
Vector3.new(1786.0, -95.0, -12230.0),
Vector3.new(1788.0, -95.0, -12230.0),
Vector3.new(1790.0, -95.0, -12230.0),
Vector3.new(1790.0, -95.0, -12232.0),
Vector3.new(1790.0, -95.0, -12234.0),
Vector3.new(1790.0, -95.0, -12236.0),
Vector3.new(1790.0, -95.0, -12238.0),
Vector3.new(1790.0, -95.0, -12240.0),
Vector3.new(1790.0, -95.0, -12242.0),
Vector3.new(1790.0, -95.0, -12244.0),
Vector3.new(1790.0, -95.0, -12246.0),
Vector3.new(1788.0, -95.0, -12246.0),
Vector3.new(1786.0, -95.0, -12246.0),
Vector3.new(1784.0, -95.0, -12246.0),
Vector3.new(1782.0, -95.0, -12246.0),
Vector3.new(1782.0, -95.0, -12248.0),
Vector3.new(1782.0, -95.0, -12250.0),
Vector3.new(1782.0, -95.0, -12252.0),
Vector3.new(1782.0, -95.0, -12254.0),
Vector3.new(1782.0, -95.0, -12256.0),
Vector3.new(1782.0, -95.0, -12258.0),
Vector3.new(1782.0, -95.0, -12260.0),
Vector3.new(1782.0, -95.0, -12262.0),
Vector3.new(1782.0, -95.0, -12264.0),
Vector3.new(1782.0, -95.0, -12266.0),
Vector3.new(1782.0, -95.0, -12268.0),
Vector3.new(1782.0, -95.0, -12270.0),
Vector3.new(1782.0, -95.0, -12272.0),
Vector3.new(1782.0, -95.0, -12274.0),
Vector3.new(1782.0, -95.0, -12276.0),
Vector3.new(1782.0, -95.0, -12278.0),
Vector3.new(1784.0, -95.0, -12278.0),
Vector3.new(1786.0, -95.0, -12278.0),
Vector3.new(1788.0, -95.0, -12278.0),
Vector3.new(1790.0, -95.0, -12278.0),
Vector3.new(1792.0, -95.0, -12278.0),
Vector3.new(1794.0, -95.0, -12278.0),
Vector3.new(1796.0, -95.0, -12278.0),
Vector3.new(1798.0, -95.0, -12278.0),
Vector3.new(1800.0, -95.0, -12278.0),
Vector3.new(1802.0, -95.0, -12278.0),
Vector3.new(1802.0, -95.0, -12280.0),
Vector3.new(1804.0, -95.0, -12280.0),
Vector3.new(1806.0, -95.0, -12280.0),
Vector3.new(1808.0, -95.0, -12280.0),
Vector3.new(1810.0, -95.0, -12280.0),
Vector3.new(1810.0, -95.0, -12282.0),
Vector3.new(1810.0, -95.0, -12284.0),
Vector3.new(1810.0, -95.0, -12286.0),
Vector3.new(1810.0, -95.0, -12288.0),
Vector3.new(1810.0, -95.0, -12290.0),
Vector3.new(1810.0, -95.0, -12292.0),
Vector3.new(1810.0, -95.0, -12294.0),
Vector3.new(1810.0, -95.0, -12296.0),
Vector3.new(1810.0, -95.0, -12298.0),
Vector3.new(1810.0, -95.0, -12300.0),
Vector3.new(1812.0, -95.0, -12300.0),
Vector3.new(1814.0, -95.0, -12300.0),
Vector3.new(1816.0, -95.0, -12300.0),
Vector3.new(1818.0, -95.0, -12300.0),
Vector3.new(1820.0, -95.0, -12300.0),
Vector3.new(1822.0, -95.0, -12300.0),
Vector3.new(1824.0, -95.0, -12300.0),
Vector3.new(1826.0, -95.0, -12300.0),
Vector3.new(1828.0, -95.0, -12300.0),
Vector3.new(1830.0, -95.0, -12300.0),
Vector3.new(1832.0, -95.0, -12300.0),
Vector3.new(1834.0, -95.0, -12300.0),
Vector3.new(1836.0, -95.0, -12300.0),
Vector3.new(1838.0, -95.0, -12300.0),
Vector3.new(1840.0, -95.0, -12300.0),
Vector3.new(1842.0, -95.0, -12300.0),
Vector3.new(1844.0, -95.0, -12300.0),
Vector3.new(1846.0, -95.0, -12300.0),
Vector3.new(1846.0, -95.0, -12302.0),
Vector3.new(1846.0, -95.0, -12304.0),
Vector3.new(1846.0, -95.0, -12306.0),
Vector3.new(1846.0, -95.0, -12308.0),
Vector3.new(1844.0, -95.0, -12308.0),
Vector3.new(1842.0, -95.0, -12308.0),
Vector3.new(1840.0, -95.0, -12308.0),
Vector3.new(1838.0, -95.0, -12308.0),
Vector3.new(1836.0, -95.0, -12308.0),
Vector3.new(1834.0, -95.0, -12308.0),
Vector3.new(1832.0, -95.0, -12308.0),
Vector3.new(1830.0, -95.0, -12308.0),
Vector3.new(1828.0, -95.0, -12308.0),
Vector3.new(1826.0, -95.0, -12308.0),
Vector3.new(1824.0, -95.0, -12308.0),
Vector3.new(1822.0, -95.0, -12308.0),
Vector3.new(1822.0, -95.0, -12310.0),
Vector3.new(1822.0, -95.0, -12312.0),
Vector3.new(1822.0, -95.0, -12314.0),
Vector3.new(1822.0, -95.0, -12316.0),
Vector3.new(1822.0, -95.0, -12318.0),
Vector3.new(1822.0, -95.0, -12320.0),
Vector3.new(1822.0, -78.0, -12322.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -95.0, -12326.0),
Vector3.new(1822.0, -95.0, -12328.0),
Vector3.new(1820.0, -95.0, -12328.0),
Vector3.new(1818.0, -95.0, -12328.0),
Vector3.new(1816.0, -95.0, -12328.0),
Vector3.new(1814.0, -95.0, -12328.0),
Vector3.new(1812.0, -95.0, -12328.0),
Vector3.new(1810.0, -95.0, -12328.0),
Vector3.new(1808.0, -95.0, -12328.0),
Vector3.new(1806.0, -95.0, -12328.0),
Vector3.new(1804.0, -95.0, -12328.0),
Vector3.new(1802.0, -95.0, -12328.0),
Vector3.new(1800.0, -95.0, -12328.0),
Vector3.new(1798.0, -95.0, -12328.0),
Vector3.new(1796.0, -95.0, -12328.0),
Vector3.new(1793.7, -95.0, -12327.5)
}
function FishmanMaze.Travel(hrp)
if not hrp or not Core then return end
local EasyTravel = Core.Import(_d({26,27,23,81,90,89,25,86,83,76,25,79,75,93,99,73,94,92,75,96,79,86,24,86,95,75},22), _d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,86,95,75,95,23,77,89,78,79,25,87,75,83,88,25,26,27,73,93,77,92,83,90,94,25,86,83,76,25,79,75,93,99,73,94,92,75,96,79,86,24,86,95,75},22))
if not EasyTravel then warn(_d({69,48,83,93,82,87,75,88,10,55,75,100,79,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,47,75,93,99,62,92,75,96,79,86,11},22)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({69,48,83,93,82,87,75,88,10,55,75,100,79,71,10,61,94,75,92,94,83,88,81,10,47,75,93,99,62,92,75,96,79,86,23,76,75,93,79,78,10,87,75,100,79,10,94,92,75,96,79,92,93,75,86,24,24,24},22))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({44,75,93,79,58,75,92,94},22)) then
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
print(_d({69,48,83,93,82,87,75,88,10,55,75,100,79,71,10,45,89,87,90,86,79,94,79,24},22))
end
return FishmanMaze
end)()