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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,53,75,84,75,87,85,53,81,72,86,89,67,84,71,46,86,70,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71,16,78,87,67},30),
_d({74,86,86,82,85,28,17,17,85,75,84,75,87,85,16,79,71,80,87,17,84,67,91,72,75,71,78,70},30),
_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,85,74,78,71,90,89,67,84,71,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71},30)
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
error(_d({61,37,81,79,82,67,69,86,2,42,87,68,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,52,67,91,72,75,71,78,70,2,55,43,2,46,75,68,84,67,84,91,16},30))
end
local Window = Rayfield:CreateWindow({
Name = _d({42,81,84,81,2,42,81,84,81,2,60,15,40,67,84,79},30),
LoadingTitle = _d({46,81,67,70,75,80,73,2,42,81,84,81,2,60,2,46,81,81,82,16,16,16},30),
LoadingSubtitle = _d({49,82,86,75,79,75,92,71,70},30),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({35,87,86,81,2,40,67,84,79},30), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)) or (bp and bp:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({48,50,37,85},30))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum = boss:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({42,81,84,81,37,67,79,71,84,67,46,81,69,77},30)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)).Health > 0 then
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
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,37,78,71,67,80,71,70,2,87,82,2,82,84,71,88,75,81,87,85,2,85,71,85,85,75,81,80,16},30))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,36,81,85,85},30), selectedBoss, _d({75,85,2,80,81,86,2,85,82,67,89,80,71,70,16,2,57,67,75,86,75,80,73},30), checkSpawnInterval, _d({85,71,69,81,80,70,85,16,16,16},30))
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
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,42,81,88,71,84,71,70,2,67,80,70,2,72,75,84,71,70,2,60,2,67,86},30), selectedBoss)
else
warn(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,40,67,75,78,71,70,2,86,81,2,82,84,81,76,71,69,86,2,86,67,84,73,71,86,2,86,81,2,88,75,71,89,82,81,84,86,16},30))
end
else
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,54,67,84,73,71,86,2,78,81,85,86,2,81,84,2,70,75,71,70,2,70,87,84,75,80,73,2,70,71,78,67,91,16},30))
end
end
else
warn(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,9,42,81,84,81,15,42,81,84,81,9,2,86,81,81,78,2,80,81,86,2,72,81,87,80,70,2,75,80,2,68,67,69,77,82,67,69,77,2,81,84,2,69,74,67,84,67,69,86,71,84,3},30))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({53,71,78,71,69,86,2,36,81,85,85},30),
Options = {_d({35,90,71,2,42,67,80,70,2,46,81,73,67,80},30), _d({36,67,80,70,75,86,2,36,81,85,85},30)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,53,71,78,71,69,86,71,70,2,86,67,84,73,71,86,28},30), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({35,87,86,81,2,60,2,46,81,81,82},30),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({53,71,78,71,69,86,2,36,81,85,85,2,52,71,83,87,75,84,71,70},30),
Content = _d({59,81,87,2,79,87,85,86,2,85,71,78,71,69,86,2,67,2,68,81,85,85,2,72,75,84,85,86,2,68,71,72,81,84,71,2,71,80,67,68,78,75,80,73,2,35,87,86,81,2,60,2,46,81,81,82,3},30),
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
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,35,87,86,81,2,60,2,46,81,81,82,28},30), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({46,81,81,82,2,38,71,78,67,91,2,10,53,71,69,81,80,70,85,11},30),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({37,67,79,71,84,67,2,42,71,75,73,74,86},30),
Range = {10, 60},
Increment = 1,
Suffix = _d({2,85,86,87,70,85},30),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({61,42,81,84,81,2,60,15,40,67,84,79,63,2,37,67,79,71,84,67,2,74,71,75,73,74,86,2,87,82,70,67,86,71,70,2,86,81,28},30), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({38,71,85,86,84,81,91,2,55,43},30),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()