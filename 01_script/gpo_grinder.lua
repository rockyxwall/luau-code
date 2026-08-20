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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({49,93,91,80,79,98},18))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({48,79,92,82,87,98},18)
local selectedWeapon = availableWeapons[1] or _d({49,93,91,80,79,98},18)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({48,79,92,82,87,98},18), _d({48,79,92,82,87,98,14,48,93,97,97},18), _d({50,79,94,86},18), _d({54,79,89,99},18), _d({58,87,90,103},18), _d({58,87,93,92,14,62,96,87,82,83},18), _d({59,79,96,95,99,79,92},18), _d({64,93,80,93},18), _d({64,93,92,92,103},18), _d({65,79,96,79,86},18)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({65,98,79,98,97},18)) and statsFolder.Stats:FindFirstChild(_d({62,83,90,87},18)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({60,62,49,97},18))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum = npc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({60,62,49,97},18))
local yi = folder and folder:FindFirstChild(_d({71,87},18))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({71,87},18) and obj:IsA(_d({59,93,82,83,90},18)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({60,62,49,97},18))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({101,79,98,83,96},18)) or hitName:find(_d({97,83,79},18)) or hitName:find(_d({93,81,83,79,92},18)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({48,79,97,83,62,79,96,98},18)) then
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
local att = root:FindFirstChild(_d({77,77,53,96,87,92,82,83,96,47,98,98},18)) or Instance.new(_d({47,98,98,79,81,86,91,83,92,98},18))
att.Name = _d({77,77,53,96,87,92,82,83,96,47,98,98},18)
att.Parent = root
local force = root:FindFirstChild(_d({77,77,53,96,87,92,82,83,96,52,93,96,81,83},18))
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = _d({77,77,53,96,87,92,82,83,96,52,93,96,81,83},18)
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
local force = root:FindFirstChild(_d({77,77,53,96,87,92,82,83,96,52,93,96,81,83},18))
local att = root:FindFirstChild(_d({77,77,53,96,87,92,82,83,96,47,98,98},18))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({60,93,92,83},18)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
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
local yiRoot = yi:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
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
local prompt = yi:FindFirstChildWhichIsA(_d({62,96,93,102,87,91,87,98,103,62,96,93,91,94,98},18), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,84,87,96,83,94,96,93,102,87,91,87,98,103,94,96,93,91,94,98,14,92,93,98,14,97,99,94,94,93,96,98,83,82,14,80,103,14,83,102,83,81,99,98,93,96,15},18))
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
local bp = LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if npcRoot and npc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) and npc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) and finalNpc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)) and finalNpc:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 and (tick() - combatStartTime) < 8 do
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
if _G.OrionGrinderLib then
pcall(function() _G.OrionGrinderLib:Destroy() end)
_G.OrionGrinderLib = nil
end
local playerGui = LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
local mobileBtn = playerGui and playerGui:FindFirstChild(_d({53,96,87,92,82,83,96,59,93,80,87,90,83,66,93,85,85,90,83},18))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,49,90,83,79,92,83,82,14,99,94,14,94,96,83,100,87,93,99,97,14,97,83,97,97,87,93,92,28},18))
end
local OrionLib = nil
local orionSources = {
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,97,86,90,83,102,101,79,96,83,29,61,96,87,93,92,29,91,79,87,92,29,97,93,99,96,81,83},18),
}
for _, url in ipairs(orionSources) do
local ok, result = pcall(function()
return loadstring(game:HttpGet(url, true))()
end)
if ok and result then
OrionLib = result
break
end
end
if not OrionLib then
warn(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,61,96,87,93,92,14,67,55,14,208,110,130,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,94,96,87,92,98,14,93,99,98,94,99,98,14,93,92,90,103,28},18))
end
local function buildOrionUI()
if not OrionLib then return end
local Window = OrionLib:MakeWindow({
Name = _d({53,83,94,93,14,53,96,87,92,82,83,96,14,65,99,87,98,83},18),
HidePremium = true,
SaveConfig = false,
ConfigFolder = _d({53,83,93,53,96,87,92,82,83,96},18),
IntroEnabled = false,
})
_G.OrionGrinderLib = OrionLib
local FarmTab = Window:MakeTab({
Name = _d({47,99,98,93,14,52,79,96,91},18),
Icon = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,34,34,38,33,33,36,32,34,35,38},18),
PremiumOnly = false,
})
FarmTab:AddToggle({
Name = _d({47,99,98,93,14,53,96,87,92,82,14,59,93,80,97,14,14,22,62,14,57,83,103,23},18),
Default = false,
Callback = function(val)
toggleAutoFarm(val)
end,
})
FarmTab:AddDropdown({
Name = _d({66,79,96,85,83,98,14,59,93,80},18),
Default = _d({48,79,92,82,87,98},18),
Options = mobList,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end,
})
FarmTab:AddDropdown({
Name = _d({69,83,79,94,93,92,14,29,14,59,83,90,83,83},18),
Default = selectedWeapon,
Options = availableWeapons,
Callback = function(val)
selectedWeapon = tostring(val)
end,
})
FarmTab:AddSlider({
Name = _d({54,93,100,83,96,14,54,83,87,85,86,98,14,22,97,98,99,82,97,23},18),
Min = 4,
Max = 15,
Default = hoverHeight,
Color = Color3.fromRGB(80, 110, 220),
Increment = 0.5,
ValueName = _d({97,98,99,82,97},18),
Callback = function(val)
hoverHeight = val
end,
})
local peliSection = FarmTab:AddParagraph(_d({62,83,90,87,14,69,79,90,90,83,98},18), _d({58,93,79,82,87,92,85,28,28,28},18))
task.spawn(function()
while _G.OrionGrinderLib do
task.wait(1)
pcall(function()
local peli = getPeli()
local msg = peli >= 50000 and _d({222,141,124,119,14,64,83,79,82,103,14,98,93,14,80,99,103,14,53,83,94,94,93,15},18) or _d({53,96,87,92,82,87,92,85,28,28,28},18)
peliSection:Set(_d({62,83,90,87,14,69,79,90,90,83,98},18), tostring(peli) .. _d({14,14,14},18) .. msg)
end)
end
end)
local GeppoTab = Window:MakeTab({
Name = _d({53,83,94,94,93,14,48,99,103,83,96},18),
Icon = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,34,34,38,33,33,36,32,34,35,38},18),
PremiumOnly = false,
})
GeppoTab:AddToggle({
Name = _d({47,99,98,93,14,48,99,103,14,53,83,94,94,93,14,22,92,83,83,82,97,14,71,87,14,87,92,14,101,93,96,89,97,94,79,81,83,23},18),
Default = false,
Callback = function(val)
autoBuyGeppo = val
end,
})
GeppoTab:AddToggle({
Name = _d({48,103,94,79,97,97,14,35,30,89,14,62,83,90,87,14,49,86,83,81,89,14,22,66,83,97,98,87,92,85,23},18),
Default = false,
Callback = function(val)
bypassPeliCheck = val
end,
})
local FlightTab = Window:MakeTab({
Name = _d({65,79,84,83,14,52,90,87,85,86,98},18),
Icon = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,34,34,38,33,33,36,32,34,35,38},18),
PremiumOnly = false,
})
FlightTab:AddToggle({
Name = _d({55,92,84,87,92,87,98,83,14,53,83,94,94,93,14,52,90,103},18),
Default = false,
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end,
})
FlightTab:AddSlider({
Name = _d({52,90,87,85,86,98,14,65,94,83,83,82},18),
Min = 10,
Max = 150,
Default = flightSpeed,
Color = Color3.fromRGB(80, 110, 220),
Increment = 5,
ValueName = _d({97,98,99,82,97,29,97},18),
Callback = function(val)
flightSpeed = val
end,
})
local SettingsTab = Window:MakeTab({
Name = _d({65,83,98,98,87,92,85,97},18),
Icon = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,34,34,38,33,33,36,32,34,35,38},18),
PremiumOnly = false,
})
SettingsTab:AddButton({
Name = _d({50,83,97,98,96,93,103,14,67,55,14,20,14,65,98,93,94,14,51,100,83,96,103,98,86,87,92,85},18),
Callback = function()
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
end,
})
OrionLib:Init()
local playerGui = LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if playerGui then
local oldBtn = playerGui:FindFirstChild(_d({53,96,87,92,82,83,96,59,93,80,87,90,83,66,93,85,85,90,83},18))
if oldBtn then oldBtn:Destroy() end
local sg = Instance.new(_d({65,81,96,83,83,92,53,99,87},18))
sg.Name = _d({53,96,87,92,82,83,96,59,93,80,87,90,83,66,93,85,85,90,83},18)
sg.ResetOnSpawn = false
sg.Parent = playerGui
local btn = Instance.new(_d({66,83,102,98,48,99,98,98,93,92},18))
btn.Size = UDim2.new(0, 52, 0, 52)
btn.Position = UDim2.new(0, 8, 0.45, 0)
btn.BackgroundColor3 = Color3.fromRGB(24, 25, 38)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 9
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({59,51,60,67},18)
btn.Parent = sg
Instance.new(_d({67,55,49,93,96,92,83,96},18), btn).CornerRadius = UDim.new(1, 0)
local s = Instance.new(_d({67,55,65,98,96,93,89,83},18))
s.Color = Color3.fromRGB(100, 105, 135)
s.Thickness = 1.5
s.Parent = btn
btn.MouseButton1Click:Connect(function()
OrionLib:Toggle()
end)
end
end
task.spawn(buildOrionUI)
print(_d({73,53,83,94,93,14,53,96,87,92,82,83,96,14,54,99,80,75,14,100,30,28,30,28,31,35,14,90,93,79,82,83,82,14,101,87,98,86,14,61,96,87,93,92,14,58,87,80,96,79,96,103,14,67,55,28},18))
end)()