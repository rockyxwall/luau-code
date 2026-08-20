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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,41,63,72,63,75,73,41,69,60,74,77,55,72,59,34,74,58,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59,4,66,75,55},42),
_d({62,74,74,70,73,16,5,5,73,63,72,63,75,73,4,67,59,68,75,5,72,55,79,60,63,59,66,58},42),
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,73,62,66,59,78,77,55,72,59,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59},42)
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
error(_d({49,25,69,67,70,55,57,74,246,30,75,56,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,40,55,79,60,63,59,66,58,246,43,31,246,34,63,56,72,55,72,79,4},42))
end
local Window = Rayfield:CreateWindow({
Name = _d({30,69,72,69,246,30,69,72,69,246,48,3,28,55,72,67},42),
LoadingTitle = _d({34,69,55,58,63,68,61,246,30,69,72,69,246,48,246,34,69,69,70,4,4,4},42),
LoadingSubtitle = _d({37,70,74,63,67,63,80,59,58},42),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({23,78,59,246,30,55,68,58,246,34,69,61,55,68},42)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({23,75,74,69,246,28,55,72,67},42), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({30,69,72,69,3,30,69,72,69},42)) or (bp and bp:FindFirstChild(_d({30,69,72,69,3,30,69,72,69},42)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({36,38,25,73},42))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum = boss:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({30,69,72,69,25,55,67,59,72,55,34,69,57,65},42)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health > 0 then
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
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,25,66,59,55,68,59,58,246,75,70,246,70,72,59,76,63,69,75,73,246,73,59,73,73,63,69,68,4},42))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,24,69,73,73},42), selectedBoss, _d({63,73,246,68,69,74,246,73,70,55,77,68,59,58,4,246,45,55,63,74,63,68,61},42), checkSpawnInterval, _d({73,59,57,69,68,58,73,4,4,4},42))
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
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,30,69,76,59,72,59,58,246,55,68,58,246,60,63,72,59,58,246,48,246,55,74},42), selectedBoss)
else
warn(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,28,55,63,66,59,58,246,74,69,246,70,72,69,64,59,57,74,246,74,55,72,61,59,74,246,74,69,246,76,63,59,77,70,69,72,74,4},42))
end
else
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,42,55,72,61,59,74,246,66,69,73,74,246,69,72,246,58,63,59,58,246,58,75,72,63,68,61,246,58,59,66,55,79,4},42))
end
end
else
warn(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,253,30,69,72,69,3,30,69,72,69,253,246,74,69,69,66,246,68,69,74,246,60,69,75,68,58,246,63,68,246,56,55,57,65,70,55,57,65,246,69,72,246,57,62,55,72,55,57,74,59,72,247},42))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({41,59,66,59,57,74,246,24,69,73,73},42),
Options = {_d({23,78,59,246,30,55,68,58,246,34,69,61,55,68},42), _d({24,55,68,58,63,74,246,24,69,73,73},42)},
CurrentOption = _d({23,78,59,246,30,55,68,58,246,34,69,61,55,68},42),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,41,59,66,59,57,74,59,58,246,74,55,72,61,59,74,16},42), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({23,75,74,69,246,48,246,34,69,69,70},42),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,23,75,74,69,246,48,246,34,69,69,70,16},42), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({34,69,69,70,246,26,59,66,55,79,246,254,41,59,57,69,68,58,73,255},42),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({25,55,67,59,72,55,246,30,59,63,61,62,74},42),
Range = {10, 60},
Increment = 1,
Suffix = _d({246,73,74,75,58,73},42),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({49,30,69,72,69,246,48,3,28,55,72,67,51,246,25,55,67,59,72,55,246,62,59,63,61,62,74,246,75,70,58,55,74,59,58,246,74,69,16},42), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({26,59,73,74,72,69,79,246,43,31},42),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()