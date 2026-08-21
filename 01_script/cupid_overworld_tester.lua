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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({64,59,67,60},41)
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
print(_d({50,38,77,60,73,78,70,73,67,59,43,60,74,75,60,73,52},41), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({41,70,66,76,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,60,71,71,70},41), args)
elseif style == _d({25,67,56,58,66,35,60,62},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66},41), args)
elseif style == _d({34,56,68,64,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,56,68,64,74,63,64,66,64,30,60,71,71,70},41), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66,9},41), args)
end
debug(_d({29,64,73,60,59,247,30,60,71,71,70,247,41,60,68,70,75,60},41))
end)
if not ok then debug(_d({64,69,77,70,66,60,30,60,71,71,70,247,60,73,73,70,73,17},41), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({54,54,43,60,74,75,31,70,77,60,73,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,43,60,74,75,31,70,77,60,73,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,43,60,74,75,31,70,77,60,73,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,43,60,74,75,31,70,77,60,73,29,70,73,58,60},41)
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
local root = char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not root then return end
local force = root:FindFirstChild(_d({54,54,43,60,74,75,31,70,77,60,73,29,70,73,58,60},41))
local att   = root:FindFirstChild(_d({54,54,43,60,74,75,31,70,77,60,73,24,75,75},41))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({46,56,67,66,64,69,62,247,75,70,17},41), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({78,56,67,66,43,70,39,70,64,69,75,247,46,247,59,70,78,69,247,60,73,73,70,73,17},41), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({24,73,73,64,77,60,59,247,56,75,17},41), pos)
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
if item:IsA(_d({36,70,59,60,67},41)) and item:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41)) and item:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
mode = _d({64,59,67,60},41)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({43,60,74,75,60,73,247,27,64,74,56,57,67,60,59},41))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({43,60,74,75,60,73,247,28,69,56,57,67,60,59,5,247,36,70,59,60,17},41), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({39,67,56,80,60,73,247,59,64,60,59,248,247,27,64,74,56,57,67,64,69,62,247,57,70,75,5},41))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({63,70,77,60,73},41) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({59,70,59,62,60},41) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({74,72,76,56,73,60,54,59,70,59,62,60},41) then
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
local playerGui = LocalPlayer:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({38,77,60,73,78,70,73,67,59,43,60,74,75,30,76,64},41))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({42,58,73,60,60,69,30,76,64},41))
screenGui.Name = _d({38,77,60,73,78,70,73,67,59,43,60,74,75,30,76,64},41)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({29,73,56,68,60},41))
frame.Name = _d({36,56,64,69,29,73,56,68,60},41)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({44,32,26,70,73,69,60,73},41))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({43,60,79,75,35,56,57,60,67},41))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({199,118,114,120,198,143,102,247,26,76,71,64,59,247,28,69,62,64,69,60,247,38,77,60,73,78,70,73,67,59,247,43,60,74,75},41)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({43,60,79,75,35,56,57,60,67},41))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({42,75,56,75,76,74,17,247,32,59,67,60},41)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({44,32,26,70,73,69,60,73},41), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({43,60,79,75,25,70,79},41))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({44,32,26,70,73,69,60,73},41), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({31,70,77,60,73,247,24,57,70,77,60,247,43,56,73,62,60,75},41), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({63,70,77,60,73},41))
statusLabel.Text = _d({42,75,56,75,76,74,17,247,31,70,77,60,73,64,69,62,247},41) .. val .. _d({247,74,75,76,59,74,247,76,71},41)
end)
createInputBtn(_d({27,70,59,62,60,247,26,67,64,68,57},41), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({59,70,59,62,60},41))
statusLabel.Text = _d({42,75,56,75,76,74,17,247,27,70,59,62,60,4,63,70,67,59,64,69,62,247,255},41) .. val .. _d({247,74,75,76,59,74,0},41)
end)
createInputBtn(_d({43,60,74,75,247,42,72,76,56,73,60,247,27,70,59,62,60},41), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({74,72,76,56,73,60,54,59,70,59,62,60},41))
statusLabel.Text = _d({42,75,56,75,76,74,17,247,42,72,76,56,73,60,247,46,56,67,66,64,69,62,247,255},41) .. val .. _d({247,74,75,76,59,74,0},41)
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
while enabled and mode == _d({74,72,76,56,73,60,54,59,70,59,62,60},41) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({74,72,76,56,73,60,54,59,70,59,62,60},41) then
disableBot()
statusLabel.Text = _d({42,75,56,75,76,74,17,247,32,59,67,60,247,255,42,72,76,56,73,60,247,59,70,59,62,60,247,59,70,69,60,0},41)
end
end)
end)
local stopBtn = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({28,36,28,41,30,28,37,26,48,247,42,43,38,39},41)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({44,32,26,70,73,69,60,73},41), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({42,75,56,75,76,74,17,247,42,43,38,39,39,28,27,247,255,32,59,67,60,0},41)
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({50,38,77,60,73,78,70,73,67,59,43,60,74,75,60,73,52,247,35,70,56,59,60,59,247,74,76,58,58,60,74,74,61,76,67,67,80,5},41))
end)()