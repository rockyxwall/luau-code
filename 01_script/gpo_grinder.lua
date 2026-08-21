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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({34,61,61,58},50)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({34,61,61,58},50)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({17,61,59,48,47,66},50))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({16,47,60,50,55,66},50)
local selectedWeapon = availableWeapons[1] or _d({17,61,59,48,47,66},50)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({16,47,60,50,55,66},50), _d({16,47,60,50,55,66,238,16,61,65,65},50), _d({18,47,62,54},50), _d({22,47,57,67},50), _d({26,55,58,71},50), _d({26,55,61,60,238,30,64,55,50,51},50), _d({27,47,64,63,67,47,60},50), _d({32,61,48,61},50), _d({32,61,60,60,71},50), _d({33,47,64,47,54},50)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({33,66,47,66,65},50)) and statsFolder.Stats:FindFirstChild(_d({30,51,58,55},50)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum = npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({28,30,17,65},50))
local yi = folder and folder:FindFirstChild(_d({39,55},50))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({39,55},50) and obj:IsA(_d({27,61,50,51,58},50)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({69,47,66,51,64},50)) or hitName:find(_d({65,51,47},50)) or hitName:find(_d({61,49,51,47,60},50)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({16,47,65,51,30,47,64,66},50)) then
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
local att = root:FindFirstChild(_d({45,45,21,64,55,60,50,51,64,15,66,66},50)) or Instance.new(_d({15,66,66,47,49,54,59,51,60,66},50))
att.Name = _d({45,45,21,64,55,60,50,51,64,15,66,66},50)
att.Parent = root
local force = root:FindFirstChild(_d({45,45,21,64,55,60,50,51,64,20,61,64,49,51},50))
if not force then
force = Instance.new(_d({26,55,60,51,47,64,36,51,58,61,49,55,66,71},50))
force.Name = _d({45,45,21,64,55,60,50,51,64,20,61,64,49,51},50)
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
local force = root:FindFirstChild(_d({45,45,21,64,55,60,50,51,64,20,61,64,49,51},50))
local att = root:FindFirstChild(_d({45,45,21,64,55,60,50,51,64,15,66,66},50))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({28,61,60,51},50)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({32,61,57,67,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,51,62,62,61},50), args)
elseif style == _d({16,58,47,49,57,26,51,53},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57},50), args)
elseif style == _d({25,47,59,55,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,47,59,55,65,54,55,57,55,21,51,62,62,61},50), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57,0},50), args)
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
local yiRoot = yi:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
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
local prompt = yi:FindFirstChildWhichIsA(_d({30,64,61,70,55,59,55,66,71,30,64,61,59,62,66},50), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,52,55,64,51,62,64,61,70,55,59,55,66,71,62,64,61,59,62,66,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,51,70,51,49,67,66,61,64,239},50))
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
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if npcRoot and npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({21,30,29,21,64,55,60,50,51,64,28,47,66,55,68,51,35,23},50))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({21,64,55,60,50,51,64,27,61,48,55,58,51,34,61,53,53,58,51},50))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,17,58,51,47,60,51,50,238,67,62,238,62,64,51,68,55,61,67,65,238,65,51,65,65,55,61,60,252},50))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,37,55,60,50,35,23,253,59,47,55,60,253,50,55,65,66,253,59,47,55,60,252,58,67,47},50)))()
end)
if not ok or type(WindUI) ~= _d({66,47,48,58,51},50) then
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,238,37,55,60,50,35,23,252},50))
return
end
local Window = WindUI:CreateWindow({
Title = _d({21,51,62,61,238,21,64,55,60,50,51,64,238,68,254,252,254,252,255,6},50),
Icon = _d({65,69,61,64,50},50),
Folder = _d({21,51,62,61,21,64,55,60,50,51,64},50),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({18,47,64,57},50),
OpenButton = {
Title = _d({21,51,62,61,238,21,64,55,60,50,51,64},50),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({15,67,66,61,238,20,47,64,59},50), Icon = _d({65,69,61,64,50},50) })
local tabGeppo = Window:Tab({ Title = _d({21,51,62,62,61,238,16,67,71,51,64},50), Icon = _d({65,54,61,62,62,55,60,53,251,49,47,64,66},50) })
local tabSettings = Window:Tab({ Title = _d({33,51,66,66,55,60,53,65},50), Icon = _d({65,51,66,66,55,60,53,65},50) })
tabFarm:Toggle({
Title = _d({15,67,66,61,238,21,64,55,60,50,238,27,61,48,65,238,41,30,43},50),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({34,47,64,53,51,66,238,27,61,48},50),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({37,51,47,62,61,60,238,253,238,27,51,58,51,51},50),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({30,51,58,55,238,37,47,58,58,51,66},50),
Desc = _d({26,61,47,50,55,60,53,252,252,252},50)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({30,51,58,55,238,37,47,58,58,51,66},50), Desc = tostring(peli) .. (peli >= 50000 and _d({238,41,32,19,15,18,39,239,43},50) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({15,67,66,61,238,16,67,71,238,21,51,62,62,61},50),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({16,71,62,47,65,65,238,3,254,57,238,30,51,58,55,238,17,54,51,49,57},50),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({18,51,65,66,64,61,71,238,35,23,238,244,238,33,66,61,62,238,19,68,51,64,71,66,54,55,60,53},50),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,238,22,67,48,43,238,68,254,252,254,252,255,6,238,58,61,47,50,51,50,238,69,55,66,54,238,37,55,60,50,35,23,252},50))
end)()