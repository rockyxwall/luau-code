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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local LocalPlayer = Players.LocalPlayer
local enabled = false
local navConn = nil
local hoverHeight = 10.3
local localPlatform = nil
local lastAim = nil
local function debug(...)
print(_d({76,65,93,82,101,87,96,99,94,69,86,100,101,86,99,78},15), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end
local function getOrCreatePlatform(root)
if localPlatform and localPlatform.Parent then return localPlatform end
local ok, plat = pcall(function()
local p = Instance.new(_d({65,82,99,101},15))
p.Name = _d({80,80,69,86,100,101,61,96,84,82,93,65,93,82,101,87,96,99,94},15)
p.Size = Vector3.new(6, 1, 6)
p.Transparency = 0.5
p.Color = Color3.fromRGB(0, 255, 100)
p.Anchored = true
p.CanCollide = true
p.Parent = workspace
return p
end)
if ok then
localPlatform = plat
return plat
end
return nil
end
local function cleanupPlatform()
if localPlatform then
pcall(function() localPlatform:Destroy() end)
localPlatform = nil
end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15)
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
cleanupPlatform()
local char = LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not root then return end
local force = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,55,96,99,84,86},15))
local att   = root:FindFirstChild(_d({80,80,69,86,100,101,57,96,103,86,99,50,101,101},15))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local function disableBot()
if not enabled then return end
enabled = false
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({69,86,100,101,86,99,17,53,90,100,82,83,93,86,85},15))
end
local function enableBot()
if enabled then return end
enabled = true
debug(_d({69,86,100,101,86,99,17,54,95,82,83,93,86,85},15))
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
lastAim = initialPos
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({65,93,82,106,86,99,17,85,90,86,85,18,17,53,90,100,82,83,93,90,95,88,17,97,93,82,101,87,96,99,94,31},15))
disableBot()
return
end
local plat = getOrCreatePlatform(root)
if plat then
plat.CFrame = root.CFrame * CFrame.new(0, -3.5, 0)
end
local targetPos = Vector3.new(lastAim.X, lastAim.Y + hoverHeight, lastAim.Z)
local pos = root.Position
local yErr = targetPos.Y - pos.Y
local xzDir = Vector3.new(targetPos.X - pos.X, 0, targetPos.Z - pos.Z)
local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * 5, 20)) or Vector3.zero
local force = getOrCreateForce(root)
if force then
local yVel = math.clamp(yErr * 20, -120, 120)
force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({65,93,82,101,87,96,99,94,69,86,100,101,56,102,90},15))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({68,84,99,86,86,95,56,102,90},15))
screenGui.Name = _d({65,93,82,101,87,96,99,94,69,86,100,101,56,102,90},15)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({55,99,82,94,86},15))
frame.Name = _d({62,82,90,95,55,99,82,94,86},15)
frame.Size = UDim2.new(0, 260, 0, 180)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({70,58,52,96,99,95,86,99},15))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({69,86,105,101,61,82,83,86,93},15))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({225,144,140,145,224,169,128,17,65,93,82,101,87,96,99,94,17,23,17,53,86,82,101,89,17,69,86,100,101,86,99},15)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local toggleBtn = Instance.new(_d({69,86,105,101,51,102,101,101,96,95},15))
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({65,93,82,101,87,96,99,94,17,55,93,106,43,17,64,55,55},15)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 12
toggleBtn.Parent = frame
local btnCorner = Instance.new(_d({70,58,52,96,99,95,86,99},15))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = toggleBtn
local heightLabel = Instance.new(_d({69,86,105,101,61,82,83,86,93},15))
heightLabel.Size = UDim2.new(1, -20, 0, 20)
heightLabel.Position = UDim2.new(0, 10, 0, 85)
heightLabel.BackgroundTransparency = 1
heightLabel.Text = _d({57,86,90,88,89,101,17,64,87,87,100,86,101,43,17,34,33,31,36,17,100,101,102,85,100},15)
heightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
heightLabel.Font = Enum.Font.GothamMedium
heightLabel.TextSize = 11
heightLabel.Parent = frame
local addHeight = Instance.new(_d({69,86,105,101,51,102,101,101,96,95},15))
addHeight.Size = UDim2.new(0.45, 0, 0, 30)
addHeight.Position = UDim2.new(0, 10, 0, 110)
addHeight.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
addHeight.Text = _d({28,34,33,17,57,86,90,88,89,101,17,25,53,96,85,88,86,26},15)
addHeight.TextColor3 = Color3.new(1,1,1)
addHeight.Font = Enum.Font.GothamBold
addHeight.TextSize = 11
addHeight.Parent = frame
Instance.new(_d({70,58,52,96,99,95,86,99},15), addHeight).CornerRadius = UDim.new(0, 6)
local subHeight = Instance.new(_d({69,86,105,101,51,102,101,101,96,95},15))
subHeight.Size = UDim2.new(0.45, 0, 0, 30)
subHeight.Position = UDim2.new(0.55, 0, 0, 110)
subHeight.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
subHeight.Text = _d({30,34,33,17,57,86,90,88,89,101},15)
subHeight.TextColor3 = Color3.new(1,1,1)
subHeight.Font = Enum.Font.GothamBold
subHeight.TextSize = 11
subHeight.Parent = frame
Instance.new(_d({70,58,52,96,99,95,86,99},15), subHeight).CornerRadius = UDim.new(0, 6)
toggleBtn.MouseButton1Click:Connect(function()
if enabled then
disableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({65,93,82,101,87,96,99,94,17,55,93,106,43,17,64,55,55},15)
else
enableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 100)
toggleBtn.Text = _d({65,93,82,101,87,96,99,94,17,55,93,106,43,17,64,63},15)
end
end)
addHeight.MouseButton1Click:Connect(function()
hoverHeight = hoverHeight + 10
heightLabel.Text = string.format(_d({57,86,90,88,89,101,17,64,87,87,100,86,101,43,17,22,31,34,87,17,100,101,102,85,100},15), hoverHeight)
end)
subHeight.MouseButton1Click:Connect(function()
hoverHeight = math.max(0, hoverHeight - 10)
heightLabel.Text = string.format(_d({57,86,90,88,89,101,17,64,87,87,100,86,101,43,17,22,31,34,87,17,100,101,102,85,100},15), hoverHeight)
end)
RunService.RenderStepped:Connect(function()
if not enabled and toggleBtn.Text == _d({65,93,82,101,87,96,99,94,17,55,93,106,43,17,64,63},15) then
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({65,93,82,101,87,96,99,94,17,55,93,106,43,17,64,55,55},15)
end
end)
end
CreateUI()
print(_d({76,65,93,82,101,87,96,99,94,69,86,100,101,86,99,78,17,61,96,82,85,86,85,17,100,102,84,84,86,100,100,87,102,93,93,106,31},15))
end)()