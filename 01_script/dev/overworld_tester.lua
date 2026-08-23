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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({60,55,63,56},45)
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
print(_d({46,34,73,56,69,74,66,69,63,55,39,56,70,71,56,69,48},45), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({37,66,62,72,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,56,67,67,66},45), args)
elseif style == _d({21,63,52,54,62,31,56,58},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62},45), args)
elseif style == _d({30,52,64,60,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,52,64,60,70,59,60,62,60,26,56,67,67,66},45), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62,5},45), args)
end
debug(_d({25,60,69,56,55,243,26,56,67,67,66,243,37,56,64,66,71,56},45))
end)
if not ok then debug(_d({60,65,73,66,62,56,26,56,67,67,66,243,56,69,69,66,69,13},45), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({50,50,39,56,70,71,27,66,73,56,69,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,39,56,70,71,27,66,73,56,69,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,39,56,70,71,27,66,73,56,69,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,39,56,70,71,27,66,73,56,69,25,66,69,54,56},45)
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
local root = char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not root then return end
local force = root:FindFirstChild(_d({50,50,39,56,70,71,27,66,73,56,69,25,66,69,54,56},45))
local att   = root:FindFirstChild(_d({50,50,39,56,70,71,27,66,73,56,69,20,71,71},45))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({42,52,63,62,60,65,58,243,71,66,13},45), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({74,52,63,62,39,66,35,66,60,65,71,243,42,243,55,66,74,65,243,56,69,69,66,69,13},45), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({20,69,69,60,73,56,55,243,52,71,13},45), pos)
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
if item:IsA(_d({32,66,55,56,63},45)) and item:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45)) and item:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)).Health > 0 then
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
mode = _d({60,55,63,56},45)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({39,56,70,71,56,69,243,23,60,70,52,53,63,56,55},45))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({39,56,70,71,56,69,243,24,65,52,53,63,56,55,1,243,32,66,55,56,13},45), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({35,63,52,76,56,69,243,55,60,56,55,244,243,23,60,70,52,53,63,60,65,58,243,53,66,71,1},45))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({59,66,73,56,69},45) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({55,66,55,58,56},45) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({70,68,72,52,69,56,50,55,66,55,58,56},45) then
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
local playerGui = LocalPlayer:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({34,73,56,69,74,66,69,63,55,39,56,70,71,26,72,60},45))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({38,54,69,56,56,65,26,72,60},45))
screenGui.Name = _d({34,73,56,69,74,66,69,63,55,39,56,70,71,26,72,60},45)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({25,69,52,64,56},45))
frame.Name = _d({32,52,60,65,25,69,52,64,56},45)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({40,28,22,66,69,65,56,69},45))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({39,56,75,71,31,52,53,56,63},45))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({195,114,110,116,194,139,98,243,22,72,67,60,55,243,24,65,58,60,65,56,243,34,73,56,69,74,66,69,63,55,243,39,56,70,71},45)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({39,56,75,71,31,52,53,56,63},45))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({38,71,52,71,72,70,13,243,28,55,63,56},45)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({39,56,75,71,21,72,71,71,66,65},45))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({40,28,22,66,69,65,56,69},45), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({39,56,75,71,21,66,75},45))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({40,28,22,66,69,65,56,69},45), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({27,66,73,56,69,243,20,53,66,73,56,243,39,52,69,58,56,71},45), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({59,66,73,56,69},45))
statusLabel.Text = _d({38,71,52,71,72,70,13,243,27,66,73,56,69,60,65,58,243},45) .. val .. _d({243,70,71,72,55,70,243,72,67},45)
end)
createInputBtn(_d({23,66,55,58,56,243,22,63,60,64,53},45), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({55,66,55,58,56},45))
statusLabel.Text = _d({38,71,52,71,72,70,13,243,23,66,55,58,56,0,59,66,63,55,60,65,58,243,251},45) .. val .. _d({243,70,71,72,55,70,252},45)
end)
createInputBtn(_d({39,56,70,71,243,38,68,72,52,69,56,243,23,66,55,58,56},45), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({70,68,72,52,69,56,50,55,66,55,58,56},45))
statusLabel.Text = _d({38,71,52,71,72,70,13,243,38,68,72,52,69,56,243,42,52,63,62,60,65,58,243,251},45) .. val .. _d({243,70,71,72,55,70,252},45)
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
while enabled and mode == _d({70,68,72,52,69,56,50,55,66,55,58,56},45) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({70,68,72,52,69,56,50,55,66,55,58,56},45) then
disableBot()
statusLabel.Text = _d({38,71,52,71,72,70,13,243,28,55,63,56,243,251,38,68,72,52,69,56,243,55,66,55,58,56,243,55,66,65,56,252},45)
end
end)
end)
local stopBtn = Instance.new(_d({39,56,75,71,21,72,71,71,66,65},45))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({24,32,24,37,26,24,33,22,44,243,38,39,34,35},45)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({40,28,22,66,69,65,56,69},45), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({38,71,52,71,72,70,13,243,38,39,34,35,35,24,23,243,251,28,55,63,56,252},45)
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({46,34,73,56,69,74,66,69,63,55,39,56,70,71,56,69,48,243,31,66,52,55,56,55,243,70,72,54,54,56,70,70,57,72,63,63,76,1},45))
end)()