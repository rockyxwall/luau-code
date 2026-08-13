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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({57,52,60,53},48)
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local HOVER_OFFSET = 10.3
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5
local currentHoverOffset = HOVER_OFFSET
local currentDodgeHeight = 70
local function debug(...)
print(_d({43,31,70,53,66,71,63,66,60,52,36,53,67,68,53,66,45},48), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({34,63,59,69,67,56,57,59,57},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,53,64,64,63},48), args)
elseif style == _d({18,60,49,51,59,28,53,55},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,59,73,240,39,49,60,59},48), args)
elseif style == _d({27,49,61,57,67,56,57,59,57},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,49,61,57,67,56,57,59,57,23,53,64,64,63},48), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,59,73,240,39,49,60,59,2},48), args)
end
debug(_d({22,57,66,53,52,240,23,53,64,64,63,240,34,53,61,63,68,53},48))
end)
if not ok then debug(_d({57,62,70,63,59,53,23,53,64,64,63,240,53,66,66,63,66,10},48), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48)) or Instance.new(_d({17,68,68,49,51,56,61,53,62,68},48))
att.Name = _d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48)
att.Parent = root
local force = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48))
if not force then
force = Instance.new(_d({28,57,62,53,49,66,38,53,60,63,51,57,68,73},48))
force.Name = _d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then return result end
return nil
end
local function cleanupForce()
pcall(function()
local char = LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local force = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48))
local att   = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({39,49,60,59,57,62,55,240,68,63,10},48), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({71,49,60,59,36,63,32,63,57,62,68,240,39,240,52,63,71,62,240,53,66,66,63,66,10},48), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({17,66,66,57,70,53,52,240,49,68,10},48), pos)
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10)
end)
if tick() - lastDash >= dashCooldown then
pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
lastDash = tick()
end
task.wait()
end
pcall(function()
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
end)
end
local function getNearestTarget()
local root = getRoot()
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({29,63,52,53,60},48)) and item:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48)) and item:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)).Health > 0 then
local dist = (item.HumanoidRootPart.Position - root.Position).Magnitude
if dist < nearestDist then
nearestDist = dist
nearest = item
end
end
end
end
return nearest
end
local function computeLookDownCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function disableBot()
if not enabled then return end
enabled = false
mode = _d({57,52,60,53},48)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({36,53,67,68,53,66,240,20,57,67,49,50,60,53,52},48))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({36,53,67,68,53,66,240,21,62,49,50,60,53,52,254,240,29,63,52,53,10},48), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({32,60,49,73,53,66,240,52,57,53,52,241,240,20,57,67,49,50,60,57,62,55,240,50,63,68,254},48))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({56,63,70,53,66},48) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({52,63,52,55,53},48) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) then
return
end
if not aim then
aim = lastAim or root.Position
face = lastFace or aim
end
lastAim = aim
lastFace = face
local pos = root.Position
local yErr = aim.Y - pos.Y
local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60)) or Vector3.zero
local force = getOrCreateForce(root)
if force then
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
end
if xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
pcall(function()
root.CFrame = computeLookDownCFrame(root, face) + (aim - root.Position)
end)
else
pcall(function()
root.CFrame = computeLookDownCFrame(root, face)
end)
if yErr > 5 then
invokeGeppo()
end
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({31,70,53,66,71,63,66,60,52,36,53,67,68,23,69,57},48))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({35,51,66,53,53,62,23,69,57},48))
screenGui.Name = _d({31,70,53,66,71,63,66,60,52,36,53,67,68,23,69,57},48)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({22,66,49,61,53},48))
frame.Name = _d({29,49,57,62,22,66,49,61,53},48)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({37,25,19,63,66,62,53,66},48))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({192,111,107,113,191,136,95,240,19,69,64,57,52,240,21,62,55,57,62,53,240,31,70,53,66,71,63,66,60,52,240,36,53,67,68},48)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({35,68,49,68,69,67,10,240,25,52,60,53},48)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({36,53,72,68,18,63,72},48))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({24,63,70,53,66,240,17,50,63,70,53,240,36,49,66,55,53,68},48), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({56,63,70,53,66},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,24,63,70,53,66,57,62,55,240},48) .. val .. _d({240,67,68,69,52,67,240,69,64},48)
end)
createInputBtn(_d({20,63,52,55,53,240,19,60,57,61,50},48), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({52,63,52,55,53},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,20,63,52,55,53,253,56,63,60,52,57,62,55,240,248},48) .. val .. _d({240,67,68,69,52,67,249},48)
end)
createInputBtn(_d({36,53,67,68,240,35,65,69,49,66,53,240,20,63,52,55,53},48), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({67,65,69,49,66,53,47,52,63,52,55,53},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,35,65,69,49,66,53,240,39,49,60,59,57,62,55,240,248},48) .. val .. _d({240,67,68,69,52,67,249},48)
task.spawn(function()
local root = getRoot()
if not root then return end
local center = root.Position
local d = val
local corners = {
center + Vector3.new(d, 0, d),
center + Vector3.new(-d, 0, d),
center + Vector3.new(-d, 0, -d),
center + Vector3.new(d, 0, -d)
}
local startT = tick()
local cornerIdx = 1
while enabled and mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) then
disableBot()
statusLabel.Text = _d({35,68,49,68,69,67,10,240,25,52,60,53,240,248,35,65,69,49,66,53,240,52,63,52,55,53,240,52,63,62,53,249},48)
end
end)
end)
local stopBtn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({21,29,21,34,23,21,30,19,41,240,35,36,31,32},48)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({35,68,49,68,69,67,10,240,35,36,31,32,32,21,20,240,248,25,52,60,53,249},48)
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({43,31,70,53,66,71,63,66,60,52,36,53,67,68,53,66,45,240,28,63,49,52,53,52,240,67,69,51,51,53,67,67,54,69,60,60,73,254},48))
end)()