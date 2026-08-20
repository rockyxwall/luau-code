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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,46,68,77,68,80,78,46,74,65,79,82,60,77,64,39,79,63,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64,9,71,80,60},37),
_d({67,79,79,75,78,21,10,10,78,68,77,68,80,78,9,72,64,73,80,10,77,60,84,65,68,64,71,63},37),
_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,78,67,71,64,83,82,60,77,64,10,45,60,84,65,68,64,71,63,10,72,60,68,73,10,78,74,80,77,62,64},37)
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
error(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,45,60,84,65,68,64,71,63,251,48,36,251,39,68,61,77,60,77,84,9},37))
end
local Window = Rayfield:CreateWindow({
Name = _d({34,64,75,74,251,34,77,68,73,63,64,77,251,1,251,33,71,68,66,67,79,251,35,80,61},37),
LoadingTitle = _d({39,74,60,63,68,73,66,251,34,64,75,75,74,251,46,80,68,79,64,9,9,9},37),
LoadingSubtitle = _d({42,75,79,68,72,68,85,64,63,251,34,77,68,73,63},37),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({29,60,73,63,68,79},37)
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
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({46,79,60,79,78},37)) and statsFolder.Stats:FindFirstChild(_d({43,64,71,68},37)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function hasGeppo()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({46,79,60,79,78},37)) and statsFolder.Stats:FindFirstChild(_d({33,68,66,67,79,68,73,66,46,79,84,71,64},37)) then
local style = statsFolder.Stats.FightingStyle.Value
if style == _d({45,74,70,80,78,67,68,70,68},37) or style == _d({29,71,60,62,70,39,64,66},37) or style == _d({38,60,72,68,78,67,68,70,68},37) then
return true
end
end
return false
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({41,74,73,64},37)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({45,74,70,80,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,64,75,75,74},37), args)
elseif style == _d({29,71,60,62,70,39,64,66},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70},37), args)
elseif style == _d({38,60,72,68,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,60,72,68,78,67,68,70,68,34,64,75,75,74},37), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70,13},37), args)
end
end)
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,28,79,79},37)) or Instance.new(_d({28,79,79,60,62,67,72,64,73,79},37))
att.Name = _d({58,58,34,77,68,73,63,64,77,28,79,79},37)
att.Parent = root
local force = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37))
if not force then
force = Instance.new(_d({39,68,73,64,60,77,49,64,71,74,62,68,79,84},37))
force.Name = _d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37)
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
local force = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37))
local att = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,28,79,79},37))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37)) or (targetNPC:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and targetNPC:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health <= 0) then
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if targetRoot then
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local combatTool = bp and bp:FindFirstChild(_d({30,74,72,61,60,79},37))
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
local UIS = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
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
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
local MainTab = Window:CreateTab(_d({28,80,79,74,251,33,60,77,72},37), 4483362458)
local FlightTab = Window:CreateTab(_d({46,60,65,64,251,33,71,68,66,67,79},37), 4483362458)
MainTab:CreateInput({
Name = _d({46,64,71,64,62,79,251,40,74,61,251,47,60,77,66,64,79},37),
PlaceholderText = _d({40,74,61,251,41,60,72,64,251,3,64,9,66,9,251,29,60,73,63,68,79,4},37),
RemoveTextAfterFocusLost = false,
Callback = function(Text)
selectedMob = Text
targetNPC = nil
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,47,60,77,66,64,79,251,78,64,79,251,79,74,21},37), selectedMob)
end,
})
MainTab:CreateToggle({
Name = _d({28,80,79,74,251,34,77,68,73,63,251,40,74,61,78},37),
CurrentValue = false,
Callback = function(Value)
autoGrind = Value
if not autoGrind then
cleanupForce()
end
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,28,80,79,74,251,34,77,68,73,63,21},37), autoGrind)
end,
})
MainTab:CreateSlider({
Name = _d({35,74,81,64,77,251,35,64,68,66,67,79,251,28,61,74,81,64,251,40,74,61},37),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({251,78,79,80,63,78},37),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({43,64,71,68,21,251,11},37), Content = _d({34,64,75,75,74,251,43,80,77,62,67,60,78,64,251,30,74,78,79,21,251,16,11,7,11,11,11,251,43,64,71,68},37)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({43,64,71,68,21,251},37) .. tostring(peli),
Content = peli >= 50000 and _d({203,122,105,100,251,16,11,7,11,11,11,251,43,64,71,68,251,45,64,60,62,67,64,63,252,251,45,64,60,63,84,251,79,74,251,75,80,77,62,67,60,78,64,251,34,64,75,75,74,9},37) or _d({34,77,68,73,63,68,73,66,251,43,64,71,68,9,9,9},37)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({36,73,65,68,73,68,79,64,251,34,64,75,75,74,251,33,71,84},37),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,36,73,65,68,73,68,79,64,251,33,71,68,66,67,79,21},37), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({33,71,68,66,67,79,251,46,75,64,64,63},37),
Range = {10, 150},
Increment = 5,
Suffix = _d({251,78,79,80,63,78,10,78},37),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({31,64,78,79,77,74,84,251,48,36},37),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,251,35,80,61,56,251,39,74,60,63,64,63,251,78,80,62,62,64,78,78,65,80,71,71,84,9},37))
end)()