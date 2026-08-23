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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local VIM = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,19,34,58,39,42,38,45,37,240,46,34,42,47,240,52,48,54,51,36,38,239,45,54,34},63)
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
error(_d({28,9,48,51,48,225,55,243,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,225,19,34,58,39,42,38,45,37,225,22,10,225,13,42,35,51,34,51,58,239},63))
end
local Window = Rayfield:CreateWindow({
Name = _d({9,48,51,48,225,9,48,51,48,225,27,238,7,34,51,46,225,55,243},63),
LoadingTitle = _d({13,48,34,37,42,47,40,225,9,48,51,48,225,55,243,239,239,239},63),
LoadingSubtitle = _d({20,42,45,38,47,53,225,2,42,46,225,16,49,53,42,46,42,59,38,37},63),
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
local MainTab = Window:CreateTab(_d({2,54,53,48,225,7,34,51,46},63), 4483362458)
local SkillTab = Window:CreateTab(_d({20,44,42,45,45,225,20,38,53,53,42,47,40,52},63), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({9,48,51,48,238,9,48,51,48},63)) or (bp and bp:FindFirstChild(_d({9,48,51,48,238,9,48,51,48},63)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({15,17,4,52},63))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum = boss:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
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
if key == _d({9,42,53},63) then
return target.CFrame
elseif key == _d({21,34,51,40,38,53},63) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({28,9,48,51,48,225,55,243,30,225,14,38,53,34,53,34,35,45,38,225,41,48,48,44,225,39,34,42,45,38,37,251,225},63) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({28,9,48,51,48,225,55,243,30,225,4,45,38,34,47,38,37,225,54,49,225,49,51,38,55,42,48,54,52,225,52,38,52,52,42,48,47,239},63))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({20,53,34,53,54,52,251,225,24,34,42,53,42,47,40,225,39,48,51,225,3,48,52,52,225,20,49,34,56,47},63)) end
print(_d({28,9,48,51,48,225,55,243,30,225,3,48,52,52},63), _G.HoroSelectedBoss, _d({42,52,225,47,48,53,225,52,49,34,56,47,38,37,239,225,24,34,42,53,42,47,40,239,239,239},63))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({20,53,34,53,54,52,251,225,19,54,47,47,42,47,40,225,4,48,46,35,48},63)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({28,9,48,51,48,225,55,243,30,225,7,42,51,38,37,225,4,225,233,12,34,46,42,44,34,59,38,234},63))
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
print(_d({28,9,48,51,48,225,55,243,30,225,7,42,51,38,37,225,27,225,233,14,42,47,42,225,3,34,51,51,34,40,38,234},63))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({28,9,48,51,48,225,55,243,30,225,7,42,51,38,37,225,6,225,233,20,53,54,47,234},63))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({28,9,48,51,48,225,55,243,30,225,7,42,51,38,37,225,19,225,233,5,38,53,48,47,34,53,42,48,47,234},63))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({20,53,34,53,54,52,251,225,20,45,38,38,49,42,47,40,225,233},63) .. string.format(_d({230,239,242,39},63), finalSleep) .. _d({52,234},63)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({20,53,34,53,54,52,251,225,10,37,45,38},63))
MainTab:CreateDropdown({
Name = _d({20,38,45,38,36,53,225,3,48,52,52},63),
Options = {_d({2,57,38,225,9,34,47,37,225,13,48,40,34,47},63), _d({3,34,47,37,42,53,225,3,48,52,52},63), _d({11,54,59,48,225,53,41,38,225,5,42,34,46,48,47,37,35,34,36,44},63)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({28,9,48,51,48,225,55,243,30,225,20,38,45,38,36,53,38,37,225,53,34,51,40,38,53,251},63), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({20,53,34,51,53,225,2,54,53,48,225,7,34,51,46},63),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({20,38,45,38,36,53,225,3,48,52,52,225,19,38,50,54,42,51,38,37},63),
Content = _d({26,48,54,225,46,54,52,53,225,52,38,45,38,36,53,225,34,225,35,48,52,52,225,39,42,51,52,53,225,35,38,39,48,51,38,225,38,47,34,35,45,42,47,40,225,2,54,53,48,225,7,34,51,46,226},63),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({20,53,34,53,54,52,251,225,10,37,45,38},63)) end
end
print(_d({28,9,48,51,48,225,55,243,30,225,2,54,53,48,225,7,34,51,46,251},63), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({5,38,52,53,51,48,58,225,22,10},63),
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