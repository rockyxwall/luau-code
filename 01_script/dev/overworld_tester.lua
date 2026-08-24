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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({84,79,87,80},21)
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
print(_d({70,58,97,80,93,98,90,93,87,79,63,80,94,95,80,93,72},21), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({61,90,86,96,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,80,91,91,90},21), args)
elseif style == _d({45,87,76,78,86,55,80,82},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86},21), args)
elseif style == _d({54,76,88,84,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,76,88,84,94,83,84,86,84,50,80,91,91,90},21), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86,29},21), args)
end
debug(_d({49,84,93,80,79,11,50,80,91,91,90,11,61,80,88,90,95,80},21))
end)
if not ok then debug(_d({84,89,97,90,86,80,50,80,91,91,90,11,80,93,93,90,93,37},21), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21)
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
local root = char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then return end
local force = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21))
local att   = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({66,76,87,86,84,89,82,11,95,90,37},21), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({98,76,87,86,63,90,59,90,84,89,95,11,66,11,79,90,98,89,11,80,93,93,90,93,37},21), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({44,93,93,84,97,80,79,11,76,95,37},21), pos)
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
if item:IsA(_d({56,90,79,80,87},21)) and item:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21)) and item:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)).Health > 0 then
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
mode = _d({84,79,87,80},21)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({63,80,94,95,80,93,11,47,84,94,76,77,87,80,79},21))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({63,80,94,95,80,93,11,48,89,76,77,87,80,79,25,11,56,90,79,80,37},21), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({59,87,76,100,80,93,11,79,84,80,79,12,11,47,84,94,76,77,87,84,89,82,11,77,90,95,25},21))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({83,90,97,80,93},21) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({79,90,79,82,80},21) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) then
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
local playerGui = LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({58,97,80,93,98,90,93,87,79,63,80,94,95,50,96,84},21))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({62,78,93,80,80,89,50,96,84},21))
screenGui.Name = _d({58,97,80,93,98,90,93,87,79,63,80,94,95,50,96,84},21)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({49,93,76,88,80},21))
frame.Name = _d({56,76,84,89,49,93,76,88,80},21)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({219,138,134,140,218,163,122,11,46,96,91,84,79,11,48,89,82,84,89,80,11,58,97,80,93,98,90,93,87,79,11,63,80,94,95},21)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({62,95,76,95,96,94,37,11,52,79,87,80},21)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({63,80,99,95,45,90,99},21))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({51,90,97,80,93,11,44,77,90,97,80,11,63,76,93,82,80,95},21), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({83,90,97,80,93},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,51,90,97,80,93,84,89,82,11},21) .. val .. _d({11,94,95,96,79,94,11,96,91},21)
end)
createInputBtn(_d({47,90,79,82,80,11,46,87,84,88,77},21), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({79,90,79,82,80},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,47,90,79,82,80,24,83,90,87,79,84,89,82,11,19},21) .. val .. _d({11,94,95,96,79,94,20},21)
end)
createInputBtn(_d({63,80,94,95,11,62,92,96,76,93,80,11,47,90,79,82,80},21), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({94,92,96,76,93,80,74,79,90,79,82,80},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,62,92,96,76,93,80,11,66,76,87,86,84,89,82,11,19},21) .. val .. _d({11,94,95,96,79,94,20},21)
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
while enabled and mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) then
disableBot()
statusLabel.Text = _d({62,95,76,95,96,94,37,11,52,79,87,80,11,19,62,92,96,76,93,80,11,79,90,79,82,80,11,79,90,89,80,20},21)
end
end)
end)
local stopBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({48,56,48,61,50,48,57,46,68,11,62,63,58,59},21)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({62,95,76,95,96,94,37,11,62,63,58,59,59,48,47,11,19,52,79,87,80,20},21)
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({70,58,97,80,93,98,90,93,87,79,63,80,94,95,80,93,72,11,55,90,76,79,80,79,11,94,96,78,78,80,94,94,81,96,87,87,100,25},21))
end)()