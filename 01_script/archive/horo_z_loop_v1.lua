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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,23,38,62,43,46,42,49,41,244,50,38,46,51,244,56,52,58,55,40,42,243,49,58,38},59)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({32,8,52,50,53,38,40,57,229,13,58,39,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,23,38,62,43,46,42,49,41,229,26,14,229,17,46,39,55,38,55,62,243},59))
end
local Window = Rayfield:CreateWindow({
Name = _d({13,52,55,52,229,13,52,55,52,229,31,242,11,38,55,50,229,59,246},59),
LoadingTitle = _d({17,52,38,41,46,51,44,229,13,52,55,52,229,31,229,17,52,52,53,243,243,243},59),
LoadingSubtitle = _d({20,53,57,46,50,46,63,42,41},59),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({6,58,57,52,229,11,38,55,50},59), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)) or (bp and bp:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum = boss:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({13,52,55,52,8,38,50,42,55,38,17,52,40,48},59)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
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
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,8,49,42,38,51,42,41,229,58,53,229,53,55,42,59,46,52,58,56,229,56,42,56,56,46,52,51,243},59))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,7,52,56,56},59), selectedBoss, _d({46,56,229,51,52,57,229,56,53,38,60,51,42,41,243,229,28,38,46,57,46,51,44},59), checkSpawnInterval, _d({56,42,40,52,51,41,56,243,243,243},59))
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
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,13,52,59,42,55,42,41,229,38,51,41,229,43,46,55,42,41,229,31,229,38,57},59), selectedBoss)
else
warn(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,11,38,46,49,42,41,229,57,52,229,53,55,52,47,42,40,57,229,57,38,55,44,42,57,229,57,52,229,59,46,42,60,53,52,55,57,243},59))
end
else
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,25,38,55,44,42,57,229,49,52,56,57,229,52,55,229,41,46,42,41,229,41,58,55,46,51,44,229,41,42,49,38,62,243},59))
end
end
else
warn(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,236,13,52,55,52,242,13,52,55,52,236,229,57,52,52,49,229,51,52,57,229,43,52,58,51,41,229,46,51,229,39,38,40,48,53,38,40,48,229,52,55,229,40,45,38,55,38,40,57,42,55,230},59))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({24,42,49,42,40,57,229,7,52,56,56},59),
Options = {_d({6,61,42,229,13,38,51,41,229,17,52,44,38,51},59), _d({7,38,51,41,46,57,229,7,52,56,56},59), _d({15,58,63,52,229,57,45,42,229,9,46,38,50,52,51,41,39,38,40,48},59)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,24,42,49,42,40,57,42,41,229,57,38,55,44,42,57,255},59), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({6,58,57,52,229,31,229,17,52,52,53},59),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({24,42,49,42,40,57,229,7,52,56,56,229,23,42,54,58,46,55,42,41},59),
Content = _d({30,52,58,229,50,58,56,57,229,56,42,49,42,40,57,229,38,229,39,52,56,56,229,43,46,55,56,57,229,39,42,43,52,55,42,229,42,51,38,39,49,46,51,44,229,6,58,57,52,229,31,229,17,52,52,53,230},59),
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
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,6,58,57,52,229,31,229,17,52,52,53,255},59), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({17,52,52,53,229,9,42,49,38,62,229,237,24,42,40,52,51,41,56,238},59),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({8,38,50,42,55,38,229,13,42,46,44,45,57},59),
Range = {10, 60},
Increment = 1,
Suffix = _d({229,56,57,58,41,56},59),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({32,13,52,55,52,229,31,242,11,38,55,50,34,229,8,38,50,42,55,38,229,45,42,46,44,45,57,229,58,53,41,38,57,42,41,229,57,52,255},59), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({9,42,56,57,55,52,62,229,26,14},59),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()