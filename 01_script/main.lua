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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({23,51,40,64,44,57,58},57))
local UserInputService    = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local RunService          = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local VIM                 = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local ReplicatedStorage    = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({34,9,54,58,58,9,54,59,36},57), _d({30,57,54,53,46,231,46,40,52,44,231,169,71,91,231,23,51,40,42,44,16,43,1},57), game.PlaceId, _d({28,53,48,61,44,57,58,44,16,43,1},57), game.GameId, _d({244,231,53,54,59,231,57,60,53,53,48,53,46},57))
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
local LEO_PILLAR_ANIM_ID   = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,251,251,248,251,248,250,249,254},57)
local LEO_ENTEI_ANIM_ID    = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,251,251,248,250,255,249,254,255},57)
local LEO_HIKEN_ANIM_ID    = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,249,247,0,248,254,251,247,254},57)
local LEO_FIREFLY_ANIM_ID  = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,249,247,249,250,253,248,252,251},57)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({22,41,49,44,42,59,48,61,44,58},57)
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
local REPLAY_BUTTON_VALUE   = _d({25,44,55,51,40,64},57)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({52,54,61,44},57)
local NavState   = {mode = _d({48,43,51,44},57)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({34,9,54,58,58,9,54,59,36},57), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end)
if ok then return root end
debug(_d({46,44,59,25,54,54,59,231,44,57,57,54,57,1},57), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end)
if ok then return hum end
debug(_d({46,44,59,15,60,52,40,53,54,48,43,231,44,57,57,54,57,1},57), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({240,231,54,57,231,16,53,58,59,40,53,42,44,245,53,44,62,239},57)Attachment")
att.Name = _d({38,38,15,54,61,44,57,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,15,54,61,44,57,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,15,54,61,44,57,13,54,57,42,44},57)
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
debug(_d({46,44,59,22,57,10,57,44,40,59,44,13,54,57,42,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local force = root:FindFirstChild(_d({38,38,15,54,61,44,57,13,54,57,42,44},57))
local att   = root:FindFirstChild(_d({38,38,15,54,61,44,57,8,59,59},57))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({42,51,44,40,53,60,55,13,54,57,42,44,231,44,57,57,54,57,1},57), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({9,60,58,54,20,44,51,44,44},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,9,60,58,54,8,42,59,48,61,44,231,44,57,57,54,57,1},57), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({9,60,58,54},57))
end)
if not ok then debug(_d({40,42,59,48,61,40,59,44,9,60,58,54,231,44,57,57,54,57,1},57), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({9,60,58,54,231,53,54,59,231,40,42,59,48,61,44,243,231,40,42,59,48,61,40,59,48,53,46},57))
activateBuso()
end
end)
if not ok then debug(_d({9,60,58,54,18,44,44,55,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({9,60,58,54,231,50,44,44,55,44,57,231,58,59,54,55,55,44,43},57))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({18,44,53,15,40,50,48},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,18,44,53,8,42,59,48,61,44,231,44,57,57,54,57,1},57), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({18,44,53},57), true)
end)
if not ok then debug(_d({40,42,59,48,61,40,59,44,18,44,53,231,44,57,57,54,57,1},57), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({18,44,53,231,53,54,59,231,40,42,59,48,61,44,243,231,40,42,59,48,61,40,59,48,53,46},57))
activateKen()
end
end)
if not ok then debug(_d({18,44,53,18,44,44,55,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({18,44,53,231,50,44,44,55,44,57,231,58,59,54,55,55,44,43},57))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({21,23,10,58},57)) end)
if ok then return folder end
debug(_d({46,44,59,21,23,10,58,13,54,51,43,44,57,231,44,57,57,54,57,1},57), folder)
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
local r = model:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local h = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
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
debug(_d({46,44,59,21,44,40,57,44,58,59,21,23,10,231,44,57,57,54,57,1},57), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum  = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({46,44,59,21,23,10,9,64,21,40,52,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({53,55,42,58,25,44,52,40,48,53,48,53,46,231,44,57,57,54,57,1},57), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({10,60,55,48,43,231,24,60,44,44,53},57))
return queen ~= nil and queen:FindFirstChild(_d({52,54,59,48,54,53,19,44,58,58},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,24,60,44,44,53,23,47,40,58,44,249,231,44,57,57,54,57,1},57), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,248,249,248,249,0,254,0,251,249,249,0,249,254,253,0},57)
local QUEEN_GRASP_ANIM_ID   = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,248,249,0,255,247,247,247,253,248,247,247,248,254,250,251},57)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
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
debug(_d({48,58,23,51,40,64,48,53,46,8,53,48,52,13,57,54,52,19,48,58,59,231,44,57,57,54,57,1},57), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({9,51,54,42,50,48,53,46},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,21,23,10,9,51,54,42,50,48,53,46,231,44,57,57,54,57,1},57), result)
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
debug(_d({55,57,44,43,48,42,59,21,23,10,23,54,58,48,59,48,54,53,231,44,57,57,54,57,1},57), result)
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
debug(_d({21,54,231,43,40,52,40,46,44,231,54,53},57), model.Name, _d({45,54,57},57), NPC_STUCK_TIMEOUT, _d({58,231,244,231,58,62,48,59,42,47,48,53,46,231,59,40,57,46,44,59},57))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({59,57,40,42,50,21,23,10,11,40,52,40,46,44,231,44,57,57,54,57,1},57), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({20,54,43,44,51},57)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({9,40,58,44,23,40,57,59},57)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({46,44,59,20,54,43,44,51,13,40,42,44,23,54,58,231,44,57,57,54,57,1},57), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({12,53,61},57))
local folder = env and env:FindFirstChild(_d({26,59,40,59,60,44,58},57))
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
debug(_d({46,44,59,26,59,40,59,60,44,20,54,43,44,51,21,44,40,57,231,44,57,57,54,57,1},57), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({41,40,57,57,44,51,15,23},57))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({46,44,59,26,59,40,59,60,44,15,23,231,44,57,57,54,57,1},57), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,8,59,59,57,48,41,60,59,44,231,44,57,57,54,57,1},57), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({27,54,54,51},57)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,21,40,52,44,231,44,57,57,54,57,1},57), tool)
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
if not ok then debug(_d({44,56,60,48,55,27,54,54,51,231,44,57,57,54,57,1},57), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,10,47,48,51,43,21,40,52,44,231,44,57,57,54,57,1},57), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({26,62,54,57,43,12,56,60,48,55},57))
if sword then
equipTool(sword)
return _d({58,62,54,57,43},57)
end
local melee = findToolByAttribute(_d({20,44,51,44,44,27,54,54,51},57))
if melee then
equipTool(melee)
return _d({52,44,51,44,44},57)
end
debug(_d({21,54,231,58,62,54,57,43,231,54,57,231,52,44,51,44,44,231,59,54,54,51,231,45,54,60,53,43},57))
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
if not ok then debug(_d({42,51,48,42,50,20,248,231,44,57,57,54,57,1},57), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
end)
if not ok then debug(_d({48,53,61,54,50,44,14,44,55,55,54,231,44,57,57,54,57,1},57), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({55,57,44,58,58,26,50,48,51,51,25,231,44,57,57,54,57,1},57), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({47,54,51,43,9,51,54,42,50,231,44,57,57,54,57,1},57), err) end
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
if not ok then debug(_d({47,54,51,43,9,51,54,42,50,30,47,48,51,44,231,44,57,57,54,57,1},57), err) end
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
debug(_d({46,44,59,14,40,52,44,14,231,44,57,57,54,57,1},57), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({48,58,25,44,40,51,20,248,9,60,58,64,231,44,57,57,54,57,1},57), result)
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
return char ~= nil and char:FindFirstChild(_d({58,59,60,53},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,26,59,60,53,53,44,43,231,44,57,57,54,57,1},57), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({55,57,44,58,58,26,59,60,53,9,57,44,40,50,231,44,57,57,54,57,1},57), err) end
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
debug(_d({56,60,44,44,53,11,54,43,46,44,28,53,59,48,51,26,40,45,44,1,231,24,60,44,44,53,231,46,54,53,44,231,244,231,44,53,43,48,53,46,231,43,54,43,46,44,231,44,40,57,51,64},57))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({56,60,44,44,53,11,54,43,46,44,28,53,59,48,51,26,40,45,44,231,58,40,45,44,59,64,231,59,48,52,44,54,60,59},57))
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
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({24,60,44,44,53,231,42,40,58,59,48,53,46,231,43,44,59,44,42,59,44,43,231,244,231,43,54,43,46,48,53,46,231,239,62,40,59,42,47,44,57,240},57))
queenDodgeUntilSafe(function() return getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) end)
if enabled and getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) then
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
end
queenDodging = false
end
end)
if not ok then debug(_d({56,60,44,44,53,11,54,43,46,44,30,40,59,42,47,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({55,54,48,53,59},57) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({53,55,42},57) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({53,40,52,44,43},57) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({46,44,59,21,40,61,27,40,57,46,44,59,58,231,44,57,57,54,57,1},57), aimR)
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
debug(_d({42,54,52,55,60,59,44,19,54,42,50,44,43,10,13,57,40,52,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({55,54,48,53,59},57), point = pos}
phase = _d({52,54,61,44},57)
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
if not ok then debug(_d({53,40,61,27,54,23,54,48,53,59,231,46,44,55,55,54,231,42,47,44,42,50,231,44,57,57,54,57,1},57), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({53,55,42},57)}
phase = _d({52,54,61,44},57)
end
function setNavNamed(name)
NavState = {mode = _d({53,40,52,44,43},57), name = name}
phase = _d({52,54,61,44},57)
end
local function setNavIdle()
NavState = {mode = _d({48,43,51,44},57)}
phase = _d({52,54,61,44},57)
end
local function hasArrived()
return phase == _d({47,54,61,44,57},57)
end
local function startNav()
phase = _d({52,54,61,44},57)
debug(_d({21,40,61,231,51,54,54,55,231,22,21},57))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({23,51,40,64,44,57,231,43,48,44,43,232,231,26,59,54,55,55,48,53,46,231,41,54,59,245},57))
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
debug(_d({23,51,40,64,44,57,231,48,58,231,59,54,54,231,45,40,57,231,45,57,54,52,231,59,40,57,46,44,59,231,239,5,249,247,247,247,231,58,59,60,43,58,240,245,231,19,48,50,44,51,64,231,57,44,58,55,40,62,53,44,43,231,40,59,231,51,54,41,41,64,245,231,26,59,54,55,55,48,53,46,231,41,54,59,245},57))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({38,38,55,57,44,61,23,54,58},57))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({19,40,57,46,44,231,55,54,58,48,59,48,54,53,231,49,60,52,55,231,43,44,59,44,42,59,44,43,1},57), delta, _d({58,59,60,43,58,245,231,55,57,44,61,23,54,58,4},57), prevPos, _d({53,44,62,23,54,58,4},57), pos)
end
end
force:SetAttribute(_d({38,38,55,57,44,61,23,54,58},57), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({52,54,61,44},57) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({47,54,61,44,57},57)
debug(_d({23,47,40,58,44,1,231,47,54,61,44,57},57))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({232,232,232,231,25,12,13,28,26,16,21,14,231,27,22,231,8,23,23,19,32,231,8,9,21,22,25,20,8,19,231,29,12,19,22,10,16,27,32,1},57), finalVel, _d({40,48,52,4},57), aim, _d({55,54,58,4},57), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({47,54,61,44,57},57) then
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
debug(_d({10,54,52,41,40,59,231,51,54,42,50,231,58,50,48,55,55,44,43,243},57), snapDist, _d({58,59,60,43,58,231,45,57,54,52,231,59,40,57,46,44,59,231,169,71,91,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,52,54,61,44},57))
phase = _d({52,54,61,44},57)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({15,44,40,57,59,41,44,40,59,231,44,57,57,54,57,1},57), err) end
end)
end
local function stopNav()
debug(_d({21,40,61,231,51,54,54,55,231,22,13,13},57))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({52,54,61,44},57)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({27,44,63,59,10,47,40,59,26,44,57,61,48,42,44},57))
local channels = TextChatService:FindFirstChild(_d({27,44,63,59,10,47,40,53,53,44,51,58},57))
local channel = channels and channels:FindFirstChild(_d({25,9,31,14,44,53,44,57,40,51},57))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({11,44,45,40,60,51,59,10,47,40,59,26,64,58,59,44,52,10,47,40,59,12,61,44,53,59,58},57))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({26,40,64,20,44,58,58,40,46,44,25,44,56,60,44,58,59},57))
if sayEvent then
sayEvent:FireServer(message, _d({8,51,51},57))
return
end
debug(_d({58,44,53,43,10,47,40,59,20,44,58,58,40,46,44,1,231,53,54,231,27,44,63,59,10,47,40,59,26,44,57,61,48,42,44,245,25,9,31,14,44,53,44,57,40,51,231,54,57,231,51,44,46,40,42,64,231,26,40,64,20,44,58,58,40,46,44,25,44,56,60,44,58,59,231,45,54,60,53,43,231,45,54,57},57), message)
end)
if not ok then debug(_d({58,44,53,43,10,47,40,59,20,44,58,58,40,46,44,231,44,57,57,54,57,1},57), err) end
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
debug(_d({21,54,59,231,52,40,50,48,53,46,231,55,57,54,46,57,44,58,58,231,59,54,62,40,57,43,231,53,40,61,231,59,40,57,46,44,59,231,45,54,57},57), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({58,231,244,231,58,44,53,43,48,53,46,231,246,60,53,58,59,60,42,50},57))
sendChatMessage(_d({246,60,53,58,59,60,42,50},57))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({62,40,48,59,28,53,59,48,51,8,57,57,48,61,44,43,231,59,48,52,44,54,60,59},57))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({53,40,61,27,54,23,54,48,53,59,10,54,53,45,48,57,52,44,43,1},57), label or _d({59,40,57,46,44,59},57), _d({244,231,43,48,43,231,53,54,59,231,40,57,57,48,61,44,231,62,48,59,47,48,53},57), timeout, _d({58,243,231,57,44,59,57,64,48,53,46,231,54,53,42,44},57))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({53,40,61,27,54,23,54,48,53,59,10,54,53,45,48,57,52,44,43,1},57), label or _d({59,40,57,46,44,59},57), _d({244,231,58,59,48,51,51,231,53,54,59,231,40,57,57,48,61,44,43,231,40,45,59,44,57,231,57,44,59,57,64,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
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
if not ok then debug(_d({53,40,61,27,54,23,54,48,53,59,15,54,51,43,48,53,46,9,51,54,42,50,231,50,44,64,244,43,54,62,53,231,44,57,57,54,57,1},57), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({53,40,61,27,54,23,54,48,53,59,15,54,51,43,48,53,46,9,51,54,42,50,231,50,44,64,244,60,55,231,44,57,57,54,57,1},57), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({30,40,51,50,48,53,46,231,59,54,1},57), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({62,40,51,50,27,54,23,54,48,53,59,231,30,231,43,54,62,53,231,44,57,57,54,57,1},57), err) end
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
debug(_d({27,54,54,50,231,43,40,52,40,46,44,231,62,47,48,51,44,231,62,40,51,50,48,53,46,231,59,54,231,55,54,48,53,59,232,231,26,59,54,55,55,48,53,46,231,62,40,51,50,231,59,54,231,44,53,46,40,46,44,245},57))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({8,57,57,48,61,44,43,231,40,59,1},57), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({26,59,60,42,50,231,43,60,57,48,53,46,231,62,40,51,50,243,231,49,60,52,55,48,53,46,232},57))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({26,59,48,51,51,231,58,59,60,42,50,243,231,59,57,48,46,46,44,57,48,53,46,231,14,44,55,55,54,232},57))
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
debug(_d({20,54,61,48,53,46,231,59,54},57), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,21,23,10,58,231,59,54,231,58,55,40,62,53,231,40,59},57), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({231,231,58,55,40,62,53,231,42,47,44,42,50,1,231,45,54,51,43,44,57,231,44,63,48,58,59,58,231,4},57), folder ~= nil,
_d({243,231,42,47,48,51,43,57,44,53,231,4},57), folder and #folder:GetChildren() or 0,
_d({243,231,40,51,48,61,44,231,4},57), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({21,54,231,21,23,10,58,231,40,55,55,44,40,57,44,43,231,40,59},57), stageName, _d({40,45,59,44,57,231,248,252,58,243,231,52,54,61,48,53,46,231,54,53,231,40,53,64,62,40,64},57))
break
end
end
debug(_d({18,48,51,51,48,53,46,231,21,23,10,58,231,40,59},57), stageName)
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
debug(_d({25,44,59,60,57,53,48,53,46,231,59,54},57), stageName, _d({55,54,58,48,59,48,54,53,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,54,53},57))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59},57), stageName, _d({55,54,58,48,59,48,54,53},57))
task.wait(5)
debug(_d({30,40,48,59,48,53,46,231,45,54,57},57), targetHP * 100, _d({236,231,15,23,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,59,54,231,53,44,63,59,231,58,59,40,46,44},57))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({42,51,44,40,57,44,43},57))
end
local function killNamedNPC(name, targetPos)
debug(_d({20,54,61,48,53,46,231,59,54},57), name)
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
debug(name, _d({43,44,45,44,40,59,44,43},57))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({19,44,54,231,55,51,40,64,44,43,231,40,53,48,52,40,59,48,54,53,1},57), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({51,44,54,8,53,48,52,19,54,46,46,44,57,231,55,57,48,53,59,231,44,57,57,54,57,1},57), err2) end
end)
end)
if not ok then debug(_d({58,59,40,57,59,19,44,54,8,53,48,52,19,54,46,46,44,57,231,44,57,57,54,57,1},57), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({20,54,61,48,53,46,231,59,54,231,19,44,54},57))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({19,44,54},57))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({19,44,54},57))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({19,44,54},57))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({19,44,54,231,42,40,58,59,48,53,46},57), which, _d({244,231,43,54,43,46,48,53,46},57))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({19,44,54,231,58,59,40,57,59,44,43,231,41,51,54,42,50,244,41,57,44,40,50,44,57,231,52,48,43,244,41,51,54,42,50,232,231,12,61,40,43,48,53,46,245,245,245},57))
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
if not getNPCByName(_d({19,44,54},57)) then
debug(_d({19,44,54,231,46,54,53,44,231,52,48,43,244,43,54,43,46,44,231,244,231,44,53,43,48,53,46,231,12,53,59,44,48,231,47,54,51,43,231,44,40,57,51,64},57))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({19,44,54},57)) then
setNavNamed(_d({19,44,54},57))
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
debug(_d({19,44,54,231,43,44,45,44,40,59,44,43},57))
stopLeoAnimLogger()
debug(_d({25,44,59,60,57,53,48,53,46,231,59,54,231,19,44,54,231,55,54,58,48,59,48,54,53,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,54,53},57))
navToPointConfirmed(COORDS.Leo, 30, _d({19,44,54,231,55,54,58,48,59,48,54,53},57))
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59,231,19,44,54,231,55,54,58,48,59,48,54,53},57))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({20,54,61,48,53,46,231,59,54},57), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({10,54,60,51,43,231,53,54,59,231,45,48,53,43,231,58,59,40,59,60,44,231,52,54,43,44,51,231,53,44,40,57},57), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({8,59,59,40,42,50,48,53,46},57), coordKey, _d({62,48,59,47},57), weapon or _d({53,54,59,47,48,53,46,231,45,54,60,53,43},57))
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
debug(coordKey, _d({41,40,57,57,44,51,231,43,44,58,59,57,54,64,44,43},57))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({244,231,42,54,60,51,43,231,53,54,59,231,45,48,53,43,231,58,59,40,59,60,44,231,52,54,43,44,51,243,231,58,50,48,55,55,48,53,46},57))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({58,59,48,51,51,231,40,51,48,61,44,231,239,15,23},57), hp, _d({240,231,244,231,57,44,244,43,44,58,59,57,54,64,48,53,46},57))
destroyStatue(coordKey)
else
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({42,54,53,45,48,57,52,44,43,231,43,44,58,59,57,54,64,44,43},57))
end
end)
if not ok then debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,231,44,57,57,54,57,1},57), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({20,54,61,48,53,46,231,59,54,231,24,60,44,44,53},57))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
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
debug(_d({24,60,44,44,53,231,44,53,59,44,57,44,43,231,55,47,40,58,44,231,249},57))
end
local function finishQueen()
debug(_d({13,48,53,48,58,47,48,53,46,231,24,60,44,44,53},57))
equipSwordOrMelee()
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
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
debug(_d({24,60,44,44,53,231,43,44,45,44,40,59,44,43,245,231,23,51,40,53,231,42,54,52,55,51,44,59,44,245},57))
end
local CONFIRMATION_PROMPT_NAME = _d({10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59},57)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({25,44,52,54,59,44,12,61,44,53,59},57), 5)
end)
if ok then return result end
debug(_d({46,44,59,25,44,55,51,40,64,25,44,52,54,59,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({16,52,40,46,44,9,60,59,59,54,53},57)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({41,60,59,59,54,53,29,40,51,60,44},57)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({45,48,53,43,9,60,59,59,54,53,9,64,29,40,51,60,44,231,44,57,57,54,57,1},57), result)
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
if not ok then debug(_d({42,51,48,42,50,14,60,48,9,60,59,59,54,53,231,44,57,57,54,57,1},57), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({48,58,26,44,57,61,44,57},57))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({25,44,52,54,59,44,12,61,44,53,59},57))
or inst:FindFirstChild(_d({42,51,48,44,53,59,12,61,44,53,59},57))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({45,48,53,43,8,53,58,62,44,57,10,54,53,53,44,42,59,54,57,231,44,57,57,54,57,1},57), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({10,54,60,51,43,231,53,54,59,231,51,54,42,40,59,44,231,25,44,52,54,59,44,12,61,44,53,59,246,42,51,48,44,53,59,12,61,44,53,59,231,53,44,40,57,231,25,44,55,51,40,64,231,41,60,59,59,54,53,243,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,42,51,48,42,50},57))
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
debug(_d({45,48,57,44,25,44,55,51,40,64,29,40,51,60,44,231,44,57,57,54,57,1},57), err, _d({244,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,42,51,48,42,50},57))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({13,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,41,60,59,59,54,53,29,40,51,60,44,231,58,44,40,57,42,47,231,45,54,57,231,25,44,55,51,40,64},57))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({25,44,55,51,40,64,231,41,60,59,59,54,53,231,53,54,59,231,45,54,60,53,43,231,44,48,59,47,44,57,243,231,46,48,61,48,53,46,231,60,55},57))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,245,25,44,52,54,59,44,12,61,44,53,59},57))
local remote = getReplayRemote()
if not remote then
debug(_d({10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,246,25,44,52,54,59,44,12,61,44,53,59,231,53,54,59,231,45,54,60,53,43,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59},57))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({13,48,57,48,53,46,231,25,44,55,51,40,64,231,61,48,40,231,10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,245,25,44,52,54,59,44,12,61,44,53,59},57))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({13,48,57,44,26,44,57,61,44,57,231,44,57,57,54,57,1},57), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
if not playerGui then
debug(_d({62,40,48,59,13,54,57,22,41,49,44,42,59,48,61,44,58,14,60,48,1,231,53,54,231,23,51,40,64,44,57,14,60,48,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({22,41,49,44,42,59,48,61,44,58,231,14,28,16,231,45,54,60,53,43,231,244,231,58,59,40,46,44,231,51,54,40,43,44,43},57))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({22,41,49,44,42,59,48,61,44,58,231,14,28,16,231,53,54,59,231,45,54,60,53,43,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
return
end
end
end)
if not ok then debug(_d({62,40,48,59,13,54,57,22,41,49,44,42,59,48,61,44,58,14,60,48,231,44,57,57,54,57,1},57), err) end
end
local function runPlan()
debug(_d({23,51,40,53,231,58,59,40,57,59,44,43},57))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({26,59,40,57,59,48,53,46,231,53,40,61,231,51,54,54,55},57))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({55,54,58,231,247,245,249,58,231,8,13,27,12,25,231,58,59,40,57,59,21,40,61,1},57), rootAfter and rootAfter.Position)
end)
debug(_d({30,40,48,59,48,53,46,231,252,58,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,59,54,231,26,59,40,46,44,248},57))
task.wait(5)
for _, stage in ipairs({_d({26,59,40,46,44,248},57), _d({26,59,40,46,44,249},57), _d({26,59,40,46,44,250},57), _d({26,59,40,46,44,250,9},57)}) do
if not enabled then return end
local hpTarget = (stage == _d({26,59,40,46,44,250,9},57)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,59,54,231,40,57,57,54,62,231,45,51,64,244,43,54,62,53,231,40,57,44,40,231,239,10,60,55,48,43,231,25,40,48,53,240},57))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({11,54,43,46,48,53,46,231,40,57,57,54,62,231,57,40,48,53,231,48,53,231,40,231,58,56,60,40,57,44},57))
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
clearStage(_d({26,59,40,46,44,251},57))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({24,60,44,44,53,231,48,53,231,55,47,40,58,44,231,249,231,244,231,50,44,44,55,48,53,46,231,18,44,53,231,15,40,50,48,231,40,42,59,48,61,44,231,45,57,54,52,231,47,44,57,44,231,54,53},57))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({26,59,40,59,60,44,248},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,248},57))
destroyStatue(_d({26,59,40,59,60,44,249},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,248},57))
recheckStatue(_d({26,59,40,59,60,44,249},57))
destroyStatue(_d({26,59,40,59,60,44,250},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,250},57))
recheckStatue(_d({26,59,40,59,60,44,249},57))
recheckStatue(_d({26,59,40,59,60,44,248},57))
if not enabled then return end
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,55,47,40,58,44,231,249,231,59,54,231,44,53,43},57))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({23,47,40,58,44,231,249,231,44,53,43,231,62,40,48,59,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,41,40,42,50,231,59,54,231,24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
navToPointConfirmed(COORDS.Queen, 30, _d({24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59,231,24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
task.wait(5)
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,59,54,231,55,54,58,59,244,24,60,44,44,53,231,55,54,58,48,59,48,54,53},57))
navToPointConfirmed(COORDS.PostQueen, 30, _d({55,54,58,59,244,24,60,44,44,53,231,55,54,58,48,59,48,54,53},57))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({12,53,40,41,51,48,53,46,243,231,55,54,58,231,9,12,13,22,25,12,231,55,51,40,53,1},57), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({23,51,40,53,231,44,57,57,54,57,1},57), err2) end
end)
debug(_d({12,53,40,41,51,44,43,1},57), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({12,53,40,41,51,44,43,1},57), enabled)
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
if not ok then debug(_d({16,53,55,60,59,9,44,46,40,53,231,44,57,57,54,57,1},57), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({14,40,52,44,231,51,54,40,43,44,43,243,231,40,60,59,54,244,58,59,40,57,59,48,53,46,231,59,47,44,231,55,51,40,53},57))
enableBot()
end)
if not ok then debug(_d({8,60,59,54,58,59,40,57,59,231,44,57,57,54,57,1},57), err) end
end)
debug(_d({19,54,40,43,44,43,231,169,71,91,231,40,60,59,54,244,58,59,40,57,59,48,53,46,231,54,53,42,44,231,59,47,44,231,46,40,52,44,231,45,48,53,48,58,47,44,58,231,51,54,40,43,48,53,46,231,239,55,57,44,58,58,231,23,231,59,54,231,59,54,46,46,51,44,231,52,40,53,60,40,51,51,64,240},57))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,25,40,64,45,48,44,51,43,246,52,40,48,53,246,58,54,60,57,42,44,245,51,60,40},57)
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
error(_d({34,15,54,57,54,231,61,249,36,231,13,40,48,51,44,43,231,59,54,231,51,54,40,43,231,25,40,64,45,48,44,51,43,231,28,16,231,19,48,41,57,40,57,64,245},57))
end
local Window = Rayfield:CreateWindow({
Name = _d({15,54,57,54,231,15,54,57,54,231,33,244,13,40,57,52,231,61,249},57),
LoadingTitle = _d({19,54,40,43,48,53,46,231,15,54,57,54,231,61,249,245,245,245},57),
LoadingSubtitle = _d({26,48,51,44,53,59,231,8,48,52,231,22,55,59,48,52,48,65,44,43},57),
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
local MainTab = Window:CreateTab(_d({8,60,59,54,231,13,40,57,52},57), 4483362458)
local SkillTab = Window:CreateTab(_d({26,50,48,51,51,231,26,44,59,59,48,53,46,58},57), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({15,54,57,54,244,15,54,57,54},57)) or (bp and bp:FindFirstChild(_d({15,54,57,54,244,15,54,57,54},57)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({21,23,10,58},57))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum = boss:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
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
if key == _d({15,48,59},57) then
return target.CFrame
elseif key == _d({27,40,57,46,44,59},57) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({34,15,54,57,54,231,61,249,36,231,20,44,59,40,59,40,41,51,44,231,47,54,54,50,231,45,40,48,51,44,43,1,231},57) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({34,15,54,57,54,231,61,249,36,231,10,51,44,40,53,44,43,231,60,55,231,55,57,44,61,48,54,60,58,231,58,44,58,58,48,54,53,245},57))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({26,59,40,59,60,58,1,231,30,40,48,59,48,53,46,231,45,54,57,231,9,54,58,58,231,26,55,40,62,53},57)) end
print(_d({34,15,54,57,54,231,61,249,36,231,9,54,58,58},57), _G.HoroSelectedBoss, _d({48,58,231,53,54,59,231,58,55,40,62,53,44,43,245,231,30,40,48,59,48,53,46,245,245,245},57))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({26,59,40,59,60,58,1,231,25,60,53,53,48,53,46,231,10,54,52,41,54},57)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({34,15,54,57,54,231,61,249,36,231,13,48,57,44,43,231,10,231,239,18,40,52,48,50,40,65,44,240},57))
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
print(_d({34,15,54,57,54,231,61,249,36,231,13,48,57,44,43,231,33,231,239,20,48,53,48,231,9,40,57,57,40,46,44,240},57))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({34,15,54,57,54,231,61,249,36,231,13,48,57,44,43,231,12,231,239,26,59,60,53,240},57))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({34,15,54,57,54,231,61,249,36,231,13,48,57,44,43,231,25,231,239,11,44,59,54,53,40,59,48,54,53,240},57))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({26,59,40,59,60,58,1,231,26,51,44,44,55,48,53,46,231,239},57) .. string.format(_d({236,245,248,45},57), finalSleep) .. _d({58,240},57)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({26,59,40,59,60,58,1,231,16,43,51,44},57))
MainTab:CreateDropdown({
Name = _d({26,44,51,44,42,59,231,9,54,58,58},57),
Options = {_d({8,63,44,231,15,40,53,43,231,19,54,46,40,53},57), _d({9,40,53,43,48,59,231,9,54,58,58},57), _d({17,60,65,54,231,59,47,44,231,11,48,40,52,54,53,43,41,40,42,50},57)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({34,15,54,57,54,231,61,249,36,231,26,44,51,44,42,59,44,43,231,59,40,57,46,44,59,1},57), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({26,59,40,57,59,231,8,60,59,54,231,13,40,57,52},57),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({26,44,51,44,42,59,231,9,54,58,58,231,25,44,56,60,48,57,44,43},57),
Content = _d({32,54,60,231,52,60,58,59,231,58,44,51,44,42,59,231,40,231,41,54,58,58,231,45,48,57,58,59,231,41,44,45,54,57,44,231,44,53,40,41,51,48,53,46,231,8,60,59,54,231,13,40,57,52,232},57),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({26,59,40,59,60,58,1,231,16,43,51,44},57)) end
end
print(_d({34,15,54,57,54,231,61,249,36,231,8,60,59,54,231,13,40,57,52,1},57), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({11,44,58,59,57,54,64,231,28,16},57),
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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, "Combat")
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = "Bandit"
local selectedWeapon = availableWeapons[1] or "Combat"
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {"Bandit", _d({9,40,53,43,48,59,231,9,54,58,58},57), "Daph_d({243,231},57)Haku_d({243,231},57)Lily_d({243,231},57)Lion Pride_d({243,231},57)Marquan_d({243,231},57)Robo_d({243,231},57)Ronny_d({243,231},57)Sarah"}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild("Stats_d({240,231,40,53,43,231,58,59,40,59,58,13,54,51,43,44,57,245,26,59,40,59,58,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,239},57)Peli") then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({21,23,10,58},57))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum = npc:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({21,23,10,58},57))
local yi = folder and folder:FindFirstChild("Yi")
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == "Yi_d({231,40,53,43,231,54,41,49,1,16,58,8,239},57)Model") then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({21,23,10,58},57))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find("water_d({240,231,54,57,231,47,48,59,21,40,52,44,1,45,48,53,43,239},57)sea_d({240,231,54,57,231,47,48,59,21,40,52,44,1,45,48,53,43,239},57)ocean") or raycastResult.Material == Enum.Material.Water
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
if part:IsA(_d({9,40,58,44,23,40,57,59},57)) then
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
local att = root:FindFirstChild("__GrinderAtt_d({240,231,54,57,231,16,53,58,59,40,53,42,44,245,53,44,62,239},57)Attachment")
att.Name = "__GrinderAtt"
att.Parent = root
local force = root:FindFirstChild("__GrinderForce")
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
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
if not autoGrind then
local root = getRoot()
if root then
local force = root:FindFirstChild("__GrinderForce")
local att = root:FindFirstChild("__GrinderAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
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
end
end
end)
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or "None"
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
end)
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
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local peli = getPeli()
if autoBuyGeppo and (peli >= 50000 or bypassPeliCheck) and not boughtGeppo then
local yi = findYiNPC()
if yi then
local yiRoot = yi:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if yiRoot then
local targetPos = yiRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
if dir.Magnitude > 8 then
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
else
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, yiRoot.Position)
local prompt = yi:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Gepo Grinder] fireproximityprompt not supported by executor!")
end
task.wait(1.5)
if getPeli() < 50000 and not bypassPeliCheck then
boughtGeppo = true
end
end
end
return
end
end
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({240,231,40,53,43,231,53,55,42,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,30,47,48,42,47,16,58,8,239},57)Humanoid").Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({240,231,40,53,43,231,45,48,53,40,51,21,55,42,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,30,47,48,42,47,16,58,8,239},57)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
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
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({240,231,40,53,43,231,45,48,53,40,51,21,55,42,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,30,47,48,42,47,16,58,8,239},57)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
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
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
local playerGui = LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
if playerGui then
local oldUI = playerGui:FindFirstChild("GPOGrinderNativeUI")
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild("GrinderMobileToggle")
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print("[Gepo Grinder] Cleaned up previous session.")
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet("https://raw.githubusercontent.com/rockyxwall/WindUI/main/dist/main.lua"))()
end)
if not ok or type(WindUI) ~= "table" then
warn("[Gepo Grinder] Failed to load WindUI.")
return
end
local Window = WindUI:CreateWindow({
Title = "Gepo Grinder v0.0.18",
Icon = _d({58,62,54,57,43},57),
Folder = "GepoGrinder",
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = "Dark",
OpenButton = {
Title = "Gepo Grinder",
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({8,60,59,54,231,13,40,57,52},57), Icon = _d({58,62,54,57,43},57) })
local tabGeppo = Window:Tab({ Title = "Geppo Buyer_d({243,231,16,42,54,53,231,4,231},57)shopping-cart" })
local tabSettings = Window:Tab({ Title = "Settings_d({243,231,16,42,54,53,231,4,231},57)settings" })
tabFarm:Toggle({
Title = "Auto Grind Mobs [P]",
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = "Target Mob",
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = "Weapon / Melee",
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = "Peli Wallet",
Desc = "Loading..."
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = "Peli Wallet_d({243,231,11,44,58,42,231,4,231,59,54,58,59,57,48,53,46,239,55,44,51,48,240,231,245,245,231,239,55,44,51,48,231,5,4,231,252,247,247,247,247,231,40,53,43,231},57) [READY!]_d({231,54,57,231},57)") })
end
end)
end
end)
tabGeppo:Toggle({
Title = "Auto Buy Geppo",
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = "Bypass 50k Peli Check",
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = "Destroy UI & Stop Everything",
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print("[Gepo Grinder Hub] v0.0.18 loaded with WindUI.")
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 30.0
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
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum = char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({240,231,54,57,231,16,53,58,59,40,53,42,44,245,53,44,62,239},57)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
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
print("[Easy Travel] Loaded. Press 'P' to toggle flight. Press _d({12,53,43},57) to completely unload.")
return {
Start = startFlight,
Stop = stopFlight,
}
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local RunService = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local UserInputService = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({48,43,51,44},57)
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
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({48,53,61,54,50,44,14,44,55,55,54,231,44,57,57,54,57,1},57), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({240,231,54,57,231,16,53,58,59,40,53,42,44,245,53,44,62,239},57)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
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
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({30,40,51,50,48,53,46,231,59,54,1},57), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({62,40,51,50,27,54,23,54,48,53,59,231,30,231,43,54,62,53,231,44,57,57,54,57,1},57), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({8,57,57,48,61,44,43,231,40,59,1},57), pos)
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
if item:IsA("Model_d({240,231,40,53,43,231,48,59,44,52,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,239},57)HumanoidRootPart_d({240,231,40,53,43,231,48,59,44,52,1,13,48,53,43,13,48,57,58,59,10,47,48,51,43,30,47,48,42,47,16,58,8,239},57)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57)).Health > 0 then
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
mode = _d({48,43,51,44},57)
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
if mode == _d({47,54,61,44,57},57) then
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
local playerGui = LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
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
statusLabel.Text = _d({26,59,40,59,60,58,1,231,16,43,51,44},57)
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
enableBot(_d({47,54,61,44,57},57))
statusLabel.Text = "Status: Hovering _d({231,245,245,231,61,40,51,231,245,245,231},57) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({231,245,245,231,61,40,51,231,245,245,231},57) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({231,245,245,231,61,40,51,231,245,245,231},57) studs)"
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
local VIM = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({243,231},57)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({243,231},57)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({243,231},57)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({243,231},57)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({243,231},57)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()