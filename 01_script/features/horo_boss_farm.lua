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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67,12,74,83,63},34)
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
error(_d({57,38,77,80,77,254,84,16,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,48,63,87,68,71,67,74,66,254,51,39,254,42,71,64,80,63,80,87,12},34))
end
local Window = Rayfield:CreateWindow({
Name = _d({38,77,80,77,254,38,77,80,77,254,56,11,36,63,80,75,254,84,16},34),
LoadingTitle = _d({42,77,63,66,71,76,69,254,38,77,80,77,254,84,16,12,12,12},34),
LoadingSubtitle = _d({49,71,74,67,76,82,254,31,71,75,254,45,78,82,71,75,71,88,67,66},34),
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
local MainTab = Window:CreateTab(_d({31,83,82,77,254,36,63,80,75},34), 4483362458)
local SkillTab = Window:CreateTab(_d({49,73,71,74,74,254,49,67,82,82,71,76,69,81},34), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)) or (bp and bp:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({44,46,33,81},34))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hum = boss:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
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
if key == _d({38,71,82},34) then
return target.CFrame
elseif key == _d({50,63,80,69,67,82},34) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({57,38,77,80,77,254,84,16,59,254,43,67,82,63,82,63,64,74,67,254,70,77,77,73,254,68,63,71,74,67,66,24,254},34) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({57,38,77,80,77,254,84,16,59,254,33,74,67,63,76,67,66,254,83,78,254,78,80,67,84,71,77,83,81,254,81,67,81,81,71,77,76,12},34))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({49,82,63,82,83,81,24,254,53,63,71,82,71,76,69,254,68,77,80,254,32,77,81,81,254,49,78,63,85,76},34)) end
print(_d({57,38,77,80,77,254,84,16,59,254,32,77,81,81},34), _G.HoroSelectedBoss, _d({71,81,254,76,77,82,254,81,78,63,85,76,67,66,12,254,53,63,71,82,71,76,69,12,12,12},34))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({49,82,63,82,83,81,24,254,48,83,76,76,71,76,69,254,33,77,75,64,77},34)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({57,38,77,80,77,254,84,16,59,254,36,71,80,67,66,254,33,254,6,41,63,75,71,73,63,88,67,7},34))
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
print(_d({57,38,77,80,77,254,84,16,59,254,36,71,80,67,66,254,56,254,6,43,71,76,71,254,32,63,80,80,63,69,67,7},34))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({57,38,77,80,77,254,84,16,59,254,36,71,80,67,66,254,35,254,6,49,82,83,76,7},34))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({57,38,77,80,77,254,84,16,59,254,36,71,80,67,66,254,48,254,6,34,67,82,77,76,63,82,71,77,76,7},34))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({49,82,63,82,83,81,24,254,49,74,67,67,78,71,76,69,254,6},34) .. string.format(_d({3,12,15,68},34), finalSleep) .. _d({81,7},34)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({49,82,63,82,83,81,24,254,39,66,74,67},34))
MainTab:CreateDropdown({
Name = _d({49,67,74,67,65,82,254,32,77,81,81},34),
Options = {_d({31,86,67,254,38,63,76,66,254,42,77,69,63,76},34), _d({32,63,76,66,71,82,254,32,77,81,81},34), _d({40,83,88,77,254,82,70,67,254,34,71,63,75,77,76,66,64,63,65,73},34)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({57,38,77,80,77,254,84,16,59,254,49,67,74,67,65,82,67,66,254,82,63,80,69,67,82,24},34), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({49,82,63,80,82,254,31,83,82,77,254,36,63,80,75},34),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({49,67,74,67,65,82,254,32,77,81,81,254,48,67,79,83,71,80,67,66},34),
Content = _d({55,77,83,254,75,83,81,82,254,81,67,74,67,65,82,254,63,254,64,77,81,81,254,68,71,80,81,82,254,64,67,68,77,80,67,254,67,76,63,64,74,71,76,69,254,31,83,82,77,254,36,63,80,75,255},34),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({49,82,63,82,83,81,24,254,39,66,74,67},34)) end
end
print(_d({57,38,77,80,77,254,84,16,59,254,31,83,82,77,254,36,63,80,75,24},34), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({34,67,81,82,80,77,87,254,51,39},34),
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