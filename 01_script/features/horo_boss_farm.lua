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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78,23,85,94,74},23)
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
error(_d({68,49,88,91,88,9,95,27,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,59,74,98,79,82,78,85,77,9,62,50,9,53,82,75,91,74,91,98,23},23))
end
local Window = Rayfield:CreateWindow({
Name = _d({49,88,91,88,9,49,88,91,88,9,67,22,47,74,91,86,9,95,27},23),
LoadingTitle = _d({53,88,74,77,82,87,80,9,49,88,91,88,9,95,27,23,23,23},23),
LoadingSubtitle = _d({60,82,85,78,87,93,9,42,82,86,9,56,89,93,82,86,82,99,78,77},23),
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
local MainTab = Window:CreateTab(_d({42,94,93,88,9,47,74,91,86},23), 4483362458)
local SkillTab = Window:CreateTab(_d({60,84,82,85,85,9,60,78,93,93,82,87,80,92},23), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({43,74,76,84,89,74,76,84},23))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({49,88,91,88,22,49,88,91,88},23)) or (bp and bp:FindFirstChild(_d({49,88,91,88,22,49,88,91,88},23)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({55,57,44,92},23))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hum = boss:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
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
if key == _d({49,82,93},23) then
return target.CFrame
elseif key == _d({61,74,91,80,78,93},23) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({68,49,88,91,88,9,95,27,70,9,54,78,93,74,93,74,75,85,78,9,81,88,88,84,9,79,74,82,85,78,77,35,9},23) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({68,49,88,91,88,9,95,27,70,9,44,85,78,74,87,78,77,9,94,89,9,89,91,78,95,82,88,94,92,9,92,78,92,92,82,88,87,23},23))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({60,93,74,93,94,92,35,9,64,74,82,93,82,87,80,9,79,88,91,9,43,88,92,92,9,60,89,74,96,87},23)) end
print(_d({68,49,88,91,88,9,95,27,70,9,43,88,92,92},23), _G.HoroSelectedBoss, _d({82,92,9,87,88,93,9,92,89,74,96,87,78,77,23,9,64,74,82,93,82,87,80,23,23,23},23))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({60,93,74,93,94,92,35,9,59,94,87,87,82,87,80,9,44,88,86,75,88},23)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({68,49,88,91,88,9,95,27,70,9,47,82,91,78,77,9,44,9,17,52,74,86,82,84,74,99,78,18},23))
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
print(_d({68,49,88,91,88,9,95,27,70,9,47,82,91,78,77,9,67,9,17,54,82,87,82,9,43,74,91,91,74,80,78,18},23))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({68,49,88,91,88,9,95,27,70,9,47,82,91,78,77,9,46,9,17,60,93,94,87,18},23))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({68,49,88,91,88,9,95,27,70,9,47,82,91,78,77,9,59,9,17,45,78,93,88,87,74,93,82,88,87,18},23))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({60,93,74,93,94,92,35,9,60,85,78,78,89,82,87,80,9,17},23) .. string.format(_d({14,23,26,79},23), finalSleep) .. _d({92,18},23)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({60,93,74,93,94,92,35,9,50,77,85,78},23))
MainTab:CreateDropdown({
Name = _d({60,78,85,78,76,93,9,43,88,92,92},23),
Options = {_d({42,97,78,9,49,74,87,77,9,53,88,80,74,87},23), _d({43,74,87,77,82,93,9,43,88,92,92},23), _d({51,94,99,88,9,93,81,78,9,45,82,74,86,88,87,77,75,74,76,84},23)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({68,49,88,91,88,9,95,27,70,9,60,78,85,78,76,93,78,77,9,93,74,91,80,78,93,35},23), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({60,93,74,91,93,9,42,94,93,88,9,47,74,91,86},23),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({60,78,85,78,76,93,9,43,88,92,92,9,59,78,90,94,82,91,78,77},23),
Content = _d({66,88,94,9,86,94,92,93,9,92,78,85,78,76,93,9,74,9,75,88,92,92,9,79,82,91,92,93,9,75,78,79,88,91,78,9,78,87,74,75,85,82,87,80,9,42,94,93,88,9,47,74,91,86,10},23),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({60,93,74,93,94,92,35,9,50,77,85,78},23)) end
end
print(_d({68,49,88,91,88,9,95,27,70,9,42,94,93,88,9,47,74,91,86,35},23), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({45,78,92,93,91,88,98,9,62,50},23),
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