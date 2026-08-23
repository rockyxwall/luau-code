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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({64,64,53,88,70,70,79,34,85,85},31)) or Instance.new(_d({34,85,85,66,68,73,78,70,79,85},31))
att.Name = _d({64,64,53,88,70,70,79,34,85,85},31)
att.Parent = root
local force = root:FindFirstChild(_d({64,64,53,88,70,70,79,39,80,83,68,70},31))
if not force then
force = Instance.new(_d({45,74,79,70,66,83,55,70,77,80,68,74,85,90},31))
force.Name = _d({64,64,53,88,70,70,79,39,80,83,68,70},31)
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
local force = root:FindFirstChild(_d({64,64,53,88,70,70,79,39,80,83,68,70},31))
local att = root:FindFirstChild(_d({64,64,53,88,70,70,79,34,85,85},31))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({47,80,79,70},31)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({51,80,76,86,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,70,81,81,80},31), args)
elseif style == _d({35,77,66,68,76,45,70,72},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76},31), args)
elseif style == _d({44,66,78,74,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,66,78,74,84,73,74,76,74,40,70,81,81,80},31), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76,19},31), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({52,73,74,81,84},31))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({52,73,74,81},31))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({55,70,73,74,68,77,70,52,70,66,85},31), true) or myShip:FindFirstChildWhichIsA(_d({52,70,66,85},31), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({46,80,69,70,77},31)) then
local seat = obj:FindFirstChildWhichIsA(_d({55,70,73,74,68,77,70,52,70,66,85},31), true) or obj:FindFirstChildWhichIsA(_d({52,70,66,85},31), true)
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
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,46,80,86,79,85,70,69,1,79,70,66,83,67,90,1,67,80,66,85,1,71,80,83,1,85,83,66,87,70,77,15},31))
else
activeBoat = nil
activeSeat = nil
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,47,80,1,79,70,66,83,67,90,1,67,80,66,85,1,69,70,85,70,68,85,70,69,15,1,39,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,81,77,66,90,70,83,14,80,79,77,90,1,71,77,74,72,73,85,15},31))
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
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,52,70,66,85,1,77,80,84,85,15,1,39,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,81,77,66,90,70,83,1,71,77,74,72,73,85,15},31))
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
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,35,80,66,85,1,66,83,83,74,87,70,69,1,66,85,1,69,70,84,85,74,79,66,85,74,80,79,15},31))
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
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,49,77,66,90,70,83,1,66,83,83,74,87,70,69,1,66,85,1,69,70,84,85,74,79,66,85,74,80,79,15},31))
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
if type(obj) == _d({85,66,67,77,70},31) then
for k, v in pairs(obj) do
if type(v) == _d({86,84,70,83,69,66,85,66},31) and v:IsA(_d({53,70,89,85,45,66,67,70,77},31)) then
if v.Name:lower():find(_d({85,74,85,77,70},31)) then
v.Text = title
elseif v.Name:lower():find(_d({68,80,79,85,70,79,85},31)) or v.Name:lower():find(_d({69,70,84,68},31)) then
v.Text = content
end
end
end
elseif type(obj) == _d({86,84,70,83,69,66,85,66},31) and obj:IsA(_d({53,70,89,85,45,66,67,70,77},31)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,51,66,90,71,74,70,77,69,16,78,66,74,79,16,84,80,86,83,68,70,15,77,86,66},31)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({60,40,49,48,1,53,88,70,70,79,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,51,66,90,71,74,70,77,69,1,54,42,1,77,74,67,83,66,83,90,1,71,83,80,78,1,66,79,90,1,84,80,86,83,68,70,15},31))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({40,49,48,1,53,88,70,70,79,1,7,1,39,77,74,72,73,85,1,52,86,74,85,70},31),
LoadingTitle = _d({40,49,48,1,47,66,87,74,72,66,85,80,83},31),
LoadingSubtitle = _d({51,66,90,71,74,70,77,69,1,54,42,1,55,70,83,84,74,80,79},31),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({53,83,66,87,70,77,1,36,80,79,85,83,80,77,84},31), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({36,86,83,83,70,79,85,1,49,80,84,74,85,74,80,79},31),
Content = _d({57,27,1,17,15,17,17,1,93,1,58,27,1,17,15,17,17,1,93,1,59,27,1,17,15,17,17},31)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({57,27,1,6,15,19,71,1,93,1,58,27,1,6,15,19,71,1,93,1,59,27,1,6,15,19,71},31), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({36,86,83,83,70,79,85,1,49,80,84,74,85,74,80,79},31), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({36,80,81,90,1,36,86,83,83,70,79,85,1,36,80,80,83,69,74,79,66,85,70,84},31),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({6,15,19,71,13,1,6,15,19,71,13,1,6,15,19,71},31), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,36,80,81,74,70,69,1,68,80,80,83,69,74,79,66,85,70,84,1,85,80,1,68,77,74,81,67,80,66,83,69,27,1},31) .. text)
else
warn(_d({60,40,49,48,1,53,88,70,70,79,62,1,84,70,85,68,77,74,81,67,80,66,83,69,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,70,89,70,68,86,85,80,83,2},31))
end
end
end,
})
MainTab:CreateInput({
Name = _d({53,66,83,72,70,85,1,36,80,80,83,69,74,79,66,85,70,84,1,9,57,13,1,58,13,1,59,10},31),
PlaceholderText = _d({38,89,66,78,81,77,70,27,1,18,19,17,15,22,13,1,21,17,15,19,13,1,14,18,17,20,17,15,17},31),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({9,60,6,69,6,15,6,14,62,12,10,6,84,11,6,13,32,6,84,11,9,60,6,69,6,15,6,14,62,12,10,6,84,11,6,13,32,6,84,11,9,60,6,69,6,15,6,14,62,12,10},31))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({60,40,49,48,1,53,88,70,70,79,62,1,52,70,85,1,69,70,84,85,74,79,66,85,74,80,79,1,85,66,83,72,70,85,1,85,80,27,1,6,15,19,71,13,1,6,15,19,71,13,1,6,15,19,71},31), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({52,85,66,83,85,1,42,84,77,66,79,69,1,53,83,66,87,70,77},31),
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
Name = _d({38,79,66,67,77,70,1,56,34,52,37,1,39,77,74,72,73,85},31),
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
Name = _d({53,83,66,87,70,77,1,7,1,39,77,74,72,73,85,1,52,81,70,70,69},31),
Range = {10, 150},
Increment = 1,
Suffix = _d({1,84,85,86,69,84,16,84,70,68},31),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({39,77,74,72,73,85,1,34,77,85,74,85,86,69,70,1,9,58,10},31),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({1,58,14,84,85,86,69,84},31),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({37,70,84,85,83,80,90,1,54,42,1,7,1,52,85,80,81,1,38,87,70,83,90,85,73,74,79,72},31),
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
print(_d({60,40,49,48,1,53,88,70,70,79,62,1,36,77,70,66,79,70,69,1,86,81,1,66,79,69,1,69,70,84,85,83,80,90,70,69,1,51,66,90,71,74,70,77,69,1,54,42,15},31))
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
print(_d({60,40,49,48,1,53,88,70,70,79,1,53,70,84,85,70,83,62,1,77,80,66,69,70,69,1,88,74,85,73,1,70,78,70,83,72,70,79,68,90,1,84,85,80,81,1,76,70,90,1,60,49,62,15},31))
end)()