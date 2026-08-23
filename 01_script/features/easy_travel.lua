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
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 3.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local GEPPO_COOLDOWN_MIN = 1.8
local GEPPO_COOLDOWN_MAX = 2.2
local flightEnabled = false
local currentTargetY = 0
local lastGeppoTime = 0
local currentGeppoCooldown = 2.0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local inputConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum = char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({77,77,51,79,97,103,66,96,79,100,83,90,47,98,98},18)) or Instance.new(_d({47,98,98,79,81,86,91,83,92,98},18))
att.Name = _d({77,77,51,79,97,103,66,96,79,100,83,90,47,98,98},18)
att.Parent = root
local force = root:FindFirstChild(_d({77,77,51,79,97,103,66,96,79,100,83,90,52,93,96,81,83},18))
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = _d({77,77,51,79,97,103,66,96,79,100,83,90,52,93,96,81,83},18)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 10000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local _, _, root = getCharacterComponents()
if root then
local force = root:FindFirstChild(_d({77,77,51,79,97,103,66,96,79,100,83,90,52,93,96,81,83},18))
local att = root:FindFirstChild(_d({77,77,51,79,97,103,66,96,79,100,83,90,47,98,98},18))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < currentGeppoCooldown then return end
lastGeppoTime = now
currentGeppoCooldown = math.random(GEPPO_COOLDOWN_MIN * 100, GEPPO_COOLDOWN_MAX * 100) / 100
pcall(function()
local char, _, root = getCharacterComponents()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({60,93,92,83},18)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
end
end)
end
local function getSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 250, position.Z)
local direction = Vector3.new(0, -500, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
end
local function runRaycastLoop()
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * 8, raycastParams)
if forwardHit then
local clearanceY = nil
for heightOffset = 4, 100, 4 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * 8, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
break
end
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local _, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
currentTargetY = root.Position.Y
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
pcall(function()
currentHum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
currentHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
currentHum:ChangeState(Enum.HumanoidStateType.Running)
end)
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
currentTargetY = currentTargetY + (dt * 50)
isClimbing = false
elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
currentTargetY = currentTargetY - (dt * 50)
isClimbing = false
end
local finalTargetY = isClimbing and climbTargetY or currentTargetY
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 5 then
speedMultiplier = math.clamp(1 - (yError / 30), 0.1, 1)
end
targetVelocity = moveDir.Unit * (FLIGHT_SPEED * speedMultiplier)
end
local verticalVel = math.clamp(yError * 6, -150, 150)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + Vector3.new(look.X, 0, look.Z).Unit)
if (currentRoot.Position.Y - getSurfaceY(currentRoot.Position, char)) > 5 then
invokeGeppo()
end
end
end)
print(_d({73,51,79,97,103,14,66,96,79,100,83,90,75,14,52,90,87,85,86,98,14,83,92,79,80,90,83,82,28},18))
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({73,51,79,97,103,14,66,96,79,100,83,90,75,14,52,90,87,85,86,98,14,82,87,97,79,80,90,83,82,28},18))
end
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
elseif input.KeyCode == Enum.KeyCode.End then
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end
end)
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravelCleanup = nil
print(_d({73,51,79,97,103,14,66,96,79,100,83,90,75,14,49,93,91,94,90,83,98,83,90,103,14,99,92,90,93,79,82,83,82,14,79,92,82,14,81,90,83,79,92,83,82,14,99,94,14,97,81,96,87,94,98,14,97,98,79,98,83,28},18))
end
print(_d({73,51,79,97,103,14,66,96,79,100,83,90,75,14,58,93,79,82,83,82,28,14,62,96,83,97,97,14,21,62,21,14,98,93,14,98,93,85,85,90,83,14,84,90,87,85,86,98,28,14,62,96,83,97,97,14,21,51,92,82,21,14,98,93,14,81,93,91,94,90,83,98,83,90,103,14,99,92,90,93,79,82,28},18))
return {
Start = startFlight,
Stop = stopFlight,
}
end)()