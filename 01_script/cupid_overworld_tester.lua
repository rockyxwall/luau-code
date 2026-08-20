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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({90,85,93,86},15)
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
print(_d({76,64,103,86,99,104,96,99,93,85,69,86,100,101,86,99,78},15), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({67,96,92,102,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,86,97,97,96},15), args)
elseif style == _d({51,93,82,84,92,61,86,88},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92},15), args)
elseif style == _d({60,82,94,90,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,82,94,90,100,89,90,92,90,56,86,97,97,96},15), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92,35},15), args)
end
debug(_d({55,90,99,86,85,17,56,86,97,97,96,17,67,86,94,96,101,86},15))
end)
if not ok then debug(_d({90,95,103,96,92,86,56,86,97,97,96,17,86,99,99,96,99,43},15), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15)
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
local root = char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not root then return end
local force = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15))
local att   = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({72,82,93,92,90,95,88,17,101,96,43},15), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({104,82,93,92,69,96,65,96,90,95,101,17,72,17,85,96,104,95,17,86,99,99,96,99,43},15), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({50,99,99,90,103,86,85,17,82,101,43},15), pos)
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
if item:IsA(_d({62,96,85,86,93},15)) and item:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15)) and item:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health > 0 then
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
mode = _d({90,85,93,86},15)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({69,86,100,101,86,99,17,53,90,100,82,83,93,86,85},15))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({69,86,100,101,86,99,17,54,95,82,83,93,86,85,31,17,62,96,85,86,43},15), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({65,93,82,106,86,99,17,85,90,86,85,18,17,53,90,100,82,83,93,90,95,88,17,83,96,101,31},15))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({89,96,103,86,99},15) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({85,96,85,88,86},15) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({100,98,102,82,99,86,80,85,96,85,88,86},15) then
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
local playerGui = LocalPlayer:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({64,103,86,99,104,96,99,93,85,69,86,100,101,56,102,90},15))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({68,84,99,86,86,95,56,102,90},15))
screenGui.Name = _d({64,103,86,99,104,96,99,93,85,69,86,100,101,56,102,90},15)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({55,99,82,94,86},15))
frame.Name = _d({62,82,90,95,55,99,82,94,86},15)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({70,58,52,96,99,95,86,99},15))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({69,86,105,101,61,82,83,86,93},15))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({225,144,140,146,224,169,128,17,52,102,97,90,85,17,54,95,88,90,95,86,17,64,103,86,99,104,96,99,93,85,17,69,86,100,101},15)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({69,86,105,101,61,82,83,86,93},15))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({68,101,82,101,102,100,43,17,58,85,93,86},15)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({69,86,105,101,51,102,101,101,96,95},15))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({70,58,52,96,99,95,86,99},15), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({69,86,105,101,51,96,105},15))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({70,58,52,96,99,95,86,99},15), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({57,96,103,86,99,17,50,83,96,103,86,17,69,82,99,88,86,101},15), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({89,96,103,86,99},15))
statusLabel.Text = _d({68,101,82,101,102,100,43,17,57,96,103,86,99,90,95,88,17},15) .. val .. _d({17,100,101,102,85,100,17,102,97},15)
end)
createInputBtn(_d({53,96,85,88,86,17,52,93,90,94,83},15), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({85,96,85,88,86},15))
statusLabel.Text = _d({68,101,82,101,102,100,43,17,53,96,85,88,86,30,89,96,93,85,90,95,88,17,25},15) .. val .. _d({17,100,101,102,85,100,26},15)
end)
createInputBtn(_d({69,86,100,101,17,68,98,102,82,99,86,17,53,96,85,88,86},15), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({100,98,102,82,99,86,80,85,96,85,88,86},15))
statusLabel.Text = _d({68,101,82,101,102,100,43,17,68,98,102,82,99,86,17,72,82,93,92,90,95,88,17,25},15) .. val .. _d({17,100,101,102,85,100,26},15)
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
while enabled and mode == _d({100,98,102,82,99,86,80,85,96,85,88,86},15) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({100,98,102,82,99,86,80,85,96,85,88,86},15) then
disableBot()
statusLabel.Text = _d({68,101,82,101,102,100,43,17,58,85,93,86,17,25,68,98,102,82,99,86,17,85,96,85,88,86,17,85,96,95,86,26},15)
end
end)
end)
local stopBtn = Instance.new(_d({69,86,105,101,51,102,101,101,96,95},15))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({54,62,54,67,56,54,63,52,74,17,68,69,64,65},15)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({70,58,52,96,99,95,86,99},15), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({68,101,82,101,102,100,43,17,68,69,64,65,65,54,53,17,25,58,85,93,86,26},15)
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({76,64,103,86,99,104,96,99,93,85,69,86,100,101,86,99,78,17,61,96,82,85,86,85,17,100,102,84,84,86,100,100,87,102,93,93,106,31},15))
end)()