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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,24,39,63,44,47,43,50,42,245,51,39,47,52,245,57,53,59,56,41,43,244,50,59,39},58)
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
error(_d({33,14,53,56,53,230,60,248,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,24,39,63,44,47,43,50,42,230,27,15,230,18,47,40,56,39,56,63,244},58))
end
local Window = Rayfield:CreateWindow({
Name = _d({14,53,56,53,230,14,53,56,53,230,32,243,12,39,56,51,230,60,248},58),
LoadingTitle = _d({18,53,39,42,47,52,45,230,14,53,56,53,230,60,248,244,244,244},58),
LoadingSubtitle = _d({25,47,50,43,52,58,230,7,47,51,230,21,54,58,47,51,47,64,43,42},58),
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
local MainTab = Window:CreateTab(_d({7,59,58,53,230,12,39,56,51},58), 4483362458)
local SkillTab = Window:CreateTab(_d({25,49,47,50,50,230,25,43,58,58,47,52,45,57},58), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)) or (bp and bp:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = boss:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
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
if key == _d({14,47,58},58) then
return target.CFrame
elseif key == _d({26,39,56,45,43,58},58) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({33,14,53,56,53,230,60,248,35,230,19,43,58,39,58,39,40,50,43,230,46,53,53,49,230,44,39,47,50,43,42,0,230},58) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({33,14,53,56,53,230,60,248,35,230,9,50,43,39,52,43,42,230,59,54,230,54,56,43,60,47,53,59,57,230,57,43,57,57,47,53,52,244},58))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({25,58,39,58,59,57,0,230,29,39,47,58,47,52,45,230,44,53,56,230,8,53,57,57,230,25,54,39,61,52},58)) end
print(_d({33,14,53,56,53,230,60,248,35,230,8,53,57,57},58), _G.HoroSelectedBoss, _d({47,57,230,52,53,58,230,57,54,39,61,52,43,42,244,230,29,39,47,58,47,52,45,244,244,244},58))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({25,58,39,58,59,57,0,230,24,59,52,52,47,52,45,230,9,53,51,40,53},58)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({33,14,53,56,53,230,60,248,35,230,12,47,56,43,42,230,9,230,238,17,39,51,47,49,39,64,43,239},58))
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
print(_d({33,14,53,56,53,230,60,248,35,230,12,47,56,43,42,230,32,230,238,19,47,52,47,230,8,39,56,56,39,45,43,239},58))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({33,14,53,56,53,230,60,248,35,230,12,47,56,43,42,230,11,230,238,25,58,59,52,239},58))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({33,14,53,56,53,230,60,248,35,230,12,47,56,43,42,230,24,230,238,10,43,58,53,52,39,58,47,53,52,239},58))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({25,58,39,58,59,57,0,230,25,50,43,43,54,47,52,45,230,238},58) .. string.format(_d({235,244,247,44},58), finalSleep) .. _d({57,239},58)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({25,58,39,58,59,57,0,230,15,42,50,43},58))
MainTab:CreateDropdown({
Name = _d({25,43,50,43,41,58,230,8,53,57,57},58),
Options = {_d({7,62,43,230,14,39,52,42,230,18,53,45,39,52},58), _d({8,39,52,42,47,58,230,8,53,57,57},58), _d({16,59,64,53,230,58,46,43,230,10,47,39,51,53,52,42,40,39,41,49},58)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({33,14,53,56,53,230,60,248,35,230,25,43,50,43,41,58,43,42,230,58,39,56,45,43,58,0},58), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({25,58,39,56,58,230,7,59,58,53,230,12,39,56,51},58),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({25,43,50,43,41,58,230,8,53,57,57,230,24,43,55,59,47,56,43,42},58),
Content = _d({31,53,59,230,51,59,57,58,230,57,43,50,43,41,58,230,39,230,40,53,57,57,230,44,47,56,57,58,230,40,43,44,53,56,43,230,43,52,39,40,50,47,52,45,230,7,59,58,53,230,12,39,56,51,231},58),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({25,58,39,58,59,57,0,230,15,42,50,43},58)) end
end
print(_d({33,14,53,56,53,230,60,248,35,230,7,59,58,53,230,12,39,56,51,0},58), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({10,43,57,58,56,53,63,230,27,15},58),
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