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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local UserInputService = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({41,36,44,37},64)
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
print(_d({27,15,54,37,50,55,47,50,44,36,20,37,51,52,37,50,29},64), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({18,47,43,53,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({7,37,48,48,47},64), args)
elseif style == _d({2,44,33,35,43,12,37,39},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43},64), args)
elseif style == _d({11,33,45,41,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,33,45,41,51,40,41,43,41,7,37,48,48,47},64), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43,242},64), args)
end
debug(_d({6,41,50,37,36,224,7,37,48,48,47,224,18,37,45,47,52,37},64))
end)
if not ok then debug(_d({41,46,54,47,43,37,7,37,48,48,47,224,37,50,50,47,50,250},64), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({31,31,20,37,51,52,8,47,54,37,50,1,52,52},64)) or Instance.new(_d({1,52,52,33,35,40,45,37,46,52},64))
att.Name = _d({31,31,20,37,51,52,8,47,54,37,50,1,52,52},64)
att.Parent = root
local force = root:FindFirstChild(_d({31,31,20,37,51,52,8,47,54,37,50,6,47,50,35,37},64))
if not force then
force = Instance.new(_d({12,41,46,37,33,50,22,37,44,47,35,41,52,57},64))
force.Name = _d({31,31,20,37,51,52,8,47,54,37,50,6,47,50,35,37},64)
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
local root = char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not root then return end
local force = root:FindFirstChild(_d({31,31,20,37,51,52,8,47,54,37,50,6,47,50,35,37},64))
local att   = root:FindFirstChild(_d({31,31,20,37,51,52,8,47,54,37,50,1,52,52},64))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({23,33,44,43,41,46,39,224,52,47,250},64), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({55,33,44,43,20,47,16,47,41,46,52,224,23,224,36,47,55,46,224,37,50,50,47,50,250},64), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({1,50,50,41,54,37,36,224,33,52,250},64), pos)
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
if item:IsA(_d({13,47,36,37,44},64)) and item:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64)) and item:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)).Health > 0 then
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
mode = _d({41,36,44,37},64)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({20,37,51,52,37,50,224,4,41,51,33,34,44,37,36},64))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({20,37,51,52,37,50,224,5,46,33,34,44,37,36,238,224,13,47,36,37,250},64), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({16,44,33,57,37,50,224,36,41,37,36,225,224,4,41,51,33,34,44,41,46,39,224,34,47,52,238},64))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({40,47,54,37,50},64) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({36,47,36,39,37},64) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({51,49,53,33,50,37,31,36,47,36,39,37},64) then
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
local playerGui = LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({15,54,37,50,55,47,50,44,36,20,37,51,52,7,53,41},64))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({19,35,50,37,37,46,7,53,41},64))
screenGui.Name = _d({15,54,37,50,55,47,50,44,36,20,37,51,52,7,53,41},64)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({6,50,33,45,37},64))
frame.Name = _d({13,33,41,46,6,50,33,45,37},64)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({21,9,3,47,50,46,37,50},64))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({20,37,56,52,12,33,34,37,44},64))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({176,95,91,97,175,120,79,224,3,53,48,41,36,224,5,46,39,41,46,37,224,15,54,37,50,55,47,50,44,36,224,20,37,51,52},64)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({20,37,56,52,12,33,34,37,44},64))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({19,52,33,52,53,51,250,224,9,36,44,37},64)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({20,37,56,52,2,53,52,52,47,46},64))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({21,9,3,47,50,46,37,50},64), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({20,37,56,52,2,47,56},64))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({21,9,3,47,50,46,37,50},64), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({8,47,54,37,50,224,1,34,47,54,37,224,20,33,50,39,37,52},64), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({40,47,54,37,50},64))
statusLabel.Text = _d({19,52,33,52,53,51,250,224,8,47,54,37,50,41,46,39,224},64) .. val .. _d({224,51,52,53,36,51,224,53,48},64)
end)
createInputBtn(_d({4,47,36,39,37,224,3,44,41,45,34},64), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({36,47,36,39,37},64))
statusLabel.Text = _d({19,52,33,52,53,51,250,224,4,47,36,39,37,237,40,47,44,36,41,46,39,224,232},64) .. val .. _d({224,51,52,53,36,51,233},64)
end)
createInputBtn(_d({20,37,51,52,224,19,49,53,33,50,37,224,4,47,36,39,37},64), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({51,49,53,33,50,37,31,36,47,36,39,37},64))
statusLabel.Text = _d({19,52,33,52,53,51,250,224,19,49,53,33,50,37,224,23,33,44,43,41,46,39,224,232},64) .. val .. _d({224,51,52,53,36,51,233},64)
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
while enabled and mode == _d({51,49,53,33,50,37,31,36,47,36,39,37},64) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({51,49,53,33,50,37,31,36,47,36,39,37},64) then
disableBot()
statusLabel.Text = _d({19,52,33,52,53,51,250,224,9,36,44,37,224,232,19,49,53,33,50,37,224,36,47,36,39,37,224,36,47,46,37,233},64)
end
end)
end)
local stopBtn = Instance.new(_d({20,37,56,52,2,53,52,52,47,46},64))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({5,13,5,18,7,5,14,3,25,224,19,20,15,16},64)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({21,9,3,47,50,46,37,50},64), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({19,52,33,52,53,51,250,224,19,20,15,16,16,5,4,224,232,9,36,44,37,233},64)
local VIM = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({27,15,54,37,50,55,47,50,44,36,20,37,51,52,37,50,29,224,12,47,33,36,37,36,224,51,53,35,35,37,51,51,38,53,44,44,57,238},64))
end)()