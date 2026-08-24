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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local VIM = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({58,101,106,95,16,100,88,85,16,52,89,81,93,95,94,84,82,81,83,91},16),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({32,33,29,87,96,95,31,92,89,82,31,83,95,98,85,30,92,101,81},16)) then
Core = loadstring(readfile(_d({32,33,29,87,96,95,31,92,89,82,31,83,95,98,85,30,92,101,81},16)))()
else
Core = loadstring(game:HttpGet(_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,83,95,98,85,30,92,101,81},16)))()
end
end)
if not Core then warn(_d({75,51,95,98,85,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,17},16)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)) or (bp and bp:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({62,64,51,99},16))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = boss:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
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
if key == _d({56,89,100},16) then return target.CFrame
elseif key == _d({68,81,98,87,85,100},16) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({75,56,95,98,95,54,81,98,93,77,16,61,85,100,81,100,81,82,92,85,16,88,95,95,91,16,86,81,89,92,85,84,42,16},16) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({75,56,95,98,95,54,81,98,93,77,16,67,100,95,96,96,85,84,30},16))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({75,56,95,98,95,54,81,98,93,77,16,49,92,98,85,81,84,105,16,98,101,94,94,89,94,87,17},16)); return end
if not Safeguard then warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,17},16)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({75,56,95,98,95,54,81,98,93,77,16,67,100,81,98,100,85,84,16,100,81,98,87,85,100,89,94,87,42,16},16) .. HoroFarm.Config.SelectedBoss)
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
Core.SetupStandalone(
HoroFarm,
_d({56,95,98,95,54,81,98,93},16),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()