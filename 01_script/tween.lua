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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
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
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({54,54,43,78,60,60,69,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,43,78,60,60,69,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,43,78,60,60,69,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,43,78,60,60,69,29,70,73,58,60},41)
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
local force = root:FindFirstChild(_d({54,54,43,78,60,60,69,29,70,73,58,60},41))
local att = root:FindFirstChild(_d({54,54,43,78,60,60,69,24,75,75},41))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({37,70,69,60},41)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({41,70,66,76,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,60,71,71,70},41), args)
elseif style == _d({25,67,56,58,66,35,60,62},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66},41), args)
elseif style == _d({34,56,68,64,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,56,68,64,74,63,64,66,64,30,60,71,71,70},41), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66,9},41), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({42,63,64,71,74},41))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({42,63,64,71},41))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({45,60,63,64,58,67,60,42,60,56,75},41), true) or myShip:FindFirstChildWhichIsA(_d({42,60,56,75},41), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({36,70,59,60,67},41)) then
local seat = obj:FindFirstChildWhichIsA(_d({45,60,63,64,58,67,60,42,60,56,75},41), true) or obj:FindFirstChildWhichIsA(_d({42,60,56,75},41), true)
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
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,36,70,76,69,75,60,59,247,69,60,56,73,57,80,247,57,70,56,75,247,61,70,73,247,75,73,56,77,60,67,5},41))
else
activeBoat = nil
activeSeat = nil
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,37,70,247,69,60,56,73,57,80,247,57,70,56,75,247,59,60,75,60,58,75,60,59,5,247,29,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,71,67,56,80,60,73,4,70,69,67,80,247,61,67,64,62,63,75,5},41))
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
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,42,60,56,75,247,67,70,74,75,5,247,29,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,71,67,56,80,60,73,247,61,67,64,62,63,75,5},41))
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
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,25,70,56,75,247,56,73,73,64,77,60,59,247,56,75,247,59,60,74,75,64,69,56,75,64,70,69,5},41))
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
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,39,67,56,80,60,73,247,56,73,73,64,77,60,59,247,56,75,247,59,60,74,75,64,69,56,75,64,70,69,5},41))
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
if type(obj) == _d({75,56,57,67,60},41) then
for k, v in pairs(obj) do
if type(v) == _d({76,74,60,73,59,56,75,56},41) and v:IsA(_d({43,60,79,75,35,56,57,60,67},41)) then
if v.Name:lower():find(_d({75,64,75,67,60},41)) then
v.Text = title
elseif v.Name:lower():find(_d({58,70,69,75,60,69,75},41)) or v.Name:lower():find(_d({59,60,74,58},41)) then
v.Text = content
end
end
end
elseif type(obj) == _d({76,74,60,73,59,56,75,56},41) and obj:IsA(_d({43,60,79,75,35,56,57,60,67},41)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,41,56,80,61,64,60,67,59,6,68,56,64,69,6,74,70,76,73,58,60,5,67,76,56},41)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({50,30,39,38,247,43,78,60,60,69,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,41,56,80,61,64,60,67,59,247,44,32,247,67,64,57,73,56,73,80,247,61,73,70,68,247,56,69,80,247,74,70,76,73,58,60,5},41))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({30,39,38,247,43,78,60,60,69,247,253,247,29,67,64,62,63,75,247,42,76,64,75,60},41),
LoadingTitle = _d({30,39,38,247,37,56,77,64,62,56,75,70,73},41),
LoadingSubtitle = _d({41,56,80,61,64,60,67,59,247,44,32,247,45,60,73,74,64,70,69},41),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({43,73,56,77,60,67,247,26,70,69,75,73,70,67,74},41), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({26,76,73,73,60,69,75,247,39,70,74,64,75,64,70,69},41),
Content = _d({47,17,247,7,5,7,7,247,83,247,48,17,247,7,5,7,7,247,83,247,49,17,247,7,5,7,7},41)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({47,17,247,252,5,9,61,247,83,247,48,17,247,252,5,9,61,247,83,247,49,17,247,252,5,9,61},41), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({26,76,73,73,60,69,75,247,39,70,74,64,75,64,70,69},41), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({26,70,71,80,247,26,76,73,73,60,69,75,247,26,70,70,73,59,64,69,56,75,60,74},41),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({252,5,9,61,3,247,252,5,9,61,3,247,252,5,9,61},41), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,26,70,71,64,60,59,247,58,70,70,73,59,64,69,56,75,60,74,247,75,70,247,58,67,64,71,57,70,56,73,59,17,247},41) .. text)
else
warn(_d({50,30,39,38,247,43,78,60,60,69,52,247,74,60,75,58,67,64,71,57,70,56,73,59,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
end
end
end,
})
MainTab:CreateInput({
Name = _d({43,56,73,62,60,75,247,26,70,70,73,59,64,69,56,75,60,74,247,255,47,3,247,48,3,247,49,0},41),
PlaceholderText = _d({28,79,56,68,71,67,60,17,247,8,9,7,5,12,3,247,11,7,5,9,3,247,4,8,7,10,7,5,7},41),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({255,50,252,59,252,5,252,4,52,2,0,252,74,1,252,3,22,252,74,1,255,50,252,59,252,5,252,4,52,2,0,252,74,1,252,3,22,252,74,1,255,50,252,59,252,5,252,4,52,2,0},41))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({50,30,39,38,247,43,78,60,60,69,52,247,42,60,75,247,59,60,74,75,64,69,56,75,64,70,69,247,75,56,73,62,60,75,247,75,70,17,247,252,5,9,61,3,247,252,5,9,61,3,247,252,5,9,61},41), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({42,75,56,73,75,247,32,74,67,56,69,59,247,43,73,56,77,60,67},41),
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
Name = _d({28,69,56,57,67,60,247,46,24,42,27,247,29,67,64,62,63,75},41),
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
Name = _d({43,73,56,77,60,67,247,253,247,29,67,64,62,63,75,247,42,71,60,60,59},41),
Range = {10, 150},
Increment = 1,
Suffix = _d({247,74,75,76,59,74,6,74,60,58},41),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({29,67,64,62,63,75,247,24,67,75,64,75,76,59,60,247,255,48,0},41),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({247,48,4,74,75,76,59,74},41),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({27,60,74,75,73,70,80,247,44,32,247,253,247,42,75,70,71,247,28,77,60,73,80,75,63,64,69,62},41),
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
print(_d({50,30,39,38,247,43,78,60,60,69,52,247,26,67,60,56,69,60,59,247,76,71,247,56,69,59,247,59,60,74,75,73,70,80,60,59,247,41,56,80,61,64,60,67,59,247,44,32,5},41))
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
print(_d({50,30,39,38,247,43,78,60,60,69,247,43,60,74,75,60,73,52,247,67,70,56,59,60,59,247,78,64,75,63,247,60,68,60,73,62,60,69,58,80,247,74,75,70,71,247,66,60,80,247,50,39,52,5},41))
end)()