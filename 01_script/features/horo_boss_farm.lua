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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74,19,81,90,70},27)
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
error(_d({64,45,84,87,84,5,91,23,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,55,70,94,75,78,74,81,73,5,58,46,5,49,78,71,87,70,87,94,19},27))
end
local Window = Rayfield:CreateWindow({
Name = _d({45,84,87,84,5,45,84,87,84,5,63,18,43,70,87,82,5,91,23},27),
LoadingTitle = _d({49,84,70,73,78,83,76,5,45,84,87,84,5,91,23,19,19,19},27),
LoadingSubtitle = _d({56,78,81,74,83,89,5,38,78,82,5,52,85,89,78,82,78,95,74,73},27),
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
local MainTab = Window:CreateTab(_d({38,90,89,84,5,43,70,87,82},27), 4483362458)
local SkillTab = Window:CreateTab(_d({56,80,78,81,81,5,56,74,89,89,78,83,76,88},27), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)) or (bp and bp:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({51,53,40,88},27))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum = boss:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
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
if key == _d({45,78,89},27) then
return target.CFrame
elseif key == _d({57,70,87,76,74,89},27) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({64,45,84,87,84,5,91,23,66,5,50,74,89,70,89,70,71,81,74,5,77,84,84,80,5,75,70,78,81,74,73,31,5},27) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({64,45,84,87,84,5,91,23,66,5,40,81,74,70,83,74,73,5,90,85,5,85,87,74,91,78,84,90,88,5,88,74,88,88,78,84,83,19},27))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,60,70,78,89,78,83,76,5,75,84,87,5,39,84,88,88,5,56,85,70,92,83},27)) end
print(_d({64,45,84,87,84,5,91,23,66,5,39,84,88,88},27), _G.HoroSelectedBoss, _d({78,88,5,83,84,89,5,88,85,70,92,83,74,73,19,5,60,70,78,89,78,83,76,19,19,19},27))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,55,90,83,83,78,83,76,5,40,84,82,71,84},27)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,40,5,13,48,70,82,78,80,70,95,74,14},27))
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
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,63,5,13,50,78,83,78,5,39,70,87,87,70,76,74,14},27))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,42,5,13,56,89,90,83,14},27))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,55,5,13,41,74,89,84,83,70,89,78,84,83,14},27))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,56,81,74,74,85,78,83,76,5,13},27) .. string.format(_d({10,19,22,75},27), finalSleep) .. _d({88,14},27)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({56,89,70,89,90,88,31,5,46,73,81,74},27))
MainTab:CreateDropdown({
Name = _d({56,74,81,74,72,89,5,39,84,88,88},27),
Options = {_d({38,93,74,5,45,70,83,73,5,49,84,76,70,83},27), _d({39,70,83,73,78,89,5,39,84,88,88},27), _d({47,90,95,84,5,89,77,74,5,41,78,70,82,84,83,73,71,70,72,80},27)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({64,45,84,87,84,5,91,23,66,5,56,74,81,74,72,89,74,73,5,89,70,87,76,74,89,31},27), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({56,89,70,87,89,5,38,90,89,84,5,43,70,87,82},27),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({56,74,81,74,72,89,5,39,84,88,88,5,55,74,86,90,78,87,74,73},27),
Content = _d({62,84,90,5,82,90,88,89,5,88,74,81,74,72,89,5,70,5,71,84,88,88,5,75,78,87,88,89,5,71,74,75,84,87,74,5,74,83,70,71,81,78,83,76,5,38,90,89,84,5,43,70,87,82,6},27),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,46,73,81,74},27)) end
end
print(_d({64,45,84,87,84,5,91,23,66,5,38,90,89,84,5,43,70,87,82,31},27), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({41,74,88,89,87,84,94,5,58,46},27),
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