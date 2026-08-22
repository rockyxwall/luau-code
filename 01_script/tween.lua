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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({74,74,63,98,80,80,89,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,63,98,80,80,89,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,63,98,80,80,89,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,63,98,80,80,89,49,90,93,78,80},21)
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
local force = root:FindFirstChild(_d({74,74,63,98,80,80,89,49,90,93,78,80},21))
local att = root:FindFirstChild(_d({74,74,63,98,80,80,89,44,95,95},21))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({57,90,89,80},21)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({61,90,86,96,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,80,91,91,90},21), args)
elseif style == _d({45,87,76,78,86,55,80,82},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86},21), args)
elseif style == _d({54,76,88,84,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,76,88,84,94,83,84,86,84,50,80,91,91,90},21), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86,29},21), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({62,83,84,91,94},21))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({62,83,84,91},21))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({65,80,83,84,78,87,80,62,80,76,95},21), true) or myShip:FindFirstChildWhichIsA(_d({62,80,76,95},21), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({56,90,79,80,87},21)) then
local seat = obj:FindFirstChildWhichIsA(_d({65,80,83,84,78,87,80,62,80,76,95},21), true) or obj:FindFirstChildWhichIsA(_d({62,80,76,95},21), true)
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
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,56,90,96,89,95,80,79,11,89,80,76,93,77,100,11,77,90,76,95,11,81,90,93,11,95,93,76,97,80,87,25},21))
else
activeBoat = nil
activeSeat = nil
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,57,90,11,89,80,76,93,77,100,11,77,90,76,95,11,79,80,95,80,78,95,80,79,25,11,49,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,91,87,76,100,80,93,24,90,89,87,100,11,81,87,84,82,83,95,25},21))
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
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,62,80,76,95,11,87,90,94,95,25,11,49,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,91,87,76,100,80,93,11,81,87,84,82,83,95,25},21))
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
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,45,90,76,95,11,76,93,93,84,97,80,79,11,76,95,11,79,80,94,95,84,89,76,95,84,90,89,25},21))
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
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,59,87,76,100,80,93,11,76,93,93,84,97,80,79,11,76,95,11,79,80,94,95,84,89,76,95,84,90,89,25},21))
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
if type(obj) == _d({95,76,77,87,80},21) then
for k, v in pairs(obj) do
if type(v) == _d({96,94,80,93,79,76,95,76},21) and v:IsA(_d({63,80,99,95,55,76,77,80,87},21)) then
if v.Name:lower():find(_d({95,84,95,87,80},21)) then
v.Text = title
elseif v.Name:lower():find(_d({78,90,89,95,80,89,95},21)) or v.Name:lower():find(_d({79,80,94,78},21)) then
v.Text = content
end
end
end
elseif type(obj) == _d({96,94,80,93,79,76,95,76},21) and obj:IsA(_d({63,80,99,95,55,76,77,80,87},21)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,61,76,100,81,84,80,87,79,26,88,76,84,89,26,94,90,96,93,78,80,25,87,96,76},21)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({70,50,59,58,11,63,98,80,80,89,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,11,61,76,100,81,84,80,87,79,11,64,52,11,87,84,77,93,76,93,100,11,81,93,90,88,11,76,89,100,11,94,90,96,93,78,80,25},21))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({50,59,58,11,63,98,80,80,89,11,17,11,49,87,84,82,83,95,11,62,96,84,95,80},21),
LoadingTitle = _d({50,59,58,11,57,76,97,84,82,76,95,90,93},21),
LoadingSubtitle = _d({61,76,100,81,84,80,87,79,11,64,52,11,65,80,93,94,84,90,89},21),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({63,93,76,97,80,87,11,46,90,89,95,93,90,87,94},21), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({46,96,93,93,80,89,95,11,59,90,94,84,95,84,90,89},21),
Content = _d({67,37,11,27,25,27,27,11,103,11,68,37,11,27,25,27,27,11,103,11,69,37,11,27,25,27,27},21)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({67,37,11,16,25,29,81,11,103,11,68,37,11,16,25,29,81,11,103,11,69,37,11,16,25,29,81},21), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({46,96,93,93,80,89,95,11,59,90,94,84,95,84,90,89},21), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({46,90,91,100,11,46,96,93,93,80,89,95,11,46,90,90,93,79,84,89,76,95,80,94},21),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({16,25,29,81,23,11,16,25,29,81,23,11,16,25,29,81},21), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,46,90,91,84,80,79,11,78,90,90,93,79,84,89,76,95,80,94,11,95,90,11,78,87,84,91,77,90,76,93,79,37,11},21) .. text)
else
warn(_d({70,50,59,58,11,63,98,80,80,89,72,11,94,80,95,78,87,84,91,77,90,76,93,79,11,89,90,95,11,94,96,91,91,90,93,95,80,79,11,77,100,11,80,99,80,78,96,95,90,93,12},21))
end
end
end,
})
MainTab:CreateInput({
Name = _d({63,76,93,82,80,95,11,46,90,90,93,79,84,89,76,95,80,94,11,19,67,23,11,68,23,11,69,20},21),
PlaceholderText = _d({48,99,76,88,91,87,80,37,11,28,29,27,25,32,23,11,31,27,25,29,23,11,24,28,27,30,27,25,27},21),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({19,70,16,79,16,25,16,24,72,22,20,16,94,21,16,23,42,16,94,21,19,70,16,79,16,25,16,24,72,22,20,16,94,21,16,23,42,16,94,21,19,70,16,79,16,25,16,24,72,22,20},21))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({70,50,59,58,11,63,98,80,80,89,72,11,62,80,95,11,79,80,94,95,84,89,76,95,84,90,89,11,95,76,93,82,80,95,11,95,90,37,11,16,25,29,81,23,11,16,25,29,81,23,11,16,25,29,81},21), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({62,95,76,93,95,11,52,94,87,76,89,79,11,63,93,76,97,80,87},21),
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
Name = _d({48,89,76,77,87,80,11,66,44,62,47,11,49,87,84,82,83,95},21),
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
Name = _d({63,93,76,97,80,87,11,17,11,49,87,84,82,83,95,11,62,91,80,80,79},21),
Range = {10, 150},
Increment = 1,
Suffix = _d({11,94,95,96,79,94,26,94,80,78},21),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({49,87,84,82,83,95,11,44,87,95,84,95,96,79,80,11,19,68,20},21),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({11,68,24,94,95,96,79,94},21),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({47,80,94,95,93,90,100,11,64,52,11,17,11,62,95,90,91,11,48,97,80,93,100,95,83,84,89,82},21),
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
print(_d({70,50,59,58,11,63,98,80,80,89,72,11,46,87,80,76,89,80,79,11,96,91,11,76,89,79,11,79,80,94,95,93,90,100,80,79,11,61,76,100,81,84,80,87,79,11,64,52,25},21))
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
print(_d({70,50,59,58,11,63,98,80,80,89,11,63,80,94,95,80,93,72,11,87,90,76,79,80,79,11,98,84,95,83,11,80,88,80,93,82,80,89,78,100,11,94,95,90,91,11,86,80,100,11,70,59,72,25},21))
end)()