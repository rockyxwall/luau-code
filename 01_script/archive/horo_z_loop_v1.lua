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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local VIM = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,43,58,82,63,66,62,69,61,8,70,58,66,71,8,76,72,78,75,60,62,7,69,78,58},39)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({52,28,72,70,73,58,60,77,249,33,78,59,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,43,58,82,63,66,62,69,61,249,46,34,249,37,66,59,75,58,75,82,7},39))
end
local Window = Rayfield:CreateWindow({
Name = _d({33,72,75,72,249,33,72,75,72,249,51,6,31,58,75,70,249,79,10},39),
LoadingTitle = _d({37,72,58,61,66,71,64,249,33,72,75,72,249,51,249,37,72,72,73,7,7,7},39),
LoadingSubtitle = _d({40,73,77,66,70,66,83,62,61},39),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({26,78,77,72,249,31,58,75,70},39), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({33,72,75,72,6,33,72,75,72},39)) or (bp and bp:FindFirstChild(_d({33,72,75,72,6,33,72,75,72},39)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({39,41,28,76},39))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local hum = boss:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({33,72,75,72,28,58,70,62,75,58,37,72,60,68},39)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)).Health > 0 then
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
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,28,69,62,58,71,62,61,249,78,73,249,73,75,62,79,66,72,78,76,249,76,62,76,76,66,72,71,7},39))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,27,72,76,76},39), selectedBoss, _d({66,76,249,71,72,77,249,76,73,58,80,71,62,61,7,249,48,58,66,77,66,71,64},39), checkSpawnInterval, _d({76,62,60,72,71,61,76,7,7,7},39))
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
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,33,72,79,62,75,62,61,249,58,71,61,249,63,66,75,62,61,249,51,249,58,77},39), selectedBoss)
else
warn(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,31,58,66,69,62,61,249,77,72,249,73,75,72,67,62,60,77,249,77,58,75,64,62,77,249,77,72,249,79,66,62,80,73,72,75,77,7},39))
end
else
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,45,58,75,64,62,77,249,69,72,76,77,249,72,75,249,61,66,62,61,249,61,78,75,66,71,64,249,61,62,69,58,82,7},39))
end
end
else
warn(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,0,33,72,75,72,6,33,72,75,72,0,249,77,72,72,69,249,71,72,77,249,63,72,78,71,61,249,66,71,249,59,58,60,68,73,58,60,68,249,72,75,249,60,65,58,75,58,60,77,62,75,250},39))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({44,62,69,62,60,77,249,27,72,76,76},39),
Options = {_d({26,81,62,249,33,58,71,61,249,37,72,64,58,71},39), _d({27,58,71,61,66,77,249,27,72,76,76},39), _d({35,78,83,72,249,77,65,62,249,29,66,58,70,72,71,61,59,58,60,68},39)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,44,62,69,62,60,77,62,61,249,77,58,75,64,62,77,19},39), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({26,78,77,72,249,51,249,37,72,72,73},39),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({44,62,69,62,60,77,249,27,72,76,76,249,43,62,74,78,66,75,62,61},39),
Content = _d({50,72,78,249,70,78,76,77,249,76,62,69,62,60,77,249,58,249,59,72,76,76,249,63,66,75,76,77,249,59,62,63,72,75,62,249,62,71,58,59,69,66,71,64,249,26,78,77,72,249,51,249,37,72,72,73,250},39),
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
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,26,78,77,72,249,51,249,37,72,72,73,19},39), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({37,72,72,73,249,29,62,69,58,82,249,1,44,62,60,72,71,61,76,2},39),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({28,58,70,62,75,58,249,33,62,66,64,65,77},39),
Range = {10, 60},
Increment = 1,
Suffix = _d({249,76,77,78,61,76},39),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({52,33,72,75,72,249,51,6,31,58,75,70,54,249,28,58,70,62,75,58,249,65,62,66,64,65,77,249,78,73,61,58,77,62,61,249,77,72,19},39), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({29,62,76,77,75,72,82,249,46,34},39),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()