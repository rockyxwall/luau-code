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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({47,78,91,81,86,97},19)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({64,97,78,97,96},19)) and statsFolder.Stats:FindFirstChild(_d({57,82,99,82,89},19)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({64,97,78,97,96},19)) and statsFolder.Stats:FindFirstChild(_d({61,82,89,86},19)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({62,98,82,96,97},19)) and statsFolder.Quest:FindFirstChild(_d({48,98,95,95,82,91,97,62,98,82,96,97},19)) and statsFolder.Quest.CurrentQuest.Value or _d({59,92,91,82},19)
return lvl, peli, quest
end
return 1, 0, _d({59,92,91,82},19)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = npc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,83,82,78,97,98,95,82,96,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19)))()
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
warn(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,76,52,27,50,78,96,102,65,95,78,99,82,89,13,86,96,13,90,86,96,96,86,91,84,27,13,61,89,82,78,96,82,13,82,91,96,98,95,82,13,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78,13,86,96,13,95,98,91,91,86,91,84,13,83,86,95,96,97,27},19))
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
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({66,93,93,82,95,65,92,95,96,92},19))
local prompt = torso and torso:FindFirstChild(_d({61,95,92,90,93,97},19))
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
warn(_d({72,62,98,82,96,97,13,46,80,80,82,93,97,78,91,80,82,74,13,83,86,95,82,93,95,92,101,86,90,86,97,102,93,95,92,90,93,97,13,91,92,97,13,96,98,93,93,92,95,97,82,81,13,79,102,13,82,101,82,80,98,97,92,95,14},19))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
local chatGui = playerGui and playerGui:FindFirstChild(_d({59,61,48,48,53,46,65},19))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({51,95,78,90,82},19))
local goBtn = frame and frame:FindFirstChild(_d({84,92},19))
local endChatBtn = frame and frame:FindFirstChild(_d({82,91,81,48,85,78,97},19))
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
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,46,98,97,92,13,83,78,95,90,13,97,92,84,84,89,82,81,13,97,92,39,13},19) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({63,86,83,89,82},19)) or LocalPlayer.Character:FindFirstChild(_d({63,86,83,89,82},19))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({47,78,91,81,86,97},19)
if lvl < 3 then
if quest == _d({59,92,91,82},19) then
acceptQuest(_d({49,78,93,85},19))
return
end
else
if quest == _d({59,92,91,82},19) then
acceptQuest(_d({64,78,95,78,85},19))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({47,78,91,81,86,97,13,47,92,96,96},19)
if quest == _d({59,92,91,82},19) then
acceptQuest(_d({63,92,91,91,102},19))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({47,98,102,78,79,89,82,54,97,82,90,96},19))
local shopItem = buyables and buyables:FindFirstChild(_d({63,86,83,89,82},19))
local shopPart = shopItem and shopItem:FindFirstChild(_d({64,85,92,93,61,78,95,97},19))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({61,95,92,101,86,90,86,97,102,61,95,92,90,93,97},19), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({72,63,86,83,89,82,13,61,98,95,80,85,78,96,82,74,13,83,86,95,82,93,95,92,101,86,90,86,97,102,93,95,92,90,93,97,13,91,92,97,13,96,98,93,93,92,95,97,82,81,13,79,102,13,82,101,82,80,98,97,92,95,14},19))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,63,86,83,89,82,13,93,98,95,80,85,78,96,82,81,14,13,64,97,78,95,97,82,95,13,54,96,89,78,91,81,13,93,95,92,84,95,82,96,96,86,92,91,13,80,92,90,93,89,82,97,82,81,27,13,68,78,86,97,86,91,84,13,83,92,95,13,51,86,96,85,90,78,91,13,48,78,99,82,13,97,95,78,99,82,89,13,93,85,78,96,82,27},19))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local weaponTool = bp and bp:FindFirstChild(_d({58,82,89,82,82},19))
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) and finalNpc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,48,89,82,78,91,82,81,13,98,93,13,93,95,82,99,86,92,98,96,13,96,82,96,96,86,92,91,27},19))
end
print(_d({72,52,82,93,92,13,52,95,86,91,81,82,95,74,13,46,98,97,92,90,78,97,82,81,13,96,80,95,86,93,97,13,89,92,78,81,82,81,27,13,61,95,82,96,96,13,20,61,20,13,97,92,13,97,92,84,84,89,82,13,78,98,97,92,13,83,78,95,90,27},19))
end)()