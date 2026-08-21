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
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local travelEnabled = false
local wasdFlightEnabled = false
local flightSpeed = 70.0
local hoverHeight = 15.0
local targetX, targetY, targetZ = 0, 0, 0
local lastGeppoTime = 0
local geppoCooldown = 2.0
local lastGroundingTime = tick()
local groundingActive = false
local groundingDuration = 0.5
local groundingInterval = 12.0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({67,67,56,91,73,73,82,37,88,88},28)) or Instance.new(_d({37,88,88,69,71,76,81,73,82,88},28))
att.Name = _d({67,67,56,91,73,73,82,37,88,88},28)
att.Parent = root
local force = root:FindFirstChild(_d({67,67,56,91,73,73,82,42,83,86,71,73},28))
if not force then
force = Instance.new(_d({48,77,82,73,69,86,58,73,80,83,71,77,88,93},28))
force.Name = _d({67,67,56,91,73,73,82,42,83,86,71,73},28)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({67,67,56,91,73,73,82,42,83,86,71,73},28))
local att = root:FindFirstChild(_d({67,67,56,91,73,73,82,37,88,88},28))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({50,83,82,73},28)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({54,83,79,89,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,73,84,84,83},28), args)
elseif style == _d({38,80,69,71,79,48,73,75},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79},28), args)
elseif style == _d({47,69,81,77,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,69,81,77,87,76,77,79,77,43,73,84,84,83},28), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79,22},28), args)
end
end)
end
local loopConn = nil
local function startMovementLoop()
if loopConn then loopConn:Disconnect() end
lastGroundingTime = tick()
groundingActive = false
loopConn = RunService.Heartbeat:Connect(function(dt)
local root = getRoot()
if not root or (not travelEnabled and not wasdFlightEnabled) then
cleanupForce()
if loopConn then loopConn:Disconnect() loopConn = nil end
return
end
local force = getOrCreateForce(root)
if wasdFlightEnabled then
local camera = Workspace.CurrentCamera
local moveDir = Vector3.zero
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
if moveDir.Magnitude > 0 then
root.CFrame = CFrame.lookAt(root.Position, root.Position + Vector3.new(look.X, 0, look.Z).Unit)
end
force.VectorVelocity = targetVelocity
if moveDir.Magnitude > 0 then
invokeGeppo()
end
elseif travelEnabled then
local currentPos = root.Position
local targetPos = Vector3.new(targetX, targetY, targetZ)
local dist = (targetPos - currentPos).Magnitude
if dist < 5 then
travelEnabled = false
cleanupForce()
print(_d({63,43,52,51,4,56,91,73,73,82,65,4,37,86,86,77,90,73,72,4,69,88,4,88,69,86,75,73,88,18},28))
if loopConn then loopConn:Disconnect() loopConn = nil end
return
end
local now = tick()
if not groundingActive and (now - lastGroundingTime > groundingInterval) then
groundingActive = true
task.spawn(function()
task.wait(groundingDuration)
groundingActive = false
lastGroundingTime = tick()
end)
end
if groundingActive then
force.VectorVelocity = Vector3.new(0, -60, 0)
else
local xzDir = Vector3.new(targetPos.X - currentPos.X, 0, targetPos.Z - currentPos.Z)
local xzVel = Vector3.zero
if xzDir.Magnitude > 0 then
xzVel = xzDir.Unit * math.min(xzDir.Magnitude, flightSpeed)
end
local yErr = targetPos.Y - currentPos.Y
local yVel = math.clamp(yErr * 2, -120, 120)
force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
if xzDir.Magnitude > 0.5 then
root.CFrame = CFrame.lookAt(currentPos, Vector3.new(targetPos.X, currentPos.Y, targetPos.Z))
end
if yErr > 5 then
invokeGeppo()
end
end
end
end)
end
local function updateRayfieldParagraph(paragraph, title, content)
if not paragraph then return end
local ok = pcall(function()
paragraph:Set({Title = title, Content = content})
end)
if ok then return end
pcall(function()
for _, obj in ipairs(paragraph) do
if type(obj) == _d({88,69,70,80,73},28) then
for k, v in pairs(obj) do
if type(v) == _d({89,87,73,86,72,69,88,69},28) and v:IsA(_d({56,73,92,88,48,69,70,73,80},28)) then
if v.Name:lower():find(_d({88,77,88,80,73},28)) then
v.Text = title
elseif v.Name:lower():find(_d({71,83,82,88,73,82,88},28)) or v.Name:lower():find(_d({72,73,87,71},28)) then
v.Text = content
end
end
end
elseif type(obj) == _d({89,87,73,86,72,69,88,69},28) and obj:IsA(_d({56,73,92,88,48,69,70,73,80},28)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local ok, Rayfield = pcall(function()
return loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,86,69,93,74,77,73,80,72,18,80,89,69,35,90,33},28) .. os.time()))()
end)
if not ok or not Rayfield then
warn(_d({63,43,52,51,4,56,91,73,73,82,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,74,83,86,79,73,72,4,54,69,93,74,77,73,80,72,4,57,45,18},28))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({43,52,51,4,56,91,73,73,82,4,10,4,42,80,77,75,76,88,4,55,89,77,88,73},28),
LoadingTitle = _d({43,52,51,4,50,69,90,77,75,69,88,83,86},28),
LoadingSubtitle = _d({55,77,86,77,89,87,4,42,83,86,79,73,72},28),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({56,86,69,90,73,80,4,39,83,82,88,86,83,80,87},28), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({39,89,86,86,73,82,88,4,52,83,87,77,88,77,83,82},28),
Content = _d({60,30,4,20,18,20,20,4,96,4,61,30,4,20,18,20,20,4,96,4,62,30,4,20,18,20,20},28)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({60,30,4,9,18,22,74,4,96,4,61,30,4,9,18,22,74,4,96,4,62,30,4,9,18,22,74},28), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({39,89,86,86,73,82,88,4,52,83,87,77,88,77,83,82},28), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({39,83,84,93,4,39,89,86,86,73,82,88,4,39,83,83,86,72,77,82,69,88,73,87},28),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({9,18,22,74,16,4,9,18,22,74,16,4,9,18,22,74},28), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({63,43,52,51,4,56,91,73,73,82,65,4,39,83,84,77,73,72,4,71,83,83,86,72,77,82,69,88,73,87,4,88,83,4,71,80,77,84,70,83,69,86,72,30,4},28) .. text)
else
warn(_d({63,43,52,51,4,56,91,73,73,82,65,4,87,73,88,71,80,77,84,70,83,69,86,72,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,73,92,73,71,89,88,83,86,5},28))
end
end
end,
})
MainTab:CreateInput({
Name = _d({56,69,86,75,73,88,4,39,83,83,86,72,77,82,69,88,73,87,4,12,60,16,4,61,16,4,62,13},28),
PlaceholderText = _d({41,92,69,81,84,80,73,30,4,21,22,20,18,25,16,4,24,20,18,22,16,4,17,21,20,23,20,18,20},28),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({12,63,9,72,9,18,9,17,65,15,13,9,87,14,9,16,35,9,87,14,12,63,9,72,9,18,9,17,65,15,13,9,87,14,9,16,35,9,87,14,12,63,9,72,9,18,9,17,65,15,13},28))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({63,43,52,51,4,56,91,73,73,82,65,4,55,73,88,4,72,73,87,88,77,82,69,88,77,83,82,4,88,69,86,75,73,88,4,88,83,30,4,9,18,22,74,16,4,9,18,22,74,16,4,9,18,22,74},28), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({55,88,69,86,88,4,45,87,80,69,82,72,4,56,86,69,90,73,80},28),
CurrentValue = false,
Callback = function(val)
travelEnabled = val
if travelEnabled then
wasdFlightEnabled = false
startMovementLoop()
else
cleanupForce()
end
end,
})
MainTab:CreateToggle({
Name = _d({41,82,69,70,80,73,4,59,37,55,40,4,42,80,77,75,76,88},28),
CurrentValue = false,
Callback = function(val)
wasdFlightEnabled = val
if wasdFlightEnabled then
travelEnabled = false
startMovementLoop()
else
cleanupForce()
end
end,
})
MainTab:CreateSlider({
Name = _d({56,86,69,90,73,80,4,10,4,42,80,77,75,76,88,4,55,84,73,73,72},28),
Range = {10, 150},
Increment = 1,
Suffix = _d({4,87,88,89,72,87,19,87,73,71},28),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({40,73,87,88,86,83,93,4,57,45,4,10,4,55,88,83,84,4,41,90,73,86,93,88,76,77,82,75},28),
Callback = function()
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
end,
})
end
_G.GPOTweenCleanup = function()
travelEnabled = false
wasdFlightEnabled = false
cleanupForce()
if loopConn then
pcall(function() loopConn:Disconnect() end)
loopConn = nil
end
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Destroy() end)
_G.GPOTweenLibrary = nil
end
print(_d({63,43,52,51,4,56,91,73,73,82,65,4,39,80,73,69,82,73,72,4,89,84,4,69,82,72,4,72,73,87,88,86,83,93,73,72,4,54,69,93,74,77,73,80,72,4,57,45,18},28))
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed then
if input.KeyCode == Enum.KeyCode.P then
if _G.GPOTweenCleanup then
pcall(_G.GPOTweenCleanup)
end
end
end
end)
task.spawn(buildUI)
print(_d({63,43,52,51,4,56,91,73,73,82,4,56,73,87,88,73,86,65,4,80,83,69,72,73,72,4,91,77,88,76,4,73,81,73,86,75,73,82,71,93,4,87,88,83,84,4,79,73,93,4,63,52,65,18},28))
end)()