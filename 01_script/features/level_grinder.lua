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
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,49,92,98,85,81,84,105,16,98,101,94,94,89,94,87,17,16,49,82,95,98,100,89,94,87,16,84,101,96,92,89,83,81,100,85,16,92,81,101,94,83,88,30},16))
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
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
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
end
local function waitForGameLoad()
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,71,81,89,100,89,94,87,16,86,95,98,16,87,81,93,85,16,100,95,16,92,95,81,84,30,30,30},16))
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16)) or not LocalPlayer.Character:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) do
task.wait(0.5)
end
local folderName = _d({67,100,81,100,99},16) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,67,100,81,100,99,16,86,95,92,84,85,98,16,94,95,100,16,86,95,101,94,84,16,89,94,16,66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85,17},16))
end
statsFolder:WaitForChild(_d({67,100,81,100,99},16), 10)
statsFolder:WaitForChild(_d({57,94,102,85,94,100,95,98,105},16), 10)
statsFolder:WaitForChild(_d({67,85,100,100,89,94,87,99},16), 10)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,55,81,93,85,16,86,101,92,92,105,16,92,95,81,84,85,84,17},16))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({67,100,81,100,99},16)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild(_d({60,85,102,85,92},16)) and stats.Level.Value or 1
local peli = stats:FindFirstChild(_d({64,85,92,89},16)) and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16)) or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({66,89,86,92,85},16)))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild(_d({57,94,102,85,94,100,95,98,105},16)) and statsFolder.Inventory:FindFirstChild(_d({57,94,102,85,94,100,95,98,105},16))
if invVal then
return invVal.Value:find(_d({18,66,89,86,92,85,18},16)) ~= nil
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
importLib(_d({92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16))
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
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,79,55,30,53,81,99,105,68,98,81,102,85,92,16,89,99,16,93,89,99,99,89,94,87,30,16,51,81,94,94,95,100,16,94,81,102,89,87,81,100,85,30},16))
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
local slots = {_d({74,85,98,95},16), _d({63,94,85},16), _d({68,103,95},16), _d({68,88,98,85,85},16), _d({54,95,101,98},16), _d({54,89,102,85},16), _d({67,89,104},16), _d({67,85,102,85,94},16), _d({53,89,87,88,100},16), _d({62,89,94,85},16)}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = _d({62,95,94,85},16)
end
local pgui = LocalPlayer:FindFirstChild(_d({64,92,81,105,85,98,55,101,89},16))
local backpackGui = pgui and pgui:FindFirstChild(_d({50,81,83,91,96,81,83,91,55,101,89},16))
local hotbar = backpackGui and backpackGui:FindFirstChild(_d({56,95,100,82,81,98},16))
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= _d({52,85,99,89,87,94},16) and child.Name ~= _d({62,101,93,82,85,98},16) and child.Name ~= _d({69,57,60,89,99,100,60,81,105,95,101,100},16) and child.Name ~= _d({69,57,64,81,84,84,89,94,87},16) then
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
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,67,100,95,96,96,85,84,42,16},16) .. (reason or _d({84,95,94,85},16)) .. ".")
end
_G.GepoGrinderCleanup = function()
cleanup(_d({93,81,94,101,81,92,16,83,92,85,81,94,101,96,16,88,95,95,91},16))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,16,96,98,85,99,99,85,84,16,210,112,132,16,81,82,95,98,100,89,94,87,17},16))
cleanup(_d({64,16,91,85,105,16,81,82,95,98,100},16))
end
end
end)
local function flyToFishmanCave()
if not running then return end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,53,94,81,82,92,89,94,87,16,53,81,99,105,16,68,98,81,102,85,92,16,81,94,84,16,86,92,105,89,94,87,16,100,95,16,54,89,99,88,93,81,94,16,51,81,102,85,30,30,30},16))
_G.EasyTravelHelperMode = true(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
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
local root = char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16)) or Instance.new(_d({49,100,100,81,83,88,93,85,94,100},16))
att.Name = _d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16)
att.Parent = root
local force = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16))
if not force then
force = Instance.new(_d({60,89,94,85,81,98,70,85,92,95,83,89,100,105},16))
force.Name = _d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16)
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
local force = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16))
local att = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16))
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
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,54,92,89,87,88,100,16,85,94,81,82,92,85,84,30},16))
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,54,92,89,87,88,100,16,84,89,99,81,82,92,85,84,30},16))
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
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,51,95,93,96,92,85,100,85,92,105,16,101,94,92,95,81,84,85,84,16,81,94,84,16,83,92,85,81,94,85,84,16,101,96,16,99,83,98,89,96,100,16,99,100,81,100,85,30},16))
end
if _G.EasyTravelHelperMode then
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,60,95,81,84,85,84,16,89,94,16,88,85,92,96,85,98,16,93,95,84,85,30,16,59,85,105,82,95,81,98,84,16,89,94,96,101,100,99,16,84,89,99,81,82,92,85,84,30},16))
else
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,60,95,81,84,85,84,30,16,64,98,85,99,99,16,23,64,23,16,100,95,16,100,95,87,87,92,85,16,86,92,89,87,88,100,30,16,79,55,30,53,81,99,105,68,98,81,102,85,92,16,49,64,57,16,98,85,87,89,99,100,85,98,85,84,30},16))
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
local hrp = char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,85,81,83,88,85,84,16,54,89,99,88,93,81,94,16,51,81,102,85,17,16,67,100,95,96,96,89,94,87,16,86,92,89,87,88,100,30},16))
_G.EasyTravel.Stop()
break
end
end
end
else
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,89,92,85,84,16,100,95,16,89,94,89,100,89,81,92,89,106,85,16,53,81,99,105,16,68,98,81,102,85,92,30},16))
end
cleanup(_d({49,98,98,89,102,85,84,16,81,100,16,54,89,99,88,93,81,94,16,51,81,102,85},16))
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,81,92,98,85,81,84,105,16,85,97,101,89,96,96,85,84,31,95,103,94,85,84,30},16))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({66,89,86,92,85},16))
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,85,97,101,89,96,96,85,84,17},16))
end
flyToFishmanCave()
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,62,95,100,16,85,94,95,101,87,88,16,64,85,92,89,16,100,95,16,82,101,105,16,81,16,66,89,86,92,85,16,24,35,32,32,25,16,81,94,84,16,94,95,100,16,81,100,16,68,95,103,94,16,95,86,16,50,85,87,89,94,94,89,94,87,99,30,16,64,92,85,81,99,85,16,100,98,81,102,85,92,16,100,95,16,68,95,103,94,16,95,86,16,50,85,87,89,94,94,89,94,87,99,16,100,95,16,83,88,85,99,100,16,86,81,98,93,30},16))
cleanup(_d({57,94,102,81,92,89,84,16,92,95,83,81,100,89,95,94,16,86,95,98,16,83,88,85,99,100,16,86,81,98,93,89,94,87},16))
return
end
if not _G.EasyTravel then
importLib(_d({92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,85,81,99,105,79,100,98,81,102,85,92,30,92,101,81},16))
end
if not _G.ChestFarmer then
importLib(_d({92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16), _d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,92,101,81,101,29,83,95,84,85,31,93,81,89,94,31,32,33,79,99,83,98,89,96,100,31,92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81},16))
end
if _G.ChestFarmer then
local getPeli = function()
local _, p = getStats()
return p
end
local isRunning = function()
return running
end
local farmSuccess = _G.ChestFarmer.FarmUntilPeli(300, getPeli, isRunning)
if not farmSuccess or not running then
cleanup(_d({51,88,85,99,100,16,86,81,98,93,16,86,81,89,92,85,84,16,95,98,16,99,100,95,96,96,85,84},16))
return
end
else
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,92,89,82,31,83,88,85,99,100,79,86,81,98,93,85,98,30,92,101,81,17},16))
end
end
if not running then return end
if not hasRifleInInventory() then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,62,81,102,89,87,81,100,89,94,87,16,100,95,16,82,101,105,16,66,89,86,92,85,30,30,30},16))
local buyables = Workspace:FindFirstChild(_d({50,101,105,81,82,92,85,57,100,85,93,99},16))
local shopItem = buyables and buyables:FindFirstChild(_d({66,89,86,92,85},16))
local shopPart = shopItem and shopItem:FindFirstChild(_d({67,88,95,96,64,81,98,100},16))
if not shopPart then
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,67,88,95,96,64,81,98,100,16,94,95,100,16,86,95,101,94,84,16,101,94,84,85,98,16,50,101,105,81,82,92,85,57,100,85,93,99,17},16))
end
local shopTarget = shopPart.Position - Vector3.new(0, 3.0, 0)
local elapsed = 0
local reached = false
while running and elapsed < 30 do
task.wait(0.1)
elapsed = elapsed + 0.1
if navigateTo(shopTarget) then
reached = true
break
end
end
if not reached or not running then
cleanup(_d({54,81,89,92,85,84,16,100,95,16,98,85,81,83,88,16,66,89,86,92,85,16,99,88,95,96},16))
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({64,98,95,104,89,93,89,100,105,64,98,95,93,96,100},16), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,101,98,83,88,81,99,85,84,16,66,89,86,92,85,16,96,98,95,93,96,100,16,100,98,89,87,87,85,98,85,84,30},16))
else
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,86,89,98,85,96,98,95,104,89,93,89,100,105,96,98,95,93,96,100,16,94,95,100,16,99,101,96,96,95,98,100,85,84,16,82,105,16,85,104,85,83,101,100,95,98,17},16))
end
else
error(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,98,95,104,89,93,89,100,105,64,98,95,93,96,100,16,94,95,100,16,86,95,101,94,84,16,95,94,16,66,89,86,92,85,16,99,88,95,96,16,89,100,85,93,17},16))
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild(_d({53,102,85,94,100,99},16)) and ReplicatedStorage.Events:FindFirstChild(_d({67,88,95,96},16))
if shopEvent and shopEvent:IsA(_d({66,85,93,95,100,85,54,101,94,83,100,89,95,94},16)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({64,92,81,105,85,98,55,101,89},16))
local diag = pgui and pgui:FindFirstChild(_d({52,89,81,92,95,87,101,85},16))
if diag then
local closeBtn = diag:FindFirstChild(_d({51,92,95,99,85},16), true)
if closeBtn and getconnections then
pcall(function()
for _, conn in ipairs(getconnections(closeBtn.MouseButton1Click)) do
conn:Fire()
end
for _, conn in ipairs(getconnections(closeBtn.Activated)) do
conn:Fire()
end
end)
end
end
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,53,97,101,89,96,96,89,94,87,16,66,89,86,92,85,16,86,98,95,93,16,89,94,102,85,94,100,95,98,105,30,30,30},16))
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == _d({66,89,86,92,85},16) then
currentSlot = slot
break
end
end
if not currentSlot then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,94,95,100,16,89,94,16,88,95,100,82,81,98,30,16,53,97,101,89,96,96,89,94,87,16,102,89,81,16,70,57,61,16,61,81,83,98,95,16,96,92,81,105,82,81,83,91,30,30,30},16))
local vim = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local vs = workspace.CurrentCamera.ViewportSize
local function clickRelative(pctX, pctY)
local cx = vs.X * pctX
local cy = vs.Y * pctY
pcall(function()
vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
task.wait(0.05)
vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
end)
end
clickRelative(0.025, 0.975)
task.wait(0.8)
clickRelative(0.494, 0.377)
task.wait(0.5)
clickRelative(0.518, 0.443)
task.wait(0.5)
clickRelative(0.770, 0.655)
task.wait(0.5)
clickRelative(0.038, 0.981)
task.wait(1)
mapping = getHotbarMapping()
for slot, toolName in pairs(mapping) do
if toolName == _d({66,89,86,92,85},16) then
currentSlot = slot
break
end
end
end
if not currentSlot then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,89,92,85,84,16,100,95,16,81,99,99,89,87,94,16,66,89,86,92,85,16,100,95,16,81,16,88,95,100,82,81,98,16,99,92,95,100,30},16))
cleanup(_d({66,89,86,92,85,16,85,97,101,89,96,16,85,98,98,95,98},16))
return
end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,89,99,16,93,81,96,96,85,84,16,100,95,16,88,95,100,82,81,98,16,99,92,95,100,42,16},16) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,98,85,99,99,89,94,87,16,88,95,100,82,81,98,16,91,85,105,42,16},16) .. tostring(currentSlot) .. _d({16,100,95,16,96,101,92,92,16,95,101,100,16,66,89,86,92,85,30,30,30},16))
vim:SendKeyEvent(true, keyCode, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, keyCode, false, game)
end
local replicaElapsed = 0
local rifleEquipped = false
while running and replicaElapsed < 5 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
local char = LocalPlayer.Character
local rh = char and char:FindFirstChild(_d({66,89,87,88,100,56,81,94,84},16))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({66,89,86,92,85},16)) then
rifleEquipped = true
break
end
end
end
if rifleEquipped then
break
end
end
if not rifleEquipped then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,84,89,84,16,94,95,100,16,81,96,96,85,81,98,16,89,94,16,66,89,87,88,100,56,81,94,84,16,81,86,100,85,98,16,96,98,85,99,99,89,94,87,16,88,95,100,91,85,105,30},16))
cleanup(_d({66,89,86,92,85,16,85,97,101,89,96,16,100,89,93,85,95,101,100},16))
return
end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,89,99,16,93,81,96,96,85,84,16,100,95,16,88,95,100,82,81,98,16,99,92,95,100,42,16},16) .. tostring(currentSlot))
task.wait(1)
local vim = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local keyCode = Enum.KeyCode[currentSlot]
if keyCode then
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,64,98,85,99,99,89,94,87,16,88,95,100,82,81,98,16,91,85,105,42,16},16) .. tostring(currentSlot) .. _d({16,100,95,16,96,101,92,92,16,95,101,100,16,66,89,86,92,85,30,30,30},16))
vim:SendKeyEvent(true, keyCode, false, game)
task.wait(0.1)
vim:SendKeyEvent(false, keyCode, false, game)
end
local replicaElapsed = 0
local rifleEquipped = false
while running and replicaElapsed < 5 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
local char = LocalPlayer.Character
local rh = char and char:FindFirstChild(_d({66,89,87,88,100,56,81,94,84},16))
if rh then
for _, v in ipairs(rh:GetChildren()) do
if v.Name:find(_d({66,89,86,92,85},16)) then
rifleEquipped = true
break
end
end
end
if rifleEquipped then
break
end
end
if not rifleEquipped then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,84,89,84,16,94,95,100,16,81,96,96,85,81,98,16,89,94,16,66,89,87,88,100,56,81,94,84,16,81,86,100,85,98,16,96,98,85,99,99,89,94,87,16,88,95,100,91,85,105,30},16))
cleanup(_d({66,89,86,92,85,16,85,97,101,89,96,16,100,89,93,85,95,101,100},16))
return
end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,66,89,86,92,85,16,99,101,83,83,85,99,99,86,101,92,92,105,16,85,97,101,89,96,96,85,84,16,89,94,16,88,81,94,84,99,17},16))
flyToFishmanCave()
end)
if not ok then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,100,81,92,16,85,98,98,95,98,42,16},16) .. tostring(err))
cleanup(_d({86,81,100,81,92,16,85,98,98,95,98},16))
end
end)
end)()