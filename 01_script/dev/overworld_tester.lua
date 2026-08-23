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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({68,63,71,64},37)
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
print(_d({54,42,81,64,77,82,74,77,71,63,47,64,78,79,64,77,56},37), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({45,74,70,80,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,64,75,75,74},37), args)
elseif style == _d({29,71,60,62,70,39,64,66},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70},37), args)
elseif style == _d({38,60,72,68,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,60,72,68,78,67,68,70,68,34,64,75,75,74},37), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70,13},37), args)
end
debug(_d({33,68,77,64,63,251,34,64,75,75,74,251,45,64,72,74,79,64},37))
end)
if not ok then debug(_d({68,73,81,74,70,64,34,64,75,75,74,251,64,77,77,74,77,21},37), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({58,58,47,64,78,79,35,74,81,64,77,28,79,79},37)) or Instance.new(_d({28,79,79,60,62,67,72,64,73,79},37))
att.Name = _d({58,58,47,64,78,79,35,74,81,64,77,28,79,79},37)
att.Parent = root
local force = root:FindFirstChild(_d({58,58,47,64,78,79,35,74,81,64,77,33,74,77,62,64},37))
if not force then
force = Instance.new(_d({39,68,73,64,60,77,49,64,71,74,62,68,79,84},37))
force.Name = _d({58,58,47,64,78,79,35,74,81,64,77,33,74,77,62,64},37)
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
local root = char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not root then return end
local force = root:FindFirstChild(_d({58,58,47,64,78,79,35,74,81,64,77,33,74,77,62,64},37))
local att   = root:FindFirstChild(_d({58,58,47,64,78,79,35,74,81,64,77,28,79,79},37))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({50,60,71,70,68,73,66,251,79,74,21},37), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({82,60,71,70,47,74,43,74,68,73,79,251,50,251,63,74,82,73,251,64,77,77,74,77,21},37), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({28,77,77,68,81,64,63,251,60,79,21},37), pos)
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
if item:IsA(_d({40,74,63,64,71},37)) and item:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37)) and item:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
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
mode = _d({68,63,71,64},37)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({47,64,78,79,64,77,251,31,68,78,60,61,71,64,63},37))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({47,64,78,79,64,77,251,32,73,60,61,71,64,63,9,251,40,74,63,64,21},37), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({43,71,60,84,64,77,251,63,68,64,63,252,251,31,68,78,60,61,71,68,73,66,251,61,74,79,9},37))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({67,74,81,64,77},37) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({63,74,63,66,64},37) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({78,76,80,60,77,64,58,63,74,63,66,64},37) then
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
local playerGui = LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({42,81,64,77,82,74,77,71,63,47,64,78,79,34,80,68},37))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({46,62,77,64,64,73,34,80,68},37))
screenGui.Name = _d({42,81,64,77,82,74,77,71,63,47,64,78,79,34,80,68},37)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({33,77,60,72,64},37))
frame.Name = _d({40,60,68,73,33,77,60,72,64},37)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({48,36,30,74,77,73,64,77},37))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({203,122,118,124,202,147,106,251,30,80,75,68,63,251,32,73,66,68,73,64,251,42,81,64,77,82,74,77,71,63,251,47,64,78,79},37)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({47,64,83,79,39,60,61,64,71},37))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({46,79,60,79,80,78,21,251,36,63,71,64},37)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({48,36,30,74,77,73,64,77},37), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({47,64,83,79,29,74,83},37))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({48,36,30,74,77,73,64,77},37), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({35,74,81,64,77,251,28,61,74,81,64,251,47,60,77,66,64,79},37), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({67,74,81,64,77},37))
statusLabel.Text = _d({46,79,60,79,80,78,21,251,35,74,81,64,77,68,73,66,251},37) .. val .. _d({251,78,79,80,63,78,251,80,75},37)
end)
createInputBtn(_d({31,74,63,66,64,251,30,71,68,72,61},37), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({63,74,63,66,64},37))
statusLabel.Text = _d({46,79,60,79,80,78,21,251,31,74,63,66,64,8,67,74,71,63,68,73,66,251,3},37) .. val .. _d({251,78,79,80,63,78,4},37)
end)
createInputBtn(_d({47,64,78,79,251,46,76,80,60,77,64,251,31,74,63,66,64},37), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({78,76,80,60,77,64,58,63,74,63,66,64},37))
statusLabel.Text = _d({46,79,60,79,80,78,21,251,46,76,80,60,77,64,251,50,60,71,70,68,73,66,251,3},37) .. val .. _d({251,78,79,80,63,78,4},37)
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
while enabled and mode == _d({78,76,80,60,77,64,58,63,74,63,66,64},37) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({78,76,80,60,77,64,58,63,74,63,66,64},37) then
disableBot()
statusLabel.Text = _d({46,79,60,79,80,78,21,251,36,63,71,64,251,3,46,76,80,60,77,64,251,63,74,63,66,64,251,63,74,73,64,4},37)
end
end)
end)
local stopBtn = Instance.new(_d({47,64,83,79,29,80,79,79,74,73},37))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({32,40,32,45,34,32,41,30,52,251,46,47,42,43},37)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({48,36,30,74,77,73,64,77},37), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({46,79,60,79,80,78,21,251,46,47,42,43,43,32,31,251,3,36,63,71,64,4},37)
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({54,42,81,64,77,82,74,77,71,63,47,64,78,79,64,77,56,251,39,74,60,63,64,63,251,78,80,62,62,64,78,78,65,80,71,71,84,9},37))
end)()