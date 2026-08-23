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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({39,70,83,73,78,89},27)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({56,89,70,89,88},27)) and statsFolder.Stats:FindFirstChild(_d({49,74,91,74,81},27)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({56,89,70,89,88},27)) and statsFolder.Stats:FindFirstChild(_d({53,74,81,78},27)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({54,90,74,88,89},27)) and statsFolder.Quest:FindFirstChild(_d({40,90,87,87,74,83,89,54,90,74,88,89},27)) and statsFolder.Quest.CurrentQuest.Value or _d({51,84,83,74},27)
return lvl, peli, quest
end
return 1, 0, _d({51,84,83,74},27)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({51,53,40,88},27))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum = npc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
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
if part:IsA(_d({39,70,88,74,53,70,87,89},27)) then
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
loadstring(game:HttpGet(_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,81,90,70,90,18,72,84,73,74,20,82,70,78,83,20,21,22,68,88,72,87,78,85,89,20,75,74,70,89,90,87,74,88,20,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70},27)))()
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
warn(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,68,44,19,42,70,88,94,57,87,70,91,74,81,5,78,88,5,82,78,88,88,78,83,76,19,5,53,81,74,70,88,74,5,74,83,88,90,87,74,5,74,70,88,94,68,89,87,70,91,74,81,19,81,90,70,5,78,88,5,87,90,83,83,78,83,76,5,75,78,87,88,89,19},27))
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
local npcsFolder = Workspace:FindFirstChild(_d({51,53,40,88},27))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({58,85,85,74,87,57,84,87,88,84},27))
local prompt = torso and torso:FindFirstChild(_d({53,87,84,82,85,89},27))
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
warn(_d({64,54,90,74,88,89,5,38,72,72,74,85,89,70,83,72,74,66,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local chatGui = playerGui and playerGui:FindFirstChild(_d({51,53,40,40,45,38,57},27))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({76,84},27))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({74,83,73,40,77,70,89},27))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({19,19,19},27) then
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
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,38,90,89,84,5,75,70,87,82,5,89,84,76,76,81,74,73,5,89,84,31,5},27) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({55,78,75,81,74},27)) or LocalPlayer.Character:FindFirstChild(_d({55,78,75,81,74},27))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({39,70,83,73,78,89},27)
if lvl < 3 then
if quest == _d({51,84,83,74},27) then
acceptQuest(_d({41,70,85,77},27))
return
end
else
if quest == _d({51,84,83,74},27) then
acceptQuest(_d({56,70,87,70,77},27))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({39,70,83,73,78,89,5,39,84,88,88},27)
if quest == _d({51,84,83,74},27) then
acceptQuest(_d({55,84,83,83,94},27))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({39,90,94,70,71,81,74,46,89,74,82,88},27))
local shopItem = buyables and buyables:FindFirstChild(_d({55,78,75,81,74},27))
local shopPart = shopItem and shopItem:FindFirstChild(_d({56,77,84,85,53,70,87,89},27))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({53,87,84,93,78,82,78,89,94,53,87,84,82,85,89},27), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({64,55,78,75,81,74,5,53,90,87,72,77,70,88,74,66,5,75,78,87,74,85,87,84,93,78,82,78,89,94,85,87,84,82,85,89,5,83,84,89,5,88,90,85,85,84,87,89,74,73,5,71,94,5,74,93,74,72,90,89,84,87,6},27))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,55,78,75,81,74,5,85,90,87,72,77,70,88,74,73,6,5,56,89,70,87,89,74,87,5,46,88,81,70,83,73,5,85,87,84,76,87,74,88,88,78,84,83,5,72,84,82,85,81,74,89,74,73,19,5,60,70,78,89,78,83,76,5,75,84,87,5,43,78,88,77,82,70,83,5,40,70,91,74,5,89,87,70,91,74,81,5,85,77,70,88,74,19},27))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
local weaponTool = bp and bp:FindFirstChild(_d({50,74,81,74,74},27))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if npcRoot and npc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) and npc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) and finalNpc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)) and finalNpc:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({51,53,40,88},27))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,40,81,74,70,83,74,73,5,90,85,5,85,87,74,91,78,84,90,88,5,88,74,88,88,78,84,83,19},27))
end
print(_d({64,44,74,85,84,5,44,87,78,83,73,74,87,66,5,38,90,89,84,82,70,89,74,73,5,88,72,87,78,85,89,5,81,84,70,73,74,73,19,5,53,87,74,88,88,5,12,53,12,5,89,84,5,89,84,76,76,81,74,5,70,90,89,84,5,75,70,87,82,19},27))
end)()