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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({5,36,49,39,44,55},61)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({22,55,36,55,54},61)) and statsFolder.Stats:FindFirstChild(_d({15,40,57,40,47},61)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({22,55,36,55,54},61)) and statsFolder.Stats:FindFirstChild(_d({19,40,47,44},61)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({20,56,40,54,55},61)) and statsFolder.Quest:FindFirstChild(_d({6,56,53,53,40,49,55,20,56,40,54,55},61)) and statsFolder.Quest.CurrentQuest.Value or _d({17,50,49,40},61)
return lvl, peli, quest
end
return 1, 0, _d({17,50,49,40},61)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
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
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
importLib(_d({47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36},61))
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
warn(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,34,10,241,8,36,54,60,23,53,36,57,40,47,227,44,54,227,48,44,54,54,44,49,42,241,227,19,47,40,36,54,40,227,40,49,54,56,53,40,227,40,36,54,60,34,55,53,36,57,40,47,241,47,56,36,227,44,54,227,53,56,49,49,44,49,42,227,41,44,53,54,55,241},61))
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
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({24,51,51,40,53,23,50,53,54,50},61))
if not torso then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
importLib(_d({47,44,37,242,52,56,40,54,55,34,43,36,49,39,47,40,53,241,47,56,36},61), _d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,47,56,36,56,240,38,50,39,40,242,48,36,44,49,242,243,244,34,54,38,53,44,51,55,242,47,44,37,242,52,56,40,54,55,34,43,36,49,39,47,40,53,241,47,56,36},61))
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,8,21,21,18,21,253,227,20,56,40,54,55,11,36,49,39,47,40,53,227,47,44,37,53,36,53,60,227,38,50,56,47,39,227,49,50,55,227,37,40,227,47,50,36,39,40,39,228},61))
end
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
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,4,56,55,50,227,41,36,53,48,227,55,50,42,42,47,40,39,227,55,50,253,227},61) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({21,44,41,47,40},61)) or LocalPlayer.Character:FindFirstChild(_d({21,44,41,47,40},61))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({5,36,49,39,44,55},61)
if lvl < 3 then
if quest == _d({17,50,49,40},61) then
acceptQuest(_d({7,36,51,43},61))
return
end
else
if quest == _d({17,50,49,40},61) then
acceptQuest(_d({22,36,53,36,43},61))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({5,36,49,39,44,55,227,5,50,54,54},61)
if quest == _d({17,50,49,40},61) then
acceptQuest(_d({21,50,49,49,60},61))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({5,56,60,36,37,47,40,12,55,40,48,54},61))
local shopItem = buyables and buyables:FindFirstChild(_d({21,44,41,47,40},61))
local shopPart = shopItem and shopItem:FindFirstChild(_d({22,43,50,51,19,36,53,55},61))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({19,53,50,59,44,48,44,55,60,19,53,50,48,51,55},61), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({30,21,44,41,47,40,227,19,56,53,38,43,36,54,40,32,227,41,44,53,40,51,53,50,59,44,48,44,55,60,51,53,50,48,51,55,227,49,50,55,227,54,56,51,51,50,53,55,40,39,227,37,60,227,40,59,40,38,56,55,50,53,228},61))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,21,44,41,47,40,227,51,56,53,38,43,36,54,40,39,228,227,22,55,36,53,55,40,53,227,12,54,47,36,49,39,227,51,53,50,42,53,40,54,54,44,50,49,227,38,50,48,51,47,40,55,40,39,241,227,26,36,44,55,44,49,42,227,41,50,53,227,9,44,54,43,48,36,49,227,6,36,57,40,227,55,53,36,57,40,47,227,51,43,36,54,40,241},61))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
local weaponTool = bp and bp:FindFirstChild(_d({16,40,47,40,40},61))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if npcRoot and npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)) and finalNpc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,6,47,40,36,49,40,39,227,56,51,227,51,53,40,57,44,50,56,54,227,54,40,54,54,44,50,49,241},61))
end
print(_d({30,10,40,51,50,227,10,53,44,49,39,40,53,32,227,4,56,55,50,48,36,55,40,39,227,54,38,53,44,51,55,227,47,50,36,39,40,39,241,227,19,53,40,54,54,227,234,19,234,227,55,50,227,55,50,42,42,47,40,227,36,56,55,50,227,41,36,53,48,241},61))
end)()