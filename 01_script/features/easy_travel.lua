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
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 3.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local GEPPO_COOLDOWN_MIN = 1.8
local GEPPO_COOLDOWN_MAX = 2.2
local flightEnabled = false
local currentTargetY = 0
local lastGeppoTime = 0
local currentGeppoCooldown = 2.0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local inputConnection = nil
local unloadGui = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hum = char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43)
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
local force = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43))
local att = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({35,68,67,58},43)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({39,68,64,74,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,58,69,69,68},43), args)
elseif style == _d({23,65,54,56,64,33,58,60},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64},43), args)
elseif style == _d({32,54,66,62,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,54,66,62,72,61,62,64,62,28,58,69,69,68},43), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64,7},43), args)
end
end)
end
local function getSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 250, position.Z)
local direction = Vector3.new(0, -500, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
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
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * 8, raycastParams)
if forwardHit then
local clearanceY = nil
for heightOffset = 4, 100, 4 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * 8, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
break
end
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local _, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
currentTargetY = root.Position.Y
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
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
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
currentTargetY = currentTargetY + (dt * 50)
isClimbing = false
elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
currentTargetY = currentTargetY - (dt * 50)
isClimbing = false
end
local finalTargetY = isClimbing and climbTargetY or currentTargetY
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 5 then
speedMultiplier = math.clamp(1 - (yError / 30), 0.1, 1)
end
targetVelocity = moveDir.Unit * (FLIGHT_SPEED * speedMultiplier)
end
local verticalVel = math.clamp(yError * 6, -150, 150)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + Vector3.new(look.X, 0, look.Z).Unit)
if (currentRoot.Position.Y - getSurfaceY(currentRoot.Position, char)) > 5 then
invokeGeppo()
end
end
end)
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,27,65,62,60,61,73,245,58,67,54,55,65,58,57,3},43))
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,27,65,62,60,61,73,245,57,62,72,54,55,65,58,57,3},43))
end
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
end
end)
local function createUnloadUI()
local playerGui = LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then return end
unloadGui = Instance.new(_d({40,56,71,58,58,67,28,74,62},43))
unloadGui.Name = _d({26,54,72,78,41,71,54,75,58,65,42,67,65,68,54,57,42,30},43)
unloadGui.ResetOnSpawn = false
unloadGui.Parent = playerGui
local button = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
button.Size = UDim2.new(0, 130, 0, 30)
button.Position = UDim2.new(1, -145, 1, -45)
button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
button.BorderSizePixel = 0
button.Font = Enum.Font.GothamBold
button.TextSize = 11
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Text = _d({42,67,65,68,54,57,245,26,54,72,78,245,41,71,54,75,58,65},43)
button.Parent = unloadGui
local corner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
corner.CornerRadius = UDim.new(0, 6)
corner.Parent = button
local stroke = Instance.new(_d({42,30,40,73,71,68,64,58},43))
stroke.Color = Color3.fromRGB(255, 100, 100)
stroke.Thickness = 1
stroke.Parent = button
button.MouseButton1Click:Connect(function()
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end)
end
task.spawn(createUnloadUI)
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
if unloadGui then
unloadGui:Destroy()
unloadGui = nil
end
_G.EasyTravelCleanup = nil
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,24,68,66,69,65,58,73,58,65,78,245,74,67,65,68,54,57,58,57,245,54,67,57,245,56,65,58,54,67,58,57,245,74,69,245,68,65,57,245,72,56,71,62,69,73,245,72,73,54,73,58,3},43))
end
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,33,68,54,57,58,57,3,245,37,71,58,72,72,245,252,37,252,245,73,68,245,73,68,60,60,65,58,245,60,71,68,74,67,57,2,59,68,65,65,68,76,62,67,60,245,44,22,40,25,245,59,65,62,60,61,73,3},43))
return {
Start = startFlight,
Stop = stopFlight,
}
end)()