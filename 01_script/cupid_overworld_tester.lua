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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({42,37,45,38},63)
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
print(_d({28,16,55,38,51,56,48,51,45,37,21,38,52,53,38,51,30},63), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({19,48,44,54,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({8,38,49,49,48},63), args)
elseif style == _d({3,45,34,36,44,13,38,40},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44},63), args)
elseif style == _d({12,34,46,42,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,34,46,42,52,41,42,44,42,8,38,49,49,48},63), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44,243},63), args)
end
debug(_d({7,42,51,38,37,225,8,38,49,49,48,225,19,38,46,48,53,38},63))
end)
if not ok then debug(_d({42,47,55,48,44,38,8,38,49,49,48,225,38,51,51,48,51,251},63), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({32,32,21,38,52,53,9,48,55,38,51,2,53,53},63)) or Instance.new(_d({2,53,53,34,36,41,46,38,47,53},63))
att.Name = _d({32,32,21,38,52,53,9,48,55,38,51,2,53,53},63)
att.Parent = root
local force = root:FindFirstChild(_d({32,32,21,38,52,53,9,48,55,38,51,7,48,51,36,38},63))
if not force then
force = Instance.new(_d({13,42,47,38,34,51,23,38,45,48,36,42,53,58},63))
force.Name = _d({32,32,21,38,52,53,9,48,55,38,51,7,48,51,36,38},63)
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
local root = char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not root then return end
local force = root:FindFirstChild(_d({32,32,21,38,52,53,9,48,55,38,51,7,48,51,36,38},63))
local att   = root:FindFirstChild(_d({32,32,21,38,52,53,9,48,55,38,51,2,53,53},63))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({24,34,45,44,42,47,40,225,53,48,251},63), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({56,34,45,44,21,48,17,48,42,47,53,225,24,225,37,48,56,47,225,38,51,51,48,51,251},63), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({2,51,51,42,55,38,37,225,34,53,251},63), pos)
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
if item:IsA(_d({14,48,37,38,45},63)) and item:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63)) and item:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)).Health > 0 then
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
mode = _d({42,37,45,38},63)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({21,38,52,53,38,51,225,5,42,52,34,35,45,38,37},63))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({21,38,52,53,38,51,225,6,47,34,35,45,38,37,239,225,14,48,37,38,251},63), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({17,45,34,58,38,51,225,37,42,38,37,226,225,5,42,52,34,35,45,42,47,40,225,35,48,53,239},63))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({41,48,55,38,51},63) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({37,48,37,40,38},63) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({52,50,54,34,51,38,32,37,48,37,40,38},63) then
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
local playerGui = LocalPlayer:WaitForChild(_d({17,45,34,58,38,51,8,54,42},63), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({16,55,38,51,56,48,51,45,37,21,38,52,53,8,54,42},63))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({20,36,51,38,38,47,8,54,42},63))
screenGui.Name = _d({16,55,38,51,56,48,51,45,37,21,38,52,53,8,54,42},63)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({7,51,34,46,38},63))
frame.Name = _d({14,34,42,47,7,51,34,46,38},63)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({22,10,4,48,51,47,38,51},63))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({21,38,57,53,13,34,35,38,45},63))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({177,96,92,98,176,121,80,225,4,54,49,42,37,225,6,47,40,42,47,38,225,16,55,38,51,56,48,51,45,37,225,21,38,52,53},63)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({21,38,57,53,13,34,35,38,45},63))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({20,53,34,53,54,52,251,225,10,37,45,38},63)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({22,10,4,48,51,47,38,51},63), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({21,38,57,53,3,48,57},63))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({22,10,4,48,51,47,38,51},63), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({9,48,55,38,51,225,2,35,48,55,38,225,21,34,51,40,38,53},63), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({41,48,55,38,51},63))
statusLabel.Text = _d({20,53,34,53,54,52,251,225,9,48,55,38,51,42,47,40,225},63) .. val .. _d({225,52,53,54,37,52,225,54,49},63)
end)
createInputBtn(_d({5,48,37,40,38,225,4,45,42,46,35},63), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({37,48,37,40,38},63))
statusLabel.Text = _d({20,53,34,53,54,52,251,225,5,48,37,40,38,238,41,48,45,37,42,47,40,225,233},63) .. val .. _d({225,52,53,54,37,52,234},63)
end)
createInputBtn(_d({21,38,52,53,225,20,50,54,34,51,38,225,5,48,37,40,38},63), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({52,50,54,34,51,38,32,37,48,37,40,38},63))
statusLabel.Text = _d({20,53,34,53,54,52,251,225,20,50,54,34,51,38,225,24,34,45,44,42,47,40,225,233},63) .. val .. _d({225,52,53,54,37,52,234},63)
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
while enabled and mode == _d({52,50,54,34,51,38,32,37,48,37,40,38},63) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({52,50,54,34,51,38,32,37,48,37,40,38},63) then
disableBot()
statusLabel.Text = _d({20,53,34,53,54,52,251,225,10,37,45,38,225,233,20,50,54,34,51,38,225,37,48,37,40,38,225,37,48,47,38,234},63)
end
end)
end)
local stopBtn = Instance.new(_d({21,38,57,53,3,54,53,53,48,47},63))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({6,14,6,19,8,6,15,4,26,225,20,21,16,17},63)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({22,10,4,48,51,47,38,51},63), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({20,53,34,53,54,52,251,225,20,21,16,17,17,6,5,225,233,10,37,45,38,234},63)
local VIM = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({28,16,55,38,51,56,48,51,45,37,21,38,52,53,38,51,30,225,13,48,34,37,38,37,225,52,54,36,36,38,52,52,39,54,45,45,58,239},63))
end)()