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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,27,42,66,47,50,46,53,45,248,54,42,50,55,248,60,56,62,59,44,46,247,53,62,42},55)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({36,12,56,54,57,42,44,61,233,17,62,43,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,27,42,66,47,50,46,53,45,233,30,18,233,21,50,43,59,42,59,66,247},55))
end
local Window = Rayfield:CreateWindow({
Name = _d({17,56,59,56,233,17,56,59,56,233,35,246,15,42,59,54,233,63,250},55),
LoadingTitle = _d({21,56,42,45,50,55,48,233,17,56,59,56,233,35,233,21,56,56,57,247,247,247},55),
LoadingSubtitle = _d({24,57,61,50,54,50,67,46,45},55),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({10,62,61,56,233,15,42,59,54},55), 4483362458)
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({17,56,59,56,246,17,56,59,56},55)) or (bp and bp:FindFirstChild(_d({17,56,59,56,246,17,56,59,56},55)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({23,25,12,60},55))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local hum = boss:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({17,56,59,56,12,42,54,46,59,42,21,56,44,52},55)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
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
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,12,53,46,42,55,46,45,233,62,57,233,57,59,46,63,50,56,62,60,233,60,46,60,60,50,56,55,247},55))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,11,56,60,60},55), selectedBoss, _d({50,60,233,55,56,61,233,60,57,42,64,55,46,45,247,233,32,42,50,61,50,55,48},55), checkSpawnInterval, _d({60,46,44,56,55,45,60,247,247,247},55))
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
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,17,56,63,46,59,46,45,233,42,55,45,233,47,50,59,46,45,233,35,233,42,61},55), selectedBoss)
else
warn(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,15,42,50,53,46,45,233,61,56,233,57,59,56,51,46,44,61,233,61,42,59,48,46,61,233,61,56,233,63,50,46,64,57,56,59,61,247},55))
end
else
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,29,42,59,48,46,61,233,53,56,60,61,233,56,59,233,45,50,46,45,233,45,62,59,50,55,48,233,45,46,53,42,66,247},55))
end
end
else
warn(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,240,17,56,59,56,246,17,56,59,56,240,233,61,56,56,53,233,55,56,61,233,47,56,62,55,45,233,50,55,233,43,42,44,52,57,42,44,52,233,56,59,233,44,49,42,59,42,44,61,46,59,234},55))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({28,46,53,46,44,61,233,11,56,60,60},55),
Options = {_d({10,65,46,233,17,42,55,45,233,21,56,48,42,55},55), _d({11,42,55,45,50,61,233,11,56,60,60},55), _d({19,62,67,56,233,61,49,46,233,13,50,42,54,56,55,45,43,42,44,52},55)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,28,46,53,46,44,61,46,45,233,61,42,59,48,46,61,3},55), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({10,62,61,56,233,35,233,21,56,56,57},55),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({28,46,53,46,44,61,233,11,56,60,60,233,27,46,58,62,50,59,46,45},55),
Content = _d({34,56,62,233,54,62,60,61,233,60,46,53,46,44,61,233,42,233,43,56,60,60,233,47,50,59,60,61,233,43,46,47,56,59,46,233,46,55,42,43,53,50,55,48,233,10,62,61,56,233,35,233,21,56,56,57,234},55),
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
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,10,62,61,56,233,35,233,21,56,56,57,3},55), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({21,56,56,57,233,13,46,53,42,66,233,241,28,46,44,56,55,45,60,242},55),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({12,42,54,46,59,42,233,17,46,50,48,49,61},55),
Range = {10, 60},
Increment = 1,
Suffix = _d({233,60,61,62,45,60},55),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({36,17,56,59,56,233,35,246,15,42,59,54,38,233,12,42,54,46,59,42,233,49,46,50,48,49,61,233,62,57,45,42,61,46,45,233,61,56,3},55), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({13,46,60,61,59,56,66,233,30,18},55),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()