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
local Players = game:GetService(_d({16,44,33,57,37,50,51},64))
local ReplicatedStorage = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local RunService = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local VIM = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,19,41,50,41,53,51,19,47,38,52,55,33,50,37,12,52,36,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37,238,44,53,33},64),
_d({40,52,52,48,51,250,239,239,51,41,50,41,53,51,238,45,37,46,53,239,50,33,57,38,41,37,44,36},64),
_d({40,52,52,48,51,250,239,239,50,33,55,238,39,41,52,40,53,34,53,51,37,50,35,47,46,52,37,46,52,238,35,47,45,239,51,40,44,37,56,55,33,50,37,239,18,33,57,38,41,37,44,36,239,45,33,41,46,239,51,47,53,50,35,37},64)
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
error(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,6,33,41,44,37,36,224,52,47,224,44,47,33,36,224,18,33,57,38,41,37,44,36,224,21,9,224,12,41,34,50,33,50,57,238},64))
end
local Window = Rayfield:CreateWindow({
Name = _d({7,37,48,47,224,7,50,41,46,36,37,50,224,230,224,6,44,41,39,40,52,224,8,53,34},64),
LoadingTitle = _d({12,47,33,36,41,46,39,224,7,37,48,48,47,224,19,53,41,52,37,238,238,238},64),
LoadingSubtitle = _d({15,48,52,41,45,41,58,37,36,224,7,50,41,46,36},64),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({2,33,46,36,41,52},64)
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
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({19,52,33,52,51},64)) and statsFolder.Stats:FindFirstChild(_d({16,37,44,41},64)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function hasGeppo()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({19,52,33,52,51},64)) and statsFolder.Stats:FindFirstChild(_d({6,41,39,40,52,41,46,39,19,52,57,44,37},64)) then
local style = statsFolder.Stats.FightingStyle.Value
if style == _d({18,47,43,53,51,40,41,43,41},64) or style == _d({2,44,33,35,43,12,37,39},64) or style == _d({11,33,45,41,51,40,41,43,41},64) then
return true
end
end
return false
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({14,16,3,51},64))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local hum = npc:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({14,47,46,37},64)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({18,47,43,53,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({7,37,48,48,47},64), args)
elseif style == _d({2,44,33,35,43,12,37,39},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43},64), args)
elseif style == _d({11,33,45,41,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,33,45,41,51,40,41,43,41,7,37,48,48,47},64), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43,242},64), args)
end
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({31,31,7,50,41,46,36,37,50,1,52,52},64)) or Instance.new(_d({1,52,52,33,35,40,45,37,46,52},64))
att.Name = _d({31,31,7,50,41,46,36,37,50,1,52,52},64)
att.Parent = root
local force = root:FindFirstChild(_d({31,31,7,50,41,46,36,37,50,6,47,50,35,37},64))
if not force then
force = Instance.new(_d({12,41,46,37,33,50,22,37,44,47,35,41,52,57},64))
force.Name = _d({31,31,7,50,41,46,36,37,50,6,47,50,35,37},64)
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
local force = root:FindFirstChild(_d({31,31,7,50,41,46,36,37,50,6,47,50,35,37},64))
local att = root:FindFirstChild(_d({31,31,7,50,41,46,36,37,50,1,52,52},64))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64)) or (targetNPC:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)) and targetNPC:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64)).Health <= 0) then
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if targetRoot then
local bp = LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
local combatTool = bp and bp:FindFirstChild(_d({3,47,45,34,33,52},64))
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
local UIS = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
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
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,3,44,37,33,46,37,36,224,53,48,224,48,50,37,54,41,47,53,51,224,51,37,51,51,41,47,46,238},64))
end
local MainTab = Window:CreateTab(_d({1,53,52,47,224,6,33,50,45},64), 4483362458)
local FlightTab = Window:CreateTab(_d({19,33,38,37,224,6,44,41,39,40,52},64), 4483362458)
MainTab:CreateInput({
Name = _d({19,37,44,37,35,52,224,13,47,34,224,20,33,50,39,37,52},64),
PlaceholderText = _d({13,47,34,224,14,33,45,37,224,232,37,238,39,238,224,2,33,46,36,41,52,233},64),
RemoveTextAfterFocusLost = false,
Callback = function(Text)
selectedMob = Text
targetNPC = nil
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,20,33,50,39,37,52,224,51,37,52,224,52,47,250},64), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({1,53,52,47,224,7,50,41,46,36,224,13,47,34,51},64),
CurrentValue = false,
Callback = function(Value)
autoGrind = Value
if not autoGrind then
cleanupForce()
end
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,1,53,52,47,224,7,50,41,46,36,250},64), autoGrind)
end,
})
MainTab:CreateSlider({
Name = _d({8,47,54,37,50,224,8,37,41,39,40,52,224,1,34,47,54,37,224,13,47,34},64),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({224,51,52,53,36,51},64),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({16,37,44,41,250,224,240},64), Content = _d({7,37,48,48,47,224,16,53,50,35,40,33,51,37,224,3,47,51,52,250,224,245,240,236,240,240,240,224,16,37,44,41},64)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({16,37,44,41,250,224},64) .. tostring(peli),
Content = peli >= 50000 and _d({176,95,78,73,224,245,240,236,240,240,240,224,16,37,44,41,224,18,37,33,35,40,37,36,225,224,18,37,33,36,57,224,52,47,224,48,53,50,35,40,33,51,37,224,7,37,48,48,47,238},64) or _d({7,50,41,46,36,41,46,39,224,16,37,44,41,238,238,238},64)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({9,46,38,41,46,41,52,37,224,7,37,48,48,47,224,6,44,57},64),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,29,224,9,46,38,41,46,41,52,37,224,6,44,41,39,40,52,250},64), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({6,44,41,39,40,52,224,19,48,37,37,36},64),
Range = {10, 150},
Increment = 5,
Suffix = _d({224,51,52,53,36,51,239,51},64),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({4,37,51,52,50,47,57,224,21,9},64),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({27,7,37,48,47,224,7,50,41,46,36,37,50,224,8,53,34,29,224,12,47,33,36,37,36,224,51,53,35,35,37,51,51,38,53,44,44,57,238},64))
end)()