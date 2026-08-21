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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,23,45,54,45,57,55,23,51,42,56,59,37,54,41,16,56,40,243,22,37,61,42,45,41,48,40,243,49,37,45,50,243,55,51,57,54,39,41,242,48,57,37},60),
_d({44,56,56,52,55,254,243,243,55,45,54,45,57,55,242,49,41,50,57,243,54,37,61,42,45,41,48,40},60),
_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,55,44,48,41,60,59,37,54,41,243,22,37,61,42,45,41,48,40,243,49,37,45,50,243,55,51,57,54,39,41},60)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({31,7,51,49,52,37,39,56,228,12,57,38,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,22,37,61,42,45,41,48,40,228,25,13,228,16,45,38,54,37,54,61,242},60))
end
local Window = Rayfield:CreateWindow({
Name = _d({12,51,54,51,228,12,51,54,51,228,30,241,10,37,54,49},60),
LoadingTitle = _d({16,51,37,40,45,50,43,228,12,51,54,51,228,30,228,16,51,51,52,242,242,242},60),
LoadingSubtitle = _d({19,52,56,45,49,45,62,41,40},60),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({5,57,56,51,228,10,37,54,49},60), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({12,51,54,51,241,12,51,54,51},60)) or (bp and bp:FindFirstChild(_d({12,51,54,51,241,12,51,54,51},60)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({18,20,7,55},60))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local hum = boss:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({12,51,54,51,7,37,49,41,54,37,16,51,39,47},60)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,7,48,41,37,50,41,40,228,57,52,228,52,54,41,58,45,51,57,55,228,55,41,55,55,45,51,50,242},60))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,6,51,55,55},60), selectedBoss, _d({45,55,228,50,51,56,228,55,52,37,59,50,41,40,242,228,27,37,45,56,45,50,43},60), checkSpawnInterval, _d({55,41,39,51,50,40,55,242,242,242},60))
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
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,12,51,58,41,54,41,40,228,37,50,40,228,42,45,54,41,40,228,30,228,37,56},60), selectedBoss)
else
warn(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,10,37,45,48,41,40,228,56,51,228,52,54,51,46,41,39,56,228,56,37,54,43,41,56,228,56,51,228,58,45,41,59,52,51,54,56,242},60))
end
else
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,24,37,54,43,41,56,228,48,51,55,56,228,51,54,228,40,45,41,40,228,40,57,54,45,50,43,228,40,41,48,37,61,242},60))
end
end
else
warn(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,235,12,51,54,51,241,12,51,54,51,235,228,56,51,51,48,228,50,51,56,228,42,51,57,50,40,228,45,50,228,38,37,39,47,52,37,39,47,228,51,54,228,39,44,37,54,37,39,56,41,54,229},60))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({23,41,48,41,39,56,228,6,51,55,55},60),
Options = {_d({5,60,41,228,12,37,50,40,228,16,51,43,37,50},60), _d({6,37,50,40,45,56,228,6,51,55,55},60)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,23,41,48,41,39,56,41,40,228,56,37,54,43,41,56,254},60), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({5,57,56,51,228,30,228,16,51,51,52},60),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({23,41,48,41,39,56,228,6,51,55,55,228,22,41,53,57,45,54,41,40},60),
Content = _d({29,51,57,228,49,57,55,56,228,55,41,48,41,39,56,228,37,228,38,51,55,55,228,42,45,54,55,56,228,38,41,42,51,54,41,228,41,50,37,38,48,45,50,43,228,5,57,56,51,228,30,228,16,51,51,52,229},60),
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
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,5,57,56,51,228,30,228,16,51,51,52,254},60), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({16,51,51,52,228,8,41,48,37,61,228,236,23,41,39,51,50,40,55,237},60),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({7,37,49,41,54,37,228,12,41,45,43,44,56},60),
Range = {10, 60},
Increment = 1,
Suffix = _d({228,55,56,57,40,55},60),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,7,37,49,41,54,37,228,44,41,45,43,44,56,228,57,52,40,37,56,41,40,228,56,51,254},60), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({8,41,55,56,54,51,61,228,25,13},60),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()