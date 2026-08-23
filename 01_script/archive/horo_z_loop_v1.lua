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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local VIM = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,31,46,70,51,54,50,57,49,252,58,46,54,59,252,64,60,66,63,48,50,251,57,66,46},51)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({40,16,60,58,61,46,48,65,237,21,66,47,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,31,46,70,51,54,50,57,49,237,34,22,237,25,54,47,63,46,63,70,251},51))
end
local Window = Rayfield:CreateWindow({
Name = _d({21,60,63,60,237,21,60,63,60,237,39,250,19,46,63,58,237,67,254},51),
LoadingTitle = _d({25,60,46,49,54,59,52,237,21,60,63,60,237,39,237,25,60,60,61,251,251,251},51),
LoadingSubtitle = _d({28,61,65,54,58,54,71,50,49},51),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({14,66,65,60,237,19,46,63,58},51), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({21,60,63,60,250,21,60,63,60},51)) or (bp and bp:FindFirstChild(_d({21,60,63,60,250,21,60,63,60},51)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({27,29,16,64},51))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
local hum = boss:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({21,60,63,60,16,46,58,50,63,46,25,60,48,56},51)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)).Health > 0 then
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
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,16,57,50,46,59,50,49,237,66,61,237,61,63,50,67,54,60,66,64,237,64,50,64,64,54,60,59,251},51))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,15,60,64,64},51), selectedBoss, _d({54,64,237,59,60,65,237,64,61,46,68,59,50,49,251,237,36,46,54,65,54,59,52},51), checkSpawnInterval, _d({64,50,48,60,59,49,64,251,251,251},51))
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
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,21,60,67,50,63,50,49,237,46,59,49,237,51,54,63,50,49,237,39,237,46,65},51), selectedBoss)
else
warn(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,19,46,54,57,50,49,237,65,60,237,61,63,60,55,50,48,65,237,65,46,63,52,50,65,237,65,60,237,67,54,50,68,61,60,63,65,251},51))
end
else
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,33,46,63,52,50,65,237,57,60,64,65,237,60,63,237,49,54,50,49,237,49,66,63,54,59,52,237,49,50,57,46,70,251},51))
end
end
else
warn(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,244,21,60,63,60,250,21,60,63,60,244,237,65,60,60,57,237,59,60,65,237,51,60,66,59,49,237,54,59,237,47,46,48,56,61,46,48,56,237,60,63,237,48,53,46,63,46,48,65,50,63,238},51))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({32,50,57,50,48,65,237,15,60,64,64},51),
Options = {_d({14,69,50,237,21,46,59,49,237,25,60,52,46,59},51), _d({15,46,59,49,54,65,237,15,60,64,64},51), _d({23,66,71,60,237,65,53,50,237,17,54,46,58,60,59,49,47,46,48,56},51)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,32,50,57,50,48,65,50,49,237,65,46,63,52,50,65,7},51), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({14,66,65,60,237,39,237,25,60,60,61},51),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({32,50,57,50,48,65,237,15,60,64,64,237,31,50,62,66,54,63,50,49},51),
Content = _d({38,60,66,237,58,66,64,65,237,64,50,57,50,48,65,237,46,237,47,60,64,64,237,51,54,63,64,65,237,47,50,51,60,63,50,237,50,59,46,47,57,54,59,52,237,14,66,65,60,237,39,237,25,60,60,61,238},51),
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
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,14,66,65,60,237,39,237,25,60,60,61,7},51), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({25,60,60,61,237,17,50,57,46,70,237,245,32,50,48,60,59,49,64,246},51),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({16,46,58,50,63,46,237,21,50,54,52,53,65},51),
Range = {10, 60},
Increment = 1,
Suffix = _d({237,64,65,66,49,64},51),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({40,21,60,63,60,237,39,250,19,46,63,58,42,237,16,46,58,50,63,46,237,53,50,54,52,53,65,237,66,61,49,46,65,50,49,237,65,60,7},51), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({17,50,64,65,63,60,70,237,34,22},51),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()