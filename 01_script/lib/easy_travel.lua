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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService       = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({244,245,241,43,52,51,243,48,45,38,243,39,51,54,41,242,48,57,37},60)) then
Core = loadstring(readfile(_d({244,245,241,43,52,51,243,48,45,38,243,39,51,54,41,242,48,57,37},60)))()
else
Core = loadstring(game:HttpGet(_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,48,57,37,57,241,39,51,40,41,243,49,37,45,50,243,244,245,35,55,39,54,45,52,56,243,48,45,38,243,39,51,54,41,242,48,57,37},60)))()
end
end)
if not Core then warn(_d({31,7,51,54,41,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,229},60)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
return char, char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)), char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60)) or Instance.new(_d({5,56,56,37,39,44,49,41,50,56},60))
att.Name = _d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60)
att.Parent = root
local force = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60))
if not force then
force = Instance.new(_d({16,45,50,41,37,54,26,41,48,51,39,45,56,61},60))
force.Name = _d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60)
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
local force = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,10,51,54,39,41},60))
local att = root:FindFirstChild(_d({35,35,9,37,55,61,24,54,37,58,41,48,5,56,56},60))
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
local cave = Workspace.Islands:FindFirstChild(_d({10,45,55,44,49,37,50,228,7,37,58,41},60))
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
if not Safeguard then warn(_d({31,23,37,42,41,43,57,37,54,40,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,229},60)); return end
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
print(_d({31,9,37,55,61,228,24,54,37,58,41,48,33,228,10,48,45,43,44,56,228,41,50,37,38,48,41,40,242},60))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({31,9,37,55,61,228,24,54,37,58,41,48,33,228,10,48,45,43,44,56,228,40,45,55,37,38,48,41,40,242},60))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({9,37,55,61,228,24,54,37,58,41,48},60),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)()