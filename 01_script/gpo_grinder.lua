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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({26,70,68,57,56,75},41))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({25,56,69,59,64,75},41)
local selectedWeapon = availableWeapons[1] or _d({26,70,68,57,56,75},41)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({25,56,69,59,64,75},41), _d({25,56,69,59,64,75,247,25,70,74,74},41), _d({27,56,71,63},41), _d({31,56,66,76},41), _d({35,64,67,80},41), _d({35,64,70,69,247,39,73,64,59,60},41), _d({36,56,73,72,76,56,69},41), _d({41,70,57,70},41), _d({41,70,69,69,80},41), _d({42,56,73,56,63},41)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({42,75,56,75,74},41)) and statsFolder.Stats:FindFirstChild(_d({39,60,67,64},41)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local yi = folder and folder:FindFirstChild(_d({48,64},41))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({48,64},41) and obj:IsA(_d({36,70,59,60,67},41)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({78,56,75,60,73},41)) or hitName:find(_d({74,60,56},41)) or hitName:find(_d({70,58,60,56,69},41)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({25,56,74,60,39,56,73,75},41)) then
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
local att = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,30,73,64,69,59,60,73,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41)
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
local force = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,29,70,73,58,60},41))
local att = root:FindFirstChild(_d({54,54,30,73,64,69,59,60,73,24,75,75},41))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({37,70,69,60},41)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({41,70,66,76,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,60,71,71,70},41), args)
elseif style == _d({25,67,56,58,66,35,60,62},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66},41), args)
elseif style == _d({34,56,68,64,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,56,68,64,74,63,64,66,64,30,60,71,71,70},41), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66,9},41), args)
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
local yiRoot = yi:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
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
local prompt = yi:FindFirstChildWhichIsA(_d({39,73,70,79,64,68,64,75,80,39,73,70,68,71,75},41), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
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
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if npcRoot and npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local oldUI = playerGui and playerGui:FindFirstChild(_d({30,39,38,30,73,64,69,59,60,73,37,56,75,64,77,60,44,32},41))
if oldUI then
pcall(function() oldUI:Destroy() end)
end
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,26,67,60,56,69,60,59,247,76,71,247,71,73,60,77,64,70,76,74,247,74,60,74,74,64,70,69,5},41))
end
local function buildNativeUI()
local playerGui = LocalPlayer:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({30,39,38,30,73,64,69,59,60,73,37,56,75,64,77,60,44,32},41))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({42,58,73,60,60,69,30,76,64},41))
screenGui.Name = _d({30,39,38,30,73,64,69,59,60,73,37,56,75,64,77,60,44,32},41)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({29,73,56,68,60},41))
main.Size = UDim2.new(0, 240, 0, 390)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.ClipsDescendants = false
main.Parent = screenGui
local corner = Instance.new(_d({44,32,26,70,73,69,60,73},41))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({44,32,42,75,73,70,66,60},41))
stroke.Color = Color3.fromRGB(50, 52, 68)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({43,60,79,75,35,56,57,60,67},41))
title.Size = UDim2.new(1, 0, 0, 36)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.Text = _d({30,60,71,70,247,30,73,64,69,59,60,73,247,42,76,64,75,60},41)
title.Parent = main
local function createToggle(text, valName, yPos, callback)
local btn = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
btn.Size = UDim2.new(1, -24, 0, 30)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 10
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main
Instance.new(_d({44,32,26,70,73,69,60,73},41), btn).CornerRadius = UDim.new(0, 6)
local function updateUI()
local active = false
if valName == _d({56,76,75,70,30,73,64,69,59},41) then active = autoGrind
elseif valName == _d({56,76,75,70,29,67,64,62,63,75},41) then active = autoFlight
elseif valName == _d({56,76,75,70,25,76,80,30,60,71,71,70},41) then active = autoBuyGeppo
elseif valName == _d({57,80,71,56,74,74,39,60,67,64,26,63,60,58,66},41) then active = bypassPeliCheck end
btn.Text = text .. _d({17,247},41) .. (active and _d({38,37},41) or _d({38,29,29},41))
btn.BackgroundColor3 = active and Color3.fromRGB(34, 139, 34) or Color3.fromRGB(160, 34, 34)
end
btn.MouseButton1Click:Connect(function()
callback()
updateUI()
end)
updateUI()
return btn
end
createToggle(_d({24,76,75,70,247,30,73,64,69,59,247,36,70,57,74},41), _d({56,76,75,70,30,73,64,69,59},41), 40, function()
toggleAutoFarm()
end)
createToggle(_d({32,69,61,64,69,64,75,60,247,29,67,64,62,63,75},41), _d({56,76,75,70,29,67,64,62,63,75},41), 75, function()
autoFlight = not autoFlight
if not autoFlight then cleanupForce() end
end)
createToggle(_d({24,76,75,70,247,25,76,80,247,30,60,71,71,70},41), _d({56,76,75,70,25,76,80,30,60,71,71,70},41), 110, function()
autoBuyGeppo = not autoBuyGeppo
end)
createToggle(_d({25,80,71,56,74,74,247,12,7,66,247,39,60,67,64,247,255,43,60,74,75,0},41), _d({57,80,71,56,74,74,39,60,67,64,26,63,60,58,66},41), 145, function()
bypassPeliCheck = not bypassPeliCheck
end)
local function createSlider(text, minVal, maxVal, increment, currentVal, yPos, callback)
local container = Instance.new(_d({29,73,56,68,60},41))
container.Size = UDim2.new(1, -24, 0, 42)
container.Position = UDim2.new(0, 12, 0, yPos)
container.BackgroundTransparency = 1
container.Parent = main
local label = Instance.new(_d({43,60,79,75,35,56,57,60,67},41))
label.Size = UDim2.new(1, 0, 0, 16)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 10
label.TextColor3 = Color3.fromRGB(200, 200, 210)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Text = text .. _d({17,247},41) .. tostring(currentVal)
label.Parent = container
local track = Instance.new(_d({29,73,56,68,60},41))
track.Size = UDim2.new(1, 0, 0, 6)
track.Position = UDim2.new(0, 0, 0, 24)
track.BackgroundColor3 = Color3.fromRGB(40, 42, 54)
track.BorderSizePixel = 0
track.Parent = container
Instance.new(_d({44,32,26,70,73,69,60,73},41), track).CornerRadius = UDim.new(1, 0)
local fill = Instance.new(_d({29,73,56,68,60},41))
fill.Size = UDim2.new((currentVal - minVal) / (maxVal - minVal), 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(80, 110, 220)
fill.BorderSizePixel = 0
fill.Parent = track
Instance.new(_d({44,32,26,70,73,69,60,73},41), fill).CornerRadius = UDim.new(1, 0)
local dragging = false
local function update(input)
local scale = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
local rawVal = minVal + scale * (maxVal - minVal)
local steps = math.round((rawVal - minVal) / increment)
local finalVal = minVal + steps * increment
finalVal = math.clamp(finalVal, minVal, maxVal)
fill.Size = UDim2.new((finalVal - minVal) / (maxVal - minVal), 0, 1, 0)
label.Text = text .. _d({17,247},41) .. tostring(finalVal)
callback(finalVal)
end
track.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
update(input)
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
update(input)
end
end)
UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
end
createSlider(_d({31,70,77,60,73,247,31,60,64,62,63,75},41), 4.0, 15.0, 0.5, hoverHeight, 185, function(val)
hoverHeight = val
end)
createSlider(_d({29,67,64,62,63,75,247,42,71,60,60,59},41), 10, 150, 5, flightSpeed, 235, function(val)
flightSpeed = val
end)
local function createDropdown(text, options, currentVal, yPos, callback)
local btn = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
btn.Size = UDim2.new(1, -24, 0, 28)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = Color3.fromRGB(36, 40, 52)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 10
btn.TextColor3 = Color3.fromRGB(220, 220, 235)
btn.Text = text .. _d({17,247},41) .. tostring(currentVal)
btn.ZIndex = 10
btn.Parent = main
Instance.new(_d({44,32,26,70,73,69,60,73},41), btn).CornerRadius = UDim.new(0, 6)
local menuFrame = nil
btn.MouseButton1Click:Connect(function()
if menuFrame then
menuFrame:Destroy()
menuFrame = nil
return
end
menuFrame = Instance.new(_d({42,58,73,70,67,67,64,69,62,29,73,56,68,60},41))
menuFrame.Size = UDim2.new(1, 0, 0, math.min(#options * 28, 140))
menuFrame.Position = UDim2.new(0, 0, 1, 4)
menuFrame.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
menuFrame.BorderSizePixel = 0
menuFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 28)
menuFrame.ScrollBarThickness = 4
menuFrame.ZIndex = 50
menuFrame.Parent = btn
local listCorner = Instance.new(_d({44,32,26,70,73,69,60,73},41))
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = menuFrame
local listStroke = Instance.new(_d({44,32,42,75,73,70,66,60},41))
listStroke.Color = Color3.fromRGB(60, 62, 80)
listStroke.Thickness = 1
listStroke.Parent = menuFrame
local layout = Instance.new(_d({44,32,35,64,74,75,35,56,80,70,76,75},41))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)
layout.Parent = menuFrame
for _, opt in ipairs(options) do
local optBtn = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
optBtn.Size = UDim2.new(1, 0, 0, 26)
optBtn.BackgroundTransparency = 1
optBtn.Font = Enum.Font.GothamBold
optBtn.TextSize = 9
optBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
optBtn.Text = tostring(opt)
optBtn.ZIndex = 51
optBtn.Parent = menuFrame
optBtn.MouseButton1Click:Connect(function()
btn.Text = text .. _d({17,247},41) .. tostring(opt)
callback(opt)
menuFrame:Destroy()
menuFrame = nil
end)
end
end)
end
createDropdown(_d({46,60,56,71,70,69},41), availableWeapons, selectedWeapon, 285, function(opt)
selectedWeapon = tostring(opt)
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,46,60,56,71,70,69,247,74,60,75,247,75,70,17},41), selectedWeapon)
end)
createDropdown(_d({43,56,73,62,60,75,247,36,70,57},41), mobList, selectedMob, 320, function(opt)
selectedMob = tostring(opt)
targetNPC = nil
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,43,56,73,62,60,75,247,68,70,57,247,74,60,75,247,75,70,17},41), selectedMob)
end)
local peliLabel = Instance.new(_d({43,60,79,75,35,56,57,60,67},41))
peliLabel.Size = UDim2.new(1, -24, 0, 20)
peliLabel.Position = UDim2.new(0, 12, 0, 360)
peliLabel.BackgroundTransparency = 1
peliLabel.Font = Enum.Font.Code
peliLabel.TextSize = 9
peliLabel.TextColor3 = Color3.fromRGB(150, 220, 150)
peliLabel.Text = _d({39,60,67,64,17,247},41) .. tostring(getPeli())
peliLabel.Parent = main
task.spawn(function()
while screenGui.Parent do
task.wait(1)
pcall(function()
peliLabel.Text = _d({39,60,67,64,17,247},41) .. tostring(getPeli())
end)
end
end)
local toggleTab = Instance.new(_d({43,60,79,75,25,76,75,75,70,69},41))
toggleTab.Size = UDim2.new(0, 48, 0, 48)
toggleTab.Position = UDim2.new(0.05, 0, 0.12, 0)
toggleTab.BackgroundColor3 = Color3.fromRGB(24, 25, 38)
toggleTab.Font = Enum.Font.GothamBold
toggleTab.TextSize = 10
toggleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTab.Text = _d({36,28,37,44},41)
toggleTab.Parent = screenGui
Instance.new(_d({44,32,26,70,73,69,60,73},41), toggleTab).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new(_d({44,32,42,75,73,70,66,60},41))
toggleStroke.Color = Color3.fromRGB(100, 105, 135)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleTab
toggleTab.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)
end
task.spawn(buildNativeUI)
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,247,31,76,57,52,247,35,70,56,59,60,59,247,74,76,58,58,60,74,74,61,76,67,67,80,247,78,64,75,63,247,26,76,74,75,70,68,247,39,67,56,80,60,73,30,76,64,5},41))
end)()