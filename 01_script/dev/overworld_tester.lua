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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({47,42,50,43},58)
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
print(_d({33,21,60,43,56,61,53,56,50,42,26,43,57,58,43,56,35},58), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({24,53,49,59,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,43,54,54,53},58), args)
elseif style == _d({8,50,39,41,49,18,43,45},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49},58), args)
elseif style == _d({17,39,51,47,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,39,51,47,57,46,47,49,47,13,43,54,54,53},58), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49,248},58), args)
end
debug(_d({12,47,56,43,42,230,13,43,54,54,53,230,24,43,51,53,58,43},58))
end)
if not ok then debug(_d({47,52,60,53,49,43,13,43,54,54,53,230,43,56,56,53,56,0},58), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58)
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
local root = char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local force = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58))
local att   = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({29,39,50,49,47,52,45,230,58,53,0},58), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({61,39,50,49,26,53,22,53,47,52,58,230,29,230,42,53,61,52,230,43,56,56,53,56,0},58), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({7,56,56,47,60,43,42,230,39,58,0},58), pos)
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
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({19,53,42,43,50},58)) and item:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58)) and item:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 then
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
mode = _d({47,42,50,43},58)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({26,43,57,58,43,56,230,10,47,57,39,40,50,43,42},58))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({26,43,57,58,43,56,230,11,52,39,40,50,43,42,244,230,19,53,42,43,0},58), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({22,50,39,63,43,56,230,42,47,43,42,231,230,10,47,57,39,40,50,47,52,45,230,40,53,58,244},58))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({46,53,60,43,56},58) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({42,53,42,45,43},58) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) then
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
local playerGui = LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({21,60,43,56,61,53,56,50,42,26,43,57,58,13,59,47},58))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({25,41,56,43,43,52,13,59,47},58))
screenGui.Name = _d({21,60,43,56,61,53,56,50,42,26,43,57,58,13,59,47},58)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({12,56,39,51,43},58))
frame.Name = _d({19,39,47,52,12,56,39,51,43},58)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({27,15,9,53,56,52,43,56},58))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({182,101,97,103,181,126,85,230,9,59,54,47,42,230,11,52,45,47,52,43,230,21,60,43,56,61,53,56,50,42,230,26,43,57,58},58)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({25,58,39,58,59,57,0,230,15,42,50,43},58)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({26,43,62,58,8,53,62},58))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({14,53,60,43,56,230,7,40,53,60,43,230,26,39,56,45,43,58},58), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({46,53,60,43,56},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,14,53,60,43,56,47,52,45,230},58) .. val .. _d({230,57,58,59,42,57,230,59,54},58)
end)
createInputBtn(_d({10,53,42,45,43,230,9,50,47,51,40},58), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({42,53,42,45,43},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,10,53,42,45,43,243,46,53,50,42,47,52,45,230,238},58) .. val .. _d({230,57,58,59,42,57,239},58)
end)
createInputBtn(_d({26,43,57,58,230,25,55,59,39,56,43,230,10,53,42,45,43},58), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({57,55,59,39,56,43,37,42,53,42,45,43},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,25,55,59,39,56,43,230,29,39,50,49,47,52,45,230,238},58) .. val .. _d({230,57,58,59,42,57,239},58)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
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
while enabled and mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) then
disableBot()
statusLabel.Text = _d({25,58,39,58,59,57,0,230,15,42,50,43,230,238,25,55,59,39,56,43,230,42,53,42,45,43,230,42,53,52,43,239},58)
end
end)
end)
local stopBtn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({11,19,11,24,13,11,20,9,31,230,25,26,21,22},58)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({25,58,39,58,59,57,0,230,25,26,21,22,22,11,10,230,238,15,42,50,43,239},58)
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({33,21,60,43,56,61,53,56,50,42,26,43,57,58,43,56,35,230,18,53,39,42,43,42,230,57,59,41,41,43,57,57,44,59,50,50,63,244},58))
end)()