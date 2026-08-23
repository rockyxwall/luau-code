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
local Players = game:GetService(_d({55,83,72,96,76,89,90},25))
local ReplicatedStorage = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local RunService = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local VIM = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local UserInputService = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({41,72,85,75,80,91},25)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({58,91,72,91,90},25) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({58,91,72,91,90},25)) and statsFolder.Stats:FindFirstChild(_d({51,76,93,76,83},25)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({58,91,72,91,90},25)) and statsFolder.Stats:FindFirstChild(_d({55,76,83,80},25)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({56,92,76,90,91},25)) and statsFolder.Quest:FindFirstChild(_d({42,92,89,89,76,85,91,56,92,76,90,91},25)) and statsFolder.Quest.CurrentQuest.Value or _d({53,86,85,76},25)
return lvl, peli, quest
end
return 1, 0, _d({53,86,85,76},25)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local hum = npc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
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
if part:IsA(_d({41,72,90,76,55,72,89,91},25)) then
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
importLib(_d({83,80,73,22,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72},25), _d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72},25))
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
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,70,46,21,44,72,90,96,59,89,72,93,76,83,7,80,90,7,84,80,90,90,80,85,78,21,7,55,83,76,72,90,76,7,76,85,90,92,89,76,7,76,72,90,96,70,91,89,72,93,76,83,21,83,92,72,7,80,90,7,89,92,85,85,80,85,78,7,77,80,89,90,91,21},25))
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
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({60,87,87,76,89,59,86,89,90,86},25))
if not torso then return false end
local flatPos = torso.Position + (torso.CFrame.LookVector * 4.0)
local groundY = (torso.Position.Y - 3.0)
if _G.EasyTravel and _G.EasyTravel.GetSurfaceY then
groundY = _G.EasyTravel.GetSurfaceY(flatPos, LocalPlayer.Character)
end
local targetPos = Vector3.new(flatPos.X, groundY, flatPos.Z)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if not _G.QuestHandler then
importLib(_d({83,80,73,22,88,92,76,90,91,70,79,72,85,75,83,76,89,21,83,92,72},25), _d({79,91,91,87,90,33,22,22,89,72,94,21,78,80,91,79,92,73,92,90,76,89,74,86,85,91,76,85,91,21,74,86,84,22,89,86,74,82,96,95,94,72,83,83,22,83,92,72,92,20,74,86,75,76,22,84,72,80,85,22,23,24,70,90,74,89,80,87,91,22,83,80,73,22,88,92,76,90,91,70,79,72,85,75,83,76,89,21,83,92,72},25))
end
if _G.QuestHandler then
return _G.QuestHandler.AcceptQuest(npcName)
else
warn(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,44,57,57,54,57,33,7,56,92,76,90,91,47,72,85,75,83,76,89,7,83,80,73,89,72,89,96,7,74,86,92,83,75,7,85,86,91,7,73,76,7,83,86,72,75,76,75,8},25))
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
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,40,92,91,86,7,77,72,89,84,7,91,86,78,78,83,76,75,7,91,86,33,7},25) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({57,80,77,83,76},25)) or LocalPlayer.Character:FindFirstChild(_d({57,80,77,83,76},25))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({41,72,85,75,80,91},25)
if lvl < 3 then
if quest == _d({53,86,85,76},25) then
acceptQuest(_d({43,72,87,79},25))
return
end
else
if quest == _d({53,86,85,76},25) then
acceptQuest(_d({58,72,89,72,79},25))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({41,72,85,75,80,91,7,41,86,90,90},25)
if quest == _d({53,86,85,76},25) then
acceptQuest(_d({57,86,85,85,96},25))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({41,92,96,72,73,83,76,48,91,76,84,90},25))
local shopItem = buyables and buyables:FindFirstChild(_d({57,80,77,83,76},25))
local shopPart = shopItem and shopItem:FindFirstChild(_d({58,79,86,87,55,72,89,91},25))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({55,89,86,95,80,84,80,91,96,55,89,86,84,87,91},25), true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({66,57,80,77,83,76,7,55,92,89,74,79,72,90,76,68,7,77,80,89,76,87,89,86,95,80,84,80,91,96,87,89,86,84,87,91,7,85,86,91,7,90,92,87,87,86,89,91,76,75,7,73,96,7,76,95,76,74,92,91,86,89,8},25))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,57,80,77,83,76,7,87,92,89,74,79,72,90,76,75,8,7,58,91,72,89,91,76,89,7,48,90,83,72,85,75,7,87,89,86,78,89,76,90,90,80,86,85,7,74,86,84,87,83,76,91,76,75,21,7,62,72,80,91,80,85,78,7,77,86,89,7,45,80,90,79,84,72,85,7,42,72,93,76,7,91,89,72,93,76,83,7,87,79,72,90,76,21},25))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
local weaponTool = bp and bp:FindFirstChild(_d({52,76,83,76,76},25))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if npcRoot and npc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)) and npc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)) and finalNpc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)) and finalNpc:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({53,55,42,90},25))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,42,83,76,72,85,76,75,7,92,87,7,87,89,76,93,80,86,92,90,7,90,76,90,90,80,86,85,21},25))
end
print(_d({66,46,76,87,86,7,46,89,80,85,75,76,89,68,7,40,92,91,86,84,72,91,76,75,7,90,74,89,80,87,91,7,83,86,72,75,76,75,21,7,55,89,76,90,90,7,14,55,14,7,91,86,7,91,86,78,78,83,76,7,72,92,91,86,7,77,72,89,84,21},25))
end)()