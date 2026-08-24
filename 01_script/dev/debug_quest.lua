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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
local root = char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local hum = char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({31,31,5,33,51,57,20,50,33,54,37,44,1,52,52},64)) or Instance.new(_d({1,52,52,33,35,40,45,37,46,52},64))
att.Name = _d({31,31,5,33,51,57,20,50,33,54,37,44,1,52,52},64)
att.Parent = root
local force = root:FindFirstChild(_d({31,31,5,33,51,57,20,50,33,54,37,44,6,47,50,35,37},64))
if not force then
force = Instance.new(_d({12,41,46,37,33,50,22,37,44,47,35,41,52,57},64))
force.Name = _d({31,31,5,33,51,57,20,50,33,54,37,44,6,47,50,35,37},64)
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
local force = root:FindFirstChild(_d({31,31,5,33,51,57,20,50,33,54,37,44,6,47,50,35,37},64))
local att = root:FindFirstChild(_d({31,31,5,33,51,57,20,50,33,54,37,44,1,52,52},64))
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
local npcsFolder = Workspace:FindFirstChild(_d({14,16,3,51},64))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({21,48,48,37,50,20,47,50,51,47},64))
local prompt = torso and torso:FindFirstChild(_d({16,50,47,45,48,52},64))
if not prompt then
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,14,47,224,48,50,47,45,48,52,224,38,47,53,46,36,224,38,47,50,224,14,16,3,250,224},64) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,16,44,33,57,37,50,224,52,47,47,224,38,33,50,224,232,4,41,51,52,250,224},64) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({27,17,53,37,51,52,224,8,33,46,36,44,37,50,29,224,38,41,50,37,48,50,47,56,41,45,41,52,57,48,50,47,45,48,52,224,46,47,52,224,51,53,48,48,47,50,52,37,36,225},64))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({16,44,33,57,37,50,7,53,41},64))
local chatGui = playerGui and playerGui:FindFirstChild(_d({14,16,3,3,8,1,20},64))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({6,50,33,45,37},64))
local goBtn = frame and frame:FindFirstChild(_d({39,47},64))
local endChatBtn = frame and frame:FindFirstChild(_d({37,46,36,3,40,33,52},64))
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
local npcName = _d({4,33,48,40},64)
local npcsFolder = Workspace:FindFirstChild(_d({14,16,3,51},64))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({21,48,48,37,50,20,47,50,51,47},64))
if not torso then
print(_d({27,4,37,34,53,39,224,17,53,37,51,52,29,224,5,18,18,15,18,250,224,4,33,48,40,224,14,16,3,224,46,47,52,224,38,47,53,46,36,224,41,46,224,23,47,50,43,51,48,33,35,37,238,14,16,3,51,225},64))
return
end
print(_d({27,4,37,34,53,39,224,17,53,37,51,52,29,224,19,52,33,50,52,41,46,39,224,38,44,41,39,40,52,224,52,47,55,33,50,36,51,224},64) .. npcName .. _d({238,238,238},64))
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
print(_d({27,4,37,34,53,39,224,17,53,37,51,52,29,224,18,37,33,35,40,37,36,224,36,37,51,52,41,46,33,52,41,47,46,238,224,19,52,47,48,48,41,46,39,224,38,44,41,39,40,52,224,230,224,52,33,43,41,46,39,224,49,53,37,51,52,238,238,238},64))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({27,4,37,34,53,39,224,17,53,37,51,52,29,224,1,35,35,37,48,52,17,53,37,51,52,224,51,37,49,53,37,46,35,37,224,37,56,37,35,53,52,37,36,238,224,18,37,51,53,44,52,250,224},64) .. tostring(success))
else
print(_d({27,4,37,34,53,39,224,17,53,37,51,52,29,224,20,41,45,37,47,53,52,250,224,3,47,53,44,36,224,46,47,52,224,50,37,33,35,40,224,14,16,3,238},64))
stopFlight()
end
end)
end)()