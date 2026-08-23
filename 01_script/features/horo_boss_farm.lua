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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,34,49,73,54,57,53,60,52,255,61,49,57,62,255,67,63,69,66,51,53,254,60,69,49},48)
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
error(_d({43,24,63,66,63,240,70,2,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,34,49,73,54,57,53,60,52,240,37,25,240,28,57,50,66,49,66,73,254},48))
end
local Window = Rayfield:CreateWindow({
Name = _d({24,63,66,63,240,24,63,66,63,240,42,253,22,49,66,61,240,70,2},48),
LoadingTitle = _d({28,63,49,52,57,62,55,240,24,63,66,63,240,70,2,254,254,254},48),
LoadingSubtitle = _d({35,57,60,53,62,68,240,17,57,61,240,31,64,68,57,61,57,74,53,52},48),
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
local MainTab = Window:CreateTab(_d({17,69,68,63,240,22,49,66,61},48), 4483362458)
local SkillTab = Window:CreateTab(_d({35,59,57,60,60,240,35,53,68,68,57,62,55,67},48), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)) or (bp and bp:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({30,32,19,67},48))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hum = boss:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
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
if key == _d({24,57,68},48) then
return target.CFrame
elseif key == _d({36,49,66,55,53,68},48) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({43,24,63,66,63,240,70,2,45,240,29,53,68,49,68,49,50,60,53,240,56,63,63,59,240,54,49,57,60,53,52,10,240},48) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({43,24,63,66,63,240,70,2,45,240,19,60,53,49,62,53,52,240,69,64,240,64,66,53,70,57,63,69,67,240,67,53,67,67,57,63,62,254},48))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({35,68,49,68,69,67,10,240,39,49,57,68,57,62,55,240,54,63,66,240,18,63,67,67,240,35,64,49,71,62},48)) end
print(_d({43,24,63,66,63,240,70,2,45,240,18,63,67,67},48), _G.HoroSelectedBoss, _d({57,67,240,62,63,68,240,67,64,49,71,62,53,52,254,240,39,49,57,68,57,62,55,254,254,254},48))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({35,68,49,68,69,67,10,240,34,69,62,62,57,62,55,240,19,63,61,50,63},48)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({43,24,63,66,63,240,70,2,45,240,22,57,66,53,52,240,19,240,248,27,49,61,57,59,49,74,53,249},48))
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
print(_d({43,24,63,66,63,240,70,2,45,240,22,57,66,53,52,240,42,240,248,29,57,62,57,240,18,49,66,66,49,55,53,249},48))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({43,24,63,66,63,240,70,2,45,240,22,57,66,53,52,240,21,240,248,35,68,69,62,249},48))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({43,24,63,66,63,240,70,2,45,240,22,57,66,53,52,240,34,240,248,20,53,68,63,62,49,68,57,63,62,249},48))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({35,68,49,68,69,67,10,240,35,60,53,53,64,57,62,55,240,248},48) .. string.format(_d({245,254,1,54},48), finalSleep) .. _d({67,249},48)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({35,68,49,68,69,67,10,240,25,52,60,53},48))
MainTab:CreateDropdown({
Name = _d({35,53,60,53,51,68,240,18,63,67,67},48),
Options = {_d({17,72,53,240,24,49,62,52,240,28,63,55,49,62},48), _d({18,49,62,52,57,68,240,18,63,67,67},48), _d({26,69,74,63,240,68,56,53,240,20,57,49,61,63,62,52,50,49,51,59},48)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({43,24,63,66,63,240,70,2,45,240,35,53,60,53,51,68,53,52,240,68,49,66,55,53,68,10},48), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({35,68,49,66,68,240,17,69,68,63,240,22,49,66,61},48),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({35,53,60,53,51,68,240,18,63,67,67,240,34,53,65,69,57,66,53,52},48),
Content = _d({41,63,69,240,61,69,67,68,240,67,53,60,53,51,68,240,49,240,50,63,67,67,240,54,57,66,67,68,240,50,53,54,63,66,53,240,53,62,49,50,60,57,62,55,240,17,69,68,63,240,22,49,66,61,241},48),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({35,68,49,68,69,67,10,240,25,52,60,53},48)) end
end
print(_d({43,24,63,66,63,240,70,2,45,240,17,69,68,63,240,22,49,66,61,10},48), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({20,53,67,68,66,63,73,240,37,25},48),
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