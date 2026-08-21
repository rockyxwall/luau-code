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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local RunService = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local VIM = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
local UserInputService = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({44,71,71,68},40)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({44,71,71,68},40)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({27,71,69,58,57,76},40))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({26,57,70,60,65,76},40)
local selectedWeapon = availableWeapons[1] or _d({27,71,69,58,57,76},40)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({26,57,70,60,65,76},40), _d({26,57,70,60,65,76,248,26,71,75,75},40), _d({28,57,72,64},40), _d({32,57,67,77},40), _d({36,65,68,81},40), _d({36,65,71,70,248,40,74,65,60,61},40), _d({37,57,74,73,77,57,70},40), _d({42,71,58,71},40), _d({42,71,70,70,81},40), _d({43,57,74,57,64},40)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({43,76,57,76,75},40)) and statsFolder.Stats:FindFirstChild(_d({40,61,68,65},40)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local hum = npc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({38,40,27,75},40))
local yi = folder and folder:FindFirstChild(_d({49,65},40))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({49,65},40) and obj:IsA(_d({37,71,60,61,68},40)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({38,40,27,75},40))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({79,57,76,61,74},40)) or hitName:find(_d({75,61,57},40)) or hitName:find(_d({71,59,61,57,70},40)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({26,57,75,61,40,57,74,76},40)) then
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
local att = root:FindFirstChild(_d({55,55,31,74,65,70,60,61,74,25,76,76},40)) or Instance.new(_d({25,76,76,57,59,64,69,61,70,76},40))
att.Name = _d({55,55,31,74,65,70,60,61,74,25,76,76},40)
att.Parent = root
local force = root:FindFirstChild(_d({55,55,31,74,65,70,60,61,74,30,71,74,59,61},40))
if not force then
force = Instance.new(_d({36,65,70,61,57,74,46,61,68,71,59,65,76,81},40))
force.Name = _d({55,55,31,74,65,70,60,61,74,30,71,74,59,61},40)
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
local force = root:FindFirstChild(_d({55,55,31,74,65,70,60,61,74,30,71,74,59,61},40))
local att = root:FindFirstChild(_d({55,55,31,74,65,70,60,61,74,25,76,76},40))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({38,71,70,61},40)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({42,71,67,77,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,61,72,72,71},40), args)
elseif style == _d({26,68,57,59,67,36,61,63},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67},40), args)
elseif style == _d({35,57,69,65,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,57,69,65,75,64,65,67,65,31,61,72,72,71},40), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67,10},40), args)
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
local yiRoot = yi:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
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
local prompt = yi:FindFirstChildWhichIsA(_d({40,74,71,80,65,69,65,76,81,40,74,71,69,72,76},40), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({51,31,61,72,71,248,31,74,65,70,60,61,74,53,248,62,65,74,61,72,74,71,80,65,69,65,76,81,72,74,71,69,72,76,248,70,71,76,248,75,77,72,72,71,74,76,61,60,248,58,81,248,61,80,61,59,77,76,71,74,249},40))
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
local bp = LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if npcRoot and npc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)) and npc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)) and finalNpc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)) and finalNpc:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({40,68,57,81,61,74,31,77,65},40))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({31,40,39,31,74,65,70,60,61,74,38,57,76,65,78,61,45,33},40))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({31,74,65,70,60,61,74,37,71,58,65,68,61,44,71,63,63,68,61},40))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({51,31,61,72,71,248,31,74,65,70,60,61,74,53,248,27,68,61,57,70,61,60,248,77,72,248,72,74,61,78,65,71,77,75,248,75,61,75,75,65,71,70,6},40))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,47,65,70,60,45,33,7,69,57,65,70,7,60,65,75,76,7,69,57,65,70,6,68,77,57},40)))()
end)
if not ok or type(WindUI) ~= _d({76,57,58,68,61},40) then
warn(_d({51,31,61,72,71,248,31,74,65,70,60,61,74,53,248,30,57,65,68,61,60,248,76,71,248,68,71,57,60,248,47,65,70,60,45,33,6},40))
return
end
local Window = WindUI:CreateWindow({
Title = _d({31,61,72,71,248,31,74,65,70,60,61,74,248,78,8,6,8,6,9,16},40),
Icon = _d({75,79,71,74,60},40),
Folder = _d({31,61,72,71,31,74,65,70,60,61,74},40),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({28,57,74,67},40),
OpenButton = {
Title = _d({31,61,72,71,248,31,74,65,70,60,61,74},40),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({25,77,76,71,248,30,57,74,69},40), Icon = _d({75,79,71,74,60},40) })
local tabGeppo = Window:Tab({ Title = _d({31,61,72,72,71,248,26,77,81,61,74},40), Icon = _d({75,64,71,72,72,65,70,63,5,59,57,74,76},40) })
local tabSettings = Window:Tab({ Title = _d({43,61,76,76,65,70,63,75},40), Icon = _d({75,61,76,76,65,70,63,75},40) })
tabFarm:Toggle({
Title = _d({25,77,76,71,248,31,74,65,70,60,248,37,71,58,75,248,51,40,53},40),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({44,57,74,63,61,76,248,37,71,58},40),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({47,61,57,72,71,70,248,7,248,37,61,68,61,61},40),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({40,61,68,65,248,47,57,68,68,61,76},40),
Desc = _d({36,71,57,60,65,70,63,6,6,6},40)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({40,61,68,65,248,47,57,68,68,61,76},40), Desc = tostring(peli) .. (peli >= 50000 and _d({248,51,42,29,25,28,49,249,53},40) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({25,77,76,71,248,26,77,81,248,31,61,72,72,71},40),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({26,81,72,57,75,75,248,13,8,67,248,40,61,68,65,248,27,64,61,59,67},40),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({28,61,75,76,74,71,81,248,45,33,248,254,248,43,76,71,72,248,29,78,61,74,81,76,64,65,70,63},40),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({51,31,61,72,71,248,31,74,65,70,60,61,74,248,32,77,58,53,248,78,8,6,8,6,9,16,248,68,71,57,60,61,60,248,79,65,76,64,248,47,65,70,60,45,33,6},40))
end)()