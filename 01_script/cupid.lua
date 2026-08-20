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
local att = root:FindFirstChild(_d({34,34,11,50,57,40,53,4,55,55},61)) or Instance.new(_d({4,55,55,36,38,43,48,40,49,55},61))
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
local function invokeGeppo()
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
local navToPoint, setNavNamed
local function queenDodgeUntilSafe(getInfoFn)
local info = getInfoFn()
if not info then return end
local root = getRoot()
local myPos = root and root.Position or info.root.Position
navToPoint(myPos + Vector3.new(0, QUEEN_DODGE_DISTANCE, 0), true)
local t = 0
local sinceGeppo = 0
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
sinceGeppo += 0.1
if sinceGeppo >= GEPPO_HOLD_INTERVAL then
invokeGeppo()
sinceGeppo = 0
end
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
local function clearStage(stageName)
debug(_d({16,50,57,44,49,42,227,55,50},61), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
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
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({21,40,55,56,53,49,44,49,42,227,55,50},61), stageName, _d({51,50,54,44,55,44,50,49,227,37,40,41,50,53,40,227,48,50,57,44,49,42,227,50,49},61))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({26,36,44,55,44,49,42,227,248,54,227,36,55},61), stageName, _d({51,50,54,44,55,44,50,49},61))
task.wait(5)
debug(stageName, _d({38,47,40,36,53,40,39},61))
end
local function killNamedNPC(name, targetPos)
debug(_d({16,50,57,44,49,42,227,55,50},61), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
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
debug(_d({16,50,57,44,49,42,227,55,50,227,15,40,50,227,235,37,47,50,38,46,44,49,42,227,36,41,55,40,53},61), LEO_BLOCK_DELAY, _d({54,236},61))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({15,40,50},61))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({15,40,50},61))
while enabled do
local info = getNPCByName(_d({15,40,50},61))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({15,40,50,227,38,36,54,55,44,49,42},61), which, _d({240,227,39,50,39,42,44,49,42},61))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
holdBlock(LEO_QUICK_BLOCK_DURATION)
else
local root = getRoot()
local myPos = root and root.Position or info.root.Position
local awayPoint = myPos + Vector3.new(0, LEO_DODGE_DISTANCE, 0)
navToPoint(awayPoint, true)
if which == LEO_ENTEI_ANIM_ID then
local held = 0
while enabled and held < 6 do
task.wait(GEPPO_HOLD_INTERVAL)
held += GEPPO_HOLD_INTERVAL
if not getNPCByName(_d({15,40,50},61)) then
debug(_d({15,40,50,227,42,50,49,40,227,48,44,39,240,39,50,39,42,40,227,240,227,40,49,39,44,49,42,227,8,49,55,40,44,227,43,50,47,39,227,40,36,53,47,60},61))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({15,40,50},61)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({15,40,50,227,42,50,49,40,227,48,44,39,240,39,50,39,42,40,227,240,227,40,49,39,44,49,42,227,9,47,36,48,40,227,19,44,47,47,36,53,227,43,50,47,39,227,40,36,53,47,60},61))
end
end
end
if enabled and getNPCByName(_d({15,40,50},61)) then
setNavNamed(_d({15,40,50},61))
end
else
equipSwordOrMelee()
if isNPCBlocking(info.model) then
pressSkillR()
elseif not isRealM1Busy() then
clickM1(0.05)
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
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({6,56,51,44,39,227,20,56,40,40,49},61))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
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
while enabled and getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({6,56,51,44,39,227,20,56,40,40,49},61))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
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
clearStage(stage)
end
if not enabled then return end
debug(_d({16,50,57,44,49,42,227,55,50,227,36,53,53,50,58,227,41,47,60,240,39,50,58,49,227,36,53,40,36},61))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({7,50,39,42,44,49,42,227,36,53,53,50,58,227,53,36,44,49},61))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
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
local function disableBot()
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
end)()