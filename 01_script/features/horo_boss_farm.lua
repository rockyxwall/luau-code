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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({43,86,91,80,1,85,73,70,1,37,74,66,78,80,79,69,67,66,68,76},31),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)) then
Core = loadstring(readfile(_d({17,18,14,72,81,80,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
else
Core = loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,68,80,83,70,15,77,86,66},31)))()
end
end)
if not Core then warn(_d({60,36,80,83,70,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)) or (bp and bp:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({47,49,36,84},31))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum = boss:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
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
if key == _d({41,74,85},31) then return target.CFrame
elseif key == _d({53,66,83,72,70,85},31) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({60,41,80,83,80,39,66,83,78,62,1,46,70,85,66,85,66,67,77,70,1,73,80,80,76,1,71,66,74,77,70,69,27,1},31) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({60,41,80,83,80,39,66,83,78,62,1,52,85,80,81,81,70,69,15},31))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({60,41,80,83,80,39,66,83,78,62,1,34,77,83,70,66,69,90,1,83,86,79,79,74,79,72,2},31)); return end
if not Safeguard then warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({60,41,80,83,80,39,66,83,78,62,1,52,85,66,83,85,70,69,1,85,66,83,72,70,85,74,79,72,27,1},31) .. HoroFarm.Config.SelectedBoss)
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
print(_d({60,41,80,83,80,39,66,83,78,62,1,52,85,66,79,69,66,77,80,79,70,1,46,80,69,70,27,1,49,83,70,84,84,1,8,62,8,1,85,80,1,85,80,72,72,77,70,15},31))
end
return HoroFarm
end)()