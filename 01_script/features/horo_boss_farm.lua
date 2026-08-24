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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local VIM = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
local UserInputService = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({28,71,76,65,242,70,58,55,242,22,59,51,63,65,64,54,52,51,53,61},46),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({26,65,68,65,255,26,65,68,65},46)) or (bp and bp:FindFirstChild(_d({26,65,68,65,255,26,65,68,65},46)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({32,34,21,69},46))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
local hum = boss:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
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
if key == _d({26,59,70},46) then return target.CFrame
elseif key == _d({38,51,68,57,55,70},46) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({45,26,65,68,65,24,51,68,63,47,242,31,55,70,51,70,51,52,62,55,242,58,65,65,61,242,56,51,59,62,55,54,12,242},46) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({45,26,65,68,65,24,51,68,63,47,242,37,70,65,66,66,55,54,0},46))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({45,26,65,68,65,24,51,68,63,47,242,19,62,68,55,51,54,75,242,68,71,64,64,59,64,57,243},46)); return end
HoroFarm.Running = true
setupHook()
print(_d({45,26,65,68,65,24,51,68,63,47,242,37,70,51,68,70,55,54,242,70,51,68,57,55,70,59,64,57,12,242},46) .. HoroFarm.Config.SelectedBoss)
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
print(_d({45,26,65,68,65,24,51,68,63,47,242,37,70,51,64,54,51,62,65,64,55,242,31,65,54,55,12,242,34,68,55,69,69,242,249,47,249,242,70,65,242,70,65,57,57,62,55,0},46))
end
return HoroFarm
end)()