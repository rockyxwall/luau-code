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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local VIM = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,57,72,96,77,80,76,83,75,22,84,72,80,85,22,90,86,92,89,74,76,21,83,92,72},25)
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
error(_d({66,47,86,89,86,7,93,25,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,57,72,96,77,80,76,83,75,7,60,48,7,51,80,73,89,72,89,96,21},25))
end
local Window = Rayfield:CreateWindow({
Name = _d({47,86,89,86,7,47,86,89,86,7,65,20,45,72,89,84,7,93,25},25),
LoadingTitle = _d({51,86,72,75,80,85,78,7,47,86,89,86,7,93,25,21,21,21},25),
LoadingSubtitle = _d({58,80,83,76,85,91,7,40,80,84,7,54,87,91,80,84,80,97,76,75},25),
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
local MainTab = Window:CreateTab(_d({40,92,91,86,7,45,72,89,84},25), 4483362458)
local SkillTab = Window:CreateTab(_d({58,82,80,83,83,7,58,76,91,91,80,85,78,90},25), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({47,86,89,86,20,47,86,89,86},25)) or (bp and bp:FindFirstChild(_d({47,86,89,86,20,47,86,89,86},25)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({53,55,42,90},25))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local hum = boss:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
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
if key == _d({47,80,91},25) then
return target.CFrame
elseif key == _d({59,72,89,78,76,91},25) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({66,47,86,89,86,7,93,25,68,7,52,76,91,72,91,72,73,83,76,7,79,86,86,82,7,77,72,80,83,76,75,33,7},25) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({66,47,86,89,86,7,93,25,68,7,42,83,76,72,85,76,75,7,92,87,7,87,89,76,93,80,86,92,90,7,90,76,90,90,80,86,85,21},25))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({58,91,72,91,92,90,33,7,62,72,80,91,80,85,78,7,77,86,89,7,41,86,90,90,7,58,87,72,94,85},25)) end
print(_d({66,47,86,89,86,7,93,25,68,7,41,86,90,90},25), _G.HoroSelectedBoss, _d({80,90,7,85,86,91,7,90,87,72,94,85,76,75,21,7,62,72,80,91,80,85,78,21,21,21},25))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({58,91,72,91,92,90,33,7,57,92,85,85,80,85,78,7,42,86,84,73,86},25)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({66,47,86,89,86,7,93,25,68,7,45,80,89,76,75,7,42,7,15,50,72,84,80,82,72,97,76,16},25))
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
print(_d({66,47,86,89,86,7,93,25,68,7,45,80,89,76,75,7,65,7,15,52,80,85,80,7,41,72,89,89,72,78,76,16},25))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({66,47,86,89,86,7,93,25,68,7,45,80,89,76,75,7,44,7,15,58,91,92,85,16},25))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({66,47,86,89,86,7,93,25,68,7,45,80,89,76,75,7,57,7,15,43,76,91,86,85,72,91,80,86,85,16},25))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({58,91,72,91,92,90,33,7,58,83,76,76,87,80,85,78,7,15},25) .. string.format(_d({12,21,24,77},25), finalSleep) .. _d({90,16},25)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({58,91,72,91,92,90,33,7,48,75,83,76},25))
MainTab:CreateDropdown({
Name = _d({58,76,83,76,74,91,7,41,86,90,90},25),
Options = {_d({40,95,76,7,47,72,85,75,7,51,86,78,72,85},25), _d({41,72,85,75,80,91,7,41,86,90,90},25), _d({49,92,97,86,7,91,79,76,7,43,80,72,84,86,85,75,73,72,74,82},25)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({66,47,86,89,86,7,93,25,68,7,58,76,83,76,74,91,76,75,7,91,72,89,78,76,91,33},25), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({58,91,72,89,91,7,40,92,91,86,7,45,72,89,84},25),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({58,76,83,76,74,91,7,41,86,90,90,7,57,76,88,92,80,89,76,75},25),
Content = _d({64,86,92,7,84,92,90,91,7,90,76,83,76,74,91,7,72,7,73,86,90,90,7,77,80,89,90,91,7,73,76,77,86,89,76,7,76,85,72,73,83,80,85,78,7,40,92,91,86,7,45,72,89,84,8},25),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({58,91,72,91,92,90,33,7,48,75,83,76},25)) end
end
print(_d({66,47,86,89,86,7,93,25,68,7,40,92,91,86,7,45,72,89,84,33},25), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({43,76,90,91,89,86,96,7,60,48},25),
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