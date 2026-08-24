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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
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
local root = char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum = char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({57,57,31,59,77,83,46,76,59,80,63,70,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,31,59,77,83,46,76,59,80,63,70,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,31,59,77,83,46,76,59,80,63,70,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,31,59,77,83,46,76,59,80,63,70,32,73,76,61,63},38)
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
local force = root:FindFirstChild(_d({57,57,31,59,77,83,46,76,59,80,63,70,32,73,76,61,63},38))
local att = root:FindFirstChild(_d({57,57,31,59,77,83,46,76,59,80,63,70,27,78,78},38))
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
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({47,74,74,63,76,46,73,76,77,73},38))
local prompt = torso and torso:FindFirstChild(_d({42,76,73,71,74,78},38))
if not prompt then
print(_d({53,43,79,63,77,78,250,34,59,72,62,70,63,76,55,250,40,73,250,74,76,73,71,74,78,250,64,73,79,72,62,250,64,73,76,250,40,42,29,20,250},38) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({53,43,79,63,77,78,250,34,59,72,62,70,63,76,55,250,42,70,59,83,63,76,250,78,73,73,250,64,59,76,250,2,30,67,77,78,20,250},38) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({53,43,79,63,77,78,250,34,59,72,62,70,63,76,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,72,73,78,250,77,79,74,74,73,76,78,63,62,251},38))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({42,70,59,83,63,76,33,79,67},38))
local chatGui = playerGui and playerGui:FindFirstChild(_d({40,42,29,29,34,27,46},38))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({32,76,59,71,63},38))
local goBtn = frame and frame:FindFirstChild(_d({65,73},38))
local endChatBtn = frame and frame:FindFirstChild(_d({63,72,62,29,66,59,78},38))
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
local npcName = _d({30,59,74,66},38)
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({47,74,74,63,76,46,73,76,77,73},38))
if not torso then
print(_d({53,30,63,60,79,65,250,43,79,63,77,78,55,250,31,44,44,41,44,20,250,30,59,74,66,250,40,42,29,250,72,73,78,250,64,73,79,72,62,250,67,72,250,49,73,76,69,77,74,59,61,63,8,40,42,29,77,251},38))
return
end
print(_d({53,30,63,60,79,65,250,43,79,63,77,78,55,250,45,78,59,76,78,67,72,65,250,64,70,67,65,66,78,250,78,73,81,59,76,62,77,250},38) .. npcName .. _d({8,8,8},38))
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
print(_d({53,30,63,60,79,65,250,43,79,63,77,78,55,250,44,63,59,61,66,63,62,250,62,63,77,78,67,72,59,78,67,73,72,8,250,45,78,73,74,74,67,72,65,250,64,70,67,65,66,78,250,0,250,78,59,69,67,72,65,250,75,79,63,77,78,8,8,8},38))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({53,30,63,60,79,65,250,43,79,63,77,78,55,250,27,61,61,63,74,78,43,79,63,77,78,250,77,63,75,79,63,72,61,63,250,63,82,63,61,79,78,63,62,8,250,44,63,77,79,70,78,20,250},38) .. tostring(success))
else
print(_d({53,30,63,60,79,65,250,43,79,63,77,78,55,250,46,67,71,63,73,79,78,20,250,29,73,79,70,62,250,72,73,78,250,76,63,59,61,66,250,40,42,29,8},38))
stopFlight()
end
end)
end)()