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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,55,77,86,77,89,87,55,83,74,88,91,69,86,73,48,88,72,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73,18,80,89,69},28),
_d({76,88,88,84,87,30,19,19,87,77,86,77,89,87,18,81,73,82,89,19,86,69,93,74,77,73,80,72},28),
_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,87,76,80,73,92,91,69,86,73,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73},28)
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
error(_d({63,39,83,81,84,69,71,88,4,44,89,70,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,54,69,93,74,77,73,80,72,4,57,45,4,48,77,70,86,69,86,93,18},28))
end
local Window = Rayfield:CreateWindow({
Name = _d({44,83,86,83,4,44,83,86,83,4,62,17,42,69,86,81},28),
LoadingTitle = _d({48,83,69,72,77,82,75,4,44,83,86,83,4,62,4,48,83,83,84,18,18,18},28),
LoadingSubtitle = _d({51,84,88,77,81,77,94,73,72},28),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({37,92,73,4,44,69,82,72,4,48,83,75,69,82},28)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({37,89,88,83,4,42,69,86,81},28), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)) or (bp and bp:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hum = boss:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
_G.HoroFarmCleanup = function()
autoZLoop = false
pcall(function() Rayfield:Destroy() end)
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,39,80,73,69,82,73,72,4,89,84,4,84,86,73,90,77,83,89,87,4,87,73,87,87,77,83,82,18},28))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,38,83,87,87},28), selectedBoss, _d({77,87,4,82,83,88,4,87,84,69,91,82,73,72,18,4,59,69,77,88,77,82,75},28), checkSpawnInterval, _d({87,73,71,83,82,72,87,18,18,18},28))
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
local myRoot = getRoot()
if currentTarget and myRoot then
pcall(function()
myRoot.CFrame = CFrame.lookAt(myRoot.Position, Vector3.new(currentTarget.Position.X, myRoot.Position.Y, currentTarget.Position.Z))
Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, currentTarget.Position)
end)
task.wait(0.1)
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.05)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,55,77,81,89,80,69,88,73,72,4,62,4,81,83,89,87,73,4,80,69,89,82,71,76,4,69,88},28), selectedBoss)
else
warn(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,38,83,87,87,4,77,87,4,82,83,88,4,83,82,4,87,71,86,73,73,82,16,4,71,83,89,80,72,4,82,83,88,4,69,77,81,18},28))
end
else
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,56,69,86,75,73,88,4,80,83,87,88,4,83,86,4,72,77,73,72,4,72,89,86,77,82,75,4,21,87,4,72,73,80,69,93,18},28))
end
end
else
warn(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,11,44,83,86,83,17,44,83,86,83,11,4,88,83,83,80,4,82,83,88,4,74,83,89,82,72,4,77,82,4,70,69,71,79,84,69,71,79,4,83,86,4,71,76,69,86,69,71,88,73,86,5},28))
end
task.wait(loopDelay)
end
end
end
end)
MainTab:CreateDropdown({
Name = _d({55,73,80,73,71,88,4,38,83,87,87},28),
Options = {_d({37,92,73,4,44,69,82,72,4,48,83,75,69,82},28)},
CurrentOption = _d({37,92,73,4,44,69,82,72,4,48,83,75,69,82},28),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,55,73,80,73,71,88,73,72,4,88,69,86,75,73,88,30},28), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({37,89,88,83,4,62,4,48,83,83,84},28),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,37,89,88,83,4,62,4,48,83,83,84,30},28), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({48,83,83,84,4,40,73,80,69,93,4,12,55,73,71,83,82,72,87,13},28),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({40,73,87,88,86,83,93,4,57,45},28),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()