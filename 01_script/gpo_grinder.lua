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
local Players = game:GetService(_d({36,64,53,77,57,70,71},44))
local ReplicatedStorage = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local RunService = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local VIM = game:GetService(_d({42,61,70,72,73,53,64,29,66,68,73,72,33,53,66,53,59,57,70},44))
local UserInputService = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({22,53,55,63,68,53,55,63},44))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({40,67,67,64},44)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({40,67,67,64},44)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({23,67,65,54,53,72},44))
end
return toolNames
end
local availableWeapons = scanTools()
local Rayfield = nil
local rayfieldSources = {
_d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,39,61,70,61,73,71,39,67,58,72,75,53,70,57,32,72,56,3,38,53,77,58,61,57,64,56,3,65,53,61,66,3,71,67,73,70,55,57,2,64,73,53},44),
_d({60,72,72,68,71,14,3,3,71,61,70,61,73,71,2,65,57,66,73,3,70,53,77,58,61,57,64,56},44),
_d({60,72,72,68,71,14,3,3,70,53,75,2,59,61,72,60,73,54,73,71,57,70,55,67,66,72,57,66,72,2,55,67,65,3,71,60,64,57,76,75,53,70,57,3,38,53,77,58,61,57,64,56,3,65,53,61,66,3,71,67,73,70,55,57},44)
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
error(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,49,244,26,53,61,64,57,56,244,72,67,244,64,67,53,56,244,38,53,77,58,61,57,64,56,244,41,29,244,32,61,54,70,53,70,77,2},44))
end
local Window = Rayfield:CreateWindow({
Name = _d({27,57,68,67,244,27,70,61,66,56,57,70,244,250,244,26,64,61,59,60,72,244,28,73,54},44),
LoadingTitle = _d({32,67,53,56,61,66,59,244,27,57,68,68,67,244,39,73,61,72,57,2,2,2},44),
LoadingSubtitle = _d({35,68,72,61,65,61,78,57,56,244,27,70,61,66,56},44),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({22,53,66,56,61,72},44)
local selectedWeapon = availableWeapons[1] or _d({23,67,65,54,53,72},44)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({39,72,53,72,71},44) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({39,72,53,72,71},44)) and statsFolder.Stats:FindFirstChild(_d({36,57,64,61},44)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({34,36,23,71},44))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
local hum = npc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({22,53,71,57,36,53,70,72},44)) then
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
local att = root:FindFirstChild(_d({51,51,27,70,61,66,56,57,70,21,72,72},44)) or Instance.new(_d({21,72,72,53,55,60,65,57,66,72},44))
att.Name = _d({51,51,27,70,61,66,56,57,70,21,72,72},44)
att.Parent = root
local force = root:FindFirstChild(_d({51,51,27,70,61,66,56,57,70,26,67,70,55,57},44))
if not force then
force = Instance.new(_d({32,61,66,57,53,70,42,57,64,67,55,61,72,77},44))
force.Name = _d({51,51,27,70,61,66,56,57,70,26,67,70,55,57},44)
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
local force = root:FindFirstChild(_d({51,51,27,70,61,66,56,57,70,26,67,70,55,57},44))
local att = root:FindFirstChild(_d({51,51,27,70,61,66,56,57,70,21,72,72},44))
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
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({39,72,53,72,71},44) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({34,67,66,57},44)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({38,67,63,73,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,57,68,68,67},44), args)
elseif style == _d({22,64,53,55,63,32,57,59},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63},44), args)
elseif style == _d({31,53,65,61,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,53,65,61,71,60,61,63,61,27,57,68,68,67},44), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63,6},44), args)
end
end)
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({22,53,55,63,68,53,55,63},44))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if npcRoot and npc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)) and npc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)).Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (targetPos - myRoot.Position)
force.VectorVelocity = dir.Unit * 60
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)) and finalNpc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
force.VectorVelocity = dir.Unit * 60
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)) and finalNpc:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44)).Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
force.VectorVelocity = dir.Unit * 30
task.wait(0.05)
end
end
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
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
pcall(function() Rayfield:Destroy() end)
print(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,49,244,23,64,57,53,66,57,56,244,73,68,244,68,70,57,74,61,67,73,71,244,71,57,71,71,61,67,66,2},44))
end
local MainTab = Window:CreateTab(_d({21,73,72,67,244,26,53,70,65},44), 4483362458)
local FlightTab = Window:CreateTab(_d({39,53,58,57,244,26,64,61,59,60,72},44), 4483362458)
MainTab:CreateDropdown({
Name = _d({39,57,64,57,55,72,244,33,67,54,244,40,53,70,59,57,72},44),
Options = {_d({22,53,66,56,61,72},44), _d({22,53,66,56,61,72,244,22,67,71,71},44), _d({24,53,68,60},44), _d({28,53,63,73},44), _d({32,61,64,77},44), _d({32,61,67,66,244,36,70,61,56,57},44), _d({33,53,70,69,73,53,66},44), _d({38,67,54,67},44), _d({38,67,66,66,77},44), _d({39,53,70,53,60},44)},
CurrentOption = _d({22,53,66,56,61,72},44),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,49,244,40,53,70,59,57,72,244,71,57,72,244,72,67,14},44), selectedMob)
end,
})
MainTab:CreateDropdown({
Name = _d({39,57,64,57,55,72,244,43,57,53,68,67,66,3,33,57,64,57,57},44),
Options = availableWeapons,
CurrentOption = selectedWeapon,
MultipleOptions = false,
Callback = function(Option)
local val = type(Option) == _d({72,53,54,64,57},44) and Option[1] or Option
selectedWeapon = tostring(val)
print(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,49,244,43,57,53,68,67,66,244,71,57,72,244,72,67,14},44), selectedWeapon)
end,
})
MainTab:CreateToggle({
Name = _d({21,73,72,67,244,27,70,61,66,56,244,33,67,54,71,244,252,35,70,244,36,70,57,71,71,244,36,244,31,57,77,253},44),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({28,67,74,57,70,244,28,57,61,59,60,72,244,21,54,67,74,57,244,33,67,54},44),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({244,71,72,73,56,71},44),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({36,57,64,61,14,244,4},44), Content = _d({27,57,68,68,67,244,36,73,70,55,60,53,71,57,244,23,67,71,72,14,244,9,4,0,4,4,4,244,36,57,64,61},44)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({36,57,64,61,14,244},44) .. tostring(peli),
Content = peli >= 50000 and _d({196,115,98,93,244,9,4,0,4,4,4,244,36,57,64,61,244,38,57,53,55,60,57,56,245,244,38,57,53,56,77,244,72,67,244,68,73,70,55,60,53,71,57,244,27,57,68,68,67,2},44) or _d({27,70,61,66,56,61,66,59,244,36,57,64,61,2,2,2},44)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({29,66,58,61,66,61,72,57,244,27,57,68,68,67,244,26,64,77},44),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,49,244,29,66,58,61,66,61,72,57,244,26,64,61,59,60,72,14},44), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({26,64,61,59,60,72,244,39,68,57,57,56},44),
Range = {10, 150},
Increment = 5,
Suffix = _d({244,71,72,73,56,71,3,71},44),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({24,57,71,72,70,67,77,244,41,29},44),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({47,27,57,68,67,244,27,70,61,66,56,57,70,244,28,73,54,49,244,32,67,53,56,57,56,244,71,73,55,55,57,71,71,58,73,64,64,77,2},44))
end)()