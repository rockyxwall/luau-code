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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({48,92,90,79,78,97},19))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({47,78,91,81,86,97},19)
local selectedWeapon = availableWeapons[1] or _d({48,92,90,79,78,97},19)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local manualGeppoEnabled = false
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({47,78,91,81,86,97},19), _d({47,78,91,81,86,97,13,47,92,96,96},19), _d({49,78,93,85},19), _d({53,78,88,98},19), _d({57,86,89,102},19), _d({57,86,92,91,13,61,95,86,81,82},19), _d({58,78,95,94,98,78,91},19), _d({63,92,79,92},19), _d({63,92,91,91,102},19), _d({64,78,95,78,85},19)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({64,97,78,97,96},19)) and statsFolder.Stats:FindFirstChild(_d({61,82,89,86},19)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = npc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({59,61,48,96},19))
local yi = folder and folder:FindFirstChild(_d({70,86},19))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({70,86},19) and obj:IsA(_d({58,92,81,82,89},19)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({100,78,97,82,95},19)) or hitName:find(_d({96,82,78},19)) or hitName:find(_d({92,80,82,78,91},19)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({47,78,96,82,61,78,95,97},19)) then
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
local att = root:FindFirstChild(_d({76,76,52,95,86,91,81,82,95,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,52,95,86,91,81,82,95,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,52,95,86,91,81,82,95,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,52,95,86,91,81,82,95,51,92,95,80,82},19)
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
local force = root:FindFirstChild(_d({76,76,52,95,86,91,81,82,95,51,92,95,80,82},19))
local att = root:FindFirstChild(_d({76,76,52,95,86,91,81,82,95,46,97,97},19))
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
elseif input.KeyCode == Enum.KeyCode.Q and manualGeppoEnabled then
invokeGeppo()
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({59,92,91,82},19)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
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
local yiRoot = yi:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
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
local prompt = yi:FindFirstChildWhichIsA(_d({61,95,92,101,86,90,86,97,102,61,95,92,90,93,97},19), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,83,86,95,82,93,95,92,101,86,90,86,97,102,93,95,92,90,93,97,13,91,92,97,13,96,98,93,93,92,95,97,82,81,13,79,102,13,82,101,82,80,98,97,92,95,14},19))
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
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if npcRoot and npc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and npc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
if playerGui then
local oldUI = playerGui:FindFirstChild(_d({52,61,60,52,95,86,91,81,82,95,59,78,97,86,99,82,66,54},19))
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild(_d({52,95,86,91,81,82,95,58,92,79,86,89,82,65,92,84,84,89,82},19))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,48,89,82,78,91,82,81,13,98,93,13,93,95,82,99,86,92,98,96,13,96,82,96,96,86,92,91,27},19))
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,84,86,97,85,98,79,27,80,92,90,28,51,92,92,97,78,84,82,96,98,96,28,68,86,91,81,66,54,28,95,82,89,82,78,96,82,96,28,89,78,97,82,96,97,28,81,92,100,91,89,92,78,81,28,90,78,86,91,27,89,98,78},19)))()
end)
if not ok or type(WindUI) ~= _d({97,78,79,89,82},19) then
warn(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,68,86,91,81,66,54,27},19))
return
end
local Window = WindUI:CreateWindow({
Title = _d({52,82,93,92,13,52,95,86,91,81,82,95,13,99,29,27,29,27,30,37},19),
Icon = _d({96,100,92,95,81},19),
Folder = _d({52,82,93,92,52,95,86,91,81,82,95},19),
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = _d({49,78,95,88},19),
OpenButton = {
Title = _d({52,82,93,92,13,52,95,86,91,81,82,95},19),
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({46,98,97,92,13,51,78,95,90},19), Icon = _d({96,100,92,95,81},19) })
local tabFlight = Window:Tab({ Title = _d({51,89,86,84,85,97},19), Icon = _d({93,89,78,91,82},19) })
local tabGeppo = Window:Tab({ Title = _d({52,82,93,93,92,13,47,98,102,82,95},19), Icon = _d({96,85,92,93,93,86,91,84,26,80,78,95,97},19) })
local tabSettings = Window:Tab({ Title = _d({64,82,97,97,86,91,84,96},19), Icon = _d({96,82,97,97,86,91,84,96},19) })
tabFarm:Toggle({
Title = _d({46,98,97,92,13,52,95,86,91,81,13,58,92,79,96,13,72,61,74},19),
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = _d({65,78,95,84,82,97,13,58,92,79},19),
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = _d({68,82,78,93,92,91,13,28,13,58,82,89,82,82},19),
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = _d({61,82,89,86,13,68,78,89,89,82,97},19),
Desc = _d({57,92,78,81,86,91,84,27,27,27},19)
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = _d({61,82,89,86,13,68,78,89,89,82,97},19), Desc = tostring(peli) .. (peli >= 50000 and _d({13,72,63,50,46,49,70,14,74},19) or "") })
end
end)
end
end)
tabFlight:Toggle({
Title = _d({54,91,83,86,91,86,97,82,13,52,82,93,93,92,13,51,89,102},19),
Value = false,
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end
})
tabFlight:Slider({
Title = _d({51,89,86,84,85,97,13,64,93,82,82,81},19),
Default = 50,
Min = 10,
Max = 200,
Step = 1,
Callback = function(val)
flightSpeed = val
end
})
tabFlight:Slider({
Title = _d({53,92,99,82,95,13,53,82,86,84,85,97},19),
Default = 6.5,
Min = 0,
Max = 50,
Step = 0.5,
Callback = function(val)
hoverHeight = val
end
})
tabFlight:Toggle({
Title = _d({58,78,91,98,78,89,13,52,82,93,93,92,13,72,62,74},19),
Value = false,
Callback = function(val)
manualGeppoEnabled = val
end
})
tabGeppo:Toggle({
Title = _d({46,98,97,92,13,47,98,102,13,52,82,93,93,92},19),
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = _d({47,102,93,78,96,96,13,34,29,88,13,61,82,89,86,13,48,85,82,80,88},19),
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = _d({49,82,96,97,95,92,102,13,66,54,13,19,13,64,97,92,93,13,50,99,82,95,102,97,85,86,91,84},19),
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,13,53,98,79,74,13,99,29,27,29,27,30,37,13,89,92,78,81,82,81,13,100,86,97,85,13,68,86,91,81,66,54,27},19))
end)()