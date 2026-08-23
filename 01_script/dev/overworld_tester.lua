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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({49,44,52,45},56)
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
print(_d({35,23,62,45,58,63,55,58,52,44,28,45,59,60,45,58,37},56), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({26,55,51,61,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,45,56,56,55},56), args)
elseif style == _d({10,52,41,43,51,20,45,47},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51},56), args)
elseif style == _d({19,41,53,49,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,41,53,49,59,48,49,51,49,15,45,56,56,55},56), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51,250},56), args)
end
debug(_d({14,49,58,45,44,232,15,45,56,56,55,232,26,45,53,55,60,45},56))
end)
if not ok then debug(_d({49,54,62,55,51,45,15,45,56,56,55,232,45,58,58,55,58,2},56), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56)) or Instance.new(_d({9,60,60,41,43,48,53,45,54,60},56))
att.Name = _d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56)
att.Parent = root
local force = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56))
if not force then
force = Instance.new(_d({20,49,54,45,41,58,30,45,52,55,43,49,60,65},56))
force.Name = _d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56)
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
local root = char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local force = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56))
local att   = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({31,41,52,51,49,54,47,232,60,55,2},56), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({63,41,52,51,28,55,24,55,49,54,60,232,31,232,44,55,63,54,232,45,58,58,55,58,2},56), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({9,58,58,49,62,45,44,232,41,60,2},56), pos)
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
if item:IsA(_d({21,55,44,45,52},56)) and item:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56)) and item:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)).Health > 0 then
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
mode = _d({49,44,52,45},56)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({28,45,59,60,45,58,232,12,49,59,41,42,52,45,44},56))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({28,45,59,60,45,58,232,13,54,41,42,52,45,44,246,232,21,55,44,45,2},56), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({24,52,41,65,45,58,232,44,49,45,44,233,232,12,49,59,41,42,52,49,54,47,232,42,55,60,246},56))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({48,55,62,45,58},56) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({44,55,44,47,45},56) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) then
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
local playerGui = LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({23,62,45,58,63,55,58,52,44,28,45,59,60,15,61,49},56))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({27,43,58,45,45,54,15,61,49},56))
screenGui.Name = _d({23,62,45,58,63,55,58,52,44,28,45,59,60,15,61,49},56)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({14,58,41,53,45},56))
frame.Name = _d({21,41,49,54,14,58,41,53,45},56)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({184,103,99,105,183,128,87,232,11,61,56,49,44,232,13,54,47,49,54,45,232,23,62,45,58,63,55,58,52,44,232,28,45,59,60},56)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({27,60,41,60,61,59,2,232,17,44,52,45},56)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({28,45,64,60,10,55,64},56))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({16,55,62,45,58,232,9,42,55,62,45,232,28,41,58,47,45,60},56), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({48,55,62,45,58},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,16,55,62,45,58,49,54,47,232},56) .. val .. _d({232,59,60,61,44,59,232,61,56},56)
end)
createInputBtn(_d({12,55,44,47,45,232,11,52,49,53,42},56), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({44,55,44,47,45},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,12,55,44,47,45,245,48,55,52,44,49,54,47,232,240},56) .. val .. _d({232,59,60,61,44,59,241},56)
end)
createInputBtn(_d({28,45,59,60,232,27,57,61,41,58,45,232,12,55,44,47,45},56), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({59,57,61,41,58,45,39,44,55,44,47,45},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,27,57,61,41,58,45,232,31,41,52,51,49,54,47,232,240},56) .. val .. _d({232,59,60,61,44,59,241},56)
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
while enabled and mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) then
disableBot()
statusLabel.Text = _d({27,60,41,60,61,59,2,232,17,44,52,45,232,240,27,57,61,41,58,45,232,44,55,44,47,45,232,44,55,54,45,241},56)
end
end)
end)
local stopBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({13,21,13,26,15,13,22,11,33,232,27,28,23,24},56)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({27,60,41,60,61,59,2,232,27,28,23,24,24,13,12,232,240,17,44,52,45,241},56)
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({35,23,62,45,58,63,55,58,52,44,28,45,59,60,45,58,37,232,20,55,41,44,45,44,232,59,61,43,43,45,59,59,46,61,52,52,65,246},56))
end)()