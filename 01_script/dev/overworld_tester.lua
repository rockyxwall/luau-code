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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({58,53,61,54},47)
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
print(_d({44,32,71,54,67,72,64,67,61,53,37,54,68,69,54,67,46},47), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({35,64,60,70,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,54,65,65,64},47), args)
elseif style == _d({19,61,50,52,60,29,54,56},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60},47), args)
elseif style == _d({28,50,62,58,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,50,62,58,68,57,58,60,58,24,54,65,65,64},47), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60,3},47), args)
end
debug(_d({23,58,67,54,53,241,24,54,65,65,64,241,35,54,62,64,69,54},47))
end)
if not ok then debug(_d({58,63,71,64,60,54,24,54,65,65,64,241,54,67,67,64,67,11},47), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({48,48,37,54,68,69,25,64,71,54,67,18,69,69},47)) or Instance.new(_d({18,69,69,50,52,57,62,54,63,69},47))
att.Name = _d({48,48,37,54,68,69,25,64,71,54,67,18,69,69},47)
att.Parent = root
local force = root:FindFirstChild(_d({48,48,37,54,68,69,25,64,71,54,67,23,64,67,52,54},47))
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
force.Name = _d({48,48,37,54,68,69,25,64,71,54,67,23,64,67,52,54},47)
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
local root = char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local force = root:FindFirstChild(_d({48,48,37,54,68,69,25,64,71,54,67,23,64,67,52,54},47))
local att   = root:FindFirstChild(_d({48,48,37,54,68,69,25,64,71,54,67,18,69,69},47))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({40,50,61,60,58,63,56,241,69,64,11},47), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({72,50,61,60,37,64,33,64,58,63,69,241,40,241,53,64,72,63,241,54,67,67,64,67,11},47), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({18,67,67,58,71,54,53,241,50,69,11},47), pos)
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
if item:IsA(_d({30,64,53,54,61},47)) and item:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47)) and item:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 then
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
mode = _d({58,53,61,54},47)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({37,54,68,69,54,67,241,21,58,68,50,51,61,54,53},47))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({37,54,68,69,54,67,241,22,63,50,51,61,54,53,255,241,30,64,53,54,11},47), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({33,61,50,74,54,67,241,53,58,54,53,242,241,21,58,68,50,51,61,58,63,56,241,51,64,69,255},47))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({57,64,71,54,67},47) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({53,64,53,56,54},47) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({68,66,70,50,67,54,48,53,64,53,56,54},47) then
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
local playerGui = LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({32,71,54,67,72,64,67,61,53,37,54,68,69,24,70,58},47))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({36,52,67,54,54,63,24,70,58},47))
screenGui.Name = _d({32,71,54,67,72,64,67,61,53,37,54,68,69,24,70,58},47)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({23,67,50,62,54},47))
frame.Name = _d({30,50,58,63,23,67,50,62,54},47)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({38,26,20,64,67,63,54,67},47))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({37,54,73,69,29,50,51,54,61},47))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({193,112,108,114,192,137,96,241,20,70,65,58,53,241,22,63,56,58,63,54,241,32,71,54,67,72,64,67,61,53,241,37,54,68,69},47)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({37,54,73,69,29,50,51,54,61},47))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({36,69,50,69,70,68,11,241,26,53,61,54},47)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({37,54,73,69,19,70,69,69,64,63},47))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({38,26,20,64,67,63,54,67},47), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({37,54,73,69,19,64,73},47))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({38,26,20,64,67,63,54,67},47), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({25,64,71,54,67,241,18,51,64,71,54,241,37,50,67,56,54,69},47), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({57,64,71,54,67},47))
statusLabel.Text = _d({36,69,50,69,70,68,11,241,25,64,71,54,67,58,63,56,241},47) .. val .. _d({241,68,69,70,53,68,241,70,65},47)
end)
createInputBtn(_d({21,64,53,56,54,241,20,61,58,62,51},47), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({53,64,53,56,54},47))
statusLabel.Text = _d({36,69,50,69,70,68,11,241,21,64,53,56,54,254,57,64,61,53,58,63,56,241,249},47) .. val .. _d({241,68,69,70,53,68,250},47)
end)
createInputBtn(_d({37,54,68,69,241,36,66,70,50,67,54,241,21,64,53,56,54},47), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({68,66,70,50,67,54,48,53,64,53,56,54},47))
statusLabel.Text = _d({36,69,50,69,70,68,11,241,36,66,70,50,67,54,241,40,50,61,60,58,63,56,241,249},47) .. val .. _d({241,68,69,70,53,68,250},47)
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
while enabled and mode == _d({68,66,70,50,67,54,48,53,64,53,56,54},47) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({68,66,70,50,67,54,48,53,64,53,56,54},47) then
disableBot()
statusLabel.Text = _d({36,69,50,69,70,68,11,241,26,53,61,54,241,249,36,66,70,50,67,54,241,53,64,53,56,54,241,53,64,63,54,250},47)
end
end)
end)
local stopBtn = Instance.new(_d({37,54,73,69,19,70,69,69,64,63},47))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({22,30,22,35,24,22,31,20,42,241,36,37,32,33},47)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({38,26,20,64,67,63,54,67},47), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({36,69,50,69,70,68,11,241,36,37,32,33,33,22,21,241,249,26,53,61,54,250},47)
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({44,32,71,54,67,72,64,67,61,53,37,54,68,69,54,67,46,241,29,64,50,53,54,53,241,68,70,52,52,54,68,68,55,70,61,61,74,255},47))
end)()