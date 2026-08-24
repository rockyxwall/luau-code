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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local UserInputService = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({52,47,55,48},53)
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
print(_d({38,26,65,48,61,66,58,61,55,47,31,48,62,63,48,61,40},53), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({29,58,54,64,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,48,59,59,58},53), args)
elseif style == _d({13,55,44,46,54,23,48,50},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54},53), args)
elseif style == _d({22,44,56,52,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,44,56,52,62,51,52,54,52,18,48,59,59,58},53), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54,253},53), args)
end
debug(_d({17,52,61,48,47,235,18,48,59,59,58,235,29,48,56,58,63,48},53))
end)
if not ok then debug(_d({52,57,65,58,54,48,18,48,59,59,58,235,48,61,61,58,61,5},53), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({42,42,31,48,62,63,19,58,65,48,61,12,63,63},53)) or Instance.new(_d({12,63,63,44,46,51,56,48,57,63},53))
att.Name = _d({42,42,31,48,62,63,19,58,65,48,61,12,63,63},53)
att.Parent = root
local force = root:FindFirstChild(_d({42,42,31,48,62,63,19,58,65,48,61,17,58,61,46,48},53))
if not force then
force = Instance.new(_d({23,52,57,48,44,61,33,48,55,58,46,52,63,68},53))
force.Name = _d({42,42,31,48,62,63,19,58,65,48,61,17,58,61,46,48},53)
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
local root = char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if not root then return end
local force = root:FindFirstChild(_d({42,42,31,48,62,63,19,58,65,48,61,17,58,61,46,48},53))
local att   = root:FindFirstChild(_d({42,42,31,48,62,63,19,58,65,48,61,12,63,63},53))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({34,44,55,54,52,57,50,235,63,58,5},53), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({66,44,55,54,31,58,27,58,52,57,63,235,34,235,47,58,66,57,235,48,61,61,58,61,5},53), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({12,61,61,52,65,48,47,235,44,63,5},53), pos)
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
if item:IsA(_d({24,58,47,48,55},53)) and item:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53)) and item:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health > 0 then
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
mode = _d({52,47,55,48},53)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({31,48,62,63,48,61,235,15,52,62,44,45,55,48,47},53))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({31,48,62,63,48,61,235,16,57,44,45,55,48,47,249,235,24,58,47,48,5},53), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({27,55,44,68,48,61,235,47,52,48,47,236,235,15,52,62,44,45,55,52,57,50,235,45,58,63,249},53))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({51,58,65,48,61},53) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({47,58,47,50,48},53) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({62,60,64,44,61,48,42,47,58,47,50,48},53) then
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
local playerGui = LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({26,65,48,61,66,58,61,55,47,31,48,62,63,18,64,52},53))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({30,46,61,48,48,57,18,64,52},53))
screenGui.Name = _d({26,65,48,61,66,58,61,55,47,31,48,62,63,18,64,52},53)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({17,61,44,56,48},53))
frame.Name = _d({24,44,52,57,17,61,44,56,48},53)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({32,20,14,58,61,57,48,61},53))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({31,48,67,63,23,44,45,48,55},53))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({187,106,102,108,186,131,90,235,14,64,59,52,47,235,16,57,50,52,57,48,235,26,65,48,61,66,58,61,55,47,235,31,48,62,63},53)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({31,48,67,63,23,44,45,48,55},53))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({30,63,44,63,64,62,5,235,20,47,55,48},53)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({31,48,67,63,13,64,63,63,58,57},53))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({32,20,14,58,61,57,48,61},53), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({31,48,67,63,13,58,67},53))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({32,20,14,58,61,57,48,61},53), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({19,58,65,48,61,235,12,45,58,65,48,235,31,44,61,50,48,63},53), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({51,58,65,48,61},53))
statusLabel.Text = _d({30,63,44,63,64,62,5,235,19,58,65,48,61,52,57,50,235},53) .. val .. _d({235,62,63,64,47,62,235,64,59},53)
end)
createInputBtn(_d({15,58,47,50,48,235,14,55,52,56,45},53), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({47,58,47,50,48},53))
statusLabel.Text = _d({30,63,44,63,64,62,5,235,15,58,47,50,48,248,51,58,55,47,52,57,50,235,243},53) .. val .. _d({235,62,63,64,47,62,244},53)
end)
createInputBtn(_d({31,48,62,63,235,30,60,64,44,61,48,235,15,58,47,50,48},53), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({62,60,64,44,61,48,42,47,58,47,50,48},53))
statusLabel.Text = _d({30,63,44,63,64,62,5,235,30,60,64,44,61,48,235,34,44,55,54,52,57,50,235,243},53) .. val .. _d({235,62,63,64,47,62,244},53)
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
while enabled and mode == _d({62,60,64,44,61,48,42,47,58,47,50,48},53) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({62,60,64,44,61,48,42,47,58,47,50,48},53) then
disableBot()
statusLabel.Text = _d({30,63,44,63,64,62,5,235,20,47,55,48,235,243,30,60,64,44,61,48,235,47,58,47,50,48,235,47,58,57,48,244},53)
end
end)
end)
local stopBtn = Instance.new(_d({31,48,67,63,13,64,63,63,58,57},53))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({16,24,16,29,18,16,25,14,36,235,30,31,26,27},53)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({32,20,14,58,61,57,48,61},53), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({30,63,44,63,64,62,5,235,30,31,26,27,27,16,15,235,243,20,47,55,48,244},53)
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({38,26,65,48,61,66,58,61,55,47,31,48,62,63,48,61,40,235,23,58,44,47,48,47,235,62,64,46,46,48,62,62,49,64,55,55,68,249},53))
end)()