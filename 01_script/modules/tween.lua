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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
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
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({63,63,52,87,69,69,78,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,52,87,69,69,78,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,52,87,69,69,78,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,52,87,69,69,78,38,79,82,67,69},32)
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
local force = root:FindFirstChild(_d({63,63,52,87,69,69,78,38,79,82,67,69},32))
local att = root:FindFirstChild(_d({63,63,52,87,69,69,78,33,84,84},32))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({46,79,78,69},32)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({51,72,73,80,83},32))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({51,72,73,80},32))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({54,69,72,73,67,76,69,51,69,65,84},32), true) or myShip:FindFirstChildWhichIsA(_d({51,69,65,84},32), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({45,79,68,69,76},32)) then
local seat = obj:FindFirstChildWhichIsA(_d({54,69,72,73,67,76,69,51,69,65,84},32), true) or obj:FindFirstChildWhichIsA(_d({51,69,65,84},32), true)
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
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,45,79,85,78,84,69,68,0,78,69,65,82,66,89,0,66,79,65,84,0,70,79,82,0,84,82,65,86,69,76,14},32))
else
activeBoat = nil
activeSeat = nil
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,46,79,0,78,69,65,82,66,89,0,66,79,65,84,0,68,69,84,69,67,84,69,68,14,0,38,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,80,76,65,89,69,82,13,79,78,76,89,0,70,76,73,71,72,84,14},32))
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
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,51,69,65,84,0,76,79,83,84,14,0,38,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,80,76,65,89,69,82,0,70,76,73,71,72,84,14},32))
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
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,34,79,65,84,0,65,82,82,73,86,69,68,0,65,84,0,68,69,83,84,73,78,65,84,73,79,78,14},32))
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
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,48,76,65,89,69,82,0,65,82,82,73,86,69,68,0,65,84,0,68,69,83,84,73,78,65,84,73,79,78,14},32))
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
if type(obj) == _d({84,65,66,76,69},32) then
for k, v in pairs(obj) do
if type(v) == _d({85,83,69,82,68,65,84,65},32) and v:IsA(_d({52,69,88,84,44,65,66,69,76},32)) then
if v.Name:lower():find(_d({84,73,84,76,69},32)) then
v.Text = title
elseif v.Name:lower():find(_d({67,79,78,84,69,78,84},32)) or v.Name:lower():find(_d({68,69,83,67},32)) then
v.Text = content
end
end
end
elseif type(obj) == _d({85,83,69,82,68,65,84,65},32) and obj:IsA(_d({52,69,88,84,44,65,66,69,76},32)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69,14,76,85,65},32)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({59,39,48,47,0,52,87,69,69,78,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,50,65,89,70,73,69,76,68,0,53,41,0,76,73,66,82,65,82,89,0,70,82,79,77,0,65,78,89,0,83,79,85,82,67,69,14},32))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({39,48,47,0,52,87,69,69,78,0,6,0,38,76,73,71,72,84,0,51,85,73,84,69},32),
LoadingTitle = _d({39,48,47,0,46,65,86,73,71,65,84,79,82},32),
LoadingSubtitle = _d({50,65,89,70,73,69,76,68,0,53,41,0,54,69,82,83,73,79,78},32),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({52,82,65,86,69,76,0,35,79,78,84,82,79,76,83},32), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({35,85,82,82,69,78,84,0,48,79,83,73,84,73,79,78},32),
Content = _d({56,26,0,16,14,16,16,0,92,0,57,26,0,16,14,16,16,0,92,0,58,26,0,16,14,16,16},32)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({56,26,0,5,14,18,70,0,92,0,57,26,0,5,14,18,70,0,92,0,58,26,0,5,14,18,70},32), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({35,85,82,82,69,78,84,0,48,79,83,73,84,73,79,78},32), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({35,79,80,89,0,35,85,82,82,69,78,84,0,35,79,79,82,68,73,78,65,84,69,83},32),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({5,14,18,70,12,0,5,14,18,70,12,0,5,14,18,70},32), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,35,79,80,73,69,68,0,67,79,79,82,68,73,78,65,84,69,83,0,84,79,0,67,76,73,80,66,79,65,82,68,26,0},32) .. text)
else
warn(_d({59,39,48,47,0,52,87,69,69,78,61,0,83,69,84,67,76,73,80,66,79,65,82,68,0,78,79,84,0,83,85,80,80,79,82,84,69,68,0,66,89,0,69,88,69,67,85,84,79,82,1},32))
end
end
end,
})
MainTab:CreateInput({
Name = _d({52,65,82,71,69,84,0,35,79,79,82,68,73,78,65,84,69,83,0,8,56,12,0,57,12,0,58,9},32),
PlaceholderText = _d({37,88,65,77,80,76,69,26,0,17,18,16,14,21,12,0,20,16,14,18,12,0,13,17,16,19,16,14,16},32),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({8,59,5,68,5,14,5,13,61,11,9,5,83,10,5,12,31,5,83,10,8,59,5,68,5,14,5,13,61,11,9,5,83,10,5,12,31,5,83,10,8,59,5,68,5,14,5,13,61,11,9},32))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({59,39,48,47,0,52,87,69,69,78,61,0,51,69,84,0,68,69,83,84,73,78,65,84,73,79,78,0,84,65,82,71,69,84,0,84,79,26,0,5,14,18,70,12,0,5,14,18,70,12,0,5,14,18,70},32), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({51,84,65,82,84,0,41,83,76,65,78,68,0,52,82,65,86,69,76},32),
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
Name = _d({37,78,65,66,76,69,0,55,33,51,36,0,38,76,73,71,72,84},32),
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
Name = _d({52,82,65,86,69,76,0,6,0,38,76,73,71,72,84,0,51,80,69,69,68},32),
Range = {10, 150},
Increment = 1,
Suffix = _d({0,83,84,85,68,83,15,83,69,67},32),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({38,76,73,71,72,84,0,33,76,84,73,84,85,68,69,0,8,57,9},32),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({0,57,13,83,84,85,68,83},32),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({36,69,83,84,82,79,89,0,53,41,0,6,0,51,84,79,80,0,37,86,69,82,89,84,72,73,78,71},32),
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
print(_d({59,39,48,47,0,52,87,69,69,78,61,0,35,76,69,65,78,69,68,0,85,80,0,65,78,68,0,68,69,83,84,82,79,89,69,68,0,50,65,89,70,73,69,76,68,0,53,41,14},32))
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
print(_d({59,39,48,47,0,52,87,69,69,78,0,52,69,83,84,69,82,61,0,76,79,65,68,69,68,0,87,73,84,72,0,69,77,69,82,71,69,78,67,89,0,83,84,79,80,0,75,69,89,0,59,48,61,14},32))
end)()