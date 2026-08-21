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
local Players = game:GetService(_d({65,93,82,106,86,99,100},15))
local ReplicatedStorage = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local RunService = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local VIM = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local UserInputService = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({69,96,96,93},15)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({69,96,96,93},15)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({52,96,94,83,82,101},15))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({51,82,95,85,90,101},15)
local selectedWeapon = availableWeapons[1] or _d({52,96,94,83,82,101},15)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({51,82,95,85,90,101},15), _d({51,82,95,85,90,101,17,51,96,100,100},15), _d({53,82,97,89},15), _d({57,82,92,102},15), _d({61,90,93,106},15), _d({61,90,96,95,17,65,99,90,85,86},15), _d({62,82,99,98,102,82,95},15), _d({67,96,83,96},15), _d({67,96,95,95,106},15), _d({68,82,99,82,89},15)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({68,101,82,101,100},15)) and statsFolder.Stats:FindFirstChild(_d({65,86,93,90},15)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum = npc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({63,65,52,100},15))
local yi = folder and folder:FindFirstChild(_d({74,90},15))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({74,90},15) and obj:IsA(_d({62,96,85,86,93},15)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({63,65,52,100},15))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({104,82,101,86,99},15)) or hitName:find(_d({100,86,82},15)) or hitName:find(_d({96,84,86,82,95},15)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({51,82,100,86,65,82,99,101},15)) then
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
local att = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,56,99,90,95,85,86,99,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15)
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
local force = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,55,96,99,84,86},15))
local att = root:FindFirstChild(_d({80,80,56,99,90,95,85,86,99,50,101,101},15))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({63,96,95,86},15)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({67,96,92,102,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,86,97,97,96},15), args)
elseif style == _d({51,93,82,84,92,61,86,88},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92},15), args)
elseif style == _d({60,82,94,90,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,82,94,90,100,89,90,92,90,56,86,97,97,96},15), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92,35},15), args)
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
local yiRoot = yi:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
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
local prompt = yi:FindFirstChildWhichIsA(_d({65,99,96,105,90,94,90,101,106,65,99,96,94,97,101},15), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,87,90,99,86,97,99,96,105,90,94,90,101,106,97,99,96,94,97,101,17,95,96,101,17,100,102,97,97,96,99,101,86,85,17,83,106,17,86,105,86,84,102,101,96,99,18},15))
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
local bp = LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if npcRoot and npc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) and npc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) and finalNpc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)) and finalNpc:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({65,93,82,106,86,99,56,102,90},15))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({56,65,64,56,99,90,95,85,86,99,63,82,101,90,103,86,70,58},15))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({56,99,90,95,85,86,99,62,96,83,90,93,86,69,96,88,88,93,86},15))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,52,93,86,82,95,86,85,17,102,97,17,97,99,86,103,90,96,102,100,17,100,86,100,100,90,96,95,31},15))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({89,101,101,97,100,43,32,32,99,82,104,31,88,90,101,89,102,83,102,100,86,99,84,96,95,101,86,95,101,31,84,96,94,32,99,96,84,92,106,105,104,82,93,93,32,72,90,95,85,70,58,32,94,82,90,95,32,85,90,100,101,32,94,82,90,95,31,93,102,82},15)))()
end)
if not ok or type(WindUI) ~= _d({101,82,83,93,86},15) then
warn(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,78,17,55,82,90,93,86,85,17,101,96,17,93,96,82,85,17,72,90,95,85,70,58,31},15))
return
end
local Window = WindUI:CreateWindow({
Title = _d({56,86,97,96,17,56,99,90,95,85,86,99,17,103,33,31,33,31,34,41},15),
Icon = _d({100,104,96,99,85},15),
Folder = _d({56,86,97,96,56,99,90,95,85,86,99},15),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({53,82,99,92},15),
OpenButton = {
Title = _d({56,86,97,96,17,56,99,90,95,85,86,99},15),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({50,102,101,96,17,55,82,99,94},15), Icon = _d({100,104,96,99,85},15) })
local tabGeppo = Window:Tab({ Title = _d({56,86,97,97,96,17,51,102,106,86,99},15), Icon = _d({100,89,96,97,97,90,95,88,30,84,82,99,101},15) })
local tabSettings = Window:Tab({ Title = _d({68,86,101,101,90,95,88,100},15), Icon = _d({100,86,101,101,90,95,88,100},15) })
tabFarm:Toggle({
Title = _d({50,102,101,96,17,56,99,90,95,85,17,62,96,83,100,17,76,65,78},15),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({69,82,99,88,86,101,17,62,96,83},15),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({72,86,82,97,96,95,17,32,17,62,86,93,86,86},15),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({65,86,93,90,17,72,82,93,93,86,101},15),
Desc = _d({61,96,82,85,90,95,88,31,31,31},15)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({65,86,93,90,17,72,82,93,93,86,101},15), Desc = tostring(peli) .. (peli >= 50000 and _d({17,76,67,54,50,53,74,18,78},15) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({50,102,101,96,17,51,102,106,17,56,86,97,97,96},15),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({51,106,97,82,100,100,17,38,33,92,17,65,86,93,90,17,52,89,86,84,92},15),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({53,86,100,101,99,96,106,17,70,58,17,23,17,68,101,96,97,17,54,103,86,99,106,101,89,90,95,88},15),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({76,56,86,97,96,17,56,99,90,95,85,86,99,17,57,102,83,78,17,103,33,31,33,31,34,41,17,93,96,82,85,86,85,17,104,90,101,89,17,72,90,95,85,70,58,31},15))
end)()