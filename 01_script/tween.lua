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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
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
return char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({52,52,41,76,58,58,67,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,41,76,58,58,67,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,41,76,58,58,67,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,41,76,58,58,67,27,68,71,56,58},43)
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
local force = root:FindFirstChild(_d({52,52,41,76,58,58,67,27,68,71,56,58},43))
local att = root:FindFirstChild(_d({52,52,41,76,58,58,67,22,73,73},43))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({35,68,67,58},43)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({39,68,64,74,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,58,69,69,68},43), args)
elseif style == _d({23,65,54,56,64,33,58,60},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64},43), args)
elseif style == _d({32,54,66,62,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,54,66,62,72,61,62,64,62,28,58,69,69,68},43), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64,7},43), args)
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
print(_d({48,28,37,36,245,41,76,58,58,67,50,245,22,71,71,62,75,58,57,245,54,73,245,73,54,71,60,58,73,3},43))
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
local function updateParagraph(paragraph, title, desc)
if not paragraph then return end
local ok = pcall(function()
paragraph:Set({ Title = title, Desc = desc })
end)
if ok then return end
local ok2 = pcall(function()
paragraph:Set(desc)
end)
if ok2 then return end
pcall(function() paragraph:SetTitle(title) end)
pcall(function() paragraph:SetDesc(desc) end)
pcall(function() paragraph:SetValue(desc) end)
pcall(function() paragraph.Title = title end)
pcall(function() paragraph.Desc = desc end)
pcall(function()
for k, v in pairs(paragraph) do
if type(v) == _d({74,72,58,71,57,54,73,54},43) and v:IsA(_d({41,58,77,73,33,54,55,58,65},43)) then
if v.Name:lower():find(_d({73,62,73,65,58},43)) or v.Name == _d({41,62,73,65,58},43) then
v.Text = title
elseif v.Name:lower():find(_d({57,58,72,56},43)) or v.Name == _d({25,58,72,56,71,62,69,73,62,68,67},43) or v.Name == _d({25,58,72,56},43) or v.Name == _d({41,58,77,73},43) then
v.Text = desc
end
elseif type(v) == _d({73,54,55,65,58},43) then
for k2, v2 in pairs(v) do
if type(v2) == _d({74,72,58,71,57,54,73,54},43) and v2:IsA(_d({41,58,77,73,33,54,55,58,65},43)) then
if v2.Name:lower():find(_d({73,62,73,65,58},43)) or v2.Name == _d({41,62,73,65,58},43) then
v2.Text = title
elseif v2.Name:lower():find(_d({57,58,72,56},43)) or v2.Name == _d({25,58,72,56,71,62,69,73,62,68,67},43) or v2.Name == _d({25,58,72,56},43) or v2.Name == _d({41,58,77,73},43) then
v2.Text = desc
end
end
end
end
end
end)
end
local function buildUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,44,62,67,57,42,30,4,66,54,62,67,4,57,62,72,73,4,66,54,62,67,3,65,74,54},43)))()
end)
if not ok or type(WindUI) ~= _d({73,54,55,65,58},43) then
warn(_d({48,28,37,36,245,41,76,58,58,67,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,245,44,62,67,57,42,30,3},43))
return
end
local Window = WindUI:CreateWindow({
Title = _d({28,37,36,245,41,76,58,58,67,245,41,58,72,73,58,71,245,75,5,3,5,3,7},43),
Icon = _d({69,65,54,67,58},43),
Folder = _d({28,37,36,41,76,58,58,67},43),
Size = UDim2.fromOffset(500, 360),
Transparent = true,
Theme = _d({25,54,71,64},43),
OpenButton = {
Title = _d({41,76,58,58,67,245,41,58,72,73,58,71},43),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GPOTweenLibrary = Window
local tabMain = Window:Tab({ Title = _d({35,54,75,62,60,54,73,62,68,67},43), Icon = _d({66,54,69,2,69,62,67},43) })
local tabSettings = Window:Tab({ Title = _d({40,58,73,73,62,67,60,72},43), Icon = _d({72,58,73,73,62,67,60,72},43) })
local posLabel = tabMain:Paragraph({ Title = _d({24,74,71,71,58,67,73,245,37,68,72,62,73,62,68,67},43), Desc = _d({45,15,245,5,3,5,5,245,81,245,46,15,245,5,3,5,5,245,81,245,47,15,245,5,3,5,5},43) })
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({45,15,245,250,3,7,59,245,81,245,46,15,245,250,3,7,59,245,81,245,47,15,245,250,3,7,59},43), pos.X, pos.Y, pos.Z)
updateParagraph(posLabel, _d({24,74,71,71,58,67,73,245,37,68,72,62,73,62,68,67},43), text)
end
end)
end
end)
tabMain:Button({
Title = _d({24,68,69,78,245,24,74,71,71,58,67,73,245,24,68,68,71,57,62,67,54,73,58,72},43),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({250,3,7,59,1,245,250,3,7,59,1,245,250,3,7,59},43), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({48,28,37,36,245,41,76,58,58,67,50,245,24,68,69,62,58,57,245,56,68,68,71,57,62,67,54,73,58,72,15,245},43) .. text)
else
warn(_d({48,28,37,36,245,41,76,58,58,67,50,245,72,58,73,56,65,62,69,55,68,54,71,57,245,58,77,58,56,74,73,68,71,245,59,74,67,56,73,62,68,67,245,67,68,73,245,72,74,69,69,68,71,73,58,57,246},43))
end
end
end
})
tabMain:Input({
Title = _d({41,54,71,60,58,73,245,24,68,68,71,57,62,67,54,73,58,72,245,253,45,1,245,46,1,245,47,254},43),
Placeholder = _d({26,77,54,66,69,65,58,15,245,6,7,5,3,10,1,245,9,5,3,7,1,245,2,6,5,8,5,3,5},43),
Callback = function(val)
local x, y, z = string.match(val, _d({253,48,250,57,250,3,250,2,50,0,254,250,72,255,250,1,20,250,72,255,253,48,250,57,250,3,250,2,50,0,254,250,72,255,250,1,20,250,72,255,253,48,250,57,250,3,250,2,50,0,254},43))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({48,28,37,36,245,41,76,58,58,67,50,245,40,58,73,245,57,58,72,73,62,67,54,73,62,68,67,245,73,68,15,245,250,3,7,59,1,245,250,3,7,59,1,245,250,3,7,59},43), targetX, targetY, targetZ))
end
end
})
tabMain:Toggle({
Title = _d({40,73,54,71,73,245,30,72,65,54,67,57,245,41,71,54,75,58,65},43),
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
Title = _d({41,71,54,75,58,65,245,40,69,58,58,57,245,253,45,47,254},43),
Default = 70,
Min = 10,
Max = 150,
Step = 1,
Callback = function(val)
travelSpeed = val
end
})
tabSettings:Slider({
Title = _d({29,68,75,58,71,245,36,59,59,72,58,73,245,29,58,62,60,61,73},43),
Default = 15,
Min = 5,
Max = 40,
Step = 1,
Callback = function(val)
hoverHeight = val
end
})
tabSettings:Button({
Title = _d({25,58,72,73,71,68,78,245,42,30,245,251,245,24,65,58,54,67,74,69},43),
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
local playerGui = LocalPlayer:FindFirstChild(_d({37,65,54,78,58,71,28,74,62},43))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({28,37,36,41,76,58,58,67,35,54,73,62,75,58,42,30},43))
if oldUI then pcall(function() oldUI:Destroy() end) end
end
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Unload() end)
_G.GPOTweenLibrary = nil
end
print(_d({48,28,37,36,245,41,76,58,58,67,50,245,24,65,58,54,67,58,57,245,74,69,245,72,58,72,72,62,68,67,3},43))
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
print(_d({48,28,37,36,245,41,76,58,58,67,245,41,58,72,73,58,71,50,245,65,68,54,57,58,57,245,76,62,73,61,245,58,66,58,71,60,58,67,56,78,245,72,73,68,69,245,64,58,78,245,48,37,50,3},43))
end)()