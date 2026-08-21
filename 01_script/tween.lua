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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
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
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({61,61,50,85,67,67,76,31,82,82},34)) or Instance.new(_d({31,82,82,63,65,70,75,67,76,82},34))
att.Name = _d({61,61,50,85,67,67,76,31,82,82},34)
att.Parent = root
local force = root:FindFirstChild(_d({61,61,50,85,67,67,76,36,77,80,65,67},34))
if not force then
force = Instance.new(_d({42,71,76,67,63,80,52,67,74,77,65,71,82,87},34))
force.Name = _d({61,61,50,85,67,67,76,36,77,80,65,67},34)
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
local force = root:FindFirstChild(_d({61,61,50,85,67,67,76,36,77,80,65,67},34))
local att = root:FindFirstChild(_d({61,61,50,85,67,67,76,31,82,82},34))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({44,77,76,67},34)
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
print(_d({57,37,46,45,254,50,85,67,67,76,59,254,31,80,80,71,84,67,66,254,63,82,254,82,63,80,69,67,82,12},34))
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
if type(obj) == _d({82,63,64,74,67},34) then
for k, v in pairs(obj) do
if type(v) == _d({83,81,67,80,66,63,82,63},34) and v:IsA(_d({50,67,86,82,42,63,64,67,74},34)) then
if v.Name:lower():find(_d({82,71,82,74,67},34)) then
v.Text = title
elseif v.Name:lower():find(_d({65,77,76,82,67,76,82},34)) or v.Name:lower():find(_d({66,67,81,65},34)) then
v.Text = content
end
end
end
elseif type(obj) == _d({83,81,67,80,66,63,82,63},34) and obj:IsA(_d({50,67,86,82,42,63,64,67,74},34)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local rayfieldSources = {
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,80,77,65,73,87,86,85,63,74,74,13,80,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67,12,74,83,63},34),
_d({70,82,82,78,81,24,13,13,80,63,85,12,69,71,82,70,83,64,83,81,67,80,65,77,76,82,67,76,82,12,65,77,75,13,49,71,80,71,83,81,49,77,68,82,85,63,80,67,42,82,66,13,48,63,87,68,71,67,74,66,13,75,63,71,76,13,81,77,83,80,65,67,12,74,83,63},34),
_d({70,82,82,78,81,24,13,13,81,71,80,71,83,81,12,75,67,76,83,13,80,63,87,68,71,67,74,66},34)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
warn(_d({57,37,46,45,254,50,85,67,67,76,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,254,48,63,87,68,71,67,74,66,254,51,39,254,74,71,64,80,63,80,87,254,68,80,77,75,254,63,76,87,254,81,77,83,80,65,67,12},34))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({37,46,45,254,50,85,67,67,76,254,4,254,36,74,71,69,70,82,254,49,83,71,82,67},34),
LoadingTitle = _d({37,46,45,254,44,63,84,71,69,63,82,77,80},34),
LoadingSubtitle = _d({48,63,87,68,71,67,74,66,254,51,39,254,52,67,80,81,71,77,76},34),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({50,80,63,84,67,74,254,33,77,76,82,80,77,74,81},34), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({33,83,80,80,67,76,82,254,46,77,81,71,82,71,77,76},34),
Content = _d({54,24,254,14,12,14,14,254,90,254,55,24,254,14,12,14,14,254,90,254,56,24,254,14,12,14,14},34)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({54,24,254,3,12,16,68,254,90,254,55,24,254,3,12,16,68,254,90,254,56,24,254,3,12,16,68},34), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({33,83,80,80,67,76,82,254,46,77,81,71,82,71,77,76},34), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({33,77,78,87,254,33,83,80,80,67,76,82,254,33,77,77,80,66,71,76,63,82,67,81},34),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({3,12,16,68,10,254,3,12,16,68,10,254,3,12,16,68},34), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({57,37,46,45,254,50,85,67,67,76,59,254,33,77,78,71,67,66,254,65,77,77,80,66,71,76,63,82,67,81,254,82,77,254,65,74,71,78,64,77,63,80,66,24,254},34) .. text)
else
warn(_d({57,37,46,45,254,50,85,67,67,76,59,254,81,67,82,65,74,71,78,64,77,63,80,66,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,67,86,67,65,83,82,77,80,255},34))
end
end
end,
})
MainTab:CreateInput({
Name = _d({50,63,80,69,67,82,254,33,77,77,80,66,71,76,63,82,67,81,254,6,54,10,254,55,10,254,56,7},34),
PlaceholderText = _d({35,86,63,75,78,74,67,24,254,15,16,14,12,19,10,254,18,14,12,16,10,254,11,15,14,17,14,12,14},34),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({6,57,3,66,3,12,3,11,59,9,7,3,81,8,3,10,29,3,81,8,6,57,3,66,3,12,3,11,59,9,7,3,81,8,3,10,29,3,81,8,6,57,3,66,3,12,3,11,59,9,7},34))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({57,37,46,45,254,50,85,67,67,76,59,254,49,67,82,254,66,67,81,82,71,76,63,82,71,77,76,254,82,63,80,69,67,82,254,82,77,24,254,3,12,16,68,10,254,3,12,16,68,10,254,3,12,16,68},34), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({49,82,63,80,82,254,39,81,74,63,76,66,254,50,80,63,84,67,74},34),
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
Name = _d({35,76,63,64,74,67,254,53,31,49,34,254,36,74,71,69,70,82},34),
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
Name = _d({50,80,63,84,67,74,254,4,254,36,74,71,69,70,82,254,49,78,67,67,66},34),
Range = {10, 150},
Increment = 1,
Suffix = _d({254,81,82,83,66,81,13,81,67,65},34),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({34,67,81,82,80,77,87,254,51,39,254,4,254,49,82,77,78,254,35,84,67,80,87,82,70,71,76,69},34),
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
print(_d({57,37,46,45,254,50,85,67,67,76,59,254,33,74,67,63,76,67,66,254,83,78,254,63,76,66,254,66,67,81,82,80,77,87,67,66,254,48,63,87,68,71,67,74,66,254,51,39,12},34))
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
print(_d({57,37,46,45,254,50,85,67,67,76,254,50,67,81,82,67,80,59,254,74,77,63,66,67,66,254,85,71,82,70,254,67,75,67,80,69,67,76,65,87,254,81,82,77,78,254,73,67,87,254,57,46,59,12},34))
end)()