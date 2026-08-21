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
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({62,89,89,86},22)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({62,89,89,86},22)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({45,89,87,76,75,94},22))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({44,75,88,78,83,94},22)
local selectedWeapon = availableWeapons[1] or _d({45,89,87,76,75,94},22)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({44,75,88,78,83,94},22), _d({44,75,88,78,83,94,10,44,89,93,93},22), _d({46,75,90,82},22), _d({50,75,85,95},22), _d({54,83,86,99},22), _d({54,83,89,88,10,58,92,83,78,79},22), _d({55,75,92,91,95,75,88},22), _d({60,89,76,89},22), _d({60,89,88,88,99},22), _d({61,75,92,75,82},22)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({61,94,75,94,93},22)) and statsFolder.Stats:FindFirstChild(_d({58,79,86,83},22)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({56,58,45,93},22))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum = npc:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({56,58,45,93},22))
local yi = folder and folder:FindFirstChild(_d({67,83},22))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({67,83},22) and obj:IsA(_d({55,89,78,79,86},22)) then
return obj
end
end
return nil
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
if not autoGrind then
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,48,89,92,77,79},22))
local att = root:FindFirstChild(_d({73,73,49,92,83,88,78,79,92,43,94,94},22))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({56,89,88,79},22)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({60,89,85,95,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,79,90,90,89},22), args)
elseif style == _d({44,86,75,77,85,54,79,81},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85},22), args)
elseif style == _d({53,75,87,83,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,75,87,83,93,82,83,85,83,49,79,90,90,89},22), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85,28},22), args)
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
local yiRoot = yi:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
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
local prompt = yi:FindFirstChildWhichIsA(_d({58,92,89,98,83,87,83,94,99,58,92,89,87,90,94},22), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,80,83,92,79,90,92,89,98,83,87,83,94,99,90,92,89,87,90,94,10,88,89,94,10,93,95,90,90,89,92,94,79,78,10,76,99,10,79,98,79,77,95,94,89,92,11},22))
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
local bp = LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
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
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
local playerGui = LocalPlayer:FindFirstChild(_d({58,86,75,99,79,92,49,95,83},22))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({49,58,57,49,92,83,88,78,79,92,56,75,94,83,96,79,63,51},22))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({49,92,83,88,78,79,92,55,89,76,83,86,79,62,89,81,81,86,79},22))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,45,86,79,75,88,79,78,10,95,90,10,90,92,79,96,83,89,95,93,10,93,79,93,93,83,89,88,24},22))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,65,83,88,78,63,51,25,87,75,83,88,25,78,83,93,94,25,87,75,83,88,24,86,95,75},22)))()
end)
if not ok or type(WindUI) ~= _d({94,75,76,86,79},22) then
warn(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,10,65,83,88,78,63,51,24},22))
return
end
local Window = WindUI:CreateWindow({
Title = _d({49,79,90,89,10,49,92,83,88,78,79,92,10,96,26,24,26,24,27,34},22),
Icon = _d({93,97,89,92,78},22),
Folder = _d({49,79,90,89,49,92,83,88,78,79,92},22),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({46,75,92,85},22),
OpenButton = {
Title = _d({49,79,90,89,10,49,92,83,88,78,79,92},22),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({43,95,94,89,10,48,75,92,87},22), Icon = _d({93,97,89,92,78},22) })
local tabGeppo = Window:Tab({ Title = _d({49,79,90,90,89,10,44,95,99,79,92},22), Icon = _d({93,82,89,90,90,83,88,81,23,77,75,92,94},22) })
local tabSettings = Window:Tab({ Title = _d({61,79,94,94,83,88,81,93},22), Icon = _d({93,79,94,94,83,88,81,93},22) })
tabFarm:Toggle({
Title = _d({43,95,94,89,10,49,92,83,88,78,10,55,89,76,93,10,69,58,71},22),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({62,75,92,81,79,94,10,55,89,76},22),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({65,79,75,90,89,88,10,25,10,55,79,86,79,79},22),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({58,79,86,83,10,65,75,86,86,79,94},22),
Desc = _d({54,89,75,78,83,88,81,24,24,24},22)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({58,79,86,83,10,65,75,86,86,79,94},22), Desc = tostring(peli) .. (peli >= 50000 and _d({10,69,60,47,43,46,67,11,71},22) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({43,95,94,89,10,44,95,99,10,49,79,90,90,89},22),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({44,99,90,75,93,93,10,31,26,85,10,58,79,86,83,10,45,82,79,77,85},22),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({46,79,93,94,92,89,99,10,63,51,10,16,10,61,94,89,90,10,47,96,79,92,99,94,82,83,88,81},22),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({69,49,79,90,89,10,49,92,83,88,78,79,92,10,50,95,76,71,10,96,26,24,26,24,27,34,10,86,89,75,78,79,78,10,97,83,94,82,10,65,83,88,78,63,51,24},22))
end)()