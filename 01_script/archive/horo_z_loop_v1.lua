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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,61,76,100,81,84,80,87,79,26,88,76,84,89,26,94,90,96,93,78,80,25,87,96,76},21)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({70,46,90,88,91,76,78,95,11,51,96,77,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,61,76,100,81,84,80,87,79,11,64,52,11,55,84,77,93,76,93,100,25},21))
end
local Window = Rayfield:CreateWindow({
Name = _d({51,90,93,90,11,51,90,93,90,11,69,24,49,76,93,88,11,97,28},21),
LoadingTitle = _d({55,90,76,79,84,89,82,11,51,90,93,90,11,69,11,55,90,90,91,25,25,25},21),
LoadingSubtitle = _d({58,91,95,84,88,84,101,80,79},21),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({44,96,95,90,11,49,76,93,88},21), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)) or (bp and bp:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({57,59,46,94},21))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hum = boss:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({51,90,93,90,46,76,88,80,93,76,55,90,78,86},21)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)).Health > 0 then
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
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,46,87,80,76,89,80,79,11,96,91,11,91,93,80,97,84,90,96,94,11,94,80,94,94,84,90,89,25},21))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,45,90,94,94},21), selectedBoss, _d({84,94,11,89,90,95,11,94,91,76,98,89,80,79,25,11,66,76,84,95,84,89,82},21), checkSpawnInterval, _d({94,80,78,90,89,79,94,25,25,25},21))
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
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,51,90,97,80,93,80,79,11,76,89,79,11,81,84,93,80,79,11,69,11,76,95},21), selectedBoss)
else
warn(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,49,76,84,87,80,79,11,95,90,11,91,93,90,85,80,78,95,11,95,76,93,82,80,95,11,95,90,11,97,84,80,98,91,90,93,95,25},21))
end
else
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,63,76,93,82,80,95,11,87,90,94,95,11,90,93,11,79,84,80,79,11,79,96,93,84,89,82,11,79,80,87,76,100,25},21))
end
end
else
warn(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,18,51,90,93,90,24,51,90,93,90,18,11,95,90,90,87,11,89,90,95,11,81,90,96,89,79,11,84,89,11,77,76,78,86,91,76,78,86,11,90,93,11,78,83,76,93,76,78,95,80,93,12},21))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({62,80,87,80,78,95,11,45,90,94,94},21),
Options = {_d({44,99,80,11,51,76,89,79,11,55,90,82,76,89},21), _d({45,76,89,79,84,95,11,45,90,94,94},21), _d({53,96,101,90,11,95,83,80,11,47,84,76,88,90,89,79,77,76,78,86},21)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,62,80,87,80,78,95,80,79,11,95,76,93,82,80,95,37},21), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({44,96,95,90,11,69,11,55,90,90,91},21),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({62,80,87,80,78,95,11,45,90,94,94,11,61,80,92,96,84,93,80,79},21),
Content = _d({68,90,96,11,88,96,94,95,11,94,80,87,80,78,95,11,76,11,77,90,94,94,11,81,84,93,94,95,11,77,80,81,90,93,80,11,80,89,76,77,87,84,89,82,11,44,96,95,90,11,69,11,55,90,90,91,12},21),
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
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,44,96,95,90,11,69,11,55,90,90,91,37},21), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({55,90,90,91,11,47,80,87,76,100,11,19,62,80,78,90,89,79,94,20},21),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({46,76,88,80,93,76,11,51,80,84,82,83,95},21),
Range = {10, 60},
Increment = 1,
Suffix = _d({11,94,95,96,79,94},21),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({70,51,90,93,90,11,69,24,49,76,93,88,72,11,46,76,88,80,93,76,11,83,80,84,82,83,95,11,96,91,79,76,95,80,79,11,95,90,37},21), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({47,80,94,95,93,90,100,11,64,52},21),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()