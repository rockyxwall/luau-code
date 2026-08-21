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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local UserInputService = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({63,58,66,59},42)
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
print(_d({49,37,76,59,72,77,69,72,66,58,42,59,73,74,59,72,51},42), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({40,69,65,75,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,59,70,70,69},42), args)
elseif style == _d({24,66,55,57,65,34,59,61},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65},42), args)
elseif style == _d({33,55,67,63,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,55,67,63,73,62,63,65,63,29,59,70,70,69},42), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65,8},42), args)
end
debug(_d({28,63,72,59,58,246,29,59,70,70,69,246,40,59,67,69,74,59},42))
end)
if not ok then debug(_d({63,68,76,69,65,59,29,59,70,70,69,246,59,72,72,69,72,16},42), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({53,53,42,59,73,74,30,69,76,59,72,23,74,74},42)) or Instance.new(_d({23,74,74,55,57,62,67,59,68,74},42))
att.Name = _d({53,53,42,59,73,74,30,69,76,59,72,23,74,74},42)
att.Parent = root
local force = root:FindFirstChild(_d({53,53,42,59,73,74,30,69,76,59,72,28,69,72,57,59},42))
if not force then
force = Instance.new(_d({34,63,68,59,55,72,44,59,66,69,57,63,74,79},42))
force.Name = _d({53,53,42,59,73,74,30,69,76,59,72,28,69,72,57,59},42)
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
local root = char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not root then return end
local force = root:FindFirstChild(_d({53,53,42,59,73,74,30,69,76,59,72,28,69,72,57,59},42))
local att   = root:FindFirstChild(_d({53,53,42,59,73,74,30,69,76,59,72,23,74,74},42))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({45,55,66,65,63,68,61,246,74,69,16},42), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({77,55,66,65,42,69,38,69,63,68,74,246,45,246,58,69,77,68,246,59,72,72,69,72,16},42), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({23,72,72,63,76,59,58,246,55,74,16},42), pos)
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
if item:IsA(_d({35,69,58,59,66},42)) and item:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42)) and item:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health > 0 then
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
mode = _d({63,58,66,59},42)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({42,59,73,74,59,72,246,26,63,73,55,56,66,59,58},42))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({42,59,73,74,59,72,246,27,68,55,56,66,59,58,4,246,35,69,58,59,16},42), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({38,66,55,79,59,72,246,58,63,59,58,247,246,26,63,73,55,56,66,63,68,61,246,56,69,74,4},42))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({62,69,76,59,72},42) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({58,69,58,61,59},42) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({73,71,75,55,72,59,53,58,69,58,61,59},42) then
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
local playerGui = LocalPlayer:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({37,76,59,72,77,69,72,66,58,42,59,73,74,29,75,63},42))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({41,57,72,59,59,68,29,75,63},42))
screenGui.Name = _d({37,76,59,72,77,69,72,66,58,42,59,73,74,29,75,63},42)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({28,72,55,67,59},42))
frame.Name = _d({35,55,63,68,28,72,55,67,59},42)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({43,31,25,69,72,68,59,72},42))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({42,59,78,74,34,55,56,59,66},42))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({198,117,113,119,197,142,101,246,25,75,70,63,58,246,27,68,61,63,68,59,246,37,76,59,72,77,69,72,66,58,246,42,59,73,74},42)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({42,59,78,74,34,55,56,59,66},42))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({41,74,55,74,75,73,16,246,31,58,66,59},42)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({42,59,78,74,24,75,74,74,69,68},42))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({43,31,25,69,72,68,59,72},42), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({42,59,78,74,24,69,78},42))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({43,31,25,69,72,68,59,72},42), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({30,69,76,59,72,246,23,56,69,76,59,246,42,55,72,61,59,74},42), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({62,69,76,59,72},42))
statusLabel.Text = _d({41,74,55,74,75,73,16,246,30,69,76,59,72,63,68,61,246},42) .. val .. _d({246,73,74,75,58,73,246,75,70},42)
end)
createInputBtn(_d({26,69,58,61,59,246,25,66,63,67,56},42), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({58,69,58,61,59},42))
statusLabel.Text = _d({41,74,55,74,75,73,16,246,26,69,58,61,59,3,62,69,66,58,63,68,61,246,254},42) .. val .. _d({246,73,74,75,58,73,255},42)
end)
createInputBtn(_d({42,59,73,74,246,41,71,75,55,72,59,246,26,69,58,61,59},42), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({73,71,75,55,72,59,53,58,69,58,61,59},42))
statusLabel.Text = _d({41,74,55,74,75,73,16,246,41,71,75,55,72,59,246,45,55,66,65,63,68,61,246,254},42) .. val .. _d({246,73,74,75,58,73,255},42)
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
while enabled and mode == _d({73,71,75,55,72,59,53,58,69,58,61,59},42) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({73,71,75,55,72,59,53,58,69,58,61,59},42) then
disableBot()
statusLabel.Text = _d({41,74,55,74,75,73,16,246,31,58,66,59,246,254,41,71,75,55,72,59,246,58,69,58,61,59,246,58,69,68,59,255},42)
end
end)
end)
local stopBtn = Instance.new(_d({42,59,78,74,24,75,74,74,69,68},42))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({27,35,27,40,29,27,36,25,47,246,41,42,37,38},42)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({43,31,25,69,72,68,59,72},42), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({41,74,55,74,75,73,16,246,41,42,37,38,38,27,26,246,254,31,58,66,59,255},42)
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({49,37,76,59,72,77,69,72,66,58,42,59,73,74,59,72,51,246,34,69,55,58,59,58,246,73,75,57,57,59,73,73,60,75,66,66,79,4},42))
end)()