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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,61,83,92,83,95,93,61,89,80,94,97,75,92,79,54,94,78,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79,24,86,95,75},22),
_d({82,94,94,90,93,36,25,25,93,83,92,83,95,93,24,87,79,88,95,25,92,75,99,80,83,79,86,78},22),
_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,93,82,86,79,98,97,75,92,79,25,60,75,99,80,83,79,86,78,25,87,75,83,88,25,93,89,95,92,77,79},22)
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
error(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,60,75,99,80,83,79,86,78,10,63,51,10,54,83,76,92,75,92,99,24},22))
end
local Window = Rayfield:CreateWindow({
Name = _d({49,79,90,89,10,49,92,83,88,78,79,92,10,16,10,48,86,83,81,82,94,10,50,95,76},22),
LoadingTitle = _d({54,89,75,78,83,88,81,10,49,79,90,90,89,10,61,95,83,94,79,24,24,24},22),
LoadingSubtitle = _d({57,90,94,83,87,83,100,79,78,10,49,92,83,88,78},22),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({44,75,88,78,83,94},22)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local lastGeppoTime = 0
local farmAnchor = nil
local spawnCoordinates = {}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({61,94,75,94,93},22)) and statsFolder.Stats:FindFirstChild(_d({58,79,86,83},22)) then
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
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,60,79,81,83,93,94,79,92,79,78,10,93,90,75,97,88,10,77,89,89,92,78,83,88,75,94,79,36},22), pos)
return pos
end
local function updateAndGetTargets()
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum = npc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
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
if part:IsA(_d({44,75,93,79,58,75,92,94},22)) then
part.CanCollide = enabled
end
end
end
local function simulateM1()
pcall(function()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.01)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,43,94,94},22)) or Instance.new(_d({43,94,94,75,77,82,87,79,88,94},22))
att.Name = _d({73,73,49,92,83,88,78,79,92,43,94,94},22)
att.Parent = root
local force = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22))
if not force then
force = Instance.new(_d({54,83,88,79,75,92,64,79,86,89,77,83,94,99},22))
force.Name = _d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22)
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
local force = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22))
local att = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,43,94,94},22))
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
pcall(setCharacterCollision, false)
if myHum then
pcall(function() myHum.PlatformStand = true end)
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,43,95,94,89,10,48,75,92,87,10,47,56,43,44,54,47,46},22))
else
cleanupForce()
pcall(setCharacterCollision, true)
if myHum then
pcall(function() myHum.PlatformStand = false end)
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,43,95,94,89,10,48,75,92,87,10,46,51,61,43,44,54,47,46},22))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({56,89,88,79},22)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({60,89,85,95,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,79,90,90,89},22), args)
elseif style == _d({44,86,75,77,85,54,79,81},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85},22), args)
elseif style == _d({53,75,87,83,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,75,87,83,93,82,83,85,83,49,79,90,90,89},22), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85,28},22), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.5)
if autoGrind then
pcall(function()
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
local root = npc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if root then
table.insert(activeSpawns, root.Position)
end
end
end
local n = #activeSpawns
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
local combatTool = bp and bp:FindFirstChild(_d({45,89,87,76,75,94},22))
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
end)
end
end
end)
task.spawn(function()
while autoFlight ~= nil do
task.wait(0.05)
if autoFlight then
pcall(function()
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
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
autoFlight = nil
cleanupForce()
pcall(setCharacterCollision, true)
local myHum = getHumanoid()
if myHum then
pcall(function() myHum.PlatformStand = false end)
end
pcall(function() Rayfield:Destroy() end)
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,45,86,79,75,88,79,78,10,95,90,10,90,92,79,96,83,89,95,93,10,93,79,93,93,83,89,88,24},22))
end
local MainTab = Window:CreateTab(_d({43,95,94,89,10,48,75,92,87},22), 4483362458)
local FlightTab = Window:CreateTab(_d({61,75,80,79,10,48,86,83,81,82,94},22), 4483362458)
MainTab:CreateDropdown({
Name = _d({61,79,86,79,77,94,10,55,89,76,10,62,75,92,81,79,94},22),
Options = {_d({44,75,88,78,83,94},22), _d({44,75,88,78,83,94,10,44,89,93,93},22), _d({46,75,90,82},22), _d({50,75,85,95},22), _d({54,83,86,99},22), _d({54,83,89,88,10,58,92,83,78,79},22), _d({55,75,92,91,95,75,88},22), _d({60,89,76,89},22), _d({60,89,88,88,99},22), _d({61,75,92,75,82},22)},
CurrentOption = _d({44,75,88,78,83,94},22),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
spawnCoordinates = {}
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,62,75,92,81,79,94,10,93,79,94,10,94,89,36},22), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({43,95,94,89,10,49,92,83,88,78,10,55,89,76,93,10,18,57,92,10,58,92,79,93,93,10,58,10,53,79,99,19},22),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({50,89,96,79,92,10,50,79,83,81,82,94,10,43,76,89,96,79,10,55,89,76},22),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({10,93,94,95,78,93},22),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({58,79,86,83,36,10,26},22), Content = _d({49,79,90,90,89,10,58,95,92,77,82,75,93,79,10,45,89,93,94,36,10,31,26,22,26,26,26,10,58,79,86,83},22)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({58,79,86,83,36,10},22) .. tostring(peli),
Content = peli >= 50000 and _d({218,137,120,115,10,31,26,22,26,26,26,10,58,79,86,83,10,60,79,75,77,82,79,78,11,10,60,79,75,78,99,10,94,89,10,90,95,92,77,82,75,93,79,10,49,79,90,90,89,24},22) or _d({49,92,83,88,78,83,88,81,10,58,79,86,83,24,24,24},22)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({51,88,80,83,88,83,94,79,10,49,79,90,90,89,10,48,86,99},22),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,51,88,80,83,88,83,94,79,10,48,86,83,81,82,94,36},22), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({48,86,83,81,82,94,10,61,90,79,79,78},22),
Range = {10, 150},
Increment = 5,
Suffix = _d({10,93,94,95,78,93,25,93},22),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({46,79,93,94,92,89,99,10,63,51},22),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,10,50,95,76,71,10,54,89,75,78,79,78,10,93,95,77,77,79,93,93,80,95,86,86,99,24},22))
end)()