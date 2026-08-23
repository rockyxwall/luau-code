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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local VIM = game:GetService(_d({69,88,97,99,100,80,91,56,93,95,100,99,60,80,93,80,86,84,97},17))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,65,80,104,85,88,84,91,83,30,92,80,88,93,30,98,94,100,97,82,84,29,91,100,80},17)
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
error(_d({74,55,94,97,94,15,101,33,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,65,80,104,85,88,84,91,83,15,68,56,15,59,88,81,97,80,97,104,29},17))
end
local Window = Rayfield:CreateWindow({
Name = _d({55,94,97,94,15,55,94,97,94,15,73,28,53,80,97,92,15,101,33},17),
LoadingTitle = _d({59,94,80,83,88,93,86,15,55,94,97,94,15,101,33,29,29,29},17),
LoadingSubtitle = _d({66,88,91,84,93,99,15,48,88,92,15,62,95,99,88,92,88,105,84,83},17),
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
local MainTab = Window:CreateTab(_d({48,100,99,94,15,53,80,97,92},17), 4483362458)
local SkillTab = Window:CreateTab(_d({66,90,88,91,91,15,66,84,99,99,88,93,86,98},17), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({49,80,82,90,95,80,82,90},17))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({55,94,97,94,28,55,94,97,94},17)) or (bp and bp:FindFirstChild(_d({55,94,97,94,28,55,94,97,94},17)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({61,63,50,98},17))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
local hum = boss:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
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
if key == _d({55,88,99},17) then
return target.CFrame
elseif key == _d({67,80,97,86,84,99},17) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({74,55,94,97,94,15,101,33,76,15,60,84,99,80,99,80,81,91,84,15,87,94,94,90,15,85,80,88,91,84,83,41,15},17) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({74,55,94,97,94,15,101,33,76,15,50,91,84,80,93,84,83,15,100,95,15,95,97,84,101,88,94,100,98,15,98,84,98,98,88,94,93,29},17))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({66,99,80,99,100,98,41,15,70,80,88,99,88,93,86,15,85,94,97,15,49,94,98,98,15,66,95,80,102,93},17)) end
print(_d({74,55,94,97,94,15,101,33,76,15,49,94,98,98},17), _G.HoroSelectedBoss, _d({88,98,15,93,94,99,15,98,95,80,102,93,84,83,29,15,70,80,88,99,88,93,86,29,29,29},17))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({66,99,80,99,100,98,41,15,65,100,93,93,88,93,86,15,50,94,92,81,94},17)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({74,55,94,97,94,15,101,33,76,15,53,88,97,84,83,15,50,15,23,58,80,92,88,90,80,105,84,24},17))
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
print(_d({74,55,94,97,94,15,101,33,76,15,53,88,97,84,83,15,73,15,23,60,88,93,88,15,49,80,97,97,80,86,84,24},17))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({74,55,94,97,94,15,101,33,76,15,53,88,97,84,83,15,52,15,23,66,99,100,93,24},17))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({74,55,94,97,94,15,101,33,76,15,53,88,97,84,83,15,65,15,23,51,84,99,94,93,80,99,88,94,93,24},17))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({66,99,80,99,100,98,41,15,66,91,84,84,95,88,93,86,15,23},17) .. string.format(_d({20,29,32,85},17), finalSleep) .. _d({98,24},17)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({66,99,80,99,100,98,41,15,56,83,91,84},17))
MainTab:CreateDropdown({
Name = _d({66,84,91,84,82,99,15,49,94,98,98},17),
Options = {_d({48,103,84,15,55,80,93,83,15,59,94,86,80,93},17), _d({49,80,93,83,88,99,15,49,94,98,98},17), _d({57,100,105,94,15,99,87,84,15,51,88,80,92,94,93,83,81,80,82,90},17)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({74,55,94,97,94,15,101,33,76,15,66,84,91,84,82,99,84,83,15,99,80,97,86,84,99,41},17), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({66,99,80,97,99,15,48,100,99,94,15,53,80,97,92},17),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({66,84,91,84,82,99,15,49,94,98,98,15,65,84,96,100,88,97,84,83},17),
Content = _d({72,94,100,15,92,100,98,99,15,98,84,91,84,82,99,15,80,15,81,94,98,98,15,85,88,97,98,99,15,81,84,85,94,97,84,15,84,93,80,81,91,88,93,86,15,48,100,99,94,15,53,80,97,92,16},17),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({66,99,80,99,100,98,41,15,56,83,91,84},17)) end
end
print(_d({74,55,94,97,94,15,101,33,76,15,48,100,99,94,15,53,80,97,92,41},17), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({51,84,98,99,97,94,104,15,68,56},17),
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