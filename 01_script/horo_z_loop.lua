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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,33,55,64,55,67,65,33,61,52,66,69,47,64,51,26,66,50,253,32,47,71,52,55,51,58,50,253,59,47,55,60,253,65,61,67,64,49,51,252,58,67,47},50),
_d({54,66,66,62,65,8,253,253,65,55,64,55,67,65,252,59,51,60,67,253,64,47,71,52,55,51,58,50},50),
_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,65,54,58,51,70,69,47,64,51,253,32,47,71,52,55,51,58,50,253,59,47,55,60,253,65,61,67,64,49,51},50)
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
error(_d({41,17,61,59,62,47,49,66,238,22,67,48,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,238,32,47,71,52,55,51,58,50,238,35,23,238,26,55,48,64,47,64,71,252},50))
end
local Window = Rayfield:CreateWindow({
Name = _d({22,61,64,61,238,22,61,64,61,238,40,251,20,47,64,59},50),
LoadingTitle = _d({26,61,47,50,55,60,53,238,22,61,64,61,238,40,238,26,61,61,62,252,252,252},50),
LoadingSubtitle = _d({29,62,66,55,59,55,72,51,50},50),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({15,67,66,61,238,20,47,64,59},50), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)) or (bp and bp:FindFirstChild(_d({22,61,64,61,251,22,61,64,61},50)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum = boss:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({22,61,64,61,17,47,59,51,64,47,26,61,49,57},50)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
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
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,17,58,51,47,60,51,50,238,67,62,238,62,64,51,68,55,61,67,65,238,65,51,65,65,55,61,60,252},50))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,16,61,65,65},50), selectedBoss, _d({55,65,238,60,61,66,238,65,62,47,69,60,51,50,252,238,37,47,55,66,55,60,53},50), checkSpawnInterval, _d({65,51,49,61,60,50,65,252,252,252},50))
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
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,22,61,68,51,64,51,50,238,47,60,50,238,52,55,64,51,50,238,40,238,47,66},50), selectedBoss)
else
warn(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,20,47,55,58,51,50,238,66,61,238,62,64,61,56,51,49,66,238,66,47,64,53,51,66,238,66,61,238,68,55,51,69,62,61,64,66,252},50))
end
else
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,34,47,64,53,51,66,238,58,61,65,66,238,61,64,238,50,55,51,50,238,50,67,64,55,60,53,238,50,51,58,47,71,252},50))
end
end
else
warn(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,245,22,61,64,61,251,22,61,64,61,245,238,66,61,61,58,238,60,61,66,238,52,61,67,60,50,238,55,60,238,48,47,49,57,62,47,49,57,238,61,64,238,49,54,47,64,47,49,66,51,64,239},50))
end
task.wait(loopDelay)
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({33,51,58,51,49,66,238,16,61,65,65},50),
Options = {_d({15,70,51,238,22,47,60,50,238,26,61,53,47,60},50), _d({16,47,60,50,55,66,238,16,61,65,65},50)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,33,51,58,51,49,66,51,50,238,66,47,64,53,51,66,8},50), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({15,67,66,61,238,40,238,26,61,61,62},50),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({33,51,58,51,49,66,238,16,61,65,65,238,32,51,63,67,55,64,51,50},50),
Content = _d({39,61,67,238,59,67,65,66,238,65,51,58,51,49,66,238,47,238,48,61,65,65,238,52,55,64,65,66,238,48,51,52,61,64,51,238,51,60,47,48,58,55,60,53,238,15,67,66,61,238,40,238,26,61,61,62,239},50),
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
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,15,67,66,61,238,40,238,26,61,61,62,8},50), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({26,61,61,62,238,18,51,58,47,71,238,246,33,51,49,61,60,50,65,247},50),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({17,47,59,51,64,47,238,22,51,55,53,54,66},50),
Range = {10, 60},
Increment = 1,
Suffix = _d({238,65,66,67,50,65},50),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({41,22,61,64,61,238,40,251,20,47,64,59,43,238,17,47,59,51,64,47,238,54,51,55,53,54,66,238,67,62,50,47,66,51,50,238,66,61,8},50), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({18,51,65,66,64,61,71,238,35,23},50),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()