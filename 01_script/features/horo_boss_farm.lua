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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48,249,55,64,44},53)
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
error(_d({38,19,58,61,58,235,65,253,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,29,44,68,49,52,48,55,47,235,32,20,235,23,52,45,61,44,61,68,249},53))
end
local Window = Rayfield:CreateWindow({
Name = _d({19,58,61,58,235,19,58,61,58,235,37,248,17,44,61,56,235,65,253},53),
LoadingTitle = _d({23,58,44,47,52,57,50,235,19,58,61,58,235,65,253,249,249,249},53),
LoadingSubtitle = _d({30,52,55,48,57,63,235,12,52,56,235,26,59,63,52,56,52,69,48,47},53),
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
local MainTab = Window:CreateTab(_d({12,64,63,58,235,17,44,61,56},53), 4483362458)
local SkillTab = Window:CreateTab(_d({30,54,52,55,55,235,30,48,63,63,52,57,50,62},53), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({19,58,61,58,248,19,58,61,58},53)) or (bp and bp:FindFirstChild(_d({19,58,61,58,248,19,58,61,58},53)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({25,27,14,62},53))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local hum = boss:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
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
if key == _d({19,52,63},53) then
return target.CFrame
elseif key == _d({31,44,61,50,48,63},53) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({38,19,58,61,58,235,65,253,40,235,24,48,63,44,63,44,45,55,48,235,51,58,58,54,235,49,44,52,55,48,47,5,235},53) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({38,19,58,61,58,235,65,253,40,235,14,55,48,44,57,48,47,235,64,59,235,59,61,48,65,52,58,64,62,235,62,48,62,62,52,58,57,249},53))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({30,63,44,63,64,62,5,235,34,44,52,63,52,57,50,235,49,58,61,235,13,58,62,62,235,30,59,44,66,57},53)) end
print(_d({38,19,58,61,58,235,65,253,40,235,13,58,62,62},53), _G.HoroSelectedBoss, _d({52,62,235,57,58,63,235,62,59,44,66,57,48,47,249,235,34,44,52,63,52,57,50,249,249,249},53))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({30,63,44,63,64,62,5,235,29,64,57,57,52,57,50,235,14,58,56,45,58},53)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({38,19,58,61,58,235,65,253,40,235,17,52,61,48,47,235,14,235,243,22,44,56,52,54,44,69,48,244},53))
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
print(_d({38,19,58,61,58,235,65,253,40,235,17,52,61,48,47,235,37,235,243,24,52,57,52,235,13,44,61,61,44,50,48,244},53))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({38,19,58,61,58,235,65,253,40,235,17,52,61,48,47,235,16,235,243,30,63,64,57,244},53))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({38,19,58,61,58,235,65,253,40,235,17,52,61,48,47,235,29,235,243,15,48,63,58,57,44,63,52,58,57,244},53))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({30,63,44,63,64,62,5,235,30,55,48,48,59,52,57,50,235,243},53) .. string.format(_d({240,249,252,49},53), finalSleep) .. _d({62,244},53)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({30,63,44,63,64,62,5,235,20,47,55,48},53))
MainTab:CreateDropdown({
Name = _d({30,48,55,48,46,63,235,13,58,62,62},53),
Options = {_d({12,67,48,235,19,44,57,47,235,23,58,50,44,57},53), _d({13,44,57,47,52,63,235,13,58,62,62},53), _d({21,64,69,58,235,63,51,48,235,15,52,44,56,58,57,47,45,44,46,54},53)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({38,19,58,61,58,235,65,253,40,235,30,48,55,48,46,63,48,47,235,63,44,61,50,48,63,5},53), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({30,63,44,61,63,235,12,64,63,58,235,17,44,61,56},53),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({30,48,55,48,46,63,235,13,58,62,62,235,29,48,60,64,52,61,48,47},53),
Content = _d({36,58,64,235,56,64,62,63,235,62,48,55,48,46,63,235,44,235,45,58,62,62,235,49,52,61,62,63,235,45,48,49,58,61,48,235,48,57,44,45,55,52,57,50,235,12,64,63,58,235,17,44,61,56,236},53),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({30,63,44,63,64,62,5,235,20,47,55,48},53)) end
end
print(_d({38,19,58,61,58,235,65,253,40,235,12,64,63,58,235,17,44,61,56,5},53), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({15,48,62,63,61,58,68,235,32,20},53),
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