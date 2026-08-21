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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local travelEnabled = false
local wasdFlightEnabled = false
local flightSpeed = 70.0
local hoverHeight = 15.0
local targetX, targetY, targetZ = 0, 0, 0
local flightAltitudeY = 50.0
local altitudeSlider = nil
local lastGeppoTime = 0
local geppoCooldown = 2.0
local lastGroundingTime = tick()
local groundingActive = false
local groundingDuration = 0.5
local groundingInterval = 12.0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({38,38,27,62,44,44,53,8,59,59},57)) or Instance.new(_d({8,59,59,40,42,47,52,44,53,59},57))
att.Name = _d({38,38,27,62,44,44,53,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,27,62,44,44,53,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,27,62,44,44,53,13,54,57,42,44},57)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local localPlatform = nil
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function setFreefallDisabled(disabled)
pcall(function()
local hum = getHumanoid()
if hum then
hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, not disabled)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not disabled)
if disabled then
hum:ChangeState(Enum.HumanoidStateType.Running)
end
end
end)
end
local function cleanupForce()
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({38,38,27,62,44,44,53,13,54,57,42,44},57))
local att = root:FindFirstChild(_d({38,38,27,62,44,44,53,8,59,59},57))
if force then force:Destroy() end
if att then att:Destroy() end
end
setFreefallDisabled(false)
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({21,54,53,44},57)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
end)
end
local loopConn = nil
local function startMovementLoop()
if loopConn then loopConn:Disconnect() end
lastGroundingTime = tick()
groundingActive = false
setFreefallDisabled(true)
loopConn = RunService.Heartbeat:Connect(function(dt)
local root = getRoot()
if not root or (not travelEnabled and not wasdFlightEnabled) then
if loopConn then loopConn:Disconnect() loopConn = nil end
cleanupForce()
return
end
local force = getOrCreateForce(root)
local hum = getHumanoid()
if wasdFlightEnabled then
local camera = Workspace.CurrentCamera
local moveDir = Vector3.zero
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local targetYChanged = false
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
flightAltitudeY = math.clamp(flightAltitudeY + (dt * 150), -50, 1500)
targetYChanged = true
end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
flightAltitudeY = math.clamp(flightAltitudeY - (dt * 150), -50, 1500)
targetYChanged = true
end
if targetYChanged and altitudeSlider and altitudeSlider.Set then
pcall(function() altitudeSlider:Set(math.round(flightAltitudeY)) end)
end
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
local yErr = flightAltitudeY - root.Position.Y
local yVel = math.clamp(yErr * 2, -120, 120)
if moveDir.Magnitude > 0 then
root.CFrame = CFrame.lookAt(root.Position, root.Position + Vector3.new(look.X, 0, look.Z).Unit)
end
force.VectorVelocity = Vector3.new(targetVelocity.X, yVel, targetVelocity.Z)
if hum then
pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
end
if moveDir.Magnitude > 0 then
invokeGeppo()
end
elseif travelEnabled then
local currentPos = root.Position
local targetPos = Vector3.new(targetX, targetY, targetZ)
local dist = (targetPos - currentPos).Magnitude
if dist < 5 then
travelEnabled = false
if loopConn then loopConn:Disconnect() loopConn = nil end
cleanupForce()
print(_d({34,14,23,22,231,27,62,44,44,53,36,231,8,57,57,48,61,44,43,231,40,59,231,59,40,57,46,44,59,245},57))
return
end
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
pcall(function()
if hum then
hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
end
end)
force.VectorVelocity = Vector3.new(0, -60, 0)
else
pcall(function()
if hum then
hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
hum:ChangeState(Enum.HumanoidStateType.Running)
end
end)
local xzDir = Vector3.new(targetPos.X - currentPos.X, 0, targetPos.Z - currentPos.Z)
local xzVel = Vector3.zero
if xzDir.Magnitude > 0 then
xzVel = xzDir.Unit * math.min(xzDir.Magnitude, flightSpeed)
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
end
end)
end
local function updateRayfieldParagraph(paragraph, title, content)
if not paragraph then return end
local ok = pcall(function()
paragraph:Set({Title = title, Content = content})
end)
if ok then return end
pcall(function()
for _, obj in ipairs(paragraph) do
if type(obj) == _d({59,40,41,51,44},57) then
for k, v in pairs(obj) do
if type(v) == _d({60,58,44,57,43,40,59,40},57) and v:IsA(_d({27,44,63,59,19,40,41,44,51},57)) then
if v.Name:lower():find(_d({59,48,59,51,44},57)) then
v.Text = title
elseif v.Name:lower():find(_d({42,54,53,59,44,53,59},57)) or v.Name:lower():find(_d({43,44,58,42},57)) then
v.Text = content
end
end
end
elseif type(obj) == _d({60,58,44,57,43,40,59,40},57) and obj:IsA(_d({27,44,63,59,19,40,41,44,51},57)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44,245,51,60,40},57)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({34,14,23,22,231,27,62,44,44,53,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,25,40,64,45,48,44,51,43,231,28,16,231,51,48,41,57,40,57,64,231,45,57,54,52,231,40,53,64,231,58,54,60,57,42,44,245},57))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({14,23,22,231,27,62,44,44,53,231,237,231,13,51,48,46,47,59,231,26,60,48,59,44},57),
LoadingTitle = _d({14,23,22,231,21,40,61,48,46,40,59,54,57},57),
LoadingSubtitle = _d({25,40,64,45,48,44,51,43,231,28,16,231,29,44,57,58,48,54,53},57),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({27,57,40,61,44,51,231,10,54,53,59,57,54,51,58},57), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({10,60,57,57,44,53,59,231,23,54,58,48,59,48,54,53},57),
Content = _d({31,1,231,247,245,247,247,231,67,231,32,1,231,247,245,247,247,231,67,231,33,1,231,247,245,247,247},57)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({31,1,231,236,245,249,45,231,67,231,32,1,231,236,245,249,45,231,67,231,33,1,231,236,245,249,45},57), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({10,60,57,57,44,53,59,231,23,54,58,48,59,48,54,53},57), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({10,54,55,64,231,10,60,57,57,44,53,59,231,10,54,54,57,43,48,53,40,59,44,58},57),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({236,245,249,45,243,231,236,245,249,45,243,231,236,245,249,45},57), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({34,14,23,22,231,27,62,44,44,53,36,231,10,54,55,48,44,43,231,42,54,54,57,43,48,53,40,59,44,58,231,59,54,231,42,51,48,55,41,54,40,57,43,1,231},57) .. text)
else
warn(_d({34,14,23,22,231,27,62,44,44,53,36,231,58,44,59,42,51,48,55,41,54,40,57,43,231,53,54,59,231,58,60,55,55,54,57,59,44,43,231,41,64,231,44,63,44,42,60,59,54,57,232},57))
end
end
end,
})
MainTab:CreateInput({
Name = _d({27,40,57,46,44,59,231,10,54,54,57,43,48,53,40,59,44,58,231,239,31,243,231,32,243,231,33,240},57),
PlaceholderText = _d({12,63,40,52,55,51,44,1,231,248,249,247,245,252,243,231,251,247,245,249,243,231,244,248,247,250,247,245,247},57),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({239,34,236,43,236,245,236,244,36,242,240,236,58,241,236,243,6,236,58,241,239,34,236,43,236,245,236,244,36,242,240,236,58,241,236,243,6,236,58,241,239,34,236,43,236,245,236,244,36,242,240},57))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({34,14,23,22,231,27,62,44,44,53,36,231,26,44,59,231,43,44,58,59,48,53,40,59,48,54,53,231,59,40,57,46,44,59,231,59,54,1,231,236,245,249,45,243,231,236,245,249,45,243,231,236,245,249,45},57), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({26,59,40,57,59,231,16,58,51,40,53,43,231,27,57,40,61,44,51},57),
CurrentValue = false,
Callback = function(val)
travelEnabled = val
if travelEnabled then
wasdFlightEnabled = false
startMovementLoop()
else
cleanupForce()
end
end,
})
MainTab:CreateToggle({
Name = _d({12,53,40,41,51,44,231,30,8,26,11,231,13,51,48,46,47,59},57),
CurrentValue = false,
Callback = function(val)
wasdFlightEnabled = val
if wasdFlightEnabled then
travelEnabled = false
startMovementLoop()
else
cleanupForce()
end
end,
})
MainTab:CreateSlider({
Name = _d({27,57,40,61,44,51,231,237,231,13,51,48,46,47,59,231,26,55,44,44,43},57),
Range = {10, 150},
Increment = 1,
Suffix = _d({231,58,59,60,43,58,246,58,44,42},57),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({13,51,48,46,47,59,231,8,51,59,48,59,60,43,44,231,239,32,240},57),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({231,32,244,58,59,60,43,58},57),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({11,44,58,59,57,54,64,231,28,16,231,237,231,26,59,54,55,231,12,61,44,57,64,59,47,48,53,46},57),
Callback = function()
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
end,
})
end
_G.GPOTweenCleanup = function()
travelEnabled = false
wasdFlightEnabled = false
if loopConn then
pcall(function() loopConn:Disconnect() end)
loopConn = nil
end
cleanupForce()
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Destroy() end)
_G.GPOTweenLibrary = nil
end
print(_d({34,14,23,22,231,27,62,44,44,53,36,231,10,51,44,40,53,44,43,231,60,55,231,40,53,43,231,43,44,58,59,57,54,64,44,43,231,25,40,64,45,48,44,51,43,231,28,16,245},57))
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
print(_d({34,14,23,22,231,27,62,44,44,53,231,27,44,58,59,44,57,36,231,51,54,40,43,44,43,231,62,48,59,47,231,44,52,44,57,46,44,53,42,64,231,58,59,54,55,231,50,44,64,231,34,23,36,245},57))
end)()