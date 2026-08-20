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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,41,63,72,63,75,73,41,69,60,74,77,55,72,59,34,74,58,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59,4,66,75,55},42),
_d({62,74,74,70,73,16,5,5,73,63,72,63,75,73,4,67,59,68,75,5,72,55,79,60,63,59,66,58},42),
_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,73,62,66,59,78,77,55,72,59,5,40,55,79,60,63,59,66,58,5,67,55,63,68,5,73,69,75,72,57,59},42)
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
error(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,40,55,79,60,63,59,66,58,246,43,31,246,34,63,56,72,55,72,79,4},42))
end
local Window = Rayfield:CreateWindow({
Name = _d({29,59,70,69,246,29,72,63,68,58,59,72,246,252,246,28,66,63,61,62,74,246,30,75,56},42),
LoadingTitle = _d({34,69,55,58,63,68,61,246,29,59,70,70,69,246,41,75,63,74,59,4,4,4},42),
LoadingSubtitle = _d({37,70,74,63,67,63,80,59,58,246,29,72,63,68,58},42),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({24,55,68,58,63,74},42)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({41,74,55,74,73},42)) and statsFolder.Stats:FindFirstChild(_d({38,59,66,63},42)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum = npc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
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
task.wait(0.01)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end
local UserInputService = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.End then
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,27,67,59,72,61,59,68,57,79,246,73,74,69,70,70,59,58,246,76,63,55,246,27,36,26,246,65,59,79,247},42))
end
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({36,69,68,59},42)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({40,69,65,75,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,59,70,70,69},42), args)
elseif style == _d({24,66,55,57,65,34,59,61},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65},42), args)
elseif style == _d({33,55,67,63,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,55,67,63,73,62,63,65,63,29,59,70,70,69},42), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65,8},42), args)
end
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,23,74,74},42)) or Instance.new(_d({23,74,74,55,57,62,67,59,68,74},42))
att.Name = _d({53,53,29,72,63,68,58,59,72,23,74,74},42)
att.Parent = root
local force = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42))
if not force then
force = Instance.new(_d({34,63,68,59,55,72,44,59,66,69,57,63,74,79},42))
force.Name = _d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42)
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
local force = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42))
local att = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,23,74,74},42))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.3)
if autoGrind then
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42)) or (targetNPC:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) and targetNPC:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health <= 0) then
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if targetRoot then
local bp = LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
local combatTool = bp and bp:FindFirstChild(_d({25,69,67,56,55,74},42))
if combatTool then
myHum:EquipTool(combatTool)
end
local targetPos = targetRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Magnitude > 1 and (dir.Unit * math.min(dir.Magnitude * 20, 60)) or Vector3.zero
force.VectorVelocity = velocityVec
local UIS = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
if dir.Magnitude < 10 and not UIS:GetFocusedTextBox() then
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
local UIS = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
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
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,25,66,59,55,68,59,58,246,75,70,246,70,72,59,76,63,69,75,73,246,73,59,73,73,63,69,68,4},42))
end
local MainTab = Window:CreateTab(_d({23,75,74,69,246,28,55,72,67},42), 4483362458)
local FlightTab = Window:CreateTab(_d({41,55,60,59,246,28,66,63,61,62,74},42), 4483362458)
MainTab:CreateDropdown({
Name = _d({41,59,66,59,57,74,246,35,69,56,246,42,55,72,61,59,74},42),
Options = {_d({24,55,68,58,63,74},42), _d({24,55,68,58,63,74,246,24,69,73,73},42), _d({26,55,70,62},42), _d({30,55,65,75},42), _d({34,63,66,79},42), _d({34,63,69,68,246,38,72,63,58,59},42), _d({35,55,72,71,75,55,68},42), _d({40,69,56,69},42), _d({40,69,68,68,79},42), _d({41,55,72,55,62},42)},
CurrentOption = _d({24,55,68,58,63,74},42),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,42,55,72,61,59,74,246,73,59,74,246,74,69,16},42), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({23,75,74,69,246,29,72,63,68,58,246,35,69,56,73},42),
CurrentValue = false,
Callback = function(Value)
autoGrind = Value
if not autoGrind then
cleanupForce()
end
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,23,75,74,69,246,29,72,63,68,58,16},42), autoGrind)
end,
})
MainTab:CreateSlider({
Name = _d({30,69,76,59,72,246,30,59,63,61,62,74,246,23,56,69,76,59,246,35,69,56},42),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({246,73,74,75,58,73},42),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({38,59,66,63,16,246,6},42), Content = _d({29,59,70,70,69,246,38,75,72,57,62,55,73,59,246,25,69,73,74,16,246,11,6,2,6,6,6,246,38,59,66,63},42)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({38,59,66,63,16,246},42) .. tostring(peli),
Content = peli >= 50000 and _d({198,117,100,95,246,11,6,2,6,6,6,246,38,59,66,63,246,40,59,55,57,62,59,58,247,246,40,59,55,58,79,246,74,69,246,70,75,72,57,62,55,73,59,246,29,59,70,70,69,4},42) or _d({29,72,63,68,58,63,68,61,246,38,59,66,63,4,4,4},42)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({31,68,60,63,68,63,74,59,246,29,59,70,70,69,246,28,66,79},42),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,31,68,60,63,68,63,74,59,246,28,66,63,61,62,74,16},42), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({28,66,63,61,62,74,246,41,70,59,59,58},42),
Range = {10, 150},
Increment = 5,
Suffix = _d({246,73,74,75,58,73,5,73},42),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({26,59,73,74,72,69,79,246,43,31},42),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,246,30,75,56,51,246,34,69,55,58,59,58,246,73,75,57,57,59,73,73,60,75,66,66,79,4},42))
end)()