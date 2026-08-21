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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local RunService = game:GetService(_d({33,68,61,34,52,65,69,56,50,52},49))
local VIM = game:GetService(_d({37,56,65,67,68,48,59,24,61,63,68,67,28,48,61,48,54,52,65},49))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,34,56,65,56,68,66,34,62,53,67,70,48,65,52,27,67,51,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52,253,59,68,48},49),
_d({55,67,67,63,66,9,254,254,66,56,65,56,68,66,253,60,52,61,68,254,65,48,72,53,56,52,59,51},49),
_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,66,55,59,52,71,70,48,65,52,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52},49)
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
error(_d({42,18,62,60,63,48,50,67,239,23,68,49,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,33,48,72,53,56,52,59,51,239,36,24,239,27,56,49,65,48,65,72,253},49))
end
local Window = Rayfield:CreateWindow({
Name = _d({23,62,65,62,239,23,62,65,62,239,41,252,21,48,65,60},49),
LoadingTitle = _d({27,62,48,51,56,61,54,239,23,62,65,62,239,41,239,27,62,62,63,253,253,253},49),
LoadingSubtitle = _d({30,63,67,56,60,56,73,52,51},49),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({16,68,67,62,239,21,48,65,60},49), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({17,48,50,58,63,48,50,58},49))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({23,62,65,62,252,23,62,65,62},49)) or (bp and bp:FindFirstChild(_d({23,62,65,62,252,23,62,65,62},49)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({29,31,18,66},49))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
local hum = boss:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({23,62,65,62,18,48,60,52,65,48,27,62,50,58},49)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49)).Health > 0 then
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
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,18,59,52,48,61,52,51,239,68,63,239,63,65,52,69,56,62,68,66,239,66,52,66,66,56,62,61,253},49))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,17,62,66,66},49), selectedBoss, _d({56,66,239,61,62,67,239,66,63,48,70,61,52,51,253,239,38,48,56,67,56,61,54},49), checkSpawnInterval, _d({66,52,50,62,61,51,66,253,253,253},49))
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
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,23,62,69,52,65,52,51,239,48,61,51,239,53,56,65,52,51,239,41,239,48,67},49), selectedBoss)
else
warn(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,21,48,56,59,52,51,239,67,62,239,63,65,62,57,52,50,67,239,67,48,65,54,52,67,239,67,62,239,69,56,52,70,63,62,65,67,253},49))
end
else
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,35,48,65,54,52,67,239,59,62,66,67,239,62,65,239,51,56,52,51,239,51,68,65,56,61,54,239,51,52,59,48,72,253},49))
end
end
else
warn(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,246,23,62,65,62,252,23,62,65,62,246,239,67,62,62,59,239,61,62,67,239,53,62,68,61,51,239,56,61,239,49,48,50,58,63,48,50,58,239,62,65,239,50,55,48,65,48,50,67,52,65,240},49))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({34,52,59,52,50,67,239,17,62,66,66},49),
Options = {_d({16,71,52,239,23,48,61,51,239,27,62,54,48,61},49), _d({17,48,61,51,56,67,239,17,62,66,66},49)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,34,52,59,52,50,67,52,51,239,67,48,65,54,52,67,9},49), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({16,68,67,62,239,41,239,27,62,62,63},49),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({34,52,59,52,50,67,239,17,62,66,66,239,33,52,64,68,56,65,52,51},49),
Content = _d({40,62,68,239,60,68,66,67,239,66,52,59,52,50,67,239,48,239,49,62,66,66,239,53,56,65,66,67,239,49,52,53,62,65,52,239,52,61,48,49,59,56,61,54,239,16,68,67,62,239,41,239,27,62,62,63,240},49),
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
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,16,68,67,62,239,41,239,27,62,62,63,9},49), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({27,62,62,63,239,19,52,59,48,72,239,247,34,52,50,62,61,51,66,248},49),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({18,48,60,52,65,48,239,23,52,56,54,55,67},49),
Range = {10, 60},
Increment = 1,
Suffix = _d({239,66,67,68,51,66},49),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({42,23,62,65,62,239,41,252,21,48,65,60,44,239,18,48,60,52,65,48,239,55,52,56,54,55,67,239,68,63,51,48,67,52,51,239,67,62,9},49), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({19,52,66,67,65,62,72,239,36,24},49),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()