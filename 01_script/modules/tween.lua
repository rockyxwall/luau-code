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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
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
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({56,56,45,80,62,62,71,26,77,77},39)) or Instance.new(_d({26,77,77,58,60,65,70,62,71,77},39))
att.Name = _d({56,56,45,80,62,62,71,26,77,77},39)
att.Parent = root
local force = root:FindFirstChild(_d({56,56,45,80,62,62,71,31,72,75,60,62},39))
if not force then
force = Instance.new(_d({37,66,71,62,58,75,47,62,69,72,60,66,77,82},39))
force.Name = _d({56,56,45,80,62,62,71,31,72,75,60,62},39)
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
local force = root:FindFirstChild(_d({56,56,45,80,62,62,71,31,72,75,60,62},39))
local att = root:FindFirstChild(_d({56,56,45,80,62,62,71,26,77,77},39))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({39,72,71,62},39)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({43,72,68,78,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,62,73,73,72},39), args)
elseif style == _d({27,69,58,60,68,37,62,64},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68},39), args)
elseif style == _d({36,58,70,66,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,58,70,66,76,65,66,68,66,32,62,73,73,72},39), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68,11},39), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({44,65,66,73,76},39))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({44,65,66,73},39))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({47,62,65,66,60,69,62,44,62,58,77},39), true) or myShip:FindFirstChildWhichIsA(_d({44,62,58,77},39), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({38,72,61,62,69},39)) then
local seat = obj:FindFirstChildWhichIsA(_d({47,62,65,66,60,69,62,44,62,58,77},39), true) or obj:FindFirstChildWhichIsA(_d({44,62,58,77},39), true)
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
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,38,72,78,71,77,62,61,249,71,62,58,75,59,82,249,59,72,58,77,249,63,72,75,249,77,75,58,79,62,69,7},39))
else
activeBoat = nil
activeSeat = nil
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,39,72,249,71,62,58,75,59,82,249,59,72,58,77,249,61,62,77,62,60,77,62,61,7,249,31,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,73,69,58,82,62,75,6,72,71,69,82,249,63,69,66,64,65,77,7},39))
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
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,44,62,58,77,249,69,72,76,77,7,249,31,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,73,69,58,82,62,75,249,63,69,66,64,65,77,7},39))
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
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,27,72,58,77,249,58,75,75,66,79,62,61,249,58,77,249,61,62,76,77,66,71,58,77,66,72,71,7},39))
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
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,41,69,58,82,62,75,249,58,75,75,66,79,62,61,249,58,77,249,61,62,76,77,66,71,58,77,66,72,71,7},39))
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
if type(obj) == _d({77,58,59,69,62},39) then
for k, v in pairs(obj) do
if type(v) == _d({78,76,62,75,61,58,77,58},39) and v:IsA(_d({45,62,81,77,37,58,59,62,69},39)) then
if v.Name:lower():find(_d({77,66,77,69,62},39)) then
v.Text = title
elseif v.Name:lower():find(_d({60,72,71,77,62,71,77},39)) or v.Name:lower():find(_d({61,62,76,60},39)) then
v.Text = content
end
end
end
elseif type(obj) == _d({78,76,62,75,61,58,77,58},39) and obj:IsA(_d({45,62,81,77,37,58,59,62,69},39)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,43,58,82,63,66,62,69,61,8,70,58,66,71,8,76,72,78,75,60,62,7,69,78,58},39)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({52,32,41,40,249,45,80,62,62,71,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,43,58,82,63,66,62,69,61,249,46,34,249,69,66,59,75,58,75,82,249,63,75,72,70,249,58,71,82,249,76,72,78,75,60,62,7},39))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({32,41,40,249,45,80,62,62,71,249,255,249,31,69,66,64,65,77,249,44,78,66,77,62},39),
LoadingTitle = _d({32,41,40,249,39,58,79,66,64,58,77,72,75},39),
LoadingSubtitle = _d({43,58,82,63,66,62,69,61,249,46,34,249,47,62,75,76,66,72,71},39),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({45,75,58,79,62,69,249,28,72,71,77,75,72,69,76},39), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({28,78,75,75,62,71,77,249,41,72,76,66,77,66,72,71},39),
Content = _d({49,19,249,9,7,9,9,249,85,249,50,19,249,9,7,9,9,249,85,249,51,19,249,9,7,9,9},39)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({49,19,249,254,7,11,63,249,85,249,50,19,249,254,7,11,63,249,85,249,51,19,249,254,7,11,63},39), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({28,78,75,75,62,71,77,249,41,72,76,66,77,66,72,71},39), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({28,72,73,82,249,28,78,75,75,62,71,77,249,28,72,72,75,61,66,71,58,77,62,76},39),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({254,7,11,63,5,249,254,7,11,63,5,249,254,7,11,63},39), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,28,72,73,66,62,61,249,60,72,72,75,61,66,71,58,77,62,76,249,77,72,249,60,69,66,73,59,72,58,75,61,19,249},39) .. text)
else
warn(_d({52,32,41,40,249,45,80,62,62,71,54,249,76,62,77,60,69,66,73,59,72,58,75,61,249,71,72,77,249,76,78,73,73,72,75,77,62,61,249,59,82,249,62,81,62,60,78,77,72,75,250},39))
end
end
end,
})
MainTab:CreateInput({
Name = _d({45,58,75,64,62,77,249,28,72,72,75,61,66,71,58,77,62,76,249,1,49,5,249,50,5,249,51,2},39),
PlaceholderText = _d({30,81,58,70,73,69,62,19,249,10,11,9,7,14,5,249,13,9,7,11,5,249,6,10,9,12,9,7,9},39),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({1,52,254,61,254,7,254,6,54,4,2,254,76,3,254,5,24,254,76,3,1,52,254,61,254,7,254,6,54,4,2,254,76,3,254,5,24,254,76,3,1,52,254,61,254,7,254,6,54,4,2},39))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({52,32,41,40,249,45,80,62,62,71,54,249,44,62,77,249,61,62,76,77,66,71,58,77,66,72,71,249,77,58,75,64,62,77,249,77,72,19,249,254,7,11,63,5,249,254,7,11,63,5,249,254,7,11,63},39), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({44,77,58,75,77,249,34,76,69,58,71,61,249,45,75,58,79,62,69},39),
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
Name = _d({30,71,58,59,69,62,249,48,26,44,29,249,31,69,66,64,65,77},39),
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
Name = _d({45,75,58,79,62,69,249,255,249,31,69,66,64,65,77,249,44,73,62,62,61},39),
Range = {10, 150},
Increment = 1,
Suffix = _d({249,76,77,78,61,76,8,76,62,60},39),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({31,69,66,64,65,77,249,26,69,77,66,77,78,61,62,249,1,50,2},39),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({249,50,6,76,77,78,61,76},39),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({29,62,76,77,75,72,82,249,46,34,249,255,249,44,77,72,73,249,30,79,62,75,82,77,65,66,71,64},39),
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
print(_d({52,32,41,40,249,45,80,62,62,71,54,249,28,69,62,58,71,62,61,249,78,73,249,58,71,61,249,61,62,76,77,75,72,82,62,61,249,43,58,82,63,66,62,69,61,249,46,34,7},39))
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
print(_d({52,32,41,40,249,45,80,62,62,71,249,45,62,76,77,62,75,54,249,69,72,58,61,62,61,249,80,66,77,65,249,62,70,62,75,64,62,71,60,82,249,76,77,72,73,249,68,62,82,249,52,41,54,7},39))
end)()