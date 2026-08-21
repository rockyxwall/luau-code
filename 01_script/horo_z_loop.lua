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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,64,86,95,86,98,96,64,92,83,97,100,78,95,82,57,97,81,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82,27,89,98,78},19),
_d({85,97,97,93,96,39,28,28,96,86,95,86,98,96,27,90,82,91,98,28,95,78,102,83,86,82,89,81},19),
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,96,85,89,82,101,100,78,95,82,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82},19)
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
error(_d({72,48,92,90,93,78,80,97,13,53,98,79,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,63,78,102,83,86,82,89,81,13,66,54,13,57,86,79,95,78,95,102,27},19))
end
local Window = Rayfield:CreateWindow({
Name = _d({53,92,95,92,13,53,92,95,92,13,71,26,51,78,95,90},19),
LoadingTitle = _d({57,92,78,81,86,91,84,13,53,92,95,92,13,71,13,57,92,92,93,27,27,27},19),
LoadingSubtitle = _d({60,93,97,86,90,86,103,82,81},19),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = nil
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local cameraHeight = 30.0
local MainTab = Window:CreateTab(_d({46,98,97,92,13,51,78,95,90},19), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
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
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)) or (bp and bp:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = boss:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local cameraBound = false
local savedCameraCF = nil
local savedCameraType = nil
local BIND_NAME = _d({53,92,95,92,48,78,90,82,95,78,57,92,80,88},19)
local function lockCameraToBoss(targetRoot)
if not savedCameraCF then
savedCameraCF = Camera.CFrame
savedCameraType = Camera.CameraType
end
if not cameraBound then
cameraBound = true
RunService:BindToRenderStep(BIND_NAME, Enum.RenderPriority.Camera.Value + 1, function()
if targetRoot and targetRoot.Parent and targetRoot.Parent:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and targetRoot.Parent:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
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
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,68,78,89,88,86,91,84,13,97,92,39},19), pos)
unlockCamera()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(true, Enum.KeyCode.D, false, game)
end)
if not ok then warn(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,100,78,89,88,65,92,61,92,86,91,97,13,88,82,102,96,13,81,92,100,91,13,82,95,95,92,95,39},19), err) end
local startT = tick()
while autoZLoop and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local currentPosFlat = Vector3.new(currentRoot.Position.X, 0, currentRoot.Position.Z)
local targetPosFlat = Vector3.new(pos.X, 0, pos.Z)
local dist = (currentPosFlat - targetPosFlat).Magnitude
if dist < 3 then
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,46,95,95,86,99,82,81,13,78,97,13,81,82,96,97,86,91,78,97,86,92,91},19))
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10)
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
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,48,89,82,78,91,82,81,13,98,93,13,93,95,82,99,86,92,98,96,13,96,82,96,96,86,92,91,27},19))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
if selectedBoss == _d({55,98,103,92,13,97,85,82,13,49,86,78,90,92,91,81,79,78,80,88},19) then
if not isOnJuzoAxis() then
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,64,82,89,82,80,97,82,81,13,55,98,103,92,13,79,98,97,13,93,89,78,102,82,95,13,86,96,13,91,92,97,13,92,91,13,97,85,82,13,80,78,99,82,13,78,101,86,96,27,13,70,13,80,92,92,95,81,86,91,78,97,82,13,90,98,96,97,13,79,82,13,30,29,29,26,30,30,31,13,78,91,81,13,91,82,78,95,13,97,85,82,13,80,78,99,82,27,13,68,78,86,97,86,91,84,27,27,27},19))
unlockCamera()
task.wait(5)
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,47,92,96,96},19), selectedBoss, _d({86,96,13,91,92,97,13,96,93,78,100,91,82,81,27,13,68,78,86,97,86,91,84},19), checkSpawnInterval, _d({96,82,80,92,91,81,96,27,27,27},19))
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
task.wait(0.1)
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.1)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,51,86,95,82,81,13,71,13,78,97,13,55,98,103,92,13,21,78,84,95,92,13,95,78,91,84,82,22},19))
else
warn(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,51,78,86,89,82,81,13,97,92,13,93,95,92,87,82,80,97,13,55,98,103,92,13,97,92,13,99,86,82,100,93,92,95,97,27},19))
end
unlockCamera()
end
walkToPoint(JUZO_NON_AGRO, 15)
else
warn(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,20,53,92,95,92,26,53,92,95,92,20,13,97,92,92,89,13,91,92,97,13,83,92,98,91,81,13,86,91,13,79,78,80,88,93,78,80,88,13,92,95,13,80,85,78,95,78,80,97,82,95,14},19))
end
task.wait(loopDelay)
end
end
else
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,47,92,96,96},19), selectedBoss, _d({86,96,13,91,92,97,13,96,93,78,100,91,82,81,27,13,68,78,86,97,86,91,84},19), checkSpawnInterval, _d({96,82,80,92,91,81,96,27,27,27},19))
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
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,53,92,99,82,95,82,81,13,78,91,81,13,83,86,95,82,81,13,71,13,78,97},19), selectedBoss)
else
warn(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,51,78,86,89,82,81,13,97,92,13,93,95,92,87,82,80,97,13,97,78,95,84,82,97,13,97,92,13,99,86,82,100,93,92,95,97,27},19))
end
else
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,65,78,95,84,82,97,13,89,92,96,97,13,92,95,13,81,86,82,81,13,81,98,95,86,91,84,13,81,82,89,78,102,27},19))
end
end
else
warn(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,20,53,92,95,92,26,53,92,95,92,20,13,97,92,92,89,13,91,92,97,13,83,92,98,91,81,13,86,91,13,79,78,80,88,93,78,80,88,13,92,95,13,80,85,78,95,78,80,97,82,95,14},19))
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
Name = _d({64,82,89,82,80,97,13,47,92,96,96},19),
Options = {_d({46,101,82,13,53,78,91,81,13,57,92,84,78,91},19), _d({47,78,91,81,86,97,13,47,92,96,96},19), _d({55,98,103,92,13,97,85,82,13,49,86,78,90,92,91,81,79,78,80,88},19)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,64,82,89,82,80,97,82,81,13,97,78,95,84,82,97,39},19), selectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({46,98,97,92,13,71,13,57,92,92,93},19),
CurrentValue = false,
Callback = function(Value)
if Value and (not selectedBoss or selectedBoss == "") then
Rayfield:Notify({
Title = _d({64,82,89,82,80,97,13,47,92,96,96,13,63,82,94,98,86,95,82,81},19),
Content = _d({70,92,98,13,90,98,96,97,13,96,82,89,82,80,97,13,78,13,79,92,96,96,13,83,86,95,96,97,13,79,82,83,92,95,82,13,82,91,78,79,89,86,91,84,13,46,98,97,92,13,71,13,57,92,92,93,14},19),
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
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,46,98,97,92,13,71,13,57,92,92,93,39},19), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({57,92,92,93,13,49,82,89,78,102,13,21,64,82,80,92,91,81,96,22},19),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateSlider({
Name = _d({48,78,90,82,95,78,13,53,82,86,84,85,97},19),
Range = {10, 60},
Increment = 1,
Suffix = _d({13,96,97,98,81,96},19),
CurrentValue = 30,
Callback = function(Value)
cameraHeight = Value
print(_d({72,53,92,95,92,13,71,26,51,78,95,90,74,13,48,78,90,82,95,78,13,85,82,86,84,85,97,13,98,93,81,78,97,82,81,13,97,92,39},19), cameraHeight)
end,
})
MainTab:CreateButton({
Name = _d({49,82,96,97,95,92,102,13,66,54},19),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()