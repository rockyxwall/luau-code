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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 3.0
local RAYCAST_COOLDOWN = 0.05
local GEPPO_COOLDOWN_MIN = 1.8
local GEPPO_COOLDOWN_MAX = 2.2
local flightEnabled = false
local currentTargetY = 0
local lastGeppoTime = 0
local currentGeppoCooldown = 2.0
local loopConnection = nil
local raycastConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16)) or Instance.new(_d({49,100,100,81,83,88,93,85,94,100},16))
att.Name = _d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16)
att.Parent = root
local force = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16))
if not force then
force = Instance.new(_d({60,89,94,85,81,98,70,85,92,95,83,89,100,105},16))
force.Name = _d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16)
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
local force = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,54,95,98,83,85},16))
local att = root:FindFirstChild(_d({79,79,53,81,99,105,68,98,81,102,85,92,49,100,100},16))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < currentGeppoCooldown then return end
lastGeppoTime = now
currentGeppoCooldown = math.random(GEPPO_COOLDOWN_MIN * 100, GEPPO_COOLDOWN_MAX * 100) / 100
pcall(function()
local char, _, root = getCharacterComponents()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({62,95,94,85},16)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({66,95,91,101,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,85,96,96,95},16), args)
elseif style == _d({50,92,81,83,91,60,85,87},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91},16), args)
elseif style == _d({59,81,93,89,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,81,93,89,99,88,89,91,89,55,85,96,96,95},16), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91,34},16), args)
end
end)
end
local function getSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = false
local startPos = Vector3.new(position.X, position.Y + 250, position.Z)
local direction = Vector3.new(0, -500, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
if result then
return result.Position.Y
end
return -18
end
local function runRaycastLoop()
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local currentPos = root.Position
local currentGroundY = getSurfaceY(currentPos, char)
if moveDir.Magnitude > 0 then
local lookAheadDistance = math.clamp(FLIGHT_SPEED * 0.1, 4, 12)
local aheadPos = currentPos + (moveDir.Unit * lookAheadDistance)
local aheadGroundY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(currentGroundY, aheadGroundY) + HEIGHT_OFFSET
else
currentTargetY = currentGroundY + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local _, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
currentTargetY = root.Position.Y
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect() loopConnection = nil end
cleanupForce()
return
end
pcall(function()
currentHum:SetStateEnabled(Enum.HumanoidStateType.Freefall, false)
currentHum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
currentHum:ChangeState(Enum.HumanoidStateType.Running)
end)
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * FLIGHT_SPEED) or Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
currentTargetY = currentTargetY + (dt * 50)
elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
currentTargetY = currentTargetY - (dt * 50)
end
local yError = currentTargetY - currentRoot.Position.Y
local verticalVel = math.clamp(yError * 5, -120, 120)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + Vector3.new(look.X, 0, look.Z).Unit)
if (currentRoot.Position.Y - currentTargetY + HEIGHT_OFFSET) > 5 then
invokeGeppo()
end
end
end)
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,54,92,89,87,88,100,16,85,94,81,82,92,85,84,30},16))
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,54,92,89,87,88,100,16,84,89,99,81,82,92,85,84,30},16))
end
UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
end
end)
print(_d({75,53,81,99,105,16,68,98,81,102,85,92,77,16,60,95,81,84,85,84,30,16,64,98,85,99,99,16,23,64,23,16,100,95,16,100,95,87,87,92,85,16,87,98,95,101,94,84,29,86,95,92,92,95,103,89,94,87,16,71,49,67,52,16,86,92,89,87,88,100,30},16))
return {
Start = startFlight,
Stop = stopFlight,
}
end)()