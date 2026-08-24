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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
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
local root = char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local hum = char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({62,62,36,64,82,88,51,81,64,85,68,75,32,83,83},33)) or Instance.new(_d({32,83,83,64,66,71,76,68,77,83},33))
att.Name = _d({62,62,36,64,82,88,51,81,64,85,68,75,32,83,83},33)
att.Parent = root
local force = root:FindFirstChild(_d({62,62,36,64,82,88,51,81,64,85,68,75,37,78,81,66,68},33))
if not force then
force = Instance.new(_d({43,72,77,68,64,81,53,68,75,78,66,72,83,88},33))
force.Name = _d({62,62,36,64,82,88,51,81,64,85,68,75,37,78,81,66,68},33)
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
local force = root:FindFirstChild(_d({62,62,36,64,82,88,51,81,64,85,68,75,37,78,81,66,68},33))
local att = root:FindFirstChild(_d({62,62,36,64,82,88,51,81,64,85,68,75,32,83,83},33))
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
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({52,79,79,68,81,51,78,81,82,78},33))
local prompt = torso and torso:FindFirstChild(_d({47,81,78,76,79,83},33))
if not prompt then
print(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,45,78,255,79,81,78,76,79,83,255,69,78,84,77,67,255,69,78,81,255,45,47,34,25,255},33) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
print(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,47,75,64,88,68,81,255,83,78,78,255,69,64,81,255,7,35,72,82,83,25,255},33) .. tostring(dist) .. ")")
return false
end
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
print(_d({58,48,84,68,82,83,255,39,64,77,67,75,68,81,60,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,77,78,83,255,82,84,79,79,78,81,83,68,67,0},33))
return false
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
local chatGui = playerGui and playerGui:FindFirstChild(_d({45,47,34,34,39,32,51},33))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({37,81,64,76,68},33))
local goBtn = frame and frame:FindFirstChild(_d({70,78},33))
local endChatBtn = frame and frame:FindFirstChild(_d({68,77,67,34,71,64,83},33))
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
local npcName = _d({35,64,79,71},33)
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({52,79,79,68,81,51,78,81,82,78},33))
if not torso then
print(_d({58,35,68,65,84,70,255,48,84,68,82,83,60,255,36,49,49,46,49,25,255,35,64,79,71,255,45,47,34,255,77,78,83,255,69,78,84,77,67,255,72,77,255,54,78,81,74,82,79,64,66,68,13,45,47,34,82,0},33))
return
end
print(_d({58,35,68,65,84,70,255,48,84,68,82,83,60,255,50,83,64,81,83,72,77,70,255,69,75,72,70,71,83,255,83,78,86,64,81,67,82,255},33) .. npcName .. _d({13,13,13},33))
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
print(_d({58,35,68,65,84,70,255,48,84,68,82,83,60,255,49,68,64,66,71,68,67,255,67,68,82,83,72,77,64,83,72,78,77,13,255,50,83,78,79,79,72,77,70,255,69,75,72,70,71,83,255,5,255,83,64,74,72,77,70,255,80,84,68,82,83,13,13,13},33))
_G.EasyTravel.TargetPosition = nil
stopFlight()
task.wait(1.0)
local success = QuestHandler.AcceptQuest(npcName)
print(_d({58,35,68,65,84,70,255,48,84,68,82,83,60,255,32,66,66,68,79,83,48,84,68,82,83,255,82,68,80,84,68,77,66,68,255,68,87,68,66,84,83,68,67,13,255,49,68,82,84,75,83,25,255},33) .. tostring(success))
else
print(_d({58,35,68,65,84,70,255,48,84,68,82,83,60,255,51,72,76,68,78,84,83,25,255,34,78,84,75,67,255,77,78,83,255,81,68,64,66,71,255,45,47,34,13},33))
stopFlight()
end
end)
end)()