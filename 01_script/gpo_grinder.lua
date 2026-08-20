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
local Players = game:GetService(_d({18,46,35,59,39,52,53},62))
local ReplicatedStorage = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local RunService = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local VIM = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local UserInputService = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, _d({5,49,47,36,35,54},62))
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({4,35,48,38,43,54},62)
local selectedWeapon = availableWeapons[1] or _d({5,49,47,36,35,54},62)
local hoverHeight = 6.5
local flightSpeed = 50.0
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {_d({4,35,48,38,43,54},62), _d({4,35,48,38,43,54,226,4,49,53,53},62), _d({6,35,50,42},62), _d({10,35,45,55},62), _d({14,43,46,59},62), _d({14,43,49,48,226,18,52,43,38,39},62), _d({15,35,52,51,55,35,48},62), _d({20,49,36,49},62), _d({20,49,48,48,59},62), _d({21,35,52,35,42},62)}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({21,54,35,54,53},62)) and statsFolder.Stats:FindFirstChild(_d({18,39,46,43},62)) then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({16,18,5,53},62))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local hum = npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({16,18,5,53},62))
local yi = folder and folder:FindFirstChild(_d({27,43},62))
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == _d({27,43},62) and obj:IsA(_d({15,49,38,39,46},62)) then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({16,18,5,53},62))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find(_d({57,35,54,39,52},62)) or hitName:find(_d({53,39,35},62)) or hitName:find(_d({49,37,39,35,48},62)) or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({4,35,53,39,18,35,52,54},62)) then
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
local att = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,3,54,54},62)) or Instance.new(_d({3,54,54,35,37,42,47,39,48,54},62))
att.Name = _d({33,33,9,52,43,48,38,39,52,3,54,54},62)
att.Parent = root
local force = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62))
if not force then
force = Instance.new(_d({14,43,48,39,35,52,24,39,46,49,37,43,54,59},62))
force.Name = _d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62)
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
local force = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,8,49,52,37,39},62))
local att = root:FindFirstChild(_d({33,33,9,52,43,48,38,39,52,3,54,54},62))
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
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or _d({16,49,48,39},62)
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({20,49,45,55,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({9,39,50,50,49},62), args)
elseif style == _d({4,46,35,37,45,14,39,41},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45},62), args)
elseif style == _d({13,35,47,43,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,35,47,43,53,42,43,45,43,9,39,50,50,49},62), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45,244},62), args)
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
local yiRoot = yi:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
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
local prompt = yi:FindFirstChildWhichIsA(_d({18,52,49,58,43,47,43,54,59,18,52,49,47,50,54},62), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,40,43,52,39,50,52,49,58,43,47,43,54,59,50,52,49,47,50,54,226,48,49,54,226,53,55,50,50,49,52,54,39,38,226,36,59,226,39,58,39,37,55,54,49,52,227},62))
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
local bp = LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if npcRoot and npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and npc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 then
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)) and finalNpc:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local playerGui = LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
local mobileBtn = playerGui and playerGui:FindFirstChild(_d({9,52,43,48,38,39,52,15,49,36,43,46,39,22,49,41,41,46,39},62))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,5,46,39,35,48,39,38,226,55,50,226,50,52,39,56,43,49,55,53,226,53,39,53,53,43,49,48,240},62))
end
local LinoriaRepo = _d({42,54,54,50,53,252,241,241,52,35,57,240,41,43,54,42,55,36,55,53,39,52,37,49,48,54,39,48,54,240,37,49,47,241,56,43,49,46,43,48,239,53,55,60,55,54,53,55,45,43,241,14,43,48,49,52,43,35,14,43,36,241,47,35,43,48,241},62)
local Library = nil
local ok, err = pcall(function()
Library = loadstring(game:HttpGet(LinoriaRepo .. _d({14,43,36,52,35,52,59,240,46,55,35},62)))()
end)
if not ok or not Library then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,14,43,48,49,52,43,35,14,43,36,226,40,35,43,46,39,38,226,54,49,226,46,49,35,38,252,226},62) .. tostring(err))
end
local function buildLinoriaUI()
if not Library then
warn(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,31,226,23,11,226,53,45,43,50,50,39,38,226,164,66,86,226,46,43,36,52,35,52,59,226,48,49,54,226,46,49,35,38,39,38,240},62))
return
end
local Window = Library:CreateWindow({
Title = _d({9,39,50,49,226,9,52,43,48,38,39,52,226,56,242,240,242,240,243,247},62),
Center = false,
AutoShow = true,
TabPadding = 8,
MenuFadeTime = 0.2,
})
_G.GrinderLibrary = Library
local Tabs = {
Farm    = Window:AddTab(_d({3,55,54,49,226,8,35,52,47},62)),
Flight  = Window:AddTab(_d({21,35,40,39,226,8,46,43,41,42,54},62)),
Geppo   = Window:AddTab(_d({9,39,50,50,49,226,4,55,59,39,52},62)),
Settings = Window:AddTab(_d({21,39,54,54,43,48,41,53},62)),
}
local FarmBox = Tabs.Farm:AddLeftGroupbox(_d({15,49,36,226,8,35,52,47},62))
FarmBox:AddToggle(_d({3,55,54,49,9,52,43,48,38},62), {
Text = _d({3,55,54,49,226,9,52,43,48,38,226,15,49,36,53,226,226,29,18,31},62),
Default = false,
Tooltip = _d({22,49,41,41,46,39,226,35,55,54,49,226,47,49,36,226,41,52,43,48,38,43,48,41,226,49,48,241,49,40,40},62),
Callback = function(val)
toggleAutoFarm(val)
end,
})
FarmBox:AddDropdown(_d({22,35,52,41,39,54,15,49,36},62), {
Text = _d({22,35,52,41,39,54,226,15,49,36},62),
Default = _d({4,35,48,38,43,54},62),
Values = mobList,
Tooltip = _d({25,42,43,37,42,226,47,49,36,226,54,49,226,40,35,52,47},62),
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end,
})
FarmBox:AddDropdown(_d({25,39,35,50,49,48,21,39,46},62), {
Text = _d({25,39,35,50,49,48,226,241,226,15,39,46,39,39},62),
Default = selectedWeapon,
Values = availableWeapons,
Tooltip = _d({22,49,49,46,226,54,49,226,39,51,55,43,50,226,57,42,39,48,226,35,54,54,35,37,45,43,48,41},62),
Callback = function(val)
selectedWeapon = tostring(val)
end,
})
FarmBox:AddSlider(_d({10,49,56,39,52,10,39,43,41,42,54},62), {
Text = _d({10,49,56,39,52,226,10,39,43,41,42,54},62),
Default = hoverHeight,
Min = 4,
Max = 15,
Rounding = 1,
Suffix = _d({226,53,54,55,38,53},62),
Callback = function(val)
hoverHeight = val
end,
})
local peliLabel = FarmBox:AddLabel(_d({18,39,46,43,252,226,46,49,35,38,43,48,41,240,240,240},62))
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
local tag = peli >= 50000 and _d({226,29,20,7,3,6,27,227,31},62) or ""
peliLabel:SetText(_d({18,39,46,43,252,226},62) .. tostring(peli) .. tag)
end)
end
end)
local FlightBox = Tabs.Flight:AddLeftGroupbox(_d({11,48,40,43,48,43,54,39,226,8,46,43,41,42,54},62))
FlightBox:AddToggle(_d({11,48,40,43,48,43,54,39,8,46,43,41,42,54},62), {
Text = _d({11,48,40,43,48,43,54,39,226,9,39,50,50,49,226,8,46,59},62),
Default = false,
Tooltip = _d({13,39,39,50,226,40,46,59,43,48,41,226,55,53,43,48,41,226,9,39,50,50,49,226,35,36,43,46,43,54,59},62),
Callback = function(val)
autoFlight = val
if not autoFlight then cleanupForce() end
end,
})
FlightBox:AddSlider(_d({8,46,43,41,42,54,21,50,39,39,38},62), {
Text = _d({8,46,43,41,42,54,226,21,50,39,39,38},62),
Default = flightSpeed,
Min = 10,
Max = 150,
Rounding = 0,
Suffix = _d({226,53,241,53},62),
Callback = function(val)
flightSpeed = val
end,
})
local GeppoBox = Tabs.Geppo:AddLeftGroupbox(_d({3,55,54,49,226,18,55,52,37,42,35,53,39},62))
GeppoBox:AddToggle(_d({3,55,54,49,4,55,59,9,39,50,50,49},62), {
Text = _d({3,55,54,49,226,4,55,59,226,9,39,50,50,49},62),
Default = false,
Tooltip = _d({16,39,39,38,53,226,27,43,226,16,18,5,226,43,48,226,57,49,52,45,53,50,35,37,39,226,234,5,49,37,49,226,11,53,46,35,48,38,235},62),
Callback = function(val)
autoBuyGeppo = val
end,
})
GeppoBox:AddToggle(_d({4,59,50,35,53,53,18,39,46,43},62), {
Text = _d({4,59,50,35,53,53,226,247,242,45,226,18,39,46,43,226,5,42,39,37,45},62),
Default = false,
Tooltip = _d({8,49,52,226,54,39,53,54,43,48,41,226,164,66,86,226,53,45,43,50,53,226,50,39,46,43,226,36,35,46,35,48,37,39,226,52,39,51,55,43,52,39,47,39,48,54},62),
Callback = function(val)
bypassPeliCheck = val
end,
})
local SettingsBox = Tabs.Settings:AddLeftGroupbox(_d({21,37,52,43,50,54,226,5,49,48,54,52,49,46},62))
SettingsBox:AddButton({
Text = _d({6,39,53,54,52,49,59,226,23,11,226,232,226,21,54,49,50,226,7,56,39,52,59,54,42,43,48,41},62),
Func = function()
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
end,
Tooltip = _d({21,54,49,50,53,226,35,46,46,226,46,49,49,50,53,226,35,48,38,226,38,39,53,54,52,49,59,53,226,54,42,39,226,23,11},62),
})
local playerGui = LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62), 10)
if playerGui then
local oldBtn = playerGui:FindFirstChild(_d({9,52,43,48,38,39,52,15,49,36,43,46,39,22,49,41,41,46,39},62))
if oldBtn then oldBtn:Destroy() end
local sg = Instance.new(_d({21,37,52,39,39,48,9,55,43},62))
sg.Name = _d({9,52,43,48,38,39,52,15,49,36,43,46,39,22,49,41,41,46,39},62)
sg.ResetOnSpawn = false
sg.Parent = playerGui
local btn = Instance.new(_d({22,39,58,54,4,55,54,54,49,48},62))
btn.Size = UDim2.new(0, 56, 0, 56)
btn.Position = UDim2.new(0, 6, 0.42, 0)
btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 9
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({15,7,16,23},62)
btn.Parent = sg
Instance.new(_d({23,11,5,49,52,48,39,52},62), btn).CornerRadius = UDim.new(1, 0)
local s = Instance.new(_d({23,11,21,54,52,49,45,39},62))
s.Color = Color3.fromRGB(80, 110, 220)
s.Thickness = 2
s.Parent = btn
local shown = true
btn.MouseButton1Click:Connect(function()
shown = not shown
if shown then
Library:Show()
else
Library:Hide()
end
end)
end
end
task.spawn(buildLinoriaUI)
print(_d({29,9,39,50,49,226,9,52,43,48,38,39,52,226,10,55,36,31,226,56,242,240,242,240,243,247,226,46,49,35,38,39,38,226,57,43,54,42,226,14,43,48,49,52,43,35,14,43,36,226,23,11,240},62))
end)()