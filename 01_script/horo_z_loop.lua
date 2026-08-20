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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,22,44,53,44,56,54,22,50,41,55,58,36,53,40,15,55,39,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40,241,47,56,36},61),
_d({43,55,55,51,54,253,242,242,54,44,53,44,56,54,241,48,40,49,56,242,53,36,60,41,44,40,47,39},61),
_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,54,43,47,40,59,58,36,53,40,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40},61)
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
error(_d({30,6,50,48,51,36,38,55,227,11,56,37,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,21,36,60,41,44,40,47,39,227,24,12,227,15,44,37,53,36,53,60,241},61))
end
local Window = Rayfield:CreateWindow({
Name = _d({11,50,53,50,227,11,50,53,50,227,29,240,9,36,53,48},61),
LoadingTitle = _d({15,50,36,39,44,49,42,227,11,50,53,50,227,29,227,15,50,50,51,241,241,241},61),
LoadingSubtitle = _d({18,51,55,44,48,44,61,40,39},61),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({4,59,40,227,11,36,49,39,227,15,50,42,36,49},61)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({4,56,55,50,227,9,36,53,48},61), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({11,50,53,50,240,11,50,53,50},61)) or (bp and bp:FindFirstChild(_d({11,50,53,50,240,11,50,53,50},61)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = boss:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraConnection = nil
local savedCameraCF = nil
local savedCameraType = nil
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if cameraConnection then
cameraConnection:Disconnect()
cameraConnection = nil
end
cameraConnection = RunService.RenderStepped:Connect(function()
local myRoot = getRoot()
if myRoot and targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.lookAt(myRoot.Position + Vector3.new(0, 40, 0), targetRoot.Position)
else
if cameraConnection then
cameraConnection:Disconnect()
cameraConnection = nil
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
end)
end
local function unlockCamera()
if cameraConnection then
cameraConnection:Disconnect()
cameraConnection = nil
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
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,6,47,40,36,49,40,39,227,56,51,227,51,53,40,57,44,50,56,54,227,54,40,54,54,44,50,49,241},61))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,5,50,54,54},61), selectedBoss, _d({44,54,227,49,50,55,227,54,51,36,58,49,40,39,241,227,26,36,44,55,44,49,42},61), checkSpawnInterval, _d({54,40,38,50,49,39,54,241,241,241},61))
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
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,11,50,57,40,53,40,39,227,36,49,39,227,41,44,53,40,39,227,29,227,36,55},61), selectedBoss)
else
warn(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,9,36,44,47,40,39,227,55,50,227,51,53,50,45,40,38,55,227,55,36,53,42,40,55,227,55,50,227,57,44,40,58,51,50,53,55,241},61))
end
else
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,23,36,53,42,40,55,227,47,50,54,55,227,50,53,227,39,44,40,39,227,39,56,53,44,49,42,227,39,40,47,36,60,241},61))
end
end
else
warn(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,234,11,50,53,50,240,11,50,53,50,234,227,55,50,50,47,227,49,50,55,227,41,50,56,49,39,227,44,49,227,37,36,38,46,51,36,38,46,227,50,53,227,38,43,36,53,36,38,55,40,53,228},61))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({22,40,47,40,38,55,227,5,50,54,54},61),
Options = {_d({4,59,40,227,11,36,49,39,227,15,50,42,36,49},61)},
CurrentOption = _d({4,59,40,227,11,36,49,39,227,15,50,42,36,49},61),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,22,40,47,40,38,55,40,39,227,55,36,53,42,40,55,253},61), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({4,56,55,50,227,29,227,15,50,50,51},61),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({30,11,50,53,50,227,29,240,9,36,53,48,32,227,4,56,55,50,227,29,227,15,50,50,51,253},61), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({15,50,50,51,227,7,40,47,36,60,227,235,22,40,38,50,49,39,54,236},61),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({7,40,54,55,53,50,60,227,24,12},61),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()