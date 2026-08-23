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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local RunService = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local VIM = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({53,80,80,77},31)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({53,80,80,77},31)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({36,80,78,67,66,85},31))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({35,66,79,69,74,85},31)
local selectedWeapon = availableWeapons[1] or _d({36,80,78,67,66,85},31)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({35,66,79,69,74,85},31), _d({35,66,79,69,74,85,1,35,80,84,84},31), _d({37,66,81,73},31), _d({41,66,76,86},31), _d({45,74,77,90},31), _d({45,74,80,79,1,49,83,74,69,70},31), _d({46,66,83,82,86,66,79},31), _d({51,80,67,80},31), _d({51,80,79,79,90},31), _d({52,66,83,66,73},31)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({52,85,66,85,84},31)) and statsFolder.Stats:FindFirstChild(_d({49,70,77,74},31)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({47,49,36,84},31))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum = npc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({47,49,36,84},31))
local yi = folder and folder:FindFirstChild(_d({58,74},31))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({58,74},31) and obj:IsA(_d({46,80,69,70,77},31)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({47,49,36,84},31))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({88,66,85,70,83},31)) or hitName:find(_d({84,70,66},31)) or hitName:find(_d({80,68,70,66,79},31)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({35,66,84,70,49,66,83,85},31)) then
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
local att = root:FindFirstChild(_d({64,64,40,83,74,79,69,70,83,34,85,85},31)) or Instance.new(_d({34,85,85,66,68,73,78,70,79,85},31))
att.Name = _d({64,64,40,83,74,79,69,70,83,34,85,85},31)
att.Parent = root
local force = root:FindFirstChild(_d({64,64,40,83,74,79,69,70,83,39,80,83,68,70},31))
if not force then
force = Instance.new(_d({45,74,79,70,66,83,55,70,77,80,68,74,85,90},31))
force.Name = _d({64,64,40,83,74,79,69,70,83,39,80,83,68,70},31)
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
local force = root:FindFirstChild(_d({64,64,40,83,74,79,69,70,83,39,80,83,68,70},31))
local att = root:FindFirstChild(_d({64,64,40,83,74,79,69,70,83,34,85,85},31))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({47,80,79,70},31)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({51,80,76,86,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,70,81,81,80},31), args)
elseif style == _d({35,77,66,68,76,45,70,72},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76},31), args)
elseif style == _d({44,66,78,74,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,66,78,74,84,73,74,76,74,40,70,81,81,80},31), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76,19},31), args)
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
local yiRoot = yi:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
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
local prompt = yi:FindFirstChildWhichIsA(_d({49,83,80,89,74,78,74,85,90,49,83,80,78,81,85},31), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,71,74,83,70,81,83,80,89,74,78,74,85,90,81,83,80,78,81,85,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,70,89,70,68,86,85,80,83,2},31))
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
local bp = LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if npcRoot and npc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) and npc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) and finalNpc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)) and finalNpc:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({40,49,48,40,83,74,79,69,70,83,47,66,85,74,87,70,54,42},31))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({40,83,74,79,69,70,83,46,80,67,74,77,70,53,80,72,72,77,70},31))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,36,77,70,66,79,70,69,1,86,81,1,81,83,70,87,74,80,86,84,1,84,70,84,84,74,80,79,15},31))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({73,85,85,81,84,27,16,16,83,66,88,15,72,74,85,73,86,67,86,84,70,83,68,80,79,85,70,79,85,15,68,80,78,16,83,80,68,76,90,89,88,66,77,77,16,56,74,79,69,54,42,16,78,66,74,79,16,69,74,84,85,16,78,66,74,79,15,77,86,66},31)))()
end)
if not ok or type(WindUI) ~= _d({85,66,67,77,70},31) then
warn(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,1,56,74,79,69,54,42,15},31))
return
end
local Window = WindUI:CreateWindow({
Title = _d({40,70,81,80,1,40,83,74,79,69,70,83,1,87,17,15,17,15,18,25},31),
Icon = _d({84,88,80,83,69},31),
Folder = _d({40,70,81,80,40,83,74,79,69,70,83},31),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({37,66,83,76},31),
OpenButton = {
Title = _d({40,70,81,80,1,40,83,74,79,69,70,83},31),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({34,86,85,80,1,39,66,83,78},31), Icon = _d({84,88,80,83,69},31) })
local tabGeppo = Window:Tab({ Title = _d({40,70,81,81,80,1,35,86,90,70,83},31), Icon = _d({84,73,80,81,81,74,79,72,14,68,66,83,85},31) })
local tabSettings = Window:Tab({ Title = _d({52,70,85,85,74,79,72,84},31), Icon = _d({84,70,85,85,74,79,72,84},31) })
tabFarm:Toggle({
Title = _d({34,86,85,80,1,40,83,74,79,69,1,46,80,67,84,1,60,49,62},31),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({53,66,83,72,70,85,1,46,80,67},31),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({56,70,66,81,80,79,1,16,1,46,70,77,70,70},31),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({49,70,77,74,1,56,66,77,77,70,85},31),
Desc = _d({45,80,66,69,74,79,72,15,15,15},31)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({49,70,77,74,1,56,66,77,77,70,85},31), Desc = tostring(peli) .. (peli >= 50000 and _d({1,60,51,38,34,37,58,2,62},31) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({34,86,85,80,1,35,86,90,1,40,70,81,81,80},31),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({35,90,81,66,84,84,1,22,17,76,1,49,70,77,74,1,36,73,70,68,76},31),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({37,70,84,85,83,80,90,1,54,42,1,7,1,52,85,80,81,1,38,87,70,83,90,85,73,74,79,72},31),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({60,40,70,81,80,1,40,83,74,79,69,70,83,1,41,86,67,62,1,87,17,15,17,15,18,25,1,77,80,66,69,70,69,1,88,74,85,73,1,56,74,79,69,54,42,15},31))
end)()