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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,27,42,66,47,50,46,53,45,248,54,42,50,55,248,60,56,62,59,44,46,247,53,62,42},55)
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
error(_d({36,17,56,59,56,233,63,251,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,27,42,66,47,50,46,53,45,233,30,18,233,21,50,43,59,42,59,66,247},55))
end
local Window = Rayfield:CreateWindow({
Name = _d({17,56,59,56,233,17,56,59,56,233,35,246,15,42,59,54,233,63,251},55),
LoadingTitle = _d({21,56,42,45,50,55,48,233,17,56,59,56,233,63,251,247,247,247},55),
LoadingSubtitle = _d({28,50,53,46,55,61,233,10,50,54,233,24,57,61,50,54,50,67,46,45},55),
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
local MainTab = Window:CreateTab(_d({10,62,61,56,233,15,42,59,54},55), 4483362458)
local SkillTab = Window:CreateTab(_d({28,52,50,53,53,233,28,46,61,61,50,55,48,60},55), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({17,56,59,56,246,17,56,59,56},55)) or (bp and bp:FindFirstChild(_d({17,56,59,56,246,17,56,59,56},55)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({23,25,12,60},55))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local hum = boss:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
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
if key == _d({17,50,61},55) then
return target.CFrame
elseif key == _d({29,42,59,48,46,61},55) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({36,17,56,59,56,233,63,251,38,233,22,46,61,42,61,42,43,53,46,233,49,56,56,52,233,47,42,50,53,46,45,3,233},55) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({36,17,56,59,56,233,63,251,38,233,12,53,46,42,55,46,45,233,62,57,233,57,59,46,63,50,56,62,60,233,60,46,60,60,50,56,55,247},55))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({28,61,42,61,62,60,3,233,32,42,50,61,50,55,48,233,47,56,59,233,11,56,60,60,233,28,57,42,64,55},55)) end
print(_d({36,17,56,59,56,233,63,251,38,233,11,56,60,60},55), _G.HoroSelectedBoss, _d({50,60,233,55,56,61,233,60,57,42,64,55,46,45,247,233,32,42,50,61,50,55,48,247,247,247},55))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({28,61,42,61,62,60,3,233,27,62,55,55,50,55,48,233,12,56,54,43,56},55)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({36,17,56,59,56,233,63,251,38,233,15,50,59,46,45,233,12,233,241,20,42,54,50,52,42,67,46,242},55))
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
print(_d({36,17,56,59,56,233,63,251,38,233,15,50,59,46,45,233,35,233,241,22,50,55,50,233,11,42,59,59,42,48,46,242},55))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({36,17,56,59,56,233,63,251,38,233,15,50,59,46,45,233,14,233,241,28,61,62,55,242},55))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({36,17,56,59,56,233,63,251,38,233,15,50,59,46,45,233,27,233,241,13,46,61,56,55,42,61,50,56,55,242},55))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({28,61,42,61,62,60,3,233,28,53,46,46,57,50,55,48,233,241},55) .. string.format(_d({238,247,250,47},55), finalSleep) .. _d({60,242},55)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({28,61,42,61,62,60,3,233,18,45,53,46},55))
MainTab:CreateDropdown({
Name = _d({28,46,53,46,44,61,233,11,56,60,60},55),
Options = {_d({10,65,46,233,17,42,55,45,233,21,56,48,42,55},55), _d({11,42,55,45,50,61,233,11,56,60,60},55), _d({19,62,67,56,233,61,49,46,233,13,50,42,54,56,55,45,43,42,44,52},55)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({36,17,56,59,56,233,63,251,38,233,28,46,53,46,44,61,46,45,233,61,42,59,48,46,61,3},55), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({28,61,42,59,61,233,10,62,61,56,233,15,42,59,54},55),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({28,46,53,46,44,61,233,11,56,60,60,233,27,46,58,62,50,59,46,45},55),
Content = _d({34,56,62,233,54,62,60,61,233,60,46,53,46,44,61,233,42,233,43,56,60,60,233,47,50,59,60,61,233,43,46,47,56,59,46,233,46,55,42,43,53,50,55,48,233,10,62,61,56,233,15,42,59,54,234},55),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({28,61,42,61,62,60,3,233,18,45,53,46},55)) end
end
print(_d({36,17,56,59,56,233,63,251,38,233,10,62,61,56,233,15,42,59,54,3},55), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({13,46,60,61,59,56,66,233,30,18},55),
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