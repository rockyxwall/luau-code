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
local Players = game:GetService(_d({35,63,52,76,56,69,70},45))
local ReplicatedStorage = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local RunService = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local VIM = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local UserInputService = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({39,66,66,63},45)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({39,66,66,63},45)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({22,66,64,53,52,71},45))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({21,52,65,55,60,71},45)
local selectedWeapon = availableWeapons[1] or _d({22,66,64,53,52,71},45)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({21,52,65,55,60,71},45), _d({21,52,65,55,60,71,243,21,66,70,70},45), _d({23,52,67,59},45), _d({27,52,62,72},45), _d({31,60,63,76},45), _d({31,60,66,65,243,35,69,60,55,56},45), _d({32,52,69,68,72,52,65},45), _d({37,66,53,66},45), _d({37,66,65,65,76},45), _d({38,52,69,52,59},45)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({38,71,52,71,70},45)) and statsFolder.Stats:FindFirstChild(_d({35,56,63,60},45)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({33,35,22,70},45))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hum = npc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({33,35,22,70},45))
local yi = folder and folder:FindFirstChild(_d({44,60},45))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({44,60},45) and obj:IsA(_d({32,66,55,56,63},45)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({33,35,22,70},45))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({74,52,71,56,69},45)) or hitName:find(_d({70,56,52},45)) or hitName:find(_d({66,54,56,52,65},45)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({21,52,70,56,35,52,69,71},45)) then
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
local att = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,26,69,60,65,55,56,69,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45)
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
local force = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,25,66,69,54,56},45))
local att = root:FindFirstChild(_d({50,50,26,69,60,65,55,56,69,20,71,71},45))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({33,66,65,56},45)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({37,66,62,72,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,56,67,67,66},45), args)
elseif style == _d({21,63,52,54,62,31,56,58},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62},45), args)
elseif style == _d({30,52,64,60,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,52,64,60,70,59,60,62,60,26,56,67,67,66},45), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62,5},45), args)
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
local yiRoot = yi:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
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
local prompt = yi:FindFirstChildWhichIsA(_d({35,69,66,75,60,64,60,71,76,35,69,66,64,67,71},45), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,57,60,69,56,67,69,66,75,60,64,60,71,76,67,69,66,64,67,71,243,65,66,71,243,70,72,67,67,66,69,71,56,55,243,53,76,243,56,75,56,54,72,71,66,69,244},45))
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
local bp = LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if npcRoot and npc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) and npc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) and finalNpc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)) and finalNpc:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({26,35,34,26,69,60,65,55,56,69,33,52,71,60,73,56,40,28},45))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({26,69,60,65,55,56,69,32,66,53,60,63,56,39,66,58,58,63,56},45))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,22,63,56,52,65,56,55,243,72,67,243,67,69,56,73,60,66,72,70,243,70,56,70,70,60,66,65,1},45))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({59,71,71,67,70,13,2,2,69,52,74,1,58,60,71,59,72,53,72,70,56,69,54,66,65,71,56,65,71,1,54,66,64,2,69,66,54,62,76,75,74,52,63,63,2,42,60,65,55,40,28,2,64,52,60,65,2,55,60,70,71,2,64,52,60,65,1,63,72,52},45)))()
end)
if not ok or type(WindUI) ~= _d({71,52,53,63,56},45) then
warn(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,48,243,25,52,60,63,56,55,243,71,66,243,63,66,52,55,243,42,60,65,55,40,28,1},45))
return
end
local Window = WindUI:CreateWindow({
Title = _d({26,56,67,66,243,26,69,60,65,55,56,69,243,73,3,1,3,1,4,11},45),
Icon = _d({70,74,66,69,55},45),
Folder = _d({26,56,67,66,26,69,60,65,55,56,69},45),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({23,52,69,62},45),
OpenButton = {
Title = _d({26,56,67,66,243,26,69,60,65,55,56,69},45),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({20,72,71,66,243,25,52,69,64},45), Icon = _d({70,74,66,69,55},45) })
local tabGeppo = Window:Tab({ Title = _d({26,56,67,67,66,243,21,72,76,56,69},45), Icon = _d({70,59,66,67,67,60,65,58,0,54,52,69,71},45) })
local tabSettings = Window:Tab({ Title = _d({38,56,71,71,60,65,58,70},45), Icon = _d({70,56,71,71,60,65,58,70},45) })
tabFarm:Toggle({
Title = _d({20,72,71,66,243,26,69,60,65,55,243,32,66,53,70,243,46,35,48},45),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({39,52,69,58,56,71,243,32,66,53},45),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({42,56,52,67,66,65,243,2,243,32,56,63,56,56},45),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({35,56,63,60,243,42,52,63,63,56,71},45),
Desc = _d({31,66,52,55,60,65,58,1,1,1},45)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({35,56,63,60,243,42,52,63,63,56,71},45), Desc = tostring(peli) .. (peli >= 50000 and _d({243,46,37,24,20,23,44,244,48},45) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({20,72,71,66,243,21,72,76,243,26,56,67,67,66},45),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({21,76,67,52,70,70,243,8,3,62,243,35,56,63,60,243,22,59,56,54,62},45),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({23,56,70,71,69,66,76,243,40,28,243,249,243,38,71,66,67,243,24,73,56,69,76,71,59,60,65,58},45),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({46,26,56,67,66,243,26,69,60,65,55,56,69,243,27,72,53,48,243,73,3,1,3,1,4,11,243,63,66,52,55,56,55,243,74,60,71,59,243,42,60,65,55,40,28,1},45))
end)()