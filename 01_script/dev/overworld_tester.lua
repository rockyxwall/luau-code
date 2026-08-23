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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({88,83,91,84},17)
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
print(_d({74,62,101,84,97,102,94,97,91,83,67,84,98,99,84,97,76},17), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({65,94,90,100,98,87,88,90,88},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,84,95,95,94},17), args)
elseif style == _d({49,91,80,82,90,59,84,86},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({66,90,104,15,70,80,91,90},17), args)
elseif style == _d({58,80,92,88,98,87,88,90,88},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,80,92,88,98,87,88,90,88,54,84,95,95,94},17), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({66,90,104,15,70,80,91,90,33},17), args)
end
debug(_d({53,88,97,84,83,15,54,84,95,95,94,15,65,84,92,94,99,84},17))
end)
if not ok then debug(_d({88,93,101,94,90,84,54,84,95,95,94,15,84,97,97,94,97,41},17), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({78,78,67,84,98,99,55,94,101,84,97,48,99,99},17)) or Instance.new(_d({48,99,99,80,82,87,92,84,93,99},17))
att.Name = _d({78,78,67,84,98,99,55,94,101,84,97,48,99,99},17)
att.Parent = root
local force = root:FindFirstChild(_d({78,78,67,84,98,99,55,94,101,84,97,53,94,97,82,84},17))
if not force then
force = Instance.new(_d({59,88,93,84,80,97,69,84,91,94,82,88,99,104},17))
force.Name = _d({78,78,67,84,98,99,55,94,101,84,97,53,94,97,82,84},17)
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
local root = char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
if not root then return end
local force = root:FindFirstChild(_d({78,78,67,84,98,99,55,94,101,84,97,53,94,97,82,84},17))
local att   = root:FindFirstChild(_d({78,78,67,84,98,99,55,94,101,84,97,48,99,99},17))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({69,88,97,99,100,80,91,56,93,95,100,99,60,80,93,80,86,84,97},17))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({70,80,91,90,88,93,86,15,99,94,41},17), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({102,80,91,90,67,94,63,94,88,93,99,15,70,15,83,94,102,93,15,84,97,97,94,97,41},17), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({48,97,97,88,101,84,83,15,80,99,41},17), pos)
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
if item:IsA(_d({60,94,83,84,91},17)) and item:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17)) and item:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)).Health > 0 then
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
mode = _d({88,83,91,84},17)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({67,84,98,99,84,97,15,51,88,98,80,81,91,84,83},17))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({67,84,98,99,84,97,15,52,93,80,81,91,84,83,29,15,60,94,83,84,41},17), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({63,91,80,104,84,97,15,83,88,84,83,16,15,51,88,98,80,81,91,88,93,86,15,81,94,99,29},17))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({87,94,101,84,97},17) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({83,94,83,86,84},17) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({98,96,100,80,97,84,78,83,94,83,86,84},17) then
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
local playerGui = LocalPlayer:WaitForChild(_d({63,91,80,104,84,97,54,100,88},17), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({62,101,84,97,102,94,97,91,83,67,84,98,99,54,100,88},17))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({66,82,97,84,84,93,54,100,88},17))
screenGui.Name = _d({62,101,84,97,102,94,97,91,83,67,84,98,99,54,100,88},17)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({53,97,80,92,84},17))
frame.Name = _d({60,80,88,93,53,97,80,92,84},17)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({68,56,50,94,97,93,84,97},17))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({67,84,103,99,59,80,81,84,91},17))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({223,142,138,144,222,167,126,15,50,100,95,88,83,15,52,93,86,88,93,84,15,62,101,84,97,102,94,97,91,83,15,67,84,98,99},17)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({67,84,103,99,59,80,81,84,91},17))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({66,99,80,99,100,98,41,15,56,83,91,84},17)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({67,84,103,99,49,100,99,99,94,93},17))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({68,56,50,94,97,93,84,97},17), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({67,84,103,99,49,94,103},17))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({68,56,50,94,97,93,84,97},17), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({55,94,101,84,97,15,48,81,94,101,84,15,67,80,97,86,84,99},17), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({87,94,101,84,97},17))
statusLabel.Text = _d({66,99,80,99,100,98,41,15,55,94,101,84,97,88,93,86,15},17) .. val .. _d({15,98,99,100,83,98,15,100,95},17)
end)
createInputBtn(_d({51,94,83,86,84,15,50,91,88,92,81},17), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({83,94,83,86,84},17))
statusLabel.Text = _d({66,99,80,99,100,98,41,15,51,94,83,86,84,28,87,94,91,83,88,93,86,15,23},17) .. val .. _d({15,98,99,100,83,98,24},17)
end)
createInputBtn(_d({67,84,98,99,15,66,96,100,80,97,84,15,51,94,83,86,84},17), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({98,96,100,80,97,84,78,83,94,83,86,84},17))
statusLabel.Text = _d({66,99,80,99,100,98,41,15,66,96,100,80,97,84,15,70,80,91,90,88,93,86,15,23},17) .. val .. _d({15,98,99,100,83,98,24},17)
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
while enabled and mode == _d({98,96,100,80,97,84,78,83,94,83,86,84},17) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({98,96,100,80,97,84,78,83,94,83,86,84},17) then
disableBot()
statusLabel.Text = _d({66,99,80,99,100,98,41,15,56,83,91,84,15,23,66,96,100,80,97,84,15,83,94,83,86,84,15,83,94,93,84,24},17)
end
end)
end)
local stopBtn = Instance.new(_d({67,84,103,99,49,100,99,99,94,93},17))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({52,60,52,65,54,52,61,50,72,15,66,67,62,63},17)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({68,56,50,94,97,93,84,97},17), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({66,99,80,99,100,98,41,15,66,67,62,63,63,52,51,15,23,56,83,91,84,24},17)
local VIM = game:GetService(_d({69,88,97,99,100,80,91,56,93,95,100,99,60,80,93,80,86,84,97},17))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({74,62,101,84,97,102,94,97,91,83,67,84,98,99,84,97,76,15,59,94,80,83,84,83,15,98,100,82,82,84,98,98,85,100,91,91,104,29},17))
end)()