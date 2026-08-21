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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86,31,93,102,82},15)
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
error(_d({76,52,96,94,97,82,84,101,17,57,102,83,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,67,82,106,87,90,86,93,85,17,70,58,17,61,90,83,99,82,99,106,31},15))
end
local Window = Rayfield:CreateWindow({
Name = _d({57,96,99,96,17,57,96,99,96,17,75,30,55,82,99,94},15),
LoadingTitle = _d({61,96,82,85,90,95,88,17,57,96,99,96,17,75,17,61,96,96,97,31,31,31},15),
LoadingSubtitle = _d({64,97,101,90,94,90,107,86,85},15),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local cameraHeight = 30.0
local checkSpawnInterval = 60
local stamThreshold = 30
local lowUseE = true
local lowUseZ = true
local lowUseC = false
local lowUseR = true
local highUseE = true
local highUseZ = true
local highUseC = true
local highUseR = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({50,102,101,96,17,55,82,99,94},15), 4483362458)
local SkillTab = Window:CreateTab(_d({68,92,90,93,93,17,68,86,101,101,90,95,88,100},15), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({68,101,82,101,100},15))
local stam = stats and stats:FindFirstChild(_d({68,101,82,94,90,95,82},15))
local maxStam = stats and stats:FindFirstChild(_d({62,82,105,68,101,82,94,90,95,82},15))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({57,96,99,96,30,57,96,99,96},15)) or (bp and bp:FindFirstChild(_d({57,96,99,96,30,57,96,99,96},15)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({63,65,52,100},15))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum = boss:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({57,96,99,96,52,82,94,86,99,82,61,96,84,92},15)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health > 0 then
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
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,52,93,86,82,95,86,85,17,102,97,17,97,99,86,103,90,96,102,100,17,100,86,100,100,90,96,95,31},15))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(0.1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,72,82,90,101,90,95,88,17,87,96,99,17,51,96,100,100,17,68,97,82,104,95},15)) end
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,51,96,100,100},15), selectedBoss, _d({90,100,17,95,96,101,17,100,97,82,104,95,86,85,31,17,72,82,90,101,90,95,88},15), checkSpawnInterval, _d({100,86,84,96,95,85,100,31,31,31},15))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,62,90,100,100,90,95,88,17,57,96,99,96,17,69,96,96,93},15)) end
warn(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,24,57,96,99,96,30,57,96,99,96,24,17,101,96,96,93,17,95,96,101,17,87,96,102,95,85,17,90,95,17,83,82,84,92,97,82,84,92,17,96,99,17,84,89,82,99,82,84,101,86,99,18},15))
task.wait(1)
else
lockCameraToBoss(targetRoot)
local stamPct = getStaminaPercent()
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,65,82,102,100,86,85,17,25,61,96,104,17,68,101,82,94,90,95,82,17,45,17,34,33,33,26},15)) end
task.wait(1)
else
local useE, useZ, useC, useR
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,61,96,104,17,68,101,82,94,90,95,82,17,62,96,85,86},15)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,57,90,88,89,17,68,101,82,94,90,95,82,17,62,96,85,86},15)) end
useE, useZ, useC, useR = highUseE, highUseZ, highUseC, highUseR
end
if useC and (tick() - lastC >= 60) then
local screenPos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,55,90,99,86,85,17,52,17,25,60,82,94,90,92,82,107,86,26},15))
end
elseif useZ and (tick() - lastZ >= 10) then
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
lastZ = tick()
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,55,90,99,86,85,17,75,17,25,62,90,95,90,17,51,82,99,99,82,88,86,26},15))
end
end
end
if useE and (tick() - lastE >= 17) then
local screenPos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,55,90,99,86,85,17,54,17,25,68,101,102,95,26},15))
end
end
if useR and (tick() - lastR >= 1) then
local timeSinceE = tick() - lastE
local timeSinceZ = tick() - lastZ
local timeSinceC = tick() - lastC
if timeSinceE >= 2 and timeSinceE <= 4 and (timeSinceZ < 6 or timeSinceC < 6) then
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,55,90,99,86,85,17,67,17,25,53,86,101,96,95,82,101,90,96,95,26},15))
end
end
end
end
end
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({68,101,82,101,102,100,43,17,58,85,93,86},15))
MainTab:CreateDropdown({
Name = _d({68,86,93,86,84,101,17,51,96,100,100},15),
Options = {_d({50,105,86,17,57,82,95,85,17,61,96,88,82,95},15), _d({51,82,95,85,90,101,17,51,96,100,100},15), _d({59,102,107,96,17,101,89,86,17,53,90,82,94,96,95,85,83,82,84,92},15)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,68,86,93,86,84,101,86,85,17,101,82,99,88,86,101,43},15), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({68,101,82,99,101,17,50,102,101,96,17,55,82,99,94},15),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({68,86,93,86,84,101,17,51,96,100,100,17,67,86,98,102,90,99,86,85},15),
Content = _d({74,96,102,17,94,102,100,101,17,100,86,93,86,84,101,17,82,17,83,96,100,100,17,87,90,99,100,101,17,83,86,87,96,99,86,17,86,95,82,83,93,90,95,88,17,50,102,101,96,17,55,82,99,94,18},15),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({68,101,82,101,102,100,43,17,58,85,93,86},15)) end
end
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,50,102,101,96,17,55,82,99,94,43},15), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({52,82,94,86,99,82,17,57,86,90,88,89,101},15),
Range = {10, 60},
Increment = 1,
Suffix = _d({17,100,101,102,85,100},15),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,52,82,94,86,99,82,17,89,86,90,88,89,101,17,102,97,85,82,101,86,85,17,101,96,43},15), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({53,86,100,101,99,96,106,17,70,58},15),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({68,101,82,94,90,95,82,17,69,89,99,86,100,89,96,93,85,17,22},15),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,68,101,82,94,90,95,82,17,69,89,99,86,100,89,96,93,85,17,100,86,101,17,101,96,43},15), stamThreshold)
else
stamThreshold = 30
print(_d({76,57,96,99,96,17,75,30,55,82,99,94,78,17,58,95,103,82,93,90,85,17,101,89,99,86,100,89,96,93,85,17,90,95,97,102,101,31,17,53,86,87,82,102,93,101,90,95,88,17,101,96,17,36,33,22},15))
end
end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Low Stam: Use E (Stun)",
CurrentValue = true,
Callback = function(Value) lowUseE = Value end,
})
SkillTab:CreateToggle({
Name = "Low Stam: Use Z (Mini)",
CurrentValue = true,
Callback = function(Value) lowUseZ = Value end,
})
SkillTab:CreateToggle({
Name = "Low Stam: Use C (Kamikaze)",
CurrentValue = false,
Callback = function(Value) lowUseC = Value end,
})
SkillTab:CreateToggle({
Name = "Low Stam: Use R (Snap)",
CurrentValue = true,
Callback = function(Value) lowUseR = Value end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = _d({57,90,88,89,17,68,101,82,94,43,17,70,100,86,17,54,17,25,68,101,102,95,26},15),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({57,90,88,89,17,68,101,82,94,43,17,70,100,86,17,75,17,25,62,90,95,90,26},15),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({57,90,88,89,17,68,101,82,94,43,17,70,100,86,17,52,17,25,60,82,94,90,92,82,107,86,26},15),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({57,90,88,89,17,68,101,82,94,43,17,70,100,86,17,67,17,25,68,95,82,97,26},15),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
end)()