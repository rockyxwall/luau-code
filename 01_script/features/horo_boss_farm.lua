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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,51,66,90,71,74,70,77,69,16,78,66,74,79,16,84,80,86,83,68,70,15,77,86,66},31)
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
error(_d({60,41,80,83,80,1,87,19,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,51,66,90,71,74,70,77,69,1,54,42,1,45,74,67,83,66,83,90,15},31))
end
local Window = Rayfield:CreateWindow({
Name = _d({41,80,83,80,1,41,80,83,80,1,59,14,39,66,83,78,1,87,19},31),
LoadingTitle = _d({45,80,66,69,74,79,72,1,41,80,83,80,1,87,19,15,15,15},31),
LoadingSubtitle = _d({52,74,77,70,79,85,1,34,74,78,1,48,81,85,74,78,74,91,70,69},31),
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
local MainTab = Window:CreateTab(_d({34,86,85,80,1,39,66,83,78},31), 4483362458)
local SkillTab = Window:CreateTab(_d({52,76,74,77,77,1,52,70,85,85,74,79,72,84},31), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)) or (bp and bp:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({47,49,36,84},31))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum = boss:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
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
if key == _d({41,74,85},31) then
return target.CFrame
elseif key == _d({53,66,83,72,70,85},31) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({60,41,80,83,80,1,87,19,62,1,46,70,85,66,85,66,67,77,70,1,73,80,80,76,1,71,66,74,77,70,69,27,1},31) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({60,41,80,83,80,1,87,19,62,1,36,77,70,66,79,70,69,1,86,81,1,81,83,70,87,74,80,86,84,1,84,70,84,84,74,80,79,15},31))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({52,85,66,85,86,84,27,1,56,66,74,85,74,79,72,1,71,80,83,1,35,80,84,84,1,52,81,66,88,79},31)) end
print(_d({60,41,80,83,80,1,87,19,62,1,35,80,84,84},31), _G.HoroSelectedBoss, _d({74,84,1,79,80,85,1,84,81,66,88,79,70,69,15,1,56,66,74,85,74,79,72,15,15,15},31))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({52,85,66,85,86,84,27,1,51,86,79,79,74,79,72,1,36,80,78,67,80},31)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({60,41,80,83,80,1,87,19,62,1,39,74,83,70,69,1,36,1,9,44,66,78,74,76,66,91,70,10},31))
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
print(_d({60,41,80,83,80,1,87,19,62,1,39,74,83,70,69,1,59,1,9,46,74,79,74,1,35,66,83,83,66,72,70,10},31))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({60,41,80,83,80,1,87,19,62,1,39,74,83,70,69,1,38,1,9,52,85,86,79,10},31))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({60,41,80,83,80,1,87,19,62,1,39,74,83,70,69,1,51,1,9,37,70,85,80,79,66,85,74,80,79,10},31))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({52,85,66,85,86,84,27,1,52,77,70,70,81,74,79,72,1,9},31) .. string.format(_d({6,15,18,71},31), finalSleep) .. _d({84,10},31)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({52,85,66,85,86,84,27,1,42,69,77,70},31))
MainTab:CreateDropdown({
Name = _d({52,70,77,70,68,85,1,35,80,84,84},31),
Options = {_d({34,89,70,1,41,66,79,69,1,45,80,72,66,79},31), _d({35,66,79,69,74,85,1,35,80,84,84},31), _d({43,86,91,80,1,85,73,70,1,37,74,66,78,80,79,69,67,66,68,76},31)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({60,41,80,83,80,1,87,19,62,1,52,70,77,70,68,85,70,69,1,85,66,83,72,70,85,27},31), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({52,85,66,83,85,1,34,86,85,80,1,39,66,83,78},31),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({52,70,77,70,68,85,1,35,80,84,84,1,51,70,82,86,74,83,70,69},31),
Content = _d({58,80,86,1,78,86,84,85,1,84,70,77,70,68,85,1,66,1,67,80,84,84,1,71,74,83,84,85,1,67,70,71,80,83,70,1,70,79,66,67,77,74,79,72,1,34,86,85,80,1,39,66,83,78,2},31),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({52,85,66,85,86,84,27,1,42,69,77,70},31)) end
end
print(_d({60,41,80,83,80,1,87,19,62,1,34,86,85,80,1,39,66,83,78,27},31), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({37,70,84,85,83,80,90,1,54,42},31),
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