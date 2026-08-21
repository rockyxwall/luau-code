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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({83,78,86,79},22)
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
print(_d({69,57,96,79,92,97,89,92,86,78,62,79,93,94,79,92,71},22), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({60,89,85,95,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,79,90,90,89},22), args)
elseif style == _d({44,86,75,77,85,54,79,81},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85},22), args)
elseif style == _d({53,75,87,83,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,75,87,83,93,82,83,85,83,49,79,90,90,89},22), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85,28},22), args)
end
debug(_d({48,83,92,79,78,10,49,79,90,90,89,10,60,79,87,89,94,79},22))
end)
if not ok then debug(_d({83,88,96,89,85,79,49,79,90,90,89,10,79,92,92,89,92,36},22), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({73,73,62,79,93,94,50,89,96,79,92,43,94,94},22)) or Instance.new(_d({43,94,94,75,77,82,87,79,88,94},22))
att.Name = _d({73,73,62,79,93,94,50,89,96,79,92,43,94,94},22)
att.Parent = root
local force = root:FindFirstChild(_d({73,73,62,79,93,94,50,89,96,79,92,48,89,92,77,79},22))
if not force then
force = Instance.new(_d({54,83,88,79,75,92,64,79,86,89,77,83,94,99},22))
force.Name = _d({73,73,62,79,93,94,50,89,96,79,92,48,89,92,77,79},22)
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
local root = char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if not root then return end
local force = root:FindFirstChild(_d({73,73,62,79,93,94,50,89,96,79,92,48,89,92,77,79},22))
local att   = root:FindFirstChild(_d({73,73,62,79,93,94,50,89,96,79,92,43,94,94},22))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({65,75,86,85,83,88,81,10,94,89,36},22), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({97,75,86,85,62,89,58,89,83,88,94,10,65,10,78,89,97,88,10,79,92,92,89,92,36},22), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({43,92,92,83,96,79,78,10,75,94,36},22), pos)
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
if item:IsA(_d({55,89,78,79,86},22)) and item:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22)) and item:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)).Health > 0 then
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
mode = _d({83,78,86,79},22)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({62,79,93,94,79,92,10,46,83,93,75,76,86,79,78},22))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({62,79,93,94,79,92,10,47,88,75,76,86,79,78,24,10,55,89,78,79,36},22), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({58,86,75,99,79,92,10,78,83,79,78,11,10,46,83,93,75,76,86,83,88,81,10,76,89,94,24},22))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({82,89,96,79,92},22) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({78,89,78,81,79},22) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({93,91,95,75,92,79,73,78,89,78,81,79},22) then
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
local playerGui = LocalPlayer:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({57,96,79,92,97,89,92,86,78,62,79,93,94,49,95,83},22))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({61,77,92,79,79,88,49,95,83},22))
screenGui.Name = _d({57,96,79,92,97,89,92,86,78,62,79,93,94,49,95,83},22)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({48,92,75,87,79},22))
frame.Name = _d({55,75,83,88,48,92,75,87,79},22)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({63,51,45,89,92,88,79,92},22))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({62,79,98,94,54,75,76,79,86},22))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({218,137,133,139,217,162,121,10,45,95,90,83,78,10,47,88,81,83,88,79,10,57,96,79,92,97,89,92,86,78,10,62,79,93,94},22)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({62,79,98,94,54,75,76,79,86},22))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({61,94,75,94,95,93,36,10,51,78,86,79},22)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({62,79,98,94,44,95,94,94,89,88},22))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({63,51,45,89,92,88,79,92},22), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({62,79,98,94,44,89,98},22))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({63,51,45,89,92,88,79,92},22), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({50,89,96,79,92,10,43,76,89,96,79,10,62,75,92,81,79,94},22), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({82,89,96,79,92},22))
statusLabel.Text = _d({61,94,75,94,95,93,36,10,50,89,96,79,92,83,88,81,10},22) .. val .. _d({10,93,94,95,78,93,10,95,90},22)
end)
createInputBtn(_d({46,89,78,81,79,10,45,86,83,87,76},22), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({78,89,78,81,79},22))
statusLabel.Text = _d({61,94,75,94,95,93,36,10,46,89,78,81,79,23,82,89,86,78,83,88,81,10,18},22) .. val .. _d({10,93,94,95,78,93,19},22)
end)
createInputBtn(_d({62,79,93,94,10,61,91,95,75,92,79,10,46,89,78,81,79},22), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({93,91,95,75,92,79,73,78,89,78,81,79},22))
statusLabel.Text = _d({61,94,75,94,95,93,36,10,61,91,95,75,92,79,10,65,75,86,85,83,88,81,10,18},22) .. val .. _d({10,93,94,95,78,93,19},22)
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
while enabled and mode == _d({93,91,95,75,92,79,73,78,89,78,81,79},22) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({93,91,95,75,92,79,73,78,89,78,81,79},22) then
disableBot()
statusLabel.Text = _d({61,94,75,94,95,93,36,10,51,78,86,79,10,18,61,91,95,75,92,79,10,78,89,78,81,79,10,78,89,88,79,19},22)
end
end)
end)
local stopBtn = Instance.new(_d({62,79,98,94,44,95,94,94,89,88},22))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({47,55,47,60,49,47,56,45,67,10,61,62,57,58},22)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({63,51,45,89,92,88,79,92},22), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({61,94,75,94,95,93,36,10,61,62,57,58,58,47,46,10,18,51,78,86,79,19},22)
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({69,57,96,79,92,97,89,92,86,78,62,79,93,94,79,92,71,10,54,89,75,78,79,78,10,93,95,77,77,79,93,93,80,95,86,86,99,24},22))
end)()