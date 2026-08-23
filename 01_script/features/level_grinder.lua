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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local RunService = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({16,47,60,50,55,66},50)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({33,66,47,66,65},50)) and statsFolder.Stats:FindFirstChild(_d({26,51,68,51,58},50)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({33,66,47,66,65},50)) and statsFolder.Stats:FindFirstChild(_d({30,51,58,55},50)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({31,67,51,65,66},50)) and statsFolder.Quest:FindFirstChild(_d({17,67,64,64,51,60,66,31,67,51,65,66},50)) and statsFolder.Quest.CurrentQuest.Value or _d({28,61,60,51},50)
return lvl, peli, quest
end
return 1, 0, _d({28,61,60,51},50)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum = npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
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
if part:IsA(_d({16,47,65,51,30,47,64,66},50)) then
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
loadstring(game:HttpGet(_d({54,66,66,62,65,8,253,253,64,47,69,252,53,55,66,54,67,48,67,65,51,64,49,61,60,66,51,60,66,252,49,61,59,253,64,61,49,57,71,70,69,47,58,58,253,58,67,47,67,251,49,61,50,51,253,59,47,55,60,253,254,255,45,65,49,64,55,62,66,253,52,51,47,66,67,64,51,65,253,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47},50)))()
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
warn(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,45,21,252,19,47,65,71,34,64,47,68,51,58,238,55,65,238,59,55,65,65,55,60,53,252,238,30,58,51,47,65,51,238,51,60,65,67,64,51,238,51,47,65,71,45,66,64,47,68,51,58,252,58,67,47,238,55,65,238,64,67,60,60,55,60,53,238,52,55,64,65,66,252},50))
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
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({35,62,62,51,64,34,61,64,65,61},50))
local prompt = torso and torso:FindFirstChild(_d({30,64,61,59,62,66},50))
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
warn(_d({41,31,67,51,65,66,238,15,49,49,51,62,66,47,60,49,51,43,238,52,55,64,51,62,64,61,70,55,59,55,66,71,62,64,61,59,62,66,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,51,70,51,49,67,66,61,64,239},50))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
local chatGui = playerGui and playerGui:FindFirstChild(_d({28,30,17,17,22,15,34},50))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({53,61},50))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({51,60,50,17,54,47,66},50))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({252,252,252},50) then
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
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,15,67,66,61,238,52,47,64,59,238,66,61,53,53,58,51,50,238,66,61,8,238},50) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({32,55,52,58,51},50)) or LocalPlayer.Character:FindFirstChild(_d({32,55,52,58,51},50))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({16,47,60,50,55,66},50)
if lvl < 3 then
if quest == _d({28,61,60,51},50) then
acceptQuest(_d({18,47,62,54},50))
return
end
else
if quest == _d({28,61,60,51},50) then
acceptQuest(_d({33,47,64,47,54},50))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({16,47,60,50,55,66,238,16,61,65,65},50)
if quest == _d({28,61,60,51},50) then
acceptQuest(_d({32,61,60,60,71},50))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({16,67,71,47,48,58,51,23,66,51,59,65},50))
local shopItem = buyables and buyables:FindFirstChild(_d({32,55,52,58,51},50))
local shopPart = shopItem and shopItem:FindFirstChild(_d({33,54,61,62,30,47,64,66},50))
if shopPart then
local reached = navigateTo(shopPart.Position + Vector3.new(0, hoverHeight, 0))
if reached then
stopNavigation()
myRoot.CFrame = shopPart.CFrame + Vector3.new(0, 2, 0)
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({30,64,61,70,55,59,55,66,71,30,64,61,59,62,66},50), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({41,32,55,52,58,51,238,30,67,64,49,54,47,65,51,43,238,52,55,64,51,62,64,61,70,55,59,55,66,71,62,64,61,59,62,66,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,51,70,51,49,67,66,61,64,239},50))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,32,55,52,58,51,238,62,67,64,49,54,47,65,51,50,239,238,33,66,47,64,66,51,64,238,23,65,58,47,60,50,238,62,64,61,53,64,51,65,65,55,61,60,238,49,61,59,62,58,51,66,51,50,252,238,37,47,55,66,55,60,53,238,52,61,64,238,20,55,65,54,59,47,60,238,17,47,68,51,238,66,64,47,68,51,58,238,62,54,47,65,51,252},50))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
local weaponTool = bp and bp:FindFirstChild(_d({27,51,58,51,51},50))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if npcRoot and npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and npc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)) and finalNpc:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,17,58,51,47,60,51,50,238,67,62,238,62,64,51,68,55,61,67,65,238,65,51,65,65,55,61,60,252},50))
end
print(_d({41,21,51,62,61,238,21,64,55,60,50,51,64,43,238,15,67,66,61,59,47,66,51,50,238,65,49,64,55,62,66,238,58,61,47,50,51,50,252,238,30,64,51,65,65,238,245,30,245,238,66,61,238,66,61,53,53,58,51,238,47,67,66,61,238,52,47,64,59,252},50))
end)()