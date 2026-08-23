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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local VIM = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,57,72,96,77,80,76,83,75,22,84,72,80,85,22,90,86,92,89,74,76,21,83,92,72},25)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({66,42,86,84,87,72,74,91,7,47,92,73,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,57,72,96,77,80,76,83,75,7,60,48,7,51,80,73,89,72,89,96,21},25))
end
local Window = Rayfield:CreateWindow({
Name = _d({47,86,89,86,7,47,86,89,86,7,65,20,45,72,89,84,7,93,24},25),
LoadingTitle = _d({51,86,72,75,80,85,78,7,47,86,89,86,7,65,7,51,86,86,87,21,21,21},25),
LoadingSubtitle = _d({54,87,91,80,84,80,97,76,75},25),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({40,92,91,86,7,45,72,89,84},25), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({47,86,89,86,20,47,86,89,86},25)) or (bp and bp:FindFirstChild(_d({47,86,89,86,20,47,86,89,86},25)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({53,55,42,90},25))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local hum = boss:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({47,86,89,86,42,72,84,76,89,72,51,86,74,82},25)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)).Health > 0 then
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
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,42,83,76,72,85,76,75,7,92,87,7,87,89,76,93,80,86,92,90,7,90,76,90,90,80,86,85,21},25))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,41,86,90,90},25), selectedBoss, _d({80,90,7,85,86,91,7,90,87,72,94,85,76,75,21,7,62,72,80,91,80,85,78},25), checkSpawnInterval, _d({90,76,74,86,85,75,90,21,21,21},25))
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
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,47,86,93,76,89,76,75,7,72,85,75,7,77,80,89,76,75,7,65,7,72,91},25), selectedBoss)
else
warn(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,45,72,80,83,76,75,7,91,86,7,87,89,86,81,76,74,91,7,91,72,89,78,76,91,7,91,86,7,93,80,76,94,87,86,89,91,21},25))
end
else
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,59,72,89,78,76,91,7,83,86,90,91,7,86,89,7,75,80,76,75,7,75,92,89,80,85,78,7,75,76,83,72,96,21},25))
end
end
else
warn(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,14,47,86,89,86,20,47,86,89,86,14,7,91,86,86,83,7,85,86,91,7,77,86,92,85,75,7,80,85,7,73,72,74,82,87,72,74,82,7,86,89,7,74,79,72,89,72,74,91,76,89,8},25))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({58,76,83,76,74,91,7,41,86,90,90},25),
Options = {_d({40,95,76,7,47,72,85,75,7,51,86,78,72,85},25), _d({41,72,85,75,80,91,7,41,86,90,90},25), _d({49,92,97,86,7,91,79,76,7,43,80,72,84,86,85,75,73,72,74,82},25)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,58,76,83,76,74,91,76,75,7,91,72,89,78,76,91,33},25), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({40,92,91,86,7,65,7,51,86,86,87},25),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({58,76,83,76,74,91,7,41,86,90,90,7,57,76,88,92,80,89,76,75},25),
Content = _d({64,86,92,7,84,92,90,91,7,90,76,83,76,74,91,7,72,7,73,86,90,90,7,77,80,89,90,91,7,73,76,77,86,89,76,7,76,85,72,73,83,80,85,78,7,40,92,91,86,7,65,7,51,86,86,87,8},25),
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
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,40,92,91,86,7,65,7,51,86,86,87,33},25), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({51,86,86,87,7,43,76,83,72,96,7,15,58,76,74,86,85,75,90,16},25),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({42,72,84,76,89,72,7,47,76,80,78,79,91},25),
Range = {10, 60},
Increment = 1,
Suffix = _d({7,90,91,92,75,90},25),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({66,47,86,89,86,7,65,20,45,72,89,84,68,7,42,72,84,76,89,72,7,79,76,80,78,79,91,7,92,87,75,72,91,76,75,7,91,86,33},25), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({43,76,90,91,89,86,96,7,60,48},25),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()