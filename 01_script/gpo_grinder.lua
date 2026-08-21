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
local Players = game:GetService(_d({34,62,51,75,55,68,69},46))
local ReplicatedStorage = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local RunService = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local VIM = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
local UserInputService = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({38,65,65,62},46)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({38,65,65,62},46)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({21,65,63,52,51,70},46))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({20,51,64,54,59,70},46)
local selectedWeapon = availableWeapons[1] or _d({21,65,63,52,51,70},46)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({20,51,64,54,59,70},46), _d({20,51,64,54,59,70,242,20,65,69,69},46), _d({22,51,66,58},46), _d({26,51,61,71},46), _d({30,59,62,75},46), _d({30,59,65,64,242,34,68,59,54,55},46), _d({31,51,68,67,71,51,64},46), _d({36,65,52,65},46), _d({36,65,64,64,75},46), _d({37,51,68,51,58},46)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({37,70,51,70,69},46) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({37,70,51,70,69},46)) and statsFolder.Stats:FindFirstChild(_d({34,55,62,59},46)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({32,34,21,69},46))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
local hum = npc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({32,34,21,69},46))
local yi = folder and folder:FindFirstChild(_d({43,59},46))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({43,59},46) and obj:IsA(_d({31,65,54,55,62},46)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({32,34,21,69},46))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({73,51,70,55,68},46)) or hitName:find(_d({69,55,51},46)) or hitName:find(_d({65,53,55,51,64},46)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({20,51,69,55,34,51,68,70},46)) then
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
local att = root:FindFirstChild(_d({49,49,25,68,59,64,54,55,68,19,70,70},46)) or Instance.new(_d({19,70,70,51,53,58,63,55,64,70},46))
att.Name = _d({49,49,25,68,59,64,54,55,68,19,70,70},46)
att.Parent = root
local force = root:FindFirstChild(_d({49,49,25,68,59,64,54,55,68,24,65,68,53,55},46))
if not force then
force = Instance.new(_d({30,59,64,55,51,68,40,55,62,65,53,59,70,75},46))
force.Name = _d({49,49,25,68,59,64,54,55,68,24,65,68,53,55},46)
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
local force = root:FindFirstChild(_d({49,49,25,68,59,64,54,55,68,24,65,68,53,55},46))
local att = root:FindFirstChild(_d({49,49,25,68,59,64,54,55,68,19,70,70},46))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({37,70,51,70,69},46) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({32,65,64,55},46)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({36,65,61,71,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,55,66,66,65},46), args)
elseif style == _d({20,62,51,53,61,30,55,57},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61},46), args)
elseif style == _d({29,51,63,59,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,51,63,59,69,58,59,61,59,25,55,66,66,65},46), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61,4},46), args)
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
local yiRoot = yi:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
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
local prompt = yi:FindFirstChildWhichIsA(_d({34,68,65,74,59,63,59,70,75,34,68,65,63,66,70},46), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,56,59,68,55,66,68,65,74,59,63,59,70,75,66,68,65,63,66,70,242,64,65,70,242,69,71,66,66,65,68,70,55,54,242,52,75,242,55,74,55,53,71,70,65,68,243},46))
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
local bp = LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if npcRoot and npc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)) and npc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)) and finalNpc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)) and finalNpc:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({34,62,51,75,55,68,25,71,59},46))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({25,34,33,25,68,59,64,54,55,68,32,51,70,59,72,55,39,27},46))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({25,68,59,64,54,55,68,31,65,52,59,62,55,38,65,57,57,62,55},46))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,21,62,55,51,64,55,54,242,71,66,242,66,68,55,72,59,65,71,69,242,69,55,69,69,59,65,64,0},46))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({58,70,70,66,69,12,1,1,68,51,73,0,57,59,70,58,71,52,71,69,55,68,53,65,64,70,55,64,70,0,53,65,63,1,68,65,53,61,75,74,73,51,62,62,1,41,59,64,54,39,27,1,63,51,59,64,1,54,59,69,70,1,63,51,59,64,0,62,71,51},46)))()
end)
if not ok or type(WindUI) ~= _d({70,51,52,62,55},46) then
warn(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,47,242,24,51,59,62,55,54,242,70,65,242,62,65,51,54,242,41,59,64,54,39,27,0},46))
return
end
local Window = WindUI:CreateWindow({
Title = _d({25,55,66,65,242,25,68,59,64,54,55,68,242,72,2,0,2,0,3,10},46),
Icon = _d({69,73,65,68,54},46),
Folder = _d({25,55,66,65,25,68,59,64,54,55,68},46),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({22,51,68,61},46),
OpenButton = {
Title = _d({25,55,66,65,242,25,68,59,64,54,55,68},46),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({19,71,70,65,242,24,51,68,63},46), Icon = _d({69,73,65,68,54},46) })
local tabGeppo = Window:Tab({ Title = _d({25,55,66,66,65,242,20,71,75,55,68},46), Icon = _d({69,58,65,66,66,59,64,57,255,53,51,68,70},46) })
local tabSettings = Window:Tab({ Title = _d({37,55,70,70,59,64,57,69},46), Icon = _d({69,55,70,70,59,64,57,69},46) })
tabFarm:Toggle({
Title = _d({19,71,70,65,242,25,68,59,64,54,242,31,65,52,69,242,45,34,47},46),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({38,51,68,57,55,70,242,31,65,52},46),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({41,55,51,66,65,64,242,1,242,31,55,62,55,55},46),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({34,55,62,59,242,41,51,62,62,55,70},46),
Desc = _d({30,65,51,54,59,64,57,0,0,0},46)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({34,55,62,59,242,41,51,62,62,55,70},46), Desc = tostring(peli) .. (peli >= 50000 and _d({242,45,36,23,19,22,43,243,47},46) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({19,71,70,65,242,20,71,75,242,25,55,66,66,65},46),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({20,75,66,51,69,69,242,7,2,61,242,34,55,62,59,242,21,58,55,53,61},46),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({22,55,69,70,68,65,75,242,39,27,242,248,242,37,70,65,66,242,23,72,55,68,75,70,58,59,64,57},46),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({45,25,55,66,65,242,25,68,59,64,54,55,68,242,26,71,52,47,242,72,2,0,2,0,3,10,242,62,65,51,54,55,54,242,73,59,70,58,242,41,59,64,54,39,27,0},46))
end)()