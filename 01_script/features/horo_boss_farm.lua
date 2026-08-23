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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71,16,78,87,67},30)
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
error(_d({61,42,81,84,81,2,88,20,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,52,67,91,72,75,71,78,70,2,55,43,2,46,75,68,84,67,84,91,16},30))
end
local Window = Rayfield:CreateWindow({
Name = _d({42,81,84,81,2,42,81,84,81,2,60,15,40,67,84,79,2,88,20},30),
LoadingTitle = _d({46,81,67,70,75,80,73,2,42,81,84,81,2,88,20,16,16,16},30),
LoadingSubtitle = _d({53,75,78,71,80,86,2,35,75,79,2,49,82,86,75,79,75,92,71,70},30),
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
local MainTab = Window:CreateTab(_d({35,87,86,81,2,40,67,84,79},30), 4483362458)
local SkillTab = Window:CreateTab(_d({53,77,75,78,78,2,53,71,86,86,75,80,73,85},30), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)) or (bp and bp:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({48,50,37,85},30))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum = boss:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
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
if key == _d({42,75,86},30) then
return target.CFrame
elseif key == _d({54,67,84,73,71,86},30) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({61,42,81,84,81,2,88,20,63,2,47,71,86,67,86,67,68,78,71,2,74,81,81,77,2,72,67,75,78,71,70,28,2},30) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({61,42,81,84,81,2,88,20,63,2,37,78,71,67,80,71,70,2,87,82,2,82,84,71,88,75,81,87,85,2,85,71,85,85,75,81,80,16},30))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({53,86,67,86,87,85,28,2,57,67,75,86,75,80,73,2,72,81,84,2,36,81,85,85,2,53,82,67,89,80},30)) end
print(_d({61,42,81,84,81,2,88,20,63,2,36,81,85,85},30), _G.HoroSelectedBoss, _d({75,85,2,80,81,86,2,85,82,67,89,80,71,70,16,2,57,67,75,86,75,80,73,16,16,16},30))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({53,86,67,86,87,85,28,2,52,87,80,80,75,80,73,2,37,81,79,68,81},30)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({61,42,81,84,81,2,88,20,63,2,40,75,84,71,70,2,37,2,10,45,67,79,75,77,67,92,71,11},30))
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
print(_d({61,42,81,84,81,2,88,20,63,2,40,75,84,71,70,2,60,2,10,47,75,80,75,2,36,67,84,84,67,73,71,11},30))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({61,42,81,84,81,2,88,20,63,2,40,75,84,71,70,2,39,2,10,53,86,87,80,11},30))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({61,42,81,84,81,2,88,20,63,2,40,75,84,71,70,2,52,2,10,38,71,86,81,80,67,86,75,81,80,11},30))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({53,86,67,86,87,85,28,2,53,78,71,71,82,75,80,73,2,10},30) .. string.format(_d({7,16,19,72},30), finalSleep) .. _d({85,11},30)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({53,86,67,86,87,85,28,2,43,70,78,71},30))
MainTab:CreateDropdown({
Name = _d({53,71,78,71,69,86,2,36,81,85,85},30),
Options = {_d({35,90,71,2,42,67,80,70,2,46,81,73,67,80},30), _d({36,67,80,70,75,86,2,36,81,85,85},30), _d({44,87,92,81,2,86,74,71,2,38,75,67,79,81,80,70,68,67,69,77},30)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({61,42,81,84,81,2,88,20,63,2,53,71,78,71,69,86,71,70,2,86,67,84,73,71,86,28},30), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({53,86,67,84,86,2,35,87,86,81,2,40,67,84,79},30),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({53,71,78,71,69,86,2,36,81,85,85,2,52,71,83,87,75,84,71,70},30),
Content = _d({59,81,87,2,79,87,85,86,2,85,71,78,71,69,86,2,67,2,68,81,85,85,2,72,75,84,85,86,2,68,71,72,81,84,71,2,71,80,67,68,78,75,80,73,2,35,87,86,81,2,40,67,84,79,3},30),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({53,86,67,86,87,85,28,2,43,70,78,71},30)) end
end
print(_d({61,42,81,84,81,2,88,20,63,2,35,87,86,81,2,40,67,84,79,28},30), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({38,71,85,86,84,81,91,2,55,43},30),
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