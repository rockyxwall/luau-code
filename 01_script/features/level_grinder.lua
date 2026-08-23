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
local Players = game:GetService(_d({29,57,46,70,50,63,64},51))
local ReplicatedStorage = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local RunService = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local VIM = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local UserInputService = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({33,60,60,57},51)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({33,60,60,57},51)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({16,60,58,47,46,65},51))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({15,46,59,49,54,65},51)
local selectedWeapon = availableWeapons[1] or _d({16,60,58,47,46,65},51)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({15,46,59,49,54,65},51), _d({15,46,59,49,54,65,237,15,60,64,64},51), _d({17,46,61,53},51), _d({21,46,56,66},51), _d({25,54,57,70},51), _d({25,54,60,59,237,29,63,54,49,50},51), _d({26,46,63,62,66,46,59},51), _d({31,60,47,60},51), _d({31,60,59,59,70},51), _d({32,46,63,46,53},51)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({32,65,46,65,64},51)) and statsFolder.Stats:FindFirstChild(_d({29,50,57,54},51)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({27,29,16,64},51))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
local hum = npc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({27,29,16,64},51))
local yi = folder and folder:FindFirstChild(_d({38,54},51))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({38,54},51) and obj:IsA(_d({26,60,49,50,57},51)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({27,29,16,64},51))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({68,46,65,50,63},51)) or hitName:find(_d({64,50,46},51)) or hitName:find(_d({60,48,50,46,59},51)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({15,46,64,50,29,46,63,65},51)) then
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
local att = root:FindFirstChild(_d({44,44,20,63,54,59,49,50,63,14,65,65},51)) or Instance.new(_d({14,65,65,46,48,53,58,50,59,65},51))
att.Name = _d({44,44,20,63,54,59,49,50,63,14,65,65},51)
att.Parent = root
local force = root:FindFirstChild(_d({44,44,20,63,54,59,49,50,63,19,60,63,48,50},51))
if not force then
force = Instance.new(_d({25,54,59,50,46,63,35,50,57,60,48,54,65,70},51))
force.Name = _d({44,44,20,63,54,59,49,50,63,19,60,63,48,50},51)
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
local force = root:FindFirstChild(_d({44,44,20,63,54,59,49,50,63,19,60,63,48,50},51))
local att = root:FindFirstChild(_d({44,44,20,63,54,59,49,50,63,14,65,65},51))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({27,60,59,50},51)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({31,60,56,66,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,50,61,61,60},51), args)
elseif style == _d({15,57,46,48,56,25,50,52},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56},51), args)
elseif style == _d({24,46,58,54,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,46,58,54,64,53,54,56,54,20,50,61,61,60},51), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56,255},51), args)
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
local yiRoot = yi:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
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
local prompt = yi:FindFirstChildWhichIsA(_d({29,63,60,69,54,58,54,65,70,29,63,60,58,61,65},51), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,51,54,63,50,61,63,60,69,54,58,54,65,70,61,63,60,58,61,65,237,59,60,65,237,64,66,61,61,60,63,65,50,49,237,47,70,237,50,69,50,48,66,65,60,63,238},51))
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
local bp = LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if npcRoot and npc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) and npc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) and finalNpc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)) and finalNpc:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({29,57,46,70,50,63,20,66,54},51))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({20,29,28,20,63,54,59,49,50,63,27,46,65,54,67,50,34,22},51))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({20,63,54,59,49,50,63,26,60,47,54,57,50,33,60,52,52,57,50},51))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,16,57,50,46,59,50,49,237,66,61,237,61,63,50,67,54,60,66,64,237,64,50,64,64,54,60,59,251},51))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({53,65,65,61,64,7,252,252,63,46,68,251,52,54,65,53,66,47,66,64,50,63,48,60,59,65,50,59,65,251,48,60,58,252,63,60,48,56,70,69,68,46,57,57,252,36,54,59,49,34,22,252,58,46,54,59,252,49,54,64,65,252,58,46,54,59,251,57,66,46},51)))()
end)
if not ok or type(WindUI) ~= _d({65,46,47,57,50},51) then
warn(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,42,237,19,46,54,57,50,49,237,65,60,237,57,60,46,49,237,36,54,59,49,34,22,251},51))
return
end
local Window = WindUI:CreateWindow({
Title = _d({20,50,61,60,237,20,63,54,59,49,50,63,237,67,253,251,253,251,254,5},51),
Icon = _d({64,68,60,63,49},51),
Folder = _d({20,50,61,60,20,63,54,59,49,50,63},51),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({17,46,63,56},51),
OpenButton = {
Title = _d({20,50,61,60,237,20,63,54,59,49,50,63},51),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({14,66,65,60,237,19,46,63,58},51), Icon = _d({64,68,60,63,49},51) })
local tabGeppo = Window:Tab({ Title = _d({20,50,61,61,60,237,15,66,70,50,63},51), Icon = _d({64,53,60,61,61,54,59,52,250,48,46,63,65},51) })
local tabSettings = Window:Tab({ Title = _d({32,50,65,65,54,59,52,64},51), Icon = _d({64,50,65,65,54,59,52,64},51) })
tabFarm:Toggle({
Title = _d({14,66,65,60,237,20,63,54,59,49,237,26,60,47,64,237,40,29,42},51),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({33,46,63,52,50,65,237,26,60,47},51),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({36,50,46,61,60,59,237,252,237,26,50,57,50,50},51),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({29,50,57,54,237,36,46,57,57,50,65},51),
Desc = _d({25,60,46,49,54,59,52,251,251,251},51)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({29,50,57,54,237,36,46,57,57,50,65},51), Desc = tostring(peli) .. (peli >= 50000 and _d({237,40,31,18,14,17,38,238,42},51) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({14,66,65,60,237,15,66,70,237,20,50,61,61,60},51),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({15,70,61,46,64,64,237,2,253,56,237,29,50,57,54,237,16,53,50,48,56},51),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({17,50,64,65,63,60,70,237,34,22,237,243,237,32,65,60,61,237,18,67,50,63,70,65,53,54,59,52},51),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({40,20,50,61,60,237,20,63,54,59,49,50,63,237,21,66,47,42,237,67,253,251,253,251,254,5,237,57,60,46,49,50,49,237,68,54,65,53,237,36,54,59,49,34,22,251},51))
end)()