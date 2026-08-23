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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56,1,63,72,52},45)
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
error(_d({46,27,66,69,66,243,73,5,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,37,52,76,57,60,56,63,55,243,40,28,243,31,60,53,69,52,69,76,1},45))
end
local Window = Rayfield:CreateWindow({
Name = _d({27,66,69,66,243,27,66,69,66,243,45,0,25,52,69,64,243,73,5},45),
LoadingTitle = _d({31,66,52,55,60,65,58,243,27,66,69,66,243,73,5,1,1,1},45),
LoadingSubtitle = _d({38,60,63,56,65,71,243,20,60,64,243,34,67,71,60,64,60,77,56,55},45),
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
local MainTab = Window:CreateTab(_d({20,72,71,66,243,25,52,69,64},45), 4483362458)
local SkillTab = Window:CreateTab(_d({38,62,60,63,63,243,38,56,71,71,60,65,58,70},45), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({27,66,69,66,0,27,66,69,66},45)) or (bp and bp:FindFirstChild(_d({27,66,69,66,0,27,66,69,66},45)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({33,35,22,70},45))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hum = boss:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
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
if key == _d({27,60,71},45) then
return target.CFrame
elseif key == _d({39,52,69,58,56,71},45) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({46,27,66,69,66,243,73,5,48,243,32,56,71,52,71,52,53,63,56,243,59,66,66,62,243,57,52,60,63,56,55,13,243},45) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({46,27,66,69,66,243,73,5,48,243,22,63,56,52,65,56,55,243,72,67,243,67,69,56,73,60,66,72,70,243,70,56,70,70,60,66,65,1},45))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({38,71,52,71,72,70,13,243,42,52,60,71,60,65,58,243,57,66,69,243,21,66,70,70,243,38,67,52,74,65},45)) end
print(_d({46,27,66,69,66,243,73,5,48,243,21,66,70,70},45), _G.HoroSelectedBoss, _d({60,70,243,65,66,71,243,70,67,52,74,65,56,55,1,243,42,52,60,71,60,65,58,1,1,1},45))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({38,71,52,71,72,70,13,243,37,72,65,65,60,65,58,243,22,66,64,53,66},45)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({46,27,66,69,66,243,73,5,48,243,25,60,69,56,55,243,22,243,251,30,52,64,60,62,52,77,56,252},45))
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
print(_d({46,27,66,69,66,243,73,5,48,243,25,60,69,56,55,243,45,243,251,32,60,65,60,243,21,52,69,69,52,58,56,252},45))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({46,27,66,69,66,243,73,5,48,243,25,60,69,56,55,243,24,243,251,38,71,72,65,252},45))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({46,27,66,69,66,243,73,5,48,243,25,60,69,56,55,243,37,243,251,23,56,71,66,65,52,71,60,66,65,252},45))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({38,71,52,71,72,70,13,243,38,63,56,56,67,60,65,58,243,251},45) .. string.format(_d({248,1,4,57},45), finalSleep) .. _d({70,252},45)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({38,71,52,71,72,70,13,243,28,55,63,56},45))
MainTab:CreateDropdown({
Name = _d({38,56,63,56,54,71,243,21,66,70,70},45),
Options = {_d({20,75,56,243,27,52,65,55,243,31,66,58,52,65},45), _d({21,52,65,55,60,71,243,21,66,70,70},45), _d({29,72,77,66,243,71,59,56,243,23,60,52,64,66,65,55,53,52,54,62},45)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({46,27,66,69,66,243,73,5,48,243,38,56,63,56,54,71,56,55,243,71,52,69,58,56,71,13},45), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({38,71,52,69,71,243,20,72,71,66,243,25,52,69,64},45),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({38,56,63,56,54,71,243,21,66,70,70,243,37,56,68,72,60,69,56,55},45),
Content = _d({44,66,72,243,64,72,70,71,243,70,56,63,56,54,71,243,52,243,53,66,70,70,243,57,60,69,70,71,243,53,56,57,66,69,56,243,56,65,52,53,63,60,65,58,243,20,72,71,66,243,25,52,69,64,244},45),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({38,71,52,71,72,70,13,243,28,55,63,56},45)) end
end
print(_d({46,27,66,69,66,243,73,5,48,243,20,72,71,66,243,25,52,69,64,13},45), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({23,56,70,71,69,66,76,243,40,28},45),
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