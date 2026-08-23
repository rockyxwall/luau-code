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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
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
local root = char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({75,75,49,77,95,101,64,94,77,98,81,88,45,96,96},20)) or Instance.new(_d({45,96,96,77,79,84,89,81,90,96},20))
att.Name = _d({75,75,49,77,95,101,64,94,77,98,81,88,45,96,96},20)
att.Parent = root
local force = root:FindFirstChild(_d({75,75,49,77,95,101,64,94,77,98,81,88,50,91,94,79,81},20))
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = _d({75,75,49,77,95,101,64,94,77,98,81,88,50,91,94,79,81},20)
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
local force = root:FindFirstChild(_d({75,75,49,77,95,101,64,94,77,98,81,88,50,91,94,79,81},20))
local att = root:FindFirstChild(_d({75,75,49,77,95,101,64,94,77,98,81,88,45,96,96},20))
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
manualHeightOffset = 0
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
print(_d({71,49,77,95,101,12,64,94,77,98,81,88,73,12,50,88,85,83,84,96,12,81,90,77,78,88,81,80,26},20))
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
print(_d({71,49,77,95,101,12,64,94,77,98,81,88,73,12,50,88,85,83,84,96,12,80,85,95,77,78,88,81,80,26},20))
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
print(_d({71,49,77,95,101,12,64,94,77,98,81,88,73,12,47,91,89,92,88,81,96,81,88,101,12,97,90,88,91,77,80,81,80,12,77,90,80,12,79,88,81,77,90,81,80,12,97,92,12,95,79,94,85,92,96,12,95,96,77,96,81,26},20))
end
print(_d({71,49,77,95,101,12,64,94,77,98,81,88,73,12,56,91,77,80,81,80,26,12,60,94,81,95,95,12,19,60,19,12,96,91,12,96,91,83,83,88,81,12,82,88,85,83,84,96,26,12,60,94,81,95,95,12,19,49,90,80,19,12,96,91,12,79,91,89,92,88,81,96,81,88,101,12,97,90,88,91,77,80,26},20))
return {
Start = startFlight,
Stop = stopFlight,
}
end)()