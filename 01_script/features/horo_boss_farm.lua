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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69,14,76,85,65},32)
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
error(_d({59,40,79,82,79,0,86,18,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,50,65,89,70,73,69,76,68,0,53,41,0,44,73,66,82,65,82,89,14},32))
end
local Window = Rayfield:CreateWindow({
Name = _d({40,79,82,79,0,40,79,82,79,0,58,13,38,65,82,77,0,86,18},32),
LoadingTitle = _d({44,79,65,68,73,78,71,0,40,79,82,79,0,86,18,14,14,14},32),
LoadingSubtitle = _d({51,73,76,69,78,84,0,33,73,77,0,47,80,84,73,77,73,90,69,68},32),
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
local MainTab = Window:CreateTab(_d({33,85,84,79,0,38,65,82,77},32), 4483362458)
local SkillTab = Window:CreateTab(_d({51,75,73,76,76,0,51,69,84,84,73,78,71,83},32), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)) or (bp and bp:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = boss:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
if key == _d({40,73,84},32) then
return target.CFrame
elseif key == _d({52,65,82,71,69,84},32) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({59,40,79,82,79,0,86,18,61,0,45,69,84,65,84,65,66,76,69,0,72,79,79,75,0,70,65,73,76,69,68,26,0},32) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({59,40,79,82,79,0,86,18,61,0,35,76,69,65,78,69,68,0,85,80,0,80,82,69,86,73,79,85,83,0,83,69,83,83,73,79,78,14},32))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,55,65,73,84,73,78,71,0,70,79,82,0,34,79,83,83,0,51,80,65,87,78},32)) end
print(_d({59,40,79,82,79,0,86,18,61,0,34,79,83,83},32), _G.HoroSelectedBoss, _d({73,83,0,78,79,84,0,83,80,65,87,78,69,68,14,0,55,65,73,84,73,78,71,14,14,14},32))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,50,85,78,78,73,78,71,0,35,79,77,66,79},32)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,35,0,8,43,65,77,73,75,65,90,69,9},32))
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
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,58,0,8,45,73,78,73,0,34,65,82,82,65,71,69,9},32))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,37,0,8,51,84,85,78,9},32))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,50,0,8,36,69,84,79,78,65,84,73,79,78,9},32))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,51,76,69,69,80,73,78,71,0,8},32) .. string.format(_d({5,14,17,70},32), finalSleep) .. _d({83,9},32)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({51,84,65,84,85,83,26,0,41,68,76,69},32))
MainTab:CreateDropdown({
Name = _d({51,69,76,69,67,84,0,34,79,83,83},32),
Options = {_d({33,88,69,0,40,65,78,68,0,44,79,71,65,78},32), _d({34,65,78,68,73,84,0,34,79,83,83},32), _d({42,85,90,79,0,84,72,69,0,36,73,65,77,79,78,68,66,65,67,75},32)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({59,40,79,82,79,0,86,18,61,0,51,69,76,69,67,84,69,68,0,84,65,82,71,69,84,26},32), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({51,84,65,82,84,0,33,85,84,79,0,38,65,82,77},32),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({51,69,76,69,67,84,0,34,79,83,83,0,50,69,81,85,73,82,69,68},32),
Content = _d({57,79,85,0,77,85,83,84,0,83,69,76,69,67,84,0,65,0,66,79,83,83,0,70,73,82,83,84,0,66,69,70,79,82,69,0,69,78,65,66,76,73,78,71,0,33,85,84,79,0,38,65,82,77,1},32),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,41,68,76,69},32)) end
end
print(_d({59,40,79,82,79,0,86,18,61,0,33,85,84,79,0,38,65,82,77,26},32), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({36,69,83,84,82,79,89,0,53,41},32),
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