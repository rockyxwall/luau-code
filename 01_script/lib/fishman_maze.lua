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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)) then
Core = loadstring(readfile(_d({6,7,3,61,70,69,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
else
Core = loadstring(game:HttpGet(_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,57,69,72,59,4,66,75,55},42)))()
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
local EasyTravel = Core.Import(_d({6,7,3,61,70,69,5,66,63,56,5,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55},42), _d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,66,75,55,75,3,57,69,58,59,5,67,55,63,68,5,6,7,53,73,57,72,63,70,74,5,66,63,56,5,59,55,73,79,53,74,72,55,76,59,66,4,66,75,55},42))
if not EasyTravel then warn(_d({49,28,63,73,62,67,55,68,246,35,55,80,59,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,27,55,73,79,42,72,55,76,59,66,247},42)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({49,28,63,73,62,67,55,68,246,35,55,80,59,51,246,41,74,55,72,74,63,68,61,246,27,55,73,79,42,72,55,76,59,66,3,56,55,73,59,58,246,67,55,80,59,246,74,72,55,76,59,72,73,55,66,4,4,4},42))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({24,55,73,59,38,55,72,74},42)) then
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
print(_d({49,28,63,73,62,67,55,68,246,35,55,80,59,51,246,25,69,67,70,66,59,74,59,4},42))
end
return FishmanMaze
end)()