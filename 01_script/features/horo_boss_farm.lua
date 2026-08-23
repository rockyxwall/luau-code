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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,23,38,62,43,46,42,49,41,244,50,38,46,51,244,56,52,58,55,40,42,243,49,58,38},59)
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
error(_d({32,13,52,55,52,229,59,247,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,23,38,62,43,46,42,49,41,229,26,14,229,17,46,39,55,38,55,62,243},59))
end
local Window = Rayfield:CreateWindow({
Name = _d({13,52,55,52,229,13,52,55,52,229,31,242,11,38,55,50,229,59,247},59),
LoadingTitle = _d({17,52,38,41,46,51,44,229,13,52,55,52,229,59,247,243,243,243},59),
LoadingSubtitle = _d({24,46,49,42,51,57,229,6,46,50,229,20,53,57,46,50,46,63,42,41},59),
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
local MainTab = Window:CreateTab(_d({6,58,57,52,229,11,38,55,50},59), 4483362458)
local SkillTab = Window:CreateTab(_d({24,48,46,49,49,229,24,42,57,57,46,51,44,56},59), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)) or (bp and bp:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum = boss:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
if key == _d({13,46,57},59) then
return target.CFrame
elseif key == _d({25,38,55,44,42,57},59) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({32,13,52,55,52,229,59,247,34,229,18,42,57,38,57,38,39,49,42,229,45,52,52,48,229,43,38,46,49,42,41,255,229},59) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({32,13,52,55,52,229,59,247,34,229,8,49,42,38,51,42,41,229,58,53,229,53,55,42,59,46,52,58,56,229,56,42,56,56,46,52,51,243},59))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({24,57,38,57,58,56,255,229,28,38,46,57,46,51,44,229,43,52,55,229,7,52,56,56,229,24,53,38,60,51},59)) end
print(_d({32,13,52,55,52,229,59,247,34,229,7,52,56,56},59), _G.HoroSelectedBoss, _d({46,56,229,51,52,57,229,56,53,38,60,51,42,41,243,229,28,38,46,57,46,51,44,243,243,243},59))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({24,57,38,57,58,56,255,229,23,58,51,51,46,51,44,229,8,52,50,39,52},59)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({32,13,52,55,52,229,59,247,34,229,11,46,55,42,41,229,8,229,237,16,38,50,46,48,38,63,42,238},59))
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
print(_d({32,13,52,55,52,229,59,247,34,229,11,46,55,42,41,229,31,229,237,18,46,51,46,229,7,38,55,55,38,44,42,238},59))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({32,13,52,55,52,229,59,247,34,229,11,46,55,42,41,229,10,229,237,24,57,58,51,238},59))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({32,13,52,55,52,229,59,247,34,229,11,46,55,42,41,229,23,229,237,9,42,57,52,51,38,57,46,52,51,238},59))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({24,57,38,57,58,56,255,229,24,49,42,42,53,46,51,44,229,237},59) .. string.format(_d({234,243,246,43},59), finalSleep) .. _d({56,238},59)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({24,57,38,57,58,56,255,229,14,41,49,42},59))
MainTab:CreateDropdown({
Name = _d({24,42,49,42,40,57,229,7,52,56,56},59),
Options = {_d({6,61,42,229,13,38,51,41,229,17,52,44,38,51},59), _d({7,38,51,41,46,57,229,7,52,56,56},59), _d({15,58,63,52,229,57,45,42,229,9,46,38,50,52,51,41,39,38,40,48},59)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({32,13,52,55,52,229,59,247,34,229,24,42,49,42,40,57,42,41,229,57,38,55,44,42,57,255},59), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({24,57,38,55,57,229,6,58,57,52,229,11,38,55,50},59),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({24,42,49,42,40,57,229,7,52,56,56,229,23,42,54,58,46,55,42,41},59),
Content = _d({30,52,58,229,50,58,56,57,229,56,42,49,42,40,57,229,38,229,39,52,56,56,229,43,46,55,56,57,229,39,42,43,52,55,42,229,42,51,38,39,49,46,51,44,229,6,58,57,52,229,11,38,55,50,230},59),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({24,57,38,57,58,56,255,229,14,41,49,42},59)) end
end
print(_d({32,13,52,55,52,229,59,247,34,229,6,58,57,52,229,11,38,55,50,255},59), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({9,42,56,57,55,52,62,229,26,14},59),
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