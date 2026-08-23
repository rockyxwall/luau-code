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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local VIM = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,19,34,58,39,42,38,45,37,240,46,34,42,47,240,52,48,54,51,36,38,239,45,54,34},63)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({28,4,48,46,49,34,36,53,225,9,54,35,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,225,19,34,58,39,42,38,45,37,225,22,10,225,13,42,35,51,34,51,58,239},63))
end
local Window = Rayfield:CreateWindow({
Name = _d({9,48,51,48,225,9,48,51,48,225,27,238,7,34,51,46,225,55,242},63),
LoadingTitle = _d({13,48,34,37,42,47,40,225,9,48,51,48,225,27,225,13,48,48,49,239,239,239},63),
LoadingSubtitle = _d({16,49,53,42,46,42,59,38,37},63),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({2,54,53,48,225,7,34,51,46},63), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({9,48,51,48,238,9,48,51,48},63)) or (bp and bp:FindFirstChild(_d({9,48,51,48,238,9,48,51,48},63)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({15,17,4,52},63))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum = boss:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({9,48,51,48,4,34,46,38,51,34,13,48,36,44},63)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)).Health > 0 then
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
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,4,45,38,34,47,38,37,225,54,49,225,49,51,38,55,42,48,54,52,225,52,38,52,52,42,48,47,239},63))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,3,48,52,52},63), selectedBoss, _d({42,52,225,47,48,53,225,52,49,34,56,47,38,37,239,225,24,34,42,53,42,47,40},63), checkSpawnInterval, _d({52,38,36,48,47,37,52,239,239,239},63))
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
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,9,48,55,38,51,38,37,225,34,47,37,225,39,42,51,38,37,225,27,225,34,53},63), selectedBoss)
else
warn(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,7,34,42,45,38,37,225,53,48,225,49,51,48,43,38,36,53,225,53,34,51,40,38,53,225,53,48,225,55,42,38,56,49,48,51,53,239},63))
end
else
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,21,34,51,40,38,53,225,45,48,52,53,225,48,51,225,37,42,38,37,225,37,54,51,42,47,40,225,37,38,45,34,58,239},63))
end
end
else
warn(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,232,9,48,51,48,238,9,48,51,48,232,225,53,48,48,45,225,47,48,53,225,39,48,54,47,37,225,42,47,225,35,34,36,44,49,34,36,44,225,48,51,225,36,41,34,51,34,36,53,38,51,226},63))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({20,38,45,38,36,53,225,3,48,52,52},63),
Options = {_d({2,57,38,225,9,34,47,37,225,13,48,40,34,47},63), _d({3,34,47,37,42,53,225,3,48,52,52},63), _d({11,54,59,48,225,53,41,38,225,5,42,34,46,48,47,37,35,34,36,44},63)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,20,38,45,38,36,53,38,37,225,53,34,51,40,38,53,251},63), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({2,54,53,48,225,27,225,13,48,48,49},63),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({20,38,45,38,36,53,225,3,48,52,52,225,19,38,50,54,42,51,38,37},63),
Content = _d({26,48,54,225,46,54,52,53,225,52,38,45,38,36,53,225,34,225,35,48,52,52,225,39,42,51,52,53,225,35,38,39,48,51,38,225,38,47,34,35,45,42,47,40,225,2,54,53,48,225,27,225,13,48,48,49,226},63),
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
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,2,54,53,48,225,27,225,13,48,48,49,251},63), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({13,48,48,49,225,5,38,45,34,58,225,233,20,38,36,48,47,37,52,234},63),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({4,34,46,38,51,34,225,9,38,42,40,41,53},63),
Range = {10, 60},
Increment = 1,
Suffix = _d({225,52,53,54,37,52},63),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({28,9,48,51,48,225,27,238,7,34,51,46,30,225,4,34,46,38,51,34,225,41,38,42,40,41,53,225,54,49,37,34,53,38,37,225,53,48,251},63), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({5,38,52,53,51,48,58,225,22,10},63),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()