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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,60,82,91,82,94,92,60,88,79,93,96,74,91,78,53,93,77,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78,23,85,94,74},23),
_d({81,93,93,89,92,35,24,24,92,82,91,82,94,92,23,86,78,87,94,24,91,74,98,79,82,78,85,77},23),
_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,92,81,85,78,97,96,74,91,78,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78},23)
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
error(_d({68,44,88,86,89,74,76,93,9,49,94,75,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,59,74,98,79,82,78,85,77,9,62,50,9,53,82,75,91,74,91,98,23},23))
end
local Window = Rayfield:CreateWindow({
Name = _d({49,88,91,88,9,49,88,91,88,9,67,22,47,74,91,86},23),
LoadingTitle = _d({53,88,74,77,82,87,80,9,49,88,91,88,9,67,9,53,88,88,89,23,23,23},23),
LoadingSubtitle = _d({56,89,93,82,86,82,99,78,77},23),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({42,97,78,9,49,74,87,77,9,53,88,80,74,87},23)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({42,94,93,88,9,47,74,91,86},23), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({43,74,76,84,89,74,76,84},23))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({49,88,91,88,22,49,88,91,88},23)) or (bp and bp:FindFirstChild(_d({49,88,91,88,22,49,88,91,88},23)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({55,57,44,92},23))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hum = boss:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
_G.HoroFarmCleanup = function()
autoZLoop = false
pcall(function() Rayfield:Destroy() end)
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,44,85,78,74,87,78,77,9,94,89,9,89,91,78,95,82,88,94,92,9,92,78,92,92,82,88,87,23},23))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,43,88,92,92},23), selectedBoss, _d({82,92,9,87,88,93,9,92,89,74,96,87,78,77,23,9,64,74,82,93,82,87,80},23), checkSpawnInterval, _d({92,78,76,88,87,77,92,23,23,23},23))
task.wait(checkSpawnInterval)
else
local tool = equipHoroTool()
if tool then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(1.0)
local myRoot = getRoot()
if myRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
local lookCF = CFrame.lookAt(myRoot.Position, targetRoot.Position)
local remoteName = LocalPlayer.Name .. _d({101,60,78,91,95,78,91,60,76,91,82,89,93,60,78,91,95,82,76,78,23,60,84,82,85,85,92,23,60,84,82,85,85,92,23,60,84,82,85,85,44,88,87,93,74,82,87,78,91,23,49,88,91,88,22,49,88,91,88,23,54,82,87,82,9,49,88,85,85,88,96,9,43,74,91,91,74,80,78},23)
local remote = ReplicatedStorage:FindFirstChild(remoteName)
if remote and remote:IsA(_d({59,78,86,88,93,78,46,95,78,87,93},23)) then
remote:FireServer({
Target = targetRoot,
cf = lookCF
})
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,47,82,91,78,77,9,67,9,93,74,91,80,78,93,82,87,80,9,91,78,86,88,93,78,9,74,93},23), selectedBoss)
else
warn(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,44,88,94,85,77,9,87,88,93,9,79,82,87,77,9,91,78,86,88,93,78,9,78,95,78,87,93,35},23), remoteName)
end
else
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,61,74,91,80,78,93,9,85,88,92,93,9,88,91,9,77,82,78,77,9,77,94,91,82,87,80,9,26,92,9,77,78,85,74,98,23},23))
end
else
warn(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,16,49,88,91,88,22,49,88,91,88,16,9,93,88,88,85,9,87,88,93,9,79,88,94,87,77,9,82,87,9,75,74,76,84,89,74,76,84,9,88,91,9,76,81,74,91,74,76,93,78,91,10},23))
end
task.wait(loopDelay)
end
end
end
end)
MainTab:CreateDropdown({
Name = _d({60,78,85,78,76,93,9,43,88,92,92},23),
Options = {_d({42,97,78,9,49,74,87,77,9,53,88,80,74,87},23)},
CurrentOption = _d({42,97,78,9,49,74,87,77,9,53,88,80,74,87},23),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,60,78,85,78,76,93,78,77,9,93,74,91,80,78,93,35},23), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({42,94,93,88,9,67,9,53,88,88,89},23),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,42,94,93,88,9,67,9,53,88,88,89,35},23), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({53,88,88,89,9,45,78,85,74,98,9,17,60,78,76,88,87,77,92,18},23),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({45,78,92,93,91,88,98,9,62,50},23),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()