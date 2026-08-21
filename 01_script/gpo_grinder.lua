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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local RunService = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local VIM = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({21,48,48,45},63)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({21,48,48,45},63)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({4,48,46,35,34,53},63))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({3,34,47,37,42,53},63)
local selectedWeapon = availableWeapons[1] or _d({4,48,46,35,34,53},63)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({3,34,47,37,42,53},63), _d({3,34,47,37,42,53,225,3,48,52,52},63), _d({5,34,49,41},63), _d({9,34,44,54},63), _d({13,42,45,58},63), _d({13,42,48,47,225,17,51,42,37,38},63), _d({14,34,51,50,54,34,47},63), _d({19,48,35,48},63), _d({19,48,47,47,58},63), _d({20,34,51,34,41},63)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({20,53,34,53,52},63)) and statsFolder.Stats:FindFirstChild(_d({17,38,45,42},63)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum = npc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({15,17,4,52},63))
local yi = folder and folder:FindFirstChild(_d({26,42},63))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({26,42},63) and obj:IsA(_d({14,48,37,38,45},63)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({56,34,53,38,51},63)) or hitName:find(_d({52,38,34},63)) or hitName:find(_d({48,36,38,34,47},63)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({3,34,52,38,17,34,51,53},63)) then
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
local att = root:FindFirstChild(_d({32,32,8,51,42,47,37,38,51,2,53,53},63)) or Instance.new(_d({2,53,53,34,36,41,46,38,47,53},63))
att.Name = _d({32,32,8,51,42,47,37,38,51,2,53,53},63)
att.Parent = root
local force = root:FindFirstChild(_d({32,32,8,51,42,47,37,38,51,7,48,51,36,38},63))
if not force then
force = Instance.new(_d({13,42,47,38,34,51,23,38,45,48,36,42,53,58},63))
force.Name = _d({32,32,8,51,42,47,37,38,51,7,48,51,36,38},63)
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
local force = root:FindFirstChild(_d({32,32,8,51,42,47,37,38,51,7,48,51,36,38},63))
local att = root:FindFirstChild(_d({32,32,8,51,42,47,37,38,51,2,53,53},63))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({15,48,47,38},63)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({19,48,44,54,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({8,38,49,49,48},63), args)
elseif style == _d({3,45,34,36,44,13,38,40},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44},63), args)
elseif style == _d({12,34,46,42,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,34,46,42,52,41,42,44,42,8,38,49,49,48},63), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44,243},63), args)
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
local yiRoot = yi:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
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
local prompt = yi:FindFirstChildWhichIsA(_d({17,51,48,57,42,46,42,53,58,17,51,48,46,49,53},63), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,39,42,51,38,49,51,48,57,42,46,42,53,58,49,51,48,46,49,53,225,47,48,53,225,52,54,49,49,48,51,53,38,37,225,35,58,225,38,57,38,36,54,53,48,51,226},63))
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
local bp = LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if npcRoot and npc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) and npc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) and finalNpc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)) and finalNpc:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({8,17,16,8,51,42,47,37,38,51,15,34,53,42,55,38,22,10},63))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({8,51,42,47,37,38,51,14,48,35,42,45,38,21,48,40,40,45,38},63))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,4,45,38,34,47,38,37,225,54,49,225,49,51,38,55,42,48,54,52,225,52,38,52,52,42,48,47,239},63))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,24,42,47,37,22,10,240,46,34,42,47,240,37,42,52,53,240,46,34,42,47,239,45,54,34},63)))()
end)
if not ok or type(WindUI) ~= _d({53,34,35,45,38},63) then
warn(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,225,24,42,47,37,22,10,239},63))
return
end
local Window = WindUI:CreateWindow({
Title = _d({8,38,49,48,225,8,51,42,47,37,38,51,225,55,241,239,241,239,242,249},63),
Icon = _d({52,56,48,51,37},63),
Folder = _d({8,38,49,48,8,51,42,47,37,38,51},63),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({5,34,51,44},63),
OpenButton = {
Title = _d({8,38,49,48,225,8,51,42,47,37,38,51},63),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({2,54,53,48,225,7,34,51,46},63), Icon = _d({52,56,48,51,37},63) })
local tabGeppo = Window:Tab({ Title = _d({8,38,49,49,48,225,3,54,58,38,51},63), Icon = _d({52,41,48,49,49,42,47,40,238,36,34,51,53},63) })
local tabSettings = Window:Tab({ Title = _d({20,38,53,53,42,47,40,52},63), Icon = _d({52,38,53,53,42,47,40,52},63) })
tabFarm:Toggle({
Title = _d({2,54,53,48,225,8,51,42,47,37,225,14,48,35,52,225,28,17,30},63),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({21,34,51,40,38,53,225,14,48,35},63),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({24,38,34,49,48,47,225,240,225,14,38,45,38,38},63),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({17,38,45,42,225,24,34,45,45,38,53},63),
Desc = _d({13,48,34,37,42,47,40,239,239,239},63)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({17,38,45,42,225,24,34,45,45,38,53},63), Desc = tostring(peli) .. (peli >= 50000 and _d({225,28,19,6,2,5,26,226,30},63) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({2,54,53,48,225,3,54,58,225,8,38,49,49,48},63),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({3,58,49,34,52,52,225,246,241,44,225,17,38,45,42,225,4,41,38,36,44},63),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({5,38,52,53,51,48,58,225,22,10,225,231,225,20,53,48,49,225,6,55,38,51,58,53,41,42,47,40},63),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({28,8,38,49,48,225,8,51,42,47,37,38,51,225,9,54,35,30,225,55,241,239,241,239,242,249,225,45,48,34,37,38,37,225,56,42,53,41,225,24,42,47,37,22,10,239},63))
end)()