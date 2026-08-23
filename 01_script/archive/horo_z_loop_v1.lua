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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79,24,86,95,75},22)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({69,45,89,87,90,75,77,94,10,50,95,76,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,60,75,99,80,83,79,86,78,10,63,51,10,54,83,76,92,75,92,99,24},22))
end
local Window = Rayfield:CreateWindow({
Name = _d({50,89,92,89,10,50,89,92,89,10,68,23,48,75,92,87,10,96,27},22),
LoadingTitle = _d({54,89,75,78,83,88,81,10,50,89,92,89,10,68,10,54,89,89,90,24,24,24},22),
LoadingSubtitle = _d({57,90,94,83,87,83,100,79,78},22),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({43,95,94,89,10,48,75,92,87},22), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({50,89,92,89,23,50,89,92,89},22)) or (bp and bp:FindFirstChild(_d({50,89,92,89,23,50,89,92,89},22)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({56,58,45,93},22))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum = boss:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({50,89,92,89,45,75,87,79,92,75,54,89,77,85},22)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)).Health > 0 then
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
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,45,86,79,75,88,79,78,10,95,90,10,90,92,79,96,83,89,95,93,10,93,79,93,93,83,89,88,24},22))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,44,89,93,93},22), selectedBoss, _d({83,93,10,88,89,94,10,93,90,75,97,88,79,78,24,10,65,75,83,94,83,88,81},22), checkSpawnInterval, _d({93,79,77,89,88,78,93,24,24,24},22))
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
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,50,89,96,79,92,79,78,10,75,88,78,10,80,83,92,79,78,10,68,10,75,94},22), selectedBoss)
else
warn(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,48,75,83,86,79,78,10,94,89,10,90,92,89,84,79,77,94,10,94,75,92,81,79,94,10,94,89,10,96,83,79,97,90,89,92,94,24},22))
end
else
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,62,75,92,81,79,94,10,86,89,93,94,10,89,92,10,78,83,79,78,10,78,95,92,83,88,81,10,78,79,86,75,99,24},22))
end
end
else
warn(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,17,50,89,92,89,23,50,89,92,89,17,10,94,89,89,86,10,88,89,94,10,80,89,95,88,78,10,83,88,10,76,75,77,85,90,75,77,85,10,89,92,10,77,82,75,92,75,77,94,79,92,11},22))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({61,79,86,79,77,94,10,44,89,93,93},22),
Options = {_d({43,98,79,10,50,75,88,78,10,54,89,81,75,88},22), _d({44,75,88,78,83,94,10,44,89,93,93},22), _d({52,95,100,89,10,94,82,79,10,46,83,75,87,89,88,78,76,75,77,85},22)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,61,79,86,79,77,94,79,78,10,94,75,92,81,79,94,36},22), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({43,95,94,89,10,68,10,54,89,89,90},22),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({61,79,86,79,77,94,10,44,89,93,93,10,60,79,91,95,83,92,79,78},22),
Content = _d({67,89,95,10,87,95,93,94,10,93,79,86,79,77,94,10,75,10,76,89,93,93,10,80,83,92,93,94,10,76,79,80,89,92,79,10,79,88,75,76,86,83,88,81,10,43,95,94,89,10,68,10,54,89,89,90,11},22),
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
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,43,95,94,89,10,68,10,54,89,89,90,36},22), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({54,89,89,90,10,46,79,86,75,99,10,18,61,79,77,89,88,78,93,19},22),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({45,75,87,79,92,75,10,50,79,83,81,82,94},22),
Range = {10, 60},
Increment = 1,
Suffix = _d({10,93,94,95,78,93},22),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({69,50,89,92,89,10,68,23,48,75,92,87,71,10,45,75,87,79,92,75,10,82,79,83,81,82,94,10,95,90,78,75,94,79,78,10,94,89,36},22), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({46,79,93,94,92,89,99,10,63,51},22),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()