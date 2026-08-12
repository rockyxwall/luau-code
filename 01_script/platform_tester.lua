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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local LocalPlayer = Players.LocalPlayer
local enabled = false
local navConn = nil
local hoverHeight = 10.3
local localPlatform = nil
local lastAim = nil
local function debug(...)
print(_d({34,23,51,40,59,45,54,57,52,27,44,58,59,44,57,36},57), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function getOrCreatePlatform(root)
if localPlatform and localPlatform.Parent then return localPlatform end
local ok, plat = pcall(function()
local p = Instance.new(_d({23,40,57,59},57))
p.Name = _d({27,44,58,59,10,40,52,44,57,40,12,45,45,44,42,59,23,40,57,59},57)
p.Size = Vector3.new(3, 0.5, 3)
p.Transparency = 0.5
p.Color = Color3.fromRGB(0, 255, 100)
p.Anchored = true
p.CanCollide = true
p.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
p.Parent = workspace.CurrentCamera
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
local att = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57)) or Instance.new(_d({8,59,59,40,42,47,52,44,53,59},57))
att.Name = _d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57)
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
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local force = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,13,54,57,42,44},57))
local att   = root:FindFirstChild(_d({38,38,27,44,58,59,15,54,61,44,57,8,59,59},57))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local function disableBot()
if not enabled then return end
enabled = false
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({27,44,58,59,44,57,231,11,48,58,40,41,51,44,43},57))
end
local function enableBot()
if enabled then return end
enabled = true
debug(_d({27,44,58,59,44,57,231,12,53,40,41,51,44,43},57))
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
lastAim = initialPos
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({23,51,40,64,44,57,231,43,48,44,43,232,231,11,48,58,40,41,51,48,53,46,231,55,51,40,59,45,54,57,52,245},57))
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
local playerGui = LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({23,51,40,59,45,54,57,52,27,44,58,59,14,60,48},57))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({26,42,57,44,44,53,14,60,48},57))
screenGui.Name = _d({23,51,40,59,45,54,57,52,27,44,58,59,14,60,48},57)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({13,57,40,52,44},57))
frame.Name = _d({20,40,48,53,13,57,40,52,44},57)
frame.Size = UDim2.new(0, 260, 0, 180)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({28,16,10,54,57,53,44,57},57))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({27,44,63,59,19,40,41,44,51},57))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({183,102,98,103,182,127,86,231,23,51,40,59,45,54,57,52,231,237,231,11,44,40,59,47,231,27,44,58,59,44,57},57)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local toggleBtn = Instance.new(_d({27,44,63,59,9,60,59,59,54,53},57))
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({23,51,40,59,45,54,57,52,231,13,51,64,1,231,22,13,13},57)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 12
toggleBtn.Parent = frame
local btnCorner = Instance.new(_d({28,16,10,54,57,53,44,57},57))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = toggleBtn
local heightLabel = Instance.new(_d({27,44,63,59,19,40,41,44,51},57))
heightLabel.Size = UDim2.new(1, -20, 0, 20)
heightLabel.Position = UDim2.new(0, 10, 0, 85)
heightLabel.BackgroundTransparency = 1
heightLabel.Text = _d({15,44,48,46,47,59,231,22,45,45,58,44,59,1,231,248,247,245,250,231,58,59,60,43,58},57)
heightLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
heightLabel.Font = Enum.Font.GothamMedium
heightLabel.TextSize = 11
heightLabel.Parent = frame
local addHeight = Instance.new(_d({27,44,63,59,9,60,59,59,54,53},57))
addHeight.Size = UDim2.new(0.45, 0, 0, 30)
addHeight.Position = UDim2.new(0, 10, 0, 110)
addHeight.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
addHeight.Text = _d({242,248,247,231,15,44,48,46,47,59,231,239,11,54,43,46,44,240},57)
addHeight.TextColor3 = Color3.new(1,1,1)
addHeight.Font = Enum.Font.GothamBold
addHeight.TextSize = 11
addHeight.Parent = frame
Instance.new(_d({28,16,10,54,57,53,44,57},57), addHeight).CornerRadius = UDim.new(0, 6)
local subHeight = Instance.new(_d({27,44,63,59,9,60,59,59,54,53},57))
subHeight.Size = UDim2.new(0.45, 0, 0, 30)
subHeight.Position = UDim2.new(0.55, 0, 0, 110)
subHeight.BackgroundColor3 = Color3.fromRGB(50, 60, 80)
subHeight.Text = _d({244,248,247,231,15,44,48,46,47,59},57)
subHeight.TextColor3 = Color3.new(1,1,1)
subHeight.Font = Enum.Font.GothamBold
subHeight.TextSize = 11
subHeight.Parent = frame
Instance.new(_d({28,16,10,54,57,53,44,57},57), subHeight).CornerRadius = UDim.new(0, 6)
toggleBtn.MouseButton1Click:Connect(function()
if enabled then
disableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({23,51,40,59,45,54,57,52,231,13,51,64,1,231,22,13,13},57)
else
enableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 100)
toggleBtn.Text = _d({23,51,40,59,45,54,57,52,231,13,51,64,1,231,22,21},57)
end
end)
addHeight.MouseButton1Click:Connect(function()
hoverHeight = hoverHeight + 10
heightLabel.Text = string.format(_d({15,44,48,46,47,59,231,22,45,45,58,44,59,1,231,236,245,248,45,231,58,59,60,43,58},57), hoverHeight)
end)
subHeight.MouseButton1Click:Connect(function()
hoverHeight = math.max(0, hoverHeight - 10)
heightLabel.Text = string.format(_d({15,44,48,46,47,59,231,22,45,45,58,44,59,1,231,236,245,248,45,231,58,59,60,43,58},57), hoverHeight)
end)
RunService.RenderStepped:Connect(function()
if not enabled and toggleBtn.Text == _d({23,51,40,59,45,54,57,52,231,13,51,64,1,231,22,21},57) then
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({23,51,40,59,45,54,57,52,231,13,51,64,1,231,22,13,13},57)
end
end)
end
CreateUI()
print(_d({34,23,51,40,59,45,54,57,52,27,44,58,59,44,57,36,231,19,54,40,43,44,43,231,58,60,42,42,44,58,58,45,60,51,51,64,245},57))
end)()