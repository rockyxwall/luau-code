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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local RunService = game:GetService(_d({33,68,61,34,52,65,69,56,50,52},49))
local UserInputService = game:GetService(_d({36,66,52,65,24,61,63,68,67,34,52,65,69,56,50,52},49))
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
return char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({46,46,35,70,52,52,61,16,67,67},49)) or Instance.new(_d({16,67,67,48,50,55,60,52,61,67},49))
att.Name = _d({46,46,35,70,52,52,61,16,67,67},49)
att.Parent = root
local force = root:FindFirstChild(_d({46,46,35,70,52,52,61,21,62,65,50,52},49))
if not force then
force = Instance.new(_d({27,56,61,52,48,65,37,52,59,62,50,56,67,72},49))
force.Name = _d({46,46,35,70,52,52,61,21,62,65,50,52},49)
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
local force = root:FindFirstChild(_d({46,46,35,70,52,52,61,21,62,65,50,52},49))
local att = root:FindFirstChild(_d({46,46,35,70,52,52,61,16,67,67},49))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({34,67,48,67,66},49) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({29,62,61,52},49)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({33,62,58,68,66,55,56,58,56},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,52,63,63,62},49), args)
elseif style == _d({17,59,48,50,58,27,52,54},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,58,72,239,38,48,59,58},49), args)
elseif style == _d({26,48,60,56,66,55,56,58,56},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,48,60,56,66,55,56,58,56,22,52,63,63,62},49), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,58,72,239,38,48,59,58,1},49), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({34,55,56,63,66},49))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({34,55,56,63},49))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({37,52,55,56,50,59,52,34,52,48,67},49), true) or myShip:FindFirstChildWhichIsA(_d({34,52,48,67},49), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({28,62,51,52,59},49)) then
local seat = obj:FindFirstChildWhichIsA(_d({37,52,55,56,50,59,52,34,52,48,67},49), true) or obj:FindFirstChildWhichIsA(_d({34,52,48,67},49), true)
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
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,28,62,68,61,67,52,51,239,61,52,48,65,49,72,239,49,62,48,67,239,53,62,65,239,67,65,48,69,52,59,253},49))
else
activeBoat = nil
activeSeat = nil
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,29,62,239,61,52,48,65,49,72,239,49,62,48,67,239,51,52,67,52,50,67,52,51,253,239,21,48,59,59,56,61,54,239,49,48,50,58,239,67,62,239,63,59,48,72,52,65,252,62,61,59,72,239,53,59,56,54,55,67,253},49))
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
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,34,52,48,67,239,59,62,66,67,253,239,21,48,59,59,56,61,54,239,49,48,50,58,239,67,62,239,63,59,48,72,52,65,239,53,59,56,54,55,67,253},49))
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
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,17,62,48,67,239,48,65,65,56,69,52,51,239,48,67,239,51,52,66,67,56,61,48,67,56,62,61,253},49))
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
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,31,59,48,72,52,65,239,48,65,65,56,69,52,51,239,48,67,239,51,52,66,67,56,61,48,67,56,62,61,253},49))
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
if type(obj) == _d({67,48,49,59,52},49) then
for k, v in pairs(obj) do
if type(v) == _d({68,66,52,65,51,48,67,48},49) and v:IsA(_d({35,52,71,67,27,48,49,52,59},49)) then
if v.Name:lower():find(_d({67,56,67,59,52},49)) then
v.Text = title
elseif v.Name:lower():find(_d({50,62,61,67,52,61,67},49)) or v.Name:lower():find(_d({51,52,66,50},49)) then
v.Text = content
end
end
end
elseif type(obj) == _d({68,66,52,65,51,48,67,48},49) and obj:IsA(_d({35,52,71,67,27,48,49,52,59},49)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,33,48,72,53,56,52,59,51,254,60,48,56,61,254,66,62,68,65,50,52,253,59,68,48},49)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({42,22,31,30,239,35,70,52,52,61,44,239,21,48,56,59,52,51,239,67,62,239,59,62,48,51,239,33,48,72,53,56,52,59,51,239,36,24,239,59,56,49,65,48,65,72,239,53,65,62,60,239,48,61,72,239,66,62,68,65,50,52,253},49))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({22,31,30,239,35,70,52,52,61,239,245,239,21,59,56,54,55,67,239,34,68,56,67,52},49),
LoadingTitle = _d({22,31,30,239,29,48,69,56,54,48,67,62,65},49),
LoadingSubtitle = _d({33,48,72,53,56,52,59,51,239,36,24,239,37,52,65,66,56,62,61},49),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({35,65,48,69,52,59,239,18,62,61,67,65,62,59,66},49), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({18,68,65,65,52,61,67,239,31,62,66,56,67,56,62,61},49),
Content = _d({39,9,239,255,253,255,255,239,75,239,40,9,239,255,253,255,255,239,75,239,41,9,239,255,253,255,255},49)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({39,9,239,244,253,1,53,239,75,239,40,9,239,244,253,1,53,239,75,239,41,9,239,244,253,1,53},49), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({18,68,65,65,52,61,67,239,31,62,66,56,67,56,62,61},49), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({18,62,63,72,239,18,68,65,65,52,61,67,239,18,62,62,65,51,56,61,48,67,52,66},49),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({244,253,1,53,251,239,244,253,1,53,251,239,244,253,1,53},49), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,18,62,63,56,52,51,239,50,62,62,65,51,56,61,48,67,52,66,239,67,62,239,50,59,56,63,49,62,48,65,51,9,239},49) .. text)
else
warn(_d({42,22,31,30,239,35,70,52,52,61,44,239,66,52,67,50,59,56,63,49,62,48,65,51,239,61,62,67,239,66,68,63,63,62,65,67,52,51,239,49,72,239,52,71,52,50,68,67,62,65,240},49))
end
end
end,
})
MainTab:CreateInput({
Name = _d({35,48,65,54,52,67,239,18,62,62,65,51,56,61,48,67,52,66,239,247,39,251,239,40,251,239,41,248},49),
PlaceholderText = _d({20,71,48,60,63,59,52,9,239,0,1,255,253,4,251,239,3,255,253,1,251,239,252,0,255,2,255,253,255},49),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({247,42,244,51,244,253,244,252,44,250,248,244,66,249,244,251,14,244,66,249,247,42,244,51,244,253,244,252,44,250,248,244,66,249,244,251,14,244,66,249,247,42,244,51,244,253,244,252,44,250,248},49))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({42,22,31,30,239,35,70,52,52,61,44,239,34,52,67,239,51,52,66,67,56,61,48,67,56,62,61,239,67,48,65,54,52,67,239,67,62,9,239,244,253,1,53,251,239,244,253,1,53,251,239,244,253,1,53},49), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({34,67,48,65,67,239,24,66,59,48,61,51,239,35,65,48,69,52,59},49),
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
Name = _d({20,61,48,49,59,52,239,38,16,34,19,239,21,59,56,54,55,67},49),
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
Name = _d({35,65,48,69,52,59,239,245,239,21,59,56,54,55,67,239,34,63,52,52,51},49),
Range = {10, 150},
Increment = 1,
Suffix = _d({239,66,67,68,51,66,254,66,52,50},49),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({21,59,56,54,55,67,239,16,59,67,56,67,68,51,52,239,247,40,248},49),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({239,40,252,66,67,68,51,66},49),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({19,52,66,67,65,62,72,239,36,24,239,245,239,34,67,62,63,239,20,69,52,65,72,67,55,56,61,54},49),
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
print(_d({42,22,31,30,239,35,70,52,52,61,44,239,18,59,52,48,61,52,51,239,68,63,239,48,61,51,239,51,52,66,67,65,62,72,52,51,239,33,48,72,53,56,52,59,51,239,36,24,253},49))
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
print(_d({42,22,31,30,239,35,70,52,52,61,239,35,52,66,67,52,65,44,239,59,62,48,51,52,51,239,70,56,67,55,239,52,60,52,65,54,52,61,50,72,239,66,67,62,63,239,58,52,72,239,42,31,44,253},49))
end)()