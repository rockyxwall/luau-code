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
local Players = game:GetService(_d({25,53,42,66,46,59,60},55))
local ReplicatedStorage = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local RunService = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local VIM = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local UserInputService = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({11,42,55,45,50,61},55)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({28,61,42,61,60},55)) and statsFolder.Stats:FindFirstChild(_d({21,46,63,46,53},55)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({28,61,42,61,60},55)) and statsFolder.Stats:FindFirstChild(_d({25,46,53,50},55)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({26,62,46,60,61},55)) and statsFolder.Quest:FindFirstChild(_d({12,62,59,59,46,55,61,26,62,46,60,61},55)) and statsFolder.Quest.CurrentQuest.Value or _d({23,56,55,46},55)
return lvl, peli, quest
end
return 1, 0, _d({23,56,55,46},55)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local hum = npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
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
if part:IsA(_d({11,42,60,46,25,42,59,61},55)) then
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
loadstring(game:HttpGet(_d({49,61,61,57,60,3,248,248,59,42,64,247,48,50,61,49,62,43,62,60,46,59,44,56,55,61,46,55,61,247,44,56,54,248,59,56,44,52,66,65,64,42,53,53,248,53,62,42,62,246,44,56,45,46,248,54,42,50,55,248,249,250,40,60,44,59,50,57,61,248,47,46,42,61,62,59,46,60,248,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42},55)))()
end)
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 8 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,40,16,247,14,42,60,66,29,59,42,63,46,53,233,50,60,233,54,50,60,60,50,55,48,247,233,25,53,46,42,60,46,233,46,55,60,62,59,46,233,46,42,60,66,40,61,59,42,63,46,53,247,53,62,42,233,50,60,233,59,62,55,55,50,55,48,233,47,50,59,60,61,247},55))
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
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({30,57,57,46,59,29,56,59,60,56},55))
local prompt = torso and torso:FindFirstChild(_d({25,59,56,54,57,61},55))
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local reached = navigateTo(torso.Position + Vector3.new(0, hoverHeight, 0))
if reached then
stopNavigation()
myRoot.CFrame = torso.CFrame + Vector3.new(0, 2, 0)
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({36,26,62,46,60,61,233,10,44,44,46,57,61,42,55,44,46,38,233,47,50,59,46,57,59,56,65,50,54,50,61,66,57,59,56,54,57,61,233,55,56,61,233,60,62,57,57,56,59,61,46,45,233,43,66,233,46,65,46,44,62,61,56,59,234},55))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({25,53,42,66,46,59,16,62,50},55))
local chatGui = playerGui and playerGui:FindFirstChild(_d({23,25,12,12,17,10,29},55))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({48,56},55))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({46,55,45,12,49,42,61},55))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({247,247,247},55) then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
conn:Fire()
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
conn:Fire()
end
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
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,10,62,61,56,233,47,42,59,54,233,61,56,48,48,53,46,45,233,61,56,3,233},55) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({27,50,47,53,46},55)) or LocalPlayer.Character:FindFirstChild(_d({27,50,47,53,46},55))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({11,42,55,45,50,61},55)
if lvl < 3 then
if quest == _d({23,56,55,46},55) then
acceptQuest(_d({13,42,57,49},55))
return
end
else
if quest == _d({23,56,55,46},55) then
acceptQuest(_d({28,42,59,42,49},55))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({11,42,55,45,50,61,233,11,56,60,60},55)
if quest == _d({23,56,55,46},55) then
acceptQuest(_d({27,56,55,55,66},55))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({11,62,66,42,43,53,46,18,61,46,54,60},55))
local shopItem = buyables and buyables:FindFirstChild(_d({27,50,47,53,46},55))
local shopPart = shopItem and shopItem:FindFirstChild(_d({28,49,56,57,25,42,59,61},55))
if shopPart then
local reached = navigateTo(shopPart.Position + Vector3.new(0, hoverHeight, 0))
if reached then
stopNavigation()
myRoot.CFrame = shopPart.CFrame + Vector3.new(0, 2, 0)
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({25,59,56,65,50,54,50,61,66,25,59,56,54,57,61},55), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({36,27,50,47,53,46,233,25,62,59,44,49,42,60,46,38,233,47,50,59,46,57,59,56,65,50,54,50,61,66,57,59,56,54,57,61,233,55,56,61,233,60,62,57,57,56,59,61,46,45,233,43,66,233,46,65,46,44,62,61,56,59,234},55))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,27,50,47,53,46,233,57,62,59,44,49,42,60,46,45,234,233,28,61,42,59,61,46,59,233,18,60,53,42,55,45,233,57,59,56,48,59,46,60,60,50,56,55,233,44,56,54,57,53,46,61,46,45,247,233,32,42,50,61,50,55,48,233,47,56,59,233,15,50,60,49,54,42,55,233,12,42,63,46,233,61,59,42,63,46,53,233,57,49,42,60,46,247},55))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
local weaponTool = bp and bp:FindFirstChild(_d({22,46,53,46,46},55))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if npcRoot and npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and npc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)) and finalNpc:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({23,25,12,60},55))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,12,53,46,42,55,46,45,233,62,57,233,57,59,46,63,50,56,62,60,233,60,46,60,60,50,56,55,247},55))
end
print(_d({36,16,46,57,56,233,16,59,50,55,45,46,59,38,233,10,62,61,56,54,42,61,46,45,233,60,44,59,50,57,61,233,53,56,42,45,46,45,247,233,25,59,46,60,60,233,240,25,240,233,61,56,233,61,56,48,48,53,46,233,42,62,61,56,233,47,42,59,54,247},55))
end)()