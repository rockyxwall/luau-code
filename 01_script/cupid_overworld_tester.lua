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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({74,69,77,70},31)
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
print(_d({60,48,87,70,83,88,80,83,77,69,53,70,84,85,70,83,62},31), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({51,80,76,86,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,70,81,81,80},31), args)
elseif style == _d({35,77,66,68,76,45,70,72},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76},31), args)
elseif style == _d({44,66,78,74,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,66,78,74,84,73,74,76,74,40,70,81,81,80},31), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76,19},31), args)
end
debug(_d({39,74,83,70,69,1,40,70,81,81,80,1,51,70,78,80,85,70},31))
end)
if not ok then debug(_d({74,79,87,80,76,70,40,70,81,81,80,1,70,83,83,80,83,27},31), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({64,64,53,70,84,85,41,80,87,70,83,34,85,85},31)) or Instance.new(_d({34,85,85,66,68,73,78,70,79,85},31))
att.Name = _d({64,64,53,70,84,85,41,80,87,70,83,34,85,85},31)
att.Parent = root
local force = root:FindFirstChild(_d({64,64,53,70,84,85,41,80,87,70,83,39,80,83,68,70},31))
if not force then
force = Instance.new(_d({45,74,79,70,66,83,55,70,77,80,68,74,85,90},31))
force.Name = _d({64,64,53,70,84,85,41,80,87,70,83,39,80,83,68,70},31)
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
local root = char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not root then return end
local force = root:FindFirstChild(_d({64,64,53,70,84,85,41,80,87,70,83,39,80,83,68,70},31))
local att   = root:FindFirstChild(_d({64,64,53,70,84,85,41,80,87,70,83,34,85,85},31))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({56,66,77,76,74,79,72,1,85,80,27},31), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({88,66,77,76,53,80,49,80,74,79,85,1,56,1,69,80,88,79,1,70,83,83,80,83,27},31), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({34,83,83,74,87,70,69,1,66,85,27},31), pos)
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
if item:IsA(_d({46,80,69,70,77},31)) and item:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31)) and item:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)).Health > 0 then
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
mode = _d({74,69,77,70},31)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({53,70,84,85,70,83,1,37,74,84,66,67,77,70,69},31))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({53,70,84,85,70,83,1,38,79,66,67,77,70,69,15,1,46,80,69,70,27},31), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({49,77,66,90,70,83,1,69,74,70,69,2,1,37,74,84,66,67,77,74,79,72,1,67,80,85,15},31))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({73,80,87,70,83},31) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({69,80,69,72,70},31) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({84,82,86,66,83,70,64,69,80,69,72,70},31) then
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
local playerGui = LocalPlayer:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({48,87,70,83,88,80,83,77,69,53,70,84,85,40,86,74},31))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({52,68,83,70,70,79,40,86,74},31))
screenGui.Name = _d({48,87,70,83,88,80,83,77,69,53,70,84,85,40,86,74},31)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({39,83,66,78,70},31))
frame.Name = _d({46,66,74,79,39,83,66,78,70},31)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({54,42,36,80,83,79,70,83},31))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({53,70,89,85,45,66,67,70,77},31))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({209,128,124,130,208,153,112,1,36,86,81,74,69,1,38,79,72,74,79,70,1,48,87,70,83,88,80,83,77,69,1,53,70,84,85},31)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({53,70,89,85,45,66,67,70,77},31))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({52,85,66,85,86,84,27,1,42,69,77,70},31)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({53,70,89,85,35,86,85,85,80,79},31))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({54,42,36,80,83,79,70,83},31), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({53,70,89,85,35,80,89},31))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({54,42,36,80,83,79,70,83},31), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({41,80,87,70,83,1,34,67,80,87,70,1,53,66,83,72,70,85},31), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({73,80,87,70,83},31))
statusLabel.Text = _d({52,85,66,85,86,84,27,1,41,80,87,70,83,74,79,72,1},31) .. val .. _d({1,84,85,86,69,84,1,86,81},31)
end)
createInputBtn(_d({37,80,69,72,70,1,36,77,74,78,67},31), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({69,80,69,72,70},31))
statusLabel.Text = _d({52,85,66,85,86,84,27,1,37,80,69,72,70,14,73,80,77,69,74,79,72,1,9},31) .. val .. _d({1,84,85,86,69,84,10},31)
end)
createInputBtn(_d({53,70,84,85,1,52,82,86,66,83,70,1,37,80,69,72,70},31), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({84,82,86,66,83,70,64,69,80,69,72,70},31))
statusLabel.Text = _d({52,85,66,85,86,84,27,1,52,82,86,66,83,70,1,56,66,77,76,74,79,72,1,9},31) .. val .. _d({1,84,85,86,69,84,10},31)
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
while enabled and mode == _d({84,82,86,66,83,70,64,69,80,69,72,70},31) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({84,82,86,66,83,70,64,69,80,69,72,70},31) then
disableBot()
statusLabel.Text = _d({52,85,66,85,86,84,27,1,42,69,77,70,1,9,52,82,86,66,83,70,1,69,80,69,72,70,1,69,80,79,70,10},31)
end
end)
end)
local stopBtn = Instance.new(_d({53,70,89,85,35,86,85,85,80,79},31))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({38,46,38,51,40,38,47,36,58,1,52,53,48,49},31)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({54,42,36,80,83,79,70,83},31), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({52,85,66,85,86,84,27,1,52,53,48,49,49,38,37,1,9,42,69,77,70,10},31)
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({60,48,87,70,83,88,80,83,77,69,53,70,84,85,70,83,62,1,45,80,66,69,70,69,1,84,86,68,68,70,84,84,71,86,77,77,90,15},31))
end)()