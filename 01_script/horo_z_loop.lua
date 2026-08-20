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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,57,79,88,79,91,89,57,85,76,90,93,71,88,75,50,90,74,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26),
_d({78,90,90,86,89,32,21,21,89,79,88,79,91,89,20,83,75,84,91,21,88,71,95,76,79,75,82,74},26),
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,89,78,82,75,94,93,71,88,75,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75},26)
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
error(_d({65,41,85,83,86,71,73,90,6,46,91,72,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,50,79,72,88,71,88,95,20},26))
end
local Window = Rayfield:CreateWindow({
Name = _d({46,85,88,85,6,46,85,88,85,6,64,19,44,71,88,83},26),
LoadingTitle = _d({50,85,71,74,79,84,77,6,46,85,88,85,6,64,6,50,85,85,86,20,20,20},26),
LoadingSubtitle = _d({53,86,90,79,83,79,96,75,74},26),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({39,94,75,6,46,71,84,74,6,50,85,77,71,84},26)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({39,91,90,85,6,44,71,88,83},26), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)) or (bp and bp:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = boss:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({46,85,88,85,41,71,83,75,88,71,50,85,73,81},26)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 then
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
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,41,82,75,71,84,75,74,6,91,86,6,86,88,75,92,79,85,91,89,6,89,75,89,89,79,85,84,20},26))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,40,85,89,89},26), selectedBoss, _d({79,89,6,84,85,90,6,89,86,71,93,84,75,74,20,6,61,71,79,90,79,84,77},26), checkSpawnInterval, _d({89,75,73,85,84,74,89,20,20,20},26))
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
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,46,85,92,75,88,75,74,6,71,84,74,6,76,79,88,75,74,6,64,6,71,90},26), selectedBoss)
else
warn(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,44,71,79,82,75,74,6,90,85,6,86,88,85,80,75,73,90,6,90,71,88,77,75,90,6,90,85,6,92,79,75,93,86,85,88,90,20},26))
end
else
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,58,71,88,77,75,90,6,82,85,89,90,6,85,88,6,74,79,75,74,6,74,91,88,79,84,77,6,74,75,82,71,95,20},26))
end
end
else
warn(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,13,46,85,88,85,19,46,85,88,85,13,6,90,85,85,82,6,84,85,90,6,76,85,91,84,74,6,79,84,6,72,71,73,81,86,71,73,81,6,85,88,6,73,78,71,88,71,73,90,75,88,7},26))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({57,75,82,75,73,90,6,40,85,89,89},26),
Options = {_d({39,94,75,6,46,71,84,74,6,50,85,77,71,84},26), _d({40,71,84,74,79,90,6,40,85,89,89},26)},
CurrentOption = _d({39,94,75,6,46,71,84,74,6,50,85,77,71,84},26),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,57,75,82,75,73,90,75,74,6,90,71,88,77,75,90,32},26), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({39,91,90,85,6,64,6,50,85,85,86},26),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,39,91,90,85,6,64,6,50,85,85,86,32},26), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({50,85,85,86,6,42,75,82,71,95,6,14,57,75,73,85,84,74,89,15},26),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({41,71,83,75,88,71,6,46,75,79,77,78,90},26),
Range = {10, 60},
Increment = 1,
Suffix = _d({6,89,90,91,74,89},26),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({65,46,85,88,85,6,64,19,44,71,88,83,67,6,41,71,83,75,88,71,6,78,75,79,77,78,90,6,91,86,74,71,90,75,74,6,90,85,32},26), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,59,47},26),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()