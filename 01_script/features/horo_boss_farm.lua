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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,30,45,69,50,53,49,56,48,251,57,45,53,58,251,63,59,65,62,47,49,250,56,65,45},52)
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
error(_d({39,20,59,62,59,236,66,254,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,30,45,69,50,53,49,56,48,236,33,21,236,24,53,46,62,45,62,69,250},52))
end
local Window = Rayfield:CreateWindow({
Name = _d({20,59,62,59,236,20,59,62,59,236,38,249,18,45,62,57,236,66,254},52),
LoadingTitle = _d({24,59,45,48,53,58,51,236,20,59,62,59,236,66,254,250,250,250},52),
LoadingSubtitle = _d({31,53,56,49,58,64,236,13,53,57,236,27,60,64,53,57,53,70,49,48},52),
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
local MainTab = Window:CreateTab(_d({13,65,64,59,236,18,45,62,57},52), 4483362458)
local SkillTab = Window:CreateTab(_d({31,55,53,56,56,236,31,49,64,64,53,58,51,63},52), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)) or (bp and bp:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = boss:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
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
if key == _d({20,53,64},52) then
return target.CFrame
elseif key == _d({32,45,62,51,49,64},52) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({39,20,59,62,59,236,66,254,41,236,25,49,64,45,64,45,46,56,49,236,52,59,59,55,236,50,45,53,56,49,48,6,236},52) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({39,20,59,62,59,236,66,254,41,236,15,56,49,45,58,49,48,236,65,60,236,60,62,49,66,53,59,65,63,236,63,49,63,63,53,59,58,250},52))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({31,64,45,64,65,63,6,236,35,45,53,64,53,58,51,236,50,59,62,236,14,59,63,63,236,31,60,45,67,58},52)) end
print(_d({39,20,59,62,59,236,66,254,41,236,14,59,63,63},52), _G.HoroSelectedBoss, _d({53,63,236,58,59,64,236,63,60,45,67,58,49,48,250,236,35,45,53,64,53,58,51,250,250,250},52))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({31,64,45,64,65,63,6,236,30,65,58,58,53,58,51,236,15,59,57,46,59},52)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({39,20,59,62,59,236,66,254,41,236,18,53,62,49,48,236,15,236,244,23,45,57,53,55,45,70,49,245},52))
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
print(_d({39,20,59,62,59,236,66,254,41,236,18,53,62,49,48,236,38,236,244,25,53,58,53,236,14,45,62,62,45,51,49,245},52))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({39,20,59,62,59,236,66,254,41,236,18,53,62,49,48,236,17,236,244,31,64,65,58,245},52))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({39,20,59,62,59,236,66,254,41,236,18,53,62,49,48,236,30,236,244,16,49,64,59,58,45,64,53,59,58,245},52))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({31,64,45,64,65,63,6,236,31,56,49,49,60,53,58,51,236,244},52) .. string.format(_d({241,250,253,50},52), finalSleep) .. _d({63,245},52)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({31,64,45,64,65,63,6,236,21,48,56,49},52))
MainTab:CreateDropdown({
Name = _d({31,49,56,49,47,64,236,14,59,63,63},52),
Options = {_d({13,68,49,236,20,45,58,48,236,24,59,51,45,58},52), _d({14,45,58,48,53,64,236,14,59,63,63},52), _d({22,65,70,59,236,64,52,49,236,16,53,45,57,59,58,48,46,45,47,55},52)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({39,20,59,62,59,236,66,254,41,236,31,49,56,49,47,64,49,48,236,64,45,62,51,49,64,6},52), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({31,64,45,62,64,236,13,65,64,59,236,18,45,62,57},52),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({31,49,56,49,47,64,236,14,59,63,63,236,30,49,61,65,53,62,49,48},52),
Content = _d({37,59,65,236,57,65,63,64,236,63,49,56,49,47,64,236,45,236,46,59,63,63,236,50,53,62,63,64,236,46,49,50,59,62,49,236,49,58,45,46,56,53,58,51,236,13,65,64,59,236,18,45,62,57,237},52),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({31,64,45,64,65,63,6,236,21,48,56,49},52)) end
end
print(_d({39,20,59,62,59,236,66,254,41,236,13,65,64,59,236,18,45,62,57,6},52), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({16,49,63,64,62,59,69,236,33,21},52),
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