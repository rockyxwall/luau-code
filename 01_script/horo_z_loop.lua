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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,59,81,90,81,93,91,59,87,78,92,95,73,90,77,52,92,76,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24),
_d({80,92,92,88,91,34,23,23,91,81,90,81,93,91,22,85,77,86,93,23,90,73,97,78,81,77,84,76},24),
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,91,80,84,77,96,95,73,90,77,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77},24)
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
error(_d({67,43,87,85,88,73,75,92,8,48,93,74,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({48,87,90,87,8,48,87,90,87,8,66,21,46,73,90,85},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,48,87,90,87,8,66,8,52,87,87,88,22,22,22},24),
LoadingSubtitle = _d({55,88,92,81,85,81,98,77,76},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({41,96,77,8,48,73,86,76,8,52,87,79,73,86},24)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({41,93,92,87,8,46,73,90,85},24), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({48,87,90,87,21,48,87,90,87},24)) or (bp and bp:FindFirstChild(_d({48,87,90,87,21,48,87,90,87},24)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({54,56,43,91},24))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = boss:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function disableQueryOnObstacles(bossPart)
local char = LocalPlayer.Character
if not char then return {} end
local disabledParts = {}
local ignoreList = {char, bossPart.Parent}
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = ignoreList
for i = 1, 15 do
local origin = Camera.CFrame.Position
local direction = bossPart.Position - origin
local result = Workspace:Raycast(origin, direction, params)
if result and result.Instance then
local part = result.Instance
local success, _ = pcall(function()
if part.CanQuery == true then
part.CanQuery = false
table.insert(disabledParts, part)
end
end)
if not success then break end
table.insert(ignoreList, part)
params.FilterDescendantsInstances = ignoreList
else
break
end
end
return disabledParts
end
local function restoreObstacles(partsList)
for _, part in ipairs(partsList) do
pcall(function()
part.CanQuery = true
end)
end
end
_G.HoroFarmCleanup = function()
autoZLoop = false
pcall(function() Rayfield:Destroy() end)
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,42,87,91,91},24), selectedBoss, _d({81,91,8,86,87,92,8,91,88,73,95,86,77,76,22,8,63,73,81,92,81,86,79},24), checkSpawnInterval, _d({91,77,75,87,86,76,91,22,22,22},24))
task.wait(checkSpawnInterval)
else
local tool = equipHoroTool()
if tool then
if getBossPart(selectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(1.0)
local currentTarget = getBossPart(selectedBoss)
if currentTarget then
local bypassed = disableQueryOnObstacles(currentTarget)
task.wait(0.05)
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.05)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,46,81,90,77,76,8,66,8,92,80,90,87,93,79,80,8,87,74,91,92,73,75,84,77,91,8,73,92},24), selectedBoss)
else
warn(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,42,87,91,91,8,81,91,8,86,87,92,8,95,81,92,80,81,86,8,92,80,77,8,75,73,85,77,90,73,8,94,81,77,95,88,87,90,92,20,8,75,73,86,86,87,92,8,92,73,90,79,77,92,22},24))
end
restoreObstacles(bypassed)
else
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,60,73,90,79,77,92,8,84,87,91,92,8,87,90,8,76,81,77,76,8,76,93,90,81,86,79,8,25,91,8,76,77,84,73,97,22},24))
end
end
else
warn(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,15,48,87,90,87,21,48,87,90,87,15,8,92,87,87,84,8,86,87,92,8,78,87,93,86,76,8,81,86,8,74,73,75,83,88,73,75,83,8,87,90,8,75,80,73,90,73,75,92,77,90,9},24))
end
task.wait(loopDelay)
end
end
end
end)
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,42,87,91,91},24),
Options = {_d({41,96,77,8,48,73,86,76,8,52,87,79,73,86},24)},
CurrentOption = _d({41,96,77,8,48,73,86,76,8,52,87,79,73,86},24),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,59,77,84,77,75,92,77,76,8,92,73,90,79,77,92,34},24), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({41,93,92,87,8,66,8,52,87,87,88},24),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,41,93,92,87,8,66,8,52,87,87,88,34},24), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({52,87,87,88,8,44,77,84,73,97,8,16,59,77,75,87,86,76,91,17},24),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49},24),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()