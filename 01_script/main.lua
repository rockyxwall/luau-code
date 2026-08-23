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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({26,54,43,67,47,60,61},54))
local UserInputService    = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local RunService          = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM                 = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local ReplicatedStorage    = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({37,12,57,61,61,12,57,62,39},54), _d({33,60,57,56,49,234,49,43,55,47,234,172,74,94,234,26,54,43,45,47,19,46,4},54), game.PlaceId, _d({31,56,51,64,47,60,61,47,19,46,4},54), game.GameId, _d({247,234,56,57,62,234,60,63,56,56,51,56,49},54))
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
local LEO_PILLAR_ANIM_ID   = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,254,254,251,254,251,253,252,1},54)
local LEO_ENTEI_ANIM_ID    = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,254,254,251,253,2,252,1,2},54)
local LEO_HIKEN_ANIM_ID    = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,252,250,3,251,1,254,250,1},54)
local LEO_FIREFLY_ANIM_ID  = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,252,250,252,253,0,251,255,254},54)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({25,44,52,47,45,62,51,64,47,61},54)
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
local REPLAY_BUTTON_VALUE   = _d({28,47,58,54,43,67},54)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({55,57,64,47},54)
local NavState   = {mode = _d({51,46,54,47},54)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({37,12,57,61,61,12,57,62,39},54), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end)
if ok then return root end
debug(_d({49,47,62,28,57,57,62,234,47,60,60,57,60,4},54), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end)
if ok then return hum end
debug(_d({49,47,62,18,63,55,43,56,57,51,46,234,47,60,60,57,60,4},54), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({243,234,57,60,234,19,56,61,62,43,56,45,47,248,56,47,65,242},54)Attachment")
att.Name = _d({41,41,18,57,64,47,60,11,62,62},54)
att.Parent = root
local force = root:FindFirstChild(_d({41,41,18,57,64,47,60,16,57,60,45,47},54))
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = _d({41,41,18,57,64,47,60,16,57,60,45,47},54)
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
debug(_d({49,47,62,25,60,13,60,47,43,62,47,16,57,60,45,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local force = root:FindFirstChild(_d({41,41,18,57,64,47,60,16,57,60,45,47},54))
local att   = root:FindFirstChild(_d({41,41,18,57,64,47,60,11,62,62},54))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({45,54,47,43,56,63,58,16,57,60,45,47,234,47,60,60,57,60,4},54), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({12,63,61,57,23,47,54,47,47},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,12,63,61,57,11,45,62,51,64,47,234,47,60,60,57,60,4},54), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({12,63,61,57},54))
end)
if not ok then debug(_d({43,45,62,51,64,43,62,47,12,63,61,57,234,47,60,60,57,60,4},54), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({12,63,61,57,234,56,57,62,234,43,45,62,51,64,47,246,234,43,45,62,51,64,43,62,51,56,49},54))
activateBuso()
end
end)
if not ok then debug(_d({12,63,61,57,21,47,47,58,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({12,63,61,57,234,53,47,47,58,47,60,234,61,62,57,58,58,47,46},54))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({21,47,56,18,43,53,51},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,21,47,56,11,45,62,51,64,47,234,47,60,60,57,60,4},54), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({21,47,56},54), true)
end)
if not ok then debug(_d({43,45,62,51,64,43,62,47,21,47,56,234,47,60,60,57,60,4},54), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({21,47,56,234,56,57,62,234,43,45,62,51,64,47,246,234,43,45,62,51,64,43,62,51,56,49},54))
activateKen()
end
end)
if not ok then debug(_d({21,47,56,21,47,47,58,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({21,47,56,234,53,47,47,58,47,60,234,61,62,57,58,58,47,46},54))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({24,26,13,61},54)) end)
if ok then return folder end
debug(_d({49,47,62,24,26,13,61,16,57,54,46,47,60,234,47,60,60,57,60,4},54), folder)
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
local r = model:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local h = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
debug(_d({49,47,62,24,47,43,60,47,61,62,24,26,13,234,47,60,60,57,60,4},54), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum  = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({49,47,62,24,26,13,12,67,24,43,55,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({56,58,45,61,28,47,55,43,51,56,51,56,49,234,47,60,60,57,60,4},54), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({13,63,58,51,46,234,27,63,47,47,56},54))
return queen ~= nil and queen:FindFirstChild(_d({55,57,62,51,57,56,22,47,61,61},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,27,63,47,47,56,26,50,43,61,47,252,234,47,60,60,57,60,4},54), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,251,252,251,252,3,1,3,254,252,252,3,252,1,0,3},54)
local QUEEN_GRASP_ANIM_ID   = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,251,252,3,2,250,250,250,0,251,250,250,251,1,253,254},54)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
debug(_d({51,61,26,54,43,67,51,56,49,11,56,51,55,16,60,57,55,22,51,61,62,234,47,60,60,57,60,4},54), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({12,54,57,45,53,51,56,49},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,24,26,13,12,54,57,45,53,51,56,49,234,47,60,60,57,60,4},54), result)
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
debug(_d({58,60,47,46,51,45,62,24,26,13,26,57,61,51,62,51,57,56,234,47,60,60,57,60,4},54), result)
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
debug(_d({24,57,234,46,43,55,43,49,47,234,57,56},54), model.Name, _d({48,57,60},54), NPC_STUCK_TIMEOUT, _d({61,234,247,234,61,65,51,62,45,50,51,56,49,234,62,43,60,49,47,62},54))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({62,60,43,45,53,24,26,13,14,43,55,43,49,47,234,47,60,60,57,60,4},54), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({23,57,46,47,54},54)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({12,43,61,47,26,43,60,62},54)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({49,47,62,23,57,46,47,54,16,43,45,47,26,57,61,234,47,60,60,57,60,4},54), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({15,56,64},54))
local folder = env and env:FindFirstChild(_d({29,62,43,62,63,47,61},54))
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
debug(_d({49,47,62,29,62,43,62,63,47,23,57,46,47,54,24,47,43,60,234,47,60,60,57,60,4},54), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({44,43,60,60,47,54,18,26},54))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({49,47,62,29,62,43,62,63,47,18,26,234,47,60,60,57,60,4},54), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,11,62,62,60,51,44,63,62,47,234,47,60,60,57,60,4},54), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({30,57,57,54},54)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,24,43,55,47,234,47,60,60,57,60,4},54), tool)
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
if not ok then debug(_d({47,59,63,51,58,30,57,57,54,234,47,60,60,57,60,4},54), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,13,50,51,54,46,24,43,55,47,234,47,60,60,57,60,4},54), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({29,65,57,60,46,15,59,63,51,58},54))
if sword then
equipTool(sword)
return _d({61,65,57,60,46},54)
end
local melee = findToolByAttribute(_d({23,47,54,47,47,30,57,57,54},54))
if melee then
equipTool(melee)
return _d({55,47,54,47,47},54)
end
debug(_d({24,57,234,61,65,57,60,46,234,57,60,234,55,47,54,47,47,234,62,57,57,54,234,48,57,63,56,46},54))
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
if not ok then debug(_d({45,54,51,45,53,23,251,234,47,60,60,57,60,4},54), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
end
end)
if not ok then debug(_d({51,56,64,57,53,47,17,47,58,58,57,234,47,60,60,57,60,4},54), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({58,60,47,61,61,29,53,51,54,54,28,234,47,60,60,57,60,4},54), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({50,57,54,46,12,54,57,45,53,234,47,60,60,57,60,4},54), err) end
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
if not ok then debug(_d({50,57,54,46,12,54,57,45,53,33,50,51,54,47,234,47,60,60,57,60,4},54), err) end
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
debug(_d({49,47,62,17,43,55,47,17,234,47,60,60,57,60,4},54), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({51,61,28,47,43,54,23,251,12,63,61,67,234,47,60,60,57,60,4},54), result)
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
return char ~= nil and char:FindFirstChild(_d({61,62,63,56},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,29,62,63,56,56,47,46,234,47,60,60,57,60,4},54), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({58,60,47,61,61,29,62,63,56,12,60,47,43,53,234,47,60,60,57,60,4},54), err) end
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
debug(_d({59,63,47,47,56,14,57,46,49,47,31,56,62,51,54,29,43,48,47,4,234,27,63,47,47,56,234,49,57,56,47,234,247,234,47,56,46,51,56,49,234,46,57,46,49,47,234,47,43,60,54,67},54))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({59,63,47,47,56,14,57,46,49,47,31,56,62,51,54,29,43,48,47,234,61,43,48,47,62,67,234,62,51,55,47,57,63,62},54))
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
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({27,63,47,47,56,234,45,43,61,62,51,56,49,234,46,47,62,47,45,62,47,46,234,247,234,46,57,46,49,51,56,49,234,242,65,43,62,45,50,47,60,243},54))
queenDodgeUntilSafe(function() return getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) end)
if enabled and getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) then
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
end
queenDodging = false
end
end)
if not ok then debug(_d({59,63,47,47,56,14,57,46,49,47,33,43,62,45,50,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({58,57,51,56,62},54) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({56,58,45},54) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({56,43,55,47,46},54) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({49,47,62,24,43,64,30,43,60,49,47,62,61,234,47,60,60,57,60,4},54), aimR)
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
debug(_d({45,57,55,58,63,62,47,22,57,45,53,47,46,13,16,60,43,55,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({58,57,51,56,62},54), point = pos}
phase = _d({55,57,64,47},54)
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
if not ok then debug(_d({56,43,64,30,57,26,57,51,56,62,234,49,47,58,58,57,234,45,50,47,45,53,234,47,60,60,57,60,4},54), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({56,58,45},54)}
phase = _d({55,57,64,47},54)
end
function setNavNamed(name)
NavState = {mode = _d({56,43,55,47,46},54), name = name}
phase = _d({55,57,64,47},54)
end
local function setNavIdle()
NavState = {mode = _d({51,46,54,47},54)}
phase = _d({55,57,64,47},54)
end
local function hasArrived()
return phase == _d({50,57,64,47,60},54)
end
local function startNav()
phase = _d({55,57,64,47},54)
debug(_d({24,43,64,234,54,57,57,58,234,25,24},54))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({26,54,43,67,47,60,234,46,51,47,46,235,234,29,62,57,58,58,51,56,49,234,44,57,62,248},54))
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
debug(_d({26,54,43,67,47,60,234,51,61,234,62,57,57,234,48,43,60,234,48,60,57,55,234,62,43,60,49,47,62,234,242,8,252,250,250,250,234,61,62,63,46,61,243,248,234,22,51,53,47,54,67,234,60,47,61,58,43,65,56,47,46,234,43,62,234,54,57,44,44,67,248,234,29,62,57,58,58,51,56,49,234,44,57,62,248},54))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({41,41,58,60,47,64,26,57,61},54))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({22,43,60,49,47,234,58,57,61,51,62,51,57,56,234,52,63,55,58,234,46,47,62,47,45,62,47,46,4},54), delta, _d({61,62,63,46,61,248,234,58,60,47,64,26,57,61,7},54), prevPos, _d({56,47,65,26,57,61,7},54), pos)
end
end
force:SetAttribute(_d({41,41,58,60,47,64,26,57,61},54), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({55,57,64,47},54) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({50,57,64,47,60},54)
debug(_d({26,50,43,61,47,4,234,50,57,64,47,60},54))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({235,235,235,234,28,15,16,31,29,19,24,17,234,30,25,234,11,26,26,22,35,234,11,12,24,25,28,23,11,22,234,32,15,22,25,13,19,30,35,4},54), finalVel, _d({43,51,55,7},54), aim, _d({58,57,61,7},54), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({50,57,64,47,60},54) then
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
debug(_d({13,57,55,44,43,62,234,54,57,45,53,234,61,53,51,58,58,47,46,246},54), snapDist, _d({61,62,63,46,61,234,48,60,57,55,234,62,43,60,49,47,62,234,172,74,94,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,55,57,64,47},54))
phase = _d({55,57,64,47},54)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({18,47,43,60,62,44,47,43,62,234,47,60,60,57,60,4},54), err) end
end)
end
local function stopNav()
debug(_d({24,43,64,234,54,57,57,58,234,25,16,16},54))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({55,57,64,47},54)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({30,47,66,62,13,50,43,62,29,47,60,64,51,45,47},54))
local channels = TextChatService:FindFirstChild(_d({30,47,66,62,13,50,43,56,56,47,54,61},54))
local channel = channels and channels:FindFirstChild(_d({28,12,34,17,47,56,47,60,43,54},54))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({14,47,48,43,63,54,62,13,50,43,62,29,67,61,62,47,55,13,50,43,62,15,64,47,56,62,61},54))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({29,43,67,23,47,61,61,43,49,47,28,47,59,63,47,61,62},54))
if sayEvent then
sayEvent:FireServer(message, _d({11,54,54},54))
return
end
debug(_d({61,47,56,46,13,50,43,62,23,47,61,61,43,49,47,4,234,56,57,234,30,47,66,62,13,50,43,62,29,47,60,64,51,45,47,248,28,12,34,17,47,56,47,60,43,54,234,57,60,234,54,47,49,43,45,67,234,29,43,67,23,47,61,61,43,49,47,28,47,59,63,47,61,62,234,48,57,63,56,46,234,48,57,60},54), message)
end)
if not ok then debug(_d({61,47,56,46,13,50,43,62,23,47,61,61,43,49,47,234,47,60,60,57,60,4},54), err) end
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
debug(_d({24,57,62,234,55,43,53,51,56,49,234,58,60,57,49,60,47,61,61,234,62,57,65,43,60,46,234,56,43,64,234,62,43,60,49,47,62,234,48,57,60},54), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({61,234,247,234,61,47,56,46,51,56,49,234,249,63,56,61,62,63,45,53},54))
sendChatMessage(_d({249,63,56,61,62,63,45,53},54))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({65,43,51,62,31,56,62,51,54,11,60,60,51,64,47,46,234,62,51,55,47,57,63,62},54))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({56,43,64,30,57,26,57,51,56,62,13,57,56,48,51,60,55,47,46,4},54), label or _d({62,43,60,49,47,62},54), _d({247,234,46,51,46,234,56,57,62,234,43,60,60,51,64,47,234,65,51,62,50,51,56},54), timeout, _d({61,246,234,60,47,62,60,67,51,56,49,234,57,56,45,47},54))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({56,43,64,30,57,26,57,51,56,62,13,57,56,48,51,60,55,47,46,4},54), label or _d({62,43,60,49,47,62},54), _d({247,234,61,62,51,54,54,234,56,57,62,234,43,60,60,51,64,47,46,234,43,48,62,47,60,234,60,47,62,60,67,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
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
if not ok then debug(_d({56,43,64,30,57,26,57,51,56,62,18,57,54,46,51,56,49,12,54,57,45,53,234,53,47,67,247,46,57,65,56,234,47,60,60,57,60,4},54), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({56,43,64,30,57,26,57,51,56,62,18,57,54,46,51,56,49,12,54,57,45,53,234,53,47,67,247,63,58,234,47,60,60,57,60,4},54), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({33,43,54,53,51,56,49,234,62,57,4},54), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({65,43,54,53,30,57,26,57,51,56,62,234,33,234,46,57,65,56,234,47,60,60,57,60,4},54), err) end
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
debug(_d({30,57,57,53,234,46,43,55,43,49,47,234,65,50,51,54,47,234,65,43,54,53,51,56,49,234,62,57,234,58,57,51,56,62,235,234,29,62,57,58,58,51,56,49,234,65,43,54,53,234,62,57,234,47,56,49,43,49,47,248},54))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({11,60,60,51,64,47,46,234,43,62,4},54), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({29,62,63,45,53,234,46,63,60,51,56,49,234,65,43,54,53,246,234,52,63,55,58,51,56,49,235},54))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({29,62,51,54,54,234,61,62,63,45,53,246,234,62,60,51,49,49,47,60,51,56,49,234,17,47,58,58,57,235},54))
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
debug(_d({23,57,64,51,56,49,234,62,57},54), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,24,26,13,61,234,62,57,234,61,58,43,65,56,234,43,62},54), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({234,234,61,58,43,65,56,234,45,50,47,45,53,4,234,48,57,54,46,47,60,234,47,66,51,61,62,61,234,7},54), folder ~= nil,
_d({246,234,45,50,51,54,46,60,47,56,234,7},54), folder and #folder:GetChildren() or 0,
_d({246,234,43,54,51,64,47,234,7},54), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({24,57,234,24,26,13,61,234,43,58,58,47,43,60,47,46,234,43,62},54), stageName, _d({43,48,62,47,60,234,251,255,61,246,234,55,57,64,51,56,49,234,57,56,234,43,56,67,65,43,67},54))
break
end
end
debug(_d({21,51,54,54,51,56,49,234,24,26,13,61,234,43,62},54), stageName)
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
debug(_d({28,47,62,63,60,56,51,56,49,234,62,57},54), stageName, _d({58,57,61,51,62,51,57,56,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,57,56},54))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62},54), stageName, _d({58,57,61,51,62,51,57,56},54))
task.wait(5)
debug(_d({33,43,51,62,51,56,49,234,48,57,60},54), targetHP * 100, _d({239,234,18,26,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,62,57,234,56,47,66,62,234,61,62,43,49,47},54))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({45,54,47,43,60,47,46},54))
end
local function killNamedNPC(name, targetPos)
debug(_d({23,57,64,51,56,49,234,62,57},54), name)
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
debug(name, _d({46,47,48,47,43,62,47,46},54))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({22,47,57,234,58,54,43,67,47,46,234,43,56,51,55,43,62,51,57,56,4},54), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({54,47,57,11,56,51,55,22,57,49,49,47,60,234,58,60,51,56,62,234,47,60,60,57,60,4},54), err2) end
end)
end)
if not ok then debug(_d({61,62,43,60,62,22,47,57,11,56,51,55,22,57,49,49,47,60,234,47,60,60,57,60,4},54), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({23,57,64,51,56,49,234,62,57,234,22,47,57},54))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({22,47,57},54))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({22,47,57},54))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({22,47,57},54))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({22,47,57,234,45,43,61,62,51,56,49},54), which, _d({247,234,46,57,46,49,51,56,49},54))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({22,47,57,234,61,62,43,60,62,47,46,234,44,54,57,45,53,247,44,60,47,43,53,47,60,234,55,51,46,247,44,54,57,45,53,235,234,15,64,43,46,51,56,49,248,248,248},54))
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
if not getNPCByName(_d({22,47,57},54)) then
debug(_d({22,47,57,234,49,57,56,47,234,55,51,46,247,46,57,46,49,47,234,247,234,47,56,46,51,56,49,234,15,56,62,47,51,234,50,57,54,46,234,47,43,60,54,67},54))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({22,47,57},54)) then
setNavNamed(_d({22,47,57},54))
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
debug(_d({22,47,57,234,46,47,48,47,43,62,47,46},54))
stopLeoAnimLogger()
debug(_d({28,47,62,63,60,56,51,56,49,234,62,57,234,22,47,57,234,58,57,61,51,62,51,57,56,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,57,56},54))
navToPointConfirmed(COORDS.Leo, 30, _d({22,47,57,234,58,57,61,51,62,51,57,56},54))
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62,234,22,47,57,234,58,57,61,51,62,51,57,56},54))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({23,57,64,51,56,49,234,62,57},54), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({13,57,63,54,46,234,56,57,62,234,48,51,56,46,234,61,62,43,62,63,47,234,55,57,46,47,54,234,56,47,43,60},54), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({11,62,62,43,45,53,51,56,49},54), coordKey, _d({65,51,62,50},54), weapon or _d({56,57,62,50,51,56,49,234,48,57,63,56,46},54))
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
debug(coordKey, _d({44,43,60,60,47,54,234,46,47,61,62,60,57,67,47,46},54))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({247,234,45,57,63,54,46,234,56,57,62,234,48,51,56,46,234,61,62,43,62,63,47,234,55,57,46,47,54,246,234,61,53,51,58,58,51,56,49},54))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({61,62,51,54,54,234,43,54,51,64,47,234,242,18,26},54), hp, _d({243,234,247,234,60,47,247,46,47,61,62,60,57,67,51,56,49},54))
destroyStatue(coordKey)
else
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({45,57,56,48,51,60,55,47,46,234,46,47,61,62,60,57,67,47,46},54))
end
end)
if not ok then debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,234,47,60,60,57,60,4},54), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({23,57,64,51,56,49,234,62,57,234,27,63,47,47,56},54))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
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
debug(_d({27,63,47,47,56,234,47,56,62,47,60,47,46,234,58,50,43,61,47,234,252},54))
end
local function finishQueen()
debug(_d({16,51,56,51,61,50,51,56,49,234,27,63,47,47,56},54))
equipSwordOrMelee()
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
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
debug(_d({27,63,47,47,56,234,46,47,48,47,43,62,47,46,248,234,26,54,43,56,234,45,57,55,58,54,47,62,47,248},54))
end
local CONFIRMATION_PROMPT_NAME = _d({13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62},54)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({28,47,55,57,62,47,15,64,47,56,62},54), 5)
end)
if ok then return result end
debug(_d({49,47,62,28,47,58,54,43,67,28,47,55,57,62,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({26,54,43,67,47,60,17,63,51},54))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({19,55,43,49,47,12,63,62,62,57,56},54)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({44,63,62,62,57,56,32,43,54,63,47},54)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({48,51,56,46,12,63,62,62,57,56,12,67,32,43,54,63,47,234,47,60,60,57,60,4},54), result)
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
if not ok then debug(_d({45,54,51,45,53,17,63,51,12,63,62,62,57,56,234,47,60,60,57,60,4},54), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({51,61,29,47,60,64,47,60},54))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({28,47,55,57,62,47,15,64,47,56,62},54))
or inst:FindFirstChild(_d({45,54,51,47,56,62,15,64,47,56,62},54))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({48,51,56,46,11,56,61,65,47,60,13,57,56,56,47,45,62,57,60,234,47,60,60,57,60,4},54), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({13,57,63,54,46,234,56,57,62,234,54,57,45,43,62,47,234,28,47,55,57,62,47,15,64,47,56,62,249,45,54,51,47,56,62,15,64,47,56,62,234,56,47,43,60,234,28,47,58,54,43,67,234,44,63,62,62,57,56,246,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,45,54,51,45,53},54))
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
debug(_d({48,51,60,47,28,47,58,54,43,67,32,43,54,63,47,234,47,60,60,57,60,4},54), err, _d({247,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,45,54,51,45,53},54))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({16,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,44,63,62,62,57,56,32,43,54,63,47,234,61,47,43,60,45,50,234,48,57,60,234,28,47,58,54,43,67},54))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({28,47,58,54,43,67,234,44,63,62,62,57,56,234,56,57,62,234,48,57,63,56,46,234,47,51,62,50,47,60,246,234,49,51,64,51,56,49,234,63,58},54))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,248,28,47,55,57,62,47,15,64,47,56,62},54))
local remote = getReplayRemote()
if not remote then
debug(_d({13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,249,28,47,55,57,62,47,15,64,47,56,62,234,56,57,62,234,48,57,63,56,46,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62},54))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({16,51,60,51,56,49,234,28,47,58,54,43,67,234,64,51,43,234,13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,248,28,47,55,57,62,47,15,64,47,56,62},54))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({16,51,60,47,29,47,60,64,47,60,234,47,60,60,57,60,4},54), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54), 10)
if not playerGui then
debug(_d({65,43,51,62,16,57,60,25,44,52,47,45,62,51,64,47,61,17,63,51,4,234,56,57,234,26,54,43,67,47,60,17,63,51,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({25,44,52,47,45,62,51,64,47,61,234,17,31,19,234,48,57,63,56,46,234,247,234,61,62,43,49,47,234,54,57,43,46,47,46},54))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({25,44,52,47,45,62,51,64,47,61,234,17,31,19,234,56,57,62,234,48,57,63,56,46,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
return
end
end
end)
if not ok then debug(_d({65,43,51,62,16,57,60,25,44,52,47,45,62,51,64,47,61,17,63,51,234,47,60,60,57,60,4},54), err) end
end
local function runPlan()
debug(_d({26,54,43,56,234,61,62,43,60,62,47,46},54))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({29,62,43,60,62,51,56,49,234,56,43,64,234,54,57,57,58},54))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({58,57,61,234,250,248,252,61,234,11,16,30,15,28,234,61,62,43,60,62,24,43,64,4},54), rootAfter and rootAfter.Position)
end)
debug(_d({33,43,51,62,51,56,49,234,255,61,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,62,57,234,29,62,43,49,47,251},54))
task.wait(5)
for _, stage in ipairs({_d({29,62,43,49,47,251},54), _d({29,62,43,49,47,252},54), _d({29,62,43,49,47,253},54), _d({29,62,43,49,47,253,12},54)}) do
if not enabled then return end
local hpTarget = (stage == _d({29,62,43,49,47,253,12},54)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,62,57,234,43,60,60,57,65,234,48,54,67,247,46,57,65,56,234,43,60,47,43,234,242,13,63,58,51,46,234,28,43,51,56,243},54))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({14,57,46,49,51,56,49,234,43,60,60,57,65,234,60,43,51,56,234,51,56,234,43,234,61,59,63,43,60,47},54))
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
clearStage(_d({29,62,43,49,47,254},54))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({27,63,47,47,56,234,51,56,234,58,50,43,61,47,234,252,234,247,234,53,47,47,58,51,56,49,234,21,47,56,234,18,43,53,51,234,43,45,62,51,64,47,234,48,60,57,55,234,50,47,60,47,234,57,56},54))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({29,62,43,62,63,47,251},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,251},54))
destroyStatue(_d({29,62,43,62,63,47,252},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,251},54))
recheckStatue(_d({29,62,43,62,63,47,252},54))
destroyStatue(_d({29,62,43,62,63,47,253},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,253},54))
recheckStatue(_d({29,62,43,62,63,47,252},54))
recheckStatue(_d({29,62,43,62,63,47,251},54))
if not enabled then return end
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,58,50,43,61,47,234,252,234,62,57,234,47,56,46},54))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({26,50,43,61,47,234,252,234,47,56,46,234,65,43,51,62,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,44,43,45,53,234,62,57,234,27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
navToPointConfirmed(COORDS.Queen, 30, _d({27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62,234,27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
task.wait(5)
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,62,57,234,58,57,61,62,247,27,63,47,47,56,234,58,57,61,51,62,51,57,56},54))
navToPointConfirmed(COORDS.PostQueen, 30, _d({58,57,61,62,247,27,63,47,47,56,234,58,57,61,51,62,51,57,56},54))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({15,56,43,44,54,51,56,49,246,234,58,57,61,234,12,15,16,25,28,15,234,58,54,43,56,4},54), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({26,54,43,56,234,47,60,60,57,60,4},54), err2) end
end)
debug(_d({15,56,43,44,54,47,46,4},54), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({15,56,43,44,54,47,46,4},54), enabled)
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
if not ok then debug(_d({19,56,58,63,62,12,47,49,43,56,234,47,60,60,57,60,4},54), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({17,43,55,47,234,54,57,43,46,47,46,246,234,43,63,62,57,247,61,62,43,60,62,51,56,49,234,62,50,47,234,58,54,43,56},54))
enableBot()
end)
if not ok then debug(_d({11,63,62,57,61,62,43,60,62,234,47,60,60,57,60,4},54), err) end
end)
debug(_d({22,57,43,46,47,46,234,172,74,94,234,43,63,62,57,247,61,62,43,60,62,51,56,49,234,57,56,45,47,234,62,50,47,234,49,43,55,47,234,48,51,56,51,61,50,47,61,234,54,57,43,46,51,56,49,234,242,58,60,47,61,61,234,26,234,62,57,234,62,57,49,49,54,47,234,55,43,56,63,43,54,54,67,243},54))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({50,62,62,58,61,4,249,249,60,43,65,248,49,51,62,50,63,44,63,61,47,60,45,57,56,62,47,56,62,248,45,57,55,249,60,57,45,53,67,66,65,43,54,54,249,28,43,67,48,51,47,54,46,249,55,43,51,56,249,61,57,63,60,45,47,248,54,63,43},54)
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
error(_d({37,18,57,60,57,234,64,252,39,234,16,43,51,54,47,46,234,62,57,234,54,57,43,46,234,28,43,67,48,51,47,54,46,234,31,19,234,22,51,44,60,43,60,67,248},54))
end
local Window = Rayfield:CreateWindow({
Name = _d({18,57,60,57,234,18,57,60,57,234,36,247,16,43,60,55,234,64,252},54),
LoadingTitle = _d({22,57,43,46,51,56,49,234,18,57,60,57,234,64,252,248,248,248},54),
LoadingSubtitle = _d({29,51,54,47,56,62,234,11,51,55,234,25,58,62,51,55,51,68,47,46},54),
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
local MainTab = Window:CreateTab(_d({11,63,62,57,234,16,43,60,55},54), 4483362458)
local SkillTab = Window:CreateTab(_d({29,53,51,54,54,234,29,47,62,62,51,56,49,61},54), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)) or (bp and bp:FindFirstChild(_d({18,57,60,57,247,18,57,60,57},54)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = boss:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
if key == _d({18,51,62},54) then
return target.CFrame
elseif key == _d({30,43,60,49,47,62},54) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({37,18,57,60,57,234,64,252,39,234,23,47,62,43,62,43,44,54,47,234,50,57,57,53,234,48,43,51,54,47,46,4,234},54) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({37,18,57,60,57,234,64,252,39,234,13,54,47,43,56,47,46,234,63,58,234,58,60,47,64,51,57,63,61,234,61,47,61,61,51,57,56,248},54))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,33,43,51,62,51,56,49,234,48,57,60,234,12,57,61,61,234,29,58,43,65,56},54)) end
print(_d({37,18,57,60,57,234,64,252,39,234,12,57,61,61},54), _G.HoroSelectedBoss, _d({51,61,234,56,57,62,234,61,58,43,65,56,47,46,248,234,33,43,51,62,51,56,49,248,248,248},54))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,28,63,56,56,51,56,49,234,13,57,55,44,57},54)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,13,234,242,21,43,55,51,53,43,68,47,243},54))
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
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,36,234,242,23,51,56,51,234,12,43,60,60,43,49,47,243},54))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,15,234,242,29,62,63,56,243},54))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({37,18,57,60,57,234,64,252,39,234,16,51,60,47,46,234,28,234,242,14,47,62,57,56,43,62,51,57,56,243},54))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,29,54,47,47,58,51,56,49,234,242},54) .. string.format(_d({239,248,251,48},54), finalSleep) .. _d({61,243},54)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({29,62,43,62,63,61,4,234,19,46,54,47},54))
MainTab:CreateDropdown({
Name = _d({29,47,54,47,45,62,234,12,57,61,61},54),
Options = {_d({11,66,47,234,18,43,56,46,234,22,57,49,43,56},54), _d({12,43,56,46,51,62,234,12,57,61,61},54), _d({20,63,68,57,234,62,50,47,234,14,51,43,55,57,56,46,44,43,45,53},54)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({37,18,57,60,57,234,64,252,39,234,29,47,54,47,45,62,47,46,234,62,43,60,49,47,62,4},54), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({29,62,43,60,62,234,11,63,62,57,234,16,43,60,55},54),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({29,47,54,47,45,62,234,12,57,61,61,234,28,47,59,63,51,60,47,46},54),
Content = _d({35,57,63,234,55,63,61,62,234,61,47,54,47,45,62,234,43,234,44,57,61,61,234,48,51,60,61,62,234,44,47,48,57,60,47,234,47,56,43,44,54,51,56,49,234,11,63,62,57,234,16,43,60,55,235},54),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({29,62,43,62,63,61,4,234,19,46,54,47},54)) end
end
print(_d({37,18,57,60,57,234,64,252,39,234,11,63,62,57,234,16,43,60,55,4},54), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({14,47,61,62,60,57,67,234,31,19},54),
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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = "Bandit"
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild("Stats_d({243,234,43,56,46,234,61,62,43,62,61,16,57,54,46,47,60,248,29,62,43,62,61,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,242},54)Level") and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild("Stats_d({243,234,43,56,46,234,61,62,43,62,61,16,57,54,46,47,60,248,29,62,43,62,61,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,242},54)Peli") and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild("Quest_d({243,234,43,56,46,234,61,62,43,62,61,16,57,54,46,47,60,248,27,63,47,61,62,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,242},54)CurrentQuest_d({243,234,43,56,46,234,61,62,43,62,61,16,57,54,46,47,60,248,27,63,47,61,62,248,13,63,60,60,47,56,62,27,63,47,61,62,248,32,43,54,63,47,234,57,60,234},54)None"
return lvl, peli, quest
end
return 1, 0, "None"
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = npc:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find("water_d({243,234,57,60,234,50,51,62,24,43,55,47,4,48,51,56,46,242},54)sea_d({243,234,57,60,234,50,51,62,24,43,55,47,4,48,51,56,46,242},54)ocean") or raycastResult.Material == Enum.Material.Water
local currentHeight = pos.Y - raycastResult.Position.Y
if currentHeight < 20 then
return 20 - currentHeight
end
else
if pos.Y < 50 then
return 50 - pos.Y
end
end
return 0
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({12,43,61,47,26,43,60,62},54)) then
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
local function getOrCreateForce(root)
local att = root:FindFirstChild("__GrinderAtt_d({243,234,57,60,234,19,56,61,62,43,56,45,47,248,56,47,65,242},54)Attachment")
att.Name = "__GrinderAtt"
att.Parent = root
local force = root:FindFirstChild("__GrinderForce")
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = "__GrinderForce"
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
local root = getRoot()
if root then
local force = root:FindFirstChild("__GrinderForce")
local att = root:FindFirstChild("__GrinderAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
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
local function checkStuck(currentPos, targetPos, deltaTime)
deltaTime = deltaTime or 0.2
if (targetPos - currentPos).Magnitude > 5 then
if (currentPos - lastPosition).Magnitude < 1 then
stuckTime = stuckTime + deltaTime
if stuckTime > 1.5 then
unstuckActive = true
stuckTime = 0
end
else
stuckTime = 0
end
else
stuckTime = 0
end
lastPosition = currentPos
end
local function navigateTo(targetPos)
local myRoot = getRoot()
if not myRoot then return false end
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
if dir.Magnitude > 8 then
checkStuck(myRoot.Position, targetPos, 0.1)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
return false
else
force.VectorVelocity = Vector3.zero
return true
end
end
local function acceptQuest(npcName)
local npc = Workspace.NPCs:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild("UpperTorso")
local prompt = torso and torso:FindFirstChild("Prompt")
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local reached = navigateTo(torso.Position + Vector3.new(0, hoverHeight, 0))
if reached then
cleanupForce()
myRoot.CFrame = torso.CFrame + Vector3.new(0, 2, 0)
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Quest Acceptance] fireproximityprompt not supported by executor!")
end
task.wait(0.8)
local chatGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("NPCCHAT")
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild("go")
local endChatBtn = chatGui.Frame:FindFirstChild("endChat")
if goBtn and goBtn.Visible and goBtn.Text ~= "_d({234,43,56,46,234,49,57,12,62,56,248,30,47,66,62,234,72,7,234},54)..." then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
elseif endChatBtn and endChatBtn.Visible then
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
conn:Fire()
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
cleanupForce()
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild("Rifle_d({243,234,57,60,234,22,57,45,43,54,26,54,43,67,47,60,248,13,50,43,60,43,45,62,47,60,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,242},54)Rifle")
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
targetMob = _d({12,43,56,46,51,62,234,12,57,61,61},54)
if quest == "None" then
acceptQuest("Ronny")
return
end
elseif peli >= 300 and not hasRifle then
local shopItem = workspace.BuyableItems:FindFirstChild("Rifle")
local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")
if shopPart then
local reached = navigateTo(shopPart.Position + Vector3.new(0, hoverHeight, 0))
if reached then
cleanupForce()
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
cleanupForce()
print("[Gepo Grinder] Rifle purchased! Starter Island progression completed. Waiting for Fishman Cave travel phase.")
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
local weaponTool = bp and bp:FindFirstChild("Melee")
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({243,234,43,56,46,234,56,58,45,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,33,50,51,45,50,19,61,11,242},54)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, targetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({243,234,43,56,46,234,48,51,56,43,54,24,58,45,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,33,50,51,45,50,19,61,11,242},54)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, finalTargetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (finalTargetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({243,234,43,56,46,234,48,51,56,43,54,24,58,45,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,33,50,51,45,50,19,61,11,242},54)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
force.VectorVelocity = dir.Unit * 30
task.wait(0.05)
end
end
end
end
else
cleanupForce()
end
else
cleanupForce()
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
cleanupForce()
local npcsFolder = Workspace:FindFirstChild(_d({24,26,13,61},54))
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
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
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
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum = char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({243,234,57,60,234,19,56,61,62,43,56,45,47,248,56,47,65,242},54)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
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
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local finalTargetY = isClimbing and climbTargetY or currentTargetY
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (FLIGHT_SPEED * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + Vector3.new(look.X, 0, look.Z).Unit)
end
end)
print("[Easy Travel] Flight enabled.")
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print("[Easy Travel] Flight disabled.")
end
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
_G.EasyTravelCleanup = nil
print("[Easy Travel] Completely unloaded and cleaned up script state.")
end
print("[Easy Travel] Loaded. Press 'P' to toggle flight. Press _d({15,56,46},54) to completely unload.")
return {
Start = startFlight,
Stop = stopFlight,
}
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({26,54,43,67,47,60,61},54))
local RunService = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local UserInputService = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local ReplicatedStorage = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({51,46,54,47},54)
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
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({51,56,64,57,53,47,17,47,58,58,57,234,47,60,60,57,60,4},54), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({243,234,57,60,234,19,56,61,62,43,56,45,47,248,56,47,65,242},54)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
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
local root = char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({33,43,54,53,51,56,49,234,62,57,4},54), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({65,43,54,53,30,57,26,57,51,56,62,234,33,234,46,57,65,56,234,47,60,60,57,60,4},54), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({11,60,60,51,64,47,46,234,43,62,4},54), pos)
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
if item:IsA("Model_d({243,234,43,56,46,234,51,62,47,55,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,242},54)HumanoidRootPart_d({243,234,43,56,46,234,51,62,47,55,4,16,51,56,46,16,51,60,61,62,13,50,51,54,46,33,50,51,45,50,19,61,11,242},54)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54)).Health > 0 then
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
mode = _d({51,46,54,47},54)
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
if mode == _d({50,57,64,47,60},54) then
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
local playerGui = LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54), 10)
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
statusLabel.Text = _d({29,62,43,62,63,61,4,234,19,46,54,47},54)
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
enableBot(_d({50,57,64,47,60},54))
statusLabel.Text = "Status: Hovering _d({234,248,248,234,64,43,54,234,248,248,234},54) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({234,248,248,234,64,43,54,234,248,248,234},54) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({234,248,248,234,64,43,54,234,248,248,234},54) studs)"
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
local VIM = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({246,234},54)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({246,234},54)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({246,234},54)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({246,234},54)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({246,234},54)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()