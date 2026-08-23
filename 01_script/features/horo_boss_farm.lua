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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local VIM = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85,30,92,101,81},16)
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
error(_d({75,56,95,98,95,16,102,34,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,66,81,105,86,89,85,92,84,16,69,57,16,60,89,82,98,81,98,105,30},16))
end
local Window = Rayfield:CreateWindow({
Name = _d({56,95,98,95,16,56,95,98,95,16,74,29,54,81,98,93,16,102,34},16),
LoadingTitle = _d({60,95,81,84,89,94,87,16,56,95,98,95,16,102,34,30,30,30},16),
LoadingSubtitle = _d({67,89,92,85,94,100,16,49,89,93,16,63,96,100,89,93,89,106,85,84},16),
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
local MainTab = Window:CreateTab(_d({49,101,100,95,16,54,81,98,93},16), 4483362458)
local SkillTab = Window:CreateTab(_d({67,91,89,92,92,16,67,85,100,100,89,94,87,99},16), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)) or (bp and bp:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({62,64,51,99},16))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = boss:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
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
if key == _d({56,89,100},16) then
return target.CFrame
elseif key == _d({68,81,98,87,85,100},16) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({75,56,95,98,95,16,102,34,77,16,61,85,100,81,100,81,82,92,85,16,88,95,95,91,16,86,81,89,92,85,84,42,16},16) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({75,56,95,98,95,16,102,34,77,16,51,92,85,81,94,85,84,16,101,96,16,96,98,85,102,89,95,101,99,16,99,85,99,99,89,95,94,30},16))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({67,100,81,100,101,99,42,16,71,81,89,100,89,94,87,16,86,95,98,16,50,95,99,99,16,67,96,81,103,94},16)) end
print(_d({75,56,95,98,95,16,102,34,77,16,50,95,99,99},16), _G.HoroSelectedBoss, _d({89,99,16,94,95,100,16,99,96,81,103,94,85,84,30,16,71,81,89,100,89,94,87,30,30,30},16))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({67,100,81,100,101,99,42,16,66,101,94,94,89,94,87,16,51,95,93,82,95},16)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({75,56,95,98,95,16,102,34,77,16,54,89,98,85,84,16,51,16,24,59,81,93,89,91,81,106,85,25},16))
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
print(_d({75,56,95,98,95,16,102,34,77,16,54,89,98,85,84,16,74,16,24,61,89,94,89,16,50,81,98,98,81,87,85,25},16))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({75,56,95,98,95,16,102,34,77,16,54,89,98,85,84,16,53,16,24,67,100,101,94,25},16))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({75,56,95,98,95,16,102,34,77,16,54,89,98,85,84,16,66,16,24,52,85,100,95,94,81,100,89,95,94,25},16))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({67,100,81,100,101,99,42,16,67,92,85,85,96,89,94,87,16,24},16) .. string.format(_d({21,30,33,86},16), finalSleep) .. _d({99,25},16)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({67,100,81,100,101,99,42,16,57,84,92,85},16))
MainTab:CreateDropdown({
Name = _d({67,85,92,85,83,100,16,50,95,99,99},16),
Options = {_d({49,104,85,16,56,81,94,84,16,60,95,87,81,94},16), _d({50,81,94,84,89,100,16,50,95,99,99},16), _d({58,101,106,95,16,100,88,85,16,52,89,81,93,95,94,84,82,81,83,91},16)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({75,56,95,98,95,16,102,34,77,16,67,85,92,85,83,100,85,84,16,100,81,98,87,85,100,42},16), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({67,100,81,98,100,16,49,101,100,95,16,54,81,98,93},16),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({67,85,92,85,83,100,16,50,95,99,99,16,66,85,97,101,89,98,85,84},16),
Content = _d({73,95,101,16,93,101,99,100,16,99,85,92,85,83,100,16,81,16,82,95,99,99,16,86,89,98,99,100,16,82,85,86,95,98,85,16,85,94,81,82,92,89,94,87,16,49,101,100,95,16,54,81,98,93,17},16),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({67,100,81,100,101,99,42,16,57,84,92,85},16)) end
end
print(_d({75,56,95,98,95,16,102,34,77,16,49,101,100,95,16,54,81,98,93,42},16), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({52,85,99,100,98,95,105,16,69,57},16),
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