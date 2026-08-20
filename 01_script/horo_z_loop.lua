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
local selectedBoss = _d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({18,70,69,64,241,23,50,67,62},47), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
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
_G.HoroFarmCleanup = function()
autoZLoop = nil
pcall(function() Rayfield:Destroy() end)
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,20,61,54,50,63,54,53,241,70,65,241,65,67,54,71,58,64,70,68,241,68,54,68,68,58,64,63,255},47))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,19,64,68,68},47), selectedBoss, _d({58,68,241,63,64,69,241,68,65,50,72,63,54,53,255,241,40,50,58,69,58,63,56},47), checkSpawnInterval, _d({68,54,52,64,63,53,68,255,255,255},47))
task.wait(checkSpawnInterval)
else
local tool = equipHoroTool()
if tool then
if getBossPart(selectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(selectedBoss)
local myRoot = getRoot()
if currentTarget and myRoot then
local originalCameraCF = Camera.CFrame
local originalCameraType = Camera.CameraType
local tempCameraCF = CFrame.lookAt(myRoot.Position + Vector3.new(0, 40, 0), currentTarget.Position)
local camConnection
camConnection = RunService.RenderStepped:Connect(function()
Camera.CameraType = Enum.CameraType.Scriptable
Camera.CFrame = tempCameraCF
end)
task.wait(0.02)
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.03)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,58,67,54,53,241,43,241,71,58,50,241,35,54,63,53,54,67,36,69,54,65,65,54,53,241,52,50,62,54,67,50,241,61,64,52,60,241,50,69},47), selectedBoss)
else
warn(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,23,50,58,61,54,53,241,69,64,241,65,67,64,59,54,52,69,241,69,50,67,56,54,69,241,69,64,241,71,58,54,72,65,64,67,69,255},47))
end
task.wait(0.05)
if camConnection then
camConnection:Disconnect()
end
Camera.CameraType = originalCameraType
Camera.CFrame = originalCameraCF
else
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,37,50,67,56,54,69,241,61,64,68,69,241,64,67,241,53,58,54,53,241,53,70,67,58,63,56,241,53,54,61,50,74,255},47))
end
end
else
warn(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,248,25,64,67,64,254,25,64,67,64,248,241,69,64,64,61,241,63,64,69,241,55,64,70,63,53,241,58,63,241,51,50,52,60,65,50,52,60,241,64,67,241,52,57,50,67,50,52,69,54,67,242},47))
end
task.wait(loopDelay)
end
end
end
end)
MainTab:CreateDropdown({
Name = _d({36,54,61,54,52,69,241,19,64,68,68},47),
Options = {_d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47)},
CurrentOption = _d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,36,54,61,54,52,69,54,53,241,69,50,67,56,54,69,11},47), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({18,70,69,64,241,43,241,29,64,64,65},47),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
print(_d({44,25,64,67,64,241,43,254,23,50,67,62,46,241,18,70,69,64,241,43,241,29,64,64,65,11},47), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({29,64,64,65,241,21,54,61,50,74,241,249,36,54,52,64,63,53,68,250},47),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,38,26},47),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()