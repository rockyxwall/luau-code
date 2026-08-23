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
local Players = game:GetService(_d({39,67,56,80,60,73,74},41))
local ReplicatedStorage = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local RunService = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local UserInputService = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({25,56,69,59,64,75},41)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({42,75,56,75,74},41)) and statsFolder.Stats:FindFirstChild(_d({35,60,77,60,67},41)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({42,75,56,75,74},41)) and statsFolder.Stats:FindFirstChild(_d({39,60,67,64},41)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({40,76,60,74,75},41)) and statsFolder.Quest:FindFirstChild(_d({26,76,73,73,60,69,75,40,76,60,74,75},41)) and statsFolder.Quest.CurrentQuest.Value or _d({37,70,69,60},41)
return lvl, peli, quest
end
return 1, 0, _d({37,70,69,60},41)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum = npc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
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
loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,61,60,56,75,76,73,60,74,6,60,56,74,80,54,75,73,56,77,60,67,5,67,76,56},41)))()
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
warn(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,54,30,5,28,56,74,80,43,73,56,77,60,67,247,64,74,247,68,64,74,74,64,69,62,5,247,39,67,60,56,74,60,247,60,69,74,76,73,60,247,60,56,74,80,54,75,73,56,77,60,67,5,67,76,56,247,64,74,247,73,76,69,69,64,69,62,247,61,64,73,74,75,5},41))
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
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({44,71,71,60,73,43,70,73,74,70},41))
local prompt = torso and torso:FindFirstChild(_d({39,73,70,68,71,75},41))
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position + (torso.CFrame.LookVector * 5.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,40,76,60,74,75,247,24,58,58,60,71,75,56,69,58,60,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
local chatGui = playerGui and playerGui:FindFirstChild(_d({37,39,26,26,31,24,43},41))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({62,70},41))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({60,69,59,26,63,56,75},41))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({5,5,5},41) then
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
task.wait(0.4)
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
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,24,76,75,70,247,61,56,73,68,247,75,70,62,62,67,60,59,247,75,70,17,247},41) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({41,64,61,67,60},41)) or LocalPlayer.Character:FindFirstChild(_d({41,64,61,67,60},41))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({25,56,69,59,64,75},41)
if lvl < 3 then
if quest == _d({37,70,69,60},41) then
acceptQuest(_d({27,56,71,63},41))
return
end
else
if quest == _d({37,70,69,60},41) then
acceptQuest(_d({42,56,73,56,63},41))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({25,56,69,59,64,75,247,25,70,74,74},41)
if quest == _d({37,70,69,60},41) then
acceptQuest(_d({41,70,69,69,80},41))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({25,76,80,56,57,67,60,32,75,60,68,74},41))
local shopItem = buyables and buyables:FindFirstChild(_d({41,64,61,67,60},41))
local shopPart = shopItem and shopItem:FindFirstChild(_d({42,63,70,71,39,56,73,75},41))
if shopPart then
local targetPos = shopPart.Position + Vector3.new(0, 2, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({39,73,70,79,64,68,64,75,80,39,73,70,68,71,75},41), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({50,41,64,61,67,60,247,39,76,73,58,63,56,74,60,52,247,61,64,73,60,71,73,70,79,64,68,64,75,80,71,73,70,68,71,75,247,69,70,75,247,74,76,71,71,70,73,75,60,59,247,57,80,247,60,79,60,58,76,75,70,73,248},41))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,41,64,61,67,60,247,71,76,73,58,63,56,74,60,59,248,247,42,75,56,73,75,60,73,247,32,74,67,56,69,59,247,71,73,70,62,73,60,74,74,64,70,69,247,58,70,68,71,67,60,75,60,59,5,247,46,56,64,75,64,69,62,247,61,70,73,247,29,64,74,63,68,56,69,247,26,56,77,60,247,75,73,56,77,60,67,247,71,63,56,74,60,5},41))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
local weaponTool = bp and bp:FindFirstChild(_d({36,60,67,60,60},41))
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)) and finalNpc:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({37,39,26,74},41))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,26,67,60,56,69,60,59,247,76,71,247,71,73,60,77,64,70,76,74,247,74,60,74,74,64,70,69,5},41))
end
print(_d({50,30,60,71,70,247,30,73,64,69,59,60,73,52,247,24,76,75,70,68,56,75,60,59,247,74,58,73,64,71,75,247,67,70,56,59,60,59,5,247,39,73,60,74,74,247,254,39,254,247,75,70,247,75,70,62,62,67,60,247,56,76,75,70,247,61,56,73,68,5},41))
end)()