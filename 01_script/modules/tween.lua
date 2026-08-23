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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
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
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({57,57,46,81,63,63,72,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,46,81,63,63,72,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,46,81,63,63,72,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,46,81,63,63,72,32,73,76,61,63},38)
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
local force = root:FindFirstChild(_d({57,57,46,81,63,63,72,32,73,76,61,63},38))
local att = root:FindFirstChild(_d({57,57,46,81,63,63,72,27,78,78},38))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({40,73,72,63},38)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({44,73,69,79,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,63,74,74,73},38), args)
elseif style == _d({28,70,59,61,69,38,63,65},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69},38), args)
elseif style == _d({37,59,71,67,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,59,71,67,77,66,67,69,67,33,63,74,74,73},38), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69,12},38), args)
end
end)
end
local function findNearbyBoat()
local root = getRoot()
if not root then return nil, nil end
local shipsFolder = Workspace:FindFirstChild(_d({45,66,67,74,77},38))
if shipsFolder then
local myShip = shipsFolder:FindFirstChild(LocalPlayer.Name .. _d({45,66,67,74},38))
if myShip then
local seat = myShip:FindFirstChildWhichIsA(_d({48,63,66,67,61,70,63,45,63,59,78},38), true) or myShip:FindFirstChildWhichIsA(_d({45,63,59,78},38), true)
if seat then
return myShip, seat
end
end
end
for _, obj in ipairs(Workspace:GetChildren()) do
if obj:IsA(_d({39,73,62,63,70},38)) then
local seat = obj:FindFirstChildWhichIsA(_d({48,63,66,67,61,70,63,45,63,59,78},38), true) or obj:FindFirstChildWhichIsA(_d({45,63,59,78},38), true)
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
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,39,73,79,72,78,63,62,250,72,63,59,76,60,83,250,60,73,59,78,250,64,73,76,250,78,76,59,80,63,70,8},38))
else
activeBoat = nil
activeSeat = nil
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,40,73,250,72,63,59,76,60,83,250,60,73,59,78,250,62,63,78,63,61,78,63,62,8,250,32,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,74,70,59,83,63,76,7,73,72,70,83,250,64,70,67,65,66,78,8},38))
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
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,45,63,59,78,250,70,73,77,78,8,250,32,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,74,70,59,83,63,76,250,64,70,67,65,66,78,8},38))
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
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,28,73,59,78,250,59,76,76,67,80,63,62,250,59,78,250,62,63,77,78,67,72,59,78,67,73,72,8},38))
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
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,42,70,59,83,63,76,250,59,76,76,67,80,63,62,250,59,78,250,62,63,77,78,67,72,59,78,67,73,72,8},38))
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
if type(obj) == _d({78,59,60,70,63},38) then
for k, v in pairs(obj) do
if type(v) == _d({79,77,63,76,62,59,78,59},38) and v:IsA(_d({46,63,82,78,38,59,60,63,70},38)) then
if v.Name:lower():find(_d({78,67,78,70,63},38)) then
v.Text = title
elseif v.Name:lower():find(_d({61,73,72,78,63,72,78},38)) or v.Name:lower():find(_d({62,63,77,61},38)) then
v.Text = content
end
end
end
elseif type(obj) == _d({79,77,63,76,62,59,78,59},38) and obj:IsA(_d({46,63,82,78,38,59,60,63,70},38)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63,8,70,79,59},38)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({53,33,42,41,250,46,81,63,63,72,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,44,59,83,64,67,63,70,62,250,47,35,250,70,67,60,76,59,76,83,250,64,76,73,71,250,59,72,83,250,77,73,79,76,61,63,8},38))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({33,42,41,250,46,81,63,63,72,250,0,250,32,70,67,65,66,78,250,45,79,67,78,63},38),
LoadingTitle = _d({33,42,41,250,40,59,80,67,65,59,78,73,76},38),
LoadingSubtitle = _d({44,59,83,64,67,63,70,62,250,47,35,250,48,63,76,77,67,73,72},38),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({46,76,59,80,63,70,250,29,73,72,78,76,73,70,77},38), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({29,79,76,76,63,72,78,250,42,73,77,67,78,67,73,72},38),
Content = _d({50,20,250,10,8,10,10,250,86,250,51,20,250,10,8,10,10,250,86,250,52,20,250,10,8,10,10},38)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({50,20,250,255,8,12,64,250,86,250,51,20,250,255,8,12,64,250,86,250,52,20,250,255,8,12,64},38), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({29,79,76,76,63,72,78,250,42,73,77,67,78,67,73,72},38), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({29,73,74,83,250,29,79,76,76,63,72,78,250,29,73,73,76,62,67,72,59,78,63,77},38),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({255,8,12,64,6,250,255,8,12,64,6,250,255,8,12,64},38), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,29,73,74,67,63,62,250,61,73,73,76,62,67,72,59,78,63,77,250,78,73,250,61,70,67,74,60,73,59,76,62,20,250},38) .. text)
else
warn(_d({53,33,42,41,250,46,81,63,63,72,55,250,77,63,78,61,70,67,74,60,73,59,76,62,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,63,82,63,61,79,78,73,76,251},38))
end
end
end,
})
MainTab:CreateInput({
Name = _d({46,59,76,65,63,78,250,29,73,73,76,62,67,72,59,78,63,77,250,2,50,6,250,51,6,250,52,3},38),
PlaceholderText = _d({31,82,59,71,74,70,63,20,250,11,12,10,8,15,6,250,14,10,8,12,6,250,7,11,10,13,10,8,10},38),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({2,53,255,62,255,8,255,7,55,5,3,255,77,4,255,6,25,255,77,4,2,53,255,62,255,8,255,7,55,5,3,255,77,4,255,6,25,255,77,4,2,53,255,62,255,8,255,7,55,5,3},38))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({53,33,42,41,250,46,81,63,63,72,55,250,45,63,78,250,62,63,77,78,67,72,59,78,67,73,72,250,78,59,76,65,63,78,250,78,73,20,250,255,8,12,64,6,250,255,8,12,64,6,250,255,8,12,64},38), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({45,78,59,76,78,250,35,77,70,59,72,62,250,46,76,59,80,63,70},38),
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
Name = _d({31,72,59,60,70,63,250,49,27,45,30,250,32,70,67,65,66,78},38),
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
Name = _d({46,76,59,80,63,70,250,0,250,32,70,67,65,66,78,250,45,74,63,63,62},38),
Range = {10, 150},
Increment = 1,
Suffix = _d({250,77,78,79,62,77,9,77,63,61},38),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
altitudeSlider = MainTab:CreateSlider({
Name = _d({32,70,67,65,66,78,250,27,70,78,67,78,79,62,63,250,2,51,3},38),
Range = {-50, 1500},
Increment = 5,
Suffix = _d({250,51,7,77,78,79,62,77},38),
CurrentValue = 50,
Callback = function(Value)
flightAltitudeY = Value
end,
})
MainTab:CreateButton({
Name = _d({30,63,77,78,76,73,83,250,47,35,250,0,250,45,78,73,74,250,31,80,63,76,83,78,66,67,72,65},38),
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
print(_d({53,33,42,41,250,46,81,63,63,72,55,250,29,70,63,59,72,63,62,250,79,74,250,59,72,62,250,62,63,77,78,76,73,83,63,62,250,44,59,83,64,67,63,70,62,250,47,35,8},38))
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
print(_d({53,33,42,41,250,46,81,63,63,72,250,46,63,77,78,63,76,55,250,70,73,59,62,63,62,250,81,67,78,66,250,63,71,63,76,65,63,72,61,83,250,77,78,73,74,250,69,63,83,250,53,42,55,8},38))
end)()