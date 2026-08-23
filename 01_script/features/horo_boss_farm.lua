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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79,24,86,95,75},22)
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
error(_d({69,50,89,92,89,10,96,28,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,60,75,99,80,83,79,86,78,10,63,51,10,54,83,76,92,75,92,99,24},22))
end
local Window = Rayfield:CreateWindow({
Name = _d({50,89,92,89,10,50,89,92,89,10,68,23,48,75,92,87,10,96,28},22),
LoadingTitle = _d({54,89,75,78,83,88,81,10,50,89,92,89,10,96,28,24,24,24},22),
LoadingSubtitle = _d({61,83,86,79,88,94,10,43,83,87,10,57,90,94,83,87,83,100,79,78},22),
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
local MainTab = Window:CreateTab(_d({43,95,94,89,10,48,75,92,87},22), 4483362458)
local SkillTab = Window:CreateTab(_d({61,85,83,86,86,10,61,79,94,94,83,88,81,93},22), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({50,89,92,89,23,50,89,92,89},22)) or (bp and bp:FindFirstChild(_d({50,89,92,89,23,50,89,92,89},22)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({56,58,45,93},22))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum = boss:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
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
if key == _d({50,83,94},22) then
return target.CFrame
elseif key == _d({62,75,92,81,79,94},22) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({69,50,89,92,89,10,96,28,71,10,55,79,94,75,94,75,76,86,79,10,82,89,89,85,10,80,75,83,86,79,78,36,10},22) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({69,50,89,92,89,10,96,28,71,10,45,86,79,75,88,79,78,10,95,90,10,90,92,79,96,83,89,95,93,10,93,79,93,93,83,89,88,24},22))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({61,94,75,94,95,93,36,10,65,75,83,94,83,88,81,10,80,89,92,10,44,89,93,93,10,61,90,75,97,88},22)) end
print(_d({69,50,89,92,89,10,96,28,71,10,44,89,93,93},22), _G.HoroSelectedBoss, _d({83,93,10,88,89,94,10,93,90,75,97,88,79,78,24,10,65,75,83,94,83,88,81,24,24,24},22))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({61,94,75,94,95,93,36,10,60,95,88,88,83,88,81,10,45,89,87,76,89},22)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({69,50,89,92,89,10,96,28,71,10,48,83,92,79,78,10,45,10,18,53,75,87,83,85,75,100,79,19},22))
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
print(_d({69,50,89,92,89,10,96,28,71,10,48,83,92,79,78,10,68,10,18,55,83,88,83,10,44,75,92,92,75,81,79,19},22))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({69,50,89,92,89,10,96,28,71,10,48,83,92,79,78,10,47,10,18,61,94,95,88,19},22))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({69,50,89,92,89,10,96,28,71,10,48,83,92,79,78,10,60,10,18,46,79,94,89,88,75,94,83,89,88,19},22))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({61,94,75,94,95,93,36,10,61,86,79,79,90,83,88,81,10,18},22) .. string.format(_d({15,24,27,80},22), finalSleep) .. _d({93,19},22)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({61,94,75,94,95,93,36,10,51,78,86,79},22))
MainTab:CreateDropdown({
Name = _d({61,79,86,79,77,94,10,44,89,93,93},22),
Options = {_d({43,98,79,10,50,75,88,78,10,54,89,81,75,88},22), _d({44,75,88,78,83,94,10,44,89,93,93},22), _d({52,95,100,89,10,94,82,79,10,46,83,75,87,89,88,78,76,75,77,85},22)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({69,50,89,92,89,10,96,28,71,10,61,79,86,79,77,94,79,78,10,94,75,92,81,79,94,36},22), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({61,94,75,92,94,10,43,95,94,89,10,48,75,92,87},22),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({61,79,86,79,77,94,10,44,89,93,93,10,60,79,91,95,83,92,79,78},22),
Content = _d({67,89,95,10,87,95,93,94,10,93,79,86,79,77,94,10,75,10,76,89,93,93,10,80,83,92,93,94,10,76,79,80,89,92,79,10,79,88,75,76,86,83,88,81,10,43,95,94,89,10,48,75,92,87,11},22),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({61,94,75,94,95,93,36,10,51,78,86,79},22)) end
end
print(_d({69,50,89,92,89,10,96,28,71,10,43,95,94,89,10,48,75,92,87,36},22), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({46,79,93,94,92,89,99,10,63,51},22),
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