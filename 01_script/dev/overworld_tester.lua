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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local UserInputService = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({59,54,62,55},46)
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
print(_d({45,33,72,55,68,73,65,68,62,54,38,55,69,70,55,68,47},46), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({37,70,51,70,69},46) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({36,65,61,71,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,55,66,66,65},46), args)
elseif style == _d({20,62,51,53,61,30,55,57},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61},46), args)
elseif style == _d({29,51,63,59,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,51,63,59,69,58,59,61,59,25,55,66,66,65},46), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61,4},46), args)
end
debug(_d({24,59,68,55,54,242,25,55,66,66,65,242,36,55,63,65,70,55},46))
end)
if not ok then debug(_d({59,64,72,65,61,55,25,55,66,66,65,242,55,68,68,65,68,12},46), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({49,49,38,55,69,70,26,65,72,55,68,19,70,70},46)) or Instance.new(_d({19,70,70,51,53,58,63,55,64,70},46))
att.Name = _d({49,49,38,55,69,70,26,65,72,55,68,19,70,70},46)
att.Parent = root
local force = root:FindFirstChild(_d({49,49,38,55,69,70,26,65,72,55,68,24,65,68,53,55},46))
if not force then
force = Instance.new(_d({30,59,64,55,51,68,40,55,62,65,53,59,70,75},46))
force.Name = _d({49,49,38,55,69,70,26,65,72,55,68,24,65,68,53,55},46)
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
local root = char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not root then return end
local force = root:FindFirstChild(_d({49,49,38,55,69,70,26,65,72,55,68,24,65,68,53,55},46))
local att   = root:FindFirstChild(_d({49,49,38,55,69,70,26,65,72,55,68,19,70,70},46))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({41,51,62,61,59,64,57,242,70,65,12},46), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({73,51,62,61,38,65,34,65,59,64,70,242,41,242,54,65,73,64,242,55,68,68,65,68,12},46), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({19,68,68,59,72,55,54,242,51,70,12},46), pos)
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
if item:IsA(_d({31,65,54,55,62},46)) and item:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46)) and item:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)).Health > 0 then
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
mode = _d({59,54,62,55},46)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({38,55,69,70,55,68,242,22,59,69,51,52,62,55,54},46))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({38,55,69,70,55,68,242,23,64,51,52,62,55,54,0,242,31,65,54,55,12},46), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({34,62,51,75,55,68,242,54,59,55,54,243,242,22,59,69,51,52,62,59,64,57,242,52,65,70,0},46))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({58,65,72,55,68},46) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({54,65,54,57,55},46) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({69,67,71,51,68,55,49,54,65,54,57,55},46) then
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
local playerGui = LocalPlayer:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({33,72,55,68,73,65,68,62,54,38,55,69,70,25,71,59},46))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({37,53,68,55,55,64,25,71,59},46))
screenGui.Name = _d({33,72,55,68,73,65,68,62,54,38,55,69,70,25,71,59},46)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({24,68,51,63,55},46))
frame.Name = _d({31,51,59,64,24,68,51,63,55},46)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({39,27,21,65,68,64,55,68},46))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({38,55,74,70,30,51,52,55,62},46))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({194,113,109,115,193,138,97,242,21,71,66,59,54,242,23,64,57,59,64,55,242,33,72,55,68,73,65,68,62,54,242,38,55,69,70},46)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({38,55,74,70,30,51,52,55,62},46))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({37,70,51,70,71,69,12,242,27,54,62,55},46)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({38,55,74,70,20,71,70,70,65,64},46))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({39,27,21,65,68,64,55,68},46), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({38,55,74,70,20,65,74},46))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({39,27,21,65,68,64,55,68},46), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({26,65,72,55,68,242,19,52,65,72,55,242,38,51,68,57,55,70},46), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({58,65,72,55,68},46))
statusLabel.Text = _d({37,70,51,70,71,69,12,242,26,65,72,55,68,59,64,57,242},46) .. val .. _d({242,69,70,71,54,69,242,71,66},46)
end)
createInputBtn(_d({22,65,54,57,55,242,21,62,59,63,52},46), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({54,65,54,57,55},46))
statusLabel.Text = _d({37,70,51,70,71,69,12,242,22,65,54,57,55,255,58,65,62,54,59,64,57,242,250},46) .. val .. _d({242,69,70,71,54,69,251},46)
end)
createInputBtn(_d({38,55,69,70,242,37,67,71,51,68,55,242,22,65,54,57,55},46), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({69,67,71,51,68,55,49,54,65,54,57,55},46))
statusLabel.Text = _d({37,70,51,70,71,69,12,242,37,67,71,51,68,55,242,41,51,62,61,59,64,57,242,250},46) .. val .. _d({242,69,70,71,54,69,251},46)
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
while enabled and mode == _d({69,67,71,51,68,55,49,54,65,54,57,55},46) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({69,67,71,51,68,55,49,54,65,54,57,55},46) then
disableBot()
statusLabel.Text = _d({37,70,51,70,71,69,12,242,27,54,62,55,242,250,37,67,71,51,68,55,242,54,65,54,57,55,242,54,65,64,55,251},46)
end
end)
end)
local stopBtn = Instance.new(_d({38,55,74,70,20,71,70,70,65,64},46))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({23,31,23,36,25,23,32,21,43,242,37,38,33,34},46)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({39,27,21,65,68,64,55,68},46), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({37,70,51,70,71,69,12,242,37,38,33,34,34,23,22,242,250,27,54,62,55,251},46)
local VIM = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({45,33,72,55,68,73,65,68,62,54,38,55,69,70,55,68,47,242,30,65,51,54,55,54,242,69,71,53,53,55,69,69,56,71,62,62,75,0},46))
end)()