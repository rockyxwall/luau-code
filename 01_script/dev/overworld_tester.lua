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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({79,74,82,75},26)
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
print(_d({65,53,92,75,88,93,85,88,82,74,58,75,89,90,75,88,67},26), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({56,85,81,91,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,75,86,86,85},26), args)
elseif style == _d({40,82,71,73,81,50,75,77},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81},26), args)
elseif style == _d({49,71,83,79,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,71,83,79,89,78,79,81,79,45,75,86,86,85},26), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81,24},26), args)
end
debug(_d({44,79,88,75,74,6,45,75,86,86,85,6,56,75,83,85,90,75},26))
end)
if not ok then debug(_d({79,84,92,85,81,75,45,75,86,86,85,6,75,88,88,85,88,32},26), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({69,69,58,75,89,90,46,85,92,75,88,39,90,90},26)) or Instance.new(_d({39,90,90,71,73,78,83,75,84,90},26))
att.Name = _d({69,69,58,75,89,90,46,85,92,75,88,39,90,90},26)
att.Parent = root
local force = root:FindFirstChild(_d({69,69,58,75,89,90,46,85,92,75,88,44,85,88,73,75},26))
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
force.Name = _d({69,69,58,75,89,90,46,85,92,75,88,44,85,88,73,75},26)
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
local root = char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local force = root:FindFirstChild(_d({69,69,58,75,89,90,46,85,92,75,88,44,85,88,73,75},26))
local att   = root:FindFirstChild(_d({69,69,58,75,89,90,46,85,92,75,88,39,90,90},26))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({61,71,82,81,79,84,77,6,90,85,32},26), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({93,71,82,81,58,85,54,85,79,84,90,6,61,6,74,85,93,84,6,75,88,88,85,88,32},26), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({39,88,88,79,92,75,74,6,71,90,32},26), pos)
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
if item:IsA(_d({51,85,74,75,82},26)) and item:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26)) and item:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 then
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
mode = _d({79,74,82,75},26)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({58,75,89,90,75,88,6,42,79,89,71,72,82,75,74},26))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({58,75,89,90,75,88,6,43,84,71,72,82,75,74,20,6,51,85,74,75,32},26), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({54,82,71,95,75,88,6,74,79,75,74,7,6,42,79,89,71,72,82,79,84,77,6,72,85,90,20},26))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({78,85,92,75,88},26) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({74,85,74,77,75},26) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({89,87,91,71,88,75,69,74,85,74,77,75},26) then
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
local playerGui = LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({53,92,75,88,93,85,88,82,74,58,75,89,90,45,91,79},26))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({57,73,88,75,75,84,45,91,79},26))
screenGui.Name = _d({53,92,75,88,93,85,88,82,74,58,75,89,90,45,91,79},26)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({44,88,71,83,75},26))
frame.Name = _d({51,71,79,84,44,88,71,83,75},26)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({59,47,41,85,88,84,75,88},26))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({58,75,94,90,50,71,72,75,82},26))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({214,133,129,135,213,158,117,6,41,91,86,79,74,6,43,84,77,79,84,75,6,53,92,75,88,93,85,88,82,74,6,58,75,89,90},26)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({58,75,94,90,50,71,72,75,82},26))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({57,90,71,90,91,89,32,6,47,74,82,75},26)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({58,75,94,90,40,91,90,90,85,84},26))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({59,47,41,85,88,84,75,88},26), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({58,75,94,90,40,85,94},26))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({59,47,41,85,88,84,75,88},26), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({46,85,92,75,88,6,39,72,85,92,75,6,58,71,88,77,75,90},26), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({78,85,92,75,88},26))
statusLabel.Text = _d({57,90,71,90,91,89,32,6,46,85,92,75,88,79,84,77,6},26) .. val .. _d({6,89,90,91,74,89,6,91,86},26)
end)
createInputBtn(_d({42,85,74,77,75,6,41,82,79,83,72},26), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({74,85,74,77,75},26))
statusLabel.Text = _d({57,90,71,90,91,89,32,6,42,85,74,77,75,19,78,85,82,74,79,84,77,6,14},26) .. val .. _d({6,89,90,91,74,89,15},26)
end)
createInputBtn(_d({58,75,89,90,6,57,87,91,71,88,75,6,42,85,74,77,75},26), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({89,87,91,71,88,75,69,74,85,74,77,75},26))
statusLabel.Text = _d({57,90,71,90,91,89,32,6,57,87,91,71,88,75,6,61,71,82,81,79,84,77,6,14},26) .. val .. _d({6,89,90,91,74,89,15},26)
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
while enabled and mode == _d({89,87,91,71,88,75,69,74,85,74,77,75},26) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({89,87,91,71,88,75,69,74,85,74,77,75},26) then
disableBot()
statusLabel.Text = _d({57,90,71,90,91,89,32,6,47,74,82,75,6,14,57,87,91,71,88,75,6,74,85,74,77,75,6,74,85,84,75,15},26)
end
end)
end)
local stopBtn = Instance.new(_d({58,75,94,90,40,91,90,90,85,84},26))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({43,51,43,56,45,43,52,41,63,6,57,58,53,54},26)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({59,47,41,85,88,84,75,88},26), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({57,90,71,90,91,89,32,6,57,58,53,54,54,43,42,6,14,47,74,82,75,15},26)
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({65,53,92,75,88,93,85,88,82,74,58,75,89,90,75,88,67,6,50,85,71,74,75,74,6,89,91,73,73,75,89,89,76,91,82,82,95,20},26))
end)()