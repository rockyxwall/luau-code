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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,41,56,80,61,64,60,67,59,6,68,56,64,69,6,74,70,76,73,58,60,5,67,76,56},41)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({50,26,70,68,71,56,58,75,247,31,76,57,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,41,56,80,61,64,60,67,59,247,44,32,247,35,64,57,73,56,73,80,5},41))
end
local Window = Rayfield:CreateWindow({
Name = _d({31,70,73,70,247,31,70,73,70,247,49,4,29,56,73,68,247,77,8},41),
LoadingTitle = _d({35,70,56,59,64,69,62,247,31,70,73,70,247,49,247,35,70,70,71,5,5,5},41),
LoadingSubtitle = _d({38,71,75,64,68,64,81,60,59},41),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({24,76,75,70,247,29,56,73,68},41), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({31,70,73,70,4,31,70,73,70},41)) or (bp and bp:FindFirstChild(_d({31,70,73,70,4,31,70,73,70},41)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = boss:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({31,70,73,70,26,56,68,60,73,56,35,70,58,66},41)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,26,67,60,56,69,60,59,247,76,71,247,71,73,60,77,64,70,76,74,247,74,60,74,74,64,70,69,5},41))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,25,70,74,74},41), selectedBoss, _d({64,74,247,69,70,75,247,74,71,56,78,69,60,59,5,247,46,56,64,75,64,69,62},41), checkSpawnInterval, _d({74,60,58,70,69,59,74,5,5,5},41))
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
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,31,70,77,60,73,60,59,247,56,69,59,247,61,64,73,60,59,247,49,247,56,75},41), selectedBoss)
else
warn(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,29,56,64,67,60,59,247,75,70,247,71,73,70,65,60,58,75,247,75,56,73,62,60,75,247,75,70,247,77,64,60,78,71,70,73,75,5},41))
end
else
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,43,56,73,62,60,75,247,67,70,74,75,247,70,73,247,59,64,60,59,247,59,76,73,64,69,62,247,59,60,67,56,80,5},41))
end
end
else
warn(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,254,31,70,73,70,4,31,70,73,70,254,247,75,70,70,67,247,69,70,75,247,61,70,76,69,59,247,64,69,247,57,56,58,66,71,56,58,66,247,70,73,247,58,63,56,73,56,58,75,60,73,248},41))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({42,60,67,60,58,75,247,25,70,74,74},41),
Options = {_d({24,79,60,247,31,56,69,59,247,35,70,62,56,69},41), _d({25,56,69,59,64,75,247,25,70,74,74},41), _d({33,76,81,70,247,75,63,60,247,27,64,56,68,70,69,59,57,56,58,66},41)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,42,60,67,60,58,75,60,59,247,75,56,73,62,60,75,17},41), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({24,76,75,70,247,49,247,35,70,70,71},41),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({42,60,67,60,58,75,247,25,70,74,74,247,41,60,72,76,64,73,60,59},41),
Content = _d({48,70,76,247,68,76,74,75,247,74,60,67,60,58,75,247,56,247,57,70,74,74,247,61,64,73,74,75,247,57,60,61,70,73,60,247,60,69,56,57,67,64,69,62,247,24,76,75,70,247,49,247,35,70,70,71,248},41),
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
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,24,76,75,70,247,49,247,35,70,70,71,17},41), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({35,70,70,71,247,27,60,67,56,80,247,255,42,60,58,70,69,59,74,0},41),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({26,56,68,60,73,56,247,31,60,64,62,63,75},41),
Range = {10, 60},
Increment = 1,
Suffix = _d({247,74,75,76,59,74},41),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({50,31,70,73,70,247,49,4,29,56,73,68,52,247,26,56,68,60,73,56,247,63,60,64,62,63,75,247,76,71,59,56,75,60,59,247,75,70,17},41), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({27,60,74,75,73,70,80,247,44,32},41),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()