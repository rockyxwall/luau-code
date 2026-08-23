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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local RunService = game:GetService(_d({33,68,61,34,52,65,69,56,50,52},49))
local VIM = game:GetService(_d({37,56,65,67,68,48,59,24,61,63,68,67,28,48,61,48,54,52,65},49))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52,253,59,68,48},49)
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
error(_d({42,23,62,65,62,239,69,1,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,33,48,72,53,56,52,59,51,239,36,24,239,27,56,49,65,48,65,72,253},49))
end
local Window = Rayfield:CreateWindow({
Name = _d({23,62,65,62,239,23,62,65,62,239,41,252,21,48,65,60,239,69,1},49),
LoadingTitle = _d({27,62,48,51,56,61,54,239,23,62,65,62,239,69,1,253,253,253},49),
LoadingSubtitle = _d({34,56,59,52,61,67,239,16,56,60,239,30,63,67,56,60,56,73,52,51},49),
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
local MainTab = Window:CreateTab(_d({16,68,67,62,239,21,48,65,60},49), 4483362458)
local SkillTab = Window:CreateTab(_d({34,58,56,59,59,239,34,52,67,67,56,61,54,66},49), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({17,48,50,58,63,48,50,58},49))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({23,62,65,62,252,23,62,65,62},49)) or (bp and bp:FindFirstChild(_d({23,62,65,62,252,23,62,65,62},49)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({29,31,18,66},49))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
local hum = boss:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
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
if key == _d({23,56,67},49) then
return target.CFrame
elseif key == _d({35,48,65,54,52,67},49) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({42,23,62,65,62,239,69,1,44,239,28,52,67,48,67,48,49,59,52,239,55,62,62,58,239,53,48,56,59,52,51,9,239},49) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({42,23,62,65,62,239,69,1,44,239,18,59,52,48,61,52,51,239,68,63,239,63,65,52,69,56,62,68,66,239,66,52,66,66,56,62,61,253},49))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({34,67,48,67,68,66,9,239,38,48,56,67,56,61,54,239,53,62,65,239,17,62,66,66,239,34,63,48,70,61},49)) end
print(_d({42,23,62,65,62,239,69,1,44,239,17,62,66,66},49), _G.HoroSelectedBoss, _d({56,66,239,61,62,67,239,66,63,48,70,61,52,51,253,239,38,48,56,67,56,61,54,253,253,253},49))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({34,67,48,67,68,66,9,239,33,68,61,61,56,61,54,239,18,62,60,49,62},49)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({42,23,62,65,62,239,69,1,44,239,21,56,65,52,51,239,18,239,247,26,48,60,56,58,48,73,52,248},49))
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
print(_d({42,23,62,65,62,239,69,1,44,239,21,56,65,52,51,239,41,239,247,28,56,61,56,239,17,48,65,65,48,54,52,248},49))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({42,23,62,65,62,239,69,1,44,239,21,56,65,52,51,239,20,239,247,34,67,68,61,248},49))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({42,23,62,65,62,239,69,1,44,239,21,56,65,52,51,239,33,239,247,19,52,67,62,61,48,67,56,62,61,248},49))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({34,67,48,67,68,66,9,239,34,59,52,52,63,56,61,54,239,247},49) .. string.format(_d({244,253,0,53},49), finalSleep) .. _d({66,248},49)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({34,67,48,67,68,66,9,239,24,51,59,52},49))
MainTab:CreateDropdown({
Name = _d({34,52,59,52,50,67,239,17,62,66,66},49),
Options = {_d({16,71,52,239,23,48,61,51,239,27,62,54,48,61},49), _d({17,48,61,51,56,67,239,17,62,66,66},49), _d({25,68,73,62,239,67,55,52,239,19,56,48,60,62,61,51,49,48,50,58},49)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({42,23,62,65,62,239,69,1,44,239,34,52,59,52,50,67,52,51,239,67,48,65,54,52,67,9},49), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({34,67,48,65,67,239,16,68,67,62,239,21,48,65,60},49),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({34,52,59,52,50,67,239,17,62,66,66,239,33,52,64,68,56,65,52,51},49),
Content = _d({40,62,68,239,60,68,66,67,239,66,52,59,52,50,67,239,48,239,49,62,66,66,239,53,56,65,66,67,239,49,52,53,62,65,52,239,52,61,48,49,59,56,61,54,239,16,68,67,62,239,21,48,65,60,240},49),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({34,67,48,67,68,66,9,239,24,51,59,52},49)) end
end
print(_d({42,23,62,65,62,239,69,1,44,239,16,68,67,62,239,21,48,65,60,9},49), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({19,52,66,67,65,62,72,239,36,24},49),
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