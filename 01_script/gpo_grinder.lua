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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local RunService = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local VIM = game:GetService(_d({53,72,81,83,84,64,75,40,77,79,84,83,44,64,77,64,70,68,81},33))
local UserInputService = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({51,78,78,75},33)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({51,78,78,75},33)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({34,78,76,65,64,83},33))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({33,64,77,67,72,83},33)
local selectedWeapon = availableWeapons[1] or _d({34,78,76,65,64,83},33)
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({33,64,77,67,72,83},33), _d({33,64,77,67,72,83,255,33,78,82,82},33), _d({35,64,79,71},33), _d({39,64,74,84},33), _d({43,72,75,88},33), _d({43,72,78,77,255,47,81,72,67,68},33), _d({44,64,81,80,84,64,77},33), _d({49,78,65,78},33), _d({49,78,77,77,88},33), _d({50,64,81,64,71},33)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({50,83,64,83,82},33)) and statsFolder.Stats:FindFirstChild(_d({47,68,75,72},33)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local hum = npc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({45,47,34,82},33))
local yi = folder and folder:FindFirstChild(_d({56,72},33))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({56,72},33) and obj:IsA(_d({44,78,67,68,75},33)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({45,47,34,82},33))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({86,64,83,68,81},33)) or hitName:find(_d({82,68,64},33)) or hitName:find(_d({78,66,68,64,77},33)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({33,64,82,68,47,64,81,83},33)) then
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
local att = root:FindFirstChild(_d({62,62,38,81,72,77,67,68,81,32,83,83},33)) or Instance.new(_d({32,83,83,64,66,71,76,68,77,83},33))
att.Name = _d({62,62,38,81,72,77,67,68,81,32,83,83},33)
att.Parent = root
local force = root:FindFirstChild(_d({62,62,38,81,72,77,67,68,81,37,78,81,66,68},33))
if not force then
force = Instance.new(_d({43,72,77,68,64,81,53,68,75,78,66,72,83,88},33))
force.Name = _d({62,62,38,81,72,77,67,68,81,37,78,81,66,68},33)
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
local force = root:FindFirstChild(_d({62,62,38,81,72,77,67,68,81,37,78,81,66,68},33))
local att = root:FindFirstChild(_d({62,62,38,81,72,77,67,68,81,32,83,83},33))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({45,78,77,68},33)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({49,78,74,84,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,68,79,79,78},33), args)
elseif style == _d({33,75,64,66,74,43,68,70},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74},33), args)
elseif style == _d({42,64,76,72,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,64,76,72,82,71,72,74,72,38,68,79,79,78},33), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74,17},33), args)
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
local yiRoot = yi:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
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
local prompt = yi:FindFirstChildWhichIsA(_d({47,81,78,87,72,76,72,83,88,47,81,78,76,79,83},33), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,69,72,81,68,79,81,78,87,72,76,72,83,88,79,81,78,76,79,83,255,77,78,83,255,82,84,79,79,78,81,83,68,67,255,65,88,255,68,87,68,66,84,83,78,81,0},33))
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
local bp = LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if npcRoot and npc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)) and npc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)) and finalNpc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)) and finalNpc:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({38,47,46,38,81,72,77,67,68,81,45,64,83,72,85,68,52,40},33))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({38,81,72,77,67,68,81,44,78,65,72,75,68,51,78,70,70,75,68},33))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,34,75,68,64,77,68,67,255,84,79,255,79,81,68,85,72,78,84,82,255,82,68,82,82,72,78,77,13},33))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,54,72,77,67,52,40,14,76,64,72,77,14,67,72,82,83,14,76,64,72,77,13,75,84,64},33)))()
end)
if not ok or type(WindUI) ~= _d({83,64,65,75,68},33) then
warn(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,37,64,72,75,68,67,255,83,78,255,75,78,64,67,255,54,72,77,67,52,40,13},33))
return
end
local Window = WindUI:CreateWindow({
Title = _d({38,68,79,78,255,38,81,72,77,67,68,81,255,85,15,13,15,13,16,23},33),
Icon = _d({82,86,78,81,67},33),
Folder = _d({38,68,79,78,38,81,72,77,67,68,81},33),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({35,64,81,74},33),
OpenButton = {
Title = _d({38,68,79,78,255,38,81,72,77,67,68,81},33),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({32,84,83,78,255,37,64,81,76},33), Icon = _d({82,86,78,81,67},33) })
local tabGeppo = Window:Tab({ Title = _d({38,68,79,79,78,255,33,84,88,68,81},33), Icon = _d({82,71,78,79,79,72,77,70,12,66,64,81,83},33) })
local tabSettings = Window:Tab({ Title = _d({50,68,83,83,72,77,70,82},33), Icon = _d({82,68,83,83,72,77,70,82},33) })
tabFarm:Toggle({
Title = _d({32,84,83,78,255,38,81,72,77,67,255,44,78,65,82,255,58,47,60},33),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({51,64,81,70,68,83,255,44,78,65},33),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({54,68,64,79,78,77,255,14,255,44,68,75,68,68},33),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({47,68,75,72,255,54,64,75,75,68,83},33),
Desc = _d({43,78,64,67,72,77,70,13,13,13},33)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({47,68,75,72,255,54,64,75,75,68,83},33), Desc = tostring(peli) .. (peli >= 50000 and _d({255,58,49,36,32,35,56,0,60},33) or "") })
end
end)
end
end)
tabGeppo:Toggle({
Title = _d({32,84,83,78,255,33,84,88,255,38,68,79,79,78},33),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({33,88,79,64,82,82,255,20,15,74,255,47,68,75,72,255,34,71,68,66,74},33),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({35,68,82,83,81,78,88,255,52,40,255,5,255,50,83,78,79,255,36,85,68,81,88,83,71,72,77,70},33),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,255,39,84,65,60,255,85,15,13,15,13,16,23,255,75,78,64,67,68,67,255,86,72,83,71,255,54,72,77,67,52,40,13},33))
end)()