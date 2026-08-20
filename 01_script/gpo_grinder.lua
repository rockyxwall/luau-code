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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local RunService = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local VIM = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({50,77,77,74},34)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({50,77,77,74},34)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({33,77,75,64,63,82},34))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({32,63,76,66,71,82},34)
local selectedWeapon = availableWeapons[1] or _d({33,77,75,64,63,82},34)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({32,63,76,66,71,82},34), _d({32,63,76,66,71,82,254,32,77,81,81},34), _d({34,63,78,70},34), _d({38,63,73,83},34), _d({42,71,74,87},34), _d({42,71,77,76,254,46,80,71,66,67},34), _d({43,63,80,79,83,63,76},34), _d({48,77,64,77},34), _d({48,77,76,76,87},34), _d({49,63,80,63,70},34)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({49,82,63,82,81},34)) and statsFolder.Stats:FindFirstChild(_d({46,67,74,71},34)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({44,46,33,81},34))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hum = npc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({44,46,33,81},34))
local yi = folder and folder:FindFirstChild(_d({55,71},34))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({55,71},34) and obj:IsA(_d({43,77,66,67,74},34)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({44,46,33,81},34))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({85,63,82,67,80},34)) or hitName:find(_d({81,67,63},34)) or hitName:find(_d({77,65,67,63,76},34)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({32,63,81,67,46,63,80,82},34)) then
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
local att = root:FindFirstChild(_d({61,61,37,80,71,76,66,67,80,31,82,82},34)) or Instance.new(_d({31,82,82,63,65,70,75,67,76,82},34))
att.Name = _d({61,61,37,80,71,76,66,67,80,31,82,82},34)
att.Parent = root
local force = root:FindFirstChild(_d({61,61,37,80,71,76,66,67,80,36,77,80,65,67},34))
if not force then
force = Instance.new(_d({42,71,76,67,63,80,52,67,74,77,65,71,82,87},34))
force.Name = _d({61,61,37,80,71,76,66,67,80,36,77,80,65,67},34)
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
if not autoGrind and not autoFlight then
local root = getRoot()
if root then
local force = root:FindFirstChild(_d({61,61,37,80,71,76,66,67,80,36,77,80,65,67},34))
local att = root:FindFirstChild(_d({61,61,37,80,71,76,66,67,80,31,82,82},34))
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
if not processed and input.KeyCode == Enum.KeyCode.P then
toggleAutoFarm()
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({44,77,76,67},34)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({48,77,73,83,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,67,78,78,77},34), args)
elseif style == _d({32,74,63,65,73,42,67,69},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73},34), args)
elseif style == _d({41,63,75,71,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,63,75,71,81,70,71,73,71,37,67,78,78,77},34), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73,16},34), args)
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
local yiRoot = yi:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
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
local prompt = yi:FindFirstChildWhichIsA(_d({46,80,77,86,71,75,71,82,87,46,80,77,75,78,82},34), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,68,71,80,67,78,80,77,86,71,75,71,82,87,78,80,77,75,78,82,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,67,86,67,65,83,82,77,80,255},34))
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
local bp = LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if npcRoot and npc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)) and npc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)) and finalNpc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)) and finalNpc:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34)).Health > 0 and (tick() - combatStartTime) < 8 do
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
task.spawn(function()
while autoFlight ~= nil do
task.wait(0.05)
if autoFlight then
pcall(function()
local myRoot = getRoot()
if myRoot then
local force = getOrCreateForce(myRoot)
local camera = Workspace.CurrentCamera
local moveDir = Vector3.zero
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
local targetVelocity = moveDir.Magnitude > 0 and (moveDir.Unit * flightSpeed) or Vector3.zero
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
targetVelocity = targetVelocity + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = targetVelocity
if moveDir.Magnitude > 0 or heightAdjust > 0 then
invokeGeppo()
end
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
autoFlight = nil
cleanupForce()
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
local playerGui = LocalPlayer:FindFirstChild(_d({46,74,63,87,67,80,37,83,71},34))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({37,46,45,37,80,71,76,66,67,80,44,63,82,71,84,67,51,39},34))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({37,80,71,76,66,67,80,43,77,64,71,74,67,50,77,69,69,74,67},34))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,59,254,33,74,67,63,76,67,66,254,83,78,254,78,80,67,84,71,77,83,81,254,81,67,81,81,71,77,76,12},34))
end
local MobileUI =
local function buildMobileUI()
if not MobileUI then return end
local Window = MobileUI.CreateWindow({ Title = _d({37,67,78,77,254,37,80,71,76,66,67,80,254,84,14,12,14,12,15,21},34) })
if not Window then return end
_G.GrinderLibrary = Window
local tabFarm = Window:AddTab(_d({31,83,82,77,254,36,63,80,75},34))
local tabFlight = Window:AddTab(_d({36,74,71,69,70,82},34))
local tabGeppo = Window:AddTab(_d({37,67,78,78,77,254,32,83,87,67,80},34))
local tabSettings = Window:AddTab(_d({49,67,82,82,71,76,69,81},34))
tabFarm:AddToggle(_d({31,83,82,77,254,37,80,71,76,66,254,43,77,64,81,254,57,46,59},34), false, function(val)
toggleAutoFarm(val)
end)
tabFarm:AddCycle(_d({50,63,80,69,67,82,254,43,77,64},34), mobList, selectedMob, function(val)
selectedMob = tostring(val)
targetNPC = nil
end)
tabFarm:AddCycle(_d({53,67,63,78,77,76,254,13,254,43,67,74,67,67},34), availableWeapons, selectedWeapon, function(val)
selectedWeapon = tostring(val)
end)
local peliLabel = tabFarm:AddLabel(_d({46,67,74,71,254,53,63,74,74,67,82,24,254,42,77,63,66,71,76,69,12,12,12},34))
task.spawn(function()
while Window.Main.Parent do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel.SetText(_d({46,67,74,71,254,53,63,74,74,67,82,24,254},34) .. tostring(peli) .. (peli >= 50000 and _d({254,57,48,35,31,34,55,255,59},34) or ""))
end)
end
end)
tabFlight:AddToggle(_d({39,76,68,71,76,71,82,67,254,37,67,78,78,77,254,36,74,87},34), false, function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end)
tabGeppo:AddToggle(_d({31,83,82,77,254,32,83,87,254,37,67,78,78,77},34), false, function(val)
autoBuyGeppo = val
end)
tabGeppo:AddToggle(_d({32,87,78,63,81,81,254,19,14,73,254,46,67,74,71,254,33,70,67,65,73},34), false, function(val)
bypassPeliCheck = val
end)
tabSettings:AddButton(_d({34,67,81,82,80,77,87,254,51,39,254,4,254,49,82,77,78,254,35,84,67,80,87,82,70,71,76,69},34), true, function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end)
end
task.spawn(buildMobileUI)
print(_d({57,37,67,78,77,254,37,80,71,76,66,67,80,254,38,83,64,59,254,84,14,12,14,12,15,21,254,74,77,63,66,67,66,254,85,71,82,70,254,43,77,66,83,74,63,80,254,43,77,64,71,74,67,51,39,12},34))
end)()