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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82,27,89,98,78},19)
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
error(_d({72,53,92,95,92,13,99,31,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,63,78,102,83,86,82,89,81,13,66,54,13,57,86,79,95,78,95,102,27},19))
end
local Window = Rayfield:CreateWindow({
Name = _d({53,92,95,92,13,53,92,95,92,13,71,26,51,78,95,90,13,99,31},19),
LoadingTitle = _d({57,92,78,81,86,91,84,13,53,92,95,92,13,99,31,27,27,27},19),
LoadingSubtitle = _d({64,86,89,82,91,97,13,46,86,90,13,60,93,97,86,90,86,103,82,81},19),
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
local MainTab = Window:CreateTab(_d({46,98,97,92,13,51,78,95,90},19), 4483362458)
local SkillTab = Window:CreateTab(_d({64,88,86,89,89,13,64,82,97,97,86,91,84,96},19), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)) or (bp and bp:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = boss:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
if key == _d({53,86,97},19) then
return target.CFrame
elseif key == _d({65,78,95,84,82,97},19) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({72,53,92,95,92,13,99,31,74,13,58,82,97,78,97,78,79,89,82,13,85,92,92,88,13,83,78,86,89,82,81,39,13},19) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({72,53,92,95,92,13,99,31,74,13,48,89,82,78,91,82,81,13,98,93,13,93,95,82,99,86,92,98,96,13,96,82,96,96,86,92,91,27},19))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,68,78,86,97,86,91,84,13,83,92,95,13,47,92,96,96,13,64,93,78,100,91},19)) end
print(_d({72,53,92,95,92,13,99,31,74,13,47,92,96,96},19), _G.HoroSelectedBoss, _d({86,96,13,91,92,97,13,96,93,78,100,91,82,81,27,13,68,78,86,97,86,91,84,27,27,27},19))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,63,98,91,91,86,91,84,13,48,92,90,79,92},19)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,48,13,21,56,78,90,86,88,78,103,82,22},19))
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
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,71,13,21,58,86,91,86,13,47,78,95,95,78,84,82,22},19))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,50,13,21,64,97,98,91,22},19))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,63,13,21,49,82,97,92,91,78,97,86,92,91,22},19))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,64,89,82,82,93,86,91,84,13,21},19) .. string.format(_d({18,27,30,83},19), finalSleep) .. _d({96,22},19)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({64,97,78,97,98,96,39,13,54,81,89,82},19))
MainTab:CreateDropdown({
Name = _d({64,82,89,82,80,97,13,47,92,96,96},19),
Options = {_d({46,101,82,13,53,78,91,81,13,57,92,84,78,91},19), _d({47,78,91,81,86,97,13,47,92,96,96},19), _d({55,98,103,92,13,97,85,82,13,49,86,78,90,92,91,81,79,78,80,88},19)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({72,53,92,95,92,13,99,31,74,13,64,82,89,82,80,97,82,81,13,97,78,95,84,82,97,39},19), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({64,97,78,95,97,13,46,98,97,92,13,51,78,95,90},19),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({64,82,89,82,80,97,13,47,92,96,96,13,63,82,94,98,86,95,82,81},19),
Content = _d({70,92,98,13,90,98,96,97,13,96,82,89,82,80,97,13,78,13,79,92,96,96,13,83,86,95,96,97,13,79,82,83,92,95,82,13,82,91,78,79,89,86,91,84,13,46,98,97,92,13,51,78,95,90,14},19),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,54,81,89,82},19)) end
end
print(_d({72,53,92,95,92,13,99,31,74,13,46,98,97,92,13,51,78,95,90,39},19), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({49,82,96,97,95,92,102,13,66,54},19),
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