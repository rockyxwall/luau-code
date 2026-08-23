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
_G.EasyTravelHelperMode = true
if _G.GepoGrinderRunning then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233,232,9,42,55,58,60,49,54,47,232,44,61,56,52,49,43,41,60,45,232,52,41,61,54,43,48,246},56))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local running = true
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
end
local function waitForGameLoad()
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,31,41,49,60,49,54,47,232,46,55,58,232,47,41,53,45,232,60,55,232,52,55,41,44,246,246,246},56))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)) do
task.wait(0.5)
end
local folderName = _d({27,60,41,60,59},56) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,27,60,41,60,59,232,46,55,52,44,45,58,232,54,55,60,232,46,55,61,54,44,232,49,54,232,26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45,233},56))
end
statsFolder:WaitForChild(_d({27,60,41,60,59},56), 10)
statsFolder:WaitForChild(_d({17,54,62,45,54,60,55,58,65},56), 10)
statsFolder:WaitForChild(_d({27,45,60,60,49,54,47,59},56), 10)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,15,41,53,45,232,46,61,52,52,65,232,52,55,41,44,45,44,233},56))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({27,60,41,60,59},56)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({20,45,62,45,52},56)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({24,45,52,49},56)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({26,49,46,52,45},56)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({17,54,62,45,54,60,55,58,65},56)) and statsFolder.Inventory:FindFirstChild(_d({17,54,62,45,54,60,55,58,65},56))
if invVal then
return invVal.Value:find(_d({234,26,49,46,52,45,234},56)) ~= nil
end
return false
end
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
importLib(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 4.0 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,39,15,246,13,41,59,65,28,58,41,62,45,52,232,49,59,232,53,49,59,59,49,54,47,246,232,11,41,54,54,55,60,232,54,41,62,49,47,41,60,45,246},56))
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function getHotbarMapping()
local slots = {_d({34,45,58,55},56), _d({23,54,45},56), _d({28,63,55},56), _d({28,48,58,45,45},56), _d({14,55,61,58},56), _d({14,49,62,45},56), _d({27,49,64},56), _d({27,45,62,45,54},56), _d({13,49,47,48,60},56), _d({22,49,54,45},56)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({22,55,54,45},56)
end
local pgui = LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
local backpackGui = pgui and pgui:FindFirstChild(_d({10,41,43,51,56,41,43,51,15,61,49},56))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({16,55,60,42,41,58},56))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({12,45,59,49,47,54},56) and child.Name ~= _d({22,61,53,42,45,58},56) and child.Name ~= _d({29,17,20,49,59,60,20,41,65,55,61,60},56) and child.Name ~= _d({29,17,24,41,44,44,49,54,47},56) then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,27,60,55,56,56,45,44,2,232},56) .. (reason or _d({44,55,54,45},56)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({53,41,54,61,41,52,232,43,52,45,41,54,61,56,232,48,55,55,51},56))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
if running then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,37,232,56,58,45,59,59,45,44,232,170,72,92,232,41,42,55,58,60,49,54,47,233},56))
cleanup(_d({37,232,51,45,65,232,41,42,55,58,60},56))
end
end
end)
local function flyToFishmanCave()
if not running then return end
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,13,54,41,42,52,49,54,47,232,13,41,59,65,232,28,58,41,62,45,52,232,41,54,44,232,46,52,65,49,54,47,232,60,55,232,14,49,59,48,53,41,54,232,11,41,62,45,246,246,246},56))
_G.EasyTravelHelperMode = true;(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil
_G.EasyTravel = {
TargetPosition = nil,
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hum = char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56)) or Instance.new(_d({9,60,60,41,43,48,53,45,54,60},56))
att.Name = _d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56)
att.Parent = root
local force = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56))
if not force then
force = Instance.new(_d({20,49,54,45,41,58,30,45,52,55,43,49,60,65},56))
force.Name = _d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56)
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
local force = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56))
local att = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function getSurfaceY(position, character)
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
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local moveDir = Vector3.zero
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
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
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
else
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (currentSpeed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,14,52,49,47,48,60,232,45,54,41,42,52,45,44,246},56))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,14,52,49,47,48,60,232,44,49,59,41,42,52,45,44,246},56))
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
_G.EasyTravel.GetSurfaceY = getSurfaceY
if not _G.EasyTravelHelperMode then
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
end
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,11,55,53,56,52,45,60,45,52,65,232,61,54,52,55,41,44,45,44,232,41,54,44,232,43,52,45,41,54,45,44,232,61,56,232,59,43,58,49,56,60,232,59,60,41,60,45,246},56))
end
if _G.EasyTravelHelperMode then
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,20,55,41,44,45,44,232,49,54,232,48,45,52,56,45,58,232,53,55,44,45,246,232,19,45,65,42,55,41,58,44,232,49,54,56,61,60,59,232,44,49,59,41,42,52,45,44,246},56))
else
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,20,55,41,44,45,44,246,232,24,58,45,59,59,232,239,24,239,232,60,55,232,60,55,47,47,52,45,232,46,52,49,47,48,60,246,232,39,15,246,13,41,59,65,28,58,41,62,45,52,232,9,24,17,232,58,45,47,49,59,60,45,58,45,44,246},56))
end
return _G.EasyTravel
end)();
if not _G.EasyTravel then
importLib(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
if _G.EasyTravel and _G.EasyTravel.Start then
_G.EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
_G.EasyTravel.Start()
local replicaElapsed = 0
while running do
task.wait(1)
replicaElapsed = replicaElapsed + 1
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,45,41,43,48,45,44,232,14,49,59,48,53,41,54,232,11,41,62,45,233,232,27,60,55,56,56,49,54,47,232,46,52,49,47,48,60,246},56))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,49,54,49,60,49,41,52,49,66,45,232,13,41,59,65,232,28,58,41,62,45,52,246},56))
end
cleanup(_d({9,58,58,49,62,45,44,232,41,60,232,14,49,59,48,53,41,54,232,11,41,62,45},56))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if not hasRifleTool() then
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,54,55,60,232,45,57,61,49,56,56,45,44,246,232,31,41,49,60,49,54,47,232,46,55,58,232,61,59,45,58,232,60,55,232,53,41,54,61,41,52,52,65,232,42,61,65,232,41,54,44,232,45,57,61,49,56,232,26,49,46,52,45,246,246,246},56))
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,22,55,60,232,41,60,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,246,232,24,52,45,41,59,45,232,60,58,41,62,45,52,232,60,55,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,232,59,55,232,63,45,232,43,41,54,232,46,41,58,53,232,43,48,45,59,60,59,232,63,48,49,52,45,232,63,41,49,60,49,54,47,246},56))
while running and not hasRifleTool() do
task.wait(1)
end
else
if not _G.EasyTravel then
importLib(_d({52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
end
if not _G.ChestFarmer then
importLib(_d({52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56))
end
if _G.ChestFarmer then
local getPeli = function() return 0 end
local isRunning = function()
return running and not hasRifleTool()
end
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,58,53,49,54,47,232,43,48,45,59,60,59,232,49,54,44,45,46,49,54,49,60,45,52,65,232,61,54,60,49,52,232,26,49,46,52,45,232,49,59,232,53,41,54,61,41,52,52,65,232,45,57,61,49,56,56,45,44,246,246,246},56))
_G.ChestFarmer.FarmUntilPeli(9999999, getPeli, isRunning)
else
error(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,232,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41,233},56))
end
end
end
if not running then return end
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,44,45,60,45,43,60,45,44,232,49,54,232,49,54,62,45,54,60,55,58,65,247,48,41,54,44,59,233},56))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,26,49,46,52,45,232,45,57,61,49,56,56,45,44,232,60,55,232,26,49,47,48,60,16,41,54,44,233},56))
end
flyToFishmanCave()
end)
if not ok then
warn(_d({35,15,45,56,55,232,15,58,49,54,44,45,58,37,232,14,41,60,41,52,232,45,58,58,55,58,2,232},56) .. tostring(err))
cleanup(_d({46,41,60,41,52,232,45,58,58,55,58},56))
end
end)
end)()