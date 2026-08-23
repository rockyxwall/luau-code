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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,24,39,63,44,47,43,50,42,245,51,39,47,52,245,57,53,59,56,41,43,244,50,59,39},58)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({33,9,53,51,54,39,41,58,230,14,59,40,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,24,39,63,44,47,43,50,42,230,27,15,230,18,47,40,56,39,56,63,244},58))
end
local Window = Rayfield:CreateWindow({
Name = _d({14,53,56,53,230,14,53,56,53,230,32,243,12,39,56,51,230,60,247},58),
LoadingTitle = _d({18,53,39,42,47,52,45,230,14,53,56,53,230,32,230,18,53,53,54,244,244,244},58),
LoadingSubtitle = _d({21,54,58,47,51,47,64,43,42},58),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({7,59,58,53,230,12,39,56,51},58), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)) or (bp and bp:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = boss:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({14,53,56,53,9,39,51,43,56,39,18,53,41,49},58)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 then
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
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,9,50,43,39,52,43,42,230,59,54,230,54,56,43,60,47,53,59,57,230,57,43,57,57,47,53,52,244},58))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,8,53,57,57},58), selectedBoss, _d({47,57,230,52,53,58,230,57,54,39,61,52,43,42,244,230,29,39,47,58,47,52,45},58), checkSpawnInterval, _d({57,43,41,53,52,42,57,244,244,244},58))
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
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,14,53,60,43,56,43,42,230,39,52,42,230,44,47,56,43,42,230,32,230,39,58},58), selectedBoss)
else
warn(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,12,39,47,50,43,42,230,58,53,230,54,56,53,48,43,41,58,230,58,39,56,45,43,58,230,58,53,230,60,47,43,61,54,53,56,58,244},58))
end
else
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,26,39,56,45,43,58,230,50,53,57,58,230,53,56,230,42,47,43,42,230,42,59,56,47,52,45,230,42,43,50,39,63,244},58))
end
end
else
warn(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,237,14,53,56,53,243,14,53,56,53,237,230,58,53,53,50,230,52,53,58,230,44,53,59,52,42,230,47,52,230,40,39,41,49,54,39,41,49,230,53,56,230,41,46,39,56,39,41,58,43,56,231},58))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({25,43,50,43,41,58,230,8,53,57,57},58),
Options = {_d({7,62,43,230,14,39,52,42,230,18,53,45,39,52},58), _d({8,39,52,42,47,58,230,8,53,57,57},58), _d({16,59,64,53,230,58,46,43,230,10,47,39,51,53,52,42,40,39,41,49},58)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,25,43,50,43,41,58,43,42,230,58,39,56,45,43,58,0},58), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({7,59,58,53,230,32,230,18,53,53,54},58),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({25,43,50,43,41,58,230,8,53,57,57,230,24,43,55,59,47,56,43,42},58),
Content = _d({31,53,59,230,51,59,57,58,230,57,43,50,43,41,58,230,39,230,40,53,57,57,230,44,47,56,57,58,230,40,43,44,53,56,43,230,43,52,39,40,50,47,52,45,230,7,59,58,53,230,32,230,18,53,53,54,231},58),
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
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,7,59,58,53,230,32,230,18,53,53,54,0},58), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({18,53,53,54,230,10,43,50,39,63,230,238,25,43,41,53,52,42,57,239},58),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({9,39,51,43,56,39,230,14,43,47,45,46,58},58),
Range = {10, 60},
Increment = 1,
Suffix = _d({230,57,58,59,42,57},58),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({33,14,53,56,53,230,32,243,12,39,56,51,35,230,9,39,51,43,56,39,230,46,43,47,45,46,58,230,59,54,42,39,58,43,42,230,58,53,0},58), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({10,43,57,58,56,53,63,230,27,15},58),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()