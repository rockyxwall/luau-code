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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({71,66,74,67},34)
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
print(_d({57,45,84,67,80,85,77,80,74,66,50,67,81,82,67,80,59},34), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({48,77,73,83,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,67,78,78,77},34), args)
elseif style == _d({32,74,63,65,73,42,67,69},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73},34), args)
elseif style == _d({41,63,75,71,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,63,75,71,81,70,71,73,71,37,67,78,78,77},34), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73,16},34), args)
end
debug(_d({36,71,80,67,66,254,37,67,78,78,77,254,48,67,75,77,82,67},34))
end)
if not ok then debug(_d({71,76,84,77,73,67,37,67,78,78,77,254,67,80,80,77,80,24},34), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({61,61,50,67,81,82,38,77,84,67,80,31,82,82},34)) or Instance.new(_d({31,82,82,63,65,70,75,67,76,82},34))
att.Name = _d({61,61,50,67,81,82,38,77,84,67,80,31,82,82},34)
att.Parent = root
local force = root:FindFirstChild(_d({61,61,50,67,81,82,38,77,84,67,80,36,77,80,65,67},34))
if not force then
force = Instance.new(_d({42,71,76,67,63,80,52,67,74,77,65,71,82,87},34))
force.Name = _d({61,61,50,67,81,82,38,77,84,67,80,36,77,80,65,67},34)
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
local root = char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not root then return end
local force = root:FindFirstChild(_d({61,61,50,67,81,82,38,77,84,67,80,36,77,80,65,67},34))
local att   = root:FindFirstChild(_d({61,61,50,67,81,82,38,77,84,67,80,31,82,82},34))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({53,63,74,73,71,76,69,254,82,77,24},34), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({85,63,74,73,50,77,46,77,71,76,82,254,53,254,66,77,85,76,254,67,80,80,77,80,24},34), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({31,80,80,71,84,67,66,254,63,82,24},34), pos)
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
if item:IsA(_d({43,77,66,67,74},34)) and item:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34)) and item:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)).Health > 0 then
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
mode = _d({71,66,74,67},34)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({50,67,81,82,67,80,254,34,71,81,63,64,74,67,66},34))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({50,67,81,82,67,80,254,35,76,63,64,74,67,66,12,254,43,77,66,67,24},34), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({46,74,63,87,67,80,254,66,71,67,66,255,254,34,71,81,63,64,74,71,76,69,254,64,77,82,12},34))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({70,77,84,67,80},34) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({66,77,66,69,67},34) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({81,79,83,63,80,67,61,66,77,66,69,67},34) then
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
local playerGui = LocalPlayer:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({45,84,67,80,85,77,80,74,66,50,67,81,82,37,83,71},34))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({49,65,80,67,67,76,37,83,71},34))
screenGui.Name = _d({45,84,67,80,85,77,80,74,66,50,67,81,82,37,83,71},34)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({36,80,63,75,67},34))
frame.Name = _d({43,63,71,76,36,80,63,75,67},34)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({51,39,33,77,80,76,67,80},34))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({50,67,86,82,42,63,64,67,74},34))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({206,125,121,127,205,150,109,254,33,83,78,71,66,254,35,76,69,71,76,67,254,45,84,67,80,85,77,80,74,66,254,50,67,81,82},34)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({50,67,86,82,42,63,64,67,74},34))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({49,82,63,82,83,81,24,254,39,66,74,67},34)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({50,67,86,82,32,83,82,82,77,76},34))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({51,39,33,77,80,76,67,80},34), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({50,67,86,82,32,77,86},34))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({51,39,33,77,80,76,67,80},34), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({38,77,84,67,80,254,31,64,77,84,67,254,50,63,80,69,67,82},34), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({70,77,84,67,80},34))
statusLabel.Text = _d({49,82,63,82,83,81,24,254,38,77,84,67,80,71,76,69,254},34) .. val .. _d({254,81,82,83,66,81,254,83,78},34)
end)
createInputBtn(_d({34,77,66,69,67,254,33,74,71,75,64},34), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({66,77,66,69,67},34))
statusLabel.Text = _d({49,82,63,82,83,81,24,254,34,77,66,69,67,11,70,77,74,66,71,76,69,254,6},34) .. val .. _d({254,81,82,83,66,81,7},34)
end)
createInputBtn(_d({50,67,81,82,254,49,79,83,63,80,67,254,34,77,66,69,67},34), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({81,79,83,63,80,67,61,66,77,66,69,67},34))
statusLabel.Text = _d({49,82,63,82,83,81,24,254,49,79,83,63,80,67,254,53,63,74,73,71,76,69,254,6},34) .. val .. _d({254,81,82,83,66,81,7},34)
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
while enabled and mode == _d({81,79,83,63,80,67,61,66,77,66,69,67},34) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({81,79,83,63,80,67,61,66,77,66,69,67},34) then
disableBot()
statusLabel.Text = _d({49,82,63,82,83,81,24,254,39,66,74,67,254,6,49,79,83,63,80,67,254,66,77,66,69,67,254,66,77,76,67,7},34)
end
end)
end)
local stopBtn = Instance.new(_d({50,67,86,82,32,83,82,82,77,76},34))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({35,43,35,48,37,35,44,33,55,254,49,50,45,46},34)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({51,39,33,77,80,76,67,80},34), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({49,82,63,82,83,81,24,254,49,50,45,46,46,35,34,254,6,39,66,74,67,7},34)
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({57,45,84,67,80,85,77,80,74,66,50,67,81,82,67,80,59,254,42,77,63,66,67,66,254,81,83,65,65,67,81,81,68,83,74,74,87,12},34))
end)()