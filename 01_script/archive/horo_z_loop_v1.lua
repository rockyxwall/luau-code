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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,34,49,73,54,57,53,60,52,255,61,49,57,62,255,67,63,69,66,51,53,254,60,69,49},48)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({43,19,63,61,64,49,51,68,240,24,69,50,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,240,34,49,73,54,57,53,60,52,240,37,25,240,28,57,50,66,49,66,73,254},48))
end
local Window = Rayfield:CreateWindow({
Name = _d({24,63,66,63,240,24,63,66,63,240,42,253,22,49,66,61,240,70,1},48),
LoadingTitle = _d({28,63,49,52,57,62,55,240,24,63,66,63,240,42,240,28,63,63,64,254,254,254},48),
LoadingSubtitle = _d({31,64,68,57,61,57,74,53,52},48),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({17,69,68,63,240,22,49,66,61},48), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)) or (bp and bp:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({30,32,19,67},48))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hum = boss:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({24,63,66,63,19,49,61,53,66,49,28,63,51,59},48)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)).Health > 0 then
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
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,19,60,53,49,62,53,52,240,69,64,240,64,66,53,70,57,63,69,67,240,67,53,67,67,57,63,62,254},48))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,18,63,67,67},48), selectedBoss, _d({57,67,240,62,63,68,240,67,64,49,71,62,53,52,254,240,39,49,57,68,57,62,55},48), checkSpawnInterval, _d({67,53,51,63,62,52,67,254,254,254},48))
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
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,24,63,70,53,66,53,52,240,49,62,52,240,54,57,66,53,52,240,42,240,49,68},48), selectedBoss)
else
warn(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,22,49,57,60,53,52,240,68,63,240,64,66,63,58,53,51,68,240,68,49,66,55,53,68,240,68,63,240,70,57,53,71,64,63,66,68,254},48))
end
else
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,36,49,66,55,53,68,240,60,63,67,68,240,63,66,240,52,57,53,52,240,52,69,66,57,62,55,240,52,53,60,49,73,254},48))
end
end
else
warn(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,247,24,63,66,63,253,24,63,66,63,247,240,68,63,63,60,240,62,63,68,240,54,63,69,62,52,240,57,62,240,50,49,51,59,64,49,51,59,240,63,66,240,51,56,49,66,49,51,68,53,66,241},48))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({35,53,60,53,51,68,240,18,63,67,67},48),
Options = {_d({17,72,53,240,24,49,62,52,240,28,63,55,49,62},48), _d({18,49,62,52,57,68,240,18,63,67,67},48), _d({26,69,74,63,240,68,56,53,240,20,57,49,61,63,62,52,50,49,51,59},48)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,35,53,60,53,51,68,53,52,240,68,49,66,55,53,68,10},48), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({17,69,68,63,240,42,240,28,63,63,64},48),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({35,53,60,53,51,68,240,18,63,67,67,240,34,53,65,69,57,66,53,52},48),
Content = _d({41,63,69,240,61,69,67,68,240,67,53,60,53,51,68,240,49,240,50,63,67,67,240,54,57,66,67,68,240,50,53,54,63,66,53,240,53,62,49,50,60,57,62,55,240,17,69,68,63,240,42,240,28,63,63,64,241},48),
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
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,17,69,68,63,240,42,240,28,63,63,64,10},48), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({28,63,63,64,240,20,53,60,49,73,240,248,35,53,51,63,62,52,67,249},48),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({19,49,61,53,66,49,240,24,53,57,55,56,68},48),
Range = {10, 60},
Increment = 1,
Suffix = _d({240,67,68,69,52,67},48),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({43,24,63,66,63,240,42,253,22,49,66,61,45,240,19,49,61,53,66,49,240,56,53,57,55,56,68,240,69,64,52,49,68,53,52,240,68,63,10},48), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({20,53,67,68,66,63,73,240,37,25},48),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()