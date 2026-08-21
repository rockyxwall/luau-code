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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,46,61,85,66,69,65,72,64,11,73,61,69,74,11,79,75,81,78,63,65,10,72,81,61},36)
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
error(_d({55,31,75,73,76,61,63,80,252,36,81,62,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,46,61,85,66,69,65,72,64,252,49,37,252,40,69,62,78,61,78,85,10},36))
end
local Window = Rayfield:CreateWindow({
Name = _d({36,75,78,75,252,36,75,78,75,252,54,9,34,61,78,73},36),
LoadingTitle = _d({40,75,61,64,69,74,67,252,36,75,78,75,252,54,252,40,75,75,76,10,10,10},36),
LoadingSubtitle = _d({43,76,80,69,73,69,86,65,64},36),
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
local MainTab = Window:CreateTab(_d({29,81,80,75,252,34,61,78,73},36), 4483362458)
local SkillTab = Window:CreateTab(_d({47,71,69,72,72,252,47,65,80,80,69,74,67,79},36), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
local stam = stats and stats:FindFirstChild(_d({47,80,61,73,69,74,61},36))
local maxStam = stats and stats:FindFirstChild(_d({41,61,84,47,80,61,73,69,74,61},36))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({36,75,78,75,9,36,75,78,75},36)) or (bp and bp:FindFirstChild(_d({36,75,78,75,9,36,75,78,75},36)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({42,44,31,79},36))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum = boss:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({36,75,78,75,31,61,73,65,78,61,40,75,63,71},36)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 then
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
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,31,72,65,61,74,65,64,252,81,76,252,76,78,65,82,69,75,81,79,252,79,65,79,79,69,75,74,10},36))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(0.1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,51,61,69,80,69,74,67,252,66,75,78,252,30,75,79,79,252,47,76,61,83,74},36)) end
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,30,75,79,79},36), selectedBoss, _d({69,79,252,74,75,80,252,79,76,61,83,74,65,64,10,252,51,61,69,80,69,74,67},36), checkSpawnInterval, _d({79,65,63,75,74,64,79,10,10,10},36))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,41,69,79,79,69,74,67,252,36,75,78,75,252,48,75,75,72},36)) end
warn(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,3,36,75,78,75,9,36,75,78,75,3,252,80,75,75,72,252,74,75,80,252,66,75,81,74,64,252,69,74,252,62,61,63,71,76,61,63,71,252,75,78,252,63,68,61,78,61,63,80,65,78,253},36))
task.wait(1)
else
lockCameraToBoss(targetRoot)
local stamPct = getStaminaPercent()
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,44,61,81,79,65,64,252,4,40,75,83,252,47,80,61,73,69,74,61,252,24,252,13,12,12,5},36)) end
task.wait(1)
else
local useE, useZ, useC, useR
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,40,75,83,252,47,80,61,73,69,74,61,252,41,75,64,65},36)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,36,69,67,68,252,47,80,61,73,69,74,61,252,41,75,64,65},36)) end
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
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,34,69,78,65,64,252,31,252,4,39,61,73,69,71,61,86,65,5},36))
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
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,34,69,78,65,64,252,54,252,4,41,69,74,69,252,30,61,78,78,61,67,65,5},36))
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
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,34,69,78,65,64,252,33,252,4,47,80,81,74,5},36))
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
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,34,69,78,65,64,252,46,252,4,32,65,80,75,74,61,80,69,75,74,5},36))
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
statusLabel = MainTab:CreateLabel(_d({47,80,61,80,81,79,22,252,37,64,72,65},36))
MainTab:CreateDropdown({
Name = _d({47,65,72,65,63,80,252,30,75,79,79},36),
Options = {_d({29,84,65,252,36,61,74,64,252,40,75,67,61,74},36), _d({30,61,74,64,69,80,252,30,75,79,79},36), _d({38,81,86,75,252,80,68,65,252,32,69,61,73,75,74,64,62,61,63,71},36)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,47,65,72,65,63,80,65,64,252,80,61,78,67,65,80,22},36), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({47,80,61,78,80,252,29,81,80,75,252,34,61,78,73},36),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({47,65,72,65,63,80,252,30,75,79,79,252,46,65,77,81,69,78,65,64},36),
Content = _d({53,75,81,252,73,81,79,80,252,79,65,72,65,63,80,252,61,252,62,75,79,79,252,66,69,78,79,80,252,62,65,66,75,78,65,252,65,74,61,62,72,69,74,67,252,29,81,80,75,252,34,61,78,73,253},36),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({47,80,61,80,81,79,22,252,37,64,72,65},36)) end
end
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,29,81,80,75,252,34,61,78,73,22},36), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({31,61,73,65,78,61,252,36,65,69,67,68,80},36),
Range = {10, 60},
Increment = 1,
Suffix = _d({252,79,80,81,64,79},36),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,31,61,73,65,78,61,252,68,65,69,67,68,80,252,81,76,64,61,80,65,64,252,80,75,22},36), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({32,65,79,80,78,75,85,252,49,37},36),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({47,80,61,73,69,74,61,252,48,68,78,65,79,68,75,72,64,252,1},36),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,47,80,61,73,69,74,61,252,48,68,78,65,79,68,75,72,64,252,79,65,80,252,80,75,22},36), stamThreshold)
else
stamThreshold = 30
print(_d({55,36,75,78,75,252,54,9,34,61,78,73,57,252,37,74,82,61,72,69,64,252,80,68,78,65,79,68,75,72,64,252,69,74,76,81,80,10,252,32,65,66,61,81,72,80,69,74,67,252,80,75,252,15,12,1},36))
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
Name = _d({36,69,67,68,252,47,80,61,73,22,252,49,79,65,252,33,252,4,47,80,81,74,5},36),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({36,69,67,68,252,47,80,61,73,22,252,49,79,65,252,54,252,4,41,69,74,69,5},36),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({36,69,67,68,252,47,80,61,73,22,252,49,79,65,252,31,252,4,39,61,73,69,71,61,86,65,5},36),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({36,69,67,68,252,47,80,61,73,22,252,49,79,65,252,46,252,4,47,74,61,76,5},36),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
end)()