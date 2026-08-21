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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local VIM = game:GetService(_d({53,72,81,83,84,64,75,40,77,79,84,83,44,64,77,64,70,68,81},33))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,50,72,81,72,84,82,50,78,69,83,86,64,81,68,43,83,67,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68,13,75,84,64},33),
_d({71,83,83,79,82,25,14,14,82,72,81,72,84,82,13,76,68,77,84,14,81,64,88,69,72,68,75,67},33),
_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,82,71,75,68,87,86,64,81,68,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68},33)
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
error(_d({58,34,78,76,79,64,66,83,255,39,84,65,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,49,64,88,69,72,68,75,67,255,52,40,255,43,72,65,81,64,81,88,13},33))
end
local Window = Rayfield:CreateWindow({
Name = _d({39,78,81,78,255,39,78,81,78,255,57,12,37,64,81,76},33),
LoadingTitle = _d({43,78,64,67,72,77,70,255,39,78,81,78,255,57,255,43,78,78,79,13,13,13},33),
LoadingSubtitle = _d({46,79,83,72,76,72,89,68,67},33),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({32,84,83,78,255,37,64,81,76},33), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
local JUZO_CORRECT_Y_MIN = 100
local JUZO_CORRECT_Y_MAX = 112
local JUZO_NON_AGRO = Vector3.new(1760.473389, 107.736938, -11011.005859)
local JUZO_AGRO = Vector3.new(1750.523804, 104.150673, -11002.995117)
local function isOnJuzoAxis()
local root = getRoot()
if not root then return false end
local pos = root.Position
local distToC1 = (pos - JUZO_NON_AGRO).Magnitude
local distToC2 = (pos - JUZO_AGRO).Magnitude
return pos.Y >= JUZO_CORRECT_Y_MIN and pos.Y <= JUZO_CORRECT_Y_MAX and (distToC1 < 50 or distToC2 < 50)
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({39,78,81,78,12,39,78,81,78},33)) or (bp and bp:FindFirstChild(_d({39,78,81,78,12,39,78,81,78},33)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local actualName = name
if name == _d({41,84,89,78,17},33) then
actualName = _d({41,84,89,78,255,83,71,68,255,35,72,64,76,78,77,67,65,64,66,74},33)
end
local npts = Workspace:FindFirstChild(_d({45,47,34,82},33))
if not npts then return nil end
local boss = npts:FindFirstChild(actualName)
if boss then
local root = boss:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local hum = boss:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({39,78,81,78,34,64,76,68,81,64,43,78,66,74},33)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)).Health > 0 then
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
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,54,64,75,74,72,77,70,255,83,78,25},33), pos)
unlockCamera()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(true, Enum.KeyCode.D, false, game)
end)
if not ok then warn(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,86,64,75,74,51,78,47,78,72,77,83,255,74,68,88,82,255,67,78,86,77,255,68,81,81,78,81,25},33), err) end
local startT = tick()
while autoZLoop and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local currentPosFlat = Vector3.new(currentRoot.Position.X, 0, currentRoot.Position.Z)
local targetPosFlat = Vector3.new(pos.X, 0, pos.Z)
local dist = (currentPosFlat - targetPosFlat).Magnitude
if dist < 3 then
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,32,81,81,72,85,68,67,255,64,83,255,67,68,82,83,72,77,64,83,72,78,77},33))
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
end)
task.wait()
end
pcall(function()
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.D, false, game)
end)
end
_G.HoroFarmCleanup = function()
autoZLoop = nil
unlockCamera()
pcall(function() Rayfield:Destroy() end)
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,34,75,68,64,77,68,67,255,84,79,255,79,81,68,85,72,78,84,82,255,82,68,82,82,72,78,77,13},33))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
if selectedBoss == _d({41,84,89,78,255,83,71,68,255,35,72,64,76,78,77,67,65,64,66,74},33) then
if not isOnJuzoAxis() then
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,50,68,75,68,66,83,68,67,255,41,84,89,78,255,65,84,83,255,79,75,64,88,68,81,255,72,82,255,77,78,83,255,78,77,255,83,71,68,255,66,64,85,68,255,64,87,72,82,13,255,56,255,66,78,78,81,67,72,77,64,83,68,255,76,84,82,83,255,65,68,255,16,15,15,12,16,16,17,255,64,77,67,255,77,68,64,81,255,83,71,68,255,66,64,85,68,13,255,54,64,72,83,72,77,70,13,13,13},33))
unlockCamera()
task.wait(5)
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,33,78,82,82},33), selectedBoss, _d({72,82,255,77,78,83,255,82,79,64,86,77,68,67,13,255,54,64,72,83,72,77,70},33), checkSpawnInterval, _d({82,68,66,78,77,67,82,13,13,13},33))
unlockCamera()
task.wait(checkSpawnInterval)
else
local tool = equipHoroTool()
if tool then
local root = getRoot()
if root and (root.Position - JUZO_NON_AGRO).Magnitude > 5 then
walkToPoint(JUZO_NON_AGRO, 15)
end
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
walkToPoint(JUZO_AGRO, 15)
local currentTarget = getBossPart(selectedBoss)
if currentTarget then
lockCameraToBoss(currentTarget)
local screenPos, onScreen
local settleStart = tick()
while tick() - settleStart < 1.5 do
screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then break end
task.wait(0.05)
end
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.3)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,37,72,81,68,67,255,57,255,64,83,255,41,84,89,78,255,7,64,70,81,78,255,81,64,77,70,68,8},33))
task.wait(0.5)
else
warn(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,37,64,72,75,68,67,255,83,78,255,79,81,78,73,68,66,83,255,41,84,89,78,255,83,78,255,85,72,68,86,79,78,81,83,255,64,69,83,68,81,255,86,64,72,83,72,77,70,13},33))
end
unlockCamera()
end
walkToPoint(JUZO_NON_AGRO, 15)
else
warn(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,6,39,78,81,78,12,39,78,81,78,6,255,83,78,78,75,255,77,78,83,255,69,78,84,77,67,255,72,77,255,65,64,66,74,79,64,66,74,255,78,81,255,66,71,64,81,64,66,83,68,81,0},33))
end
task.wait(loopDelay)
end
end
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,33,78,82,82},33), selectedBoss, _d({72,82,255,77,78,83,255,82,79,64,86,77,68,67,13,255,54,64,72,83,72,77,70},33), checkSpawnInterval, _d({82,68,66,78,77,67,82,13,13,13},33))
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
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,39,78,85,68,81,68,67,255,64,77,67,255,69,72,81,68,67,255,57,255,64,83},33), selectedBoss)
else
warn(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,37,64,72,75,68,67,255,83,78,255,79,81,78,73,68,66,83,255,83,64,81,70,68,83,255,83,78,255,85,72,68,86,79,78,81,83,13},33))
end
else
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,51,64,81,70,68,83,255,75,78,82,83,255,78,81,255,67,72,68,67,255,67,84,81,72,77,70,255,67,68,75,64,88,13},33))
end
end
else
warn(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,6,39,78,81,78,12,39,78,81,78,6,255,83,78,78,75,255,77,78,83,255,69,78,84,77,67,255,72,77,255,65,64,66,74,79,64,66,74,255,78,81,255,66,71,64,81,64,66,83,68,81,0},33))
end
task.wait(loopDelay)
end
end
else
unlockCamera()
end
end
end)
MainTab:CreateDropdown({
Name = _d({50,68,75,68,66,83,255,33,78,82,82},33),
Options = {_d({32,87,68,255,39,64,77,67,255,43,78,70,64,77},33), _d({33,64,77,67,72,83,255,33,78,82,82},33), _d({41,84,89,78,255,83,71,68,255,35,72,64,76,78,77,67,65,64,66,74},33), _d({41,84,89,78,17},33)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,50,68,75,68,66,83,68,67,255,83,64,81,70,68,83,25},33), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({32,84,83,78,255,57,255,43,78,78,79},33),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({50,68,75,68,66,83,255,33,78,82,82,255,49,68,80,84,72,81,68,67},33),
Content = _d({56,78,84,255,76,84,82,83,255,82,68,75,68,66,83,255,64,255,65,78,82,82,255,69,72,81,82,83,255,65,68,69,78,81,68,255,68,77,64,65,75,72,77,70,255,32,84,83,78,255,57,255,43,78,78,79,0},33),
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
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,32,84,83,78,255,57,255,43,78,78,79,25},33), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({43,78,78,79,255,35,68,75,64,88,255,7,50,68,66,78,77,67,82,8},33),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({34,64,76,68,81,64,255,39,68,72,70,71,83},33),
Range = {10, 60},
Increment = 1,
Suffix = _d({255,82,83,84,67,82},33),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({58,39,78,81,78,255,57,12,37,64,81,76,60,255,34,64,76,68,81,64,255,71,68,72,70,71,83,255,84,79,67,64,83,68,67,255,83,78,25},33), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({35,68,82,83,81,78,88,255,52,40},33),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()