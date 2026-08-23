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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({35,79,77,66,65,84},32))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({34,65,78,68,73,84},32)
local selectedWeapon = availableWeapons[1] or _d({35,79,77,66,65,84},32)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({34,65,78,68,73,84},32), _d({34,65,78,68,73,84,0,34,79,83,83},32), _d({36,65,80,72},32), _d({40,65,75,85},32), _d({44,73,76,89},32), _d({44,73,79,78,0,48,82,73,68,69},32), _d({45,65,82,81,85,65,78},32), _d({50,79,66,79},32), _d({50,79,78,78,89},32), _d({51,65,82,65,72},32)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({51,84,65,84,83},32)) and statsFolder.Stats:FindFirstChild(_d({48,69,76,73},32)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = npc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({46,48,35,83},32))
local yi = folder and folder:FindFirstChild(_d({57,73},32))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({57,73},32) and obj:IsA(_d({45,79,68,69,76},32)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({87,65,84,69,82},32)) or hitName:find(_d({83,69,65},32)) or hitName:find(_d({79,67,69,65,78},32)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({34,65,83,69,48,65,82,84},32)) then
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
local att = root:FindFirstChild(_d({63,63,39,82,73,78,68,69,82,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,39,82,73,78,68,69,82,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,39,82,73,78,68,69,82,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,39,82,73,78,68,69,82,38,79,82,67,69},32)
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
local force = root:FindFirstChild(_d({63,63,39,82,73,78,68,69,82,38,79,82,67,69},32))
local att = root:FindFirstChild(_d({63,63,39,82,73,78,68,69,82,33,84,84},32))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({46,79,78,69},32)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
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
local yiRoot = yi:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
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
local prompt = yi:FindFirstChildWhichIsA(_d({48,82,79,88,73,77,73,84,89,48,82,79,77,80,84},32), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,70,73,82,69,80,82,79,88,73,77,73,84,89,80,82,79,77,80,84,0,78,79,84,0,83,85,80,80,79,82,84,69,68,0,66,89,0,69,88,69,67,85,84,79,82,1},32))
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
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if npcRoot and npc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) and npc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) and finalNpc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) and finalNpc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({39,48,47,39,82,73,78,68,69,82,46,65,84,73,86,69,53,41},32))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({39,82,73,78,68,69,82,45,79,66,73,76,69,52,79,71,71,76,69},32))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,35,76,69,65,78,69,68,0,85,80,0,80,82,69,86,73,79,85,83,0,83,69,83,83,73,79,78,14},32))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,55,73,78,68,53,41,15,77,65,73,78,15,68,73,83,84,15,77,65,73,78,14,76,85,65},32)))()
end)
if not ok or type(WindUI) ~= _d({84,65,66,76,69},32) then
warn(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,55,73,78,68,53,41,14},32))
return
end
local Window = WindUI:CreateWindow({
Title = _d({39,69,80,79,0,39,82,73,78,68,69,82,0,86,16,14,16,14,17,24},32),
Icon = _d({83,87,79,82,68},32),
Folder = _d({39,69,80,79,39,82,73,78,68,69,82},32),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({36,65,82,75},32),
OpenButton = {
Title = _d({39,69,80,79,0,39,82,73,78,68,69,82},32),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({33,85,84,79,0,38,65,82,77},32), Icon = _d({83,87,79,82,68},32) })
local tabGeppo = Window:Tab({ Title = _d({39,69,80,80,79,0,34,85,89,69,82},32), Icon = _d({83,72,79,80,80,73,78,71,13,67,65,82,84},32) })
local tabSettings = Window:Tab({ Title = _d({51,69,84,84,73,78,71,83},32), Icon = _d({83,69,84,84,73,78,71,83},32) })
tabFarm:Toggle({
Title = _d({33,85,84,79,0,39,82,73,78,68,0,45,79,66,83,0,59,48,61},32),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({52,65,82,71,69,84,0,45,79,66},32),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({55,69,65,80,79,78,0,15,0,45,69,76,69,69},32),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({48,69,76,73,0,55,65,76,76,69,84},32),
Desc = _d({44,79,65,68,73,78,71,14,14,14},32)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({48,69,76,73,0,55,65,76,76,69,84},32), Desc = tostring(peli) .. (peli >= 50000 and _d({0,59,50,37,33,36,57,1,61},32) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({33,85,84,79,0,34,85,89,0,39,69,80,80,79},32),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({34,89,80,65,83,83,0,21,16,75,0,48,69,76,73,0,35,72,69,67,75},32),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({36,69,83,84,82,79,89,0,53,41,0,6,0,51,84,79,80,0,37,86,69,82,89,84,72,73,78,71},32),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({59,39,69,80,79,0,39,82,73,78,68,69,82,0,40,85,66,61,0,86,16,14,16,14,17,24,0,76,79,65,68,69,68,0,87,73,84,72,0,55,73,78,68,53,41,14},32))
end)()