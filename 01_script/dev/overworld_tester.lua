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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local RunService = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local UserInputService = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
local ReplicatedStorage = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({61,56,64,57},44)
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
print(_d({47,35,74,57,70,75,67,70,64,56,40,57,71,72,57,70,49},44), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({39,72,53,72,71},44) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({38,67,63,73,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,57,68,68,67},44), args)
elseif style == _d({22,64,53,55,63,32,57,59},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63},44), args)
elseif style == _d({31,53,65,61,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,53,65,61,71,60,61,63,61,27,57,68,68,67},44), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63,6},44), args)
end
debug(_d({26,61,70,57,56,244,27,57,68,68,67,244,38,57,65,67,72,57},44))
end)
if not ok then debug(_d({61,66,74,67,63,57,27,57,68,68,67,244,57,70,70,67,70,14},44), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({51,51,40,57,71,72,28,67,74,57,70,21,72,72},44)) or Instance.new(_d({21,72,72,53,55,60,65,57,66,72},44))
att.Name = _d({51,51,40,57,71,72,28,67,74,57,70,21,72,72},44)
att.Parent = root
local force = root:FindFirstChild(_d({51,51,40,57,71,72,28,67,74,57,70,26,67,70,55,57},44))
if not force then
force = Instance.new(_d({32,61,66,57,53,70,42,57,64,67,55,61,72,77},44))
force.Name = _d({51,51,40,57,71,72,28,67,74,57,70,26,67,70,55,57},44)
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
local root = char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if not root then return end
local force = root:FindFirstChild(_d({51,51,40,57,71,72,28,67,74,57,70,26,67,70,55,57},44))
local att   = root:FindFirstChild(_d({51,51,40,57,71,72,28,67,74,57,70,21,72,72},44))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({42,61,70,72,73,53,64,29,66,68,73,72,33,53,66,53,59,57,70},44))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({43,53,64,63,61,66,59,244,72,67,14},44), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({75,53,64,63,40,67,36,67,61,66,72,244,43,244,56,67,75,66,244,57,70,70,67,70,14},44), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({21,70,70,61,74,57,56,244,53,72,14},44), pos)
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
if item:IsA(_d({33,67,56,57,64},44)) and item:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44)) and item:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)).Health > 0 then
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
mode = _d({61,56,64,57},44)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({40,57,71,72,57,70,244,24,61,71,53,54,64,57,56},44))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({40,57,71,72,57,70,244,25,66,53,54,64,57,56,2,244,33,67,56,57,14},44), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({36,64,53,77,57,70,244,56,61,57,56,245,244,24,61,71,53,54,64,61,66,59,244,54,67,72,2},44))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({60,67,74,57,70},44) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({56,67,56,59,57},44) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({71,69,73,53,70,57,51,56,67,56,59,57},44) then
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
local playerGui = LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({35,74,57,70,75,67,70,64,56,40,57,71,72,27,73,61},44))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({39,55,70,57,57,66,27,73,61},44))
screenGui.Name = _d({35,74,57,70,75,67,70,64,56,40,57,71,72,27,73,61},44)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({26,70,53,65,57},44))
frame.Name = _d({33,53,61,66,26,70,53,65,57},44)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({41,29,23,67,70,66,57,70},44))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({196,115,111,117,195,140,99,244,23,73,68,61,56,244,25,66,59,61,66,57,244,35,74,57,70,75,67,70,64,56,244,40,57,71,72},44)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({40,57,76,72,32,53,54,57,64},44))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({39,72,53,72,73,71,14,244,29,56,64,57},44)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({41,29,23,67,70,66,57,70},44), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({40,57,76,72,22,67,76},44))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({41,29,23,67,70,66,57,70},44), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({28,67,74,57,70,244,21,54,67,74,57,244,40,53,70,59,57,72},44), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({60,67,74,57,70},44))
statusLabel.Text = _d({39,72,53,72,73,71,14,244,28,67,74,57,70,61,66,59,244},44) .. val .. _d({244,71,72,73,56,71,244,73,68},44)
end)
createInputBtn(_d({24,67,56,59,57,244,23,64,61,65,54},44), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({56,67,56,59,57},44))
statusLabel.Text = _d({39,72,53,72,73,71,14,244,24,67,56,59,57,1,60,67,64,56,61,66,59,244,252},44) .. val .. _d({244,71,72,73,56,71,253},44)
end)
createInputBtn(_d({40,57,71,72,244,39,69,73,53,70,57,244,24,67,56,59,57},44), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({71,69,73,53,70,57,51,56,67,56,59,57},44))
statusLabel.Text = _d({39,72,53,72,73,71,14,244,39,69,73,53,70,57,244,43,53,64,63,61,66,59,244,252},44) .. val .. _d({244,71,72,73,56,71,253},44)
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
while enabled and mode == _d({71,69,73,53,70,57,51,56,67,56,59,57},44) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({71,69,73,53,70,57,51,56,67,56,59,57},44) then
disableBot()
statusLabel.Text = _d({39,72,53,72,73,71,14,244,29,56,64,57,244,252,39,69,73,53,70,57,244,56,67,56,59,57,244,56,67,66,57,253},44)
end
end)
end)
local stopBtn = Instance.new(_d({40,57,76,72,22,73,72,72,67,66},44))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({25,33,25,38,27,25,34,23,45,244,39,40,35,36},44)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({41,29,23,67,70,66,57,70},44), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({39,72,53,72,73,71,14,244,39,40,35,36,36,25,24,244,252,29,56,64,57,253},44)
local VIM = game:GetService(_d({42,61,70,72,73,53,64,29,66,68,73,72,33,53,66,53,59,57,70},44))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({47,35,74,57,70,75,67,70,64,56,40,57,71,72,57,70,49,244,32,67,53,56,57,56,244,71,73,55,55,57,71,71,58,73,64,64,77,2},44))
end)()