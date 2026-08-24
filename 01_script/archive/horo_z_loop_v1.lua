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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({54,30,74,72,75,60,62,79,251,35,80,61,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,39,68,61,77,60,77,84,9},37))
end
local Window = Rayfield:CreateWindow({
Name = _d({35,74,77,74,251,35,74,77,74,251,53,8,33,60,77,72,251,81,12},37),
LoadingTitle = _d({39,74,60,63,68,73,66,251,35,74,77,74,251,53,251,39,74,74,75,9,9,9},37),
LoadingSubtitle = _d({42,75,79,68,72,68,85,64,63},37),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({28,80,79,74,251,33,60,77,72},37), 4483362458)
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)) or (bp and bp:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = boss:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({35,74,77,74,30,60,72,64,77,60,39,74,62,70},37)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
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
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,29,74,78,78},37), selectedBoss, _d({68,78,251,73,74,79,251,78,75,60,82,73,64,63,9,251,50,60,68,79,68,73,66},37), checkSpawnInterval, _d({78,64,62,74,73,63,78,9,9,9},37))
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
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,35,74,81,64,77,64,63,251,60,73,63,251,65,68,77,64,63,251,53,251,60,79},37), selectedBoss)
else
warn(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,33,60,68,71,64,63,251,79,74,251,75,77,74,69,64,62,79,251,79,60,77,66,64,79,251,79,74,251,81,68,64,82,75,74,77,79,9},37))
end
else
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,47,60,77,66,64,79,251,71,74,78,79,251,74,77,251,63,68,64,63,251,63,80,77,68,73,66,251,63,64,71,60,84,9},37))
end
end
else
warn(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,2,35,74,77,74,8,35,74,77,74,2,251,79,74,74,71,251,73,74,79,251,65,74,80,73,63,251,68,73,251,61,60,62,70,75,60,62,70,251,74,77,251,62,67,60,77,60,62,79,64,77,252},37))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({46,64,71,64,62,79,251,29,74,78,78},37),
Options = {_d({28,83,64,251,35,60,73,63,251,39,74,66,60,73},37), _d({29,60,73,63,68,79,251,29,74,78,78},37), _d({37,80,85,74,251,79,67,64,251,31,68,60,72,74,73,63,61,60,62,70},37)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,46,64,71,64,62,79,64,63,251,79,60,77,66,64,79,21},37), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({28,80,79,74,251,53,251,39,74,74,75},37),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({46,64,71,64,62,79,251,29,74,78,78,251,45,64,76,80,68,77,64,63},37),
Content = _d({52,74,80,251,72,80,78,79,251,78,64,71,64,62,79,251,60,251,61,74,78,78,251,65,68,77,78,79,251,61,64,65,74,77,64,251,64,73,60,61,71,68,73,66,251,28,80,79,74,251,53,251,39,74,74,75,252},37),
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
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,28,80,79,74,251,53,251,39,74,74,75,21},37), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({39,74,74,75,251,31,64,71,60,84,251,3,46,64,62,74,73,63,78,4},37),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({30,60,72,64,77,60,251,35,64,68,66,67,79},37),
Range = {10, 60},
Increment = 1,
Suffix = _d({251,78,79,80,63,78},37),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,30,60,72,64,77,60,251,67,64,68,66,67,79,251,80,75,63,60,79,64,63,251,79,74,21},37), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,48,36},37),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()