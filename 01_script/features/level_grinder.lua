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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local RunService = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({42,73,86,76,81,92},24)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({59,92,73,92,91},24)) and statsFolder.Stats:FindFirstChild(_d({52,77,94,77,84},24)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({59,92,73,92,91},24)) and statsFolder.Stats:FindFirstChild(_d({56,77,84,81},24)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({57,93,77,91,92},24)) and statsFolder.Quest:FindFirstChild(_d({43,93,90,90,77,86,92,57,93,77,91,92},24)) and statsFolder.Quest.CurrentQuest.Value or _d({54,87,86,77},24)
return lvl, peli, quest
end
return 1, 0, _d({54,87,86,77},24)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum = npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
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
if part:IsA(_d({42,73,91,77,56,73,90,92},24)) then
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
loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73},24)))()
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
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,71,47,22,45,73,91,97,60,90,73,94,77,84,8,81,91,8,85,81,91,91,81,86,79,22,8,56,84,77,73,91,77,8,77,86,91,93,90,77,8,77,73,91,97,71,92,90,73,94,77,84,22,84,93,73,8,81,91,8,90,93,86,86,81,86,79,8,78,81,90,91,92,22},24))
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
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({61,88,88,77,90,60,87,90,91,87},24))
if not torso then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
pcall(function()
loadstring(game:HttpGet(_d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,89,93,77,91,92,71,80,73,86,76,84,77,90,22,84,93,73},24)))()
end)
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,45,58,58,55,58,34,8,57,93,77,91,92,48,73,86,76,84,77,90,8,84,81,74,90,73,90,97,8,75,87,93,84,76,8,86,87,92,8,74,77,8,84,87,73,76,77,76,9},24))
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
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,41,93,92,87,8,78,73,90,85,8,92,87,79,79,84,77,76,8,92,87,34,8},24) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({58,81,78,84,77},24)) or LocalPlayer.Character:FindFirstChild(_d({58,81,78,84,77},24))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({42,73,86,76,81,92},24)
if lvl < 3 then
if quest == _d({54,87,86,77},24) then
acceptQuest(_d({44,73,88,80},24))
return
end
else
if quest == _d({54,87,86,77},24) then
acceptQuest(_d({59,73,90,73,80},24))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({42,73,86,76,81,92,8,42,87,91,91},24)
if quest == _d({54,87,86,77},24) then
acceptQuest(_d({58,87,86,86,97},24))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({42,93,97,73,74,84,77,49,92,77,85,91},24))
local shopItem = buyables and buyables:FindFirstChild(_d({58,81,78,84,77},24))
local shopPart = shopItem and shopItem:FindFirstChild(_d({59,80,87,88,56,73,90,92},24))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({56,90,87,96,81,85,81,92,97,56,90,87,85,88,92},24), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({67,58,81,78,84,77,8,56,93,90,75,80,73,91,77,69,8,78,81,90,77,88,90,87,96,81,85,81,92,97,88,90,87,85,88,92,8,86,87,92,8,91,93,88,88,87,90,92,77,76,8,74,97,8,77,96,77,75,93,92,87,90,9},24))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,58,81,78,84,77,8,88,93,90,75,80,73,91,77,76,9,8,59,92,73,90,92,77,90,8,49,91,84,73,86,76,8,88,90,87,79,90,77,91,91,81,87,86,8,75,87,85,88,84,77,92,77,76,22,8,63,73,81,92,81,86,79,8,78,87,90,8,46,81,91,80,85,73,86,8,43,73,94,77,8,92,90,73,94,77,84,8,88,80,73,91,77,22},24))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
local weaponTool = bp and bp:FindFirstChild(_d({53,77,84,77,77},24))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if npcRoot and npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and npc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)) and finalNpc:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({54,56,43,91},24))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,43,84,77,73,86,77,76,8,93,88,8,88,90,77,94,81,87,93,91,8,91,77,91,91,81,87,86,22},24))
end
print(_d({67,47,77,88,87,8,47,90,81,86,76,77,90,69,8,41,93,92,87,85,73,92,77,76,8,91,75,90,81,88,92,8,84,87,73,76,77,76,22,8,56,90,77,91,91,8,15,56,15,8,92,87,8,92,87,79,79,84,77,8,73,93,92,87,8,78,73,90,85,22},24))
end)()