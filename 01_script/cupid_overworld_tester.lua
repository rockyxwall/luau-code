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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({78,73,81,74},27)
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
print(_d({64,52,91,74,87,92,84,87,81,73,57,74,88,89,74,87,66},27), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({55,84,80,90,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,74,85,85,84},27), args)
elseif style == _d({39,81,70,72,80,49,74,76},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80},27), args)
elseif style == _d({48,70,82,78,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,70,82,78,88,77,78,80,78,44,74,85,85,84},27), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80,23},27), args)
end
debug(_d({43,78,87,74,73,5,44,74,85,85,84,5,55,74,82,84,89,74},27))
end)
if not ok then debug(_d({78,83,91,84,80,74,44,74,85,85,84,5,74,87,87,84,87,31},27), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27)) or Instance.new(_d({38,89,89,70,72,77,82,74,83,89},27))
att.Name = _d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27)
att.Parent = root
local force = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27))
if not force then
force = Instance.new(_d({49,78,83,74,70,87,59,74,81,84,72,78,89,94},27))
force.Name = _d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27)
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
local root = char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local force = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27))
local att   = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({60,70,81,80,78,83,76,5,89,84,31},27), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({92,70,81,80,57,84,53,84,78,83,89,5,60,5,73,84,92,83,5,74,87,87,84,87,31},27), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({38,87,87,78,91,74,73,5,70,89,31},27), pos)
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
if item:IsA(_d({50,84,73,74,81},27)) and item:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27)) and item:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 then
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
mode = _d({78,73,81,74},27)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({57,74,88,89,74,87,5,41,78,88,70,71,81,74,73},27))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({57,74,88,89,74,87,5,42,83,70,71,81,74,73,19,5,50,84,73,74,31},27), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({53,81,70,94,74,87,5,73,78,74,73,6,5,41,78,88,70,71,81,78,83,76,5,71,84,89,19},27))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({77,84,91,74,87},27) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({73,84,73,76,74},27) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({88,86,90,70,87,74,68,73,84,73,76,74},27) then
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
local playerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({52,91,74,87,92,84,87,81,73,57,74,88,89,44,90,78},27))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({56,72,87,74,74,83,44,90,78},27))
screenGui.Name = _d({52,91,74,87,92,84,87,81,73,57,74,88,89,44,90,78},27)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({43,87,70,82,74},27))
frame.Name = _d({50,70,78,83,43,87,70,82,74},27)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({58,46,40,84,87,83,74,87},27))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({213,132,128,134,212,157,116,5,40,90,85,78,73,5,42,83,76,78,83,74,5,52,91,74,87,92,84,87,81,73,5,57,74,88,89},27)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({56,89,70,89,90,88,31,5,46,73,81,74},27)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({57,74,93,89,39,90,89,89,84,83},27))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({58,46,40,84,87,83,74,87},27), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({57,74,93,89,39,84,93},27))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({58,46,40,84,87,83,74,87},27), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({45,84,91,74,87,5,38,71,84,91,74,5,57,70,87,76,74,89},27), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({77,84,91,74,87},27))
statusLabel.Text = _d({56,89,70,89,90,88,31,5,45,84,91,74,87,78,83,76,5},27) .. val .. _d({5,88,89,90,73,88,5,90,85},27)
end)
createInputBtn(_d({41,84,73,76,74,5,40,81,78,82,71},27), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({73,84,73,76,74},27))
statusLabel.Text = _d({56,89,70,89,90,88,31,5,41,84,73,76,74,18,77,84,81,73,78,83,76,5,13},27) .. val .. _d({5,88,89,90,73,88,14},27)
end)
createInputBtn(_d({57,74,88,89,5,56,86,90,70,87,74,5,41,84,73,76,74},27), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({88,86,90,70,87,74,68,73,84,73,76,74},27))
statusLabel.Text = _d({56,89,70,89,90,88,31,5,56,86,90,70,87,74,5,60,70,81,80,78,83,76,5,13},27) .. val .. _d({5,88,89,90,73,88,14},27)
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
while enabled and mode == _d({88,86,90,70,87,74,68,73,84,73,76,74},27) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({88,86,90,70,87,74,68,73,84,73,76,74},27) then
disableBot()
statusLabel.Text = _d({56,89,70,89,90,88,31,5,46,73,81,74,5,13,56,86,90,70,87,74,5,73,84,73,76,74,5,73,84,83,74,14},27)
end
end)
end)
local stopBtn = Instance.new(_d({57,74,93,89,39,90,89,89,84,83},27))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({42,50,42,55,44,42,51,40,62,5,56,57,52,53},27)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({58,46,40,84,87,83,74,87},27), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({56,89,70,89,90,88,31,5,56,57,52,53,53,42,41,5,13,46,73,81,74,14},27)
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({64,52,91,74,87,92,84,87,81,73,57,74,88,89,74,87,66,5,49,84,70,73,74,73,5,88,90,72,72,74,88,88,75,90,81,81,94,19},27))
end)()