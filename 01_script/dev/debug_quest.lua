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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
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
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum = char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({38,38,12,40,58,64,27,57,40,61,44,51,8,59,59},57)) or Instance.new(_d({8,59,59,40,42,47,52,44,53,59},57))
att.Name = _d({38,38,12,40,58,64,27,57,40,61,44,51,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,12,40,58,64,27,57,40,61,44,51,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,12,40,58,64,27,57,40,61,44,51,13,54,57,42,44},57)
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
local force = root:FindFirstChild(_d({38,38,12,40,58,64,27,57,40,61,44,51,13,54,57,42,44},57))
local att = root:FindFirstChild(_d({38,38,12,40,58,64,27,57,40,61,44,51,8,59,59},57))
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
local npcsFolder = Workspace:FindFirstChild(_d({21,23,10,58},57))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({28,55,55,44,57,27,54,57,58,54},57))
local prompt = torso and torso:FindFirstChild(_d({23,57,54,52,55,59},57))
if not prompt then
print(_d({34,24,60,44,58,59,231,15,40,53,43,51,44,57,36,231,21,54,231,55,57,54,52,55,59,231,45,54,60,53,43,231,45,54,57,231,21,23,10,1,231},57) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({34,24,60,44,58,59,231,15,40,53,43,51,44,57,36,231,23,51,40,64,44,57,231,59,54,54,231,45,40,57,231,239,11,48,58,59,1,231},57) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({34,24,60,44,58,59,231,15,40,53,43,51,44,57,36,231,45,48,57,44,55,57,54,63,48,52,48,59,64,55,57,54,52,55,59,231,53,54,59,231,58,60,55,55,54,57,59,44,43,232},57))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
local chatGui = playerGui and playerGui:FindFirstChild(_d({21,23,10,10,15,8,27},57))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({13,57,40,52,44},57))
local goBtn = frame and frame:FindFirstChild(_d({46,54},57))
local endChatBtn = frame and frame:FindFirstChild(_d({44,53,43,10,47,40,59},57))
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
local npcName = _d({11,40,55,47},57)
local npcsFolder = Workspace:FindFirstChild(_d({21,23,10,58},57))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({28,55,55,44,57,27,54,57,58,54},57))
if not torso then
print(_d({34,11,44,41,60,46,231,24,60,44,58,59,36,231,12,25,25,22,25,1,231,11,40,55,47,231,21,23,10,231,53,54,59,231,45,54,60,53,43,231,48,53,231,30,54,57,50,58,55,40,42,44,245,21,23,10,58,232},57))
return
end
print(_d({34,11,44,41,60,46,231,24,60,44,58,59,36,231,26,59,40,57,59,48,53,46,231,45,51,48,46,47,59,231,59,54,62,40,57,43,58,231},57) .. npcName .. _d({245,245,245},57))
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
print(_d({34,11,44,41,60,46,231,24,60,44,58,59,36,231,25,44,40,42,47,44,43,231,43,44,58,59,48,53,40,59,48,54,53,245,231,26,59,54,55,55,48,53,46,231,45,51,48,46,47,59,231,237,231,59,40,50,48,53,46,231,56,60,44,58,59,245,245,245},57))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({34,11,44,41,60,46,231,24,60,44,58,59,36,231,8,42,42,44,55,59,24,60,44,58,59,231,58,44,56,60,44,53,42,44,231,44,63,44,42,60,59,44,43,245,231,25,44,58,60,51,59,1,231},57) .. tostring(success))
else
print(_d({34,11,44,41,60,46,231,24,60,44,58,59,36,231,27,48,52,44,54,60,59,1,231,10,54,60,51,43,231,53,54,59,231,57,44,40,42,47,231,21,23,10,245},57))
stopFlight()
end
end)
end)()