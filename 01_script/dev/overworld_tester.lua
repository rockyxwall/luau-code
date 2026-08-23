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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({75,70,78,71},30)
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
print(_d({61,49,88,71,84,89,81,84,78,70,54,71,85,86,71,84,63},30), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({53,86,67,86,85},30) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({52,81,77,87,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,71,82,82,81},30), args)
elseif style == _d({36,78,67,69,77,46,71,73},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77},30), args)
elseif style == _d({45,67,79,75,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,67,79,75,85,74,75,77,75,41,71,82,82,81},30), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77,20},30), args)
end
debug(_d({40,75,84,71,70,2,41,71,82,82,81,2,52,71,79,81,86,71},30))
end)
if not ok then debug(_d({75,80,88,81,77,71,41,71,82,82,81,2,71,84,84,81,84,28},30), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30)
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
local root = char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local force = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30))
local att   = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({57,67,78,77,75,80,73,2,86,81,28},30), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({89,67,78,77,54,81,50,81,75,80,86,2,57,2,70,81,89,80,2,71,84,84,81,84,28},30), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({35,84,84,75,88,71,70,2,67,86,28},30), pos)
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
if item:IsA(_d({47,81,70,71,78},30)) and item:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30)) and item:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)).Health > 0 then
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
mode = _d({75,70,78,71},30)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({54,71,85,86,71,84,2,38,75,85,67,68,78,71,70},30))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({54,71,85,86,71,84,2,39,80,67,68,78,71,70,16,2,47,81,70,71,28},30), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({50,78,67,91,71,84,2,70,75,71,70,3,2,38,75,85,67,68,78,75,80,73,2,68,81,86,16},30))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({74,81,88,71,84},30) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({70,81,70,73,71},30) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) then
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
local playerGui = LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({49,88,71,84,89,81,84,78,70,54,71,85,86,41,87,75},30))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({53,69,84,71,71,80,41,87,75},30))
screenGui.Name = _d({49,88,71,84,89,81,84,78,70,54,71,85,86,41,87,75},30)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({40,84,67,79,71},30))
frame.Name = _d({47,67,75,80,40,84,67,79,71},30)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({210,129,125,131,209,154,113,2,37,87,82,75,70,2,39,80,73,75,80,71,2,49,88,71,84,89,81,84,78,70,2,54,71,85,86},30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({53,86,67,86,87,85,28,2,43,70,78,71},30)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({54,71,90,86,36,81,90},30))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({42,81,88,71,84,2,35,68,81,88,71,2,54,67,84,73,71,86},30), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({74,81,88,71,84},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,42,81,88,71,84,75,80,73,2},30) .. val .. _d({2,85,86,87,70,85,2,87,82},30)
end)
createInputBtn(_d({38,81,70,73,71,2,37,78,75,79,68},30), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({70,81,70,73,71},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,38,81,70,73,71,15,74,81,78,70,75,80,73,2,10},30) .. val .. _d({2,85,86,87,70,85,11},30)
end)
createInputBtn(_d({54,71,85,86,2,53,83,87,67,84,71,2,38,81,70,73,71},30), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({85,83,87,67,84,71,65,70,81,70,73,71},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,53,83,87,67,84,71,2,57,67,78,77,75,80,73,2,10},30) .. val .. _d({2,85,86,87,70,85,11},30)
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
while enabled and mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) then
disableBot()
statusLabel.Text = _d({53,86,67,86,87,85,28,2,43,70,78,71,2,10,53,83,87,67,84,71,2,70,81,70,73,71,2,70,81,80,71,11},30)
end
end)
end)
local stopBtn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({39,47,39,52,41,39,48,37,59,2,53,54,49,50},30)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({53,86,67,86,87,85,28,2,53,54,49,50,50,39,38,2,10,43,70,78,71,11},30)
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({61,49,88,71,84,89,81,84,78,70,54,71,85,86,71,84,63,2,46,81,67,70,71,70,2,85,87,69,69,71,85,85,72,87,78,78,91,16},30))
end)()