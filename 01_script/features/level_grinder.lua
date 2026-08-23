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
local Players = game:GetService(_d({42,70,59,83,63,76,77},38))
local ReplicatedStorage = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local RunService = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local VIM = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local UserInputService = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({28,59,72,62,67,78},38)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({45,78,59,78,77},38)) and statsFolder.Stats:FindFirstChild(_d({38,63,80,63,70},38)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({45,78,59,78,77},38)) and statsFolder.Stats:FindFirstChild(_d({42,63,70,67},38)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({43,79,63,77,78},38)) and statsFolder.Quest:FindFirstChild(_d({29,79,76,76,63,72,78,43,79,63,77,78},38)) and statsFolder.Quest.CurrentQuest.Value or _d({40,73,72,63},38)
return lvl, peli, quest
end
return 1, 0, _d({40,73,72,63},38)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum = npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
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
if part:IsA(_d({28,59,77,63,42,59,76,78},38)) then
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
loadstring(game:HttpGet(_d({66,78,78,74,77,20,9,9,76,59,81,8,65,67,78,66,79,60,79,77,63,76,61,73,72,78,63,72,78,8,61,73,71,9,76,73,61,69,83,82,81,59,70,70,9,70,79,59,79,7,61,73,62,63,9,71,59,67,72,9,10,11,57,77,61,76,67,74,78,9,64,63,59,78,79,76,63,77,9,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59},38)))()
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
warn(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,57,33,8,31,59,77,83,46,76,59,80,63,70,250,67,77,250,71,67,77,77,67,72,65,8,250,42,70,63,59,77,63,250,63,72,77,79,76,63,250,63,59,77,83,57,78,76,59,80,63,70,8,70,79,59,250,67,77,250,76,79,72,72,67,72,65,250,64,67,76,77,78,8},38))
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
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({47,74,74,63,76,46,73,76,77,73},38))
local prompt = torso and torso:FindFirstChild(_d({42,76,73,71,74,78},38))
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
warn(_d({53,43,79,63,77,78,250,27,61,61,63,74,78,59,72,61,63,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,63,82,63,61,79,78,73,76,251},38))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({42,70,59,83,63,76,33,79,67},38))
local chatGui = playerGui and playerGui:FindFirstChild(_d({40,42,29,29,34,27,46},38))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({65,73},38))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({63,72,62,29,66,59,78},38))
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
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,27,79,78,73,250,64,59,76,71,250,78,73,65,65,70,63,62,250,78,73,20,250},38) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({44,67,64,70,63},38)) or LocalPlayer.Character:FindFirstChild(_d({44,67,64,70,63},38))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({28,59,72,62,67,78},38)
if lvl < 3 then
if quest == _d({40,73,72,63},38) then
acceptQuest(_d({30,59,74,66},38))
return
end
else
if quest == _d({40,73,72,63},38) then
acceptQuest(_d({45,59,76,59,66},38))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({28,59,72,62,67,78,250,28,73,77,77},38)
if quest == _d({40,73,72,63},38) then
acceptQuest(_d({44,73,72,72,83},38))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({28,79,83,59,60,70,63,35,78,63,71,77},38))
local shopItem = buyables and buyables:FindFirstChild(_d({44,67,64,70,63},38))
local shopPart = shopItem and shopItem:FindFirstChild(_d({45,66,73,74,42,59,76,78},38))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({42,76,73,82,67,71,67,78,83,42,76,73,71,74,78},38), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({53,44,67,64,70,63,250,42,79,76,61,66,59,77,63,55,250,64,67,76,63,74,76,73,82,67,71,67,78,83,74,76,73,71,74,78,250,72,73,78,250,77,79,74,74,73,76,78,63,62,250,60,83,250,63,82,63,61,79,78,73,76,251},38))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,44,67,64,70,63,250,74,79,76,61,66,59,77,63,62,251,250,45,78,59,76,78,63,76,250,35,77,70,59,72,62,250,74,76,73,65,76,63,77,77,67,73,72,250,61,73,71,74,70,63,78,63,62,8,250,49,59,67,78,67,72,65,250,64,73,76,250,32,67,77,66,71,59,72,250,29,59,80,63,250,78,76,59,80,63,70,250,74,66,59,77,63,8},38))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
local weaponTool = bp and bp:FindFirstChild(_d({39,63,70,63,63},38))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if npcRoot and npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and npc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)) and finalNpc:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({40,42,29,77},38))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,29,70,63,59,72,63,62,250,79,74,250,74,76,63,80,67,73,79,77,250,77,63,77,77,67,73,72,8},38))
end
print(_d({53,33,63,74,73,250,33,76,67,72,62,63,76,55,250,27,79,78,73,71,59,78,63,62,250,77,61,76,67,74,78,250,70,73,59,62,63,62,8,250,42,76,63,77,77,250,1,42,1,250,78,73,250,78,73,65,65,70,63,250,59,79,78,73,250,64,59,76,71,8},38))
end)()