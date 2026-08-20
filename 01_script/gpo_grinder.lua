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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,38,60,69,60,72,70,38,66,57,71,74,52,69,56,31,71,55,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56,1,63,72,52},45),
_d({59,71,71,67,70,13,2,2,70,60,69,60,72,70,1,64,56,65,72,2,69,52,76,57,60,56,63,55},45),
_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,70,59,63,56,75,74,52,69,56,2,37,52,76,57,60,56,63,55,2,64,52,60,65,2,70,66,72,69,54,56},45)
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
error(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,37,52,76,57,60,56,63,55,243,40,28,243,31,60,53,69,52,69,76,1},45))
end
local Window = Rayfield:CreateWindow({
Name = _d({26,56,67,66,243,26,69,60,65,55,56,69,243,249,243,25,63,60,58,59,71,243,27,72,53},45),
LoadingTitle = _d({31,66,52,55,60,65,58,243,26,56,67,67,66,243,38,72,60,71,56,1,1,1},45),
LoadingSubtitle = _d({34,67,71,60,64,60,77,56,55,243,26,69,60,65,55},45),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({21,52,65,55,60,71},45)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local lastGeppoTime = 0
local farmAnchor = nil
local spawnCoordinates = {}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({38,71,52,71,70},45)) and statsFolder.Stats:FindFirstChild(_d({35,56,63,60},45)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function registerSpawnPosition(pos)
for _, cachedPos in ipairs(spawnCoordinates) do
if (cachedPos - pos).Magnitude < 15 then
return cachedPos
end
end
table.insert(spawnCoordinates, pos)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,37,56,58,60,70,71,56,69,56,55,243,70,67,52,74,65,243,54,66,66,69,55,60,65,52,71,56,13},45), pos)
return pos
end
local function updateAndGetTargets()
local npcsFolder = Workspace:FindFirstChild(_d({33,35,22,70},45))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hum = npc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if root and hum and hum.Health > 0 then
if hum.Health == hum.MaxHealth then
registerSpawnPosition(root.Position)
end
table.insert(targets, npc)
end
end
end
return targets
end
local function setCharacterCollision(enabled)
local char = LocalPlayer.Character
if not char then return end
for _, part in ipairs(char:GetDescendants()) do
if part:IsA(_d({21,52,70,56,35,52,69,71},45)) then
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
local att = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,26,69,60,65,55,56,69,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45)
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
local force = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45))
local att = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,20,71,71},45))
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
local myHum = getHumanoid()
if autoGrind then
local myRoot = getRoot()
if myRoot then
farmAnchor = myRoot.Position
end
setCharacterCollision(false)
if myHum then
myHum.PlatformStand = true
end
Rayfield:Notify({
Title = _d({20,72,71,66,243,25,52,69,64,243,38,71,52,71,72,70},45),
Content = _d({20,72,71,66,243,25,52,69,64,243,60,70,243,65,66,74,243,24,33,20,21,31,24,23,1},45),
Duration = 2,
Image = 4483362458
})
else
cleanupForce()
setCharacterCollision(true)
if myHum then
myHum.PlatformStand = false
end
Rayfield:Notify({
Title = _d({20,72,71,66,243,25,52,69,64,243,38,71,52,71,72,70},45),
Content = _d({20,72,71,66,243,25,52,69,64,243,60,70,243,65,66,74,243,23,28,38,20,21,31,24,23,1},45),
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({33,66,65,56},45)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({37,66,62,72,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,56,67,67,66},45), args)
elseif style == _d({21,63,52,54,62,31,56,58},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62},45), args)
elseif style == _d({30,52,64,60,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,52,64,60,70,59,60,62,60,26,56,67,67,66},45), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62,5},45), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.5)
if autoGrind then
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
setCharacterCollision(false)
myHum.PlatformStand = true
local targets = updateAndGetTargets()
local activeSpawns = {}
if #spawnCoordinates > 0 then
for _, pos in ipairs(spawnCoordinates) do
table.insert(activeSpawns, pos)
end
else
for _, npc in ipairs(targets) do
local root = npc:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if root then
table.insert(activeSpawns, root.Position)
end
end
end
local n = #activeSpawns
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
local combatTool = bp and bp:FindFirstChild(_d({22,66,64,53,52,71},45))
if combatTool then
myHum:EquipTool(combatTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local targetPos = activeSpawns[i] + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 3 do
local dir = (targetPos - myRoot.Position)
force.VectorVelocity = dir.Unit * 60
task.wait(0.05)
end
if autoGrind then
simulateM1()
task.wait(0.15)
end
end
end
if autoGrind then
local finalSpawn = activeSpawns[n]
local finalTargetPos = finalSpawn + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 4 do
local dir = (finalTargetPos - myRoot.Position)
force.VectorVelocity = dir.Unit * 60
task.wait(0.05)
end
force.VectorVelocity = Vector3.zero
local combatStartTime = tick()
while autoGrind and (tick() - combatStartTime) < 8 do
local dir = (finalTargetPos - myRoot.Position)
force.VectorVelocity = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 50)) or Vector3.zero
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
end
end
else
cleanupForce()
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
local myHum = getHumanoid()
if myHum then
myHum.PlatformStand = false
end
pcall(function() Rayfield:Destroy() end)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,22,63,56,52,65,56,55,243,72,67,243,67,69,56,73,60,66,72,70,243,70,56,70,70,60,66,65,1},45))
end
local MainTab = Window:CreateTab(_d({20,72,71,66,243,25,52,69,64},45), 4483362458)
local FlightTab = Window:CreateTab(_d({38,52,57,56,243,25,63,60,58,59,71},45), 4483362458)
MainTab:CreateDropdown({
Name = _d({38,56,63,56,54,71,243,32,66,53,243,39,52,69,58,56,71},45),
Options = {_d({21,52,65,55,60,71},45), _d({21,52,65,55,60,71,243,21,66,70,70},45), _d({23,52,67,59},45), _d({27,52,62,72},45), _d({31,60,63,76},45), _d({31,60,66,65,243,35,69,60,55,56},45), _d({32,52,69,68,72,52,65},45), _d({37,66,53,66},45), _d({37,66,65,65,76},45), _d({38,52,69,52,59},45)},
CurrentOption = _d({21,52,65,55,60,71},45),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
spawnCoordinates = {}
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,39,52,69,58,56,71,243,70,56,71,243,71,66,13},45), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({20,72,71,66,243,26,69,60,65,55,243,32,66,53,70,243,251,34,69,243,35,69,56,70,70,243,35,243,30,56,76,252},45),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({27,66,73,56,69,243,27,56,60,58,59,71,243,20,53,66,73,56,243,32,66,53},45),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({243,70,71,72,55,70},45),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({35,56,63,60,13,243,3},45), Content = _d({26,56,67,67,66,243,35,72,69,54,59,52,70,56,243,22,66,70,71,13,243,8,3,255,3,3,3,243,35,56,63,60},45)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({35,56,63,60,13,243},45) .. tostring(peli),
Content = peli >= 50000 and _d({195,114,97,92,243,8,3,255,3,3,3,243,35,56,63,60,243,37,56,52,54,59,56,55,244,243,37,56,52,55,76,243,71,66,243,67,72,69,54,59,52,70,56,243,26,56,67,67,66,1},45) or _d({26,69,60,65,55,60,65,58,243,35,56,63,60,1,1,1},45)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({28,65,57,60,65,60,71,56,243,26,56,67,67,66,243,25,63,76},45),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,28,65,57,60,65,60,71,56,243,25,63,60,58,59,71,13},45), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({25,63,60,58,59,71,243,38,67,56,56,55},45),
Range = {10, 150},
Increment = 5,
Suffix = _d({243,70,71,72,55,70,2,70},45),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({23,56,70,71,69,66,76,243,40,28},45),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,243,27,72,53,48,243,31,66,52,55,56,55,243,70,72,54,54,56,70,70,57,72,63,63,76,1},45))
end)()