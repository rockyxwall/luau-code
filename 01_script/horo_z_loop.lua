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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,56,78,87,78,90,88,56,84,75,89,92,70,87,74,49,89,73,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74,19,81,90,70},27),
_d({77,89,89,85,88,31,20,20,88,78,87,78,90,88,19,82,74,83,90,20,87,70,94,75,78,74,81,73},27),
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,88,77,81,74,93,92,70,87,74,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74},27)
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
error(_d({64,40,84,82,85,70,72,89,5,45,90,71,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,55,70,94,75,78,74,81,73,5,58,46,5,49,78,71,87,70,87,94,19},27))
end
local Window = Rayfield:CreateWindow({
Name = _d({45,84,87,84,5,45,84,87,84,5,63,18,43,70,87,82},27),
LoadingTitle = _d({49,84,70,73,78,83,76,5,45,84,87,84,5,63,5,49,84,84,85,19,19,19},27),
LoadingSubtitle = _d({52,85,89,78,82,78,95,74,73},27),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({38,93,74,5,45,70,83,73,5,49,84,76,70,83},27)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({38,90,89,84,5,43,70,87,82},27), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)) or (bp and bp:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({51,53,40,88},27))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum = boss:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({45,84,87,84,40,70,82,74,87,70,49,84,72,80},27)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 then
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = CFrame.lookAt(targetRoot.Position + Vector3.new(0, 30, 0), targetRoot.Position)
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
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,40,81,74,70,83,74,73,5,90,85,5,85,87,74,91,78,84,90,88,5,88,74,88,88,78,84,83,19},27))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,39,84,88,88},27), selectedBoss, _d({78,88,5,83,84,89,5,88,85,70,92,83,74,73,19,5,60,70,78,89,78,83,76},27), checkSpawnInterval, _d({88,74,72,84,83,73,88,19,19,19},27))
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
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,45,84,91,74,87,74,73,5,70,83,73,5,75,78,87,74,73,5,63,5,70,89},27), selectedBoss)
else
warn(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,43,70,78,81,74,73,5,89,84,5,85,87,84,79,74,72,89,5,89,70,87,76,74,89,5,89,84,5,91,78,74,92,85,84,87,89,19},27))
end
else
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,57,70,87,76,74,89,5,81,84,88,89,5,84,87,5,73,78,74,73,5,73,90,87,78,83,76,5,73,74,81,70,94,19},27))
end
end
else
warn(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,12,45,84,87,84,18,45,84,87,84,12,5,89,84,84,81,5,83,84,89,5,75,84,90,83,73,5,78,83,5,71,70,72,80,85,70,72,80,5,84,87,5,72,77,70,87,70,72,89,74,87,6},27))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({56,74,81,74,72,89,5,39,84,88,88},27),
Options = {_d({38,93,74,5,45,70,83,73,5,49,84,76,70,83},27)},
CurrentOption = _d({38,93,74,5,45,70,83,73,5,49,84,76,70,83},27),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,56,74,81,74,72,89,74,73,5,89,70,87,76,74,89,31},27), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({38,90,89,84,5,63,5,49,84,84,85},27),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
if not autoZLoop then
unlockCamera()
end
print(_d({64,45,84,87,84,5,63,18,43,70,87,82,66,5,38,90,89,84,5,63,5,49,84,84,85,31},27), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({49,84,84,85,5,41,74,81,70,94,5,13,56,74,72,84,83,73,88,14},27),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({41,74,88,89,87,84,94,5,58,46},27),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()