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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local LocalPlayer = Players.LocalPlayer
local enabled = false
local navConn = nil
local flySpeed = 40
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function debug(...)
print(_d({64,43,81,94,57,74,88,89,74,87,66},27), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({55,84,80,90,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,74,85,85,84},27), args)
elseif style == _d({39,81,70,72,80,49,74,76},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80},27), args)
elseif style == _d({48,70,82,78,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,70,82,78,88,77,78,80,78,44,74,85,85,84},27), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80,23},27), args)
end
debug(_d({43,78,87,74,73,5,44,74,85,85,84,5,55,74,82,84,89,74,5,13,45,74,78,76,77,89,5,60,77,78,89,74,81,78,88,89,14},27))
end)
if not ok then debug(_d({78,83,91,84,80,74,44,74,85,85,84,5,74,87,87,84,87,31},27), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27)) or Instance.new(_d({38,89,89,70,72,77,82,74,83,89},27))
att.Name = _d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27)
att.Parent = root
local force = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27))
if not force then
force = Instance.new(_d({49,78,83,74,70,87,59,74,81,84,72,78,89,94},27))
force.Name = _d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27)
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
local root = char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local force = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,43,84,87,72,74},27))
local att   = root:FindFirstChild(_d({68,68,57,74,88,89,45,84,91,74,87,38,89,89},27))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local function disableBot()
if not enabled then return end
enabled = false
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({43,81,78,76,77,89,5,41,78,88,70,71,81,74,73},27))
end
local function enableBot()
if enabled then return end
enabled = true
debug(_d({43,81,78,76,77,89,5,42,83,70,71,81,74,73},27))
lastGeppoTime = 0
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({53,81,70,94,74,87,5,73,78,74,73,6,5,41,78,88,70,71,81,78,83,76,5,75,81,78,76,77,89,19},27))
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
local playerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({53,81,70,89,75,84,87,82,57,74,88,89,44,90,78},27))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({56,72,87,74,74,83,44,90,78},27))
screenGui.Name = _d({53,81,70,89,75,84,87,82,57,74,88,89,44,90,78},27)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({43,87,70,82,74},27))
frame.Name = _d({50,70,78,83,43,87,70,82,74},27)
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({58,46,40,84,87,83,74,87},27))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({199,129,109,212,157,116,5,56,70,75,74,5,43,81,78,76,77,89,5,57,74,88,89,74,87,5,13,60,38,56,41,14},27)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local toggleBtn = Instance.new(_d({57,74,93,89,39,90,89,89,84,83},27))
toggleBtn.Size = UDim2.new(1, -20, 0, 35)
toggleBtn.Position = UDim2.new(0, 10, 0, 40)
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({43,81,78,76,77,89,31,5,52,43,43},27)
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.TextSize = 12
toggleBtn.Parent = frame
local btnCorner = Instance.new(_d({58,46,40,84,87,83,74,87},27))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = toggleBtn
local desc = Instance.new(_d({57,74,93,89,49,70,71,74,81},27))
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
toggleBtn.Text = _d({43,81,78,76,77,89,31,5,52,43,43},27)
else
enableBot()
toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 100)
toggleBtn.Text = _d({43,81,78,76,77,89,31,5,52,51},27)
end
end)
RunService.RenderStepped:Connect(function()
if not enabled and toggleBtn.Text == _d({43,81,78,76,77,89,31,5,52,51},27) then
toggleBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
toggleBtn.Text = _d({43,81,78,76,77,89,31,5,52,43,43},27)
end
end)
end
CreateUI()
print(_d({64,56,70,75,74,43,81,78,76,77,89,57,74,88,89,74,87,66,5,49,84,70,73,74,73,5,88,90,72,72,74,88,88,75,90,81,81,94,19},27))
end)()