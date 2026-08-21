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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({29,56,56,53},55)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({29,56,56,53},55)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({12,56,54,43,42,61},55))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({11,42,55,45,50,61},55)
local selectedWeapon = availableWeapons[1] or _d({12,56,54,43,42,61},55)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({11,42,55,45,50,61},55), _d({11,42,55,45,50,61,233,11,56,60,60},55), _d({13,42,57,49},55), _d({17,42,52,62},55), _d({21,50,53,66},55), _d({21,50,56,55,233,25,59,50,45,46},55), _d({22,42,59,58,62,42,55},55), _d({27,56,43,56},55), _d({27,56,55,55,66},55), _d({28,42,59,42,49},55)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({28,61,42,61,60},55)) and statsFolder.Stats:FindFirstChild(_d({25,46,53,50},55)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local hum = npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({23,25,12,60},55))
local yi = folder and folder:FindFirstChild(_d({34,50},55))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({34,50},55) and obj:IsA(_d({22,56,45,46,53},55)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({64,42,61,46,59},55)) or hitName:find(_d({60,46,42},55)) or hitName:find(_d({56,44,46,42,55},55)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
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
local att = root:FindFirstChild(_d({40,40,16,59,50,55,45,46,59,10,61,61},55)) or Instance.new(_d({10,61,61,42,44,49,54,46,55,61},55))
att.Name = _d({40,40,16,59,50,55,45,46,59,10,61,61},55)
att.Parent = root
local force = root:FindFirstChild(_d({40,40,16,59,50,55,45,46,59,15,56,59,44,46},55))
if not force then
force = Instance.new(_d({21,50,55,46,42,59,31,46,53,56,44,50,61,66},55))
force.Name = _d({40,40,16,59,50,55,45,46,59,15,56,59,44,46},55)
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
local force = root:FindFirstChild(_d({40,40,16,59,50,55,45,46,59,15,56,59,44,46},55))
local att = root:FindFirstChild(_d({40,40,16,59,50,55,45,46,59,10,61,61},55))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({23,56,55,46},55)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({27,56,52,62,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,46,57,57,56},55), args)
elseif style == _d({11,53,42,44,52,21,46,48},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52},55), args)
elseif style == _d({20,42,54,50,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,42,54,50,60,49,50,52,50,16,46,57,57,56},55), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52,251},55), args)
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
local yiRoot = yi:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
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
local prompt = yi:FindFirstChildWhichIsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,47,50,59,46,57,59,56,65,50,54,50,61,66,57,59,56,54,57,61,233,55,56,61,233,60,62,57,57,56,59,61,46,45,233,43,66,233,46,65,46,44,62,61,56,59,234},55))
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
local bp = LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if npcRoot and npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({25,53,42,66,46,59,16,62,50},55))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({16,25,24,16,59,50,55,45,46,59,23,42,61,50,63,46,30,18},55))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({16,59,50,55,45,46,59,22,56,43,50,53,46,29,56,48,48,53,46},55))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,12,53,46,42,55,46,45,233,62,57,233,57,59,46,63,50,56,62,60,233,60,46,60,60,50,56,55,247},55))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,32,50,55,45,30,18,248,54,42,50,55,248,45,50,60,61,248,54,42,50,55,247,53,62,42},55)))()
end)
if not ok or type(WindUI) ~= _d({61,42,43,53,46},55) then
warn(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,15,42,50,53,46,45,233,61,56,233,53,56,42,45,233,32,50,55,45,30,18,247},55))
return
end
local Window = WindUI:CreateWindow({
Title = _d({16,46,57,56,233,16,59,50,55,45,46,59,233,63,249,247,249,247,250,1},55),
Icon = _d({60,64,56,59,45},55),
Folder = _d({16,46,57,56,16,59,50,55,45,46,59},55),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({13,42,59,52},55),
OpenButton = {
Title = _d({16,46,57,56,233,16,59,50,55,45,46,59},55),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({10,62,61,56,233,15,42,59,54},55), Icon = _d({60,64,56,59,45},55) })
local tabGeppo = Window:Tab({ Title = _d({16,46,57,57,56,233,11,62,66,46,59},55), Icon = _d({60,49,56,57,57,50,55,48,246,44,42,59,61},55) })
local tabSettings = Window:Tab({ Title = _d({28,46,61,61,50,55,48,60},55), Icon = _d({60,46,61,61,50,55,48,60},55) })
tabFarm:Toggle({
Title = _d({10,62,61,56,233,16,59,50,55,45,233,22,56,43,60,233,36,25,38},55),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({29,42,59,48,46,61,233,22,56,43},55),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({32,46,42,57,56,55,233,248,233,22,46,53,46,46},55),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({25,46,53,50,233,32,42,53,53,46,61},55),
Desc = _d({21,56,42,45,50,55,48,247,247,247},55)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({25,46,53,50,233,32,42,53,53,46,61},55), Desc = tostring(peli) .. (peli >= 50000 and _d({233,36,27,14,10,13,34,234,38},55) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({10,62,61,56,233,11,62,66,233,16,46,57,57,56},55),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({11,66,57,42,60,60,233,254,249,52,233,25,46,53,50,233,12,49,46,44,52},55),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({13,46,60,61,59,56,66,233,30,18,233,239,233,28,61,56,57,233,14,63,46,59,66,61,49,50,55,48},55),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,233,17,62,43,38,233,63,249,247,249,247,250,1,233,53,56,42,45,46,45,233,64,50,61,49,233,32,50,55,45,30,18,247},55))
end)()