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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({48,43,51,44},57)
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
print(_d({34,22,61,44,57,62,54,57,51,43,27,44,58,59,44,57,36},57), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then
return
end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then
return
end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
if not statsFolder then
return
end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = { char = char, cf = cf }
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
debug(_d({13,48,57,44,43,231,14,44,55,55,54,231,25,44,52,54,59,44},57))
end)
if not ok then
debug(_d({48,53,61,54,50,44,14,44,55,55,54,231,44,57,57,54,57,1},57), err)
end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57)) or Instance.new(_d({8,59,59,40,42,47,52,44,53,59},57))
att.Name = _d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then
return result
end
return nil
end
local function cleanupForce()
pcall(function()
local char = LocalPlayer.Character
if not char then
return
end
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then
return
end
local force = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57))
local att = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end)
end
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
debug(_d({30,40,51,50,48,53,46,231,59,54,1},57), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then
debug(_d({62,40,51,50,27,54,23,54,48,53,59,231,30,231,43,54,62,53,231,44,57,57,54,57,1},57), err)
end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then
break
end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({8,57,57,48,61,44,43,231,40,59,1},57), pos)
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Workspace.CurrentCamera.CFrame = CFrame.lookAt(
Workspace.CurrentCamera.CFrame.Position,
currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
)
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
if not root then
return nil
end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if
item:IsA(_d({20,54,43,44,51},57))
and item:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
and item:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57)).Health > 0 then
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
if fwdFlat.Magnitude < 0.01 then
fwdFlat = Vector3.new(0, 0, 1)
end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function disableBot()
if not enabled then
return
end
enabled = false
mode = _d({48,43,51,44},57)
if navConn then
navConn:Disconnect()
navConn = nil
end
cleanupForce()
debug(_d({27,44,58,59,44,57,231,11,48,58,40,41,51,44,43},57))
end
local function enableBot(targetMode)
if enabled then
disableBot()
end
enabled = true
mode = targetMode
debug(_d({27,44,58,59,44,57,231,12,53,40,41,51,44,43,245,231,20,54,43,44,1},57), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({23,51,40,64,44,57,231,43,48,44,43,232,231,11,48,58,40,41,51,48,53,46,231,41,54,59,245},57))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({47,54,61,44,57},57) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({43,54,43,46,44},57) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({58,56,60,40,57,44,38,43,54,43,46,44},57) then
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
local playerGui = LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
if not playerGui then
return
end
local existingGui = playerGui:FindFirstChild(_d({22,61,44,57,62,54,57,51,43,27,44,58,59,14,60,48},57))
if existingGui then
existingGui:Destroy()
end
local screenGui = Instance.new(_d({26,42,57,44,44,53,14,60,48},57))
screenGui.Name = _d({22,61,44,57,62,54,57,51,43,27,44,58,59,14,60,48},57)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({13,57,40,52,44},57))
frame.Name = _d({20,40,48,53,13,57,40,52,44},57)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({28,16,10,54,57,53,44,57},57))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({27,44,63,59,19,40,41,44,51},57))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({183,102,98,104,182,127,86,231,10,60,55,48,43,231,12,53,46,48,53,44,231,22,61,44,57,62,54,57,51,43,231,27,44,58,59},57)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({27,44,63,59,19,40,41,44,51},57))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({26,59,40,59,60,58,1,231,16,43,51,44},57)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({27,44,63,59,9,60,59,59,54,53},57))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({28,16,10,54,57,53,44,57},57), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({27,44,63,59,9,54,63},57))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1, 1, 1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({28,16,10,54,57,53,44,57},57), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({15,54,61,44,57,231,8,41,54,61,44,231,27,40,57,46,44,59},57), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({47,54,61,44,57},57))
statusLabel.Text = _d({26,59,40,59,60,58,1,231,15,54,61,44,57,48,53,46,231},57) .. val .. _d({231,58,59,60,43,58,231,60,55},57)
end)
createInputBtn(_d({11,54,43,46,44,231,10,51,48,52,41},57), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({43,54,43,46,44},57))
statusLabel.Text = _d({26,59,40,59,60,58,1,231,11,54,43,46,44,244,47,54,51,43,48,53,46,231,239},57) .. val .. _d({231,58,59,60,43,58,240},57)
end)
createInputBtn(_d({27,44,58,59,231,26,56,60,40,57,44,231,11,54,43,46,44},57), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({58,56,60,40,57,44,38,43,54,43,46,44},57))
statusLabel.Text = _d({26,59,40,59,60,58,1,231,26,56,60,40,57,44,231,30,40,51,50,48,53,46,231,239},57) .. val .. _d({231,58,59,60,43,58,240},57)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local center = root.Position
local d = val
local corners = {
center + Vector3.new(d, 0, d),
center + Vector3.new(-d, 0, d),
center + Vector3.new(-d, 0, -d),
center + Vector3.new(d, 0, -d),
}
local startT = tick()
local cornerIdx = 1
while enabled and mode == _d({58,56,60,40,57,44,38,43,54,43,46,44},57) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({58,56,60,40,57,44,38,43,54,43,46,44},57) then
disableBot()
statusLabel.Text = _d({26,59,40,59,60,58,1,231,16,43,51,44,231,239,26,56,60,40,57,44,231,43,54,43,46,44,231,43,54,53,44,240},57)
end
end)
end)
local stopBtn = Instance.new(_d({27,44,63,59,9,60,59,59,54,53},57))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({12,20,12,25,14,12,21,10,32,231,26,27,22,23},57)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({28,16,10,54,57,53,44,57},57), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({26,59,40,59,60,58,1,231,26,27,22,23,23,12,11,231,239,16,43,51,44,240},57)
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({34,22,61,44,57,62,54,57,51,43,27,44,58,59,44,57,36,231,19,54,40,43,44,43,231,58,60,42,42,44,58,58,45,60,51,51,64,245},57))
end)()