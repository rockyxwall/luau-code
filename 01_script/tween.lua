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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
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
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({62,62,51,86,68,68,77,32,83,83},33)) or Instance.new(_d({32,83,83,64,66,71,76,68,77,83},33))
att.Name = _d({62,62,51,86,68,68,77,32,83,83},33)
att.Parent = root
local force = root:FindFirstChild(_d({62,62,51,86,68,68,77,37,78,81,66,68},33))
if not force then
force = Instance.new(_d({43,72,77,68,64,81,53,68,75,78,66,72,83,88},33))
force.Name = _d({62,62,51,86,68,68,77,37,78,81,66,68},33)
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
local force = root:FindFirstChild(_d({62,62,51,86,68,68,77,37,78,81,66,68},33))
local att = root:FindFirstChild(_d({62,62,51,86,68,68,77,32,83,83},33))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({45,78,77,68},33)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({49,78,74,84,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,68,79,79,78},33), args)
elseif style == _d({33,75,64,66,74,43,68,70},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74},33), args)
elseif style == _d({42,64,76,72,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,64,76,72,82,71,72,74,72,38,68,79,79,78},33), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74,17},33), args)
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
if loopConn then loopConn:Disconnect() loopConn = nil end
cleanupForce()
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
if loopConn then loopConn:Disconnect() loopConn = nil end
cleanupForce()
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,32,81,81,72,85,68,67,255,64,83,255,83,64,81,70,68,83,13},33))
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
if type(obj) == _d({83,64,65,75,68},33) then
for k, v in pairs(obj) do
if type(v) == _d({84,82,68,81,67,64,83,64},33) and v:IsA(_d({51,68,87,83,43,64,65,68,75},33)) then
if v.Name:lower():find(_d({83,72,83,75,68},33)) then
v.Text = title
elseif v.Name:lower():find(_d({66,78,77,83,68,77,83},33)) or v.Name:lower():find(_d({67,68,82,66},33)) then
v.Text = content
end
end
end
elseif type(obj) == _d({84,82,68,81,67,64,83,64},33) and obj:IsA(_d({51,68,87,83,43,64,65,68,75},33)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local success, result = pcall(function()
return loadstring(game:HttpGet(_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,49,64,88,69,72,68,75,67,14,76,64,72,77,14,82,78,84,81,66,68,13,75,84,64},33)))()
end)
if success and result then
Rayfield = result
end
if not Rayfield then
warn(_d({58,38,47,46,255,51,86,68,68,77,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,49,64,88,69,72,68,75,67,255,52,40,255,75,72,65,81,64,81,88,255,69,81,78,76,255,64,77,88,255,82,78,84,81,66,68,13},33))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({38,47,46,255,51,86,68,68,77,255,5,255,37,75,72,70,71,83,255,50,84,72,83,68},33),
LoadingTitle = _d({38,47,46,255,45,64,85,72,70,64,83,78,81},33),
LoadingSubtitle = _d({49,64,88,69,72,68,75,67,255,52,40,255,53,68,81,82,72,78,77},33),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({51,81,64,85,68,75,255,34,78,77,83,81,78,75,82},33), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({34,84,81,81,68,77,83,255,47,78,82,72,83,72,78,77},33),
Content = _d({55,25,255,15,13,15,15,255,91,255,56,25,255,15,13,15,15,255,91,255,57,25,255,15,13,15,15},33)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({55,25,255,4,13,17,69,255,91,255,56,25,255,4,13,17,69,255,91,255,57,25,255,4,13,17,69},33), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({34,84,81,81,68,77,83,255,47,78,82,72,83,72,78,77},33), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({34,78,79,88,255,34,84,81,81,68,77,83,255,34,78,78,81,67,72,77,64,83,68,82},33),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({4,13,17,69,11,255,4,13,17,69,11,255,4,13,17,69},33), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,34,78,79,72,68,67,255,66,78,78,81,67,72,77,64,83,68,82,255,83,78,255,66,75,72,79,65,78,64,81,67,25,255},33) .. text)
else
warn(_d({58,38,47,46,255,51,86,68,68,77,60,255,82,68,83,66,75,72,79,65,78,64,81,67,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
end
end
end,
})
MainTab:CreateInput({
Name = _d({51,64,81,70,68,83,255,34,78,78,81,67,72,77,64,83,68,82,255,7,55,11,255,56,11,255,57,8},33),
PlaceholderText = _d({36,87,64,76,79,75,68,25,255,16,17,15,13,20,11,255,19,15,13,17,11,255,12,16,15,18,15,13,15},33),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({7,58,4,67,4,13,4,12,60,10,8,4,82,9,4,11,30,4,82,9,7,58,4,67,4,13,4,12,60,10,8,4,82,9,4,11,30,4,82,9,7,58,4,67,4,13,4,12,60,10,8},33))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({58,38,47,46,255,51,86,68,68,77,60,255,50,68,83,255,67,68,82,83,72,77,64,83,72,78,77,255,83,64,81,70,68,83,255,83,78,25,255,4,13,17,69,11,255,4,13,17,69,11,255,4,13,17,69},33), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({50,83,64,81,83,255,40,82,75,64,77,67,255,51,81,64,85,68,75},33),
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
Name = _d({36,77,64,65,75,68,255,54,32,50,35,255,37,75,72,70,71,83},33),
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
Name = _d({51,81,64,85,68,75,255,5,255,37,75,72,70,71,83,255,50,79,68,68,67},33),
Range = {10, 150},
Increment = 1,
Suffix = _d({255,82,83,84,67,82,14,82,68,66},33),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({35,68,82,83,81,78,88,255,52,40,255,5,255,50,83,78,79,255,36,85,68,81,88,83,71,72,77,70},33),
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
if loopConn then
pcall(function() loopConn:Disconnect() end)
loopConn = nil
end
cleanupForce()
if _G.GPOTweenLibrary then
pcall(function() _G.GPOTweenLibrary:Destroy() end)
_G.GPOTweenLibrary = nil
end
print(_d({58,38,47,46,255,51,86,68,68,77,60,255,34,75,68,64,77,68,67,255,84,79,255,64,77,67,255,67,68,82,83,81,78,88,68,67,255,49,64,88,69,72,68,75,67,255,52,40,13},33))
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
print(_d({58,38,47,46,255,51,86,68,68,77,255,51,68,82,83,68,81,60,255,75,78,64,67,68,67,255,86,72,83,71,255,68,76,68,81,70,68,77,66,88,255,82,83,78,79,255,74,68,88,255,58,47,60,13},33))
end)()