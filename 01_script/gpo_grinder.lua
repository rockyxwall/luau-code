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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({47,74,74,71},37)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({47,74,74,71},37)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({30,74,72,61,60,79},37))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({29,60,73,63,68,79},37)
local selectedWeapon = availableWeapons[1] or _d({30,74,72,61,60,79},37)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({29,60,73,63,68,79},37), _d({29,60,73,63,68,79,251,29,74,78,78},37), _d({31,60,75,67},37), _d({35,60,70,80},37), _d({39,68,71,84},37), _d({39,68,74,73,251,43,77,68,63,64},37), _d({40,60,77,76,80,60,73},37), _d({45,74,61,74},37), _d({45,74,73,73,84},37), _d({46,60,77,60,67},37)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({46,79,60,79,78},37)) and statsFolder.Stats:FindFirstChild(_d({43,64,71,68},37)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({41,43,30,78},37))
local yi = folder and folder:FindFirstChild(_d({52,68},37))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({52,68},37) and obj:IsA(_d({40,74,63,64,71},37)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({82,60,79,64,77},37)) or hitName:find(_d({78,64,60},37)) or hitName:find(_d({74,62,64,60,73},37)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
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
local att = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,28,79,79},37)) or Instance.new(_d({28,79,79,60,62,67,72,64,73,79},37))
att.Name = _d({58,58,34,77,68,73,63,64,77,28,79,79},37)
att.Parent = root
local force = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37))
if not force then
force = Instance.new(_d({39,68,73,64,60,77,49,64,71,74,62,68,79,84},37))
force.Name = _d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37)
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
local force = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,33,74,77,62,64},37))
local att = root:FindFirstChild(_d({58,58,34,77,68,73,63,64,77,28,79,79},37))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({41,74,73,64},37)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({45,74,70,80,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,64,75,75,74},37), args)
elseif style == _d({29,71,60,62,70,39,64,66},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70},37), args)
elseif style == _d({38,60,72,68,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,60,72,68,78,67,68,70,68,34,64,75,75,74},37), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70,13},37), args)
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
local yiRoot = yi:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
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
local prompt = yi:FindFirstChildWhichIsA(_d({43,77,74,83,68,72,68,79,84,43,77,74,72,75,79},37), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
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
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if npcRoot and npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({43,71,60,84,64,77,34,80,68},37))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({34,43,42,34,77,68,73,63,64,77,41,60,79,68,81,64,48,36},37))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({34,77,68,73,63,64,77,40,74,61,68,71,64,47,74,66,66,71,64},37))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,50,68,73,63,48,36,10,72,60,68,73,10,63,68,78,79,10,72,60,68,73,9,71,80,60},37)))()
end)
if not ok or type(WindUI) ~= _d({79,60,61,71,64},37) then
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,33,60,68,71,64,63,251,79,74,251,71,74,60,63,251,50,68,73,63,48,36,9},37))
return
end
local Window = WindUI:CreateWindow({
Title = _d({34,64,75,74,251,34,77,68,73,63,64,77,251,81,11,9,11,9,12,19},37),
Icon = _d({78,82,74,77,63},37),
Folder = _d({34,64,75,74,34,77,68,73,63,64,77},37),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({31,60,77,70},37),
OpenButton = {
Title = _d({34,64,75,74,251,34,77,68,73,63,64,77},37),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({28,80,79,74,251,33,60,77,72},37), Icon = _d({78,82,74,77,63},37) })
local tabGeppo = Window:Tab({ Title = _d({34,64,75,75,74,251,29,80,84,64,77},37), Icon = _d({78,67,74,75,75,68,73,66,8,62,60,77,79},37) })
local tabSettings = Window:Tab({ Title = _d({46,64,79,79,68,73,66,78},37), Icon = _d({78,64,79,79,68,73,66,78},37) })
tabFarm:Toggle({
Title = _d({28,80,79,74,251,34,77,68,73,63,251,40,74,61,78,251,54,43,56},37),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({47,60,77,66,64,79,251,40,74,61},37),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({50,64,60,75,74,73,251,10,251,40,64,71,64,64},37),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({43,64,71,68,251,50,60,71,71,64,79},37),
Desc = _d({39,74,60,63,68,73,66,9,9,9},37)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({43,64,71,68,251,50,60,71,71,64,79},37), Desc = tostring(peli) .. (peli >= 50000 and _d({251,54,45,32,28,31,52,252,56},37) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({28,80,79,74,251,29,80,84,251,34,64,75,75,74},37),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({29,84,75,60,78,78,251,16,11,70,251,43,64,71,68,251,30,67,64,62,70},37),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({31,64,78,79,77,74,84,251,48,36,251,1,251,46,79,74,75,251,32,81,64,77,84,79,67,68,73,66},37),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,251,35,80,61,56,251,81,11,9,11,9,12,19,251,71,74,60,63,64,63,251,82,68,79,67,251,50,68,73,63,48,36,9},37))
end)()