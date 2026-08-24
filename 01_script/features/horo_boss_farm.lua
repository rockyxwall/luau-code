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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({40,83,88,77,254,82,70,67,254,34,71,63,75,77,76,66,64,63,65,73},34),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({14,15,11,69,78,77,13,74,71,64,13,65,77,80,67,12,74,83,63},34)) then
Core = loadstring(readfile(_d({14,15,11,69,78,77,13,74,71,64,13,65,77,80,67,12,74,83,63},34)))()
else
Core = loadstring(game:HttpGet(_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,74,83,63,83,11,65,77,66,67,13,75,63,71,76,13,14,15,61,81,65,80,71,78,82,13,74,71,64,13,65,77,80,67,12,74,83,63},34)))()
end
end)
if not Core then warn(_d({57,33,77,80,67,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,255},34)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)) or (bp and bp:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({44,46,33,81},34))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hum = boss:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
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
if key == _d({38,71,82},34) then return target.CFrame
elseif key == _d({50,63,80,69,67,82},34) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({57,38,77,80,77,36,63,80,75,59,254,43,67,82,63,82,63,64,74,67,254,70,77,77,73,254,68,63,71,74,67,66,24,254},34) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({57,38,77,80,77,36,63,80,75,59,254,49,82,77,78,78,67,66,12},34))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({57,38,77,80,77,36,63,80,75,59,254,31,74,80,67,63,66,87,254,80,83,76,76,71,76,69,255},34)); return end
if not Safeguard then warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,255},34)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({57,38,77,80,77,36,63,80,75,59,254,49,82,63,80,82,67,66,254,82,63,80,69,67,82,71,76,69,24,254},34) .. HoroFarm.Config.SelectedBoss)
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
_d({38,77,80,77,36,63,80,75},34),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()