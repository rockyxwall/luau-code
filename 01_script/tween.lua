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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
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
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({73,73,62,97,79,79,88,43,94,94},22)) or Instance.new(_d({43,94,94,75,77,82,87,79,88,94},22))
att.Name = _d({73,73,62,97,79,79,88,43,94,94},22)
att.Parent = root
local force = root:FindFirstChild(_d({73,73,62,97,79,79,88,48,89,92,77,79},22))
if not force then
force = Instance.new(_d({54,83,88,79,75,92,64,79,86,89,77,83,94,99},22))
force.Name = _d({73,73,62,97,79,79,88,48,89,92,77,79},22)
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
local force = root:FindFirstChild(_d({73,73,62,97,79,79,88,48,89,92,77,79},22))
local att = root:FindFirstChild(_d({73,73,62,97,79,79,88,43,94,94},22))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({56,89,88,79},22)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({60,89,85,95,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,79,90,90,89},22), args)
elseif style == _d({44,86,75,77,85,54,79,81},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85},22), args)
elseif style == _d({53,75,87,83,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,75,87,83,93,82,83,85,83,49,79,90,90,89},22), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85,28},22), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({61,82,83,90,93},22))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({61,82,83,90},22))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({64,79,82,83,77,86,79,61,79,75,94},22), true) or myShip:FindFirstChildWhichIsA(_d({61,79,75,94},22), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({55,89,78,79,86},22)) then
local seat = obj:FindFirstChildWhichIsA(_d({64,79,82,83,77,86,79,61,79,75,94},22), true) or obj:FindFirstChildWhichIsA(_d({61,79,75,94},22), true)
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
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,55,89,95,88,94,79,78,10,88,79,75,92,76,99,10,76,89,75,94,10,80,89,92,10,94,92,75,96,79,86,24},22))
else
activeBoat = nil
activeSeat = nil
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,56,89,10,88,79,75,92,76,99,10,76,89,75,94,10,78,79,94,79,77,94,79,78,24,10,48,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,90,86,75,99,79,92,23,89,88,86,99,10,80,86,83,81,82,94,24},22))
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
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,61,79,75,94,10,86,89,93,94,24,10,48,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,90,86,75,99,79,92,10,80,86,83,81,82,94,24},22))
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
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,44,89,75,94,10,75,92,92,83,96,79,78,10,75,94,10,78,79,93,94,83,88,75,94,83,89,88,24},22))
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
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,58,86,75,99,79,92,10,75,92,92,83,96,79,78,10,75,94,10,78,79,93,94,83,88,75,94,83,89,88,24},22))
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
if type(obj) == _d({94,75,76,86,79},22) then
for k, v in pairs(obj) do
if type(v) == _d({95,93,79,92,78,75,94,75},22) and v:IsA(_d({62,79,98,94,54,75,76,79,86},22)) then
if v.Name:lower():find(_d({94,83,94,86,79},22)) then
v.Text = title
elseif v.Name:lower():find(_d({77,89,88,94,79,88,94},22)) or v.Name:lower():find(_d({78,79,93,77},22)) then
v.Text = content
end
end
end
elseif type(obj) == _d({95,93,79,92,78,75,94,75},22) and obj:IsA(_d({62,79,98,94,54,75,76,79,86},22)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79,24,86,95,75},22)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({69,49,58,57,10,62,97,79,79,88,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,60,75,99,80,83,79,86,78,10,63,51,10,86,83,76,92,75,92,99,10,80,92,89,87,10,75,88,99,10,93,89,95,92,77,79,24},22))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({49,58,57,10,62,97,79,79,88,10,16,10,48,86,83,81,82,94,10,61,95,83,94,79},22),
LoadingTitle = _d({49,58,57,10,56,75,96,83,81,75,94,89,92},22),
LoadingSubtitle = _d({60,75,99,80,83,79,86,78,10,63,51,10,64,79,92,93,83,89,88},22),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({62,92,75,96,79,86,10,45,89,88,94,92,89,86,93},22), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({45,95,92,92,79,88,94,10,58,89,93,83,94,83,89,88},22),
Content = _d({66,36,10,26,24,26,26,10,102,10,67,36,10,26,24,26,26,10,102,10,68,36,10,26,24,26,26},22)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({66,36,10,15,24,28,80,10,102,10,67,36,10,15,24,28,80,10,102,10,68,36,10,15,24,28,80},22), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({45,95,92,92,79,88,94,10,58,89,93,83,94,83,89,88},22), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({45,89,90,99,10,45,95,92,92,79,88,94,10,45,89,89,92,78,83,88,75,94,79,93},22),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({15,24,28,80,22,10,15,24,28,80,22,10,15,24,28,80},22), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,45,89,90,83,79,78,10,77,89,89,92,78,83,88,75,94,79,93,10,94,89,10,77,86,83,90,76,89,75,92,78,36,10},22) .. text)
else
warn(_d({69,49,58,57,10,62,97,79,79,88,71,10,93,79,94,77,86,83,90,76,89,75,92,78,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,79,98,79,77,95,94,89,92,11},22))
end
end
end,
})
MainTab:CreateInput({
Name = _d({62,75,92,81,79,94,10,45,89,89,92,78,83,88,75,94,79,93,10,18,66,22,10,67,22,10,68,19},22),
PlaceholderText = _d({47,98,75,87,90,86,79,36,10,27,28,26,24,31,22,10,30,26,24,28,22,10,23,27,26,29,26,24,26},22),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({18,69,15,78,15,24,15,23,71,21,19,15,93,20,15,22,41,15,93,20,18,69,15,78,15,24,15,23,71,21,19,15,93,20,15,22,41,15,93,20,18,69,15,78,15,24,15,23,71,21,19},22))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({69,49,58,57,10,62,97,79,79,88,71,10,61,79,94,10,78,79,93,94,83,88,75,94,83,89,88,10,94,75,92,81,79,94,10,94,89,36,10,15,24,28,80,22,10,15,24,28,80,22,10,15,24,28,80},22), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({61,94,75,92,94,10,51,93,86,75,88,78,10,62,92,75,96,79,86},22),
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
Name = _d({47,88,75,76,86,79,10,65,43,61,46,10,48,86,83,81,82,94},22),
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
Name = _d({62,92,75,96,79,86,10,16,10,48,86,83,81,82,94,10,61,90,79,79,78},22),
Range = {10, 150},
Increment = 1,
Suffix = _d({10,93,94,95,78,93,25,93,79,77},22),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({48,86,83,81,82,94,10,43,86,94,83,94,95,78,79,10,18,67,19},22),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({10,67,23,93,94,95,78,93},22),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({46,79,93,94,92,89,99,10,63,51,10,16,10,61,94,89,90,10,47,96,79,92,99,94,82,83,88,81},22),
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
print(_d({69,49,58,57,10,62,97,79,79,88,71,10,45,86,79,75,88,79,78,10,95,90,10,75,88,78,10,78,79,93,94,92,89,99,79,78,10,60,75,99,80,83,79,86,78,10,63,51,24},22))
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
print(_d({69,49,58,57,10,62,97,79,79,88,10,62,79,93,94,79,92,71,10,86,89,75,78,79,78,10,97,83,94,82,10,79,87,79,92,81,79,88,77,99,10,93,94,89,90,10,85,79,99,10,69,58,71,24},22))
end)()