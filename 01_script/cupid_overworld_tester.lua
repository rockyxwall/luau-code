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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({85,80,88,81},20)
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
print(_d({71,59,98,81,94,99,91,94,88,80,64,81,95,96,81,94,73},20), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({62,91,87,97,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,81,92,92,91},20), args)
elseif style == _d({46,88,77,79,87,56,81,83},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87},20), args)
elseif style == _d({55,77,89,85,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,77,89,85,95,84,85,87,85,51,81,92,92,91},20), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87,30},20), args)
end
debug(_d({50,85,94,81,80,12,51,81,92,92,91,12,62,81,89,91,96,81},20))
end)
if not ok then debug(_d({85,90,98,91,87,81,51,81,92,92,91,12,81,94,94,91,94,38},20), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({75,75,64,81,95,96,52,91,98,81,94,45,96,96},20)) or Instance.new(_d({45,96,96,77,79,84,89,81,90,96},20))
att.Name = _d({75,75,64,81,95,96,52,91,98,81,94,45,96,96},20)
att.Parent = root
local force = root:FindFirstChild(_d({75,75,64,81,95,96,52,91,98,81,94,50,91,94,79,81},20))
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = _d({75,75,64,81,95,96,52,91,98,81,94,50,91,94,79,81},20)
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
local root = char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local force = root:FindFirstChild(_d({75,75,64,81,95,96,52,91,98,81,94,50,91,94,79,81},20))
local att   = root:FindFirstChild(_d({75,75,64,81,95,96,52,91,98,81,94,45,96,96},20))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({67,77,88,87,85,90,83,12,96,91,38},20), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({99,77,88,87,64,91,60,91,85,90,96,12,67,12,80,91,99,90,12,81,94,94,91,94,38},20), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({45,94,94,85,98,81,80,12,77,96,38},20), pos)
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
if item:IsA(_d({57,91,80,81,88},20)) and item:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20)) and item:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 then
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
mode = _d({85,80,88,81},20)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({64,81,95,96,81,94,12,48,85,95,77,78,88,81,80},20))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({64,81,95,96,81,94,12,49,90,77,78,88,81,80,26,12,57,91,80,81,38},20), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({60,88,77,101,81,94,12,80,85,81,80,13,12,48,85,95,77,78,88,85,90,83,12,78,91,96,26},20))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({84,91,98,81,94},20) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({80,91,80,83,81},20) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({95,93,97,77,94,81,75,80,91,80,83,81},20) then
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
local playerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({59,98,81,94,99,91,94,88,80,64,81,95,96,51,97,85},20))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({63,79,94,81,81,90,51,97,85},20))
screenGui.Name = _d({59,98,81,94,99,91,94,88,80,64,81,95,96,51,97,85},20)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({50,94,77,89,81},20))
frame.Name = _d({57,77,85,90,50,94,77,89,81},20)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({65,53,47,91,94,90,81,94},20))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({64,81,100,96,56,77,78,81,88},20))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({220,139,135,141,219,164,123,12,47,97,92,85,80,12,49,90,83,85,90,81,12,59,98,81,94,99,91,94,88,80,12,64,81,95,96},20)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({64,81,100,96,56,77,78,81,88},20))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({63,96,77,96,97,95,38,12,53,80,88,81},20)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({64,81,100,96,46,97,96,96,91,90},20))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({65,53,47,91,94,90,81,94},20), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({64,81,100,96,46,91,100},20))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({65,53,47,91,94,90,81,94},20), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({52,91,98,81,94,12,45,78,91,98,81,12,64,77,94,83,81,96},20), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({84,91,98,81,94},20))
statusLabel.Text = _d({63,96,77,96,97,95,38,12,52,91,98,81,94,85,90,83,12},20) .. val .. _d({12,95,96,97,80,95,12,97,92},20)
end)
createInputBtn(_d({48,91,80,83,81,12,47,88,85,89,78},20), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({80,91,80,83,81},20))
statusLabel.Text = _d({63,96,77,96,97,95,38,12,48,91,80,83,81,25,84,91,88,80,85,90,83,12,20},20) .. val .. _d({12,95,96,97,80,95,21},20)
end)
createInputBtn(_d({64,81,95,96,12,63,93,97,77,94,81,12,48,91,80,83,81},20), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({95,93,97,77,94,81,75,80,91,80,83,81},20))
statusLabel.Text = _d({63,96,77,96,97,95,38,12,63,93,97,77,94,81,12,67,77,88,87,85,90,83,12,20},20) .. val .. _d({12,95,96,97,80,95,21},20)
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
while enabled and mode == _d({95,93,97,77,94,81,75,80,91,80,83,81},20) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({95,93,97,77,94,81,75,80,91,80,83,81},20) then
disableBot()
statusLabel.Text = _d({63,96,77,96,97,95,38,12,53,80,88,81,12,20,63,93,97,77,94,81,12,80,91,80,83,81,12,80,91,90,81,21},20)
end
end)
end)
local stopBtn = Instance.new(_d({64,81,100,96,46,97,96,96,91,90},20))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({49,57,49,62,51,49,58,47,69,12,63,64,59,60},20)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({65,53,47,91,94,90,81,94},20), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({63,96,77,96,97,95,38,12,63,64,59,60,60,49,48,12,20,53,80,88,81,21},20)
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({71,59,98,81,94,99,91,94,88,80,64,81,95,96,81,94,73,12,56,91,77,80,81,80,12,95,97,79,79,81,95,95,82,97,88,88,101,26},20))
end)()