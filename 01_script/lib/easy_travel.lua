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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService       = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
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
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({54,75,82,79},26))
if not (peliValueObj and peliValueObj:IsA(_d({60,71,82,91,75,40,71,89,75},26))) then
local nested = statsFolder:FindFirstChild(_d({57,90,71,90,89},26))
peliValueObj = nested and nested:FindFirstChild(_d({54,75,82,79},26))
end
levelValueObj = statsFolder:FindFirstChild(_d({50,75,92,75,82},26))
if not (levelValueObj and levelValueObj:IsA(_d({60,71,82,91,75,40,71,89,75},26))) then
local nested = statsFolder:FindFirstChild(_d({57,90,71,90,89},26))
levelValueObj = nested and nested:FindFirstChild(_d({50,75,92,75,82},26))
end
staminaValueObj = statsFolder:FindFirstChild(_d({57,90,71,83,79,84,71},26))
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
local hum = char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74},26))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
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
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({67,6,57,90,71,84,74,71,82,85,84,75,6,51,85,74,75,32,6,54,88,75,89,89,6,13},26) .. toggleKey.Name .. _d({13,6,90,85,6,90,85,77,77,82,75,20},26))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({48,81,24,48,49,58,39,49,41,76},26),
TeleportLocation = _d({23,89,90,57,75,71},26)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({44,79,88,89,90,6,57,75,71,6,46,85,83,75,89,73,88,75,75,84,6,21,6,51,71,79,84,6,51,75,84,91},26),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({89,90,88,79,84,77},26) and code ~= "" then
print(string.format(_d({65,57,71,76,75,77,91,71,88,74,67,6,48,85,79,84,79,84,77,6,54,88,79,92,71,90,75,6,57,75,88,92,75,88,6,13,11,89,13,20,20,20},26), code))
task.spawn(function()
local rs = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local reservedRemote = rs:WaitForChild(_d({43,92,75,84,90,89},26)):WaitForChild(_d({88,75,89,75,88,92,75,74},26))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({56,75,83,85,90,75,43,92,75,84,90},26)) and (v.Name == _d({56,75,83,85,90,75,43,92,75,84,90},26) or v.Name == _d({90,75,82,75},26) or v.Name == _d({58,75,82,75,86,85,88,90},26)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({65,57,71,76,75,77,91,71,88,74,67,6,44,79,88,79,84,77,6,90,75,82,75,86,85,88,90,6,88,75,83,85,90,75,32,6},26) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,41,85,91,82,74,6,84,85,90,6,76,79,84,74,6,56,75,83,85,90,75,43,92,75,84,90,6,79,84,6,84,79,82,20,6,54,88,79,84,90,79,84,77,6,71,82,82,6,56,75,83,85,90,75,43,92,75,84,90,89,6,79,84,6,84,79,82,32},26))
for _,v in next, getnilinstances() do
if v:IsA(_d({56,75,83,85,90,75,43,92,75,84,90},26)) then
print(_d({6,19,6,52,71,83,75,32},26), v.Name)
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
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,61,88,85,84,77,6,77,71,83,75,6,91,84,79,92,75,88,89,75,7,6,57,73,88,79,86,90,6,79,89,6,85,84,82,95,6,76,85,88,6,45,54,53,20},26))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,57,73,88,79,86,90,6,75,94,75,73,91,90,79,85,84,6,72,82,85,73,81,75,74,6,85,84,32,6},26) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({65,57,71,76,75,77,91,71,88,74,67,6,58,75,82,75,86,85,88,90,79,84,77,6,90,85,6,54,88,79,92,71,90,75,6,57,75,88,92,75,88,20,20,20,6,54,82,75,71,89,75,6,93,71,79,90,20},26))
else
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,54,88,79,92,71,90,75,57,75,88,92,75,88,41,85,74,75,6,79,89,6,84,85,90,6,89,75,90,20,6,41,71,84,84,85,90,6,71,91,90,85,19,80,85,79,84,20},26))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,61,88,85,84,77,6,77,71,83,75,6,91,84,79,92,75,88,89,75,7,6,57,73,88,79,86,90,6,79,89,6,85,84,82,95,6,76,85,88,6,45,54,53,20},26))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({65,57,71,76,75,77,91,71,88,74,67,6,63,85,91,6,71,88,75,6,85,84,6,90,78,75,6,46,85,83,75,89,73,88,75,75,84,20,6,57,73,88,79,86,90,6,88,75,87,91,79,88,75,89,6,11,89,20},26), name or _d({71,6,89,86,75,73,79,76,79,73,6,86,82,71,73,75},26)))
if Safeguard.JoinPrivateServer() then
print(_d({65,57,71,76,75,77,91,71,88,74,67,6,58,75,82,75,86,85,88,90,79,84,77,6,90,85,6,54,88,79,92,71,90,75,6,57,75,88,92,75,88,20,20,20,6,54,82,75,71,89,75,6,93,71,79,90,20},26))
else
warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,54,88,79,92,71,90,75,57,75,88,92,75,88,41,85,74,75,6,79,89,6,84,85,90,6,89,75,90,20,6,41,71,84,84,85,90,6,71,91,90,85,19,80,85,79,84,20},26))
end
return false
end
warn(string.format(_d({65,57,71,76,75,77,91,71,88,74,67,6,61,88,85,84,77,6,86,82,71,73,75,7,6,56,75,87,91,79,88,75,74,32,6,11,89,6,14,11,74,15,18,6,41,91,88,88,75,84,90,32,6,11,74},26), name or _d({59,84,81,84,85,93,84},26), placeId, game.PlaceId))
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
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
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
return char, char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)), char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({69,69,43,71,89,95,58,88,71,92,75,82,39,90,90},26)) or Instance.new(_d({39,90,90,71,73,78,83,75,84,90},26))
att.Name = _d({69,69,43,71,89,95,58,88,71,92,75,82,39,90,90},26)
att.Parent = root
local force = root:FindFirstChild(_d({69,69,43,71,89,95,58,88,71,92,75,82,44,85,88,73,75},26))
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
force.Name = _d({69,69,43,71,89,95,58,88,71,92,75,82,44,85,88,73,75},26)
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
local force = root:FindFirstChild(_d({69,69,43,71,89,95,58,88,71,92,75,82,44,85,88,73,75},26))
local att = root:FindFirstChild(_d({69,69,43,71,89,95,58,88,71,92,75,82,39,90,90},26))
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
local cave = Workspace.Islands:FindFirstChild(_d({44,79,89,78,83,71,84,6,41,71,92,75},26))
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
if not Safeguard then warn(_d({65,57,71,76,75,77,91,71,88,74,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,7},26)); return end
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
print(_d({65,43,71,89,95,6,58,88,71,92,75,82,67,6,44,82,79,77,78,90,6,75,84,71,72,82,75,74,20},26))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({65,43,71,89,95,6,58,88,71,92,75,82,67,6,44,82,79,77,78,90,6,74,79,89,71,72,82,75,74,20},26))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({43,71,89,95,6,58,88,71,92,75,82},26),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)()