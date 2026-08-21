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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
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
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({80,80,69,104,86,86,95,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,69,104,86,86,95,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,69,104,86,86,95,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,69,104,86,86,95,55,96,99,84,86},15)
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
local force = root:FindFirstChild(_d({80,80,69,104,86,86,95,55,96,99,84,86},15))
local att = root:FindFirstChild(_d({80,80,69,104,86,86,95,50,101,101},15))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({63,96,95,86},15)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({67,96,92,102,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,86,97,97,96},15), args)
elseif style == _d({51,93,82,84,92,61,86,88},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92},15), args)
elseif style == _d({60,82,94,90,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,82,94,90,100,89,90,92,90,56,86,97,97,96},15), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92,35},15), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({68,89,90,97,100},15))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({68,89,90,97},15))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({71,86,89,90,84,93,86,68,86,82,101},15), true) or myShip:FindFirstChildWhichIsA(_d({68,86,82,101},15), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({62,96,85,86,93},15)) then
local seat = obj:FindFirstChildWhichIsA(_d({71,86,89,90,84,93,86,68,86,82,101},15), true) or obj:FindFirstChildWhichIsA(_d({68,86,82,101},15), true)
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
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,62,96,102,95,101,86,85,17,95,86,82,99,83,106,17,83,96,82,101,17,87,96,99,17,101,99,82,103,86,93,31},15))
else
activeBoat = nil
activeSeat = nil
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,63,96,17,95,86,82,99,83,106,17,83,96,82,101,17,85,86,101,86,84,101,86,85,31,17,55,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,97,93,82,106,86,99,30,96,95,93,106,17,87,93,90,88,89,101,31},15))
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
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,68,86,82,101,17,93,96,100,101,31,17,55,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,97,93,82,106,86,99,17,87,93,90,88,89,101,31},15))
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
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,51,96,82,101,17,82,99,99,90,103,86,85,17,82,101,17,85,86,100,101,90,95,82,101,90,96,95,31},15))
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
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,65,93,82,106,86,99,17,82,99,99,90,103,86,85,17,82,101,17,85,86,100,101,90,95,82,101,90,96,95,31},15))
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
if type(obj) == _d({101,82,83,93,86},15) then
for k, v in pairs(obj) do
if type(v) == _d({102,100,86,99,85,82,101,82},15) and v:IsA(_d({69,86,105,101,61,82,83,86,93},15)) then
if v.Name:lower():find(_d({101,90,101,93,86},15)) then
v.Text = title
elseif v.Name:lower():find(_d({84,96,95,101,86,95,101},15)) or v.Name:lower():find(_d({85,86,100,84},15)) then
v.Text = content
end
end
end
elseif type(obj) == _d({102,100,86,99,85,82,101,82},15) and obj:IsA(_d({69,86,105,101,61,82,83,86,93},15)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86,31,93,102,82},15)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({76,56,65,64,17,69,104,86,86,95,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,67,82,106,87,90,86,93,85,17,70,58,17,93,90,83,99,82,99,106,17,87,99,96,94,17,82,95,106,17,100,96,102,99,84,86,31},15))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({56,65,64,17,69,104,86,86,95,17,23,17,55,93,90,88,89,101,17,68,102,90,101,86},15),
LoadingTitle = _d({56,65,64,17,63,82,103,90,88,82,101,96,99},15),
LoadingSubtitle = _d({67,82,106,87,90,86,93,85,17,70,58,17,71,86,99,100,90,96,95},15),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({69,99,82,103,86,93,17,52,96,95,101,99,96,93,100},15), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({52,102,99,99,86,95,101,17,65,96,100,90,101,90,96,95},15),
Content = _d({73,43,17,33,31,33,33,17,109,17,74,43,17,33,31,33,33,17,109,17,75,43,17,33,31,33,33},15)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({73,43,17,22,31,35,87,17,109,17,74,43,17,22,31,35,87,17,109,17,75,43,17,22,31,35,87},15), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({52,102,99,99,86,95,101,17,65,96,100,90,101,90,96,95},15), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({52,96,97,106,17,52,102,99,99,86,95,101,17,52,96,96,99,85,90,95,82,101,86,100},15),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({22,31,35,87,29,17,22,31,35,87,29,17,22,31,35,87},15), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,52,96,97,90,86,85,17,84,96,96,99,85,90,95,82,101,86,100,17,101,96,17,84,93,90,97,83,96,82,99,85,43,17},15) .. text)
else
warn(_d({76,56,65,64,17,69,104,86,86,95,78,17,100,86,101,84,93,90,97,83,96,82,99,85,17,95,96,101,17,100,102,97,97,96,99,101,86,85,17,83,106,17,86,105,86,84,102,101,96,99,18},15))
end
end
end,
})
MainTab:CreateInput({
Name = _d({69,82,99,88,86,101,17,52,96,96,99,85,90,95,82,101,86,100,17,25,73,29,17,74,29,17,75,26},15),
PlaceholderText = _d({54,105,82,94,97,93,86,43,17,34,35,33,31,38,29,17,37,33,31,35,29,17,30,34,33,36,33,31,33},15),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({25,76,22,85,22,31,22,30,78,28,26,22,100,27,22,29,48,22,100,27,25,76,22,85,22,31,22,30,78,28,26,22,100,27,22,29,48,22,100,27,25,76,22,85,22,31,22,30,78,28,26},15))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({76,56,65,64,17,69,104,86,86,95,78,17,68,86,101,17,85,86,100,101,90,95,82,101,90,96,95,17,101,82,99,88,86,101,17,101,96,43,17,22,31,35,87,29,17,22,31,35,87,29,17,22,31,35,87},15), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({68,101,82,99,101,17,58,100,93,82,95,85,17,69,99,82,103,86,93},15),
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
Name = _d({54,95,82,83,93,86,17,72,50,68,53,17,55,93,90,88,89,101},15),
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
Name = _d({69,99,82,103,86,93,17,23,17,55,93,90,88,89,101,17,68,97,86,86,85},15),
Range = {10, 150},
Increment = 1,
Suffix = _d({17,100,101,102,85,100,32,100,86,84},15),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({55,93,90,88,89,101,17,50,93,101,90,101,102,85,86,17,25,74,26},15),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({17,74,30,100,101,102,85,100},15),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({53,86,100,101,99,96,106,17,70,58,17,23,17,68,101,96,97,17,54,103,86,99,106,101,89,90,95,88},15),
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
print(_d({76,56,65,64,17,69,104,86,86,95,78,17,52,93,86,82,95,86,85,17,102,97,17,82,95,85,17,85,86,100,101,99,96,106,86,85,17,67,82,106,87,90,86,93,85,17,70,58,31},15))
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
print(_d({76,56,65,64,17,69,104,86,86,95,17,69,86,100,101,86,99,78,17,93,96,82,85,86,85,17,104,90,101,89,17,86,94,86,99,88,86,95,84,106,17,100,101,96,97,17,92,86,106,17,76,65,78,31},15))
end)()