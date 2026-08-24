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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({39,82,87,76,253,81,69,66,253,33,70,62,74,76,75,65,63,62,64,72},35),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)) or (bp and bp:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = boss:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({37,70,81},35) then return target.CFrame
elseif key == _d({49,62,79,68,66,81},35) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({56,37,76,79,76,35,62,79,74,58,253,42,66,81,62,81,62,63,73,66,253,69,76,76,72,253,67,62,70,73,66,65,23,253},35) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,76,77,77,66,65,11},35))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({56,37,76,79,76,35,62,79,74,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254},35)) return end
HoroFarm.Running = true
setupHook()
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,62,79,81,66,65,253,81,62,79,68,66,81,70,75,68,23,253},35) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
if not _G.lazyhub then
table.insert(HoroFarm.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if HoroFarm.Running then
HoroFarm.Stop()
else
HoroFarm.Start()
end
end
end))
HoroFarm.Start()
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,62,75,65,62,73,76,75,66,253,42,76,65,66,23,253,45,79,66,80,80,253,4,58,4,253,81,76,253,81,76,68,68,73,66,11},35))
end
return HoroFarm
end)()