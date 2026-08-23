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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local VIM = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,53,68,92,73,76,72,79,71,18,80,68,76,81,18,86,82,88,85,70,72,17,79,88,68},29)
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
error(_d({62,43,82,85,82,3,89,21,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,53,68,92,73,76,72,79,71,3,56,44,3,47,76,69,85,68,85,92,17},29))
end
local Window = Rayfield:CreateWindow({
Name = _d({43,82,85,82,3,43,82,85,82,3,61,16,41,68,85,80,3,89,21},29),
LoadingTitle = _d({47,82,68,71,76,81,74,3,43,82,85,82,3,89,21,17,17,17},29),
LoadingSubtitle = _d({54,76,79,72,81,87,3,36,76,80,3,50,83,87,76,80,76,93,72,71},29),
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
local MainTab = Window:CreateTab(_d({36,88,87,82,3,41,68,85,80},29), 4483362458)
local SkillTab = Window:CreateTab(_d({54,78,76,79,79,3,54,72,87,87,76,81,74,86},29), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({43,82,85,82,16,43,82,85,82},29)) or (bp and bp:FindFirstChild(_d({43,82,85,82,16,43,82,85,82},29)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local hum = boss:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
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
if key == _d({43,76,87},29) then
return target.CFrame
elseif key == _d({55,68,85,74,72,87},29) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({62,43,82,85,82,3,89,21,64,3,48,72,87,68,87,68,69,79,72,3,75,82,82,78,3,73,68,76,79,72,71,29,3},29) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({62,43,82,85,82,3,89,21,64,3,38,79,72,68,81,72,71,3,88,83,3,83,85,72,89,76,82,88,86,3,86,72,86,86,76,82,81,17},29))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({54,87,68,87,88,86,29,3,58,68,76,87,76,81,74,3,73,82,85,3,37,82,86,86,3,54,83,68,90,81},29)) end
print(_d({62,43,82,85,82,3,89,21,64,3,37,82,86,86},29), _G.HoroSelectedBoss, _d({76,86,3,81,82,87,3,86,83,68,90,81,72,71,17,3,58,68,76,87,76,81,74,17,17,17},29))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({54,87,68,87,88,86,29,3,53,88,81,81,76,81,74,3,38,82,80,69,82},29)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({62,43,82,85,82,3,89,21,64,3,41,76,85,72,71,3,38,3,11,46,68,80,76,78,68,93,72,12},29))
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
print(_d({62,43,82,85,82,3,89,21,64,3,41,76,85,72,71,3,61,3,11,48,76,81,76,3,37,68,85,85,68,74,72,12},29))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({62,43,82,85,82,3,89,21,64,3,41,76,85,72,71,3,40,3,11,54,87,88,81,12},29))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({62,43,82,85,82,3,89,21,64,3,41,76,85,72,71,3,53,3,11,39,72,87,82,81,68,87,76,82,81,12},29))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({54,87,68,87,88,86,29,3,54,79,72,72,83,76,81,74,3,11},29) .. string.format(_d({8,17,20,73},29), finalSleep) .. _d({86,12},29)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({54,87,68,87,88,86,29,3,44,71,79,72},29))
MainTab:CreateDropdown({
Name = _d({54,72,79,72,70,87,3,37,82,86,86},29),
Options = {_d({36,91,72,3,43,68,81,71,3,47,82,74,68,81},29), _d({37,68,81,71,76,87,3,37,82,86,86},29), _d({45,88,93,82,3,87,75,72,3,39,76,68,80,82,81,71,69,68,70,78},29)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({62,43,82,85,82,3,89,21,64,3,54,72,79,72,70,87,72,71,3,87,68,85,74,72,87,29},29), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({54,87,68,85,87,3,36,88,87,82,3,41,68,85,80},29),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({54,72,79,72,70,87,3,37,82,86,86,3,53,72,84,88,76,85,72,71},29),
Content = _d({60,82,88,3,80,88,86,87,3,86,72,79,72,70,87,3,68,3,69,82,86,86,3,73,76,85,86,87,3,69,72,73,82,85,72,3,72,81,68,69,79,76,81,74,3,36,88,87,82,3,41,68,85,80,4},29),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({54,87,68,87,88,86,29,3,44,71,79,72},29)) end
end
print(_d({62,43,82,85,82,3,89,21,64,3,36,88,87,82,3,41,68,85,80,29},29), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({39,72,86,87,85,82,92,3,56,44},29),
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