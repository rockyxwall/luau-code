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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37)
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
error(_d({54,35,74,77,74,251,81,13,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,39,68,61,77,60,77,84,9},37))
end
local Window = Rayfield:CreateWindow({
Name = _d({35,74,77,74,251,35,74,77,74,251,53,8,33,60,77,72,251,81,13},37),
LoadingTitle = _d({39,74,60,63,68,73,66,251,35,74,77,74,251,81,13,9,9,9},37),
LoadingSubtitle = _d({46,68,71,64,73,79,251,28,68,72,251,42,75,79,68,72,68,85,64,63},37),
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
local MainTab = Window:CreateTab(_d({28,80,79,74,251,33,60,77,72},37), 4483362458)
local SkillTab = Window:CreateTab(_d({46,70,68,71,71,251,46,64,79,79,68,73,66,78},37), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)) or (bp and bp:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = boss:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
if key == _d({35,68,79},37) then
return target.CFrame
elseif key == _d({47,60,77,66,64,79},37) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({54,35,74,77,74,251,81,13,56,251,40,64,79,60,79,60,61,71,64,251,67,74,74,70,251,65,60,68,71,64,63,21,251},37) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({54,35,74,77,74,251,81,13,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({46,79,60,79,80,78,21,251,50,60,68,79,68,73,66,251,65,74,77,251,29,74,78,78,251,46,75,60,82,73},37)) end
print(_d({54,35,74,77,74,251,81,13,56,251,29,74,78,78},37), _G.HoroSelectedBoss, _d({68,78,251,73,74,79,251,78,75,60,82,73,64,63,9,251,50,60,68,79,68,73,66,9,9,9},37))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({46,79,60,79,80,78,21,251,45,80,73,73,68,73,66,251,30,74,72,61,74},37)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({54,35,74,77,74,251,81,13,56,251,33,68,77,64,63,251,30,251,3,38,60,72,68,70,60,85,64,4},37))
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
print(_d({54,35,74,77,74,251,81,13,56,251,33,68,77,64,63,251,53,251,3,40,68,73,68,251,29,60,77,77,60,66,64,4},37))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({54,35,74,77,74,251,81,13,56,251,33,68,77,64,63,251,32,251,3,46,79,80,73,4},37))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({54,35,74,77,74,251,81,13,56,251,33,68,77,64,63,251,45,251,3,31,64,79,74,73,60,79,68,74,73,4},37))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({46,79,60,79,80,78,21,251,46,71,64,64,75,68,73,66,251,3},37) .. string.format(_d({0,9,12,65},37), finalSleep) .. _d({78,4},37)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({46,79,60,79,80,78,21,251,36,63,71,64},37))
MainTab:CreateDropdown({
Name = _d({46,64,71,64,62,79,251,29,74,78,78},37),
Options = {_d({28,83,64,251,35,60,73,63,251,39,74,66,60,73},37), _d({29,60,73,63,68,79,251,29,74,78,78},37), _d({37,80,85,74,251,79,67,64,251,31,68,60,72,74,73,63,61,60,62,70},37)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({54,35,74,77,74,251,81,13,56,251,46,64,71,64,62,79,64,63,251,79,60,77,66,64,79,21},37), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({46,79,60,77,79,251,28,80,79,74,251,33,60,77,72},37),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({46,64,71,64,62,79,251,29,74,78,78,251,45,64,76,80,68,77,64,63},37),
Content = _d({52,74,80,251,72,80,78,79,251,78,64,71,64,62,79,251,60,251,61,74,78,78,251,65,68,77,78,79,251,61,64,65,74,77,64,251,64,73,60,61,71,68,73,66,251,28,80,79,74,251,33,60,77,72,252},37),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({46,79,60,79,80,78,21,251,36,63,71,64},37)) end
end
print(_d({54,35,74,77,74,251,81,13,56,251,28,80,79,74,251,33,60,77,72,21},37), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,48,36},37),
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