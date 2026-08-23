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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local VIM = game:GetService(_d({53,72,81,83,84,64,75,40,77,79,84,83,44,64,77,64,70,68,81},33))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68,13,75,84,64},33)
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
error(_d({58,39,78,81,78,255,85,17,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,49,64,88,69,72,68,75,67,255,52,40,255,43,72,65,81,64,81,88,13},33))
end
local Window = Rayfield:CreateWindow({
Name = _d({39,78,81,78,255,39,78,81,78,255,57,12,37,64,81,76,255,85,17},33),
LoadingTitle = _d({43,78,64,67,72,77,70,255,39,78,81,78,255,85,17,13,13,13},33),
LoadingSubtitle = _d({50,72,75,68,77,83,255,32,72,76,255,46,79,83,72,76,72,89,68,67},33),
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
local MainTab = Window:CreateTab(_d({32,84,83,78,255,37,64,81,76},33), 4483362458)
local SkillTab = Window:CreateTab(_d({50,74,72,75,75,255,50,68,83,83,72,77,70,82},33), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({39,78,81,78,12,39,78,81,78},33)) or (bp and bp:FindFirstChild(_d({39,78,81,78,12,39,78,81,78},33)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({45,47,34,82},33))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local hum = boss:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
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
if key == _d({39,72,83},33) then
return target.CFrame
elseif key == _d({51,64,81,70,68,83},33) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({58,39,78,81,78,255,85,17,60,255,44,68,83,64,83,64,65,75,68,255,71,78,78,74,255,69,64,72,75,68,67,25,255},33) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({58,39,78,81,78,255,85,17,60,255,34,75,68,64,77,68,67,255,84,79,255,79,81,68,85,72,78,84,82,255,82,68,82,82,72,78,77,13},33))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({50,83,64,83,84,82,25,255,54,64,72,83,72,77,70,255,69,78,81,255,33,78,82,82,255,50,79,64,86,77},33)) end
print(_d({58,39,78,81,78,255,85,17,60,255,33,78,82,82},33), _G.HoroSelectedBoss, _d({72,82,255,77,78,83,255,82,79,64,86,77,68,67,13,255,54,64,72,83,72,77,70,13,13,13},33))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({50,83,64,83,84,82,25,255,49,84,77,77,72,77,70,255,34,78,76,65,78},33)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({58,39,78,81,78,255,85,17,60,255,37,72,81,68,67,255,34,255,7,42,64,76,72,74,64,89,68,8},33))
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
print(_d({58,39,78,81,78,255,85,17,60,255,37,72,81,68,67,255,57,255,7,44,72,77,72,255,33,64,81,81,64,70,68,8},33))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({58,39,78,81,78,255,85,17,60,255,37,72,81,68,67,255,36,255,7,50,83,84,77,8},33))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({58,39,78,81,78,255,85,17,60,255,37,72,81,68,67,255,49,255,7,35,68,83,78,77,64,83,72,78,77,8},33))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({50,83,64,83,84,82,25,255,50,75,68,68,79,72,77,70,255,7},33) .. string.format(_d({4,13,16,69},33), finalSleep) .. _d({82,8},33)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({50,83,64,83,84,82,25,255,40,67,75,68},33))
MainTab:CreateDropdown({
Name = _d({50,68,75,68,66,83,255,33,78,82,82},33),
Options = {_d({32,87,68,255,39,64,77,67,255,43,78,70,64,77},33), _d({33,64,77,67,72,83,255,33,78,82,82},33), _d({41,84,89,78,255,83,71,68,255,35,72,64,76,78,77,67,65,64,66,74},33)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({58,39,78,81,78,255,85,17,60,255,50,68,75,68,66,83,68,67,255,83,64,81,70,68,83,25},33), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({50,83,64,81,83,255,32,84,83,78,255,37,64,81,76},33),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({50,68,75,68,66,83,255,33,78,82,82,255,49,68,80,84,72,81,68,67},33),
Content = _d({56,78,84,255,76,84,82,83,255,82,68,75,68,66,83,255,64,255,65,78,82,82,255,69,72,81,82,83,255,65,68,69,78,81,68,255,68,77,64,65,75,72,77,70,255,32,84,83,78,255,37,64,81,76,0},33),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({50,83,64,83,84,82,25,255,40,67,75,68},33)) end
end
print(_d({58,39,78,81,78,255,85,17,60,255,32,84,83,78,255,37,64,81,76,25},33), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({35,68,82,83,81,78,88,255,52,40},33),
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