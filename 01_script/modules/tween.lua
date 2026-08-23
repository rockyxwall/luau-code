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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
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
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({58,58,47,82,64,64,73,28,79,79},37)) or Instance.new(_d({28,79,79,60,62,67,72,64,73,79},37))
att.Name = _d({58,58,47,82,64,64,73,28,79,79},37)
att.Parent = root
local force = root:FindFirstChild(_d({58,58,47,82,64,64,73,33,74,77,62,64},37))
if not force then
force = Instance.new(_d({39,68,73,64,60,77,49,64,71,74,62,68,79,84},37))
force.Name = _d({58,58,47,82,64,64,73,33,74,77,62,64},37)
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
local force = root:FindFirstChild(_d({58,58,47,82,64,64,73,33,74,77,62,64},37))
local att = root:FindFirstChild(_d({58,58,47,82,64,64,73,28,79,79},37))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({41,74,73,64},37)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({45,74,70,80,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,64,75,75,74},37), args)
elseif style == _d({29,71,60,62,70,39,64,66},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70},37), args)
elseif style == _d({38,60,72,68,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,60,72,68,78,67,68,70,68,34,64,75,75,74},37), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70,13},37), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({46,67,68,75,78},37))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({46,67,68,75},37))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({49,64,67,68,62,71,64,46,64,60,79},37), true) or myShip:FindFirstChildWhichIsA(_d({46,64,60,79},37), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({40,74,63,64,71},37)) then
local seat = obj:FindFirstChildWhichIsA(_d({49,64,67,68,62,71,64,46,64,60,79},37), true) or obj:FindFirstChildWhichIsA(_d({46,64,60,79},37), true)
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
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,40,74,80,73,79,64,63,251,73,64,60,77,61,84,251,61,74,60,79,251,65,74,77,251,79,77,60,81,64,71,9},37))
else
activeBoat = nil
activeSeat = nil
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,41,74,251,73,64,60,77,61,84,251,61,74,60,79,251,63,64,79,64,62,79,64,63,9,251,33,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,75,71,60,84,64,77,8,74,73,71,84,251,65,71,68,66,67,79,9},37))
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
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,46,64,60,79,251,71,74,78,79,9,251,33,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,75,71,60,84,64,77,251,65,71,68,66,67,79,9},37))
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
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,29,74,60,79,251,60,77,77,68,81,64,63,251,60,79,251,63,64,78,79,68,73,60,79,68,74,73,9},37))
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
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,43,71,60,84,64,77,251,60,77,77,68,81,64,63,251,60,79,251,63,64,78,79,68,73,60,79,68,74,73,9},37))
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
if type(obj) == _d({79,60,61,71,64},37) then
for k, v in pairs(obj) do
if type(v) == _d({80,78,64,77,63,60,79,60},37) and v:IsA(_d({47,64,83,79,39,60,61,64,71},37)) then
if v.Name:lower():find(_d({79,68,79,71,64},37)) then
v.Text = title
elseif v.Name:lower():find(_d({62,74,73,79,64,73,79},37)) or v.Name:lower():find(_d({63,64,78,62},37)) then
v.Text = content
end
end
end
elseif type(obj) == _d({80,78,64,77,63,60,79,60},37) and obj:IsA(_d({47,64,83,79,39,60,61,64,71},37)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({54,34,43,42,251,47,82,64,64,73,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,71,68,61,77,60,77,84,251,65,77,74,72,251,60,73,84,251,78,74,80,77,62,64,9},37))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({34,43,42,251,47,82,64,64,73,251,1,251,33,71,68,66,67,79,251,46,80,68,79,64},37),
LoadingTitle = _d({34,43,42,251,41,60,81,68,66,60,79,74,77},37),
LoadingSubtitle = _d({45,60,84,65,68,64,71,63,251,48,36,251,49,64,77,78,68,74,73},37),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({47,77,60,81,64,71,251,30,74,73,79,77,74,71,78},37), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({30,80,77,77,64,73,79,251,43,74,78,68,79,68,74,73},37),
Content = _d({51,21,251,11,9,11,11,251,87,251,52,21,251,11,9,11,11,251,87,251,53,21,251,11,9,11,11},37)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({51,21,251,0,9,13,65,251,87,251,52,21,251,0,9,13,65,251,87,251,53,21,251,0,9,13,65},37), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({30,80,77,77,64,73,79,251,43,74,78,68,79,68,74,73},37), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({30,74,75,84,251,30,80,77,77,64,73,79,251,30,74,74,77,63,68,73,60,79,64,78},37),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({0,9,13,65,7,251,0,9,13,65,7,251,0,9,13,65},37), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,30,74,75,68,64,63,251,62,74,74,77,63,68,73,60,79,64,78,251,79,74,251,62,71,68,75,61,74,60,77,63,21,251},37) .. text)
else
warn(_d({54,34,43,42,251,47,82,64,64,73,56,251,78,64,79,62,71,68,75,61,74,60,77,63,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
end
end
end,
})
MainTab:CreateInput({
Name = _d({47,60,77,66,64,79,251,30,74,74,77,63,68,73,60,79,64,78,251,3,51,7,251,52,7,251,53,4},37),
PlaceholderText = _d({32,83,60,72,75,71,64,21,251,12,13,11,9,16,7,251,15,11,9,13,7,251,8,12,11,14,11,9,11},37),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({3,54,0,63,0,9,0,8,56,6,4,0,78,5,0,7,26,0,78,5,3,54,0,63,0,9,0,8,56,6,4,0,78,5,0,7,26,0,78,5,3,54,0,63,0,9,0,8,56,6,4},37))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({54,34,43,42,251,47,82,64,64,73,56,251,46,64,79,251,63,64,78,79,68,73,60,79,68,74,73,251,79,60,77,66,64,79,251,79,74,21,251,0,9,13,65,7,251,0,9,13,65,7,251,0,9,13,65},37), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({46,79,60,77,79,251,36,78,71,60,73,63,251,47,77,60,81,64,71},37),
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
Name = _d({32,73,60,61,71,64,251,50,28,46,31,251,33,71,68,66,67,79},37),
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
Name = _d({47,77,60,81,64,71,251,1,251,33,71,68,66,67,79,251,46,75,64,64,63},37),
Range = {10, 150},
Increment = 1,
Suffix = _d({251,78,79,80,63,78,10,78,64,62},37),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({33,71,68,66,67,79,251,28,71,79,68,79,80,63,64,251,3,52,4},37),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({251,52,8,78,79,80,63,78},37),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,48,36,251,1,251,46,79,74,75,251,32,81,64,77,84,79,67,68,73,66},37),
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
print(_d({54,34,43,42,251,47,82,64,64,73,56,251,30,71,64,60,73,64,63,251,80,75,251,60,73,63,251,63,64,78,79,77,74,84,64,63,251,45,60,84,65,68,64,71,63,251,48,36,9},37))
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
print(_d({54,34,43,42,251,47,82,64,64,73,251,47,64,78,79,64,77,56,251,71,74,60,63,64,63,251,82,68,79,67,251,64,72,64,77,66,64,73,62,84,251,78,79,74,75,251,70,64,84,251,54,43,56,9},37))
end)()