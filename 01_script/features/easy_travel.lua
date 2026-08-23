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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 3.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local manualHeightOffset = 0
local originalFreefallEnabled = true
local originalFallingDownEnabled = true
local isClimbing = false
local climbTargetY = 0
local inputConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum = char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63)) or Instance.new(_d({2,53,53,34,36,41,46,38,47,53},63))
att.Name = _d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63)
att.Parent = root
local force = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63))
if not force then
force = Instance.new(_d({13,42,47,38,34,51,23,38,45,48,36,42,53,58},63))
force.Name = _d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63)
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
local force = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63))
local att = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63))
if force then force:Destroy() end
if att then att:Destroy() end
end
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
originalFreefallEnabled = hum:GetStateEnabled(Enum.HumanoidStateType.Freefall)
originalFallingDownEnabled = hum:GetStateEnabled(Enum.HumanoidStateType.FallingDown)
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
currentHum:ChangeState(Enum.HumanoidStateType.Physics)
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
manualHeightOffset = manualHeightOffset + (dt * 50)
isClimbing = false
elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
manualHeightOffset = manualHeightOffset - (dt * 50)
isClimbing = false
end
local finalTargetY = (isClimbing and climbTargetY or currentTargetY) + manualHeightOffset
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
end
end)
print(_d({28,6,34,52,58,225,21,51,34,55,38,45,30,225,7,45,42,40,41,53,225,38,47,34,35,45,38,37,239},63))
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
pcall(function()
local _, hum, _ = getCharacterComponents()
if hum then
hum:SetStateEnabled(Enum.HumanoidStateType.Freefall, originalFreefallEnabled)
hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, originalFallingDownEnabled)
end
end)
cleanupForce()
print(_d({28,6,34,52,58,225,21,51,34,55,38,45,30,225,7,45,42,40,41,53,225,37,42,52,34,35,45,38,37,239},63))
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
print(_d({28,6,34,52,58,225,21,51,34,55,38,45,30,225,4,48,46,49,45,38,53,38,45,58,225,54,47,45,48,34,37,38,37,225,34,47,37,225,36,45,38,34,47,38,37,225,54,49,225,52,36,51,42,49,53,225,52,53,34,53,38,239},63))
end
print(_d({28,6,34,52,58,225,21,51,34,55,38,45,30,225,13,48,34,37,38,37,239,225,17,51,38,52,52,225,232,17,232,225,53,48,225,53,48,40,40,45,38,225,39,45,42,40,41,53,239,225,17,51,38,52,52,225,232,6,47,37,232,225,53,48,225,36,48,46,49,45,38,53,38,45,58,225,54,47,45,48,34,37,239},63))
return {
Start = startFlight,
Stop = stopFlight,
}
end)()