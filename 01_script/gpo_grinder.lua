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
local autoFlight = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = _d({33,64,77,67,72,83},33)
local selectedWeapon = availableWeapons[1] or _d({34,78,76,65,64,83},33)
local hoverHeight = 6.5
local flightSpeed = 50.0
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
if not autoGrind and not autoFlight then
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
local playerGui = LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
local mobileBtn = playerGui and playerGui:FindFirstChild(_d({38,81,72,77,67,68,81,44,78,65,72,75,68,51,78,70,70,75,68},33))
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,60,255,34,75,68,64,77,68,67,255,84,79,255,79,81,68,85,72,78,84,82,255,82,68,82,82,72,78,77,13},33))
end
local function buildUI()
local playerGui = LocalPlayer:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33), 10)
if not playerGui then return end
for _, name in ipairs({_d({38,47,46,62,38,81,72,77,67,68,81,52,40},33), _d({38,47,46,62,38,81,72,77,67,68,81,51,78,70,70,75,68},33)}) do
local old = playerGui:FindFirstChild(name)
if old then old:Destroy() end
end
local toggleSG = Instance.new(_d({50,66,81,68,68,77,38,84,72},33))
toggleSG.Name = _d({38,47,46,62,38,81,72,77,67,68,81,51,78,70,70,75,68},33)
toggleSG.ResetOnSpawn = false
toggleSG.DisplayOrder = 100
toggleSG.Parent = playerGui
local toggleBtn = Instance.new(_d({51,68,87,83,33,84,83,83,78,77},33))
toggleBtn.Size = UDim2.new(0, 54, 0, 54)
toggleBtn.Position = UDim2.new(0, 6, 0.5, -27)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30, 33, 50)
toggleBtn.Text = "⚙"
toggleBtn.TextSize = 22
toggleBtn.TextColor3 = Color3.fromRGB(180, 200, 255)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BorderSizePixel = 0
toggleBtn.Parent = toggleSG
Instance.new(_d({52,40,34,78,81,77,68,81},33), toggleBtn).CornerRadius = UDim.new(1, 0)
local ts = Instance.new(_d({52,40,50,83,81,78,74,68},33), toggleBtn)
ts.Color = Color3.fromRGB(80, 100, 200)
ts.Thickness = 1.5
local sg = Instance.new(_d({50,66,81,68,68,77,38,84,72},33))
sg.Name = _d({38,47,46,62,38,81,72,77,67,68,81,52,40},33)
sg.ResetOnSpawn = false
sg.DisplayOrder = 99
sg.Parent = playerGui
local panel = Instance.new(_d({37,81,64,76,68},33))
panel.Name = _d({47,64,77,68,75},33)
panel.Size = UDim2.new(0, 230, 0, 420)
panel.Position = UDim2.new(0, 66, 0.5, -210)
panel.BackgroundColor3 = Color3.fromRGB(18, 20, 32)
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = sg
Instance.new(_d({52,40,34,78,81,77,68,81},33), panel).CornerRadius = UDim.new(0, 10)
local ps = Instance.new(_d({52,40,50,83,81,78,74,68},33), panel)
ps.Color = Color3.fromRGB(60, 70, 130)
ps.Thickness = 1.5
local header = Instance.new(_d({51,68,87,83,43,64,65,68,75},33))
header.Size = UDim2.new(1, 0, 0, 34)
header.BackgroundColor3 = Color3.fromRGB(26, 30, 50)
header.BorderSizePixel = 0
header.Text = _d({255,193,121,120,255,255,38,68,79,78,255,38,81,72,77,67,68,81,255,50,84,72,83,68},33)
header.TextSize = 12
header.Font = Enum.Font.GothamBold
header.TextColor3 = Color3.fromRGB(200, 210, 255)
header.TextXAlignment = Enum.TextXAlignment.Left
header.Parent = panel
Instance.new(_d({52,40,34,78,81,77,68,81},33), header).CornerRadius = UDim.new(0, 10)
local dragging, dragStart, startPos
header.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
dragging = true
dragStart = i.Position
startPos = panel.Position
end
end)
UserInputService.InputChanged:Connect(function(i)
if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
local delta = i.Position - dragStart
panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
end)
UserInputService.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
local scroll = Instance.new(_d({50,66,81,78,75,75,72,77,70,37,81,64,76,68},33))
scroll.Size = UDim2.new(1, 0, 1, -34)
scroll.Position = UDim2.new(0, 0, 0, 34)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 3
scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 100, 200)
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = panel
local layout = Instance.new(_d({52,40,43,72,82,83,43,64,88,78,84,83},33), scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 4)
Instance.new(_d({52,40,47,64,67,67,72,77,70},33), scroll).PaddingTop = UDim.new(0, 6)
local function pad(parent)
local p = Instance.new(_d({52,40,47,64,67,67,72,77,70},33), parent)
p.PaddingLeft = UDim.new(0, 10)
p.PaddingRight = UDim.new(0, 10)
end
local function makeSection(text, order)
local lbl = Instance.new(_d({51,68,87,83,43,64,65,68,75},33))
lbl.Size = UDim2.new(1, -20, 0, 18)
lbl.BackgroundTransparency = 1
lbl.Text = _d({193,115,95,193,115,95,255},33) .. text
lbl.TextSize = 10
lbl.Font = Enum.Font.GothamBold
lbl.TextColor3 = Color3.fromRGB(100, 120, 200)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.LayoutOrder = order
lbl.Parent = scroll
pad(lbl)
end
local function makeToggle(text, getVal, setVal, order)
local btn = Instance.new(_d({51,68,87,83,33,84,83,83,78,77},33))
btn.Size = UDim2.new(1, -20, 0, 30)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.LayoutOrder = order
btn.Parent = scroll
pad(btn)
Instance.new(_d({52,40,34,78,81,77,68,81},33), btn).CornerRadius = UDim.new(0, 6)
local function refresh()
local on = getVal()
btn.Text = (on and _d({193,123,115,255},33) or _d({193,123,117,255},33)) .. text
btn.BackgroundColor3 = on and Color3.fromRGB(30, 110, 50) or Color3.fromRGB(90, 25, 25)
end
refresh()
btn.MouseButton1Click:Connect(function()
setVal(not getVal())
refresh()
end)
return refresh
end
local function makeSlider(text, min, max, step, getVal, setVal, order)
local cont = Instance.new(_d({37,81,64,76,68},33))
cont.Size = UDim2.new(1, -20, 0, 44)
cont.BackgroundTransparency = 1
cont.LayoutOrder = order
cont.Parent = scroll
local lbl = Instance.new(_d({51,68,87,83,43,64,65,68,75},33))
lbl.Size = UDim2.new(1, 0, 0, 18)
lbl.BackgroundTransparency = 1
lbl.Font = Enum.Font.GothamBold
lbl.TextSize = 10
lbl.TextColor3 = Color3.fromRGB(190, 195, 230)
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Text = text .. _d({25,255},33) .. tostring(getVal())
lbl.Parent = cont
pad(lbl)
local track = Instance.new(_d({37,81,64,76,68},33))
track.Size = UDim2.new(1, -20, 0, 8)
track.Position = UDim2.new(0, 10, 0, 28)
track.BackgroundColor3 = Color3.fromRGB(40, 44, 70)
track.BorderSizePixel = 0
track.Parent = cont
Instance.new(_d({52,40,34,78,81,77,68,81},33), track).CornerRadius = UDim.new(1, 0)
local fill = Instance.new(_d({37,81,64,76,68},33))
fill.BackgroundColor3 = Color3.fromRGB(80, 110, 220)
fill.BorderSizePixel = 0
fill.Size = UDim2.new((getVal() - min) / (max - min), 0, 1, 0)
fill.Parent = track
Instance.new(_d({52,40,34,78,81,77,68,81},33), fill).CornerRadius = UDim.new(1, 0)
local sliding = false
local function update(inputPos)
local rel = math.clamp((inputPos.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
local raw = min + rel * (max - min)
local steps = math.round((raw - min) / step)
local val = math.clamp(min + steps * step, min, max)
fill.Size = UDim2.new((val - min) / (max - min), 0, 1, 0)
lbl.Text = text .. _d({25,255},33) .. tostring(val)
setVal(val)
end
track.InputBegan:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
sliding = true; update(i.Position)
end
end)
UserInputService.InputChanged:Connect(function(i)
if sliding and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
update(i.Position)
end
end)
UserInputService.InputEnded:Connect(function(i)
if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
sliding = false
end
end)
end
local function makeDropdown(text, options, getVal, setVal, order)
local btn = Instance.new(_d({51,68,87,83,33,84,83,83,78,77},33))
btn.Size = UDim2.new(1, -20, 0, 30)
btn.BackgroundColor3 = Color3.fromRGB(28, 32, 52)
btn.BorderSizePixel = 0
btn.Font = Enum.Font.GothamBold
btn.TextSize = 10
btn.TextColor3 = Color3.fromRGB(200, 205, 240)
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Text = _d({193,117,157,255},33) .. text .. _d({25,255},33) .. tostring(getVal())
btn.LayoutOrder = order
btn.Parent = scroll
pad(btn)
Instance.new(_d({52,40,34,78,81,77,68,81},33), btn).CornerRadius = UDim.new(0, 6)
local stroke = Instance.new(_d({52,40,50,83,81,78,74,68},33), btn)
stroke.Color = Color3.fromRGB(60, 70, 130)
stroke.Thickness = 1
local listFrame = nil
btn.MouseButton1Click:Connect(function()
if listFrame then listFrame:Destroy(); listFrame = nil; return end
listFrame = Instance.new(_d({37,81,64,76,68},33))
listFrame.Size = UDim2.new(1, 0, 0, math.min(#options, 5) * 26)
listFrame.Position = UDim2.new(0, 0, 1, 2)
listFrame.BackgroundColor3 = Color3.fromRGB(22, 25, 40)
listFrame.BorderSizePixel = 0
listFrame.ZIndex = 20
listFrame.ClipsDescendants = true
listFrame.Parent = btn
Instance.new(_d({52,40,34,78,81,77,68,81},33), listFrame).CornerRadius = UDim.new(0, 6)
local ll = Instance.new(_d({52,40,43,72,82,83,43,64,88,78,84,83},33), listFrame)
ll.SortOrder = Enum.SortOrder.LayoutOrder
for idx, opt in ipairs(options) do
local ob = Instance.new(_d({51,68,87,83,33,84,83,83,78,77},33))
ob.Size = UDim2.new(1, 0, 0, 26)
ob.BackgroundTransparency = 1
ob.Font = Enum.Font.GothamBold
ob.TextSize = 10
ob.TextColor3 = Color3.fromRGB(200, 205, 240)
ob.Text = tostring(opt)
ob.LayoutOrder = idx
ob.ZIndex = 21
ob.Parent = listFrame
ob.MouseButton1Click:Connect(function()
setVal(tostring(opt))
btn.Text = _d({193,117,157,255},33) .. text .. _d({25,255},33) .. tostring(opt)
listFrame:Destroy(); listFrame = nil
end)
end
end)
end
local infoLbl = Instance.new(_d({51,68,87,83,43,64,65,68,75},33))
infoLbl.Size = UDim2.new(1, -20, 0, 20)
infoLbl.BackgroundTransparency = 1
infoLbl.Font = Enum.Font.Code
infoLbl.TextSize = 10
infoLbl.TextColor3 = Color3.fromRGB(130, 220, 130)
infoLbl.TextXAlignment = Enum.TextXAlignment.Left
infoLbl.LayoutOrder = 99
infoLbl.Parent = scroll
pad(infoLbl)
local destroyBtn = Instance.new(_d({51,68,87,83,33,84,83,83,78,77},33))
destroyBtn.Size = UDim2.new(1, -20, 0, 28)
destroyBtn.BackgroundColor3 = Color3.fromRGB(100, 20, 20)
destroyBtn.BorderSizePixel = 0
destroyBtn.Font = Enum.Font.GothamBold
destroyBtn.TextSize = 11
destroyBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
destroyBtn.Text = _d({193,123,116,255,255,35,68,82,83,81,78,88,255,5,255,50,83,78,79},33)
destroyBtn.LayoutOrder = 100
destroyBtn.Parent = scroll
pad(destroyBtn)
Instance.new(_d({52,40,34,78,81,77,68,81},33), destroyBtn).CornerRadius = UDim.new(0, 6)
destroyBtn.MouseButton1Click:Connect(function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end)
makeSection(_d({32,52,51,46,255,37,32,49,44},33), 1)
makeToggle(_d({32,84,83,78,255,38,81,72,77,67,255,44,78,65,82,255,7,47,255,74,68,88,8},33), function() return autoGrind end, function(v)
autoGrind = v
if v then toggleAutoFarm(true) else toggleAutoFarm(false) end
end, 2)
makeDropdown(_d({51,64,81,70,68,83,255,44,78,65},33), mobList, function() return selectedMob end, function(v)
selectedMob = v; targetNPC = nil
end, 3)
makeDropdown(_d({54,68,64,79,78,77},33), availableWeapons, function() return selectedWeapon end, function(v)
selectedWeapon = v
end, 4)
makeSlider(_d({39,78,85,68,81,255,39,68,72,70,71,83},33), 4, 15, 0.5, function() return hoverHeight end, function(v) hoverHeight = v end, 5)
makeSection(_d({37,43,40,38,39,51},33), 10)
makeToggle(_d({40,77,69,72,77,72,83,68,255,37,75,72,70,71,83},33), function() return autoFlight end, function(v)
autoFlight = v
if not v then cleanupForce() end
end, 11)
makeSlider(_d({37,75,72,70,71,83,255,50,79,68,68,67},33), 10, 150, 5, function() return flightSpeed end, function(v) flightSpeed = v end, 12)
makeSection(_d({38,36,47,47,46,255,33,52,56,36,49},33), 20)
makeToggle(_d({32,84,83,78,255,33,84,88,255,38,68,79,79,78},33), function() return autoBuyGeppo end, function(v) autoBuyGeppo = v end, 21)
makeToggle(_d({33,88,79,64,82,82,255,20,15,74,255,47,68,75,72,255,7,51,68,82,83,8},33), function() return bypassPeliCheck end, function(v) bypassPeliCheck = v end, 22)
toggleBtn.MouseButton1Click:Connect(function()
panel.Visible = not panel.Visible
end)
task.spawn(function()
while sg.Parent do
task.wait(1)
pcall(function()
local peli = getPeli()
infoLbl.Text = _d({207,126,113,143,255,47,68,75,72,25,255},33) .. tostring(peli) .. (peli >= 50000 and _d({255,255,193,123,115,255,49,68,64,67,88,0},33) or "")
end)
end
end)
_G.GPO_GrinderUISG = sg
_G.GPO_GrinderToggleSG = toggleSG
end
local _origCleanup = _G.GepoGrinderCleanup
_G.GepoGrinderCleanup = function()
if _origCleanup then pcall(_origCleanup) end
if _G.GPO_GrinderUISG then pcall(function() _G.GPO_GrinderUISG:Destroy() end) end
if _G.GPO_GrinderToggleSG then pcall(function() _G.GPO_GrinderToggleSG:Destroy() end) end
end
task.spawn(buildUI)
print(_d({58,38,68,79,78,255,38,81,72,77,67,68,81,255,39,84,65,60,255,85,15,13,15,13,16,21,255,75,78,64,67,68,67,255,193,95,115,255,83,64,79,255,193,121,120,255,65,84,83,83,78,77,255,83,78,255,78,79,68,77,255,76,68,77,84,13},33))
end)()