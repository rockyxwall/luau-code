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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
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
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({62,62,51,86,68,68,77,32,83,83},33)) or Instance.new(_d({32,83,83,64,66,71,76,68,77,83},33))
att.Name = _d({62,62,51,86,68,68,77,32,83,83},33)
att.Parent = root
local force = root:FindFirstChild(_d({62,62,51,86,68,68,77,37,78,81,66,68},33))
if not force then
force = Instance.new(_d({43,72,77,68,64,81,53,68,75,78,66,72,83,88},33))
force.Name = _d({62,62,51,86,68,68,77,37,78,81,66,68},33)
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
local force = root:FindFirstChild(_d({62,62,51,86,68,68,77,37,78,81,66,68},33))
local att = root:FindFirstChild(_d({62,62,51,86,68,68,77,32,83,83},33))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({45,78,77,68},33)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({49,78,74,84,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,68,79,79,78},33), args)
elseif style == _d({33,75,64,66,74,43,68,70},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74},33), args)
elseif style == _d({42,64,76,72,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,64,76,72,82,71,72,74,72,38,68,79,79,78},33), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74,17},33), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({50,71,72,79,82},33))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({50,71,72,79},33))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({53,68,71,72,66,75,68,50,68,64,83},33), true) or myShip:FindFirstChildWhichIsA(_d({50,68,64,83},33), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({44,78,67,68,75},33)) then
local seat = obj:FindFirstChildWhichIsA(_d({53,68,71,72,66,75,68,50,68,64,83},33), true) or obj:FindFirstChildWhichIsA(_d({50,68,64,83},33), true)
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
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,44,78,84,77,83,68,67,255,77,68,64,81,65,88,255,65,78,64,83,255,69,78,81,255,83,81,64,85,68,75,13},33))
else
activeBoat = nil
activeSeat = nil
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,45,78,255,77,68,64,81,65,88,255,65,78,64,83,255,67,68,83,68,66,83,68,67,13,255,37,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,79,75,64,88,68,81,12,78,77,75,88,255,69,75,72,70,71,83,13},33))
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
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,50,68,64,83,255,75,78,82,83,13,255,37,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,79,75,64,88,68,81,255,69,75,72,70,71,83,13},33))
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
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,33,78,64,83,255,64,81,81,72,85,68,67,255,64,83,255,67,68,82,83,72,77,64,83,72,78,77,13},33))
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
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,47,75,64,88,68,81,255,64,81,81,72,85,68,67,255,64,83,255,67,68,82,83,72,77,64,83,72,78,77,13},33))
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
if type(obj) == _d({83,64,65,75,68},33) then
for k, v in pairs(obj) do
if type(v) == _d({84,82,68,81,67,64,83,64},33) and v:IsA(_d({51,68,87,83,43,64,65,68,75},33)) then
if v.Name:lower():find(_d({83,72,83,75,68},33)) then
v.Text = title
elseif v.Name:lower():find(_d({66,78,77,83,68,77,83},33)) or v.Name:lower():find(_d({67,68,82,66},33)) then
v.Text = content
end
end
end
elseif type(obj) == _d({84,82,68,81,67,64,83,64},33) and obj:IsA(_d({51,68,87,83,43,64,65,68,75},33)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68,13,75,84,64},33)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({58,38,47,46,255,51,86,68,68,77,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,49,64,88,69,72,68,75,67,255,52,40,255,75,72,65,81,64,81,88,255,69,81,78,76,255,64,77,88,255,82,78,84,81,66,68,13},33))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({38,47,46,255,51,86,68,68,77,255,5,255,37,75,72,70,71,83,255,50,84,72,83,68},33),
LoadingTitle = _d({38,47,46,255,45,64,85,72,70,64,83,78,81},33),
LoadingSubtitle = _d({49,64,88,69,72,68,75,67,255,52,40,255,53,68,81,82,72,78,77},33),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({51,81,64,85,68,75,255,34,78,77,83,81,78,75,82},33), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({34,84,81,81,68,77,83,255,47,78,82,72,83,72,78,77},33),
Content = _d({55,25,255,15,13,15,15,255,91,255,56,25,255,15,13,15,15,255,91,255,57,25,255,15,13,15,15},33)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({55,25,255,4,13,17,69,255,91,255,56,25,255,4,13,17,69,255,91,255,57,25,255,4,13,17,69},33), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({34,84,81,81,68,77,83,255,47,78,82,72,83,72,78,77},33), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({34,78,79,88,255,34,84,81,81,68,77,83,255,34,78,78,81,67,72,77,64,83,68,82},33),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({4,13,17,69,11,255,4,13,17,69,11,255,4,13,17,69},33), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,34,78,79,72,68,67,255,66,78,78,81,67,72,77,64,83,68,82,255,83,78,255,66,75,72,79,65,78,64,81,67,25,255},33) .. text)
else
warn(_d({58,38,47,46,255,51,86,68,68,77,60,255,82,68,83,66,75,72,79,65,78,64,81,67,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
end
end
end,
})
MainTab:CreateInput({
Name = _d({51,64,81,70,68,83,255,34,78,78,81,67,72,77,64,83,68,82,255,7,55,11,255,56,11,255,57,8},33),
PlaceholderText = _d({36,87,64,76,79,75,68,25,255,16,17,15,13,20,11,255,19,15,13,17,11,255,12,16,15,18,15,13,15},33),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({7,58,4,67,4,13,4,12,60,10,8,4,82,9,4,11,30,4,82,9,7,58,4,67,4,13,4,12,60,10,8,4,82,9,4,11,30,4,82,9,7,58,4,67,4,13,4,12,60,10,8},33))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({58,38,47,46,255,51,86,68,68,77,60,255,50,68,83,255,67,68,82,83,72,77,64,83,72,78,77,255,83,64,81,70,68,83,255,83,78,25,255,4,13,17,69,11,255,4,13,17,69,11,255,4,13,17,69},33), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({50,83,64,81,83,255,40,82,75,64,77,67,255,51,81,64,85,68,75},33),
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
Name = _d({36,77,64,65,75,68,255,54,32,50,35,255,37,75,72,70,71,83},33),
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
Name = _d({51,81,64,85,68,75,255,5,255,37,75,72,70,71,83,255,50,79,68,68,67},33),
Range = {10, 150},
Increment = 1,
Suffix = _d({255,82,83,84,67,82,14,82,68,66},33),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({37,75,72,70,71,83,255,32,75,83,72,83,84,67,68,255,7,56,8},33),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({255,56,12,82,83,84,67,82},33),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({35,68,82,83,81,78,88,255,52,40,255,5,255,50,83,78,79,255,36,85,68,81,88,83,71,72,77,70},33),
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
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,34,75,68,64,77,68,67,255,84,79,255,64,77,67,255,67,68,82,83,81,78,88,68,67,255,49,64,88,69,72,68,75,67,255,52,40,13},33))
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
print(_d({58,38,47,46,255,51,86,68,68,77,255,51,68,82,83,68,81,60,255,75,78,64,67,68,67,255,86,72,83,71,255,68,76,68,81,70,68,77,66,88,255,82,83,78,79,255,74,68,88,255,58,47,60,13},33))
end)()