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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({44,87,92,81,2,86,74,71,2,38,75,67,79,81,80,70,68,67,69,77},30),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)) or (bp and bp:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({48,50,37,85},30))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum = boss:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
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
if key == _d({42,75,86},30) then return target.CFrame
elseif key == _d({54,67,84,73,71,86},30) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({61,42,81,84,81,40,67,84,79,63,2,47,71,86,67,86,67,68,78,71,2,74,81,81,77,2,72,67,75,78,71,70,28,2},30) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({61,42,81,84,81,40,67,84,79,63,2,53,86,81,82,82,71,70,16},30))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({61,42,81,84,81,40,67,84,79,63,2,35,78,84,71,67,70,91,2,84,87,80,80,75,80,73,3},30)); return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({61,42,81,84,81,40,67,84,79,63,2,53,86,67,84,86,71,70,2,86,67,84,73,71,86,75,80,73,28,2},30) .. HoroFarm.Config.SelectedBoss)
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
if not _G.DisableStandalone then
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
print(_d({61,42,81,84,81,40,67,84,79,63,2,53,86,67,80,70,67,78,81,80,71,2,47,81,70,71,28,2,50,84,71,85,85,2,9,63,9,2,86,81,2,86,81,73,73,78,71,16},30))
end
return HoroFarm
end)()