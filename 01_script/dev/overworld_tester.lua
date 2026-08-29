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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({87,82,90,83},18)
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
print(_d({73,61,100,83,96,101,93,96,90,82,66,83,97,98,83,96,75},18), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
end
debug(_d({52,87,96,83,82,14,53,83,94,94,93,14,64,83,91,93,98,83},18))
end)
if not ok then debug(_d({87,92,100,93,89,83,53,83,94,94,93,14,83,96,96,93,96,40},18), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({77,77,66,83,97,98,54,93,100,83,96,47,98,98},18)) or Instance.new(_d({47,98,98,79,81,86,91,83,92,98},18))
att.Name = _d({77,77,66,83,97,98,54,93,100,83,96,47,98,98},18)
att.Parent = root
local force = root:FindFirstChild(_d({77,77,66,83,97,98,54,93,100,83,96,52,93,96,81,83},18))
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = _d({77,77,66,83,97,98,54,93,100,83,96,52,93,96,81,83},18)
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
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local force = root:FindFirstChild(_d({77,77,66,83,97,98,54,93,100,83,96,52,93,96,81,83},18))
local att   = root:FindFirstChild(_d({77,77,66,83,97,98,54,93,100,83,96,47,98,98},18))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({69,79,90,89,87,92,85,14,98,93,40},18), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({101,79,90,89,66,93,62,93,87,92,98,14,69,14,82,93,101,92,14,83,96,96,93,96,40},18), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({47,96,96,87,100,83,82,14,79,98,40},18), pos)
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
if item:IsA(_d({59,93,82,83,90},18)) and item:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18)) and item:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 then
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
mode = _d({87,82,90,83},18)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({66,83,97,98,83,96,14,50,87,97,79,80,90,83,82},18))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({66,83,97,98,83,96,14,51,92,79,80,90,83,82,28,14,59,93,82,83,40},18), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({62,90,79,103,83,96,14,82,87,83,82,15,14,50,87,97,79,80,90,87,92,85,14,80,93,98,28},18))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({86,93,100,83,96},18) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({82,93,82,85,83},18) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({97,95,99,79,96,83,77,82,93,82,85,83},18) then
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
local playerGui = LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({61,100,83,96,101,93,96,90,82,66,83,97,98,53,99,87},18))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({65,81,96,83,83,92,53,99,87},18))
screenGui.Name = _d({61,100,83,96,101,93,96,90,82,66,83,97,98,53,99,87},18)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({52,96,79,91,83},18))
frame.Name = _d({59,79,87,92,52,96,79,91,83},18)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({67,55,49,93,96,92,83,96},18))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({66,83,102,98,58,79,80,83,90},18))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({222,141,137,143,221,166,125,14,49,99,94,87,82,14,51,92,85,87,92,83,14,61,100,83,96,101,93,96,90,82,14,66,83,97,98},18)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({66,83,102,98,58,79,80,83,90},18))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({65,98,79,98,99,97,40,14,55,82,90,83},18)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({67,55,49,93,96,92,83,96},18), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({66,83,102,98,48,93,102},18))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({67,55,49,93,96,92,83,96},18), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({54,93,100,83,96,14,47,80,93,100,83,14,66,79,96,85,83,98},18), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({86,93,100,83,96},18))
statusLabel.Text = _d({65,98,79,98,99,97,40,14,54,93,100,83,96,87,92,85,14},18) .. val .. _d({14,97,98,99,82,97,14,99,94},18)
end)
createInputBtn(_d({50,93,82,85,83,14,49,90,87,91,80},18), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({82,93,82,85,83},18))
statusLabel.Text = _d({65,98,79,98,99,97,40,14,50,93,82,85,83,27,86,93,90,82,87,92,85,14,22},18) .. val .. _d({14,97,98,99,82,97,23},18)
end)
createInputBtn(_d({66,83,97,98,14,65,95,99,79,96,83,14,50,93,82,85,83},18), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({97,95,99,79,96,83,77,82,93,82,85,83},18))
statusLabel.Text = _d({65,98,79,98,99,97,40,14,65,95,99,79,96,83,14,69,79,90,89,87,92,85,14,22},18) .. val .. _d({14,97,98,99,82,97,23},18)
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
while enabled and mode == _d({97,95,99,79,96,83,77,82,93,82,85,83},18) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({97,95,99,79,96,83,77,82,93,82,85,83},18) then
disableBot()
statusLabel.Text = _d({65,98,79,98,99,97,40,14,55,82,90,83,14,22,65,95,99,79,96,83,14,82,93,82,85,83,14,82,93,92,83,23},18)
end
end)
end)
local stopBtn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({51,59,51,64,53,51,60,49,71,14,65,66,61,62},18)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({67,55,49,93,96,92,83,96},18), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({65,98,79,98,99,97,40,14,65,66,61,62,62,51,50,14,22,55,82,90,83,23},18)
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({73,61,100,83,96,101,93,96,90,82,66,83,97,98,83,96,75,14,58,93,79,82,83,82,14,97,99,81,81,83,97,97,84,99,90,90,103,28},18))
end)()