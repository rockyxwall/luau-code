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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,62,77,101,82,85,81,88,80,27,89,77,85,90,27,95,91,97,94,79,81,26,88,97,77},20)
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
error(_d({71,52,91,94,91,12,98,30,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,62,77,101,82,85,81,88,80,12,65,53,12,56,85,78,94,77,94,101,26},20))
end
local Window = Rayfield:CreateWindow({
Name = _d({52,91,94,91,12,52,91,94,91,12,70,25,50,77,94,89,12,98,30},20),
LoadingTitle = _d({56,91,77,80,85,90,83,12,52,91,94,91,12,98,30,26,26,26},20),
LoadingSubtitle = _d({63,85,88,81,90,96,12,45,85,89,12,59,92,96,85,89,85,102,81,80},20),
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
local MainTab = Window:CreateTab(_d({45,97,96,91,12,50,77,94,89},20), 4483362458)
local SkillTab = Window:CreateTab(_d({63,87,85,88,88,12,63,81,96,96,85,90,83,95},20), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)) or (bp and bp:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = boss:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
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
if key == _d({52,85,96},20) then
return target.CFrame
elseif key == _d({64,77,94,83,81,96},20) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({71,52,91,94,91,12,98,30,73,12,57,81,96,77,96,77,78,88,81,12,84,91,91,87,12,82,77,85,88,81,80,38,12},20) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({71,52,91,94,91,12,98,30,73,12,47,88,81,77,90,81,80,12,97,92,12,92,94,81,98,85,91,97,95,12,95,81,95,95,85,91,90,26},20))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,67,77,85,96,85,90,83,12,82,91,94,12,46,91,95,95,12,63,92,77,99,90},20)) end
print(_d({71,52,91,94,91,12,98,30,73,12,46,91,95,95},20), _G.HoroSelectedBoss, _d({85,95,12,90,91,96,12,95,92,77,99,90,81,80,26,12,67,77,85,96,85,90,83,26,26,26},20))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,62,97,90,90,85,90,83,12,47,91,89,78,91},20)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,47,12,20,55,77,89,85,87,77,102,81,21},20))
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
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,70,12,20,57,85,90,85,12,46,77,94,94,77,83,81,21},20))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,49,12,20,63,96,97,90,21},20))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,62,12,20,48,81,96,91,90,77,96,85,91,90,21},20))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,63,88,81,81,92,85,90,83,12,20},20) .. string.format(_d({17,26,29,82},20), finalSleep) .. _d({95,21},20)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({63,96,77,96,97,95,38,12,53,80,88,81},20))
MainTab:CreateDropdown({
Name = _d({63,81,88,81,79,96,12,46,91,95,95},20),
Options = {_d({45,100,81,12,52,77,90,80,12,56,91,83,77,90},20), _d({46,77,90,80,85,96,12,46,91,95,95},20), _d({54,97,102,91,12,96,84,81,12,48,85,77,89,91,90,80,78,77,79,87},20)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({71,52,91,94,91,12,98,30,73,12,63,81,88,81,79,96,81,80,12,96,77,94,83,81,96,38},20), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({63,96,77,94,96,12,45,97,96,91,12,50,77,94,89},20),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({63,81,88,81,79,96,12,46,91,95,95,12,62,81,93,97,85,94,81,80},20),
Content = _d({69,91,97,12,89,97,95,96,12,95,81,88,81,79,96,12,77,12,78,91,95,95,12,82,85,94,95,96,12,78,81,82,91,94,81,12,81,90,77,78,88,85,90,83,12,45,97,96,91,12,50,77,94,89,13},20),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,53,80,88,81},20)) end
end
print(_d({71,52,91,94,91,12,98,30,73,12,45,97,96,91,12,50,77,94,89,38},20), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({48,81,95,96,94,91,101,12,65,53},20),
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