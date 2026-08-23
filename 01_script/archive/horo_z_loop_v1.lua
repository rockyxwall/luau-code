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
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,54,69,93,74,77,73,80,72,19,81,69,77,82,19,87,83,89,86,71,73,18,80,89,69},28)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({63,39,83,81,84,69,71,88,4,44,89,70,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,54,69,93,74,77,73,80,72,4,57,45,4,48,77,70,86,69,86,93,18},28))
end
local Window = Rayfield:CreateWindow({
Name = _d({44,83,86,83,4,44,83,86,83,4,62,17,42,69,86,81,4,90,21},28),
LoadingTitle = _d({48,83,69,72,77,82,75,4,44,83,86,83,4,62,4,48,83,83,84,18,18,18},28),
LoadingSubtitle = _d({51,84,88,77,81,77,94,73,72},28),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
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
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({44,83,86,83,39,69,81,73,86,69,48,83,71,79},28)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)).Health > 0 then
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
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,39,80,73,69,82,73,72,4,89,84,4,84,86,73,90,77,83,89,87,4,87,73,87,87,77,83,82,18},28))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,38,83,87,87},28), selectedBoss, _d({77,87,4,82,83,88,4,87,84,69,91,82,73,72,18,4,59,69,77,88,77,82,75},28), checkSpawnInterval, _d({87,73,71,83,82,72,87,18,18,18},28))
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
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,44,83,90,73,86,73,72,4,69,82,72,4,74,77,86,73,72,4,62,4,69,88},28), selectedBoss)
else
warn(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,42,69,77,80,73,72,4,88,83,4,84,86,83,78,73,71,88,4,88,69,86,75,73,88,4,88,83,4,90,77,73,91,84,83,86,88,18},28))
end
else
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,56,69,86,75,73,88,4,80,83,87,88,4,83,86,4,72,77,73,72,4,72,89,86,77,82,75,4,72,73,80,69,93,18},28))
end
end
else
warn(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,11,44,83,86,83,17,44,83,86,83,11,4,88,83,83,80,4,82,83,88,4,74,83,89,82,72,4,77,82,4,70,69,71,79,84,69,71,79,4,83,86,4,71,76,69,86,69,71,88,73,86,5},28))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({55,73,80,73,71,88,4,38,83,87,87},28),
Options = {_d({37,92,73,4,44,69,82,72,4,48,83,75,69,82},28), _d({38,69,82,72,77,88,4,38,83,87,87},28), _d({46,89,94,83,4,88,76,73,4,40,77,69,81,83,82,72,70,69,71,79},28)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,55,73,80,73,71,88,73,72,4,88,69,86,75,73,88,30},28), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({37,89,88,83,4,62,4,48,83,83,84},28),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({55,73,80,73,71,88,4,38,83,87,87,4,54,73,85,89,77,86,73,72},28),
Content = _d({61,83,89,4,81,89,87,88,4,87,73,80,73,71,88,4,69,4,70,83,87,87,4,74,77,86,87,88,4,70,73,74,83,86,73,4,73,82,69,70,80,77,82,75,4,37,89,88,83,4,62,4,48,83,83,84,5},28),
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
MainTab:CreateSlider({
Name = _d({39,69,81,73,86,69,4,44,73,77,75,76,88},28),
Range = {10, 60},
Increment = 1,
Suffix = _d({4,87,88,89,72,87},28),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({63,44,83,86,83,4,62,17,42,69,86,81,65,4,39,69,81,73,86,69,4,76,73,77,75,76,88,4,89,84,72,69,88,73,72,4,88,83,30},28), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({40,73,87,88,86,83,93,4,57,45},28),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()