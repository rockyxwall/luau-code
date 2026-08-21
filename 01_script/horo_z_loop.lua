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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local VIM = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,54,76,85,76,88,86,54,82,73,87,90,68,85,72,47,87,71,18,53,68,92,73,76,72,79,71,18,80,68,76,81,18,86,82,88,85,70,72,17,79,88,68},29),
_d({75,87,87,83,86,29,18,18,86,76,85,76,88,86,17,80,72,81,88,18,85,68,92,73,76,72,79,71},29),
_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,86,75,79,72,91,90,68,85,72,18,53,68,92,73,76,72,79,71,18,80,68,76,81,18,86,82,88,85,70,72},29)
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
error(_d({62,38,82,80,83,68,70,87,3,43,88,69,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,53,68,92,73,76,72,79,71,3,56,44,3,47,76,69,85,68,85,92,17},29))
end
local Window = Rayfield:CreateWindow({
Name = _d({43,82,85,82,3,43,82,85,82,3,61,16,41,68,85,80},29),
LoadingTitle = _d({47,82,68,71,76,81,74,3,43,82,85,82,3,61,3,47,82,82,83,17,17,17},29),
LoadingSubtitle = _d({50,83,87,76,80,76,93,72,71},29),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({36,88,87,82,3,41,68,85,80},29), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({43,82,85,82,16,43,82,85,82},29)) or (bp and bp:FindFirstChild(_d({43,82,85,82,16,43,82,85,82},29)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local hum = boss:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({43,82,85,82,38,68,80,72,85,68,47,82,70,78},29)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 then
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
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,38,79,72,68,81,72,71,3,88,83,3,83,85,72,89,76,82,88,86,3,86,72,86,86,76,82,81,17},29))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,37,82,86,86},29), selectedBoss, _d({76,86,3,81,82,87,3,86,83,68,90,81,72,71,17,3,58,68,76,87,76,81,74},29), checkSpawnInterval, _d({86,72,70,82,81,71,86,17,17,17},29))
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
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,43,82,89,72,85,72,71,3,68,81,71,3,73,76,85,72,71,3,61,3,68,87},29), selectedBoss)
else
warn(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,41,68,76,79,72,71,3,87,82,3,83,85,82,77,72,70,87,3,87,68,85,74,72,87,3,87,82,3,89,76,72,90,83,82,85,87,17},29))
end
else
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,55,68,85,74,72,87,3,79,82,86,87,3,82,85,3,71,76,72,71,3,71,88,85,76,81,74,3,71,72,79,68,92,17},29))
end
end
else
warn(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,10,43,82,85,82,16,43,82,85,82,10,3,87,82,82,79,3,81,82,87,3,73,82,88,81,71,3,76,81,3,69,68,70,78,83,68,70,78,3,82,85,3,70,75,68,85,68,70,87,72,85,4},29))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({54,72,79,72,70,87,3,37,82,86,86},29),
Options = {_d({36,91,72,3,43,68,81,71,3,47,82,74,68,81},29), _d({37,68,81,71,76,87,3,37,82,86,86},29)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,54,72,79,72,70,87,72,71,3,87,68,85,74,72,87,29},29), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({36,88,87,82,3,61,3,47,82,82,83},29),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({54,72,79,72,70,87,3,37,82,86,86,3,53,72,84,88,76,85,72,71},29),
Content = _d({60,82,88,3,80,88,86,87,3,86,72,79,72,70,87,3,68,3,69,82,86,86,3,73,76,85,86,87,3,69,72,73,82,85,72,3,72,81,68,69,79,76,81,74,3,36,88,87,82,3,61,3,47,82,82,83,4},29),
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
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,36,88,87,82,3,61,3,47,82,82,83,29},29), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({47,82,82,83,3,39,72,79,68,92,3,11,54,72,70,82,81,71,86,12},29),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({38,68,80,72,85,68,3,43,72,76,74,75,87},29),
Range = {10, 60},
Increment = 1,
Suffix = _d({3,86,87,88,71,86},29),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({62,43,82,85,82,3,61,16,41,68,85,80,64,3,38,68,80,72,85,68,3,75,72,76,74,75,87,3,88,83,71,68,87,72,71,3,87,82,29},29), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({39,72,86,87,85,82,92,3,56,44},29),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()