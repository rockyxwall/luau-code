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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
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
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({34,34,23,58,40,40,49,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,23,58,40,40,49,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,23,58,40,40,49,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,23,58,40,40,49,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,23,58,40,40,49,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,23,58,40,40,49,4,55,55},61))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({17,50,49,40},61)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({21,50,46,56,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({10,40,51,51,50},61), args)
elseif style == _d({5,47,36,38,46,15,40,42},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46},61), args)
elseif style == _d({14,36,48,44,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,36,48,44,54,43,44,46,44,10,40,51,51,50},61), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46,245},61), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({22,43,44,51,54},61))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({22,43,44,51},61))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({25,40,43,44,38,47,40,22,40,36,55},61), true) or myShip:FindFirstChildWhichIsA(_d({22,40,36,55},61), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({16,50,39,40,47},61)) then
local seat = obj:FindFirstChildWhichIsA(_d({25,40,43,44,38,47,40,22,40,36,55},61), true) or obj:FindFirstChildWhichIsA(_d({22,40,36,55},61), true)
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
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,16,50,56,49,55,40,39,227,49,40,36,53,37,60,227,37,50,36,55,227,41,50,53,227,55,53,36,57,40,47,241},61))
else
activeBoat = nil
activeSeat = nil
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,17,50,227,49,40,36,53,37,60,227,37,50,36,55,227,39,40,55,40,38,55,40,39,241,227,9,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,51,47,36,60,40,53,240,50,49,47,60,227,41,47,44,42,43,55,241},61))
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
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,22,40,36,55,227,47,50,54,55,241,227,9,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,51,47,36,60,40,53,227,41,47,44,42,43,55,241},61))
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
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,5,50,36,55,227,36,53,53,44,57,40,39,227,36,55,227,39,40,54,55,44,49,36,55,44,50,49,241},61))
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
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,19,47,36,60,40,53,227,36,53,53,44,57,40,39,227,36,55,227,39,40,54,55,44,49,36,55,44,50,49,241},61))
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
if type(obj) == _d({55,36,37,47,40},61) then
for k, v in pairs(obj) do
if type(v) == _d({56,54,40,53,39,36,55,36},61) and v:IsA(_d({23,40,59,55,15,36,37,40,47},61)) then
if v.Name:lower():find(_d({55,44,55,47,40},61)) then
v.Text = title
elseif v.Name:lower():find(_d({38,50,49,55,40,49,55},61)) or v.Name:lower():find(_d({39,40,54,38},61)) then
v.Text = content
end
end
end
elseif type(obj) == _d({56,54,40,53,39,36,55,36},61) and obj:IsA(_d({23,40,59,55,15,36,37,40,47},61)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40,241,47,56,36},61)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({30,10,19,18,227,23,58,40,40,49,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,21,36,60,41,44,40,47,39,227,24,12,227,47,44,37,53,36,53,60,227,41,53,50,48,227,36,49,60,227,54,50,56,53,38,40,241},61))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({10,19,18,227,23,58,40,40,49,227,233,227,9,47,44,42,43,55,227,22,56,44,55,40},61),
LoadingTitle = _d({10,19,18,227,17,36,57,44,42,36,55,50,53},61),
LoadingSubtitle = _d({21,36,60,41,44,40,47,39,227,24,12,227,25,40,53,54,44,50,49},61),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({23,53,36,57,40,47,227,6,50,49,55,53,50,47,54},61), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({6,56,53,53,40,49,55,227,19,50,54,44,55,44,50,49},61),
Content = _d({27,253,227,243,241,243,243,227,63,227,28,253,227,243,241,243,243,227,63,227,29,253,227,243,241,243,243},61)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({27,253,227,232,241,245,41,227,63,227,28,253,227,232,241,245,41,227,63,227,29,253,227,232,241,245,41},61), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({6,56,53,53,40,49,55,227,19,50,54,44,55,44,50,49},61), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({6,50,51,60,227,6,56,53,53,40,49,55,227,6,50,50,53,39,44,49,36,55,40,54},61),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({232,241,245,41,239,227,232,241,245,41,239,227,232,241,245,41},61), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,6,50,51,44,40,39,227,38,50,50,53,39,44,49,36,55,40,54,227,55,50,227,38,47,44,51,37,50,36,53,39,253,227},61) .. text)
else
warn(_d({30,10,19,18,227,23,58,40,40,49,32,227,54,40,55,38,47,44,51,37,50,36,53,39,227,49,50,55,227,54,56,51,51,50,53,55,40,39,227,37,60,227,40,59,40,38,56,55,50,53,228},61))
end
end
end,
})
MainTab:CreateInput({
Name = _d({23,36,53,42,40,55,227,6,50,50,53,39,44,49,36,55,40,54,227,235,27,239,227,28,239,227,29,236},61),
PlaceholderText = _d({8,59,36,48,51,47,40,253,227,244,245,243,241,248,239,227,247,243,241,245,239,227,240,244,243,246,243,241,243},61),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({235,30,232,39,232,241,232,240,32,238,236,232,54,237,232,239,2,232,54,237,235,30,232,39,232,241,232,240,32,238,236,232,54,237,232,239,2,232,54,237,235,30,232,39,232,241,232,240,32,238,236},61))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({30,10,19,18,227,23,58,40,40,49,32,227,22,40,55,227,39,40,54,55,44,49,36,55,44,50,49,227,55,36,53,42,40,55,227,55,50,253,227,232,241,245,41,239,227,232,241,245,41,239,227,232,241,245,41},61), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({22,55,36,53,55,227,12,54,47,36,49,39,227,23,53,36,57,40,47},61),
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
Name = _d({8,49,36,37,47,40,227,26,4,22,7,227,9,47,44,42,43,55},61),
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
Name = _d({23,53,36,57,40,47,227,233,227,9,47,44,42,43,55,227,22,51,40,40,39},61),
Range = {10, 150},
Increment = 1,
Suffix = _d({227,54,55,56,39,54,242,54,40,38},61),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({9,47,44,42,43,55,227,4,47,55,44,55,56,39,40,227,235,28,236},61),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({227,28,240,54,55,56,39,54},61),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({7,40,54,55,53,50,60,227,24,12,227,233,227,22,55,50,51,227,8,57,40,53,60,55,43,44,49,42},61),
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
print(_d({30,10,19,18,227,23,58,40,40,49,32,227,6,47,40,36,49,40,39,227,56,51,227,36,49,39,227,39,40,54,55,53,50,60,40,39,227,21,36,60,41,44,40,47,39,227,24,12,241},61))
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
print(_d({30,10,19,18,227,23,58,40,40,49,227,23,40,54,55,40,53,32,227,47,50,36,39,40,39,227,58,44,55,43,227,40,48,40,53,42,40,49,38,60,227,54,55,50,51,227,46,40,60,227,30,19,32,241},61))
end)()