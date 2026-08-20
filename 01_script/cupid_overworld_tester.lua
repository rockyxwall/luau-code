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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({82,77,85,78},23)
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
print(_d({68,56,95,78,91,96,88,91,85,77,61,78,92,93,78,91,70},23), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({59,88,84,94,92,81,82,84,82},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,78,89,89,88},23), args)
elseif style == _d({43,85,74,76,84,53,78,80},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,84,98,9,64,74,85,84},23), args)
elseif style == _d({52,74,86,82,92,81,82,84,82},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,74,86,82,92,81,82,84,82,48,78,89,89,88},23), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,84,98,9,64,74,85,84,27},23), args)
end
debug(_d({47,82,91,78,77,9,48,78,89,89,88,9,59,78,86,88,93,78},23))
end)
if not ok then debug(_d({82,87,95,88,84,78,48,78,89,89,88,9,78,91,91,88,91,35},23), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({72,72,61,78,92,93,49,88,95,78,91,42,93,93},23)) or Instance.new(_d({42,93,93,74,76,81,86,78,87,93},23))
att.Name = _d({72,72,61,78,92,93,49,88,95,78,91,42,93,93},23)
att.Parent = root
local force = root:FindFirstChild(_d({72,72,61,78,92,93,49,88,95,78,91,47,88,91,76,78},23))
if not force then
force = Instance.new(_d({53,82,87,78,74,91,63,78,85,88,76,82,93,98},23))
force.Name = _d({72,72,61,78,92,93,49,88,95,78,91,47,88,91,76,78},23)
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
local root = char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if not root then return end
local force = root:FindFirstChild(_d({72,72,61,78,92,93,49,88,95,78,91,47,88,91,76,78},23))
local att   = root:FindFirstChild(_d({72,72,61,78,92,93,49,88,95,78,91,42,93,93},23))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({64,74,85,84,82,87,80,9,93,88,35},23), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({96,74,85,84,61,88,57,88,82,87,93,9,64,9,77,88,96,87,9,78,91,91,88,91,35},23), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({42,91,91,82,95,78,77,9,74,93,35},23), pos)
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
if item:IsA(_d({54,88,77,78,85},23)) and item:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23)) and item:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
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
mode = _d({82,77,85,78},23)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({61,78,92,93,78,91,9,45,82,92,74,75,85,78,77},23))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({61,78,92,93,78,91,9,46,87,74,75,85,78,77,23,9,54,88,77,78,35},23), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({57,85,74,98,78,91,9,77,82,78,77,10,9,45,82,92,74,75,85,82,87,80,9,75,88,93,23},23))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({81,88,95,78,91},23) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({77,88,77,80,78},23) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({92,90,94,74,91,78,72,77,88,77,80,78},23) then
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
local playerGui = LocalPlayer:WaitForChild(_d({57,85,74,98,78,91,48,94,82},23), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({56,95,78,91,96,88,91,85,77,61,78,92,93,48,94,82},23))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({60,76,91,78,78,87,48,94,82},23))
screenGui.Name = _d({56,95,78,91,96,88,91,85,77,61,78,92,93,48,94,82},23)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({47,91,74,86,78},23))
frame.Name = _d({54,74,82,87,47,91,74,86,78},23)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({62,50,44,88,91,87,78,91},23))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({61,78,97,93,53,74,75,78,85},23))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({217,136,132,138,216,161,120,9,44,94,89,82,77,9,46,87,80,82,87,78,9,56,95,78,91,96,88,91,85,77,9,61,78,92,93},23)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({61,78,97,93,53,74,75,78,85},23))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({60,93,74,93,94,92,35,9,50,77,85,78},23)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({61,78,97,93,43,94,93,93,88,87},23))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({62,50,44,88,91,87,78,91},23), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({61,78,97,93,43,88,97},23))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({62,50,44,88,91,87,78,91},23), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({49,88,95,78,91,9,42,75,88,95,78,9,61,74,91,80,78,93},23), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({81,88,95,78,91},23))
statusLabel.Text = _d({60,93,74,93,94,92,35,9,49,88,95,78,91,82,87,80,9},23) .. val .. _d({9,92,93,94,77,92,9,94,89},23)
end)
createInputBtn(_d({45,88,77,80,78,9,44,85,82,86,75},23), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({77,88,77,80,78},23))
statusLabel.Text = _d({60,93,74,93,94,92,35,9,45,88,77,80,78,22,81,88,85,77,82,87,80,9,17},23) .. val .. _d({9,92,93,94,77,92,18},23)
end)
createInputBtn(_d({61,78,92,93,9,60,90,94,74,91,78,9,45,88,77,80,78},23), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({92,90,94,74,91,78,72,77,88,77,80,78},23))
statusLabel.Text = _d({60,93,74,93,94,92,35,9,60,90,94,74,91,78,9,64,74,85,84,82,87,80,9,17},23) .. val .. _d({9,92,93,94,77,92,18},23)
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
while enabled and mode == _d({92,90,94,74,91,78,72,77,88,77,80,78},23) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({92,90,94,74,91,78,72,77,88,77,80,78},23) then
disableBot()
statusLabel.Text = _d({60,93,74,93,94,92,35,9,50,77,85,78,9,17,60,90,94,74,91,78,9,77,88,77,80,78,9,77,88,87,78,18},23)
end
end)
end)
local stopBtn = Instance.new(_d({61,78,97,93,43,94,93,93,88,87},23))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({46,54,46,59,48,46,55,44,66,9,60,61,56,57},23)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({62,50,44,88,91,87,78,91},23), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({60,93,74,93,94,92,35,9,60,61,56,57,57,46,45,9,17,50,77,85,78,18},23)
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({68,56,95,78,91,96,88,91,85,77,61,78,92,93,78,91,70,9,53,88,74,77,78,77,9,92,94,76,76,78,92,92,79,94,85,85,98,23},23))
end)()