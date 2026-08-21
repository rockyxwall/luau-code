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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
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
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({36,36,25,60,42,42,51,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,25,60,42,42,51,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,25,60,42,42,51,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,25,60,42,42,51,11,52,55,40,42},59)
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
local force = root:FindFirstChild(_d({36,36,25,60,42,42,51,11,52,55,40,42},59))
local att = root:FindFirstChild(_d({36,36,25,60,42,42,51,6,57,57},59))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({19,52,51,42},59)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({23,52,48,58,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,42,53,53,52},59), args)
elseif style == _d({7,49,38,40,48,17,42,44},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48},59), args)
elseif style == _d({16,38,50,46,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,38,50,46,56,45,46,48,46,12,42,53,53,52},59), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48,247},59), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({24,45,46,53,56},59))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({24,45,46,53},59))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({27,42,45,46,40,49,42,24,42,38,57},59), true) or myShip:FindFirstChildWhichIsA(_d({24,42,38,57},59), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({18,52,41,42,49},59)) then
local seat = obj:FindFirstChildWhichIsA(_d({27,42,45,46,40,49,42,24,42,38,57},59), true) or obj:FindFirstChildWhichIsA(_d({24,42,38,57},59), true)
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
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,18,52,58,51,57,42,41,229,51,42,38,55,39,62,229,39,52,38,57,229,43,52,55,229,57,55,38,59,42,49,243},59))
else
activeBoat = nil
activeSeat = nil
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,19,52,229,51,42,38,55,39,62,229,39,52,38,57,229,41,42,57,42,40,57,42,41,243,229,11,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,53,49,38,62,42,55,242,52,51,49,62,229,43,49,46,44,45,57,243},59))
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
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,24,42,38,57,229,49,52,56,57,243,229,11,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,53,49,38,62,42,55,229,43,49,46,44,45,57,243},59))
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
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,7,52,38,57,229,38,55,55,46,59,42,41,229,38,57,229,41,42,56,57,46,51,38,57,46,52,51,243},59))
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
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,21,49,38,62,42,55,229,38,55,55,46,59,42,41,229,38,57,229,41,42,56,57,46,51,38,57,46,52,51,243},59))
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
if type(obj) == _d({57,38,39,49,42},59) then
for k, v in pairs(obj) do
if type(v) == _d({58,56,42,55,41,38,57,38},59) and v:IsA(_d({25,42,61,57,17,38,39,42,49},59)) then
if v.Name:lower():find(_d({57,46,57,49,42},59)) then
v.Text = title
elseif v.Name:lower():find(_d({40,52,51,57,42,51,57},59)) or v.Name:lower():find(_d({41,42,56,40},59)) then
v.Text = content
end
end
end
elseif type(obj) == _d({58,56,42,55,41,38,57,38},59) and obj:IsA(_d({25,42,61,57,17,38,39,42,49},59)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,23,38,62,43,46,42,49,41,244,50,38,46,51,244,56,52,58,55,40,42,243,49,58,38},59)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({32,12,21,20,229,25,60,42,42,51,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,23,38,62,43,46,42,49,41,229,26,14,229,49,46,39,55,38,55,62,229,43,55,52,50,229,38,51,62,229,56,52,58,55,40,42,243},59))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({12,21,20,229,25,60,42,42,51,229,235,229,11,49,46,44,45,57,229,24,58,46,57,42},59),
LoadingTitle = _d({12,21,20,229,19,38,59,46,44,38,57,52,55},59),
LoadingSubtitle = _d({23,38,62,43,46,42,49,41,229,26,14,229,27,42,55,56,46,52,51},59),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({25,55,38,59,42,49,229,8,52,51,57,55,52,49,56},59), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({8,58,55,55,42,51,57,229,21,52,56,46,57,46,52,51},59),
Content = _d({29,255,229,245,243,245,245,229,65,229,30,255,229,245,243,245,245,229,65,229,31,255,229,245,243,245,245},59)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({29,255,229,234,243,247,43,229,65,229,30,255,229,234,243,247,43,229,65,229,31,255,229,234,243,247,43},59), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({8,58,55,55,42,51,57,229,21,52,56,46,57,46,52,51},59), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({8,52,53,62,229,8,58,55,55,42,51,57,229,8,52,52,55,41,46,51,38,57,42,56},59),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({234,243,247,43,241,229,234,243,247,43,241,229,234,243,247,43},59), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,8,52,53,46,42,41,229,40,52,52,55,41,46,51,38,57,42,56,229,57,52,229,40,49,46,53,39,52,38,55,41,255,229},59) .. text)
else
warn(_d({32,12,21,20,229,25,60,42,42,51,34,229,56,42,57,40,49,46,53,39,52,38,55,41,229,51,52,57,229,56,58,53,53,52,55,57,42,41,229,39,62,229,42,61,42,40,58,57,52,55,230},59))
end
end
end,
})
MainTab:CreateInput({
Name = _d({25,38,55,44,42,57,229,8,52,52,55,41,46,51,38,57,42,56,229,237,29,241,229,30,241,229,31,238},59),
PlaceholderText = _d({10,61,38,50,53,49,42,255,229,246,247,245,243,250,241,229,249,245,243,247,241,229,242,246,245,248,245,243,245},59),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({237,32,234,41,234,243,234,242,34,240,238,234,56,239,234,241,4,234,56,239,237,32,234,41,234,243,234,242,34,240,238,234,56,239,234,241,4,234,56,239,237,32,234,41,234,243,234,242,34,240,238},59))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({32,12,21,20,229,25,60,42,42,51,34,229,24,42,57,229,41,42,56,57,46,51,38,57,46,52,51,229,57,38,55,44,42,57,229,57,52,255,229,234,243,247,43,241,229,234,243,247,43,241,229,234,243,247,43},59), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({24,57,38,55,57,229,14,56,49,38,51,41,229,25,55,38,59,42,49},59),
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
Name = _d({10,51,38,39,49,42,229,28,6,24,9,229,11,49,46,44,45,57},59),
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
Name = _d({25,55,38,59,42,49,229,235,229,11,49,46,44,45,57,229,24,53,42,42,41},59),
Range = {10, 150},
Increment = 1,
Suffix = _d({229,56,57,58,41,56,244,56,42,40},59),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({11,49,46,44,45,57,229,6,49,57,46,57,58,41,42,229,237,30,238},59),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({229,30,242,56,57,58,41,56},59),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({9,42,56,57,55,52,62,229,26,14,229,235,229,24,57,52,53,229,10,59,42,55,62,57,45,46,51,44},59),
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
print(_d({32,12,21,20,229,25,60,42,42,51,34,229,8,49,42,38,51,42,41,229,58,53,229,38,51,41,229,41,42,56,57,55,52,62,42,41,229,23,38,62,43,46,42,49,41,229,26,14,243},59))
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
print(_d({32,12,21,20,229,25,60,42,42,51,229,25,42,56,57,42,55,34,229,49,52,38,41,42,41,229,60,46,57,45,229,42,50,42,55,44,42,51,40,62,229,56,57,52,53,229,48,42,62,229,32,21,34,243},59))
end)()