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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,26,41,65,46,49,45,52,44,247,53,41,49,54,247,59,55,61,58,43,45,246,52,61,41},56)
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
error(_d({35,16,55,58,55,232,62,250,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,26,41,65,46,49,45,52,44,232,29,17,232,20,49,42,58,41,58,65,246},56))
end
local Window = Rayfield:CreateWindow({
Name = _d({16,55,58,55,232,16,55,58,55,232,34,245,14,41,58,53,232,62,250},56),
LoadingTitle = _d({20,55,41,44,49,54,47,232,16,55,58,55,232,62,250,246,246,246},56),
LoadingSubtitle = _d({27,49,52,45,54,60,232,9,49,53,232,23,56,60,49,53,49,66,45,44},56),
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
local MainTab = Window:CreateTab(_d({9,61,60,55,232,14,41,58,53},56), 4483362458)
local SkillTab = Window:CreateTab(_d({27,51,49,52,52,232,27,45,60,60,49,54,47,59},56), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)) or (bp and bp:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({22,24,11,59},56))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hum = boss:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
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
if key == _d({16,49,60},56) then
return target.CFrame
elseif key == _d({28,41,58,47,45,60},56) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({35,16,55,58,55,232,62,250,37,232,21,45,60,41,60,41,42,52,45,232,48,55,55,51,232,46,41,49,52,45,44,2,232},56) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({35,16,55,58,55,232,62,250,37,232,11,52,45,41,54,45,44,232,61,56,232,56,58,45,62,49,55,61,59,232,59,45,59,59,49,55,54,246},56))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({27,60,41,60,61,59,2,232,31,41,49,60,49,54,47,232,46,55,58,232,10,55,59,59,232,27,56,41,63,54},56)) end
print(_d({35,16,55,58,55,232,62,250,37,232,10,55,59,59},56), _G.HoroSelectedBoss, _d({49,59,232,54,55,60,232,59,56,41,63,54,45,44,246,232,31,41,49,60,49,54,47,246,246,246},56))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({27,60,41,60,61,59,2,232,26,61,54,54,49,54,47,232,11,55,53,42,55},56)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({35,16,55,58,55,232,62,250,37,232,14,49,58,45,44,232,11,232,240,19,41,53,49,51,41,66,45,241},56))
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
print(_d({35,16,55,58,55,232,62,250,37,232,14,49,58,45,44,232,34,232,240,21,49,54,49,232,10,41,58,58,41,47,45,241},56))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({35,16,55,58,55,232,62,250,37,232,14,49,58,45,44,232,13,232,240,27,60,61,54,241},56))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({35,16,55,58,55,232,62,250,37,232,14,49,58,45,44,232,26,232,240,12,45,60,55,54,41,60,49,55,54,241},56))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({27,60,41,60,61,59,2,232,27,52,45,45,56,49,54,47,232,240},56) .. string.format(_d({237,246,249,46},56), finalSleep) .. _d({59,241},56)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({27,60,41,60,61,59,2,232,17,44,52,45},56))
MainTab:CreateDropdown({
Name = _d({27,45,52,45,43,60,232,10,55,59,59},56),
Options = {_d({9,64,45,232,16,41,54,44,232,20,55,47,41,54},56), _d({10,41,54,44,49,60,232,10,55,59,59},56), _d({18,61,66,55,232,60,48,45,232,12,49,41,53,55,54,44,42,41,43,51},56)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({35,16,55,58,55,232,62,250,37,232,27,45,52,45,43,60,45,44,232,60,41,58,47,45,60,2},56), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({27,60,41,58,60,232,9,61,60,55,232,14,41,58,53},56),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({27,45,52,45,43,60,232,10,55,59,59,232,26,45,57,61,49,58,45,44},56),
Content = _d({33,55,61,232,53,61,59,60,232,59,45,52,45,43,60,232,41,232,42,55,59,59,232,46,49,58,59,60,232,42,45,46,55,58,45,232,45,54,41,42,52,49,54,47,232,9,61,60,55,232,14,41,58,53,233},56),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({27,60,41,60,61,59,2,232,17,44,52,45},56)) end
end
print(_d({35,16,55,58,55,232,62,250,37,232,9,61,60,55,232,14,41,58,53,2},56), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({12,45,59,60,58,55,65,232,29,17},56),
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