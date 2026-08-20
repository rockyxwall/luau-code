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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local VIM = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,19,41,50,41,53,51,19,47,38,52,55,33,50,37,12,52,36,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37,238,44,53,33},64),
_d({40,52,52,48,51,250,239,239,51,41,50,41,53,51,238,45,37,46,53,239,50,33,57,38,41,37,44,36},64),
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,51,40,44,37,56,55,33,50,37,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37},64)
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
error(_d({27,3,47,45,48,33,35,52,224,8,53,34,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,18,33,57,38,41,37,44,36,224,21,9,224,12,41,34,50,33,50,57,238},64))
end
local Window = Rayfield:CreateWindow({
Name = _d({8,47,50,47,224,8,47,50,47,224,26,237,6,33,50,45},64),
LoadingTitle = _d({12,47,33,36,41,46,39,224,8,47,50,47,224,26,224,12,47,47,48,238,238,238},64),
LoadingSubtitle = _d({15,48,52,41,45,41,58,37,36},64),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({1,56,37,224,8,33,46,36,224,12,47,39,33,46},64)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({1,53,52,47,224,6,33,50,45},64), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({8,47,50,47,237,8,47,50,47},64)) or (bp and bp:FindFirstChild(_d({8,47,50,47,237,8,47,50,47},64)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({14,16,3,51},64))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local hum = boss:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({8,47,50,47,3,33,45,37,50,33,12,47,35,43},64)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)).Health > 0 then
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
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,3,44,37,33,46,37,36,224,53,48,224,48,50,37,54,41,47,53,51,224,51,37,51,51,41,47,46,238},64))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,2,47,51,51},64), selectedBoss, _d({41,51,224,46,47,52,224,51,48,33,55,46,37,36,238,224,23,33,41,52,41,46,39},64), checkSpawnInterval, _d({51,37,35,47,46,36,51,238,238,238},64))
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
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,8,47,54,37,50,37,36,224,33,46,36,224,38,41,50,37,36,224,26,224,33,52},64), selectedBoss)
else
warn(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,6,33,41,44,37,36,224,52,47,224,48,50,47,42,37,35,52,224,52,33,50,39,37,52,224,52,47,224,54,41,37,55,48,47,50,52,238},64))
end
else
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,20,33,50,39,37,52,224,44,47,51,52,224,47,50,224,36,41,37,36,224,36,53,50,41,46,39,224,36,37,44,33,57,238},64))
end
end
else
warn(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,231,8,47,50,47,237,8,47,50,47,231,224,52,47,47,44,224,46,47,52,224,38,47,53,46,36,224,41,46,224,34,33,35,43,48,33,35,43,224,47,50,224,35,40,33,50,33,35,52,37,50,225},64))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({19,37,44,37,35,52,224,2,47,51,51},64),
Options = {_d({1,56,37,224,8,33,46,36,224,12,47,39,33,46},64), _d({2,33,46,36,41,52,224,2,47,51,51},64)},
CurrentOption = _d({1,56,37,224,8,33,46,36,224,12,47,39,33,46},64),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,19,37,44,37,35,52,37,36,224,52,33,50,39,37,52,250},64), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({1,53,52,47,224,26,224,12,47,47,48},64),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,1,53,52,47,224,26,224,12,47,47,48,250},64), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({12,47,47,48,224,4,37,44,33,57,224,232,19,37,35,47,46,36,51,233},64),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({3,33,45,37,50,33,224,8,37,41,39,40,52},64),
Range = {10, 60},
Increment = 1,
Suffix = _d({224,51,52,53,36,51},64),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({27,8,47,50,47,224,26,237,6,33,50,45,29,224,3,33,45,37,50,33,224,40,37,41,39,40,52,224,53,48,36,33,52,37,36,224,52,47,250},64), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({4,37,51,52,50,47,57,224,21,9},64),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()