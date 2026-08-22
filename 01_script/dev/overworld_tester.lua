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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({67,62,70,63},38)
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
print(_d({53,41,80,63,76,81,73,76,70,62,46,63,77,78,63,76,55},38), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({44,73,69,79,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,63,74,74,73},38), args)
elseif style == _d({28,70,59,61,69,38,63,65},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69},38), args)
elseif style == _d({37,59,71,67,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,59,71,67,77,66,67,69,67,33,63,74,74,73},38), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69,12},38), args)
end
debug(_d({32,67,76,63,62,250,33,63,74,74,73,250,44,63,71,73,78,63},38))
end)
if not ok then debug(_d({67,72,80,73,69,63,33,63,74,74,73,250,63,76,76,73,76,20},38), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({57,57,46,63,77,78,34,73,80,63,76,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,46,63,77,78,34,73,80,63,76,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,46,63,77,78,34,73,80,63,76,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,46,63,77,78,34,73,80,63,76,32,73,76,61,63},38)
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
local root = char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not root then return end
local force = root:FindFirstChild(_d({57,57,46,63,77,78,34,73,80,63,76,32,73,76,61,63},38))
local att   = root:FindFirstChild(_d({57,57,46,63,77,78,34,73,80,63,76,27,78,78},38))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({49,59,70,69,67,72,65,250,78,73,20},38), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({81,59,70,69,46,73,42,73,67,72,78,250,49,250,62,73,81,72,250,63,76,76,73,76,20},38), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({27,76,76,67,80,63,62,250,59,78,20},38), pos)
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
if item:IsA(_d({39,73,62,63,70},38)) and item:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38)) and item:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
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
mode = _d({67,62,70,63},38)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({46,63,77,78,63,76,250,30,67,77,59,60,70,63,62},38))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({46,63,77,78,63,76,250,31,72,59,60,70,63,62,8,250,39,73,62,63,20},38), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({42,70,59,83,63,76,250,62,67,63,62,251,250,30,67,77,59,60,70,67,72,65,250,60,73,78,8},38))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({66,73,80,63,76},38) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({62,73,62,65,63},38) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({77,75,79,59,76,63,57,62,73,62,65,63},38) then
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
local playerGui = LocalPlayer:WaitForChild(_d({42,70,59,83,63,76,33,79,67},38), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({41,80,63,76,81,73,76,70,62,46,63,77,78,33,79,67},38))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({45,61,76,63,63,72,33,79,67},38))
screenGui.Name = _d({41,80,63,76,81,73,76,70,62,46,63,77,78,33,79,67},38)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({32,76,59,71,63},38))
frame.Name = _d({39,59,67,72,32,76,59,71,63},38)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({47,35,29,73,76,72,63,76},38))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({46,63,82,78,38,59,60,63,70},38))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({202,121,117,123,201,146,105,250,29,79,74,67,62,250,31,72,65,67,72,63,250,41,80,63,76,81,73,76,70,62,250,46,63,77,78},38)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({46,63,82,78,38,59,60,63,70},38))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({45,78,59,78,79,77,20,250,35,62,70,63},38)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({46,63,82,78,28,79,78,78,73,72},38))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({47,35,29,73,76,72,63,76},38), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({46,63,82,78,28,73,82},38))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({47,35,29,73,76,72,63,76},38), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({34,73,80,63,76,250,27,60,73,80,63,250,46,59,76,65,63,78},38), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({66,73,80,63,76},38))
statusLabel.Text = _d({45,78,59,78,79,77,20,250,34,73,80,63,76,67,72,65,250},38) .. val .. _d({250,77,78,79,62,77,250,79,74},38)
end)
createInputBtn(_d({30,73,62,65,63,250,29,70,67,71,60},38), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({62,73,62,65,63},38))
statusLabel.Text = _d({45,78,59,78,79,77,20,250,30,73,62,65,63,7,66,73,70,62,67,72,65,250,2},38) .. val .. _d({250,77,78,79,62,77,3},38)
end)
createInputBtn(_d({46,63,77,78,250,45,75,79,59,76,63,250,30,73,62,65,63},38), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({77,75,79,59,76,63,57,62,73,62,65,63},38))
statusLabel.Text = _d({45,78,59,78,79,77,20,250,45,75,79,59,76,63,250,49,59,70,69,67,72,65,250,2},38) .. val .. _d({250,77,78,79,62,77,3},38)
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
while enabled and mode == _d({77,75,79,59,76,63,57,62,73,62,65,63},38) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({77,75,79,59,76,63,57,62,73,62,65,63},38) then
disableBot()
statusLabel.Text = _d({45,78,59,78,79,77,20,250,35,62,70,63,250,2,45,75,79,59,76,63,250,62,73,62,65,63,250,62,73,72,63,3},38)
end
end)
end)
local stopBtn = Instance.new(_d({46,63,82,78,28,79,78,78,73,72},38))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({31,39,31,44,33,31,40,29,51,250,45,46,41,42},38)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({47,35,29,73,76,72,63,76},38), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({45,78,59,78,79,77,20,250,45,46,41,42,42,31,30,250,2,35,62,70,63,3},38)
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({53,41,80,63,76,81,73,76,70,62,46,63,77,78,63,76,55,250,38,73,59,62,63,62,250,77,79,61,61,63,77,77,64,79,70,70,83,8},38))
end)()