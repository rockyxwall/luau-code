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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,61,76,100,81,84,80,87,79,26,88,76,84,89,26,94,90,96,93,78,80,25,87,96,76},21)
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
error(_d({70,51,90,93,90,11,97,29,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,61,76,100,81,84,80,87,79,11,64,52,11,55,84,77,93,76,93,100,25},21))
end
local Window = Rayfield:CreateWindow({
Name = _d({51,90,93,90,11,51,90,93,90,11,69,24,49,76,93,88,11,97,29},21),
LoadingTitle = _d({55,90,76,79,84,89,82,11,51,90,93,90,11,97,29,25,25,25},21),
LoadingSubtitle = _d({62,84,87,80,89,95,11,44,84,88,11,58,91,95,84,88,84,101,80,79},21),
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
local MainTab = Window:CreateTab(_d({44,96,95,90,11,49,76,93,88},21), 4483362458)
local SkillTab = Window:CreateTab(_d({62,86,84,87,87,11,62,80,95,95,84,89,82,94},21), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)) or (bp and bp:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({57,59,46,94},21))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hum = boss:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
if key == _d({51,84,95},21) then
return target.CFrame
elseif key == _d({63,76,93,82,80,95},21) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({70,51,90,93,90,11,97,29,72,11,56,80,95,76,95,76,77,87,80,11,83,90,90,86,11,81,76,84,87,80,79,37,11},21) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({70,51,90,93,90,11,97,29,72,11,46,87,80,76,89,80,79,11,96,91,11,91,93,80,97,84,90,96,94,11,94,80,94,94,84,90,89,25},21))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({62,95,76,95,96,94,37,11,66,76,84,95,84,89,82,11,81,90,93,11,45,90,94,94,11,62,91,76,98,89},21)) end
print(_d({70,51,90,93,90,11,97,29,72,11,45,90,94,94},21), _G.HoroSelectedBoss, _d({84,94,11,89,90,95,11,94,91,76,98,89,80,79,25,11,66,76,84,95,84,89,82,25,25,25},21))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({62,95,76,95,96,94,37,11,61,96,89,89,84,89,82,11,46,90,88,77,90},21)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({70,51,90,93,90,11,97,29,72,11,49,84,93,80,79,11,46,11,19,54,76,88,84,86,76,101,80,20},21))
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
print(_d({70,51,90,93,90,11,97,29,72,11,49,84,93,80,79,11,69,11,19,56,84,89,84,11,45,76,93,93,76,82,80,20},21))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({70,51,90,93,90,11,97,29,72,11,49,84,93,80,79,11,48,11,19,62,95,96,89,20},21))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({70,51,90,93,90,11,97,29,72,11,49,84,93,80,79,11,61,11,19,47,80,95,90,89,76,95,84,90,89,20},21))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({62,95,76,95,96,94,37,11,62,87,80,80,91,84,89,82,11,19},21) .. string.format(_d({16,25,28,81},21), finalSleep) .. _d({94,20},21)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({62,95,76,95,96,94,37,11,52,79,87,80},21))
MainTab:CreateDropdown({
Name = _d({62,80,87,80,78,95,11,45,90,94,94},21),
Options = {_d({44,99,80,11,51,76,89,79,11,55,90,82,76,89},21), _d({45,76,89,79,84,95,11,45,90,94,94},21), _d({53,96,101,90,11,95,83,80,11,47,84,76,88,90,89,79,77,76,78,86},21)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({70,51,90,93,90,11,97,29,72,11,62,80,87,80,78,95,80,79,11,95,76,93,82,80,95,37},21), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({62,95,76,93,95,11,44,96,95,90,11,49,76,93,88},21),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({62,80,87,80,78,95,11,45,90,94,94,11,61,80,92,96,84,93,80,79},21),
Content = _d({68,90,96,11,88,96,94,95,11,94,80,87,80,78,95,11,76,11,77,90,94,94,11,81,84,93,94,95,11,77,80,81,90,93,80,11,80,89,76,77,87,84,89,82,11,44,96,95,90,11,49,76,93,88,12},21),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({62,95,76,95,96,94,37,11,52,79,87,80},21)) end
end
print(_d({70,51,90,93,90,11,97,29,72,11,44,96,95,90,11,49,76,93,88,37},21), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({47,80,94,95,93,90,100,11,64,52},21),
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