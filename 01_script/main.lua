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
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({52,80,69,93,73,86,87},28))
local UserInputService    = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local RunService          = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local VIM                 = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local ReplicatedStorage    = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
local HOVER_OFFSET   = 10.3
local HOVER_YVEL     = 120
local XZ_SPEED       = 5
local XZ_THRESHOLD   = 3
local Y_THRESHOLD    = 1.5
local TOGGLE_KEY     = Enum.KeyCode.P
local MELEE_CLICK_INTERVAL = 0.2
local ARROW_HOVER_OFFSET   = 10
local ARROW_HOVER_WAIT     = 30
local ARROW_DODGE_DISTANCE = 40
local ARROW_DODGE_INTERVAL = 0.5
local LEO_PILLAR_ANIM_ID   = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,25,22,24,24,21,24,21,23,22,27},28)
local LEO_ENTEI_ANIM_ID    = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,25,22,24,24,21,23,28,22,27,28},28)
local LEO_HIKEN_ANIM_ID    = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,25,22,22,20,29,21,27,24,20,27},28)
local LEO_FIREFLY_ANIM_ID  = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,25,22,22,20,22,23,26,21,25,24},28)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({51,70,78,73,71,88,77,90,73,87},28)
local OBJECTIVES_WAIT_MAX   = 60
local BUSO_CHECK_INTERVAL  = 1
local KEN_CHECK_INTERVAL   = 1
local GEPPO_CLIMB_THRESHOLD = 10
local GEPPO_HOLD_INTERVAL   = 2
local COMBAT_LOCK_MAX_SNAP  = 10
local UNSTUCK_CHECK_INTERVAL  = 1
local UNSTUCK_MOVE_THRESHOLD  = 5
local UNSTUCK_STUCK_TICKS     = 10
local UNSTUCK_COOLDOWN        = 8
local COORDS = {
Stage1       = Vector3.new(557.1764526367188, 310.18902587890625, -2282.130126953125),
Stage2       = Vector3.new(514.002197265625, 320.0939025878906, -2755.223876953125),
Stage3       = Vector3.new(-213.13096618652344, 376.07440185546875, -2699.046142578125),
Stage3B      = Vector3.new(-915.4906616210938, 435.0939636230469, -2743.846923828125),
ArrowFlyDown = Vector3.new(-1071.06884765625, 444.2209167480469, -3205.72412109375),
Stage4       = Vector3.new(-1089.56494140625, 452.1291198730469, -3590.454833984375),
Leo          = Vector3.new(-1092.56298828125, 506.0744462890625, -4248.216796875),
Queen        = Vector3.new(-1098.1424560546875, 666.206787109375, -5066.43603515625),
Statue1      = Vector3.new(-902.9956665039062, 670.851867675757812, -5307.0703125),
Statue2      = Vector3.new(-1089.46533203125, 671.2554931640625, -5410.2470703125),
Statue3      = Vector3.new(-1304.9073486328125, 666.7710571289062, -5306.22705078125),
PostQueen    = Vector3.new(-1096.88134765625, 672.9217529296875, -5380.06396484375),
}
local REPLAY_BUTTON_VALUE   = _d({54,73,84,80,69,93},28)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({81,83,90,73},28)
local NavState   = {mode = _d({77,72,80,73},28)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({63,38,83,87,87,38,83,88,65},28), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end)
if ok then return root end
debug(_d({75,73,88,54,83,83,88,4,73,86,86,83,86,30},28), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
end)
if ok then return hum end
debug(_d({75,73,88,44,89,81,69,82,83,77,72,4,73,86,86,83,86,30},28), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({67,67,44,83,90,73,86,37,88,88},28)) or Instance.new(_d({37,88,88,69,71,76,81,73,82,88},28))
att.Name = _d({67,67,44,83,90,73,86,37,88,88},28)
att.Parent = root
local force = root:FindFirstChild(_d({67,67,44,83,90,73,86,42,83,86,71,73},28))
if not force then
force = Instance.new(_d({48,77,82,73,69,86,58,73,80,83,71,77,88,93},28))
force.Name = _d({67,67,44,83,90,73,86,42,83,86,71,73},28)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then return result end
debug(_d({75,73,88,51,86,39,86,73,69,88,73,42,83,86,71,73,4,73,86,86,83,86,30},28), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not root then return end
local force = root:FindFirstChild(_d({67,67,44,83,90,73,86,42,83,86,71,73},28))
local att   = root:FindFirstChild(_d({67,67,44,83,90,73,86,37,88,88},28))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({71,80,73,69,82,89,84,42,83,86,71,73,4,73,86,86,83,86,30},28), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({38,89,87,83,49,73,80,73,73},28)) ~= nil
end)
if ok then return result end
debug(_d({77,87,38,89,87,83,37,71,88,77,90,73,4,73,86,86,83,86,30},28), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({38,89,87,83},28))
end)
if not ok then debug(_d({69,71,88,77,90,69,88,73,38,89,87,83,4,73,86,86,83,86,30},28), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({38,89,87,83,4,82,83,88,4,69,71,88,77,90,73,16,4,69,71,88,77,90,69,88,77,82,75},28))
activateBuso()
end
end)
if not ok then debug(_d({38,89,87,83,47,73,73,84,73,86,4,73,86,86,83,86,30},28), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({38,89,87,83,4,79,73,73,84,73,86,4,87,88,83,84,84,73,72},28))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({47,73,82,44,69,79,77},28)) ~= nil
end)
if ok then return result end
debug(_d({77,87,47,73,82,37,71,88,77,90,73,4,73,86,86,83,86,30},28), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({47,73,82},28), true)
end)
if not ok then debug(_d({69,71,88,77,90,69,88,73,47,73,82,4,73,86,86,83,86,30},28), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({47,73,82,4,82,83,88,4,69,71,88,77,90,73,16,4,69,71,88,77,90,69,88,77,82,75},28))
activateKen()
end
end)
if not ok then debug(_d({47,73,82,47,73,73,84,73,86,4,73,86,86,83,86,30},28), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({47,73,82,4,79,73,73,84,73,86,4,87,88,83,84,84,73,72},28))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({50,52,39,87},28)) end)
if ok then return folder end
debug(_d({75,73,88,50,52,39,87,42,83,80,72,73,86,4,73,86,86,83,86,30},28), folder)
return nil
end
local function getNearestNPC(exclude)
local ok, result = pcall(function()
local root = Core.GetRoot(LocalPlayer)
local folder = getNPCsFolder()
if not root or not folder then return nil end
local nearest, nearestDist = nil, math.huge
local fallbackNearest, fallbackDist = nil, math.huge
for _, model in ipairs(folder:GetChildren()) do
local okp, info = pcall(function()
local r = model:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local h = model:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if r and h and h.Health > 0 then return {root = r, humanoid = h, model = model} end
return nil
end)
if okp and info then
local dist = (info.root.Position - root.Position).Magnitude
if dist < fallbackDist then fallbackDist, fallbackNearest = dist, info end
if dist < nearestDist and not (exclude and exclude[model]) then
nearestDist, nearest = dist, info
end
end
end
return nearest or fallbackNearest
end)
if ok then return result end
debug(_d({75,73,88,50,73,69,86,73,87,88,50,52,39,4,73,86,86,83,86,30},28), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hum  = model:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({75,73,88,50,52,39,38,93,50,69,81,73,4,73,86,86,83,86,30},28), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({82,84,71,87,54,73,81,69,77,82,77,82,75,4,73,86,86,83,86,30},28), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({39,89,84,77,72,4,53,89,73,73,82},28))
return queen ~= nil and queen:FindFirstChild(_d({81,83,88,77,83,82,48,73,87,87},28)) ~= nil
end)
if ok then return result end
debug(_d({77,87,53,89,73,73,82,52,76,69,87,73,22,4,73,86,86,83,86,30},28), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,21,22,21,22,29,27,29,24,22,22,29,22,27,26,29},28)
local QUEEN_GRASP_ANIM_ID   = _d({86,70,92,69,87,87,73,88,77,72,30,19,19,21,22,29,28,20,20,20,26,21,20,20,21,27,23,24},28)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if not hum then return false end
for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
local animId = track.Animation and track.Animation.AnimationId
for _, id in ipairs(animList) do
if animId == id then
return true, id
end
end
end
return false
end)
if ok then return result, which end
debug(_d({77,87,52,80,69,93,77,82,75,37,82,77,81,42,86,83,81,48,77,87,88,4,73,86,86,83,86,30},28), result)
return false
end
local function isCastingDodgeSkill(npcModel)
return isPlayingAnimFromList(npcModel, LEO_DODGE_ANIMS)
end
local function isQueenCastingBlockableSkill(npcModel)
return isPlayingAnimFromList(npcModel, QUEEN_BLOCK_ANIMS)
end
local function isNPCBlocking(npcModel)
local ok, result = pcall(function()
return npcModel ~= nil and npcModel:FindFirstChild(_d({38,80,83,71,79,77,82,75},28)) ~= nil
end)
if ok then return result end
debug(_d({77,87,50,52,39,38,80,83,71,79,77,82,75,4,73,86,86,83,86,30},28), result)
return false
end
local NPC_PREDICT_LOOKAHEAD = 0.15
local NPC_PREDICT_MAX_LEAD  = 12
local function predictNPCPosition(info)
local ok, result = pcall(function()
local vel = info.root.AssemblyLinearVelocity
local flatVel = Vector3.new(vel.X, 0, vel.Z)
local lead = flatVel * NPC_PREDICT_LOOKAHEAD
if lead.Magnitude > NPC_PREDICT_MAX_LEAD then
lead = lead.Unit * NPC_PREDICT_MAX_LEAD
end
return info.root.Position + lead
end)
if ok then return result end
debug(_d({84,86,73,72,77,71,88,50,52,39,52,83,87,77,88,77,83,82,4,73,86,86,83,86,30},28), result)
return info.root.Position
end
local NPC_STUCK_TIMEOUT = 10
local npcDamageTracker  = setmetatable({}, {__mode = "k"})
local stuckNPCs         = setmetatable({}, {__mode = "k"})
local function trackNPCDamage(info)
local ok, err = pcall(function()
local model = info.model
local hp = info.humanoid.Health
local tracked = npcDamageTracker[model]
if not tracked or tracked.lastHP ~= hp then
npcDamageTracker[model] = {lastHP = hp, since = tick()}
stuckNPCs[model] = nil
return
end
if not stuckNPCs[model] and tick() - tracked.since > NPC_STUCK_TIMEOUT then
debug(_d({50,83,4,72,69,81,69,75,73,4,83,82},28), model.Name, _d({74,83,86},28), NPC_STUCK_TIMEOUT, _d({87,4,17,4,87,91,77,88,71,76,77,82,75,4,88,69,86,75,73,88},28))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({88,86,69,71,79,50,52,39,40,69,81,69,75,73,4,73,86,86,83,86,30},28), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({49,83,72,73,80},28)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({38,69,87,73,52,69,86,88},28)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({75,73,88,49,83,72,73,80,42,69,71,73,52,83,87,4,73,86,86,83,86,30},28), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({41,82,90},28))
local folder = env and env:FindFirstChild(_d({55,88,69,88,89,73,87},28))
if not folder then return nil end
local nearest, nearestDist = nil, math.huge
for _, m in ipairs(folder:GetChildren()) do
local okp, mpos = pcall(getModelFacePos, m)
if okp and mpos then
local dist = (mpos - coordPos).Magnitude
if dist < nearestDist then nearestDist, nearest = dist, m end
end
end
return nearest
end)
if ok then return result end
debug(_d({75,73,88,55,88,69,88,89,73,49,83,72,73,80,50,73,69,86,4,73,86,86,83,86,30},28), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({70,69,86,86,73,80,44,52},28))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({75,73,88,55,88,69,88,89,73,44,52,4,73,86,86,83,86,30},28), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({56,83,83,80},28)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({74,77,82,72,56,83,83,80,38,93,37,88,88,86,77,70,89,88,73,4,73,86,86,83,86,30},28), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({56,83,83,80},28)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({74,77,82,72,56,83,83,80,38,93,50,69,81,73,4,73,86,86,83,86,30},28), tool)
return nil
end
local function equipTool(tool)
if not tool then return false end
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if tool.Parent == char then return end
local hum = getHumanoid()
if not hum then return end
hum:EquipTool(tool)
end)
if not ok then debug(_d({73,85,89,77,84,56,83,83,80,4,73,86,86,83,86,30},28), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({56,83,83,80},28)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({74,77,82,72,56,83,83,80,38,93,39,76,77,80,72,50,69,81,73,4,73,86,86,83,86,30},28), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({55,91,83,86,72,41,85,89,77,84},28))
if sword then
equipTool(sword)
return _d({87,91,83,86,72},28)
end
local melee = findToolByAttribute(_d({49,73,80,73,73,56,83,83,80},28))
if melee then
equipTool(melee)
return _d({81,73,80,73,73},28)
end
debug(_d({50,83,4,87,91,83,86,72,4,83,86,4,81,73,80,73,73,4,88,83,83,80,4,74,83,89,82,72},28))
return nil
end
local function clickM1(holdTime)
local ok, err = pcall(function()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(holdTime or 0.05)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
if not ok then debug(_d({71,80,77,71,79,49,21,4,73,86,86,83,86,30},28), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({54,83,79,89,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,73,84,84,83},28), args)
elseif style == _d({38,80,69,71,79,48,73,75},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79},28), args)
elseif style == _d({47,69,81,77,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,69,81,77,87,76,77,79,77,43,73,84,84,83},28), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79,22},28), args)
end
end)
if not ok then debug(_d({77,82,90,83,79,73,43,73,84,84,83,4,73,86,86,83,86,30},28), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({84,86,73,87,87,55,79,77,80,80,54,4,73,86,86,83,86,30},28), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({76,83,80,72,38,80,83,71,79,4,73,86,86,83,86,30},28), err) end
end
local function holdBlockWhile(conditionFn, timeout)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local t = 0
while enabled and conditionFn() and t < (timeout or 5) do
task.wait(0.1)
t += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({76,83,80,72,38,80,83,71,79,59,76,77,80,73,4,73,86,86,83,86,30},28), err) end
end
local function getGameG()
local ok, result = pcall(function()
if getrenv then
local renv = getrenv()
return renv and renv._G
end
return nil
end)
if ok then return result end
debug(_d({75,73,88,43,69,81,73,43,4,73,86,86,83,86,30},28), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({77,87,54,73,69,80,49,21,38,89,87,93,4,73,86,86,83,86,30},28), result)
return false
end
local prevM1Busy = false
local function pollM1Completed()
local busy = isRealM1Busy()
local completed = prevM1Busy and not busy
prevM1Busy = busy
return completed
end
local function waitOrReact(duration, checkFn)
local t = 0
local step = 0.03
while enabled and t < duration do
if checkFn() then return true end
task.wait(step)
t += step
end
return checkFn()
end
local function isStunned()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({87,88,89,82},28)) ~= nil
end)
if ok then return result end
debug(_d({77,87,55,88,89,82,82,73,72,4,73,86,86,83,86,30},28), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({84,86,73,87,87,55,88,89,82,38,86,73,69,79,4,73,86,86,83,86,30},28), err) end
end
local function dodgeHold(duration)
local t = 0
local step = 0.1
while enabled and t < duration do
if isStunned() then
pressStunBreak()
end
task.wait(step)
t += step
end
end
local navToPoint, setNavNamed, disableBot
local function queenDodgeUntilSafe(getInfoFn)
local info = getInfoFn()
if not info then return end
local root = Core.GetRoot(LocalPlayer)
local myPos = root and root.Position or info.root.Position
local bossPos = info.root.Position
local flatDir = Vector3.new(myPos.X - bossPos.X, 0, myPos.Z - bossPos.Z)
if flatDir.Magnitude < 1 then flatDir = Vector3.new(1, 0, 0) end
local awayPoint = myPos + (flatDir.Unit * QUEEN_DODGE_DISTANCE)
awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)
navToPoint(awayPoint, true)
local t = 0
while enabled do
if isStunned() then pressStunBreak() end
info = getInfoFn()
if not info then
debug(_d({85,89,73,73,82,40,83,72,75,73,57,82,88,77,80,55,69,74,73,30,4,53,89,73,73,82,4,75,83,82,73,4,17,4,73,82,72,77,82,75,4,72,83,72,75,73,4,73,69,86,80,93},28))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({85,89,73,73,82,40,83,72,75,73,57,82,88,77,80,55,69,74,73,4,87,69,74,73,88,93,4,88,77,81,73,83,89,88},28))
break
end
end
end
local queenDodging = false
local queenWatcherStarted = false
local function startQueenDodgeWatcher()
if queenWatcherStarted then return end
queenWatcherStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
local info = getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({53,89,73,73,82,4,71,69,87,88,77,82,75,4,72,73,88,73,71,88,73,72,4,17,4,72,83,72,75,77,82,75,4,12,91,69,88,71,76,73,86,13},28))
queenDodgeUntilSafe(function() return getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28)) end)
if enabled and getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28)) then
setNavNamed(_d({39,89,84,77,72,4,53,89,73,73,82},28))
end
queenDodging = false
end
end)
if not ok then debug(_d({85,89,73,73,82,40,83,72,75,73,59,69,88,71,76,73,86,4,73,86,86,83,86,30},28), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({84,83,77,82,88},28) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({82,84,71},28) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({82,69,81,73,72},28) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({75,73,88,50,69,90,56,69,86,75,73,88,87,4,73,86,86,83,86,30},28), aimR)
return nil, nil
end
local function computeLookDownCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local COMBAT_LOCK_MODES = {npc = true, named = true}
local function computeLockedCFrame(root, aimPos, facePos)
local ok, result = pcall(function()
return computeLookDownCFrame(root, facePos) + (aimPos - root.Position)
end)
if ok then return result end
debug(_d({71,83,81,84,89,88,73,48,83,71,79,73,72,39,42,86,69,81,73,4,73,86,86,83,86,30},28), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({84,83,77,82,88},28), point = pos}
phase = _d({81,83,90,73},28)
end
function navToPoint(pos, skipExtraGeppo)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if root and pos.Y - root.Position.Y > GEPPO_CLIMB_THRESHOLD then
invokeGeppo()
if not skipExtraGeppo then
task.spawn(function()
for _ = 1, 2 do
task.wait(GEPPO_HOLD_INTERVAL)
invokeGeppo()
end
end)
end
end
end)
if not ok then debug(_d({82,69,90,56,83,52,83,77,82,88,4,75,73,84,84,83,4,71,76,73,71,79,4,73,86,86,83,86,30},28), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({82,84,71},28)}
phase = _d({81,83,90,73},28)
end
function setNavNamed(name)
NavState = {mode = _d({82,69,81,73,72},28), name = name}
phase = _d({81,83,90,73},28)
end
local function setNavIdle()
NavState = {mode = _d({77,72,80,73},28)}
phase = _d({81,83,90,73},28)
end
local function hasArrived()
return phase == _d({76,83,90,73,86},28)
end
local function startNav()
phase = _d({81,83,90,73},28)
debug(_d({50,69,90,4,80,83,83,84,4,51,50},28))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({52,80,69,93,73,86,4,72,77,73,72,5,4,55,88,83,84,84,77,82,75,4,70,83,88,18},28))
disableBot()
return
end
local aim, face = getNavTargets()
if aim then
lastAim = aim
lastFace = face
else
aim = lastAim or root.Position
face = lastFace or aim
end
local pos    = root.Position
local yErr   = aim.Y - pos.Y
local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
if (pos - aim).Magnitude > 2000 then
debug(_d({52,80,69,93,73,86,4,77,87,4,88,83,83,4,74,69,86,4,74,86,83,81,4,88,69,86,75,73,88,4,12,34,22,20,20,20,4,87,88,89,72,87,13,18,4,48,77,79,73,80,93,4,86,73,87,84,69,91,82,73,72,4,69,88,4,80,83,70,70,93,18,4,55,88,83,84,84,77,82,75,4,70,83,88,18},28))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({67,67,84,86,73,90,52,83,87},28))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({48,69,86,75,73,4,84,83,87,77,88,77,83,82,4,78,89,81,84,4,72,73,88,73,71,88,73,72,30},28), delta, _d({87,88,89,72,87,18,4,84,86,73,90,52,83,87,33},28), prevPos, _d({82,73,91,52,83,87,33},28), pos)
end
end
force:SetAttribute(_d({67,67,84,86,73,90,52,83,87},28), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({81,83,90,73},28) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({76,83,90,73,86},28)
debug(_d({52,76,69,87,73,30,4,76,83,90,73,86},28))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({5,5,5,4,54,41,42,57,55,45,50,43,4,56,51,4,37,52,52,48,61,4,37,38,50,51,54,49,37,48,4,58,41,48,51,39,45,56,61,30},28), finalVel, _d({69,77,81,33},28), aim, _d({84,83,87,33},28), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({76,83,90,73,86},28) then
pcall(function()
if COMBAT_LOCK_MODES[NavState.mode] then
local snapDist = (aim - root.Position).Magnitude
if snapDist <= COMBAT_LOCK_MAX_SNAP then
local locked = computeLockedCFrame(root, aim, face)
if locked then
root.CFrame = locked
else
root.CFrame = computeLookDownCFrame(root, face)
end
else
debug(_d({39,83,81,70,69,88,4,80,83,71,79,4,87,79,77,84,84,73,72,16},28), snapDist, _d({87,88,89,72,87,4,74,86,83,81,4,88,69,86,75,73,88,4,198,100,120,4,74,69,80,80,77,82,75,4,70,69,71,79,4,88,83,4,81,83,90,73},28))
phase = _d({81,83,90,73},28)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({44,73,69,86,88,70,73,69,88,4,73,86,86,83,86,30},28), err) end
end)
end
local function stopNav()
debug(_d({50,69,90,4,80,83,83,84,4,51,42,42},28))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({81,83,90,73},28)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({56,73,92,88,39,76,69,88,55,73,86,90,77,71,73},28))
local channels = TextChatService:FindFirstChild(_d({56,73,92,88,39,76,69,82,82,73,80,87},28))
local channel = channels and channels:FindFirstChild(_d({54,38,60,43,73,82,73,86,69,80},28))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({40,73,74,69,89,80,88,39,76,69,88,55,93,87,88,73,81,39,76,69,88,41,90,73,82,88,87},28))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({55,69,93,49,73,87,87,69,75,73,54,73,85,89,73,87,88},28))
if sayEvent then
sayEvent:FireServer(message, _d({37,80,80},28))
return
end
debug(_d({87,73,82,72,39,76,69,88,49,73,87,87,69,75,73,30,4,82,83,4,56,73,92,88,39,76,69,88,55,73,86,90,77,71,73,18,54,38,60,43,73,82,73,86,69,80,4,83,86,4,80,73,75,69,71,93,4,55,69,93,49,73,87,87,69,75,73,54,73,85,89,73,87,88,4,74,83,89,82,72,4,74,83,86},28), message)
end)
if not ok then debug(_d({87,73,82,72,39,76,69,88,49,73,87,87,69,75,73,4,73,86,86,83,86,30},28), err) end
end
local function waitUntilArrived(timeout)
local t = 0
local lastPos          = nil
local stuckTicks       = 0
local sinceStuckCheck  = 0
local lastUnstuckSent  = -math.huge
while enabled and not hasArrived() do
task.wait(0.2)
t += 0.2
sinceStuckCheck += 0.2
if sinceStuckCheck >= UNSTUCK_CHECK_INTERVAL then
sinceStuckCheck = 0
local root = Core.GetRoot(LocalPlayer)
if root then
local pos = root.Position
if lastPos then
local moved = (pos - lastPos).Magnitude
if moved < UNSTUCK_MOVE_THRESHOLD then
stuckTicks += 1
else
stuckTicks = 0
end
end
lastPos = pos
if stuckTicks >= UNSTUCK_STUCK_TICKS and (tick() - lastUnstuckSent) > UNSTUCK_COOLDOWN then
debug(_d({50,83,88,4,81,69,79,77,82,75,4,84,86,83,75,86,73,87,87,4,88,83,91,69,86,72,4,82,69,90,4,88,69,86,75,73,88,4,74,83,86},28), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({87,4,17,4,87,73,82,72,77,82,75,4,19,89,82,87,88,89,71,79},28))
sendChatMessage(_d({19,89,82,87,88,89,71,79},28))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({91,69,77,88,57,82,88,77,80,37,86,86,77,90,73,72,4,88,77,81,73,83,89,88},28))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({82,69,90,56,83,52,83,77,82,88,39,83,82,74,77,86,81,73,72,30},28), label or _d({88,69,86,75,73,88},28), _d({17,4,72,77,72,4,82,83,88,4,69,86,86,77,90,73,4,91,77,88,76,77,82},28), timeout, _d({87,16,4,86,73,88,86,93,77,82,75,4,83,82,71,73},28))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({82,69,90,56,83,52,83,77,82,88,39,83,82,74,77,86,81,73,72,30},28), label or _d({88,69,86,75,73,88},28), _d({17,4,87,88,77,80,80,4,82,83,88,4,69,86,86,77,90,73,72,4,69,74,88,73,86,4,86,73,88,86,93,16,4,84,86,83,71,73,73,72,77,82,75,4,69,82,93,91,69,93},28))
end
end
end
local function navToPointHoldingBlock(pos, timeout, blockDelay)
navToPoint(pos)
if blockDelay and blockDelay > 0 then
task.wait(blockDelay)
end
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({82,69,90,56,83,52,83,77,82,88,44,83,80,72,77,82,75,38,80,83,71,79,4,79,73,93,17,72,83,91,82,4,73,86,86,83,86,30},28), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({82,69,90,56,83,52,83,77,82,88,44,83,80,72,77,82,75,38,80,83,71,79,4,79,73,93,17,89,84,4,73,86,86,83,86,30},28), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({59,69,80,79,77,82,75,4,88,83,30},28), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({91,69,80,79,56,83,52,83,77,82,88,4,59,4,72,83,91,82,4,73,86,86,83,86,30},28), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
local hum = getHumanoid()
local startHP = hum and hum.Health or math.huge
local lastUnstuckCheck = tick()
local lastPos = nil
local stuckTicks = 0
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({56,83,83,79,4,72,69,81,69,75,73,4,91,76,77,80,73,4,91,69,80,79,77,82,75,4,88,83,4,84,83,77,82,88,5,4,55,88,83,84,84,77,82,75,4,91,69,80,79,4,88,83,4,73,82,75,69,75,73,18},28))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({37,86,86,77,90,73,72,4,69,88,30},28), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({55,88,89,71,79,4,72,89,86,77,82,75,4,91,69,80,79,16,4,78,89,81,84,77,82,75,5},28))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({55,88,77,80,80,4,87,88,89,71,79,16,4,88,86,77,75,75,73,86,77,82,75,4,43,73,84,84,83,5},28))
task.wait(0.05)
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
stuckTicks = 0
end
else
stuckTicks = 0
end
lastPos = currentRoot.Position
lastUnstuckCheck = tick()
end
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10)
end)
if tick() - lastDash >= dashCooldown then
pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
lastDash = tick()
end
task.wait()
end
pcall(function()
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
end)
if wasNavActive and enabled then
startNav()
end
end
local function clearStage(stageName, targetHP)
targetHP = targetHP or 0.95
debug(_d({49,83,90,77,82,75,4,88,83},28), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({59,69,77,88,77,82,75,4,74,83,86,4,50,52,39,87,4,88,83,4,87,84,69,91,82,4,69,88},28), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({4,4,87,84,69,91,82,4,71,76,73,71,79,30,4,74,83,80,72,73,86,4,73,92,77,87,88,87,4,33},28), folder ~= nil,
_d({16,4,71,76,77,80,72,86,73,82,4,33},28), folder and #folder:GetChildren() or 0,
_d({16,4,69,80,77,90,73,4,33},28), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({50,83,4,50,52,39,87,4,69,84,84,73,69,86,73,72,4,69,88},28), stageName, _d({69,74,88,73,86,4,21,25,87,16,4,81,83,90,77,82,75,4,83,82,4,69,82,93,91,69,93},28))
break
end
end
debug(_d({47,77,80,80,77,82,75,4,50,52,39,87,4,69,88},28), stageName)
equipSwordOrMelee()
setNavNPCNearest()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
m1Combo += 1
if m1Combo >= m1Target then
m1Combo = 0
m1Target = math.random(4, 5)
task.wait(0.2)
end
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({54,73,88,89,86,82,77,82,75,4,88,83},28), stageName, _d({84,83,87,77,88,77,83,82,4,70,73,74,83,86,73,4,81,83,90,77,82,75,4,83,82},28))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({59,69,77,88,77,82,75,4,25,87,4,69,88},28), stageName, _d({84,83,87,77,88,77,83,82},28))
task.wait(5)
debug(_d({59,69,77,88,77,82,75,4,74,83,86},28), targetHP * 100, _d({9,4,44,52,4,70,73,74,83,86,73,4,81,83,90,77,82,75,4,88,83,4,82,73,92,88,4,87,88,69,75,73},28))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({71,80,73,69,86,73,72},28))
end
local function killNamedNPC(name, targetPos)
debug(_d({49,83,90,77,82,75,4,88,83},28), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
m1Combo += 1
if m1Combo >= m1Target then
m1Combo = 0
m1Target = math.random(4, 5)
task.wait(0.2)
end
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({72,73,74,73,69,88,73,72},28))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({48,73,83,4,84,80,69,93,73,72,4,69,82,77,81,69,88,77,83,82,30},28), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({80,73,83,37,82,77,81,48,83,75,75,73,86,4,84,86,77,82,88,4,73,86,86,83,86,30},28), err2) end
end)
end)
if not ok then debug(_d({87,88,69,86,88,48,73,83,37,82,77,81,48,83,75,75,73,86,4,73,86,86,83,86,30},28), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({49,83,90,77,82,75,4,88,83,4,48,73,83},28))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({48,73,83},28))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({48,73,83},28))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({48,73,83},28))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({48,73,83,4,71,69,87,88,77,82,75},28), which, _d({17,4,72,83,72,75,77,82,75},28))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({48,73,83,4,87,88,69,86,88,73,72,4,70,80,83,71,79,17,70,86,73,69,79,73,86,4,81,77,72,17,70,80,83,71,79,5,4,41,90,69,72,77,82,75,18,18,18},28))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = Core.GetRoot(LocalPlayer)
local myPos = root and root.Position or info.root.Position
local bossPos = info.root.Position
local flatDir = Vector3.new(myPos.X - bossPos.X, 0, myPos.Z - bossPos.Z)
if flatDir.Magnitude < 1 then flatDir = Vector3.new(1, 0, 0) end
local awayPoint = myPos + (flatDir.Unit * LEO_DODGE_DISTANCE)
awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)
navToPoint(awayPoint, true)
if which == LEO_ENTEI_ANIM_ID then
local held = 0
while enabled and held < 6 do
task.wait(1)
held += 1
if not getNPCByName(_d({48,73,83},28)) then
debug(_d({48,73,83,4,75,83,82,73,4,81,77,72,17,72,83,72,75,73,4,17,4,73,82,72,77,82,75,4,41,82,88,73,77,4,76,83,80,72,4,73,69,86,80,93},28))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({48,73,83},28)) then
setNavNamed(_d({48,73,83},28))
end
else
equipSwordOrMelee()
if isNPCBlocking(info.model) then
pressSkillR()
m1Combo = 0
elseif not isRealM1Busy() then
clickM1(0.05)
m1Combo += 1
if m1Combo >= m1Target then
m1Combo = 0
m1Target = math.random(4, 5)
task.wait(0.2)
end
end
waitOrReact(MELEE_CLICK_INTERVAL, function()
return isCastingDodgeSkill(info.model) or isNPCBlocking(info.model)
end)
end
end
debug(_d({48,73,83,4,72,73,74,73,69,88,73,72},28))
stopLeoAnimLogger()
debug(_d({54,73,88,89,86,82,77,82,75,4,88,83,4,48,73,83,4,84,83,87,77,88,77,83,82,4,70,73,74,83,86,73,4,81,83,90,77,82,75,4,83,82},28))
navToPointConfirmed(COORDS.Leo, 30, _d({48,73,83,4,84,83,87,77,88,77,83,82},28))
debug(_d({59,69,77,88,77,82,75,4,25,87,4,69,88,4,48,73,83,4,84,83,87,77,88,77,83,82},28))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({49,83,90,77,82,75,4,88,83},28), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({39,83,89,80,72,4,82,83,88,4,74,77,82,72,4,87,88,69,88,89,73,4,81,83,72,73,80,4,82,73,69,86},28), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({37,88,88,69,71,79,77,82,75},28), coordKey, _d({91,77,88,76},28), weapon or _d({82,83,88,76,77,82,75,4,74,83,89,82,72},28))
setNavIdle()
while enabled and getStatueHP(statueModel) > 0 do
local root = Core.GetRoot(LocalPlayer)
local facePos = getModelFacePos(statueModel)
if root and facePos then
pcall(function()
root.CFrame = computeLookDownCFrame(root, facePos)
end)
end
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(coordKey, _d({70,69,86,86,73,80,4,72,73,87,88,86,83,93,73,72},28))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({86,73,71,76,73,71,79,55,88,69,88,89,73,30},28), coordKey, _d({17,4,71,83,89,80,72,4,82,83,88,4,74,77,82,72,4,87,88,69,88,89,73,4,81,83,72,73,80,16,4,87,79,77,84,84,77,82,75},28))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({86,73,71,76,73,71,79,55,88,69,88,89,73,30},28), coordKey, _d({87,88,77,80,80,4,69,80,77,90,73,4,12,44,52},28), hp, _d({13,4,17,4,86,73,17,72,73,87,88,86,83,93,77,82,75},28))
destroyStatue(coordKey)
else
debug(_d({86,73,71,76,73,71,79,55,88,69,88,89,73,30},28), coordKey, _d({71,83,82,74,77,86,81,73,72,4,72,73,87,88,86,83,93,73,72},28))
end
end)
if not ok then debug(_d({86,73,71,76,73,71,79,55,88,69,88,89,73,4,73,86,86,83,86,30},28), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({49,83,90,77,82,75,4,88,83,4,53,89,73,73,82},28))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({39,89,84,77,72,4,53,89,73,73,82},28))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
m1Combo = 0
else
clickM1(0.05)
m1Combo += 1
if m1Combo >= m1Target then
m1Combo = 0
m1Target = math.random(4, 5)
task.wait(0.2)
end
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({53,89,73,73,82,4,73,82,88,73,86,73,72,4,84,76,69,87,73,4,22},28))
end
local function finishQueen()
debug(_d({42,77,82,77,87,76,77,82,75,4,53,89,73,73,82},28))
equipSwordOrMelee()
setNavNamed(_d({39,89,84,77,72,4,53,89,73,73,82},28))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({39,89,84,77,72,4,53,89,73,73,82},28))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
m1Combo = 0
else
clickM1(0.05)
m1Combo += 1
if m1Combo >= m1Target then
m1Combo = 0
m1Target = math.random(4, 5)
task.wait(0.2)
end
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({53,89,73,73,82,4,72,73,74,73,69,88,73,72,18,4,52,80,69,82,4,71,83,81,84,80,73,88,73,18},28))
end
local CONFIRMATION_PROMPT_NAME = _d({39,83,82,74,77,86,81,69,88,77,83,82,52,86,83,81,84,88},28)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({54,73,81,83,88,73,41,90,73,82,88},28), 5)
end)
if ok then return result end
debug(_d({75,73,88,54,73,84,80,69,93,54,73,81,83,88,73,4,73,86,86,83,86,30},28), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({52,80,69,93,73,86,43,89,77},28))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({45,81,69,75,73,38,89,88,88,83,82},28)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({70,89,88,88,83,82,58,69,80,89,73},28)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({74,77,82,72,38,89,88,88,83,82,38,93,58,69,80,89,73,4,73,86,86,83,86,30},28), result)
return nil
end
local function clickGuiButton(button)
local ok, err = pcall(function()
local pos, size = button.AbsolutePosition, button.AbsoluteSize
local x = math.floor(pos.X + size.X / 2)
local y = math.floor(pos.Y + size.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.05)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
if not ok then debug(_d({71,80,77,71,79,43,89,77,38,89,88,88,83,82,4,73,86,86,83,86,30},28), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({77,87,55,73,86,90,73,86},28))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({54,73,81,83,88,73,41,90,73,82,88},28))
or inst:FindFirstChild(_d({71,80,77,73,82,88,41,90,73,82,88},28))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({74,77,82,72,37,82,87,91,73,86,39,83,82,82,73,71,88,83,86,4,73,86,86,83,86,30},28), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({39,83,89,80,72,4,82,83,88,4,80,83,71,69,88,73,4,54,73,81,83,88,73,41,90,73,82,88,19,71,80,77,73,82,88,41,90,73,82,88,4,82,73,69,86,4,54,73,84,80,69,93,4,70,89,88,88,83,82,16,4,74,69,80,80,77,82,75,4,70,69,71,79,4,88,83,4,71,80,77,71,79},28))
clickGuiButton(button)
return
end
local ok, err = pcall(function()
if isServer then
connector:FireServer(REPLAY_BUTTON_VALUE)
else
connector:Fire(REPLAY_BUTTON_VALUE)
end
end)
if not ok then
debug(_d({74,77,86,73,54,73,84,80,69,93,58,69,80,89,73,4,73,86,86,83,86,30},28), err, _d({17,4,74,69,80,80,77,82,75,4,70,69,71,79,4,88,83,4,71,80,77,71,79},28))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({42,69,80,80,77,82,75,4,70,69,71,79,4,88,83,4,70,89,88,88,83,82,58,69,80,89,73,4,87,73,69,86,71,76,4,74,83,86,4,54,73,84,80,69,93},28))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({54,73,84,80,69,93,4,70,89,88,88,83,82,4,82,83,88,4,74,83,89,82,72,4,73,77,88,76,73,86,16,4,75,77,90,77,82,75,4,89,84},28))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({59,69,77,88,77,82,75,4,74,83,86,4,39,83,82,74,77,86,81,69,88,77,83,82,52,86,83,81,84,88,18,54,73,81,83,88,73,41,90,73,82,88},28))
local remote = getReplayRemote()
if not remote then
debug(_d({39,83,82,74,77,86,81,69,88,77,83,82,52,86,83,81,84,88,19,54,73,81,83,88,73,41,90,73,82,88,4,82,83,88,4,74,83,89,82,72,4,91,77,88,76,77,82,4,88,77,81,73,83,89,88},28))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({42,77,86,77,82,75,4,54,73,84,80,69,93,4,90,77,69,4,39,83,82,74,77,86,81,69,88,77,83,82,52,86,83,81,84,88,18,54,73,81,83,88,73,41,90,73,82,88},28))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({42,77,86,73,55,73,86,90,73,86,4,73,86,86,83,86,30},28), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28), 10)
if not playerGui then
debug(_d({91,69,77,88,42,83,86,51,70,78,73,71,88,77,90,73,87,43,89,77,30,4,82,83,4,52,80,69,93,73,86,43,89,77,4,91,77,88,76,77,82,4,88,77,81,73,83,89,88,16,4,84,86,83,71,73,73,72,77,82,75,4,69,82,93,91,69,93},28))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({51,70,78,73,71,88,77,90,73,87,4,43,57,45,4,74,83,89,82,72,4,17,4,87,88,69,75,73,4,80,83,69,72,73,72},28))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({51,70,78,73,71,88,77,90,73,87,4,43,57,45,4,82,83,88,4,74,83,89,82,72,4,91,77,88,76,77,82,4,88,77,81,73,83,89,88,16,4,84,86,83,71,73,73,72,77,82,75,4,69,82,93,91,69,93},28))
return
end
end
end)
if not ok then debug(_d({91,69,77,88,42,83,86,51,70,78,73,71,88,77,90,73,87,43,89,77,4,73,86,86,83,86,30},28), err) end
end
local function runPlan()
debug(_d({52,80,69,82,4,87,88,69,86,88,73,72},28))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({55,88,69,86,88,77,82,75,4,82,69,90,4,80,83,83,84},28))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({84,83,87,4,20,18,22,87,4,37,42,56,41,54,4,87,88,69,86,88,50,69,90,30},28), rootAfter and rootAfter.Position)
end)
debug(_d({59,69,77,88,77,82,75,4,25,87,4,70,73,74,83,86,73,4,81,83,90,77,82,75,4,88,83,4,55,88,69,75,73,21},28))
task.wait(5)
for _, stage in ipairs({_d({55,88,69,75,73,21},28), _d({55,88,69,75,73,22},28), _d({55,88,69,75,73,23},28), _d({55,88,69,75,73,23,38},28)}) do
if not enabled then return end
local hpTarget = (stage == _d({55,88,69,75,73,23,38},28)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({49,83,90,77,82,75,4,88,83,4,69,86,86,83,91,4,74,80,93,17,72,83,91,82,4,69,86,73,69,4,12,39,89,84,77,72,4,54,69,77,82,13},28))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({40,83,72,75,77,82,75,4,69,86,86,83,91,4,86,69,77,82,4,77,82,4,69,4,87,85,89,69,86,73},28))
local elapsed = 0
local d = ARROW_DODGE_DISTANCE
local corners = {
COORDS.ArrowFlyDown + Vector3.new(d, 0, d),
COORDS.ArrowFlyDown + Vector3.new(-d, 0, d),
COORDS.ArrowFlyDown + Vector3.new(-d, 0, -d),
COORDS.ArrowFlyDown + Vector3.new(d, 0, -d)
}
local startT = tick()
local cornerIdx = 1
while enabled and (tick() - startT) < ARROW_HOVER_WAIT do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if not enabled then return end
clearStage(_d({55,88,69,75,73,24},28))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({53,89,73,73,82,4,77,82,4,84,76,69,87,73,4,22,4,17,4,79,73,73,84,77,82,75,4,47,73,82,4,44,69,79,77,4,69,71,88,77,90,73,4,74,86,83,81,4,76,73,86,73,4,83,82},28))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({55,88,69,88,89,73,21},28))
if not enabled then return end
recheckStatue(_d({55,88,69,88,89,73,21},28))
destroyStatue(_d({55,88,69,88,89,73,22},28))
if not enabled then return end
recheckStatue(_d({55,88,69,88,89,73,21},28))
recheckStatue(_d({55,88,69,88,89,73,22},28))
destroyStatue(_d({55,88,69,88,89,73,23},28))
if not enabled then return end
recheckStatue(_d({55,88,69,88,89,73,23},28))
recheckStatue(_d({55,88,69,88,89,73,22},28))
recheckStatue(_d({55,88,69,88,89,73,21},28))
if not enabled then return end
debug(_d({59,69,77,88,77,82,75,4,74,83,86,4,84,76,69,87,73,4,22,4,88,83,4,73,82,72},28))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({52,76,69,87,73,4,22,4,73,82,72,4,91,69,77,88,4,88,77,81,73,83,89,88,16,4,84,86,83,71,73,73,72,77,82,75,4,69,82,93,91,69,93},28))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({49,83,90,77,82,75,4,70,69,71,79,4,88,83,4,53,89,73,73,82,4,87,88,69,75,73,4,84,83,87,77,88,77,83,82},28))
navToPointConfirmed(COORDS.Queen, 30, _d({53,89,73,73,82,4,87,88,69,75,73,4,84,83,87,77,88,77,83,82},28))
debug(_d({59,69,77,88,77,82,75,4,25,87,4,69,88,4,53,89,73,73,82,4,87,88,69,75,73,4,84,83,87,77,88,77,83,82},28))
task.wait(5)
if not enabled then return end
debug(_d({49,83,90,77,82,75,4,88,83,4,84,83,87,88,17,53,89,73,73,82,4,84,83,87,77,88,77,83,82},28))
navToPointConfirmed(COORDS.PostQueen, 30, _d({84,83,87,88,17,53,89,73,73,82,4,84,83,87,77,88,77,83,82},28))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local CupidDungeon = {
Connections = {}
}
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({41,82,69,70,80,77,82,75,16,4,84,83,87,4,38,41,42,51,54,41,4,84,80,69,82,30},28), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({52,80,69,82,4,73,86,86,83,86,30},28), err2) end
end)
debug(_d({41,82,69,70,80,73,72,30},28), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({41,82,69,70,80,73,72,30},28), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
if not Safeguard.RequirePlace(11424731604, _d({39,89,84,77,72,4,40,89,82,75,73,83,82},28)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
if not _G.DisableStandalone then
table.insert(CupidDungeon.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if enabled then
CupidDungeon.Stop()
else
CupidDungeon.Start()
end
end
end))
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({43,69,81,73,4,80,83,69,72,73,72,16,4,69,89,88,83,17,87,88,69,86,88,77,82,75,4,88,76,73,4,84,80,69,82},28))
CupidDungeon.Start()
end)
debug(_d({55,88,69,82,72,69,80,83,82,73,4,49,83,72,73,30,4,69,89,88,83,17,87,88,69,86,88,77,82,75,4,12,84,86,73,87,87,4,65,4,88,83,4,88,83,75,75,80,73,13},28))
end
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({46,89,94,83,4,88,76,73,4,40,77,69,81,83,82,72,70,69,71,79},28),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({38,69,71,79,84,69,71,79},28))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)) or (bp and bp:FindFirstChild(_d({44,83,86,83,17,44,83,86,83},28)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({50,52,39,87},28))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hum = boss:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({44,77,88},28) then return target.CFrame
elseif key == _d({56,69,86,75,73,88},28) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({63,44,83,86,83,42,69,86,81,65,4,49,73,88,69,88,69,70,80,73,4,76,83,83,79,4,74,69,77,80,73,72,30,4},28) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({63,44,83,86,83,42,69,86,81,65,4,55,88,83,84,84,73,72,18},28))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({63,44,83,86,83,42,69,86,81,65,4,37,80,86,73,69,72,93,4,86,89,82,82,77,82,75,5},28)); return end
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({63,44,83,86,83,42,69,86,81,65,4,55,88,69,86,88,73,72,4,88,69,86,75,73,88,77,82,75,30,4},28) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
if not _G.DisableStandalone then
table.insert(HoroFarm.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if HoroFarm.Running then
HoroFarm.Stop()
else
HoroFarm.Start()
end
end
end))
HoroFarm.Start()
print(_d({63,44,83,86,83,42,69,86,81,65,4,55,88,69,82,72,69,80,83,82,73,4,49,83,72,73,30,4,52,86,73,87,87,4,11,65,11,4,88,83,4,88,83,75,75,80,73,18},28))
end
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,55,88,83,84,84,73,72,18},28))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,37,80,86,73,69,72,93,4,86,89,82,82,77,82,75,5},28)); return end
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
if not Safeguard.RequirePlace(3978370137, _d({42,77,86,87,88,4,55,73,69},28)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28), 10)
local hum = char:WaitForChild(_d({44,89,81,69,82,83,77,72},28), 10)
local stats = ReplicatedStorage:WaitForChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({52,73,80,77},28), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28)) or (char and char:FindFirstChild(_d({54,77,74,80,73},28)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,39,89,86,86,73,82,88,4,52,73,80,77,4,71,76,73,71,79,30},28), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,50,83,88,4,69,88,4,56,83,91,82,4,83,74,4,38,73,75,77,82,82,77,82,75,87,18,4,52,80,73,69,87,73,4,88,86,69,90,73,80,4,88,76,73,86,73,4,88,83,4,74,69,86,81,4,71,76,73,87,88,87,4,91,76,77,80,73,4,91,69,77,88,77,82,75,4,74,83,86,4,54,77,74,80,73,18},28))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,71,76,73,87,88,67,74,69,86,81,73,86,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,76,73,87,88,67,74,69,86,81,73,86,18,80,89,69},28))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,42,69,86,81,77,82,75,4,71,76,73,87,88,87,4,89,82,88,77,80,4,23,20,20,4,52,73,80,77,18,18,18,4,12,39,89,86,86,73,82,88,30,4},28) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({52,73,80,77},28))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28)) or (c and c:FindFirstChild(_d({54,77,74,80,73},28))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28))
_G.DisableStandalone = old
end
local buyables = workspace:FindFirstChild(_d({38,89,93,69,70,80,73,45,88,73,81,87},28))
local shopItem = buyables and buyables:FindFirstChild(_d({54,77,74,80,73},28))
local shopPart = shopItem and shopItem:FindFirstChild(_d({55,76,83,84,52,69,86,88},28))
if EasyTravel and shopPart and hrp then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,56,86,69,90,73,80,77,82,75,4,88,83,4,54,77,74,80,73,4,87,76,83,84,4,90,77,69,4,41,69,87,93,56,86,69,90,73,80,18,18,18},28))
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({41,90,73,82,88,87},28)) and ReplicatedStorage.Events:FindFirstChild(_d({55,76,83,84},28))
if shopEvent and shopEvent:IsA(_d({54,73,81,83,88,73,42,89,82,71,88,77,83,82},28)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,41,85,89,77,84,84,77,82,75,4,54,77,74,80,73,18,18,18},28))
local args = {
[1] = _d({73,85,89,77,84},28),
[2] = _d({54,77,74,80,73},28)
}
pcall(function()
game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28)):WaitForChild(_d({41,90,73,82,88,87},28)):WaitForChild(_d({56,83,83,80,87},28)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72},28))
local hrp = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({54,77,74,80,73},28))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,42,80,93,77,82,75,4,88,83,4,42,77,87,76,81,69,82,4,39,69,90,73,18,18,18},28))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({20,21,17,75,84,83,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28), _d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,73,69,87,93,67,88,86,69,90,73,80,18,80,89,69},28))
_G.DisableStandalone = old
end
if EasyTravel then
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 50 then break end
task.wait(1)
end
pcall(EasyTravel.Stop)
end
LevelGrinder.Stop()
end)
end
if not _G.DisableStandalone then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
if LevelGrinder.Running then
print(_d({63,48,73,90,73,80,4,43,86,77,82,72,73,86,65,4,55,88,69,82,72,69,80,83,82,73,4,49,83,72,73,30,4,52,86,73,87,87,4,11,65,11,4,88,83,4,87,88,83,84,18},28))
end
end
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local RunService       = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)) then
Core = loadstring(readfile(_d({20,21,17,75,84,83,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
else
Core = loadstring(game:HttpGet(_d({76,88,88,84,87,30,19,19,86,69,91,18,75,77,88,76,89,70,89,87,73,86,71,83,82,88,73,82,88,18,71,83,81,19,86,83,71,79,93,92,91,69,80,80,19,80,89,69,89,17,71,83,72,73,19,81,69,77,82,19,20,21,67,87,71,86,77,84,88,19,80,77,70,19,71,83,86,73,18,80,89,69},28)))()
end
end)
if not Core then warn(_d({63,39,83,86,73,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
Connections = {}
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
return char, char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)), char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({67,67,41,69,87,93,56,86,69,90,73,80,37,88,88},28)) or Instance.new(_d({37,88,88,69,71,76,81,73,82,88},28))
att.Name = _d({67,67,41,69,87,93,56,86,69,90,73,80,37,88,88},28)
att.Parent = root
local force = root:FindFirstChild(_d({67,67,41,69,87,93,56,86,69,90,73,80,42,83,86,71,73},28))
if not force then
force = Instance.new(_d({48,77,82,73,69,86,58,73,80,83,71,77,88,93},28))
force.Name = _d({67,67,41,69,87,93,56,86,69,90,73,80,42,83,86,71,73},28)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 10000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local _, _, root = getCharacterComponents()
if root then
local force = root:FindFirstChild(_d({67,67,41,69,87,93,56,86,69,90,73,80,42,83,86,71,73},28))
local att = root:FindFirstChild(_d({67,67,41,69,87,93,56,86,69,90,73,80,37,88,88},28))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {character}
raycastParams.IgnoreWater = true
local startPos = Vector3.new(position.X, position.Y + 2, position.Z)
local checkDepth = math.max((position.Y + 2) - SEA_LEVEL_Y, 30)
local direction = Vector3.new(0, -checkDepth, 0)
local result = Workspace:Raycast(startPos, direction, raycastParams)
local groundY = result and result.Position.Y or -100
return math.max(groundY, SEA_LEVEL_Y)
end
local function runRaycastLoop()
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local moveDir = Vector3.zero
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit = Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if forwardHit then
distanceToWall = forwardHit.Distance
local clearanceY = nil
local currentScanDist = FORWARD_SCAN_DISTANCE
local heightOffset = 4
while heightOffset <= 100 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * currentScanDist, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
local secondaryOrigin = scanOrigin + moveUnit * 10
local secondaryHit = Workspace:Raycast(secondaryOrigin, moveUnit * 15, raycastParams)
if secondaryHit then
currentScanDist = currentScanDist + 15
else
break
end
end
heightOffset = heightOffset + 4
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then return end
if not Safeguard then warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,69,77,80,73,72,4,88,83,4,80,83,69,72,5},28)); return end
if not Safeguard.IsSafe() then return end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then moveDir = flatDiff.Unit end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({63,41,69,87,93,4,56,86,69,90,73,80,65,4,42,80,77,75,76,88,4,73,82,69,70,80,73,72,18},28))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({63,41,69,87,93,4,56,86,69,90,73,80,65,4,42,80,77,75,76,88,4,72,77,87,69,70,80,73,72,18},28))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
if not _G.DisableStandalone then
table.insert(EasyTravel.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if EasyTravel.Enabled then
EasyTravel.Stop()
else
EasyTravel.Start()
end
end
end))
print(_d({63,41,69,87,93,4,56,86,69,90,73,80,65,4,55,88,69,82,72,69,80,83,82,73,4,49,83,72,73,30,4,52,86,73,87,87,4,11,65,11,4,88,83,4,88,83,75,75,80,73,4,74,80,77,75,76,88,18},28))
end
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({52,80,69,93,73,86,87},28))
local RunService = game:GetService(_d({54,89,82,55,73,86,90,77,71,73},28))
local UserInputService = game:GetService(_d({57,87,73,86,45,82,84,89,88,55,73,86,90,77,71,73},28))
local ReplicatedStorage = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({77,72,80,73},28)
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local HOVER_OFFSET = 10.3
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5
local currentHoverOffset = HOVER_OFFSET
local currentDodgeHeight = 70
local function debug(...)
print(_d({63,51,90,73,86,91,83,86,80,72,56,73,87,88,73,86,65},28), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({55,88,69,88,87},28) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({54,83,79,89,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,73,84,84,83},28), args)
elseif style == _d({38,80,69,71,79,48,73,75},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79},28), args)
elseif style == _d({47,69,81,77,87,76,77,79,77},28) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,69,81,77,87,76,77,79,77,43,73,84,84,83},28), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,79,93,4,59,69,80,79,22},28), args)
end
debug(_d({42,77,86,73,72,4,43,73,84,84,83,4,54,73,81,83,88,73},28))
end)
if not ok then debug(_d({77,82,90,83,79,73,43,73,84,84,83,4,73,86,86,83,86,30},28), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({67,67,56,73,87,88,44,83,90,73,86,37,88,88},28)) or Instance.new(_d({37,88,88,69,71,76,81,73,82,88},28))
att.Name = _d({67,67,56,73,87,88,44,83,90,73,86,37,88,88},28)
att.Parent = root
local force = root:FindFirstChild(_d({67,67,56,73,87,88,44,83,90,73,86,42,83,86,71,73},28))
if not force then
force = Instance.new(_d({48,77,82,73,69,86,58,73,80,83,71,77,88,93},28))
force.Name = _d({67,67,56,73,87,88,44,83,90,73,86,42,83,86,71,73},28)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then return result end
return nil
end
local function cleanupForce()
pcall(function()
local char = LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28))
if not root then return end
local force = root:FindFirstChild(_d({67,67,56,73,87,88,44,83,90,73,86,42,83,86,71,73},28))
local att   = root:FindFirstChild(_d({67,67,56,73,87,88,44,83,90,73,86,37,88,88},28))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({59,69,80,79,77,82,75,4,88,83,30},28), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({91,69,80,79,56,83,52,83,77,82,88,4,59,4,72,83,91,82,4,73,86,86,83,86,30},28), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({37,86,86,77,90,73,72,4,69,88,30},28), pos)
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Workspace.CurrentCamera.CFrame = CFrame.lookAt(Workspace.CurrentCamera.CFrame.Position, currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10)
end)
if tick() - lastDash >= dashCooldown then
pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.Q, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
lastDash = tick()
end
task.wait()
end
pcall(function()
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
end)
end
local function getNearestTarget()
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({49,83,72,73,80},28)) and item:FindFirstChild(_d({44,89,81,69,82,83,77,72,54,83,83,88,52,69,86,88},28)) and item:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({44,89,81,69,82,83,77,72},28)).Health > 0 then
local dist = (item.HumanoidRootPart.Position - root.Position).Magnitude
if dist < nearestDist then
nearestDist = dist
nearest = item
end
end
end
end
return nearest
end
local function computeLookDownCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function disableBot()
if not enabled then return end
enabled = false
mode = _d({77,72,80,73},28)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({56,73,87,88,73,86,4,40,77,87,69,70,80,73,72},28))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({56,73,87,88,73,86,4,41,82,69,70,80,73,72,18,4,49,83,72,73,30},28), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({52,80,69,93,73,86,4,72,77,73,72,5,4,40,77,87,69,70,80,77,82,75,4,70,83,88,18},28))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({76,83,90,73,86},28) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({72,83,72,75,73},28) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({87,85,89,69,86,73,67,72,83,72,75,73},28) then
return
end
if not aim then
aim = lastAim or root.Position
face = lastFace or aim
end
lastAim = aim
lastFace = face
local pos = root.Position
local yErr = aim.Y - pos.Y
local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60)) or Vector3.zero
local force = getOrCreateForce(root)
if force then
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
force.VectorVelocity = Vector3.new(xzVel.X, yVel, xzVel.Z)
end
if xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
pcall(function()
root.CFrame = computeLookDownCFrame(root, face) + (aim - root.Position)
end)
else
pcall(function()
root.CFrame = computeLookDownCFrame(root, face)
end)
if yErr > 5 then
invokeGeppo()
end
end
end)
end
local function CreateUI()
local playerGui = LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({51,90,73,86,91,83,86,80,72,56,73,87,88,43,89,77},28))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({55,71,86,73,73,82,43,89,77},28))
screenGui.Name = _d({51,90,73,86,91,83,86,80,72,56,73,87,88,43,89,77},28)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({42,86,69,81,73},28))
frame.Name = _d({49,69,77,82,42,86,69,81,73},28)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({57,45,39,83,86,82,73,86},28))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({56,73,92,88,48,69,70,73,80},28))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({212,131,127,133,211,156,115,4,39,89,84,77,72,4,41,82,75,77,82,73,4,51,90,73,86,91,83,86,80,72,4,56,73,87,88},28)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({56,73,92,88,48,69,70,73,80},28))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({55,88,69,88,89,87,30,4,45,72,80,73},28)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({56,73,92,88,38,89,88,88,83,82},28))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({57,45,39,83,86,82,73,86},28), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({56,73,92,88,38,83,92},28))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({57,45,39,83,86,82,73,86},28), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({44,83,90,73,86,4,37,70,83,90,73,4,56,69,86,75,73,88},28), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({76,83,90,73,86},28))
statusLabel.Text = _d({55,88,69,88,89,87,30,4,44,83,90,73,86,77,82,75,4},28) .. val .. _d({4,87,88,89,72,87,4,89,84},28)
end)
createInputBtn(_d({40,83,72,75,73,4,39,80,77,81,70},28), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({72,83,72,75,73},28))
statusLabel.Text = _d({55,88,69,88,89,87,30,4,40,83,72,75,73,17,76,83,80,72,77,82,75,4,12},28) .. val .. _d({4,87,88,89,72,87,13},28)
end)
createInputBtn(_d({56,73,87,88,4,55,85,89,69,86,73,4,40,83,72,75,73},28), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({87,85,89,69,86,73,67,72,83,72,75,73},28))
statusLabel.Text = _d({55,88,69,88,89,87,30,4,55,85,89,69,86,73,4,59,69,80,79,77,82,75,4,12},28) .. val .. _d({4,87,88,89,72,87,13},28)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local center = root.Position
local d = val
local corners = {
center + Vector3.new(d, 0, d),
center + Vector3.new(-d, 0, d),
center + Vector3.new(-d, 0, -d),
center + Vector3.new(d, 0, -d)
}
local startT = tick()
local cornerIdx = 1
while enabled and mode == _d({87,85,89,69,86,73,67,72,83,72,75,73},28) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({87,85,89,69,86,73,67,72,83,72,75,73},28) then
disableBot()
statusLabel.Text = _d({55,88,69,88,89,87,30,4,45,72,80,73,4,12,55,85,89,69,86,73,4,72,83,72,75,73,4,72,83,82,73,13},28)
end
end)
end)
local stopBtn = Instance.new(_d({56,73,92,88,38,89,88,88,83,82},28))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({41,49,41,54,43,41,50,39,61,4,55,56,51,52},28)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({57,45,39,83,86,82,73,86},28), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({55,88,69,88,89,87,30,4,55,56,51,52,52,41,40,4,12,45,72,80,73,13},28)
local VIM = game:GetService(_d({58,77,86,88,89,69,80,45,82,84,89,88,49,69,82,69,75,73,86},28))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({63,51,90,73,86,91,83,86,80,72,56,73,87,88,73,86,65,4,48,83,69,72,73,72,4,87,89,71,71,73,87,87,74,89,80,80,93,18},28))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({52,80,69,93,73,86,43,89,77},28), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({43,52,51,48,69,89,82,71,76,73,86,57,45},28))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({55,71,86,73,73,82,43,89,77},28))
screenGui.Name = _d({43,52,51,48,69,89,82,71,76,73,86,57,45},28)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({42,86,69,81,73},28))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({57,45,39,83,86,82,73,86},28))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({57,45,55,88,86,83,79,73},28))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({56,73,92,88,48,69,70,73,80},28))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({212,131,112,112,4,43,52,51,4,44,89,70,4,48,69,89,82,71,76,73,86},28)
title.Parent = main
local closeBtn = Instance.new(_d({56,73,92,88,38,89,88,88,83,82},28))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({57,45,39,83,86,82,73,86},28), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({56,73,92,88,48,69,70,73,80},28))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({39,76,83,83,87,73,4,69,4,70,83,88,4,83,86,4,89,88,77,80,77,88,93,4,88,83,4,86,89,82,30},28)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({56,73,92,88,38,89,88,88,83,82},28))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({4,4},28) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({57,45,39,83,86,82,73,86},28))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({57,45,55,88,86,83,79,73},28))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({56,73,92,88,48,69,70,73,80},28))
descLabel.Size = UDim2.new(1, -20, 0, 15)
descLabel.Position = UDim2.new(0, 10, 1, -18)
descLabel.BackgroundTransparency = 1
descLabel.Font = Enum.Font.GothamMedium
descLabel.TextSize = 9
descLabel.TextColor3 = Color3.fromRGB(140, 145, 160)
descLabel.TextXAlignment = Enum.TextXAlignment.Left
descLabel.Text = desc
descLabel.Parent = btn
btn.MouseButton1Click:Connect(function()
screenGui:Destroy()
task.spawn(onClick)
end)
buttonCount = buttonCount + 1
end
CreateLaunchButton(_d({39,89,84,77,72,4,40,89,82,75,73,83,82,4,42,69,86,81},28), _d({37,89,88,83,81,69,88,73,4,71,89,84,77,72,4,72,89,82,75,73,83,82,87,4,10,4,70,83,87,87,4,71,93,71,80,73,87},28), loadCupidDungeon)
CreateLaunchButton(_d({44,83,86,83,4,38,83,87,87,4,42,69,86,81,4,12,55,77,80,73,82,88,4,37,77,81,13},28), _d({37,89,88,83,74,69,86,81,4,83,90,73,86,91,83,86,80,72,4,70,83,87,87,73,87,4,89,87,77,82,75,4,44,83,86,83,4,74,86,89,77,88,87},28), loadHoroBossFarm)
CreateLaunchButton(_d({48,73,90,73,80,4,10,4,49,83,70,4,43,86,77,82,72,73,86},28), _d({37,89,88,83,17,80,73,90,73,80,4,69,82,72,4,74,69,86,81,4,80,83,71,69,80,4,50,52,39,4,81,83,70,87},28), loadLevelGrinder)
CreateLaunchButton(_d({41,69,87,93,4,56,86,69,90,73,80,4,12,52,4,56,83,75,75,80,73,13},28), _d({59,37,55,40,4,42,80,77,75,76,88,4,91,77,88,76,4,75,86,83,89,82,72,4,74,83,80,80,83,91,4,10,4,91,69,80,80,4,71,80,77,81,70,77,82,75},28), loadNavigationLab)
CreateLaunchButton(_d({52,76,93,87,77,71,87,4,51,90,73,86,91,83,86,80,72,4,56,73,87,88,73,86},28), _d({56,73,87,88,4,71,83,81,70,69,88,4,76,83,90,73,86,16,4,75,73,84,84,83,4,10,4,72,83,72,75,73,4,76,73,77,75,76,88,87},28), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({63,43,52,51,4,44,89,70,65,4,48,69,89,82,71,76,73,86,4,57,45,4,77,82,77,88,77,69,80,77,94,73,72,18},28))
end)()