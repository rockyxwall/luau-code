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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Rayfield = nil
local rayfieldSources = {
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,46,68,77,68,80,78,46,74,65,79,82,60,77,64,39,79,63,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37),
_d({67,79,79,75,78,21,10,10,78,68,77,68,80,78,9,72,64,73,80,10,77,60,84,65,68,64,71,63},37),
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,78,67,71,64,83,82,60,77,64,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64},37)
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
error(_d({54,30,74,72,75,60,62,79,251,35,80,61,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,39,68,61,77,60,77,84,9},37))
end
local Window = Rayfield:CreateWindow({
Name = _d({35,74,77,74,251,35,74,77,74,251,53,8,33,60,77,72},37),
LoadingTitle = _d({39,74,60,63,68,73,66,251,35,74,77,74,251,53,251,39,74,74,75,9,9,9},37),
LoadingSubtitle = _d({42,75,79,68,72,68,85,64,63},37),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local selectedBoss = _d({28,83,64,251,35,60,73,63,251,39,74,66,60,73},37)
local autoZLoop = false
local loopDelay = 10.5
local checkSpawnInterval = 60
local MainTab = Window:CreateTab(_d({28,80,79,74,251,33,60,77,72},37), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)) or (bp and bp:FindFirstChild(_d({35,74,77,74,8,35,74,77,74},37)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
local npts = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = boss:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
_G.HoroFarmCleanup = function()
autoZLoop = nil
pcall(function() Rayfield:Destroy() end)
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
task.spawn(function()
while autoZLoop ~= nil do
task.wait(1)
if autoZLoop then
local targetRoot = getBossPart(selectedBoss)
if not targetRoot then
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,29,74,78,78},37), selectedBoss, _d({68,78,251,73,74,79,251,78,75,60,82,73,64,63,9,251,50,60,68,79,68,73,66},37), checkSpawnInterval, _d({78,64,62,74,73,63,78,9,9,9},37))
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
Camera.CameraType = Enum.CameraType.Scriptable
local tempCameraCF = CFrame.lookAt(myRoot.Position + Vector3.new(0, 40, 0), currentTarget.Position)
Camera.CFrame = tempCameraCF
task.wait(0.02)
local screenPos, onScreen = Camera:WorldToViewportPoint(currentTarget.Position)
if onScreen then
VIM:SendMouseMoveEvent(screenPos.X, screenPos.Y, game)
task.wait(0.03)
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,33,68,77,64,63,251,53,251,81,68,60,251,29,68,77,63,2,78,8,32,84,64,251,49,68,64,82,251,30,33,77,60,72,64,251,60,79},37), selectedBoss)
else
warn(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,33,60,68,71,64,63,251,79,74,251,75,77,74,69,64,62,79,251,79,60,77,66,64,79,251,79,74,251,81,68,64,82,75,74,77,79,9},37))
end
task.wait(0.05)
Camera.CameraType = originalCameraType
Camera.CFrame = originalCameraCF
else
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,47,60,77,66,64,79,251,71,74,78,79,251,74,77,251,63,68,64,63,251,63,80,77,68,73,66,251,63,64,71,60,84,9},37))
end
end
else
warn(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,2,35,74,77,74,8,35,74,77,74,2,251,79,74,74,71,251,73,74,79,251,65,74,80,73,63,251,68,73,251,61,60,62,70,75,60,62,70,251,74,77,251,62,67,60,77,60,62,79,64,77,252},37))
end
task.wait(loopDelay)
end
end
end
end)
MainTab:CreateDropdown({
Name = _d({46,64,71,64,62,79,251,29,74,78,78},37),
Options = {_d({28,83,64,251,35,60,73,63,251,39,74,66,60,73},37)},
CurrentOption = _d({28,83,64,251,35,60,73,63,251,39,74,66,60,73},37),
MultipleOptions = false,
Callback = function(Option)
selectedBoss = Option[1] or Option
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,46,64,71,64,62,79,64,63,251,79,60,77,66,64,79,21},37), selectedBoss)
end,
})
MainTab:CreateToggle({
Name = _d({28,80,79,74,251,53,251,39,74,74,75},37),
CurrentValue = false,
Callback = function(Value)
autoZLoop = Value
print(_d({54,35,74,77,74,251,53,8,33,60,77,72,56,251,28,80,79,74,251,53,251,39,74,74,75,21},37), autoZLoop)
end,
})
MainTab:CreateSlider({
Name = _d({39,74,74,75,251,31,64,71,60,84,251,3,46,64,62,74,73,63,78,4},37),
Range = {10, 30},
Increment = 0.5,
Suffix = "s",
CurrentValue = 10.5,
Callback = function(Value)
loopDelay = Value
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,48,36},37),
Callback = function()
_G.HoroFarmCleanup()
end,
})
end)()