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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
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
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({59,59,48,83,65,65,74,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,48,83,65,65,74,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,48,83,65,65,74,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,48,83,65,65,74,34,75,78,63,65},36)
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
local force = root:FindFirstChild(_d({59,59,48,83,65,65,74,34,75,78,63,65},36))
local att = root:FindFirstChild(_d({59,59,48,83,65,65,74,29,80,80},36))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({42,75,74,65},36)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
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
print(_d({55,35,44,43,252,48,83,65,65,74,57,252,29,78,78,69,82,65,64,252,61,80,252,80,61,78,67,65,80,10},36))
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
return loadstring(game:HttpGet(_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,51,69,74,64,49,37,11,73,61,69,74,11,64,69,79,80,11,73,61,69,74,10,72,81,61},36)))()
end)
if not ok or type(WindUI) ~= _d({80,61,62,72,65},36) then
warn(_d({55,35,44,43,252,48,83,65,65,74,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,51,69,74,64,49,37,10},36))
return
end
local Window = WindUI:CreateWindow({
Title = _d({35,44,43,252,48,83,65,65,74,252,48,65,79,80,65,78,252,82,12,10,12,10,13},36),
Icon = _d({76,72,61,74,65},36),
Folder = _d({35,44,43,48,83,65,65,74},36),
Size = UDim2.fromOffset(500, 420),
Transparent = true,
Theme = _d({32,61,78,71},36),
OpenButton = {
Title = _d({48,83,65,65,74,252,48,65,79,80,65,78},36),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GPOTweenLibrary = Window
local tabMain = Window:Tab({ Title = _d({42,61,82,69,67,61,80,69,75,74},36), Icon = _d({73,61,76,9,76,69,74},36) })
local tabSettings = Window:Tab({ Title = _d({47,65,80,80,69,74,67,79},36), Icon = _d({79,65,80,80,69,74,67,79},36) })
local xLabel = tabMain:Paragraph({ Title = _d({31,81,78,78,65,74,80,252,52},36), Desc = "0" })
local yLabel = tabMain:Paragraph({ Title = _d({31,81,78,78,65,74,80,252,53},36), Desc = "0" })
local zLabel = tabMain:Paragraph({ Title = _d({31,81,78,78,65,74,80,252,54},36), Desc = "0" })
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
if xLabel and xLabel.Set then xLabel:Set({ Title = _d({31,81,78,78,65,74,80,252,52},36), Desc = string.format(_d({1,10,14,66},36), pos.X) }) end
if yLabel and yLabel.Set then yLabel:Set({ Title = _d({31,81,78,78,65,74,80,252,53},36), Desc = string.format(_d({1,10,14,66},36), pos.Y) }) end
if zLabel and zLabel.Set then zLabel:Set({ Title = _d({31,81,78,78,65,74,80,252,54},36), Desc = string.format(_d({1,10,14,66},36), pos.Z) }) end
end
end)
end
end)
tabMain:Button({
Title = _d({31,75,76,85,252,31,81,78,78,65,74,80,252,31,75,75,78,64,69,74,61,80,65,79},36),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({1,10,14,66,8,252,1,10,14,66,8,252,1,10,14,66},36), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({55,35,44,43,252,48,83,65,65,74,57,252,31,75,76,69,65,64,252,63,75,75,78,64,69,74,61,80,65,79,22,252},36) .. text)
else
warn(_d({55,35,44,43,252,48,83,65,65,74,57,252,79,65,80,63,72,69,76,62,75,61,78,64,252,65,84,65,63,81,80,75,78,252,66,81,74,63,80,69,75,74,252,74,75,80,252,79,81,76,76,75,78,80,65,64,253},36))
end
end
end
})
tabMain:Input({
Title = _d({48,61,78,67,65,80,252,52,252,31,75,75,78,64,69,74,61,80,65},36),
Placeholder = "0",
Callback = function(val)
targetX = tonumber(val) or 0
end
})
tabMain:Input({
Title = _d({48,61,78,67,65,80,252,53,252,31,75,75,78,64,69,74,61,80,65},36),
Placeholder = "0",
Callback = function(val)
targetY = tonumber(val) or 0
end
})
tabMain:Input({
Title = _d({48,61,78,67,65,80,252,54,252,31,75,75,78,64,69,74,61,80,65},36),
Placeholder = "0",
Callback = function(val)
targetZ = tonumber(val) or 0
end
})
tabMain:Toggle({
Title = _d({47,80,61,78,80,252,37,79,72,61,74,64,252,48,78,61,82,65,72},36),
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
Title = _d({48,78,61,82,65,72,252,47,76,65,65,64,252,4,52,54,5},36),
Default = 70,
Min = 10,
Max = 150,
Step = 1,
Callback = function(val)
travelSpeed = val
end
})
tabSettings:Slider({
Title = _d({36,75,82,65,78,252,43,66,66,79,65,80,252,36,65,69,67,68,80},36),
Default = 15,
Min = 5,
Max = 40,
Step = 1,
Callback = function(val)
hoverHeight = val
end
})
tabSettings:Button({
Title = _d({32,65,79,80,78,75,85,252,49,37,252,2,252,31,72,65,61,74,81,76},36),
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
local playerGui = LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({35,44,43,48,83,65,65,74,42,61,80,69,82,65,49,37},36))
if oldUI then pcall(function() oldUI:Destroy() end) end
end
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Unload() end)
_G.GPOTweenLibrary = nil
end
print(_d({55,35,44,43,252,48,83,65,65,74,57,252,31,72,65,61,74,65,64,252,81,76,252,79,65,79,79,69,75,74,10},36))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed then
if input.KeyCode == Enum.KeyCode.P then
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
end
end
end)
task.spawn(buildUI)
print(_d({55,35,44,43,252,48,83,65,65,74,252,48,65,79,80,65,78,57,252,72,75,61,64,65,64,252,83,69,80,68,252,65,73,65,78,67,65,74,63,85,252,79,80,75,76,252,71,65,85,252,55,44,57,10},36))
end)()