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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local VIM = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,31,46,70,51,54,50,57,49,252,58,46,54,59,252,64,60,66,63,48,50,251,57,66,46},51)
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
error(_d({40,21,60,63,60,237,67,255,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,31,46,70,51,54,50,57,49,237,34,22,237,25,54,47,63,46,63,70,251},51))
end
local Window = Rayfield:CreateWindow({
Name = _d({21,60,63,60,237,21,60,63,60,237,39,250,19,46,63,58,237,67,255},51),
LoadingTitle = _d({25,60,46,49,54,59,52,237,21,60,63,60,237,67,255,251,251,251},51),
LoadingSubtitle = _d({32,54,57,50,59,65,237,14,54,58,237,28,61,65,54,58,54,71,50,49},51),
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
local MainTab = Window:CreateTab(_d({14,66,65,60,237,19,46,63,58},51), 4483362458)
local SkillTab = Window:CreateTab(_d({32,56,54,57,57,237,32,50,65,65,54,59,52,64},51), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({21,60,63,60,250,21,60,63,60},51)) or (bp and bp:FindFirstChild(_d({21,60,63,60,250,21,60,63,60},51)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({27,29,16,64},51))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
local hum = boss:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
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
if key == _d({21,54,65},51) then
return target.CFrame
elseif key == _d({33,46,63,52,50,65},51) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({40,21,60,63,60,237,67,255,42,237,26,50,65,46,65,46,47,57,50,237,53,60,60,56,237,51,46,54,57,50,49,7,237},51) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({40,21,60,63,60,237,67,255,42,237,16,57,50,46,59,50,49,237,66,61,237,61,63,50,67,54,60,66,64,237,64,50,64,64,54,60,59,251},51))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({32,65,46,65,66,64,7,237,36,46,54,65,54,59,52,237,51,60,63,237,15,60,64,64,237,32,61,46,68,59},51)) end
print(_d({40,21,60,63,60,237,67,255,42,237,15,60,64,64},51), _G.HoroSelectedBoss, _d({54,64,237,59,60,65,237,64,61,46,68,59,50,49,251,237,36,46,54,65,54,59,52,251,251,251},51))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({32,65,46,65,66,64,7,237,31,66,59,59,54,59,52,237,16,60,58,47,60},51)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({40,21,60,63,60,237,67,255,42,237,19,54,63,50,49,237,16,237,245,24,46,58,54,56,46,71,50,246},51))
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
print(_d({40,21,60,63,60,237,67,255,42,237,19,54,63,50,49,237,39,237,245,26,54,59,54,237,15,46,63,63,46,52,50,246},51))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({40,21,60,63,60,237,67,255,42,237,19,54,63,50,49,237,18,237,245,32,65,66,59,246},51))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({40,21,60,63,60,237,67,255,42,237,19,54,63,50,49,237,31,237,245,17,50,65,60,59,46,65,54,60,59,246},51))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({32,65,46,65,66,64,7,237,32,57,50,50,61,54,59,52,237,245},51) .. string.format(_d({242,251,254,51},51), finalSleep) .. _d({64,246},51)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({32,65,46,65,66,64,7,237,22,49,57,50},51))
MainTab:CreateDropdown({
Name = _d({32,50,57,50,48,65,237,15,60,64,64},51),
Options = {_d({14,69,50,237,21,46,59,49,237,25,60,52,46,59},51), _d({15,46,59,49,54,65,237,15,60,64,64},51), _d({23,66,71,60,237,65,53,50,237,17,54,46,58,60,59,49,47,46,48,56},51)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({40,21,60,63,60,237,67,255,42,237,32,50,57,50,48,65,50,49,237,65,46,63,52,50,65,7},51), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({32,65,46,63,65,237,14,66,65,60,237,19,46,63,58},51),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({32,50,57,50,48,65,237,15,60,64,64,237,31,50,62,66,54,63,50,49},51),
Content = _d({38,60,66,237,58,66,64,65,237,64,50,57,50,48,65,237,46,237,47,60,64,64,237,51,54,63,64,65,237,47,50,51,60,63,50,237,50,59,46,47,57,54,59,52,237,14,66,65,60,237,19,46,63,58,238},51),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({32,65,46,65,66,64,7,237,22,49,57,50},51)) end
end
print(_d({40,21,60,63,60,237,67,255,42,237,14,66,65,60,237,19,46,63,58,7},51), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({17,50,64,65,63,60,70,237,34,22},51),
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