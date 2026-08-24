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
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({22,50,39,63,43,56,57},58))
local UserInputService    = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local RunService          = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM                 = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local ReplicatedStorage    = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({33,8,53,57,57,8,53,58,35},58), _d({29,56,53,52,45,230,45,39,51,43,230,168,70,90,230,22,50,39,41,43,15,42,0},58), game.PlaceId, _d({27,52,47,60,43,56,57,43,15,42,0},58), game.GameId, _d({243,230,52,53,58,230,56,59,52,52,47,52,45},58))
return
end
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
local LEO_PILLAR_ANIM_ID   = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,251,248,250,250,247,250,247,249,248,253},58)
local LEO_ENTEI_ANIM_ID    = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,251,248,250,250,247,249,254,248,253,254},58)
local LEO_HIKEN_ANIM_ID    = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,251,248,248,246,255,247,253,250,246,253},58)
local LEO_FIREFLY_ANIM_ID  = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,251,248,248,246,248,249,252,247,251,250},58)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({21,40,48,43,41,58,47,60,43,57},58)
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
local REPLAY_BUTTON_VALUE   = _d({24,43,54,50,39,63},58)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({51,53,60,43},58)
local NavState   = {mode = _d({47,42,50,43},58)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({33,8,53,57,57,8,53,58,35},58), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end)
if ok then return root end
debug(_d({45,43,58,24,53,53,58,230,43,56,56,53,56,0},58), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
end)
if ok then return hum end
debug(_d({45,43,58,14,59,51,39,52,53,47,42,230,43,56,56,53,56,0},58), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({37,37,14,53,60,43,56,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,14,53,60,43,56,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,14,53,60,43,56,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,14,53,60,43,56,12,53,56,41,43},58)
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
debug(_d({45,43,58,21,56,9,56,43,39,58,43,12,53,56,41,43,230,43,56,56,53,56,0},58), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local force = root:FindFirstChild(_d({37,37,14,53,60,43,56,12,53,56,41,43},58))
local att   = root:FindFirstChild(_d({37,37,14,53,60,43,56,7,58,58},58))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({41,50,43,39,52,59,54,12,53,56,41,43,230,43,56,56,53,56,0},58), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({8,59,57,53,19,43,50,43,43},58)) ~= nil
end)
if ok then return result end
debug(_d({47,57,8,59,57,53,7,41,58,47,60,43,230,43,56,56,53,56,0},58), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({8,59,57,53},58))
end)
if not ok then debug(_d({39,41,58,47,60,39,58,43,8,59,57,53,230,43,56,56,53,56,0},58), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({8,59,57,53,230,52,53,58,230,39,41,58,47,60,43,242,230,39,41,58,47,60,39,58,47,52,45},58))
activateBuso()
end
end)
if not ok then debug(_d({8,59,57,53,17,43,43,54,43,56,230,43,56,56,53,56,0},58), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({8,59,57,53,230,49,43,43,54,43,56,230,57,58,53,54,54,43,42},58))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({17,43,52,14,39,49,47},58)) ~= nil
end)
if ok then return result end
debug(_d({47,57,17,43,52,7,41,58,47,60,43,230,43,56,56,53,56,0},58), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({17,43,52},58), true)
end)
if not ok then debug(_d({39,41,58,47,60,39,58,43,17,43,52,230,43,56,56,53,56,0},58), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({17,43,52,230,52,53,58,230,39,41,58,47,60,43,242,230,39,41,58,47,60,39,58,47,52,45},58))
activateKen()
end
end)
if not ok then debug(_d({17,43,52,17,43,43,54,43,56,230,43,56,56,53,56,0},58), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({17,43,52,230,49,43,43,54,43,56,230,57,58,53,54,54,43,42},58))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({20,22,9,57},58)) end)
if ok then return folder end
debug(_d({45,43,58,20,22,9,57,12,53,50,42,43,56,230,43,56,56,53,56,0},58), folder)
return nil
end
local function getNearestNPC(exclude)
local ok, result = pcall(function()
local root = getRoot()
local folder = getNPCsFolder()
if not root or not folder then return nil end
local nearest, nearestDist = nil, math.huge
local fallbackNearest, fallbackDist = nil, math.huge
for _, model in ipairs(folder:GetChildren()) do
local okp, info = pcall(function()
local r = model:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local h = model:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
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
debug(_d({45,43,58,20,43,39,56,43,57,58,20,22,9,230,43,56,56,53,56,0},58), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum  = model:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({45,43,58,20,22,9,8,63,20,39,51,43,230,43,56,56,53,56,0},58), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({52,54,41,57,24,43,51,39,47,52,47,52,45,230,43,56,56,53,56,0},58), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({9,59,54,47,42,230,23,59,43,43,52},58))
return queen ~= nil and queen:FindFirstChild(_d({51,53,58,47,53,52,18,43,57,57},58)) ~= nil
end)
if ok then return result end
debug(_d({47,57,23,59,43,43,52,22,46,39,57,43,248,230,43,56,56,53,56,0},58), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,247,248,247,248,255,253,255,250,248,248,255,248,253,252,255},58)
local QUEEN_GRASP_ANIM_ID   = _d({56,40,62,39,57,57,43,58,47,42,0,245,245,247,248,255,254,246,246,246,252,247,246,246,247,253,249,250},58)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
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
debug(_d({47,57,22,50,39,63,47,52,45,7,52,47,51,12,56,53,51,18,47,57,58,230,43,56,56,53,56,0},58), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({8,50,53,41,49,47,52,45},58)) ~= nil
end)
if ok then return result end
debug(_d({47,57,20,22,9,8,50,53,41,49,47,52,45,230,43,56,56,53,56,0},58), result)
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
debug(_d({54,56,43,42,47,41,58,20,22,9,22,53,57,47,58,47,53,52,230,43,56,56,53,56,0},58), result)
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
debug(_d({20,53,230,42,39,51,39,45,43,230,53,52},58), model.Name, _d({44,53,56},58), NPC_STUCK_TIMEOUT, _d({57,230,243,230,57,61,47,58,41,46,47,52,45,230,58,39,56,45,43,58},58))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({58,56,39,41,49,20,22,9,10,39,51,39,45,43,230,43,56,56,53,56,0},58), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({19,53,42,43,50},58)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({8,39,57,43,22,39,56,58},58)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({45,43,58,19,53,42,43,50,12,39,41,43,22,53,57,230,43,56,56,53,56,0},58), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({11,52,60},58))
local folder = env and env:FindFirstChild(_d({25,58,39,58,59,43,57},58))
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
debug(_d({45,43,58,25,58,39,58,59,43,19,53,42,43,50,20,43,39,56,230,43,56,56,53,56,0},58), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({40,39,56,56,43,50,14,22},58))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({45,43,58,25,58,39,58,59,43,14,22,230,43,56,56,53,56,0},58), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({26,53,53,50},58)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({44,47,52,42,26,53,53,50,8,63,7,58,58,56,47,40,59,58,43,230,43,56,56,53,56,0},58), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({26,53,53,50},58)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({44,47,52,42,26,53,53,50,8,63,20,39,51,43,230,43,56,56,53,56,0},58), tool)
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
if not ok then debug(_d({43,55,59,47,54,26,53,53,50,230,43,56,56,53,56,0},58), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({26,53,53,50},58)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({44,47,52,42,26,53,53,50,8,63,9,46,47,50,42,20,39,51,43,230,43,56,56,53,56,0},58), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({25,61,53,56,42,11,55,59,47,54},58))
if sword then
equipTool(sword)
return _d({57,61,53,56,42},58)
end
local melee = findToolByAttribute(_d({19,43,50,43,43,26,53,53,50},58))
if melee then
equipTool(melee)
return _d({51,43,50,43,43},58)
end
debug(_d({20,53,230,57,61,53,56,42,230,53,56,230,51,43,50,43,43,230,58,53,53,50,230,44,53,59,52,42},58))
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
if not ok then debug(_d({41,50,47,41,49,19,247,230,43,56,56,53,56,0},58), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({24,53,49,59,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,43,54,54,53},58), args)
elseif style == _d({8,50,39,41,49,18,43,45},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49},58), args)
elseif style == _d({17,39,51,47,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,39,51,47,57,46,47,49,47,13,43,54,54,53},58), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49,248},58), args)
end
end)
if not ok then debug(_d({47,52,60,53,49,43,13,43,54,54,53,230,43,56,56,53,56,0},58), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({54,56,43,57,57,25,49,47,50,50,24,230,43,56,56,53,56,0},58), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({46,53,50,42,8,50,53,41,49,230,43,56,56,53,56,0},58), err) end
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
if not ok then debug(_d({46,53,50,42,8,50,53,41,49,29,46,47,50,43,230,43,56,56,53,56,0},58), err) end
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
debug(_d({45,43,58,13,39,51,43,13,230,43,56,56,53,56,0},58), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({47,57,24,43,39,50,19,247,8,59,57,63,230,43,56,56,53,56,0},58), result)
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
return char ~= nil and char:FindFirstChild(_d({57,58,59,52},58)) ~= nil
end)
if ok then return result end
debug(_d({47,57,25,58,59,52,52,43,42,230,43,56,56,53,56,0},58), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({54,56,43,57,57,25,58,59,52,8,56,43,39,49,230,43,56,56,53,56,0},58), err) end
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
local root = getRoot()
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
debug(_d({55,59,43,43,52,10,53,42,45,43,27,52,58,47,50,25,39,44,43,0,230,23,59,43,43,52,230,45,53,52,43,230,243,230,43,52,42,47,52,45,230,42,53,42,45,43,230,43,39,56,50,63},58))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({55,59,43,43,52,10,53,42,45,43,27,52,58,47,50,25,39,44,43,230,57,39,44,43,58,63,230,58,47,51,43,53,59,58},58))
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
local info = getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({23,59,43,43,52,230,41,39,57,58,47,52,45,230,42,43,58,43,41,58,43,42,230,243,230,42,53,42,45,47,52,45,230,238,61,39,58,41,46,43,56,239},58))
queenDodgeUntilSafe(function() return getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58)) end)
if enabled and getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58)) then
setNavNamed(_d({9,59,54,47,42,230,23,59,43,43,52},58))
end
queenDodging = false
end
end)
if not ok then debug(_d({55,59,43,43,52,10,53,42,45,43,29,39,58,41,46,43,56,230,43,56,56,53,56,0},58), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({54,53,47,52,58},58) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({52,54,41},58) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({52,39,51,43,42},58) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({45,43,58,20,39,60,26,39,56,45,43,58,57,230,43,56,56,53,56,0},58), aimR)
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
debug(_d({41,53,51,54,59,58,43,18,53,41,49,43,42,9,12,56,39,51,43,230,43,56,56,53,56,0},58), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({54,53,47,52,58},58), point = pos}
phase = _d({51,53,60,43},58)
end
function navToPoint(pos, skipExtraGeppo)
local ok, err = pcall(function()
local root = getRoot()
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
if not ok then debug(_d({52,39,60,26,53,22,53,47,52,58,230,45,43,54,54,53,230,41,46,43,41,49,230,43,56,56,53,56,0},58), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({52,54,41},58)}
phase = _d({51,53,60,43},58)
end
function setNavNamed(name)
NavState = {mode = _d({52,39,51,43,42},58), name = name}
phase = _d({51,53,60,43},58)
end
local function setNavIdle()
NavState = {mode = _d({47,42,50,43},58)}
phase = _d({51,53,60,43},58)
end
local function hasArrived()
return phase == _d({46,53,60,43,56},58)
end
local function startNav()
phase = _d({51,53,60,43},58)
debug(_d({20,39,60,230,50,53,53,54,230,21,20},58))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({22,50,39,63,43,56,230,42,47,43,42,231,230,25,58,53,54,54,47,52,45,230,40,53,58,244},58))
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
debug(_d({22,50,39,63,43,56,230,47,57,230,58,53,53,230,44,39,56,230,44,56,53,51,230,58,39,56,45,43,58,230,238,4,248,246,246,246,230,57,58,59,42,57,239,244,230,18,47,49,43,50,63,230,56,43,57,54,39,61,52,43,42,230,39,58,230,50,53,40,40,63,244,230,25,58,53,54,54,47,52,45,230,40,53,58,244},58))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({37,37,54,56,43,60,22,53,57},58))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({18,39,56,45,43,230,54,53,57,47,58,47,53,52,230,48,59,51,54,230,42,43,58,43,41,58,43,42,0},58), delta, _d({57,58,59,42,57,244,230,54,56,43,60,22,53,57,3},58), prevPos, _d({52,43,61,22,53,57,3},58), pos)
end
end
force:SetAttribute(_d({37,37,54,56,43,60,22,53,57},58), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({51,53,60,43},58) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({46,53,60,43,56},58)
debug(_d({22,46,39,57,43,0,230,46,53,60,43,56},58))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({231,231,231,230,24,11,12,27,25,15,20,13,230,26,21,230,7,22,22,18,31,230,7,8,20,21,24,19,7,18,230,28,11,18,21,9,15,26,31,0},58), finalVel, _d({39,47,51,3},58), aim, _d({54,53,57,3},58), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({46,53,60,43,56},58) then
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
debug(_d({9,53,51,40,39,58,230,50,53,41,49,230,57,49,47,54,54,43,42,242},58), snapDist, _d({57,58,59,42,57,230,44,56,53,51,230,58,39,56,45,43,58,230,168,70,90,230,44,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,51,53,60,43},58))
phase = _d({51,53,60,43},58)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({14,43,39,56,58,40,43,39,58,230,43,56,56,53,56,0},58), err) end
end)
end
local function stopNav()
debug(_d({20,39,60,230,50,53,53,54,230,21,12,12},58))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({51,53,60,43},58)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({26,43,62,58,9,46,39,58,25,43,56,60,47,41,43},58))
local channels = TextChatService:FindFirstChild(_d({26,43,62,58,9,46,39,52,52,43,50,57},58))
local channel = channels and channels:FindFirstChild(_d({24,8,30,13,43,52,43,56,39,50},58))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({10,43,44,39,59,50,58,9,46,39,58,25,63,57,58,43,51,9,46,39,58,11,60,43,52,58,57},58))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({25,39,63,19,43,57,57,39,45,43,24,43,55,59,43,57,58},58))
if sayEvent then
sayEvent:FireServer(message, _d({7,50,50},58))
return
end
debug(_d({57,43,52,42,9,46,39,58,19,43,57,57,39,45,43,0,230,52,53,230,26,43,62,58,9,46,39,58,25,43,56,60,47,41,43,244,24,8,30,13,43,52,43,56,39,50,230,53,56,230,50,43,45,39,41,63,230,25,39,63,19,43,57,57,39,45,43,24,43,55,59,43,57,58,230,44,53,59,52,42,230,44,53,56},58), message)
end)
if not ok then debug(_d({57,43,52,42,9,46,39,58,19,43,57,57,39,45,43,230,43,56,56,53,56,0},58), err) end
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
local root = getRoot()
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
debug(_d({20,53,58,230,51,39,49,47,52,45,230,54,56,53,45,56,43,57,57,230,58,53,61,39,56,42,230,52,39,60,230,58,39,56,45,43,58,230,44,53,56},58), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({57,230,243,230,57,43,52,42,47,52,45,230,245,59,52,57,58,59,41,49},58))
sendChatMessage(_d({245,59,52,57,58,59,41,49},58))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({61,39,47,58,27,52,58,47,50,7,56,56,47,60,43,42,230,58,47,51,43,53,59,58},58))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({52,39,60,26,53,22,53,47,52,58,9,53,52,44,47,56,51,43,42,0},58), label or _d({58,39,56,45,43,58},58), _d({243,230,42,47,42,230,52,53,58,230,39,56,56,47,60,43,230,61,47,58,46,47,52},58), timeout, _d({57,242,230,56,43,58,56,63,47,52,45,230,53,52,41,43},58))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({52,39,60,26,53,22,53,47,52,58,9,53,52,44,47,56,51,43,42,0},58), label or _d({58,39,56,45,43,58},58), _d({243,230,57,58,47,50,50,230,52,53,58,230,39,56,56,47,60,43,42,230,39,44,58,43,56,230,56,43,58,56,63,242,230,54,56,53,41,43,43,42,47,52,45,230,39,52,63,61,39,63},58))
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
if not ok then debug(_d({52,39,60,26,53,22,53,47,52,58,14,53,50,42,47,52,45,8,50,53,41,49,230,49,43,63,243,42,53,61,52,230,43,56,56,53,56,0},58), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({52,39,60,26,53,22,53,47,52,58,14,53,50,42,47,52,45,8,50,53,41,49,230,49,43,63,243,59,54,230,43,56,56,53,56,0},58), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({29,39,50,49,47,52,45,230,58,53,0},58), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({61,39,50,49,26,53,22,53,47,52,58,230,29,230,42,53,61,52,230,43,56,56,53,56,0},58), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
local hum = getHumanoid()
local startHP = hum and hum.Health or math.huge
local lastUnstuckCheck = tick()
local lastPos = nil
local stuckTicks = 0
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({26,53,53,49,230,42,39,51,39,45,43,230,61,46,47,50,43,230,61,39,50,49,47,52,45,230,58,53,230,54,53,47,52,58,231,230,25,58,53,54,54,47,52,45,230,61,39,50,49,230,58,53,230,43,52,45,39,45,43,244},58))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({7,56,56,47,60,43,42,230,39,58,0},58), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({25,58,59,41,49,230,42,59,56,47,52,45,230,61,39,50,49,242,230,48,59,51,54,47,52,45,231},58))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({25,58,47,50,50,230,57,58,59,41,49,242,230,58,56,47,45,45,43,56,47,52,45,230,13,43,54,54,53,231},58))
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
debug(_d({19,53,60,47,52,45,230,58,53},58), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({29,39,47,58,47,52,45,230,44,53,56,230,20,22,9,57,230,58,53,230,57,54,39,61,52,230,39,58},58), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({230,230,57,54,39,61,52,230,41,46,43,41,49,0,230,44,53,50,42,43,56,230,43,62,47,57,58,57,230,3},58), folder ~= nil,
_d({242,230,41,46,47,50,42,56,43,52,230,3},58), folder and #folder:GetChildren() or 0,
_d({242,230,39,50,47,60,43,230,3},58), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({20,53,230,20,22,9,57,230,39,54,54,43,39,56,43,42,230,39,58},58), stageName, _d({39,44,58,43,56,230,247,251,57,242,230,51,53,60,47,52,45,230,53,52,230,39,52,63,61,39,63},58))
break
end
end
debug(_d({17,47,50,50,47,52,45,230,20,22,9,57,230,39,58},58), stageName)
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
debug(_d({24,43,58,59,56,52,47,52,45,230,58,53},58), stageName, _d({54,53,57,47,58,47,53,52,230,40,43,44,53,56,43,230,51,53,60,47,52,45,230,53,52},58))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({29,39,47,58,47,52,45,230,251,57,230,39,58},58), stageName, _d({54,53,57,47,58,47,53,52},58))
task.wait(5)
debug(_d({29,39,47,58,47,52,45,230,44,53,56},58), targetHP * 100, _d({235,230,14,22,230,40,43,44,53,56,43,230,51,53,60,47,52,45,230,58,53,230,52,43,62,58,230,57,58,39,45,43},58))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({41,50,43,39,56,43,42},58))
end
local function killNamedNPC(name, targetPos)
debug(_d({19,53,60,47,52,45,230,58,53},58), name)
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
debug(name, _d({42,43,44,43,39,58,43,42},58))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({18,43,53,230,54,50,39,63,43,42,230,39,52,47,51,39,58,47,53,52,0},58), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({50,43,53,7,52,47,51,18,53,45,45,43,56,230,54,56,47,52,58,230,43,56,56,53,56,0},58), err2) end
end)
end)
if not ok then debug(_d({57,58,39,56,58,18,43,53,7,52,47,51,18,53,45,45,43,56,230,43,56,56,53,56,0},58), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({19,53,60,47,52,45,230,58,53,230,18,43,53},58))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({18,43,53},58))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({18,43,53},58))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({18,43,53},58))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({18,43,53,230,41,39,57,58,47,52,45},58), which, _d({243,230,42,53,42,45,47,52,45},58))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({18,43,53,230,57,58,39,56,58,43,42,230,40,50,53,41,49,243,40,56,43,39,49,43,56,230,51,47,42,243,40,50,53,41,49,231,230,11,60,39,42,47,52,45,244,244,244},58))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = getRoot()
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
if not getNPCByName(_d({18,43,53},58)) then
debug(_d({18,43,53,230,45,53,52,43,230,51,47,42,243,42,53,42,45,43,230,243,230,43,52,42,47,52,45,230,11,52,58,43,47,230,46,53,50,42,230,43,39,56,50,63},58))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({18,43,53},58)) then
setNavNamed(_d({18,43,53},58))
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
debug(_d({18,43,53,230,42,43,44,43,39,58,43,42},58))
stopLeoAnimLogger()
debug(_d({24,43,58,59,56,52,47,52,45,230,58,53,230,18,43,53,230,54,53,57,47,58,47,53,52,230,40,43,44,53,56,43,230,51,53,60,47,52,45,230,53,52},58))
navToPointConfirmed(COORDS.Leo, 30, _d({18,43,53,230,54,53,57,47,58,47,53,52},58))
debug(_d({29,39,47,58,47,52,45,230,251,57,230,39,58,230,18,43,53,230,54,53,57,47,58,47,53,52},58))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({19,53,60,47,52,45,230,58,53},58), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({9,53,59,50,42,230,52,53,58,230,44,47,52,42,230,57,58,39,58,59,43,230,51,53,42,43,50,230,52,43,39,56},58), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({7,58,58,39,41,49,47,52,45},58), coordKey, _d({61,47,58,46},58), weapon or _d({52,53,58,46,47,52,45,230,44,53,59,52,42},58))
setNavIdle()
while enabled and getStatueHP(statueModel) > 0 do
local root = getRoot()
local facePos = getModelFacePos(statueModel)
if root and facePos then
pcall(function()
root.CFrame = computeLookDownCFrame(root, facePos)
end)
end
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(coordKey, _d({40,39,56,56,43,50,230,42,43,57,58,56,53,63,43,42},58))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({56,43,41,46,43,41,49,25,58,39,58,59,43,0},58), coordKey, _d({243,230,41,53,59,50,42,230,52,53,58,230,44,47,52,42,230,57,58,39,58,59,43,230,51,53,42,43,50,242,230,57,49,47,54,54,47,52,45},58))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({56,43,41,46,43,41,49,25,58,39,58,59,43,0},58), coordKey, _d({57,58,47,50,50,230,39,50,47,60,43,230,238,14,22},58), hp, _d({239,230,243,230,56,43,243,42,43,57,58,56,53,63,47,52,45},58))
destroyStatue(coordKey)
else
debug(_d({56,43,41,46,43,41,49,25,58,39,58,59,43,0},58), coordKey, _d({41,53,52,44,47,56,51,43,42,230,42,43,57,58,56,53,63,43,42},58))
end
end)
if not ok then debug(_d({56,43,41,46,43,41,49,25,58,39,58,59,43,230,43,56,56,53,56,0},58), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({19,53,60,47,52,45,230,58,53,230,23,59,43,43,52},58))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({9,59,54,47,42,230,23,59,43,43,52},58))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58))
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
debug(_d({23,59,43,43,52,230,43,52,58,43,56,43,42,230,54,46,39,57,43,230,248},58))
end
local function finishQueen()
debug(_d({12,47,52,47,57,46,47,52,45,230,23,59,43,43,52},58))
equipSwordOrMelee()
setNavNamed(_d({9,59,54,47,42,230,23,59,43,43,52},58))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({9,59,54,47,42,230,23,59,43,43,52},58))
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
debug(_d({23,59,43,43,52,230,42,43,44,43,39,58,43,42,244,230,22,50,39,52,230,41,53,51,54,50,43,58,43,244},58))
end
local CONFIRMATION_PROMPT_NAME = _d({9,53,52,44,47,56,51,39,58,47,53,52,22,56,53,51,54,58},58)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({24,43,51,53,58,43,11,60,43,52,58},58), 5)
end)
if ok then return result end
debug(_d({45,43,58,24,43,54,50,39,63,24,43,51,53,58,43,230,43,56,56,53,56,0},58), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({22,50,39,63,43,56,13,59,47},58))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({15,51,39,45,43,8,59,58,58,53,52},58)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({40,59,58,58,53,52,28,39,50,59,43},58)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({44,47,52,42,8,59,58,58,53,52,8,63,28,39,50,59,43,230,43,56,56,53,56,0},58), result)
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
if not ok then debug(_d({41,50,47,41,49,13,59,47,8,59,58,58,53,52,230,43,56,56,53,56,0},58), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({47,57,25,43,56,60,43,56},58))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({24,43,51,53,58,43,11,60,43,52,58},58))
or inst:FindFirstChild(_d({41,50,47,43,52,58,11,60,43,52,58},58))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({44,47,52,42,7,52,57,61,43,56,9,53,52,52,43,41,58,53,56,230,43,56,56,53,56,0},58), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({9,53,59,50,42,230,52,53,58,230,50,53,41,39,58,43,230,24,43,51,53,58,43,11,60,43,52,58,245,41,50,47,43,52,58,11,60,43,52,58,230,52,43,39,56,230,24,43,54,50,39,63,230,40,59,58,58,53,52,242,230,44,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,41,50,47,41,49},58))
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
debug(_d({44,47,56,43,24,43,54,50,39,63,28,39,50,59,43,230,43,56,56,53,56,0},58), err, _d({243,230,44,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,41,50,47,41,49},58))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({12,39,50,50,47,52,45,230,40,39,41,49,230,58,53,230,40,59,58,58,53,52,28,39,50,59,43,230,57,43,39,56,41,46,230,44,53,56,230,24,43,54,50,39,63},58))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({24,43,54,50,39,63,230,40,59,58,58,53,52,230,52,53,58,230,44,53,59,52,42,230,43,47,58,46,43,56,242,230,45,47,60,47,52,45,230,59,54},58))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({29,39,47,58,47,52,45,230,44,53,56,230,9,53,52,44,47,56,51,39,58,47,53,52,22,56,53,51,54,58,244,24,43,51,53,58,43,11,60,43,52,58},58))
local remote = getReplayRemote()
if not remote then
debug(_d({9,53,52,44,47,56,51,39,58,47,53,52,22,56,53,51,54,58,245,24,43,51,53,58,43,11,60,43,52,58,230,52,53,58,230,44,53,59,52,42,230,61,47,58,46,47,52,230,58,47,51,43,53,59,58},58))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({12,47,56,47,52,45,230,24,43,54,50,39,63,230,60,47,39,230,9,53,52,44,47,56,51,39,58,47,53,52,22,56,53,51,54,58,244,24,43,51,53,58,43,11,60,43,52,58},58))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({12,47,56,43,25,43,56,60,43,56,230,43,56,56,53,56,0},58), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58), 10)
if not playerGui then
debug(_d({61,39,47,58,12,53,56,21,40,48,43,41,58,47,60,43,57,13,59,47,0,230,52,53,230,22,50,39,63,43,56,13,59,47,230,61,47,58,46,47,52,230,58,47,51,43,53,59,58,242,230,54,56,53,41,43,43,42,47,52,45,230,39,52,63,61,39,63},58))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({21,40,48,43,41,58,47,60,43,57,230,13,27,15,230,44,53,59,52,42,230,243,230,57,58,39,45,43,230,50,53,39,42,43,42},58))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({21,40,48,43,41,58,47,60,43,57,230,13,27,15,230,52,53,58,230,44,53,59,52,42,230,61,47,58,46,47,52,230,58,47,51,43,53,59,58,242,230,54,56,53,41,43,43,42,47,52,45,230,39,52,63,61,39,63},58))
return
end
end
end)
if not ok then debug(_d({61,39,47,58,12,53,56,21,40,48,43,41,58,47,60,43,57,13,59,47,230,43,56,56,53,56,0},58), err) end
end
local function runPlan()
debug(_d({22,50,39,52,230,57,58,39,56,58,43,42},58))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({25,58,39,56,58,47,52,45,230,52,39,60,230,50,53,53,54},58))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({54,53,57,230,246,244,248,57,230,7,12,26,11,24,230,57,58,39,56,58,20,39,60,0},58), rootAfter and rootAfter.Position)
end)
debug(_d({29,39,47,58,47,52,45,230,251,57,230,40,43,44,53,56,43,230,51,53,60,47,52,45,230,58,53,230,25,58,39,45,43,247},58))
task.wait(5)
for _, stage in ipairs({_d({25,58,39,45,43,247},58), _d({25,58,39,45,43,248},58), _d({25,58,39,45,43,249},58), _d({25,58,39,45,43,249,8},58)}) do
if not enabled then return end
local hpTarget = (stage == _d({25,58,39,45,43,249,8},58)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({19,53,60,47,52,45,230,58,53,230,39,56,56,53,61,230,44,50,63,243,42,53,61,52,230,39,56,43,39,230,238,9,59,54,47,42,230,24,39,47,52,239},58))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({10,53,42,45,47,52,45,230,39,56,56,53,61,230,56,39,47,52,230,47,52,230,39,230,57,55,59,39,56,43},58))
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
clearStage(_d({25,58,39,45,43,250},58))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({23,59,43,43,52,230,47,52,230,54,46,39,57,43,230,248,230,243,230,49,43,43,54,47,52,45,230,17,43,52,230,14,39,49,47,230,39,41,58,47,60,43,230,44,56,53,51,230,46,43,56,43,230,53,52},58))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({25,58,39,58,59,43,247},58))
if not enabled then return end
recheckStatue(_d({25,58,39,58,59,43,247},58))
destroyStatue(_d({25,58,39,58,59,43,248},58))
if not enabled then return end
recheckStatue(_d({25,58,39,58,59,43,247},58))
recheckStatue(_d({25,58,39,58,59,43,248},58))
destroyStatue(_d({25,58,39,58,59,43,249},58))
if not enabled then return end
recheckStatue(_d({25,58,39,58,59,43,249},58))
recheckStatue(_d({25,58,39,58,59,43,248},58))
recheckStatue(_d({25,58,39,58,59,43,247},58))
if not enabled then return end
debug(_d({29,39,47,58,47,52,45,230,44,53,56,230,54,46,39,57,43,230,248,230,58,53,230,43,52,42},58))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({22,46,39,57,43,230,248,230,43,52,42,230,61,39,47,58,230,58,47,51,43,53,59,58,242,230,54,56,53,41,43,43,42,47,52,45,230,39,52,63,61,39,63},58))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({19,53,60,47,52,45,230,40,39,41,49,230,58,53,230,23,59,43,43,52,230,57,58,39,45,43,230,54,53,57,47,58,47,53,52},58))
navToPointConfirmed(COORDS.Queen, 30, _d({23,59,43,43,52,230,57,58,39,45,43,230,54,53,57,47,58,47,53,52},58))
debug(_d({29,39,47,58,47,52,45,230,251,57,230,39,58,230,23,59,43,43,52,230,57,58,39,45,43,230,54,53,57,47,58,47,53,52},58))
task.wait(5)
if not enabled then return end
debug(_d({19,53,60,47,52,45,230,58,53,230,54,53,57,58,243,23,59,43,43,52,230,54,53,57,47,58,47,53,52},58))
navToPointConfirmed(COORDS.PostQueen, 30, _d({54,53,57,58,243,23,59,43,43,52,230,54,53,57,47,58,47,53,52},58))
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
local rootBefore = getRoot()
debug(_d({11,52,39,40,50,47,52,45,242,230,54,53,57,230,8,11,12,21,24,11,230,54,50,39,52,0},58), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({22,50,39,52,230,43,56,56,53,56,0},58), err2) end
end)
debug(_d({11,52,39,40,50,43,42,0},58), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({11,52,39,40,50,43,42,0},58), enabled)
end
function CupidDungeon.Start()
if enabled then return end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
if not _G.lazyhub then
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
debug(_d({13,39,51,43,230,50,53,39,42,43,42,242,230,39,59,58,53,243,57,58,39,56,58,47,52,45,230,58,46,43,230,54,50,39,52},58))
CupidDungeon.Start()
end)
debug(_d({25,58,39,52,42,39,50,53,52,43,230,19,53,42,43,0,230,39,59,58,53,243,57,58,39,56,58,47,52,45,230,238,54,56,43,57,57,230,35,230,58,53,230,58,53,45,45,50,43,239},58))
end
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({16,59,64,53,230,58,46,43,230,10,47,39,51,53,52,42,40,39,41,49},58),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({8,39,41,49,54,39,41,49},58))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)) or (bp and bp:FindFirstChild(_d({14,53,56,53,243,14,53,56,53},58)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({20,22,9,57},58))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
local hum = boss:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
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
if key == _d({14,47,58},58) then return target.CFrame
elseif key == _d({26,39,56,45,43,58},58) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({33,14,53,56,53,12,39,56,51,35,230,19,43,58,39,58,39,40,50,43,230,46,53,53,49,230,44,39,47,50,43,42,0,230},58) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({33,14,53,56,53,12,39,56,51,35,230,25,58,53,54,54,43,42,244},58))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({33,14,53,56,53,12,39,56,51,35,230,7,50,56,43,39,42,63,230,56,59,52,52,47,52,45,231},58)) return end
HoroFarm.Running = true
setupHook()
print(_d({33,14,53,56,53,12,39,56,51,35,230,25,58,39,56,58,43,42,230,58,39,56,45,43,58,47,52,45,0,230},58) .. HoroFarm.Config.SelectedBoss)
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
if not _G.lazyhub then
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
print(_d({33,14,53,56,53,12,39,56,51,35,230,25,58,39,52,42,39,50,53,52,43,230,19,53,42,43,0,230,22,56,43,57,57,230,237,35,237,230,58,53,230,58,53,45,45,50,43,244},58))
end
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local function importLib(localPath, rawUrl)
local loaded = false
local result = nil
local oldLazyHub = _G.lazyhub
_G.lazyhub = true
if isfile and readfile then
pcall(function()
if isfile(localPath) then
result = loadstring(readfile(localPath))()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(rawUrl))() end)
end
_G.lazyhub = oldLazyHub
return result
end
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,25,58,53,54,54,43,42,244},58))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,7,50,56,43,39,42,63,230,56,59,52,52,47,52,45,231},58)) return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58), 10)
local hum = char:WaitForChild(_d({14,59,51,39,52,53,47,42},58), 10)
ReplicatedStorage:WaitForChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name, 30)
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58)) or char:FindFirstChild(_d({24,47,44,50,43},58))
if hasRifle then break end
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,20,53,58,230,39,58,230,26,53,61,52,230,53,44,230,8,43,45,47,52,52,47,52,45,57,244,230,22,50,43,39,57,43,230,58,56,39,60,43,50,230,58,46,43,56,43,230,58,53,230,44,39,56,51,230,41,46,43,57,58,57,230,61,46,47,50,43,230,61,39,47,58,47,52,45,230,44,53,56,230,24,47,44,50,43,244},58))
task.wait(2)
continue
end
if not ChestFarmer then
ChestFarmer = importLib(_d({50,47,40,245,41,46,43,57,58,37,44,39,56,51,43,56,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,41,46,43,57,58,37,44,39,56,51,43,56,244,50,59,39},58))
end
if ChestFarmer then
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,39,56,51,47,52,45,230,41,46,43,57,58,57,230,59,52,58,47,50,230,24,47,44,50,43,230,47,57,230,43,55,59,47,54,54,43,42,244,244,244},58))
ChestFarmer.FarmUntilPeli(9999999, function() return 0 end, function()
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58)) or char:FindFirstChild(_d({24,47,44,50,43},58)))
end)
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({24,47,44,50,43},58))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,12,50,63,47,52,45,230,58,53,230,12,47,57,46,51,39,52,230,9,39,60,43,244,244,244},58))
if not EasyTravel then
EasyTravel = importLib(_d({50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58), _d({46,58,58,54,57,0,245,245,56,39,61,244,45,47,58,46,59,40,59,57,43,56,41,53,52,58,43,52,58,244,41,53,51,245,56,53,41,49,63,62,61,39,50,50,245,50,59,39,59,243,41,53,42,43,245,51,39,47,52,245,246,247,37,57,41,56,47,54,58,245,50,47,40,245,43,39,57,63,37,58,56,39,60,43,50,244,50,59,39},58))
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
if not _G.lazyhub then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
print(_d({33,18,43,60,43,50,230,13,56,47,52,42,43,56,35,230,25,58,39,52,42,39,50,53,52,43,230,19,53,42,43,0,230,22,56,43,57,57,230,237,35,237,230,58,53,230,57,58,53,54,244},58))
end
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
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
return char, char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)), char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58)
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
local force = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,12,53,56,41,43},58))
local att = root:FindFirstChild(_d({37,37,11,39,57,63,26,56,39,60,43,50,7,58,58},58))
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
print(_d({33,11,39,57,63,230,26,56,39,60,43,50,35,230,12,50,47,45,46,58,230,43,52,39,40,50,43,42,244},58))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({33,11,39,57,63,230,26,56,39,60,43,50,35,230,12,50,47,45,46,58,230,42,47,57,39,40,50,43,42,244},58))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
if not _G.lazyhub then
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
print(_d({33,11,39,57,63,230,26,56,39,60,43,50,35,230,25,58,39,52,42,39,50,53,52,43,230,19,53,42,43,0,230,22,56,43,57,57,230,237,35,237,230,58,53,230,58,53,45,45,50,43,230,44,50,47,45,46,58,244},58))
end
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({22,50,39,63,43,56,57},58))
local RunService = game:GetService(_d({24,59,52,25,43,56,60,47,41,43},58))
local UserInputService = game:GetService(_d({27,57,43,56,15,52,54,59,58,25,43,56,60,47,41,43},58))
local ReplicatedStorage = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({47,42,50,43},58)
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
print(_d({33,21,60,43,56,61,53,56,50,42,26,43,57,58,43,56,35},58), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({25,58,39,58,57},58) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({24,53,49,59,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,43,54,54,53},58), args)
elseif style == _d({8,50,39,41,49,18,43,45},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49},58), args)
elseif style == _d({17,39,51,47,57,46,47,49,47},58) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,39,51,47,57,46,47,49,47,13,43,54,54,53},58), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,49,63,230,29,39,50,49,248},58), args)
end
debug(_d({12,47,56,43,42,230,13,43,54,54,53,230,24,43,51,53,58,43},58))
end)
if not ok then debug(_d({47,52,60,53,49,43,13,43,54,54,53,230,43,56,56,53,56,0},58), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58)) or Instance.new(_d({7,58,58,39,41,46,51,43,52,58},58))
att.Name = _d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58)
att.Parent = root
local force = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58))
if not force then
force = Instance.new(_d({18,47,52,43,39,56,28,43,50,53,41,47,58,63},58))
force.Name = _d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58)
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
local root = char:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58))
if not root then return end
local force = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,12,53,56,41,43},58))
local att   = root:FindFirstChild(_d({37,37,26,43,57,58,14,53,60,43,56,7,58,58},58))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({29,39,50,49,47,52,45,230,58,53,0},58), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({61,39,50,49,26,53,22,53,47,52,58,230,29,230,42,53,61,52,230,43,56,56,53,56,0},58), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({7,56,56,47,60,43,42,230,39,58,0},58), pos)
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
local root = getRoot()
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({19,53,42,43,50},58)) and item:FindFirstChild(_d({14,59,51,39,52,53,47,42,24,53,53,58,22,39,56,58},58)) and item:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({14,59,51,39,52,53,47,42},58)).Health > 0 then
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
mode = _d({47,42,50,43},58)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({26,43,57,58,43,56,230,10,47,57,39,40,50,43,42},58))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({26,43,57,58,43,56,230,11,52,39,40,50,43,42,244,230,19,53,42,43,0},58), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({22,50,39,63,43,56,230,42,47,43,42,231,230,10,47,57,39,40,50,47,52,45,230,40,53,58,244},58))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({46,53,60,43,56},58) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({42,53,42,45,43},58) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) then
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
local playerGui = LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({21,60,43,56,61,53,56,50,42,26,43,57,58,13,59,47},58))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({25,41,56,43,43,52,13,59,47},58))
screenGui.Name = _d({21,60,43,56,61,53,56,50,42,26,43,57,58,13,59,47},58)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({12,56,39,51,43},58))
frame.Name = _d({19,39,47,52,12,56,39,51,43},58)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({27,15,9,53,56,52,43,56},58))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({182,101,97,103,181,126,85,230,9,59,54,47,42,230,11,52,45,47,52,43,230,21,60,43,56,61,53,56,50,42,230,26,43,57,58},58)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({25,58,39,58,59,57,0,230,15,42,50,43},58)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({26,43,62,58,8,53,62},58))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({14,53,60,43,56,230,7,40,53,60,43,230,26,39,56,45,43,58},58), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({46,53,60,43,56},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,14,53,60,43,56,47,52,45,230},58) .. val .. _d({230,57,58,59,42,57,230,59,54},58)
end)
createInputBtn(_d({10,53,42,45,43,230,9,50,47,51,40},58), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({42,53,42,45,43},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,10,53,42,45,43,243,46,53,50,42,47,52,45,230,238},58) .. val .. _d({230,57,58,59,42,57,239},58)
end)
createInputBtn(_d({26,43,57,58,230,25,55,59,39,56,43,230,10,53,42,45,43},58), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({57,55,59,39,56,43,37,42,53,42,45,43},58))
statusLabel.Text = _d({25,58,39,58,59,57,0,230,25,55,59,39,56,43,230,29,39,50,49,47,52,45,230,238},58) .. val .. _d({230,57,58,59,42,57,239},58)
task.spawn(function()
local root = getRoot()
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
while enabled and mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({57,55,59,39,56,43,37,42,53,42,45,43},58) then
disableBot()
statusLabel.Text = _d({25,58,39,58,59,57,0,230,15,42,50,43,230,238,25,55,59,39,56,43,230,42,53,42,45,43,230,42,53,52,43,239},58)
end
end)
end)
local stopBtn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({11,19,11,24,13,11,20,9,31,230,25,26,21,22},58)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({27,15,9,53,56,52,43,56},58), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({25,58,39,58,59,57,0,230,25,26,21,22,22,11,10,230,238,15,42,50,43,239},58)
local VIM = game:GetService(_d({28,47,56,58,59,39,50,15,52,54,59,58,19,39,52,39,45,43,56},58))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({33,21,60,43,56,61,53,56,50,42,26,43,57,58,43,56,35,230,18,53,39,42,43,42,230,57,59,41,41,43,57,57,44,59,50,50,63,244},58))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({22,50,39,63,43,56,13,59,47},58), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({13,22,21,18,39,59,52,41,46,43,56,27,15},58))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({25,41,56,43,43,52,13,59,47},58))
screenGui.Name = _d({13,22,21,18,39,59,52,41,46,43,56,27,15},58)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({12,56,39,51,43},58))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({27,15,9,53,56,52,43,56},58))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({27,15,25,58,56,53,49,43},58))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({182,101,82,82,230,13,22,21,230,14,59,40,230,18,39,59,52,41,46,43,56},58)
title.Parent = main
local closeBtn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({27,15,9,53,56,52,43,56},58), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({9,46,53,53,57,43,230,39,230,40,53,58,230,53,56,230,59,58,47,50,47,58,63,230,58,53,230,56,59,52,0},58)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({26,43,62,58,8,59,58,58,53,52},58))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({230,230},58) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({27,15,9,53,56,52,43,56},58))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({27,15,25,58,56,53,49,43},58))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({26,43,62,58,18,39,40,43,50},58))
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
CreateLaunchButton(_d({9,59,54,47,42,230,10,59,52,45,43,53,52,230,12,39,56,51},58), _d({7,59,58,53,51,39,58,43,230,41,59,54,47,42,230,42,59,52,45,43,53,52,57,230,236,230,40,53,57,57,230,41,63,41,50,43,57},58), loadCupidDungeon)
CreateLaunchButton(_d({14,53,56,53,230,8,53,57,57,230,12,39,56,51,230,238,25,47,50,43,52,58,230,7,47,51,239},58), _d({7,59,58,53,44,39,56,51,230,53,60,43,56,61,53,56,50,42,230,40,53,57,57,43,57,230,59,57,47,52,45,230,14,53,56,53,230,44,56,59,47,58,57},58), loadHoroBossFarm)
CreateLaunchButton(_d({18,43,60,43,50,230,236,230,19,53,40,230,13,56,47,52,42,43,56},58), _d({7,59,58,53,243,50,43,60,43,50,230,39,52,42,230,44,39,56,51,230,50,53,41,39,50,230,20,22,9,230,51,53,40,57},58), loadLevelGrinder)
CreateLaunchButton(_d({11,39,57,63,230,26,56,39,60,43,50,230,238,22,230,26,53,45,45,50,43,239},58), _d({29,7,25,10,230,12,50,47,45,46,58,230,61,47,58,46,230,45,56,53,59,52,42,230,44,53,50,50,53,61,230,236,230,61,39,50,50,230,41,50,47,51,40,47,52,45},58), loadNavigationLab)
CreateLaunchButton(_d({22,46,63,57,47,41,57,230,21,60,43,56,61,53,56,50,42,230,26,43,57,58,43,56},58), _d({26,43,57,58,230,41,53,51,40,39,58,230,46,53,60,43,56,242,230,45,43,54,54,53,230,236,230,42,53,42,45,43,230,46,43,47,45,46,58,57},58), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({33,13,22,21,230,14,59,40,35,230,18,39,59,52,41,46,43,56,230,27,15,230,47,52,47,58,47,39,50,47,64,43,42,244},58))
end)()