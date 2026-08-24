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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({26,69,74,63,240,68,56,53,240,20,57,49,61,63,62,52,50,49,51,59},48),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)) or (bp and bp:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({30,32,19,67},48))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hum = boss:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
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
if key == _d({24,57,68},48) then return target.CFrame
elseif key == _d({36,49,66,55,53,68},48) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({43,24,63,66,63,22,49,66,61,45,240,29,53,68,49,68,49,50,60,53,240,56,63,63,59,240,54,49,57,60,53,52,10,240},48) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({43,24,63,66,63,22,49,66,61,45,240,35,68,63,64,64,53,52,254},48))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({43,24,63,66,63,22,49,66,61,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241},48)); return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({43,24,63,66,63,22,49,66,61,45,240,35,68,49,66,68,53,52,240,68,49,66,55,53,68,57,62,55,10,240},48) .. HoroFarm.Config.SelectedBoss)
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
_d({24,63,66,63,22,49,66,61},48),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()