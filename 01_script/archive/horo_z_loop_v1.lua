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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63,8,70,79,59},38)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({53,29,73,71,74,59,61,78,250,34,79,60,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,44,59,83,64,67,63,70,62,250,47,35,250,38,67,60,76,59,76,83,8},38))
end
local Window = Rayfield:CreateWindow({
Name = _d({34,73,76,73,250,34,73,76,73,250,52,7,32,59,76,71,250,80,11},38),
LoadingTitle = _d({38,73,59,62,67,72,65,250,34,73,76,73,250,52,250,38,73,73,74,8,8,8},38),
LoadingSubtitle = _d({41,74,78,67,71,67,84,63,62},38),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({27,79,78,73,250,32,59,76,71},38), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({34,73,76,73,7,34,73,76,73},38)) or (bp and bp:FindFirstChild(_d({34,73,76,73,7,34,73,76,73},38)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({40,42,29,77},38))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum = boss:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({34,73,76,73,29,59,71,63,76,59,38,73,61,69},38)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
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
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,29,70,63,59,72,63,62,250,79,74,250,74,76,63,80,67,73,79,77,250,77,63,77,77,67,73,72,8},38))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,28,73,77,77},38), selectedBoss, _d({67,77,250,72,73,78,250,77,74,59,81,72,63,62,8,250,49,59,67,78,67,72,65},38), checkSpawnInterval, _d({77,63,61,73,72,62,77,8,8,8},38))
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
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,34,73,80,63,76,63,62,250,59,72,62,250,64,67,76,63,62,250,52,250,59,78},38), selectedBoss)
else
warn(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,32,59,67,70,63,62,250,78,73,250,74,76,73,68,63,61,78,250,78,59,76,65,63,78,250,78,73,250,80,67,63,81,74,73,76,78,8},38))
end
else
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,46,59,76,65,63,78,250,70,73,77,78,250,73,76,250,62,67,63,62,250,62,79,76,67,72,65,250,62,63,70,59,83,8},38))
end
end
else
warn(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,1,34,73,76,73,7,34,73,76,73,1,250,78,73,73,70,250,72,73,78,250,64,73,79,72,62,250,67,72,250,60,59,61,69,74,59,61,69,250,73,76,250,61,66,59,76,59,61,78,63,76,251},38))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({45,63,70,63,61,78,250,28,73,77,77},38),
Options = {_d({27,82,63,250,34,59,72,62,250,38,73,65,59,72},38), _d({28,59,72,62,67,78,250,28,73,77,77},38), _d({36,79,84,73,250,78,66,63,250,30,67,59,71,73,72,62,60,59,61,69},38)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,45,63,70,63,61,78,63,62,250,78,59,76,65,63,78,20},38), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({27,79,78,73,250,52,250,38,73,73,74},38),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({45,63,70,63,61,78,250,28,73,77,77,250,44,63,75,79,67,76,63,62},38),
Content = _d({51,73,79,250,71,79,77,78,250,77,63,70,63,61,78,250,59,250,60,73,77,77,250,64,67,76,77,78,250,60,63,64,73,76,63,250,63,72,59,60,70,67,72,65,250,27,79,78,73,250,52,250,38,73,73,74,251},38),
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
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,27,79,78,73,250,52,250,38,73,73,74,20},38), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({38,73,73,74,250,30,63,70,59,83,250,2,45,63,61,73,72,62,77,3},38),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({29,59,71,63,76,59,250,34,63,67,65,66,78},38),
Range = {10, 60},
Increment = 1,
Suffix = _d({250,77,78,79,62,77},38),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({53,34,73,76,73,250,52,7,32,59,76,71,55,250,29,59,71,63,76,59,250,66,63,67,65,66,78,250,79,74,62,59,78,63,62,250,78,73,20},38), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({30,63,77,78,76,73,83,250,47,35},38),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()