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
local Players = game:GetService(_d({57,85,74,98,78,91,92},23))
local ReplicatedStorage = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local RunService = game:GetService(_d({59,94,87,60,78,91,95,82,76,78},23))
local VIM = game:GetService(_d({63,82,91,93,94,74,85,50,87,89,94,93,54,74,87,74,80,78,91},23))
local UserInputService = game:GetService(_d({62,92,78,91,50,87,89,94,93,60,78,91,95,82,76,78},23))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({43,74,87,77,82,93},23)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({60,93,74,93,92},23) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({60,93,74,93,92},23)) and statsFolder.Stats:FindFirstChild(_d({53,78,95,78,85},23)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({60,93,74,93,92},23)) and statsFolder.Stats:FindFirstChild(_d({57,78,85,82},23)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({58,94,78,92,93},23)) and statsFolder.Quest:FindFirstChild(_d({44,94,91,91,78,87,93,58,94,78,92,93},23)) and statsFolder.Quest.CurrentQuest.Value or _d({55,88,87,78},23)
return lvl, peli, quest
end
return 1, 0, _d({55,88,87,78},23)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
local hum = npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23))
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
if part:IsA(_d({43,74,92,78,57,74,91,93},23)) then
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
importLib(_d({85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74},23))
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
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,72,48,23,46,74,92,98,61,91,74,95,78,85,9,82,92,9,86,82,92,92,82,87,80,23,9,57,85,78,74,92,78,9,78,87,92,94,91,78,9,78,74,92,98,72,93,91,74,95,78,85,23,85,94,74,9,82,92,9,91,94,87,87,82,87,80,9,79,82,91,92,93,23},23))
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
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({62,89,89,78,91,61,88,91,92,88},23))
if not torso then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
importLib(_d({85,82,75,24,90,94,78,92,93,72,81,74,87,77,85,78,91,23,85,94,74},23), _d({81,93,93,89,92,35,24,24,91,74,96,23,80,82,93,81,94,75,94,92,78,91,76,88,87,93,78,87,93,23,76,88,86,24,91,88,76,84,98,97,96,74,85,85,24,85,94,74,94,22,76,88,77,78,24,86,74,82,87,24,25,26,72,92,76,91,82,89,93,24,85,82,75,24,90,94,78,92,93,72,81,74,87,77,85,78,91,23,85,94,74},23))
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,46,59,59,56,59,35,9,58,94,78,92,93,49,74,87,77,85,78,91,9,85,82,75,91,74,91,98,9,76,88,94,85,77,9,87,88,93,9,75,78,9,85,88,74,77,78,77,10},23))
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
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,42,94,93,88,9,79,74,91,86,9,93,88,80,80,85,78,77,9,93,88,35,9},23) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({59,82,79,85,78},23)) or LocalPlayer.Character:FindFirstChild(_d({59,82,79,85,78},23))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({43,74,87,77,82,93},23)
if lvl < 3 then
if quest == _d({55,88,87,78},23) then
acceptQuest(_d({45,74,89,81},23))
return
end
else
if quest == _d({55,88,87,78},23) then
acceptQuest(_d({60,74,91,74,81},23))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({43,74,87,77,82,93,9,43,88,92,92},23)
if quest == _d({55,88,87,78},23) then
acceptQuest(_d({59,88,87,87,98},23))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({43,94,98,74,75,85,78,50,93,78,86,92},23))
local shopItem = buyables and buyables:FindFirstChild(_d({59,82,79,85,78},23))
local shopPart = shopItem and shopItem:FindFirstChild(_d({60,81,88,89,57,74,91,93},23))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({57,91,88,97,82,86,82,93,98,57,91,88,86,89,93},23), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({68,59,82,79,85,78,9,57,94,91,76,81,74,92,78,70,9,79,82,91,78,89,91,88,97,82,86,82,93,98,89,91,88,86,89,93,9,87,88,93,9,92,94,89,89,88,91,93,78,77,9,75,98,9,78,97,78,76,94,93,88,91,10},23))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,59,82,79,85,78,9,89,94,91,76,81,74,92,78,77,10,9,60,93,74,91,93,78,91,9,50,92,85,74,87,77,9,89,91,88,80,91,78,92,92,82,88,87,9,76,88,86,89,85,78,93,78,77,23,9,64,74,82,93,82,87,80,9,79,88,91,9,47,82,92,81,86,74,87,9,44,74,95,78,9,93,91,74,95,78,85,9,89,81,74,92,78,23},23))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({43,74,76,84,89,74,76,84},23))
local weaponTool = bp and bp:FindFirstChild(_d({54,78,85,78,78},23))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if npcRoot and npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and npc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({49,94,86,74,87,88,82,77,59,88,88,93,57,74,91,93},23))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)) and finalNpc:FindFirstChildWhichIsA(_d({49,94,86,74,87,88,82,77},23)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({55,57,44,92},23))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,44,85,78,74,87,78,77,9,94,89,9,89,91,78,95,82,88,94,92,9,92,78,92,92,82,88,87,23},23))
end
print(_d({68,48,78,89,88,9,48,91,82,87,77,78,91,70,9,42,94,93,88,86,74,93,78,77,9,92,76,91,82,89,93,9,85,88,74,77,78,77,23,9,57,91,78,92,92,9,16,57,16,9,93,88,9,93,88,80,80,85,78,9,74,94,93,88,9,79,74,91,86,23},23))
end)()