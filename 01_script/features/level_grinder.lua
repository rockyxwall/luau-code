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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({43,74,76,84,89,74,76,84},23))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({61,88,88,85},23)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({61,88,88,85},23)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({44,88,86,75,74,93},23))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({43,74,87,77,82,93},23)
local selectedWeapon = availableWeapons[1] or _d({44,88,86,75,74,93},23)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({43,74,87,77,82,93},23), _d({43,74,87,77,82,93,9,43,88,92,92},23), _d({45,74,89,81},23), _d({49,74,84,94},23), _d({53,82,85,98},23), _d({53,82,88,87,9,57,91,82,77,78},23), _d({54,74,91,90,94,74,87},23), _d({59,88,75,88},23), _d({59,88,87,87,98},23), _d({60,74,91,74,81},23)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({60,93,74,93,92},23)) and statsFolder.Stats:FindFirstChild(_d({57,78,85,82},23)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hum = npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({55,57,44,92},23))
local yi = folder and folder:FindFirstChild(_d({66,82},23))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({66,82},23) and obj:IsA(_d({54,88,77,78,85},23)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({96,74,93,78,91},23)) or hitName:find(_d({92,78,74},23)) or hitName:find(_d({88,76,78,74,87},23)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({43,74,92,78,57,74,91,93},23)) then
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
local att = root:FindFirstChild(_d({72,72,48,91,82,87,77,78,91,42,93,93},23)) or Instance.new(_d({42,93,93,74,76,81,86,78,87,93},23))
att.Name = _d({72,72,48,91,82,87,77,78,91,42,93,93},23)
att.Parent = root
local force = root:FindFirstChild(_d({72,72,48,91,82,87,77,78,91,47,88,91,76,78},23))
if not force then
force = Instance.new(_d({53,82,87,78,74,91,63,78,85,88,76,82,93,98},23))
force.Name = _d({72,72,48,91,82,87,77,78,91,47,88,91,76,78},23)
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
local force = root:FindFirstChild(_d({72,72,48,91,82,87,77,78,91,47,88,91,76,78},23))
local att = root:FindFirstChild(_d({72,72,48,91,82,87,77,78,91,42,93,93},23))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({55,88,87,78},23)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({59,88,84,94,92,81,82,84,82},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,78,89,89,88},23), args)
elseif style == _d({43,85,74,76,84,53,78,80},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,84,98,9,64,74,85,84},23), args)
elseif style == _d({52,74,86,82,92,81,82,84,82},23) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,74,86,82,92,81,82,84,82,48,78,89,89,88},23), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,84,98,9,64,74,85,84,27},23), args)
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
local yiRoot = yi:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
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
local prompt = yi:FindFirstChildWhichIsA(_d({57,91,88,97,82,86,82,93,98,57,91,88,86,89,93},23), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,79,82,91,78,89,91,88,97,82,86,82,93,98,89,91,88,86,89,93,9,87,88,93,9,92,94,89,89,88,91,93,78,77,9,75,98,9,78,97,78,76,94,93,88,91,10},23))
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
local bp = LocalPlayer:FindFirstChild(_d({43,74,76,84,89,74,76,84},23))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if npcRoot and npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({57,85,74,98,78,91,48,94,82},23))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({48,57,56,48,91,82,87,77,78,91,55,74,93,82,95,78,62,50},23))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({48,91,82,87,77,78,91,54,88,75,82,85,78,61,88,80,80,85,78},23))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,44,85,78,74,87,78,77,9,94,89,9,89,91,78,95,82,88,94,92,9,92,78,92,92,82,88,87,23},23))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,64,82,87,77,62,50,24,86,74,82,87,24,77,82,92,93,24,86,74,82,87,23,85,94,74},23)))()
end)
if not ok or type(WindUI) ~= _d({93,74,75,85,78},23) then
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,47,74,82,85,78,77,9,93,88,9,85,88,74,77,9,64,82,87,77,62,50,23},23))
return
end
local Window = WindUI:CreateWindow({
Title = _d({48,78,89,88,9,48,91,82,87,77,78,91,9,95,25,23,25,23,26,33},23),
Icon = _d({92,96,88,91,77},23),
Folder = _d({48,78,89,88,48,91,82,87,77,78,91},23),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({45,74,91,84},23),
OpenButton = {
Title = _d({48,78,89,88,9,48,91,82,87,77,78,91},23),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({42,94,93,88,9,47,74,91,86},23), Icon = _d({92,96,88,91,77},23) })
local tabGeppo = Window:Tab({ Title = _d({48,78,89,89,88,9,43,94,98,78,91},23), Icon = _d({92,81,88,89,89,82,87,80,22,76,74,91,93},23) })
local tabSettings = Window:Tab({ Title = _d({60,78,93,93,82,87,80,92},23), Icon = _d({92,78,93,93,82,87,80,92},23) })
tabFarm:Toggle({
Title = _d({42,94,93,88,9,48,91,82,87,77,9,54,88,75,92,9,68,57,70},23),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({61,74,91,80,78,93,9,54,88,75},23),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({64,78,74,89,88,87,9,24,9,54,78,85,78,78},23),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({57,78,85,82,9,64,74,85,85,78,93},23),
Desc = _d({53,88,74,77,82,87,80,23,23,23},23)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({57,78,85,82,9,64,74,85,85,78,93},23), Desc = tostring(peli) .. (peli >= 50000 and _d({9,68,59,46,42,45,66,10,70},23) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({42,94,93,88,9,43,94,98,9,48,78,89,89,88},23),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({43,98,89,74,92,92,9,30,25,84,9,57,78,85,82,9,44,81,78,76,84},23),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({45,78,92,93,91,88,98,9,62,50,9,15,9,60,93,88,89,9,46,95,78,91,98,93,81,82,87,80},23),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,9,49,94,75,70,9,95,25,23,25,23,26,33,9,85,88,74,77,78,77,9,96,82,93,81,9,64,82,87,77,62,50,23},23))
end)()