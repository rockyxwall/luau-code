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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({29,73,71,60,59,78},38))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({28,59,72,62,67,78},38)
local selectedWeapon = availableWeapons[1] or _d({29,73,71,60,59,78},38)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({28,59,72,62,67,78},38), _d({28,59,72,62,67,78,250,28,73,77,77},38), _d({30,59,74,66},38), _d({34,59,69,79},38), _d({38,67,70,83},38), _d({38,67,73,72,250,42,76,67,62,63},38), _d({39,59,76,75,79,59,72},38), _d({44,73,60,73},38), _d({44,73,72,72,83},38), _d({45,59,76,59,66},38)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({45,78,59,78,77},38)) and statsFolder.Stats:FindFirstChild(_d({42,63,70,67},38)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum = npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({40,42,29,77},38))
local yi = folder and folder:FindFirstChild(_d({51,67},38))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({51,67},38) and obj:IsA(_d({39,73,62,63,70},38)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({81,59,78,63,76},38)) or hitName:find(_d({77,63,59},38)) or hitName:find(_d({73,61,63,59,72},38)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({28,59,77,63,42,59,76,78},38)) then
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
local att = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,33,76,67,72,62,63,76,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38)
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
local force = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,32,73,76,61,63},38))
local att = root:FindFirstChild(_d({57,57,33,76,67,72,62,63,76,27,78,78},38))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({40,73,72,63},38)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({44,73,69,79,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,63,74,74,73},38), args)
elseif style == _d({28,70,59,61,69,38,63,65},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69},38), args)
elseif style == _d({37,59,71,67,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,59,71,67,77,66,67,69,67,33,63,74,74,73},38), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69,12},38), args)
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
local yiRoot = yi:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
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
local prompt = yi:FindFirstChildWhichIsA(_d({42,76,73,82,67,71,67,78,83,42,76,73,71,74,78},38), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,63,82,63,61,79,78,73,76,251},38))
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
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if npcRoot and npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({42,70,59,83,63,76,33,79,67},38))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({33,42,41,33,76,67,72,62,63,76,40,59,78,67,80,63,47,35},38))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({33,76,67,72,62,63,76,39,73,60,67,70,63,46,73,65,65,70,63},38))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,29,70,63,59,72,63,62,250,79,74,250,74,76,63,80,67,73,79,77,250,77,63,77,77,67,73,72,8},38))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,49,67,72,62,47,35,9,71,59,67,72,9,62,67,77,78,9,71,59,67,72,8,70,79,59},38)))()
end)
if not ok or type(WindUI) ~= _d({78,59,60,70,63},38) then
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,32,59,67,70,63,62,250,78,73,250,70,73,59,62,250,49,67,72,62,47,35,8},38))
return
end
local Window = WindUI:CreateWindow({
Title = _d({33,63,74,73,250,33,76,67,72,62,63,76,250,80,10,8,10,8,11,18},38),
Icon = _d({77,81,73,76,62},38),
Folder = _d({33,63,74,73,33,76,67,72,62,63,76},38),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({30,59,76,69},38),
OpenButton = {
Title = _d({33,63,74,73,250,33,76,67,72,62,63,76},38),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({27,79,78,73,250,32,59,76,71},38), Icon = _d({77,81,73,76,62},38) })
local tabGeppo = Window:Tab({ Title = _d({33,63,74,74,73,250,28,79,83,63,76},38), Icon = _d({77,66,73,74,74,67,72,65,7,61,59,76,78},38) })
local tabSettings = Window:Tab({ Title = _d({45,63,78,78,67,72,65,77},38), Icon = _d({77,63,78,78,67,72,65,77},38) })
tabFarm:Toggle({
Title = _d({27,79,78,73,250,33,76,67,72,62,250,39,73,60,77,250,53,42,55},38),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({46,59,76,65,63,78,250,39,73,60},38),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({49,63,59,74,73,72,250,9,250,39,63,70,63,63},38),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({42,63,70,67,250,49,59,70,70,63,78},38),
Desc = _d({38,73,59,62,67,72,65,8,8,8},38)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({42,63,70,67,250,49,59,70,70,63,78},38), Desc = tostring(peli) .. (peli >= 50000 and _d({250,53,44,31,27,30,51,251,55},38) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({27,79,78,73,250,28,79,83,250,33,63,74,74,73},38),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({28,83,74,59,77,77,250,15,10,69,250,42,63,70,67,250,29,66,63,61,69},38),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({30,63,77,78,76,73,83,250,47,35,250,0,250,45,78,73,74,250,31,80,63,76,83,78,66,67,72,65},38),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,250,34,79,60,55,250,80,10,8,10,8,11,18,250,70,73,59,62,63,62,250,81,67,78,66,250,49,67,72,62,47,35,8},38))
end)()