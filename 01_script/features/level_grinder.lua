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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = _d({7,38,51,41,46,57},59)
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild(_d({24,57,38,57,56},59)) and statsFolder.Stats:FindFirstChild(_d({17,42,59,42,49},59)) and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild(_d({24,57,38,57,56},59)) and statsFolder.Stats:FindFirstChild(_d({21,42,49,46},59)) and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild(_d({22,58,42,56,57},59)) and statsFolder.Quest:FindFirstChild(_d({8,58,55,55,42,51,57,22,58,42,56,57},59)) and statsFolder.Quest.CurrentQuest.Value or _d({19,52,51,42},59)
return lvl, peli, quest
end
return 1, 0, _d({19,52,51,42},59)
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum = npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
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
loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,43,42,38,57,58,55,42,56,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59)))()
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
warn(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,36,12,243,10,38,56,62,25,55,38,59,42,49,229,46,56,229,50,46,56,56,46,51,44,243,229,21,49,42,38,56,42,229,42,51,56,58,55,42,229,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38,229,46,56,229,55,58,51,51,46,51,44,229,43,46,55,56,57,243},59))
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
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({26,53,53,42,55,25,52,55,56,52},59))
local prompt = torso and torso:FindFirstChild(_d({21,55,52,50,53,57},59))
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
warn(_d({32,22,58,42,56,57,229,6,40,40,42,53,57,38,51,40,42,34,229,43,46,55,42,53,55,52,61,46,50,46,57,62,53,55,52,50,53,57,229,51,52,57,229,56,58,53,53,52,55,57,42,41,229,39,62,229,42,61,42,40,58,57,52,55,230},59))
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({21,49,38,62,42,55,12,58,46},59))
local chatGui = playerGui and playerGui:FindFirstChild(_d({19,21,8,8,13,6,25},59))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild(_d({44,52},59))
local endChatBtn = chatGui.Frame:FindFirstChild(_d({42,51,41,8,45,38,57},59))
if goBtn and goBtn.Visible and goBtn.Text ~= "" and goBtn.Text ~= _d({243,243,243},59) then
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
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,6,58,57,52,229,43,38,55,50,229,57,52,44,44,49,42,41,229,57,52,255,229},59) .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59)) or LocalPlayer.Character:FindFirstChild(_d({23,46,43,49,42},59))
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = _d({7,38,51,41,46,57},59)
if lvl < 3 then
if quest == _d({19,52,51,42},59) then
acceptQuest(_d({9,38,53,45},59))
return
end
else
if quest == _d({19,52,51,42},59) then
acceptQuest(_d({24,38,55,38,45},59))
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({7,38,51,41,46,57,229,7,52,56,56},59)
if quest == _d({19,52,51,42},59) then
acceptQuest(_d({23,52,51,51,62},59))
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild(_d({7,58,62,38,39,49,42,14,57,42,50,56},59))
local shopItem = buyables and buyables:FindFirstChild(_d({23,46,43,49,42},59))
local shopPart = shopItem and shopItem:FindFirstChild(_d({24,45,52,53,21,38,55,57},59))
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA(_d({21,55,52,61,46,50,46,57,62,21,55,52,50,53,57},59), true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({32,23,46,43,49,42,229,21,58,55,40,45,38,56,42,34,229,43,46,55,42,53,55,52,61,46,50,46,57,62,53,55,52,50,53,57,229,51,52,57,229,56,58,53,53,52,55,57,42,41,229,39,62,229,42,61,42,40,58,57,52,55,230},59))
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,23,46,43,49,42,229,53,58,55,40,45,38,56,42,41,230,229,24,57,38,55,57,42,55,229,14,56,49,38,51,41,229,53,55,52,44,55,42,56,56,46,52,51,229,40,52,50,53,49,42,57,42,41,243,229,28,38,46,57,46,51,44,229,43,52,55,229,11,46,56,45,50,38,51,229,8,38,59,42,229,57,55,38,59,42,49,229,53,45,38,56,42,243},59))
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
local weaponTool = bp and bp:FindFirstChild(_d({18,42,49,42,42},59))
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if npcRoot and npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and npc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if finalRoot and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) and finalNpc:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({19,21,8,56},59))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,8,49,42,38,51,42,41,229,58,53,229,53,55,42,59,46,52,58,56,229,56,42,56,56,46,52,51,243},59))
end
print(_d({32,12,42,53,52,229,12,55,46,51,41,42,55,34,229,6,58,57,52,50,38,57,42,41,229,56,40,55,46,53,57,229,49,52,38,41,42,41,243,229,21,55,42,56,56,229,236,21,236,229,57,52,229,57,52,44,44,49,42,229,38,58,57,52,229,43,38,55,50,243},59))
end)()