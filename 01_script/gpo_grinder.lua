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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local VIM = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({55,82,82,79},29)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({55,82,82,79},29)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({38,82,80,69,68,87},29))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({37,68,81,71,76,87},29)
local selectedWeapon = availableWeapons[1] or _d({38,82,80,69,68,87},29)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({37,68,81,71,76,87},29), _d({37,68,81,71,76,87,3,37,82,86,86},29), _d({39,68,83,75},29), _d({43,68,78,88},29), _d({47,76,79,92},29), _d({47,76,82,81,3,51,85,76,71,72},29), _d({48,68,85,84,88,68,81},29), _d({53,82,69,82},29), _d({53,82,81,81,92},29), _d({54,68,85,68,75},29)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({54,87,68,87,86},29)) and statsFolder.Stats:FindFirstChild(_d({51,72,79,76},29)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local hum = npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({49,51,38,86},29))
local yi = folder and folder:FindFirstChild(_d({60,76},29))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({60,76},29) and obj:IsA(_d({48,82,71,72,79},29)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({90,68,87,72,85},29)) or hitName:find(_d({86,72,68},29)) or hitName:find(_d({82,70,72,68,81},29)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({37,68,86,72,51,68,85,87},29)) then
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
local att = root:FindFirstChild(_d({66,66,42,85,76,81,71,72,85,36,87,87},29)) or Instance.new(_d({36,87,87,68,70,75,80,72,81,87},29))
att.Name = _d({66,66,42,85,76,81,71,72,85,36,87,87},29)
att.Parent = root
local force = root:FindFirstChild(_d({66,66,42,85,76,81,71,72,85,41,82,85,70,72},29))
if not force then
force = Instance.new(_d({47,76,81,72,68,85,57,72,79,82,70,76,87,92},29))
force.Name = _d({66,66,42,85,76,81,71,72,85,41,82,85,70,72},29)
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
local force = root:FindFirstChild(_d({66,66,42,85,76,81,71,72,85,41,82,85,70,72},29))
local att = root:FindFirstChild(_d({66,66,42,85,76,81,71,72,85,36,87,87},29))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({49,82,81,72},29)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({53,82,78,88,86,75,76,78,76},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,72,83,83,82},29), args)
elseif style == _d({37,79,68,70,78,47,72,74},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,78,92,3,58,68,79,78},29), args)
elseif style == _d({46,68,80,76,86,75,76,78,76},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,68,80,76,86,75,76,78,76,42,72,83,83,82},29), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,78,92,3,58,68,79,78,21},29), args)
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
local yiRoot = yi:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
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
local prompt = yi:FindFirstChildWhichIsA(_d({51,85,82,91,76,80,76,87,92,51,85,82,80,83,87},29), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
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
local bp = LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if npcRoot and npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({42,51,50,42,85,76,81,71,72,85,49,68,87,76,89,72,56,44},29))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({42,85,76,81,71,72,85,48,82,69,76,79,72,55,82,74,74,79,72},29))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,38,79,72,68,81,72,71,3,88,83,3,83,85,72,89,76,82,88,86,3,86,72,86,86,76,82,81,17},29))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,58,76,81,71,56,44,18,80,68,76,81,18,71,76,86,87,18,80,68,76,81,17,79,88,68},29)))()
end)
if not ok or type(WindUI) ~= _d({87,68,69,79,72},29) then
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,3,58,76,81,71,56,44,17},29))
return
end
local Window = WindUI:CreateWindow({
Title = _d({42,72,83,82,3,42,85,76,81,71,72,85,3,89,19,17,19,17,20,27},29),
Icon = _d({86,90,82,85,71},29),
Folder = _d({42,72,83,82,42,85,76,81,71,72,85},29),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({39,68,85,78},29),
OpenButton = {
Title = _d({42,72,83,82,3,42,85,76,81,71,72,85},29),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({36,88,87,82,3,41,68,85,80},29), Icon = _d({86,90,82,85,71},29) })
local tabGeppo = Window:Tab({ Title = _d({42,72,83,83,82,3,37,88,92,72,85},29), Icon = _d({86,75,82,83,83,76,81,74,16,70,68,85,87},29) })
local tabSettings = Window:Tab({ Title = _d({54,72,87,87,76,81,74,86},29), Icon = _d({86,72,87,87,76,81,74,86},29) })
tabFarm:Toggle({
Title = _d({36,88,87,82,3,42,85,76,81,71,3,48,82,69,86,3,62,51,64},29),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({55,68,85,74,72,87,3,48,82,69},29),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({58,72,68,83,82,81,3,18,3,48,72,79,72,72},29),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({51,72,79,76,3,58,68,79,79,72,87},29),
Desc = _d({47,82,68,71,76,81,74,17,17,17},29)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({51,72,79,76,3,58,68,79,79,72,87},29), Desc = tostring(peli) .. (peli >= 50000 and _d({3,62,53,40,36,39,60,4,64},29) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({36,88,87,82,3,37,88,92,3,42,72,83,83,82},29),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({37,92,83,68,86,86,3,24,19,78,3,51,72,79,76,3,38,75,72,70,78},29),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({39,72,86,87,85,82,92,3,56,44,3,9,3,54,87,82,83,3,40,89,72,85,92,87,75,76,81,74},29),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,3,43,88,69,64,3,89,19,17,19,17,20,27,3,79,82,68,71,72,71,3,90,76,87,75,3,58,76,81,71,56,44,17},29))
end)()