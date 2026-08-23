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
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,41,84,90,77,73,76,97,8,90,93,86,86,81,86,79,9,8,41,74,87,90,92,81,86,79,8,76,93,88,84,81,75,73,92,77,8,84,73,93,86,75,80,22},24))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end
local function waitForGameLoad()
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,63,73,81,92,81,86,79,8,78,87,90,8,79,73,85,77,8,92,87,8,84,87,73,76,22,22,22},24))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) do
task.wait(0.5)
end
local folderName = _d({59,92,73,92,91},24) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,59,92,73,92,91,8,78,87,84,76,77,90,8,86,87,92,8,78,87,93,86,76,8,81,86,8,58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77,9},24))
end
statsFolder:WaitForChild(_d({59,92,73,92,91},24), 10)
statsFolder:WaitForChild(_d({49,86,94,77,86,92,87,90,97},24), 10)
statsFolder:WaitForChild(_d({59,77,92,92,81,86,79,91},24), 10)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,47,73,85,77,8,78,93,84,84,97,8,84,87,73,76,77,76,9},24))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({59,92,73,92,91},24)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({52,77,94,77,84},24)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({56,77,84,81},24)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({58,81,78,84,77},24)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({49,86,94,77,86,92,87,90,97},24)) and statsFolder.Inventory:FindFirstChild(_d({49,86,94,77,86,92,87,90,97},24))
if invVal then
return invVal.Value:find(_d({10,58,81,78,84,77,10},24)) ~= nil
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
importLib(_d({84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
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
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,71,47,22,45,73,91,97,60,90,73,94,77,84,8,81,91,8,85,81,91,91,81,86,79,22,8,43,73,86,86,87,92,8,86,73,94,81,79,73,92,77,22},24))
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
local slots = {_d({66,77,90,87},24), _d({55,86,77},24), _d({60,95,87},24), _d({60,80,90,77,77},24), _d({46,87,93,90},24), _d({46,81,94,77},24), _d({59,81,96},24), _d({59,77,94,77,86},24), _d({45,81,79,80,92},24), _d({54,81,86,77},24)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({54,87,86,77},24)
end
local pgui = LocalPlayer:FindFirstChild(_d({56,84,73,97,77,90,47,93,81},24))
local backpackGui = pgui and pgui:FindFirstChild(_d({42,73,75,83,88,73,75,83,47,93,81},24))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({48,87,92,74,73,90},24))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({44,77,91,81,79,86},24) and child.Name ~= _d({54,93,85,74,77,90},24) and child.Name ~= _d({61,49,52,81,91,92,52,73,97,87,93,92},24) and child.Name ~= _d({61,49,56,73,76,76,81,86,79},24) then
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
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,59,92,87,88,88,77,76,34,8},24) .. (reason or _d({76,87,86,77},24)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({85,73,86,93,73,84,8,75,84,77,73,86,93,88,8,80,87,87,83},24))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,56,8,88,90,77,91,91,77,76,8,202,104,124,8,73,74,87,90,92,81,86,79,9},24))
cleanup(_d({56,8,83,77,97,8,73,74,87,90,92},24))
end
end
end)
local function flyToFishmanCave()
if not running then return end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,45,86,73,74,84,81,86,79,8,45,73,91,97,8,60,90,73,94,77,84,8,73,86,76,8,78,84,97,81,86,79,8,92,87,8,46,81,91,80,85,73,86,8,43,73,94,77,22,22,22},24))
_G.EasyTravelHelperMode = true;(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
local root = char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({71,71,45,73,91,97,60,90,73,94,77,84,41,92,92},24)) or Instance.new(_d({41,92,92,73,75,80,85,77,86,92},24))
att.Name = _d({71,71,45,73,91,97,60,90,73,94,77,84,41,92,92},24)
att.Parent = root
local force = root:FindFirstChild(_d({71,71,45,73,91,97,60,90,73,94,77,84,46,87,90,75,77},24))
if not force then
force = Instance.new(_d({52,81,86,77,73,90,62,77,84,87,75,81,92,97},24))
force.Name = _d({71,71,45,73,91,97,60,90,73,94,77,84,46,87,90,75,77},24)
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
local force = root:FindFirstChild(_d({71,71,45,73,91,97,60,90,73,94,77,84,46,87,90,75,77},24))
local att = root:FindFirstChild(_d({71,71,45,73,91,97,60,90,73,94,77,84,41,92,92},24))
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
print(_d({67,45,73,91,97,8,60,90,73,94,77,84,69,8,46,84,81,79,80,92,8,77,86,73,74,84,77,76,22},24))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({67,45,73,91,97,8,60,90,73,94,77,84,69,8,46,84,81,79,80,92,8,76,81,91,73,74,84,77,76,22},24))
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
print(_d({67,45,73,91,97,8,60,90,73,94,77,84,69,8,43,87,85,88,84,77,92,77,84,97,8,93,86,84,87,73,76,77,76,8,73,86,76,8,75,84,77,73,86,77,76,8,93,88,8,91,75,90,81,88,92,8,91,92,73,92,77,22},24))
end
if _G.EasyTravelHelperMode then
print(_d({67,45,73,91,97,8,60,90,73,94,77,84,69,8,52,87,73,76,77,76,8,81,86,8,80,77,84,88,77,90,8,85,87,76,77,22,8,51,77,97,74,87,73,90,76,8,81,86,88,93,92,91,8,76,81,91,73,74,84,77,76,22},24))
else
print(_d({67,45,73,91,97,8,60,90,73,94,77,84,69,8,52,87,73,76,77,76,22,8,56,90,77,91,91,8,15,56,15,8,92,87,8,92,87,79,79,84,77,8,78,84,81,79,80,92,22,8,71,47,22,45,73,91,97,60,90,73,94,77,84,8,41,56,49,8,90,77,79,81,91,92,77,90,77,76,22},24))
end
return _G.EasyTravel
end)();
if _G.EasyTravel and _G.EasyTravel.Start then
_G.EasyTravel.TargetPosition = Vector3.new(1837, -15, -12258)
_G.EasyTravel.Start()
local replicaElapsed = 0
while running do
task.wait(1)
replicaElapsed = replicaElapsed + 1
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,77,73,75,80,77,76,8,46,81,91,80,85,73,86,8,43,73,94,77,9,8,59,92,87,88,88,81,86,79,8,78,84,81,79,80,92,22},24))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,81,86,81,92,81,73,84,81,98,77,8,45,73,91,97,8,60,90,73,94,77,84,22},24))
end
cleanup(_d({41,90,90,81,94,77,76,8,73,92,8,46,81,91,80,85,73,86,8,43,73,94,77},24))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if not hasRifleTool() then
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,86,87,92,8,77,89,93,81,88,88,77,76,22,8,63,73,81,92,81,86,79,8,78,87,90,8,93,91,77,90,8,92,87,8,85,73,86,93,73,84,84,97,8,74,93,97,8,73,86,76,8,77,89,93,81,88,8,58,81,78,84,77,22,22,22},24))
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,54,87,92,8,73,92,8,60,87,95,86,8,87,78,8,42,77,79,81,86,86,81,86,79,91,22,8,56,84,77,73,91,77,8,92,90,73,94,77,84,8,92,87,8,60,87,95,86,8,87,78,8,42,77,79,81,86,86,81,86,79,91,8,91,87,8,95,77,8,75,73,86,8,78,73,90,85,8,75,80,77,91,92,91,8,95,80,81,84,77,8,95,73,81,92,81,86,79,22},24))
while running and not hasRifleTool() do
task.wait(1)
end
else
if not _G.EasyTravel then
importLib(_d({84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24))
end
if not _G.ChestFarmer then
importLib(_d({84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73},24))
end
if _G.ChestFarmer then
local getPeli = function() return 0 end
local isRunning = function()
return running and not hasRifleTool()
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,90,85,81,86,79,8,75,80,77,91,92,91,8,81,86,76,77,78,81,86,81,92,77,84,97,8,93,86,92,81,84,8,58,81,78,84,77,8,81,91,8,85,73,86,93,73,84,84,97,8,77,89,93,81,88,88,77,76,22,22,22},24))
_G.ChestFarmer.FarmUntilPeli(9999999, getPeli, isRunning)
else
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,84,81,74,23,75,80,77,91,92,71,78,73,90,85,77,90,22,84,93,73,9},24))
end
end
end
if not running then return end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,76,77,92,77,75,92,77,76,8,81,86,8,81,86,94,77,86,92,87,90,97,23,80,73,86,76,91,9},24))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,77,89,93,81,88,88,77,76,8,92,87,8,58,81,79,80,92,48,73,86,76,9},24))
end
flyToFishmanCave()
end)
if not ok then
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,92,73,84,8,77,90,90,87,90,34,8},24) .. tostring(err))
cleanup(_d({78,73,92,73,84,8,77,90,90,87,90},24))
end
end)
end)()