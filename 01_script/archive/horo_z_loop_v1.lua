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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,47,62,86,67,70,66,73,65,12,74,62,70,75,12,80,76,82,79,64,66,11,73,82,62},35)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({56,32,76,74,77,62,64,81,253,37,82,63,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,47,62,86,67,70,66,73,65,253,50,38,253,41,70,63,79,62,79,86,11},35))
end
local Window = Rayfield:CreateWindow({
Name = _d({37,76,79,76,253,37,76,79,76,253,55,10,35,62,79,74,253,83,14},35),
LoadingTitle = _d({41,76,62,65,70,75,68,253,37,76,79,76,253,55,253,41,76,76,77,11,11,11},35),
LoadingSubtitle = _d({44,77,81,70,74,70,87,66,65},35),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({30,82,81,76,253,35,62,79,74},35), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)) or (bp and bp:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = boss:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({37,76,79,76,32,62,74,66,79,62,41,76,64,72},35)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 then
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
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,32,73,66,62,75,66,65,253,82,77,253,77,79,66,83,70,76,82,80,253,80,66,80,80,70,76,75,11},35))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,31,76,80,80},35), selectedBoss, _d({70,80,253,75,76,81,253,80,77,62,84,75,66,65,11,253,52,62,70,81,70,75,68},35), checkSpawnInterval, _d({80,66,64,76,75,65,80,11,11,11},35))
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
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,37,76,83,66,79,66,65,253,62,75,65,253,67,70,79,66,65,253,55,253,62,81},35), selectedBoss)
else
warn(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,35,62,70,73,66,65,253,81,76,253,77,79,76,71,66,64,81,253,81,62,79,68,66,81,253,81,76,253,83,70,66,84,77,76,79,81,11},35))
end
else
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,49,62,79,68,66,81,253,73,76,80,81,253,76,79,253,65,70,66,65,253,65,82,79,70,75,68,253,65,66,73,62,86,11},35))
end
end
else
warn(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,4,37,76,79,76,10,37,76,79,76,4,253,81,76,76,73,253,75,76,81,253,67,76,82,75,65,253,70,75,253,63,62,64,72,77,62,64,72,253,76,79,253,64,69,62,79,62,64,81,66,79,254},35))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({48,66,73,66,64,81,253,31,76,80,80},35),
Options = {_d({30,85,66,253,37,62,75,65,253,41,76,68,62,75},35), _d({31,62,75,65,70,81,253,31,76,80,80},35), _d({39,82,87,76,253,81,69,66,253,33,70,62,74,76,75,65,63,62,64,72},35)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,48,66,73,66,64,81,66,65,253,81,62,79,68,66,81,23},35), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({30,82,81,76,253,55,253,41,76,76,77},35),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({48,66,73,66,64,81,253,31,76,80,80,253,47,66,78,82,70,79,66,65},35),
Content = _d({54,76,82,253,74,82,80,81,253,80,66,73,66,64,81,253,62,253,63,76,80,80,253,67,70,79,80,81,253,63,66,67,76,79,66,253,66,75,62,63,73,70,75,68,253,30,82,81,76,253,55,253,41,76,76,77,254},35),
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
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,30,82,81,76,253,55,253,41,76,76,77,23},35), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({41,76,76,77,253,33,66,73,62,86,253,5,48,66,64,76,75,65,80,6},35),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({32,62,74,66,79,62,253,37,66,70,68,69,81},35),
Range = {10, 60},
Increment = 1,
Suffix = _d({253,80,81,82,65,80},35),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({56,37,76,79,76,253,55,10,35,62,79,74,58,253,32,62,74,66,79,62,253,69,66,70,68,69,81,253,82,77,65,62,81,66,65,253,81,76,23},35), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({33,66,80,81,79,76,86,253,50,38},35),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()