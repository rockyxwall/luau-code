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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
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
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({69,69,58,93,75,75,84,39,90,90},26)) or Instance.new(_d({39,90,90,71,73,78,83,75,84,90},26))
att.Name = _d({69,69,58,93,75,75,84,39,90,90},26)
att.Parent = root
local force = root:FindFirstChild(_d({69,69,58,93,75,75,84,44,85,88,73,75},26))
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
force.Name = _d({69,69,58,93,75,75,84,44,85,88,73,75},26)
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
local force = root:FindFirstChild(_d({69,69,58,93,75,75,84,44,85,88,73,75},26))
local att = root:FindFirstChild(_d({69,69,58,93,75,75,84,39,90,90},26))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({52,85,84,75},26)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({56,85,81,91,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,75,86,86,85},26), args)
elseif style == _d({40,82,71,73,81,50,75,77},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81},26), args)
elseif style == _d({49,71,83,79,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,71,83,79,89,78,79,81,79,45,75,86,86,85},26), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81,24},26), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({57,78,79,86,89},26))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({57,78,79,86},26))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({60,75,78,79,73,82,75,57,75,71,90},26), true) or myShip:FindFirstChildWhichIsA(_d({57,75,71,90},26), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({51,85,74,75,82},26)) then
local seat = obj:FindFirstChildWhichIsA(_d({60,75,78,79,73,82,75,57,75,71,90},26), true) or obj:FindFirstChildWhichIsA(_d({57,75,71,90},26), true)
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
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,51,85,91,84,90,75,74,6,84,75,71,88,72,95,6,72,85,71,90,6,76,85,88,6,90,88,71,92,75,82,20},26))
else
activeBoat = nil
activeSeat = nil
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,52,85,6,84,75,71,88,72,95,6,72,85,71,90,6,74,75,90,75,73,90,75,74,20,6,44,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,86,82,71,95,75,88,19,85,84,82,95,6,76,82,79,77,78,90,20},26))
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
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,57,75,71,90,6,82,85,89,90,20,6,44,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,86,82,71,95,75,88,6,76,82,79,77,78,90,20},26))
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
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,40,85,71,90,6,71,88,88,79,92,75,74,6,71,90,6,74,75,89,90,79,84,71,90,79,85,84,20},26))
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
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,54,82,71,95,75,88,6,71,88,88,79,92,75,74,6,71,90,6,74,75,89,90,79,84,71,90,79,85,84,20},26))
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
if type(obj) == _d({90,71,72,82,75},26) then
for k, v in pairs(obj) do
if type(v) == _d({91,89,75,88,74,71,90,71},26) and v:IsA(_d({58,75,94,90,50,71,72,75,82},26)) then
if v.Name:lower():find(_d({90,79,90,82,75},26)) then
v.Text = title
elseif v.Name:lower():find(_d({73,85,84,90,75,84,90},26)) or v.Name:lower():find(_d({74,75,89,73},26)) then
v.Text = content
end
end
end
elseif type(obj) == _d({91,89,75,88,74,71,90,71},26) and obj:IsA(_d({58,75,94,90,50,71,72,75,82},26)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({65,45,54,53,6,58,93,75,75,84,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,82,79,72,88,71,88,95,6,76,88,85,83,6,71,84,95,6,89,85,91,88,73,75,20},26))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({45,54,53,6,58,93,75,75,84,6,12,6,44,82,79,77,78,90,6,57,91,79,90,75},26),
LoadingTitle = _d({45,54,53,6,52,71,92,79,77,71,90,85,88},26),
LoadingSubtitle = _d({56,71,95,76,79,75,82,74,6,59,47,6,60,75,88,89,79,85,84},26),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({58,88,71,92,75,82,6,41,85,84,90,88,85,82,89},26), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({41,91,88,88,75,84,90,6,54,85,89,79,90,79,85,84},26),
Content = _d({62,32,6,22,20,22,22,6,98,6,63,32,6,22,20,22,22,6,98,6,64,32,6,22,20,22,22},26)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({62,32,6,11,20,24,76,6,98,6,63,32,6,11,20,24,76,6,98,6,64,32,6,11,20,24,76},26), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({41,91,88,88,75,84,90,6,54,85,89,79,90,79,85,84},26), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({41,85,86,95,6,41,91,88,88,75,84,90,6,41,85,85,88,74,79,84,71,90,75,89},26),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({11,20,24,76,18,6,11,20,24,76,18,6,11,20,24,76},26), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,41,85,86,79,75,74,6,73,85,85,88,74,79,84,71,90,75,89,6,90,85,6,73,82,79,86,72,85,71,88,74,32,6},26) .. text)
else
warn(_d({65,45,54,53,6,58,93,75,75,84,67,6,89,75,90,73,82,79,86,72,85,71,88,74,6,84,85,90,6,89,91,86,86,85,88,90,75,74,6,72,95,6,75,94,75,73,91,90,85,88,7},26))
end
end
end,
})
MainTab:CreateInput({
Name = _d({58,71,88,77,75,90,6,41,85,85,88,74,79,84,71,90,75,89,6,14,62,18,6,63,18,6,64,15},26),
PlaceholderText = _d({43,94,71,83,86,82,75,32,6,23,24,22,20,27,18,6,26,22,20,24,18,6,19,23,22,25,22,20,22},26),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({14,65,11,74,11,20,11,19,67,17,15,11,89,16,11,18,37,11,89,16,14,65,11,74,11,20,11,19,67,17,15,11,89,16,11,18,37,11,89,16,14,65,11,74,11,20,11,19,67,17,15},26))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({65,45,54,53,6,58,93,75,75,84,67,6,57,75,90,6,74,75,89,90,79,84,71,90,79,85,84,6,90,71,88,77,75,90,6,90,85,32,6,11,20,24,76,18,6,11,20,24,76,18,6,11,20,24,76},26), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({57,90,71,88,90,6,47,89,82,71,84,74,6,58,88,71,92,75,82},26),
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
Name = _d({43,84,71,72,82,75,6,61,39,57,42,6,44,82,79,77,78,90},26),
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
Name = _d({58,88,71,92,75,82,6,12,6,44,82,79,77,78,90,6,57,86,75,75,74},26),
Range = {10, 150},
Increment = 1,
Suffix = _d({6,89,90,91,74,89,21,89,75,73},26),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({44,82,79,77,78,90,6,39,82,90,79,90,91,74,75,6,14,63,15},26),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({6,63,19,89,90,91,74,89},26),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,59,47,6,12,6,57,90,85,86,6,43,92,75,88,95,90,78,79,84,77},26),
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
print(_d({65,45,54,53,6,58,93,75,75,84,67,6,41,82,75,71,84,75,74,6,91,86,6,71,84,74,6,74,75,89,90,88,85,95,75,74,6,56,71,95,76,79,75,82,74,6,59,47,20},26))
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
print(_d({65,45,54,53,6,58,93,75,75,84,6,58,75,89,90,75,88,67,6,82,85,71,74,75,74,6,93,79,90,78,6,75,83,75,88,77,75,84,73,95,6,89,90,85,86,6,81,75,95,6,65,54,67,20},26))
end)()