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
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,41,56,80,61,64,60,67,59,6,68,56,64,69,6,74,70,76,73,58,60,5,67,76,56},41)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({50,31,70,73,70,247,77,9,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,41,56,80,61,64,60,67,59,247,44,32,247,35,64,57,73,56,73,80,5},41))
end
local Window = Rayfield:CreateWindow({
Name = _d({31,70,73,70,247,31,70,73,70,247,49,4,29,56,73,68,247,77,9},41),
LoadingTitle = _d({35,70,56,59,64,69,62,247,31,70,73,70,247,77,9,5,5,5},41),
LoadingSubtitle = _d({42,64,67,60,69,75,247,24,64,68,247,38,71,75,64,68,64,81,60,59},41),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.HoroSelectedBoss = nil
_G.HoroAutoZLoop = false
local checkSpawnInterval = 60
local useE = true
local useZ = true
local useC = true
local useR = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({24,76,75,70,247,29,56,73,68},41), 4483362458)
local SkillTab = Window:CreateTab(_d({42,66,64,67,67,247,42,60,75,75,64,69,62,74},41), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({31,70,73,70,4,31,70,73,70},41)) or (bp and bp:FindFirstChild(_d({31,70,73,70,4,31,70,73,70},41)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = boss:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
if not _G.HoroMouseHooked then
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and _G.HoroAutoZLoop and _G.HoroSelectedBoss then
local target = getBossPart(_G.HoroSelectedBoss)
if target then
if key == _d({31,64,75},41) then
return target.CFrame
elseif key == _d({43,56,73,62,60,75},41) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({50,31,70,73,70,247,77,9,52,247,36,60,75,56,75,56,57,67,60,247,63,70,70,66,247,61,56,64,67,60,59,17,247},41) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({50,31,70,73,70,247,77,9,52,247,26,67,60,56,69,60,59,247,76,71,247,71,73,60,77,64,70,76,74,247,74,60,74,74,64,70,69,5},41))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({42,75,56,75,76,74,17,247,46,56,64,75,64,69,62,247,61,70,73,247,25,70,74,74,247,42,71,56,78,69},41)) end
print(_d({50,31,70,73,70,247,77,9,52,247,25,70,74,74},41), _G.HoroSelectedBoss, _d({64,74,247,69,70,75,247,74,71,56,78,69,60,59,5,247,46,56,64,75,64,69,62,5,5,5},41))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({42,75,56,75,76,74,17,247,41,76,69,69,64,69,62,247,26,70,68,57,70},41)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({50,31,70,73,70,247,77,9,52,247,29,64,73,60,59,247,26,247,255,34,56,68,64,66,56,81,60,0},41))
elseif useZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
print(_d({50,31,70,73,70,247,77,9,52,247,29,64,73,60,59,247,49,247,255,36,64,69,64,247,25,56,73,73,56,62,60,0},41))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({50,31,70,73,70,247,77,9,52,247,29,64,73,60,59,247,28,247,255,42,75,76,69,0},41))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({50,31,70,73,70,247,77,9,52,247,29,64,73,60,59,247,41,247,255,27,60,75,70,69,56,75,64,70,69,0},41))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({42,75,56,75,76,74,17,247,42,67,60,60,71,64,69,62,247,255},41) .. string.format(_d({252,5,8,61},41), finalSleep) .. _d({74,0},41)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({42,75,56,75,76,74,17,247,32,59,67,60},41))
MainTab:CreateDropdown({
Name = _d({42,60,67,60,58,75,247,25,70,74,74},41),
Options = {_d({24,79,60,247,31,56,69,59,247,35,70,62,56,69},41), _d({25,56,69,59,64,75,247,25,70,74,74},41), _d({33,76,81,70,247,75,63,60,247,27,64,56,68,70,69,59,57,56,58,66},41)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({50,31,70,73,70,247,77,9,52,247,42,60,67,60,58,75,60,59,247,75,56,73,62,60,75,17},41), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({42,75,56,73,75,247,24,76,75,70,247,29,56,73,68},41),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({42,60,67,60,58,75,247,25,70,74,74,247,41,60,72,76,64,73,60,59},41),
Content = _d({48,70,76,247,68,76,74,75,247,74,60,67,60,58,75,247,56,247,57,70,74,74,247,61,64,73,74,75,247,57,60,61,70,73,60,247,60,69,56,57,67,64,69,62,247,24,76,75,70,247,29,56,73,68,248},41),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({42,75,56,75,76,74,17,247,32,59,67,60},41)) end
end
print(_d({50,31,70,73,70,247,77,9,52,247,24,76,75,70,247,29,56,73,68,17},41), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({27,60,74,75,73,70,80,247,44,32},41),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Use E (Stun)",
CurrentValue = true,
Callback = function(Value) useE = Value end,
})
SkillTab:CreateToggle({
Name = "Use Z (Mini)",
CurrentValue = true,
Callback = function(Value) useZ = Value end,
})
SkillTab:CreateToggle({
Name = "Use C (Kamikaze)",
CurrentValue = true,
Callback = function(Value) useC = Value end,
})
SkillTab:CreateToggle({
Name = "Use R (Snap)",
CurrentValue = true,
Callback = function(Value) useR = Value end,
})
end)()