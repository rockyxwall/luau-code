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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local UserInputService = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
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
local root = char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local hum = char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({70,70,44,72,90,96,59,89,72,93,76,83,40,91,91},25)) or Instance.new(_d({40,91,91,72,74,79,84,76,85,91},25))
att.Name = _d({70,70,44,72,90,96,59,89,72,93,76,83,40,91,91},25)
att.Parent = root
local force = root:FindFirstChild(_d({70,70,44,72,90,96,59,89,72,93,76,83,45,86,89,74,76},25))
if not force then
force = Instance.new(_d({51,80,85,76,72,89,61,76,83,86,74,80,91,96},25))
force.Name = _d({70,70,44,72,90,96,59,89,72,93,76,83,45,86,89,74,76},25)
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
local force = root:FindFirstChild(_d({70,70,44,72,90,96,59,89,72,93,76,83,45,86,89,74,76},25))
local att = root:FindFirstChild(_d({70,70,44,72,90,96,59,89,72,93,76,83,40,91,91},25))
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
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({60,87,87,76,89,59,86,89,90,86},25))
local prompt = torso and torso:FindFirstChild(_d({55,89,86,84,87,91},25))
if not prompt then
print(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,53,86,7,87,89,86,84,87,91,7,77,86,92,85,75,7,77,86,89,7,53,55,42,33,7},25) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,55,83,72,96,76,89,7,91,86,86,7,77,72,89,7,15,43,80,90,91,33,7},25) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({66,56,92,76,90,91,7,47,72,85,75,83,76,89,68,7,77,80,89,76,87,89,86,95,80,84,80,91,96,87,89,86,84,87,91,7,85,86,91,7,90,92,87,87,86,89,91,76,75,8},25))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({55,83,72,96,76,89,46,92,80},25))
local chatGui = playerGui and playerGui:FindFirstChild(_d({53,55,42,42,47,40,59},25))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({45,89,72,84,76},25))
local goBtn = frame and frame:FindFirstChild(_d({78,86},25))
local endChatBtn = frame and frame:FindFirstChild(_d({76,85,75,42,79,72,91},25))
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
local npcName = _d({43,72,87,79},25)
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({60,87,87,76,89,59,86,89,90,86},25))
if not torso then
print(_d({66,43,76,73,92,78,7,56,92,76,90,91,68,7,44,57,57,54,57,33,7,43,72,87,79,7,53,55,42,7,85,86,91,7,77,86,92,85,75,7,80,85,7,62,86,89,82,90,87,72,74,76,21,53,55,42,90,8},25))
return
end
print(_d({66,43,76,73,92,78,7,56,92,76,90,91,68,7,58,91,72,89,91,80,85,78,7,77,83,80,78,79,91,7,91,86,94,72,89,75,90,7},25) .. npcName .. _d({21,21,21},25))
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
print(_d({66,43,76,73,92,78,7,56,92,76,90,91,68,7,57,76,72,74,79,76,75,7,75,76,90,91,80,85,72,91,80,86,85,21,7,58,91,86,87,87,80,85,78,7,77,83,80,78,79,91,7,13,7,91,72,82,80,85,78,7,88,92,76,90,91,21,21,21},25))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({66,43,76,73,92,78,7,56,92,76,90,91,68,7,40,74,74,76,87,91,56,92,76,90,91,7,90,76,88,92,76,85,74,76,7,76,95,76,74,92,91,76,75,21,7,57,76,90,92,83,91,33,7},25) .. tostring(success))
else
print(_d({66,43,76,73,92,78,7,56,92,76,90,91,68,7,59,80,84,76,86,92,91,33,7,42,86,92,83,75,7,85,86,91,7,89,76,72,74,79,7,53,55,42,21},25))
stopFlight()
end
end)
end)()