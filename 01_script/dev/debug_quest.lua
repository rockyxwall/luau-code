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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local RunService = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local UserInputService = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
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
Enabled = false,
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then
return nil, nil, nil
end
local root = char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local hum = char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({55,55,29,57,75,81,44,74,57,78,61,68,25,76,76},40)) or Instance.new(_d({25,76,76,57,59,64,69,61,70,76},40))
att.Name = _d({55,55,29,57,75,81,44,74,57,78,61,68,25,76,76},40)
att.Parent = root
local force = root:FindFirstChild(_d({55,55,29,57,75,81,44,74,57,78,61,68,30,71,74,59,61},40))
if not force then
force = Instance.new(_d({36,65,70,61,57,74,46,61,68,71,59,65,76,81},40))
force.Name = _d({55,55,29,57,75,81,44,74,57,78,61,68,30,71,74,59,61},40)
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
local force = root:FindFirstChild(_d({55,55,29,57,75,81,44,74,57,78,61,68,30,71,74,59,61},40))
local att = root:FindFirstChild(_d({55,55,29,57,75,81,44,74,57,78,61,68,25,76,76},40))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
local function getSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if not root or not hum then
return
end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({45,72,72,61,74,44,71,74,75,71},40))
local prompt = torso and torso:FindFirstChild(_d({40,74,71,69,72,76},40))
if not prompt then
print(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,38,71,248,72,74,71,69,72,76,248,62,71,77,70,60,248,62,71,74,248,38,40,27,18,248},40) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not myRoot then
return false
end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,40,68,57,81,61,74,248,76,71,71,248,62,57,74,248,0,28,65,75,76,18,248},40) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({51,41,77,61,75,76,248,32,57,70,60,68,61,74,53,248,62,65,74,61,72,74,71,80,65,69,65,76,81,72,74,71,69,72,76,248,70,71,76,248,75,77,72,72,71,74,76,61,60,249},40))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({40,68,57,81,61,74,31,77,65},40))
local chatGui = playerGui and playerGui:FindFirstChild(_d({38,40,27,27,32,25,44},40))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({30,74,57,69,61},40))
local goBtn = frame and frame:FindFirstChild(_d({63,71},40))
local endChatBtn = frame and frame:FindFirstChild(_d({61,70,60,27,64,57,76},40))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
pcall(function()
conn:Fire()
end)
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function()
conn:Fire()
end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
pcall(function()
conn:Fire()
end)
end
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
pcall(function()
conn:Fire()
end)
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
local npcName = _d({28,57,72,64},40)
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({45,72,72,61,74,44,71,74,75,71},40))
if not torso then
print(_d({51,28,61,58,77,63,248,41,77,61,75,76,53,248,29,42,42,39,42,18,248,28,57,72,64,248,38,40,27,248,70,71,76,248,62,71,77,70,60,248,65,70,248,47,71,74,67,75,72,57,59,61,6,38,40,27,75,249},40))
return
end
print(_d({51,28,61,58,77,63,248,41,77,61,75,76,53,248,43,76,57,74,76,65,70,63,248,62,68,65,63,64,76,248,76,71,79,57,74,60,75,248},40) .. npcName .. _d({6,6,6},40))
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
print(_d({51,28,61,58,77,63,248,41,77,61,75,76,53,248,42,61,57,59,64,61,60,248,60,61,75,76,65,70,57,76,65,71,70,6,248,43,76,71,72,72,65,70,63,248,62,68,65,63,64,76,248,254,248,76,57,67,65,70,63,248,73,77,61,75,76,6,6,6},40))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({51,28,61,58,77,63,248,41,77,61,75,76,53,248,25,59,59,61,72,76,41,77,61,75,76,248,75,61,73,77,61,70,59,61,248,61,80,61,59,77,76,61,60,6,248,42,61,75,77,68,76,18,248},40) .. tostring(success))
else
print(_d({51,28,61,58,77,63,248,41,77,61,75,76,53,248,44,65,69,61,71,77,76,18,248,27,71,77,68,60,248,70,71,76,248,74,61,57,59,64,248,38,40,27,6},40))
stopFlight()
end
end)
end)()