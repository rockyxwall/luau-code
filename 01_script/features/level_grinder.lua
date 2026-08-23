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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({56,83,83,80},28)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({56,83,83,80},28)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({39,83,81,70,69,88},28))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({38,69,82,72,77,88},28)
local selectedWeapon = availableWeapons[1] or _d({39,83,81,70,69,88},28)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({38,69,82,72,77,88},28), _d({38,69,82,72,77,88,4,38,83,87,87},28), _d({40,69,84,76},28), _d({44,69,79,89},28), _d({48,77,80,93},28), _d({48,77,83,82,4,52,86,77,72,73},28), _d({49,69,86,85,89,69,82},28), _d({54,83,70,83},28), _d({54,83,82,82,93},28), _d({55,69,86,69,76},28)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({55,88,69,88,87},28)) and statsFolder.Stats:FindFirstChild(_d({52,73,80,77},28)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hum = npc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({50,52,39,87},28))
local yi = folder and folder:FindFirstChild(_d({61,77},28))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({61,77},28) and obj:IsA(_d({49,83,72,73,80},28)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({50,52,39,87},28))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({91,69,88,73,86},28)) or hitName:find(_d({87,73,69},28)) or hitName:find(_d({83,71,73,69,82},28)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({38,69,87,73,52,69,86,88},28)) then
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
local att = root:FindFirstChild(_d({67,67,43,86,77,82,72,73,86,37,88,88},28)) or Instance.new(_d({37,88,88,69,71,76,81,73,82,88},28))
att.Name = _d({67,67,43,86,77,82,72,73,86,37,88,88},28)
att.Parent = root
local force = root:FindFirstChild(_d({67,67,43,86,77,82,72,73,86,42,83,86,71,73},28))
if not force then
force = Instance.new(_d({48,77,82,73,69,86,58,73,80,83,71,77,88,93},28))
force.Name = _d({67,67,43,86,77,82,72,73,86,42,83,86,71,73},28)
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
if not autoGrind then
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({67,67,43,86,77,82,72,73,86,42,83,86,71,73},28))
local att = root:FindFirstChild(_d({67,67,43,86,77,82,72,73,86,37,88,88},28))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({50,83,82,73},28)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({54,83,79,89,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,73,84,84,83},28), args)
elseif style == _d({38,80,69,71,79,48,73,75},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79},28), args)
elseif style == _d({47,69,81,77,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,69,81,77,87,76,77,79,77,43,73,84,84,83},28), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79,22},28), args)
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
local yiRoot = yi:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
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
local prompt = yi:FindFirstChildWhichIsA(_d({52,86,83,92,77,81,77,88,93,52,86,83,81,84,88},28), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({63,43,73,84,83,4,43,86,77,82,72,73,86,65,4,74,77,86,73,84,86,83,92,77,81,77,88,93,84,86,83,81,84,88,4,82,83,88,4,87,89,84,84,83,86,88,73,72,4,70,93,4,73,92,73,71,89,88,83,86,5},28))
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
local bp = LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if npcRoot and npc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)) and npc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)) and finalNpc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)) and finalNpc:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
local playerGui = LocalPlayer:FindFirstChild(_d({52,80,69,93,73,86,43,89,77},28))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({43,52,51,43,86,77,82,72,73,86,50,69,88,77,90,73,57,45},28))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({43,86,77,82,72,73,86,49,83,70,77,80,73,56,83,75,75,80,73},28))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({63,43,73,84,83,4,43,86,77,82,72,73,86,65,4,39,80,73,69,82,73,72,4,89,84,4,84,86,73,90,77,83,89,87,4,87,73,87,87,77,83,82,18},28))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,59,77,82,72,57,45,19,81,69,77,82,19,72,77,87,88,19,81,69,77,82,18,80,89,69},28)))()
end)
if not ok or type(WindUI) ~= _d({88,69,70,80,73},28) then
warn(_d({63,43,73,84,83,4,43,86,77,82,72,73,86,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,4,59,77,82,72,57,45,18},28))
return
end
local Window = WindUI:CreateWindow({
Title = _d({43,73,84,83,4,43,86,77,82,72,73,86,4,90,20,18,20,18,21,28},28),
Icon = _d({87,91,83,86,72},28),
Folder = _d({43,73,84,83,43,86,77,82,72,73,86},28),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({40,69,86,79},28),
OpenButton = {
Title = _d({43,73,84,83,4,43,86,77,82,72,73,86},28),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({37,89,88,83,4,42,69,86,81},28), Icon = _d({87,91,83,86,72},28) })
local tabGeppo = Window:Tab({ Title = _d({43,73,84,84,83,4,38,89,93,73,86},28), Icon = _d({87,76,83,84,84,77,82,75,17,71,69,86,88},28) })
local tabSettings = Window:Tab({ Title = _d({55,73,88,88,77,82,75,87},28), Icon = _d({87,73,88,88,77,82,75,87},28) })
tabFarm:Toggle({
Title = _d({37,89,88,83,4,43,86,77,82,72,4,49,83,70,87,4,63,52,65},28),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({56,69,86,75,73,88,4,49,83,70},28),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({59,73,69,84,83,82,4,19,4,49,73,80,73,73},28),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({52,73,80,77,4,59,69,80,80,73,88},28),
Desc = _d({48,83,69,72,77,82,75,18,18,18},28)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({52,73,80,77,4,59,69,80,80,73,88},28), Desc = tostring(peli) .. (peli >= 50000 and _d({4,63,54,41,37,40,61,5,65},28) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({37,89,88,83,4,38,89,93,4,43,73,84,84,83},28),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({38,93,84,69,87,87,4,25,20,79,4,52,73,80,77,4,39,76,73,71,79},28),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({40,73,87,88,86,83,93,4,57,45,4,10,4,55,88,83,84,4,41,90,73,86,93,88,76,77,82,75},28),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({63,43,73,84,83,4,43,86,77,82,72,73,86,4,44,89,70,65,4,90,20,18,20,18,21,28,4,80,83,69,72,73,72,4,91,77,88,76,4,59,77,82,72,57,45,18},28))
end)()