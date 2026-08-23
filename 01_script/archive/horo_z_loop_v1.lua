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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,51,66,90,71,74,70,77,69,16,78,66,74,79,16,84,80,86,83,68,70,15,77,86,66},31)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({60,36,80,78,81,66,68,85,1,41,86,67,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,51,66,90,71,74,70,77,69,1,54,42,1,45,74,67,83,66,83,90,15},31))
end
local Window = Rayfield:CreateWindow({
Name = _d({41,80,83,80,1,41,80,83,80,1,59,14,39,66,83,78,1,87,18},31),
LoadingTitle = _d({45,80,66,69,74,79,72,1,41,80,83,80,1,59,1,45,80,80,81,15,15,15},31),
LoadingSubtitle = _d({48,81,85,74,78,74,91,70,69},31),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({34,86,85,80,1,39,66,83,78},31), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)) or (bp and bp:FindFirstChild(_d({41,80,83,80,14,41,80,83,80},31)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({47,49,36,84},31))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum = boss:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({41,80,83,80,36,66,78,70,83,66,45,80,68,76},31)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)).Health > 0 then
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
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,36,77,70,66,79,70,69,1,86,81,1,81,83,70,87,74,80,86,84,1,84,70,84,84,74,80,79,15},31))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,35,80,84,84},31), selectedBoss, _d({74,84,1,79,80,85,1,84,81,66,88,79,70,69,15,1,56,66,74,85,74,79,72},31), checkSpawnInterval, _d({84,70,68,80,79,69,84,15,15,15},31))
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
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,41,80,87,70,83,70,69,1,66,79,69,1,71,74,83,70,69,1,59,1,66,85},31), selectedBoss)
else
warn(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,39,66,74,77,70,69,1,85,80,1,81,83,80,75,70,68,85,1,85,66,83,72,70,85,1,85,80,1,87,74,70,88,81,80,83,85,15},31))
end
else
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,53,66,83,72,70,85,1,77,80,84,85,1,80,83,1,69,74,70,69,1,69,86,83,74,79,72,1,69,70,77,66,90,15},31))
end
end
else
warn(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,8,41,80,83,80,14,41,80,83,80,8,1,85,80,80,77,1,79,80,85,1,71,80,86,79,69,1,74,79,1,67,66,68,76,81,66,68,76,1,80,83,1,68,73,66,83,66,68,85,70,83,2},31))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({52,70,77,70,68,85,1,35,80,84,84},31),
Options = {_d({34,89,70,1,41,66,79,69,1,45,80,72,66,79},31), _d({35,66,79,69,74,85,1,35,80,84,84},31), _d({43,86,91,80,1,85,73,70,1,37,74,66,78,80,79,69,67,66,68,76},31)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,52,70,77,70,68,85,70,69,1,85,66,83,72,70,85,27},31), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({34,86,85,80,1,59,1,45,80,80,81},31),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({52,70,77,70,68,85,1,35,80,84,84,1,51,70,82,86,74,83,70,69},31),
Content = _d({58,80,86,1,78,86,84,85,1,84,70,77,70,68,85,1,66,1,67,80,84,84,1,71,74,83,84,85,1,67,70,71,80,83,70,1,70,79,66,67,77,74,79,72,1,34,86,85,80,1,59,1,45,80,80,81,2},31),
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
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,34,86,85,80,1,59,1,45,80,80,81,27},31), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({45,80,80,81,1,37,70,77,66,90,1,9,52,70,68,80,79,69,84,10},31),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({36,66,78,70,83,66,1,41,70,74,72,73,85},31),
Range = {10, 60},
Increment = 1,
Suffix = _d({1,84,85,86,69,84},31),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({60,41,80,83,80,1,59,14,39,66,83,78,62,1,36,66,78,70,83,66,1,73,70,74,72,73,85,1,86,81,69,66,85,70,69,1,85,80,27},31), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({37,70,84,85,83,80,90,1,54,42},31),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()