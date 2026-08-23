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
local Players = game:GetService(_d({27,55,44,68,48,61,62},53))
local ReplicatedStorage = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local RunService = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local VIM = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local UserInputService = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({31,58,58,55},53)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({31,58,58,55},53)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({14,58,56,45,44,63},53))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({13,44,57,47,52,63},53)
local selectedWeapon = availableWeapons[1] or _d({14,58,56,45,44,63},53)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({13,44,57,47,52,63},53), _d({13,44,57,47,52,63,235,13,58,62,62},53), _d({15,44,59,51},53), _d({19,44,54,64},53), _d({23,52,55,68},53), _d({23,52,58,57,235,27,61,52,47,48},53), _d({24,44,61,60,64,44,57},53), _d({29,58,45,58},53), _d({29,58,57,57,68},53), _d({30,44,61,44,51},53)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({30,63,44,63,62},53)) and statsFolder.Stats:FindFirstChild(_d({27,48,55,52},53)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({25,27,14,62},53))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local hum = npc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({25,27,14,62},53))
local yi = folder and folder:FindFirstChild(_d({36,52},53))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({36,52},53) and obj:IsA(_d({24,58,47,48,55},53)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({25,27,14,62},53))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({66,44,63,48,61},53)) or hitName:find(_d({62,48,44},53)) or hitName:find(_d({58,46,48,44,57},53)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({13,44,62,48,27,44,61,63},53)) then
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
local att = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,12,63,63},53)) or Instance.new(_d({12,63,63,44,46,51,56,48,57,63},53))
att.Name = _d({42,42,18,61,52,57,47,48,61,12,63,63},53)
att.Parent = root
local force = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53))
if not force then
force = Instance.new(_d({23,52,57,48,44,61,33,48,55,58,46,52,63,68},53))
force.Name = _d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53)
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
local force = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,17,58,61,46,48},53))
local att = root:FindFirstChild(_d({42,42,18,61,52,57,47,48,61,12,63,63},53))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({25,58,57,48},53)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({29,58,54,64,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,48,59,59,58},53), args)
elseif style == _d({13,55,44,46,54,23,48,50},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54},53), args)
elseif style == _d({22,44,56,52,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,44,56,52,62,51,52,54,52,18,48,59,59,58},53), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54,253},53), args)
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
local yiRoot = yi:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
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
local prompt = yi:FindFirstChildWhichIsA(_d({27,61,58,67,52,56,52,63,68,27,61,58,56,59,63},53), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,49,52,61,48,59,61,58,67,52,56,52,63,68,59,61,58,56,59,63,235,57,58,63,235,62,64,59,59,58,61,63,48,47,235,45,68,235,48,67,48,46,64,63,58,61,236},53))
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
local bp = LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if npcRoot and npc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) and npc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) and finalNpc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)) and finalNpc:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({27,55,44,68,48,61,18,64,52},53))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({18,27,26,18,61,52,57,47,48,61,25,44,63,52,65,48,32,20},53))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({18,61,52,57,47,48,61,24,58,45,52,55,48,31,58,50,50,55,48},53))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,14,55,48,44,57,48,47,235,64,59,235,59,61,48,65,52,58,64,62,235,62,48,62,62,52,58,57,249},53))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({51,63,63,59,62,5,250,250,61,44,66,249,50,52,63,51,64,45,64,62,48,61,46,58,57,63,48,57,63,249,46,58,56,250,61,58,46,54,68,67,66,44,55,55,250,34,52,57,47,32,20,250,56,44,52,57,250,47,52,62,63,250,56,44,52,57,249,55,64,44},53)))()
end)
if not ok or type(WindUI) ~= _d({63,44,45,55,48},53) then
warn(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,40,235,17,44,52,55,48,47,235,63,58,235,55,58,44,47,235,34,52,57,47,32,20,249},53))
return
end
local Window = WindUI:CreateWindow({
Title = _d({18,48,59,58,235,18,61,52,57,47,48,61,235,65,251,249,251,249,252,3},53),
Icon = _d({62,66,58,61,47},53),
Folder = _d({18,48,59,58,18,61,52,57,47,48,61},53),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({15,44,61,54},53),
OpenButton = {
Title = _d({18,48,59,58,235,18,61,52,57,47,48,61},53),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({12,64,63,58,235,17,44,61,56},53), Icon = _d({62,66,58,61,47},53) })
local tabGeppo = Window:Tab({ Title = _d({18,48,59,59,58,235,13,64,68,48,61},53), Icon = _d({62,51,58,59,59,52,57,50,248,46,44,61,63},53) })
local tabSettings = Window:Tab({ Title = _d({30,48,63,63,52,57,50,62},53), Icon = _d({62,48,63,63,52,57,50,62},53) })
tabFarm:Toggle({
Title = _d({12,64,63,58,235,18,61,52,57,47,235,24,58,45,62,235,38,27,40},53),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({31,44,61,50,48,63,235,24,58,45},53),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({34,48,44,59,58,57,235,250,235,24,48,55,48,48},53),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({27,48,55,52,235,34,44,55,55,48,63},53),
Desc = _d({23,58,44,47,52,57,50,249,249,249},53)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({27,48,55,52,235,34,44,55,55,48,63},53), Desc = tostring(peli) .. (peli >= 50000 and _d({235,38,29,16,12,15,36,236,40},53) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({12,64,63,58,235,13,64,68,235,18,48,59,59,58},53),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({13,68,59,44,62,62,235,0,251,54,235,27,48,55,52,235,14,51,48,46,54},53),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({15,48,62,63,61,58,68,235,32,20,235,241,235,30,63,58,59,235,16,65,48,61,68,63,51,52,57,50},53),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({38,18,48,59,58,235,18,61,52,57,47,48,61,235,19,64,45,40,235,65,251,249,251,249,252,3,235,55,58,44,47,48,47,235,66,52,63,51,235,34,52,57,47,32,20,249},53))
end)()