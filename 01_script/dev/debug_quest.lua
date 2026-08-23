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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
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
local root = char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({54,54,28,56,74,80,43,73,56,77,60,67,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,28,56,74,80,43,73,56,77,60,67,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,28,56,74,80,43,73,56,77,60,67,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,28,56,74,80,43,73,56,77,60,67,29,70,73,58,60},41)
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
local force = root:FindFirstChild(_d({54,54,28,56,74,80,43,73,56,77,60,67,29,70,73,58,60},41))
local att = root:FindFirstChild(_d({54,54,28,56,74,80,43,73,56,77,60,67,24,75,75},41))
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
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
local prompt = torso and torso:FindFirstChild(_d({39,73,70,68,71,75},41))
if not prompt then
print(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,37,70,247,71,73,70,68,71,75,247,61,70,76,69,59,247,61,70,73,247,37,39,26,17,247},41) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,39,67,56,80,60,73,247,75,70,70,247,61,56,73,247,255,27,64,74,75,17,247},41) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({50,40,76,60,74,75,247,31,56,69,59,67,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,248},41))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local chatGui = playerGui and playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({29,73,56,68,60},41))
local goBtn = frame and frame:FindFirstChild(_d({62,70},41))
local endChatBtn = frame and frame:FindFirstChild(_d({60,69,59,26,63,56,75},41))
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
local npcName = _d({27,56,71,63},41)
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
if not torso then
print(_d({50,27,60,57,76,62,247,40,76,60,74,75,52,247,28,41,41,38,41,17,247,27,56,71,63,247,37,39,26,247,69,70,75,247,61,70,76,69,59,247,64,69,247,46,70,73,66,74,71,56,58,60,5,37,39,26,74,248},41))
return
end
print(_d({50,27,60,57,76,62,247,40,76,60,74,75,52,247,42,75,56,73,75,64,69,62,247,61,67,64,62,63,75,247,75,70,78,56,73,59,74,247},41) .. npcName .. _d({5,5,5},41))
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
print(_d({50,27,60,57,76,62,247,40,76,60,74,75,52,247,41,60,56,58,63,60,59,247,59,60,74,75,64,69,56,75,64,70,69,5,247,42,75,70,71,71,64,69,62,247,61,67,64,62,63,75,247,253,247,75,56,66,64,69,62,247,72,76,60,74,75,5,5,5},41))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({50,27,60,57,76,62,247,40,76,60,74,75,52,247,24,58,58,60,71,75,40,76,60,74,75,247,74,60,72,76,60,69,58,60,247,60,79,60,58,76,75,60,59,5,247,41,60,74,76,67,75,17,247},41) .. tostring(success))
else
print(_d({50,27,60,57,76,62,247,40,76,60,74,75,52,247,43,64,68,60,70,76,75,17,247,26,70,76,67,59,247,69,70,75,247,73,60,56,58,63,247,37,39,26,5},41))
stopFlight()
end
end)
end)()