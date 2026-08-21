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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({44,39,47,40},61)
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
print(_d({30,18,57,40,53,58,50,53,47,39,23,40,54,55,40,53,32},61), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({21,50,46,56,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({10,40,51,51,50},61), args)
elseif style == _d({5,47,36,38,46,15,40,42},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46},61), args)
elseif style == _d({14,36,48,44,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,36,48,44,54,43,44,46,44,10,40,51,51,50},61), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46,245},61), args)
end
debug(_d({9,44,53,40,39,227,10,40,51,51,50,227,21,40,48,50,55,40},61))
end)
if not ok then debug(_d({44,49,57,50,46,40,10,40,51,51,50,227,40,53,53,50,53,253},61), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({34,34,23,40,54,55,11,50,57,40,53,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,23,40,54,55,11,50,57,40,53,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,23,40,54,55,11,50,57,40,53,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,23,40,54,55,11,50,57,40,53,9,50,53,38,40},61)
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
local root = char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local force = root:FindFirstChild(_d({34,34,23,40,54,55,11,50,57,40,53,9,50,53,38,40},61))
local att   = root:FindFirstChild(_d({34,34,23,40,54,55,11,50,57,40,53,4,55,55},61))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({26,36,47,46,44,49,42,227,55,50,253},61), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({58,36,47,46,23,50,19,50,44,49,55,227,26,227,39,50,58,49,227,40,53,53,50,53,253},61), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({4,53,53,44,57,40,39,227,36,55,253},61), pos)
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
if item:IsA(_d({16,50,39,40,47},61)) and item:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61)) and item:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
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
mode = _d({44,39,47,40},61)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({23,40,54,55,40,53,227,7,44,54,36,37,47,40,39},61))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({23,40,54,55,40,53,227,8,49,36,37,47,40,39,241,227,16,50,39,40,253},61), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({19,47,36,60,40,53,227,39,44,40,39,228,227,7,44,54,36,37,47,44,49,42,227,37,50,55,241},61))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({43,50,57,40,53},61) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({39,50,39,42,40},61) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({54,52,56,36,53,40,34,39,50,39,42,40},61) then
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
local playerGui = LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({18,57,40,53,58,50,53,47,39,23,40,54,55,10,56,44},61))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({22,38,53,40,40,49,10,56,44},61))
screenGui.Name = _d({18,57,40,53,58,50,53,47,39,23,40,54,55,10,56,44},61)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({9,53,36,48,40},61))
frame.Name = _d({16,36,44,49,9,53,36,48,40},61)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({24,12,6,50,53,49,40,53},61))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({23,40,59,55,15,36,37,40,47},61))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({179,98,94,100,178,123,82,227,6,56,51,44,39,227,8,49,42,44,49,40,227,18,57,40,53,58,50,53,47,39,227,23,40,54,55},61)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({23,40,59,55,15,36,37,40,47},61))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({22,55,36,55,56,54,253,227,12,39,47,40},61)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({23,40,59,55,5,56,55,55,50,49},61))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({24,12,6,50,53,49,40,53},61), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({23,40,59,55,5,50,59},61))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({24,12,6,50,53,49,40,53},61), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({11,50,57,40,53,227,4,37,50,57,40,227,23,36,53,42,40,55},61), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({43,50,57,40,53},61))
statusLabel.Text = _d({22,55,36,55,56,54,253,227,11,50,57,40,53,44,49,42,227},61) .. val .. _d({227,54,55,56,39,54,227,56,51},61)
end)
createInputBtn(_d({7,50,39,42,40,227,6,47,44,48,37},61), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({39,50,39,42,40},61))
statusLabel.Text = _d({22,55,36,55,56,54,253,227,7,50,39,42,40,240,43,50,47,39,44,49,42,227,235},61) .. val .. _d({227,54,55,56,39,54,236},61)
end)
createInputBtn(_d({23,40,54,55,227,22,52,56,36,53,40,227,7,50,39,42,40},61), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({54,52,56,36,53,40,34,39,50,39,42,40},61))
statusLabel.Text = _d({22,55,36,55,56,54,253,227,22,52,56,36,53,40,227,26,36,47,46,44,49,42,227,235},61) .. val .. _d({227,54,55,56,39,54,236},61)
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
while enabled and mode == _d({54,52,56,36,53,40,34,39,50,39,42,40},61) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({54,52,56,36,53,40,34,39,50,39,42,40},61) then
disableBot()
statusLabel.Text = _d({22,55,36,55,56,54,253,227,12,39,47,40,227,235,22,52,56,36,53,40,227,39,50,39,42,40,227,39,50,49,40,236},61)
end
end)
end)
local stopBtn = Instance.new(_d({23,40,59,55,5,56,55,55,50,49},61))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({8,16,8,21,10,8,17,6,28,227,22,23,18,19},61)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({24,12,6,50,53,49,40,53},61), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({22,55,36,55,56,54,253,227,22,23,18,19,19,8,7,227,235,12,39,47,40,236},61)
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({30,18,57,40,53,58,50,53,47,39,23,40,54,55,40,53,32,227,15,50,36,39,40,39,227,54,56,38,38,40,54,54,41,56,47,47,60,241},61))
end)()