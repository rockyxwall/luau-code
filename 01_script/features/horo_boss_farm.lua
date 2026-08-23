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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54,255,61,70,50},47)
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
error(_d({44,25,64,67,64,241,71,3,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,35,50,74,55,58,54,61,53,241,38,26,241,29,58,51,67,50,67,74,255},47))
end
local Window = Rayfield:CreateWindow({
Name = _d({25,64,67,64,241,25,64,67,64,241,43,254,23,50,67,62,241,71,3},47),
LoadingTitle = _d({29,64,50,53,58,63,56,241,25,64,67,64,241,71,3,255,255,255},47),
LoadingSubtitle = _d({36,58,61,54,63,69,241,18,58,62,241,32,65,69,58,62,58,75,54,53},47),
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
local MainTab = Window:CreateTab(_d({18,70,69,64,241,23,50,67,62},47), 4483362458)
local SkillTab = Window:CreateTab(_d({36,60,58,61,61,241,36,54,69,69,58,63,56,68},47), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)) or (bp and bp:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({31,33,20,68},47))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = boss:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
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
if key == _d({25,58,69},47) then
return target.CFrame
elseif key == _d({37,50,67,56,54,69},47) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({44,25,64,67,64,241,71,3,46,241,30,54,69,50,69,50,51,61,54,241,57,64,64,60,241,55,50,58,61,54,53,11,241},47) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({44,25,64,67,64,241,71,3,46,241,20,61,54,50,63,54,53,241,70,65,241,65,67,54,71,58,64,70,68,241,68,54,68,68,58,64,63,255},47))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,40,50,58,69,58,63,56,241,55,64,67,241,19,64,68,68,241,36,65,50,72,63},47)) end
print(_d({44,25,64,67,64,241,71,3,46,241,19,64,68,68},47), _G.HoroSelectedBoss, _d({58,68,241,63,64,69,241,68,65,50,72,63,54,53,255,241,40,50,58,69,58,63,56,255,255,255},47))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,35,70,63,63,58,63,56,241,20,64,62,51,64},47)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,20,241,249,28,50,62,58,60,50,75,54,250},47))
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
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,43,241,249,30,58,63,58,241,19,50,67,67,50,56,54,250},47))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,22,241,249,36,69,70,63,250},47))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,35,241,249,21,54,69,64,63,50,69,58,64,63,250},47))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,36,61,54,54,65,58,63,56,241,249},47) .. string.format(_d({246,255,2,55},47), finalSleep) .. _d({68,250},47)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({36,69,50,69,70,68,11,241,26,53,61,54},47))
MainTab:CreateDropdown({
Name = _d({36,54,61,54,52,69,241,19,64,68,68},47),
Options = {_d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47), _d({19,50,63,53,58,69,241,19,64,68,68},47), _d({27,70,75,64,241,69,57,54,241,21,58,50,62,64,63,53,51,50,52,60},47)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({44,25,64,67,64,241,71,3,46,241,36,54,61,54,52,69,54,53,241,69,50,67,56,54,69,11},47), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({36,69,50,67,69,241,18,70,69,64,241,23,50,67,62},47),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({36,54,61,54,52,69,241,19,64,68,68,241,35,54,66,70,58,67,54,53},47),
Content = _d({42,64,70,241,62,70,68,69,241,68,54,61,54,52,69,241,50,241,51,64,68,68,241,55,58,67,68,69,241,51,54,55,64,67,54,241,54,63,50,51,61,58,63,56,241,18,70,69,64,241,23,50,67,62,242},47),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,26,53,61,54},47)) end
end
print(_d({44,25,64,67,64,241,71,3,46,241,18,70,69,64,241,23,50,67,62,11},47), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,38,26},47),
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