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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({54,49,57,50},51)
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
print(_d({40,28,67,50,63,68,60,63,57,49,33,50,64,65,50,63,42},51), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({31,60,56,66,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,50,61,61,60},51), args)
elseif style == _d({15,57,46,48,56,25,50,52},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56},51), args)
elseif style == _d({24,46,58,54,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,46,58,54,64,53,54,56,54,20,50,61,61,60},51), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56,255},51), args)
end
debug(_d({19,54,63,50,49,237,20,50,61,61,60,237,31,50,58,60,65,50},51))
end)
if not ok then debug(_d({54,59,67,60,56,50,20,50,61,61,60,237,50,63,63,60,63,7},51), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51)) or Instance.new(_d({14,65,65,46,48,53,58,50,59,65},51))
att.Name = _d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51)
att.Parent = root
local force = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51))
if not force then
force = Instance.new(_d({25,54,59,50,46,63,35,50,57,60,48,54,65,70},51))
force.Name = _d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51)
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
local root = char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local force = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51))
local att   = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({36,46,57,56,54,59,52,237,65,60,7},51), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({68,46,57,56,33,60,29,60,54,59,65,237,36,237,49,60,68,59,237,50,63,63,60,63,7},51), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({14,63,63,54,67,50,49,237,46,65,7},51), pos)
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
if item:IsA(_d({26,60,49,50,57},51)) and item:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51)) and item:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)).Health > 0 then
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
mode = _d({54,49,57,50},51)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({33,50,64,65,50,63,237,17,54,64,46,47,57,50,49},51))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({33,50,64,65,50,63,237,18,59,46,47,57,50,49,251,237,26,60,49,50,7},51), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({29,57,46,70,50,63,237,49,54,50,49,238,237,17,54,64,46,47,57,54,59,52,237,47,60,65,251},51))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({53,60,67,50,63},51) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({49,60,49,52,50},51) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({64,62,66,46,63,50,44,49,60,49,52,50},51) then
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
local playerGui = LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({28,67,50,63,68,60,63,57,49,33,50,64,65,20,66,54},51))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({32,48,63,50,50,59,20,66,54},51))
screenGui.Name = _d({28,67,50,63,68,60,63,57,49,33,50,64,65,20,66,54},51)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({19,63,46,58,50},51))
frame.Name = _d({26,46,54,59,19,63,46,58,50},51)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({189,108,104,110,188,133,92,237,16,66,61,54,49,237,18,59,52,54,59,50,237,28,67,50,63,68,60,63,57,49,237,33,50,64,65},51)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({32,65,46,65,66,64,7,237,22,49,57,50},51)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({33,50,69,65,15,66,65,65,60,59},51))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({34,22,16,60,63,59,50,63},51), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({33,50,69,65,15,60,69},51))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({34,22,16,60,63,59,50,63},51), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({21,60,67,50,63,237,14,47,60,67,50,237,33,46,63,52,50,65},51), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({53,60,67,50,63},51))
statusLabel.Text = _d({32,65,46,65,66,64,7,237,21,60,67,50,63,54,59,52,237},51) .. val .. _d({237,64,65,66,49,64,237,66,61},51)
end)
createInputBtn(_d({17,60,49,52,50,237,16,57,54,58,47},51), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({49,60,49,52,50},51))
statusLabel.Text = _d({32,65,46,65,66,64,7,237,17,60,49,52,50,250,53,60,57,49,54,59,52,237,245},51) .. val .. _d({237,64,65,66,49,64,246},51)
end)
createInputBtn(_d({33,50,64,65,237,32,62,66,46,63,50,237,17,60,49,52,50},51), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({64,62,66,46,63,50,44,49,60,49,52,50},51))
statusLabel.Text = _d({32,65,46,65,66,64,7,237,32,62,66,46,63,50,237,36,46,57,56,54,59,52,237,245},51) .. val .. _d({237,64,65,66,49,64,246},51)
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
while enabled and mode == _d({64,62,66,46,63,50,44,49,60,49,52,50},51) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({64,62,66,46,63,50,44,49,60,49,52,50},51) then
disableBot()
statusLabel.Text = _d({32,65,46,65,66,64,7,237,22,49,57,50,237,245,32,62,66,46,63,50,237,49,60,49,52,50,237,49,60,59,50,246},51)
end
end)
end)
local stopBtn = Instance.new(_d({33,50,69,65,15,66,65,65,60,59},51))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({18,26,18,31,20,18,27,16,38,237,32,33,28,29},51)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({34,22,16,60,63,59,50,63},51), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({32,65,46,65,66,64,7,237,32,33,28,29,29,18,17,237,245,22,49,57,50,246},51)
local VIM = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({40,28,67,50,63,68,60,63,57,49,33,50,64,65,50,63,42,237,25,60,46,49,50,49,237,64,66,48,48,50,64,64,51,66,57,57,70,251},51))
end)()