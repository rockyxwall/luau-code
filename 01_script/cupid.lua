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
local Players            = game:GetService(_d({17,45,34,58,38,51,52},63))
local UserInputService    = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
local RunService          = game:GetService(_d({19,54,47,20,38,51,55,42,36,38},63))
local VIM                 = game:GetService(_d({23,42,51,53,54,34,45,10,47,49,54,53,14,34,47,34,40,38,51},63))
local ReplicatedStorage    = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({28,3,48,52,52,3,48,53,30},63), _d({24,51,48,47,40,225,40,34,46,38,225,163,65,85,225,17,45,34,36,38,10,37,251},63), game.PlaceId, _d({22,47,42,55,38,51,52,38,10,37,251},63), game.GameId, _d({238,225,47,48,53,225,51,54,47,47,42,47,40},63))
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
local LEO_PILLAR_ANIM_ID   = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,246,243,245,245,242,245,242,244,243,248},63)
local LEO_ENTEI_ANIM_ID    = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,246,243,245,245,242,244,249,243,248,249},63)
local LEO_HIKEN_ANIM_ID    = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,246,243,243,241,250,242,248,245,241,248},63)
local LEO_FIREFLY_ANIM_ID  = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,246,243,243,241,243,244,247,242,246,245},63)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({16,35,43,38,36,53,42,55,38,52},63)
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
local REPLAY_BUTTON_VALUE   = _d({19,38,49,45,34,58},63)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({46,48,55,38},63)
local NavState   = {mode = _d({42,37,45,38},63)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({28,3,48,52,52,3,48,53,30},63), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end)
if ok then return root end
debug(_d({40,38,53,19,48,48,53,225,38,51,51,48,51,251},63), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
end)
if ok then return hum end
debug(_d({40,38,53,9,54,46,34,47,48,42,37,225,38,51,51,48,51,251},63), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({32,32,9,48,55,38,51,2,53,53},63)) or Instance.new(_d({2,53,53,34,36,41,46,38,47,53},63))
att.Name = _d({32,32,9,48,55,38,51,2,53,53},63)
att.Parent = root
local force = root:FindFirstChild(_d({32,32,9,48,55,38,51,7,48,51,36,38},63))
if not force then
force = Instance.new(_d({13,42,47,38,34,51,23,38,45,48,36,42,53,58},63))
force.Name = _d({32,32,9,48,55,38,51,7,48,51,36,38},63)
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
debug(_d({40,38,53,16,51,4,51,38,34,53,38,7,48,51,36,38,225,38,51,51,48,51,251},63), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not root then return end
local force = root:FindFirstChild(_d({32,32,9,48,55,38,51,7,48,51,36,38},63))
local att   = root:FindFirstChild(_d({32,32,9,48,55,38,51,2,53,53},63))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({36,45,38,34,47,54,49,7,48,51,36,38,225,38,51,51,48,51,251},63), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({3,54,52,48,14,38,45,38,38},63)) ~= nil
end)
if ok then return result end
debug(_d({42,52,3,54,52,48,2,36,53,42,55,38,225,38,51,51,48,51,251},63), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({3,54,52,48},63))
end)
if not ok then debug(_d({34,36,53,42,55,34,53,38,3,54,52,48,225,38,51,51,48,51,251},63), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({3,54,52,48,225,47,48,53,225,34,36,53,42,55,38,237,225,34,36,53,42,55,34,53,42,47,40},63))
activateBuso()
end
end)
if not ok then debug(_d({3,54,52,48,12,38,38,49,38,51,225,38,51,51,48,51,251},63), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({3,54,52,48,225,44,38,38,49,38,51,225,52,53,48,49,49,38,37},63))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({12,38,47,9,34,44,42},63)) ~= nil
end)
if ok then return result end
debug(_d({42,52,12,38,47,2,36,53,42,55,38,225,38,51,51,48,51,251},63), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({12,38,47},63), true)
end)
if not ok then debug(_d({34,36,53,42,55,34,53,38,12,38,47,225,38,51,51,48,51,251},63), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({12,38,47,225,47,48,53,225,34,36,53,42,55,38,237,225,34,36,53,42,55,34,53,42,47,40},63))
activateKen()
end
end)
if not ok then debug(_d({12,38,47,12,38,38,49,38,51,225,38,51,51,48,51,251},63), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({12,38,47,225,44,38,38,49,38,51,225,52,53,48,49,49,38,37},63))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({15,17,4,52},63)) end)
if ok then return folder end
debug(_d({40,38,53,15,17,4,52,7,48,45,37,38,51,225,38,51,51,48,51,251},63), folder)
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
local r = model:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local h = model:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
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
debug(_d({40,38,53,15,38,34,51,38,52,53,15,17,4,225,38,51,51,48,51,251},63), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
local hum  = model:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({40,38,53,15,17,4,3,58,15,34,46,38,225,38,51,51,48,51,251},63), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({47,49,36,52,19,38,46,34,42,47,42,47,40,225,38,51,51,48,51,251},63), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({4,54,49,42,37,225,18,54,38,38,47},63))
return queen ~= nil and queen:FindFirstChild(_d({46,48,53,42,48,47,13,38,52,52},63)) ~= nil
end)
if ok then return result end
debug(_d({42,52,18,54,38,38,47,17,41,34,52,38,243,225,38,51,51,48,51,251},63), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,242,243,242,243,250,248,250,245,243,243,250,243,248,247,250},63)
local QUEEN_GRASP_ANIM_ID   = _d({51,35,57,34,52,52,38,53,42,37,251,240,240,242,243,250,249,241,241,241,247,242,241,241,242,248,244,245},63)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
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
debug(_d({42,52,17,45,34,58,42,47,40,2,47,42,46,7,51,48,46,13,42,52,53,225,38,51,51,48,51,251},63), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({3,45,48,36,44,42,47,40},63)) ~= nil
end)
if ok then return result end
debug(_d({42,52,15,17,4,3,45,48,36,44,42,47,40,225,38,51,51,48,51,251},63), result)
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
debug(_d({49,51,38,37,42,36,53,15,17,4,17,48,52,42,53,42,48,47,225,38,51,51,48,51,251},63), result)
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
debug(_d({15,48,225,37,34,46,34,40,38,225,48,47},63), model.Name, _d({39,48,51},63), NPC_STUCK_TIMEOUT, _d({52,225,238,225,52,56,42,53,36,41,42,47,40,225,53,34,51,40,38,53},63))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({53,51,34,36,44,15,17,4,5,34,46,34,40,38,225,38,51,51,48,51,251},63), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({14,48,37,38,45},63)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({3,34,52,38,17,34,51,53},63)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({40,38,53,14,48,37,38,45,7,34,36,38,17,48,52,225,38,51,51,48,51,251},63), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({6,47,55},63))
local folder = env and env:FindFirstChild(_d({20,53,34,53,54,38,52},63))
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
debug(_d({40,38,53,20,53,34,53,54,38,14,48,37,38,45,15,38,34,51,225,38,51,51,48,51,251},63), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({35,34,51,51,38,45,9,17},63))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({40,38,53,20,53,34,53,54,38,9,17,225,38,51,51,48,51,251},63), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({21,48,48,45},63)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({39,42,47,37,21,48,48,45,3,58,2,53,53,51,42,35,54,53,38,225,38,51,51,48,51,251},63), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({21,48,48,45},63)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({39,42,47,37,21,48,48,45,3,58,15,34,46,38,225,38,51,51,48,51,251},63), tool)
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
if not ok then debug(_d({38,50,54,42,49,21,48,48,45,225,38,51,51,48,51,251},63), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({3,34,36,44,49,34,36,44},63))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({21,48,48,45},63)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({39,42,47,37,21,48,48,45,3,58,4,41,42,45,37,15,34,46,38,225,38,51,51,48,51,251},63), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({20,56,48,51,37,6,50,54,42,49},63))
if sword then
equipTool(sword)
return _d({52,56,48,51,37},63)
end
local melee = findToolByAttribute(_d({14,38,45,38,38,21,48,48,45},63))
if melee then
equipTool(melee)
return _d({46,38,45,38,38},63)
end
debug(_d({15,48,225,52,56,48,51,37,225,48,51,225,46,38,45,38,38,225,53,48,48,45,225,39,48,54,47,37},63))
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
if not ok then debug(_d({36,45,42,36,44,14,242,225,38,51,51,48,51,251},63), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({19,48,44,54,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({8,38,49,49,48},63), args)
elseif style == _d({3,45,34,36,44,13,38,40},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44},63), args)
elseif style == _d({12,34,46,42,52,41,42,44,42},63) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,34,46,42,52,41,42,44,42,8,38,49,49,48},63), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,44,58,225,24,34,45,44,243},63), args)
end
end)
if not ok then debug(_d({42,47,55,48,44,38,8,38,49,49,48,225,38,51,51,48,51,251},63), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({49,51,38,52,52,20,44,42,45,45,19,225,38,51,51,48,51,251},63), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({41,48,45,37,3,45,48,36,44,225,38,51,51,48,51,251},63), err) end
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
if not ok then debug(_d({41,48,45,37,3,45,48,36,44,24,41,42,45,38,225,38,51,51,48,51,251},63), err) end
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
debug(_d({40,38,53,8,34,46,38,8,225,38,51,51,48,51,251},63), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({42,52,19,38,34,45,14,242,3,54,52,58,225,38,51,51,48,51,251},63), result)
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
return char ~= nil and char:FindFirstChild(_d({52,53,54,47},63)) ~= nil
end)
if ok then return result end
debug(_d({42,52,20,53,54,47,47,38,37,225,38,51,51,48,51,251},63), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({49,51,38,52,52,20,53,54,47,3,51,38,34,44,225,38,51,51,48,51,251},63), err) end
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
debug(_d({50,54,38,38,47,5,48,37,40,38,22,47,53,42,45,20,34,39,38,251,225,18,54,38,38,47,225,40,48,47,38,225,238,225,38,47,37,42,47,40,225,37,48,37,40,38,225,38,34,51,45,58},63))
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
debug(_d({50,54,38,38,47,5,48,37,40,38,22,47,53,42,45,20,34,39,38,225,52,34,39,38,53,58,225,53,42,46,38,48,54,53},63))
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
local info = getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({18,54,38,38,47,225,36,34,52,53,42,47,40,225,37,38,53,38,36,53,38,37,225,238,225,37,48,37,40,42,47,40,225,233,56,34,53,36,41,38,51,234},63))
queenDodgeUntilSafe(function() return getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63)) end)
if enabled and getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63)) then
setNavNamed(_d({4,54,49,42,37,225,18,54,38,38,47},63))
end
queenDodging = false
end
end)
if not ok then debug(_d({50,54,38,38,47,5,48,37,40,38,24,34,53,36,41,38,51,225,38,51,51,48,51,251},63), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({49,48,42,47,53},63) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({47,49,36},63) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({47,34,46,38,37},63) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({40,38,53,15,34,55,21,34,51,40,38,53,52,225,38,51,51,48,51,251},63), aimR)
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
debug(_d({36,48,46,49,54,53,38,13,48,36,44,38,37,4,7,51,34,46,38,225,38,51,51,48,51,251},63), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({49,48,42,47,53},63), point = pos}
phase = _d({46,48,55,38},63)
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
if not ok then debug(_d({47,34,55,21,48,17,48,42,47,53,225,40,38,49,49,48,225,36,41,38,36,44,225,38,51,51,48,51,251},63), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({47,49,36},63)}
phase = _d({46,48,55,38},63)
end
function setNavNamed(name)
NavState = {mode = _d({47,34,46,38,37},63), name = name}
phase = _d({46,48,55,38},63)
end
local function setNavIdle()
NavState = {mode = _d({42,37,45,38},63)}
phase = _d({46,48,55,38},63)
end
local function hasArrived()
return phase == _d({41,48,55,38,51},63)
end
local function startNav()
phase = _d({46,48,55,38},63)
debug(_d({15,34,55,225,45,48,48,49,225,16,15},63))
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
local prevPos = force:GetAttribute(_d({32,32,49,51,38,55,17,48,52},63))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({13,34,51,40,38,225,49,48,52,42,53,42,48,47,225,43,54,46,49,225,37,38,53,38,36,53,38,37,251},63), delta, _d({52,53,54,37,52,239,225,49,51,38,55,17,48,52,254},63), prevPos, _d({47,38,56,17,48,52,254},63), pos)
end
end
force:SetAttribute(_d({32,32,49,51,38,55,17,48,52},63), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({46,48,55,38},63) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({41,48,55,38,51},63)
debug(_d({17,41,34,52,38,251,225,41,48,55,38,51},63))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({226,226,226,225,19,6,7,22,20,10,15,8,225,21,16,225,2,17,17,13,26,225,2,3,15,16,19,14,2,13,225,23,6,13,16,4,10,21,26,251},63), finalVel, _d({34,42,46,254},63), aim, _d({49,48,52,254},63), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({41,48,55,38,51},63) then
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
debug(_d({4,48,46,35,34,53,225,45,48,36,44,225,52,44,42,49,49,38,37,237},63), snapDist, _d({52,53,54,37,52,225,39,51,48,46,225,53,34,51,40,38,53,225,163,65,85,225,39,34,45,45,42,47,40,225,35,34,36,44,225,53,48,225,46,48,55,38},63))
phase = _d({46,48,55,38},63)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({9,38,34,51,53,35,38,34,53,225,38,51,51,48,51,251},63), err) end
end)
end
local function stopNav()
debug(_d({15,34,55,225,45,48,48,49,225,16,7,7},63))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({46,48,55,38},63)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({21,38,57,53,4,41,34,53,20,38,51,55,42,36,38},63))
local channels = TextChatService:FindFirstChild(_d({21,38,57,53,4,41,34,47,47,38,45,52},63))
local channel = channels and channels:FindFirstChild(_d({19,3,25,8,38,47,38,51,34,45},63))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({5,38,39,34,54,45,53,4,41,34,53,20,58,52,53,38,46,4,41,34,53,6,55,38,47,53,52},63))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({20,34,58,14,38,52,52,34,40,38,19,38,50,54,38,52,53},63))
if sayEvent then
sayEvent:FireServer(message, _d({2,45,45},63))
return
end
debug(_d({52,38,47,37,4,41,34,53,14,38,52,52,34,40,38,251,225,47,48,225,21,38,57,53,4,41,34,53,20,38,51,55,42,36,38,239,19,3,25,8,38,47,38,51,34,45,225,48,51,225,45,38,40,34,36,58,225,20,34,58,14,38,52,52,34,40,38,19,38,50,54,38,52,53,225,39,48,54,47,37,225,39,48,51},63), message)
end)
if not ok then debug(_d({52,38,47,37,4,41,34,53,14,38,52,52,34,40,38,225,38,51,51,48,51,251},63), err) end
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
debug(_d({15,48,53,225,46,34,44,42,47,40,225,49,51,48,40,51,38,52,52,225,53,48,56,34,51,37,225,47,34,55,225,53,34,51,40,38,53,225,39,48,51},63), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({52,225,238,225,52,38,47,37,42,47,40,225,240,54,47,52,53,54,36,44},63))
sendChatMessage(_d({240,54,47,52,53,54,36,44},63))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({56,34,42,53,22,47,53,42,45,2,51,51,42,55,38,37,225,53,42,46,38,48,54,53},63))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({47,34,55,21,48,17,48,42,47,53,4,48,47,39,42,51,46,38,37,251},63), label or _d({53,34,51,40,38,53},63), _d({238,225,37,42,37,225,47,48,53,225,34,51,51,42,55,38,225,56,42,53,41,42,47},63), timeout, _d({52,237,225,51,38,53,51,58,42,47,40,225,48,47,36,38},63))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({47,34,55,21,48,17,48,42,47,53,4,48,47,39,42,51,46,38,37,251},63), label or _d({53,34,51,40,38,53},63), _d({238,225,52,53,42,45,45,225,47,48,53,225,34,51,51,42,55,38,37,225,34,39,53,38,51,225,51,38,53,51,58,237,225,49,51,48,36,38,38,37,42,47,40,225,34,47,58,56,34,58},63))
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
if not ok then debug(_d({47,34,55,21,48,17,48,42,47,53,9,48,45,37,42,47,40,3,45,48,36,44,225,44,38,58,238,37,48,56,47,225,38,51,51,48,51,251},63), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({47,34,55,21,48,17,48,42,47,53,9,48,45,37,42,47,40,3,45,48,36,44,225,44,38,58,238,54,49,225,38,51,51,48,51,251},63), err2) end
end
local function clearStage(stageName)
debug(_d({14,48,55,42,47,40,225,53,48},63), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({24,34,42,53,42,47,40,225,39,48,51,225,15,17,4,52,225,53,48,225,52,49,34,56,47,225,34,53},63), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({225,225,52,49,34,56,47,225,36,41,38,36,44,251,225,39,48,45,37,38,51,225,38,57,42,52,53,52,225,254},63), folder ~= nil,
_d({237,225,36,41,42,45,37,51,38,47,225,254},63), folder and #folder:GetChildren() or 0,
_d({237,225,34,45,42,55,38,225,254},63), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({15,48,225,15,17,4,52,225,34,49,49,38,34,51,38,37,225,34,53},63), stageName, _d({34,39,53,38,51,225,242,246,52,237,225,46,48,55,42,47,40,225,48,47,225,34,47,58,56,34,58},63))
break
end
end
debug(_d({12,42,45,45,42,47,40,225,15,17,4,52,225,34,53},63), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({19,38,53,54,51,47,42,47,40,225,53,48},63), stageName, _d({49,48,52,42,53,42,48,47,225,35,38,39,48,51,38,225,46,48,55,42,47,40,225,48,47},63))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({24,34,42,53,42,47,40,225,246,52,225,34,53},63), stageName, _d({49,48,52,42,53,42,48,47},63))
task.wait(5)
debug(stageName, _d({36,45,38,34,51,38,37},63))
end
local function killNamedNPC(name, targetPos)
debug(_d({14,48,55,42,47,40,225,53,48},63), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({37,38,39,38,34,53,38,37},63))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({9,54,46,34,47,48,42,37},63))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({13,38,48,225,49,45,34,58,38,37,225,34,47,42,46,34,53,42,48,47,251},63), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({45,38,48,2,47,42,46,13,48,40,40,38,51,225,49,51,42,47,53,225,38,51,51,48,51,251},63), err2) end
end)
end)
if not ok then debug(_d({52,53,34,51,53,13,38,48,2,47,42,46,13,48,40,40,38,51,225,38,51,51,48,51,251},63), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({14,48,55,42,47,40,225,53,48,225,13,38,48,225,233,35,45,48,36,44,42,47,40,225,34,39,53,38,51},63), LEO_BLOCK_DELAY, _d({52,234},63))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({13,38,48},63))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({13,38,48},63))
while enabled do
local info = getNPCByName(_d({13,38,48},63))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({13,38,48,225,36,34,52,53,42,47,40},63), which, _d({238,225,37,48,37,40,42,47,40},63))
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
if not getNPCByName(_d({13,38,48},63)) then
debug(_d({13,38,48,225,40,48,47,38,225,46,42,37,238,37,48,37,40,38,225,238,225,38,47,37,42,47,40,225,6,47,53,38,42,225,41,48,45,37,225,38,34,51,45,58},63))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({13,38,48},63)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({13,38,48,225,40,48,47,38,225,46,42,37,238,37,48,37,40,38,225,238,225,38,47,37,42,47,40,225,7,45,34,46,38,225,17,42,45,45,34,51,225,41,48,45,37,225,38,34,51,45,58},63))
end
end
end
if enabled and getNPCByName(_d({13,38,48},63)) then
setNavNamed(_d({13,38,48},63))
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
debug(_d({13,38,48,225,37,38,39,38,34,53,38,37},63))
stopLeoAnimLogger()
debug(_d({19,38,53,54,51,47,42,47,40,225,53,48,225,13,38,48,225,49,48,52,42,53,42,48,47,225,35,38,39,48,51,38,225,46,48,55,42,47,40,225,48,47},63))
navToPointConfirmed(COORDS.Leo, 30, _d({13,38,48,225,49,48,52,42,53,42,48,47},63))
debug(_d({24,34,42,53,42,47,40,225,246,52,225,34,53,225,13,38,48,225,49,48,52,42,53,42,48,47},63))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({14,48,55,42,47,40,225,53,48},63), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({4,48,54,45,37,225,47,48,53,225,39,42,47,37,225,52,53,34,53,54,38,225,46,48,37,38,45,225,47,38,34,51},63), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({2,53,53,34,36,44,42,47,40},63), coordKey, _d({56,42,53,41},63), weapon or _d({47,48,53,41,42,47,40,225,39,48,54,47,37},63))
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
debug(coordKey, _d({35,34,51,51,38,45,225,37,38,52,53,51,48,58,38,37},63))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({51,38,36,41,38,36,44,20,53,34,53,54,38,251},63), coordKey, _d({238,225,36,48,54,45,37,225,47,48,53,225,39,42,47,37,225,52,53,34,53,54,38,225,46,48,37,38,45,237,225,52,44,42,49,49,42,47,40},63))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({51,38,36,41,38,36,44,20,53,34,53,54,38,251},63), coordKey, _d({52,53,42,45,45,225,34,45,42,55,38,225,233,9,17},63), hp, _d({234,225,238,225,51,38,238,37,38,52,53,51,48,58,42,47,40},63))
destroyStatue(coordKey)
else
debug(_d({51,38,36,41,38,36,44,20,53,34,53,54,38,251},63), coordKey, _d({36,48,47,39,42,51,46,38,37,225,37,38,52,53,51,48,58,38,37},63))
end
end)
if not ok then debug(_d({51,38,36,41,38,36,44,20,53,34,53,54,38,225,38,51,51,48,51,251},63), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({14,48,55,42,47,40,225,53,48,225,18,54,38,38,47},63))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({4,54,49,42,37,225,18,54,38,38,47},63))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({18,54,38,38,47,225,38,47,53,38,51,38,37,225,49,41,34,52,38,225,243},63))
end
local function finishQueen()
debug(_d({7,42,47,42,52,41,42,47,40,225,18,54,38,38,47},63))
equipSwordOrMelee()
setNavNamed(_d({4,54,49,42,37,225,18,54,38,38,47},63))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({4,54,49,42,37,225,18,54,38,38,47},63))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({18,54,38,38,47,225,37,38,39,38,34,53,38,37,239,225,17,45,34,47,225,36,48,46,49,45,38,53,38,239},63))
end
local CONFIRMATION_PROMPT_NAME = _d({4,48,47,39,42,51,46,34,53,42,48,47,17,51,48,46,49,53},63)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({17,45,34,58,38,51,8,54,42},63))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({19,38,46,48,53,38,6,55,38,47,53},63), 5)
end)
if ok then return result end
debug(_d({40,38,53,19,38,49,45,34,58,19,38,46,48,53,38,225,38,51,51,48,51,251},63), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({10,46,34,40,38,3,54,53,53,48,47},63)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({35,54,53,53,48,47,23,34,45,54,38},63)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({39,42,47,37,3,54,53,53,48,47,3,58,23,34,45,54,38,225,38,51,51,48,51,251},63), result)
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
if not ok then debug(_d({36,45,42,36,44,8,54,42,3,54,53,53,48,47,225,38,51,51,48,51,251},63), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({42,52,20,38,51,55,38,51},63))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({19,38,46,48,53,38,6,55,38,47,53},63))
or inst:FindFirstChild(_d({36,45,42,38,47,53,6,55,38,47,53},63))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({39,42,47,37,2,47,52,56,38,51,4,48,47,47,38,36,53,48,51,225,38,51,51,48,51,251},63), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({4,48,54,45,37,225,47,48,53,225,45,48,36,34,53,38,225,19,38,46,48,53,38,6,55,38,47,53,240,36,45,42,38,47,53,6,55,38,47,53,225,47,38,34,51,225,19,38,49,45,34,58,225,35,54,53,53,48,47,237,225,39,34,45,45,42,47,40,225,35,34,36,44,225,53,48,225,36,45,42,36,44},63))
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
debug(_d({39,42,51,38,19,38,49,45,34,58,23,34,45,54,38,225,38,51,51,48,51,251},63), err, _d({238,225,39,34,45,45,42,47,40,225,35,34,36,44,225,53,48,225,36,45,42,36,44},63))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({7,34,45,45,42,47,40,225,35,34,36,44,225,53,48,225,35,54,53,53,48,47,23,34,45,54,38,225,52,38,34,51,36,41,225,39,48,51,225,19,38,49,45,34,58},63))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({19,38,49,45,34,58,225,35,54,53,53,48,47,225,47,48,53,225,39,48,54,47,37,225,38,42,53,41,38,51,237,225,40,42,55,42,47,40,225,54,49},63))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({24,34,42,53,42,47,40,225,39,48,51,225,4,48,47,39,42,51,46,34,53,42,48,47,17,51,48,46,49,53,239,19,38,46,48,53,38,6,55,38,47,53},63))
local remote = getReplayRemote()
if not remote then
debug(_d({4,48,47,39,42,51,46,34,53,42,48,47,17,51,48,46,49,53,240,19,38,46,48,53,38,6,55,38,47,53,225,47,48,53,225,39,48,54,47,37,225,56,42,53,41,42,47,225,53,42,46,38,48,54,53},63))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({7,42,51,42,47,40,225,19,38,49,45,34,58,225,55,42,34,225,4,48,47,39,42,51,46,34,53,42,48,47,17,51,48,46,49,53,239,19,38,46,48,53,38,6,55,38,47,53},63))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({7,42,51,38,20,38,51,55,38,51,225,38,51,51,48,51,251},63), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({17,45,34,58,38,51,8,54,42},63), 10)
if not playerGui then
debug(_d({56,34,42,53,7,48,51,16,35,43,38,36,53,42,55,38,52,8,54,42,251,225,47,48,225,17,45,34,58,38,51,8,54,42,225,56,42,53,41,42,47,225,53,42,46,38,48,54,53,237,225,49,51,48,36,38,38,37,42,47,40,225,34,47,58,56,34,58},63))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({16,35,43,38,36,53,42,55,38,52,225,8,22,10,225,39,48,54,47,37,225,238,225,52,53,34,40,38,225,45,48,34,37,38,37},63))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({16,35,43,38,36,53,42,55,38,52,225,8,22,10,225,47,48,53,225,39,48,54,47,37,225,56,42,53,41,42,47,225,53,42,46,38,48,54,53,237,225,49,51,48,36,38,38,37,42,47,40,225,34,47,58,56,34,58},63))
return
end
end
end)
if not ok then debug(_d({56,34,42,53,7,48,51,16,35,43,38,36,53,42,55,38,52,8,54,42,225,38,51,51,48,51,251},63), err) end
end
local function runPlan()
debug(_d({17,45,34,47,225,52,53,34,51,53,38,37},63))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({20,53,34,51,53,42,47,40,225,47,34,55,225,45,48,48,49},63))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({49,48,52,225,241,239,243,52,225,2,7,21,6,19,225,52,53,34,51,53,15,34,55,251},63), rootAfter and rootAfter.Position)
end)
debug(_d({24,34,42,53,42,47,40,225,246,52,225,35,38,39,48,51,38,225,46,48,55,42,47,40,225,53,48,225,20,53,34,40,38,242},63))
task.wait(5)
for _, stage in ipairs({_d({20,53,34,40,38,242},63), _d({20,53,34,40,38,243},63), _d({20,53,34,40,38,244},63), _d({20,53,34,40,38,244,3},63)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({14,48,55,42,47,40,225,53,48,225,34,51,51,48,56,225,39,45,58,238,37,48,56,47,225,34,51,38,34},63))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({5,48,37,40,42,47,40,225,34,51,51,48,56,225,51,34,42,47},63))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({20,53,34,40,38,245},63))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({18,54,38,38,47,225,42,47,225,49,41,34,52,38,225,243,225,238,225,44,38,38,49,42,47,40,225,12,38,47,225,9,34,44,42,225,34,36,53,42,55,38,225,39,51,48,46,225,41,38,51,38,225,48,47},63))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({20,53,34,53,54,38,242},63))
if not enabled then return end
recheckStatue(_d({20,53,34,53,54,38,242},63))
destroyStatue(_d({20,53,34,53,54,38,243},63))
if not enabled then return end
recheckStatue(_d({20,53,34,53,54,38,242},63))
recheckStatue(_d({20,53,34,53,54,38,243},63))
destroyStatue(_d({20,53,34,53,54,38,244},63))
if not enabled then return end
recheckStatue(_d({20,53,34,53,54,38,244},63))
recheckStatue(_d({20,53,34,53,54,38,243},63))
recheckStatue(_d({20,53,34,53,54,38,242},63))
if not enabled then return end
debug(_d({24,34,42,53,42,47,40,225,39,48,51,225,49,41,34,52,38,225,243,225,53,48,225,38,47,37},63))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({17,41,34,52,38,225,243,225,38,47,37,225,56,34,42,53,225,53,42,46,38,48,54,53,237,225,49,51,48,36,38,38,37,42,47,40,225,34,47,58,56,34,58},63))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({14,48,55,42,47,40,225,35,34,36,44,225,53,48,225,18,54,38,38,47,225,52,53,34,40,38,225,49,48,52,42,53,42,48,47},63))
navToPointConfirmed(COORDS.Queen, 30, _d({18,54,38,38,47,225,52,53,34,40,38,225,49,48,52,42,53,42,48,47},63))
debug(_d({24,34,42,53,42,47,40,225,246,52,225,34,53,225,18,54,38,38,47,225,52,53,34,40,38,225,49,48,52,42,53,42,48,47},63))
task.wait(5)
if not enabled then return end
debug(_d({14,48,55,42,47,40,225,53,48,225,49,48,52,53,238,18,54,38,38,47,225,49,48,52,42,53,42,48,47},63))
navToPointConfirmed(COORDS.PostQueen, 30, _d({49,48,52,53,238,18,54,38,38,47,225,49,48,52,42,53,42,48,47},63))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({6,47,34,35,45,42,47,40,237,225,49,48,52,225,3,6,7,16,19,6,225,49,45,34,47,251},63), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({17,45,34,47,225,38,51,51,48,51,251},63), err2) end
end)
debug(_d({6,47,34,35,45,38,37,251},63), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({6,47,34,35,45,38,37,251},63), enabled)
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
if not ok then debug(_d({10,47,49,54,53,3,38,40,34,47,225,38,51,51,48,51,251},63), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({8,34,46,38,225,45,48,34,37,38,37,237,225,34,54,53,48,238,52,53,34,51,53,42,47,40,225,53,41,38,225,49,45,34,47},63))
enableBot()
end)
if not ok then debug(_d({2,54,53,48,52,53,34,51,53,225,38,51,51,48,51,251},63), err) end
end)
debug(_d({13,48,34,37,38,37,225,163,65,85,225,34,54,53,48,238,52,53,34,51,53,42,47,40,225,48,47,36,38,225,53,41,38,225,40,34,46,38,225,39,42,47,42,52,41,38,52,225,45,48,34,37,42,47,40,225,233,49,51,38,52,52,225,17,225,53,48,225,53,48,40,40,45,38,225,46,34,47,54,34,45,45,58,234},63))
end)()