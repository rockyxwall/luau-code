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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({66,61,69,62},39)
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
print(_d({52,40,79,62,75,80,72,75,69,61,45,62,76,77,62,75,54},39), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({43,72,68,78,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,62,73,73,72},39), args)
elseif style == _d({27,69,58,60,68,37,62,64},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68},39), args)
elseif style == _d({36,58,70,66,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,58,70,66,76,65,66,68,66,32,62,73,73,72},39), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68,11},39), args)
end
debug(_d({31,66,75,62,61,249,32,62,73,73,72,249,43,62,70,72,77,62},39))
end)
if not ok then debug(_d({66,71,79,72,68,62,32,62,73,73,72,249,62,75,75,72,75,19},39), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({56,56,45,62,76,77,33,72,79,62,75,26,77,77},39)) or Instance.new(_d({26,77,77,58,60,65,70,62,71,77},39))
att.Name = _d({56,56,45,62,76,77,33,72,79,62,75,26,77,77},39)
att.Parent = root
local force = root:FindFirstChild(_d({56,56,45,62,76,77,33,72,79,62,75,31,72,75,60,62},39))
if not force then
force = Instance.new(_d({37,66,71,62,58,75,47,62,69,72,60,66,77,82},39))
force.Name = _d({56,56,45,62,76,77,33,72,79,62,75,31,72,75,60,62},39)
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
local root = char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not root then return end
local force = root:FindFirstChild(_d({56,56,45,62,76,77,33,72,79,62,75,31,72,75,60,62},39))
local att   = root:FindFirstChild(_d({56,56,45,62,76,77,33,72,79,62,75,26,77,77},39))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({48,58,69,68,66,71,64,249,77,72,19},39), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({80,58,69,68,45,72,41,72,66,71,77,249,48,249,61,72,80,71,249,62,75,75,72,75,19},39), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({26,75,75,66,79,62,61,249,58,77,19},39), pos)
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
if item:IsA(_d({38,72,61,62,69},39)) and item:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39)) and item:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)).Health > 0 then
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
mode = _d({66,61,69,62},39)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({45,62,76,77,62,75,249,29,66,76,58,59,69,62,61},39))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({45,62,76,77,62,75,249,30,71,58,59,69,62,61,7,249,38,72,61,62,19},39), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({41,69,58,82,62,75,249,61,66,62,61,250,249,29,66,76,58,59,69,66,71,64,249,59,72,77,7},39))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({65,72,79,62,75},39) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({61,72,61,64,62},39) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({76,74,78,58,75,62,56,61,72,61,64,62},39) then
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
local playerGui = LocalPlayer:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({40,79,62,75,80,72,75,69,61,45,62,76,77,32,78,66},39))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({44,60,75,62,62,71,32,78,66},39))
screenGui.Name = _d({40,79,62,75,80,72,75,69,61,45,62,76,77,32,78,66},39)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({31,75,58,70,62},39))
frame.Name = _d({38,58,66,71,31,75,58,70,62},39)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({46,34,28,72,75,71,62,75},39))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({45,62,81,77,37,58,59,62,69},39))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({201,120,116,122,200,145,104,249,28,78,73,66,61,249,30,71,64,66,71,62,249,40,79,62,75,80,72,75,69,61,249,45,62,76,77},39)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({45,62,81,77,37,58,59,62,69},39))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({44,77,58,77,78,76,19,249,34,61,69,62},39)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({45,62,81,77,27,78,77,77,72,71},39))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({46,34,28,72,75,71,62,75},39), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({45,62,81,77,27,72,81},39))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({46,34,28,72,75,71,62,75},39), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({33,72,79,62,75,249,26,59,72,79,62,249,45,58,75,64,62,77},39), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({65,72,79,62,75},39))
statusLabel.Text = _d({44,77,58,77,78,76,19,249,33,72,79,62,75,66,71,64,249},39) .. val .. _d({249,76,77,78,61,76,249,78,73},39)
end)
createInputBtn(_d({29,72,61,64,62,249,28,69,66,70,59},39), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({61,72,61,64,62},39))
statusLabel.Text = _d({44,77,58,77,78,76,19,249,29,72,61,64,62,6,65,72,69,61,66,71,64,249,1},39) .. val .. _d({249,76,77,78,61,76,2},39)
end)
createInputBtn(_d({45,62,76,77,249,44,74,78,58,75,62,249,29,72,61,64,62},39), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({76,74,78,58,75,62,56,61,72,61,64,62},39))
statusLabel.Text = _d({44,77,58,77,78,76,19,249,44,74,78,58,75,62,249,48,58,69,68,66,71,64,249,1},39) .. val .. _d({249,76,77,78,61,76,2},39)
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
while enabled and mode == _d({76,74,78,58,75,62,56,61,72,61,64,62},39) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({76,74,78,58,75,62,56,61,72,61,64,62},39) then
disableBot()
statusLabel.Text = _d({44,77,58,77,78,76,19,249,34,61,69,62,249,1,44,74,78,58,75,62,249,61,72,61,64,62,249,61,72,71,62,2},39)
end
end)
end)
local stopBtn = Instance.new(_d({45,62,81,77,27,78,77,77,72,71},39))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({30,38,30,43,32,30,39,28,50,249,44,45,40,41},39)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({46,34,28,72,75,71,62,75},39), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({44,77,58,77,78,76,19,249,44,45,40,41,41,30,29,249,1,34,61,69,62,2},39)
local VIM = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({52,40,79,62,75,80,72,75,69,61,45,62,76,77,62,75,54,249,37,72,58,61,62,61,249,76,78,60,60,62,76,76,63,78,69,69,82,7},39))
end)()