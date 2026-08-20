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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,30,52,61,52,64,62,30,58,49,63,66,44,61,48,23,63,47,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48,249,55,64,44},53),
_d({51,63,63,59,62,5,250,250,62,52,61,52,64,62,249,56,48,57,64,250,61,44,68,49,52,48,55,47},53),
_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,62,51,55,48,67,66,44,61,48,250,29,44,68,49,52,48,55,47,250,56,44,52,57,250,62,58,64,61,46,48},53)
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
error(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,29,44,68,49,52,48,55,47,235,32,20,235,23,52,45,61,44,61,68,249},53))
end
local Window = Rayfield:CreateWindow({
Name = _d({18,48,59,58,235,18,61,52,57,47,48,61,235,241,235,17,55,52,50,51,63,235,19,64,45},53),
LoadingTitle = _d({23,58,44,47,52,57,50,235,18,48,59,59,58,235,30,64,52,63,48,249,249,249},53),
LoadingSubtitle = _d({26,59,63,52,56,52,69,48,47,235,18,61,52,57,47},53),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({13,44,57,47,52,63},53)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({30,63,44,63,62},53)) and statsFolder.Stats:FindFirstChild(_d({27,48,55,52},53)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({25,27,14,62},53))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local hum = npc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({25,58,57,48},53)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({29,58,54,64,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,48,59,59,58},53), args)
elseif style == _d({13,55,44,46,54,23,48,50},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54},53), args)
elseif style == _d({22,44,56,52,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,44,56,52,62,51,52,54,52,18,48,59,59,58},53), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54,253},53), args)
end
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,12,63,63},53)) or Instance.new(_d({12,63,63,44,46,51,56,48,57,63},53))
att.Name = _d({42,42,18,61,52,57,47,48,61,12,63,63},53)
att.Parent = root
local force = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53))
if not force then
force = Instance.new(_d({23,52,57,48,44,61,33,48,55,58,46,52,63,68},53))
force.Name = _d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53)
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
local force = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53))
local att = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,12,63,63},53))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53)) or (targetNPC:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) and targetNPC:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health <= 0) then
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if targetRoot then
local bp = LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
local combatTool = bp and bp:FindFirstChild(_d({14,58,56,45,44,63},53))
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
local UIS = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
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
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,14,55,48,44,57,48,47,235,64,59,235,59,61,48,65,52,58,64,62,235,62,48,62,62,52,58,57,249},53))
end
local MainTab = Window:CreateTab(_d({12,64,63,58,235,17,44,61,56},53), 4483362458)
local FlightTab = Window:CreateTab(_d({30,44,49,48,235,17,55,52,50,51,63},53), 4483362458)
MainTab:CreateDropdown({
Name = _d({30,48,55,48,46,63,235,24,58,45,235,31,44,61,50,48,63},53),
Options = {_d({13,44,57,47,52,63},53), _d({13,44,57,47,52,63,235,13,58,62,62},53), _d({15,44,59,51},53), _d({19,44,54,64},53), _d({23,52,55,68},53), _d({23,52,58,57,235,27,61,52,47,48},53), _d({24,44,61,60,64,44,57},53), _d({29,58,45,58},53), _d({29,58,57,57,68},53), _d({30,44,61,44,51},53)},
CurrentOption = _d({13,44,57,47,52,63},53),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,31,44,61,50,48,63,235,62,48,63,235,63,58,5},53), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({12,64,63,58,235,18,61,52,57,47,235,24,58,45,62},53),
CurrentValue = false,
Callback = function(Value)
autoGrind = Value
if not autoGrind then
cleanupForce()
end
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,12,64,63,58,235,18,61,52,57,47,5},53), autoGrind)
end,
})
MainTab:CreateSlider({
Name = _d({19,58,65,48,61,235,19,48,52,50,51,63,235,12,45,58,65,48,235,24,58,45},53),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({235,62,63,64,47,62},53),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({27,48,55,52,5,235,251},53), Content = _d({18,48,59,59,58,235,27,64,61,46,51,44,62,48,235,14,58,62,63,5,235,0,251,247,251,251,251,235,27,48,55,52},53)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({27,48,55,52,5,235},53) .. tostring(peli),
Content = peli >= 50000 and _d({187,106,89,84,235,0,251,247,251,251,251,235,27,48,55,52,235,29,48,44,46,51,48,47,236,235,29,48,44,47,68,235,63,58,235,59,64,61,46,51,44,62,48,235,18,48,59,59,58,249},53) or _d({18,61,52,57,47,52,57,50,235,27,48,55,52,249,249,249},53)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({20,57,49,52,57,52,63,48,235,18,48,59,59,58,235,17,55,68},53),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,20,57,49,52,57,52,63,48,235,17,55,52,50,51,63,5},53), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({17,55,52,50,51,63,235,30,59,48,48,47},53),
Range = {10, 150},
Increment = 5,
Suffix = _d({235,62,63,64,47,62,250,62},53),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({15,48,62,63,61,58,68,235,32,20},53),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,235,19,64,45,40,235,23,58,44,47,48,47,235,62,64,46,46,48,62,62,49,64,55,55,68,249},53))
end)()