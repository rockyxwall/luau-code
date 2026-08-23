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
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,34,77,83,70,66,69,90,1,83,86,79,79,74,79,72,2,1,34,67,80,83,85,74,79,72,1,69,86,81,77,74,68,66,85,70,1,77,66,86,79,68,73,15},31))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
end
local function waitForGameLoad()
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,56,66,74,85,74,79,72,1,71,80,83,1,72,66,78,70,1,85,80,1,77,80,66,69,15,15,15},31))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) do
task.wait(0.5)
end
local folderName = _d({52,85,66,85,84},31) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,52,85,66,85,84,1,71,80,77,69,70,83,1,79,80,85,1,71,80,86,79,69,1,74,79,1,51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70,2},31))
end
statsFolder:WaitForChild(_d({52,85,66,85,84},31), 10)
statsFolder:WaitForChild(_d({42,79,87,70,79,85,80,83,90},31), 10)
statsFolder:WaitForChild(_d({52,70,85,85,74,79,72,84},31), 10)
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,40,66,78,70,1,71,86,77,77,90,1,77,80,66,69,70,69,2},31))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({52,85,66,85,84},31)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({45,70,87,70,77},31)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({49,70,77,74},31)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({51,74,71,77,70},31)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({51,74,71,77,70},31)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({42,79,87,70,79,85,80,83,90},31)) and statsFolder.Inventory:FindFirstChild(_d({42,79,87,70,79,85,80,83,90},31))
if invVal then
return invVal.Value:find(_d({3,51,74,71,77,70,3},31)) ~= nil
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
importLib(_d({77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
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
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,64,40,15,38,66,84,90,53,83,66,87,70,77,1,74,84,1,78,74,84,84,74,79,72,15,1,36,66,79,79,80,85,1,79,66,87,74,72,66,85,70,15},31))
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
local slots = {_d({59,70,83,80},31), _d({48,79,70},31), _d({53,88,80},31), _d({53,73,83,70,70},31), _d({39,80,86,83},31), _d({39,74,87,70},31), _d({52,74,89},31), _d({52,70,87,70,79},31), _d({38,74,72,73,85},31), _d({47,74,79,70},31)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({47,80,79,70},31)
end
local pgui = LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
local backpackGui = pgui and pgui:FindFirstChild(_d({35,66,68,76,81,66,68,76,40,86,74},31))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({41,80,85,67,66,83},31))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({37,70,84,74,72,79},31) and child.Name ~= _d({47,86,78,67,70,83},31) and child.Name ~= _d({54,42,45,74,84,85,45,66,90,80,86,85},31) and child.Name ~= _d({54,42,49,66,69,69,74,79,72},31) then
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
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,52,85,80,81,81,70,69,27,1},31) .. (reason or _d({69,80,79,70},31)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({78,66,79,86,66,77,1,68,77,70,66,79,86,81,1,73,80,80,76},31))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,49,1,81,83,70,84,84,70,69,1,195,97,117,1,66,67,80,83,85,74,79,72,2},31))
cleanup(_d({49,1,76,70,90,1,66,67,80,83,85},31))
end
end
end)
local function flyToFishmanCave()
if not running then return end
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,38,79,66,67,77,74,79,72,1,38,66,84,90,1,53,83,66,87,70,77,1,66,79,69,1,71,77,90,74,79,72,1,85,80,1,39,74,84,73,78,66,79,1,36,66,87,70,15,15,15},31))
_G.EasyTravelHelperMode = true(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
local root = char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum = char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({64,64,38,66,84,90,53,83,66,87,70,77,34,85,85},31)) or Instance.new(_d({34,85,85,66,68,73,78,70,79,85},31))
att.Name = _d({64,64,38,66,84,90,53,83,66,87,70,77,34,85,85},31)
att.Parent = root
local force = root:FindFirstChild(_d({64,64,38,66,84,90,53,83,66,87,70,77,39,80,83,68,70},31))
if not force then
force = Instance.new(_d({45,74,79,70,66,83,55,70,77,80,68,74,85,90},31))
force.Name = _d({64,64,38,66,84,90,53,83,66,87,70,77,39,80,83,68,70},31)
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
local force = root:FindFirstChild(_d({64,64,38,66,84,90,53,83,66,87,70,77,39,80,83,68,70},31))
local att = root:FindFirstChild(_d({64,64,38,66,84,90,53,83,66,87,70,77,34,85,85},31))
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
print(_d({60,38,66,84,90,1,53,83,66,87,70,77,62,1,39,77,74,72,73,85,1,70,79,66,67,77,70,69,15},31))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({60,38,66,84,90,1,53,83,66,87,70,77,62,1,39,77,74,72,73,85,1,69,74,84,66,67,77,70,69,15},31))
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
print(_d({60,38,66,84,90,1,53,83,66,87,70,77,62,1,36,80,78,81,77,70,85,70,77,90,1,86,79,77,80,66,69,70,69,1,66,79,69,1,68,77,70,66,79,70,69,1,86,81,1,84,68,83,74,81,85,1,84,85,66,85,70,15},31))
end
if _G.EasyTravelHelperMode then
print(_d({60,38,66,84,90,1,53,83,66,87,70,77,62,1,45,80,66,69,70,69,1,74,79,1,73,70,77,81,70,83,1,78,80,69,70,15,1,44,70,90,67,80,66,83,69,1,74,79,81,86,85,84,1,69,74,84,66,67,77,70,69,15},31))
else
print(_d({60,38,66,84,90,1,53,83,66,87,70,77,62,1,45,80,66,69,70,69,15,1,49,83,70,84,84,1,8,49,8,1,85,80,1,85,80,72,72,77,70,1,71,77,74,72,73,85,15,1,64,40,15,38,66,84,90,53,83,66,87,70,77,1,34,49,42,1,83,70,72,74,84,85,70,83,70,69,15},31))
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
local hrp = char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,70,66,68,73,70,69,1,39,74,84,73,78,66,79,1,36,66,87,70,2,1,52,85,80,81,81,74,79,72,1,71,77,74,72,73,85,15},31))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,74,77,70,69,1,85,80,1,74,79,74,85,74,66,77,74,91,70,1,38,66,84,90,1,53,83,66,87,70,77,15},31))
end
cleanup(_d({34,83,83,74,87,70,69,1,66,85,1,39,74,84,73,78,66,79,1,36,66,87,70},31))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if not hasRifleTool() then
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,79,80,85,1,70,82,86,74,81,81,70,69,15,1,56,66,74,85,74,79,72,1,71,80,83,1,86,84,70,83,1,85,80,1,78,66,79,86,66,77,77,90,1,67,86,90,1,66,79,69,1,70,82,86,74,81,1,51,74,71,77,70,15,15,15},31))
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,47,80,85,1,66,85,1,53,80,88,79,1,80,71,1,35,70,72,74,79,79,74,79,72,84,15,1,49,77,70,66,84,70,1,85,83,66,87,70,77,1,85,80,1,53,80,88,79,1,80,71,1,35,70,72,74,79,79,74,79,72,84,1,84,80,1,88,70,1,68,66,79,1,71,66,83,78,1,68,73,70,84,85,84,1,88,73,74,77,70,1,88,66,74,85,74,79,72,15},31))
while running and not hasRifleTool() do
task.wait(1)
end
else
if not _G.EasyTravel then
importLib(_d({77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,70,66,84,90,64,85,83,66,87,70,77,15,77,86,66},31))
end
if not _G.ChestFarmer then
importLib(_d({77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66},31), _d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,77,86,66,86,14,68,80,69,70,16,78,66,74,79,16,17,18,64,84,68,83,74,81,85,16,77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66},31))
end
if _G.ChestFarmer then
local getPeli = function() return 0 end
local isRunning = function()
return running and not hasRifleTool()
end
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,83,78,74,79,72,1,68,73,70,84,85,84,1,74,79,69,70,71,74,79,74,85,70,77,90,1,86,79,85,74,77,1,51,74,71,77,70,1,74,84,1,78,66,79,86,66,77,77,90,1,70,82,86,74,81,81,70,69,15,15,15},31))
_G.ChestFarmer.FarmUntilPeli(9999999, getPeli, isRunning)
else
error(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,77,74,67,16,68,73,70,84,85,64,71,66,83,78,70,83,15,77,86,66,2},31))
end
end
end
if not running then return end
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,69,70,85,70,68,85,70,69,1,74,79,1,74,79,87,70,79,85,80,83,90,16,73,66,79,69,84,2},31))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({51,74,71,77,70},31))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,51,74,71,77,70,1,70,82,86,74,81,81,70,69,1,85,80,1,51,74,72,73,85,41,66,79,69,2},31))
end
flyToFishmanCave()
end)
if not ok then
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,85,66,77,1,70,83,83,80,83,27,1},31) .. tostring(err))
cleanup(_d({71,66,85,66,77,1,70,83,83,80,83},31))
end
end)
end)()