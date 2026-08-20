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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({86,81,89,82},19)
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
print(_d({72,60,99,82,95,100,92,95,89,81,65,82,96,97,82,95,74},19), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
end
debug(_d({51,86,95,82,81,13,52,82,93,93,92,13,63,82,90,92,97,82},19))
end)
if not ok then debug(_d({86,91,99,92,88,82,52,82,93,93,92,13,82,95,95,92,95,39},19), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19)
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
local root = char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local force = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19))
local att   = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({68,78,89,88,86,91,84,13,97,92,39},19), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({100,78,89,88,65,92,61,92,86,91,97,13,68,13,81,92,100,91,13,82,95,95,92,95,39},19), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({46,95,95,86,99,82,81,13,78,97,39},19), pos)
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
if item:IsA(_d({58,92,81,82,89},19)) and item:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19)) and item:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
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
mode = _d({86,81,89,82},19)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({65,82,96,97,82,95,13,49,86,96,78,79,89,82,81},19))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({65,82,96,97,82,95,13,50,91,78,79,89,82,81,27,13,58,92,81,82,39},19), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({61,89,78,102,82,95,13,81,86,82,81,14,13,49,86,96,78,79,89,86,91,84,13,79,92,97,27},19))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({85,92,99,82,95},19) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({81,92,81,84,82},19) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) then
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
local playerGui = LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({60,99,82,95,100,92,95,89,81,65,82,96,97,52,98,86},19))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({64,80,95,82,82,91,52,98,86},19))
screenGui.Name = _d({60,99,82,95,100,92,95,89,81,65,82,96,97,52,98,86},19)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({51,95,78,90,82},19))
frame.Name = _d({58,78,86,91,51,95,78,90,82},19)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({66,54,48,92,95,91,82,95},19))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({221,140,136,142,220,165,124,13,48,98,93,86,81,13,50,91,84,86,91,82,13,60,99,82,95,100,92,95,89,81,13,65,82,96,97},19)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({64,97,78,97,98,96,39,13,54,81,89,82},19)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({65,82,101,97,47,92,101},19))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({53,92,99,82,95,13,46,79,92,99,82,13,65,78,95,84,82,97},19), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({85,92,99,82,95},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,53,92,99,82,95,86,91,84,13},19) .. val .. _d({13,96,97,98,81,96,13,98,93},19)
end)
createInputBtn(_d({49,92,81,84,82,13,48,89,86,90,79},19), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({81,92,81,84,82},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,49,92,81,84,82,26,85,92,89,81,86,91,84,13,21},19) .. val .. _d({13,96,97,98,81,96,22},19)
end)
createInputBtn(_d({65,82,96,97,13,64,94,98,78,95,82,13,49,92,81,84,82},19), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({96,94,98,78,95,82,76,81,92,81,84,82},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,64,94,98,78,95,82,13,68,78,89,88,86,91,84,13,21},19) .. val .. _d({13,96,97,98,81,96,22},19)
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
while enabled and mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) then
disableBot()
statusLabel.Text = _d({64,97,78,97,98,96,39,13,54,81,89,82,13,21,64,94,98,78,95,82,13,81,92,81,84,82,13,81,92,91,82,22},19)
end
end)
end)
local stopBtn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({50,58,50,63,52,50,59,48,70,13,64,65,60,61},19)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({64,97,78,97,98,96,39,13,64,65,60,61,61,50,49,13,21,54,81,89,82,22},19)
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({72,60,99,82,95,100,92,95,89,81,65,82,96,97,82,95,74,13,57,92,78,81,82,81,13,96,98,80,80,82,96,96,83,98,89,89,102,27},19))
end)()