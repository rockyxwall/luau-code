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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({22,65,70,59,236,64,52,49,236,16,53,45,57,59,58,48,46,45,47,55},52),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)) then
Core = loadstring(readfile(_d({252,253,249,51,60,59,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
else
Core = loadstring(game:HttpGet(_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,56,65,45,65,249,47,59,48,49,251,57,45,53,58,251,252,253,43,63,47,62,53,60,64,251,56,53,46,251,47,59,62,49,250,56,65,45},52)))()
end
end)
if not Core then warn(_d({39,15,59,62,49,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)) or (bp and bp:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = boss:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
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
if key == _d({20,53,64},52) then return target.CFrame
elseif key == _d({32,45,62,51,49,64},52) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({39,20,59,62,59,18,45,62,57,41,236,25,49,64,45,64,45,46,56,49,236,52,59,59,55,236,50,45,53,56,49,48,6,236},52) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,59,60,60,49,48,250},52))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({39,20,59,62,59,18,45,62,57,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237},52)); return end
if not Safeguard then warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,45,62,64,49,48,236,64,45,62,51,49,64,53,58,51,6,236},52) .. HoroFarm.Config.SelectedBoss)
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
_d({20,59,62,59,18,45,62,57},52),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()