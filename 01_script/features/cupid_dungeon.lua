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
local Players            = game:GetService(_d({38,66,55,79,59,72,73},42))
local UserInputService    = game:GetService(_d({43,73,59,72,31,68,70,75,74,41,59,72,76,63,57,59},42))
local RunService          = game:GetService(_d({40,75,68,41,59,72,76,63,57,59},42))
local VIM                 = game:GetService(_d({44,63,72,74,75,55,66,31,68,70,75,74,35,55,68,55,61,59,72},42))
local ReplicatedStorage    = game:GetService(_d({40,59,70,66,63,57,55,74,59,58,41,74,69,72,55,61,59},42))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({49,24,69,73,73,24,69,74,51},42), _d({45,72,69,68,61,246,61,55,67,59,246,184,86,106,246,38,66,55,57,59,31,58,16},42), game.PlaceId, _d({43,68,63,76,59,72,73,59,31,58,16},42), game.GameId, _d({3,246,68,69,74,246,72,75,68,68,63,68,61},42))
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
local LEO_PILLAR_ANIM_ID   = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,11,8,10,10,7,10,7,9,8,13},42)
local LEO_ENTEI_ANIM_ID    = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,11,8,10,10,7,9,14,8,13,14},42)
local LEO_HIKEN_ANIM_ID    = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,11,8,8,6,15,7,13,10,6,13},42)
local LEO_FIREFLY_ANIM_ID  = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,11,8,8,6,8,9,12,7,11,10},42)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({37,56,64,59,57,74,63,76,59,73},42)
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
local REPLAY_BUTTON_VALUE   = _d({40,59,70,66,55,79},42)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({67,69,76,59},42)
local NavState   = {mode = _d({63,58,66,59},42)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({49,24,69,73,73,24,69,74,51},42), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
end)
if ok then return root end
debug(_d({61,59,74,40,69,69,74,246,59,72,72,69,72,16},42), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
end)
if ok then return hum end
debug(_d({61,59,74,30,75,67,55,68,69,63,58,246,59,72,72,69,72,16},42), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({53,53,30,69,76,59,72,23,74,74},42)) or Instance.new(_d({23,74,74,55,57,62,67,59,68,74},42))
att.Name = _d({53,53,30,69,76,59,72,23,74,74},42)
att.Parent = root
local force = root:FindFirstChild(_d({53,53,30,69,76,59,72,28,69,72,57,59},42))
if not force then
force = Instance.new(_d({34,63,68,59,55,72,44,59,66,69,57,63,74,79},42))
force.Name = _d({53,53,30,69,76,59,72,28,69,72,57,59},42)
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
debug(_d({61,59,74,37,72,25,72,59,55,74,59,28,69,72,57,59,246,59,72,72,69,72,16},42), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not root then return end
local force = root:FindFirstChild(_d({53,53,30,69,76,59,72,28,69,72,57,59},42))
local att   = root:FindFirstChild(_d({53,53,30,69,76,59,72,23,74,74},42))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({57,66,59,55,68,75,70,28,69,72,57,59,246,59,72,72,69,72,16},42), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({24,75,73,69,35,59,66,59,59},42)) ~= nil
end)
if ok then return result end
debug(_d({63,73,24,75,73,69,23,57,74,63,76,59,246,59,72,72,69,72,16},42), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({24,75,73,69},42))
end)
if not ok then debug(_d({55,57,74,63,76,55,74,59,24,75,73,69,246,59,72,72,69,72,16},42), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({24,75,73,69,246,68,69,74,246,55,57,74,63,76,59,2,246,55,57,74,63,76,55,74,63,68,61},42))
activateBuso()
end
end)
if not ok then debug(_d({24,75,73,69,33,59,59,70,59,72,246,59,72,72,69,72,16},42), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({24,75,73,69,246,65,59,59,70,59,72,246,73,74,69,70,70,59,58},42))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({33,59,68,30,55,65,63},42)) ~= nil
end)
if ok then return result end
debug(_d({63,73,33,59,68,23,57,74,63,76,59,246,59,72,72,69,72,16},42), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({33,59,68},42), true)
end)
if not ok then debug(_d({55,57,74,63,76,55,74,59,33,59,68,246,59,72,72,69,72,16},42), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({33,59,68,246,68,69,74,246,55,57,74,63,76,59,2,246,55,57,74,63,76,55,74,63,68,61},42))
activateKen()
end
end)
if not ok then debug(_d({33,59,68,33,59,59,70,59,72,246,59,72,72,69,72,16},42), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({33,59,68,246,65,59,59,70,59,72,246,73,74,69,70,70,59,58},42))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({36,38,25,73},42)) end)
if ok then return folder end
debug(_d({61,59,74,36,38,25,73,28,69,66,58,59,72,246,59,72,72,69,72,16},42), folder)
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
local r = model:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local h = model:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
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
debug(_d({61,59,74,36,59,55,72,59,73,74,36,38,25,246,59,72,72,69,72,16},42), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
local hum  = model:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({61,59,74,36,38,25,24,79,36,55,67,59,246,59,72,72,69,72,16},42), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({68,70,57,73,40,59,67,55,63,68,63,68,61,246,59,72,72,69,72,16},42), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({25,75,70,63,58,246,39,75,59,59,68},42))
return queen ~= nil and queen:FindFirstChild(_d({67,69,74,63,69,68,34,59,73,73},42)) ~= nil
end)
if ok then return result end
debug(_d({63,73,39,75,59,59,68,38,62,55,73,59,8,246,59,72,72,69,72,16},42), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,7,8,7,8,15,13,15,10,8,8,15,8,13,12,15},42)
local QUEEN_GRASP_ANIM_ID   = _d({72,56,78,55,73,73,59,74,63,58,16,5,5,7,8,15,14,6,6,6,12,7,6,6,7,13,9,10},42)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
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
debug(_d({63,73,38,66,55,79,63,68,61,23,68,63,67,28,72,69,67,34,63,73,74,246,59,72,72,69,72,16},42), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({24,66,69,57,65,63,68,61},42)) ~= nil
end)
if ok then return result end
debug(_d({63,73,36,38,25,24,66,69,57,65,63,68,61,246,59,72,72,69,72,16},42), result)
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
debug(_d({70,72,59,58,63,57,74,36,38,25,38,69,73,63,74,63,69,68,246,59,72,72,69,72,16},42), result)
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
debug(_d({36,69,246,58,55,67,55,61,59,246,69,68},42), model.Name, _d({60,69,72},42), NPC_STUCK_TIMEOUT, _d({73,246,3,246,73,77,63,74,57,62,63,68,61,246,74,55,72,61,59,74},42))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({74,72,55,57,65,36,38,25,26,55,67,55,61,59,246,59,72,72,69,72,16},42), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({35,69,58,59,66},42)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({24,55,73,59,38,55,72,74},42)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({61,59,74,35,69,58,59,66,28,55,57,59,38,69,73,246,59,72,72,69,72,16},42), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({27,68,76},42))
local folder = env and env:FindFirstChild(_d({41,74,55,74,75,59,73},42))
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
debug(_d({61,59,74,41,74,55,74,75,59,35,69,58,59,66,36,59,55,72,246,59,72,72,69,72,16},42), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({56,55,72,72,59,66,30,38},42))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({61,59,74,41,74,55,74,75,59,30,38,246,59,72,72,69,72,16},42), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({42,69,69,66},42)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({60,63,68,58,42,69,69,66,24,79,23,74,74,72,63,56,75,74,59,246,59,72,72,69,72,16},42), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({42,69,69,66},42)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({60,63,68,58,42,69,69,66,24,79,36,55,67,59,246,59,72,72,69,72,16},42), tool)
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
if not ok then debug(_d({59,71,75,63,70,42,69,69,66,246,59,72,72,69,72,16},42), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({24,55,57,65,70,55,57,65},42))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({42,69,69,66},42)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({60,63,68,58,42,69,69,66,24,79,25,62,63,66,58,36,55,67,59,246,59,72,72,69,72,16},42), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({41,77,69,72,58,27,71,75,63,70},42))
if sword then
equipTool(sword)
return _d({73,77,69,72,58},42)
end
local melee = findToolByAttribute(_d({35,59,66,59,59,42,69,69,66},42))
if melee then
equipTool(melee)
return _d({67,59,66,59,59},42)
end
debug(_d({36,69,246,73,77,69,72,58,246,69,72,246,67,59,66,59,59,246,74,69,69,66,246,60,69,75,68,58},42))
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
if not ok then debug(_d({57,66,63,57,65,35,7,246,59,72,72,69,72,16},42), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({30,75,67,55,68,69,63,58,40,69,69,74,38,55,72,74},42))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({41,74,55,74,73},42) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({40,69,65,75,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,59,70,70,69},42), args)
elseif style == _d({24,66,55,57,65,34,59,61},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65},42), args)
elseif style == _d({33,55,67,63,73,62,63,65,63},42) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,55,67,63,73,62,63,65,63,29,59,70,70,69},42), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,65,79,246,45,55,66,65,8},42), args)
end
end)
if not ok then debug(_d({63,68,76,69,65,59,29,59,70,70,69,246,59,72,72,69,72,16},42), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({70,72,59,73,73,41,65,63,66,66,40,246,59,72,72,69,72,16},42), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({62,69,66,58,24,66,69,57,65,246,59,72,72,69,72,16},42), err) end
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
if not ok then debug(_d({62,69,66,58,24,66,69,57,65,45,62,63,66,59,246,59,72,72,69,72,16},42), err) end
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
debug(_d({61,59,74,29,55,67,59,29,246,59,72,72,69,72,16},42), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({63,73,40,59,55,66,35,7,24,75,73,79,246,59,72,72,69,72,16},42), result)
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
return char ~= nil and char:FindFirstChild(_d({73,74,75,68},42)) ~= nil
end)
if ok then return result end
debug(_d({63,73,41,74,75,68,68,59,58,246,59,72,72,69,72,16},42), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({70,72,59,73,73,41,74,75,68,24,72,59,55,65,246,59,72,72,69,72,16},42), err) end
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
debug(_d({71,75,59,59,68,26,69,58,61,59,43,68,74,63,66,41,55,60,59,16,246,39,75,59,59,68,246,61,69,68,59,246,3,246,59,68,58,63,68,61,246,58,69,58,61,59,246,59,55,72,66,79},42))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({71,75,59,59,68,26,69,58,61,59,43,68,74,63,66,41,55,60,59,246,73,55,60,59,74,79,246,74,63,67,59,69,75,74},42))
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
local info = getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({39,75,59,59,68,246,57,55,73,74,63,68,61,246,58,59,74,59,57,74,59,58,246,3,246,58,69,58,61,63,68,61,246,254,77,55,74,57,62,59,72,255},42))
queenDodgeUntilSafe(function() return getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42)) end)
if enabled and getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42)) then
setNavNamed(_d({25,75,70,63,58,246,39,75,59,59,68},42))
end
queenDodging = false
end
end)
if not ok then debug(_d({71,75,59,59,68,26,69,58,61,59,45,55,74,57,62,59,72,246,59,72,72,69,72,16},42), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({70,69,63,68,74},42) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({68,70,57},42) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({68,55,67,59,58},42) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({61,59,74,36,55,76,42,55,72,61,59,74,73,246,59,72,72,69,72,16},42), aimR)
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
debug(_d({57,69,67,70,75,74,59,34,69,57,65,59,58,25,28,72,55,67,59,246,59,72,72,69,72,16},42), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({70,69,63,68,74},42), point = pos}
phase = _d({67,69,76,59},42)
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
if not ok then debug(_d({68,55,76,42,69,38,69,63,68,74,246,61,59,70,70,69,246,57,62,59,57,65,246,59,72,72,69,72,16},42), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({68,70,57},42)}
phase = _d({67,69,76,59},42)
end
function setNavNamed(name)
NavState = {mode = _d({68,55,67,59,58},42), name = name}
phase = _d({67,69,76,59},42)
end
local function setNavIdle()
NavState = {mode = _d({63,58,66,59},42)}
phase = _d({67,69,76,59},42)
end
local function hasArrived()
return phase == _d({62,69,76,59,72},42)
end
local function startNav()
phase = _d({67,69,76,59},42)
debug(_d({36,55,76,246,66,69,69,70,246,37,36},42))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({38,66,55,79,59,72,246,58,63,59,58,247,246,41,74,69,70,70,63,68,61,246,56,69,74,4},42))
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
debug(_d({38,66,55,79,59,72,246,63,73,246,74,69,69,246,60,55,72,246,60,72,69,67,246,74,55,72,61,59,74,246,254,20,8,6,6,6,246,73,74,75,58,73,255,4,246,34,63,65,59,66,79,246,72,59,73,70,55,77,68,59,58,246,55,74,246,66,69,56,56,79,4,246,41,74,69,70,70,63,68,61,246,56,69,74,4},42))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({53,53,70,72,59,76,38,69,73},42))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({34,55,72,61,59,246,70,69,73,63,74,63,69,68,246,64,75,67,70,246,58,59,74,59,57,74,59,58,16},42), delta, _d({73,74,75,58,73,4,246,70,72,59,76,38,69,73,19},42), prevPos, _d({68,59,77,38,69,73,19},42), pos)
end
end
force:SetAttribute(_d({53,53,70,72,59,76,38,69,73},42), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({67,69,76,59},42) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({62,69,76,59,72},42)
debug(_d({38,62,55,73,59,16,246,62,69,76,59,72},42))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({247,247,247,246,40,27,28,43,41,31,36,29,246,42,37,246,23,38,38,34,47,246,23,24,36,37,40,35,23,34,246,44,27,34,37,25,31,42,47,16},42), finalVel, _d({55,63,67,19},42), aim, _d({70,69,73,19},42), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({62,69,76,59,72},42) then
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
debug(_d({25,69,67,56,55,74,246,66,69,57,65,246,73,65,63,70,70,59,58,2},42), snapDist, _d({73,74,75,58,73,246,60,72,69,67,246,74,55,72,61,59,74,246,184,86,106,246,60,55,66,66,63,68,61,246,56,55,57,65,246,74,69,246,67,69,76,59},42))
phase = _d({67,69,76,59},42)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({30,59,55,72,74,56,59,55,74,246,59,72,72,69,72,16},42), err) end
end)
end
local function stopNav()
debug(_d({36,55,76,246,66,69,69,70,246,37,28,28},42))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({67,69,76,59},42)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({42,59,78,74,25,62,55,74,41,59,72,76,63,57,59},42))
local channels = TextChatService:FindFirstChild(_d({42,59,78,74,25,62,55,68,68,59,66,73},42))
local channel = channels and channels:FindFirstChild(_d({40,24,46,29,59,68,59,72,55,66},42))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({26,59,60,55,75,66,74,25,62,55,74,41,79,73,74,59,67,25,62,55,74,27,76,59,68,74,73},42))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({41,55,79,35,59,73,73,55,61,59,40,59,71,75,59,73,74},42))
if sayEvent then
sayEvent:FireServer(message, _d({23,66,66},42))
return
end
debug(_d({73,59,68,58,25,62,55,74,35,59,73,73,55,61,59,16,246,68,69,246,42,59,78,74,25,62,55,74,41,59,72,76,63,57,59,4,40,24,46,29,59,68,59,72,55,66,246,69,72,246,66,59,61,55,57,79,246,41,55,79,35,59,73,73,55,61,59,40,59,71,75,59,73,74,246,60,69,75,68,58,246,60,69,72},42), message)
end)
if not ok then debug(_d({73,59,68,58,25,62,55,74,35,59,73,73,55,61,59,246,59,72,72,69,72,16},42), err) end
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
debug(_d({36,69,74,246,67,55,65,63,68,61,246,70,72,69,61,72,59,73,73,246,74,69,77,55,72,58,246,68,55,76,246,74,55,72,61,59,74,246,60,69,72},42), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({73,246,3,246,73,59,68,58,63,68,61,246,5,75,68,73,74,75,57,65},42))
sendChatMessage(_d({5,75,68,73,74,75,57,65},42))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({77,55,63,74,43,68,74,63,66,23,72,72,63,76,59,58,246,74,63,67,59,69,75,74},42))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({68,55,76,42,69,38,69,63,68,74,25,69,68,60,63,72,67,59,58,16},42), label or _d({74,55,72,61,59,74},42), _d({3,246,58,63,58,246,68,69,74,246,55,72,72,63,76,59,246,77,63,74,62,63,68},42), timeout, _d({73,2,246,72,59,74,72,79,63,68,61,246,69,68,57,59},42))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({68,55,76,42,69,38,69,63,68,74,25,69,68,60,63,72,67,59,58,16},42), label or _d({74,55,72,61,59,74},42), _d({3,246,73,74,63,66,66,246,68,69,74,246,55,72,72,63,76,59,58,246,55,60,74,59,72,246,72,59,74,72,79,2,246,70,72,69,57,59,59,58,63,68,61,246,55,68,79,77,55,79},42))
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
if not ok then debug(_d({68,55,76,42,69,38,69,63,68,74,30,69,66,58,63,68,61,24,66,69,57,65,246,65,59,79,3,58,69,77,68,246,59,72,72,69,72,16},42), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({68,55,76,42,69,38,69,63,68,74,30,69,66,58,63,68,61,24,66,69,57,65,246,65,59,79,3,75,70,246,59,72,72,69,72,16},42), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({45,55,66,65,63,68,61,246,74,69,16},42), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({77,55,66,65,42,69,38,69,63,68,74,246,45,246,58,69,77,68,246,59,72,72,69,72,16},42), err) end
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
debug(_d({42,69,69,65,246,58,55,67,55,61,59,246,77,62,63,66,59,246,77,55,66,65,63,68,61,246,74,69,246,70,69,63,68,74,247,246,41,74,69,70,70,63,68,61,246,77,55,66,65,246,74,69,246,59,68,61,55,61,59,4},42))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({23,72,72,63,76,59,58,246,55,74,16},42), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({41,74,75,57,65,246,58,75,72,63,68,61,246,77,55,66,65,2,246,64,75,67,70,63,68,61,247},42))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({41,74,63,66,66,246,73,74,75,57,65,2,246,74,72,63,61,61,59,72,63,68,61,246,29,59,70,70,69,247},42))
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
debug(_d({35,69,76,63,68,61,246,74,69},42), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({45,55,63,74,63,68,61,246,60,69,72,246,36,38,25,73,246,74,69,246,73,70,55,77,68,246,55,74},42), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({246,246,73,70,55,77,68,246,57,62,59,57,65,16,246,60,69,66,58,59,72,246,59,78,63,73,74,73,246,19},42), folder ~= nil,
_d({2,246,57,62,63,66,58,72,59,68,246,19},42), folder and #folder:GetChildren() or 0,
_d({2,246,55,66,63,76,59,246,19},42), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({36,69,246,36,38,25,73,246,55,70,70,59,55,72,59,58,246,55,74},42), stageName, _d({55,60,74,59,72,246,7,11,73,2,246,67,69,76,63,68,61,246,69,68,246,55,68,79,77,55,79},42))
break
end
end
debug(_d({33,63,66,66,63,68,61,246,36,38,25,73,246,55,74},42), stageName)
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
debug(_d({40,59,74,75,72,68,63,68,61,246,74,69},42), stageName, _d({70,69,73,63,74,63,69,68,246,56,59,60,69,72,59,246,67,69,76,63,68,61,246,69,68},42))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({45,55,63,74,63,68,61,246,11,73,246,55,74},42), stageName, _d({70,69,73,63,74,63,69,68},42))
task.wait(5)
debug(_d({45,55,63,74,63,68,61,246,60,69,72},42), targetHP * 100, _d({251,246,30,38,246,56,59,60,69,72,59,246,67,69,76,63,68,61,246,74,69,246,68,59,78,74,246,73,74,55,61,59},42))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({57,66,59,55,72,59,58},42))
end
local function killNamedNPC(name, targetPos)
debug(_d({35,69,76,63,68,61,246,74,69},42), name)
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
debug(name, _d({58,59,60,59,55,74,59,58},42))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({30,75,67,55,68,69,63,58},42))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({34,59,69,246,70,66,55,79,59,58,246,55,68,63,67,55,74,63,69,68,16},42), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({66,59,69,23,68,63,67,34,69,61,61,59,72,246,70,72,63,68,74,246,59,72,72,69,72,16},42), err2) end
end)
end)
if not ok then debug(_d({73,74,55,72,74,34,59,69,23,68,63,67,34,69,61,61,59,72,246,59,72,72,69,72,16},42), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({35,69,76,63,68,61,246,74,69,246,34,59,69},42))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({34,59,69},42))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({34,59,69},42))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({34,59,69},42))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({34,59,69,246,57,55,73,74,63,68,61},42), which, _d({3,246,58,69,58,61,63,68,61},42))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({34,59,69,246,73,74,55,72,74,59,58,246,56,66,69,57,65,3,56,72,59,55,65,59,72,246,67,63,58,3,56,66,69,57,65,247,246,27,76,55,58,63,68,61,4,4,4},42))
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
if not getNPCByName(_d({34,59,69},42)) then
debug(_d({34,59,69,246,61,69,68,59,246,67,63,58,3,58,69,58,61,59,246,3,246,59,68,58,63,68,61,246,27,68,74,59,63,246,62,69,66,58,246,59,55,72,66,79},42))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({34,59,69},42)) then
setNavNamed(_d({34,59,69},42))
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
debug(_d({34,59,69,246,58,59,60,59,55,74,59,58},42))
stopLeoAnimLogger()
debug(_d({40,59,74,75,72,68,63,68,61,246,74,69,246,34,59,69,246,70,69,73,63,74,63,69,68,246,56,59,60,69,72,59,246,67,69,76,63,68,61,246,69,68},42))
navToPointConfirmed(COORDS.Leo, 30, _d({34,59,69,246,70,69,73,63,74,63,69,68},42))
debug(_d({45,55,63,74,63,68,61,246,11,73,246,55,74,246,34,59,69,246,70,69,73,63,74,63,69,68},42))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({35,69,76,63,68,61,246,74,69},42), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({25,69,75,66,58,246,68,69,74,246,60,63,68,58,246,73,74,55,74,75,59,246,67,69,58,59,66,246,68,59,55,72},42), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({23,74,74,55,57,65,63,68,61},42), coordKey, _d({77,63,74,62},42), weapon or _d({68,69,74,62,63,68,61,246,60,69,75,68,58},42))
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
debug(coordKey, _d({56,55,72,72,59,66,246,58,59,73,74,72,69,79,59,58},42))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({72,59,57,62,59,57,65,41,74,55,74,75,59,16},42), coordKey, _d({3,246,57,69,75,66,58,246,68,69,74,246,60,63,68,58,246,73,74,55,74,75,59,246,67,69,58,59,66,2,246,73,65,63,70,70,63,68,61},42))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({72,59,57,62,59,57,65,41,74,55,74,75,59,16},42), coordKey, _d({73,74,63,66,66,246,55,66,63,76,59,246,254,30,38},42), hp, _d({255,246,3,246,72,59,3,58,59,73,74,72,69,79,63,68,61},42))
destroyStatue(coordKey)
else
debug(_d({72,59,57,62,59,57,65,41,74,55,74,75,59,16},42), coordKey, _d({57,69,68,60,63,72,67,59,58,246,58,59,73,74,72,69,79,59,58},42))
end
end)
if not ok then debug(_d({72,59,57,62,59,57,65,41,74,55,74,75,59,246,59,72,72,69,72,16},42), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({35,69,76,63,68,61,246,74,69,246,39,75,59,59,68},42))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({25,75,70,63,58,246,39,75,59,59,68},42))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42))
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
debug(_d({39,75,59,59,68,246,59,68,74,59,72,59,58,246,70,62,55,73,59,246,8},42))
end
local function finishQueen()
debug(_d({28,63,68,63,73,62,63,68,61,246,39,75,59,59,68},42))
equipSwordOrMelee()
setNavNamed(_d({25,75,70,63,58,246,39,75,59,59,68},42))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({25,75,70,63,58,246,39,75,59,59,68},42))
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
debug(_d({39,75,59,59,68,246,58,59,60,59,55,74,59,58,4,246,38,66,55,68,246,57,69,67,70,66,59,74,59,4},42))
end
local CONFIRMATION_PROMPT_NAME = _d({25,69,68,60,63,72,67,55,74,63,69,68,38,72,69,67,70,74},42)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({40,59,67,69,74,59,27,76,59,68,74},42), 5)
end)
if ok then return result end
debug(_d({61,59,74,40,59,70,66,55,79,40,59,67,69,74,59,246,59,72,72,69,72,16},42), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({38,66,55,79,59,72,29,75,63},42))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({31,67,55,61,59,24,75,74,74,69,68},42)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({56,75,74,74,69,68,44,55,66,75,59},42)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({60,63,68,58,24,75,74,74,69,68,24,79,44,55,66,75,59,246,59,72,72,69,72,16},42), result)
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
if not ok then debug(_d({57,66,63,57,65,29,75,63,24,75,74,74,69,68,246,59,72,72,69,72,16},42), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({63,73,41,59,72,76,59,72},42))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({40,59,67,69,74,59,27,76,59,68,74},42))
or inst:FindFirstChild(_d({57,66,63,59,68,74,27,76,59,68,74},42))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({60,63,68,58,23,68,73,77,59,72,25,69,68,68,59,57,74,69,72,246,59,72,72,69,72,16},42), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({25,69,75,66,58,246,68,69,74,246,66,69,57,55,74,59,246,40,59,67,69,74,59,27,76,59,68,74,5,57,66,63,59,68,74,27,76,59,68,74,246,68,59,55,72,246,40,59,70,66,55,79,246,56,75,74,74,69,68,2,246,60,55,66,66,63,68,61,246,56,55,57,65,246,74,69,246,57,66,63,57,65},42))
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
debug(_d({60,63,72,59,40,59,70,66,55,79,44,55,66,75,59,246,59,72,72,69,72,16},42), err, _d({3,246,60,55,66,66,63,68,61,246,56,55,57,65,246,74,69,246,57,66,63,57,65},42))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({28,55,66,66,63,68,61,246,56,55,57,65,246,74,69,246,56,75,74,74,69,68,44,55,66,75,59,246,73,59,55,72,57,62,246,60,69,72,246,40,59,70,66,55,79},42))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({40,59,70,66,55,79,246,56,75,74,74,69,68,246,68,69,74,246,60,69,75,68,58,246,59,63,74,62,59,72,2,246,61,63,76,63,68,61,246,75,70},42))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({45,55,63,74,63,68,61,246,60,69,72,246,25,69,68,60,63,72,67,55,74,63,69,68,38,72,69,67,70,74,4,40,59,67,69,74,59,27,76,59,68,74},42))
local remote = getReplayRemote()
if not remote then
debug(_d({25,69,68,60,63,72,67,55,74,63,69,68,38,72,69,67,70,74,5,40,59,67,69,74,59,27,76,59,68,74,246,68,69,74,246,60,69,75,68,58,246,77,63,74,62,63,68,246,74,63,67,59,69,75,74},42))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({28,63,72,63,68,61,246,40,59,70,66,55,79,246,76,63,55,246,25,69,68,60,63,72,67,55,74,63,69,68,38,72,69,67,70,74,4,40,59,67,69,74,59,27,76,59,68,74},42))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({28,63,72,59,41,59,72,76,59,72,246,59,72,72,69,72,16},42), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({38,66,55,79,59,72,29,75,63},42), 10)
if not playerGui then
debug(_d({77,55,63,74,28,69,72,37,56,64,59,57,74,63,76,59,73,29,75,63,16,246,68,69,246,38,66,55,79,59,72,29,75,63,246,77,63,74,62,63,68,246,74,63,67,59,69,75,74,2,246,70,72,69,57,59,59,58,63,68,61,246,55,68,79,77,55,79},42))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({37,56,64,59,57,74,63,76,59,73,246,29,43,31,246,60,69,75,68,58,246,3,246,73,74,55,61,59,246,66,69,55,58,59,58},42))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({37,56,64,59,57,74,63,76,59,73,246,29,43,31,246,68,69,74,246,60,69,75,68,58,246,77,63,74,62,63,68,246,74,63,67,59,69,75,74,2,246,70,72,69,57,59,59,58,63,68,61,246,55,68,79,77,55,79},42))
return
end
end
end)
if not ok then debug(_d({77,55,63,74,28,69,72,37,56,64,59,57,74,63,76,59,73,29,75,63,246,59,72,72,69,72,16},42), err) end
end
local function runPlan()
debug(_d({38,66,55,68,246,73,74,55,72,74,59,58},42))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({41,74,55,72,74,63,68,61,246,68,55,76,246,66,69,69,70},42))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({70,69,73,246,6,4,8,73,246,23,28,42,27,40,246,73,74,55,72,74,36,55,76,16},42), rootAfter and rootAfter.Position)
end)
debug(_d({45,55,63,74,63,68,61,246,11,73,246,56,59,60,69,72,59,246,67,69,76,63,68,61,246,74,69,246,41,74,55,61,59,7},42))
task.wait(5)
for _, stage in ipairs({_d({41,74,55,61,59,7},42), _d({41,74,55,61,59,8},42), _d({41,74,55,61,59,9},42), _d({41,74,55,61,59,9,24},42)}) do
if not enabled then return end
local hpTarget = (stage == _d({41,74,55,61,59,9,24},42)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({35,69,76,63,68,61,246,74,69,246,55,72,72,69,77,246,60,66,79,3,58,69,77,68,246,55,72,59,55,246,254,25,75,70,63,58,246,40,55,63,68,255},42))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({26,69,58,61,63,68,61,246,55,72,72,69,77,246,72,55,63,68,246,63,68,246,55,246,73,71,75,55,72,59},42))
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
clearStage(_d({41,74,55,61,59,10},42))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({39,75,59,59,68,246,63,68,246,70,62,55,73,59,246,8,246,3,246,65,59,59,70,63,68,61,246,33,59,68,246,30,55,65,63,246,55,57,74,63,76,59,246,60,72,69,67,246,62,59,72,59,246,69,68},42))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({41,74,55,74,75,59,7},42))
if not enabled then return end
recheckStatue(_d({41,74,55,74,75,59,7},42))
destroyStatue(_d({41,74,55,74,75,59,8},42))
if not enabled then return end
recheckStatue(_d({41,74,55,74,75,59,7},42))
recheckStatue(_d({41,74,55,74,75,59,8},42))
destroyStatue(_d({41,74,55,74,75,59,9},42))
if not enabled then return end
recheckStatue(_d({41,74,55,74,75,59,9},42))
recheckStatue(_d({41,74,55,74,75,59,8},42))
recheckStatue(_d({41,74,55,74,75,59,7},42))
if not enabled then return end
debug(_d({45,55,63,74,63,68,61,246,60,69,72,246,70,62,55,73,59,246,8,246,74,69,246,59,68,58},42))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({38,62,55,73,59,246,8,246,59,68,58,246,77,55,63,74,246,74,63,67,59,69,75,74,2,246,70,72,69,57,59,59,58,63,68,61,246,55,68,79,77,55,79},42))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({35,69,76,63,68,61,246,56,55,57,65,246,74,69,246,39,75,59,59,68,246,73,74,55,61,59,246,70,69,73,63,74,63,69,68},42))
navToPointConfirmed(COORDS.Queen, 30, _d({39,75,59,59,68,246,73,74,55,61,59,246,70,69,73,63,74,63,69,68},42))
debug(_d({45,55,63,74,63,68,61,246,11,73,246,55,74,246,39,75,59,59,68,246,73,74,55,61,59,246,70,69,73,63,74,63,69,68},42))
task.wait(5)
if not enabled then return end
debug(_d({35,69,76,63,68,61,246,74,69,246,70,69,73,74,3,39,75,59,59,68,246,70,69,73,63,74,63,69,68},42))
navToPointConfirmed(COORDS.PostQueen, 30, _d({70,69,73,74,3,39,75,59,59,68,246,70,69,73,63,74,63,69,68},42))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({27,68,55,56,66,63,68,61,2,246,70,69,73,246,24,27,28,37,40,27,246,70,66,55,68,16},42), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({38,66,55,68,246,59,72,72,69,72,16},42), err2) end
end)
debug(_d({27,68,55,56,66,59,58,16},42), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({27,68,55,56,66,59,58,16},42), enabled)
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
if not ok then debug(_d({31,68,70,75,74,24,59,61,55,68,246,59,72,72,69,72,16},42), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({29,55,67,59,246,66,69,55,58,59,58,2,246,55,75,74,69,3,73,74,55,72,74,63,68,61,246,74,62,59,246,70,66,55,68},42))
enableBot()
end)
if not ok then debug(_d({23,75,74,69,73,74,55,72,74,246,59,72,72,69,72,16},42), err) end
end)
debug(_d({34,69,55,58,59,58,246,184,86,106,246,55,75,74,69,3,73,74,55,72,74,63,68,61,246,69,68,57,59,246,74,62,59,246,61,55,67,59,246,60,63,68,63,73,62,59,73,246,66,69,55,58,63,68,61,246,254,70,72,59,73,73,246,38,246,74,69,246,74,69,61,61,66,59,246,67,55,68,75,55,66,66,79,255},42))
end)()