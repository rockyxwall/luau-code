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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local RunService = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local VIM = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({6,37,50,40,45,56},60)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({23,56,37,56,55},60)) and statsFolder.Stats:FindFirstChild(_d({16,41,58,41,48},60)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({23,56,37,56,55},60)) and statsFolder.Stats:FindFirstChild(_d({20,41,48,45},60)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({21,57,41,55,56},60)) and statsFolder.Quest:FindFirstChild(_d({7,57,54,54,41,50,56,21,57,41,55,56},60)) and statsFolder.Quest.CurrentQuest.Value or _d({18,51,50,41},60)
return lvl, peli, quest
end
return 1, 0, _d({18,51,50,41},60)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({18,20,7,55},60))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local hum = npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
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
if part:IsA(_d({6,37,55,41,20,37,54,56},60)) then
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
loadstring(game:HttpGet(_d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,48,57,37,57,241,39,51,40,41,243,49,37,45,50,243,244,245,35,55,39,54,45,52,56,243,48,45,38,243,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37},60)))()
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
warn(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,35,11,242,9,37,55,61,24,54,37,58,41,48,228,45,55,228,49,45,55,55,45,50,43,242,228,20,48,41,37,55,41,228,41,50,55,57,54,41,228,41,37,55,61,35,56,54,37,58,41,48,242,48,57,37,228,45,55,228,54,57,50,50,45,50,43,228,42,45,54,55,56,242},60))
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
local npcsFolder = Workspace:FindFirstChild(_d({18,20,7,55},60))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({25,52,52,41,54,24,51,54,55,51},60))
local prompt = torso and torso:FindFirstChild(_d({20,54,51,49,52,56},60))
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
warn(_d({31,21,57,41,55,56,228,5,39,39,41,52,56,37,50,39,41,33,228,42,45,54,41,52,54,51,60,45,49,45,56,61,52,54,51,49,52,56,228,50,51,56,228,55,57,52,52,51,54,56,41,40,228,38,61,228,41,60,41,39,57,56,51,54,229},60))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({20,48,37,61,41,54,11,57,45},60))
local chatGui = playerGui and playerGui:FindFirstChild(_d({18,20,7,7,12,5,24},60))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({10,54,37,49,41},60))
local goBtn = frame and frame:FindFirstChild(_d({43,51},60))
local endChatBtn = frame and frame:FindFirstChild(_d({41,50,40,7,44,37,56},60))
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
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,5,57,56,51,228,42,37,54,49,228,56,51,43,43,48,41,40,228,56,51,254,228},60) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({22,45,42,48,41},60)) or LocalPlayer.Character:FindFirstChild(_d({22,45,42,48,41},60))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({6,37,50,40,45,56},60)
if lvl < 3 then
if quest == _d({18,51,50,41},60) then
acceptQuest(_d({8,37,52,44},60))
return
end
else
if quest == _d({18,51,50,41},60) then
acceptQuest(_d({23,37,54,37,44},60))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({6,37,50,40,45,56,228,6,51,55,55},60)
if quest == _d({18,51,50,41},60) then
acceptQuest(_d({22,51,50,50,61},60))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({6,57,61,37,38,48,41,13,56,41,49,55},60))
local shopItem = buyables and buyables:FindFirstChild(_d({22,45,42,48,41},60))
local shopPart = shopItem and shopItem:FindFirstChild(_d({23,44,51,52,20,37,54,56},60))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({20,54,51,60,45,49,45,56,61,20,54,51,49,52,56},60), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({31,22,45,42,48,41,228,20,57,54,39,44,37,55,41,33,228,42,45,54,41,52,54,51,60,45,49,45,56,61,52,54,51,49,52,56,228,50,51,56,228,55,57,52,52,51,54,56,41,40,228,38,61,228,41,60,41,39,57,56,51,54,229},60))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,22,45,42,48,41,228,52,57,54,39,44,37,55,41,40,229,228,23,56,37,54,56,41,54,228,13,55,48,37,50,40,228,52,54,51,43,54,41,55,55,45,51,50,228,39,51,49,52,48,41,56,41,40,242,228,27,37,45,56,45,50,43,228,42,51,54,228,10,45,55,44,49,37,50,228,7,37,58,41,228,56,54,37,58,41,48,228,52,44,37,55,41,242},60))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
local weaponTool = bp and bp:FindFirstChild(_d({17,41,48,41,41},60))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if npcRoot and npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and npc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)) and finalNpc:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({18,20,7,55},60))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,7,48,41,37,50,41,40,228,57,52,228,52,54,41,58,45,51,57,55,228,55,41,55,55,45,51,50,242},60))
end
print(_d({31,11,41,52,51,228,11,54,45,50,40,41,54,33,228,5,57,56,51,49,37,56,41,40,228,55,39,54,45,52,56,228,48,51,37,40,41,40,242,228,20,54,41,55,55,228,235,20,235,228,56,51,228,56,51,43,43,48,41,228,37,57,56,51,228,42,37,54,49,242},60))
end)()