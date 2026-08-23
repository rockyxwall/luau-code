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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({26,53,53,50},58)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({26,53,53,50},58)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({9,53,51,40,39,58},58))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({8,39,52,42,47,58},58)
local selectedWeapon = availableWeapons[1] or _d({9,53,51,40,39,58},58)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({8,39,52,42,47,58},58), _d({8,39,52,42,47,58,230,8,53,57,57},58), _d({10,39,54,46},58), _d({14,39,49,59},58), _d({18,47,50,63},58), _d({18,47,53,52,230,22,56,47,42,43},58), _d({19,39,56,55,59,39,52},58), _d({24,53,40,53},58), _d({24,53,52,52,63},58), _d({25,39,56,39,46},58)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({25,58,39,58,57},58)) and statsFolder.Stats:FindFirstChild(_d({22,43,50,47},58)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = npc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({20,22,9,57},58))
local yi = folder and folder:FindFirstChild(_d({31,47},58))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({31,47},58) and obj:IsA(_d({19,53,42,43,50},58)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({20,22,9,57},58))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({61,39,58,43,56},58)) or hitName:find(_d({57,43,39},58)) or hitName:find(_d({53,41,43,39,52},58)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({8,39,57,43,22,39,56,58},58)) then
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
local att = root:FindFirstChild(_d({37,37,13,56,47,52,42,43,56,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,13,56,47,52,42,43,56,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,13,56,47,52,42,43,56,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,13,56,47,52,42,43,56,12,53,56,41,43},58)
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
local force = root:FindFirstChild(_d({37,37,13,56,47,52,42,43,56,12,53,56,41,43},58))
local att = root:FindFirstChild(_d({37,37,13,56,47,52,42,43,56,7,58,58},58))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({20,53,52,43},58)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({24,53,49,59,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,43,54,54,53},58), args)
elseif style == _d({8,50,39,41,49,18,43,45},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49},58), args)
elseif style == _d({17,39,51,47,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,39,51,47,57,46,47,49,47,13,43,54,54,53},58), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49,248},58), args)
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
local yiRoot = yi:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
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
local prompt = yi:FindFirstChildWhichIsA(_d({22,56,53,62,47,51,47,58,63,22,56,53,51,54,58},58), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({33,13,43,54,53,230,13,56,47,52,42,43,56,35,230,44,47,56,43,54,56,53,62,47,51,47,58,63,54,56,53,51,54,58,230,52,53,58,230,57,59,54,54,53,56,58,43,42,230,40,63,230,43,62,43,41,59,58,53,56,231},58))
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
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if npcRoot and npc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) and npc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) and finalNpc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) and finalNpc:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({22,50,39,63,43,56,13,59,47},58))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({13,22,21,13,56,47,52,42,43,56,20,39,58,47,60,43,27,15},58))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({13,56,47,52,42,43,56,19,53,40,47,50,43,26,53,45,45,50,43},58))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({33,13,43,54,53,230,13,56,47,52,42,43,56,35,230,9,50,43,39,52,43,42,230,59,54,230,54,56,43,60,47,53,59,57,230,57,43,57,57,47,53,52,244},58))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,29,47,52,42,27,15,245,51,39,47,52,245,42,47,57,58,245,51,39,47,52,244,50,59,39},58)))()
end)
if not ok or type(WindUI) ~= _d({58,39,40,50,43},58) then
warn(_d({33,13,43,54,53,230,13,56,47,52,42,43,56,35,230,12,39,47,50,43,42,230,58,53,230,50,53,39,42,230,29,47,52,42,27,15,244},58))
return
end
local Window = WindUI:CreateWindow({
Title = _d({13,43,54,53,230,13,56,47,52,42,43,56,230,60,246,244,246,244,247,254},58),
Icon = _d({57,61,53,56,42},58),
Folder = _d({13,43,54,53,13,56,47,52,42,43,56},58),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({10,39,56,49},58),
OpenButton = {
Title = _d({13,43,54,53,230,13,56,47,52,42,43,56},58),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({7,59,58,53,230,12,39,56,51},58), Icon = _d({57,61,53,56,42},58) })
local tabGeppo = Window:Tab({ Title = _d({13,43,54,54,53,230,8,59,63,43,56},58), Icon = _d({57,46,53,54,54,47,52,45,243,41,39,56,58},58) })
local tabSettings = Window:Tab({ Title = _d({25,43,58,58,47,52,45,57},58), Icon = _d({57,43,58,58,47,52,45,57},58) })
tabFarm:Toggle({
Title = _d({7,59,58,53,230,13,56,47,52,42,230,19,53,40,57,230,33,22,35},58),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({26,39,56,45,43,58,230,19,53,40},58),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({29,43,39,54,53,52,230,245,230,19,43,50,43,43},58),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({22,43,50,47,230,29,39,50,50,43,58},58),
Desc = _d({18,53,39,42,47,52,45,244,244,244},58)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({22,43,50,47,230,29,39,50,50,43,58},58), Desc = tostring(peli) .. (peli >= 50000 and _d({230,33,24,11,7,10,31,231,35},58) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({7,59,58,53,230,8,59,63,230,13,43,54,54,53},58),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({8,63,54,39,57,57,230,251,246,49,230,22,43,50,47,230,9,46,43,41,49},58),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({10,43,57,58,56,53,63,230,27,15,230,236,230,25,58,53,54,230,11,60,43,56,63,58,46,47,52,45},58),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({33,13,43,54,53,230,13,56,47,52,42,43,56,230,14,59,40,35,230,60,246,244,246,244,247,254,230,50,53,39,42,43,42,230,61,47,58,46,230,29,47,52,42,27,15,244},58))
end)()