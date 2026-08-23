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
local Players = game:GetService(_d({64,92,81,105,85,98,99},16))
local ReplicatedStorage = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local RunService = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local VIM = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local UserInputService = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({68,95,95,92},16)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({68,95,95,92},16)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({51,95,93,82,81,100},16))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({50,81,94,84,89,100},16)
local selectedWeapon = availableWeapons[1] or _d({51,95,93,82,81,100},16)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({50,81,94,84,89,100},16), _d({50,81,94,84,89,100,16,50,95,99,99},16), _d({52,81,96,88},16), _d({56,81,91,101},16), _d({60,89,92,105},16), _d({60,89,95,94,16,64,98,89,84,85},16), _d({61,81,98,97,101,81,94},16), _d({66,95,82,95},16), _d({66,95,94,94,105},16), _d({67,81,98,81,88},16)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({67,100,81,100,99},16)) and statsFolder.Stats:FindFirstChild(_d({64,85,92,89},16)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({62,64,51,99},16))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum = npc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({62,64,51,99},16))
local yi = folder and folder:FindFirstChild(_d({73,89},16))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({73,89},16) and obj:IsA(_d({61,95,84,85,92},16)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({62,64,51,99},16))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({103,81,100,85,98},16)) or hitName:find(_d({99,85,81},16)) or hitName:find(_d({95,83,85,81,94},16)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({50,81,99,85,64,81,98,100},16)) then
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
local att = root:FindFirstChild(_d({79,79,55,98,89,94,84,85,98,49,100,100},16)) or Instance.new(_d({49,100,100,81,83,88,93,85,94,100},16))
att.Name = _d({79,79,55,98,89,94,84,85,98,49,100,100},16)
att.Parent = root
local force = root:FindFirstChild(_d({79,79,55,98,89,94,84,85,98,54,95,98,83,85},16))
if not force then
force = Instance.new(_d({60,89,94,85,81,98,70,85,92,95,83,89,100,105},16))
force.Name = _d({79,79,55,98,89,94,84,85,98,54,95,98,83,85},16)
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
local force = root:FindFirstChild(_d({79,79,55,98,89,94,84,85,98,54,95,98,83,85},16))
local att = root:FindFirstChild(_d({79,79,55,98,89,94,84,85,98,49,100,100},16))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({62,95,94,85},16)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({66,95,91,101,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,85,96,96,95},16), args)
elseif style == _d({50,92,81,83,91,60,85,87},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91},16), args)
elseif style == _d({59,81,93,89,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,81,93,89,99,88,89,91,89,55,85,96,96,95},16), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91,34},16), args)
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
local yiRoot = yi:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
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
local prompt = yi:FindFirstChildWhichIsA(_d({64,98,95,104,89,93,89,100,105,64,98,95,93,96,100},16), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,86,89,98,85,96,98,95,104,89,93,89,100,105,96,98,95,93,96,100,16,94,95,100,16,99,101,96,96,95,98,100,85,84,16,82,105,16,85,104,85,83,101,100,95,98,17},16))
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
local bp = LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if npcRoot and npc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) and npc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) and finalNpc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)) and finalNpc:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({64,92,81,105,85,98,55,101,89},16))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({55,64,63,55,98,89,94,84,85,98,62,81,100,89,102,85,69,57},16))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({55,98,89,94,84,85,98,61,95,82,89,92,85,68,95,87,87,92,85},16))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,51,92,85,81,94,85,84,16,101,96,16,96,98,85,102,89,95,101,99,16,99,85,99,99,89,95,94,30},16))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({88,100,100,96,99,42,31,31,98,81,103,30,87,89,100,88,101,82,101,99,85,98,83,95,94,100,85,94,100,30,83,95,93,31,98,95,83,91,105,104,103,81,92,92,31,71,89,94,84,69,57,31,93,81,89,94,31,84,89,99,100,31,93,81,89,94,30,92,101,81},16)))()
end)
if not ok or type(WindUI) ~= _d({100,81,82,92,85},16) then
warn(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,77,16,54,81,89,92,85,84,16,100,95,16,92,95,81,84,16,71,89,94,84,69,57,30},16))
return
end
local Window = WindUI:CreateWindow({
Title = _d({55,85,96,95,16,55,98,89,94,84,85,98,16,102,32,30,32,30,33,40},16),
Icon = _d({99,103,95,98,84},16),
Folder = _d({55,85,96,95,55,98,89,94,84,85,98},16),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({52,81,98,91},16),
OpenButton = {
Title = _d({55,85,96,95,16,55,98,89,94,84,85,98},16),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({49,101,100,95,16,54,81,98,93},16), Icon = _d({99,103,95,98,84},16) })
local tabGeppo = Window:Tab({ Title = _d({55,85,96,96,95,16,50,101,105,85,98},16), Icon = _d({99,88,95,96,96,89,94,87,29,83,81,98,100},16) })
local tabSettings = Window:Tab({ Title = _d({67,85,100,100,89,94,87,99},16), Icon = _d({99,85,100,100,89,94,87,99},16) })
tabFarm:Toggle({
Title = _d({49,101,100,95,16,55,98,89,94,84,16,61,95,82,99,16,75,64,77},16),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({68,81,98,87,85,100,16,61,95,82},16),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({71,85,81,96,95,94,16,31,16,61,85,92,85,85},16),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({64,85,92,89,16,71,81,92,92,85,100},16),
Desc = _d({60,95,81,84,89,94,87,30,30,30},16)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({64,85,92,89,16,71,81,92,92,85,100},16), Desc = tostring(peli) .. (peli >= 50000 and _d({16,75,66,53,49,52,73,17,77},16) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({49,101,100,95,16,50,101,105,16,55,85,96,96,95},16),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({50,105,96,81,99,99,16,37,32,91,16,64,85,92,89,16,51,88,85,83,91},16),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({52,85,99,100,98,95,105,16,69,57,16,22,16,67,100,95,96,16,53,102,85,98,105,100,88,89,94,87},16),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({75,55,85,96,95,16,55,98,89,94,84,85,98,16,56,101,82,77,16,102,32,30,32,30,33,40,16,92,95,81,84,85,84,16,103,89,100,88,16,71,89,94,84,69,57,30},16))
end)()