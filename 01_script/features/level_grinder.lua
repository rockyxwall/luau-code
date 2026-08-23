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
_G.EasyTravelHelperMode = true
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({30,61,74,64,69,80},36)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({47,80,61,80,79},36)) and statsFolder.Stats:FindFirstChild(_d({40,65,82,65,72},36)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({47,80,61,80,79},36)) and statsFolder.Stats:FindFirstChild(_d({44,65,72,69},36)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({45,81,65,79,80},36)) and statsFolder.Quest:FindFirstChild(_d({31,81,78,78,65,74,80,45,81,65,79,80},36)) and statsFolder.Quest.CurrentQuest.Value or _d({42,75,74,65},36)
return lvl, peli, quest
end
return 1, 0, _d({42,75,74,65},36)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({42,44,31,79},36))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum = npc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
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
local function navigateTo(targetPos)
if not _G.EasyTravel then
pcall(function()
loadstring(game:HttpGet(_d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,66,65,61,80,81,78,65,79,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36)))()
end)
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 3.5 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,59,35,10,33,61,79,85,48,78,61,82,65,72,252,69,79,252,73,69,79,79,69,74,67,10,252,44,72,65,61,79,65,252,65,74,79,81,78,65,252,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61,252,69,79,252,78,81,74,74,69,74,67,252,66,69,78,79,80,10},36))
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function acceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({42,44,31,79},36))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({49,76,76,65,78,48,75,78,79,75},36))
local prompt = torso and torso:FindFirstChild(_d({44,78,75,73,76,80},36))
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({55,45,81,65,79,80,252,29,63,63,65,76,80,61,74,63,65,57,252,66,69,78,65,76,78,75,84,69,73,69,80,85,76,78,75,73,76,80,252,74,75,80,252,79,81,76,76,75,78,80,65,64,252,62,85,252,65,84,65,63,81,80,75,78,253},36))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
local chatGui = playerGui and playerGui:FindFirstChild(_d({42,44,31,31,36,29,48},36))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({34,78,61,73,65},36))
local goBtn = frame and frame:FindFirstChild(_d({67,75},36))
local endChatBtn = frame and frame:FindFirstChild(_d({65,74,64,31,68,61,80},36))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
conn:Fire()
end
end
end
task.wait(0.8)
end
end
return true
end
return false
end
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if not autoGrind then
stopNavigation()
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
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,29,81,80,75,252,66,61,78,73,252,80,75,67,67,72,65,64,252,80,75,22,252},36) .. tostring(autoGrind))
end
end
end)
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local lvl, peli, quest = getStats()
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or LocalPlayer.Character:FindFirstChild(_d({46,69,66,72,65},36))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({30,61,74,64,69,80},36)
if lvl < 3 then
if quest == _d({42,75,74,65},36) then
acceptQuest(_d({32,61,76,68},36))
return
end
else
if quest == _d({42,75,74,65},36) then
acceptQuest(_d({47,61,78,61,68},36))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({30,61,74,64,69,80,252,30,75,79,79},36)
if quest == _d({42,75,74,65},36) then
acceptQuest(_d({46,75,74,74,85},36))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({30,81,85,61,62,72,65,37,80,65,73,79},36))
local shopItem = buyables and buyables:FindFirstChild(_d({46,69,66,72,65},36))
local shopPart = shopItem and shopItem:FindFirstChild(_d({47,68,75,76,44,61,78,80},36))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({44,78,75,84,69,73,69,80,85,44,78,75,73,76,80},36), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({55,46,69,66,72,65,252,44,81,78,63,68,61,79,65,57,252,66,69,78,65,76,78,75,84,69,73,69,80,85,76,78,75,73,76,80,252,74,75,80,252,79,81,76,76,75,78,80,65,64,252,62,85,252,65,84,65,63,81,80,75,78,253},36))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,46,69,66,72,65,252,76,81,78,63,68,61,79,65,64,253,252,47,80,61,78,80,65,78,252,37,79,72,61,74,64,252,76,78,75,67,78,65,79,79,69,75,74,252,63,75,73,76,72,65,80,65,64,10,252,51,61,69,80,69,74,67,252,66,75,78,252,34,69,79,68,73,61,74,252,31,61,82,65,252,80,78,61,82,65,72,252,76,68,61,79,65,10},36))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
local weaponTool = bp and bp:FindFirstChild(_d({41,65,72,65,65},36))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if npcRoot and npc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) and npc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(targetPos)
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) and finalNpc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) and finalNpc:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
navigateTo(finalTargetPos)
task.wait(0.05)
end
end
end
end
else
stopNavigation()
end
else
stopNavigation()
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
stopNavigation()
local npcsFolder = Workspace:FindFirstChild(_d({42,44,31,79},36))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,31,72,65,61,74,65,64,252,81,76,252,76,78,65,82,69,75,81,79,252,79,65,79,79,69,75,74,10},36))
end
print(_d({55,35,65,76,75,252,35,78,69,74,64,65,78,57,252,29,81,80,75,73,61,80,65,64,252,79,63,78,69,76,80,252,72,75,61,64,65,64,10,252,44,78,65,79,79,252,3,44,3,252,80,75,252,80,75,67,67,72,65,252,61,81,80,75,252,66,61,78,73,10},36))
end)()