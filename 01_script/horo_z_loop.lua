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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local VIM = game:GetService(_d({69,88,97,99,100,80,91,56,93,95,100,99,60,80,93,80,86,84,97},17))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,66,88,97,88,100,98,66,94,85,99,102,80,97,84,59,99,83,30,65,80,104,85,88,84,91,83,30,92,80,88,93,30,98,94,100,97,82,84,29,91,100,80},17),
_d({87,99,99,95,98,41,30,30,98,88,97,88,100,98,29,92,84,93,100,30,97,80,104,85,88,84,91,83},17),
_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,98,87,91,84,103,102,80,97,84,30,65,80,104,85,88,84,91,83,30,92,80,88,93,30,98,94,100,97,82,84},17)
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
error(_d({74,50,94,92,95,80,82,99,15,55,100,81,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,65,80,104,85,88,84,91,83,15,68,56,15,59,88,81,97,80,97,104,29},17))
end
local Window = Rayfield:CreateWindow({
Name = _d({55,94,97,94,15,55,94,97,94,15,73,28,53,80,97,92},17),
LoadingTitle = _d({59,94,80,83,88,93,86,15,55,94,97,94,15,73,15,59,94,94,95,29,29,29},17),
LoadingSubtitle = _d({62,95,99,88,92,88,105,84,83},17),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({48,100,99,94,15,53,80,97,92},17), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({49,80,82,90,95,80,82,90},17))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({55,94,97,94,28,55,94,97,94},17)) or (bp and bp:FindFirstChild(_d({55,94,97,94,28,55,94,97,94},17)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({61,63,50,98},17))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
local hum = boss:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({55,94,97,94,50,80,92,84,97,80,59,94,82,90},17)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)).Health > 0 then
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
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,50,91,84,80,93,84,83,15,100,95,15,95,97,84,101,88,94,100,98,15,98,84,98,98,88,94,93,29},17))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,49,94,98,98},17), selectedBoss, _d({88,98,15,93,94,99,15,98,95,80,102,93,84,83,29,15,70,80,88,99,88,93,86},17), checkSpawnInterval, _d({98,84,82,94,93,83,98,29,29,29},17))
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
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,55,94,101,84,97,84,83,15,80,93,83,15,85,88,97,84,83,15,73,15,80,99},17), selectedBoss)
else
warn(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,53,80,88,91,84,83,15,99,94,15,95,97,94,89,84,82,99,15,99,80,97,86,84,99,15,99,94,15,101,88,84,102,95,94,97,99,29},17))
end
else
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,67,80,97,86,84,99,15,91,94,98,99,15,94,97,15,83,88,84,83,15,83,100,97,88,93,86,15,83,84,91,80,104,29},17))
end
end
else
warn(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,22,55,94,97,94,28,55,94,97,94,22,15,99,94,94,91,15,93,94,99,15,85,94,100,93,83,15,88,93,15,81,80,82,90,95,80,82,90,15,94,97,15,82,87,80,97,80,82,99,84,97,16},17))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({66,84,91,84,82,99,15,49,94,98,98},17),
Options = {_d({48,103,84,15,55,80,93,83,15,59,94,86,80,93},17), _d({49,80,93,83,88,99,15,49,94,98,98},17)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,66,84,91,84,82,99,84,83,15,99,80,97,86,84,99,41},17), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({48,100,99,94,15,73,15,59,94,94,95},17),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({66,84,91,84,82,99,15,49,94,98,98,15,65,84,96,100,88,97,84,83},17),
Content = _d({72,94,100,15,92,100,98,99,15,98,84,91,84,82,99,15,80,15,81,94,98,98,15,85,88,97,98,99,15,81,84,85,94,97,84,15,84,93,80,81,91,88,93,86,15,48,100,99,94,15,73,15,59,94,94,95,16},17),
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
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,48,100,99,94,15,73,15,59,94,94,95,41},17), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({59,94,94,95,15,51,84,91,80,104,15,23,66,84,82,94,93,83,98,24},17),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({50,80,92,84,97,80,15,55,84,88,86,87,99},17),
Range = {10, 60},
Increment = 1,
Suffix = _d({15,98,99,100,83,98},17),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({74,55,94,97,94,15,73,28,53,80,97,92,76,15,50,80,92,84,97,80,15,87,84,88,86,87,99,15,100,95,83,80,99,84,83,15,99,94,41},17), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({51,84,98,99,97,94,104,15,68,56},17),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()