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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({26,70,68,57,56,75},41))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({25,56,69,59,64,75},41)
local selectedWeapon = availableWeapons[1] or _d({26,70,68,57,56,75},41)
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
local mobList = {_d({25,56,69,59,64,75},41), _d({25,56,69,59,64,75,247,25,70,74,74},41), _d({27,56,71,63},41), _d({31,56,66,76},41), _d({35,64,67,80},41), _d({35,64,70,69,247,39,73,64,59,60},41), _d({36,56,73,72,76,56,69},41), _d({41,70,57,70},41), _d({41,70,69,69,80},41), _d({42,56,73,56,63},41)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({42,75,56,75,74},41)) and statsFolder.Stats:FindFirstChild(_d({39,60,67,64},41)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local yi = folder and folder:FindFirstChild(_d({48,64},41))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({48,64},41) and obj:IsA(_d({36,70,59,60,67},41)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({78,56,75,60,73},41)) or hitName:find(_d({74,60,56},41)) or hitName:find(_d({70,58,60,56,69},41)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({25,56,74,60,39,56,73,75},41)) then
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
local att = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,30,73,64,69,59,60,73,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41)
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
local force = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41))
local att = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,24,75,75},41))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({37,70,69,60},41)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({41,70,66,76,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,60,71,71,70},41), args)
elseif style == _d({25,67,56,58,66,35,60,62},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66},41), args)
elseif style == _d({34,56,68,64,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,56,68,64,74,63,64,66,64,30,60,71,71,70},41), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66,9},41), args)
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
local yiRoot = yi:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
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
local prompt = yi:FindFirstChildWhichIsA(_d({39,73,70,79,64,68,64,75,80,39,73,70,68,71,75},41), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
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
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if npcRoot and npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({30,39,38,30,73,64,69,59,60,73,37,56,75,64,77,60,44,32},41))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({30,73,64,69,59,60,73,36,70,57,64,67,60,43,70,62,62,67,60},41))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,26,67,60,56,69,60,59,247,76,71,247,71,73,60,77,64,70,76,74,247,74,60,74,74,64,70,69,5},41))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,46,64,69,59,44,32,6,68,56,64,69,6,59,64,74,75,6,68,56,64,69,5,67,76,56},41)))()
end)
if not ok or type(WindUI) ~= _d({75,56,57,67,60},41) then
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,247,46,64,69,59,44,32,5},41))
return
end
local Window = WindUI:CreateWindow({
Title = _d({30,60,71,70,247,30,73,64,69,59,60,73,247,77,7,5,7,5,8,15},41),
Icon = _d({74,78,70,73,59},41),
Folder = _d({30,60,71,70,30,73,64,69,59,60,73},41),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({27,56,73,66},41),
OpenButton = {
Title = _d({30,60,71,70,247,30,73,64,69,59,60,73},41),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({24,76,75,70,247,29,56,73,68},41), Icon = _d({74,78,70,73,59},41) })
local tabFlight = Window:Tab({ Title = _d({29,67,64,62,63,75},41), Icon = _d({71,67,56,69,60},41) })
local tabGeppo = Window:Tab({ Title = _d({30,60,71,71,70,247,25,76,80,60,73},41), Icon = _d({74,63,70,71,71,64,69,62,4,58,56,73,75},41) })
local tabSettings = Window:Tab({ Title = _d({42,60,75,75,64,69,62,74},41), Icon = _d({74,60,75,75,64,69,62,74},41) })
tabFarm:Toggle({
Title = _d({24,76,75,70,247,30,73,64,69,59,247,36,70,57,74,247,50,39,52},41),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({43,56,73,62,60,75,247,36,70,57},41),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({46,60,56,71,70,69,247,6,247,36,60,67,60,60},41),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({39,60,67,64,247,46,56,67,67,60,75},41),
Desc = _d({35,70,56,59,64,69,62,5,5,5},41)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({39,60,67,64,247,46,56,67,67,60,75},41), Desc = tostring(peli) .. (peli >= 50000 and _d({247,50,41,28,24,27,48,248,52},41) or "") })
end
end)
end
end)
tabFlight:Toggle({
Title = _d({32,69,61,64,69,64,75,60,247,30,60,71,71,70,247,29,67,80},41),
Value = false,
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end
})
tabFlight:Slider({
Title = _d({29,67,64,62,63,75,247,42,71,60,60,59},41),
Default = 50,
Min = 10,
Max = 200,
Step = 1,
Callback = function(val)
flightSpeed = val
end
})
tabFlight:Slider({
Title = _d({31,70,77,60,73,247,31,60,64,62,63,75},41),
Default = 6.5,
Min = 0,
Max = 50,
Step = 0.5,
Callback = function(val)
hoverHeight = val
end
})
tabFlight:Toggle({
Title = _d({36,56,69,76,56,67,247,30,60,71,71,70,247,50,42,71,56,58,60,52},41),
Value = false,
Callback = function(val)
manualGeppoEnabled = val
end
})
tabGeppo:Toggle({
Title = _d({24,76,75,70,247,25,76,80,247,30,60,71,71,70},41),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({25,80,71,56,74,74,247,12,7,66,247,39,60,67,64,247,26,63,60,58,66},41),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({27,60,74,75,73,70,80,247,44,32,247,253,247,42,75,70,71,247,28,77,60,73,80,75,63,64,69,62},41),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,247,31,76,57,52,247,77,7,5,7,5,8,15,247,67,70,56,59,60,59,247,78,64,75,63,247,46,64,69,59,44,32,5},41))
end)()