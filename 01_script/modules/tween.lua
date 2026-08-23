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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
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
local activeSeat = nil
local activeBoat = nil
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({41,41,30,65,47,47,56,11,62,62},54)) or Instance.new(_d({11,62,62,43,45,50,55,47,56,62},54))
att.Name = _d({41,41,30,65,47,47,56,11,62,62},54)
att.Parent = root
local force = root:FindFirstChild(_d({41,41,30,65,47,47,56,16,57,60,45,47},54))
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = _d({41,41,30,65,47,47,56,16,57,60,45,47},54)
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
local force = root:FindFirstChild(_d({41,41,30,65,47,47,56,16,57,60,45,47},54))
local att = root:FindFirstChild(_d({41,41,30,65,47,47,56,11,62,62},54))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({24,57,56,47},54)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({29,50,51,58,61},54))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({29,50,51,58},54))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({32,47,50,51,45,54,47,29,47,43,62},54), true) or myShip:FindFirstChildWhichIsA(_d({29,47,43,62},54), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({23,57,46,47,54},54)) then
local seat = obj:FindFirstChildWhichIsA(_d({32,47,50,51,45,54,47,29,47,43,62},54), true) or obj:FindFirstChildWhichIsA(_d({29,47,43,62},54), true)
if seat then
local dist = (seat.Position - root.Position).Magnitude
if dist < 150 then
return obj, seat
end
end
end
end
return nil, nil
end
local function mountBoat(seat)
local hum = getHumanoid()
local root = getRoot()
if hum and root and seat then
pcall(function()
seat.Anchored = true
root.CFrame = seat.CFrame + Vector3.new(0, 2, 0)
task.wait(0.1)
seat:Sit(hum)
end)
end
end
local loopConn = nil
local function startMovementLoop()
if loopConn then loopConn:Disconnect() end
local boat, seat = findNearbyBoat()
if seat then
activeBoat = boat
activeSeat = seat
mountBoat(seat)
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,23,57,63,56,62,47,46,234,56,47,43,60,44,67,234,44,57,43,62,234,48,57,60,234,62,60,43,64,47,54,248},54))
else
activeBoat = nil
activeSeat = nil
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,24,57,234,56,47,43,60,44,67,234,44,57,43,62,234,46,47,62,47,45,62,47,46,248,234,16,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,58,54,43,67,47,60,247,57,56,54,67,234,48,54,51,49,50,62,248},54))
end
loopConn = RunService.Heartbeat:Connect(function(dt)
local root = getRoot()
local hum = getHumanoid()
if not root or (not travelEnabled and not wasdFlightEnabled) then
if loopConn then loopConn:Disconnect() loopConn = nil end
if activeSeat then pcall(function() activeSeat.Anchored = false end) end
cleanupForce()
return
end
local isBoating = false
if activeSeat and activeSeat.Parent and hum and hum.SeatPart == activeSeat then
isBoating = true
else
if activeSeat then
pcall(function() activeSeat.Anchored = false end)
activeSeat = nil
activeBoat = nil
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,29,47,43,62,234,54,57,61,62,248,234,16,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,58,54,43,67,47,60,234,48,54,51,49,50,62,248},54))
end
end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
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
if isBoating then
cleanupForce()
local seat = activeSeat
seat.Anchored = true
if wasdFlightEnabled then
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local newPos = seat.Position + (moveDir * flightSpeed * dt)
local flatLook = Vector3.new(look.X, 0, look.Z).Unit
if moveDir.Magnitude > 0 then
seat.CFrame = CFrame.lookAt(newPos, newPos + flatLook) + (Vector3.new(0, flightAltitudeY - newPos.Y, 0))
else
seat.CFrame = CFrame.lookAt(seat.Position, seat.Position + flatLook) + (Vector3.new(0, flightAltitudeY - seat.Position.Y, 0))
end
elseif travelEnabled then
local currentPos = seat.Position
local targetPos = Vector3.new(targetX, targetY, targetZ)
local dist = (targetPos - currentPos).Magnitude
if dist < 5 then
travelEnabled = false
seat.Anchored = false
if loopConn then loopConn:Disconnect() loopConn = nil end
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,12,57,43,62,234,43,60,60,51,64,47,46,234,43,62,234,46,47,61,62,51,56,43,62,51,57,56,248},54))
return
end
local dir = (targetPos - currentPos).Unit
local flatDir = Vector3.new(dir.X, 0, dir.Z).Unit
local stepPos = currentPos + (flatDir * flightSpeed * dt)
local yDiff = targetPos.Y - flightAltitudeY
if math.abs(yDiff) > 2 then
flightAltitudeY = flightAltitudeY + (math.sign(yDiff) * dt * 50)
if altitudeSlider and altitudeSlider.Set then
pcall(function() altitudeSlider:Set(math.round(flightAltitudeY)) end)
end
end
seat.CFrame = CFrame.lookAt(stepPos, stepPos + flatDir) + (Vector3.new(0, flightAltitudeY - stepPos.Y, 0))
end
else
local force = getOrCreateForce(root)
pcall(function()
hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
hum:ChangeState(Enum.HumanoidStateType.Running)
end)
if wasdFlightEnabled then
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
local yErr = flightAltitudeY - root.Position.Y
local yVel = math.clamp(yErr * 2, -120, 120)
if moveDir.Magnitude > 0 then
root.CFrame = CFrame.lookAt(root.Position, root.Position + Vector3.new(look.X, 0, look.Z).Unit)
end
force.VectorVelocity = Vector3.new(targetVelocity.X, yVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
invokeGeppo()
end
elseif travelEnabled then
local currentPos = root.Position
local targetPos = Vector3.new(targetX, targetY, targetZ)
local dist = (targetPos - currentPos).Magnitude
if dist < 5 then
travelEnabled = false
cleanupForce()
if loopConn then loopConn:Disconnect() loopConn = nil end
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,26,54,43,67,47,60,234,43,60,60,51,64,47,46,234,43,62,234,46,47,61,62,51,56,43,62,51,57,56,248},54))
return
end
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
if type(obj) == _d({62,43,44,54,47},54) then
for k, v in pairs(obj) do
if type(v) == _d({63,61,47,60,46,43,62,43},54) and v:IsA(_d({30,47,66,62,22,43,44,47,54},54)) then
if v.Name:lower():find(_d({62,51,62,54,47},54)) then
v.Text = title
elseif v.Name:lower():find(_d({45,57,56,62,47,56,62},54)) or v.Name:lower():find(_d({46,47,61,45},54)) then
v.Text = content
end
end
end
elseif type(obj) == _d({63,61,47,60,46,43,62,43},54) and obj:IsA(_d({30,47,66,62,22,43,44,47,54},54)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({37,17,26,25,234,30,65,47,47,56,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,54,51,44,60,43,60,67,234,48,60,57,55,234,43,56,67,234,61,57,63,60,45,47,248},54))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({17,26,25,234,30,65,47,47,56,234,240,234,16,54,51,49,50,62,234,29,63,51,62,47},54),
LoadingTitle = _d({17,26,25,234,24,43,64,51,49,43,62,57,60},54),
LoadingSubtitle = _d({28,43,67,48,51,47,54,46,234,31,19,234,32,47,60,61,51,57,56},54),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({30,60,43,64,47,54,234,13,57,56,62,60,57,54,61},54), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({13,63,60,60,47,56,62,234,26,57,61,51,62,51,57,56},54),
Content = _d({34,4,234,250,248,250,250,234,70,234,35,4,234,250,248,250,250,234,70,234,36,4,234,250,248,250,250},54)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({34,4,234,239,248,252,48,234,70,234,35,4,234,239,248,252,48,234,70,234,36,4,234,239,248,252,48},54), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({13,63,60,60,47,56,62,234,26,57,61,51,62,51,57,56},54), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({13,57,58,67,234,13,63,60,60,47,56,62,234,13,57,57,60,46,51,56,43,62,47,61},54),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({239,248,252,48,246,234,239,248,252,48,246,234,239,248,252,48},54), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,13,57,58,51,47,46,234,45,57,57,60,46,51,56,43,62,47,61,234,62,57,234,45,54,51,58,44,57,43,60,46,4,234},54) .. text)
else
warn(_d({37,17,26,25,234,30,65,47,47,56,39,234,61,47,62,45,54,51,58,44,57,43,60,46,234,56,57,62,234,61,63,58,58,57,60,62,47,46,234,44,67,234,47,66,47,45,63,62,57,60,235},54))
end
end
end,
})
MainTab:CreateInput({
Name = _d({30,43,60,49,47,62,234,13,57,57,60,46,51,56,43,62,47,61,234,242,34,246,234,35,246,234,36,243},54),
PlaceholderText = _d({15,66,43,55,58,54,47,4,234,251,252,250,248,255,246,234,254,250,248,252,246,234,247,251,250,253,250,248,250},54),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({242,37,239,46,239,248,239,247,39,245,243,239,61,244,239,246,9,239,61,244,242,37,239,46,239,248,239,247,39,245,243,239,61,244,239,246,9,239,61,244,242,37,239,46,239,248,239,247,39,245,243},54))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({37,17,26,25,234,30,65,47,47,56,39,234,29,47,62,234,46,47,61,62,51,56,43,62,51,57,56,234,62,43,60,49,47,62,234,62,57,4,234,239,248,252,48,246,234,239,248,252,48,246,234,239,248,252,48},54), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({29,62,43,60,62,234,19,61,54,43,56,46,234,30,60,43,64,47,54},54),
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
Name = _d({15,56,43,44,54,47,234,33,11,29,14,234,16,54,51,49,50,62},54),
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
Name = _d({30,60,43,64,47,54,234,240,234,16,54,51,49,50,62,234,29,58,47,47,46},54),
Range = {10, 150},
Increment = 1,
Suffix = _d({234,61,62,63,46,61,249,61,47,45},54),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({16,54,51,49,50,62,234,11,54,62,51,62,63,46,47,234,242,35,243},54),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({234,35,247,61,62,63,46,61},54),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,31,19,234,240,234,29,62,57,58,234,15,64,47,60,67,62,50,51,56,49},54),
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
if activeSeat then
pcall(function() activeSeat.Anchored = false end)
activeSeat = nil
activeBoat = nil
end
cleanupForce()
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Destroy() end)
_G.GPOTweenLibrary = nil
end
print(_d({37,17,26,25,234,30,65,47,47,56,39,234,13,54,47,43,56,47,46,234,63,58,234,43,56,46,234,46,47,61,62,60,57,67,47,46,234,28,43,67,48,51,47,54,46,234,31,19,248},54))
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
print(_d({37,17,26,25,234,30,65,47,47,56,234,30,47,61,62,47,60,39,234,54,57,43,46,47,46,234,65,51,62,50,234,47,55,47,60,49,47,56,45,67,234,61,62,57,58,234,53,47,67,234,37,26,39,248},54))
end)()