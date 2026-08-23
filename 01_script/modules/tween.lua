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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({71,71,60,95,77,77,86,41,92,92},24)) or Instance.new(_d({41,92,92,73,75,80,85,77,86,92},24))
att.Name = _d({71,71,60,95,77,77,86,41,92,92},24)
att.Parent = root
local force = root:FindFirstChild(_d({71,71,60,95,77,77,86,46,87,90,75,77},24))
if not force then
force = Instance.new(_d({52,81,86,77,73,90,62,77,84,87,75,81,92,97},24))
force.Name = _d({71,71,60,95,77,77,86,46,87,90,75,77},24)
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
local force = root:FindFirstChild(_d({71,71,60,95,77,77,86,46,87,90,75,77},24))
local att = root:FindFirstChild(_d({71,71,60,95,77,77,86,41,92,92},24))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({54,87,86,77},24)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({58,87,83,93,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,77,88,88,87},24), args)
elseif style == _d({42,84,73,75,83,52,77,79},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83},24), args)
elseif style == _d({51,73,85,81,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,73,85,81,91,80,81,83,81,47,77,88,88,87},24), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83,26},24), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({59,80,81,88,91},24))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({59,80,81,88},24))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({62,77,80,81,75,84,77,59,77,73,92},24), true) or myShip:FindFirstChildWhichIsA(_d({59,77,73,92},24), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({53,87,76,77,84},24)) then
local seat = obj:FindFirstChildWhichIsA(_d({62,77,80,81,75,84,77,59,77,73,92},24), true) or obj:FindFirstChildWhichIsA(_d({59,77,73,92},24), true)
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
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,53,87,93,86,92,77,76,8,86,77,73,90,74,97,8,74,87,73,92,8,78,87,90,8,92,90,73,94,77,84,22},24))
else
activeBoat = nil
activeSeat = nil
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,54,87,8,86,77,73,90,74,97,8,74,87,73,92,8,76,77,92,77,75,92,77,76,22,8,46,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,88,84,73,97,77,90,21,87,86,84,97,8,78,84,81,79,80,92,22},24))
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
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,59,77,73,92,8,84,87,91,92,22,8,46,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,88,84,73,97,77,90,8,78,84,81,79,80,92,22},24))
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
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,42,87,73,92,8,73,90,90,81,94,77,76,8,73,92,8,76,77,91,92,81,86,73,92,81,87,86,22},24))
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
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,56,84,73,97,77,90,8,73,90,90,81,94,77,76,8,73,92,8,76,77,91,92,81,86,73,92,81,87,86,22},24))
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
if type(obj) == _d({92,73,74,84,77},24) then
for k, v in pairs(obj) do
if type(v) == _d({93,91,77,90,76,73,92,73},24) and v:IsA(_d({60,77,96,92,52,73,74,77,84},24)) then
if v.Name:lower():find(_d({92,81,92,84,77},24)) then
v.Text = title
elseif v.Name:lower():find(_d({75,87,86,92,77,86,92},24)) or v.Name:lower():find(_d({76,77,91,75},24)) then
v.Text = content
end
end
end
elseif type(obj) == _d({93,91,77,90,76,73,92,73},24) and obj:IsA(_d({60,77,96,92,52,73,74,77,84},24)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({67,47,56,55,8,60,95,77,77,86,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,84,81,74,90,73,90,97,8,78,90,87,85,8,73,86,97,8,91,87,93,90,75,77,22},24))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({47,56,55,8,60,95,77,77,86,8,14,8,46,84,81,79,80,92,8,59,93,81,92,77},24),
LoadingTitle = _d({47,56,55,8,54,73,94,81,79,73,92,87,90},24),
LoadingSubtitle = _d({58,73,97,78,81,77,84,76,8,61,49,8,62,77,90,91,81,87,86},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({60,90,73,94,77,84,8,43,87,86,92,90,87,84,91},24), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({43,93,90,90,77,86,92,8,56,87,91,81,92,81,87,86},24),
Content = _d({64,34,8,24,22,24,24,8,100,8,65,34,8,24,22,24,24,8,100,8,66,34,8,24,22,24,24},24)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({64,34,8,13,22,26,78,8,100,8,65,34,8,13,22,26,78,8,100,8,66,34,8,13,22,26,78},24), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({43,93,90,90,77,86,92,8,56,87,91,81,92,81,87,86},24), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({43,87,88,97,8,43,93,90,90,77,86,92,8,43,87,87,90,76,81,86,73,92,77,91},24),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({13,22,26,78,20,8,13,22,26,78,20,8,13,22,26,78},24), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,43,87,88,81,77,76,8,75,87,87,90,76,81,86,73,92,77,91,8,92,87,8,75,84,81,88,74,87,73,90,76,34,8},24) .. text)
else
warn(_d({67,47,56,55,8,60,95,77,77,86,69,8,91,77,92,75,84,81,88,74,87,73,90,76,8,86,87,92,8,91,93,88,88,87,90,92,77,76,8,74,97,8,77,96,77,75,93,92,87,90,9},24))
end
end
end,
})
MainTab:CreateInput({
Name = _d({60,73,90,79,77,92,8,43,87,87,90,76,81,86,73,92,77,91,8,16,64,20,8,65,20,8,66,17},24),
PlaceholderText = _d({45,96,73,85,88,84,77,34,8,25,26,24,22,29,20,8,28,24,22,26,20,8,21,25,24,27,24,22,24},24),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({16,67,13,76,13,22,13,21,69,19,17,13,91,18,13,20,39,13,91,18,16,67,13,76,13,22,13,21,69,19,17,13,91,18,13,20,39,13,91,18,16,67,13,76,13,22,13,21,69,19,17},24))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({67,47,56,55,8,60,95,77,77,86,69,8,59,77,92,8,76,77,91,92,81,86,73,92,81,87,86,8,92,73,90,79,77,92,8,92,87,34,8,13,22,26,78,20,8,13,22,26,78,20,8,13,22,26,78},24), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({59,92,73,90,92,8,49,91,84,73,86,76,8,60,90,73,94,77,84},24),
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
Name = _d({45,86,73,74,84,77,8,63,41,59,44,8,46,84,81,79,80,92},24),
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
Name = _d({60,90,73,94,77,84,8,14,8,46,84,81,79,80,92,8,59,88,77,77,76},24),
Range = {10, 150},
Increment = 1,
Suffix = _d({8,91,92,93,76,91,23,91,77,75},24),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({46,84,81,79,80,92,8,41,84,92,81,92,93,76,77,8,16,65,17},24),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({8,65,21,91,92,93,76,91},24),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49,8,14,8,59,92,87,88,8,45,94,77,90,97,92,80,81,86,79},24),
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
print(_d({67,47,56,55,8,60,95,77,77,86,69,8,43,84,77,73,86,77,76,8,93,88,8,73,86,76,8,76,77,91,92,90,87,97,77,76,8,58,73,97,78,81,77,84,76,8,61,49,22},24))
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
print(_d({67,47,56,55,8,60,95,77,77,86,8,60,77,91,92,77,90,69,8,84,87,73,76,77,76,8,95,81,92,80,8,77,85,77,90,79,77,86,75,97,8,91,92,87,88,8,83,77,97,8,67,56,69,22},24))
end)()