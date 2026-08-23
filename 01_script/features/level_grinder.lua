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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({40,71,84,74,79,90},26)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({57,90,71,90,89},26)) and statsFolder.Stats:FindFirstChild(_d({50,75,92,75,82},26)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({57,90,71,90,89},26)) and statsFolder.Stats:FindFirstChild(_d({54,75,82,79},26)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({55,91,75,89,90},26)) and statsFolder.Quest:FindFirstChild(_d({41,91,88,88,75,84,90,55,91,75,89,90},26)) and statsFolder.Quest.CurrentQuest.Value or _d({52,85,84,75},26)
return lvl, peli, quest
end
return 1, 0, _d({52,85,84,75},26)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = npc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
if part:IsA(_d({40,71,89,75,54,71,88,90},26)) then
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
importLib(_d({82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26), _d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71},26))
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
warn(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,69,45,20,43,71,89,95,58,88,71,92,75,82,6,79,89,6,83,79,89,89,79,84,77,20,6,54,82,75,71,89,75,6,75,84,89,91,88,75,6,75,71,89,95,69,90,88,71,92,75,82,20,82,91,71,6,79,89,6,88,91,84,84,79,84,77,6,76,79,88,89,90,20},26))
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
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({59,86,86,75,88,58,85,88,89,85},26))
if not torso then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
importLib(_d({82,79,72,21,87,91,75,89,90,69,78,71,84,74,82,75,88,20,82,91,71},26), _d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,87,91,75,89,90,69,78,71,84,74,82,75,88,20,82,91,71},26))
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,43,56,56,53,56,32,6,55,91,75,89,90,46,71,84,74,82,75,88,6,82,79,72,88,71,88,95,6,73,85,91,82,74,6,84,85,90,6,72,75,6,82,85,71,74,75,74,7},26))
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
print(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,39,91,90,85,6,76,71,88,83,6,90,85,77,77,82,75,74,6,90,85,32,6},26) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({56,79,76,82,75},26)) or LocalPlayer.Character:FindFirstChild(_d({56,79,76,82,75},26))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({40,71,84,74,79,90},26)
if lvl < 3 then
if quest == _d({52,85,84,75},26) then
acceptQuest(_d({42,71,86,78},26))
return
end
else
if quest == _d({52,85,84,75},26) then
acceptQuest(_d({57,71,88,71,78},26))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({40,71,84,74,79,90,6,40,85,89,89},26)
if quest == _d({52,85,84,75},26) then
acceptQuest(_d({56,85,84,84,95},26))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({40,91,95,71,72,82,75,47,90,75,83,89},26))
local shopItem = buyables and buyables:FindFirstChild(_d({56,79,76,82,75},26))
local shopPart = shopItem and shopItem:FindFirstChild(_d({57,78,85,86,54,71,88,90},26))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({54,88,85,94,79,83,79,90,95,54,88,85,83,86,90},26), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({65,56,79,76,82,75,6,54,91,88,73,78,71,89,75,67,6,76,79,88,75,86,88,85,94,79,83,79,90,95,86,88,85,83,86,90,6,84,85,90,6,89,91,86,86,85,88,90,75,74,6,72,95,6,75,94,75,73,91,90,85,88,7},26))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,56,79,76,82,75,6,86,91,88,73,78,71,89,75,74,7,6,57,90,71,88,90,75,88,6,47,89,82,71,84,74,6,86,88,85,77,88,75,89,89,79,85,84,6,73,85,83,86,82,75,90,75,74,20,6,61,71,79,90,79,84,77,6,76,85,88,6,44,79,89,78,83,71,84,6,41,71,92,75,6,90,88,71,92,75,82,6,86,78,71,89,75,20},26))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
local weaponTool = bp and bp:FindFirstChild(_d({51,75,82,75,75},26))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if npcRoot and npc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)) and npc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)) and finalNpc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)) and finalNpc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,41,82,75,71,84,75,74,6,91,86,6,86,88,75,92,79,85,91,89,6,89,75,89,89,79,85,84,20},26))
end
print(_d({65,45,75,86,85,6,45,88,79,84,74,75,88,67,6,39,91,90,85,83,71,90,75,74,6,89,73,88,79,86,90,6,82,85,71,74,75,74,20,6,54,88,75,89,89,6,13,54,13,6,90,85,6,90,85,77,77,82,75,6,71,91,90,85,6,76,71,88,83,20},26))
end)()