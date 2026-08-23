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
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
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
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({58,79,80,87,90},25))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({58,79,80,87},25))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({61,76,79,80,74,83,76,58,76,72,91},25), true) or myShip:FindFirstChildWhichIsA(_d({58,76,72,91},25), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({52,86,75,76,83},25)) then
local seat = obj:FindFirstChildWhichIsA(_d({61,76,79,80,74,83,76,58,76,72,91},25), true) or obj:FindFirstChildWhichIsA(_d({58,76,72,91},25), true)
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
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,52,86,92,85,91,76,75,7,85,76,72,89,73,96,7,73,86,72,91,7,77,86,89,7,91,89,72,93,76,83,21},25))
else
activeBoat = nil
activeSeat = nil
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,53,86,7,85,76,72,89,73,96,7,73,86,72,91,7,75,76,91,76,74,91,76,75,21,7,45,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,87,83,72,96,76,89,20,86,85,83,96,7,77,83,80,78,79,91,21},25))
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
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,58,76,72,91,7,83,86,90,91,21,7,45,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,87,83,72,96,76,89,7,77,83,80,78,79,91,21},25))
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
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,41,86,72,91,7,72,89,89,80,93,76,75,7,72,91,7,75,76,90,91,80,85,72,91,80,86,85,21},25))
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
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,55,83,72,96,76,89,7,72,89,89,80,93,76,75,7,72,91,7,75,76,90,91,80,85,72,91,80,86,85,21},25))
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
if type(obj) == _d({91,72,73,83,76},25) then
for k, v in pairs(obj) do
if type(v) == _d({92,90,76,89,75,72,91,72},25) and v:IsA(_d({59,76,95,91,51,72,73,76,83},25)) then
if v.Name:lower():find(_d({91,80,91,83,76},25)) then
v.Text = title
elseif v.Name:lower():find(_d({74,86,85,91,76,85,91},25)) or v.Name:lower():find(_d({75,76,90,74},25)) then
v.Text = content
end
end
end
elseif type(obj) == _d({92,90,76,89,75,72,91,72},25) and obj:IsA(_d({59,76,95,91,51,72,73,76,83},25)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,57,72,96,77,80,76,83,75,22,84,72,80,85,22,90,86,92,89,74,76,21,83,92,72},25)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({66,46,55,54,7,59,94,76,76,85,68,7,45,72,80,83,76,75,7,91,86,7,83,86,72,75,7,57,72,96,77,80,76,83,75,7,60,48,7,83,80,73,89,72,89,96,7,77,89,86,84,7,72,85,96,7,90,86,92,89,74,76,21},25))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({46,55,54,7,59,94,76,76,85,7,13,7,45,83,80,78,79,91,7,58,92,80,91,76},25),
LoadingTitle = _d({46,55,54,7,53,72,93,80,78,72,91,86,89},25),
LoadingSubtitle = _d({57,72,96,77,80,76,83,75,7,60,48,7,61,76,89,90,80,86,85},25),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({59,89,72,93,76,83,7,42,86,85,91,89,86,83,90},25), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({42,92,89,89,76,85,91,7,55,86,90,80,91,80,86,85},25),
Content = _d({63,33,7,23,21,23,23,7,99,7,64,33,7,23,21,23,23,7,99,7,65,33,7,23,21,23,23},25)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({63,33,7,12,21,25,77,7,99,7,64,33,7,12,21,25,77,7,99,7,65,33,7,12,21,25,77},25), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({42,92,89,89,76,85,91,7,55,86,90,80,91,80,86,85},25), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({42,86,87,96,7,42,92,89,89,76,85,91,7,42,86,86,89,75,80,85,72,91,76,90},25),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({12,21,25,77,19,7,12,21,25,77,19,7,12,21,25,77},25), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,42,86,87,80,76,75,7,74,86,86,89,75,80,85,72,91,76,90,7,91,86,7,74,83,80,87,73,86,72,89,75,33,7},25) .. text)
else
warn(_d({66,46,55,54,7,59,94,76,76,85,68,7,90,76,91,74,83,80,87,73,86,72,89,75,7,85,86,91,7,90,92,87,87,86,89,91,76,75,7,73,96,7,76,95,76,74,92,91,86,89,8},25))
end
end
end,
})
MainTab:CreateInput({
Name = _d({59,72,89,78,76,91,7,42,86,86,89,75,80,85,72,91,76,90,7,15,63,19,7,64,19,7,65,16},25),
PlaceholderText = _d({44,95,72,84,87,83,76,33,7,24,25,23,21,28,19,7,27,23,21,25,19,7,20,24,23,26,23,21,23},25),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({15,66,12,75,12,21,12,20,68,18,16,12,90,17,12,19,38,12,90,17,15,66,12,75,12,21,12,20,68,18,16,12,90,17,12,19,38,12,90,17,15,66,12,75,12,21,12,20,68,18,16},25))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({66,46,55,54,7,59,94,76,76,85,68,7,58,76,91,7,75,76,90,91,80,85,72,91,80,86,85,7,91,72,89,78,76,91,7,91,86,33,7,12,21,25,77,19,7,12,21,25,77,19,7,12,21,25,77},25), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({58,91,72,89,91,7,48,90,83,72,85,75,7,59,89,72,93,76,83},25),
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
Name = _d({44,85,72,73,83,76,7,62,40,58,43,7,45,83,80,78,79,91},25),
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
Name = _d({59,89,72,93,76,83,7,13,7,45,83,80,78,79,91,7,58,87,76,76,75},25),
Range = {10, 150},
Increment = 1,
Suffix = _d({7,90,91,92,75,90,22,90,76,74},25),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({45,83,80,78,79,91,7,40,83,91,80,91,92,75,76,7,15,64,16},25),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({7,64,20,90,91,92,75,90},25),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({43,76,90,91,89,86,96,7,60,48,7,13,7,58,91,86,87,7,44,93,76,89,96,91,79,80,85,78},25),
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
print(_d({66,46,55,54,7,59,94,76,76,85,68,7,42,83,76,72,85,76,75,7,92,87,7,72,85,75,7,75,76,90,91,89,86,96,76,75,7,57,72,96,77,80,76,83,75,7,60,48,21},25))
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
print(_d({66,46,55,54,7,59,94,76,76,85,7,59,76,90,91,76,89,68,7,83,86,72,75,76,75,7,94,80,91,79,7,76,84,76,89,78,76,85,74,96,7,90,91,86,87,7,82,76,96,7,66,55,68,21},25))
end)()