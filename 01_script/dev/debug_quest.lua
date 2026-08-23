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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
if _G.EasyTravelCleanup then pcall(_G.EasyTravelCleanup) end
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
DisableKeyboard = true,
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum = char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30)
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
local force = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30))
local att = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30))
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
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
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
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = _G.EasyTravel.TargetPosition.Y
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
targetVelocity = moveDir.Unit * currentSpeed
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
_G.EasyTravel.GetSurfaceY = getSurfaceY
_G.EasyTravelCleanup = function()
stopFlight()
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
end
local QuestHandler = {}
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({48,50,37,85},30))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({55,82,82,71,84,54,81,84,85,81},30))
local prompt = torso and torso:FindFirstChild(_d({50,84,81,79,82,86},30))
if not prompt then
print(_d({61,51,87,71,85,86,2,42,67,80,70,78,71,84,63,2,48,81,2,82,84,81,79,82,86,2,72,81,87,80,70,2,72,81,84,2,48,50,37,28,2},30) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({61,51,87,71,85,86,2,42,67,80,70,78,71,84,63,2,50,78,67,91,71,84,2,86,81,81,2,72,67,84,2,10,38,75,85,86,28,2},30) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({61,51,87,71,85,86,2,42,67,80,70,78,71,84,63,2,72,75,84,71,82,84,81,90,75,79,75,86,91,82,84,81,79,82,86,2,80,81,86,2,85,87,82,82,81,84,86,71,70,3},30))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({50,78,67,91,71,84,41,87,75},30))
local chatGui = playerGui and playerGui:FindFirstChild(_d({48,50,37,37,42,35,54},30))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({40,84,67,79,71},30))
local goBtn = frame and frame:FindFirstChild(_d({73,81},30))
local endChatBtn = frame and frame:FindFirstChild(_d({71,80,70,37,74,67,86},30))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
end
task.wait(0.8)
end
end
return true
end
_G.QuestHandler = QuestHandler
task.spawn(function()
local npcName = _d({38,67,82,74},30)
local npcsFolder = Workspace:FindFirstChild(_d({48,50,37,85},30))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({55,82,82,71,84,54,81,84,85,81},30))
if not torso then
print(_d({61,38,71,68,87,73,2,51,87,71,85,86,63,2,39,52,52,49,52,28,2,38,67,82,74,2,48,50,37,2,80,81,86,2,72,81,87,80,70,2,75,80,2,57,81,84,77,85,82,67,69,71,16,48,50,37,85,3},30))
return
end
print(_d({61,38,71,68,87,73,2,51,87,71,85,86,63,2,53,86,67,84,86,75,80,73,2,72,78,75,73,74,86,2,86,81,89,67,84,70,85,2},30) .. npcName .. _d({16,16,16},30))
startFlight()
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
_G.EasyTravel.TargetPosition = targetPos
local reached = false
for i = 1, 100 do
task.wait(0.2)
local _, _, myRoot = getCharacterComponents()
if myRoot then
local dist = (targetPos - myRoot.Position).Magnitude
if dist <= 3.5 then
reached = true
break
end
end
end
if reached then
print(_d({61,38,71,68,87,73,2,51,87,71,85,86,63,2,52,71,67,69,74,71,70,2,70,71,85,86,75,80,67,86,75,81,80,16,2,53,86,81,82,82,75,80,73,2,72,78,75,73,74,86,2,8,2,86,67,77,75,80,73,2,83,87,71,85,86,16,16,16},30))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({61,38,71,68,87,73,2,51,87,71,85,86,63,2,35,69,69,71,82,86,51,87,71,85,86,2,85,71,83,87,71,80,69,71,2,71,90,71,69,87,86,71,70,16,2,52,71,85,87,78,86,28,2},30) .. tostring(success))
else
print(_d({61,38,71,68,87,73,2,51,87,71,85,86,63,2,54,75,79,71,81,87,86,28,2,37,81,87,78,70,2,80,81,86,2,84,71,67,69,74,2,48,50,37,16},30))
stopFlight()
end
end)
end)()