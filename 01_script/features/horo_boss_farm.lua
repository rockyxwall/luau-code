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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local VIM = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,43,58,82,63,66,62,69,61,8,70,58,66,71,8,76,72,78,75,60,62,7,69,78,58},39)
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
error(_d({52,33,72,75,72,249,79,11,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,43,58,82,63,66,62,69,61,249,46,34,249,37,66,59,75,58,75,82,7},39))
end
local Window = Rayfield:CreateWindow({
Name = _d({33,72,75,72,249,33,72,75,72,249,51,6,31,58,75,70,249,79,11},39),
LoadingTitle = _d({37,72,58,61,66,71,64,249,33,72,75,72,249,79,11,7,7,7},39),
LoadingSubtitle = _d({44,66,69,62,71,77,249,26,66,70,249,40,73,77,66,70,66,83,62,61},39),
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
local MainTab = Window:CreateTab(_d({26,78,77,72,249,31,58,75,70},39), 4483362458)
local SkillTab = Window:CreateTab(_d({44,68,66,69,69,249,44,62,77,77,66,71,64,76},39), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({33,72,75,72,6,33,72,75,72},39)) or (bp and bp:FindFirstChild(_d({33,72,75,72,6,33,72,75,72},39)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({39,41,28,76},39))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local hum = boss:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
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
if key == _d({33,66,77},39) then
return target.CFrame
elseif key == _d({45,58,75,64,62,77},39) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({52,33,72,75,72,249,79,11,54,249,38,62,77,58,77,58,59,69,62,249,65,72,72,68,249,63,58,66,69,62,61,19,249},39) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({52,33,72,75,72,249,79,11,54,249,28,69,62,58,71,62,61,249,78,73,249,73,75,62,79,66,72,78,76,249,76,62,76,76,66,72,71,7},39))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({44,77,58,77,78,76,19,249,48,58,66,77,66,71,64,249,63,72,75,249,27,72,76,76,249,44,73,58,80,71},39)) end
print(_d({52,33,72,75,72,249,79,11,54,249,27,72,76,76},39), _G.HoroSelectedBoss, _d({66,76,249,71,72,77,249,76,73,58,80,71,62,61,7,249,48,58,66,77,66,71,64,7,7,7},39))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({44,77,58,77,78,76,19,249,43,78,71,71,66,71,64,249,28,72,70,59,72},39)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({52,33,72,75,72,249,79,11,54,249,31,66,75,62,61,249,28,249,1,36,58,70,66,68,58,83,62,2},39))
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
print(_d({52,33,72,75,72,249,79,11,54,249,31,66,75,62,61,249,51,249,1,38,66,71,66,249,27,58,75,75,58,64,62,2},39))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({52,33,72,75,72,249,79,11,54,249,31,66,75,62,61,249,30,249,1,44,77,78,71,2},39))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({52,33,72,75,72,249,79,11,54,249,31,66,75,62,61,249,43,249,1,29,62,77,72,71,58,77,66,72,71,2},39))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({44,77,58,77,78,76,19,249,44,69,62,62,73,66,71,64,249,1},39) .. string.format(_d({254,7,10,63},39), finalSleep) .. _d({76,2},39)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({44,77,58,77,78,76,19,249,34,61,69,62},39))
MainTab:CreateDropdown({
Name = _d({44,62,69,62,60,77,249,27,72,76,76},39),
Options = {_d({26,81,62,249,33,58,71,61,249,37,72,64,58,71},39), _d({27,58,71,61,66,77,249,27,72,76,76},39), _d({35,78,83,72,249,77,65,62,249,29,66,58,70,72,71,61,59,58,60,68},39)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({52,33,72,75,72,249,79,11,54,249,44,62,69,62,60,77,62,61,249,77,58,75,64,62,77,19},39), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({44,77,58,75,77,249,26,78,77,72,249,31,58,75,70},39),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({44,62,69,62,60,77,249,27,72,76,76,249,43,62,74,78,66,75,62,61},39),
Content = _d({50,72,78,249,70,78,76,77,249,76,62,69,62,60,77,249,58,249,59,72,76,76,249,63,66,75,76,77,249,59,62,63,72,75,62,249,62,71,58,59,69,66,71,64,249,26,78,77,72,249,31,58,75,70,250},39),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({44,77,58,77,78,76,19,249,34,61,69,62},39)) end
end
print(_d({52,33,72,75,72,249,79,11,54,249,26,78,77,72,249,31,58,75,70,19},39), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({29,62,76,77,75,72,82,249,46,34},39),
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