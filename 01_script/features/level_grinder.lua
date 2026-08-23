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
local Players = game:GetService(_d({51,79,68,92,72,85,86},29))
local ReplicatedStorage = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local RunService = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local VIM = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local UserInputService = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({37,68,81,71,76,87},29)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({54,87,68,87,86},29)) and statsFolder.Stats:FindFirstChild(_d({47,72,89,72,79},29)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({54,87,68,87,86},29)) and statsFolder.Stats:FindFirstChild(_d({51,72,79,76},29)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({52,88,72,86,87},29)) and statsFolder.Quest:FindFirstChild(_d({38,88,85,85,72,81,87,52,88,72,86,87},29)) and statsFolder.Quest.CurrentQuest.Value or _d({49,82,81,72},29)
return lvl, peli, quest
end
return 1, 0, _d({49,82,81,72},29)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local hum = npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
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
if part:IsA(_d({37,68,86,72,51,68,85,87},29)) then
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
loadstring(game:HttpGet(_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,73,72,68,87,88,85,72,86,18,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68},29)))()
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
warn(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,66,42,17,40,68,86,92,55,85,68,89,72,79,3,76,86,3,80,76,86,86,76,81,74,17,3,51,79,72,68,86,72,3,72,81,86,88,85,72,3,72,68,86,92,66,87,85,68,89,72,79,17,79,88,68,3,76,86,3,85,88,81,81,76,81,74,3,73,76,85,86,87,17},29))
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
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({56,83,83,72,85,55,82,85,86,82},29))
local prompt = torso and torso:FindFirstChild(_d({51,85,82,80,83,87},29))
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({62,52,88,72,86,87,3,36,70,70,72,83,87,68,81,70,72,64,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
local chatGui = playerGui and playerGui:FindFirstChild(_d({49,51,38,38,43,36,55},29))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({74,82},29))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({72,81,71,38,75,68,87},29))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({17,17,17},29) then
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
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,36,88,87,82,3,73,68,85,80,3,87,82,74,74,79,72,71,3,87,82,29,3},29) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({53,76,73,79,72},29)) or LocalPlayer.Character:FindFirstChild(_d({53,76,73,79,72},29))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({37,68,81,71,76,87},29)
if lvl < 3 then
if quest == _d({49,82,81,72},29) then
acceptQuest(_d({39,68,83,75},29))
return
end
else
if quest == _d({49,82,81,72},29) then
acceptQuest(_d({54,68,85,68,75},29))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({37,68,81,71,76,87,3,37,82,86,86},29)
if quest == _d({49,82,81,72},29) then
acceptQuest(_d({53,82,81,81,92},29))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({37,88,92,68,69,79,72,44,87,72,80,86},29))
local shopItem = buyables and buyables:FindFirstChild(_d({53,76,73,79,72},29))
local shopPart = shopItem and shopItem:FindFirstChild(_d({54,75,82,83,51,68,85,87},29))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({51,85,82,91,76,80,76,87,92,51,85,82,80,83,87},29), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({62,53,76,73,79,72,3,51,88,85,70,75,68,86,72,64,3,73,76,85,72,83,85,82,91,76,80,76,87,92,83,85,82,80,83,87,3,81,82,87,3,86,88,83,83,82,85,87,72,71,3,69,92,3,72,91,72,70,88,87,82,85,4},29))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,53,76,73,79,72,3,83,88,85,70,75,68,86,72,71,4,3,54,87,68,85,87,72,85,3,44,86,79,68,81,71,3,83,85,82,74,85,72,86,86,76,82,81,3,70,82,80,83,79,72,87,72,71,17,3,58,68,76,87,76,81,74,3,73,82,85,3,41,76,86,75,80,68,81,3,38,68,89,72,3,87,85,68,89,72,79,3,83,75,68,86,72,17},29))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
local weaponTool = bp and bp:FindFirstChild(_d({48,72,79,72,72},29))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if npcRoot and npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and npc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)) and finalNpc:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({49,51,38,86},29))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,38,79,72,68,81,72,71,3,88,83,3,83,85,72,89,76,82,88,86,3,86,72,86,86,76,82,81,17},29))
end
print(_d({62,42,72,83,82,3,42,85,76,81,71,72,85,64,3,36,88,87,82,80,68,87,72,71,3,86,70,85,76,83,87,3,79,82,68,71,72,71,17,3,51,85,72,86,86,3,10,51,10,3,87,82,3,87,82,74,74,79,72,3,68,88,87,82,3,73,68,85,80,17},29))
end)()