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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,32,47,71,52,55,51,58,50,253,59,47,55,60,253,65,61,67,64,49,51,252,58,67,47},50)
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
error(_d({41,22,61,64,61,238,68,0,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,238,32,47,71,52,55,51,58,50,238,35,23,238,26,55,48,64,47,64,71,252},50))
end
local Window = Rayfield:CreateWindow({
Name = _d({22,61,64,61,238,22,61,64,61,238,40,251,20,47,64,59,238,68,0},50),
LoadingTitle = _d({26,61,47,50,55,60,53,238,22,61,64,61,238,68,0,252,252,252},50),
LoadingSubtitle = _d({33,55,58,51,60,66,238,15,55,59,238,29,62,66,55,59,55,72,51,50},50),
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
local MainTab = Window:CreateTab(_d({15,67,66,61,238,20,47,64,59},50), 4483362458)
local SkillTab = Window:CreateTab(_d({33,57,55,58,58,238,33,51,66,66,55,60,53,65},50), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)) or (bp and bp:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum = boss:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
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
if key == _d({22,55,66},50) then
return target.CFrame
elseif key == _d({34,47,64,53,51,66},50) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({41,22,61,64,61,238,68,0,43,238,27,51,66,47,66,47,48,58,51,238,54,61,61,57,238,52,47,55,58,51,50,8,238},50) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({41,22,61,64,61,238,68,0,43,238,17,58,51,47,60,51,50,238,67,62,238,62,64,51,68,55,61,67,65,238,65,51,65,65,55,61,60,252},50))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({33,66,47,66,67,65,8,238,37,47,55,66,55,60,53,238,52,61,64,238,16,61,65,65,238,33,62,47,69,60},50)) end
print(_d({41,22,61,64,61,238,68,0,43,238,16,61,65,65},50), _G.HoroSelectedBoss, _d({55,65,238,60,61,66,238,65,62,47,69,60,51,50,252,238,37,47,55,66,55,60,53,252,252,252},50))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({33,66,47,66,67,65,8,238,32,67,60,60,55,60,53,238,17,61,59,48,61},50)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({41,22,61,64,61,238,68,0,43,238,20,55,64,51,50,238,17,238,246,25,47,59,55,57,47,72,51,247},50))
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
print(_d({41,22,61,64,61,238,68,0,43,238,20,55,64,51,50,238,40,238,246,27,55,60,55,238,16,47,64,64,47,53,51,247},50))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({41,22,61,64,61,238,68,0,43,238,20,55,64,51,50,238,19,238,246,33,66,67,60,247},50))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({41,22,61,64,61,238,68,0,43,238,20,55,64,51,50,238,32,238,246,18,51,66,61,60,47,66,55,61,60,247},50))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({33,66,47,66,67,65,8,238,33,58,51,51,62,55,60,53,238,246},50) .. string.format(_d({243,252,255,52},50), finalSleep) .. _d({65,247},50)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({33,66,47,66,67,65,8,238,23,50,58,51},50))
MainTab:CreateDropdown({
Name = _d({33,51,58,51,49,66,238,16,61,65,65},50),
Options = {_d({15,70,51,238,22,47,60,50,238,26,61,53,47,60},50), _d({16,47,60,50,55,66,238,16,61,65,65},50), _d({24,67,72,61,238,66,54,51,238,18,55,47,59,61,60,50,48,47,49,57},50)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({41,22,61,64,61,238,68,0,43,238,33,51,58,51,49,66,51,50,238,66,47,64,53,51,66,8},50), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({33,66,47,64,66,238,15,67,66,61,238,20,47,64,59},50),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({33,51,58,51,49,66,238,16,61,65,65,238,32,51,63,67,55,64,51,50},50),
Content = _d({39,61,67,238,59,67,65,66,238,65,51,58,51,49,66,238,47,238,48,61,65,65,238,52,55,64,65,66,238,48,51,52,61,64,51,238,51,60,47,48,58,55,60,53,238,15,67,66,61,238,20,47,64,59,239},50),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({33,66,47,66,67,65,8,238,23,50,58,51},50)) end
end
print(_d({41,22,61,64,61,238,68,0,43,238,15,67,66,61,238,20,47,64,59,8},50), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({18,51,65,66,64,61,71,238,35,23},50),
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