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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
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
local root = char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local hum = char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({56,56,30,58,76,82,45,75,58,79,62,69,26,77,77},39)) or Instance.new(_d({26,77,77,58,60,65,70,62,71,77},39))
att.Name = _d({56,56,30,58,76,82,45,75,58,79,62,69,26,77,77},39)
att.Parent = root
local force = root:FindFirstChild(_d({56,56,30,58,76,82,45,75,58,79,62,69,31,72,75,60,62},39))
if not force then
force = Instance.new(_d({37,66,71,62,58,75,47,62,69,72,60,66,77,82},39))
force.Name = _d({56,56,30,58,76,82,45,75,58,79,62,69,31,72,75,60,62},39)
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
local force = root:FindFirstChild(_d({56,56,30,58,76,82,45,75,58,79,62,69,31,72,75,60,62},39))
local att = root:FindFirstChild(_d({56,56,30,58,76,82,45,75,58,79,62,69,26,77,77},39))
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
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({46,73,73,62,75,45,72,75,76,72},39))
local prompt = torso and torso:FindFirstChild(_d({41,75,72,70,73,77},39))
if not prompt then
print(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,39,72,249,73,75,72,70,73,77,249,63,72,78,71,61,249,63,72,75,249,39,41,28,19,249},39) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,41,69,58,82,62,75,249,77,72,72,249,63,58,75,249,1,29,66,76,77,19,249},39) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({52,42,78,62,76,77,249,33,58,71,61,69,62,75,54,249,63,66,75,62,73,75,72,81,66,70,66,77,82,73,75,72,70,73,77,249,71,72,77,249,76,78,73,73,72,75,77,62,61,250},39))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({41,69,58,82,62,75,32,78,66},39))
local chatGui = playerGui and playerGui:FindFirstChild(_d({39,41,28,28,33,26,45},39))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({31,75,58,70,62},39))
local goBtn = frame and frame:FindFirstChild(_d({64,72},39))
local endChatBtn = frame and frame:FindFirstChild(_d({62,71,61,28,65,58,77},39))
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
local npcName = _d({29,58,73,65},39)
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({46,73,73,62,75,45,72,75,76,72},39))
if not torso then
print(_d({52,29,62,59,78,64,249,42,78,62,76,77,54,249,30,43,43,40,43,19,249,29,58,73,65,249,39,41,28,249,71,72,77,249,63,72,78,71,61,249,66,71,249,48,72,75,68,76,73,58,60,62,7,39,41,28,76,250},39))
return
end
print(_d({52,29,62,59,78,64,249,42,78,62,76,77,54,249,44,77,58,75,77,66,71,64,249,63,69,66,64,65,77,249,77,72,80,58,75,61,76,249},39) .. npcName .. _d({7,7,7},39))
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
print(_d({52,29,62,59,78,64,249,42,78,62,76,77,54,249,43,62,58,60,65,62,61,249,61,62,76,77,66,71,58,77,66,72,71,7,249,44,77,72,73,73,66,71,64,249,63,69,66,64,65,77,249,255,249,77,58,68,66,71,64,249,74,78,62,76,77,7,7,7},39))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({52,29,62,59,78,64,249,42,78,62,76,77,54,249,26,60,60,62,73,77,42,78,62,76,77,249,76,62,74,78,62,71,60,62,249,62,81,62,60,78,77,62,61,7,249,43,62,76,78,69,77,19,249},39) .. tostring(success))
else
print(_d({52,29,62,59,78,64,249,42,78,62,76,77,54,249,45,66,70,62,72,78,77,19,249,28,72,78,69,61,249,71,72,77,249,75,62,58,60,65,249,39,41,28,7},39))
stopFlight()
end
end)
end)()