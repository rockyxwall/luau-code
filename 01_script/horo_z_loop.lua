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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,26,48,57,48,60,58,26,54,45,59,62,40,57,44,19,59,43,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44,245,51,60,40},57),
_d({47,59,59,55,58,1,246,246,58,48,57,48,60,58,245,52,44,53,60,246,57,40,64,45,48,44,51,43},57),
_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,58,47,51,44,63,62,40,57,44,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44},57)
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
error(_d({34,10,54,52,55,40,42,59,231,15,60,41,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,25,40,64,45,48,44,51,43,231,28,16,231,19,48,41,57,40,57,64,245},57))
end
local Window = Rayfield:CreateWindow({
Name = _d({15,54,57,54,231,15,54,57,54,231,33,244,13,40,57,52},57),
LoadingTitle = _d({19,54,40,43,48,53,46,231,15,54,57,54,231,33,231,19,54,54,55,245,245,245},57),
LoadingSubtitle = _d({22,55,59,48,52,48,65,44,43},57),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({8,63,44,231,15,40,53,43,231,19,54,46,40,53},57)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({8,60,59,54,231,13,40,57,52},57), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({15,54,57,54,244,15,54,57,54},57)) or (bp and bp:FindFirstChild(_d({15,54,57,54,244,15,54,57,54},57)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({21,23,10,58},57))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum = boss:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({15,54,57,54,10,40,52,44,57,40,19,54,42,50},57)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
local myRoot = getRoot()
if myRoot and targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57)).Health > 0 then
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.lookAt(myRoot.Position + Vector3.new(0, 40, 0), targetRoot.Position)
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
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,10,51,44,40,53,44,43,231,60,55,231,55,57,44,61,48,54,60,58,231,58,44,58,58,48,54,53,245},57))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,9,54,58,58},57), selectedBoss, _d({48,58,231,53,54,59,231,58,55,40,62,53,44,43,245,231,30,40,48,59,48,53,46},57), checkSpawnInterval, _d({58,44,42,54,53,43,58,245,245,245},57))
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
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,15,54,61,44,57,44,43,231,40,53,43,231,45,48,57,44,43,231,33,231,40,59},57), selectedBoss)
else
warn(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,13,40,48,51,44,43,231,59,54,231,55,57,54,49,44,42,59,231,59,40,57,46,44,59,231,59,54,231,61,48,44,62,55,54,57,59,245},57))
end
else
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,27,40,57,46,44,59,231,51,54,58,59,231,54,57,231,43,48,44,43,231,43,60,57,48,53,46,231,43,44,51,40,64,245},57))
end
end
else
warn(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,238,15,54,57,54,244,15,54,57,54,238,231,59,54,54,51,231,53,54,59,231,45,54,60,53,43,231,48,53,231,41,40,42,50,55,40,42,50,231,54,57,231,42,47,40,57,40,42,59,44,57,232},57))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({26,44,51,44,42,59,231,9,54,58,58},57),
Options = {_d({8,63,44,231,15,40,53,43,231,19,54,46,40,53},57)},
CurrentOption = _d({8,63,44,231,15,40,53,43,231,19,54,46,40,53},57),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,26,44,51,44,42,59,44,43,231,59,40,57,46,44,59,1},57), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({8,60,59,54,231,33,231,19,54,54,55},57),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({34,15,54,57,54,231,33,244,13,40,57,52,36,231,8,60,59,54,231,33,231,19,54,54,55,1},57), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({19,54,54,55,231,11,44,51,40,64,231,239,26,44,42,54,53,43,58,240},57),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({11,44,58,59,57,54,64,231,28,16},57),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()