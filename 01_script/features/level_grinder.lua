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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({5,49,47,36,35,54},62))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({4,35,48,38,43,54},62)
local selectedWeapon = availableWeapons[1] or _d({5,49,47,36,35,54},62)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({4,35,48,38,43,54},62), _d({4,35,48,38,43,54,226,4,49,53,53},62), _d({6,35,50,42},62), _d({10,35,45,55},62), _d({14,43,46,59},62), _d({14,43,49,48,226,18,52,43,38,39},62), _d({15,35,52,51,55,35,48},62), _d({20,49,36,49},62), _d({20,49,48,48,59},62), _d({21,35,52,35,42},62)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({21,54,35,54,53},62)) and statsFolder.Stats:FindFirstChild(_d({18,39,46,43},62)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({16,18,5,53},62))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local hum = npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({16,18,5,53},62))
local yi = folder and folder:FindFirstChild(_d({27,43},62))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({27,43},62) and obj:IsA(_d({15,49,38,39,46},62)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({16,18,5,53},62))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({57,35,54,39,52},62)) or hitName:find(_d({53,39,35},62)) or hitName:find(_d({49,37,39,35,48},62)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({4,35,53,39,18,35,52,54},62)) then
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
local att = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,3,54,54},62)) or Instance.new(_d({3,54,54,35,37,42,47,39,48,54},62))
att.Name = _d({33,33,9,52,43,48,38,39,52,3,54,54},62)
att.Parent = root
local force = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62))
if not force then
force = Instance.new(_d({14,43,48,39,35,52,24,39,46,49,37,43,54,59},62))
force.Name = _d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62)
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
local force = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62))
local att = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,3,54,54},62))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({16,49,48,39},62)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({20,49,45,55,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({9,39,50,50,49},62), args)
elseif style == _d({4,46,35,37,45,14,39,41},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45},62), args)
elseif style == _d({13,35,47,43,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,35,47,43,53,42,43,45,43,9,39,50,50,49},62), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45,244},62), args)
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
local yiRoot = yi:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
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
local prompt = yi:FindFirstChildWhichIsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,40,43,52,39,50,52,49,58,43,47,43,54,59,50,52,49,47,50,54,226,48,49,54,226,53,55,50,50,49,52,54,39,38,226,36,59,226,39,58,39,37,55,54,49,52,227},62))
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
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if npcRoot and npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({9,18,17,9,52,43,48,38,39,52,16,35,54,43,56,39,23,11},62))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({9,52,43,48,38,39,52,15,49,36,43,46,39,22,49,41,41,46,39},62))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,5,46,39,35,48,39,38,226,55,50,226,50,52,39,56,43,49,55,53,226,53,39,53,53,43,49,48,240},62))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,52,49,37,45,59,58,57,35,46,46,241,25,43,48,38,23,11,241,47,35,43,48,241,38,43,53,54,241,47,35,43,48,240,46,55,35},62)))()
end)
if not ok or type(WindUI) ~= _d({54,35,36,46,39},62) then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,8,35,43,46,39,38,226,54,49,226,46,49,35,38,226,25,43,48,38,23,11,240},62))
return
end
local Window = WindUI:CreateWindow({
Title = _d({9,39,50,49,226,9,52,43,48,38,39,52,226,56,242,240,242,240,243,250},62),
Icon = _d({53,57,49,52,38},62),
Folder = _d({9,39,50,49,9,52,43,48,38,39,52},62),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({6,35,52,45},62),
OpenButton = {
Title = _d({9,39,50,49,226,9,52,43,48,38,39,52},62),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({3,55,54,49,226,8,35,52,47},62), Icon = _d({53,57,49,52,38},62) })
local tabGeppo = Window:Tab({ Title = _d({9,39,50,50,49,226,4,55,59,39,52},62), Icon = _d({53,42,49,50,50,43,48,41,239,37,35,52,54},62) })
local tabSettings = Window:Tab({ Title = _d({21,39,54,54,43,48,41,53},62), Icon = _d({53,39,54,54,43,48,41,53},62) })
tabFarm:Toggle({
Title = _d({3,55,54,49,226,9,52,43,48,38,226,15,49,36,53,226,29,18,31},62),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({22,35,52,41,39,54,226,15,49,36},62),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({25,39,35,50,49,48,226,241,226,15,39,46,39,39},62),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({18,39,46,43,226,25,35,46,46,39,54},62),
Desc = _d({14,49,35,38,43,48,41,240,240,240},62)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({18,39,46,43,226,25,35,46,46,39,54},62), Desc = tostring(peli) .. (peli >= 50000 and _d({226,29,20,7,3,6,27,227,31},62) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({3,55,54,49,226,4,55,59,226,9,39,50,50,49},62),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({4,59,50,35,53,53,226,247,242,45,226,18,39,46,43,226,5,42,39,37,45},62),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({6,39,53,54,52,49,59,226,23,11,226,232,226,21,54,49,50,226,7,56,39,52,59,54,42,43,48,41},62),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,226,10,55,36,31,226,56,242,240,242,240,243,250,226,46,49,35,38,39,38,226,57,43,54,42,226,25,43,48,38,23,11,240},62))
end)()