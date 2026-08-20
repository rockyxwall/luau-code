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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({50,45,53,46},55)
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
print(_d({36,24,63,46,59,64,56,59,53,45,29,46,60,61,46,59,38},55), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({27,56,52,62,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,46,57,57,56},55), args)
elseif style == _d({11,53,42,44,52,21,46,48},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52},55), args)
elseif style == _d({20,42,54,50,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,42,54,50,60,49,50,52,50,16,46,57,57,56},55), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52,251},55), args)
end
debug(_d({15,50,59,46,45,233,16,46,57,57,56,233,27,46,54,56,61,46},55))
end)
if not ok then debug(_d({50,55,63,56,52,46,16,46,57,57,56,233,46,59,59,56,59,3},55), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({40,40,29,46,60,61,17,56,63,46,59,10,61,61},55)) or Instance.new(_d({10,61,61,42,44,49,54,46,55,61},55))
att.Name = _d({40,40,29,46,60,61,17,56,63,46,59,10,61,61},55)
att.Parent = root
local force = root:FindFirstChild(_d({40,40,29,46,60,61,17,56,63,46,59,15,56,59,44,46},55))
if not force then
force = Instance.new(_d({21,50,55,46,42,59,31,46,53,56,44,50,61,66},55))
force.Name = _d({40,40,29,46,60,61,17,56,63,46,59,15,56,59,44,46},55)
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
local root = char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if not root then return end
local force = root:FindFirstChild(_d({40,40,29,46,60,61,17,56,63,46,59,15,56,59,44,46},55))
local att   = root:FindFirstChild(_d({40,40,29,46,60,61,17,56,63,46,59,10,61,61},55))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({32,42,53,52,50,55,48,233,61,56,3},55), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({64,42,53,52,29,56,25,56,50,55,61,233,32,233,45,56,64,55,233,46,59,59,56,59,3},55), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({10,59,59,50,63,46,45,233,42,61,3},55), pos)
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
if item:IsA(_d({22,56,45,46,53},55)) and item:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55)) and item:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
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
mode = _d({50,45,53,46},55)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({29,46,60,61,46,59,233,13,50,60,42,43,53,46,45},55))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({29,46,60,61,46,59,233,14,55,42,43,53,46,45,247,233,22,56,45,46,3},55), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({25,53,42,66,46,59,233,45,50,46,45,234,233,13,50,60,42,43,53,50,55,48,233,43,56,61,247},55))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({49,56,63,46,59},55) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({45,56,45,48,46},55) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({60,58,62,42,59,46,40,45,56,45,48,46},55) then
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
local playerGui = LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({24,63,46,59,64,56,59,53,45,29,46,60,61,16,62,50},55))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({28,44,59,46,46,55,16,62,50},55))
screenGui.Name = _d({24,63,46,59,64,56,59,53,45,29,46,60,61,16,62,50},55)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({15,59,42,54,46},55))
frame.Name = _d({22,42,50,55,15,59,42,54,46},55)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({30,18,12,56,59,55,46,59},55))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({29,46,65,61,21,42,43,46,53},55))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({185,104,100,106,184,129,88,233,12,62,57,50,45,233,14,55,48,50,55,46,233,24,63,46,59,64,56,59,53,45,233,29,46,60,61},55)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({29,46,65,61,21,42,43,46,53},55))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({28,61,42,61,62,60,3,233,18,45,53,46},55)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({30,18,12,56,59,55,46,59},55), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({29,46,65,61,11,56,65},55))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({30,18,12,56,59,55,46,59},55), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({17,56,63,46,59,233,10,43,56,63,46,233,29,42,59,48,46,61},55), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({49,56,63,46,59},55))
statusLabel.Text = _d({28,61,42,61,62,60,3,233,17,56,63,46,59,50,55,48,233},55) .. val .. _d({233,60,61,62,45,60,233,62,57},55)
end)
createInputBtn(_d({13,56,45,48,46,233,12,53,50,54,43},55), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({45,56,45,48,46},55))
statusLabel.Text = _d({28,61,42,61,62,60,3,233,13,56,45,48,46,246,49,56,53,45,50,55,48,233,241},55) .. val .. _d({233,60,61,62,45,60,242},55)
end)
createInputBtn(_d({29,46,60,61,233,28,58,62,42,59,46,233,13,56,45,48,46},55), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({60,58,62,42,59,46,40,45,56,45,48,46},55))
statusLabel.Text = _d({28,61,42,61,62,60,3,233,28,58,62,42,59,46,233,32,42,53,52,50,55,48,233,241},55) .. val .. _d({233,60,61,62,45,60,242},55)
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
while enabled and mode == _d({60,58,62,42,59,46,40,45,56,45,48,46},55) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({60,58,62,42,59,46,40,45,56,45,48,46},55) then
disableBot()
statusLabel.Text = _d({28,61,42,61,62,60,3,233,18,45,53,46,233,241,28,58,62,42,59,46,233,45,56,45,48,46,233,45,56,55,46,242},55)
end
end)
end)
local stopBtn = Instance.new(_d({29,46,65,61,11,62,61,61,56,55},55))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({14,22,14,27,16,14,23,12,34,233,28,29,24,25},55)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({30,18,12,56,59,55,46,59},55), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({28,61,42,61,62,60,3,233,28,29,24,25,25,14,13,233,241,18,45,53,46,242},55)
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({36,24,63,46,59,64,56,59,53,45,29,46,60,61,46,59,38,233,21,56,42,45,46,45,233,60,62,44,44,46,60,60,47,62,53,53,66,247},55))
end)()