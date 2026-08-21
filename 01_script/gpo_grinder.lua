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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({37,64,64,61},47)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({37,64,64,61},47)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({20,64,62,51,50,69},47))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({19,50,63,53,58,69},47)
local selectedWeapon = availableWeapons[1] or _d({20,64,62,51,50,69},47)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local manualGeppoEnabled = false
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({19,50,63,53,58,69},47), _d({19,50,63,53,58,69,241,19,64,68,68},47), _d({21,50,65,57},47), _d({25,50,60,70},47), _d({29,58,61,74},47), _d({29,58,64,63,241,33,67,58,53,54},47), _d({30,50,67,66,70,50,63},47), _d({35,64,51,64},47), _d({35,64,63,63,74},47), _d({36,50,67,50,57},47)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({36,69,50,69,68},47)) and statsFolder.Stats:FindFirstChild(_d({33,54,61,58},47)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({31,33,20,68},47))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = npc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({31,33,20,68},47))
local yi = folder and folder:FindFirstChild(_d({42,58},47))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({42,58},47) and obj:IsA(_d({30,64,53,54,61},47)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({31,33,20,68},47))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({72,50,69,54,67},47)) or hitName:find(_d({68,54,50},47)) or hitName:find(_d({64,52,54,50,63},47)) or raycastResult.Material == Enum.Material.Water
local currentHeight = pos.Y - raycastResult.Position.Y
if currentHeight < 20 then
return 20 - currentHeight
end
else
if pos.Y < 50 then
return 50 - pos.Y
end
end
return 0
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({19,50,68,54,33,50,67,69},47)) then
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
local att = root:FindFirstChild(_d({48,48,24,67,58,63,53,54,67,18,69,69},47)) or Instance.new(_d({18,69,69,50,52,57,62,54,63,69},47))
att.Name = _d({48,48,24,67,58,63,53,54,67,18,69,69},47)
att.Parent = root
local force = root:FindFirstChild(_d({48,48,24,67,58,63,53,54,67,23,64,67,52,54},47))
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
force.Name = _d({48,48,24,67,58,63,53,54,67,23,64,67,52,54},47)
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
local force = root:FindFirstChild(_d({48,48,24,67,58,63,53,54,67,23,64,67,52,54},47))
local att = root:FindFirstChild(_d({48,48,24,67,58,63,53,54,67,18,69,69},47))
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
if not processed then
if input.KeyCode == Enum.KeyCode.P then
toggleAutoFarm()
elseif input.KeyCode == Enum.KeyCode.Space and manualGeppoEnabled then
invokeGeppo()
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({31,64,63,54},47)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({35,64,60,70,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,54,65,65,64},47), args)
elseif style == _d({19,61,50,52,60,29,54,56},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60},47), args)
elseif style == _d({28,50,62,58,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,50,62,58,68,57,58,60,58,24,54,65,65,64},47), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60,3},47), args)
end
end)
end
local function checkStuck(currentPos, targetPos, deltaTime)
deltaTime = deltaTime or 0.2
if (targetPos - currentPos).Magnitude > 5 then
if (currentPos - lastPosition).Magnitude < 1 then
stuckTime = stuckTime + deltaTime
if stuckTime > 1.5 then
unstuckActive = true
stuckTime = 0
end
else
stuckTime = 0
end
else
stuckTime = 0
end
lastPosition = currentPos
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local peli = getPeli()
if autoBuyGeppo and (peli >= 50000 or bypassPeliCheck) and not boughtGeppo then
local yi = findYiNPC()
if yi then
local yiRoot = yi:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if yiRoot then
local targetPos = yiRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
if dir.Magnitude > 8 then
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
else
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, yiRoot.Position)
local prompt = yi:FindFirstChildWhichIsA(_d({33,67,64,73,58,62,58,69,74,33,67,64,62,65,69},47), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({44,24,54,65,64,241,24,67,58,63,53,54,67,46,241,55,58,67,54,65,67,64,73,58,62,58,69,74,65,67,64,62,65,69,241,63,64,69,241,68,70,65,65,64,67,69,54,53,241,51,74,241,54,73,54,52,70,69,64,67,242},47))
end
task.wait(1.5)
if getPeli() < 50000 and not bypassPeliCheck then
boughtGeppo = true
end
end
end
return
end
end
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if npcRoot and npc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)) and npc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, targetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)) and finalNpc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, finalTargetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (finalTargetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)) and finalNpc:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
targetVelocity = targetVelocity + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = targetVelocity
if moveDir.Magnitude > 0 or heightAdjust > 0 then
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
local playerGui = LocalPlayer:FindFirstChild(_d({33,61,50,74,54,67,24,70,58},47))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({24,33,32,24,67,58,63,53,54,67,31,50,69,58,71,54,38,26},47))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({24,67,58,63,53,54,67,30,64,51,58,61,54,37,64,56,56,61,54},47))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({44,24,54,65,64,241,24,67,58,63,53,54,67,46,241,20,61,54,50,63,54,53,241,70,65,241,65,67,54,71,58,64,70,68,241,68,54,68,68,58,64,63,255},47))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,40,58,63,53,38,26,0,62,50,58,63,0,53,58,68,69,0,62,50,58,63,255,61,70,50},47)))()
end)
if not ok or type(WindUI) ~= _d({69,50,51,61,54},47) then
warn(_d({44,24,54,65,64,241,24,67,58,63,53,54,67,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,40,58,63,53,38,26,255},47))
return
end
local Window = WindUI:CreateWindow({
Title = _d({24,54,65,64,241,24,67,58,63,53,54,67,241,71,1,255,1,255,2,9},47),
Icon = _d({68,72,64,67,53},47),
Folder = _d({24,54,65,64,24,67,58,63,53,54,67},47),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({21,50,67,60},47),
OpenButton = {
Title = _d({24,54,65,64,241,24,67,58,63,53,54,67},47),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({18,70,69,64,241,23,50,67,62},47), Icon = _d({68,72,64,67,53},47) })
local tabFlight = Window:Tab({ Title = _d({23,61,58,56,57,69},47), Icon = _d({65,61,50,63,54},47) })
local tabGeppo = Window:Tab({ Title = _d({24,54,65,65,64,241,19,70,74,54,67},47), Icon = _d({68,57,64,65,65,58,63,56,254,52,50,67,69},47) })
local tabSettings = Window:Tab({ Title = _d({36,54,69,69,58,63,56,68},47), Icon = _d({68,54,69,69,58,63,56,68},47) })
tabFarm:Toggle({
Title = _d({18,70,69,64,241,24,67,58,63,53,241,30,64,51,68,241,44,33,46},47),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({37,50,67,56,54,69,241,30,64,51},47),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({40,54,50,65,64,63,241,0,241,30,54,61,54,54},47),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({33,54,61,58,241,40,50,61,61,54,69},47),
Desc = _d({29,64,50,53,58,63,56,255,255,255},47)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({33,54,61,58,241,40,50,61,61,54,69},47), Desc = tostring(peli) .. (peli >= 50000 and _d({241,44,35,22,18,21,42,242,46},47) or "") })
end
end)
end
end)
tabFlight:Toggle({
Title = _d({26,63,55,58,63,58,69,54,241,24,54,65,65,64,241,23,61,74},47),
Value = false,
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end
})
tabFlight:Slider({
Title = _d({23,61,58,56,57,69,241,36,65,54,54,53},47),
Default = 50,
Min = 10,
Max = 200,
Step = 1,
Callback = function(val)
flightSpeed = val
end
})
tabFlight:Slider({
Title = _d({25,64,71,54,67,241,25,54,58,56,57,69},47),
Default = 6.5,
Min = 0,
Max = 50,
Step = 0.5,
Callback = function(val)
hoverHeight = val
end
})
tabFlight:Toggle({
Title = _d({30,50,63,70,50,61,241,24,54,65,65,64,241,44,36,65,50,52,54,46},47),
Value = false,
Callback = function(val)
manualGeppoEnabled = val
end
})
tabGeppo:Toggle({
Title = _d({18,70,69,64,241,19,70,74,241,24,54,65,65,64},47),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({19,74,65,50,68,68,241,6,1,60,241,33,54,61,58,241,20,57,54,52,60},47),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({21,54,68,69,67,64,74,241,38,26,241,247,241,36,69,64,65,241,22,71,54,67,74,69,57,58,63,56},47),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({44,24,54,65,64,241,24,67,58,63,53,54,67,241,25,70,51,46,241,71,1,255,1,255,2,9,241,61,64,50,53,54,53,241,72,58,69,57,241,40,58,63,53,38,26,255},47))
end)()