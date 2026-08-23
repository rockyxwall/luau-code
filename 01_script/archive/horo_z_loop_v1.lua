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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local VIM = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,36,51,75,56,59,55,62,54,1,63,51,59,64,1,69,65,71,68,53,55,0,62,71,51},46)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({45,21,65,63,66,51,53,70,242,26,71,52,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,36,51,75,56,59,55,62,54,242,39,27,242,30,59,52,68,51,68,75,0},46))
end
local Window = Rayfield:CreateWindow({
Name = _d({26,65,68,65,242,26,65,68,65,242,44,255,24,51,68,63,242,72,3},46),
LoadingTitle = _d({30,65,51,54,59,64,57,242,26,65,68,65,242,44,242,30,65,65,66,0,0,0},46),
LoadingSubtitle = _d({33,66,70,59,63,59,76,55,54},46),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({19,71,70,65,242,24,51,68,63},46), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({26,65,68,65,255,26,65,68,65},46)) or (bp and bp:FindFirstChild(_d({26,65,68,65,255,26,65,68,65},46)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({32,34,21,69},46))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
local hum = boss:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({26,65,68,65,21,51,63,55,68,51,30,65,53,61},46)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)).Health > 0 then
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
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,21,62,55,51,64,55,54,242,71,66,242,66,68,55,72,59,65,71,69,242,69,55,69,69,59,65,64,0},46))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,20,65,69,69},46), selectedBoss, _d({59,69,242,64,65,70,242,69,66,51,73,64,55,54,0,242,41,51,59,70,59,64,57},46), checkSpawnInterval, _d({69,55,53,65,64,54,69,0,0,0},46))
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
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,26,65,72,55,68,55,54,242,51,64,54,242,56,59,68,55,54,242,44,242,51,70},46), selectedBoss)
else
warn(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,24,51,59,62,55,54,242,70,65,242,66,68,65,60,55,53,70,242,70,51,68,57,55,70,242,70,65,242,72,59,55,73,66,65,68,70,0},46))
end
else
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,38,51,68,57,55,70,242,62,65,69,70,242,65,68,242,54,59,55,54,242,54,71,68,59,64,57,242,54,55,62,51,75,0},46))
end
end
else
warn(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,249,26,65,68,65,255,26,65,68,65,249,242,70,65,65,62,242,64,65,70,242,56,65,71,64,54,242,59,64,242,52,51,53,61,66,51,53,61,242,65,68,242,53,58,51,68,51,53,70,55,68,243},46))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({37,55,62,55,53,70,242,20,65,69,69},46),
Options = {_d({19,74,55,242,26,51,64,54,242,30,65,57,51,64},46), _d({20,51,64,54,59,70,242,20,65,69,69},46), _d({28,71,76,65,242,70,58,55,242,22,59,51,63,65,64,54,52,51,53,61},46)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,37,55,62,55,53,70,55,54,242,70,51,68,57,55,70,12},46), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({19,71,70,65,242,44,242,30,65,65,66},46),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({37,55,62,55,53,70,242,20,65,69,69,242,36,55,67,71,59,68,55,54},46),
Content = _d({43,65,71,242,63,71,69,70,242,69,55,62,55,53,70,242,51,242,52,65,69,69,242,56,59,68,69,70,242,52,55,56,65,68,55,242,55,64,51,52,62,59,64,57,242,19,71,70,65,242,44,242,30,65,65,66,243},46),
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
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,19,71,70,65,242,44,242,30,65,65,66,12},46), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({30,65,65,66,242,22,55,62,51,75,242,250,37,55,53,65,64,54,69,251},46),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({21,51,63,55,68,51,242,26,55,59,57,58,70},46),
Range = {10, 60},
Increment = 1,
Suffix = _d({242,69,70,71,54,69},46),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({45,26,65,68,65,242,44,255,24,51,68,63,47,242,21,51,63,55,68,51,242,58,55,59,57,58,70,242,71,66,54,51,70,55,54,242,70,65,12},46), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({22,55,69,70,68,65,75,242,39,27},46),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()