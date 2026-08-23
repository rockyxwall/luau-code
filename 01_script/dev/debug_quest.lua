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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
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
local root = char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum = char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63)) or Instance.new(_d({2,53,53,34,36,41,46,38,47,53},63))
att.Name = _d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63)
att.Parent = root
local force = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63))
if not force then
force = Instance.new(_d({13,42,47,38,34,51,23,38,45,48,36,42,53,58},63))
force.Name = _d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63)
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
local force = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,7,48,51,36,38},63))
local att = root:FindFirstChild(_d({32,32,6,34,52,58,21,51,34,55,38,45,2,53,53},63))
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
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({22,49,49,38,51,21,48,51,52,48},63))
local prompt = torso and torso:FindFirstChild(_d({17,51,48,46,49,53},63))
if not prompt then
print(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,15,48,225,49,51,48,46,49,53,225,39,48,54,47,37,225,39,48,51,225,15,17,4,251,225},63) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,17,45,34,58,38,51,225,53,48,48,225,39,34,51,225,233,5,42,52,53,251,225},63) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,39,42,51,38,49,51,48,57,42,46,42,53,58,49,51,48,46,49,53,225,47,48,53,225,52,54,49,49,48,51,53,38,37,226},63))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
local chatGui = playerGui and playerGui:FindFirstChild(_d({15,17,4,4,9,2,21},63))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({7,51,34,46,38},63))
local goBtn = frame and frame:FindFirstChild(_d({40,48},63))
local endChatBtn = frame and frame:FindFirstChild(_d({38,47,37,4,41,34,53},63))
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
local npcName = _d({5,34,49,41},63)
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({22,49,49,38,51,21,48,51,52,48},63))
if not torso then
print(_d({28,5,38,35,54,40,225,18,54,38,52,53,30,225,6,19,19,16,19,251,225,5,34,49,41,225,15,17,4,225,47,48,53,225,39,48,54,47,37,225,42,47,225,24,48,51,44,52,49,34,36,38,239,15,17,4,52,226},63))
return
end
print(_d({28,5,38,35,54,40,225,18,54,38,52,53,30,225,20,53,34,51,53,42,47,40,225,39,45,42,40,41,53,225,53,48,56,34,51,37,52,225},63) .. npcName .. _d({239,239,239},63))
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
print(_d({28,5,38,35,54,40,225,18,54,38,52,53,30,225,19,38,34,36,41,38,37,225,37,38,52,53,42,47,34,53,42,48,47,239,225,20,53,48,49,49,42,47,40,225,39,45,42,40,41,53,225,231,225,53,34,44,42,47,40,225,50,54,38,52,53,239,239,239},63))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({28,5,38,35,54,40,225,18,54,38,52,53,30,225,2,36,36,38,49,53,18,54,38,52,53,225,52,38,50,54,38,47,36,38,225,38,57,38,36,54,53,38,37,239,225,19,38,52,54,45,53,251,225},63) .. tostring(success))
else
print(_d({28,5,38,35,54,40,225,18,54,38,52,53,30,225,21,42,46,38,48,54,53,251,225,4,48,54,45,37,225,47,48,53,225,51,38,34,36,41,225,15,17,4,239},63))
stopFlight()
end
end)
end)()