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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local VIM = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37,238,44,53,33},64)
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
error(_d({27,8,47,50,47,224,54,242,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,18,33,57,38,41,37,44,36,224,21,9,224,12,41,34,50,33,50,57,238},64))
end
local Window = Rayfield:CreateWindow({
Name = _d({8,47,50,47,224,8,47,50,47,224,26,237,6,33,50,45,224,54,242},64),
LoadingTitle = _d({12,47,33,36,41,46,39,224,8,47,50,47,224,54,242,238,238,238},64),
LoadingSubtitle = _d({19,41,44,37,46,52,224,1,41,45,224,15,48,52,41,45,41,58,37,36},64),
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
local MainTab = Window:CreateTab(_d({1,53,52,47,224,6,33,50,45},64), 4483362458)
local SkillTab = Window:CreateTab(_d({19,43,41,44,44,224,19,37,52,52,41,46,39,51},64), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({8,47,50,47,237,8,47,50,47},64)) or (bp and bp:FindFirstChild(_d({8,47,50,47,237,8,47,50,47},64)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({14,16,3,51},64))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local hum = boss:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
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
if key == _d({8,41,52},64) then
return target.CFrame
elseif key == _d({20,33,50,39,37,52},64) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({27,8,47,50,47,224,54,242,29,224,13,37,52,33,52,33,34,44,37,224,40,47,47,43,224,38,33,41,44,37,36,250,224},64) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({27,8,47,50,47,224,54,242,29,224,3,44,37,33,46,37,36,224,53,48,224,48,50,37,54,41,47,53,51,224,51,37,51,51,41,47,46,238},64))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({19,52,33,52,53,51,250,224,23,33,41,52,41,46,39,224,38,47,50,224,2,47,51,51,224,19,48,33,55,46},64)) end
print(_d({27,8,47,50,47,224,54,242,29,224,2,47,51,51},64), _G.HoroSelectedBoss, _d({41,51,224,46,47,52,224,51,48,33,55,46,37,36,238,224,23,33,41,52,41,46,39,238,238,238},64))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({19,52,33,52,53,51,250,224,18,53,46,46,41,46,39,224,3,47,45,34,47},64)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({27,8,47,50,47,224,54,242,29,224,6,41,50,37,36,224,3,224,232,11,33,45,41,43,33,58,37,233},64))
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
print(_d({27,8,47,50,47,224,54,242,29,224,6,41,50,37,36,224,26,224,232,13,41,46,41,224,2,33,50,50,33,39,37,233},64))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({27,8,47,50,47,224,54,242,29,224,6,41,50,37,36,224,5,224,232,19,52,53,46,233},64))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({27,8,47,50,47,224,54,242,29,224,6,41,50,37,36,224,18,224,232,4,37,52,47,46,33,52,41,47,46,233},64))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({19,52,33,52,53,51,250,224,19,44,37,37,48,41,46,39,224,232},64) .. string.format(_d({229,238,241,38},64), finalSleep) .. _d({51,233},64)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({19,52,33,52,53,51,250,224,9,36,44,37},64))
MainTab:CreateDropdown({
Name = _d({19,37,44,37,35,52,224,2,47,51,51},64),
Options = {_d({1,56,37,224,8,33,46,36,224,12,47,39,33,46},64), _d({2,33,46,36,41,52,224,2,47,51,51},64), _d({10,53,58,47,224,52,40,37,224,4,41,33,45,47,46,36,34,33,35,43},64)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({27,8,47,50,47,224,54,242,29,224,19,37,44,37,35,52,37,36,224,52,33,50,39,37,52,250},64), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({19,52,33,50,52,224,1,53,52,47,224,6,33,50,45},64),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({19,37,44,37,35,52,224,2,47,51,51,224,18,37,49,53,41,50,37,36},64),
Content = _d({25,47,53,224,45,53,51,52,224,51,37,44,37,35,52,224,33,224,34,47,51,51,224,38,41,50,51,52,224,34,37,38,47,50,37,224,37,46,33,34,44,41,46,39,224,1,53,52,47,224,6,33,50,45,225},64),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({19,52,33,52,53,51,250,224,9,36,44,37},64)) end
end
print(_d({27,8,47,50,47,224,54,242,29,224,1,53,52,47,224,6,33,50,45,250},64), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({4,37,51,52,50,47,57,224,21,9},64),
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