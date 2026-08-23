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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local RunService = game:GetService(_d({33,68,61,34,52,65,69,56,50,52},49))
local UserInputService = game:GetService(_d({36,66,52,65,24,61,63,68,67,34,52,65,69,56,50,52},49))
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({56,51,59,52},49)
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
print(_d({42,30,69,52,65,70,62,65,59,51,35,52,66,67,52,65,44},49), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({34,67,48,67,66},49) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({33,62,58,68,66,55,56,58,56},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,52,63,63,62},49), args)
elseif style == _d({17,59,48,50,58,27,52,54},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,58,72,239,38,48,59,58},49), args)
elseif style == _d({26,48,60,56,66,55,56,58,56},49) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,48,60,56,66,55,56,58,56,22,52,63,63,62},49), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,58,72,239,38,48,59,58,1},49), args)
end
debug(_d({21,56,65,52,51,239,22,52,63,63,62,239,33,52,60,62,67,52},49))
end)
if not ok then debug(_d({56,61,69,62,58,52,22,52,63,63,62,239,52,65,65,62,65,9},49), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({46,46,35,52,66,67,23,62,69,52,65,16,67,67},49)) or Instance.new(_d({16,67,67,48,50,55,60,52,61,67},49))
att.Name = _d({46,46,35,52,66,67,23,62,69,52,65,16,67,67},49)
att.Parent = root
local force = root:FindFirstChild(_d({46,46,35,52,66,67,23,62,69,52,65,21,62,65,50,52},49))
if not force then
force = Instance.new(_d({27,56,61,52,48,65,37,52,59,62,50,56,67,72},49))
force.Name = _d({46,46,35,52,66,67,23,62,69,52,65,21,62,65,50,52},49)
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
local root = char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
if not root then return end
local force = root:FindFirstChild(_d({46,46,35,52,66,67,23,62,69,52,65,21,62,65,50,52},49))
local att   = root:FindFirstChild(_d({46,46,35,52,66,67,23,62,69,52,65,16,67,67},49))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({37,56,65,67,68,48,59,24,61,63,68,67,28,48,61,48,54,52,65},49))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({38,48,59,58,56,61,54,239,67,62,9},49), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({70,48,59,58,35,62,31,62,56,61,67,239,38,239,51,62,70,61,239,52,65,65,62,65,9},49), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({16,65,65,56,69,52,51,239,48,67,9},49), pos)
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
if item:IsA(_d({28,62,51,52,59},49)) and item:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49)) and item:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({23,68,60,48,61,62,56,51},49)).Health > 0 then
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
mode = _d({56,51,59,52},49)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({35,52,66,67,52,65,239,19,56,66,48,49,59,52,51},49))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({35,52,66,67,52,65,239,20,61,48,49,59,52,51,253,239,28,62,51,52,9},49), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({31,59,48,72,52,65,239,51,56,52,51,240,239,19,56,66,48,49,59,56,61,54,239,49,62,67,253},49))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({55,62,69,52,65},49) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({51,62,51,54,52},49) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({66,64,68,48,65,52,46,51,62,51,54,52},49) then
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
local playerGui = LocalPlayer:WaitForChild(_d({31,59,48,72,52,65,22,68,56},49), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({30,69,52,65,70,62,65,59,51,35,52,66,67,22,68,56},49))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({34,50,65,52,52,61,22,68,56},49))
screenGui.Name = _d({30,69,52,65,70,62,65,59,51,35,52,66,67,22,68,56},49)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({21,65,48,60,52},49))
frame.Name = _d({28,48,56,61,21,65,48,60,52},49)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({36,24,18,62,65,61,52,65},49))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({35,52,71,67,27,48,49,52,59},49))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({191,110,106,112,190,135,94,239,18,68,63,56,51,239,20,61,54,56,61,52,239,30,69,52,65,70,62,65,59,51,239,35,52,66,67},49)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({35,52,71,67,27,48,49,52,59},49))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({34,67,48,67,68,66,9,239,24,51,59,52},49)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({35,52,71,67,17,68,67,67,62,61},49))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({36,24,18,62,65,61,52,65},49), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({35,52,71,67,17,62,71},49))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({36,24,18,62,65,61,52,65},49), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({23,62,69,52,65,239,16,49,62,69,52,239,35,48,65,54,52,67},49), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({55,62,69,52,65},49))
statusLabel.Text = _d({34,67,48,67,68,66,9,239,23,62,69,52,65,56,61,54,239},49) .. val .. _d({239,66,67,68,51,66,239,68,63},49)
end)
createInputBtn(_d({19,62,51,54,52,239,18,59,56,60,49},49), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({51,62,51,54,52},49))
statusLabel.Text = _d({34,67,48,67,68,66,9,239,19,62,51,54,52,252,55,62,59,51,56,61,54,239,247},49) .. val .. _d({239,66,67,68,51,66,248},49)
end)
createInputBtn(_d({35,52,66,67,239,34,64,68,48,65,52,239,19,62,51,54,52},49), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({66,64,68,48,65,52,46,51,62,51,54,52},49))
statusLabel.Text = _d({34,67,48,67,68,66,9,239,34,64,68,48,65,52,239,38,48,59,58,56,61,54,239,247},49) .. val .. _d({239,66,67,68,51,66,248},49)
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
while enabled and mode == _d({66,64,68,48,65,52,46,51,62,51,54,52},49) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({66,64,68,48,65,52,46,51,62,51,54,52},49) then
disableBot()
statusLabel.Text = _d({34,67,48,67,68,66,9,239,24,51,59,52,239,247,34,64,68,48,65,52,239,51,62,51,54,52,239,51,62,61,52,248},49)
end
end)
end)
local stopBtn = Instance.new(_d({35,52,71,67,17,68,67,67,62,61},49))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({20,28,20,33,22,20,29,18,40,239,34,35,30,31},49)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({36,24,18,62,65,61,52,65},49), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({34,67,48,67,68,66,9,239,34,35,30,31,31,20,19,239,247,24,51,59,52,248},49)
local VIM = game:GetService(_d({37,56,65,67,68,48,59,24,61,63,68,67,28,48,61,48,54,52,65},49))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({42,30,69,52,65,70,62,65,59,51,35,52,66,67,52,65,44,239,27,62,48,51,52,51,239,66,68,50,50,52,66,66,53,68,59,59,72,253},49))
end)()