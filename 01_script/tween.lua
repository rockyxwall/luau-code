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
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local UserInputService = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local travelEnabled = false
local travelSpeed = 70.0
local hoverHeight = 15.0
local targetX, targetY, targetZ = 0, 0, 0
local lastGeppoTime = 0
local geppoCooldown = 2.0
local lastGroundingTime = tick()
local groundingActive = false
local groundingDuration = 0.5
local groundingInterval = 12.0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({70,70,59,94,76,76,85,40,91,91},25)) or Instance.new(_d({40,91,91,72,74,79,84,76,85,91},25))
att.Name = _d({70,70,59,94,76,76,85,40,91,91},25)
att.Parent = root
local force = root:FindFirstChild(_d({70,70,59,94,76,76,85,45,86,89,74,76},25))
if not force then
force = Instance.new(_d({51,80,85,76,72,89,61,76,83,86,74,80,91,96},25))
force.Name = _d({70,70,59,94,76,76,85,45,86,89,74,76},25)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({70,70,59,94,76,76,85,45,86,89,74,76},25))
local att = root:FindFirstChild(_d({70,70,59,94,76,76,85,40,91,91},25))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({58,91,72,91,90},25) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({53,86,85,76},25)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({57,86,82,92,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,76,87,87,86},25), args)
elseif style == _d({41,83,72,74,82,51,76,78},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82},25), args)
elseif style == _d({50,72,84,80,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,72,84,80,90,79,80,82,80,46,76,87,87,86},25), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82,25},25), args)
end
end)
end
local navConn = nil
local function startNavigation()
if navConn then navConn:Disconnect() end
lastGroundingTime = tick()
groundingActive = false
navConn = RunService.Heartbeat:Connect(function(dt)
local root = getRoot()
if not root or not travelEnabled then
cleanupForce()
if navConn then navConn:Disconnect() navConn = nil end
return
end
local currentPos = root.Position
local targetPos = Vector3.new(targetX, targetY, targetZ)
local dist = (targetPos - currentPos).Magnitude
if dist < 5 then
travelEnabled = false
cleanupForce()
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,40,89,89,80,93,76,75,7,72,91,7,91,72,89,78,76,91,21},25))
if navConn then navConn:Disconnect() navConn = nil end
return
end
local force = getOrCreateForce(root)
local now = tick()
if not groundingActive and (now - lastGroundingTime > groundingInterval) then
groundingActive = true
task.spawn(function()
task.wait(groundingDuration)
groundingActive = false
lastGroundingTime = tick()
end)
end
if groundingActive then
force.VectorVelocity = Vector3.new(0, -60, 0)
else
local xzDir = Vector3.new(targetPos.X - currentPos.X, 0, targetPos.Z - currentPos.Z)
local xzVel = Vector3.zero
if xzDir.Magnitude > 0 then
xzVel = xzDir.Unit * math.min(xzDir.Magnitude, travelSpeed)
end
local yErr = targetPos.Y - currentPos.Y
local yVel = math.clamp(yErr * 2, -120, 120)
force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
if xzDir.Magnitude > 0.5 then
root.CFrame = CFrame.lookAt(currentPos, Vector3.new(targetPos.X, currentPos.Y, targetPos.Z))
end
if yErr > 5 then
invokeGeppo()
end
end
end)
end
local function buildUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,62,80,85,75,60,48,22,84,72,80,85,22,75,80,90,91,22,84,72,80,85,21,83,92,72},25)))()
end)
if not ok or type(WindUI) ~= _d({91,72,73,83,76},25) then
warn(_d({66,46,55,54,7,59,94,76,76,85,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,62,80,85,75,60,48,21},25))
return
end
local Window = WindUI:CreateWindow({
Title = _d({46,55,54,7,59,94,76,76,85,7,59,76,90,91,76,89,7,93,23,21,23,21,24},25),
Icon = _d({87,83,72,85,76},25),
Folder = _d({46,55,54,59,94,76,76,85},25),
Size = UDim2.fromOffset(500, 420),
Transparent = true,
Theme = _d({43,72,89,82},25),
OpenButton = {
Title = _d({59,94,76,76,85,7,59,76,90,91,76,89},25),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GPOTweenLibrary = Window
local tabMain = Window:Tab({ Title = _d({53,72,93,80,78,72,91,80,86,85},25), Icon = _d({84,72,87,20,87,80,85},25) })
local tabSettings = Window:Tab({ Title = _d({58,76,91,91,80,85,78,90},25), Icon = _d({90,76,91,91,80,85,78,90},25) })
local xLabel = tabMain:Paragraph({ Title = _d({42,92,89,89,76,85,91,7,63},25), Desc = "0" })
local yLabel = tabMain:Paragraph({ Title = _d({42,92,89,89,76,85,91,7,64},25), Desc = "0" })
local zLabel = tabMain:Paragraph({ Title = _d({42,92,89,89,76,85,91,7,65},25), Desc = "0" })
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
if xLabel and xLabel.Set then xLabel:Set({ Title = _d({42,92,89,89,76,85,91,7,63},25), Desc = string.format(_d({12,21,25,77},25), pos.X) }) end
if yLabel and yLabel.Set then yLabel:Set({ Title = _d({42,92,89,89,76,85,91,7,64},25), Desc = string.format(_d({12,21,25,77},25), pos.Y) }) end
if zLabel and zLabel.Set then zLabel:Set({ Title = _d({42,92,89,89,76,85,91,7,65},25), Desc = string.format(_d({12,21,25,77},25), pos.Z) }) end
end
end)
end
end)
tabMain:Button({
Title = _d({42,86,87,96,7,42,92,89,89,76,85,91,7,42,86,86,89,75,80,85,72,91,76,90},25),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({12,21,25,77,19,7,12,21,25,77,19,7,12,21,25,77},25), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,42,86,87,80,76,75,7,74,86,86,89,75,80,85,72,91,76,90,33,7},25) .. text)
else
warn(_d({66,46,55,54,7,59,94,76,76,85,68,7,90,76,91,74,83,80,87,73,86,72,89,75,7,76,95,76,74,92,91,86,89,7,77,92,85,74,91,80,86,85,7,85,86,91,7,90,92,87,87,86,89,91,76,75,8},25))
end
end
end
})
tabMain:Input({
Title = _d({59,72,89,78,76,91,7,63,7,42,86,86,89,75,80,85,72,91,76},25),
Placeholder = "0",
Callback = function(val)
targetX = tonumber(val) or 0
end
})
tabMain:Input({
Title = _d({59,72,89,78,76,91,7,64,7,42,86,86,89,75,80,85,72,91,76},25),
Placeholder = "0",
Callback = function(val)
targetY = tonumber(val) or 0
end
})
tabMain:Input({
Title = _d({59,72,89,78,76,91,7,65,7,42,86,86,89,75,80,85,72,91,76},25),
Placeholder = "0",
Callback = function(val)
targetZ = tonumber(val) or 0
end
})
tabMain:Toggle({
Title = _d({58,91,72,89,91,7,48,90,83,72,85,75,7,59,89,72,93,76,83},25),
Value = false,
Callback = function(val)
travelEnabled = val
if travelEnabled then
startNavigation()
else
cleanupForce()
end
end
})
tabSettings:Slider({
Title = _d({59,89,72,93,76,83,7,58,87,76,76,75,7,15,63,65,16},25),
Default = 70,
Min = 10,
Max = 150,
Step = 1,
Callback = function(val)
travelSpeed = val
end
})
tabSettings:Slider({
Title = _d({47,86,93,76,89,7,54,77,77,90,76,91,7,47,76,80,78,79,91},25),
Default = 15,
Min = 5,
Max = 40,
Step = 1,
Callback = function(val)
hoverHeight = val
end
})
tabSettings:Button({
Title = _d({43,76,90,91,89,86,96,7,60,48,7,13,7,42,83,76,72,85,92,87},25),
Callback = function()
if _G.GPOTweenCleanup then pcall(_G.GPOTweenCleanup) end
end
})
end
_G.GPOTweenCleanup = function()
travelEnabled = false
cleanupForce()
if navConn then
pcall(function() navConn:Disconnect() end)
navConn = nil
end
local playerGui = LocalPlayer:FindFirstChild(_d({55,83,72,96,76,89,46,92,80},25))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({46,55,54,59,94,76,76,85,53,72,91,80,93,76,60,48},25))
if oldUI then pcall(function() oldUI:Destroy() end) end
end
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Unload() end)
_G.GPOTweenLibrary = nil
end
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,42,83,76,72,85,76,75,7,92,87,7,90,76,90,90,80,86,85,21},25))
end
task.spawn(buildUI)
print(_d({66,46,55,54,7,59,94,76,76,85,7,59,76,90,91,76,89,68,7,83,86,72,75,76,75,21},25))
end)()