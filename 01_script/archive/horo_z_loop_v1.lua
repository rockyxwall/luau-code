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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,20,35,59,40,43,39,46,38,241,47,35,43,48,241,53,49,55,52,37,39,240,46,55,35},62)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({29,5,49,47,50,35,37,54,226,10,55,36,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,20,35,59,40,43,39,46,38,226,23,11,226,14,43,36,52,35,52,59,240},62))
end
local Window = Rayfield:CreateWindow({
Name = _d({10,49,52,49,226,10,49,52,49,226,28,239,8,35,52,47,226,56,243},62),
LoadingTitle = _d({14,49,35,38,43,48,41,226,10,49,52,49,226,28,226,14,49,49,50,240,240,240},62),
LoadingSubtitle = _d({17,50,54,43,47,43,60,39,38},62),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({3,55,54,49,226,8,35,52,47},62), 4483362458)
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({10,49,52,49,239,10,49,52,49},62)) or (bp and bp:FindFirstChild(_d({10,49,52,49,239,10,49,52,49},62)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({16,18,5,53},62))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local hum = boss:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({10,49,52,49,5,35,47,39,52,35,14,49,37,45},62)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,5,46,39,35,48,39,38,226,55,50,226,50,52,39,56,43,49,55,53,226,53,39,53,53,43,49,48,240},62))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,4,49,53,53},62), selectedBoss, _d({43,53,226,48,49,54,226,53,50,35,57,48,39,38,240,226,25,35,43,54,43,48,41},62), checkSpawnInterval, _d({53,39,37,49,48,38,53,240,240,240},62))
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
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,10,49,56,39,52,39,38,226,35,48,38,226,40,43,52,39,38,226,28,226,35,54},62), selectedBoss)
else
warn(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,8,35,43,46,39,38,226,54,49,226,50,52,49,44,39,37,54,226,54,35,52,41,39,54,226,54,49,226,56,43,39,57,50,49,52,54,240},62))
end
else
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,22,35,52,41,39,54,226,46,49,53,54,226,49,52,226,38,43,39,38,226,38,55,52,43,48,41,226,38,39,46,35,59,240},62))
end
end
else
warn(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,233,10,49,52,49,239,10,49,52,49,233,226,54,49,49,46,226,48,49,54,226,40,49,55,48,38,226,43,48,226,36,35,37,45,50,35,37,45,226,49,52,226,37,42,35,52,35,37,54,39,52,227},62))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({21,39,46,39,37,54,226,4,49,53,53},62),
Options = {_d({3,58,39,226,10,35,48,38,226,14,49,41,35,48},62), _d({4,35,48,38,43,54,226,4,49,53,53},62), _d({12,55,60,49,226,54,42,39,226,6,43,35,47,49,48,38,36,35,37,45},62)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,21,39,46,39,37,54,39,38,226,54,35,52,41,39,54,252},62), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({3,55,54,49,226,28,226,14,49,49,50},62),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({21,39,46,39,37,54,226,4,49,53,53,226,20,39,51,55,43,52,39,38},62),
Content = _d({27,49,55,226,47,55,53,54,226,53,39,46,39,37,54,226,35,226,36,49,53,53,226,40,43,52,53,54,226,36,39,40,49,52,39,226,39,48,35,36,46,43,48,41,226,3,55,54,49,226,28,226,14,49,49,50,227},62),
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
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,3,55,54,49,226,28,226,14,49,49,50,252},62), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({14,49,49,50,226,6,39,46,35,59,226,234,21,39,37,49,48,38,53,235},62),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({5,35,47,39,52,35,226,10,39,43,41,42,54},62),
Range = {10, 60},
Increment = 1,
Suffix = _d({226,53,54,55,38,53},62),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({29,10,49,52,49,226,28,239,8,35,52,47,31,226,5,35,47,39,52,35,226,42,39,43,41,42,54,226,55,50,38,35,54,39,38,226,54,49,252},62), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({6,39,53,54,52,49,59,226,23,11},62),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()