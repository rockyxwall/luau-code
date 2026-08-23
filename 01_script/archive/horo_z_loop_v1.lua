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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83,28,90,99,79},18)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({73,49,93,91,94,79,81,98,14,54,99,80,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,64,79,103,84,87,83,90,82,14,67,55,14,58,87,80,96,79,96,103,28},18))
end
local Window = Rayfield:CreateWindow({
Name = _d({54,93,96,93,14,54,93,96,93,14,72,27,52,79,96,91,14,100,31},18),
LoadingTitle = _d({58,93,79,82,87,92,85,14,54,93,96,93,14,72,14,58,93,93,94,28,28,28},18),
LoadingSubtitle = _d({61,94,98,87,91,87,104,83,82},18),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({47,99,98,93,14,52,79,96,91},18), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({54,93,96,93,27,54,93,96,93},18)) or (bp and bp:FindFirstChild(_d({54,93,96,93,27,54,93,96,93},18)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({60,62,49,97},18))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum = boss:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({54,93,96,93,49,79,91,83,96,79,58,93,81,89},18)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 then
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
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,49,90,83,79,92,83,82,14,99,94,14,94,96,83,100,87,93,99,97,14,97,83,97,97,87,93,92,28},18))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,48,93,97,97},18), selectedBoss, _d({87,97,14,92,93,98,14,97,94,79,101,92,83,82,28,14,69,79,87,98,87,92,85},18), checkSpawnInterval, _d({97,83,81,93,92,82,97,28,28,28},18))
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
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,54,93,100,83,96,83,82,14,79,92,82,14,84,87,96,83,82,14,72,14,79,98},18), selectedBoss)
else
warn(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,52,79,87,90,83,82,14,98,93,14,94,96,93,88,83,81,98,14,98,79,96,85,83,98,14,98,93,14,100,87,83,101,94,93,96,98,28},18))
end
else
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,66,79,96,85,83,98,14,90,93,97,98,14,93,96,14,82,87,83,82,14,82,99,96,87,92,85,14,82,83,90,79,103,28},18))
end
end
else
warn(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,21,54,93,96,93,27,54,93,96,93,21,14,98,93,93,90,14,92,93,98,14,84,93,99,92,82,14,87,92,14,80,79,81,89,94,79,81,89,14,93,96,14,81,86,79,96,79,81,98,83,96,15},18))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({65,83,90,83,81,98,14,48,93,97,97},18),
Options = {_d({47,102,83,14,54,79,92,82,14,58,93,85,79,92},18), _d({48,79,92,82,87,98,14,48,93,97,97},18), _d({56,99,104,93,14,98,86,83,14,50,87,79,91,93,92,82,80,79,81,89},18)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,65,83,90,83,81,98,83,82,14,98,79,96,85,83,98,40},18), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({47,99,98,93,14,72,14,58,93,93,94},18),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({65,83,90,83,81,98,14,48,93,97,97,14,64,83,95,99,87,96,83,82},18),
Content = _d({71,93,99,14,91,99,97,98,14,97,83,90,83,81,98,14,79,14,80,93,97,97,14,84,87,96,97,98,14,80,83,84,93,96,83,14,83,92,79,80,90,87,92,85,14,47,99,98,93,14,72,14,58,93,93,94,15},18),
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
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,47,99,98,93,14,72,14,58,93,93,94,40},18), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({58,93,93,94,14,50,83,90,79,103,14,22,65,83,81,93,92,82,97,23},18),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({49,79,91,83,96,79,14,54,83,87,85,86,98},18),
Range = {10, 60},
Increment = 1,
Suffix = _d({14,97,98,99,82,97},18),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({73,54,93,96,93,14,72,27,52,79,96,91,75,14,49,79,91,83,96,79,14,86,83,87,85,86,98,14,99,94,82,79,98,83,82,14,98,93,40},18), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({50,83,97,98,96,93,103,14,67,55},18),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()