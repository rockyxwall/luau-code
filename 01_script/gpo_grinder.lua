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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({13,57,55,44,43,62},54))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({12,43,56,46,51,62},54)
local selectedWeapon = availableWeapons[1] or _d({13,57,55,44,43,62},54)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({12,43,56,46,51,62},54), _d({12,43,56,46,51,62,234,12,57,61,61},54), _d({14,43,58,50},54), _d({18,43,53,63},54), _d({22,51,54,67},54), _d({22,51,57,56,234,26,60,51,46,47},54), _d({23,43,60,59,63,43,56},54), _d({28,57,44,57},54), _d({28,57,56,56,67},54), _d({29,43,60,43,50},54)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({29,62,43,62,61},54)) and statsFolder.Stats:FindFirstChild(_d({26,47,54,51},54)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = npc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({24,26,13,61},54))
local yi = folder and folder:FindFirstChild(_d({35,51},54))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({35,51},54) and obj:IsA(_d({23,57,46,47,54},54)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({65,43,62,47,60},54)) or hitName:find(_d({61,47,43},54)) or hitName:find(_d({57,45,47,43,56},54)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({12,43,61,47,26,43,60,62},54)) then
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
local att = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,11,62,62},54)) or Instance.new(_d({11,62,62,43,45,50,55,47,56,62},54))
att.Name = _d({41,41,17,60,51,56,46,47,60,11,62,62},54)
att.Parent = root
local force = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54))
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = _d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54)
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
local force = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,16,57,60,45,47},54))
local att = root:FindFirstChild(_d({41,41,17,60,51,56,46,47,60,11,62,62},54))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({24,57,56,47},54)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
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
local yiRoot = yi:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
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
local prompt = yi:FindFirstChildWhichIsA(_d({26,60,57,66,51,55,51,62,67,26,60,57,55,58,62},54), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,48,51,60,47,58,60,57,66,51,55,51,62,67,58,60,57,55,58,62,234,56,57,62,234,61,63,58,58,57,60,62,47,46,234,44,67,234,47,66,47,45,63,62,57,60,235},54))
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
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if npcRoot and npc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)) and npc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)) and finalNpc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)) and finalNpc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({26,54,43,67,47,60,17,63,51},54))
local oldUI = playerGui and playerGui:FindFirstChild(_d({17,26,25,17,60,51,56,46,47,60,24,43,62,51,64,47,31,19},54))
if oldUI then
pcall(function() oldUI:Destroy() end)
end
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,13,54,47,43,56,47,46,234,63,58,234,58,60,47,64,51,57,63,61,234,61,47,61,61,51,57,56,248},54))
end
local function buildNativeUI()
local playerGui = LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({17,26,25,17,60,51,56,46,47,60,24,43,62,51,64,47,31,19},54))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({29,45,60,47,47,56,17,63,51},54))
screenGui.Name = _d({17,26,25,17,60,51,56,46,47,60,24,43,62,51,64,47,31,19},54)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({16,60,43,55,47},54))
main.Size = UDim2.new(0, 240, 0, 410)
main.Position = UDim2.new(0.05, 0, 0.2, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = true
main.ClipsDescendants = false
main.Parent = screenGui
local corner = Instance.new(_d({31,19,13,57,60,56,47,60},54))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({31,19,29,62,60,57,53,47},54))
stroke.Color = Color3.fromRGB(50, 52, 68)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({30,47,66,62,22,43,44,47,54},54))
title.Size = UDim2.new(1, 0, 0, 36)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextColor3 = Color3.fromRGB(240, 240, 250)
title.Text = _d({17,47,58,57,234,17,60,51,56,46,47,60,234,29,63,51,62,47},54)
title.Parent = main
local function createToggle(text, valName, yPos, callback)
local btn = Instance.new(_d({30,47,66,62,12,63,62,62,57,56},54))
btn.Size = UDim2.new(1, -24, 0, 30)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 10
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main
Instance.new(_d({31,19,13,57,60,56,47,60},54), btn).CornerRadius = UDim.new(0, 6)
local function updateUI()
local active = false
if valName == _d({43,63,62,57,17,60,51,56,46},54) then active = autoGrind
elseif valName == _d({43,63,62,57,16,54,51,49,50,62},54) then active = autoFlight
elseif valName == _d({43,63,62,57,12,63,67,17,47,58,58,57},54) then active = autoBuyGeppo
elseif valName == _d({44,67,58,43,61,61,26,47,54,51,13,50,47,45,53},54) then active = bypassPeliCheck end
btn.Text = text .. _d({4,234},54) .. (active and _d({25,24},54) or _d({25,16,16},54))
btn.BackgroundColor3 = active and Color3.fromRGB(34, 139, 34) or Color3.fromRGB(160, 34, 34)
end
btn.MouseButton1Click:Connect(function()
callback()
updateUI()
end)
updateUI()
return btn
end
createToggle(_d({11,63,62,57,234,17,60,51,56,46,234,23,57,44,61},54), _d({43,63,62,57,17,60,51,56,46},54), 40, function()
toggleAutoFarm()
end)
createToggle(_d({19,56,48,51,56,51,62,47,234,16,54,51,49,50,62},54), _d({43,63,62,57,16,54,51,49,50,62},54), 75, function()
autoFlight = not autoFlight
if not autoFlight then cleanupForce() end
end)
createToggle(_d({11,63,62,57,234,12,63,67,234,17,47,58,58,57},54), _d({43,63,62,57,12,63,67,17,47,58,58,57},54), 110, function()
autoBuyGeppo = not autoBuyGeppo
end)
createToggle(_d({12,67,58,43,61,61,234,255,250,53,234,26,47,54,51,234,242,30,47,61,62,243},54), _d({44,67,58,43,61,61,26,47,54,51,13,50,47,45,53},54), 145, function()
bypassPeliCheck = not bypassPeliCheck
end)
local function createSlider(text, minVal, maxVal, increment, currentVal, yPos, callback)
local container = Instance.new(_d({16,60,43,55,47},54))
container.Size = UDim2.new(1, -24, 0, 42)
container.Position = UDim2.new(0, 12, 0, yPos)
container.BackgroundTransparency = 1
container.Parent = main
local label = Instance.new(_d({30,47,66,62,22,43,44,47,54},54))
label.Size = UDim2.new(1, 0, 0, 16)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBold
label.TextSize = 10
label.TextColor3 = Color3.fromRGB(200, 200, 210)
label.TextXAlignment = Enum.TextXAlignment.Left
label.Text = text .. _d({4,234},54) .. tostring(currentVal)
label.Parent = container
local track = Instance.new(_d({16,60,43,55,47},54))
track.Size = UDim2.new(1, 0, 0, 6)
track.Position = UDim2.new(0, 0, 0, 24)
track.BackgroundColor3 = Color3.fromRGB(40, 42, 54)
track.BorderSizePixel = 0
track.Parent = container
Instance.new(_d({31,19,13,57,60,56,47,60},54), track).CornerRadius = UDim.new(1, 0)
local fill = Instance.new(_d({16,60,43,55,47},54))
fill.Size = UDim2.new((currentVal - minVal) / (maxVal - minVal), 0, 1, 0)
fill.BackgroundColor3 = Color3.fromRGB(80, 110, 220)
fill.BorderSizePixel = 0
fill.Parent = track
Instance.new(_d({31,19,13,57,60,56,47,60},54), fill).CornerRadius = UDim.new(1, 0)
local dragging = false
local function update(input)
local scale = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
local rawVal = minVal + scale * (maxVal - minVal)
local steps = math.round((rawVal - minVal) / increment)
local finalVal = minVal + steps * increment
finalVal = math.clamp(finalVal, minVal, maxVal)
fill.Size = UDim2.new((finalVal - minVal) / (maxVal - minVal), 0, 1, 0)
label.Text = text .. _d({4,234},54) .. tostring(finalVal)
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
createSlider(_d({18,57,64,47,60,234,18,47,51,49,50,62},54), 4.0, 15.0, 0.5, hoverHeight, 185, function(val)
hoverHeight = val
end)
createSlider(_d({16,54,51,49,50,62,234,29,58,47,47,46},54), 10, 150, 5, flightSpeed, 235, function(val)
flightSpeed = val
end)
local function createDropdown(text, options, currentVal, yPos, callback)
local btn = Instance.new(_d({30,47,66,62,12,63,62,62,57,56},54))
btn.Size = UDim2.new(1, -24, 0, 28)
btn.Position = UDim2.new(0, 12, 0, yPos)
btn.BackgroundColor3 = Color3.fromRGB(36, 40, 52)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 10
btn.TextColor3 = Color3.fromRGB(220, 220, 235)
btn.Text = text .. _d({4,234},54) .. tostring(currentVal)
btn.ZIndex = 10
btn.Parent = main
Instance.new(_d({31,19,13,57,60,56,47,60},54), btn).CornerRadius = UDim.new(0, 6)
local menuFrame = nil
btn.MouseButton1Click:Connect(function()
if menuFrame then
menuFrame:Destroy()
menuFrame = nil
return
end
menuFrame = Instance.new(_d({29,45,60,57,54,54,51,56,49,16,60,43,55,47},54))
menuFrame.Size = UDim2.new(1, 0, 0, math.min(#options * 28, 140))
menuFrame.Position = UDim2.new(0, 0, 1, 4)
menuFrame.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
menuFrame.BorderSizePixel = 0
menuFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 28)
menuFrame.ScrollBarThickness = 4
menuFrame.ZIndex = 50
menuFrame.Parent = btn
local listCorner = Instance.new(_d({31,19,13,57,60,56,47,60},54))
listCorner.CornerRadius = UDim.new(0, 6)
listCorner.Parent = menuFrame
local listStroke = Instance.new(_d({31,19,29,62,60,57,53,47},54))
listStroke.Color = Color3.fromRGB(60, 62, 80)
listStroke.Thickness = 1
listStroke.Parent = menuFrame
local layout = Instance.new(_d({31,19,22,51,61,62,22,43,67,57,63,62},54))
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 2)
layout.Parent = menuFrame
for _, opt in ipairs(options) do
local optBtn = Instance.new(_d({30,47,66,62,12,63,62,62,57,56},54))
optBtn.Size = UDim2.new(1, 0, 0, 26)
optBtn.BackgroundTransparency = 1
optBtn.Font = Enum.Font.GothamBold
optBtn.TextSize = 9
optBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
optBtn.Text = tostring(opt)
optBtn.ZIndex = 51
optBtn.Parent = menuFrame
optBtn.MouseButton1Click:Connect(function()
btn.Text = text .. _d({4,234},54) .. tostring(opt)
callback(opt)
menuFrame:Destroy()
menuFrame = nil
end)
end
end)
end
createDropdown(_d({33,47,43,58,57,56},54), availableWeapons, selectedWeapon, 285, function(opt)
selectedWeapon = tostring(opt)
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,33,47,43,58,57,56,234,61,47,62,234,62,57,4},54), selectedWeapon)
end)
createDropdown(_d({30,43,60,49,47,62,234,23,57,44},54), mobList, selectedMob, 320, function(opt)
selectedMob = tostring(opt)
targetNPC = nil
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,39,234,30,43,60,49,47,62,234,55,57,44,234,61,47,62,234,62,57,4},54), selectedMob)
end)
local peliLabel = Instance.new(_d({30,47,66,62,22,43,44,47,54},54))
peliLabel.Size = UDim2.new(1, -24, 0, 16)
peliLabel.Position = UDim2.new(0, 12, 0, 354)
peliLabel.BackgroundTransparency = 1
peliLabel.Font = Enum.Font.Code
peliLabel.TextSize = 9
peliLabel.TextColor3 = Color3.fromRGB(150, 220, 150)
peliLabel.Text = _d({26,47,54,51,4,234},54) .. tostring(getPeli())
peliLabel.Parent = main
task.spawn(function()
while screenGui.Parent do
task.wait(1)
pcall(function()
peliLabel.Text = _d({26,47,54,51,4,234},54) .. tostring(getPeli())
end)
end
end)
local destroyBtn = Instance.new(_d({30,47,66,62,12,63,62,62,57,56},54))
destroyBtn.Size = UDim2.new(1, -24, 0, 26)
destroyBtn.Position = UDim2.new(0, 12, 0, 374)
destroyBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 20)
destroyBtn.Font = Enum.Font.GothamBold
destroyBtn.TextSize = 10
destroyBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
destroyBtn.Text = _d({14,47,61,62,60,57,67,234,31,19,234,240,234,29,62,57,58,234,16,43,60,55},54)
destroyBtn.Parent = main
Instance.new(_d({31,19,13,57,60,56,47,60},54), destroyBtn).CornerRadius = UDim.new(0, 6)
local btnStroke = Instance.new(_d({31,19,29,62,60,57,53,47},54))
btnStroke.Color = Color3.fromRGB(160, 40, 40)
btnStroke.Thickness = 1
btnStroke.Parent = destroyBtn
destroyBtn.MouseButton1Click:Connect(function()
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
end)
local toggleTab = Instance.new(_d({30,47,66,62,12,63,62,62,57,56},54))
toggleTab.Size = UDim2.new(0, 48, 0, 48)
toggleTab.Position = UDim2.new(0.05, 0, 0.12, 0)
toggleTab.BackgroundColor3 = Color3.fromRGB(24, 25, 38)
toggleTab.Font = Enum.Font.GothamBold
toggleTab.TextSize = 10
toggleTab.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleTab.Text = _d({23,15,24,31},54)
toggleTab.Parent = screenGui
Instance.new(_d({31,19,13,57,60,56,47,60},54), toggleTab).CornerRadius = UDim.new(1, 0)
local toggleStroke = Instance.new(_d({31,19,29,62,60,57,53,47},54))
toggleStroke.Color = Color3.fromRGB(100, 105, 135)
toggleStroke.Thickness = 1.5
toggleStroke.Parent = toggleTab
toggleTab.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)
end
task.spawn(buildNativeUI)
print(_d({37,17,47,58,57,234,17,60,51,56,46,47,60,234,18,63,44,39,234,22,57,43,46,47,46,234,61,63,45,45,47,61,61,48,63,54,54,67,234,65,51,62,50,234,13,63,61,62,57,55,234,26,54,43,67,47,60,17,63,51,248},54))
end)()