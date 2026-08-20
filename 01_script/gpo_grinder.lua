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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({60,87,87,84},24)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({60,87,87,84},24)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({43,87,85,74,73,92},24))
end
return toolNames
end
local availableWeapons = scanTools()
local Rayfield = nil
local rayfieldSources = {
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,59,81,90,81,93,91,59,87,78,92,95,73,90,77,52,92,76,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77,22,84,93,73},24),
_d({80,92,92,88,91,34,23,23,91,81,90,81,93,91,22,85,77,86,93,23,90,73,97,78,81,77,84,76},24),
_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,91,80,84,77,96,95,73,90,77,23,58,73,97,78,81,77,84,76,23,85,73,81,86,23,91,87,93,90,75,77},24)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,46,73,81,84,77,76,8,92,87,8,84,87,73,76,8,58,73,97,78,81,77,84,76,8,61,49,8,52,81,74,90,73,90,97,22},24))
end
local Window = Rayfield:CreateWindow({
Name = _d({47,77,88,87,8,47,90,81,86,76,77,90,8,14,8,46,84,81,79,80,92,8,48,93,74},24),
LoadingTitle = _d({52,87,73,76,81,86,79,8,47,77,88,88,87,8,59,93,81,92,77,22,22,22},24),
LoadingSubtitle = _d({55,88,92,81,85,81,98,77,76,8,47,90,81,86,76},24),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
local autoGrind = false
local autoFlight = false
local selectedMob = _d({42,73,86,76,81,92},24)
local selectedWeapon = availableWeapons[1] or _d({43,87,85,74,73,92},24)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({59,92,73,92,91},24)) and statsFolder.Stats:FindFirstChild(_d({56,77,84,81},24)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({54,56,43,91},24))
local yi = folder and folder:FindFirstChild(_d({65,81},24))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({65,81},24) and obj:IsA(_d({53,87,76,77,84},24)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({95,73,92,77,90},24)) or hitName:find(_d({91,77,73},24)) or hitName:find(_d({87,75,77,73,86},24)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
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
local att = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,41,92,92},24)) or Instance.new(_d({41,92,92,73,75,80,85,77,86,92},24))
att.Name = _d({71,71,47,90,81,86,76,77,90,41,92,92},24)
att.Parent = root
local force = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24))
if not force then
force = Instance.new(_d({52,81,86,77,73,90,62,77,84,87,75,81,92,97},24))
force.Name = _d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24)
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
local force = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,46,87,90,75,77},24))
local att = root:FindFirstChild(_d({71,71,47,90,81,86,76,77,90,41,92,92},24))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({54,87,86,77},24)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({58,87,83,93,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,77,88,88,87},24), args)
elseif style == _d({42,84,73,75,83,52,77,79},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83},24), args)
elseif style == _d({51,73,85,81,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,73,85,81,91,80,81,83,81,47,77,88,88,87},24), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83,26},24), args)
end
end)
end
local function checkStuck(currentPos, targetPos)
if (targetPos - currentPos).Magnitude > 5 then
if (currentPos - lastPosition).Magnitude < 1 then
stuckTime = stuckTime + 0.2
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
if peli >= 50000 and not boughtGeppo then
local yi = findYiNPC()
if yi then
local yiRoot = yi:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
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
local prompt = yi:FindFirstChildWhichIsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24), true)
if prompt then
if fireproximityprompt then
fireproximityprompt(prompt)
end
task.wait(1.5)
if getPeli() < 50000 then
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
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if npcRoot and npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, targetPos)
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, finalTargetPos)
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 and (tick() - combatStartTime) < 8 do
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
pcall(function() Rayfield:Destroy() end)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
local MainTab = Window:CreateTab(_d({41,93,92,87,8,46,73,90,85},24), 4483362458)
local FlightTab = Window:CreateTab(_d({59,73,78,77,8,46,84,81,79,80,92},24), 4483362458)
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,53,87,74,8,60,73,90,79,77,92},24),
Options = {_d({42,73,86,76,81,92},24), _d({42,73,86,76,81,92,8,42,87,91,91},24), _d({44,73,88,80},24), _d({48,73,83,93},24), _d({52,81,84,97},24), _d({52,81,87,86,8,56,90,81,76,77},24), _d({53,73,90,89,93,73,86},24), _d({58,87,74,87},24), _d({58,87,86,86,97},24), _d({59,73,90,73,80},24)},
CurrentOption = _d({42,73,86,76,81,92},24),
MultipleOptions = false,
Callback = function(Option)
selectedMob = Option[1] or Option
targetNPC = nil
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,60,73,90,79,77,92,8,91,77,92,8,92,87,34},24), selectedMob)
end,
})
MainTab:CreateDropdown({
Name = _d({59,77,84,77,75,92,8,63,77,73,88,87,86,23,53,77,84,77,77},24),
Options = availableWeapons,
CurrentOption = selectedWeapon,
MultipleOptions = false,
Callback = function(Option)
local val = type(Option) == _d({92,73,74,84,77},24) and Option[1] or Option
selectedWeapon = tostring(val)
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,63,77,73,88,87,86,8,91,77,92,8,92,87,34},24), selectedWeapon)
end,
})
MainTab:CreateToggle({
Name = _d({41,93,92,87,8,47,90,81,86,76,8,53,87,74,91,8,16,55,90,8,56,90,77,91,91,8,56,8,51,77,97,17},24),
CurrentValue = false,
Callback = function(Value)
if autoGrind ~= Value then
toggleAutoFarm(Value)
end
end,
})
MainTab:CreateSlider({
Name = _d({48,87,94,77,90,8,48,77,81,79,80,92,8,41,74,87,94,77,8,53,87,74},24),
Range = {4, 15},
Increment = 0.5,
Suffix = _d({8,91,92,93,76,91},24),
CurrentValue = 6.5,
Callback = function(Value)
hoverHeight = Value
end,
})
task.spawn(function()
local peliLabel = MainTab:CreateParagraph({Title = _d({56,77,84,81,34,8,24},24), Content = _d({47,77,88,88,87,8,56,93,90,75,80,73,91,77,8,43,87,91,92,34,8,29,24,20,24,24,24,8,56,77,84,81},24)})
while autoGrind ~= nil do
task.wait(1)
pcall(function()
local peli = getPeli()
peliLabel:Set({
Title = _d({56,77,84,81,34,8},24) .. tostring(peli),
Content = peli >= 50000 and _d({216,135,118,113,8,29,24,20,24,24,24,8,56,77,84,81,8,58,77,73,75,80,77,76,9,8,58,77,73,76,97,8,92,87,8,88,93,90,75,80,73,91,77,8,47,77,88,88,87,22},24) or _d({47,90,81,86,76,81,86,79,8,56,77,84,81,22,22,22},24)
})
end)
end
end)
FlightTab:CreateToggle({
Name = _d({49,86,78,81,86,81,92,77,8,47,77,88,88,87,8,46,84,97},24),
CurrentValue = false,
Callback = function(Value)
autoFlight = Value
if not autoFlight then
cleanupForce()
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,49,86,78,81,86,81,92,77,8,46,84,81,79,80,92,34},24), autoFlight)
end,
})
FlightTab:CreateSlider({
Name = _d({46,84,81,79,80,92,8,59,88,77,77,76},24),
Range = {10, 150},
Increment = 5,
Suffix = _d({8,91,92,93,76,91,23,91},24),
CurrentValue = 50,
Callback = function(Value)
flightSpeed = Value
end,
})
MainTab:CreateButton({
Name = _d({44,77,91,92,90,87,97,8,61,49},24),
Callback = function()
_G.GepoGrinderCleanup()
end,
})
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,8,48,93,74,69,8,52,87,73,76,77,76,8,91,93,75,75,77,91,91,78,93,84,84,97,22},24))
end)()