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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local VIM = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85,30,92,101,81},16)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({75,51,95,93,96,81,83,100,16,56,101,82,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,66,81,105,86,89,85,92,84,16,69,57,16,60,89,82,98,81,98,105,30},16))
end
local Window = Rayfield:CreateWindow({
Name = _d({56,95,98,95,16,56,95,98,95,16,74,29,54,81,98,93,16,102,33},16),
LoadingTitle = _d({60,95,81,84,89,94,87,16,56,95,98,95,16,74,16,60,95,95,96,30,30,30},16),
LoadingSubtitle = _d({63,96,100,89,93,89,106,85,84},16),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({49,101,100,95,16,54,81,98,93},16), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)) or (bp and bp:FindFirstChild(_d({56,95,98,95,29,56,95,98,95},16)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({62,64,51,99},16))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = boss:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({56,95,98,95,51,81,93,85,98,81,60,95,83,91},16)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)).Health > 0 then
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
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,51,92,85,81,94,85,84,16,101,96,16,96,98,85,102,89,95,101,99,16,99,85,99,99,89,95,94,30},16))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,50,95,99,99},16), selectedBoss, _d({89,99,16,94,95,100,16,99,96,81,103,94,85,84,30,16,71,81,89,100,89,94,87},16), checkSpawnInterval, _d({99,85,83,95,94,84,99,30,30,30},16))
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
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,56,95,102,85,98,85,84,16,81,94,84,16,86,89,98,85,84,16,74,16,81,100},16), selectedBoss)
else
warn(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,54,81,89,92,85,84,16,100,95,16,96,98,95,90,85,83,100,16,100,81,98,87,85,100,16,100,95,16,102,89,85,103,96,95,98,100,30},16))
end
else
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,68,81,98,87,85,100,16,92,95,99,100,16,95,98,16,84,89,85,84,16,84,101,98,89,94,87,16,84,85,92,81,105,30},16))
end
end
else
warn(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,23,56,95,98,95,29,56,95,98,95,23,16,100,95,95,92,16,94,95,100,16,86,95,101,94,84,16,89,94,16,82,81,83,91,96,81,83,91,16,95,98,16,83,88,81,98,81,83,100,85,98,17},16))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({67,85,92,85,83,100,16,50,95,99,99},16),
Options = {_d({49,104,85,16,56,81,94,84,16,60,95,87,81,94},16), _d({50,81,94,84,89,100,16,50,95,99,99},16), _d({58,101,106,95,16,100,88,85,16,52,89,81,93,95,94,84,82,81,83,91},16)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,67,85,92,85,83,100,85,84,16,100,81,98,87,85,100,42},16), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({49,101,100,95,16,74,16,60,95,95,96},16),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({67,85,92,85,83,100,16,50,95,99,99,16,66,85,97,101,89,98,85,84},16),
Content = _d({73,95,101,16,93,101,99,100,16,99,85,92,85,83,100,16,81,16,82,95,99,99,16,86,89,98,99,100,16,82,85,86,95,98,85,16,85,94,81,82,92,89,94,87,16,49,101,100,95,16,74,16,60,95,95,96,17},16),
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
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,49,101,100,95,16,74,16,60,95,95,96,42},16), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({60,95,95,96,16,52,85,92,81,105,16,24,67,85,83,95,94,84,99,25},16),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({51,81,93,85,98,81,16,56,85,89,87,88,100},16),
Range = {10, 60},
Increment = 1,
Suffix = _d({16,99,100,101,84,99},16),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({75,56,95,98,95,16,74,29,54,81,98,93,77,16,51,81,93,85,98,81,16,88,85,89,87,88,100,16,101,96,84,81,100,85,84,16,100,95,42},16), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({52,85,99,100,98,95,105,16,69,57},16),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()