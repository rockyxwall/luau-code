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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
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
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({48,48,37,72,54,54,63,18,69,69},47)) or Instance.new(_d({18,69,69,50,52,57,62,54,63,69},47))
att.Name = _d({48,48,37,72,54,54,63,18,69,69},47)
att.Parent = root
local force = root:FindFirstChild(_d({48,48,37,72,54,54,63,23,64,67,52,54},47))
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
force.Name = _d({48,48,37,72,54,54,63,23,64,67,52,54},47)
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
local force = root:FindFirstChild(_d({48,48,37,72,54,54,63,23,64,67,52,54},47))
local att = root:FindFirstChild(_d({48,48,37,72,54,54,63,18,69,69},47))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({31,64,63,54},47)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({35,64,60,70,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,54,65,65,64},47), args)
elseif style == _d({19,61,50,52,60,29,54,56},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60},47), args)
elseif style == _d({28,50,62,58,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,50,62,58,68,57,58,60,58,24,54,65,65,64},47), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60,3},47), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({36,57,58,65,68},47))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({36,57,58,65},47))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({39,54,57,58,52,61,54,36,54,50,69},47), true) or myShip:FindFirstChildWhichIsA(_d({36,54,50,69},47), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({30,64,53,54,61},47)) then
local seat = obj:FindFirstChildWhichIsA(_d({39,54,57,58,52,61,54,36,54,50,69},47), true) or obj:FindFirstChildWhichIsA(_d({36,54,50,69},47), true)
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
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,30,64,70,63,69,54,53,241,63,54,50,67,51,74,241,51,64,50,69,241,55,64,67,241,69,67,50,71,54,61,255},47))
else
activeBoat = nil
activeSeat = nil
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,31,64,241,63,54,50,67,51,74,241,51,64,50,69,241,53,54,69,54,52,69,54,53,255,241,23,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,65,61,50,74,54,67,254,64,63,61,74,241,55,61,58,56,57,69,255},47))
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
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,36,54,50,69,241,61,64,68,69,255,241,23,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,65,61,50,74,54,67,241,55,61,58,56,57,69,255},47))
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
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,19,64,50,69,241,50,67,67,58,71,54,53,241,50,69,241,53,54,68,69,58,63,50,69,58,64,63,255},47))
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
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,33,61,50,74,54,67,241,50,67,67,58,71,54,53,241,50,69,241,53,54,68,69,58,63,50,69,58,64,63,255},47))
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
if type(obj) == _d({69,50,51,61,54},47) then
for k, v in pairs(obj) do
if type(v) == _d({70,68,54,67,53,50,69,50},47) and v:IsA(_d({37,54,73,69,29,50,51,54,61},47)) then
if v.Name:lower():find(_d({69,58,69,61,54},47)) then
v.Text = title
elseif v.Name:lower():find(_d({52,64,63,69,54,63,69},47)) or v.Name:lower():find(_d({53,54,68,52},47)) then
v.Text = content
end
end
end
elseif type(obj) == _d({70,68,54,67,53,50,69,50},47) and obj:IsA(_d({37,54,73,69,29,50,51,54,61},47)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54,255,61,70,50},47)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({44,24,33,32,241,37,72,54,54,63,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,35,50,74,55,58,54,61,53,241,38,26,241,61,58,51,67,50,67,74,241,55,67,64,62,241,50,63,74,241,68,64,70,67,52,54,255},47))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({24,33,32,241,37,72,54,54,63,241,247,241,23,61,58,56,57,69,241,36,70,58,69,54},47),
LoadingTitle = _d({24,33,32,241,31,50,71,58,56,50,69,64,67},47),
LoadingSubtitle = _d({35,50,74,55,58,54,61,53,241,38,26,241,39,54,67,68,58,64,63},47),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({37,67,50,71,54,61,241,20,64,63,69,67,64,61,68},47), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({20,70,67,67,54,63,69,241,33,64,68,58,69,58,64,63},47),
Content = _d({41,11,241,1,255,1,1,241,77,241,42,11,241,1,255,1,1,241,77,241,43,11,241,1,255,1,1},47)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({41,11,241,246,255,3,55,241,77,241,42,11,241,246,255,3,55,241,77,241,43,11,241,246,255,3,55},47), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({20,70,67,67,54,63,69,241,33,64,68,58,69,58,64,63},47), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({20,64,65,74,241,20,70,67,67,54,63,69,241,20,64,64,67,53,58,63,50,69,54,68},47),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({246,255,3,55,253,241,246,255,3,55,253,241,246,255,3,55},47), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,20,64,65,58,54,53,241,52,64,64,67,53,58,63,50,69,54,68,241,69,64,241,52,61,58,65,51,64,50,67,53,11,241},47) .. text)
else
warn(_d({44,24,33,32,241,37,72,54,54,63,46,241,68,54,69,52,61,58,65,51,64,50,67,53,241,63,64,69,241,68,70,65,65,64,67,69,54,53,241,51,74,241,54,73,54,52,70,69,64,67,242},47))
end
end
end,
})
MainTab:CreateInput({
Name = _d({37,50,67,56,54,69,241,20,64,64,67,53,58,63,50,69,54,68,241,249,41,253,241,42,253,241,43,250},47),
PlaceholderText = _d({22,73,50,62,65,61,54,11,241,2,3,1,255,6,253,241,5,1,255,3,253,241,254,2,1,4,1,255,1},47),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({249,44,246,53,246,255,246,254,46,252,250,246,68,251,246,253,16,246,68,251,249,44,246,53,246,255,246,254,46,252,250,246,68,251,246,253,16,246,68,251,249,44,246,53,246,255,246,254,46,252,250},47))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({44,24,33,32,241,37,72,54,54,63,46,241,36,54,69,241,53,54,68,69,58,63,50,69,58,64,63,241,69,50,67,56,54,69,241,69,64,11,241,246,255,3,55,253,241,246,255,3,55,253,241,246,255,3,55},47), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({36,69,50,67,69,241,26,68,61,50,63,53,241,37,67,50,71,54,61},47),
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
Name = _d({22,63,50,51,61,54,241,40,18,36,21,241,23,61,58,56,57,69},47),
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
Name = _d({37,67,50,71,54,61,241,247,241,23,61,58,56,57,69,241,36,65,54,54,53},47),
Range = {10, 150},
Increment = 1,
Suffix = _d({241,68,69,70,53,68,0,68,54,52},47),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({23,61,58,56,57,69,241,18,61,69,58,69,70,53,54,241,249,42,250},47),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({241,42,254,68,69,70,53,68},47),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,38,26,241,247,241,36,69,64,65,241,22,71,54,67,74,69,57,58,63,56},47),
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
print(_d({44,24,33,32,241,37,72,54,54,63,46,241,20,61,54,50,63,54,53,241,70,65,241,50,63,53,241,53,54,68,69,67,64,74,54,53,241,35,50,74,55,58,54,61,53,241,38,26,255},47))
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
print(_d({44,24,33,32,241,37,72,54,54,63,241,37,54,68,69,54,67,46,241,61,64,50,53,54,53,241,72,58,69,57,241,54,62,54,67,56,54,63,52,74,241,68,69,64,65,241,60,54,74,241,44,33,46,255},47))
end)()