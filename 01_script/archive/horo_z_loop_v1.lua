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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69,14,76,85,65},32)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({59,35,79,77,80,65,67,84,0,40,85,66,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,50,65,89,70,73,69,76,68,0,53,41,0,44,73,66,82,65,82,89,14},32))
end
local Window = Rayfield:CreateWindow({
Name = _d({40,79,82,79,0,40,79,82,79,0,58,13,38,65,82,77,0,86,17},32),
LoadingTitle = _d({44,79,65,68,73,78,71,0,40,79,82,79,0,58,0,44,79,79,80,14,14,14},32),
LoadingSubtitle = _d({47,80,84,73,77,73,90,69,68},32),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({33,85,84,79,0,38,65,82,77},32), 4483362458)
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)) or (bp and bp:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = boss:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({40,79,82,79,35,65,77,69,82,65,44,79,67,75},32)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,35,76,69,65,78,69,68,0,85,80,0,80,82,69,86,73,79,85,83,0,83,69,83,83,73,79,78,14},32))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,34,79,83,83},32), selectedBoss, _d({73,83,0,78,79,84,0,83,80,65,87,78,69,68,14,0,55,65,73,84,73,78,71},32), checkSpawnInterval, _d({83,69,67,79,78,68,83,14,14,14},32))
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
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,40,79,86,69,82,69,68,0,65,78,68,0,70,73,82,69,68,0,58,0,65,84},32), selectedBoss)
else
warn(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,38,65,73,76,69,68,0,84,79,0,80,82,79,74,69,67,84,0,84,65,82,71,69,84,0,84,79,0,86,73,69,87,80,79,82,84,14},32))
end
else
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,52,65,82,71,69,84,0,76,79,83,84,0,79,82,0,68,73,69,68,0,68,85,82,73,78,71,0,68,69,76,65,89,14},32))
end
end
else
warn(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,7,40,79,82,79,13,40,79,82,79,7,0,84,79,79,76,0,78,79,84,0,70,79,85,78,68,0,73,78,0,66,65,67,75,80,65,67,75,0,79,82,0,67,72,65,82,65,67,84,69,82,1},32))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({51,69,76,69,67,84,0,34,79,83,83},32),
Options = {_d({33,88,69,0,40,65,78,68,0,44,79,71,65,78},32), _d({34,65,78,68,73,84,0,34,79,83,83},32), _d({42,85,90,79,0,84,72,69,0,36,73,65,77,79,78,68,66,65,67,75},32)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,51,69,76,69,67,84,69,68,0,84,65,82,71,69,84,26},32), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({33,85,84,79,0,58,0,44,79,79,80},32),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({51,69,76,69,67,84,0,34,79,83,83,0,50,69,81,85,73,82,69,68},32),
Content = _d({57,79,85,0,77,85,83,84,0,83,69,76,69,67,84,0,65,0,66,79,83,83,0,70,73,82,83,84,0,66,69,70,79,82,69,0,69,78,65,66,76,73,78,71,0,33,85,84,79,0,58,0,44,79,79,80,1},32),
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
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,33,85,84,79,0,58,0,44,79,79,80,26},32), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({44,79,79,80,0,36,69,76,65,89,0,8,51,69,67,79,78,68,83,9},32),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({35,65,77,69,82,65,0,40,69,73,71,72,84},32),
Range = {10, 60},
Increment = 1,
Suffix = _d({0,83,84,85,68,83},32),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({59,40,79,82,79,0,58,13,38,65,82,77,61,0,35,65,77,69,82,65,0,72,69,73,71,72,84,0,85,80,68,65,84,69,68,0,84,79,26},32), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({36,69,83,84,82,79,89,0,53,41},32),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()