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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,47,62,86,67,70,66,73,65,12,74,62,70,75,12,80,76,82,79,64,66,11,73,82,62},35)
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
error(_d({56,37,76,79,76,253,83,15,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,47,62,86,67,70,66,73,65,253,50,38,253,41,70,63,79,62,79,86,11},35))
end
local Window = Rayfield:CreateWindow({
Name = _d({37,76,79,76,253,37,76,79,76,253,55,10,35,62,79,74,253,83,15},35),
LoadingTitle = _d({41,76,62,65,70,75,68,253,37,76,79,76,253,83,15,11,11,11},35),
LoadingSubtitle = _d({48,70,73,66,75,81,253,30,70,74,253,44,77,81,70,74,70,87,66,65},35),
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
local MainTab = Window:CreateTab(_d({30,82,81,76,253,35,62,79,74},35), 4483362458)
local SkillTab = Window:CreateTab(_d({48,72,70,73,73,253,48,66,81,81,70,75,68,80},35), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)) or (bp and bp:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = boss:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
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
if key == _d({37,70,81},35) then
return target.CFrame
elseif key == _d({49,62,79,68,66,81},35) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({56,37,76,79,76,253,83,15,58,253,42,66,81,62,81,62,63,73,66,253,69,76,76,72,253,67,62,70,73,66,65,23,253},35) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({56,37,76,79,76,253,83,15,58,253,32,73,66,62,75,66,65,253,82,77,253,77,79,66,83,70,76,82,80,253,80,66,80,80,70,76,75,11},35))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({48,81,62,81,82,80,23,253,52,62,70,81,70,75,68,253,67,76,79,253,31,76,80,80,253,48,77,62,84,75},35)) end
print(_d({56,37,76,79,76,253,83,15,58,253,31,76,80,80},35), _G.HoroSelectedBoss, _d({70,80,253,75,76,81,253,80,77,62,84,75,66,65,11,253,52,62,70,81,70,75,68,11,11,11},35))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({48,81,62,81,82,80,23,253,47,82,75,75,70,75,68,253,32,76,74,63,76},35)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({56,37,76,79,76,253,83,15,58,253,35,70,79,66,65,253,32,253,5,40,62,74,70,72,62,87,66,6},35))
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
print(_d({56,37,76,79,76,253,83,15,58,253,35,70,79,66,65,253,55,253,5,42,70,75,70,253,31,62,79,79,62,68,66,6},35))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({56,37,76,79,76,253,83,15,58,253,35,70,79,66,65,253,34,253,5,48,81,82,75,6},35))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({56,37,76,79,76,253,83,15,58,253,35,70,79,66,65,253,47,253,5,33,66,81,76,75,62,81,70,76,75,6},35))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({48,81,62,81,82,80,23,253,48,73,66,66,77,70,75,68,253,5},35) .. string.format(_d({2,11,14,67},35), finalSleep) .. _d({80,6},35)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({48,81,62,81,82,80,23,253,38,65,73,66},35))
MainTab:CreateDropdown({
Name = _d({48,66,73,66,64,81,253,31,76,80,80},35),
Options = {_d({30,85,66,253,37,62,75,65,253,41,76,68,62,75},35), _d({31,62,75,65,70,81,253,31,76,80,80},35), _d({39,82,87,76,253,81,69,66,253,33,70,62,74,76,75,65,63,62,64,72},35)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({56,37,76,79,76,253,83,15,58,253,48,66,73,66,64,81,66,65,253,81,62,79,68,66,81,23},35), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({48,81,62,79,81,253,30,82,81,76,253,35,62,79,74},35),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({48,66,73,66,64,81,253,31,76,80,80,253,47,66,78,82,70,79,66,65},35),
Content = _d({54,76,82,253,74,82,80,81,253,80,66,73,66,64,81,253,62,253,63,76,80,80,253,67,70,79,80,81,253,63,66,67,76,79,66,253,66,75,62,63,73,70,75,68,253,30,82,81,76,253,35,62,79,74,254},35),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({48,81,62,81,82,80,23,253,38,65,73,66},35)) end
end
print(_d({56,37,76,79,76,253,83,15,58,253,30,82,81,76,253,35,62,79,74,23},35), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({33,66,80,81,79,76,86,253,50,38},35),
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