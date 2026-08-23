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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,26,41,65,46,49,45,52,44,247,53,41,49,54,247,59,55,61,58,43,45,246,52,61,41},56)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
error(_d({35,11,55,53,56,41,43,60,232,16,61,42,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,26,41,65,46,49,45,52,44,232,29,17,232,20,49,42,58,41,58,65,246},56))
end
local Window = Rayfield:CreateWindow({
Name = _d({16,55,58,55,232,16,55,58,55,232,34,245,14,41,58,53,232,62,249},56),
LoadingTitle = _d({20,55,41,44,49,54,47,232,16,55,58,55,232,34,232,20,55,55,56,246,246,246},56),
LoadingSubtitle = _d({23,56,60,49,53,49,66,45,44},56),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({9,61,60,55,232,14,41,58,53},56), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)) or (bp and bp:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({22,24,11,59},56))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hum = boss:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({16,55,58,55,11,41,53,45,58,41,20,55,43,51},56)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)).Health > 0 then
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
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,11,52,45,41,54,45,44,232,61,56,232,56,58,45,62,49,55,61,59,232,59,45,59,59,49,55,54,246},56))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,10,55,59,59},56), selectedBoss, _d({49,59,232,54,55,60,232,59,56,41,63,54,45,44,246,232,31,41,49,60,49,54,47},56), checkSpawnInterval, _d({59,45,43,55,54,44,59,246,246,246},56))
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
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,16,55,62,45,58,45,44,232,41,54,44,232,46,49,58,45,44,232,34,232,41,60},56), selectedBoss)
else
warn(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,14,41,49,52,45,44,232,60,55,232,56,58,55,50,45,43,60,232,60,41,58,47,45,60,232,60,55,232,62,49,45,63,56,55,58,60,246},56))
end
else
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,28,41,58,47,45,60,232,52,55,59,60,232,55,58,232,44,49,45,44,232,44,61,58,49,54,47,232,44,45,52,41,65,246},56))
end
end
else
warn(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,239,16,55,58,55,245,16,55,58,55,239,232,60,55,55,52,232,54,55,60,232,46,55,61,54,44,232,49,54,232,42,41,43,51,56,41,43,51,232,55,58,232,43,48,41,58,41,43,60,45,58,233},56))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({27,45,52,45,43,60,232,10,55,59,59},56),
Options = {_d({9,64,45,232,16,41,54,44,232,20,55,47,41,54},56), _d({10,41,54,44,49,60,232,10,55,59,59},56), _d({18,61,66,55,232,60,48,45,232,12,49,41,53,55,54,44,42,41,43,51},56)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,27,45,52,45,43,60,45,44,232,60,41,58,47,45,60,2},56), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({9,61,60,55,232,34,232,20,55,55,56},56),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({27,45,52,45,43,60,232,10,55,59,59,232,26,45,57,61,49,58,45,44},56),
Content = _d({33,55,61,232,53,61,59,60,232,59,45,52,45,43,60,232,41,232,42,55,59,59,232,46,49,58,59,60,232,42,45,46,55,58,45,232,45,54,41,42,52,49,54,47,232,9,61,60,55,232,34,232,20,55,55,56,233},56),
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
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,9,61,60,55,232,34,232,20,55,55,56,2},56), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({20,55,55,56,232,12,45,52,41,65,232,240,27,45,43,55,54,44,59,241},56),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({11,41,53,45,58,41,232,16,45,49,47,48,60},56),
Range = {10, 60},
Increment = 1,
Suffix = _d({232,59,60,61,44,59},56),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({35,16,55,58,55,232,34,245,14,41,58,53,37,232,11,41,53,45,58,41,232,48,45,49,47,48,60,232,61,56,44,41,60,45,44,232,60,55,2},56), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({12,45,59,60,58,55,65,232,29,17},56),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()