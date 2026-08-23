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
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({67,43,87,85,88,73,75,92,8,48,93,74,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({48,87,90,87,8,48,87,90,87,8,66,21,46,73,90,85,8,94,25},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,48,87,90,87,8,66,8,52,87,87,88,22,22,22},24),
LoadingSubtitle = _d({55,88,92,81,85,81,98,77,76},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
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
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({48,87,90,87,43,73,85,77,90,73,52,87,75,83},24)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 then
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
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,42,87,91,91},24), selectedBoss, _d({81,91,8,86,87,92,8,91,88,73,95,86,77,76,22,8,63,73,81,92,81,86,79},24), checkSpawnInterval, _d({91,77,75,87,86,76,91,22,22,22},24))
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
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,48,87,94,77,90,77,76,8,73,86,76,8,78,81,90,77,76,8,66,8,73,92},24), selectedBoss)
else
warn(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,46,73,81,84,77,76,8,92,87,8,88,90,87,82,77,75,92,8,92,73,90,79,77,92,8,92,87,8,94,81,77,95,88,87,90,92,22},24))
end
else
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,60,73,90,79,77,92,8,84,87,91,92,8,87,90,8,76,81,77,76,8,76,93,90,81,86,79,8,76,77,84,73,97,22},24))
end
end
else
warn(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,15,48,87,90,87,21,48,87,90,87,15,8,92,87,87,84,8,86,87,92,8,78,87,93,86,76,8,81,86,8,74,73,75,83,88,73,75,83,8,87,90,8,75,80,73,90,73,75,92,77,90,9},24))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,42,87,91,91},24),
Options = {_d({41,96,77,8,48,73,86,76,8,52,87,79,73,86},24), _d({42,73,86,76,81,92,8,42,87,91,91},24), _d({50,93,98,87,8,92,80,77,8,44,81,73,85,87,86,76,74,73,75,83},24)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,59,77,84,77,75,92,77,76,8,92,73,90,79,77,92,34},24), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({41,93,92,87,8,66,8,52,87,87,88},24),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({59,77,84,77,75,92,8,42,87,91,91,8,58,77,89,93,81,90,77,76},24),
Content = _d({65,87,93,8,85,93,91,92,8,91,77,84,77,75,92,8,73,8,74,87,91,91,8,78,81,90,91,92,8,74,77,78,87,90,77,8,77,86,73,74,84,81,86,79,8,41,93,92,87,8,66,8,52,87,87,88,9},24),
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
MainTab:CreateSlider({
Name = _d({43,73,85,77,90,73,8,48,77,81,79,80,92},24),
Range = {10, 60},
Increment = 1,
Suffix = _d({8,91,92,93,76,91},24),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({67,48,87,90,87,8,66,21,46,73,90,85,69,8,43,73,85,77,90,73,8,80,77,81,79,80,92,8,93,88,76,73,92,77,76,8,92,87,34},24), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49},24),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()