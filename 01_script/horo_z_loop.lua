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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local RunService = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local VIM = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,42,57,81,62,65,61,68,60,7,69,57,65,70,7,75,71,77,74,59,61,6,68,77,57},40)
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
error(_d({51,27,71,69,72,57,59,76,248,32,77,58,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,248,42,57,81,62,65,61,68,60,248,45,33,248,36,65,58,74,57,74,81,6},40))
end
local Window = Rayfield:CreateWindow({
Name = _d({32,71,74,71,248,32,71,74,71,248,50,5,30,57,74,69},40),
LoadingTitle = _d({36,71,57,60,65,70,63,248,32,71,74,71,248,50,248,36,71,71,72,6,6,6},40),
LoadingSubtitle = _d({39,72,76,65,69,65,82,61,60},40),
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
local MainTab = Window:CreateTab(_d({25,77,76,71,248,30,57,74,69},40), 4483362458)
local SkillTab = Window:CreateTab(_d({43,67,65,68,68,248,43,61,76,76,65,70,63,75},40), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end
local function getStaminaPercent()
local success, result = pcall(function()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. LocalPlayer.Name)
if statsFolder then
local stats = statsFolder:FindFirstChild(_d({43,76,57,76,75},40))
local stam = stats and stats:FindFirstChild(_d({43,76,57,69,65,70,57},40))
local maxStam = stats and stats:FindFirstChild(_d({37,57,80,43,76,57,69,65,70,57},40))
if stam and maxStam then
return (stam.Value / maxStam.Value) * 100
end
end
end)
return success and result or 100
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({32,71,74,71,5,32,71,74,71},40)) or (bp and bp:FindFirstChild(_d({32,71,74,71,5,32,71,74,71},40)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({38,40,27,75},40))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local hum = boss:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({32,71,74,71,27,57,69,61,74,57,36,71,59,67},40)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)).Health > 0 then
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
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,27,68,61,57,70,61,60,248,77,72,248,72,74,61,78,65,71,77,75,248,75,61,75,75,65,71,70,6},40))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,47,57,65,76,65,70,63,248,62,71,74,248,26,71,75,75,248,43,72,57,79,70},40)) end
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,26,71,75,75},40), selectedBoss, _d({65,75,248,70,71,76,248,75,72,57,79,70,61,60,6,248,47,57,65,76,65,70,63},40), checkSpawnInterval, _d({75,61,59,71,70,60,75,6,6,6},40))
unlockCamera()
task.wait(5)
else
local tool = equipHoroTool()
if not tool then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,37,65,75,75,65,70,63,248,32,71,74,71,248,44,71,71,68},40)) end
warn(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,255,32,71,74,71,5,32,71,74,71,255,248,76,71,71,68,248,70,71,76,248,62,71,77,70,60,248,65,70,248,58,57,59,67,72,57,59,67,248,71,74,248,59,64,57,74,57,59,76,61,74,249},40))
task.wait(2)
else
lockCameraToBoss(targetRoot)
local stamPct = getStaminaPercent()
local useE, useZ, useC, useR
if stamPct < 12.5 then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,40,57,77,75,61,60,248,0,36,71,79,248,43,76,57,69,65,70,57,1},40)) end
task.wait(2)
else
if stamPct < stamThreshold then
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,36,71,79,248,43,76,57,69,65,70,57,248,37,71,60,61},40)) end
useE, useZ, useC, useR = lowUseE, lowUseZ, lowUseC, lowUseR
else
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,32,65,63,64,248,43,76,57,69,65,70,57,248,37,71,60,61},40)) end
useE, useZ, useC, useR = highUseE, highUseZ, highUseC, highUseR
end
local now = tick()
local firedAnything = false
if useC and (now - lastC >= 60) then
local screenPos, onScreen = Camera:WorldToViewportPoint(targetRoot.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
firedAnything = true
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,30,65,74,61,60,248,27,248,0,35,57,69,65,67,57,82,61,1},40))
end
elseif useZ and (now - lastZ >= 10) then
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
firedAnything = true
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,30,65,74,61,60,248,50,248,0,37,65,70,65,248,26,57,74,74,57,63,61,1},40))
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
firedAnything = true
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,30,65,74,61,60,248,29,248,0,43,76,77,70,1},40))
if useR then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,30,65,74,61,60,248,42,248,0,28,61,76,71,70,57,76,65,71,70,1},40))
end
end
end
now = tick()
local nextZ = lastZ + 10
local nextE = lastE + 17
local nextC = lastC + 60
local possibleWaits = {}
if useZ then table.insert(possibleWaits, nextZ - now) end
if useE then table.insert(possibleWaits, nextE - now) end
if useC then table.insert(possibleWaits, nextC - now) end
local sleepTime = 1.0
if #possibleWaits > 0 then
local minWait = 999
for _, w in ipairs(possibleWaits) do
if w > 0 and w < minWait then
minWait = w
end
end
if minWait ~= 999 then
sleepTime = math.clamp(minWait, 0.5, 30)
end
end
if statusLabel then statusLabel:Set(string.format(_d({43,76,57,76,77,75,18,248,43,68,61,61,72,65,70,63,248,0,253,6,9,62,75,1},40), sleepTime)) end
task.wait(sleepTime)
end
end
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({43,76,57,76,77,75,18,248,33,60,68,61},40))
MainTab:CreateDropdown({
Name = _d({43,61,68,61,59,76,248,26,71,75,75},40),
Options = {_d({25,80,61,248,32,57,70,60,248,36,71,63,57,70},40), _d({26,57,70,60,65,76,248,26,71,75,75},40), _d({34,77,82,71,248,76,64,61,248,28,65,57,69,71,70,60,58,57,59,67},40)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,43,61,68,61,59,76,61,60,248,76,57,74,63,61,76,18},40), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({43,76,57,74,76,248,25,77,76,71,248,30,57,74,69},40),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({43,61,68,61,59,76,248,26,71,75,75,248,42,61,73,77,65,74,61,60},40),
Content = _d({49,71,77,248,69,77,75,76,248,75,61,68,61,59,76,248,57,248,58,71,75,75,248,62,65,74,75,76,248,58,61,62,71,74,61,248,61,70,57,58,68,65,70,63,248,25,77,76,71,248,30,57,74,69,249},40),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
autoZLoop = Value
if not autoZLoop then
unlockCamera()
if statusLabel then statusLabel:Set(_d({43,76,57,76,77,75,18,248,33,60,68,61},40)) end
end
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,25,77,76,71,248,30,57,74,69,18},40), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({27,57,69,61,74,57,248,32,61,65,63,64,76},40),
Range = {10, 60},
Increment = 1,
Suffix = _d({248,75,76,77,60,75},40),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,27,57,69,61,74,57,248,64,61,65,63,64,76,248,77,72,60,57,76,61,60,248,76,71,18},40), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({28,61,75,76,74,71,81,248,45,33},40),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateInput({
Name = _d({43,76,57,69,65,70,57,248,44,64,74,61,75,64,71,68,60,248,253},40),
PlaceholderText = "30",
RemoveTextAfterFocusLost = false,
Callback = function(Text)
local num = tonumber(Text)
if num then
stamThreshold = math.clamp(num, 0, 100)
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,43,76,57,69,65,70,57,248,44,64,74,61,75,64,71,68,60,248,75,61,76,248,76,71,18},40), stamThreshold)
else
stamThreshold = 30
print(_d({51,32,71,74,71,248,50,5,30,57,74,69,53,248,33,70,78,57,68,65,60,248,76,64,74,61,75,64,71,68,60,248,65,70,72,77,76,6,248,28,61,62,57,77,68,76,65,70,63,248,76,71,248,11,8,253},40))
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
Name = _d({32,65,63,64,248,43,76,57,69,18,248,45,75,61,248,29,248,0,43,76,77,70,1},40),
CurrentValue = true,
Callback = function(Value) highUseE = Value end,
})
SkillTab:CreateToggle({
Name = _d({32,65,63,64,248,43,76,57,69,18,248,45,75,61,248,50,248,0,37,65,70,65,1},40),
CurrentValue = true,
Callback = function(Value) highUseZ = Value end,
})
SkillTab:CreateToggle({
Name = _d({32,65,63,64,248,43,76,57,69,18,248,45,75,61,248,27,248,0,35,57,69,65,67,57,82,61,1},40),
CurrentValue = true,
Callback = function(Value) highUseC = Value end,
})
SkillTab:CreateToggle({
Name = _d({32,65,63,64,248,43,76,57,69,18,248,45,75,61,248,42,248,0,43,70,57,72,1},40),
CurrentValue = true,
Callback = function(Value) highUseR = Value end,
})
end)()