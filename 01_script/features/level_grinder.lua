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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({8,52,50,39,38,57},59))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({7,38,51,41,46,57},59)
local selectedWeapon = availableWeapons[1] or _d({8,52,50,39,38,57},59)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({7,38,51,41,46,57},59), _d({7,38,51,41,46,57,229,7,52,56,56},59), _d({9,38,53,45},59), _d({13,38,48,58},59), _d({17,46,49,62},59), _d({17,46,52,51,229,21,55,46,41,42},59), _d({18,38,55,54,58,38,51},59), _d({23,52,39,52},59), _d({23,52,51,51,62},59), _d({24,38,55,38,45},59)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({24,57,38,57,56},59)) and statsFolder.Stats:FindFirstChild(_d({21,42,49,46},59)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum = npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({19,21,8,56},59))
local yi = folder and folder:FindFirstChild(_d({30,46},59))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({30,46},59) and obj:IsA(_d({18,52,41,42,49},59)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({60,38,57,42,55},59)) or hitName:find(_d({56,42,38},59)) or hitName:find(_d({52,40,42,38,51},59)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
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
local att = root:FindFirstChild(_d({36,36,12,55,46,51,41,42,55,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,12,55,46,51,41,42,55,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,12,55,46,51,41,42,55,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,12,55,46,51,41,42,55,11,52,55,40,42},59)
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
local force = root:FindFirstChild(_d({36,36,12,55,46,51,41,42,55,11,52,55,40,42},59))
local att = root:FindFirstChild(_d({36,36,12,55,46,51,41,42,55,6,57,57},59))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({19,52,51,42},59)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({23,52,48,58,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,42,53,53,52},59), args)
elseif style == _d({7,49,38,40,48,17,42,44},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48},59), args)
elseif style == _d({16,38,50,46,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,38,50,46,56,45,46,48,46,12,42,53,53,52},59), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48,247},59), args)
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
local yiRoot = yi:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
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
local prompt = yi:FindFirstChildWhichIsA(_d({21,55,52,61,46,50,46,57,62,21,55,52,50,53,57},59), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,43,46,55,42,53,55,52,61,46,50,46,57,62,53,55,52,50,53,57,229,51,52,57,229,56,58,53,53,52,55,57,42,41,229,39,62,229,42,61,42,40,58,57,52,55,230},59))
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
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if npcRoot and npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({21,49,38,62,42,55,12,58,46},59))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({12,21,20,12,55,46,51,41,42,55,19,38,57,46,59,42,26,14},59))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({12,55,46,51,41,42,55,18,52,39,46,49,42,25,52,44,44,49,42},59))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,8,49,42,38,51,42,41,229,58,53,229,53,55,42,59,46,52,58,56,229,56,42,56,56,46,52,51,243},59))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,28,46,51,41,26,14,244,50,38,46,51,244,41,46,56,57,244,50,38,46,51,243,49,58,38},59)))()
end)
if not ok or type(WindUI) ~= _d({57,38,39,49,42},59) then
warn(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,229,28,46,51,41,26,14,243},59))
return
end
local Window = WindUI:CreateWindow({
Title = _d({12,42,53,52,229,12,55,46,51,41,42,55,229,59,245,243,245,243,246,253},59),
Icon = _d({56,60,52,55,41},59),
Folder = _d({12,42,53,52,12,55,46,51,41,42,55},59),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({9,38,55,48},59),
OpenButton = {
Title = _d({12,42,53,52,229,12,55,46,51,41,42,55},59),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({6,58,57,52,229,11,38,55,50},59), Icon = _d({56,60,52,55,41},59) })
local tabGeppo = Window:Tab({ Title = _d({12,42,53,53,52,229,7,58,62,42,55},59), Icon = _d({56,45,52,53,53,46,51,44,242,40,38,55,57},59) })
local tabSettings = Window:Tab({ Title = _d({24,42,57,57,46,51,44,56},59), Icon = _d({56,42,57,57,46,51,44,56},59) })
tabFarm:Toggle({
Title = _d({6,58,57,52,229,12,55,46,51,41,229,18,52,39,56,229,32,21,34},59),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({25,38,55,44,42,57,229,18,52,39},59),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({28,42,38,53,52,51,229,244,229,18,42,49,42,42},59),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({21,42,49,46,229,28,38,49,49,42,57},59),
Desc = _d({17,52,38,41,46,51,44,243,243,243},59)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({21,42,49,46,229,28,38,49,49,42,57},59), Desc = tostring(peli) .. (peli >= 50000 and _d({229,32,23,10,6,9,30,230,34},59) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({6,58,57,52,229,7,58,62,229,12,42,53,53,52},59),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({7,62,53,38,56,56,229,250,245,48,229,21,42,49,46,229,8,45,42,40,48},59),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({9,42,56,57,55,52,62,229,26,14,229,235,229,24,57,52,53,229,10,59,42,55,62,57,45,46,51,44},59),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,229,13,58,39,34,229,59,245,243,245,243,246,253,229,49,52,38,41,42,41,229,60,46,57,45,229,28,46,51,41,26,14,243},59))
end)()