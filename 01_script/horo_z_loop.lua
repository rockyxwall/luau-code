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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,38,60,69,60,72,70,38,66,57,71,74,52,69,56,31,71,55,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56,1,63,72,52},45),
_d({59,71,71,67,70,13,2,2,70,60,69,60,72,70,1,64,56,65,72,2,69,52,76,57,60,56,63,55},45),
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,70,59,63,56,75,74,52,69,56,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56},45)
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
error(_d({46,22,66,64,67,52,54,71,243,27,72,53,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,37,52,76,57,60,56,63,55,243,40,28,243,31,60,53,69,52,69,76,1},45))
end
local Window = Rayfield:CreateWindow({
Name = _d({27,66,69,66,243,27,66,69,66,243,45,0,25,52,69,64},45),
LoadingTitle = _d({31,66,52,55,60,65,58,243,27,66,69,66,243,45,243,31,66,66,67,1,1,1},45),
LoadingSubtitle = _d({34,67,71,60,64,60,77,56,55},45),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({20,75,56,243,27,52,65,55,243,31,66,58,52,65},45)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({20,72,71,66,243,25,52,69,64},45), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({27,66,69,66,0,27,66,69,66},45)) or (bp and bp:FindFirstChild(_d({27,66,69,66,0,27,66,69,66},45)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({33,35,22,70},45))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hum = boss:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({27,66,69,66,22,52,64,56,69,52,31,66,54,62},45)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)).Health > 0 then
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
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,22,63,56,52,65,56,55,243,72,67,243,67,69,56,73,60,66,72,70,243,70,56,70,70,60,66,65,1},45))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,21,66,70,70},45), selectedBoss, _d({60,70,243,65,66,71,243,70,67,52,74,65,56,55,1,243,42,52,60,71,60,65,58},45), checkSpawnInterval, _d({70,56,54,66,65,55,70,1,1,1},45))
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
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,27,66,73,56,69,56,55,243,52,65,55,243,57,60,69,56,55,243,45,243,52,71},45), selectedBoss)
else
warn(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,25,52,60,63,56,55,243,71,66,243,67,69,66,61,56,54,71,243,71,52,69,58,56,71,243,71,66,243,73,60,56,74,67,66,69,71,1},45))
end
else
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,39,52,69,58,56,71,243,63,66,70,71,243,66,69,243,55,60,56,55,243,55,72,69,60,65,58,243,55,56,63,52,76,1},45))
end
end
else
warn(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,250,27,66,69,66,0,27,66,69,66,250,243,71,66,66,63,243,65,66,71,243,57,66,72,65,55,243,60,65,243,53,52,54,62,67,52,54,62,243,66,69,243,54,59,52,69,52,54,71,56,69,244},45))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({38,56,63,56,54,71,243,21,66,70,70},45),
Options = {_d({20,75,56,243,27,52,65,55,243,31,66,58,52,65},45)},
CurrentOption = _d({20,75,56,243,27,52,65,55,243,31,66,58,52,65},45),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,38,56,63,56,54,71,56,55,243,71,52,69,58,56,71,13},45), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({20,72,71,66,243,45,243,31,66,66,67},45),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,20,72,71,66,243,45,243,31,66,66,67,13},45), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({31,66,66,67,243,23,56,63,52,76,243,251,38,56,54,66,65,55,70,252},45),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({22,52,64,56,69,52,243,27,56,60,58,59,71},45),
Range = {10, 60},
Increment = 1,
Suffix = _d({243,70,71,72,55,70},45),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({46,27,66,69,66,243,45,0,25,52,69,64,48,243,22,52,64,56,69,52,243,59,56,60,58,59,71,243,72,67,55,52,71,56,55,243,71,66,13},45), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({23,56,70,71,69,66,76,243,40,28},45),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()