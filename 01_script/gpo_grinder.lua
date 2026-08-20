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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,59,81,90,81,93,91,59,87,78,92,95,73,90,77,52,92,76,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24),
_d({80,92,92,88,91,34,23,23,91,81,90,81,93,91,22,85,77,86,93,23,90,73,97,78,81,77,84,76},24),
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,91,80,84,77,96,95,73,90,77,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77},24)
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
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({47,77,88,87,8,47,90,81,86,76,77,90,8,14,8,46,84,81,79,80,92,8,48,93,74},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,47,77,88,88,87,8,59,93,81,92,77,22,22,22},24),
LoadingSubtitle = _d({55,88,92,81,85,81,98,77,76,8,47,90,81,86,76},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({42,73,86,76,81,92},24)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({59,92,73,92,91},24)) and statsFolder.Stats:FindFirstChild(_d({56,77,84,81},24)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
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
if part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
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
local att = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,41,92,92},24)) or Instance.new(_d({41,92,92,73,75,80,85,77,86,92},24))
att.Name = _d({71,71,47,90,81,86,76,77,90,41,92,92},24)
att.Parent = root
local force = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24))
if not force then
force = Instance.new(_d({52,81,86,77,73,90,62,77,84,87,75,81,92,97},24))
force.Name = _d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24)
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
local force = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24))
local att = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,41,92,92},24))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({54,87,86,77},24)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({58,87,83,93,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,77,88,88,87},24), args)
elseif style == _d({42,84,73,75,83,52,77,79},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83},24), args)
elseif style == _d({51,73,85,81,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,73,85,81,91,80,81,83,81,47,77,88,88,87},24), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83,26},24), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24)) or (targetNPC:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and targetNPC:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health <= 0) then
if targetNPC then
pcall(setNPCPartsCollision, targetNPC, true)
end
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if targetRoot then
setNPCPartsCollision(targetNPC, false)
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
local combatTool = bp and bp:FindFirstChild(_d({43,87,85,74,73,92},24))
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
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
local MainTab = Window:CreateTab(_d({41,93,92,87,8,46,73,90,85},24), 4483362458)
local FlightTab = Window:CreateTab(_d({59,73,78,77,8,46,84,81,79,80,92},24), 4483362458)
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,53,87,74,8,60,73,90,79,77,92},24),
Options = {_d({42,73,86,76,81,92},24), _d({42,73,86,76,81,92,8,42,87,91,91},24), _d({44,73,88,80},24), _d({48,73,83,93},24), _d({52,81,84,97},24), _d({52,81,87,86,8,56,90,81,76,77},24), _d({53,73,90,89,93,73,86},24), _d({58,87,74,87},24), _d({58,87,86,86,97},24), _d({59,73,90,73,80},24)},
CurrentOption = _d({42,73,86,76,81,92},24),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,60,73,90,79,77,92,8,91,77,92,8,92,87,34},24), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({41,93,92,87,8,47,90,81,86,76,8,53,87,74,91,8,16,55,90,8,56,90,77,91,91,8,56,8,51,77,97,17},24),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({48,87,94,77,90,8,48,77,81,79,80,92,8,41,74,87,94,77,8,53,87,74},24),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({8,91,92,93,76,91},24),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({56,77,84,81,34,8,24},24), Content = _d({47,77,88,88,87,8,56,93,90,75,80,73,91,77,8,43,87,91,92,34,8,29,24,20,24,24,24,8,56,77,84,81},24)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({56,77,84,81,34,8},24) .. tostring(peli),
Content = peli >= 50000 and _d({216,135,118,113,8,29,24,20,24,24,24,8,56,77,84,81,8,58,77,73,75,80,77,76,9,8,58,77,73,76,97,8,92,87,8,88,93,90,75,80,73,91,77,8,47,77,88,88,87,22},24) or _d({47,90,81,86,76,81,86,79,8,56,77,84,81,22,22,22},24)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({49,86,78,81,86,81,92,77,8,47,77,88,88,87,8,46,84,97},24),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,49,86,78,81,86,81,92,77,8,46,84,81,79,80,92,34},24), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({46,84,81,79,80,92,8,59,88,77,77,76},24),
Range = {10, 150},
Increment = 5,
Suffix = _d({8,91,92,93,76,91,23,91},24),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49},24),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,8,48,93,74,69,8,52,87,73,76,77,76,8,91,93,75,75,77,91,91,78,93,84,84,97,22},24))
end)()