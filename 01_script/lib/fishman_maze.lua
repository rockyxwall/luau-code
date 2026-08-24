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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local LocalPlayer = Players.LocalPlayer
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({243,244,240,42,51,50,242,47,44,37,242,38,50,53,40,241,47,56,36},61)) then
Core = loadstring(readfile(_d({243,244,240,42,51,50,242,47,44,37,242,38,50,53,40,241,47,56,36},61)))()
else
Core = loadstring(game:HttpGet(_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,38,50,53,40,241,47,56,36},61)))()
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
local EasyTravel = Core.Import(_d({243,244,240,42,51,50,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61))
if not EasyTravel then warn(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,8,36,54,60,23,53,36,57,40,47,228},61)); return end
if EasyTravel.Cleanup then pcall(EasyTravel.Cleanup) end
print(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,22,55,36,53,55,44,49,42,227,8,36,54,60,23,53,36,57,40,47,240,37,36,54,40,39,227,48,36,61,40,227,55,53,36,57,40,53,54,36,47,241,241,241},61))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
print(_d({30,9,44,54,43,48,36,49,227,16,36,61,40,32,227,6,50,48,51,47,40,55,40,241},61))
end
return FishmanMaze
end)()