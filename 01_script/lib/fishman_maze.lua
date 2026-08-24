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
Vector3.new(1836.0, 4.1, -12190.0),
Vector3.new(1836.0, -95.0, -12202.3),
Vector3.new(1836.0, -95.0, -12203.3),
Vector3.new(1836.0, -95.0, -12204.3),
Vector3.new(1835.2, -95.0, -12195.5),
Vector3.new(1836.9, -95.0, -12195.5),
Vector3.new(1838.0, -95.0, -12195.5),
Vector3.new(1840.1, -95.0, -12195.5),
Vector3.new(1845.4, -95.0, -12195.5),
Vector3.new(1839.2, -95.0, -12205.4),
Vector3.new(1836.2, -95.0, -12208.0),
Vector3.new(1836.2, -95.0, -12210.1),
Vector3.new(1822.6, -95.0, -12212.0),
Vector3.new(1836.2, -95.0, -12213.9),
Vector3.new(1840.6, -95.0, -12201.5),
Vector3.new(1832.0, -95.0, -12212.0),
Vector3.new(1830.0, -95.0, -12212.0),
Vector3.new(1828.0, -95.0, -12212.0),
Vector3.new(1826.0, -95.0, -12212.0),
Vector3.new(1824.0, -95.0, -12212.0),
Vector3.new(1822.0, -95.0, -12212.0),
Vector3.new(1820.0, -95.0, -12212.0),
Vector3.new(1818.0, -95.0, -12212.0),
Vector3.new(1816.0, -95.0, -12212.0),
Vector3.new(1814.0, -95.0, -12212.0),
Vector3.new(1812.0, -95.0, -12212.0),
Vector3.new(1810.0, -95.0, -12212.0),
Vector3.new(1808.0, -95.0, -12212.0),
Vector3.new(1806.0, -95.0, -12212.0),
Vector3.new(1804.0, -95.0, -12212.0),
Vector3.new(1802.0, -95.0, -12212.0),
Vector3.new(1799.7, -95.0, -12212.0),
Vector3.new(1795.0, -95.0, -12212.0),
Vector3.new(1797.2, -95.0, -12216.0),
Vector3.new(1784.1, -95.0, -12218.0),
Vector3.new(1784.1, -95.0, -12220.0),
Vector3.new(1784.1, -95.0, -12222.0),
Vector3.new(1796.0, -95.0, -12216.0),
Vector3.new(1794.0, -95.0, -12220.5),
Vector3.new(1792.0, -95.0, -12220.5),
Vector3.new(1790.0, -95.0, -12220.5),
Vector3.new(1788.0, -95.0, -12220.5),
Vector3.new(1786.0, -95.0, -12220.5),
Vector3.new(1784.0, -95.0, -12220.5),
Vector3.new(1782.0, -95.0, -12220.5),
Vector3.new(1780.0, -95.0, -12220.5),
Vector3.new(1778.0, -95.0, -12220.5),
Vector3.new(1776.0, -95.0, -12220.5),
Vector3.new(1774.0, -95.0, -12220.5),
Vector3.new(1772.0, -95.0, -12220.5),
Vector3.new(1770.0, -95.0, -12220.5),
Vector3.new(1770.0, -81.0, -12224.0),
Vector3.new(1770.0, -81.0, -12226.0),
Vector3.new(1770.0, -95.0, -12229.0),
Vector3.new(1770.0, -95.0, -12229.0),
Vector3.new(1772.0, -95.0, -12229.0),
Vector3.new(1774.0, -95.0, -12229.0),
Vector3.new(1776.0, -95.0, -12229.0),
Vector3.new(1778.0, -95.0, -12229.0),
Vector3.new(1780.0, -95.0, -12229.0),
Vector3.new(1782.0, -95.0, -12229.0),
Vector3.new(1784.0, -95.0, -12229.0),
Vector3.new(1786.0, -95.0, -12229.0),
Vector3.new(1788.0, -95.0, -12229.0),
Vector3.new(1790.7, -95.0, -12229.0),
Vector3.new(1791.2, -95.0, -12231.7),
Vector3.new(1791.2, -95.0, -12234.0),
Vector3.new(1791.2, -95.0, -12237.0),
Vector3.new(1791.2, -95.0, -12240.4),
Vector3.new(1778.7, -95.0, -12240.0),
Vector3.new(1778.7, -95.0, -12242.0),
Vector3.new(1790.0, -95.0, -12236.5),
Vector3.new(1790.0, -95.0, -12236.5),
Vector3.new(1788.0, -95.0, -12241.0),
Vector3.new(1786.0, -95.0, -12241.0),
Vector3.new(1784.0, -95.0, -12241.0),
Vector3.new(1778.0, -95.0, -12241.0),
Vector3.new(1780.2, -95.0, -12248.0),
Vector3.new(1777.2, -95.0, -12252.0),
Vector3.new(1777.2, -95.0, -12261.8),
Vector3.new(1780.2, -95.0, -12251.8),
Vector3.new(1777.2, -95.0, -12256.0),
Vector3.new(1777.2, -95.0, -12258.0),
Vector3.new(1777.2, -95.0, -12260.0),
Vector3.new(1777.2, -95.0, -12262.0),
Vector3.new(1777.2, -95.0, -12264.0),
Vector3.new(1777.2, -95.0, -12268.0),
Vector3.new(1779.8, -95.0, -12272.5),
Vector3.new(1781.3, -95.0, -12272.5),
Vector3.new(1781.9, -95.0, -12272.5),
Vector3.new(1782.0, -95.0, -12261.8),
Vector3.new(1782.0, -95.0, -12262.8),
Vector3.new(1782.0, -95.0, -12263.8),
Vector3.new(1784.0, -95.0, -12272.5),
Vector3.new(1786.0, -95.0, -12268.5),
Vector3.new(1788.0, -95.0, -12268.5),
Vector3.new(1790.0, -95.0, -12268.5),
Vector3.new(1792.0, -95.0, -12276.5),
Vector3.new(1794.0, -95.0, -12276.5),
Vector3.new(1796.0, -95.0, -12276.5),
Vector3.new(1798.0, -95.0, -12276.5),
Vector3.new(1800.0, -95.0, -12276.5),
Vector3.new(1802.0, -95.0, -12276.5),
Vector3.new(1789.1, -95.0, -12280.0),
Vector3.new(1790.1, -95.0, -12280.0),
Vector3.new(1791.1, -95.0, -12280.0),
Vector3.new(1810.2, -95.0, -12280.0),
Vector3.new(1811.2, -95.0, -12280.0),
Vector3.new(1811.2, -95.0, -12282.0),
Vector3.new(1811.2, -95.0, -12284.0),
Vector3.new(1811.2, -95.0, -12286.0),
Vector3.new(1811.2, -95.0, -12288.0),
Vector3.new(1811.2, -95.0, -12290.0),
Vector3.new(1811.2, -95.0, -12292.0),
Vector3.new(1811.2, -95.0, -12294.0),
Vector3.new(1824.1, -95.0, -12296.0),
Vector3.new(1824.1, -95.0, -12298.0),
Vector3.new(1824.1, -95.0, -12300.0),
Vector3.new(1825.1, -95.0, -12300.0),
Vector3.new(1812.2, -95.0, -12298.8),
Vector3.new(1815.8, -95.0, -12298.5),
Vector3.new(1818.0, -95.0, -12285.8),
Vector3.new(1820.0, -95.0, -12285.8),
Vector3.new(1822.0, -95.0, -12285.8),
Vector3.new(1824.0, -95.0, -12298.5),
Vector3.new(1826.0, -95.0, -12298.5),
Vector3.new(1828.0, -95.0, -12298.5),
Vector3.new(1830.0, -95.0, -12298.5),
Vector3.new(1832.0, -95.0, -12298.5),
Vector3.new(1834.0, -95.0, -12298.5),
Vector3.new(1836.0, -95.0, -12298.5),
Vector3.new(1838.0, -95.0, -12298.5),
Vector3.new(1840.0, -95.0, -12298.5),
Vector3.new(1842.0, -95.0, -12298.5),
Vector3.new(1844.0, -95.0, -12298.5),
Vector3.new(1847.2, -95.0, -12299.0),
Vector3.new(1847.2, -95.0, -12302.0),
Vector3.new(1854.7, -95.0, -12306.5),
Vector3.new(1847.2, -95.0, -12307.7),
Vector3.new(1847.8, -95.0, -12306.5),
Vector3.new(1844.0, -95.0, -12306.5),
Vector3.new(1842.0, -95.0, -12306.5),
Vector3.new(1840.0, -95.0, -12306.5),
Vector3.new(1838.0, -95.0, -12306.5),
Vector3.new(1836.0, -95.0, -12306.5),
Vector3.new(1834.0, -95.0, -12306.5),
Vector3.new(1832.0, -95.0, -12306.5),
Vector3.new(1830.0, -95.0, -12306.5),
Vector3.new(1828.0, -95.0, -12306.5),
Vector3.new(1826.0, -95.0, -12306.5),
Vector3.new(1823.8, -95.0, -12306.5),
Vector3.new(1821.2, -95.0, -12307.5),
Vector3.new(1821.2, -95.0, -12310.0),
Vector3.new(1821.2, -95.0, -12312.0),
Vector3.new(1821.2, -95.0, -12314.0),
Vector3.new(1821.2, -95.0, -12316.0),
Vector3.new(1821.2, -95.0, -12318.0),
Vector3.new(1821.2, -95.0, -12320.0),
Vector3.new(1822.0, -78.0, -12322.0),
Vector3.new(1822.0, -78.0, -12324.0),
Vector3.new(1822.0, -95.0, -12327.5),
Vector3.new(1808.1, -95.0, -12328.0),
Vector3.new(1820.0, -95.0, -12327.5),
Vector3.new(1818.0, -95.0, -12327.5),
Vector3.new(1816.0, -95.0, -12327.5),
Vector3.new(1814.0, -95.0, -12327.5),
Vector3.new(1812.0, -95.0, -12327.5),
Vector3.new(1810.0, -95.0, -12327.5),
Vector3.new(1808.0, -95.0, -12327.5),
Vector3.new(1806.0, -95.0, -12327.5),
Vector3.new(1804.0, -95.0, -12327.5),
Vector3.new(1802.0, -95.0, -12327.5),
Vector3.new(1800.0, -95.0, -12327.5),
Vector3.new(1798.0, -95.0, -12327.5),
Vector3.new(1796.0, -95.0, -12327.5),
Vector3.new(1793.7, -95.0, -12327.5)
function FishmanMaze.Travel(hrp)
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
RunService.Heartbeat:Wait()
end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({64,43,78,88,77,82,70,83,5,50,70,95,74,66,5,40,84,82,85,81,74,89,74,19},27))
end
return FishmanMaze
end)()