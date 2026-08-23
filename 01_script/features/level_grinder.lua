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
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,42,85,91,78,74,77,98,9,91,94,87,87,82,87,80,10,9,42,75,88,91,93,82,87,80,9,77,94,89,85,82,76,74,93,78,9,85,74,94,87,76,81,23},23))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
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
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
end
local function waitForGameLoad()
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,64,74,82,93,82,87,80,9,79,88,91,9,80,74,86,78,9,93,88,9,85,88,74,77,23,23,23},23))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) do
task.wait(0.5)
end
local folderName = _d({60,93,74,93,92},23) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,60,93,74,93,92,9,79,88,85,77,78,91,9,87,88,93,9,79,88,94,87,77,9,82,87,9,59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78,10},23))
end
statsFolder:WaitForChild(_d({60,93,74,93,92},23), 10)
statsFolder:WaitForChild(_d({50,87,95,78,87,93,88,91,98},23), 10)
statsFolder:WaitForChild(_d({60,78,93,93,82,87,80,92},23), 10)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,48,74,86,78,9,79,94,85,85,98,9,85,88,74,77,78,77,10},23))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({60,93,74,93,92},23)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({53,78,95,78,85},23)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({57,78,85,82},23)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({59,82,79,85,78},23)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({50,87,95,78,87,93,88,91,98},23)) and statsFolder.Inventory:FindFirstChild(_d({50,87,95,78,87,93,88,91,98},23))
if invVal then
return invVal.Value:find(_d({11,59,82,79,85,78,11},23)) ~= nil
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
importLib(_d({85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
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
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,72,48,23,46,74,92,98,61,91,74,95,78,85,9,82,92,9,86,82,92,92,82,87,80,23,9,44,74,87,87,88,93,9,87,74,95,82,80,74,93,78,23},23))
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
local slots = {_d({67,78,91,88},23), _d({56,87,78},23), _d({61,96,88},23), _d({61,81,91,78,78},23), _d({47,88,94,91},23), _d({47,82,95,78},23), _d({60,82,97},23), _d({60,78,95,78,87},23), _d({46,82,80,81,93},23), _d({55,82,87,78},23)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({55,88,87,78},23)
end
local pgui = LocalPlayer:FindFirstChild(_d({57,85,74,98,78,91,48,94,82},23))
local backpackGui = pgui and pgui:FindFirstChild(_d({43,74,76,84,89,74,76,84,48,94,82},23))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({49,88,93,75,74,91},23))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({45,78,92,82,80,87},23) and child.Name ~= _d({55,94,86,75,78,91},23) and child.Name ~= _d({62,50,53,82,92,93,53,74,98,88,94,93},23) and child.Name ~= _d({62,50,57,74,77,77,82,87,80},23) then
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
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,60,93,88,89,89,78,77,35,9},23) .. (reason or _d({77,88,87,78},23)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({86,74,87,94,74,85,9,76,85,78,74,87,94,89,9,81,88,88,84},23))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,57,9,89,91,78,92,92,78,77,9,203,105,125,9,74,75,88,91,93,82,87,80,10},23))
cleanup(_d({57,9,84,78,98,9,74,75,88,91,93},23))
end
end
end)
local function flyToFishmanCave()
if not running then return end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,46,87,74,75,85,82,87,80,9,46,74,92,98,9,61,91,74,95,78,85,9,74,87,77,9,79,85,98,82,87,80,9,93,88,9,47,82,92,81,86,74,87,9,44,74,95,78,23,23,23},23))
_G.EasyTravelHelperMode = true(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
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
local root = char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hum = char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({72,72,46,74,92,98,61,91,74,95,78,85,42,93,93},23)) or Instance.new(_d({42,93,93,74,76,81,86,78,87,93},23))
att.Name = _d({72,72,46,74,92,98,61,91,74,95,78,85,42,93,93},23)
att.Parent = root
local force = root:FindFirstChild(_d({72,72,46,74,92,98,61,91,74,95,78,85,47,88,91,76,78},23))
if not force then
force = Instance.new(_d({53,82,87,78,74,91,63,78,85,88,76,82,93,98},23))
force.Name = _d({72,72,46,74,92,98,61,91,74,95,78,85,47,88,91,76,78},23)
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
local force = root:FindFirstChild(_d({72,72,46,74,92,98,61,91,74,95,78,85,47,88,91,76,78},23))
local att = root:FindFirstChild(_d({72,72,46,74,92,98,61,91,74,95,78,85,42,93,93},23))
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
print(_d({68,46,74,92,98,9,61,91,74,95,78,85,70,9,47,85,82,80,81,93,9,78,87,74,75,85,78,77,23},23))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({68,46,74,92,98,9,61,91,74,95,78,85,70,9,47,85,82,80,81,93,9,77,82,92,74,75,85,78,77,23},23))
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
print(_d({68,46,74,92,98,9,61,91,74,95,78,85,70,9,44,88,86,89,85,78,93,78,85,98,9,94,87,85,88,74,77,78,77,9,74,87,77,9,76,85,78,74,87,78,77,9,94,89,9,92,76,91,82,89,93,9,92,93,74,93,78,23},23))
end
if _G.EasyTravelHelperMode then
print(_d({68,46,74,92,98,9,61,91,74,95,78,85,70,9,53,88,74,77,78,77,9,82,87,9,81,78,85,89,78,91,9,86,88,77,78,23,9,52,78,98,75,88,74,91,77,9,82,87,89,94,93,92,9,77,82,92,74,75,85,78,77,23},23))
else
print(_d({68,46,74,92,98,9,61,91,74,95,78,85,70,9,53,88,74,77,78,77,23,9,57,91,78,92,92,9,16,57,16,9,93,88,9,93,88,80,80,85,78,9,79,85,82,80,81,93,23,9,72,48,23,46,74,92,98,61,91,74,95,78,85,9,42,57,50,9,91,78,80,82,92,93,78,91,78,77,23},23))
end
return _G.EasyTravel
})();
if _G.EasyTravel and _G.EasyTravel.Start then
_G.EasyTravel.TargetPosition = Vector3.new(1837, -15, -12258)
_G.EasyTravel.Start()
local replicaElapsed = 0
while running do
task.wait(1)
replicaElapsed = replicaElapsed + 1
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,78,74,76,81,78,77,9,47,82,92,81,86,74,87,9,44,74,95,78,10,9,60,93,88,89,89,82,87,80,9,79,85,82,80,81,93,23},23))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,82,85,78,77,9,93,88,9,82,87,82,93,82,74,85,82,99,78,9,46,74,92,98,9,61,91,74,95,78,85,23},23))
end
cleanup(_d({42,91,91,82,95,78,77,9,74,93,9,47,82,92,81,86,74,87,9,44,74,95,78},23))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if not hasRifleTool() then
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,87,88,93,9,78,90,94,82,89,89,78,77,23,9,64,74,82,93,82,87,80,9,79,88,91,9,94,92,78,91,9,93,88,9,86,74,87,94,74,85,85,98,9,75,94,98,9,74,87,77,9,78,90,94,82,89,9,59,82,79,85,78,23,23,23},23))
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,55,88,93,9,74,93,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,23,9,57,85,78,74,92,78,9,93,91,74,95,78,85,9,93,88,9,61,88,96,87,9,88,79,9,43,78,80,82,87,87,82,87,80,92,9,92,88,9,96,78,9,76,74,87,9,79,74,91,86,9,76,81,78,92,93,92,9,96,81,82,85,78,9,96,74,82,93,82,87,80,23},23))
while running and not hasRifleTool() do
task.wait(1)
end
else
if not _G.EasyTravel then
importLib(_d({85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
end
if not _G.ChestFarmer then
importLib(_d({85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74},23))
end
if _G.ChestFarmer then
local getPeli = function() return 0 end
local isRunning = function()
return running and not hasRifleTool()
end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,91,86,82,87,80,9,76,81,78,92,93,92,9,82,87,77,78,79,82,87,82,93,78,85,98,9,94,87,93,82,85,9,59,82,79,85,78,9,82,92,9,86,74,87,94,74,85,85,98,9,78,90,94,82,89,89,78,77,23,23,23},23))
_G.ChestFarmer.FarmUntilPeli(9999999, getPeli, isRunning)
else
error(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,85,82,75,24,76,81,78,92,93,72,79,74,91,86,78,91,23,85,94,74,10},23))
end
end
end
if not running then return end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,77,78,93,78,76,93,78,77,9,82,87,9,82,87,95,78,87,93,88,91,98,24,81,74,87,77,92,10},23))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,78,90,94,82,89,89,78,77,9,93,88,9,59,82,80,81,93,49,74,87,77,10},23))
end
flyToFishmanCave()
end)
if not ok then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,93,74,85,9,78,91,91,88,91,35,9},23) .. tostring(err))
cleanup(_d({79,74,93,74,85,9,78,91,91,88,91},23))
end
end)
end)()