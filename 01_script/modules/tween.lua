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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
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
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({50,50,39,74,56,56,65,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,39,74,56,56,65,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,39,74,56,56,65,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,39,74,56,56,65,25,66,69,54,56},45)
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
local force = root:FindFirstChild(_d({50,50,39,74,56,56,65,25,66,69,54,56},45))
local att = root:FindFirstChild(_d({50,50,39,74,56,56,65,20,71,71},45))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({33,66,65,56},45)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({37,66,62,72,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,56,67,67,66},45), args)
elseif style == _d({21,63,52,54,62,31,56,58},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62},45), args)
elseif style == _d({30,52,64,60,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,52,64,60,70,59,60,62,60,26,56,67,67,66},45), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62,5},45), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({38,59,60,67,70},45))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({38,59,60,67},45))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({41,56,59,60,54,63,56,38,56,52,71},45), true) or myShip:FindFirstChildWhichIsA(_d({38,56,52,71},45), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({32,66,55,56,63},45)) then
local seat = obj:FindFirstChildWhichIsA(_d({41,56,59,60,54,63,56,38,56,52,71},45), true) or obj:FindFirstChildWhichIsA(_d({38,56,52,71},45), true)
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
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,32,66,72,65,71,56,55,243,65,56,52,69,53,76,243,53,66,52,71,243,57,66,69,243,71,69,52,73,56,63,1},45))
else
activeBoat = nil
activeSeat = nil
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,33,66,243,65,56,52,69,53,76,243,53,66,52,71,243,55,56,71,56,54,71,56,55,1,243,25,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,67,63,52,76,56,69,0,66,65,63,76,243,57,63,60,58,59,71,1},45))
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
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,38,56,52,71,243,63,66,70,71,1,243,25,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,67,63,52,76,56,69,243,57,63,60,58,59,71,1},45))
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
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,21,66,52,71,243,52,69,69,60,73,56,55,243,52,71,243,55,56,70,71,60,65,52,71,60,66,65,1},45))
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
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,35,63,52,76,56,69,243,52,69,69,60,73,56,55,243,52,71,243,55,56,70,71,60,65,52,71,60,66,65,1},45))
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
if type(obj) == _d({71,52,53,63,56},45) then
for k, v in pairs(obj) do
if type(v) == _d({72,70,56,69,55,52,71,52},45) and v:IsA(_d({39,56,75,71,31,52,53,56,63},45)) then
if v.Name:lower():find(_d({71,60,71,63,56},45)) then
v.Text = title
elseif v.Name:lower():find(_d({54,66,65,71,56,65,71},45)) or v.Name:lower():find(_d({55,56,70,54},45)) then
v.Text = content
end
end
end
elseif type(obj) == _d({72,70,56,69,55,52,71,52},45) and obj:IsA(_d({39,56,75,71,31,52,53,56,63},45)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56,1,63,72,52},45)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({46,26,35,34,243,39,74,56,56,65,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,37,52,76,57,60,56,63,55,243,40,28,243,63,60,53,69,52,69,76,243,57,69,66,64,243,52,65,76,243,70,66,72,69,54,56,1},45))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({26,35,34,243,39,74,56,56,65,243,249,243,25,63,60,58,59,71,243,38,72,60,71,56},45),
LoadingTitle = _d({26,35,34,243,33,52,73,60,58,52,71,66,69},45),
LoadingSubtitle = _d({37,52,76,57,60,56,63,55,243,40,28,243,41,56,69,70,60,66,65},45),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({39,69,52,73,56,63,243,22,66,65,71,69,66,63,70},45), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({22,72,69,69,56,65,71,243,35,66,70,60,71,60,66,65},45),
Content = _d({43,13,243,3,1,3,3,243,79,243,44,13,243,3,1,3,3,243,79,243,45,13,243,3,1,3,3},45)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({43,13,243,248,1,5,57,243,79,243,44,13,243,248,1,5,57,243,79,243,45,13,243,248,1,5,57},45), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({22,72,69,69,56,65,71,243,35,66,70,60,71,60,66,65},45), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({22,66,67,76,243,22,72,69,69,56,65,71,243,22,66,66,69,55,60,65,52,71,56,70},45),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({248,1,5,57,255,243,248,1,5,57,255,243,248,1,5,57},45), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,22,66,67,60,56,55,243,54,66,66,69,55,60,65,52,71,56,70,243,71,66,243,54,63,60,67,53,66,52,69,55,13,243},45) .. text)
else
warn(_d({46,26,35,34,243,39,74,56,56,65,48,243,70,56,71,54,63,60,67,53,66,52,69,55,243,65,66,71,243,70,72,67,67,66,69,71,56,55,243,53,76,243,56,75,56,54,72,71,66,69,244},45))
end
end
end,
})
MainTab:CreateInput({
Name = _d({39,52,69,58,56,71,243,22,66,66,69,55,60,65,52,71,56,70,243,251,43,255,243,44,255,243,45,252},45),
PlaceholderText = _d({24,75,52,64,67,63,56,13,243,4,5,3,1,8,255,243,7,3,1,5,255,243,0,4,3,6,3,1,3},45),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({251,46,248,55,248,1,248,0,48,254,252,248,70,253,248,255,18,248,70,253,251,46,248,55,248,1,248,0,48,254,252,248,70,253,248,255,18,248,70,253,251,46,248,55,248,1,248,0,48,254,252},45))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({46,26,35,34,243,39,74,56,56,65,48,243,38,56,71,243,55,56,70,71,60,65,52,71,60,66,65,243,71,52,69,58,56,71,243,71,66,13,243,248,1,5,57,255,243,248,1,5,57,255,243,248,1,5,57},45), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({38,71,52,69,71,243,28,70,63,52,65,55,243,39,69,52,73,56,63},45),
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
Name = _d({24,65,52,53,63,56,243,42,20,38,23,243,25,63,60,58,59,71},45),
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
Name = _d({39,69,52,73,56,63,243,249,243,25,63,60,58,59,71,243,38,67,56,56,55},45),
Range = {10, 150},
Increment = 1,
Suffix = _d({243,70,71,72,55,70,2,70,56,54},45),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({25,63,60,58,59,71,243,20,63,71,60,71,72,55,56,243,251,44,252},45),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({243,44,0,70,71,72,55,70},45),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({23,56,70,71,69,66,76,243,40,28,243,249,243,38,71,66,67,243,24,73,56,69,76,71,59,60,65,58},45),
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
print(_d({46,26,35,34,243,39,74,56,56,65,48,243,22,63,56,52,65,56,55,243,72,67,243,52,65,55,243,55,56,70,71,69,66,76,56,55,243,37,52,76,57,60,56,63,55,243,40,28,1},45))
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
print(_d({46,26,35,34,243,39,74,56,56,65,243,39,56,70,71,56,69,48,243,63,66,52,55,56,55,243,74,60,71,59,243,56,64,56,69,58,56,65,54,76,243,70,71,66,67,243,62,56,76,243,46,35,48,1},45))
end)()