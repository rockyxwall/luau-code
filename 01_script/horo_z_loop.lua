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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,29,51,60,51,63,61,29,57,48,62,65,43,60,47,22,62,46,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54),
_d({50,62,62,58,61,4,249,249,61,51,60,51,63,61,248,55,47,56,63,249,60,43,67,48,51,47,54,46},54),
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,61,50,54,47,66,65,43,60,47,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47},54)
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
error(_d({37,13,57,55,58,43,45,62,234,18,63,44,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,22,51,44,60,43,60,67,248},54))
end
local Window = Rayfield:CreateWindow({
Name = _d({18,57,60,57,234,18,57,60,57,234,36,247,16,43,60,55},54),
LoadingTitle = _d({22,57,43,46,51,56,49,234,18,57,60,57,234,36,234,22,57,57,58,248,248,248},54),
LoadingSubtitle = _d({25,58,62,51,55,51,68,47,46},54),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({11,63,62,57,234,16,43,60,55},54), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
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
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)) or (bp and bp:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = boss:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({18,57,60,57,13,43,55,47,60,43,22,57,45,53},54)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health > 0 then
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
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,33,43,54,53,51,56,49,234,62,57,4},54), pos)
unlockCamera()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(true, Enum.KeyCode.D, false, game)
end)
if not ok then warn(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,65,43,54,53,30,57,26,57,51,56,62,234,53,47,67,61,234,46,57,65,56,234,47,60,60,57,60,4},54), err) end
local startT = tick()
while autoZLoop and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local currentPosFlat = Vector3.new(currentRoot.Position.X, 0, currentRoot.Position.Z)
local targetPosFlat = Vector3.new(pos.X, 0, pos.Z)
local dist = (currentPosFlat - targetPosFlat).Magnitude
if dist < 3 then
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,11,60,60,51,64,47,46,234,43,62,234,46,47,61,62,51,56,43,62,51,57,56},54))
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
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,13,54,47,43,56,47,46,234,63,58,234,58,60,47,64,51,57,63,61,234,61,47,61,61,51,57,56,248},54))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
if selectedBoss == _d({20,63,68,57,234,62,50,47,234,14,51,43,55,57,56,46,44,43,45,53},54) then
if not isOnJuzoAxis() then
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,29,47,54,47,45,62,47,46,234,20,63,68,57,234,44,63,62,234,58,54,43,67,47,60,234,51,61,234,56,57,62,234,57,56,234,62,50,47,234,45,43,64,47,234,43,66,51,61,248,234,35,234,45,57,57,60,46,51,56,43,62,47,234,55,63,61,62,234,44,47,234,251,250,250,247,251,251,252,234,43,56,46,234,56,47,43,60,234,62,50,47,234,45,43,64,47,248,234,33,43,51,62,51,56,49,248,248,248},54))
unlockCamera()
task.wait(5)
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,12,57,61,61},54), selectedBoss, _d({51,61,234,56,57,62,234,61,58,43,65,56,47,46,248,234,33,43,51,62,51,56,49},54), checkSpawnInterval, _d({61,47,45,57,56,46,61,248,248,248},54))
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
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,16,51,60,47,46,234,36,234,43,62,234,20,63,68,57,234,242,43,49,60,57,234,60,43,56,49,47,243},54))
task.wait(0.5)
else
warn(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,16,43,51,54,47,46,234,62,57,234,58,60,57,52,47,45,62,234,20,63,68,57,234,62,57,234,64,51,47,65,58,57,60,62,234,43,48,62,47,60,234,65,43,51,62,51,56,49,248},54))
end
unlockCamera()
end
walkToPoint(JUZO_NON_AGRO, 15)
else
warn(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,241,18,57,60,57,247,18,57,60,57,241,234,62,57,57,54,234,56,57,62,234,48,57,63,56,46,234,51,56,234,44,43,45,53,58,43,45,53,234,57,60,234,45,50,43,60,43,45,62,47,60,235},54))
end
task.wait(loopDelay)
end
end
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,12,57,61,61},54), selectedBoss, _d({51,61,234,56,57,62,234,61,58,43,65,56,47,46,248,234,33,43,51,62,51,56,49},54), checkSpawnInterval, _d({61,47,45,57,56,46,61,248,248,248},54))
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
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,18,57,64,47,60,47,46,234,43,56,46,234,48,51,60,47,46,234,36,234,43,62},54), selectedBoss)
else
warn(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,16,43,51,54,47,46,234,62,57,234,58,60,57,52,47,45,62,234,62,43,60,49,47,62,234,62,57,234,64,51,47,65,58,57,60,62,248},54))
end
else
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,30,43,60,49,47,62,234,54,57,61,62,234,57,60,234,46,51,47,46,234,46,63,60,51,56,49,234,46,47,54,43,67,248},54))
end
end
else
warn(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,241,18,57,60,57,247,18,57,60,57,241,234,62,57,57,54,234,56,57,62,234,48,57,63,56,46,234,51,56,234,44,43,45,53,58,43,45,53,234,57,60,234,45,50,43,60,43,45,62,47,60,235},54))
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
Name = _d({29,47,54,47,45,62,234,12,57,61,61},54),
Options = {_d({11,66,47,234,18,43,56,46,234,22,57,49,43,56},54), _d({12,43,56,46,51,62,234,12,57,61,61},54), _d({20,63,68,57,234,62,50,47,234,14,51,43,55,57,56,46,44,43,45,53},54)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,29,47,54,47,45,62,47,46,234,62,43,60,49,47,62,4},54), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({11,63,62,57,234,36,234,22,57,57,58},54),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({29,47,54,47,45,62,234,12,57,61,61,234,28,47,59,63,51,60,47,46},54),
Content = _d({35,57,63,234,55,63,61,62,234,61,47,54,47,45,62,234,43,234,44,57,61,61,234,48,51,60,61,62,234,44,47,48,57,60,47,234,47,56,43,44,54,51,56,49,234,11,63,62,57,234,36,234,22,57,57,58,235},54),
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
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,11,63,62,57,234,36,234,22,57,57,58,4},54), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({22,57,57,58,234,14,47,54,43,67,234,242,29,47,45,57,56,46,61,243},54),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({13,43,55,47,60,43,234,18,47,51,49,50,62},54),
Range = {10, 60},
Increment = 1,
Suffix = _d({234,61,62,63,46,61},54),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({37,18,57,60,57,234,36,247,16,43,60,55,39,234,13,43,55,47,60,43,234,50,47,51,49,50,62,234,63,58,46,43,62,47,46,234,62,57,4},54), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,31,19},54),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()