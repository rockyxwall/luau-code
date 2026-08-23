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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
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
local root = char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum = char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({80,80,54,82,100,106,69,99,82,103,86,93,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,54,82,100,106,69,99,82,103,86,93,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,54,82,100,106,69,99,82,103,86,93,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,54,82,100,106,69,99,82,103,86,93,55,96,99,84,86},15)
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
local force = root:FindFirstChild(_d({80,80,54,82,100,106,69,99,82,103,86,93,55,96,99,84,86},15))
local att = root:FindFirstChild(_d({80,80,54,82,100,106,69,99,82,103,86,93,50,101,101},15))
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
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({70,97,97,86,99,69,96,99,100,96},15))
local prompt = torso and torso:FindFirstChild(_d({65,99,96,94,97,101},15))
if not prompt then
print(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,63,96,17,97,99,96,94,97,101,17,87,96,102,95,85,17,87,96,99,17,63,65,52,43,17},15) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,65,93,82,106,86,99,17,101,96,96,17,87,82,99,17,25,53,90,100,101,43,17},15) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({76,66,102,86,100,101,17,57,82,95,85,93,86,99,78,17,87,90,99,86,97,99,96,105,90,94,90,101,106,97,99,96,94,97,101,17,95,96,101,17,100,102,97,97,96,99,101,86,85,18},15))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({65,93,82,106,86,99,56,102,90},15))
local chatGui = playerGui and playerGui:FindFirstChild(_d({63,65,52,52,57,50,69},15))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({55,99,82,94,86},15))
local goBtn = frame and frame:FindFirstChild(_d({88,96},15))
local endChatBtn = frame and frame:FindFirstChild(_d({86,95,85,52,89,82,101},15))
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
local npcName = _d({53,82,97,89},15)
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({70,97,97,86,99,69,96,99,100,96},15))
if not torso then
print(_d({76,53,86,83,102,88,17,66,102,86,100,101,78,17,54,67,67,64,67,43,17,53,82,97,89,17,63,65,52,17,95,96,101,17,87,96,102,95,85,17,90,95,17,72,96,99,92,100,97,82,84,86,31,63,65,52,100,18},15))
return
end
print(_d({76,53,86,83,102,88,17,66,102,86,100,101,78,17,68,101,82,99,101,90,95,88,17,87,93,90,88,89,101,17,101,96,104,82,99,85,100,17},15) .. npcName .. _d({31,31,31},15))
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
print(_d({76,53,86,83,102,88,17,66,102,86,100,101,78,17,67,86,82,84,89,86,85,17,85,86,100,101,90,95,82,101,90,96,95,31,17,68,101,96,97,97,90,95,88,17,87,93,90,88,89,101,17,23,17,101,82,92,90,95,88,17,98,102,86,100,101,31,31,31},15))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({76,53,86,83,102,88,17,66,102,86,100,101,78,17,50,84,84,86,97,101,66,102,86,100,101,17,100,86,98,102,86,95,84,86,17,86,105,86,84,102,101,86,85,31,17,67,86,100,102,93,101,43,17},15) .. tostring(success))
else
print(_d({76,53,86,83,102,88,17,66,102,86,100,101,78,17,69,90,94,86,96,102,101,43,17,52,96,102,93,85,17,95,96,101,17,99,86,82,84,89,17,63,65,52,31},15))
stopFlight()
end
end)
end)()