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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({31,31,20,55,37,37,46,1,52,52},64)) or Instance.new(_d({1,52,52,33,35,40,45,37,46,52},64))
att.Name = _d({31,31,20,55,37,37,46,1,52,52},64)
att.Parent = root
local force = root:FindFirstChild(_d({31,31,20,55,37,37,46,6,47,50,35,37},64))
if not force then
force = Instance.new(_d({12,41,46,37,33,50,22,37,44,47,35,41,52,57},64))
force.Name = _d({31,31,20,55,37,37,46,6,47,50,35,37},64)
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
local force = root:FindFirstChild(_d({31,31,20,55,37,37,46,6,47,50,35,37},64))
local att = root:FindFirstChild(_d({31,31,20,55,37,37,46,1,52,52},64))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({14,47,46,37},64)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({18,47,43,53,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({7,37,48,48,47},64), args)
elseif style == _d({2,44,33,35,43,12,37,39},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43},64), args)
elseif style == _d({11,33,45,41,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,33,45,41,51,40,41,43,41,7,37,48,48,47},64), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43,242},64), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({19,40,41,48,51},64))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({19,40,41,48},64))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({22,37,40,41,35,44,37,19,37,33,52},64), true) or myShip:FindFirstChildWhichIsA(_d({19,37,33,52},64), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({13,47,36,37,44},64)) then
local seat = obj:FindFirstChildWhichIsA(_d({22,37,40,41,35,44,37,19,37,33,52},64), true) or obj:FindFirstChildWhichIsA(_d({19,37,33,52},64), true)
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
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,13,47,53,46,52,37,36,224,46,37,33,50,34,57,224,34,47,33,52,224,38,47,50,224,52,50,33,54,37,44,238},64))
else
activeBoat = nil
activeSeat = nil
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,14,47,224,46,37,33,50,34,57,224,34,47,33,52,224,36,37,52,37,35,52,37,36,238,224,6,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,48,44,33,57,37,50,237,47,46,44,57,224,38,44,41,39,40,52,238},64))
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
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,19,37,33,52,224,44,47,51,52,238,224,6,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,48,44,33,57,37,50,224,38,44,41,39,40,52,238},64))
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
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,2,47,33,52,224,33,50,50,41,54,37,36,224,33,52,224,36,37,51,52,41,46,33,52,41,47,46,238},64))
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
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,16,44,33,57,37,50,224,33,50,50,41,54,37,36,224,33,52,224,36,37,51,52,41,46,33,52,41,47,46,238},64))
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
if type(obj) == _d({52,33,34,44,37},64) then
for k, v in pairs(obj) do
if type(v) == _d({53,51,37,50,36,33,52,33},64) and v:IsA(_d({20,37,56,52,12,33,34,37,44},64)) then
if v.Name:lower():find(_d({52,41,52,44,37},64)) then
v.Text = title
elseif v.Name:lower():find(_d({35,47,46,52,37,46,52},64)) or v.Name:lower():find(_d({36,37,51,35},64)) then
v.Text = content
end
end
end
elseif type(obj) == _d({53,51,37,50,36,33,52,33},64) and obj:IsA(_d({20,37,56,52,12,33,34,37,44},64)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,50,47,35,43,57,56,55,33,44,44,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37,238,44,53,33},64)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({27,7,16,15,224,20,55,37,37,46,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,18,33,57,38,41,37,44,36,224,21,9,224,44,41,34,50,33,50,57,224,38,50,47,45,224,33,46,57,224,51,47,53,50,35,37,238},64))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({7,16,15,224,20,55,37,37,46,224,230,224,6,44,41,39,40,52,224,19,53,41,52,37},64),
LoadingTitle = _d({7,16,15,224,14,33,54,41,39,33,52,47,50},64),
LoadingSubtitle = _d({18,33,57,38,41,37,44,36,224,21,9,224,22,37,50,51,41,47,46},64),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({20,50,33,54,37,44,224,3,47,46,52,50,47,44,51},64), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({3,53,50,50,37,46,52,224,16,47,51,41,52,41,47,46},64),
Content = _d({24,250,224,240,238,240,240,224,60,224,25,250,224,240,238,240,240,224,60,224,26,250,224,240,238,240,240},64)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({24,250,224,229,238,242,38,224,60,224,25,250,224,229,238,242,38,224,60,224,26,250,224,229,238,242,38},64), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({3,53,50,50,37,46,52,224,16,47,51,41,52,41,47,46},64), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({3,47,48,57,224,3,53,50,50,37,46,52,224,3,47,47,50,36,41,46,33,52,37,51},64),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({229,238,242,38,236,224,229,238,242,38,236,224,229,238,242,38},64), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,3,47,48,41,37,36,224,35,47,47,50,36,41,46,33,52,37,51,224,52,47,224,35,44,41,48,34,47,33,50,36,250,224},64) .. text)
else
warn(_d({27,7,16,15,224,20,55,37,37,46,29,224,51,37,52,35,44,41,48,34,47,33,50,36,224,46,47,52,224,51,53,48,48,47,50,52,37,36,224,34,57,224,37,56,37,35,53,52,47,50,225},64))
end
end
end,
})
MainTab:CreateInput({
Name = _d({20,33,50,39,37,52,224,3,47,47,50,36,41,46,33,52,37,51,224,232,24,236,224,25,236,224,26,233},64),
PlaceholderText = _d({5,56,33,45,48,44,37,250,224,241,242,240,238,245,236,224,244,240,238,242,236,224,237,241,240,243,240,238,240},64),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({232,27,229,36,229,238,229,237,29,235,233,229,51,234,229,236,255,229,51,234,232,27,229,36,229,238,229,237,29,235,233,229,51,234,229,236,255,229,51,234,232,27,229,36,229,238,229,237,29,235,233},64))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({27,7,16,15,224,20,55,37,37,46,29,224,19,37,52,224,36,37,51,52,41,46,33,52,41,47,46,224,52,33,50,39,37,52,224,52,47,250,224,229,238,242,38,236,224,229,238,242,38,236,224,229,238,242,38},64), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({19,52,33,50,52,224,9,51,44,33,46,36,224,20,50,33,54,37,44},64),
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
Name = _d({5,46,33,34,44,37,224,23,1,19,4,224,6,44,41,39,40,52},64),
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
Name = _d({20,50,33,54,37,44,224,230,224,6,44,41,39,40,52,224,19,48,37,37,36},64),
Range = {10, 150},
Increment = 1,
Suffix = _d({224,51,52,53,36,51,239,51,37,35},64),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({6,44,41,39,40,52,224,1,44,52,41,52,53,36,37,224,232,25,233},64),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({224,25,237,51,52,53,36,51},64),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({4,37,51,52,50,47,57,224,21,9,224,230,224,19,52,47,48,224,5,54,37,50,57,52,40,41,46,39},64),
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
print(_d({27,7,16,15,224,20,55,37,37,46,29,224,3,44,37,33,46,37,36,224,53,48,224,33,46,36,224,36,37,51,52,50,47,57,37,36,224,18,33,57,38,41,37,44,36,224,21,9,238},64))
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
print(_d({27,7,16,15,224,20,55,37,37,46,224,20,37,51,52,37,50,29,224,44,47,33,36,37,36,224,55,41,52,40,224,37,45,37,50,39,37,46,35,57,224,51,52,47,48,224,43,37,57,224,27,16,29,238},64))
end)()