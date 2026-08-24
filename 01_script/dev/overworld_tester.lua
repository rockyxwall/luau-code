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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({70,65,73,66},35)
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
print(_d({56,44,83,66,79,84,76,79,73,65,49,66,80,81,66,79,58},35), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({47,76,72,82,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,66,77,77,76},35), args)
elseif style == _d({31,73,62,64,72,41,66,68},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72},35), args)
elseif style == _d({40,62,74,70,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,62,74,70,80,69,70,72,70,36,66,77,77,76},35), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72,15},35), args)
end
debug(_d({35,70,79,66,65,253,36,66,77,77,76,253,47,66,74,76,81,66},35))
end)
if not ok then debug(_d({70,75,83,76,72,66,36,66,77,77,76,253,66,79,79,76,79,23},35), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35)
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
local root = char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local force = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35))
local att   = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({52,62,73,72,70,75,68,253,81,76,23},35), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({84,62,73,72,49,76,45,76,70,75,81,253,52,253,65,76,84,75,253,66,79,79,76,79,23},35), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({30,79,79,70,83,66,65,253,62,81,23},35), pos)
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
if item:IsA(_d({42,76,65,66,73},35)) and item:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35)) and item:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 then
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
mode = _d({70,65,73,66},35)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({49,66,80,81,66,79,253,33,70,80,62,63,73,66,65},35))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({49,66,80,81,66,79,253,34,75,62,63,73,66,65,11,253,42,76,65,66,23},35), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({45,73,62,86,66,79,253,65,70,66,65,254,253,33,70,80,62,63,73,70,75,68,253,63,76,81,11},35))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({69,76,83,66,79},35) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({65,76,65,68,66},35) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) then
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
local playerGui = LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({44,83,66,79,84,76,79,73,65,49,66,80,81,36,82,70},35))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({48,64,79,66,66,75,36,82,70},35))
screenGui.Name = _d({44,83,66,79,84,76,79,73,65,49,66,80,81,36,82,70},35)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({35,79,62,74,66},35))
frame.Name = _d({42,62,70,75,35,79,62,74,66},35)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({205,124,120,126,204,149,108,253,32,82,77,70,65,253,34,75,68,70,75,66,253,44,83,66,79,84,76,79,73,65,253,49,66,80,81},35)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({48,81,62,81,82,80,23,253,38,65,73,66},35)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({49,66,85,81,31,76,85},35))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({37,76,83,66,79,253,30,63,76,83,66,253,49,62,79,68,66,81},35), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({69,76,83,66,79},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,37,76,83,66,79,70,75,68,253},35) .. val .. _d({253,80,81,82,65,80,253,82,77},35)
end)
createInputBtn(_d({33,76,65,68,66,253,32,73,70,74,63},35), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({65,76,65,68,66},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,33,76,65,68,66,10,69,76,73,65,70,75,68,253,5},35) .. val .. _d({253,80,81,82,65,80,6},35)
end)
createInputBtn(_d({49,66,80,81,253,48,78,82,62,79,66,253,33,76,65,68,66},35), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({80,78,82,62,79,66,60,65,76,65,68,66},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,48,78,82,62,79,66,253,52,62,73,72,70,75,68,253,5},35) .. val .. _d({253,80,81,82,65,80,6},35)
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
while enabled and mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) then
disableBot()
statusLabel.Text = _d({48,81,62,81,82,80,23,253,38,65,73,66,253,5,48,78,82,62,79,66,253,65,76,65,68,66,253,65,76,75,66,6},35)
end
end)
end)
local stopBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({34,42,34,47,36,34,43,32,54,253,48,49,44,45},35)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({48,81,62,81,82,80,23,253,48,49,44,45,45,34,33,253,5,38,65,73,66,6},35)
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({56,44,83,66,79,84,76,79,73,65,49,66,80,81,66,79,58,253,41,76,62,65,66,65,253,80,82,64,64,66,80,80,67,82,73,73,86,11},35))
end)()