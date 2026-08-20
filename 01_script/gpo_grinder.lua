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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,29,51,60,51,63,61,29,57,48,62,65,43,60,47,22,62,46,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54),
_d({50,62,62,58,61,4,249,249,61,51,60,51,63,61,248,55,47,56,63,249,60,43,67,48,51,47,54,46},54),
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,61,50,54,47,66,65,43,60,47,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47},54)
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
error(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,22,51,44,60,43,60,67,248},54))
end
local Window = Rayfield:CreateWindow({
Name = _d({17,47,58,57,234,17,60,51,56,46,47,60,234,240,234,16,54,51,49,50,62,234,18,63,44},54),
LoadingTitle = _d({22,57,43,46,51,56,49,234,17,47,58,58,57,234,29,63,51,62,47,248,248,248},54),
LoadingSubtitle = _d({25,58,62,51,55,51,68,47,46,234,17,60,51,56,46},54),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({12,43,56,46,51,62},54)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({29,62,43,62,61},54)) and statsFolder.Stats:FindFirstChild(_d({26,47,54,51},54)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = npc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({12,43,61,47,26,43,60,62},54)) then
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
local att = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,11,62,62},54)) or Instance.new(_d({11,62,62,43,45,50,55,47,56,62},54))
att.Name = _d({41,41,17,60,51,56,46,47,60,11,62,62},54)
att.Parent = root
local force = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54))
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = _d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54)
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
if not autoGrind and not autoFlight then
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54))
local att = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,11,62,62},54))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
end
local function computeLookDownCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function computeLockedCFrame(root, aimPos, facePos)
return computeLookDownCFrame(root, facePos) + (aimPos - root.Position)
end
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if not autoGrind then
cleanupForce()
if targetNPC then
pcall(setNPCPartsCollision, targetNPC, true)
end
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({24,57,56,47},54)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
pcall(function()
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54)) or (targetNPC:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)) and targetNPC:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health <= 0) then
if targetNPC then
pcall(setNPCPartsCollision, targetNPC, true)
end
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if targetRoot then
setNPCPartsCollision(targetNPC, false)
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local combatTool = bp and bp:FindFirstChild(_d({13,57,55,44,43,62},54))
if combatTool then
myHum:EquipTool(combatTool)
end
local targetPos = targetRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 60)) or Vector3.zero
force.VectorVelocity = velocityVec
if dir.Magnitude < 10 then
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, targetRoot.Position)
simulateM1()
end
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
if targetNPC then
pcall(setNPCPartsCollision, targetNPC, true)
end
pcall(function() Rayfield:Destroy() end)
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,13,54,47,43,56,47,46,234,63,58,234,58,60,47,64,51,57,63,61,234,61,47,61,61,51,57,56,248},54))
end
local MainTab = Window:CreateTab(_d({11,63,62,57,234,16,43,60,55},54), 4483362458)
local FlightTab = Window:CreateTab(_d({29,43,48,47,234,16,54,51,49,50,62},54), 4483362458)
MainTab:CreateDropdown({
Name = _d({29,47,54,47,45,62,234,23,57,44,234,30,43,60,49,47,62},54),
Options = {_d({12,43,56,46,51,62},54), _d({12,43,56,46,51,62,234,12,57,61,61},54), _d({14,43,58,50},54), _d({18,43,53,63},54), _d({22,51,54,67},54), _d({22,51,57,56,234,26,60,51,46,47},54), _d({23,43,60,59,63,43,56},54), _d({28,57,44,57},54), _d({28,57,56,56,67},54), _d({29,43,60,43,50},54)},
CurrentOption = _d({12,43,56,46,51,62},54),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,30,43,60,49,47,62,234,61,47,62,234,62,57,4},54), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({11,63,62,57,234,17,60,51,56,46,234,23,57,44,61,234,242,25,60,234,26,60,47,61,61,234,26,234,21,47,67,243},54),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({18,57,64,47,60,234,18,47,51,49,50,62,234,11,44,57,64,47,234,23,57,44},54),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({234,61,62,63,46,61},54),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({26,47,54,51,4,234,250},54), Content = _d({17,47,58,58,57,234,26,63,60,45,50,43,61,47,234,13,57,61,62,4,234,255,250,246,250,250,250,234,26,47,54,51},54)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({26,47,54,51,4,234},54) .. tostring(peli),
Content = peli >= 50000 and _d({186,105,88,83,234,255,250,246,250,250,250,234,26,47,54,51,234,28,47,43,45,50,47,46,235,234,28,47,43,46,67,234,62,57,234,58,63,60,45,50,43,61,47,234,17,47,58,58,57,248},54) or _d({17,60,51,56,46,51,56,49,234,26,47,54,51,248,248,248},54)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({19,56,48,51,56,51,62,47,234,17,47,58,58,57,234,16,54,67},54),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,19,56,48,51,56,51,62,47,234,16,54,51,49,50,62,4},54), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({16,54,51,49,50,62,234,29,58,47,47,46},54),
Range = {10, 150},
Increment = 5,
Suffix = _d({234,61,62,63,46,61,249,61},54),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,31,19},54),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,234,18,63,44,39,234,22,57,43,46,47,46,234,61,63,45,45,47,61,61,48,63,54,54,67,248},54))
end)()