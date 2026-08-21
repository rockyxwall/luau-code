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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({24,51,51,48},60)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({24,51,51,48},60)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({7,51,49,38,37,56},60))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({6,37,50,40,45,56},60)
local selectedWeapon = availableWeapons[1] or _d({7,51,49,38,37,56},60)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({6,37,50,40,45,56},60), _d({6,37,50,40,45,56,228,6,51,55,55},60), _d({8,37,52,44},60), _d({12,37,47,57},60), _d({16,45,48,61},60), _d({16,45,51,50,228,20,54,45,40,41},60), _d({17,37,54,53,57,37,50},60), _d({22,51,38,51},60), _d({22,51,50,50,61},60), _d({23,37,54,37,44},60)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({23,56,37,56,55},60)) and statsFolder.Stats:FindFirstChild(_d({20,41,48,45},60)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({18,20,7,55},60))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local hum = npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({18,20,7,55},60))
local yi = folder and folder:FindFirstChild(_d({29,45},60))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({29,45},60) and obj:IsA(_d({17,51,40,41,48},60)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({18,20,7,55},60))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({59,37,56,41,54},60)) or hitName:find(_d({55,41,37},60)) or hitName:find(_d({51,39,41,37,50},60)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({6,37,55,41,20,37,54,56},60)) then
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
local att = root:FindFirstChild(_d({35,35,11,54,45,50,40,41,54,5,56,56},60)) or Instance.new(_d({5,56,56,37,39,44,49,41,50,56},60))
att.Name = _d({35,35,11,54,45,50,40,41,54,5,56,56},60)
att.Parent = root
local force = root:FindFirstChild(_d({35,35,11,54,45,50,40,41,54,10,51,54,39,41},60))
if not force then
force = Instance.new(_d({16,45,50,41,37,54,26,41,48,51,39,45,56,61},60))
force.Name = _d({35,35,11,54,45,50,40,41,54,10,51,54,39,41},60)
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
local force = root:FindFirstChild(_d({35,35,11,54,45,50,40,41,54,10,51,54,39,41},60))
local att = root:FindFirstChild(_d({35,35,11,54,45,50,40,41,54,5,56,56},60))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({18,51,50,41},60)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({22,51,47,57,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,41,52,52,51},60), args)
elseif style == _d({6,48,37,39,47,16,41,43},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47},60), args)
elseif style == _d({15,37,49,45,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,37,49,45,55,44,45,47,45,11,41,52,52,51},60), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47,246},60), args)
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
local yiRoot = yi:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
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
local prompt = yi:FindFirstChildWhichIsA(_d({20,54,51,60,45,49,45,56,61,20,54,51,49,52,56},60), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,42,45,54,41,52,54,51,60,45,49,45,56,61,52,54,51,49,52,56,228,50,51,56,228,55,57,52,52,51,54,56,41,40,228,38,61,228,41,60,41,39,57,56,51,54,229},60))
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
local bp = LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if npcRoot and npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({20,48,37,61,41,54,11,57,45},60))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({11,20,19,11,54,45,50,40,41,54,18,37,56,45,58,41,25,13},60))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({11,54,45,50,40,41,54,17,51,38,45,48,41,24,51,43,43,48,41},60))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,7,48,41,37,50,41,40,228,57,52,228,52,54,41,58,45,51,57,55,228,55,41,55,55,45,51,50,242},60))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,27,45,50,40,25,13,243,49,37,45,50,243,40,45,55,56,243,49,37,45,50,242,48,57,37},60)))()
end)
if not ok or type(WindUI) ~= _d({56,37,38,48,41},60) then
warn(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,10,37,45,48,41,40,228,56,51,228,48,51,37,40,228,27,45,50,40,25,13,242},60))
return
end
local Window = WindUI:CreateWindow({
Title = _d({11,41,52,51,228,11,54,45,50,40,41,54,228,58,244,242,244,242,245,252},60),
Icon = _d({55,59,51,54,40},60),
Folder = _d({11,41,52,51,11,54,45,50,40,41,54},60),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({8,37,54,47},60),
OpenButton = {
Title = _d({11,41,52,51,228,11,54,45,50,40,41,54},60),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({5,57,56,51,228,10,37,54,49},60), Icon = _d({55,59,51,54,40},60) })
local tabGeppo = Window:Tab({ Title = _d({11,41,52,52,51,228,6,57,61,41,54},60), Icon = _d({55,44,51,52,52,45,50,43,241,39,37,54,56},60) })
local tabSettings = Window:Tab({ Title = _d({23,41,56,56,45,50,43,55},60), Icon = _d({55,41,56,56,45,50,43,55},60) })
tabFarm:Toggle({
Title = _d({5,57,56,51,228,11,54,45,50,40,228,17,51,38,55,228,31,20,33},60),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({24,37,54,43,41,56,228,17,51,38},60),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({27,41,37,52,51,50,228,243,228,17,41,48,41,41},60),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({20,41,48,45,228,27,37,48,48,41,56},60),
Desc = _d({16,51,37,40,45,50,43,242,242,242},60)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({20,41,48,45,228,27,37,48,48,41,56},60), Desc = tostring(peli) .. (peli >= 50000 and _d({228,31,22,9,5,8,29,229,33},60) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({5,57,56,51,228,6,57,61,228,11,41,52,52,51},60),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({6,61,52,37,55,55,228,249,244,47,228,20,41,48,45,228,7,44,41,39,47},60),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({8,41,55,56,54,51,61,228,25,13,228,234,228,23,56,51,52,228,9,58,41,54,61,56,44,45,50,43},60),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,228,12,57,38,33,228,58,244,242,244,242,245,252,228,48,51,37,40,41,40,228,59,45,56,44,228,27,45,50,40,25,13,242},60))
end)()