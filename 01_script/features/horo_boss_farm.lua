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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local RunService = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local VIM = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,42,57,81,62,65,61,68,60,7,69,57,65,70,7,75,71,77,74,59,61,6,68,77,57},40)
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
error(_d({51,32,71,74,71,248,78,10,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,248,42,57,81,62,65,61,68,60,248,45,33,248,36,65,58,74,57,74,81,6},40))
end
local Window = Rayfield:CreateWindow({
Name = _d({32,71,74,71,248,32,71,74,71,248,50,5,30,57,74,69,248,78,10},40),
LoadingTitle = _d({36,71,57,60,65,70,63,248,32,71,74,71,248,78,10,6,6,6},40),
LoadingSubtitle = _d({43,65,68,61,70,76,248,25,65,69,248,39,72,76,65,69,65,82,61,60},40),
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
local MainTab = Window:CreateTab(_d({25,77,76,71,248,30,57,74,69},40), 4483362458)
local SkillTab = Window:CreateTab(_d({43,67,65,68,68,248,43,61,76,76,65,70,63,75},40), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({32,71,74,71,5,32,71,74,71},40)) or (bp and bp:FindFirstChild(_d({32,71,74,71,5,32,71,74,71},40)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({38,40,27,75},40))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local hum = boss:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
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
if key == _d({32,65,76},40) then
return target.CFrame
elseif key == _d({44,57,74,63,61,76},40) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({51,32,71,74,71,248,78,10,53,248,37,61,76,57,76,57,58,68,61,248,64,71,71,67,248,62,57,65,68,61,60,18,248},40) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({51,32,71,74,71,248,78,10,53,248,27,68,61,57,70,61,60,248,77,72,248,72,74,61,78,65,71,77,75,248,75,61,75,75,65,71,70,6},40))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,47,57,65,76,65,70,63,248,62,71,74,248,26,71,75,75,248,43,72,57,79,70},40)) end
print(_d({51,32,71,74,71,248,78,10,53,248,26,71,75,75},40), _G.HoroSelectedBoss, _d({65,75,248,70,71,76,248,75,72,57,79,70,61,60,6,248,47,57,65,76,65,70,63,6,6,6},40))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,42,77,70,70,65,70,63,248,27,71,69,58,71},40)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({51,32,71,74,71,248,78,10,53,248,30,65,74,61,60,248,27,248,0,35,57,69,65,67,57,82,61,1},40))
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
print(_d({51,32,71,74,71,248,78,10,53,248,30,65,74,61,60,248,50,248,0,37,65,70,65,248,26,57,74,74,57,63,61,1},40))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({51,32,71,74,71,248,78,10,53,248,30,65,74,61,60,248,29,248,0,43,76,77,70,1},40))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({51,32,71,74,71,248,78,10,53,248,30,65,74,61,60,248,42,248,0,28,61,76,71,70,57,76,65,71,70,1},40))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,43,68,61,61,72,65,70,63,248,0},40) .. string.format(_d({253,6,9,62},40), finalSleep) .. _d({75,1},40)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({43,76,57,76,77,75,18,248,33,60,68,61},40))
MainTab:CreateDropdown({
Name = _d({43,61,68,61,59,76,248,26,71,75,75},40),
Options = {_d({25,80,61,248,32,57,70,60,248,36,71,63,57,70},40), _d({26,57,70,60,65,76,248,26,71,75,75},40), _d({34,77,82,71,248,76,64,61,248,28,65,57,69,71,70,60,58,57,59,67},40)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({51,32,71,74,71,248,78,10,53,248,43,61,68,61,59,76,61,60,248,76,57,74,63,61,76,18},40), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({43,76,57,74,76,248,25,77,76,71,248,30,57,74,69},40),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({43,61,68,61,59,76,248,26,71,75,75,248,42,61,73,77,65,74,61,60},40),
Content = _d({49,71,77,248,69,77,75,76,248,75,61,68,61,59,76,248,57,248,58,71,75,75,248,62,65,74,75,76,248,58,61,62,71,74,61,248,61,70,57,58,68,65,70,63,248,25,77,76,71,248,30,57,74,69,249},40),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,33,60,68,61},40)) end
end
print(_d({51,32,71,74,71,248,78,10,53,248,25,77,76,71,248,30,57,74,69,18},40), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({28,61,75,76,74,71,81,248,45,33},40),
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