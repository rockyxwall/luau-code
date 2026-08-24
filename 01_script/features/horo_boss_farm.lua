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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({59,102,107,96,17,101,89,86,17,53,90,82,94,96,95,85,83,82,84,92},15),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({33,34,30,88,97,96,32,93,90,83,32,84,96,99,86,31,93,102,82},15)) then
Core = loadstring(readfile(_d({33,34,30,88,97,96,32,93,90,83,32,84,96,99,86,31,93,102,82},15)))()
else
Core = loadstring(game:HttpGet(_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,93,102,82,102,30,84,96,85,86,32,94,82,90,95,32,33,34,80,100,84,99,90,97,101,32,93,90,83,32,84,96,99,86,31,93,102,82},15)))()
end
end)
if not Core then warn(_d({76,52,96,99,86,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,18},15)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({57,96,99,96,30,57,96,99,96},15)) or (bp and bp:FindFirstChild(_d({57,96,99,96,30,57,96,99,96},15)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({63,65,52,100},15))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum = boss:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
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
if key == _d({57,90,101},15) then return target.CFrame
elseif key == _d({69,82,99,88,86,101},15) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({76,57,96,99,96,55,82,99,94,78,17,62,86,101,82,101,82,83,93,86,17,89,96,96,92,17,87,82,90,93,86,85,43,17},15) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({76,57,96,99,96,55,82,99,94,78,17,68,101,96,97,97,86,85,31},15))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({76,57,96,99,96,55,82,99,94,78,17,50,93,99,86,82,85,106,17,99,102,95,95,90,95,88,18},15)); return end
if not Safeguard then warn(_d({76,68,82,87,86,88,102,82,99,85,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,18},15)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({76,57,96,99,96,55,82,99,94,78,17,68,101,82,99,101,86,85,17,101,82,99,88,86,101,90,95,88,43,17},15) .. HoroFarm.Config.SelectedBoss)
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
print(_d({76,57,96,99,96,55,82,99,94,78,17,68,101,82,95,85,82,93,96,95,86,17,62,96,85,86,43,17,65,99,86,100,100,17,24,78,24,17,101,96,17,101,96,88,88,93,86,31},15))
end
return HoroFarm
end)()