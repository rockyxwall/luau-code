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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({23,50,50,47},61)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({23,50,50,47},61)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({6,50,48,37,36,55},61))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({5,36,49,39,44,55},61)
local selectedWeapon = availableWeapons[1] or _d({6,50,48,37,36,55},61)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({5,36,49,39,44,55},61), _d({5,36,49,39,44,55,227,5,50,54,54},61), _d({7,36,51,43},61), _d({11,36,46,56},61), _d({15,44,47,60},61), _d({15,44,50,49,227,19,53,44,39,40},61), _d({16,36,53,52,56,36,49},61), _d({21,50,37,50},61), _d({21,50,49,49,60},61), _d({22,36,53,36,43},61)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({22,55,36,55,54},61)) and statsFolder.Stats:FindFirstChild(_d({19,40,47,44},61)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({17,19,6,54},61))
local yi = folder and folder:FindFirstChild(_d({28,44},61))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({28,44},61) and obj:IsA(_d({16,50,39,40,47},61)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({58,36,55,40,53},61)) or hitName:find(_d({54,40,36},61)) or hitName:find(_d({50,38,40,36,49},61)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
local att = root:FindFirstChild(_d({34,34,10,53,44,49,39,40,53,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
att.Name = _d({34,34,10,53,44,49,39,40,53,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,10,53,44,49,39,40,53,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,10,53,44,49,39,40,53,9,50,53,38,40},61)
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
local force = root:FindFirstChild(_d({34,34,10,53,44,49,39,40,53,9,50,53,38,40},61))
local att = root:FindFirstChild(_d({34,34,10,53,44,49,39,40,53,4,55,55},61))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({17,50,49,40},61)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({21,50,46,56,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({10,40,51,51,50},61), args)
elseif style == _d({5,47,36,38,46,15,40,42},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46},61), args)
elseif style == _d({14,36,48,44,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,36,48,44,54,43,44,46,44,10,40,51,51,50},61), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46,245},61), args)
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
local yiRoot = yi:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
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
local prompt = yi:FindFirstChildWhichIsA(_d({19,53,50,59,44,48,44,55,60,19,53,50,48,51,55},61), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,41,44,53,40,51,53,50,59,44,48,44,55,60,51,53,50,48,51,55,227,49,50,55,227,54,56,51,51,50,53,55,40,39,227,37,60,227,40,59,40,38,56,55,50,53,228},61))
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
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if npcRoot and npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({19,47,36,60,40,53,10,56,44},61))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({10,19,18,10,53,44,49,39,40,53,17,36,55,44,57,40,24,12},61))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({10,53,44,49,39,40,53,16,50,37,44,47,40,23,50,42,42,47,40},61))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,6,47,40,36,49,40,39,227,56,51,227,51,53,40,57,44,50,56,54,227,54,40,54,54,44,50,49,241},61))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,26,44,49,39,24,12,242,48,36,44,49,242,39,44,54,55,242,48,36,44,49,241,47,56,36},61)))()
end)
if not ok or type(WindUI) ~= _d({55,36,37,47,40},61) then
warn(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,26,44,49,39,24,12,241},61))
return
end
local Window = WindUI:CreateWindow({
Title = _d({10,40,51,50,227,10,53,44,49,39,40,53,227,57,243,241,243,241,244,251},61),
Icon = _d({54,58,50,53,39},61),
Folder = _d({10,40,51,50,10,53,44,49,39,40,53},61),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({7,36,53,46},61),
OpenButton = {
Title = _d({10,40,51,50,227,10,53,44,49,39,40,53},61),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({4,56,55,50,227,9,36,53,48},61), Icon = _d({54,58,50,53,39},61) })
local tabGeppo = Window:Tab({ Title = _d({10,40,51,51,50,227,5,56,60,40,53},61), Icon = _d({54,43,50,51,51,44,49,42,240,38,36,53,55},61) })
local tabSettings = Window:Tab({ Title = _d({22,40,55,55,44,49,42,54},61), Icon = _d({54,40,55,55,44,49,42,54},61) })
tabFarm:Toggle({
Title = _d({4,56,55,50,227,10,53,44,49,39,227,16,50,37,54,227,30,19,32},61),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({23,36,53,42,40,55,227,16,50,37},61),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({26,40,36,51,50,49,227,242,227,16,40,47,40,40},61),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({19,40,47,44,227,26,36,47,47,40,55},61),
Desc = _d({15,50,36,39,44,49,42,241,241,241},61)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({19,40,47,44,227,26,36,47,47,40,55},61), Desc = tostring(peli) .. (peli >= 50000 and _d({227,30,21,8,4,7,28,228,32},61) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({4,56,55,50,227,5,56,60,227,10,40,51,51,50},61),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({5,60,51,36,54,54,227,248,243,46,227,19,40,47,44,227,6,43,40,38,46},61),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({7,40,54,55,53,50,60,227,24,12,227,233,227,22,55,50,51,227,8,57,40,53,60,55,43,44,49,42},61),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,227,11,56,37,32,227,57,243,241,243,241,244,251,227,47,50,36,39,40,39,227,58,44,55,43,227,26,44,49,39,24,12,241},61))
end)()