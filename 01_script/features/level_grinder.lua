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
local Players = game:GetService(_d({58,86,75,99,79,92,93},22))
local ReplicatedStorage = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local RunService = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local VIM = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local UserInputService = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({44,75,88,78,83,94},22)
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({61,94,75,94,93},22)) and statsFolder.Stats:FindFirstChild(_d({54,79,96,79,86},22)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({61,94,75,94,93},22)) and statsFolder.Stats:FindFirstChild(_d({58,79,86,83},22)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({59,95,79,93,94},22)) and statsFolder.Quest:FindFirstChild(_d({45,95,92,92,79,88,94,59,95,79,93,94},22)) and statsFolder.Quest.CurrentQuest.Value or _d({56,89,88,79},22)
return lvl, peli, quest
end
return 1, 0, _d({56,89,88,79},22)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum = npc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({97,75,94,79,92},22)) or hitName:find(_d({93,79,75},22)) or hitName:find(_d({89,77,79,75,88},22)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({44,75,93,79,58,75,92,94},22)) then
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
local att = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,43,94,94},22)) or Instance.new(_d({43,94,94,75,77,82,87,79,88,94},22))
att.Name = _d({73,73,49,92,83,88,78,79,92,43,94,94},22)
att.Parent = root
local force = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22))
if not force then
force = Instance.new(_d({54,83,88,79,75,92,64,79,86,89,77,83,94,99},22))
force.Name = _d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22)
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
local force = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22))
local att = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,43,94,94},22))
if force then force:Destroy() end
if att then att:Destroy() end
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
local function navigateTo(targetPos)
local myRoot = getRoot()
if not myRoot then return false end
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
if dir.Magnitude > 8 then
checkStuck(myRoot.Position, targetPos, 0.1)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
return false
else
force.VectorVelocity = Vector3.zero
return true
end
end
local function acceptQuest(npcName)
local npc = Workspace.NPCs:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({63,90,90,79,92,62,89,92,93,89},22))
local prompt = torso and torso:FindFirstChild(_d({58,92,89,87,90,94},22))
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local reached = navigateTo(torso.Position + Vector3.new(0, hoverHeight, 0))
if reached then
cleanupForce()
myRoot.CFrame = torso.CFrame + Vector3.new(0, 2, 0)
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({69,59,95,79,93,94,10,43,77,77,79,90,94,75,88,77,79,71,10,80,83,92,79,90,92,89,98,83,87,83,94,99,90,92,89,87,90,94,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,79,98,79,77,95,94,89,92,11},22))
end
task.wait(0.8)
local chatGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild(_d({56,58,45,45,50,43,62},22))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({81,89},22))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({79,88,78,45,82,75,94},22))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({24,24,24},22) then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
elseif endChatBtn and endChatBtn.Visible then
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
conn:Fire()
end
end
task.wait(0.4)
end
end
return true
end
return false
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
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,43,95,94,89,10,80,75,92,87,10,94,89,81,81,86,79,78,10,94,89,36,10},22) .. tostring(autoGrind))
end
end
end)
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local lvl, peli, quest = getStats()
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({60,83,80,86,79},22)) or LocalPlayer.Character:FindFirstChild(_d({60,83,80,86,79},22))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({44,75,88,78,83,94},22)
if lvl < 3 then
if quest == _d({56,89,88,79},22) then
acceptQuest(_d({46,75,90,82},22))
return
end
else
if quest == _d({56,89,88,79},22) then
acceptQuest(_d({61,75,92,75,82},22))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({44,75,88,78,83,94,10,44,89,93,93},22)
if quest == _d({56,89,88,79},22) then
acceptQuest(_d({60,89,88,88,99},22))
return
end
elseif peli >= 300 and not hasRifle then
local shopItem = workspace.BuyableItems:FindFirstChild(_d({60,83,80,86,79},22))
local shopPart = shopItem and shopItem:FindFirstChild(_d({61,82,89,90,58,75,92,94},22))
if shopPart then
local reached = navigateTo(shopPart.Position + Vector3.new(0, hoverHeight, 0))
if reached then
cleanupForce()
myRoot.CFrame = shopPart.CFrame + Vector3.new(0, 2, 0)
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({58,92,89,98,83,87,83,94,99,58,92,89,87,90,94},22), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({69,60,83,80,86,79,10,58,95,92,77,82,75,93,79,71,10,80,83,92,79,90,92,89,98,83,87,83,94,99,90,92,89,87,90,94,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,79,98,79,77,95,94,89,92,11},22))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
cleanupForce()
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,60,83,80,86,79,10,90,95,92,77,82,75,93,79,78,11,10,61,94,75,92,94,79,92,10,51,93,86,75,88,78,10,90,92,89,81,92,79,93,93,83,89,88,10,77,89,87,90,86,79,94,79,78,24,10,65,75,83,94,83,88,81,10,80,89,92,10,48,83,93,82,87,75,88,10,45,75,96,79,10,94,92,75,96,79,86,10,90,82,75,93,79,24},22))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
local weaponTool = bp and bp:FindFirstChild(_d({55,79,86,79,79},22))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if npcRoot and npc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)) and npc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)) and finalNpc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)) and finalNpc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22)).Health > 0 and (tick() - combatStartTime) < 8 do
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
_G.GepoGrinderCleanup = function()
autoGrind = nil
cleanupForce()
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,45,86,79,75,88,79,78,10,95,90,10,90,92,79,96,83,89,95,93,10,93,79,93,93,83,89,88,24},22))
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,43,95,94,89,87,75,94,79,78,10,93,77,92,83,90,94,10,86,89,75,78,79,78,24,10,58,92,79,93,93,10,17,58,17,10,94,89,10,94,89,81,81,86,79,10,75,95,94,89,10,80,75,92,87,24},22))
end)()