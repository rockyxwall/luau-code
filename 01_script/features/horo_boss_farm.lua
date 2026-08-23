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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24)
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
error(_d({67,48,87,90,87,8,94,26,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({48,87,90,87,8,48,87,90,87,8,66,21,46,73,90,85,8,94,26},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,48,87,90,87,8,94,26,22,22,22},24),
LoadingSubtitle = _d({59,81,84,77,86,92,8,41,81,85,8,55,88,92,81,85,81,98,77,76},24),
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
local MainTab = Window:CreateTab(_d({41,93,92,87,8,46,73,90,85},24), 4483362458)
local SkillTab = Window:CreateTab(_d({59,83,81,84,84,8,59,77,92,92,81,86,79,91},24), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({48,87,90,87,21,48,87,90,87},24)) or (bp and bp:FindFirstChild(_d({48,87,90,87,21,48,87,90,87},24)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({54,56,43,91},24))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = boss:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
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
if key == _d({48,81,92},24) then
return target.CFrame
elseif key == _d({60,73,90,79,77,92},24) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({67,48,87,90,87,8,94,26,69,8,53,77,92,73,92,73,74,84,77,8,80,87,87,83,8,78,73,81,84,77,76,34,8},24) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({67,48,87,90,87,8,94,26,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({59,92,73,92,93,91,34,8,63,73,81,92,81,86,79,8,78,87,90,8,42,87,91,91,8,59,88,73,95,86},24)) end
print(_d({67,48,87,90,87,8,94,26,69,8,42,87,91,91},24), _G.HoroSelectedBoss, _d({81,91,8,86,87,92,8,91,88,73,95,86,77,76,22,8,63,73,81,92,81,86,79,22,22,22},24))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({59,92,73,92,93,91,34,8,58,93,86,86,81,86,79,8,43,87,85,74,87},24)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({67,48,87,90,87,8,94,26,69,8,46,81,90,77,76,8,43,8,16,51,73,85,81,83,73,98,77,17},24))
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
print(_d({67,48,87,90,87,8,94,26,69,8,46,81,90,77,76,8,66,8,16,53,81,86,81,8,42,73,90,90,73,79,77,17},24))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({67,48,87,90,87,8,94,26,69,8,46,81,90,77,76,8,45,8,16,59,92,93,86,17},24))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({67,48,87,90,87,8,94,26,69,8,46,81,90,77,76,8,58,8,16,44,77,92,87,86,73,92,81,87,86,17},24))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({59,92,73,92,93,91,34,8,59,84,77,77,88,81,86,79,8,16},24) .. string.format(_d({13,22,25,78},24), finalSleep) .. _d({91,17},24)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({59,92,73,92,93,91,34,8,49,76,84,77},24))
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,42,87,91,91},24),
Options = {_d({41,96,77,8,48,73,86,76,8,52,87,79,73,86},24), _d({42,73,86,76,81,92,8,42,87,91,91},24), _d({50,93,98,87,8,92,80,77,8,44,81,73,85,87,86,76,74,73,75,83},24)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({67,48,87,90,87,8,94,26,69,8,59,77,84,77,75,92,77,76,8,92,73,90,79,77,92,34},24), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({59,92,73,90,92,8,41,93,92,87,8,46,73,90,85},24),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({59,77,84,77,75,92,8,42,87,91,91,8,58,77,89,93,81,90,77,76},24),
Content = _d({65,87,93,8,85,93,91,92,8,91,77,84,77,75,92,8,73,8,74,87,91,91,8,78,81,90,91,92,8,74,77,78,87,90,77,8,77,86,73,74,84,81,86,79,8,41,93,92,87,8,46,73,90,85,9},24),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({59,92,73,92,93,91,34,8,49,76,84,77},24)) end
end
print(_d({67,48,87,90,87,8,94,26,69,8,41,93,92,87,8,46,73,90,85,34},24), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49},24),
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