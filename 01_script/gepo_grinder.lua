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
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,68,90,99,90,102,100,68,96,87,101,104,82,99,86,61,101,85,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86,31,93,102,82},15),
_d({89,101,101,97,100,43,32,32,100,90,99,90,102,100,31,94,86,95,102,32,99,82,106,87,90,86,93,85},15),
_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,100,89,93,86,105,104,82,99,86,32,67,82,106,87,90,86,93,85,32,94,82,90,95,32,100,96,102,99,84,86},15)
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
error(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,67,82,106,87,90,86,93,85,17,70,58,17,61,90,83,99,82,99,106,31},15))
end
local Window = Rayfield:CreateWindow({
Name = _d({56,86,97,96,17,56,99,90,95,85,86,99,17,23,17,55,93,90,88,89,101,17,57,102,83},15),
LoadingTitle = _d({61,96,82,85,90,95,88,17,56,86,97,97,96,17,68,102,90,101,86,31,31,31},15),
LoadingSubtitle = _d({64,97,101,90,94,90,107,86,85,17,56,99,90,95,85},15),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({51,82,95,85,90,101},15)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local savedCameraCF = nil
local savedCameraType = nil
local isCameraLocked = false
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({68,101,82,101,100},15)) and statsFolder.Stats:FindFirstChild(_d({65,86,93,90},15)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function hasGeppo()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({68,101,82,101,100},15)) and statsFolder.Stats:FindFirstChild(_d({55,90,88,89,101,90,95,88,68,101,106,93,86},15)) then
local style = statsFolder.Stats.FightingStyle.Value
if style == _d({67,96,92,102,100,89,90,92,90},15) or style == _d({51,93,82,84,92,61,86,88},15) or style == _d({60,82,94,90,100,89,90,92,90},15) then
return true
end
end
return false
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum = npc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if root and hum and hum.Health > 0 then
local dist = (myRoot.Position - root.Position).Magnitude
if dist < minDist then
minDist = dist
closest = npc
end
end
end
end
return closest
end
local function simulateM1()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.05)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({63,96,95,86},15)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({67,96,92,102,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,86,97,97,96},15), args)
elseif style == _d({51,93,82,84,92,61,86,88},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92},15), args)
elseif style == _d({60,82,94,90,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,82,94,90,100,89,90,92,90,56,86,97,97,96},15), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92,35},15), args)
end
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,56,99,90,95,85,86,99,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15)
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
local force = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15))
local att = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,50,101,101},15))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15)) or (targetNPC:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) and targetNPC:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health <= 0) then
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if targetRoot then
local bp = LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
local combatTool = bp and bp:FindFirstChild(_d({52,96,94,83,82,101},15))
if combatTool then
myHum:EquipTool(combatTool)
end
local targetPos = targetRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 60)) or Vector3.zero
force.VectorVelocity = velocityVec
if dir.Magnitude < 10 then
simulateM1()
end
end
else
cleanupForce()
end
end
end
end)
task.spawn(function()
while autoFlight ~= nil do
task.wait(0.05)
if autoFlight then
local myRoot = getRoot()
if myRoot then
local force = getOrCreateForce(myRoot)
local camera = Workspace.CurrentCamera
local moveDir = Vector3.zero
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local UIS = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
force.VectorVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
if moveDir.Magnitude > 0 then
invokeGeppo()
end
end
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
autoFlight = nil
cleanupForce()
pcall(function() Rayfield:Destroy() end)
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,52,93,86,82,95,86,85,17,102,97,17,97,99,86,103,90,96,102,100,17,100,86,100,100,90,96,95,31},15))
end
local MainTab = Window:CreateTab(_d({50,102,101,96,17,55,82,99,94},15), 4483362458)
local FlightTab = Window:CreateTab(_d({68,82,87,86,17,55,93,90,88,89,101},15), 4483362458)
MainTab:CreateInput({
Name = _d({68,86,93,86,84,101,17,62,96,83,17,69,82,99,88,86,101},15),
PlaceholderText = _d({62,96,83,17,63,82,94,86,17,25,86,31,88,31,17,51,82,95,85,90,101,26},15),
RemoveTextAfterFocusLost = false,
Callback = function(Text)
selectedMob = Text
targetNPC = nil
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,69,82,99,88,86,101,17,100,86,101,17,101,96,43},15), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({50,102,101,96,17,56,99,90,95,85,17,62,96,83,100},15),
CurrentValue = false,
Callback = function(Value)
autoGrind = Value
if not autoGrind then
cleanupForce()
end
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,50,102,101,96,17,56,99,90,95,85,43},15), autoGrind)
end,
})
MainTab:CreateSlider({
Name = _d({57,96,103,86,99,17,57,86,90,88,89,101,17,50,83,96,103,86,17,62,96,83},15),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({17,100,101,102,85,100},15),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({65,86,93,90,43,17,33},15), Content = _d({56,86,97,97,96,17,65,102,99,84,89,82,100,86,17,52,96,100,101,43,17,38,33,29,33,33,33,17,65,86,93,90},15)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({65,86,93,90,43,17},15) .. tostring(peli),
Content = peli >= 50000 and _d({225,144,127,122,17,38,33,29,33,33,33,17,65,86,93,90,17,67,86,82,84,89,86,85,18,17,67,86,82,85,106,17,101,96,17,97,102,99,84,89,82,100,86,17,56,86,97,97,96,31},15) or _d({56,99,90,95,85,90,95,88,17,65,86,93,90,31,31,31},15)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({58,95,87,90,95,90,101,86,17,56,86,97,97,96,17,55,93,106},15),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,58,95,87,90,95,90,101,86,17,55,93,90,88,89,101,43},15), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({55,93,90,88,89,101,17,68,97,86,86,85},15),
Range = {10, 150},
Increment = 5,
Suffix = _d({17,100,101,102,85,100,32,100},15),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({53,86,100,101,99,96,106,17,70,58},15),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,17,57,102,83,78,17,61,96,82,85,86,85,17,100,102,84,84,86,100,100,87,102,93,93,106,31},15))
end)()