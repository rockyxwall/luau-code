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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({55,50,58,51},50)
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
print(_d({41,29,68,51,64,69,61,64,58,50,34,51,65,66,51,64,43},50), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({32,61,57,67,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,51,62,62,61},50), args)
elseif style == _d({16,58,47,49,57,26,51,53},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57},50), args)
elseif style == _d({25,47,59,55,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,47,59,55,65,54,55,57,55,21,51,62,62,61},50), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57,0},50), args)
end
debug(_d({20,55,64,51,50,238,21,51,62,62,61,238,32,51,59,61,66,51},50))
end)
if not ok then debug(_d({55,60,68,61,57,51,21,51,62,62,61,238,51,64,64,61,64,8},50), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({45,45,34,51,65,66,22,61,68,51,64,15,66,66},50)) or Instance.new(_d({15,66,66,47,49,54,59,51,60,66},50))
att.Name = _d({45,45,34,51,65,66,22,61,68,51,64,15,66,66},50)
att.Parent = root
local force = root:FindFirstChild(_d({45,45,34,51,65,66,22,61,68,51,64,20,61,64,49,51},50))
if not force then
force = Instance.new(_d({26,55,60,51,47,64,36,51,58,61,49,55,66,71},50))
force.Name = _d({45,45,34,51,65,66,22,61,68,51,64,20,61,64,49,51},50)
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
local root = char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not root then return end
local force = root:FindFirstChild(_d({45,45,34,51,65,66,22,61,68,51,64,20,61,64,49,51},50))
local att   = root:FindFirstChild(_d({45,45,34,51,65,66,22,61,68,51,64,15,66,66},50))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({37,47,58,57,55,60,53,238,66,61,8},50), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({69,47,58,57,34,61,30,61,55,60,66,238,37,238,50,61,69,60,238,51,64,64,61,64,8},50), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({15,64,64,55,68,51,50,238,47,66,8},50), pos)
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
if item:IsA(_d({27,61,50,51,58},50)) and item:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50)) and item:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
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
mode = _d({55,50,58,51},50)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({34,51,65,66,51,64,238,18,55,65,47,48,58,51,50},50))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({34,51,65,66,51,64,238,19,60,47,48,58,51,50,252,238,27,61,50,51,8},50), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({30,58,47,71,51,64,238,50,55,51,50,239,238,18,55,65,47,48,58,55,60,53,238,48,61,66,252},50))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({54,61,68,51,64},50) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({50,61,50,53,51},50) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({65,63,67,47,64,51,45,50,61,50,53,51},50) then
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
local playerGui = LocalPlayer:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({29,68,51,64,69,61,64,58,50,34,51,65,66,21,67,55},50))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({33,49,64,51,51,60,21,67,55},50))
screenGui.Name = _d({29,68,51,64,69,61,64,58,50,34,51,65,66,21,67,55},50)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({20,64,47,59,51},50))
frame.Name = _d({27,47,55,60,20,64,47,59,51},50)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({35,23,17,61,64,60,51,64},50))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({34,51,70,66,26,47,48,51,58},50))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({190,109,105,111,189,134,93,238,17,67,62,55,50,238,19,60,53,55,60,51,238,29,68,51,64,69,61,64,58,50,238,34,51,65,66},50)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({34,51,70,66,26,47,48,51,58},50))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({33,66,47,66,67,65,8,238,23,50,58,51},50)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({34,51,70,66,16,67,66,66,61,60},50))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({35,23,17,61,64,60,51,64},50), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({34,51,70,66,16,61,70},50))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({35,23,17,61,64,60,51,64},50), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({22,61,68,51,64,238,15,48,61,68,51,238,34,47,64,53,51,66},50), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({54,61,68,51,64},50))
statusLabel.Text = _d({33,66,47,66,67,65,8,238,22,61,68,51,64,55,60,53,238},50) .. val .. _d({238,65,66,67,50,65,238,67,62},50)
end)
createInputBtn(_d({18,61,50,53,51,238,17,58,55,59,48},50), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({50,61,50,53,51},50))
statusLabel.Text = _d({33,66,47,66,67,65,8,238,18,61,50,53,51,251,54,61,58,50,55,60,53,238,246},50) .. val .. _d({238,65,66,67,50,65,247},50)
end)
createInputBtn(_d({34,51,65,66,238,33,63,67,47,64,51,238,18,61,50,53,51},50), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({65,63,67,47,64,51,45,50,61,50,53,51},50))
statusLabel.Text = _d({33,66,47,66,67,65,8,238,33,63,67,47,64,51,238,37,47,58,57,55,60,53,238,246},50) .. val .. _d({238,65,66,67,50,65,247},50)
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
while enabled and mode == _d({65,63,67,47,64,51,45,50,61,50,53,51},50) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({65,63,67,47,64,51,45,50,61,50,53,51},50) then
disableBot()
statusLabel.Text = _d({33,66,47,66,67,65,8,238,23,50,58,51,238,246,33,63,67,47,64,51,238,50,61,50,53,51,238,50,61,60,51,247},50)
end
end)
end)
local stopBtn = Instance.new(_d({34,51,70,66,16,67,66,66,61,60},50))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({19,27,19,32,21,19,28,17,39,238,33,34,29,30},50)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({35,23,17,61,64,60,51,64},50), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({33,66,47,66,67,65,8,238,33,34,29,30,30,19,18,238,246,23,50,58,51,247},50)
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({41,29,68,51,64,69,61,64,58,50,34,51,65,66,51,64,43,238,26,61,47,50,51,50,238,65,67,49,49,51,65,65,52,67,58,58,71,252},50))
end)()