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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({15,59,57,46,45,64},52))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({14,45,58,48,53,64},52)
local selectedWeapon = availableWeapons[1] or _d({15,59,57,46,45,64},52)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({14,45,58,48,53,64},52), _d({14,45,58,48,53,64,236,14,59,63,63},52), _d({16,45,60,52},52), _d({20,45,55,65},52), _d({24,53,56,69},52), _d({24,53,59,58,236,28,62,53,48,49},52), _d({25,45,62,61,65,45,58},52), _d({30,59,46,59},52), _d({30,59,58,58,69},52), _d({31,45,62,45,52},52)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({31,64,45,64,63},52)) and statsFolder.Stats:FindFirstChild(_d({28,49,56,53},52)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = npc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({26,28,15,63},52))
local yi = folder and folder:FindFirstChild(_d({37,53},52))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({37,53},52) and obj:IsA(_d({25,59,48,49,56},52)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({26,28,15,63},52))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({67,45,64,49,62},52)) or hitName:find(_d({63,49,45},52)) or hitName:find(_d({59,47,49,45,58},52)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
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
local att = root:FindFirstChild(_d({43,43,19,62,53,58,48,49,62,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,19,62,53,58,48,49,62,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,19,62,53,58,48,49,62,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,19,62,53,58,48,49,62,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,19,62,53,58,48,49,62,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,19,62,53,58,48,49,62,13,64,64},52))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({26,59,58,49},52)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({30,59,55,65,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,49,60,60,59},52), args)
elseif style == _d({14,56,45,47,55,24,49,51},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55},52), args)
elseif style == _d({23,45,57,53,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,45,57,53,63,52,53,55,53,19,49,60,60,59},52), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55,254},52), args)
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
local yiRoot = yi:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
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
local prompt = yi:FindFirstChildWhichIsA(_d({28,62,59,68,53,57,53,64,69,28,62,59,57,60,64},52), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,50,53,62,49,60,62,59,68,53,57,53,64,69,60,62,59,57,60,64,236,58,59,64,236,63,65,60,60,59,62,64,49,48,236,46,69,236,49,68,49,47,65,64,59,62,237},52))
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
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if npcRoot and npc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)) and npc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)) and finalNpc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)) and finalNpc:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({28,56,45,69,49,62,19,65,53},52))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({19,28,27,19,62,53,58,48,49,62,26,45,64,53,66,49,33,21},52))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({19,62,53,58,48,49,62,25,59,46,53,56,49,32,59,51,51,56,49},52))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,15,56,49,45,58,49,48,236,65,60,236,60,62,49,66,53,59,65,63,236,63,49,63,63,53,59,58,250},52))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({52,64,64,60,63,6,251,251,51,53,64,52,65,46,250,47,59,57,251,18,59,59,64,45,51,49,63,65,63,251,35,53,58,48,33,21,251,62,49,56,49,45,63,49,63,251,56,45,64,49,63,64,251,48,59,67,58,56,59,45,48,251,57,45,53,58,250,56,65,45},52)))()
end)
if not ok or type(WindUI) ~= _d({64,45,46,56,49},52) then
warn(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,35,53,58,48,33,21,250},52))
return
end
local Window = WindUI:CreateWindow({
Title = _d({19,49,60,59,236,19,62,53,58,48,49,62,236,66,252,250,252,250,253,4},52),
Icon = _d({63,67,59,62,48},52),
Folder = _d({19,49,60,59,19,62,53,58,48,49,62},52),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({16,45,62,55},52),
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({13,65,64,59,236,18,45,62,57},52), Icon = _d({63,67,59,62,48},52) })
local tabFlight = Window:Tab({ Title = _d({18,56,53,51,52,64},52), Icon = _d({60,56,45,58,49},52) })
local tabGeppo = Window:Tab({ Title = _d({19,49,60,60,59,236,14,65,69,49,62},52), Icon = _d({63,52,59,60,60,53,58,51,249,47,45,62,64},52) })
local tabSettings = Window:Tab({ Title = _d({31,49,64,64,53,58,51,63},52), Icon = _d({63,49,64,64,53,58,51,63},52) })
tabFarm:Toggle({
Title = _d({13,65,64,59,236,19,62,53,58,48,236,25,59,46,63,236,39,28,41},52),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({32,45,62,51,49,64,236,25,59,46},52),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({35,49,45,60,59,58,236,251,236,25,49,56,49,49},52),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({28,49,56,53,236,35,45,56,56,49,64},52),
Desc = _d({24,59,45,48,53,58,51,250,250,250},52)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({28,49,56,53,236,35,45,56,56,49,64},52), Desc = tostring(peli) .. (peli >= 50000 and _d({236,39,30,17,13,16,37,237,41},52) or "") })
end
end)
end
end)
tabFlight:Toggle({
Title = _d({21,58,50,53,58,53,64,49,236,19,49,60,60,59,236,18,56,69},52),
Value = false,
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end
})
tabGeppo:Toggle({
Title = _d({13,65,64,59,236,14,65,69,236,19,49,60,60,59},52),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({14,69,60,45,63,63,236,1,252,55,236,28,49,56,53,236,15,52,49,47,55},52),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({16,49,63,64,62,59,69,236,33,21,236,242,236,31,64,59,60,236,17,66,49,62,69,64,52,53,58,51},52),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({39,19,49,60,59,236,19,62,53,58,48,49,62,236,20,65,46,41,236,66,252,250,252,250,253,4,236,56,59,45,48,49,48,236,67,53,64,52,236,35,53,58,48,33,21,250},52))
end)()