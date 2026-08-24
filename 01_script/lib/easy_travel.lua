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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService       = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {}
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
return char, char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)), char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48)) or Instance.new(_d({17,68,68,49,51,56,61,53,62,68},48))
att.Name = _d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48)
att.Parent = root
local force = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48))
if not force then
force = Instance.new(_d({28,57,62,53,49,66,38,53,60,63,51,57,68,73},48))
force.Name = _d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48)
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
local force = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48))
local att = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
local direction = Vector3.new(0, -checkDepth, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
end
local function runRaycastLoop()
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01 and currentPos.X <= 3049.91 and currentPos.Z >= -11748.53 and currentPos.Z <= -9700.63
local moveDir = Vector3.zero
if EasyTravel.DisableRaycasting then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
task.wait(RAYCAST_COOLDOWN)
continue
end
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({22,57,67,56,61,49,62,240,19,49,70,53},48))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = {cave}
local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
if hit then
hitCave = true
end
end
EasyTravel.HitCave = hitCave
if hitCave or inRoughWaters then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
continue
end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if forwardHit then
distanceToWall = forwardHit.Distance
local clearanceY = nil
local currentScanDist = FORWARD_SCAN_DISTANCE
local heightOffset = 4
while heightOffset <= 100 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
local secondaryOrigin = scanOrigin + moveUnit * 10
local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
if secondaryHit then
currentScanDist = currentScanDist + 15
else
break
end
end
heightOffset = heightOffset + 4
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.IsSafe() then return end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then moveDir = flatDiff.Unit end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({43,21,49,67,73,240,36,66,49,70,53,60,45,240,22,60,57,55,56,68,240,53,62,49,50,60,53,52,254},48))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({43,21,49,67,73,240,36,66,49,70,53,60,45,240,22,60,57,55,56,68,240,52,57,67,49,50,60,53,52,254},48))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({21,49,67,73,240,36,66,49,70,53,60},48),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)()