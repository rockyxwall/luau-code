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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({29,73,71,60,59,78},38))
end
return toolNames
end
local availableWeapons = scanTools()
local Rayfield = nil
local rayfieldSources = {
_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,45,67,76,67,79,77,45,73,64,78,81,59,76,63,38,78,62,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63,8,70,79,59},38),
_d({66,78,78,74,77,20,9,9,77,67,76,67,79,77,8,71,63,72,79,9,76,59,83,64,67,63,70,62},38),
_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,77,66,70,63,82,81,59,76,63,9,44,59,83,64,67,63,70,62,9,71,59,67,72,9,77,73,79,76,61,63},38)
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
error(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,44,59,83,64,67,63,70,62,250,47,35,250,38,67,60,76,59,76,83,8},38))
end
local Window = Rayfield:CreateWindow({
Name = _d({33,63,74,73,250,33,76,67,72,62,63,76,250,0,250,32,70,67,65,66,78,250,34,79,60},38),
LoadingTitle = _d({38,73,59,62,67,72,65,250,33,63,74,74,73,250,45,79,67,78,63,8,8,8},38),
LoadingSubtitle = _d({41,74,78,67,71,67,84,63,62,250,33,76,67,72,62},38),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({28,59,72,62,67,78},38)
local selectedWeapon = availableWeapons[1] or _d({29,73,71,60,59,78},38)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({45,78,59,78,77},38)) and statsFolder.Stats:FindFirstChild(_d({42,63,70,67},38)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function findTargetMob()
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if not npcsFolder then return nil end
local myRoot = getRoot()
if not myRoot then return nil end
local closest = nil
local minDist = math.huge
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum = npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
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
if part:IsA(_d({28,59,77,63,42,59,76,78},38)) then
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
local att = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,33,76,67,72,62,63,76,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38)
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
local force = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38))
local att = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,27,78,78},38))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
end
local function computeHorizontalCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, root.Position.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function computeLockedCFrame(root, aimPos, facePos)
return computeHorizontalCFrame(root, facePos) + (aimPos - root.Position)
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({40,73,72,63},38)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({44,73,69,79,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,63,74,74,73},38), args)
elseif style == _d({28,70,59,61,69,38,63,65},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69},38), args)
elseif style == _d({37,59,71,67,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,59,71,67,77,66,67,69,67,33,63,74,74,73},38), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69,12},38), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.1)
if autoGrind then
pcall(function()
if not targetNPC or not targetNPC.Parent or not targetNPC:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38)) or (targetNPC:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and targetNPC:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health <= 0) then
if targetNPC then
pcall(setNPCPartsCollision, targetNPC, true)
end
targetNPC = findTargetMob()
end
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum and targetNPC then
local targetRoot = targetNPC:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if targetRoot then
setNPCPartsCollision(targetNPC, false)
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon) or LocalPlayer.Character:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
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
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,29,70,63,59,72,63,62,250,79,74,250,74,76,63,80,67,73,79,77,250,77,63,77,77,67,73,72,8},38))
end
local MainTab = Window:CreateTab(_d({27,79,78,73,250,32,59,76,71},38), 4483362458)
local FlightTab = Window:CreateTab(_d({45,59,64,63,250,32,70,67,65,66,78},38), 4483362458)
MainTab:CreateDropdown({
Name = _d({45,63,70,63,61,78,250,39,73,60,250,46,59,76,65,63,78},38),
Options = {_d({28,59,72,62,67,78},38), _d({28,59,72,62,67,78,250,28,73,77,77},38), _d({30,59,74,66},38), _d({34,59,69,79},38), _d({38,67,70,83},38), _d({38,67,73,72,250,42,76,67,62,63},38), _d({39,59,76,75,79,59,72},38), _d({44,73,60,73},38), _d({44,73,72,72,83},38), _d({45,59,76,59,66},38)},
CurrentOption = _d({28,59,72,62,67,78},38),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,46,59,76,65,63,78,250,77,63,78,250,78,73,20},38), selectedMob)
end,
})
MainTab:CreateDropdown({
Name = _d({45,63,70,63,61,78,250,49,63,59,74,73,72,9,39,63,70,63,63},38),
Options = availableWeapons,
CurrentOption = selectedWeapon,
MultipleOptions = false,
Callback = function(Option)
selectedWeapon = Option[1] or Option
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,49,63,59,74,73,72,250,77,63,78,250,78,73,20},38), selectedWeapon)
end,
})
MainTab:CreateToggle({
Name = _d({27,79,78,73,250,33,76,67,72,62,250,39,73,60,77,250,2,41,76,250,42,76,63,77,77,250,42,250,37,63,83,3},38),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({34,73,80,63,76,250,34,63,67,65,66,78,250,27,60,73,80,63,250,39,73,60},38),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({250,77,78,79,62,77},38),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({42,63,70,67,20,250,10},38), Content = _d({33,63,74,74,73,250,42,79,76,61,66,59,77,63,250,29,73,77,78,20,250,15,10,6,10,10,10,250,42,63,70,67},38)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({42,63,70,67,20,250},38) .. tostring(peli),
Content = peli >= 50000 and _d({202,121,104,99,250,15,10,6,10,10,10,250,42,63,70,67,250,44,63,59,61,66,63,62,251,250,44,63,59,62,83,250,78,73,250,74,79,76,61,66,59,77,63,250,33,63,74,74,73,8},38) or _d({33,76,67,72,62,67,72,65,250,42,63,70,67,8,8,8},38)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({35,72,64,67,72,67,78,63,250,33,63,74,74,73,250,32,70,83},38),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,35,72,64,67,72,67,78,63,250,32,70,67,65,66,78,20},38), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({32,70,67,65,66,78,250,45,74,63,63,62},38),
Range = {10, 150},
Increment = 5,
Suffix = _d({250,77,78,79,62,77,9,77},38),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({30,63,77,78,76,73,83,250,47,35},38),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,250,34,79,60,55,250,38,73,59,62,63,62,250,77,79,61,61,63,77,77,64,79,70,70,83,8},38))
end)()