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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({73,68,76,69},32)
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
print(_d({59,47,86,69,82,87,79,82,76,68,52,69,83,84,69,82,61},32), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
debug(_d({38,73,82,69,68,0,39,69,80,80,79,0,50,69,77,79,84,69},32))
end)
if not ok then debug(_d({73,78,86,79,75,69,39,69,80,80,79,0,69,82,82,79,82,26},32), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32)
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
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local force = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32))
local att   = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({55,65,76,75,73,78,71,0,84,79,26},32), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({87,65,76,75,52,79,48,79,73,78,84,0,55,0,68,79,87,78,0,69,82,82,79,82,26},32), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({33,82,82,73,86,69,68,0,65,84,26},32), pos)
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
if item:IsA(_d({45,79,68,69,76},32)) and item:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32)) and item:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
mode = _d({73,68,76,69},32)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({52,69,83,84,69,82,0,36,73,83,65,66,76,69,68},32))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({52,69,83,84,69,82,0,37,78,65,66,76,69,68,14,0,45,79,68,69,26},32), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({48,76,65,89,69,82,0,68,73,69,68,1,0,36,73,83,65,66,76,73,78,71,0,66,79,84,14},32))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({72,79,86,69,82},32) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({68,79,68,71,69},32) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) then
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
local playerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({47,86,69,82,87,79,82,76,68,52,69,83,84,39,85,73},32))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({51,67,82,69,69,78,39,85,73},32))
screenGui.Name = _d({47,86,69,82,87,79,82,76,68,52,69,83,84,39,85,73},32)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({38,82,65,77,69},32))
frame.Name = _d({45,65,73,78,38,82,65,77,69},32)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({53,41,35,79,82,78,69,82},32))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({208,127,123,129,207,152,111,0,35,85,80,73,68,0,37,78,71,73,78,69,0,47,86,69,82,87,79,82,76,68,0,52,69,83,84},32)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({51,84,65,84,85,83,26,0,41,68,76,69},32)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({52,69,88,84,34,79,88},32))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({40,79,86,69,82,0,33,66,79,86,69,0,52,65,82,71,69,84},32), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({72,79,86,69,82},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,40,79,86,69,82,73,78,71,0},32) .. val .. _d({0,83,84,85,68,83,0,85,80},32)
end)
createInputBtn(_d({36,79,68,71,69,0,35,76,73,77,66},32), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({68,79,68,71,69},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,36,79,68,71,69,13,72,79,76,68,73,78,71,0,8},32) .. val .. _d({0,83,84,85,68,83,9},32)
end)
createInputBtn(_d({52,69,83,84,0,51,81,85,65,82,69,0,36,79,68,71,69},32), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({83,81,85,65,82,69,63,68,79,68,71,69},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,51,81,85,65,82,69,0,55,65,76,75,73,78,71,0,8},32) .. val .. _d({0,83,84,85,68,83,9},32)
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
while enabled and mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) then
disableBot()
statusLabel.Text = _d({51,84,65,84,85,83,26,0,41,68,76,69,0,8,51,81,85,65,82,69,0,68,79,68,71,69,0,68,79,78,69,9},32)
end
end)
end)
local stopBtn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({37,45,37,50,39,37,46,35,57,0,51,52,47,48},32)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({51,84,65,84,85,83,26,0,51,52,47,48,48,37,36,0,8,41,68,76,69,9},32)
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({59,47,86,69,82,87,79,82,76,68,52,69,83,84,69,82,61,0,44,79,65,68,69,68,0,83,85,67,67,69,83,83,70,85,76,76,89,14},32))
end)()