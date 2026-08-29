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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({42,85,90,79,0,84,72,69,0,36,73,65,77,79,78,68,66,65,67,75},32),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)) or (bp and bp:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = boss:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
if key == _d({40,73,84},32) then return target.CFrame
elseif key == _d({52,65,82,71,69,84},32) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({59,40,79,82,79,38,65,82,77,61,0,45,69,84,65,84,65,66,76,69,0,72,79,79,75,0,70,65,73,76,69,68,26,0},32) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({59,40,79,82,79,38,65,82,77,61,0,51,84,79,80,80,69,68,14},32))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({59,40,79,82,79,38,65,82,77,61,0,33,76,82,69,65,68,89,0,82,85,78,78,73,78,71,1},32)); return end
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({59,40,79,82,79,38,65,82,77,61,0,51,84,65,82,84,69,68,0,84,65,82,71,69,84,73,78,71,26,0},32) .. HoroFarm.Config.SelectedBoss)
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
_d({40,79,82,79,38,65,82,77},32),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()