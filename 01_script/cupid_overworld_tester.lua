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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local UserInputService = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({80,75,83,76},25)
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
print(_d({66,54,93,76,89,94,86,89,83,75,59,76,90,91,76,89,68},25), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({58,91,72,91,90},25) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({57,86,82,92,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,76,87,87,86},25), args)
elseif style == _d({41,83,72,74,82,51,76,78},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82},25), args)
elseif style == _d({50,72,84,80,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,72,84,80,90,79,80,82,80,46,76,87,87,86},25), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82,25},25), args)
end
debug(_d({45,80,89,76,75,7,46,76,87,87,86,7,57,76,84,86,91,76},25))
end)
if not ok then debug(_d({80,85,93,86,82,76,46,76,87,87,86,7,76,89,89,86,89,33},25), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({70,70,59,76,90,91,47,86,93,76,89,40,91,91},25)) or Instance.new(_d({40,91,91,72,74,79,84,76,85,91},25))
att.Name = _d({70,70,59,76,90,91,47,86,93,76,89,40,91,91},25)
att.Parent = root
local force = root:FindFirstChild(_d({70,70,59,76,90,91,47,86,93,76,89,45,86,89,74,76},25))
if not force then
force = Instance.new(_d({51,80,85,76,72,89,61,76,83,86,74,80,91,96},25))
force.Name = _d({70,70,59,76,90,91,47,86,93,76,89,45,86,89,74,76},25)
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
local root = char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not root then return end
local force = root:FindFirstChild(_d({70,70,59,76,90,91,47,86,93,76,89,45,86,89,74,76},25))
local att   = root:FindFirstChild(_d({70,70,59,76,90,91,47,86,93,76,89,40,91,91},25))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({62,72,83,82,80,85,78,7,91,86,33},25), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({94,72,83,82,59,86,55,86,80,85,91,7,62,7,75,86,94,85,7,76,89,89,86,89,33},25), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({40,89,89,80,93,76,75,7,72,91,33},25), pos)
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
if item:IsA(_d({52,86,75,76,83},25)) and item:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25)) and item:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)).Health > 0 then
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
mode = _d({80,75,83,76},25)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({59,76,90,91,76,89,7,43,80,90,72,73,83,76,75},25))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({59,76,90,91,76,89,7,44,85,72,73,83,76,75,21,7,52,86,75,76,33},25), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({55,83,72,96,76,89,7,75,80,76,75,8,7,43,80,90,72,73,83,80,85,78,7,73,86,91,21},25))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({79,86,93,76,89},25) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({75,86,75,78,76},25) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({90,88,92,72,89,76,70,75,86,75,78,76},25) then
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
local playerGui = LocalPlayer:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({54,93,76,89,94,86,89,83,75,59,76,90,91,46,92,80},25))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({58,74,89,76,76,85,46,92,80},25))
screenGui.Name = _d({54,93,76,89,94,86,89,83,75,59,76,90,91,46,92,80},25)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({45,89,72,84,76},25))
frame.Name = _d({52,72,80,85,45,89,72,84,76},25)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({60,48,42,86,89,85,76,89},25))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({59,76,95,91,51,72,73,76,83},25))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({215,134,130,136,214,159,118,7,42,92,87,80,75,7,44,85,78,80,85,76,7,54,93,76,89,94,86,89,83,75,7,59,76,90,91},25)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({59,76,95,91,51,72,73,76,83},25))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({58,91,72,91,92,90,33,7,48,75,83,76},25)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({59,76,95,91,41,92,91,91,86,85},25))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({60,48,42,86,89,85,76,89},25), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({59,76,95,91,41,86,95},25))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({60,48,42,86,89,85,76,89},25), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({47,86,93,76,89,7,40,73,86,93,76,7,59,72,89,78,76,91},25), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({79,86,93,76,89},25))
statusLabel.Text = _d({58,91,72,91,92,90,33,7,47,86,93,76,89,80,85,78,7},25) .. val .. _d({7,90,91,92,75,90,7,92,87},25)
end)
createInputBtn(_d({43,86,75,78,76,7,42,83,80,84,73},25), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({75,86,75,78,76},25))
statusLabel.Text = _d({58,91,72,91,92,90,33,7,43,86,75,78,76,20,79,86,83,75,80,85,78,7,15},25) .. val .. _d({7,90,91,92,75,90,16},25)
end)
createInputBtn(_d({59,76,90,91,7,58,88,92,72,89,76,7,43,86,75,78,76},25), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({90,88,92,72,89,76,70,75,86,75,78,76},25))
statusLabel.Text = _d({58,91,72,91,92,90,33,7,58,88,92,72,89,76,7,62,72,83,82,80,85,78,7,15},25) .. val .. _d({7,90,91,92,75,90,16},25)
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
while enabled and mode == _d({90,88,92,72,89,76,70,75,86,75,78,76},25) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({90,88,92,72,89,76,70,75,86,75,78,76},25) then
disableBot()
statusLabel.Text = _d({58,91,72,91,92,90,33,7,48,75,83,76,7,15,58,88,92,72,89,76,7,75,86,75,78,76,7,75,86,85,76,16},25)
end
end)
end)
local stopBtn = Instance.new(_d({59,76,95,91,41,92,91,91,86,85},25))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({44,52,44,57,46,44,53,42,64,7,58,59,54,55},25)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({60,48,42,86,89,85,76,89},25), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({58,91,72,91,92,90,33,7,58,59,54,55,55,44,43,7,15,48,75,83,76,16},25)
local VIM = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({66,54,93,76,89,94,86,89,83,75,59,76,90,91,76,89,68,7,51,86,72,75,76,75,7,90,92,74,74,76,90,90,77,92,83,83,96,21},25))
end)()