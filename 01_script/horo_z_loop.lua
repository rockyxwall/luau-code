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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local VIM = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,40,62,71,62,74,72,40,68,59,73,76,54,71,58,33,73,57,4,39,54,78,59,62,58,65,57,4,66,54,62,67,4,72,68,74,71,56,58,3,65,74,54},43),
_d({61,73,73,69,72,15,4,4,72,62,71,62,74,72,3,66,58,67,74,4,71,54,78,59,62,58,65,57},43),
_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,72,61,65,58,77,76,54,71,58,4,39,54,78,59,62,58,65,57,4,66,54,62,67,4,72,68,74,71,56,58},43)
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
error(_d({48,24,68,66,69,54,56,73,245,29,74,55,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,245,39,54,78,59,62,58,65,57,245,42,30,245,33,62,55,71,54,71,78,3},43))
end
local Window = Rayfield:CreateWindow({
Name = _d({29,68,71,68,245,29,68,71,68,245,47,2,27,54,71,66},43),
LoadingTitle = _d({33,68,54,57,62,67,60,245,29,68,71,68,245,47,245,33,68,68,69,3,3,3},43),
LoadingSubtitle = _d({36,69,73,62,66,62,79,58,57},43),
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
local MainTab = Window:CreateTab(_d({22,74,73,68,245,27,54,71,66},43), 4483362458)
local SkillTab = Window:CreateTab(_d({40,64,62,65,65,245,40,58,73,73,62,67,60,72},43), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({40,73,54,73,72},43))
local stam = stats and stats:FindFirstChild(_d({40,73,54,66,62,67,54},43))
local maxStam = stats and stats:FindFirstChild(_d({34,54,77,40,73,54,66,62,67,54},43))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({29,68,71,68,2,29,68,71,68},43)) or (bp and bp:FindFirstChild(_d({29,68,71,68,2,29,68,71,68},43)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({35,37,24,72},43))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hum = boss:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({29,68,71,68,24,54,66,58,71,54,33,68,56,64},43)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43)).Health > 0 then
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
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,24,65,58,54,67,58,57,245,74,69,245,69,71,58,75,62,68,74,72,245,72,58,72,72,62,68,67,3},43))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(0.1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,44,54,62,73,62,67,60,245,59,68,71,245,23,68,72,72,245,40,69,54,76,67},43)) end
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,23,68,72,72},43), selectedBoss, _d({62,72,245,67,68,73,245,72,69,54,76,67,58,57,3,245,44,54,62,73,62,67,60},43), checkSpawnInterval, _d({72,58,56,68,67,57,72,3,3,3},43))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,34,62,72,72,62,67,60,245,29,68,71,68,245,41,68,68,65},43)) end
warn(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,252,29,68,71,68,2,29,68,71,68,252,245,73,68,68,65,245,67,68,73,245,59,68,74,67,57,245,62,67,245,55,54,56,64,69,54,56,64,245,68,71,245,56,61,54,71,54,56,73,58,71,246},43))
task.wait(1)
else
lockCameraToBoss(targetRoot)
local stamPct = getStaminaPercent()
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,37,54,74,72,58,57,245,253,33,68,76,245,40,73,54,66,62,67,54,245,17,245,6,5,5,254},43)) end
task.wait(1)
else
local useE, useZ, useC, useR
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,33,68,76,245,40,73,54,66,62,67,54,245,34,68,57,58},43)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,29,62,60,61,245,40,73,54,66,62,67,54,245,34,68,57,58},43)) end
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
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,27,62,71,58,57,245,24,245,253,32,54,66,62,64,54,79,58,254},43))
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
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,27,62,71,58,57,245,47,245,253,34,62,67,62,245,23,54,71,71,54,60,58,254},43))
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
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,27,62,71,58,57,245,26,245,253,40,73,74,67,254},43))
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
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,27,62,71,58,57,245,39,245,253,25,58,73,68,67,54,73,62,68,67,254},43))
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
statusLabel = MainTab:CreateLabel(_d({40,73,54,73,74,72,15,245,30,57,65,58},43))
MainTab:CreateDropdown({
Name = _d({40,58,65,58,56,73,245,23,68,72,72},43),
Options = {_d({22,77,58,245,29,54,67,57,245,33,68,60,54,67},43), _d({23,54,67,57,62,73,245,23,68,72,72},43), _d({31,74,79,68,245,73,61,58,245,25,62,54,66,68,67,57,55,54,56,64},43)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,40,58,65,58,56,73,58,57,245,73,54,71,60,58,73,15},43), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({40,73,54,71,73,245,22,74,73,68,245,27,54,71,66},43),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({40,58,65,58,56,73,245,23,68,72,72,245,39,58,70,74,62,71,58,57},43),
Content = _d({46,68,74,245,66,74,72,73,245,72,58,65,58,56,73,245,54,245,55,68,72,72,245,59,62,71,72,73,245,55,58,59,68,71,58,245,58,67,54,55,65,62,67,60,245,22,74,73,68,245,27,54,71,66,246},43),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({40,73,54,73,74,72,15,245,30,57,65,58},43)) end
end
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,22,74,73,68,245,27,54,71,66,15},43), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({24,54,66,58,71,54,245,29,58,62,60,61,73},43),
Range = {10, 60},
Increment = 1,
Suffix = _d({245,72,73,74,57,72},43),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,24,54,66,58,71,54,245,61,58,62,60,61,73,245,74,69,57,54,73,58,57,245,73,68,15},43), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({25,58,72,73,71,68,78,245,42,30},43),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({40,73,54,66,62,67,54,245,41,61,71,58,72,61,68,65,57,245,250},43),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,40,73,54,66,62,67,54,245,41,61,71,58,72,61,68,65,57,245,72,58,73,245,73,68,15},43), stamThreshold)
else
stamThreshold = 30
print(_d({48,29,68,71,68,245,47,2,27,54,71,66,50,245,30,67,75,54,65,62,57,245,73,61,71,58,72,61,68,65,57,245,62,67,69,74,73,3,245,25,58,59,54,74,65,73,62,67,60,245,73,68,245,8,5,250},43))
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
Name = _d({29,62,60,61,245,40,73,54,66,15,245,42,72,58,245,26,245,253,40,73,74,67,254},43),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({29,62,60,61,245,40,73,54,66,15,245,42,72,58,245,47,245,253,34,62,67,62,254},43),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({29,62,60,61,245,40,73,54,66,15,245,42,72,58,245,24,245,253,32,54,66,62,64,54,79,58,254},43),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({29,62,60,61,245,40,73,54,66,15,245,42,72,58,245,39,245,253,40,67,54,69,254},43),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
end)()