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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,36,58,67,58,70,68,36,64,55,69,72,50,67,54,29,69,53,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54,255,61,70,50},47),
_d({57,69,69,65,68,11,0,0,68,58,67,58,70,68,255,62,54,63,70,0,67,50,74,55,58,54,61,53},47),
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,68,57,61,54,73,72,50,67,54,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54},47)
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
error(_d({44,20,64,62,65,50,52,69,241,25,70,51,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,35,50,74,55,58,54,61,53,241,38,26,241,29,58,51,67,50,67,74,255},47))
end
local Window = Rayfield:CreateWindow({
Name = _d({25,64,67,64,241,25,64,67,64,241,43,254,23,50,67,62},47),
LoadingTitle = _d({29,64,50,53,58,63,56,241,25,64,67,64,241,43,241,29,64,64,65,255,255,255},47),
LoadingSubtitle = _d({32,65,69,58,62,58,75,54,53},47),
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
local useAggroRecovery = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local lastT = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({18,70,69,64,241,23,50,67,62},47), 4483362458)
local SkillTab = Window:CreateTab(_d({36,60,58,61,61,241,36,54,69,69,58,63,56,68},47), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({36,69,50,69,68},47))
local stam = stats and stats:FindFirstChild(_d({36,69,50,62,58,63,50},47))
local maxStam = stats and stats:FindFirstChild(_d({30,50,73,36,69,50,62,58,63,50},47))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)) or (bp and bp:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({31,33,20,68},47))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = boss:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({25,64,67,64,20,50,62,54,67,50,29,64,52,60},47)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 then
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
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,20,61,54,50,63,54,53,241,70,65,241,65,67,54,71,58,64,70,68,241,68,54,68,68,58,64,63,255},47))
end
local lastBossHealth = 0
local lastBossHealthTime = tick()
task.spawn(function()
while autoZLoop ~= nil do
task.wait(0.1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,40,50,58,69,58,63,56,241,55,64,67,241,19,64,68,68,241,36,65,50,72,63},47)) end
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,19,64,68,68},47), selectedBoss, _d({58,68,241,63,64,69,241,68,65,50,72,63,54,53,255,241,40,50,58,69,58,63,56},47), checkSpawnInterval, _d({68,54,52,64,63,53,68,255,255,255},47))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,30,58,68,68,58,63,56,241,25,64,67,64,241,37,64,64,61},47)) end
warn(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,248,25,64,67,64,254,25,64,67,64,248,241,69,64,64,61,241,63,64,69,241,55,64,70,63,53,241,58,63,241,51,50,52,60,65,50,52,60,241,64,67,241,52,57,50,67,50,52,69,54,67,242},47))
task.wait(1)
else
local bossHum = targetRoot.Parent:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
local bossHealth = bossHum and bossHum.Health or 0
if bossHealth ~= lastBossHealth then
lastBossHealth = bossHealth
lastBossHealthTime = tick()
end
if useAggroRecovery and (tick() - lastBossHealthTime > 15) and (tick() - lastT >= 18) then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,18,56,56,67,64,241,35,54,52,64,71,54,67,74,241,249,37,254,36,69,50,69,54,250},47)) end
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,19,64,68,68,241,57,50,68,63,248,69,241,69,50,60,54,63,241,53,50,62,50,56,54,241,55,64,67,241,2,6,68,255,241,18,52,69,58,71,50,69,58,63,56,241,36,64,70,61,241,55,64,67,62,241,55,64,67,241,50,56,56,67,64,255,255,255},47))
VIM:SendKeyEvent(true, Enum.KeyCode.T, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.T, false, game)
lastT = tick()
task.wait(0.5)
local soulStart = tick()
while autoZLoop and (tick() - soulStart < 14) do
local currentTarget = getBossPart(selectedBoss)
local root = getRoot()
if currentTarget and root then
lockCameraToBoss(currentTarget)
root.CFrame = currentTarget.CFrame + Vector3.new(0, 8, 0)
if tick() - lastE >= 17 then
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,36,64,70,61,241,55,64,67,62,241,52,50,68,69,54,53,241,22,241,69,64,241,53,67,50,72,241,50,56,56,67,64},47))
break
end
end
end
task.wait(0.1)
end
while tick() - soulStart < 15.5 do
task.wait(0.1)
end
lastBossHealthTime = tick()
unlockCamera()
else
lockCameraToBoss(targetRoot)
local stamPct = getStaminaPercent()
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,33,50,70,68,54,53,241,249,29,64,72,241,36,69,50,62,58,63,50,241,13,241,2,1,1,250},47)) end
task.wait(1)
else
local useE, useZ, useC, useR
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,29,64,72,241,36,69,50,62,58,63,50,241,30,64,53,54},47)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,25,58,56,57,241,36,69,50,62,58,63,50,241,30,64,53,54},47)) end
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
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,58,67,54,53,241,20,241,249,28,50,62,58,60,50,75,54,250},47))
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
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,58,67,54,53,241,43,241,249,30,58,63,58,241,19,50,67,67,50,56,54,250},47))
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
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,58,67,54,53,241,22,241,249,36,69,70,63,250},47))
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
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,58,67,54,53,241,35,241,249,21,54,69,64,63,50,69,58,64,63,250},47))
end
end
end
end
end
end
else
unlockCamera()
end
end
end)
statusLabel = MainTab:CreateLabel(_d({36,69,50,69,70,68,11,241,26,53,61,54},47))
MainTab:CreateDropdown({
Name = _d({36,54,61,54,52,69,241,19,64,68,68},47),
Options = {_d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47), _d({19,50,63,53,58,69,241,19,64,68,68},47), _d({27,70,75,64,241,69,57,54,241,21,58,50,62,64,63,53,51,50,52,60},47)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,36,54,61,54,52,69,54,53,241,69,50,67,56,54,69,11},47), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({36,69,50,67,69,241,18,70,69,64,241,23,50,67,62},47),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({36,54,61,54,52,69,241,19,64,68,68,241,35,54,66,70,58,67,54,53},47),
Content = _d({42,64,70,241,62,70,68,69,241,68,54,61,54,52,69,241,50,241,51,64,68,68,241,55,58,67,68,69,241,51,54,55,64,67,54,241,54,63,50,51,61,58,63,56,241,18,70,69,64,241,23,50,67,62,242},47),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,26,53,61,54},47)) end
end
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,18,70,69,64,241,23,50,67,62,11},47), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({20,50,62,54,67,50,241,25,54,58,56,57,69},47),
Range = {10, 60},
Increment = 1,
Suffix = _d({241,68,69,70,53,68},47),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,20,50,62,54,67,50,241,57,54,58,56,57,69,241,70,65,53,50,69,54,53,241,69,64,11},47), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,38,26},47),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({36,69,50,62,58,63,50,241,37,57,67,54,68,57,64,61,53,241,246},47),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,36,69,50,62,58,63,50,241,37,57,67,54,68,57,64,61,53,241,68,54,69,241,69,64,11},47), stamThreshold)
else
stamThreshold = 30
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,26,63,71,50,61,58,53,241,69,57,67,54,68,57,64,61,53,241,58,63,65,70,69,255,241,21,54,55,50,70,61,69,58,63,56,241,69,64,241,4,1,246},47))
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
Name = _d({25,58,56,57,241,36,69,50,62,11,241,38,68,54,241,22,241,249,36,69,70,63,250},47),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({25,58,56,57,241,36,69,50,62,11,241,38,68,54,241,43,241,249,30,58,63,58,250},47),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({25,58,56,57,241,36,69,50,62,11,241,38,68,54,241,20,241,249,28,50,62,58,60,50,75,54,250},47),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({25,58,56,57,241,36,69,50,62,11,241,38,68,54,241,35,241,249,36,63,50,65,250},47),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Use Aggro Recovery (Soul T)",
CurrentValue = true,
Callback = function(Value) useAggroRecovery = Value end,
})
end)()