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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local RunService = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local VIM = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({45,72,72,69},39)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({45,72,72,69},39)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({28,72,70,59,58,77},39))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({27,58,71,61,66,77},39)
local selectedWeapon = availableWeapons[1] or _d({28,72,70,59,58,77},39)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({27,58,71,61,66,77},39), _d({27,58,71,61,66,77,249,27,72,76,76},39), _d({29,58,73,65},39), _d({33,58,68,78},39), _d({37,66,69,82},39), _d({37,66,72,71,249,41,75,66,61,62},39), _d({38,58,75,74,78,58,71},39), _d({43,72,59,72},39), _d({43,72,71,71,82},39), _d({44,58,75,58,65},39)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({44,77,58,77,76},39)) and statsFolder.Stats:FindFirstChild(_d({41,62,69,66},39)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local hum = npc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({39,41,28,76},39))
local yi = folder and folder:FindFirstChild(_d({50,66},39))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({50,66},39) and obj:IsA(_d({38,72,61,62,69},39)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({39,41,28,76},39))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({80,58,77,62,75},39)) or hitName:find(_d({76,62,58},39)) or hitName:find(_d({72,60,62,58,71},39)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({27,58,76,62,41,58,75,77},39)) then
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
local att = root:FindFirstChild(_d({56,56,32,75,66,71,61,62,75,26,77,77},39)) or Instance.new(_d({26,77,77,58,60,65,70,62,71,77},39))
att.Name = _d({56,56,32,75,66,71,61,62,75,26,77,77},39)
att.Parent = root
local force = root:FindFirstChild(_d({56,56,32,75,66,71,61,62,75,31,72,75,60,62},39))
if not force then
force = Instance.new(_d({37,66,71,62,58,75,47,62,69,72,60,66,77,82},39))
force.Name = _d({56,56,32,75,66,71,61,62,75,31,72,75,60,62},39)
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
local force = root:FindFirstChild(_d({56,56,32,75,66,71,61,62,75,31,72,75,60,62},39))
local att = root:FindFirstChild(_d({56,56,32,75,66,71,61,62,75,26,77,77},39))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({39,72,71,62},39)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({43,72,68,78,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,62,73,73,72},39), args)
elseif style == _d({27,69,58,60,68,37,62,64},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68},39), args)
elseif style == _d({36,58,70,66,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,58,70,66,76,65,66,68,66,32,62,73,73,72},39), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68,11},39), args)
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
local yiRoot = yi:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
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
local prompt = yi:FindFirstChildWhichIsA(_d({41,75,72,81,66,70,66,77,82,41,75,72,70,73,77},39), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({52,32,62,73,72,249,32,75,66,71,61,62,75,54,249,63,66,75,62,73,75,72,81,66,70,66,77,82,73,75,72,70,73,77,249,71,72,77,249,76,78,73,73,72,75,77,62,61,249,59,82,249,62,81,62,60,78,77,72,75,250},39))
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
local bp = LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if npcRoot and npc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)) and npc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)) and finalNpc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)) and finalNpc:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({41,69,58,82,62,75,32,78,66},39))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({32,41,40,32,75,66,71,61,62,75,39,58,77,66,79,62,46,34},39))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({32,75,66,71,61,62,75,38,72,59,66,69,62,45,72,64,64,69,62},39))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({52,32,62,73,72,249,32,75,66,71,61,62,75,54,249,28,69,62,58,71,62,61,249,78,73,249,73,75,62,79,66,72,78,76,249,76,62,76,76,66,72,71,7},39))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,48,66,71,61,46,34,8,70,58,66,71,8,61,66,76,77,8,70,58,66,71,7,69,78,58},39)))()
end)
if not ok or type(WindUI) ~= _d({77,58,59,69,62},39) then
warn(_d({52,32,62,73,72,249,32,75,66,71,61,62,75,54,249,31,58,66,69,62,61,249,77,72,249,69,72,58,61,249,48,66,71,61,46,34,7},39))
return
end
local Window = WindUI:CreateWindow({
Title = _d({32,62,73,72,249,32,75,66,71,61,62,75,249,79,9,7,9,7,10,17},39),
Icon = _d({76,80,72,75,61},39),
Folder = _d({32,62,73,72,32,75,66,71,61,62,75},39),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({29,58,75,68},39),
OpenButton = {
Title = _d({32,62,73,72,249,32,75,66,71,61,62,75},39),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({26,78,77,72,249,31,58,75,70},39), Icon = _d({76,80,72,75,61},39) })
local tabGeppo = Window:Tab({ Title = _d({32,62,73,73,72,249,27,78,82,62,75},39), Icon = _d({76,65,72,73,73,66,71,64,6,60,58,75,77},39) })
local tabSettings = Window:Tab({ Title = _d({44,62,77,77,66,71,64,76},39), Icon = _d({76,62,77,77,66,71,64,76},39) })
tabFarm:Toggle({
Title = _d({26,78,77,72,249,32,75,66,71,61,249,38,72,59,76,249,52,41,54},39),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({45,58,75,64,62,77,249,38,72,59},39),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({48,62,58,73,72,71,249,8,249,38,62,69,62,62},39),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({41,62,69,66,249,48,58,69,69,62,77},39),
Desc = _d({37,72,58,61,66,71,64,7,7,7},39)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({41,62,69,66,249,48,58,69,69,62,77},39), Desc = tostring(peli) .. (peli >= 50000 and _d({249,52,43,30,26,29,50,250,54},39) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({26,78,77,72,249,27,78,82,249,32,62,73,73,72},39),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({27,82,73,58,76,76,249,14,9,68,249,41,62,69,66,249,28,65,62,60,68},39),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({29,62,76,77,75,72,82,249,46,34,249,255,249,44,77,72,73,249,30,79,62,75,82,77,65,66,71,64},39),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({52,32,62,73,72,249,32,75,66,71,61,62,75,249,33,78,59,54,249,79,9,7,9,7,10,17,249,69,72,58,61,62,61,249,80,66,77,65,249,48,66,71,61,46,34,7},39))
end)()