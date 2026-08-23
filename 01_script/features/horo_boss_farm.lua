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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26)
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
error(_d({65,46,85,88,85,6,92,24,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,50,79,72,88,71,88,95,20},26))
end
local Window = Rayfield:CreateWindow({
Name = _d({46,85,88,85,6,46,85,88,85,6,64,19,44,71,88,83,6,92,24},26),
LoadingTitle = _d({50,85,71,74,79,84,77,6,46,85,88,85,6,92,24,20,20,20},26),
LoadingSubtitle = _d({57,79,82,75,84,90,6,39,79,83,6,53,86,90,79,83,79,96,75,74},26),
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
local MainTab = Window:CreateTab(_d({39,91,90,85,6,44,71,88,83},26), 4483362458)
local SkillTab = Window:CreateTab(_d({57,81,79,82,82,6,57,75,90,90,79,84,77,89},26), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)) or (bp and bp:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = boss:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
if key == _d({46,79,90},26) then
return target.CFrame
elseif key == _d({58,71,88,77,75,90},26) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({65,46,85,88,85,6,92,24,67,6,51,75,90,71,90,71,72,82,75,6,78,85,85,81,6,76,71,79,82,75,74,32,6},26) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({65,46,85,88,85,6,92,24,67,6,41,82,75,71,84,75,74,6,91,86,6,86,88,75,92,79,85,91,89,6,89,75,89,89,79,85,84,20},26))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,61,71,79,90,79,84,77,6,76,85,88,6,40,85,89,89,6,57,86,71,93,84},26)) end
print(_d({65,46,85,88,85,6,92,24,67,6,40,85,89,89},26), _G.HoroSelectedBoss, _d({79,89,6,84,85,90,6,89,86,71,93,84,75,74,20,6,61,71,79,90,79,84,77,20,20,20},26))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,56,91,84,84,79,84,77,6,41,85,83,72,85},26)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,41,6,14,49,71,83,79,81,71,96,75,15},26))
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
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,64,6,14,51,79,84,79,6,40,71,88,88,71,77,75,15},26))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,43,6,14,57,90,91,84,15},26))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,56,6,14,42,75,90,85,84,71,90,79,85,84,15},26))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,57,82,75,75,86,79,84,77,6,14},26) .. string.format(_d({11,20,23,76},26), finalSleep) .. _d({89,15},26)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({57,90,71,90,91,89,32,6,47,74,82,75},26))
MainTab:CreateDropdown({
Name = _d({57,75,82,75,73,90,6,40,85,89,89},26),
Options = {_d({39,94,75,6,46,71,84,74,6,50,85,77,71,84},26), _d({40,71,84,74,79,90,6,40,85,89,89},26), _d({48,91,96,85,6,90,78,75,6,42,79,71,83,85,84,74,72,71,73,81},26)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({65,46,85,88,85,6,92,24,67,6,57,75,82,75,73,90,75,74,6,90,71,88,77,75,90,32},26), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({57,90,71,88,90,6,39,91,90,85,6,44,71,88,83},26),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({57,75,82,75,73,90,6,40,85,89,89,6,56,75,87,91,79,88,75,74},26),
Content = _d({63,85,91,6,83,91,89,90,6,89,75,82,75,73,90,6,71,6,72,85,89,89,6,76,79,88,89,90,6,72,75,76,85,88,75,6,75,84,71,72,82,79,84,77,6,39,91,90,85,6,44,71,88,83,7},26),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,47,74,82,75},26)) end
end
print(_d({65,46,85,88,85,6,92,24,67,6,39,91,90,85,6,44,71,88,83,32},26), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,59,47},26),
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