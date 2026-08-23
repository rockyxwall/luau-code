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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({52,64,64,60,63,6,251,251,62,45,67,250,51,53,64,52,65,46,65,63,49,62,47,59,58,64,49,58,64,250,47,59,57,251,62,59,47,55,69,68,67,45,56,56,251,30,45,69,50,53,49,56,48,251,57,45,53,58,251,63,59,65,62,47,49,250,56,65,45},52)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({39,15,59,57,60,45,47,64,236,20,65,46,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,30,45,69,50,53,49,56,48,236,33,21,236,24,53,46,62,45,62,69,250},52))
end
local Window = Rayfield:CreateWindow({
Name = _d({20,59,62,59,236,20,59,62,59,236,38,249,18,45,62,57,236,66,253},52),
LoadingTitle = _d({24,59,45,48,53,58,51,236,20,59,62,59,236,38,236,24,59,59,60,250,250,250},52),
LoadingSubtitle = _d({27,60,64,53,57,53,70,49,48},52),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({13,65,64,59,236,18,45,62,57},52), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)) or (bp and bp:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = boss:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({20,59,62,59,15,45,57,49,62,45,24,59,47,55},52)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)).Health > 0 then
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
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,15,56,49,45,58,49,48,236,65,60,236,60,62,49,66,53,59,65,63,236,63,49,63,63,53,59,58,250},52))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,14,59,63,63},52), selectedBoss, _d({53,63,236,58,59,64,236,63,60,45,67,58,49,48,250,236,35,45,53,64,53,58,51},52), checkSpawnInterval, _d({63,49,47,59,58,48,63,250,250,250},52))
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
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,20,59,66,49,62,49,48,236,45,58,48,236,50,53,62,49,48,236,38,236,45,64},52), selectedBoss)
else
warn(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,18,45,53,56,49,48,236,64,59,236,60,62,59,54,49,47,64,236,64,45,62,51,49,64,236,64,59,236,66,53,49,67,60,59,62,64,250},52))
end
else
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,32,45,62,51,49,64,236,56,59,63,64,236,59,62,236,48,53,49,48,236,48,65,62,53,58,51,236,48,49,56,45,69,250},52))
end
end
else
warn(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,243,20,59,62,59,249,20,59,62,59,243,236,64,59,59,56,236,58,59,64,236,50,59,65,58,48,236,53,58,236,46,45,47,55,60,45,47,55,236,59,62,236,47,52,45,62,45,47,64,49,62,237},52))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({31,49,56,49,47,64,236,14,59,63,63},52),
Options = {_d({13,68,49,236,20,45,58,48,236,24,59,51,45,58},52), _d({14,45,58,48,53,64,236,14,59,63,63},52), _d({22,65,70,59,236,64,52,49,236,16,53,45,57,59,58,48,46,45,47,55},52)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,31,49,56,49,47,64,49,48,236,64,45,62,51,49,64,6},52), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({13,65,64,59,236,38,236,24,59,59,60},52),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({31,49,56,49,47,64,236,14,59,63,63,236,30,49,61,65,53,62,49,48},52),
Content = _d({37,59,65,236,57,65,63,64,236,63,49,56,49,47,64,236,45,236,46,59,63,63,236,50,53,62,63,64,236,46,49,50,59,62,49,236,49,58,45,46,56,53,58,51,236,13,65,64,59,236,38,236,24,59,59,60,237},52),
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
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,13,65,64,59,236,38,236,24,59,59,60,6},52), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({24,59,59,60,236,16,49,56,45,69,236,244,31,49,47,59,58,48,63,245},52),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({15,45,57,49,62,45,236,20,49,53,51,52,64},52),
Range = {10, 60},
Increment = 1,
Suffix = _d({236,63,64,65,48,63},52),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({39,20,59,62,59,236,38,249,18,45,62,57,41,236,15,45,57,49,62,45,236,52,49,53,51,52,64,236,65,60,48,45,64,49,48,236,64,59,6},52), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({16,49,63,64,62,59,69,236,33,21},52),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()