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
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({19,47,36,60,40,53,54},61))
local UserInputService    = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local RunService          = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM                 = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local ReplicatedStorage    = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({30,5,50,54,54,5,50,55,32},61), _d({26,53,50,49,42,227,42,36,48,40,227,165,67,87,227,19,47,36,38,40,12,39,253},61), game.PlaceId, _d({24,49,44,57,40,53,54,40,12,39,253},61), game.GameId, _d({240,227,49,50,55,227,53,56,49,49,44,49,42},61))
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
local LEO_PILLAR_ANIM_ID   = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,248,245,247,247,244,247,244,246,245,250},61)
local LEO_ENTEI_ANIM_ID    = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,248,245,247,247,244,246,251,245,250,251},61)
local LEO_HIKEN_ANIM_ID    = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,248,245,245,243,252,244,250,247,243,250},61)
local LEO_FIREFLY_ANIM_ID  = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,248,245,245,243,245,246,249,244,248,247},61)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({18,37,45,40,38,55,44,57,40,54},61)
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
local REPLAY_BUTTON_VALUE   = _d({21,40,51,47,36,60},61)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({48,50,57,40},61)
local NavState   = {mode = _d({44,39,47,40},61)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({30,5,50,54,54,5,50,55,32},61), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end)
if ok then return root end
debug(_d({42,40,55,21,50,50,55,227,40,53,53,50,53,253},61), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end)
if ok then return hum end
debug(_d({42,40,55,11,56,48,36,49,50,44,39,227,40,53,53,50,53,253},61), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({236,227,50,53,227,12,49,54,55,36,49,38,40,241,49,40,58,235},61)Attachment")
att.Name = _d({34,34,11,50,57,40,53,4,55,55},61)
att.Parent = root
local force = root:FindFirstChild(_d({34,34,11,50,57,40,53,9,50,53,38,40},61))
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = _d({34,34,11,50,57,40,53,9,50,53,38,40},61)
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
debug(_d({42,40,55,18,53,6,53,40,36,55,40,9,50,53,38,40,227,40,53,53,50,53,253},61), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local force = root:FindFirstChild(_d({34,34,11,50,57,40,53,9,50,53,38,40},61))
local att   = root:FindFirstChild(_d({34,34,11,50,57,40,53,4,55,55},61))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({38,47,40,36,49,56,51,9,50,53,38,40,227,40,53,53,50,53,253},61), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({5,56,54,50,16,40,47,40,40},61)) ~= nil
end)
if ok then return result end
debug(_d({44,54,5,56,54,50,4,38,55,44,57,40,227,40,53,53,50,53,253},61), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({5,56,54,50},61))
end)
if not ok then debug(_d({36,38,55,44,57,36,55,40,5,56,54,50,227,40,53,53,50,53,253},61), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({5,56,54,50,227,49,50,55,227,36,38,55,44,57,40,239,227,36,38,55,44,57,36,55,44,49,42},61))
activateBuso()
end
end)
if not ok then debug(_d({5,56,54,50,14,40,40,51,40,53,227,40,53,53,50,53,253},61), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({5,56,54,50,227,46,40,40,51,40,53,227,54,55,50,51,51,40,39},61))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({14,40,49,11,36,46,44},61)) ~= nil
end)
if ok then return result end
debug(_d({44,54,14,40,49,4,38,55,44,57,40,227,40,53,53,50,53,253},61), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({14,40,49},61), true)
end)
if not ok then debug(_d({36,38,55,44,57,36,55,40,14,40,49,227,40,53,53,50,53,253},61), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({14,40,49,227,49,50,55,227,36,38,55,44,57,40,239,227,36,38,55,44,57,36,55,44,49,42},61))
activateKen()
end
end)
if not ok then debug(_d({14,40,49,14,40,40,51,40,53,227,40,53,53,50,53,253},61), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({14,40,49,227,46,40,40,51,40,53,227,54,55,50,51,51,40,39},61))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({17,19,6,54},61)) end)
if ok then return folder end
debug(_d({42,40,55,17,19,6,54,9,50,47,39,40,53,227,40,53,53,50,53,253},61), folder)
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
local r = model:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local h = model:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
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
debug(_d({42,40,55,17,40,36,53,40,54,55,17,19,6,227,40,53,53,50,53,253},61), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum  = model:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({42,40,55,17,19,6,5,60,17,36,48,40,227,40,53,53,50,53,253},61), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({49,51,38,54,21,40,48,36,44,49,44,49,42,227,40,53,53,50,53,253},61), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({6,56,51,44,39,227,20,56,40,40,49},61))
return queen ~= nil and queen:FindFirstChild(_d({48,50,55,44,50,49,15,40,54,54},61)) ~= nil
end)
if ok then return result end
debug(_d({44,54,20,56,40,40,49,19,43,36,54,40,245,227,40,53,53,50,53,253},61), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,244,245,244,245,252,250,252,247,245,245,252,245,250,249,252},61)
local QUEEN_GRASP_ANIM_ID   = _d({53,37,59,36,54,54,40,55,44,39,253,242,242,244,245,252,251,243,243,243,249,244,243,243,244,250,246,247},61)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
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
debug(_d({44,54,19,47,36,60,44,49,42,4,49,44,48,9,53,50,48,15,44,54,55,227,40,53,53,50,53,253},61), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({5,47,50,38,46,44,49,42},61)) ~= nil
end)
if ok then return result end
debug(_d({44,54,17,19,6,5,47,50,38,46,44,49,42,227,40,53,53,50,53,253},61), result)
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
debug(_d({51,53,40,39,44,38,55,17,19,6,19,50,54,44,55,44,50,49,227,40,53,53,50,53,253},61), result)
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
debug(_d({17,50,227,39,36,48,36,42,40,227,50,49},61), model.Name, _d({41,50,53},61), NPC_STUCK_TIMEOUT, _d({54,227,240,227,54,58,44,55,38,43,44,49,42,227,55,36,53,42,40,55},61))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({55,53,36,38,46,17,19,6,7,36,48,36,42,40,227,40,53,53,50,53,253},61), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({16,50,39,40,47},61)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({5,36,54,40,19,36,53,55},61)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({42,40,55,16,50,39,40,47,9,36,38,40,19,50,54,227,40,53,53,50,53,253},61), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({8,49,57},61))
local folder = env and env:FindFirstChild(_d({22,55,36,55,56,40,54},61))
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
debug(_d({42,40,55,22,55,36,55,56,40,16,50,39,40,47,17,40,36,53,227,40,53,53,50,53,253},61), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({37,36,53,53,40,47,11,19},61))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({42,40,55,22,55,36,55,56,40,11,19,227,40,53,53,50,53,253},61), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({23,50,50,47},61)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({41,44,49,39,23,50,50,47,5,60,4,55,55,53,44,37,56,55,40,227,40,53,53,50,53,253},61), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({23,50,50,47},61)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({41,44,49,39,23,50,50,47,5,60,17,36,48,40,227,40,53,53,50,53,253},61), tool)
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
if not ok then debug(_d({40,52,56,44,51,23,50,50,47,227,40,53,53,50,53,253},61), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({23,50,50,47},61)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({41,44,49,39,23,50,50,47,5,60,6,43,44,47,39,17,36,48,40,227,40,53,53,50,53,253},61), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({22,58,50,53,39,8,52,56,44,51},61))
if sword then
equipTool(sword)
return _d({54,58,50,53,39},61)
end
local melee = findToolByAttribute(_d({16,40,47,40,40,23,50,50,47},61))
if melee then
equipTool(melee)
return _d({48,40,47,40,40},61)
end
debug(_d({17,50,227,54,58,50,53,39,227,50,53,227,48,40,47,40,40,227,55,50,50,47,227,41,50,56,49,39},61))
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
if not ok then debug(_d({38,47,44,38,46,16,244,227,40,53,53,50,53,253},61), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({21,50,46,56,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({10,40,51,51,50},61), args)
elseif style == _d({5,47,36,38,46,15,40,42},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46},61), args)
elseif style == _d({14,36,48,44,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,36,48,44,54,43,44,46,44,10,40,51,51,50},61), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46,245},61), args)
end
end)
if not ok then debug(_d({44,49,57,50,46,40,10,40,51,51,50,227,40,53,53,50,53,253},61), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({51,53,40,54,54,22,46,44,47,47,21,227,40,53,53,50,53,253},61), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({43,50,47,39,5,47,50,38,46,227,40,53,53,50,53,253},61), err) end
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
if not ok then debug(_d({43,50,47,39,5,47,50,38,46,26,43,44,47,40,227,40,53,53,50,53,253},61), err) end
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
debug(_d({42,40,55,10,36,48,40,10,227,40,53,53,50,53,253},61), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({44,54,21,40,36,47,16,244,5,56,54,60,227,40,53,53,50,53,253},61), result)
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
return char ~= nil and char:FindFirstChild(_d({54,55,56,49},61)) ~= nil
end)
if ok then return result end
debug(_d({44,54,22,55,56,49,49,40,39,227,40,53,53,50,53,253},61), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({51,53,40,54,54,22,55,56,49,5,53,40,36,46,227,40,53,53,50,53,253},61), err) end
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
debug(_d({52,56,40,40,49,7,50,39,42,40,24,49,55,44,47,22,36,41,40,253,227,20,56,40,40,49,227,42,50,49,40,227,240,227,40,49,39,44,49,42,227,39,50,39,42,40,227,40,36,53,47,60},61))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({52,56,40,40,49,7,50,39,42,40,24,49,55,44,47,22,36,41,40,227,54,36,41,40,55,60,227,55,44,48,40,50,56,55},61))
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
local info = getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({20,56,40,40,49,227,38,36,54,55,44,49,42,227,39,40,55,40,38,55,40,39,227,240,227,39,50,39,42,44,49,42,227,235,58,36,55,38,43,40,53,236},61))
queenDodgeUntilSafe(function() return getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61)) end)
if enabled and getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61)) then
setNavNamed(_d({6,56,51,44,39,227,20,56,40,40,49},61))
end
queenDodging = false
end
end)
if not ok then debug(_d({52,56,40,40,49,7,50,39,42,40,26,36,55,38,43,40,53,227,40,53,53,50,53,253},61), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({51,50,44,49,55},61) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({49,51,38},61) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({49,36,48,40,39},61) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({42,40,55,17,36,57,23,36,53,42,40,55,54,227,40,53,53,50,53,253},61), aimR)
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
debug(_d({38,50,48,51,56,55,40,15,50,38,46,40,39,6,9,53,36,48,40,227,40,53,53,50,53,253},61), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({51,50,44,49,55},61), point = pos}
phase = _d({48,50,57,40},61)
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
if not ok then debug(_d({49,36,57,23,50,19,50,44,49,55,227,42,40,51,51,50,227,38,43,40,38,46,227,40,53,53,50,53,253},61), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({49,51,38},61)}
phase = _d({48,50,57,40},61)
end
function setNavNamed(name)
NavState = {mode = _d({49,36,48,40,39},61), name = name}
phase = _d({48,50,57,40},61)
end
local function setNavIdle()
NavState = {mode = _d({44,39,47,40},61)}
phase = _d({48,50,57,40},61)
end
local function hasArrived()
return phase == _d({43,50,57,40,53},61)
end
local function startNav()
phase = _d({48,50,57,40},61)
debug(_d({17,36,57,227,47,50,50,51,227,18,17},61))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({19,47,36,60,40,53,227,39,44,40,39,228,227,22,55,50,51,51,44,49,42,227,37,50,55,241},61))
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
debug(_d({19,47,36,60,40,53,227,44,54,227,55,50,50,227,41,36,53,227,41,53,50,48,227,55,36,53,42,40,55,227,235,1,245,243,243,243,227,54,55,56,39,54,236,241,227,15,44,46,40,47,60,227,53,40,54,51,36,58,49,40,39,227,36,55,227,47,50,37,37,60,241,227,22,55,50,51,51,44,49,42,227,37,50,55,241},61))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({34,34,51,53,40,57,19,50,54},61))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({15,36,53,42,40,227,51,50,54,44,55,44,50,49,227,45,56,48,51,227,39,40,55,40,38,55,40,39,253},61), delta, _d({54,55,56,39,54,241,227,51,53,40,57,19,50,54,0},61), prevPos, _d({49,40,58,19,50,54,0},61), pos)
end
end
force:SetAttribute(_d({34,34,51,53,40,57,19,50,54},61), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({48,50,57,40},61) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({43,50,57,40,53},61)
debug(_d({19,43,36,54,40,253,227,43,50,57,40,53},61))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({228,228,228,227,21,8,9,24,22,12,17,10,227,23,18,227,4,19,19,15,28,227,4,5,17,18,21,16,4,15,227,25,8,15,18,6,12,23,28,253},61), finalVel, _d({36,44,48,0},61), aim, _d({51,50,54,0},61), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({43,50,57,40,53},61) then
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
debug(_d({6,50,48,37,36,55,227,47,50,38,46,227,54,46,44,51,51,40,39,239},61), snapDist, _d({54,55,56,39,54,227,41,53,50,48,227,55,36,53,42,40,55,227,165,67,87,227,41,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,48,50,57,40},61))
phase = _d({48,50,57,40},61)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({11,40,36,53,55,37,40,36,55,227,40,53,53,50,53,253},61), err) end
end)
end
local function stopNav()
debug(_d({17,36,57,227,47,50,50,51,227,18,9,9},61))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({48,50,57,40},61)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({23,40,59,55,6,43,36,55,22,40,53,57,44,38,40},61))
local channels = TextChatService:FindFirstChild(_d({23,40,59,55,6,43,36,49,49,40,47,54},61))
local channel = channels and channels:FindFirstChild(_d({21,5,27,10,40,49,40,53,36,47},61))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({7,40,41,36,56,47,55,6,43,36,55,22,60,54,55,40,48,6,43,36,55,8,57,40,49,55,54},61))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({22,36,60,16,40,54,54,36,42,40,21,40,52,56,40,54,55},61))
if sayEvent then
sayEvent:FireServer(message, _d({4,47,47},61))
return
end
debug(_d({54,40,49,39,6,43,36,55,16,40,54,54,36,42,40,253,227,49,50,227,23,40,59,55,6,43,36,55,22,40,53,57,44,38,40,241,21,5,27,10,40,49,40,53,36,47,227,50,53,227,47,40,42,36,38,60,227,22,36,60,16,40,54,54,36,42,40,21,40,52,56,40,54,55,227,41,50,56,49,39,227,41,50,53},61), message)
end)
if not ok then debug(_d({54,40,49,39,6,43,36,55,16,40,54,54,36,42,40,227,40,53,53,50,53,253},61), err) end
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
debug(_d({17,50,55,227,48,36,46,44,49,42,227,51,53,50,42,53,40,54,54,227,55,50,58,36,53,39,227,49,36,57,227,55,36,53,42,40,55,227,41,50,53},61), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({54,227,240,227,54,40,49,39,44,49,42,227,242,56,49,54,55,56,38,46},61))
sendChatMessage(_d({242,56,49,54,55,56,38,46},61))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({58,36,44,55,24,49,55,44,47,4,53,53,44,57,40,39,227,55,44,48,40,50,56,55},61))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({49,36,57,23,50,19,50,44,49,55,6,50,49,41,44,53,48,40,39,253},61), label or _d({55,36,53,42,40,55},61), _d({240,227,39,44,39,227,49,50,55,227,36,53,53,44,57,40,227,58,44,55,43,44,49},61), timeout, _d({54,239,227,53,40,55,53,60,44,49,42,227,50,49,38,40},61))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({49,36,57,23,50,19,50,44,49,55,6,50,49,41,44,53,48,40,39,253},61), label or _d({55,36,53,42,40,55},61), _d({240,227,54,55,44,47,47,227,49,50,55,227,36,53,53,44,57,40,39,227,36,41,55,40,53,227,53,40,55,53,60,239,227,51,53,50,38,40,40,39,44,49,42,227,36,49,60,58,36,60},61))
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
if not ok then debug(_d({49,36,57,23,50,19,50,44,49,55,11,50,47,39,44,49,42,5,47,50,38,46,227,46,40,60,240,39,50,58,49,227,40,53,53,50,53,253},61), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({49,36,57,23,50,19,50,44,49,55,11,50,47,39,44,49,42,5,47,50,38,46,227,46,40,60,240,56,51,227,40,53,53,50,53,253},61), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({26,36,47,46,44,49,42,227,55,50,253},61), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({58,36,47,46,23,50,19,50,44,49,55,227,26,227,39,50,58,49,227,40,53,53,50,53,253},61), err) end
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
debug(_d({23,50,50,46,227,39,36,48,36,42,40,227,58,43,44,47,40,227,58,36,47,46,44,49,42,227,55,50,227,51,50,44,49,55,228,227,22,55,50,51,51,44,49,42,227,58,36,47,46,227,55,50,227,40,49,42,36,42,40,241},61))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({4,53,53,44,57,40,39,227,36,55,253},61), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({22,55,56,38,46,227,39,56,53,44,49,42,227,58,36,47,46,239,227,45,56,48,51,44,49,42,228},61))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({22,55,44,47,47,227,54,55,56,38,46,239,227,55,53,44,42,42,40,53,44,49,42,227,10,40,51,51,50,228},61))
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
debug(_d({16,50,57,44,49,42,227,55,50},61), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({26,36,44,55,44,49,42,227,41,50,53,227,17,19,6,54,227,55,50,227,54,51,36,58,49,227,36,55},61), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({227,227,54,51,36,58,49,227,38,43,40,38,46,253,227,41,50,47,39,40,53,227,40,59,44,54,55,54,227,0},61), folder ~= nil,
_d({239,227,38,43,44,47,39,53,40,49,227,0},61), folder and #folder:GetChildren() or 0,
_d({239,227,36,47,44,57,40,227,0},61), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({17,50,227,17,19,6,54,227,36,51,51,40,36,53,40,39,227,36,55},61), stageName, _d({36,41,55,40,53,227,244,248,54,239,227,48,50,57,44,49,42,227,50,49,227,36,49,60,58,36,60},61))
break
end
end
debug(_d({14,44,47,47,44,49,42,227,17,19,6,54,227,36,55},61), stageName)
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
debug(_d({21,40,55,56,53,49,44,49,42,227,55,50},61), stageName, _d({51,50,54,44,55,44,50,49,227,37,40,41,50,53,40,227,48,50,57,44,49,42,227,50,49},61))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({26,36,44,55,44,49,42,227,248,54,227,36,55},61), stageName, _d({51,50,54,44,55,44,50,49},61))
task.wait(5)
debug(_d({26,36,44,55,44,49,42,227,41,50,53},61), targetHP * 100, _d({232,227,11,19,227,37,40,41,50,53,40,227,48,50,57,44,49,42,227,55,50,227,49,40,59,55,227,54,55,36,42,40},61))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({38,47,40,36,53,40,39},61))
end
local function killNamedNPC(name, targetPos)
debug(_d({16,50,57,44,49,42,227,55,50},61), name)
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
debug(name, _d({39,40,41,40,36,55,40,39},61))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({15,40,50,227,51,47,36,60,40,39,227,36,49,44,48,36,55,44,50,49,253},61), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({47,40,50,4,49,44,48,15,50,42,42,40,53,227,51,53,44,49,55,227,40,53,53,50,53,253},61), err2) end
end)
end)
if not ok then debug(_d({54,55,36,53,55,15,40,50,4,49,44,48,15,50,42,42,40,53,227,40,53,53,50,53,253},61), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({16,50,57,44,49,42,227,55,50,227,15,40,50},61))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({15,40,50},61))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({15,40,50},61))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({15,40,50},61))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({15,40,50,227,38,36,54,55,44,49,42},61), which, _d({240,227,39,50,39,42,44,49,42},61))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({15,40,50,227,54,55,36,53,55,40,39,227,37,47,50,38,46,240,37,53,40,36,46,40,53,227,48,44,39,240,37,47,50,38,46,228,227,8,57,36,39,44,49,42,241,241,241},61))
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
if not getNPCByName(_d({15,40,50},61)) then
debug(_d({15,40,50,227,42,50,49,40,227,48,44,39,240,39,50,39,42,40,227,240,227,40,49,39,44,49,42,227,8,49,55,40,44,227,43,50,47,39,227,40,36,53,47,60},61))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({15,40,50},61)) then
setNavNamed(_d({15,40,50},61))
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
debug(_d({15,40,50,227,39,40,41,40,36,55,40,39},61))
stopLeoAnimLogger()
debug(_d({21,40,55,56,53,49,44,49,42,227,55,50,227,15,40,50,227,51,50,54,44,55,44,50,49,227,37,40,41,50,53,40,227,48,50,57,44,49,42,227,50,49},61))
navToPointConfirmed(COORDS.Leo, 30, _d({15,40,50,227,51,50,54,44,55,44,50,49},61))
debug(_d({26,36,44,55,44,49,42,227,248,54,227,36,55,227,15,40,50,227,51,50,54,44,55,44,50,49},61))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({16,50,57,44,49,42,227,55,50},61), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({6,50,56,47,39,227,49,50,55,227,41,44,49,39,227,54,55,36,55,56,40,227,48,50,39,40,47,227,49,40,36,53},61), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({4,55,55,36,38,46,44,49,42},61), coordKey, _d({58,44,55,43},61), weapon or _d({49,50,55,43,44,49,42,227,41,50,56,49,39},61))
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
debug(coordKey, _d({37,36,53,53,40,47,227,39,40,54,55,53,50,60,40,39},61))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({53,40,38,43,40,38,46,22,55,36,55,56,40,253},61), coordKey, _d({240,227,38,50,56,47,39,227,49,50,55,227,41,44,49,39,227,54,55,36,55,56,40,227,48,50,39,40,47,239,227,54,46,44,51,51,44,49,42},61))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({53,40,38,43,40,38,46,22,55,36,55,56,40,253},61), coordKey, _d({54,55,44,47,47,227,36,47,44,57,40,227,235,11,19},61), hp, _d({236,227,240,227,53,40,240,39,40,54,55,53,50,60,44,49,42},61))
destroyStatue(coordKey)
else
debug(_d({53,40,38,43,40,38,46,22,55,36,55,56,40,253},61), coordKey, _d({38,50,49,41,44,53,48,40,39,227,39,40,54,55,53,50,60,40,39},61))
end
end)
if not ok then debug(_d({53,40,38,43,40,38,46,22,55,36,55,56,40,227,40,53,53,50,53,253},61), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({16,50,57,44,49,42,227,55,50,227,20,56,40,40,49},61))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({6,56,51,44,39,227,20,56,40,40,49},61))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61))
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
debug(_d({20,56,40,40,49,227,40,49,55,40,53,40,39,227,51,43,36,54,40,227,245},61))
end
local function finishQueen()
debug(_d({9,44,49,44,54,43,44,49,42,227,20,56,40,40,49},61))
equipSwordOrMelee()
setNavNamed(_d({6,56,51,44,39,227,20,56,40,40,49},61))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61))
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
debug(_d({20,56,40,40,49,227,39,40,41,40,36,55,40,39,241,227,19,47,36,49,227,38,50,48,51,47,40,55,40,241},61))
end
local CONFIRMATION_PROMPT_NAME = _d({6,50,49,41,44,53,48,36,55,44,50,49,19,53,50,48,51,55},61)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({21,40,48,50,55,40,8,57,40,49,55},61), 5)
end)
if ok then return result end
debug(_d({42,40,55,21,40,51,47,36,60,21,40,48,50,55,40,227,40,53,53,50,53,253},61), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({19,47,36,60,40,53,10,56,44},61))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({12,48,36,42,40,5,56,55,55,50,49},61)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({37,56,55,55,50,49,25,36,47,56,40},61)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({41,44,49,39,5,56,55,55,50,49,5,60,25,36,47,56,40,227,40,53,53,50,53,253},61), result)
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
if not ok then debug(_d({38,47,44,38,46,10,56,44,5,56,55,55,50,49,227,40,53,53,50,53,253},61), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({44,54,22,40,53,57,40,53},61))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({21,40,48,50,55,40,8,57,40,49,55},61))
or inst:FindFirstChild(_d({38,47,44,40,49,55,8,57,40,49,55},61))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({41,44,49,39,4,49,54,58,40,53,6,50,49,49,40,38,55,50,53,227,40,53,53,50,53,253},61), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({6,50,56,47,39,227,49,50,55,227,47,50,38,36,55,40,227,21,40,48,50,55,40,8,57,40,49,55,242,38,47,44,40,49,55,8,57,40,49,55,227,49,40,36,53,227,21,40,51,47,36,60,227,37,56,55,55,50,49,239,227,41,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,38,47,44,38,46},61))
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
debug(_d({41,44,53,40,21,40,51,47,36,60,25,36,47,56,40,227,40,53,53,50,53,253},61), err, _d({240,227,41,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,38,47,44,38,46},61))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({9,36,47,47,44,49,42,227,37,36,38,46,227,55,50,227,37,56,55,55,50,49,25,36,47,56,40,227,54,40,36,53,38,43,227,41,50,53,227,21,40,51,47,36,60},61))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({21,40,51,47,36,60,227,37,56,55,55,50,49,227,49,50,55,227,41,50,56,49,39,227,40,44,55,43,40,53,239,227,42,44,57,44,49,42,227,56,51},61))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({26,36,44,55,44,49,42,227,41,50,53,227,6,50,49,41,44,53,48,36,55,44,50,49,19,53,50,48,51,55,241,21,40,48,50,55,40,8,57,40,49,55},61))
local remote = getReplayRemote()
if not remote then
debug(_d({6,50,49,41,44,53,48,36,55,44,50,49,19,53,50,48,51,55,242,21,40,48,50,55,40,8,57,40,49,55,227,49,50,55,227,41,50,56,49,39,227,58,44,55,43,44,49,227,55,44,48,40,50,56,55},61))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({9,44,53,44,49,42,227,21,40,51,47,36,60,227,57,44,36,227,6,50,49,41,44,53,48,36,55,44,50,49,19,53,50,48,51,55,241,21,40,48,50,55,40,8,57,40,49,55},61))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({9,44,53,40,22,40,53,57,40,53,227,40,53,53,50,53,253},61), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61), 10)
if not playerGui then
debug(_d({58,36,44,55,9,50,53,18,37,45,40,38,55,44,57,40,54,10,56,44,253,227,49,50,227,19,47,36,60,40,53,10,56,44,227,58,44,55,43,44,49,227,55,44,48,40,50,56,55,239,227,51,53,50,38,40,40,39,44,49,42,227,36,49,60,58,36,60},61))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({18,37,45,40,38,55,44,57,40,54,227,10,24,12,227,41,50,56,49,39,227,240,227,54,55,36,42,40,227,47,50,36,39,40,39},61))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({18,37,45,40,38,55,44,57,40,54,227,10,24,12,227,49,50,55,227,41,50,56,49,39,227,58,44,55,43,44,49,227,55,44,48,40,50,56,55,239,227,51,53,50,38,40,40,39,44,49,42,227,36,49,60,58,36,60},61))
return
end
end
end)
if not ok then debug(_d({58,36,44,55,9,50,53,18,37,45,40,38,55,44,57,40,54,10,56,44,227,40,53,53,50,53,253},61), err) end
end
local function runPlan()
debug(_d({19,47,36,49,227,54,55,36,53,55,40,39},61))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({22,55,36,53,55,44,49,42,227,49,36,57,227,47,50,50,51},61))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({51,50,54,227,243,241,245,54,227,4,9,23,8,21,227,54,55,36,53,55,17,36,57,253},61), rootAfter and rootAfter.Position)
end)
debug(_d({26,36,44,55,44,49,42,227,248,54,227,37,40,41,50,53,40,227,48,50,57,44,49,42,227,55,50,227,22,55,36,42,40,244},61))
task.wait(5)
for _, stage in ipairs({_d({22,55,36,42,40,244},61), _d({22,55,36,42,40,245},61), _d({22,55,36,42,40,246},61), _d({22,55,36,42,40,246,5},61)}) do
if not enabled then return end
local hpTarget = (stage == _d({22,55,36,42,40,246,5},61)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({16,50,57,44,49,42,227,55,50,227,36,53,53,50,58,227,41,47,60,240,39,50,58,49,227,36,53,40,36,227,235,6,56,51,44,39,227,21,36,44,49,236},61))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({7,50,39,42,44,49,42,227,36,53,53,50,58,227,53,36,44,49,227,44,49,227,36,227,54,52,56,36,53,40},61))
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
clearStage(_d({22,55,36,42,40,247},61))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({20,56,40,40,49,227,44,49,227,51,43,36,54,40,227,245,227,240,227,46,40,40,51,44,49,42,227,14,40,49,227,11,36,46,44,227,36,38,55,44,57,40,227,41,53,50,48,227,43,40,53,40,227,50,49},61))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({22,55,36,55,56,40,244},61))
if not enabled then return end
recheckStatue(_d({22,55,36,55,56,40,244},61))
destroyStatue(_d({22,55,36,55,56,40,245},61))
if not enabled then return end
recheckStatue(_d({22,55,36,55,56,40,244},61))
recheckStatue(_d({22,55,36,55,56,40,245},61))
destroyStatue(_d({22,55,36,55,56,40,246},61))
if not enabled then return end
recheckStatue(_d({22,55,36,55,56,40,246},61))
recheckStatue(_d({22,55,36,55,56,40,245},61))
recheckStatue(_d({22,55,36,55,56,40,244},61))
if not enabled then return end
debug(_d({26,36,44,55,44,49,42,227,41,50,53,227,51,43,36,54,40,227,245,227,55,50,227,40,49,39},61))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({19,43,36,54,40,227,245,227,40,49,39,227,58,36,44,55,227,55,44,48,40,50,56,55,239,227,51,53,50,38,40,40,39,44,49,42,227,36,49,60,58,36,60},61))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({16,50,57,44,49,42,227,37,36,38,46,227,55,50,227,20,56,40,40,49,227,54,55,36,42,40,227,51,50,54,44,55,44,50,49},61))
navToPointConfirmed(COORDS.Queen, 30, _d({20,56,40,40,49,227,54,55,36,42,40,227,51,50,54,44,55,44,50,49},61))
debug(_d({26,36,44,55,44,49,42,227,248,54,227,36,55,227,20,56,40,40,49,227,54,55,36,42,40,227,51,50,54,44,55,44,50,49},61))
task.wait(5)
if not enabled then return end
debug(_d({16,50,57,44,49,42,227,55,50,227,51,50,54,55,240,20,56,40,40,49,227,51,50,54,44,55,44,50,49},61))
navToPointConfirmed(COORDS.PostQueen, 30, _d({51,50,54,55,240,20,56,40,40,49,227,51,50,54,44,55,44,50,49},61))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({8,49,36,37,47,44,49,42,239,227,51,50,54,227,5,8,9,18,21,8,227,51,47,36,49,253},61), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({19,47,36,49,227,40,53,53,50,53,253},61), err2) end
end)
debug(_d({8,49,36,37,47,40,39,253},61), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({8,49,36,37,47,40,39,253},61), enabled)
end
UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
local ok, err = pcall(function()
if input.KeyCode ~= TOGGLE_KEY then return end
if enabled then
disableBot()
else
enableBot()
end
end)
if not ok then debug(_d({12,49,51,56,55,5,40,42,36,49,227,40,53,53,50,53,253},61), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({10,36,48,40,227,47,50,36,39,40,39,239,227,36,56,55,50,240,54,55,36,53,55,44,49,42,227,55,43,40,227,51,47,36,49},61))
enableBot()
end)
if not ok then debug(_d({4,56,55,50,54,55,36,53,55,227,40,53,53,50,53,253},61), err) end
end)
debug(_d({15,50,36,39,40,39,227,165,67,87,227,36,56,55,50,240,54,55,36,53,55,44,49,42,227,50,49,38,40,227,55,43,40,227,42,36,48,40,227,41,44,49,44,54,43,40,54,227,47,50,36,39,44,49,42,227,235,51,53,40,54,54,227,19,227,55,50,227,55,50,42,42,47,40,227,48,36,49,56,36,47,47,60,236},61))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({43,55,55,51,54,253,242,242,53,36,58,241,42,44,55,43,56,37,56,54,40,53,38,50,49,55,40,49,55,241,38,50,48,242,53,50,38,46,60,59,58,36,47,47,242,21,36,60,41,44,40,47,39,242,48,36,44,49,242,54,50,56,53,38,40,241,47,56,36},61)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({30,11,50,53,50,227,57,245,32,227,9,36,44,47,40,39,227,55,50,227,47,50,36,39,227,21,36,60,41,44,40,47,39,227,24,12,227,15,44,37,53,36,53,60,241},61))
end
local Window = Rayfield:CreateWindow({
Name = _d({11,50,53,50,227,11,50,53,50,227,29,240,9,36,53,48,227,57,245},61),
LoadingTitle = _d({15,50,36,39,44,49,42,227,11,50,53,50,227,57,245,241,241,241},61),
LoadingSubtitle = _d({22,44,47,40,49,55,227,4,44,48,227,18,51,55,44,48,44,61,40,39},61),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.HoroSelectedBoss = nil
_G.HoroAutoZLoop = false
local checkSpawnInterval = 60
local useE = true
local useZ = true
local useC = true
local useR = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({4,56,55,50,227,9,36,53,48},61), 4483362458)
local SkillTab = Window:CreateTab(_d({22,46,44,47,47,227,22,40,55,55,44,49,42,54},61), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({11,50,53,50,240,11,50,53,50},61)) or (bp and bp:FindFirstChild(_d({11,50,53,50,240,11,50,53,50},61)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = boss:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
if not _G.HoroMouseHooked then
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and _G.HoroAutoZLoop and _G.HoroSelectedBoss then
local target = getBossPart(_G.HoroSelectedBoss)
if target then
if key == _d({11,44,55},61) then
return target.CFrame
elseif key == _d({23,36,53,42,40,55},61) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({30,11,50,53,50,227,57,245,32,227,16,40,55,36,55,36,37,47,40,227,43,50,50,46,227,41,36,44,47,40,39,253,227},61) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({30,11,50,53,50,227,57,245,32,227,6,47,40,36,49,40,39,227,56,51,227,51,53,40,57,44,50,56,54,227,54,40,54,54,44,50,49,241},61))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({22,55,36,55,56,54,253,227,26,36,44,55,44,49,42,227,41,50,53,227,5,50,54,54,227,22,51,36,58,49},61)) end
print(_d({30,11,50,53,50,227,57,245,32,227,5,50,54,54},61), _G.HoroSelectedBoss, _d({44,54,227,49,50,55,227,54,51,36,58,49,40,39,241,227,26,36,44,55,44,49,42,241,241,241},61))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({22,55,36,55,56,54,253,227,21,56,49,49,44,49,42,227,6,50,48,37,50},61)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({30,11,50,53,50,227,57,245,32,227,9,44,53,40,39,227,6,227,235,14,36,48,44,46,36,61,40,236},61))
elseif useZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
print(_d({30,11,50,53,50,227,57,245,32,227,9,44,53,40,39,227,29,227,235,16,44,49,44,227,5,36,53,53,36,42,40,236},61))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({30,11,50,53,50,227,57,245,32,227,9,44,53,40,39,227,8,227,235,22,55,56,49,236},61))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({30,11,50,53,50,227,57,245,32,227,9,44,53,40,39,227,21,227,235,7,40,55,50,49,36,55,44,50,49,236},61))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({22,55,36,55,56,54,253,227,22,47,40,40,51,44,49,42,227,235},61) .. string.format(_d({232,241,244,41},61), finalSleep) .. _d({54,236},61)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({22,55,36,55,56,54,253,227,12,39,47,40},61))
MainTab:CreateDropdown({
Name = _d({22,40,47,40,38,55,227,5,50,54,54},61),
Options = {_d({4,59,40,227,11,36,49,39,227,15,50,42,36,49},61), _d({5,36,49,39,44,55,227,5,50,54,54},61), _d({13,56,61,50,227,55,43,40,227,7,44,36,48,50,49,39,37,36,38,46},61)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({30,11,50,53,50,227,57,245,32,227,22,40,47,40,38,55,40,39,227,55,36,53,42,40,55,253},61), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({22,55,36,53,55,227,4,56,55,50,227,9,36,53,48},61),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({22,40,47,40,38,55,227,5,50,54,54,227,21,40,52,56,44,53,40,39},61),
Content = _d({28,50,56,227,48,56,54,55,227,54,40,47,40,38,55,227,36,227,37,50,54,54,227,41,44,53,54,55,227,37,40,41,50,53,40,227,40,49,36,37,47,44,49,42,227,4,56,55,50,227,9,36,53,48,228},61),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({22,55,36,55,56,54,253,227,12,39,47,40},61)) end
end
print(_d({30,11,50,53,50,227,57,245,32,227,4,56,55,50,227,9,36,53,48,253},61), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({7,40,54,55,53,50,60,227,24,12},61),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Use E (Stun)",
CurrentValue = true,
Callback = function(Value) useE = Value end,
})
SkillTab:CreateToggle({
Name = "Use Z (Mini)",
CurrentValue = true,
Callback = function(Value) useZ = Value end,
})
SkillTab:CreateToggle({
Name = "Use C (Kamikaze)",
CurrentValue = true,
Callback = function(Value) useC = Value end,
})
SkillTab:CreateToggle({
Name = "Use R (Snap)",
CurrentValue = true,
Callback = function(Value) useR = Value end,
})
})();
end
local function loadLevelGrinder()
(function()
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = "Bandit"
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild("Stats_d({236,227,36,49,39,227,54,55,36,55,54,9,50,47,39,40,53,241,22,55,36,55,54,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,235},61)Level") and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild("Stats_d({236,227,36,49,39,227,54,55,36,55,54,9,50,47,39,40,53,241,22,55,36,55,54,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,235},61)Peli") and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild("Quest_d({236,227,36,49,39,227,54,55,36,55,54,9,50,47,39,40,53,241,20,56,40,54,55,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,235},61)CurrentQuest_d({236,227,36,49,39,227,54,55,36,55,54,9,50,47,39,40,53,241,20,56,40,54,55,241,6,56,53,53,40,49,55,20,56,40,54,55,241,25,36,47,56,40,227,50,53,227},61)None"
return lvl, peli, quest
end
return 1, 0, "None"
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = npc:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
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
if part:IsA(_d({5,36,54,40,19,36,53,55},61)) then
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
loadstring(game:HttpGet("https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/features/easy_travel.lua"))()
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
warn("[Gepo Grinder] _G.EasyTravel is missing. Please ensure easy_travel.lua is running first.")
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
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild("UpperTorso")
local prompt = torso and torso:FindFirstChild("Prompt")
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
warn("[Quest Acceptance] fireproximityprompt not supported by executor!")
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({19,47,36,60,40,53,10,56,44},61))
local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild("go")
local endChatBtn = chatGui.Frame:FindFirstChild("endChat")
if goBtn and goBtn.Visible and goBtn.Text ~= "_d({227,36,49,39,227,42,50,5,55,49,241,23,40,59,55,227,65,0,227},61)..." then
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
print("[Gepo Grinder] Auto farm toggled to: " .. tostring(autoGrind))
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild("Rifle_d({236,227,50,53,227,15,50,38,36,47,19,47,36,60,40,53,241,6,43,36,53,36,38,55,40,53,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,235},61)Rifle")
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = "Bandit"
if lvl < 3 then
if quest == "None" then
acceptQuest("Daph")
return
end
else
if quest == "None" then
acceptQuest("Sarah")
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({5,36,49,39,44,55,227,5,50,54,54},61)
if quest == "None" then
acceptQuest("Ronny")
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild("BuyableItems")
local shopItem = buyables and buyables:FindFirstChild("Rifle")
local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")
if shopPart then
local reached = navigateTo(shopPart.Position + Vector3.new(0, hoverHeight, 0))
if reached then
stopNavigation()
myRoot.CFrame = shopPart.CFrame + Vector3.new(0, 2, 0)
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Rifle Purchase] fireproximityprompt not supported by executor!")
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print("[Gepo Grinder] Rifle purchased! Starter Island progression completed. Waiting for Fishman Cave travel phase.")
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({5,36,38,46,51,36,38,46},61))
local weaponTool = bp and bp:FindFirstChild("Melee")
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({236,227,36,49,39,227,49,51,38,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,26,43,44,38,43,12,54,4,235},61)Humanoid").Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({236,227,36,49,39,227,41,44,49,36,47,17,51,38,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,26,43,44,38,43,12,54,4,235},61)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({236,227,36,49,39,227,41,44,49,36,47,17,51,38,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,26,43,44,38,43,12,54,4,235},61)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({17,19,6,54},61))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print("[Gepo Grinder] Cleaned up previous session.")
end
print("[Gepo Grinder] Automated script loaded. Press 'P' to toggle auto farm.")
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil
_G.EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
local hum = char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({236,227,50,53,227,12,49,54,55,36,49,38,40,241,49,40,58,235},61)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = "__EasyTravelForce"
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
local force = root:FindFirstChild("__EasyTravelForce")
local att = root:FindFirstChild("__EasyTravelAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function getSurfaceY(position, character)
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
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
if _G.EasyTravel.TargetPosition then
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
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
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = _G.EasyTravel.TargetPosition.Y
else
if not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (currentSpeed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print("[Easy Travel] Flight enabled.")
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print("[Easy Travel] Flight disabled.")
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
elseif input.KeyCode == Enum.KeyCode.End then
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end
end)
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
print("[Easy Travel] Completely unloaded and cleaned up script state.")
end
print("[Easy Travel] Loaded. Press 'P' to toggle flight. _G.EasyTravel API registered.")
return _G.EasyTravel
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({19,47,36,60,40,53,54},61))
local RunService = game:GetService(_d({21,56,49,22,40,53,57,44,38,40},61))
local UserInputService = game:GetService(_d({24,54,40,53,12,49,51,56,55,22,40,53,57,44,38,40},61))
local ReplicatedStorage = game:GetService(_d({21,40,51,47,44,38,36,55,40,39,22,55,50,53,36,42,40},61))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({44,39,47,40},61)
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
print("[OverworldTester]", ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({22,55,36,55,54},61) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({21,50,46,56,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({10,40,51,51,50},61), args)
elseif style == _d({5,47,36,38,46,15,40,42},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46},61), args)
elseif style == _d({14,36,48,44,54,43,44,46,44},61) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,36,48,44,54,43,44,46,44,10,40,51,51,50},61), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,46,60,227,26,36,47,46,245},61), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({44,49,57,50,46,40,10,40,51,51,50,227,40,53,53,50,53,253},61), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({236,227,50,53,227,12,49,54,55,36,49,38,40,241,49,40,58,235},61)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({15,44,49,40,36,53,25,40,47,50,38,44,55,60},61))
force.Name = "__TestHoverForce"
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
local root = char:FindFirstChild(_d({11,56,48,36,49,50,44,39,21,50,50,55,19,36,53,55},61))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({26,36,47,46,44,49,42,227,55,50,253},61), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({58,36,47,46,23,50,19,50,44,49,55,227,26,227,39,50,58,49,227,40,53,53,50,53,253},61), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({4,53,53,44,57,40,39,227,36,55,253},61), pos)
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
if item:IsA("Model_d({236,227,36,49,39,227,44,55,40,48,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,235},61)HumanoidRootPart_d({236,227,36,49,39,227,44,55,40,48,253,9,44,49,39,9,44,53,54,55,6,43,44,47,39,26,43,44,38,43,12,54,4,235},61)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({11,56,48,36,49,50,44,39},61)).Health > 0 then
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
mode = _d({44,39,47,40},61)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug("Tester Disabled")
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug("Tester Enabled. Mode:", mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug("Player died! Disabling bot.")
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({43,50,57,40,53},61) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == "dodge" then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == "square_dodge" then
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
local playerGui = LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild("OverworldTestGui")
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OverworldTestGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🛡️ Cupid Engine Overworld Test"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({22,55,36,55,56,54,253,227,12,39,47,40},61)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn("Hover Above Target", 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({43,50,57,40,53},61))
statusLabel.Text = "Status: Hovering _d({227,241,241,227,57,36,47,227,241,241,227},61) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({227,241,241,227,57,36,47,227,241,241,227},61) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({227,241,241,227,57,36,47,227,241,241,227},61) studs)"
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
while enabled and mode == "square_dodge" and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == "square_dodge" then
disableBot()
statusLabel.Text = "Status: Idle (Square dodge done)"
end
end)
end)
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = "EMERGENCY STOP"
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = "Status: STOPPED (Idle)"
local VIM = game:GetService(_d({25,44,53,55,56,36,47,12,49,51,56,55,16,36,49,36,42,40,53},61))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({19,47,36,60,40,53,10,56,44},61), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild("GPOLauncherUI")
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GPOLauncherUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "🌌 GPO Hub Launcher"
title.Parent = main
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = "Choose a bot or utility to run:"
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = "  " .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new("TextLabel")
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
CreateLaunchButton("Cupid Dungeon Farm_d({239,227},61)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({239,227},61)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({239,227},61)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({239,227},61)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({239,227},61)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()