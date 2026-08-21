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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
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
return char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({65,65,54,89,71,71,80,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,54,89,71,71,80,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,54,89,71,71,80,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,54,89,71,71,80,40,81,84,69,71},30)
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
local force = root:FindFirstChild(_d({65,65,54,89,71,71,80,40,81,84,69,71},30))
local att = root:FindFirstChild(_d({65,65,54,89,71,71,80,35,86,86},30))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({53,86,67,86,85},30) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({48,81,80,71},30)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({52,81,77,87,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,71,82,82,81},30), args)
elseif style == _d({36,78,67,69,77,46,71,73},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77},30), args)
elseif style == _d({45,67,79,75,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,67,79,75,85,74,75,77,75,41,71,82,82,81},30), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77,20},30), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({53,74,75,82,85},30))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({53,74,75,82},30))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({56,71,74,75,69,78,71,53,71,67,86},30), true) or myShip:FindFirstChildWhichIsA(_d({53,71,67,86},30), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({47,81,70,71,78},30)) then
local seat = obj:FindFirstChildWhichIsA(_d({56,71,74,75,69,78,71,53,71,67,86},30), true) or obj:FindFirstChildWhichIsA(_d({53,71,67,86},30), true)
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
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,47,81,87,80,86,71,70,2,80,71,67,84,68,91,2,68,81,67,86,2,72,81,84,2,86,84,67,88,71,78,16},30))
else
activeBoat = nil
activeSeat = nil
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,48,81,2,80,71,67,84,68,91,2,68,81,67,86,2,70,71,86,71,69,86,71,70,16,2,40,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,82,78,67,91,71,84,15,81,80,78,91,2,72,78,75,73,74,86,16},30))
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
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,53,71,67,86,2,78,81,85,86,16,2,40,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,82,78,67,91,71,84,2,72,78,75,73,74,86,16},30))
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
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,36,81,67,86,2,67,84,84,75,88,71,70,2,67,86,2,70,71,85,86,75,80,67,86,75,81,80,16},30))
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
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,50,78,67,91,71,84,2,67,84,84,75,88,71,70,2,67,86,2,70,71,85,86,75,80,67,86,75,81,80,16},30))
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
if type(obj) == _d({86,67,68,78,71},30) then
for k, v in pairs(obj) do
if type(v) == _d({87,85,71,84,70,67,86,67},30) and v:IsA(_d({54,71,90,86,46,67,68,71,78},30)) then
if v.Name:lower():find(_d({86,75,86,78,71},30)) then
v.Text = title
elseif v.Name:lower():find(_d({69,81,80,86,71,80,86},30)) or v.Name:lower():find(_d({70,71,85,69},30)) then
v.Text = content
end
end
end
elseif type(obj) == _d({87,85,71,84,70,67,86,67},30) and obj:IsA(_d({54,71,90,86,46,67,68,71,78},30)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,52,67,91,72,75,71,78,70,17,79,67,75,80,17,85,81,87,84,69,71,16,78,87,67},30)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({61,41,50,49,2,54,89,71,71,80,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,2,52,67,91,72,75,71,78,70,2,55,43,2,78,75,68,84,67,84,91,2,72,84,81,79,2,67,80,91,2,85,81,87,84,69,71,16},30))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({41,50,49,2,54,89,71,71,80,2,8,2,40,78,75,73,74,86,2,53,87,75,86,71},30),
LoadingTitle = _d({41,50,49,2,48,67,88,75,73,67,86,81,84},30),
LoadingSubtitle = _d({52,67,91,72,75,71,78,70,2,55,43,2,56,71,84,85,75,81,80},30),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({54,84,67,88,71,78,2,37,81,80,86,84,81,78,85},30), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({37,87,84,84,71,80,86,2,50,81,85,75,86,75,81,80},30),
Content = _d({58,28,2,18,16,18,18,2,94,2,59,28,2,18,16,18,18,2,94,2,60,28,2,18,16,18,18},30)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({58,28,2,7,16,20,72,2,94,2,59,28,2,7,16,20,72,2,94,2,60,28,2,7,16,20,72},30), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({37,87,84,84,71,80,86,2,50,81,85,75,86,75,81,80},30), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({37,81,82,91,2,37,87,84,84,71,80,86,2,37,81,81,84,70,75,80,67,86,71,85},30),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({7,16,20,72,14,2,7,16,20,72,14,2,7,16,20,72},30), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,37,81,82,75,71,70,2,69,81,81,84,70,75,80,67,86,71,85,2,86,81,2,69,78,75,82,68,81,67,84,70,28,2},30) .. text)
else
warn(_d({61,41,50,49,2,54,89,71,71,80,63,2,85,71,86,69,78,75,82,68,81,67,84,70,2,80,81,86,2,85,87,82,82,81,84,86,71,70,2,68,91,2,71,90,71,69,87,86,81,84,3},30))
end
end
end,
})
MainTab:CreateInput({
Name = _d({54,67,84,73,71,86,2,37,81,81,84,70,75,80,67,86,71,85,2,10,58,14,2,59,14,2,60,11},30),
PlaceholderText = _d({39,90,67,79,82,78,71,28,2,19,20,18,16,23,14,2,22,18,16,20,14,2,15,19,18,21,18,16,18},30),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({10,61,7,70,7,16,7,15,63,13,11,7,85,12,7,14,33,7,85,12,10,61,7,70,7,16,7,15,63,13,11,7,85,12,7,14,33,7,85,12,10,61,7,70,7,16,7,15,63,13,11},30))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({61,41,50,49,2,54,89,71,71,80,63,2,53,71,86,2,70,71,85,86,75,80,67,86,75,81,80,2,86,67,84,73,71,86,2,86,81,28,2,7,16,20,72,14,2,7,16,20,72,14,2,7,16,20,72},30), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({53,86,67,84,86,2,43,85,78,67,80,70,2,54,84,67,88,71,78},30),
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
Name = _d({39,80,67,68,78,71,2,57,35,53,38,2,40,78,75,73,74,86},30),
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
Name = _d({54,84,67,88,71,78,2,8,2,40,78,75,73,74,86,2,53,82,71,71,70},30),
Range = {10, 150},
Increment = 1,
Suffix = _d({2,85,86,87,70,85,17,85,71,69},30),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({40,78,75,73,74,86,2,35,78,86,75,86,87,70,71,2,10,59,11},30),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({2,59,15,85,86,87,70,85},30),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({38,71,85,86,84,81,91,2,55,43,2,8,2,53,86,81,82,2,39,88,71,84,91,86,74,75,80,73},30),
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
print(_d({61,41,50,49,2,54,89,71,71,80,63,2,37,78,71,67,80,71,70,2,87,82,2,67,80,70,2,70,71,85,86,84,81,91,71,70,2,52,67,91,72,75,71,78,70,2,55,43,16},30))
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
print(_d({61,41,50,49,2,54,89,71,71,80,2,54,71,85,86,71,84,63,2,78,81,67,70,71,70,2,89,75,86,74,2,71,79,71,84,73,71,80,69,91,2,85,86,81,82,2,77,71,91,2,61,50,63,16},30))
end)()