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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,30,52,61,52,64,62,30,58,49,63,66,44,61,48,23,63,47,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48,249,55,64,44},53),
_d({51,63,63,59,62,5,250,250,62,52,61,52,64,62,249,56,48,57,64,250,61,44,68,49,52,48,55,47},53),
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,62,51,55,48,67,66,44,61,48,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48},53)
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
error(_d({38,14,58,56,59,44,46,63,235,19,64,45,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,29,44,68,49,52,48,55,47,235,32,20,235,23,52,45,61,44,61,68,249},53))
end
local Window = Rayfield:CreateWindow({
Name = _d({19,58,61,58,235,19,58,61,58,235,37,248,17,44,61,56},53),
LoadingTitle = _d({23,58,44,47,52,57,50,235,19,58,61,58,235,37,235,23,58,58,59,249,249,249},53),
LoadingSubtitle = _d({26,59,63,52,56,52,69,48,47},53),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({12,64,63,58,235,17,44,61,56},53), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({19,58,61,58,248,19,58,61,58},53)) or (bp and bp:FindFirstChild(_d({19,58,61,58,248,19,58,61,58},53)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({25,27,14,62},53))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local hum = boss:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({19,58,61,58,14,44,56,48,61,44,23,58,46,54},53)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health > 0 then
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
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,14,55,48,44,57,48,47,235,64,59,235,59,61,48,65,52,58,64,62,235,62,48,62,62,52,58,57,249},53))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,13,58,62,62},53), selectedBoss, _d({52,62,235,57,58,63,235,62,59,44,66,57,48,47,249,235,34,44,52,63,52,57,50},53), checkSpawnInterval, _d({62,48,46,58,57,47,62,249,249,249},53))
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
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,19,58,65,48,61,48,47,235,44,57,47,235,49,52,61,48,47,235,37,235,44,63},53), selectedBoss)
else
warn(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,17,44,52,55,48,47,235,63,58,235,59,61,58,53,48,46,63,235,63,44,61,50,48,63,235,63,58,235,65,52,48,66,59,58,61,63,249},53))
end
else
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,31,44,61,50,48,63,235,55,58,62,63,235,58,61,235,47,52,48,47,235,47,64,61,52,57,50,235,47,48,55,44,68,249},53))
end
end
else
warn(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,242,19,58,61,58,248,19,58,61,58,242,235,63,58,58,55,235,57,58,63,235,49,58,64,57,47,235,52,57,235,45,44,46,54,59,44,46,54,235,58,61,235,46,51,44,61,44,46,63,48,61,236},53))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({30,48,55,48,46,63,235,13,58,62,62},53),
Options = {_d({12,67,48,235,19,44,57,47,235,23,58,50,44,57},53), _d({13,44,57,47,52,63,235,13,58,62,62},53)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,30,48,55,48,46,63,48,47,235,63,44,61,50,48,63,5},53), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({12,64,63,58,235,37,235,23,58,58,59},53),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({30,48,55,48,46,63,235,13,58,62,62,235,29,48,60,64,52,61,48,47},53),
Content = _d({36,58,64,235,56,64,62,63,235,62,48,55,48,46,63,235,44,235,45,58,62,62,235,49,52,61,62,63,235,45,48,49,58,61,48,235,48,57,44,45,55,52,57,50,235,12,64,63,58,235,37,235,23,58,58,59,236},53),
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
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,12,64,63,58,235,37,235,23,58,58,59,5},53), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({23,58,58,59,235,15,48,55,44,68,235,243,30,48,46,58,57,47,62,244},53),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({14,44,56,48,61,44,235,19,48,52,50,51,63},53),
Range = {10, 60},
Increment = 1,
Suffix = _d({235,62,63,64,47,62},53),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({38,19,58,61,58,235,37,248,17,44,61,56,40,235,14,44,56,48,61,44,235,51,48,52,50,51,63,235,64,59,47,44,63,48,47,235,63,58,5},53), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({15,48,62,63,61,58,68,235,32,20},53),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()