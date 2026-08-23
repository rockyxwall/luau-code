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
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,59,74,98,79,82,78,85,77,24,86,74,82,87,24,92,88,94,91,76,78,23,85,94,74},23)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({68,44,88,86,89,74,76,93,9,49,94,75,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,59,74,98,79,82,78,85,77,9,62,50,9,53,82,75,91,74,91,98,23},23))
end
local Window = Rayfield:CreateWindow({
Name = _d({49,88,91,88,9,49,88,91,88,9,67,22,47,74,91,86,9,95,26},23),
LoadingTitle = _d({53,88,74,77,82,87,80,9,49,88,91,88,9,67,9,53,88,88,89,23,23,23},23),
LoadingSubtitle = _d({56,89,93,82,86,82,99,78,77},23),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
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
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({49,88,91,88,44,74,86,78,91,74,53,88,76,84},23)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.lookAt(targetRoot.Position + Vector3.new(0, cameraHeight, 0), targetRoot.Position)
else
pcall(function() RunService:UnbindFromRenderStep(BIND_NAME) end)
cameraBound = false
if savedCameraType and savedCameraCF then
Camera.CameraType = savedCameraType
Camera.CFrame = savedCameraCF
savedCameraType = nil
savedCameraCF = nil
else
Camera.CameraType = Enum.CameraType.Custom
end
end
end)
end
end
local function unlockCamera()
if cameraBound then
pcall(function() RunService:UnbindFromRenderStep(BIND_NAME) end)
cameraBound = false
end
if savedCameraType and savedCameraCF then
Camera.CameraType = savedCameraType
Camera.CFrame = savedCameraCF
savedCameraType = nil
savedCameraCF = nil
else
Camera.CameraType = Enum.CameraType.Custom
end
end
_G.HoroFarmCleanup = function()
autoZLoop = nil
unlockCamera()
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
unlockCamera()
task.wait(checkSpawnInterval)
else
lockCameraToBoss(targetRoot)
local tool = equipHoroTool()
if tool then
if getBossPart(selectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(selectedBoss)
if currentTarget then
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,49,88,95,78,91,78,77,9,74,87,77,9,79,82,91,78,77,9,67,9,74,93},23), selectedBoss)
else
warn(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,47,74,82,85,78,77,9,93,88,9,89,91,88,83,78,76,93,9,93,74,91,80,78,93,9,93,88,9,95,82,78,96,89,88,91,93,23},23))
end
else
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,61,74,91,80,78,93,9,85,88,92,93,9,88,91,9,77,82,78,77,9,77,94,91,82,87,80,9,77,78,85,74,98,23},23))
end
end
else
warn(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,16,49,88,91,88,22,49,88,91,88,16,9,93,88,88,85,9,87,88,93,9,79,88,94,87,77,9,82,87,9,75,74,76,84,89,74,76,84,9,88,91,9,76,81,74,91,74,76,93,78,91,10},23))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({60,78,85,78,76,93,9,43,88,92,92},23),
Options = {_d({42,97,78,9,49,74,87,77,9,53,88,80,74,87},23), _d({43,74,87,77,82,93,9,43,88,92,92},23), _d({51,94,99,88,9,93,81,78,9,45,82,74,86,88,87,77,75,74,76,84},23)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,60,78,85,78,76,93,78,77,9,93,74,91,80,78,93,35},23), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({42,94,93,88,9,67,9,53,88,88,89},23),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({60,78,85,78,76,93,9,43,88,92,92,9,59,78,90,94,82,91,78,77},23),
Content = _d({66,88,94,9,86,94,92,93,9,92,78,85,78,76,93,9,74,9,75,88,92,92,9,79,82,91,92,93,9,75,78,79,88,91,78,9,78,87,74,75,85,82,87,80,9,42,94,93,88,9,67,9,53,88,88,89,10},23),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
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
MainTab:CreateSlider({
Name = _d({44,74,86,78,91,74,9,49,78,82,80,81,93},23),
Range = {10, 60},
Increment = 1,
Suffix = _d({9,92,93,94,77,92},23),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({68,49,88,91,88,9,67,22,47,74,91,86,70,9,44,74,86,78,91,74,9,81,78,82,80,81,93,9,94,89,77,74,93,78,77,9,93,88,35},23), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({45,78,92,93,91,88,98,9,62,50},23),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()