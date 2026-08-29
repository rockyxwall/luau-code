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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
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
local root = char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58)
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
local force = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58))
local att = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58))
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
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({27,54,54,43,56,26,53,56,57,53},58))
local prompt = torso and torso:FindFirstChild(_d({22,56,53,51,54,58},58))
if not prompt then
print(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,20,53,230,54,56,53,51,54,58,230,44,53,59,52,42,230,44,53,56,230,20,22,9,0,230},58) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,22,50,39,63,43,56,230,58,53,53,230,44,39,56,230,238,10,47,57,58,0,230},58) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({33,23,59,43,57,58,230,14,39,52,42,50,43,56,35,230,44,47,56,43,54,56,53,62,47,51,47,58,63,54,56,53,51,54,58,230,52,53,58,230,57,59,54,54,53,56,58,43,42,231},58))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({22,50,39,63,43,56,13,59,47},58))
local chatGui = playerGui and playerGui:FindFirstChild(_d({20,22,9,9,14,7,26},58))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({12,56,39,51,43},58))
local goBtn = frame and frame:FindFirstChild(_d({45,53},58))
local endChatBtn = frame and frame:FindFirstChild(_d({43,52,42,9,46,39,58},58))
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
local npcName = _d({10,39,54,46},58)
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({27,54,54,43,56,26,53,56,57,53},58))
if not torso then
print(_d({33,10,43,40,59,45,230,23,59,43,57,58,35,230,11,24,24,21,24,0,230,10,39,54,46,230,20,22,9,230,52,53,58,230,44,53,59,52,42,230,47,52,230,29,53,56,49,57,54,39,41,43,244,20,22,9,57,231},58))
return
end
print(_d({33,10,43,40,59,45,230,23,59,43,57,58,35,230,25,58,39,56,58,47,52,45,230,44,50,47,45,46,58,230,58,53,61,39,56,42,57,230},58) .. npcName .. _d({244,244,244},58))
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
print(_d({33,10,43,40,59,45,230,23,59,43,57,58,35,230,24,43,39,41,46,43,42,230,42,43,57,58,47,52,39,58,47,53,52,244,230,25,58,53,54,54,47,52,45,230,44,50,47,45,46,58,230,236,230,58,39,49,47,52,45,230,55,59,43,57,58,244,244,244},58))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({33,10,43,40,59,45,230,23,59,43,57,58,35,230,7,41,41,43,54,58,23,59,43,57,58,230,57,43,55,59,43,52,41,43,230,43,62,43,41,59,58,43,42,244,230,24,43,57,59,50,58,0,230},58) .. tostring(success))
else
print(_d({33,10,43,40,59,45,230,23,59,43,57,58,35,230,26,47,51,43,53,59,58,0,230,9,53,59,50,42,230,52,53,58,230,56,43,39,41,46,230,20,22,9,244},58))
stopFlight()
end
end)
end)()