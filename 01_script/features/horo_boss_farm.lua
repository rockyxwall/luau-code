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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59,4,66,75,55},42)
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
error(_d({49,30,69,72,69,246,76,8,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,40,55,79,60,63,59,66,58,246,43,31,246,34,63,56,72,55,72,79,4},42))
end
local Window = Rayfield:CreateWindow({
Name = _d({30,69,72,69,246,30,69,72,69,246,48,3,28,55,72,67,246,76,8},42),
LoadingTitle = _d({34,69,55,58,63,68,61,246,30,69,72,69,246,76,8,4,4,4},42),
LoadingSubtitle = _d({41,63,66,59,68,74,246,23,63,67,246,37,70,74,63,67,63,80,59,58},42),
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
local MainTab = Window:CreateTab(_d({23,75,74,69,246,28,55,72,67},42), 4483362458)
local SkillTab = Window:CreateTab(_d({41,65,63,66,66,246,41,59,74,74,63,68,61,73},42), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({30,69,72,69,3,30,69,72,69},42)) or (bp and bp:FindFirstChild(_d({30,69,72,69,3,30,69,72,69},42)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({36,38,25,73},42))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum = boss:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
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
if key == _d({30,63,74},42) then
return target.CFrame
elseif key == _d({42,55,72,61,59,74},42) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({49,30,69,72,69,246,76,8,51,246,35,59,74,55,74,55,56,66,59,246,62,69,69,65,246,60,55,63,66,59,58,16,246},42) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({49,30,69,72,69,246,76,8,51,246,25,66,59,55,68,59,58,246,75,70,246,70,72,59,76,63,69,75,73,246,73,59,73,73,63,69,68,4},42))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({41,74,55,74,75,73,16,246,45,55,63,74,63,68,61,246,60,69,72,246,24,69,73,73,246,41,70,55,77,68},42)) end
print(_d({49,30,69,72,69,246,76,8,51,246,24,69,73,73},42), _G.HoroSelectedBoss, _d({63,73,246,68,69,74,246,73,70,55,77,68,59,58,4,246,45,55,63,74,63,68,61,4,4,4},42))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({41,74,55,74,75,73,16,246,40,75,68,68,63,68,61,246,25,69,67,56,69},42)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({49,30,69,72,69,246,76,8,51,246,28,63,72,59,58,246,25,246,254,33,55,67,63,65,55,80,59,255},42))
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
print(_d({49,30,69,72,69,246,76,8,51,246,28,63,72,59,58,246,48,246,254,35,63,68,63,246,24,55,72,72,55,61,59,255},42))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({49,30,69,72,69,246,76,8,51,246,28,63,72,59,58,246,27,246,254,41,74,75,68,255},42))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({49,30,69,72,69,246,76,8,51,246,28,63,72,59,58,246,40,246,254,26,59,74,69,68,55,74,63,69,68,255},42))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({41,74,55,74,75,73,16,246,41,66,59,59,70,63,68,61,246,254},42) .. string.format(_d({251,4,7,60},42), finalSleep) .. _d({73,255},42)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({41,74,55,74,75,73,16,246,31,58,66,59},42))
MainTab:CreateDropdown({
Name = _d({41,59,66,59,57,74,246,24,69,73,73},42),
Options = {_d({23,78,59,246,30,55,68,58,246,34,69,61,55,68},42), _d({24,55,68,58,63,74,246,24,69,73,73},42), _d({32,75,80,69,246,74,62,59,246,26,63,55,67,69,68,58,56,55,57,65},42)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({49,30,69,72,69,246,76,8,51,246,41,59,66,59,57,74,59,58,246,74,55,72,61,59,74,16},42), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({41,74,55,72,74,246,23,75,74,69,246,28,55,72,67},42),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({41,59,66,59,57,74,246,24,69,73,73,246,40,59,71,75,63,72,59,58},42),
Content = _d({47,69,75,246,67,75,73,74,246,73,59,66,59,57,74,246,55,246,56,69,73,73,246,60,63,72,73,74,246,56,59,60,69,72,59,246,59,68,55,56,66,63,68,61,246,23,75,74,69,246,28,55,72,67,247},42),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({41,74,55,74,75,73,16,246,31,58,66,59},42)) end
end
print(_d({49,30,69,72,69,246,76,8,51,246,23,75,74,69,246,28,55,72,67,16},42), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({26,59,73,74,72,69,79,246,43,31},42),
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