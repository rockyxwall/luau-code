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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({43,38,46,39},62)
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
print(_d({29,17,56,39,52,57,49,52,46,38,22,39,53,54,39,52,31},62), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({20,49,45,55,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({9,39,50,50,49},62), args)
elseif style == _d({4,46,35,37,45,14,39,41},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45},62), args)
elseif style == _d({13,35,47,43,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,35,47,43,53,42,43,45,43,9,39,50,50,49},62), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45,244},62), args)
end
debug(_d({8,43,52,39,38,226,9,39,50,50,49,226,20,39,47,49,54,39},62))
end)
if not ok then debug(_d({43,48,56,49,45,39,9,39,50,50,49,226,39,52,52,49,52,252},62), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({33,33,22,39,53,54,10,49,56,39,52,3,54,54},62)) or Instance.new(_d({3,54,54,35,37,42,47,39,48,54},62))
att.Name = _d({33,33,22,39,53,54,10,49,56,39,52,3,54,54},62)
att.Parent = root
local force = root:FindFirstChild(_d({33,33,22,39,53,54,10,49,56,39,52,8,49,52,37,39},62))
if not force then
force = Instance.new(_d({14,43,48,39,35,52,24,39,46,49,37,43,54,59},62))
force.Name = _d({33,33,22,39,53,54,10,49,56,39,52,8,49,52,37,39},62)
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
local root = char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if not root then return end
local force = root:FindFirstChild(_d({33,33,22,39,53,54,10,49,56,39,52,8,49,52,37,39},62))
local att   = root:FindFirstChild(_d({33,33,22,39,53,54,10,49,56,39,52,3,54,54},62))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({25,35,46,45,43,48,41,226,54,49,252},62), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({57,35,46,45,22,49,18,49,43,48,54,226,25,226,38,49,57,48,226,39,52,52,49,52,252},62), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({3,52,52,43,56,39,38,226,35,54,252},62), pos)
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
if item:IsA(_d({15,49,38,39,46},62)) and item:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62)) and item:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
mode = _d({43,38,46,39},62)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({22,39,53,54,39,52,226,6,43,53,35,36,46,39,38},62))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({22,39,53,54,39,52,226,7,48,35,36,46,39,38,240,226,15,49,38,39,252},62), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({18,46,35,59,39,52,226,38,43,39,38,227,226,6,43,53,35,36,46,43,48,41,226,36,49,54,240},62))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({42,49,56,39,52},62) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({38,49,38,41,39},62) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({53,51,55,35,52,39,33,38,49,38,41,39},62) then
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
local playerGui = LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({17,56,39,52,57,49,52,46,38,22,39,53,54,9,55,43},62))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({21,37,52,39,39,48,9,55,43},62))
screenGui.Name = _d({17,56,39,52,57,49,52,46,38,22,39,53,54,9,55,43},62)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({8,52,35,47,39},62))
frame.Name = _d({15,35,43,48,8,52,35,47,39},62)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({23,11,5,49,52,48,39,52},62))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({22,39,58,54,14,35,36,39,46},62))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({178,97,93,99,177,122,81,226,5,55,50,43,38,226,7,48,41,43,48,39,226,17,56,39,52,57,49,52,46,38,226,22,39,53,54},62)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({22,39,58,54,14,35,36,39,46},62))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({21,54,35,54,55,53,252,226,11,38,46,39},62)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({22,39,58,54,4,55,54,54,49,48},62))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({23,11,5,49,52,48,39,52},62), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({22,39,58,54,4,49,58},62))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({23,11,5,49,52,48,39,52},62), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({10,49,56,39,52,226,3,36,49,56,39,226,22,35,52,41,39,54},62), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({42,49,56,39,52},62))
statusLabel.Text = _d({21,54,35,54,55,53,252,226,10,49,56,39,52,43,48,41,226},62) .. val .. _d({226,53,54,55,38,53,226,55,50},62)
end)
createInputBtn(_d({6,49,38,41,39,226,5,46,43,47,36},62), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({38,49,38,41,39},62))
statusLabel.Text = _d({21,54,35,54,55,53,252,226,6,49,38,41,39,239,42,49,46,38,43,48,41,226,234},62) .. val .. _d({226,53,54,55,38,53,235},62)
end)
createInputBtn(_d({22,39,53,54,226,21,51,55,35,52,39,226,6,49,38,41,39},62), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({53,51,55,35,52,39,33,38,49,38,41,39},62))
statusLabel.Text = _d({21,54,35,54,55,53,252,226,21,51,55,35,52,39,226,25,35,46,45,43,48,41,226,234},62) .. val .. _d({226,53,54,55,38,53,235},62)
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
while enabled and mode == _d({53,51,55,35,52,39,33,38,49,38,41,39},62) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({53,51,55,35,52,39,33,38,49,38,41,39},62) then
disableBot()
statusLabel.Text = _d({21,54,35,54,55,53,252,226,11,38,46,39,226,234,21,51,55,35,52,39,226,38,49,38,41,39,226,38,49,48,39,235},62)
end
end)
end)
local stopBtn = Instance.new(_d({22,39,58,54,4,55,54,54,49,48},62))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({7,15,7,20,9,7,16,5,27,226,21,22,17,18},62)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({23,11,5,49,52,48,39,52},62), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({21,54,35,54,55,53,252,226,21,22,17,18,18,7,6,226,234,11,38,46,39,235},62)
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({29,17,56,39,52,57,49,52,46,38,22,39,53,54,39,52,31,226,14,49,35,38,39,38,226,53,55,37,37,39,53,53,40,55,46,46,59,240},62))
end)()