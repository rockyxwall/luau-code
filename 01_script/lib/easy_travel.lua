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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({29,50,57,54},51))
if not (peliValueObj and peliValueObj:IsA(_d({35,46,57,66,50,15,46,64,50},51))) then
local nested = statsFolder:FindFirstChild(_d({32,65,46,65,64},51))
peliValueObj = nested and nested:FindFirstChild(_d({29,50,57,54},51))
end
levelValueObj = statsFolder:FindFirstChild(_d({25,50,67,50,57},51))
if not (levelValueObj and levelValueObj:IsA(_d({35,46,57,66,50,15,46,64,50},51))) then
local nested = statsFolder:FindFirstChild(_d({32,65,46,65,64},51))
levelValueObj = nested and nested:FindFirstChild(_d({25,50,67,50,57},51))
end
staminaValueObj = statsFolder:FindFirstChild(_d({32,65,46,58,54,59,46},51))
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
local hum = char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49},51))
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
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
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
print("[" .. tostring(name) .. _d({42,237,32,65,46,59,49,46,57,60,59,50,237,26,60,49,50,7,237,29,63,50,64,64,237,244},51) .. toggleKey.Name .. _d({244,237,65,60,237,65,60,52,52,57,50,251},51))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({23,56,255,23,24,33,14,24,16,51},51),
TeleportLocation = _d({254,64,65,32,50,46},51),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({19,54,63,64,65,237,32,50,46,237,21,60,58,50,64,48,63,50,50,59,237,252,237,26,46,54,59,237,26,50,59,66},51),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({64,65,63,54,59,52},51) and code ~= "" then
print(string.format(_d({40,32,46,51,50,52,66,46,63,49,42,237,23,60,54,59,54,59,52,237,29,63,54,67,46,65,50,237,32,50,63,67,50,63,237,244,242,64,244,251,251,251},51), code))
task.spawn(function()
local rs = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local reservedRemote = rs:WaitForChild(_d({18,67,50,59,65,64},51)):WaitForChild(_d({63,50,64,50,63,67,50,49},51))
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
v:IsA(_d({31,50,58,60,65,50,18,67,50,59,65},51)) and (v.Name == _d({31,50,58,60,65,50,18,67,50,59,65},51) or v.Name == _d({65,50,57,50},51) or v.Name == _d({33,50,57,50,61,60,63,65},51))
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
print(_d({40,32,46,51,50,52,66,46,63,49,42,237,19,54,63,54,59,52,237,65,50,57,50,61,60,63,65,237,63,50,58,60,65,50,7,237},51) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,16,60,66,57,49,237,59,60,65,237,51,54,59,49,237,31,50,58,60,65,50,18,67,50,59,65,237,54,59,237,59,54,57,251,237,29,63,54,59,65,54,59,52,237,46,57,57,237,31,50,58,60,65,50,18,67,50,59,65,64,237,54,59,237,59,54,57,7},51))
for _, v in next, getnilinstances() do
if v:IsA(_d({31,50,58,60,65,50,18,67,50,59,65},51)) then
print(_d({237,250,237,27,46,58,50,7},51), v.Name)
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
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,36,63,60,59,52,237,52,46,58,50,237,66,59,54,67,50,63,64,50,238,237,32,48,63,54,61,65,237,54,64,237,60,59,57,70,237,51,60,63,237,20,29,28,251},51))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,32,48,63,54,61,65,237,50,69,50,48,66,65,54,60,59,237,47,57,60,48,56,50,49,237,60,59,7,237},51) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({40,32,46,51,50,52,66,46,63,49,42,237,33,50,57,50,61,60,63,65,54,59,52,237,65,60,237,29,63,54,67,46,65,50,237,32,50,63,67,50,63,251,251,251,237,29,57,50,46,64,50,237,68,46,54,65,251},51))
else
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,29,63,54,67,46,65,50,32,50,63,67,50,63,16,60,49,50,237,54,64,237,59,60,65,237,64,50,65,251,237,16,46,59,59,60,65,237,46,66,65,60,250,55,60,54,59,251},51))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,36,63,60,59,52,237,52,46,58,50,237,66,59,54,67,50,63,64,50,238,237,32,48,63,54,61,65,237,54,64,237,60,59,57,70,237,51,60,63,237,20,29,28,251},51))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({40,32,46,51,50,52,66,46,63,49,42,237,38,60,66,237,46,63,50,237,60,59,237,65,53,50,237,21,60,58,50,64,48,63,50,50,59,251,237,32,48,63,54,61,65,237,63,50,62,66,54,63,50,64,237,242,64,251},51), name or _d({46,237,64,61,50,48,54,51,54,48,237,61,57,46,48,50},51)))
if Safeguard.JoinPrivateServer() then
print(_d({40,32,46,51,50,52,66,46,63,49,42,237,33,50,57,50,61,60,63,65,54,59,52,237,65,60,237,29,63,54,67,46,65,50,237,32,50,63,67,50,63,251,251,251,237,29,57,50,46,64,50,237,68,46,54,65,251},51))
else
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,29,63,54,67,46,65,50,32,50,63,67,50,63,16,60,49,50,237,54,64,237,59,60,65,237,64,50,65,251,237,16,46,59,59,60,65,237,46,66,65,60,250,55,60,54,59,251},51))
end
return false
end
warn(
string.format(
_d({40,32,46,51,50,52,66,46,63,49,42,237,36,63,60,59,52,237,61,57,46,48,50,238,237,31,50,62,66,54,63,50,49,7,237,242,64,237,245,242,49,246,249,237,16,66,63,63,50,59,65,7,237,242,49},51),
name or _d({34,59,56,59,60,68,59},51),
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
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
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
return char, char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)), char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({44,44,18,46,64,70,33,63,46,67,50,57,14,65,65},51)) or Instance.new(_d({14,65,65,46,48,53,58,50,59,65},51))
att.Name = _d({44,44,18,46,64,70,33,63,46,67,50,57,14,65,65},51)
att.Parent = root
local force = root:FindFirstChild(_d({44,44,18,46,64,70,33,63,46,67,50,57,19,60,63,48,50},51))
if not force then
force = Instance.new(_d({25,54,59,50,46,63,35,50,57,60,48,54,65,70},51))
force.Name = _d({44,44,18,46,64,70,33,63,46,67,50,57,19,60,63,48,50},51)
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
local force = root:FindFirstChild(_d({44,44,18,46,64,70,33,63,46,67,50,57,19,60,63,48,50},51))
local att = root:FindFirstChild(_d({44,44,18,46,64,70,33,63,46,67,50,57,14,65,65},51))
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
local cave = Workspace.Islands:FindFirstChild(_d({19,54,64,53,58,46,59,237,16,46,67,50},51))
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
warn(_d({40,32,46,51,50,52,66,46,63,49,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,238},51))
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
print(_d({40,18,46,64,70,237,33,63,46,67,50,57,42,237,19,57,54,52,53,65,237,50,59,46,47,57,50,49,251},51))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({40,18,46,64,70,237,33,63,46,67,50,57,42,237,19,57,54,52,53,65,237,49,54,64,46,47,57,50,49,251},51))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({18,46,64,70,237,33,63,46,67,50,57},51), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()