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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
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
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({37,37,26,61,43,43,52,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,26,61,43,43,52,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,26,61,43,43,52,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,26,61,43,43,52,12,53,56,41,43},58)
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
local force = root:FindFirstChild(_d({37,37,26,61,43,43,52,12,53,56,41,43},58))
local att = root:FindFirstChild(_d({37,37,26,61,43,43,52,7,58,58},58))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({20,53,52,43},58)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({24,53,49,59,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,43,54,54,53},58), args)
elseif style == _d({8,50,39,41,49,18,43,45},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49},58), args)
elseif style == _d({17,39,51,47,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,39,51,47,57,46,47,49,47,13,43,54,54,53},58), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49,248},58), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({25,46,47,54,57},58))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({25,46,47,54},58))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({28,43,46,47,41,50,43,25,43,39,58},58), true) or myShip:FindFirstChildWhichIsA(_d({25,43,39,58},58), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({19,53,42,43,50},58)) then
local seat = obj:FindFirstChildWhichIsA(_d({28,43,46,47,41,50,43,25,43,39,58},58), true) or obj:FindFirstChildWhichIsA(_d({25,43,39,58},58), true)
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
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,19,53,59,52,58,43,42,230,52,43,39,56,40,63,230,40,53,39,58,230,44,53,56,230,58,56,39,60,43,50,244},58))
else
activeBoat = nil
activeSeat = nil
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,20,53,230,52,43,39,56,40,63,230,40,53,39,58,230,42,43,58,43,41,58,43,42,244,230,12,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,54,50,39,63,43,56,243,53,52,50,63,230,44,50,47,45,46,58,244},58))
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
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,25,43,39,58,230,50,53,57,58,244,230,12,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,54,50,39,63,43,56,230,44,50,47,45,46,58,244},58))
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
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,8,53,39,58,230,39,56,56,47,60,43,42,230,39,58,230,42,43,57,58,47,52,39,58,47,53,52,244},58))
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
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,22,50,39,63,43,56,230,39,56,56,47,60,43,42,230,39,58,230,42,43,57,58,47,52,39,58,47,53,52,244},58))
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
if type(obj) == _d({58,39,40,50,43},58) then
for k, v in pairs(obj) do
if type(v) == _d({59,57,43,56,42,39,58,39},58) and v:IsA(_d({26,43,62,58,18,39,40,43,50},58)) then
if v.Name:lower():find(_d({58,47,58,50,43},58)) then
v.Text = title
elseif v.Name:lower():find(_d({41,53,52,58,43,52,58},58)) or v.Name:lower():find(_d({42,43,57,41},58)) then
v.Text = content
end
end
end
elseif type(obj) == _d({59,57,43,56,42,39,58,39},58) and obj:IsA(_d({26,43,62,58,18,39,40,43,50},58)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,24,39,63,44,47,43,50,42,245,51,39,47,52,245,57,53,59,56,41,43,244,50,59,39},58)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({33,13,22,21,230,26,61,43,43,52,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,24,39,63,44,47,43,50,42,230,27,15,230,50,47,40,56,39,56,63,230,44,56,53,51,230,39,52,63,230,57,53,59,56,41,43,244},58))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({13,22,21,230,26,61,43,43,52,230,236,230,12,50,47,45,46,58,230,25,59,47,58,43},58),
LoadingTitle = _d({13,22,21,230,20,39,60,47,45,39,58,53,56},58),
LoadingSubtitle = _d({24,39,63,44,47,43,50,42,230,27,15,230,28,43,56,57,47,53,52},58),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({26,56,39,60,43,50,230,9,53,52,58,56,53,50,57},58), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({9,59,56,56,43,52,58,230,22,53,57,47,58,47,53,52},58),
Content = _d({30,0,230,246,244,246,246,230,66,230,31,0,230,246,244,246,246,230,66,230,32,0,230,246,244,246,246},58)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({30,0,230,235,244,248,44,230,66,230,31,0,230,235,244,248,44,230,66,230,32,0,230,235,244,248,44},58), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({9,59,56,56,43,52,58,230,22,53,57,47,58,47,53,52},58), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({9,53,54,63,230,9,59,56,56,43,52,58,230,9,53,53,56,42,47,52,39,58,43,57},58),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({235,244,248,44,242,230,235,244,248,44,242,230,235,244,248,44},58), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,9,53,54,47,43,42,230,41,53,53,56,42,47,52,39,58,43,57,230,58,53,230,41,50,47,54,40,53,39,56,42,0,230},58) .. text)
else
warn(_d({33,13,22,21,230,26,61,43,43,52,35,230,57,43,58,41,50,47,54,40,53,39,56,42,230,52,53,58,230,57,59,54,54,53,56,58,43,42,230,40,63,230,43,62,43,41,59,58,53,56,231},58))
end
end
end,
})
MainTab:CreateInput({
Name = _d({26,39,56,45,43,58,230,9,53,53,56,42,47,52,39,58,43,57,230,238,30,242,230,31,242,230,32,239},58),
PlaceholderText = _d({11,62,39,51,54,50,43,0,230,247,248,246,244,251,242,230,250,246,244,248,242,230,243,247,246,249,246,244,246},58),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({238,33,235,42,235,244,235,243,35,241,239,235,57,240,235,242,5,235,57,240,238,33,235,42,235,244,235,243,35,241,239,235,57,240,235,242,5,235,57,240,238,33,235,42,235,244,235,243,35,241,239},58))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({33,13,22,21,230,26,61,43,43,52,35,230,25,43,58,230,42,43,57,58,47,52,39,58,47,53,52,230,58,39,56,45,43,58,230,58,53,0,230,235,244,248,44,242,230,235,244,248,44,242,230,235,244,248,44},58), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({25,58,39,56,58,230,15,57,50,39,52,42,230,26,56,39,60,43,50},58),
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
Name = _d({11,52,39,40,50,43,230,29,7,25,10,230,12,50,47,45,46,58},58),
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
Name = _d({26,56,39,60,43,50,230,236,230,12,50,47,45,46,58,230,25,54,43,43,42},58),
Range = {10, 150},
Increment = 1,
Suffix = _d({230,57,58,59,42,57,245,57,43,41},58),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({12,50,47,45,46,58,230,7,50,58,47,58,59,42,43,230,238,31,239},58),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({230,31,243,57,58,59,42,57},58),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({10,43,57,58,56,53,63,230,27,15,230,236,230,25,58,53,54,230,11,60,43,56,63,58,46,47,52,45},58),
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
print(_d({33,13,22,21,230,26,61,43,43,52,35,230,9,50,43,39,52,43,42,230,59,54,230,39,52,42,230,42,43,57,58,56,53,63,43,42,230,24,39,63,44,47,43,50,42,230,27,15,244},58))
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
print(_d({33,13,22,21,230,26,61,43,43,52,230,26,43,57,58,43,56,35,230,50,53,39,42,43,42,230,61,47,58,46,230,43,51,43,56,45,43,52,41,63,230,57,58,53,54,230,49,43,63,230,33,22,35,244},58))
end)()