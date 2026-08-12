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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local LocalPlayer = Players.LocalPlayer
local enabled = false
local navConn = nil
local flySpeed = 40
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function debug(...)
print(_d({40,19,57,70,33,50,64,65,50,63,42},51), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({31,60,56,66,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,50,61,61,60},51), args)
elseif style == _d({15,57,46,48,56,25,50,52},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56},51), args)
elseif style == _d({24,46,58,54,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,46,58,54,64,53,54,56,54,20,50,61,61,60},51), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56,255},51), args)
end
debug(_d({19,54,63,50,49,237,20,50,61,61,60,237,31,50,58,60,65,50,237,245,21,50,54,52,53,65,237,36,53,54,65,50,57,54,64,65,246},51))
end)
if not ok then debug(_d({54,59,67,60,56,50,20,50,61,61,60,237,50,63,63,60,63,7},51), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51)) or Instance.new(_d({14,65,65,46,48,53,58,50,59,65},51))
att.Name = _d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51)
att.Parent = root
local force = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51))
if not force then
force = Instance.new(_d({25,54,59,50,46,63,35,50,57,60,48,54,65,70},51))
force.Name = _d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51)
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
local root = char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local force = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,19,60,63,48,50},51))
local att   = root:FindFirstChild(_d({44,44,33,50,64,65,21,60,67,50,63,14,65,65},51))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local function disableBot()
if not enabled then return end
enabled = false
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({19,57,54,52,53,65,237,17,54,64,46,47,57,50,49},51))
end
local function enableBot()
if enabled then return end
enabled = true
debug(_d({19,57,54,52,53,65,237,18,59,46,47,57,50,49},51))
lastGeppoTime = 0
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({29,57,46,70,50,63,237,49,54,50,49,238,237,17,54,64,46,47,57,54,59,52,237,51,57,54,52,53,65,251},51))
disableBot()
return
end
local now = tick()
if now - lastGeppoTime >= GEPPO_COOLDOWN then
lastGeppoTime = now
invokeGeppo()
end
local moveDir = Vector3.zero
local camera = workspace.CurrentCamera
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
local fwd = camera.CFrame.LookVector
moveDir = moveDir + Vector3.new(fwd.X, 0, fwd.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
local fwd = camera.CFrame.LookVector
moveDir = moveDir - Vector3.new(fwd.X, 0, fwd.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
local right = camera.CFrame.RightVector
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
local right = camera.CFrame.RightVector
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
local ySpeed = 0
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
ySpeed = flySpeed
elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
ySpeed = -flySpeed
end
if moveDir.Magnitude > 0 then
moveDir = moveDir.Unit
end
local targetVel = Vector3.new(moveDir.X * flySpeed, ySpeed, moveDir.Z * flySpeed)
local force = getOrCreateForce(root)
if force then
force.VectorVelocity = targetVel
end
root.CFrame = CFrame.lookAt(root.Position, root.Position + Vector3.new(camera.CFrame.LookVector.X, 0, camera.CFrame.LookVector.Z))
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({29,57,46,65,51,60,63,58,33,50,64,65,20,66,54},51))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({32,48,63,50,50,59,20,66,54},51))
screenGui.Name = _d({29,57,46,65,51,60,63,58,33,50,64,65,20,66,54},51)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({19,63,46,58,50},51))
frame.Name = _d({26,46,54,59,19,63,46,58,50},51)
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({175,105,85,188,133,92,237,32,46,51,50,237,19,57,54,52,53,65,237,33,50,64,65,50,63,237,245,36,14,32,17,246},51)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local toggleBtn = Instance.new(_d({33,50,69,65,15,66,65,65,60,59},51))
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({19,57,54,52,53,65,7,237,28,19,19},51)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 12
toggleBtn.Parent = frame
local btnCorner = Instance.new(_d({34,22,16,60,63,59,50,63},51))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = toggleBtn
local desc = Instance.new(_d({33,50,69,65,25,46,47,50,57},51))
desc.Size = UDim2.new(1, -20, 0, 60)
desc.Position = UDim2.new(0, 10, 0, 85)
desc.BackgroundTransparency = 1
desc.Text = "Controls:\nWASD to Move | Space = Go Up | Shift = Go Down\nFires safe Geppo remote once every 4.5s."
desc.TextColor3 = Color3.fromRGB(180, 180, 180)
desc.Font = Enum.Font.GothamMedium
desc.TextSize = 10
desc.TextWrapped = true
desc.Parent = frame
toggleBtn.MouseButton1Click:Connect(function()
if enabled then
disableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({19,57,54,52,53,65,7,237,28,19,19},51)
else
enableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 100)
toggleBtn.Text = _d({19,57,54,52,53,65,7,237,28,27},51)
end
end)
RunService.RenderStepped:Connect(function()
if not enabled and toggleBtn.Text == _d({19,57,54,52,53,65,7,237,28,27},51) then
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({19,57,54,52,53,65,7,237,28,19,19},51)
end
end)
end
CreateUI()
print(_d({40,32,46,51,50,19,57,54,52,53,65,33,50,64,65,50,63,42,237,25,60,46,49,50,49,237,64,66,48,48,50,64,64,51,66,57,57,70,251},51))
end)()