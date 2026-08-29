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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({35,56,63,60},45))
if not (peliValueObj and peliValueObj:IsA(_d({41,52,63,72,56,21,52,70,56},45))) then
local nested = statsFolder:FindFirstChild(_d({38,71,52,71,70},45))
peliValueObj = nested and nested:FindFirstChild(_d({35,56,63,60},45))
end
levelValueObj = statsFolder:FindFirstChild(_d({31,56,73,56,63},45))
if not (levelValueObj and levelValueObj:IsA(_d({41,52,63,72,56,21,52,70,56},45))) then
local nested = statsFolder:FindFirstChild(_d({38,71,52,71,70},45))
levelValueObj = nested and nested:FindFirstChild(_d({31,56,73,56,63},45))
end
staminaValueObj = statsFolder:FindFirstChild(_d({38,71,52,64,60,65,52},45))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55},45))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({48,243,38,71,52,65,55,52,63,66,65,56,243,32,66,55,56,13,243,35,69,56,70,70,243,250},45) .. toggleKey.Name .. _d({250,243,71,66,243,71,66,58,58,63,56,1},45))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({29,62,5,29,30,39,20,30,22,57},45),
TeleportLocation = _d({4,70,71,38,56,52},45),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({25,60,69,70,71,243,38,56,52,243,27,66,64,56,70,54,69,56,56,65,243,2,243,32,52,60,65,243,32,56,65,72},45),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({70,71,69,60,65,58},45) and code ~= "" then
print(string.format(_d({46,38,52,57,56,58,72,52,69,55,48,243,29,66,60,65,60,65,58,243,35,69,60,73,52,71,56,243,38,56,69,73,56,69,243,250,248,70,250,1,1,1},45), code))
task.spawn(function()
local rs = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local reservedRemote = rs:WaitForChild(_d({24,73,56,65,71,70},45)):WaitForChild(_d({69,56,70,56,69,73,56,55},45))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({37,56,64,66,71,56,24,73,56,65,71},45)) and (v.Name == _d({37,56,64,66,71,56,24,73,56,65,71},45) or v.Name == _d({71,56,63,56},45) or v.Name == _d({39,56,63,56,67,66,69,71},45))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({46,38,52,57,56,58,72,52,69,55,48,243,25,60,69,60,65,58,243,71,56,63,56,67,66,69,71,243,69,56,64,66,71,56,13,243},45) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,22,66,72,63,55,243,65,66,71,243,57,60,65,55,243,37,56,64,66,71,56,24,73,56,65,71,243,60,65,243,65,60,63,1,243,35,69,60,65,71,60,65,58,243,52,63,63,243,37,56,64,66,71,56,24,73,56,65,71,70,243,60,65,243,65,60,63,13},45))
for _, v in next, getnilinstances() do
if v:IsA(_d({37,56,64,66,71,56,24,73,56,65,71},45)) then
print(_d({243,0,243,33,52,64,56,13},45), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,42,69,66,65,58,243,58,52,64,56,243,72,65,60,73,56,69,70,56,244,243,38,54,69,60,67,71,243,60,70,243,66,65,63,76,243,57,66,69,243,26,35,34,1},45))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,38,54,69,60,67,71,243,56,75,56,54,72,71,60,66,65,243,53,63,66,54,62,56,55,243,66,65,13,243},45) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({46,38,52,57,56,58,72,52,69,55,48,243,39,56,63,56,67,66,69,71,60,65,58,243,71,66,243,35,69,60,73,52,71,56,243,38,56,69,73,56,69,1,1,1,243,35,63,56,52,70,56,243,74,52,60,71,1},45))
else
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,35,69,60,73,52,71,56,38,56,69,73,56,69,22,66,55,56,243,60,70,243,65,66,71,243,70,56,71,1,243,22,52,65,65,66,71,243,52,72,71,66,0,61,66,60,65,1},45))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,42,69,66,65,58,243,58,52,64,56,243,72,65,60,73,56,69,70,56,244,243,38,54,69,60,67,71,243,60,70,243,66,65,63,76,243,57,66,69,243,26,35,34,1},45))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({46,38,52,57,56,58,72,52,69,55,48,243,44,66,72,243,52,69,56,243,66,65,243,71,59,56,243,27,66,64,56,70,54,69,56,56,65,1,243,38,54,69,60,67,71,243,69,56,68,72,60,69,56,70,243,248,70,1},45), name or _d({52,243,70,67,56,54,60,57,60,54,243,67,63,52,54,56},45)))
if Safeguard.JoinPrivateServer() then
print(_d({46,38,52,57,56,58,72,52,69,55,48,243,39,56,63,56,67,66,69,71,60,65,58,243,71,66,243,35,69,60,73,52,71,56,243,38,56,69,73,56,69,1,1,1,243,35,63,56,52,70,56,243,74,52,60,71,1},45))
else
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,35,69,60,73,52,71,56,38,56,69,73,56,69,22,66,55,56,243,60,70,243,65,66,71,243,70,56,71,1,243,22,52,65,65,66,71,243,52,72,71,66,0,61,66,60,65,1},45))
end
return false
end
warn(
string.format(
_d({46,38,52,57,56,58,72,52,69,55,48,243,42,69,66,65,58,243,67,63,52,54,56,244,243,37,56,68,72,60,69,56,55,13,243,248,70,243,251,248,55,252,255,243,22,72,69,69,56,65,71,13,243,248,55},45),
name or _d({40,65,62,65,66,74,65},45),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)), char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({50,50,24,52,70,76,39,69,52,73,56,63,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,24,52,70,76,39,69,52,73,56,63,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,24,52,70,76,39,69,52,73,56,63,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,24,52,70,76,39,69,52,73,56,63,25,66,69,54,56},45)
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
local force = root:FindFirstChild(_d({50,50,24,52,70,76,39,69,52,73,56,63,25,66,69,54,56},45))
local att = root:FindFirstChild(_d({50,50,24,52,70,76,39,69,52,73,56,63,20,71,71},45))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({25,60,70,59,64,52,65,243,22,52,73,56},45))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({46,38,52,57,56,58,72,52,69,55,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,244},45))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({46,24,52,70,76,243,39,69,52,73,56,63,48,243,25,63,60,58,59,71,243,56,65,52,53,63,56,55,1},45))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({46,24,52,70,76,243,39,69,52,73,56,63,48,243,25,63,60,58,59,71,243,55,60,70,52,53,63,56,55,1},45))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({24,52,70,76,243,39,69,52,73,56,63},45), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()