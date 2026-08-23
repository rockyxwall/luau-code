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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73,18,80,89,69},28)
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
error(_d({63,44,83,86,83,4,90,22,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,54,69,93,74,77,73,80,72,4,57,45,4,48,77,70,86,69,86,93,18},28))
end
local Window = Rayfield:CreateWindow({
Name = _d({44,83,86,83,4,44,83,86,83,4,62,17,42,69,86,81,4,90,22},28),
LoadingTitle = _d({48,83,69,72,77,82,75,4,44,83,86,83,4,90,22,18,18,18},28),
LoadingSubtitle = _d({55,77,80,73,82,88,4,37,77,81,4,51,84,88,77,81,77,94,73,72},28),
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
local MainTab = Window:CreateTab(_d({37,89,88,83,4,42,69,86,81},28), 4483362458)
local SkillTab = Window:CreateTab(_d({55,79,77,80,80,4,55,73,88,88,77,82,75,87},28), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)) or (bp and bp:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hum = boss:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
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
if key == _d({44,77,88},28) then
return target.CFrame
elseif key == _d({56,69,86,75,73,88},28) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({63,44,83,86,83,4,90,22,65,4,49,73,88,69,88,69,70,80,73,4,76,83,83,79,4,74,69,77,80,73,72,30,4},28) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({63,44,83,86,83,4,90,22,65,4,39,80,73,69,82,73,72,4,89,84,4,84,86,73,90,77,83,89,87,4,87,73,87,87,77,83,82,18},28))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({55,88,69,88,89,87,30,4,59,69,77,88,77,82,75,4,74,83,86,4,38,83,87,87,4,55,84,69,91,82},28)) end
print(_d({63,44,83,86,83,4,90,22,65,4,38,83,87,87},28), _G.HoroSelectedBoss, _d({77,87,4,82,83,88,4,87,84,69,91,82,73,72,18,4,59,69,77,88,77,82,75,18,18,18},28))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({55,88,69,88,89,87,30,4,54,89,82,82,77,82,75,4,39,83,81,70,83},28)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({63,44,83,86,83,4,90,22,65,4,42,77,86,73,72,4,39,4,12,47,69,81,77,79,69,94,73,13},28))
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
print(_d({63,44,83,86,83,4,90,22,65,4,42,77,86,73,72,4,62,4,12,49,77,82,77,4,38,69,86,86,69,75,73,13},28))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({63,44,83,86,83,4,90,22,65,4,42,77,86,73,72,4,41,4,12,55,88,89,82,13},28))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({63,44,83,86,83,4,90,22,65,4,42,77,86,73,72,4,54,4,12,40,73,88,83,82,69,88,77,83,82,13},28))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({55,88,69,88,89,87,30,4,55,80,73,73,84,77,82,75,4,12},28) .. string.format(_d({9,18,21,74},28), finalSleep) .. _d({87,13},28)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({55,88,69,88,89,87,30,4,45,72,80,73},28))
MainTab:CreateDropdown({
Name = _d({55,73,80,73,71,88,4,38,83,87,87},28),
Options = {_d({37,92,73,4,44,69,82,72,4,48,83,75,69,82},28), _d({38,69,82,72,77,88,4,38,83,87,87},28), _d({46,89,94,83,4,88,76,73,4,40,77,69,81,83,82,72,70,69,71,79},28)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({63,44,83,86,83,4,90,22,65,4,55,73,80,73,71,88,73,72,4,88,69,86,75,73,88,30},28), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({55,88,69,86,88,4,37,89,88,83,4,42,69,86,81},28),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({55,73,80,73,71,88,4,38,83,87,87,4,54,73,85,89,77,86,73,72},28),
Content = _d({61,83,89,4,81,89,87,88,4,87,73,80,73,71,88,4,69,4,70,83,87,87,4,74,77,86,87,88,4,70,73,74,83,86,73,4,73,82,69,70,80,77,82,75,4,37,89,88,83,4,42,69,86,81,5},28),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({55,88,69,88,89,87,30,4,45,72,80,73},28)) end
end
print(_d({63,44,83,86,83,4,90,22,65,4,37,89,88,83,4,42,69,86,81,30},28), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({40,73,87,88,86,83,93,4,57,45},28),
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