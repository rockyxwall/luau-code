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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,62,77,101,82,85,81,88,80,27,89,77,85,90,27,95,91,97,94,79,81,26,88,97,77},20)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({71,47,91,89,92,77,79,96,12,52,97,78,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,62,77,101,82,85,81,88,80,12,65,53,12,56,85,78,94,77,94,101,26},20))
end
local Window = Rayfield:CreateWindow({
Name = _d({52,91,94,91,12,52,91,94,91,12,70,25,50,77,94,89,12,98,29},20),
LoadingTitle = _d({56,91,77,80,85,90,83,12,52,91,94,91,12,70,12,56,91,91,92,26,26,26},20),
LoadingSubtitle = _d({59,92,96,85,89,85,102,81,80},20),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({45,97,96,91,12,50,77,94,89},20), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)) or (bp and bp:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = boss:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({52,91,94,91,47,77,89,81,94,77,56,91,79,87},20)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 then
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
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,47,88,81,77,90,81,80,12,97,92,12,92,94,81,98,85,91,97,95,12,95,81,95,95,85,91,90,26},20))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,46,91,95,95},20), selectedBoss, _d({85,95,12,90,91,96,12,95,92,77,99,90,81,80,26,12,67,77,85,96,85,90,83},20), checkSpawnInterval, _d({95,81,79,91,90,80,95,26,26,26},20))
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
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,52,91,98,81,94,81,80,12,77,90,80,12,82,85,94,81,80,12,70,12,77,96},20), selectedBoss)
else
warn(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,50,77,85,88,81,80,12,96,91,12,92,94,91,86,81,79,96,12,96,77,94,83,81,96,12,96,91,12,98,85,81,99,92,91,94,96,26},20))
end
else
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,64,77,94,83,81,96,12,88,91,95,96,12,91,94,12,80,85,81,80,12,80,97,94,85,90,83,12,80,81,88,77,101,26},20))
end
end
else
warn(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,19,52,91,94,91,25,52,91,94,91,19,12,96,91,91,88,12,90,91,96,12,82,91,97,90,80,12,85,90,12,78,77,79,87,92,77,79,87,12,91,94,12,79,84,77,94,77,79,96,81,94,13},20))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({63,81,88,81,79,96,12,46,91,95,95},20),
Options = {_d({45,100,81,12,52,77,90,80,12,56,91,83,77,90},20), _d({46,77,90,80,85,96,12,46,91,95,95},20), _d({54,97,102,91,12,96,84,81,12,48,85,77,89,91,90,80,78,77,79,87},20)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,63,81,88,81,79,96,81,80,12,96,77,94,83,81,96,38},20), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({45,97,96,91,12,70,12,56,91,91,92},20),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({63,81,88,81,79,96,12,46,91,95,95,12,62,81,93,97,85,94,81,80},20),
Content = _d({69,91,97,12,89,97,95,96,12,95,81,88,81,79,96,12,77,12,78,91,95,95,12,82,85,94,95,96,12,78,81,82,91,94,81,12,81,90,77,78,88,85,90,83,12,45,97,96,91,12,70,12,56,91,91,92,13},20),
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
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,45,97,96,91,12,70,12,56,91,91,92,38},20), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({56,91,91,92,12,48,81,88,77,101,12,20,63,81,79,91,90,80,95,21},20),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({47,77,89,81,94,77,12,52,81,85,83,84,96},20),
Range = {10, 60},
Increment = 1,
Suffix = _d({12,95,96,97,80,95},20),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({71,52,91,94,91,12,70,25,50,77,94,89,73,12,47,77,89,81,94,77,12,84,81,85,83,84,96,12,97,92,80,77,96,81,80,12,96,91,38},20), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({48,81,95,96,94,91,101,12,65,53},20),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()