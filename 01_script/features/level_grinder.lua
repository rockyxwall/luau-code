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
local Players = game:GetService(_d({63,91,80,104,84,97,98},17))
local ReplicatedStorage = game:GetService(_d({65,84,95,91,88,82,80,99,84,83,66,99,94,97,80,86,84},17))
local RunService = game:GetService(_d({65,100,93,66,84,97,101,88,82,84},17))
local VIM = game:GetService(_d({69,88,97,99,100,80,91,56,93,95,100,99,60,80,93,80,86,84,97},17))
local UserInputService = game:GetService(_d({68,98,84,97,56,93,95,100,99,66,84,97,101,88,82,84},17))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({49,80,82,90,95,80,82,90},17))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({67,94,94,91},17)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({67,94,94,91},17)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({50,94,92,81,80,99},17))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local autoBuyGun = false
local useGunGrind = false
local gunRange = 28
local bypassPeliCheck = false
local selectedMob = _d({49,80,93,83,88,99},17)
local selectedWeapon = availableWeapons[1] or _d({50,94,92,81,80,99},17)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({49,80,93,83,88,99},17), _d({49,80,93,83,88,99,15,49,94,98,98},17), _d({51,80,95,87},17), _d({55,80,90,100},17), _d({59,88,91,104},17), _d({59,88,94,93,15,63,97,88,83,84},17), _d({60,80,97,96,100,80,93},17), _d({65,94,81,94},17), _d({65,94,93,93,104},17), _d({66,80,97,80,87},17)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({66,99,80,99,98},17)) and statsFolder.Stats:FindFirstChild(_d({63,84,91,88},17)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({61,63,50,98},17))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
local hum = npc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({61,63,50,98},17))
local yi = folder and folder:FindFirstChild(_d({72,88},17))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({72,88},17) and obj:IsA(_d({60,94,83,84,91},17)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({61,63,50,98},17))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({102,80,99,84,97},17)) or hitName:find(_d({98,84,80},17)) or hitName:find(_d({94,82,84,80,93},17)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({49,80,98,84,63,80,97,99},17)) then
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
local att = root:FindFirstChild(_d({78,78,54,97,88,93,83,84,97,48,99,99},17)) or Instance.new(_d({48,99,99,80,82,87,92,84,93,99},17))
att.Name = _d({78,78,54,97,88,93,83,84,97,48,99,99},17)
att.Parent = root
local force = root:FindFirstChild(_d({78,78,54,97,88,93,83,84,97,53,94,97,82,84},17))
if not force then
force = Instance.new(_d({59,88,93,84,80,97,69,84,91,94,82,88,99,104},17))
force.Name = _d({78,78,54,97,88,93,83,84,97,53,94,97,82,84},17)
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
local force = root:FindFirstChild(_d({78,78,54,97,88,93,83,84,97,53,94,97,82,84},17))
local att = root:FindFirstChild(_d({78,78,54,97,88,93,83,84,97,48,99,99},17))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({66,99,80,99,98},17) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({61,94,93,84},17)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({65,94,90,100,98,87,88,90,88},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,84,95,95,94},17), args)
elseif style == _d({49,91,80,82,90,59,84,86},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({66,90,104,15,70,80,91,90},17), args)
elseif style == _d({58,80,92,88,98,87,88,90,88},17) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,80,92,88,98,87,88,90,88,54,84,95,95,94},17), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({66,90,104,15,70,80,91,90,33},17), args)
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
local yiRoot = yi:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
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
local prompt = yi:FindFirstChildWhichIsA(_d({63,97,94,103,88,92,88,99,104,63,97,94,92,95,99},17), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,85,88,97,84,95,97,94,103,88,92,88,99,104,95,97,94,92,95,99,15,93,94,99,15,98,100,95,95,94,97,99,84,83,15,81,104,15,84,103,84,82,100,99,94,97,16},17))
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
local hasGun = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or LocalPlayer.Character:FindFirstChild(_d({65,88,85,91,84},17)) or
LocalPlayer.Backpack:FindFirstChild(_d({63,88,98,99,94,91},17)) or LocalPlayer.Character:FindFirstChild(_d({63,88,98,99,94,91},17))
if autoBuyGun and not hasGun and peli >= 175 then
local buyables = workspace:FindFirstChild(_d({49,100,104,80,81,91,84,56,99,84,92,98},17))
local gunName = (peli >= 300) and _d({65,88,85,91,84},17) or _d({63,88,98,99,94,91},17)
local gunModel = buyables and buyables:FindFirstChild(gunName)
local shopPart = gunModel and gunModel:FindFirstChild(_d({66,87,94,95,63,80,97,99},17))
if shopPart then
local targetPos = shopPart.Position + Vector3.new(0, hoverHeight, 0)
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
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, shopPart.Position)
local prompt = gunModel:FindFirstChildWhichIsA(_d({63,97,94,103,88,92,88,99,104,63,97,94,92,95,99},17), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,85,88,97,84,95,97,94,103,88,92,88,99,104,95,97,94,92,95,99,15,93,94,99,15,98,100,95,95,94,97,99,84,83,15,81,104,15,84,103,84,82,100,99,94,97,16},17))
end
task.wait(1.5)
end
end
return
end
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local activeWeapon = selectedWeapon
local activeHoverHeight = hoverHeight
local isGun = false
if useGunGrind then
local backpackGun = LocalPlayer.Backpack:FindFirstChild(_d({65,88,85,91,84},17)) or LocalPlayer.Backpack:FindFirstChild(_d({63,88,98,99,94,91},17))
local characterGun = LocalPlayer.Character:FindFirstChild(_d({65,88,85,91,84},17)) or LocalPlayer.Character:FindFirstChild(_d({63,88,98,99,94,91},17))
local currentGun = characterGun or backpackGun
if currentGun then
activeWeapon = currentGun.Name
activeHoverHeight = gunRange
isGun = true
end
end
local bp = LocalPlayer:FindFirstChild(_d({49,80,82,90,95,80,82,90},17))
local weaponTool = bp and bp:FindFirstChild(activeWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
if npcRoot and npc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) and npc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)).Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, activeHoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, activeHoverHeight, 0)
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
if isGun then
myRoot.CFrame = CFrame.lookAt(myRoot.Position, npcRoot.Position)
else
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
end
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({55,100,92,80,93,94,88,83,65,94,94,99,63,80,97,99},17))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) and finalNpc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, activeHoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, activeHoverHeight, 0)
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)) and finalNpc:FindFirstChildWhichIsA(_d({55,100,92,80,93,94,88,83},17)).Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, activeHoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 or (isGun and dir.Magnitude < 35) then
force.VectorVelocity = Vector3.zero
if isGun then
myRoot.CFrame = CFrame.lookAt(myRoot.Position, finalRoot.Position)
else
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
end
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
local playerGui = LocalPlayer:FindFirstChild(_d({63,91,80,104,84,97,54,100,88},17))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({54,63,62,54,97,88,93,83,84,97,61,80,99,88,101,84,68,56},17))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({54,97,88,93,83,84,97,60,94,81,88,91,84,67,94,86,86,91,84},17))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,50,91,84,80,93,84,83,15,100,95,15,95,97,84,101,88,94,100,98,15,98,84,98,98,88,94,93,29},17))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({87,99,99,95,98,41,30,30,97,80,102,29,86,88,99,87,100,81,100,98,84,97,82,94,93,99,84,93,99,29,82,94,92,30,97,94,82,90,104,103,102,80,91,91,30,70,88,93,83,68,56,30,92,80,88,93,30,83,88,98,99,30,92,80,88,93,29,91,100,80},17)))()
end)
if not ok or type(WindUI) ~= _d({99,80,81,91,84},17) then
warn(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,76,15,53,80,88,91,84,83,15,99,94,15,91,94,80,83,15,70,88,93,83,68,56,29},17))
return
end
local Window = WindUI:CreateWindow({
Title = _d({54,84,95,94,15,54,97,88,93,83,84,97,15,101,31,29,31,29,32,39},17),
Icon = _d({98,102,94,97,83},17),
Folder = _d({54,84,95,94,54,97,88,93,83,84,97},17),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({51,80,97,90},17),
OpenButton = {
Title = _d({54,84,95,94,15,54,97,88,93,83,84,97},17),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({48,100,99,94,15,53,80,97,92},17), Icon = _d({98,102,94,97,83},17) })
local tabGeppo = Window:Tab({ Title = _d({54,84,95,95,94,15,49,100,104,84,97},17), Icon = _d({98,87,94,95,95,88,93,86,28,82,80,97,99},17) })
local tabGun = Window:Tab({ Title = _d({54,100,93,15,54,97,88,93,83,84,97},17), Icon = _d({98,87,88,84,91,83},17) })
local tabSettings = Window:Tab({ Title = _d({66,84,99,99,88,93,86,98},17), Icon = _d({98,84,99,99,88,93,86,98},17) })
tabFarm:Toggle({
Title = _d({48,100,99,94,15,54,97,88,93,83,15,60,94,81,98,15,74,63,76},17),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({67,80,97,86,84,99,15,60,94,81},17),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({70,84,80,95,94,93,15,30,15,60,84,91,84,84},17),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({63,84,91,88,15,70,80,91,91,84,99},17),
Desc = _d({59,94,80,83,88,93,86,29,29,29},17)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({63,84,91,88,15,70,80,91,91,84,99},17), Desc = tostring(peli) .. (peli >= 50000 and _d({15,74,65,52,48,51,72,16,76},17) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({48,100,99,94,15,49,100,104,15,54,84,95,95,94},17),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({49,104,95,80,98,98,15,36,31,90,15,63,84,91,88,15,50,87,84,82,90},17),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabGun:Toggle({
Title = _d({48,100,99,94,15,49,100,104,15,54,100,93},17),
Value = false,
Callback = function(val)
autoBuyGun = val
end
})
tabGun:Toggle({
Title = _d({68,98,84,15,54,100,93,15,23,51,88,98,99,80,93,82,84,15,53,80,97,92,24},17),
Value = false,
Callback = function(val)
useGunGrind = val
end
})
tabGun:Slider({
Title = _d({54,100,93,15,66,80,85,84,15,51,88,98,99,80,93,82,84},17),
Min = 15,
Max = 50,
Value = gunRange,
Callback = function(val)
gunRange = tonumber(val) or 28
end
})
tabSettings:Button({
Title = _d({51,84,98,99,97,94,104,15,68,56,15,21,15,66,99,94,95,15,52,101,84,97,104,99,87,88,93,86},17),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({74,54,84,95,94,15,54,97,88,93,83,84,97,15,55,100,81,76,15,101,31,29,31,29,32,39,15,91,94,80,83,84,83,15,102,88,99,87,15,70,88,93,83,68,56,29},17))
end)()