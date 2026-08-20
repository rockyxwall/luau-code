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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,49,71,80,71,83,81,49,77,68,82,85,63,80,67,42,82,66,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67,12,74,83,63},34),
_d({70,82,82,78,81,24,13,13,81,71,80,71,83,81,12,75,67,76,83,13,80,63,87,68,71,67,74,66},34),
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,81,70,74,67,86,85,63,80,67,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67},34)
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
error(_d({57,33,77,75,78,63,65,82,254,38,83,64,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,48,63,87,68,71,67,74,66,254,51,39,254,42,71,64,80,63,80,87,12},34))
end
local Window = Rayfield:CreateWindow({
Name = _d({38,77,80,77,254,38,77,80,77,254,56,11,36,63,80,75},34),
LoadingTitle = _d({42,77,63,66,71,76,69,254,38,77,80,77,254,56,254,42,77,77,78,12,12,12},34),
LoadingSubtitle = _d({45,78,82,71,75,71,88,67,66},34),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({31,86,67,254,38,63,76,66,254,42,77,69,63,76},34)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({31,83,82,77,254,36,63,80,75},34), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)) or (bp and bp:FindFirstChild(_d({38,77,80,77,11,38,77,80,77},34)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({44,46,33,81},34))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hum = boss:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({38,77,80,77,33,63,75,67,80,63,42,77,65,73},34)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)).Health > 0 then
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
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,33,74,67,63,76,67,66,254,83,78,254,78,80,67,84,71,77,83,81,254,81,67,81,81,71,77,76,12},34))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,32,77,81,81},34), selectedBoss, _d({71,81,254,76,77,82,254,81,78,63,85,76,67,66,12,254,53,63,71,82,71,76,69},34), checkSpawnInterval, _d({81,67,65,77,76,66,81,12,12,12},34))
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
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,38,77,84,67,80,67,66,254,63,76,66,254,68,71,80,67,66,254,56,254,63,82},34), selectedBoss)
else
warn(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,36,63,71,74,67,66,254,82,77,254,78,80,77,72,67,65,82,254,82,63,80,69,67,82,254,82,77,254,84,71,67,85,78,77,80,82,12},34))
end
else
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,50,63,80,69,67,82,254,74,77,81,82,254,77,80,254,66,71,67,66,254,66,83,80,71,76,69,254,66,67,74,63,87,12},34))
end
end
else
warn(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,5,38,77,80,77,11,38,77,80,77,5,254,82,77,77,74,254,76,77,82,254,68,77,83,76,66,254,71,76,254,64,63,65,73,78,63,65,73,254,77,80,254,65,70,63,80,63,65,82,67,80,255},34))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({49,67,74,67,65,82,254,32,77,81,81},34),
Options = {_d({31,86,67,254,38,63,76,66,254,42,77,69,63,76},34), _d({32,63,76,66,71,82,254,32,77,81,81},34)},
CurrentOption = _d({31,86,67,254,38,63,76,66,254,42,77,69,63,76},34),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,49,67,74,67,65,82,67,66,254,82,63,80,69,67,82,24},34), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({31,83,82,77,254,56,254,42,77,77,78},34),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,31,83,82,77,254,56,254,42,77,77,78,24},34), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({42,77,77,78,254,34,67,74,63,87,254,6,49,67,65,77,76,66,81,7},34),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({33,63,75,67,80,63,254,38,67,71,69,70,82},34),
Range = {10, 60},
Increment = 1,
Suffix = _d({254,81,82,83,66,81},34),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({57,38,77,80,77,254,56,11,36,63,80,75,59,254,33,63,75,67,80,63,254,70,67,71,69,70,82,254,83,78,66,63,82,67,66,254,82,77,24},34), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({34,67,81,82,80,77,87,254,51,39},34),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()