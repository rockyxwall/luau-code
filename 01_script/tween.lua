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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
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
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({79,79,68,103,85,85,94,49,100,100},16)) or Instance.new(_d({49,100,100,81,83,88,93,85,94,100},16))
att.Name = _d({79,79,68,103,85,85,94,49,100,100},16)
att.Parent = root
local force = root:FindFirstChild(_d({79,79,68,103,85,85,94,54,95,98,83,85},16))
if not force then
force = Instance.new(_d({60,89,94,85,81,98,70,85,92,95,83,89,100,105},16))
force.Name = _d({79,79,68,103,85,85,94,54,95,98,83,85},16)
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
local force = root:FindFirstChild(_d({79,79,68,103,85,85,94,54,95,98,83,85},16))
local att = root:FindFirstChild(_d({79,79,68,103,85,85,94,49,100,100},16))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({62,95,94,85},16)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({66,95,91,101,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,85,96,96,95},16), args)
elseif style == _d({50,92,81,83,91,60,85,87},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91},16), args)
elseif style == _d({59,81,93,89,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,81,93,89,99,88,89,91,89,55,85,96,96,95},16), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91,34},16), args)
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
print(_d({75,55,64,63,16,68,103,85,85,94,77,16,49,98,98,89,102,85,84,16,81,100,16,100,81,98,87,85,100,30},16))
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
if type(obj) == _d({100,81,82,92,85},16) then
for k, v in pairs(obj) do
if type(v) == _d({101,99,85,98,84,81,100,81},16) and v:IsA(_d({68,85,104,100,60,81,82,85,92},16)) then
if v.Name:lower():find(_d({100,89,100,92,85},16)) then
v.Text = title
elseif v.Name:lower():find(_d({83,95,94,100,85,94,100},16)) or v.Name:lower():find(_d({84,85,99,83},16)) then
v.Text = content
end
end
end
elseif type(obj) == _d({101,99,85,98,84,81,100,81},16) and obj:IsA(_d({68,85,104,100,60,81,82,85,92},16)) then
obj.Text = content
end
end
end)
end
local function buildUI()
local Rayfield = nil
local rayfieldSources = {
_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85,30,92,101,81},16),
_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,67,89,98,89,101,99,67,95,86,100,103,81,98,85,60,100,84,31,66,81,105,86,89,85,92,84,31,93,81,89,94,31,99,95,101,98,83,85,30,92,101,81},16),
_d({88,100,100,96,99,42,31,31,99,89,98,89,101,99,30,93,85,94,101,31,98,81,105,86,89,85,92,84},16)
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
warn(_d({75,55,64,63,16,68,103,85,85,94,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,66,81,105,86,89,85,92,84,16,69,57,16,92,89,82,98,81,98,105,16,86,98,95,93,16,81,94,105,16,99,95,101,98,83,85,30},16))
return
end
local Window = Rayfield:CreateWindow({
Name = _d({55,64,63,16,68,103,85,85,94,16,22,16,54,92,89,87,88,100,16,67,101,89,100,85},16),
LoadingTitle = _d({55,64,63,16,62,81,102,89,87,81,100,95,98},16),
LoadingSubtitle = _d({66,81,105,86,89,85,92,84,16,69,57,16,70,85,98,99,89,95,94},16),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.GPOTweenLibrary = Rayfield
local MainTab = Window:CreateTab(_d({68,98,81,102,85,92,16,51,95,94,100,98,95,92,99},16), 4483362458)
local posParagraph = MainTab:CreateParagraph({
Title = _d({51,101,98,98,85,94,100,16,64,95,99,89,100,89,95,94},16),
Content = _d({72,42,16,32,30,32,32,16,108,16,73,42,16,32,30,32,32,16,108,16,74,42,16,32,30,32,32},16)
})
task.spawn(function()
while _G.GPOTweenLibrary do
task.wait(0.2)
pcall(function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({72,42,16,21,30,34,86,16,108,16,73,42,16,21,30,34,86,16,108,16,74,42,16,21,30,34,86},16), pos.X, pos.Y, pos.Z)
updateRayfieldParagraph(posParagraph, _d({51,101,98,98,85,94,100,16,64,95,99,89,100,89,95,94},16), text)
end
end)
end
end)
MainTab:CreateButton({
Name = _d({51,95,96,105,16,51,101,98,98,85,94,100,16,51,95,95,98,84,89,94,81,100,85,99},16),
Callback = function()
local root = getRoot()
if root then
local pos = root.Position
local text = string.format(_d({21,30,34,86,28,16,21,30,34,86,28,16,21,30,34,86},16), pos.X, pos.Y, pos.Z)
if setclipboard then
pcall(setclipboard, text)
print(_d({75,55,64,63,16,68,103,85,85,94,77,16,51,95,96,89,85,84,16,83,95,95,98,84,89,94,81,100,85,99,16,100,95,16,83,92,89,96,82,95,81,98,84,42,16},16) .. text)
else
warn(_d({75,55,64,63,16,68,103,85,85,94,77,16,99,85,100,83,92,89,96,82,95,81,98,84,16,94,95,100,16,99,101,96,96,95,98,100,85,84,16,82,105,16,85,104,85,83,101,100,95,98,17},16))
end
end
end,
})
MainTab:CreateInput({
Name = _d({68,81,98,87,85,100,16,51,95,95,98,84,89,94,81,100,85,99,16,24,72,28,16,73,28,16,74,25},16),
PlaceholderText = _d({53,104,81,93,96,92,85,42,16,33,34,32,30,37,28,16,36,32,30,34,28,16,29,33,32,35,32,30,32},16),
RemoveTextAfterFocusLost = false,
Callback = function(val)
local x, y, z = string.match(val, _d({24,75,21,84,21,30,21,29,77,27,25,21,99,26,21,28,47,21,99,26,24,75,21,84,21,30,21,29,77,27,25,21,99,26,21,28,47,21,99,26,24,75,21,84,21,30,21,29,77,27,25},16))
if x and y and z then
targetX = tonumber(x)
targetY = tonumber(y)
targetZ = tonumber(z)
print(string.format(_d({75,55,64,63,16,68,103,85,85,94,77,16,67,85,100,16,84,85,99,100,89,94,81,100,89,95,94,16,100,81,98,87,85,100,16,100,95,42,16,21,30,34,86,28,16,21,30,34,86,28,16,21,30,34,86},16), targetX, targetY, targetZ))
end
end,
})
MainTab:CreateToggle({
Name = _d({67,100,81,98,100,16,57,99,92,81,94,84,16,68,98,81,102,85,92},16),
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
Name = _d({53,94,81,82,92,85,16,71,49,67,52,16,54,92,89,87,88,100},16),
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
Name = _d({68,98,81,102,85,92,16,22,16,54,92,89,87,88,100,16,67,96,85,85,84},16),
Range = {10, 150},
Increment = 1,
Suffix = _d({16,99,100,101,84,99,31,99,85,83},16),
CurrentValue = 70,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({52,85,99,100,98,95,105,16,69,57,16,22,16,67,100,95,96,16,53,102,85,98,105,100,88,89,94,87},16),
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
print(_d({75,55,64,63,16,68,103,85,85,94,77,16,51,92,85,81,94,85,84,16,101,96,16,81,94,84,16,84,85,99,100,98,95,105,85,84,16,66,81,105,86,89,85,92,84,16,69,57,30},16))
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
print(_d({75,55,64,63,16,68,103,85,85,94,16,68,85,99,100,85,98,77,16,92,95,81,84,85,84,16,103,89,100,88,16,85,93,85,98,87,85,94,83,105,16,99,100,95,96,16,91,85,105,16,75,64,77,30},16))
end)()