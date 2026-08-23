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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54)
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
error(_d({37,18,57,60,57,234,64,252,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,22,51,44,60,43,60,67,248},54))
end
local Window = Rayfield:CreateWindow({
Name = _d({18,57,60,57,234,18,57,60,57,234,36,247,16,43,60,55,234,64,252},54),
LoadingTitle = _d({22,57,43,46,51,56,49,234,18,57,60,57,234,64,252,248,248,248},54),
LoadingSubtitle = _d({29,51,54,47,56,62,234,11,51,55,234,25,58,62,51,55,51,68,47,46},54),
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
local MainTab = Window:CreateTab(_d({11,63,62,57,234,16,43,60,55},54), 4483362458)
local SkillTab = Window:CreateTab(_d({29,53,51,54,54,234,29,47,62,62,51,56,49,61},54), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)) or (bp and bp:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = boss:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
if key == _d({18,51,62},54) then
return target.CFrame
elseif key == _d({30,43,60,49,47,62},54) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({37,18,57,60,57,234,64,252,39,234,23,47,62,43,62,43,44,54,47,234,50,57,57,53,234,48,43,51,54,47,46,4,234},54) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({37,18,57,60,57,234,64,252,39,234,13,54,47,43,56,47,46,234,63,58,234,58,60,47,64,51,57,63,61,234,61,47,61,61,51,57,56,248},54))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,33,43,51,62,51,56,49,234,48,57,60,234,12,57,61,61,234,29,58,43,65,56},54)) end
print(_d({37,18,57,60,57,234,64,252,39,234,12,57,61,61},54), _G.HoroSelectedBoss, _d({51,61,234,56,57,62,234,61,58,43,65,56,47,46,248,234,33,43,51,62,51,56,49,248,248,248},54))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,28,63,56,56,51,56,49,234,13,57,55,44,57},54)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,13,234,242,21,43,55,51,53,43,68,47,243},54))
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
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,36,234,242,23,51,56,51,234,12,43,60,60,43,49,47,243},54))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,15,234,242,29,62,63,56,243},54))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,28,234,242,14,47,62,57,56,43,62,51,57,56,243},54))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,29,54,47,47,58,51,56,49,234,242},54) .. string.format(_d({239,248,251,48},54), finalSleep) .. _d({61,243},54)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({29,62,43,62,63,61,4,234,19,46,54,47},54))
MainTab:CreateDropdown({
Name = _d({29,47,54,47,45,62,234,12,57,61,61},54),
Options = {_d({11,66,47,234,18,43,56,46,234,22,57,49,43,56},54), _d({12,43,56,46,51,62,234,12,57,61,61},54), _d({20,63,68,57,234,62,50,47,234,14,51,43,55,57,56,46,44,43,45,53},54)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({37,18,57,60,57,234,64,252,39,234,29,47,54,47,45,62,47,46,234,62,43,60,49,47,62,4},54), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({29,62,43,60,62,234,11,63,62,57,234,16,43,60,55},54),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({29,47,54,47,45,62,234,12,57,61,61,234,28,47,59,63,51,60,47,46},54),
Content = _d({35,57,63,234,55,63,61,62,234,61,47,54,47,45,62,234,43,234,44,57,61,61,234,48,51,60,61,62,234,44,47,48,57,60,47,234,47,56,43,44,54,51,56,49,234,11,63,62,57,234,16,43,60,55,235},54),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,19,46,54,47},54)) end
end
print(_d({37,18,57,60,57,234,64,252,39,234,11,63,62,57,234,16,43,60,55,4},54), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,31,19},54),
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