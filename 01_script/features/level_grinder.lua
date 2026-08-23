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
local Players = game:GetService(_d({38,66,55,79,59,72,73},42))
local ReplicatedStorage = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local RunService = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local VIM = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local UserInputService = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({42,69,69,66},42)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({42,69,69,66},42)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({25,69,67,56,55,74},42))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({24,55,68,58,63,74},42)
local selectedWeapon = availableWeapons[1] or _d({25,69,67,56,55,74},42)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({24,55,68,58,63,74},42), _d({24,55,68,58,63,74,246,24,69,73,73},42), _d({26,55,70,62},42), _d({30,55,65,75},42), _d({34,63,66,79},42), _d({34,63,69,68,246,38,72,63,58,59},42), _d({35,55,72,71,75,55,68},42), _d({40,69,56,69},42), _d({40,69,68,68,79},42), _d({41,55,72,55,62},42)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({41,74,55,74,73},42)) and statsFolder.Stats:FindFirstChild(_d({38,59,66,63},42)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum = npc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({36,38,25,73},42))
local yi = folder and folder:FindFirstChild(_d({47,63},42))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({47,63},42) and obj:IsA(_d({35,69,58,59,66},42)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({36,38,25,73},42))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({77,55,74,59,72},42)) or hitName:find(_d({73,59,55},42)) or hitName:find(_d({69,57,59,55,68},42)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({24,55,73,59,38,55,72,74},42)) then
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
local att = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,23,74,74},42)) or Instance.new(_d({23,74,74,55,57,62,67,59,68,74},42))
att.Name = _d({53,53,29,72,63,68,58,59,72,23,74,74},42)
att.Parent = root
local force = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42))
if not force then
force = Instance.new(_d({34,63,68,59,55,72,44,59,66,69,57,63,74,79},42))
force.Name = _d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42)
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
local force = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,28,69,72,57,59},42))
local att = root:FindFirstChild(_d({53,53,29,72,63,68,58,59,72,23,74,74},42))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({36,69,68,59},42)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({40,69,65,75,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,59,70,70,69},42), args)
elseif style == _d({24,66,55,57,65,34,59,61},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65},42), args)
elseif style == _d({33,55,67,63,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,55,67,63,73,62,63,65,63,29,59,70,70,69},42), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65,8},42), args)
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
local yiRoot = yi:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
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
local prompt = yi:FindFirstChildWhichIsA(_d({38,72,69,78,63,67,63,74,79,38,72,69,67,70,74},42), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,60,63,72,59,70,72,69,78,63,67,63,74,79,70,72,69,67,70,74,246,68,69,74,246,73,75,70,70,69,72,74,59,58,246,56,79,246,59,78,59,57,75,74,69,72,247},42))
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
local bp = LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if npcRoot and npc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) and npc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) and finalNpc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)) and finalNpc:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({38,66,55,79,59,72,29,75,63},42))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({29,38,37,29,72,63,68,58,59,72,36,55,74,63,76,59,43,31},42))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({29,72,63,68,58,59,72,35,69,56,63,66,59,42,69,61,61,66,59},42))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,25,66,59,55,68,59,58,246,75,70,246,70,72,59,76,63,69,75,73,246,73,59,73,73,63,69,68,4},42))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({62,74,74,70,73,16,5,5,72,55,77,4,61,63,74,62,75,56,75,73,59,72,57,69,68,74,59,68,74,4,57,69,67,5,72,69,57,65,79,78,77,55,66,66,5,45,63,68,58,43,31,5,67,55,63,68,5,58,63,73,74,5,67,55,63,68,4,66,75,55},42)))()
end)
if not ok or type(WindUI) ~= _d({74,55,56,66,59},42) then
warn(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,51,246,28,55,63,66,59,58,246,74,69,246,66,69,55,58,246,45,63,68,58,43,31,4},42))
return
end
local Window = WindUI:CreateWindow({
Title = _d({29,59,70,69,246,29,72,63,68,58,59,72,246,76,6,4,6,4,7,14},42),
Icon = _d({73,77,69,72,58},42),
Folder = _d({29,59,70,69,29,72,63,68,58,59,72},42),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({26,55,72,65},42),
OpenButton = {
Title = _d({29,59,70,69,246,29,72,63,68,58,59,72},42),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({23,75,74,69,246,28,55,72,67},42), Icon = _d({73,77,69,72,58},42) })
local tabGeppo = Window:Tab({ Title = _d({29,59,70,70,69,246,24,75,79,59,72},42), Icon = _d({73,62,69,70,70,63,68,61,3,57,55,72,74},42) })
local tabSettings = Window:Tab({ Title = _d({41,59,74,74,63,68,61,73},42), Icon = _d({73,59,74,74,63,68,61,73},42) })
tabFarm:Toggle({
Title = _d({23,75,74,69,246,29,72,63,68,58,246,35,69,56,73,246,49,38,51},42),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({42,55,72,61,59,74,246,35,69,56},42),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({45,59,55,70,69,68,246,5,246,35,59,66,59,59},42),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({38,59,66,63,246,45,55,66,66,59,74},42),
Desc = _d({34,69,55,58,63,68,61,4,4,4},42)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({38,59,66,63,246,45,55,66,66,59,74},42), Desc = tostring(peli) .. (peli >= 50000 and _d({246,49,40,27,23,26,47,247,51},42) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({23,75,74,69,246,24,75,79,246,29,59,70,70,69},42),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({24,79,70,55,73,73,246,11,6,65,246,38,59,66,63,246,25,62,59,57,65},42),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({26,59,73,74,72,69,79,246,43,31,246,252,246,41,74,69,70,246,27,76,59,72,79,74,62,63,68,61},42),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({49,29,59,70,69,246,29,72,63,68,58,59,72,246,30,75,56,51,246,76,6,4,6,4,7,14,246,66,69,55,58,59,58,246,77,63,74,62,246,45,63,68,58,43,31,4},42))
end)()