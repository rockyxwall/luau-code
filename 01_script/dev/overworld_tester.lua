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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({45,40,48,41},60)
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
print(_d({31,19,58,41,54,59,51,54,48,40,24,41,55,56,41,54,33},60), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({22,51,47,57,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,41,52,52,51},60), args)
elseif style == _d({6,48,37,39,47,16,41,43},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47},60), args)
elseif style == _d({15,37,49,45,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,37,49,45,55,44,45,47,45,11,41,52,52,51},60), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47,246},60), args)
end
debug(_d({10,45,54,41,40,228,11,41,52,52,51,228,22,41,49,51,56,41},60))
end)
if not ok then debug(_d({45,50,58,51,47,41,11,41,52,52,51,228,41,54,54,51,54,254},60), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({35,35,24,41,55,56,12,51,58,41,54,5,56,56},60)) or Instance.new(_d({5,56,56,37,39,44,49,41,50,56},60))
att.Name = _d({35,35,24,41,55,56,12,51,58,41,54,5,56,56},60)
att.Parent = root
local force = root:FindFirstChild(_d({35,35,24,41,55,56,12,51,58,41,54,10,51,54,39,41},60))
if not force then
force = Instance.new(_d({16,45,50,41,37,54,26,41,48,51,39,45,56,61},60))
force.Name = _d({35,35,24,41,55,56,12,51,58,41,54,10,51,54,39,41},60)
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
local root = char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if not root then return end
local force = root:FindFirstChild(_d({35,35,24,41,55,56,12,51,58,41,54,10,51,54,39,41},60))
local att   = root:FindFirstChild(_d({35,35,24,41,55,56,12,51,58,41,54,5,56,56},60))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({27,37,48,47,45,50,43,228,56,51,254},60), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({59,37,48,47,24,51,20,51,45,50,56,228,27,228,40,51,59,50,228,41,54,54,51,54,254},60), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({5,54,54,45,58,41,40,228,37,56,254},60), pos)
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
if item:IsA(_d({17,51,40,41,48},60)) and item:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60)) and item:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
mode = _d({45,40,48,41},60)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({24,41,55,56,41,54,228,8,45,55,37,38,48,41,40},60))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({24,41,55,56,41,54,228,9,50,37,38,48,41,40,242,228,17,51,40,41,254},60), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({20,48,37,61,41,54,228,40,45,41,40,229,228,8,45,55,37,38,48,45,50,43,228,38,51,56,242},60))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({44,51,58,41,54},60) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({40,51,40,43,41},60) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({55,53,57,37,54,41,35,40,51,40,43,41},60) then
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
local playerGui = LocalPlayer:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({19,58,41,54,59,51,54,48,40,24,41,55,56,11,57,45},60))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({23,39,54,41,41,50,11,57,45},60))
screenGui.Name = _d({19,58,41,54,59,51,54,48,40,24,41,55,56,11,57,45},60)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({10,54,37,49,41},60))
frame.Name = _d({17,37,45,50,10,54,37,49,41},60)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({25,13,7,51,54,50,41,54},60))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({24,41,60,56,16,37,38,41,48},60))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({180,99,95,101,179,124,83,228,7,57,52,45,40,228,9,50,43,45,50,41,228,19,58,41,54,59,51,54,48,40,228,24,41,55,56},60)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({24,41,60,56,16,37,38,41,48},60))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({23,56,37,56,57,55,254,228,13,40,48,41},60)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({24,41,60,56,6,57,56,56,51,50},60))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({25,13,7,51,54,50,41,54},60), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({24,41,60,56,6,51,60},60))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({25,13,7,51,54,50,41,54},60), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({12,51,58,41,54,228,5,38,51,58,41,228,24,37,54,43,41,56},60), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({44,51,58,41,54},60))
statusLabel.Text = _d({23,56,37,56,57,55,254,228,12,51,58,41,54,45,50,43,228},60) .. val .. _d({228,55,56,57,40,55,228,57,52},60)
end)
createInputBtn(_d({8,51,40,43,41,228,7,48,45,49,38},60), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({40,51,40,43,41},60))
statusLabel.Text = _d({23,56,37,56,57,55,254,228,8,51,40,43,41,241,44,51,48,40,45,50,43,228,236},60) .. val .. _d({228,55,56,57,40,55,237},60)
end)
createInputBtn(_d({24,41,55,56,228,23,53,57,37,54,41,228,8,51,40,43,41},60), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({55,53,57,37,54,41,35,40,51,40,43,41},60))
statusLabel.Text = _d({23,56,37,56,57,55,254,228,23,53,57,37,54,41,228,27,37,48,47,45,50,43,228,236},60) .. val .. _d({228,55,56,57,40,55,237},60)
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
while enabled and mode == _d({55,53,57,37,54,41,35,40,51,40,43,41},60) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({55,53,57,37,54,41,35,40,51,40,43,41},60) then
disableBot()
statusLabel.Text = _d({23,56,37,56,57,55,254,228,13,40,48,41,228,236,23,53,57,37,54,41,228,40,51,40,43,41,228,40,51,50,41,237},60)
end
end)
end)
local stopBtn = Instance.new(_d({24,41,60,56,6,57,56,56,51,50},60))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({9,17,9,22,11,9,18,7,29,228,23,24,19,20},60)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({25,13,7,51,54,50,41,54},60), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({23,56,37,56,57,55,254,228,23,24,19,20,20,9,8,228,236,13,40,48,41,237},60)
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({31,19,58,41,54,59,51,54,48,40,24,41,55,56,41,54,33,228,16,51,37,40,41,40,228,55,57,39,39,41,55,55,42,57,48,48,61,242},60))
end)()