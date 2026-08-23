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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local RunService = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local UserInputService = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({29,60,73,63,68,79},37)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({46,79,60,79,78},37)) and statsFolder.Stats:FindFirstChild(_d({39,64,81,64,71},37)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({46,79,60,79,78},37)) and statsFolder.Stats:FindFirstChild(_d({43,64,71,68},37)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({44,80,64,78,79},37)) and statsFolder.Quest:FindFirstChild(_d({30,80,77,77,64,73,79,44,80,64,78,79},37)) and statsFolder.Quest.CurrentQuest.Value or _d({41,74,73,64},37)
return lvl, peli, quest
end
return 1, 0, _d({41,74,73,64},37)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum = npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
if part:IsA(_d({29,60,78,64,43,60,77,79},37)) then
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
importLib(_d({71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60},37))
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
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,58,34,9,32,60,78,84,47,77,60,81,64,71,251,68,78,251,72,68,78,78,68,73,66,9,251,43,71,64,60,78,64,251,64,73,78,80,77,64,251,64,60,78,84,58,79,77,60,81,64,71,9,71,80,60,251,68,78,251,77,80,73,73,68,73,66,251,65,68,77,78,79,9},37))
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
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({48,75,75,64,77,47,74,77,78,74},37))
if not torso then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
importLib(_d({71,68,61,10,76,80,64,78,79,58,67,60,73,63,71,64,77,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,76,80,64,78,79,58,67,60,73,63,71,64,77,9,71,80,60},37))
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,32,45,45,42,45,21,251,44,80,64,78,79,35,60,73,63,71,64,77,251,71,68,61,77,60,77,84,251,62,74,80,71,63,251,73,74,79,251,61,64,251,71,74,60,63,64,63,252},37))
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
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,28,80,79,74,251,65,60,77,72,251,79,74,66,66,71,64,63,251,79,74,21,251},37) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({45,68,65,71,64},37)) or LocalPlayer.Character:FindFirstChild(_d({45,68,65,71,64},37))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({29,60,73,63,68,79},37)
if lvl < 3 then
if quest == _d({41,74,73,64},37) then
acceptQuest(_d({31,60,75,67},37))
return
end
else
if quest == _d({41,74,73,64},37) then
acceptQuest(_d({46,60,77,60,67},37))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({29,60,73,63,68,79,251,29,74,78,78},37)
if quest == _d({41,74,73,64},37) then
acceptQuest(_d({45,74,73,73,84},37))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({29,80,84,60,61,71,64,36,79,64,72,78},37))
local shopItem = buyables and buyables:FindFirstChild(_d({45,68,65,71,64},37))
local shopPart = shopItem and shopItem:FindFirstChild(_d({46,67,74,75,43,60,77,79},37))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({43,77,74,83,68,72,68,79,84,43,77,74,72,75,79},37), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({54,45,68,65,71,64,251,43,80,77,62,67,60,78,64,56,251,65,68,77,64,75,77,74,83,68,72,68,79,84,75,77,74,72,75,79,251,73,74,79,251,78,80,75,75,74,77,79,64,63,251,61,84,251,64,83,64,62,80,79,74,77,252},37))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,45,68,65,71,64,251,75,80,77,62,67,60,78,64,63,252,251,46,79,60,77,79,64,77,251,36,78,71,60,73,63,251,75,77,74,66,77,64,78,78,68,74,73,251,62,74,72,75,71,64,79,64,63,9,251,50,60,68,79,68,73,66,251,65,74,77,251,33,68,78,67,72,60,73,251,30,60,81,64,251,79,77,60,81,64,71,251,75,67,60,78,64,9},37))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
local weaponTool = bp and bp:FindFirstChild(_d({40,64,71,64,64},37))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if npcRoot and npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and npc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)) and finalNpc:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({41,43,30,78},37))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,30,71,64,60,73,64,63,251,80,75,251,75,77,64,81,68,74,80,78,251,78,64,78,78,68,74,73,9},37))
end
print(_d({54,34,64,75,74,251,34,77,68,73,63,64,77,56,251,28,80,79,74,72,60,79,64,63,251,78,62,77,68,75,79,251,71,74,60,63,64,63,9,251,43,77,64,78,78,251,2,43,2,251,79,74,251,79,74,66,66,71,64,251,60,80,79,74,251,65,60,77,72,9},37))
end)()