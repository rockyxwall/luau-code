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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,47,69,78,69,81,79,47,75,66,80,83,61,78,65,40,80,64,11,46,61,85,66,69,65,72,64,11,73,61,69,74,11,79,75,81,78,63,65,10,72,81,61},36),
_d({68,80,80,76,79,22,11,11,79,69,78,69,81,79,10,73,65,74,81,11,78,61,85,66,69,65,72,64},36),
_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,79,68,72,65,84,83,61,78,65,11,46,61,85,66,69,65,72,64,11,73,61,69,74,11,79,75,81,78,63,65},36)
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
error(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,252,46,61,85,66,69,65,72,64,252,49,37,252,40,69,62,78,61,78,85,10},36))
end
local Window = Rayfield:CreateWindow({
Name = _d({35,65,76,75,252,35,78,69,74,64,65,78,252,2,252,34,72,69,67,68,80,252,36,81,62},36),
LoadingTitle = _d({40,75,61,64,69,74,67,252,35,65,76,76,75,252,47,81,69,80,65,10,10,10},36),
LoadingSubtitle = _d({43,76,80,69,73,69,86,65,64,252,35,78,69,74,64},36),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({30,61,74,64,69,80},36)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local lastGeppoTime = 0
local farmAnchor = nil
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({47,80,61,80,79},36)) and statsFolder.Stats:FindFirstChild(_d({44,65,72,69},36)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({42,44,31,79},36))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum = npc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function getClusterCentroid(targets, anchor, maxDist)
local sum = Vector3.zero
local count = 0
for _, npc in ipairs(targets) do
local root = npc:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if root then
local dist = (root.Position - anchor).Magnitude
if dist <= maxDist then
sum = sum + root.Position
count = count + 1
end
end
end
if count > 0 then
return sum / count
end
return anchor
end
local function setCharacterCollision(enabled)
local char = LocalPlayer.Character
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
part.CanCollide = enabled
end
end
end
local function simulateM1()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.01)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({59,59,35,78,69,74,64,65,78,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,35,78,69,74,64,65,78,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,35,78,69,74,64,65,78,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,35,78,69,74,64,65,78,34,75,78,63,65},36)
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
local force = root:FindFirstChild(_d({59,59,35,78,69,74,64,65,78,34,75,78,63,65},36))
local att = root:FindFirstChild(_d({59,59,35,78,69,74,64,65,78,29,80,80},36))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if autoGrind then
local myRoot = getRoot()
if myRoot then
farmAnchor = myRoot.Position
end
setCharacterCollision(false)
Rayfield:Notify({
Title = _d({29,81,80,75,252,34,61,78,73,252,47,80,61,80,81,79},36),
Content = _d({29,81,80,75,252,34,61,78,73,252,69,79,252,74,75,83,252,33,42,29,30,40,33,32,10},36),
Duration = 2,
Image = 4483362458
})
else
cleanupForce()
setCharacterCollision(true)
Rayfield:Notify({
Title = _d({29,81,80,75,252,34,61,78,73,252,47,80,61,80,81,79},36),
Content = _d({29,81,80,75,252,34,61,78,73,252,69,79,252,74,75,83,252,32,37,47,29,30,40,33,32,10},36),
Duration = 2,
Image = 4483362458
})
end
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
toggleAutoFarm()
end
end)
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({42,75,74,65},36)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
setCharacterCollision(false)
local targets = getActiveTargetNPCs()
if #targets > 0 then
local bp = LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
local combatTool = bp and bp:FindFirstChild(_d({31,75,73,62,61,80},36))
if combatTool then
myHum:EquipTool(combatTool)
end
local centroid = getClusterCentroid(targets, farmAnchor or myRoot.Position, 250)
local targetPos = centroid + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 60)) or Vector3.zero
force.VectorVelocity = velocityVec
if dir.Magnitude < 12 then
simulateM1()
end
else
if farmAnchor then
local targetPos = farmAnchor + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
force.VectorVelocity = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 50)) or Vector3.zero
else
cleanupForce()
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
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
setCharacterCollision(true)
pcall(function() Rayfield:Destroy() end)
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,31,72,65,61,74,65,64,252,81,76,252,76,78,65,82,69,75,81,79,252,79,65,79,79,69,75,74,10},36))
end
local MainTab = Window:CreateTab(_d({29,81,80,75,252,34,61,78,73},36), 4483362458)
local FlightTab = Window:CreateTab(_d({47,61,66,65,252,34,72,69,67,68,80},36), 4483362458)
MainTab:CreateDropdown({
Name = _d({47,65,72,65,63,80,252,41,75,62,252,48,61,78,67,65,80},36),
Options = {_d({30,61,74,64,69,80},36), _d({30,61,74,64,69,80,252,30,75,79,79},36), _d({32,61,76,68},36), _d({36,61,71,81},36), _d({40,69,72,85},36), _d({40,69,75,74,252,44,78,69,64,65},36), _d({41,61,78,77,81,61,74},36), _d({46,75,62,75},36), _d({46,75,74,74,85},36), _d({47,61,78,61,68},36)},
CurrentOption = _d({30,61,74,64,69,80},36),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,48,61,78,67,65,80,252,79,65,80,252,80,75,22},36), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({29,81,80,75,252,35,78,69,74,64,252,41,75,62,79,252,4,43,78,252,44,78,65,79,79,252,44,252,39,65,85,5},36),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({36,75,82,65,78,252,36,65,69,67,68,80,252,29,62,75,82,65,252,41,75,62},36),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({252,79,80,81,64,79},36),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({44,65,72,69,22,252,12},36), Content = _d({35,65,76,76,75,252,44,81,78,63,68,61,79,65,252,31,75,79,80,22,252,17,12,8,12,12,12,252,44,65,72,69},36)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({44,65,72,69,22,252},36) .. tostring(peli),
Content = peli >= 50000 and _d({204,123,106,101,252,17,12,8,12,12,12,252,44,65,72,69,252,46,65,61,63,68,65,64,253,252,46,65,61,64,85,252,80,75,252,76,81,78,63,68,61,79,65,252,35,65,76,76,75,10},36) or _d({35,78,69,74,64,69,74,67,252,44,65,72,69,10,10,10},36)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({37,74,66,69,74,69,80,65,252,35,65,76,76,75,252,34,72,85},36),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,37,74,66,69,74,69,80,65,252,34,72,69,67,68,80,22},36), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({34,72,69,67,68,80,252,47,76,65,65,64},36),
Range = {10, 150},
Increment = 5,
Suffix = _d({252,79,80,81,64,79,11,79},36),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({32,65,79,80,78,75,85,252,49,37},36),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,252,36,81,62,57,252,40,75,61,64,65,64,252,79,81,63,63,65,79,79,66,81,72,72,85,10},36))
end)()