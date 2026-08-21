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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({64,91,91,88},20)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({64,91,91,88},20)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({47,91,89,78,77,96},20))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({46,77,90,80,85,96},20)
local selectedWeapon = availableWeapons[1] or _d({47,91,89,78,77,96},20)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({46,77,90,80,85,96},20), _d({46,77,90,80,85,96,12,46,91,95,95},20), _d({48,77,92,84},20), _d({52,77,87,97},20), _d({56,85,88,101},20), _d({56,85,91,90,12,60,94,85,80,81},20), _d({57,77,94,93,97,77,90},20), _d({62,91,78,91},20), _d({62,91,90,90,101},20), _d({63,77,94,77,84},20)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({63,96,77,96,95},20)) and statsFolder.Stats:FindFirstChild(_d({60,81,88,85},20)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = npc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({58,60,47,95},20))
local yi = folder and folder:FindFirstChild(_d({69,85},20))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({69,85},20) and obj:IsA(_d({57,91,80,81,88},20)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({99,77,96,81,94},20)) or hitName:find(_d({95,81,77},20)) or hitName:find(_d({91,79,81,77,90},20)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({46,77,95,81,60,77,94,96},20)) then
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
local att = root:FindFirstChild(_d({75,75,51,94,85,90,80,81,94,45,96,96},20)) or Instance.new(_d({45,96,96,77,79,84,89,81,90,96},20))
att.Name = _d({75,75,51,94,85,90,80,81,94,45,96,96},20)
att.Parent = root
local force = root:FindFirstChild(_d({75,75,51,94,85,90,80,81,94,50,91,94,79,81},20))
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = _d({75,75,51,94,85,90,80,81,94,50,91,94,79,81},20)
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
local force = root:FindFirstChild(_d({75,75,51,94,85,90,80,81,94,50,91,94,79,81},20))
local att = root:FindFirstChild(_d({75,75,51,94,85,90,80,81,94,45,96,96},20))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({58,91,90,81},20)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({62,91,87,97,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,81,92,92,91},20), args)
elseif style == _d({46,88,77,79,87,56,81,83},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87},20), args)
elseif style == _d({55,77,89,85,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,77,89,85,95,84,85,87,85,51,81,92,92,91},20), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87,30},20), args)
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
local yiRoot = yi:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
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
local prompt = yi:FindFirstChildWhichIsA(_d({60,94,91,100,85,89,85,96,101,60,94,91,89,92,96},20), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({71,51,81,92,91,12,51,94,85,90,80,81,94,73,12,82,85,94,81,92,94,91,100,85,89,85,96,101,92,94,91,89,92,96,12,90,91,96,12,95,97,92,92,91,94,96,81,80,12,78,101,12,81,100,81,79,97,96,91,94,13},20))
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
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if npcRoot and npc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)) and npc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)) and finalNpc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)) and finalNpc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({60,88,77,101,81,94,51,97,85},20))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({51,60,59,51,94,85,90,80,81,94,58,77,96,85,98,81,65,53},20))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({51,94,85,90,80,81,94,57,91,78,85,88,81,64,91,83,83,88,81},20))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({71,51,81,92,91,12,51,94,85,90,80,81,94,73,12,47,88,81,77,90,81,80,12,97,92,12,92,94,81,98,85,91,97,95,12,95,81,95,95,85,91,90,26},20))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,67,85,90,80,65,53,27,89,77,85,90,27,80,85,95,96,27,89,77,85,90,26,88,97,77},20)))()
end)
if not ok or type(WindUI) ~= _d({96,77,78,88,81},20) then
warn(_d({71,51,81,92,91,12,51,94,85,90,80,81,94,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,67,85,90,80,65,53,26},20))
return
end
local Window = WindUI:CreateWindow({
Title = _d({51,81,92,91,12,51,94,85,90,80,81,94,12,98,28,26,28,26,29,36},20),
Icon = _d({95,99,91,94,80},20),
Folder = _d({51,81,92,91,51,94,85,90,80,81,94},20),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({48,77,94,87},20),
OpenButton = {
Title = _d({51,81,92,91,12,51,94,85,90,80,81,94},20),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({45,97,96,91,12,50,77,94,89},20), Icon = _d({95,99,91,94,80},20) })
local tabGeppo = Window:Tab({ Title = _d({51,81,92,92,91,12,46,97,101,81,94},20), Icon = _d({95,84,91,92,92,85,90,83,25,79,77,94,96},20) })
local tabSettings = Window:Tab({ Title = _d({63,81,96,96,85,90,83,95},20), Icon = _d({95,81,96,96,85,90,83,95},20) })
tabFarm:Toggle({
Title = _d({45,97,96,91,12,51,94,85,90,80,12,57,91,78,95,12,71,60,73},20),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({64,77,94,83,81,96,12,57,91,78},20),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({67,81,77,92,91,90,12,27,12,57,81,88,81,81},20),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({60,81,88,85,12,67,77,88,88,81,96},20),
Desc = _d({56,91,77,80,85,90,83,26,26,26},20)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({60,81,88,85,12,67,77,88,88,81,96},20), Desc = tostring(peli) .. (peli >= 50000 and _d({12,71,62,49,45,48,69,13,73},20) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({45,97,96,91,12,46,97,101,12,51,81,92,92,91},20),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({46,101,92,77,95,95,12,33,28,87,12,60,81,88,85,12,47,84,81,79,87},20),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({48,81,95,96,94,91,101,12,65,53,12,18,12,63,96,91,92,12,49,98,81,94,101,96,84,85,90,83},20),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({71,51,81,92,91,12,51,94,85,90,80,81,94,12,52,97,78,73,12,98,28,26,28,26,29,36,12,88,91,77,80,81,80,12,99,85,96,84,12,67,85,90,80,65,53,26},20))
end)()