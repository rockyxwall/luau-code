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
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({33,61,50,74,54,67,68},47))
local UserInputService    = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local RunService          = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local VIM                 = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local ReplicatedStorage    = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({44,19,64,68,68,19,64,69,46},47), _d({40,67,64,63,56,241,56,50,62,54,241,179,81,101,241,33,61,50,52,54,26,53,11},47), game.PlaceId, _d({38,63,58,71,54,67,68,54,26,53,11},47), game.GameId, _d({254,241,63,64,69,241,67,70,63,63,58,63,56},47))
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
local LEO_PILLAR_ANIM_ID   = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,6,3,5,5,2,5,2,4,3,8},47)
local LEO_ENTEI_ANIM_ID    = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,6,3,5,5,2,4,9,3,8,9},47)
local LEO_HIKEN_ANIM_ID    = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,6,3,3,1,10,2,8,5,1,8},47)
local LEO_FIREFLY_ANIM_ID  = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,6,3,3,1,3,4,7,2,6,5},47)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({32,51,59,54,52,69,58,71,54,68},47)
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
local REPLAY_BUTTON_VALUE   = _d({35,54,65,61,50,74},47)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({62,64,71,54},47)
local NavState   = {mode = _d({58,53,61,54},47)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({44,19,64,68,68,19,64,69,46},47), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end)
if ok then return root end
debug(_d({56,54,69,35,64,64,69,241,54,67,67,64,67,11},47), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end)
if ok then return hum end
debug(_d({56,54,69,25,70,62,50,63,64,58,53,241,54,67,67,64,67,11},47), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({250,241,64,67,241,26,63,68,69,50,63,52,54,255,63,54,72,249},47)Attachment")
att.Name = _d({48,48,25,64,71,54,67,18,69,69},47)
att.Parent = root
local force = root:FindFirstChild(_d({48,48,25,64,71,54,67,23,64,67,52,54},47))
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
force.Name = _d({48,48,25,64,71,54,67,23,64,67,52,54},47)
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
debug(_d({56,54,69,32,67,20,67,54,50,69,54,23,64,67,52,54,241,54,67,67,64,67,11},47), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local force = root:FindFirstChild(_d({48,48,25,64,71,54,67,23,64,67,52,54},47))
local att   = root:FindFirstChild(_d({48,48,25,64,71,54,67,18,69,69},47))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({52,61,54,50,63,70,65,23,64,67,52,54,241,54,67,67,64,67,11},47), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({19,70,68,64,30,54,61,54,54},47)) ~= nil
end)
if ok then return result end
debug(_d({58,68,19,70,68,64,18,52,69,58,71,54,241,54,67,67,64,67,11},47), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({19,70,68,64},47))
end)
if not ok then debug(_d({50,52,69,58,71,50,69,54,19,70,68,64,241,54,67,67,64,67,11},47), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({19,70,68,64,241,63,64,69,241,50,52,69,58,71,54,253,241,50,52,69,58,71,50,69,58,63,56},47))
activateBuso()
end
end)
if not ok then debug(_d({19,70,68,64,28,54,54,65,54,67,241,54,67,67,64,67,11},47), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({19,70,68,64,241,60,54,54,65,54,67,241,68,69,64,65,65,54,53},47))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({28,54,63,25,50,60,58},47)) ~= nil
end)
if ok then return result end
debug(_d({58,68,28,54,63,18,52,69,58,71,54,241,54,67,67,64,67,11},47), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({28,54,63},47), true)
end)
if not ok then debug(_d({50,52,69,58,71,50,69,54,28,54,63,241,54,67,67,64,67,11},47), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({28,54,63,241,63,64,69,241,50,52,69,58,71,54,253,241,50,52,69,58,71,50,69,58,63,56},47))
activateKen()
end
end)
if not ok then debug(_d({28,54,63,28,54,54,65,54,67,241,54,67,67,64,67,11},47), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({28,54,63,241,60,54,54,65,54,67,241,68,69,64,65,65,54,53},47))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({31,33,20,68},47)) end)
if ok then return folder end
debug(_d({56,54,69,31,33,20,68,23,64,61,53,54,67,241,54,67,67,64,67,11},47), folder)
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
local r = model:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local h = model:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
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
debug(_d({56,54,69,31,54,50,67,54,68,69,31,33,20,241,54,67,67,64,67,11},47), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum  = model:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({56,54,69,31,33,20,19,74,31,50,62,54,241,54,67,67,64,67,11},47), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({63,65,52,68,35,54,62,50,58,63,58,63,56,241,54,67,67,64,67,11},47), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({20,70,65,58,53,241,34,70,54,54,63},47))
return queen ~= nil and queen:FindFirstChild(_d({62,64,69,58,64,63,29,54,68,68},47)) ~= nil
end)
if ok then return result end
debug(_d({58,68,34,70,54,54,63,33,57,50,68,54,3,241,54,67,67,64,67,11},47), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,2,3,2,3,10,8,10,5,3,3,10,3,8,7,10},47)
local QUEEN_GRASP_ANIM_ID   = _d({67,51,73,50,68,68,54,69,58,53,11,0,0,2,3,10,9,1,1,1,7,2,1,1,2,8,4,5},47)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
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
debug(_d({58,68,33,61,50,74,58,63,56,18,63,58,62,23,67,64,62,29,58,68,69,241,54,67,67,64,67,11},47), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({19,61,64,52,60,58,63,56},47)) ~= nil
end)
if ok then return result end
debug(_d({58,68,31,33,20,19,61,64,52,60,58,63,56,241,54,67,67,64,67,11},47), result)
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
debug(_d({65,67,54,53,58,52,69,31,33,20,33,64,68,58,69,58,64,63,241,54,67,67,64,67,11},47), result)
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
debug(_d({31,64,241,53,50,62,50,56,54,241,64,63},47), model.Name, _d({55,64,67},47), NPC_STUCK_TIMEOUT, _d({68,241,254,241,68,72,58,69,52,57,58,63,56,241,69,50,67,56,54,69},47))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({69,67,50,52,60,31,33,20,21,50,62,50,56,54,241,54,67,67,64,67,11},47), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({30,64,53,54,61},47)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({19,50,68,54,33,50,67,69},47)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({56,54,69,30,64,53,54,61,23,50,52,54,33,64,68,241,54,67,67,64,67,11},47), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({22,63,71},47))
local folder = env and env:FindFirstChild(_d({36,69,50,69,70,54,68},47))
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
debug(_d({56,54,69,36,69,50,69,70,54,30,64,53,54,61,31,54,50,67,241,54,67,67,64,67,11},47), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({51,50,67,67,54,61,25,33},47))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({56,54,69,36,69,50,69,70,54,25,33,241,54,67,67,64,67,11},47), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({37,64,64,61},47)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({55,58,63,53,37,64,64,61,19,74,18,69,69,67,58,51,70,69,54,241,54,67,67,64,67,11},47), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({37,64,64,61},47)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({55,58,63,53,37,64,64,61,19,74,31,50,62,54,241,54,67,67,64,67,11},47), tool)
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
if not ok then debug(_d({54,66,70,58,65,37,64,64,61,241,54,67,67,64,67,11},47), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({37,64,64,61},47)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({55,58,63,53,37,64,64,61,19,74,20,57,58,61,53,31,50,62,54,241,54,67,67,64,67,11},47), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({36,72,64,67,53,22,66,70,58,65},47))
if sword then
equipTool(sword)
return _d({68,72,64,67,53},47)
end
local melee = findToolByAttribute(_d({30,54,61,54,54,37,64,64,61},47))
if melee then
equipTool(melee)
return _d({62,54,61,54,54},47)
end
debug(_d({31,64,241,68,72,64,67,53,241,64,67,241,62,54,61,54,54,241,69,64,64,61,241,55,64,70,63,53},47))
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
if not ok then debug(_d({52,61,58,52,60,30,2,241,54,67,67,64,67,11},47), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({35,64,60,70,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,54,65,65,64},47), args)
elseif style == _d({19,61,50,52,60,29,54,56},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60},47), args)
elseif style == _d({28,50,62,58,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,50,62,58,68,57,58,60,58,24,54,65,65,64},47), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60,3},47), args)
end
end)
if not ok then debug(_d({58,63,71,64,60,54,24,54,65,65,64,241,54,67,67,64,67,11},47), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({65,67,54,68,68,36,60,58,61,61,35,241,54,67,67,64,67,11},47), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({57,64,61,53,19,61,64,52,60,241,54,67,67,64,67,11},47), err) end
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
if not ok then debug(_d({57,64,61,53,19,61,64,52,60,40,57,58,61,54,241,54,67,67,64,67,11},47), err) end
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
debug(_d({56,54,69,24,50,62,54,24,241,54,67,67,64,67,11},47), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({58,68,35,54,50,61,30,2,19,70,68,74,241,54,67,67,64,67,11},47), result)
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
return char ~= nil and char:FindFirstChild(_d({68,69,70,63},47)) ~= nil
end)
if ok then return result end
debug(_d({58,68,36,69,70,63,63,54,53,241,54,67,67,64,67,11},47), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({65,67,54,68,68,36,69,70,63,19,67,54,50,60,241,54,67,67,64,67,11},47), err) end
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
debug(_d({66,70,54,54,63,21,64,53,56,54,38,63,69,58,61,36,50,55,54,11,241,34,70,54,54,63,241,56,64,63,54,241,254,241,54,63,53,58,63,56,241,53,64,53,56,54,241,54,50,67,61,74},47))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({66,70,54,54,63,21,64,53,56,54,38,63,69,58,61,36,50,55,54,241,68,50,55,54,69,74,241,69,58,62,54,64,70,69},47))
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
local info = getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({34,70,54,54,63,241,52,50,68,69,58,63,56,241,53,54,69,54,52,69,54,53,241,254,241,53,64,53,56,58,63,56,241,249,72,50,69,52,57,54,67,250},47))
queenDodgeUntilSafe(function() return getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47)) end)
if enabled and getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47)) then
setNavNamed(_d({20,70,65,58,53,241,34,70,54,54,63},47))
end
queenDodging = false
end
end)
if not ok then debug(_d({66,70,54,54,63,21,64,53,56,54,40,50,69,52,57,54,67,241,54,67,67,64,67,11},47), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({65,64,58,63,69},47) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({63,65,52},47) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({63,50,62,54,53},47) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({56,54,69,31,50,71,37,50,67,56,54,69,68,241,54,67,67,64,67,11},47), aimR)
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
debug(_d({52,64,62,65,70,69,54,29,64,52,60,54,53,20,23,67,50,62,54,241,54,67,67,64,67,11},47), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({65,64,58,63,69},47), point = pos}
phase = _d({62,64,71,54},47)
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
if not ok then debug(_d({63,50,71,37,64,33,64,58,63,69,241,56,54,65,65,64,241,52,57,54,52,60,241,54,67,67,64,67,11},47), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({63,65,52},47)}
phase = _d({62,64,71,54},47)
end
function setNavNamed(name)
NavState = {mode = _d({63,50,62,54,53},47), name = name}
phase = _d({62,64,71,54},47)
end
local function setNavIdle()
NavState = {mode = _d({58,53,61,54},47)}
phase = _d({62,64,71,54},47)
end
local function hasArrived()
return phase == _d({57,64,71,54,67},47)
end
local function startNav()
phase = _d({62,64,71,54},47)
debug(_d({31,50,71,241,61,64,64,65,241,32,31},47))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({33,61,50,74,54,67,241,53,58,54,53,242,241,36,69,64,65,65,58,63,56,241,51,64,69,255},47))
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
debug(_d({33,61,50,74,54,67,241,58,68,241,69,64,64,241,55,50,67,241,55,67,64,62,241,69,50,67,56,54,69,241,249,15,3,1,1,1,241,68,69,70,53,68,250,255,241,29,58,60,54,61,74,241,67,54,68,65,50,72,63,54,53,241,50,69,241,61,64,51,51,74,255,241,36,69,64,65,65,58,63,56,241,51,64,69,255},47))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({48,48,65,67,54,71,33,64,68},47))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({29,50,67,56,54,241,65,64,68,58,69,58,64,63,241,59,70,62,65,241,53,54,69,54,52,69,54,53,11},47), delta, _d({68,69,70,53,68,255,241,65,67,54,71,33,64,68,14},47), prevPos, _d({63,54,72,33,64,68,14},47), pos)
end
end
force:SetAttribute(_d({48,48,65,67,54,71,33,64,68},47), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({62,64,71,54},47) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({57,64,71,54,67},47)
debug(_d({33,57,50,68,54,11,241,57,64,71,54,67},47))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({242,242,242,241,35,22,23,38,36,26,31,24,241,37,32,241,18,33,33,29,42,241,18,19,31,32,35,30,18,29,241,39,22,29,32,20,26,37,42,11},47), finalVel, _d({50,58,62,14},47), aim, _d({65,64,68,14},47), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({57,64,71,54,67},47) then
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
debug(_d({20,64,62,51,50,69,241,61,64,52,60,241,68,60,58,65,65,54,53,253},47), snapDist, _d({68,69,70,53,68,241,55,67,64,62,241,69,50,67,56,54,69,241,179,81,101,241,55,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,62,64,71,54},47))
phase = _d({62,64,71,54},47)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({25,54,50,67,69,51,54,50,69,241,54,67,67,64,67,11},47), err) end
end)
end
local function stopNav()
debug(_d({31,50,71,241,61,64,64,65,241,32,23,23},47))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({62,64,71,54},47)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({37,54,73,69,20,57,50,69,36,54,67,71,58,52,54},47))
local channels = TextChatService:FindFirstChild(_d({37,54,73,69,20,57,50,63,63,54,61,68},47))
local channel = channels and channels:FindFirstChild(_d({35,19,41,24,54,63,54,67,50,61},47))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({21,54,55,50,70,61,69,20,57,50,69,36,74,68,69,54,62,20,57,50,69,22,71,54,63,69,68},47))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({36,50,74,30,54,68,68,50,56,54,35,54,66,70,54,68,69},47))
if sayEvent then
sayEvent:FireServer(message, _d({18,61,61},47))
return
end
debug(_d({68,54,63,53,20,57,50,69,30,54,68,68,50,56,54,11,241,63,64,241,37,54,73,69,20,57,50,69,36,54,67,71,58,52,54,255,35,19,41,24,54,63,54,67,50,61,241,64,67,241,61,54,56,50,52,74,241,36,50,74,30,54,68,68,50,56,54,35,54,66,70,54,68,69,241,55,64,70,63,53,241,55,64,67},47), message)
end)
if not ok then debug(_d({68,54,63,53,20,57,50,69,30,54,68,68,50,56,54,241,54,67,67,64,67,11},47), err) end
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
debug(_d({31,64,69,241,62,50,60,58,63,56,241,65,67,64,56,67,54,68,68,241,69,64,72,50,67,53,241,63,50,71,241,69,50,67,56,54,69,241,55,64,67},47), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({68,241,254,241,68,54,63,53,58,63,56,241,0,70,63,68,69,70,52,60},47))
sendChatMessage(_d({0,70,63,68,69,70,52,60},47))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({72,50,58,69,38,63,69,58,61,18,67,67,58,71,54,53,241,69,58,62,54,64,70,69},47))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({63,50,71,37,64,33,64,58,63,69,20,64,63,55,58,67,62,54,53,11},47), label or _d({69,50,67,56,54,69},47), _d({254,241,53,58,53,241,63,64,69,241,50,67,67,58,71,54,241,72,58,69,57,58,63},47), timeout, _d({68,253,241,67,54,69,67,74,58,63,56,241,64,63,52,54},47))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({63,50,71,37,64,33,64,58,63,69,20,64,63,55,58,67,62,54,53,11},47), label or _d({69,50,67,56,54,69},47), _d({254,241,68,69,58,61,61,241,63,64,69,241,50,67,67,58,71,54,53,241,50,55,69,54,67,241,67,54,69,67,74,253,241,65,67,64,52,54,54,53,58,63,56,241,50,63,74,72,50,74},47))
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
if not ok then debug(_d({63,50,71,37,64,33,64,58,63,69,25,64,61,53,58,63,56,19,61,64,52,60,241,60,54,74,254,53,64,72,63,241,54,67,67,64,67,11},47), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({63,50,71,37,64,33,64,58,63,69,25,64,61,53,58,63,56,19,61,64,52,60,241,60,54,74,254,70,65,241,54,67,67,64,67,11},47), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({40,50,61,60,58,63,56,241,69,64,11},47), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({72,50,61,60,37,64,33,64,58,63,69,241,40,241,53,64,72,63,241,54,67,67,64,67,11},47), err) end
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
debug(_d({37,64,64,60,241,53,50,62,50,56,54,241,72,57,58,61,54,241,72,50,61,60,58,63,56,241,69,64,241,65,64,58,63,69,242,241,36,69,64,65,65,58,63,56,241,72,50,61,60,241,69,64,241,54,63,56,50,56,54,255},47))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({18,67,67,58,71,54,53,241,50,69,11},47), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({36,69,70,52,60,241,53,70,67,58,63,56,241,72,50,61,60,253,241,59,70,62,65,58,63,56,242},47))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({36,69,58,61,61,241,68,69,70,52,60,253,241,69,67,58,56,56,54,67,58,63,56,241,24,54,65,65,64,242},47))
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
debug(_d({30,64,71,58,63,56,241,69,64},47), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({40,50,58,69,58,63,56,241,55,64,67,241,31,33,20,68,241,69,64,241,68,65,50,72,63,241,50,69},47), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({241,241,68,65,50,72,63,241,52,57,54,52,60,11,241,55,64,61,53,54,67,241,54,73,58,68,69,68,241,14},47), folder ~= nil,
_d({253,241,52,57,58,61,53,67,54,63,241,14},47), folder and #folder:GetChildren() or 0,
_d({253,241,50,61,58,71,54,241,14},47), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({31,64,241,31,33,20,68,241,50,65,65,54,50,67,54,53,241,50,69},47), stageName, _d({50,55,69,54,67,241,2,6,68,253,241,62,64,71,58,63,56,241,64,63,241,50,63,74,72,50,74},47))
break
end
end
debug(_d({28,58,61,61,58,63,56,241,31,33,20,68,241,50,69},47), stageName)
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
debug(_d({35,54,69,70,67,63,58,63,56,241,69,64},47), stageName, _d({65,64,68,58,69,58,64,63,241,51,54,55,64,67,54,241,62,64,71,58,63,56,241,64,63},47))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({40,50,58,69,58,63,56,241,6,68,241,50,69},47), stageName, _d({65,64,68,58,69,58,64,63},47))
task.wait(5)
debug(_d({40,50,58,69,58,63,56,241,55,64,67},47), targetHP * 100, _d({246,241,25,33,241,51,54,55,64,67,54,241,62,64,71,58,63,56,241,69,64,241,63,54,73,69,241,68,69,50,56,54},47))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({52,61,54,50,67,54,53},47))
end
local function killNamedNPC(name, targetPos)
debug(_d({30,64,71,58,63,56,241,69,64},47), name)
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
debug(name, _d({53,54,55,54,50,69,54,53},47))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({29,54,64,241,65,61,50,74,54,53,241,50,63,58,62,50,69,58,64,63,11},47), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({61,54,64,18,63,58,62,29,64,56,56,54,67,241,65,67,58,63,69,241,54,67,67,64,67,11},47), err2) end
end)
end)
if not ok then debug(_d({68,69,50,67,69,29,54,64,18,63,58,62,29,64,56,56,54,67,241,54,67,67,64,67,11},47), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({30,64,71,58,63,56,241,69,64,241,29,54,64},47))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({29,54,64},47))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({29,54,64},47))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({29,54,64},47))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({29,54,64,241,52,50,68,69,58,63,56},47), which, _d({254,241,53,64,53,56,58,63,56},47))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({29,54,64,241,68,69,50,67,69,54,53,241,51,61,64,52,60,254,51,67,54,50,60,54,67,241,62,58,53,254,51,61,64,52,60,242,241,22,71,50,53,58,63,56,255,255,255},47))
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
if not getNPCByName(_d({29,54,64},47)) then
debug(_d({29,54,64,241,56,64,63,54,241,62,58,53,254,53,64,53,56,54,241,254,241,54,63,53,58,63,56,241,22,63,69,54,58,241,57,64,61,53,241,54,50,67,61,74},47))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({29,54,64},47)) then
setNavNamed(_d({29,54,64},47))
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
debug(_d({29,54,64,241,53,54,55,54,50,69,54,53},47))
stopLeoAnimLogger()
debug(_d({35,54,69,70,67,63,58,63,56,241,69,64,241,29,54,64,241,65,64,68,58,69,58,64,63,241,51,54,55,64,67,54,241,62,64,71,58,63,56,241,64,63},47))
navToPointConfirmed(COORDS.Leo, 30, _d({29,54,64,241,65,64,68,58,69,58,64,63},47))
debug(_d({40,50,58,69,58,63,56,241,6,68,241,50,69,241,29,54,64,241,65,64,68,58,69,58,64,63},47))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({30,64,71,58,63,56,241,69,64},47), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({20,64,70,61,53,241,63,64,69,241,55,58,63,53,241,68,69,50,69,70,54,241,62,64,53,54,61,241,63,54,50,67},47), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({18,69,69,50,52,60,58,63,56},47), coordKey, _d({72,58,69,57},47), weapon or _d({63,64,69,57,58,63,56,241,55,64,70,63,53},47))
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
debug(coordKey, _d({51,50,67,67,54,61,241,53,54,68,69,67,64,74,54,53},47))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({67,54,52,57,54,52,60,36,69,50,69,70,54,11},47), coordKey, _d({254,241,52,64,70,61,53,241,63,64,69,241,55,58,63,53,241,68,69,50,69,70,54,241,62,64,53,54,61,253,241,68,60,58,65,65,58,63,56},47))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({67,54,52,57,54,52,60,36,69,50,69,70,54,11},47), coordKey, _d({68,69,58,61,61,241,50,61,58,71,54,241,249,25,33},47), hp, _d({250,241,254,241,67,54,254,53,54,68,69,67,64,74,58,63,56},47))
destroyStatue(coordKey)
else
debug(_d({67,54,52,57,54,52,60,36,69,50,69,70,54,11},47), coordKey, _d({52,64,63,55,58,67,62,54,53,241,53,54,68,69,67,64,74,54,53},47))
end
end)
if not ok then debug(_d({67,54,52,57,54,52,60,36,69,50,69,70,54,241,54,67,67,64,67,11},47), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({30,64,71,58,63,56,241,69,64,241,34,70,54,54,63},47))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({20,70,65,58,53,241,34,70,54,54,63},47))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47))
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
debug(_d({34,70,54,54,63,241,54,63,69,54,67,54,53,241,65,57,50,68,54,241,3},47))
end
local function finishQueen()
debug(_d({23,58,63,58,68,57,58,63,56,241,34,70,54,54,63},47))
equipSwordOrMelee()
setNavNamed(_d({20,70,65,58,53,241,34,70,54,54,63},47))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({20,70,65,58,53,241,34,70,54,54,63},47))
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
debug(_d({34,70,54,54,63,241,53,54,55,54,50,69,54,53,255,241,33,61,50,63,241,52,64,62,65,61,54,69,54,255},47))
end
local CONFIRMATION_PROMPT_NAME = _d({20,64,63,55,58,67,62,50,69,58,64,63,33,67,64,62,65,69},47)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({35,54,62,64,69,54,22,71,54,63,69},47), 5)
end)
if ok then return result end
debug(_d({56,54,69,35,54,65,61,50,74,35,54,62,64,69,54,241,54,67,67,64,67,11},47), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({33,61,50,74,54,67,24,70,58},47))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({26,62,50,56,54,19,70,69,69,64,63},47)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({51,70,69,69,64,63,39,50,61,70,54},47)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({55,58,63,53,19,70,69,69,64,63,19,74,39,50,61,70,54,241,54,67,67,64,67,11},47), result)
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
if not ok then debug(_d({52,61,58,52,60,24,70,58,19,70,69,69,64,63,241,54,67,67,64,67,11},47), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({58,68,36,54,67,71,54,67},47))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({35,54,62,64,69,54,22,71,54,63,69},47))
or inst:FindFirstChild(_d({52,61,58,54,63,69,22,71,54,63,69},47))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({55,58,63,53,18,63,68,72,54,67,20,64,63,63,54,52,69,64,67,241,54,67,67,64,67,11},47), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({20,64,70,61,53,241,63,64,69,241,61,64,52,50,69,54,241,35,54,62,64,69,54,22,71,54,63,69,0,52,61,58,54,63,69,22,71,54,63,69,241,63,54,50,67,241,35,54,65,61,50,74,241,51,70,69,69,64,63,253,241,55,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,52,61,58,52,60},47))
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
debug(_d({55,58,67,54,35,54,65,61,50,74,39,50,61,70,54,241,54,67,67,64,67,11},47), err, _d({254,241,55,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,52,61,58,52,60},47))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({23,50,61,61,58,63,56,241,51,50,52,60,241,69,64,241,51,70,69,69,64,63,39,50,61,70,54,241,68,54,50,67,52,57,241,55,64,67,241,35,54,65,61,50,74},47))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({35,54,65,61,50,74,241,51,70,69,69,64,63,241,63,64,69,241,55,64,70,63,53,241,54,58,69,57,54,67,253,241,56,58,71,58,63,56,241,70,65},47))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({40,50,58,69,58,63,56,241,55,64,67,241,20,64,63,55,58,67,62,50,69,58,64,63,33,67,64,62,65,69,255,35,54,62,64,69,54,22,71,54,63,69},47))
local remote = getReplayRemote()
if not remote then
debug(_d({20,64,63,55,58,67,62,50,69,58,64,63,33,67,64,62,65,69,0,35,54,62,64,69,54,22,71,54,63,69,241,63,64,69,241,55,64,70,63,53,241,72,58,69,57,58,63,241,69,58,62,54,64,70,69},47))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({23,58,67,58,63,56,241,35,54,65,61,50,74,241,71,58,50,241,20,64,63,55,58,67,62,50,69,58,64,63,33,67,64,62,65,69,255,35,54,62,64,69,54,22,71,54,63,69},47))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({23,58,67,54,36,54,67,71,54,67,241,54,67,67,64,67,11},47), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47), 10)
if not playerGui then
debug(_d({72,50,58,69,23,64,67,32,51,59,54,52,69,58,71,54,68,24,70,58,11,241,63,64,241,33,61,50,74,54,67,24,70,58,241,72,58,69,57,58,63,241,69,58,62,54,64,70,69,253,241,65,67,64,52,54,54,53,58,63,56,241,50,63,74,72,50,74},47))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({32,51,59,54,52,69,58,71,54,68,241,24,38,26,241,55,64,70,63,53,241,254,241,68,69,50,56,54,241,61,64,50,53,54,53},47))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({32,51,59,54,52,69,58,71,54,68,241,24,38,26,241,63,64,69,241,55,64,70,63,53,241,72,58,69,57,58,63,241,69,58,62,54,64,70,69,253,241,65,67,64,52,54,54,53,58,63,56,241,50,63,74,72,50,74},47))
return
end
end
end)
if not ok then debug(_d({72,50,58,69,23,64,67,32,51,59,54,52,69,58,71,54,68,24,70,58,241,54,67,67,64,67,11},47), err) end
end
local function runPlan()
debug(_d({33,61,50,63,241,68,69,50,67,69,54,53},47))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({36,69,50,67,69,58,63,56,241,63,50,71,241,61,64,64,65},47))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({65,64,68,241,1,255,3,68,241,18,23,37,22,35,241,68,69,50,67,69,31,50,71,11},47), rootAfter and rootAfter.Position)
end)
debug(_d({40,50,58,69,58,63,56,241,6,68,241,51,54,55,64,67,54,241,62,64,71,58,63,56,241,69,64,241,36,69,50,56,54,2},47))
task.wait(5)
for _, stage in ipairs({_d({36,69,50,56,54,2},47), _d({36,69,50,56,54,3},47), _d({36,69,50,56,54,4},47), _d({36,69,50,56,54,4,19},47)}) do
if not enabled then return end
local hpTarget = (stage == _d({36,69,50,56,54,4,19},47)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({30,64,71,58,63,56,241,69,64,241,50,67,67,64,72,241,55,61,74,254,53,64,72,63,241,50,67,54,50,241,249,20,70,65,58,53,241,35,50,58,63,250},47))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({21,64,53,56,58,63,56,241,50,67,67,64,72,241,67,50,58,63,241,58,63,241,50,241,68,66,70,50,67,54},47))
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
clearStage(_d({36,69,50,56,54,5},47))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({34,70,54,54,63,241,58,63,241,65,57,50,68,54,241,3,241,254,241,60,54,54,65,58,63,56,241,28,54,63,241,25,50,60,58,241,50,52,69,58,71,54,241,55,67,64,62,241,57,54,67,54,241,64,63},47))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({36,69,50,69,70,54,2},47))
if not enabled then return end
recheckStatue(_d({36,69,50,69,70,54,2},47))
destroyStatue(_d({36,69,50,69,70,54,3},47))
if not enabled then return end
recheckStatue(_d({36,69,50,69,70,54,2},47))
recheckStatue(_d({36,69,50,69,70,54,3},47))
destroyStatue(_d({36,69,50,69,70,54,4},47))
if not enabled then return end
recheckStatue(_d({36,69,50,69,70,54,4},47))
recheckStatue(_d({36,69,50,69,70,54,3},47))
recheckStatue(_d({36,69,50,69,70,54,2},47))
if not enabled then return end
debug(_d({40,50,58,69,58,63,56,241,55,64,67,241,65,57,50,68,54,241,3,241,69,64,241,54,63,53},47))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({33,57,50,68,54,241,3,241,54,63,53,241,72,50,58,69,241,69,58,62,54,64,70,69,253,241,65,67,64,52,54,54,53,58,63,56,241,50,63,74,72,50,74},47))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({30,64,71,58,63,56,241,51,50,52,60,241,69,64,241,34,70,54,54,63,241,68,69,50,56,54,241,65,64,68,58,69,58,64,63},47))
navToPointConfirmed(COORDS.Queen, 30, _d({34,70,54,54,63,241,68,69,50,56,54,241,65,64,68,58,69,58,64,63},47))
debug(_d({40,50,58,69,58,63,56,241,6,68,241,50,69,241,34,70,54,54,63,241,68,69,50,56,54,241,65,64,68,58,69,58,64,63},47))
task.wait(5)
if not enabled then return end
debug(_d({30,64,71,58,63,56,241,69,64,241,65,64,68,69,254,34,70,54,54,63,241,65,64,68,58,69,58,64,63},47))
navToPointConfirmed(COORDS.PostQueen, 30, _d({65,64,68,69,254,34,70,54,54,63,241,65,64,68,58,69,58,64,63},47))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({22,63,50,51,61,58,63,56,253,241,65,64,68,241,19,22,23,32,35,22,241,65,61,50,63,11},47), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({33,61,50,63,241,54,67,67,64,67,11},47), err2) end
end)
debug(_d({22,63,50,51,61,54,53,11},47), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({22,63,50,51,61,54,53,11},47), enabled)
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
if not ok then debug(_d({26,63,65,70,69,19,54,56,50,63,241,54,67,67,64,67,11},47), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({24,50,62,54,241,61,64,50,53,54,53,253,241,50,70,69,64,254,68,69,50,67,69,58,63,56,241,69,57,54,241,65,61,50,63},47))
enableBot()
end)
if not ok then debug(_d({18,70,69,64,68,69,50,67,69,241,54,67,67,64,67,11},47), err) end
end)
debug(_d({29,64,50,53,54,53,241,179,81,101,241,50,70,69,64,254,68,69,50,67,69,58,63,56,241,64,63,52,54,241,69,57,54,241,56,50,62,54,241,55,58,63,58,68,57,54,68,241,61,64,50,53,58,63,56,241,249,65,67,54,68,68,241,33,241,69,64,241,69,64,56,56,61,54,241,62,50,63,70,50,61,61,74,250},47))
end)();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({57,69,69,65,68,11,0,0,67,50,72,255,56,58,69,57,70,51,70,68,54,67,52,64,63,69,54,63,69,255,52,64,62,0,67,64,52,60,74,73,72,50,61,61,0,35,50,74,55,58,54,61,53,0,62,50,58,63,0,68,64,70,67,52,54,255,61,70,50},47)
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
error(_d({44,25,64,67,64,241,71,3,46,241,23,50,58,61,54,53,241,69,64,241,61,64,50,53,241,35,50,74,55,58,54,61,53,241,38,26,241,29,58,51,67,50,67,74,255},47))
end
local Window = Rayfield:CreateWindow({
Name = _d({25,64,67,64,241,25,64,67,64,241,43,254,23,50,67,62,241,71,3},47),
LoadingTitle = _d({29,64,50,53,58,63,56,241,25,64,67,64,241,71,3,255,255,255},47),
LoadingSubtitle = _d({36,58,61,54,63,69,241,18,58,62,241,32,65,69,58,62,58,75,54,53},47),
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
local MainTab = Window:CreateTab(_d({18,70,69,64,241,23,50,67,62},47), 4483362458)
local SkillTab = Window:CreateTab(_d({36,60,58,61,61,241,36,54,69,69,58,63,56,68},47), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({19,50,52,60,65,50,52,60},47))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)) or (bp and bp:FindFirstChild(_d({25,64,67,64,254,25,64,67,64},47)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({31,33,20,68},47))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = boss:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
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
if key == _d({25,58,69},47) then
return target.CFrame
elseif key == _d({37,50,67,56,54,69},47) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({44,25,64,67,64,241,71,3,46,241,30,54,69,50,69,50,51,61,54,241,57,64,64,60,241,55,50,58,61,54,53,11,241},47) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({44,25,64,67,64,241,71,3,46,241,20,61,54,50,63,54,53,241,70,65,241,65,67,54,71,58,64,70,68,241,68,54,68,68,58,64,63,255},47))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,40,50,58,69,58,63,56,241,55,64,67,241,19,64,68,68,241,36,65,50,72,63},47)) end
print(_d({44,25,64,67,64,241,71,3,46,241,19,64,68,68},47), _G.HoroSelectedBoss, _d({58,68,241,63,64,69,241,68,65,50,72,63,54,53,255,241,40,50,58,69,58,63,56,255,255,255},47))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,35,70,63,63,58,63,56,241,20,64,62,51,64},47)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,20,241,249,28,50,62,58,60,50,75,54,250},47))
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
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,43,241,249,30,58,63,58,241,19,50,67,67,50,56,54,250},47))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,22,241,249,36,69,70,63,250},47))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({44,25,64,67,64,241,71,3,46,241,23,58,67,54,53,241,35,241,249,21,54,69,64,63,50,69,58,64,63,250},47))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,36,61,54,54,65,58,63,56,241,249},47) .. string.format(_d({246,255,2,55},47), finalSleep) .. _d({68,250},47)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({36,69,50,69,70,68,11,241,26,53,61,54},47))
MainTab:CreateDropdown({
Name = _d({36,54,61,54,52,69,241,19,64,68,68},47),
Options = {_d({18,73,54,241,25,50,63,53,241,29,64,56,50,63},47), _d({19,50,63,53,58,69,241,19,64,68,68},47), _d({27,70,75,64,241,69,57,54,241,21,58,50,62,64,63,53,51,50,52,60},47)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({44,25,64,67,64,241,71,3,46,241,36,54,61,54,52,69,54,53,241,69,50,67,56,54,69,11},47), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({36,69,50,67,69,241,18,70,69,64,241,23,50,67,62},47),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({36,54,61,54,52,69,241,19,64,68,68,241,35,54,66,70,58,67,54,53},47),
Content = _d({42,64,70,241,62,70,68,69,241,68,54,61,54,52,69,241,50,241,51,64,68,68,241,55,58,67,68,69,241,51,54,55,64,67,54,241,54,63,50,51,61,58,63,56,241,18,70,69,64,241,23,50,67,62,242},47),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({36,69,50,69,70,68,11,241,26,53,61,54},47)) end
end
print(_d({44,25,64,67,64,241,71,3,46,241,18,70,69,64,241,23,50,67,62,11},47), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({21,54,68,69,67,64,74,241,38,26},47),
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
end)();
end
local function loadLevelGrinder()
(function()
_G.EasyTravelHelperMode = true
if _G.GepoGrinderRunning then
warn("[Gepo Grinder] Already running! Aborting duplicate launch.")
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local running = true
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end
local function waitForGameLoad()
print("[Gepo Grinder] Waiting for game to load...")
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart_d({250,241,64,67,241,63,64,69,241,29,64,52,50,61,33,61,50,74,54,67,255,20,57,50,67,50,52,69,54,67,11,23,58,63,53,23,58,67,68,69,20,57,58,61,53,40,57,58,52,57,26,68,18,249},47)Humanoid") do
task.wait(0.5)
end
local folderName = _d({36,69,50,69,68},47) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error("[Gepo Grinder] Stats folder not found in ReplicatedStorage!")
end
statsFolder:WaitForChild(_d({36,69,50,69,68},47), 10)
statsFolder:WaitForChild("Inventory", 10)
statsFolder:WaitForChild("Settings", 10)
print("[Gepo Grinder] Game fully loaded!")
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({36,69,50,69,68},47)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild("Level") and stats.Level.Value or 1
local peli = stats:FindFirstChild("Peli") and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild("Rifle_d({250,241,64,67,241,249,29,64,52,50,61,33,61,50,74,54,67,255,20,57,50,67,50,52,69,54,67,241,50,63,53,241,29,64,52,50,61,33,61,50,74,54,67,255,20,57,50,67,50,52,69,54,67,11,23,58,63,53,23,58,67,68,69,20,57,58,61,53,249},47)Rifle"))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild("Inventory_d({250,241,50,63,53,241,68,69,50,69,68,23,64,61,53,54,67,255,26,63,71,54,63,69,64,67,74,11,23,58,63,53,23,58,67,68,69,20,57,58,61,53,249},47)Inventory")
if invVal then
return invVal.Value:find('"Rifle"') ~= nil
end
return false
end
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
importLib("lib/easy_travel.lua_d({253,241},47)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 4.0 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn("[Gepo Grinder] _G.EasyTravel is missing. Cannot navigate.")
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function getHotbarMapping()
local slots = {"Zero_d({253,241},47)One_d({253,241},47)Two_d({253,241},47)Three_d({253,241},47)Four_d({253,241},47)Five_d({253,241},47)Six_d({253,241},47)Seven_d({253,241},47)Eight_d({253,241},47)Nine"}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = "None"
end
local pgui = LocalPlayer:FindFirstChild(_d({33,61,50,74,54,67,24,70,58},47))
local backpackGui = pgui and pgui:FindFirstChild("BackpackGui")
local hotbar = backpackGui and backpackGui:FindFirstChild("Hotbar")
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= "Design_d({241,50,63,53,241,52,57,58,61,53,255,31,50,62,54,241,79,14,241},47)Number_d({241,50,63,53,241,52,57,58,61,53,255,31,50,62,54,241,79,14,241},47)UIListLayout_d({241,50,63,53,241,52,57,58,61,53,255,31,50,62,54,241,79,14,241},47)UIPadding" then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print("[Gepo Grinder] Stopped: _d({241,255,255,241,249,67,54,50,68,64,63,241,64,67,241},47)done_d({250,241,255,255,241},47).")
end
_G.GepoGrinderCleanup = function()
cleanup("manual cleanup hook")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print("[Gepo Grinder] P pressed — aborting!")
cleanup("P key abort")
end
end
end)
local function flyToFishmanCave()
if not running then return end
print("[Gepo Grinder] Enabling Easy Travel and flying to Fishman Cave...")
_G.EasyTravelHelperMode = true;(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
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
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({250,241,64,67,241,26,63,68,69,50,63,52,54,255,63,54,72,249},47)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
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
local moveDir = Vector3.zero
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
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
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
else
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
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
_G.EasyTravel.GetSurfaceY = getSurfaceY
if not _G.EasyTravelHelperMode then
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
end
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
if _G.EasyTravelHelperMode then
print("[Easy Travel] Loaded in helper mode. Keyboard inputs disabled.")
else
print("[Easy Travel] Loaded. Press 'P' to toggle flight. _G.EasyTravel API registered.")
end
return _G.EasyTravel
end)();
if _G.EasyTravel and _G.EasyTravel.Start then
_G.EasyTravel.TargetPosition = Vector3.new(1837, -15, -12258)
_G.EasyTravel.Start()
local replicaElapsed = 0
while running do
task.wait(1)
replicaElapsed = replicaElapsed + 1
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if hrp then
local dist = (hrp.Position - _G.EasyTravel.TargetPosition).Magnitude
if dist < 50 then
print("[Gepo Grinder] Reached Fishman Cave! Stopping flight.")
_G.EasyTravel.Stop()
break
end
end
end
else
warn("[Gepo Grinder] Failed to initialize Easy Travel.")
end
cleanup("Arrived at Fishman Cave")
end
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if not hasRifleTool() then
print("[Gepo Grinder] Rifle not equipped. Waiting for user to manually buy and equip Rifle...")
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn("[Gepo Grinder] Not at Town of Beginnings. Please travel to Town of Beginnings so we can farm chests while waiting.")
while running and not hasRifleTool() do
task.wait(1)
end
else
if not _G.EasyTravel then
importLib("lib/easy_travel.lua_d({253,241},47)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
end
if not _G.ChestFarmer then
importLib("lib/chest_farmer.lua_d({253,241},47)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/chest_farmer.lua")
end
if _G.ChestFarmer then
local getPeli = function() return 0 end
local isRunning = function()
return running and not hasRifleTool()
end
print("[Gepo Grinder] Farming chests indefinitely until Rifle is manually equipped...")
_G.ChestFarmer.FarmUntilPeli(9999999, getPeli, isRunning)
else
error("[Gepo Grinder] Failed to load lib/chest_farmer.lua!")
end
end
end
if not running then return end
print("[Gepo Grinder] Rifle detected in inventory/hands!")
local rifle = LocalPlayer.Backpack:FindFirstChild("Rifle")
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print("[Gepo Grinder] Rifle equipped to RightHand!")
end
flyToFishmanCave()
end)
if not ok then
warn("[Gepo Grinder] Fatal error: " .. tostring(err))
cleanup("fatal error")
end
end)
end)();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
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
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
local hum = char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({250,241,64,67,241,26,63,68,69,50,63,52,54,255,63,54,72,249},47)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
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
local moveDir = Vector3.zero
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
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
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
else
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
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
_G.EasyTravel.GetSurfaceY = getSurfaceY
if not _G.EasyTravelHelperMode then
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
end
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
if _G.EasyTravelHelperMode then
print("[Easy Travel] Loaded in helper mode. Keyboard inputs disabled.")
else
print("[Easy Travel] Loaded. Press 'P' to toggle flight. _G.EasyTravel API registered.")
end
return _G.EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({33,61,50,74,54,67,68},47))
local RunService = game:GetService(_d({35,70,63,36,54,67,71,58,52,54},47))
local UserInputService = game:GetService(_d({38,68,54,67,26,63,65,70,69,36,54,67,71,58,52,54},47))
local ReplicatedStorage = game:GetService(_d({35,54,65,61,58,52,50,69,54,53,36,69,64,67,50,56,54},47))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({58,53,61,54},47)
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
return char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({36,69,50,69,68},47) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({35,64,60,70,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,54,65,65,64},47), args)
elseif style == _d({19,61,50,52,60,29,54,56},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60},47), args)
elseif style == _d({28,50,62,58,68,57,58,60,58},47) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,50,62,58,68,57,58,60,58,24,54,65,65,64},47), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,60,74,241,40,50,61,60,3},47), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({58,63,71,64,60,54,24,54,65,65,64,241,54,67,67,64,67,11},47), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({250,241,64,67,241,26,63,68,69,50,63,52,54,255,63,54,72,249},47)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({29,58,63,54,50,67,39,54,61,64,52,58,69,74},47))
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
local root = char:FindFirstChild(_d({25,70,62,50,63,64,58,53,35,64,64,69,33,50,67,69},47))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({40,50,61,60,58,63,56,241,69,64,11},47), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({72,50,61,60,37,64,33,64,58,63,69,241,40,241,53,64,72,63,241,54,67,67,64,67,11},47), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({18,67,67,58,71,54,53,241,50,69,11},47), pos)
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
if item:IsA("Model_d({250,241,50,63,53,241,58,69,54,62,11,23,58,63,53,23,58,67,68,69,20,57,58,61,53,249},47)HumanoidRootPart_d({250,241,50,63,53,241,58,69,54,62,11,23,58,63,53,23,58,67,68,69,20,57,58,61,53,40,57,58,52,57,26,68,18,249},47)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({25,70,62,50,63,64,58,53},47)).Health > 0 then
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
mode = _d({58,53,61,54},47)
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
if mode == _d({57,64,71,54,67},47) then
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
local playerGui = LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47), 10)
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
statusLabel.Text = _d({36,69,50,69,70,68,11,241,26,53,61,54},47)
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
enableBot(_d({57,64,71,54,67},47))
statusLabel.Text = "Status: Hovering _d({241,255,255,241,71,50,61,241,255,255,241},47) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({241,255,255,241,71,50,61,241,255,255,241},47) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({241,255,255,241,71,50,61,241,255,255,241},47) studs)"
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
local VIM = game:GetService(_d({39,58,67,69,70,50,61,26,63,65,70,69,30,50,63,50,56,54,67},47))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({33,61,50,74,54,67,24,70,58},47), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({253,241},47)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({253,241},47)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({253,241},47)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({253,241},47)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({253,241},47)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()