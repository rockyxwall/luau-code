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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,20,35,59,40,43,39,46,38,241,47,35,43,48,241,53,49,55,52,37,39,240,46,55,35},62)
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
error(_d({29,10,49,52,49,226,56,244,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,20,35,59,40,43,39,46,38,226,23,11,226,14,43,36,52,35,52,59,240},62))
end
local Window = Rayfield:CreateWindow({
Name = _d({10,49,52,49,226,10,49,52,49,226,28,239,8,35,52,47,226,56,244},62),
LoadingTitle = _d({14,49,35,38,43,48,41,226,10,49,52,49,226,56,244,240,240,240},62),
LoadingSubtitle = _d({21,43,46,39,48,54,226,3,43,47,226,17,50,54,43,47,43,60,39,38},62),
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
local MainTab = Window:CreateTab(_d({3,55,54,49,226,8,35,52,47},62), 4483362458)
local SkillTab = Window:CreateTab(_d({21,45,43,46,46,226,21,39,54,54,43,48,41,53},62), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({10,49,52,49,239,10,49,52,49},62)) or (bp and bp:FindFirstChild(_d({10,49,52,49,239,10,49,52,49},62)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({16,18,5,53},62))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local hum = boss:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
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
if key == _d({10,43,54},62) then
return target.CFrame
elseif key == _d({22,35,52,41,39,54},62) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({29,10,49,52,49,226,56,244,31,226,15,39,54,35,54,35,36,46,39,226,42,49,49,45,226,40,35,43,46,39,38,252,226},62) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({29,10,49,52,49,226,56,244,31,226,5,46,39,35,48,39,38,226,55,50,226,50,52,39,56,43,49,55,53,226,53,39,53,53,43,49,48,240},62))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({21,54,35,54,55,53,252,226,25,35,43,54,43,48,41,226,40,49,52,226,4,49,53,53,226,21,50,35,57,48},62)) end
print(_d({29,10,49,52,49,226,56,244,31,226,4,49,53,53},62), _G.HoroSelectedBoss, _d({43,53,226,48,49,54,226,53,50,35,57,48,39,38,240,226,25,35,43,54,43,48,41,240,240,240},62))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({21,54,35,54,55,53,252,226,20,55,48,48,43,48,41,226,5,49,47,36,49},62)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({29,10,49,52,49,226,56,244,31,226,8,43,52,39,38,226,5,226,234,13,35,47,43,45,35,60,39,235},62))
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
print(_d({29,10,49,52,49,226,56,244,31,226,8,43,52,39,38,226,28,226,234,15,43,48,43,226,4,35,52,52,35,41,39,235},62))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({29,10,49,52,49,226,56,244,31,226,8,43,52,39,38,226,7,226,234,21,54,55,48,235},62))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({29,10,49,52,49,226,56,244,31,226,8,43,52,39,38,226,20,226,234,6,39,54,49,48,35,54,43,49,48,235},62))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({21,54,35,54,55,53,252,226,21,46,39,39,50,43,48,41,226,234},62) .. string.format(_d({231,240,243,40},62), finalSleep) .. _d({53,235},62)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({21,54,35,54,55,53,252,226,11,38,46,39},62))
MainTab:CreateDropdown({
Name = _d({21,39,46,39,37,54,226,4,49,53,53},62),
Options = {_d({3,58,39,226,10,35,48,38,226,14,49,41,35,48},62), _d({4,35,48,38,43,54,226,4,49,53,53},62), _d({12,55,60,49,226,54,42,39,226,6,43,35,47,49,48,38,36,35,37,45},62)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({29,10,49,52,49,226,56,244,31,226,21,39,46,39,37,54,39,38,226,54,35,52,41,39,54,252},62), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({21,54,35,52,54,226,3,55,54,49,226,8,35,52,47},62),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({21,39,46,39,37,54,226,4,49,53,53,226,20,39,51,55,43,52,39,38},62),
Content = _d({27,49,55,226,47,55,53,54,226,53,39,46,39,37,54,226,35,226,36,49,53,53,226,40,43,52,53,54,226,36,39,40,49,52,39,226,39,48,35,36,46,43,48,41,226,3,55,54,49,226,8,35,52,47,227},62),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({21,54,35,54,55,53,252,226,11,38,46,39},62)) end
end
print(_d({29,10,49,52,49,226,56,244,31,226,3,55,54,49,226,8,35,52,47,252},62), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({6,39,53,54,52,49,59,226,23,11},62),
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