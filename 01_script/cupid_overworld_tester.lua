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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local RunService = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local UserInputService = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({65,60,68,61},40)
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
print(_d({51,39,78,61,74,79,71,74,68,60,44,61,75,76,61,74,53},40), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({42,71,67,77,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,61,72,72,71},40), args)
elseif style == _d({26,68,57,59,67,36,61,63},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67},40), args)
elseif style == _d({35,57,69,65,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,57,69,65,75,64,65,67,65,31,61,72,72,71},40), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67,10},40), args)
end
debug(_d({30,65,74,61,60,248,31,61,72,72,71,248,42,61,69,71,76,61},40))
end)
if not ok then debug(_d({65,70,78,71,67,61,31,61,72,72,71,248,61,74,74,71,74,18},40), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({55,55,44,61,75,76,32,71,78,61,74,25,76,76},40)) or Instance.new(_d({25,76,76,57,59,64,69,61,70,76},40))
att.Name = _d({55,55,44,61,75,76,32,71,78,61,74,25,76,76},40)
att.Parent = root
local force = root:FindFirstChild(_d({55,55,44,61,75,76,32,71,78,61,74,30,71,74,59,61},40))
if not force then
force = Instance.new(_d({36,65,70,61,57,74,46,61,68,71,59,65,76,81},40))
force.Name = _d({55,55,44,61,75,76,32,71,78,61,74,30,71,74,59,61},40)
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
local root = char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not root then return end
local force = root:FindFirstChild(_d({55,55,44,61,75,76,32,71,78,61,74,30,71,74,59,61},40))
local att   = root:FindFirstChild(_d({55,55,44,61,75,76,32,71,78,61,74,25,76,76},40))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({47,57,68,67,65,70,63,248,76,71,18},40), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({79,57,68,67,44,71,40,71,65,70,76,248,47,248,60,71,79,70,248,61,74,74,71,74,18},40), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({25,74,74,65,78,61,60,248,57,76,18},40), pos)
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
if item:IsA(_d({37,71,60,61,68},40)) and item:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40)) and item:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)).Health > 0 then
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
mode = _d({65,60,68,61},40)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({44,61,75,76,61,74,248,28,65,75,57,58,68,61,60},40))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({44,61,75,76,61,74,248,29,70,57,58,68,61,60,6,248,37,71,60,61,18},40), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({40,68,57,81,61,74,248,60,65,61,60,249,248,28,65,75,57,58,68,65,70,63,248,58,71,76,6},40))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({64,71,78,61,74},40) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({60,71,60,63,61},40) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({75,73,77,57,74,61,55,60,71,60,63,61},40) then
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
local playerGui = LocalPlayer:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({39,78,61,74,79,71,74,68,60,44,61,75,76,31,77,65},40))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({43,59,74,61,61,70,31,77,65},40))
screenGui.Name = _d({39,78,61,74,79,71,74,68,60,44,61,75,76,31,77,65},40)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({30,74,57,69,61},40))
frame.Name = _d({37,57,65,70,30,74,57,69,61},40)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({45,33,27,71,74,70,61,74},40))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({44,61,80,76,36,57,58,61,68},40))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({200,119,115,121,199,144,103,248,27,77,72,65,60,248,29,70,63,65,70,61,248,39,78,61,74,79,71,74,68,60,248,44,61,75,76},40)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({44,61,80,76,36,57,58,61,68},40))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({43,76,57,76,77,75,18,248,33,60,68,61},40)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({45,33,27,71,74,70,61,74},40), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({44,61,80,76,26,71,80},40))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({45,33,27,71,74,70,61,74},40), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({32,71,78,61,74,248,25,58,71,78,61,248,44,57,74,63,61,76},40), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({64,71,78,61,74},40))
statusLabel.Text = _d({43,76,57,76,77,75,18,248,32,71,78,61,74,65,70,63,248},40) .. val .. _d({248,75,76,77,60,75,248,77,72},40)
end)
createInputBtn(_d({28,71,60,63,61,248,27,68,65,69,58},40), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({60,71,60,63,61},40))
statusLabel.Text = _d({43,76,57,76,77,75,18,248,28,71,60,63,61,5,64,71,68,60,65,70,63,248,0},40) .. val .. _d({248,75,76,77,60,75,1},40)
end)
createInputBtn(_d({44,61,75,76,248,43,73,77,57,74,61,248,28,71,60,63,61},40), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({75,73,77,57,74,61,55,60,71,60,63,61},40))
statusLabel.Text = _d({43,76,57,76,77,75,18,248,43,73,77,57,74,61,248,47,57,68,67,65,70,63,248,0},40) .. val .. _d({248,75,76,77,60,75,1},40)
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
while enabled and mode == _d({75,73,77,57,74,61,55,60,71,60,63,61},40) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({75,73,77,57,74,61,55,60,71,60,63,61},40) then
disableBot()
statusLabel.Text = _d({43,76,57,76,77,75,18,248,33,60,68,61,248,0,43,73,77,57,74,61,248,60,71,60,63,61,248,60,71,70,61,1},40)
end
end)
end)
local stopBtn = Instance.new(_d({44,61,80,76,26,77,76,76,71,70},40))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({29,37,29,42,31,29,38,27,49,248,43,44,39,40},40)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({45,33,27,71,74,70,61,74},40), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({43,76,57,76,77,75,18,248,43,44,39,40,40,29,28,248,0,33,60,68,61,1},40)
local VIM = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({51,39,78,61,74,79,71,74,68,60,44,61,75,76,61,74,53,248,36,71,57,60,61,60,248,75,77,59,59,61,75,75,62,77,68,68,81,6},40))
end)()