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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({49,76,76,73},35)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({49,76,76,73},35)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({32,76,74,63,62,81},35))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({31,62,75,65,70,81},35)
local selectedWeapon = availableWeapons[1] or _d({32,76,74,63,62,81},35)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({31,62,75,65,70,81},35), _d({31,62,75,65,70,81,253,31,76,80,80},35), _d({33,62,77,69},35), _d({37,62,72,82},35), _d({41,70,73,86},35), _d({41,70,76,75,253,45,79,70,65,66},35), _d({42,62,79,78,82,62,75},35), _d({47,76,63,76},35), _d({47,76,75,75,86},35), _d({48,62,79,62,69},35)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({48,81,62,81,80},35)) and statsFolder.Stats:FindFirstChild(_d({45,66,73,70},35)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = npc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({43,45,32,80},35))
local yi = folder and folder:FindFirstChild(_d({54,70},35))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({54,70},35) and obj:IsA(_d({42,76,65,66,73},35)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({43,45,32,80},35))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({84,62,81,66,79},35)) or hitName:find(_d({80,66,62},35)) or hitName:find(_d({76,64,66,62,75},35)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({31,62,80,66,45,62,79,81},35)) then
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
local att = root:FindFirstChild(_d({60,60,36,79,70,75,65,66,79,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,36,79,70,75,65,66,79,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,36,79,70,75,65,66,79,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,36,79,70,75,65,66,79,35,76,79,64,66},35)
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
local force = root:FindFirstChild(_d({60,60,36,79,70,75,65,66,79,35,76,79,64,66},35))
local att = root:FindFirstChild(_d({60,60,36,79,70,75,65,66,79,30,81,81},35))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({43,76,75,66},35)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({47,76,72,82,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,66,77,77,76},35), args)
elseif style == _d({31,73,62,64,72,41,66,68},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72},35), args)
elseif style == _d({40,62,74,70,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,62,74,70,80,69,70,72,70,36,66,77,77,76},35), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72,15},35), args)
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
local yiRoot = yi:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
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
local prompt = yi:FindFirstChildWhichIsA(_d({45,79,76,85,70,74,70,81,86,45,79,76,74,77,81},35), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,67,70,79,66,77,79,76,85,70,74,70,81,86,77,79,76,74,77,81,253,75,76,81,253,80,82,77,77,76,79,81,66,65,253,63,86,253,66,85,66,64,82,81,76,79,254},35))
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
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if npcRoot and npc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) and npc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) and finalNpc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) and finalNpc:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({45,73,62,86,66,79,36,82,70},35))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({36,45,44,36,79,70,75,65,66,79,43,62,81,70,83,66,50,38},35))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({36,79,70,75,65,66,79,42,76,63,70,73,66,49,76,68,68,73,66},35))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,32,73,66,62,75,66,65,253,82,77,253,77,79,66,83,70,76,82,80,253,80,66,80,80,70,76,75,11},35))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,52,70,75,65,50,38,12,74,62,70,75,12,65,70,80,81,12,74,62,70,75,11,73,82,62},35)))()
end)
if not ok or type(WindUI) ~= _d({81,62,63,73,66},35) then
warn(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,58,253,35,62,70,73,66,65,253,81,76,253,73,76,62,65,253,52,70,75,65,50,38,11},35))
return
end
local Window = WindUI:CreateWindow({
Title = _d({36,66,77,76,253,36,79,70,75,65,66,79,253,83,13,11,13,11,14,21},35),
Icon = _d({80,84,76,79,65},35),
Folder = _d({36,66,77,76,36,79,70,75,65,66,79},35),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({33,62,79,72},35),
OpenButton = {
Title = _d({36,66,77,76,253,36,79,70,75,65,66,79},35),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({30,82,81,76,253,35,62,79,74},35), Icon = _d({80,84,76,79,65},35) })
local tabGeppo = Window:Tab({ Title = _d({36,66,77,77,76,253,31,82,86,66,79},35), Icon = _d({80,69,76,77,77,70,75,68,10,64,62,79,81},35) })
local tabSettings = Window:Tab({ Title = _d({48,66,81,81,70,75,68,80},35), Icon = _d({80,66,81,81,70,75,68,80},35) })
tabFarm:Toggle({
Title = _d({30,82,81,76,253,36,79,70,75,65,253,42,76,63,80,253,56,45,58},35),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({49,62,79,68,66,81,253,42,76,63},35),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({52,66,62,77,76,75,253,12,253,42,66,73,66,66},35),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({45,66,73,70,253,52,62,73,73,66,81},35),
Desc = _d({41,76,62,65,70,75,68,11,11,11},35)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({45,66,73,70,253,52,62,73,73,66,81},35), Desc = tostring(peli) .. (peli >= 50000 and _d({253,56,47,34,30,33,54,254,58},35) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({30,82,81,76,253,31,82,86,253,36,66,77,77,76},35),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({31,86,77,62,80,80,253,18,13,72,253,45,66,73,70,253,32,69,66,64,72},35),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({33,66,80,81,79,76,86,253,50,38,253,3,253,48,81,76,77,253,34,83,66,79,86,81,69,70,75,68},35),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({56,36,66,77,76,253,36,79,70,75,65,66,79,253,37,82,63,58,253,83,13,11,13,11,14,21,253,73,76,62,65,66,65,253,84,70,81,69,253,52,70,75,65,50,38,11},35))
end)()