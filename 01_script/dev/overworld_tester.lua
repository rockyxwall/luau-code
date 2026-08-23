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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({69,64,72,65},36)
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
print(_d({55,43,82,65,78,83,75,78,72,64,48,65,79,80,65,78,57},36), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
end
debug(_d({34,69,78,65,64,252,35,65,76,76,75,252,46,65,73,75,80,65},36))
end)
if not ok then debug(_d({69,74,82,75,71,65,35,65,76,76,75,252,65,78,78,75,78,22},36), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36)
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
local root = char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local force = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36))
local att   = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({51,61,72,71,69,74,67,252,80,75,22},36), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({83,61,72,71,48,75,44,75,69,74,80,252,51,252,64,75,83,74,252,65,78,78,75,78,22},36), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({29,78,78,69,82,65,64,252,61,80,22},36), pos)
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
if item:IsA(_d({41,75,64,65,72},36)) and item:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36)) and item:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 then
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
mode = _d({69,64,72,65},36)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({48,65,79,80,65,78,252,32,69,79,61,62,72,65,64},36))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({48,65,79,80,65,78,252,33,74,61,62,72,65,64,10,252,41,75,64,65,22},36), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({44,72,61,85,65,78,252,64,69,65,64,253,252,32,69,79,61,62,72,69,74,67,252,62,75,80,10},36))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({68,75,82,65,78},36) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({64,75,64,67,65},36) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) then
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
local playerGui = LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({43,82,65,78,83,75,78,72,64,48,65,79,80,35,81,69},36))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({47,63,78,65,65,74,35,81,69},36))
screenGui.Name = _d({43,82,65,78,83,75,78,72,64,48,65,79,80,35,81,69},36)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({34,78,61,73,65},36))
frame.Name = _d({41,61,69,74,34,78,61,73,65},36)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({49,37,31,75,78,74,65,78},36))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({204,123,119,125,203,148,107,252,31,81,76,69,64,252,33,74,67,69,74,65,252,43,82,65,78,83,75,78,72,64,252,48,65,79,80},36)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({47,80,61,80,81,79,22,252,37,64,72,65},36)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({48,65,84,80,30,75,84},36))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({36,75,82,65,78,252,29,62,75,82,65,252,48,61,78,67,65,80},36), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({68,75,82,65,78},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,36,75,82,65,78,69,74,67,252},36) .. val .. _d({252,79,80,81,64,79,252,81,76},36)
end)
createInputBtn(_d({32,75,64,67,65,252,31,72,69,73,62},36), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({64,75,64,67,65},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,32,75,64,67,65,9,68,75,72,64,69,74,67,252,4},36) .. val .. _d({252,79,80,81,64,79,5},36)
end)
createInputBtn(_d({48,65,79,80,252,47,77,81,61,78,65,252,32,75,64,67,65},36), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({79,77,81,61,78,65,59,64,75,64,67,65},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,47,77,81,61,78,65,252,51,61,72,71,69,74,67,252,4},36) .. val .. _d({252,79,80,81,64,79,5},36)
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
while enabled and mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) then
disableBot()
statusLabel.Text = _d({47,80,61,80,81,79,22,252,37,64,72,65,252,4,47,77,81,61,78,65,252,64,75,64,67,65,252,64,75,74,65,5},36)
end
end)
end)
local stopBtn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({33,41,33,46,35,33,42,31,53,252,47,48,43,44},36)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({47,80,61,80,81,79,22,252,47,48,43,44,44,33,32,252,4,37,64,72,65,5},36)
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({55,43,82,65,78,83,75,78,72,64,48,65,79,80,65,78,57,252,40,75,61,64,65,64,252,79,81,63,63,65,79,79,66,81,72,72,85,10},36))
end)()