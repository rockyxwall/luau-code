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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,22,37,61,42,45,41,48,40,243,49,37,45,50,243,55,51,57,54,39,41,242,48,57,37},60)
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
error(_d({31,7,51,49,52,37,39,56,228,12,57,38,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,22,37,61,42,45,41,48,40,228,25,13,228,16,45,38,54,37,54,61,242},60))
end
local Window = Rayfield:CreateWindow({
Name = _d({12,51,54,51,228,12,51,54,51,228,30,241,10,37,54,49},60),
LoadingTitle = _d({16,51,37,40,45,50,43,228,12,51,54,51,228,30,228,16,51,51,52,242,242,242},60),
LoadingSubtitle = _d({19,52,56,45,49,45,62,41,40},60),
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
local MainTab = Window:CreateTab(_d({5,57,56,51,228,10,37,54,49},60), 4483362458)
local SkillTab = Window:CreateTab(_d({23,47,45,48,48,228,23,41,56,56,45,50,43,55},60), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
local stam = stats and stats:FindFirstChild(_d({23,56,37,49,45,50,37},60))
local maxStam = stats and stats:FindFirstChild(_d({17,37,60,23,56,37,49,45,50,37},60))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({12,51,54,51,241,12,51,54,51},60)) or (bp and bp:FindFirstChild(_d({12,51,54,51,241,12,51,54,51},60)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({18,20,7,55},60))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local hum = boss:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({12,51,54,51,7,37,49,41,54,37,16,51,39,47},60)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,7,48,41,37,50,41,40,228,57,52,228,52,54,41,58,45,51,57,55,228,55,41,55,55,45,51,50,242},60))
end
task.spawn(function()
while autoZLoop ~= nil do
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,27,37,45,56,45,50,43,228,42,51,54,228,6,51,55,55,228,23,52,37,59,50},60)) end
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,6,51,55,55},60), selectedBoss, _d({45,55,228,50,51,56,228,55,52,37,59,50,41,40,242,228,27,37,45,56,45,50,43},60), checkSpawnInterval, _d({55,41,39,51,50,40,55,242,242,242},60))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,17,45,55,55,45,50,43,228,12,51,54,51,228,24,51,51,48},60)) end
warn(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,235,12,51,54,51,241,12,51,54,51,235,228,56,51,51,48,228,50,51,56,228,42,51,57,50,40,228,45,50,228,38,37,39,47,52,37,39,47,228,51,54,228,39,44,37,54,37,39,56,41,54,229},60))
task.wait(2)
else
local stamPct = getStaminaPercent()
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,20,37,57,55,41,40,228,236,16,51,59,228,23,56,37,49,45,50,37,228,0,228,245,244,244,237},60)) end
task.wait(2)
else
local useE, useZ, useC, useR
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,16,51,59,228,23,56,37,49,45,50,37,228,7,51,49,38,51},60)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,12,45,43,44,228,23,56,37,49,45,50,37,228,7,51,49,38,51},60)) end
useE, useZ, useC, useR = highUseE, highUseZ, highUseC, highUseR
end
lockCameraToBoss(targetRoot)
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
local screenPos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,10,45,54,41,40,228,7,228,236,15,37,49,45,47,37,62,41,237},60))
end
elseif useZ then
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
hollowsAttached = true
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,10,45,54,41,40,228,30,228,236,17,45,50,45,228,6,37,54,54,37,43,41,237},60))
end
end
end
if useE then
local currentTarget = getBossPart(selectedBoss)
if currentTarget then
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,10,45,54,41,40,228,9,228,236,23,56,57,50,237},60))
end
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,10,45,54,41,40,228,22,228,236,8,41,56,51,50,37,56,45,51,50,237},60))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,23,48,41,41,52,45,50,43,228,236},60) .. string.format(_d({233,242,245,42},60), finalSleep) .. _d({55,237},60)) end
task.wait(finalSleep)
end
end
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({23,56,37,56,57,55,254,228,13,40,48,41},60))
MainTab:CreateDropdown({
Name = _d({23,41,48,41,39,56,228,6,51,55,55},60),
Options = {_d({5,60,41,228,12,37,50,40,228,16,51,43,37,50},60), _d({6,37,50,40,45,56,228,6,51,55,55},60), _d({14,57,62,51,228,56,44,41,228,8,45,37,49,51,50,40,38,37,39,47},60)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,23,41,48,41,39,56,41,40,228,56,37,54,43,41,56,254},60), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({23,56,37,54,56,228,5,57,56,51,228,10,37,54,49},60),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({23,41,48,41,39,56,228,6,51,55,55,228,22,41,53,57,45,54,41,40},60),
Content = _d({29,51,57,228,49,57,55,56,228,55,41,48,41,39,56,228,37,228,38,51,55,55,228,42,45,54,55,56,228,38,41,42,51,54,41,228,41,50,37,38,48,45,50,43,228,5,57,56,51,228,10,37,54,49,229},60),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({23,56,37,56,57,55,254,228,13,40,48,41},60)) end
end
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,5,57,56,51,228,10,37,54,49,254},60), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({7,37,49,41,54,37,228,12,41,45,43,44,56},60),
Range = {10, 60},
Increment = 1,
Suffix = _d({228,55,56,57,40,55},60),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,7,37,49,41,54,37,228,44,41,45,43,44,56,228,57,52,40,37,56,41,40,228,56,51,254},60), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({8,41,55,56,54,51,61,228,25,13},60),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({23,56,37,49,45,50,37,228,24,44,54,41,55,44,51,48,40,228,233},60),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,23,56,37,49,45,50,37,228,24,44,54,41,55,44,51,48,40,228,55,41,56,228,56,51,254},60), stamThreshold)
else
stamThreshold = 30
print(_d({31,12,51,54,51,228,30,241,10,37,54,49,33,228,13,50,58,37,48,45,40,228,56,44,54,41,55,44,51,48,40,228,45,50,52,57,56,242,228,8,41,42,37,57,48,56,45,50,43,228,56,51,228,247,244,233},60))
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
Name = _d({12,45,43,44,228,23,56,37,49,254,228,25,55,41,228,9,228,236,23,56,57,50,237},60),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({12,45,43,44,228,23,56,37,49,254,228,25,55,41,228,30,228,236,17,45,50,45,237},60),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({12,45,43,44,228,23,56,37,49,254,228,25,55,41,228,7,228,236,15,37,49,45,47,37,62,41,237},60),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({12,45,43,44,228,23,56,37,49,254,228,25,55,41,228,22,228,236,23,50,37,52,237},60),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
end)()