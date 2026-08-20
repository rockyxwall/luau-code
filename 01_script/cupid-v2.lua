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
local Players            = game:GetService(_d({42,70,59,83,63,76,77},38))
local UserInputService    = game:GetService(_d({47,77,63,76,35,72,74,79,78,45,63,76,80,67,61,63},38))
local RunService          = game:GetService(_d({44,79,72,45,63,76,80,67,61,63},38))
local VIM                 = game:GetService(_d({48,67,76,78,79,59,70,35,72,74,79,78,39,59,72,59,65,63,76},38))
local ReplicatedStorage    = game:GetService(_d({44,63,74,70,67,61,59,78,63,62,45,78,73,76,59,65,63},38))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({53,28,73,77,77,28,73,78,55},38), _d({49,76,73,72,65,250,65,59,71,63,250,188,90,110,250,42,70,59,61,63,35,62,20},38), game.PlaceId, _d({47,72,67,80,63,76,77,63,35,62,20},38), game.GameId, _d({7,250,72,73,78,250,76,79,72,72,67,72,65},38))
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
local LEO_PILLAR_ANIM_ID   = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,15,12,14,14,11,14,11,13,12,17},38)
local LEO_ENTEI_ANIM_ID    = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,15,12,14,14,11,13,18,12,17,18},38)
local LEO_HIKEN_ANIM_ID    = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,15,12,12,10,19,11,17,14,10,17},38)
local LEO_FIREFLY_ANIM_ID  = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,15,12,12,10,12,13,16,11,15,14},38)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({41,60,68,63,61,78,67,80,63,77},38)
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
local REPLAY_BUTTON_VALUE   = _d({44,63,74,70,59,83},38)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({71,73,80,63},38)
local NavState   = {mode = _d({67,62,70,63},38)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({53,28,73,77,77,28,73,78,55},38), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
end)
if ok then return root end
debug(_d({65,63,78,44,73,73,78,250,63,76,76,73,76,20},38), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
end)
if ok then return hum end
debug(_d({65,63,78,34,79,71,59,72,73,67,62,250,63,76,76,73,76,20},38), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({57,57,34,73,80,63,76,27,78,78},38)) or Instance.new(_d({27,78,78,59,61,66,71,63,72,78},38))
att.Name = _d({57,57,34,73,80,63,76,27,78,78},38)
att.Parent = root
local force = root:FindFirstChild(_d({57,57,34,73,80,63,76,32,73,76,61,63},38))
if not force then
force = Instance.new(_d({38,67,72,63,59,76,48,63,70,73,61,67,78,83},38))
force.Name = _d({57,57,34,73,80,63,76,32,73,76,61,63},38)
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
debug(_d({65,63,78,41,76,29,76,63,59,78,63,32,73,76,61,63,250,63,76,76,73,76,20},38), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not root then return end
local force = root:FindFirstChild(_d({57,57,34,73,80,63,76,32,73,76,61,63},38))
local att   = root:FindFirstChild(_d({57,57,34,73,80,63,76,27,78,78},38))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({61,70,63,59,72,79,74,32,73,76,61,63,250,63,76,76,73,76,20},38), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({28,79,77,73,39,63,70,63,63},38)) ~= nil
end)
if ok then return result end
debug(_d({67,77,28,79,77,73,27,61,78,67,80,63,250,63,76,76,73,76,20},38), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({28,79,77,73},38))
end)
if not ok then debug(_d({59,61,78,67,80,59,78,63,28,79,77,73,250,63,76,76,73,76,20},38), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({28,79,77,73,250,72,73,78,250,59,61,78,67,80,63,6,250,59,61,78,67,80,59,78,67,72,65},38))
activateBuso()
end
end)
if not ok then debug(_d({28,79,77,73,37,63,63,74,63,76,250,63,76,76,73,76,20},38), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({28,79,77,73,250,69,63,63,74,63,76,250,77,78,73,74,74,63,62},38))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({37,63,72,34,59,69,67},38)) ~= nil
end)
if ok then return result end
debug(_d({67,77,37,63,72,27,61,78,67,80,63,250,63,76,76,73,76,20},38), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({37,63,72},38), true)
end)
if not ok then debug(_d({59,61,78,67,80,59,78,63,37,63,72,250,63,76,76,73,76,20},38), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({37,63,72,250,72,73,78,250,59,61,78,67,80,63,6,250,59,61,78,67,80,59,78,67,72,65},38))
activateKen()
end
end)
if not ok then debug(_d({37,63,72,37,63,63,74,63,76,250,63,76,76,73,76,20},38), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({37,63,72,250,69,63,63,74,63,76,250,77,78,73,74,74,63,62},38))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({40,42,29,77},38)) end)
if ok then return folder end
debug(_d({65,63,78,40,42,29,77,32,73,70,62,63,76,250,63,76,76,73,76,20},38), folder)
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
local r = model:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local h = model:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
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
debug(_d({65,63,78,40,63,59,76,63,77,78,40,42,29,250,63,76,76,73,76,20},38), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
local hum  = model:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({65,63,78,40,42,29,28,83,40,59,71,63,250,63,76,76,73,76,20},38), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({72,74,61,77,44,63,71,59,67,72,67,72,65,250,63,76,76,73,76,20},38), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({29,79,74,67,62,250,43,79,63,63,72},38))
return queen ~= nil and queen:FindFirstChild(_d({71,73,78,67,73,72,38,63,77,77},38)) ~= nil
end)
if ok then return result end
debug(_d({67,77,43,79,63,63,72,42,66,59,77,63,12,250,63,76,76,73,76,20},38), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,11,12,11,12,19,17,19,14,12,12,19,12,17,16,19},38)
local QUEEN_GRASP_ANIM_ID   = _d({76,60,82,59,77,77,63,78,67,62,20,9,9,11,12,19,18,10,10,10,16,11,10,10,11,17,13,14},38)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
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
debug(_d({67,77,42,70,59,83,67,72,65,27,72,67,71,32,76,73,71,38,67,77,78,250,63,76,76,73,76,20},38), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({28,70,73,61,69,67,72,65},38)) ~= nil
end)
if ok then return result end
debug(_d({67,77,40,42,29,28,70,73,61,69,67,72,65,250,63,76,76,73,76,20},38), result)
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
debug(_d({74,76,63,62,67,61,78,40,42,29,42,73,77,67,78,67,73,72,250,63,76,76,73,76,20},38), result)
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
debug(_d({40,73,250,62,59,71,59,65,63,250,73,72},38), model.Name, _d({64,73,76},38), NPC_STUCK_TIMEOUT, _d({77,250,7,250,77,81,67,78,61,66,67,72,65,250,78,59,76,65,63,78},38))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({78,76,59,61,69,40,42,29,30,59,71,59,65,63,250,63,76,76,73,76,20},38), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({39,73,62,63,70},38)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({28,59,77,63,42,59,76,78},38)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({65,63,78,39,73,62,63,70,32,59,61,63,42,73,77,250,63,76,76,73,76,20},38), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({31,72,80},38))
local folder = env and env:FindFirstChild(_d({45,78,59,78,79,63,77},38))
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
debug(_d({65,63,78,45,78,59,78,79,63,39,73,62,63,70,40,63,59,76,250,63,76,76,73,76,20},38), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({60,59,76,76,63,70,34,42},38))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({65,63,78,45,78,59,78,79,63,34,42,250,63,76,76,73,76,20},38), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({64,67,72,62,46,73,73,70,28,83,27,78,78,76,67,60,79,78,63,250,63,76,76,73,76,20},38), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({46,73,73,70},38)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({64,67,72,62,46,73,73,70,28,83,40,59,71,63,250,63,76,76,73,76,20},38), tool)
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
if not ok then debug(_d({63,75,79,67,74,46,73,73,70,250,63,76,76,73,76,20},38), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({28,59,61,69,74,59,61,69},38))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({46,73,73,70},38)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({64,67,72,62,46,73,73,70,28,83,29,66,67,70,62,40,59,71,63,250,63,76,76,73,76,20},38), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({45,81,73,76,62,31,75,79,67,74},38))
if sword then
equipTool(sword)
return _d({77,81,73,76,62},38)
end
local melee = findToolByAttribute(_d({39,63,70,63,63,46,73,73,70},38))
if melee then
equipTool(melee)
return _d({71,63,70,63,63},38)
end
debug(_d({40,73,250,77,81,73,76,62,250,73,76,250,71,63,70,63,63,250,78,73,73,70,250,64,73,79,72,62},38))
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
if not ok then debug(_d({61,70,67,61,69,39,11,250,63,76,76,73,76,20},38), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({34,79,71,59,72,73,67,62,44,73,73,78,42,59,76,78},38))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({45,78,59,78,77},38) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({44,73,69,79,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,63,74,74,73},38), args)
elseif style == _d({28,70,59,61,69,38,63,65},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69},38), args)
elseif style == _d({37,59,71,67,77,66,67,69,67},38) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,59,71,67,77,66,67,69,67,33,63,74,74,73},38), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,69,83,250,49,59,70,69,12},38), args)
end
end)
if not ok then debug(_d({67,72,80,73,69,63,33,63,74,74,73,250,63,76,76,73,76,20},38), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({74,76,63,77,77,45,69,67,70,70,44,250,63,76,76,73,76,20},38), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({66,73,70,62,28,70,73,61,69,250,63,76,76,73,76,20},38), err) end
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
if not ok then debug(_d({66,73,70,62,28,70,73,61,69,49,66,67,70,63,250,63,76,76,73,76,20},38), err) end
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
debug(_d({65,63,78,33,59,71,63,33,250,63,76,76,73,76,20},38), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({67,77,44,63,59,70,39,11,28,79,77,83,250,63,76,76,73,76,20},38), result)
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
return char ~= nil and char:FindFirstChild(_d({77,78,79,72},38)) ~= nil
end)
if ok then return result end
debug(_d({67,77,45,78,79,72,72,63,62,250,63,76,76,73,76,20},38), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({74,76,63,77,77,45,78,79,72,28,76,63,59,69,250,63,76,76,73,76,20},38), err) end
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
debug(_d({75,79,63,63,72,30,73,62,65,63,47,72,78,67,70,45,59,64,63,20,250,43,79,63,63,72,250,65,73,72,63,250,7,250,63,72,62,67,72,65,250,62,73,62,65,63,250,63,59,76,70,83},38))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({75,79,63,63,72,30,73,62,65,63,47,72,78,67,70,45,59,64,63,250,77,59,64,63,78,83,250,78,67,71,63,73,79,78},38))
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
local info = getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({43,79,63,63,72,250,61,59,77,78,67,72,65,250,62,63,78,63,61,78,63,62,250,7,250,62,73,62,65,67,72,65,250,2,81,59,78,61,66,63,76,3},38))
queenDodgeUntilSafe(function() return getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38)) end)
if enabled and getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38)) then
setNavNamed(_d({29,79,74,67,62,250,43,79,63,63,72},38))
end
queenDodging = false
end
end)
if not ok then debug(_d({75,79,63,63,72,30,73,62,65,63,49,59,78,61,66,63,76,250,63,76,76,73,76,20},38), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({74,73,67,72,78},38) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({72,74,61},38) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({72,59,71,63,62},38) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({65,63,78,40,59,80,46,59,76,65,63,78,77,250,63,76,76,73,76,20},38), aimR)
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
debug(_d({61,73,71,74,79,78,63,38,73,61,69,63,62,29,32,76,59,71,63,250,63,76,76,73,76,20},38), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({74,73,67,72,78},38), point = pos}
phase = _d({71,73,80,63},38)
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
if not ok then debug(_d({72,59,80,46,73,42,73,67,72,78,250,65,63,74,74,73,250,61,66,63,61,69,250,63,76,76,73,76,20},38), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({72,74,61},38)}
phase = _d({71,73,80,63},38)
end
function setNavNamed(name)
NavState = {mode = _d({72,59,71,63,62},38), name = name}
phase = _d({71,73,80,63},38)
end
local function setNavIdle()
NavState = {mode = _d({67,62,70,63},38)}
phase = _d({71,73,80,63},38)
end
local function hasArrived()
return phase == _d({66,73,80,63,76},38)
end
local function startNav()
phase = _d({71,73,80,63},38)
debug(_d({40,59,80,250,70,73,73,74,250,41,40},38))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({42,70,59,83,63,76,250,62,67,63,62,251,250,45,78,73,74,74,67,72,65,250,60,73,78,8},38))
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
debug(_d({42,70,59,83,63,76,250,67,77,250,78,73,73,250,64,59,76,250,64,76,73,71,250,78,59,76,65,63,78,250,2,24,12,10,10,10,250,77,78,79,62,77,3,8,250,38,67,69,63,70,83,250,76,63,77,74,59,81,72,63,62,250,59,78,250,70,73,60,60,83,8,250,45,78,73,74,74,67,72,65,250,60,73,78,8},38))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({57,57,74,76,63,80,42,73,77},38))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({38,59,76,65,63,250,74,73,77,67,78,67,73,72,250,68,79,71,74,250,62,63,78,63,61,78,63,62,20},38), delta, _d({77,78,79,62,77,8,250,74,76,63,80,42,73,77,23},38), prevPos, _d({72,63,81,42,73,77,23},38), pos)
end
end
force:SetAttribute(_d({57,57,74,76,63,80,42,73,77},38), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({71,73,80,63},38) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({66,73,80,63,76},38)
debug(_d({42,66,59,77,63,20,250,66,73,80,63,76},38))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({251,251,251,250,44,31,32,47,45,35,40,33,250,46,41,250,27,42,42,38,51,250,27,28,40,41,44,39,27,38,250,48,31,38,41,29,35,46,51,20},38), finalVel, _d({59,67,71,23},38), aim, _d({74,73,77,23},38), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({66,73,80,63,76},38) then
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
debug(_d({29,73,71,60,59,78,250,70,73,61,69,250,77,69,67,74,74,63,62,6},38), snapDist, _d({77,78,79,62,77,250,64,76,73,71,250,78,59,76,65,63,78,250,188,90,110,250,64,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,71,73,80,63},38))
phase = _d({71,73,80,63},38)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({34,63,59,76,78,60,63,59,78,250,63,76,76,73,76,20},38), err) end
end)
end
local function stopNav()
debug(_d({40,59,80,250,70,73,73,74,250,41,32,32},38))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({71,73,80,63},38)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({46,63,82,78,29,66,59,78,45,63,76,80,67,61,63},38))
local channels = TextChatService:FindFirstChild(_d({46,63,82,78,29,66,59,72,72,63,70,77},38))
local channel = channels and channels:FindFirstChild(_d({44,28,50,33,63,72,63,76,59,70},38))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({30,63,64,59,79,70,78,29,66,59,78,45,83,77,78,63,71,29,66,59,78,31,80,63,72,78,77},38))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({45,59,83,39,63,77,77,59,65,63,44,63,75,79,63,77,78},38))
if sayEvent then
sayEvent:FireServer(message, _d({27,70,70},38))
return
end
debug(_d({77,63,72,62,29,66,59,78,39,63,77,77,59,65,63,20,250,72,73,250,46,63,82,78,29,66,59,78,45,63,76,80,67,61,63,8,44,28,50,33,63,72,63,76,59,70,250,73,76,250,70,63,65,59,61,83,250,45,59,83,39,63,77,77,59,65,63,44,63,75,79,63,77,78,250,64,73,79,72,62,250,64,73,76},38), message)
end)
if not ok then debug(_d({77,63,72,62,29,66,59,78,39,63,77,77,59,65,63,250,63,76,76,73,76,20},38), err) end
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
debug(_d({40,73,78,250,71,59,69,67,72,65,250,74,76,73,65,76,63,77,77,250,78,73,81,59,76,62,250,72,59,80,250,78,59,76,65,63,78,250,64,73,76},38), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({77,250,7,250,77,63,72,62,67,72,65,250,9,79,72,77,78,79,61,69},38))
sendChatMessage(_d({9,79,72,77,78,79,61,69},38))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({81,59,67,78,47,72,78,67,70,27,76,76,67,80,63,62,250,78,67,71,63,73,79,78},38))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({72,59,80,46,73,42,73,67,72,78,29,73,72,64,67,76,71,63,62,20},38), label or _d({78,59,76,65,63,78},38), _d({7,250,62,67,62,250,72,73,78,250,59,76,76,67,80,63,250,81,67,78,66,67,72},38), timeout, _d({77,6,250,76,63,78,76,83,67,72,65,250,73,72,61,63},38))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({72,59,80,46,73,42,73,67,72,78,29,73,72,64,67,76,71,63,62,20},38), label or _d({78,59,76,65,63,78},38), _d({7,250,77,78,67,70,70,250,72,73,78,250,59,76,76,67,80,63,62,250,59,64,78,63,76,250,76,63,78,76,83,6,250,74,76,73,61,63,63,62,67,72,65,250,59,72,83,81,59,83},38))
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
if not ok then debug(_d({72,59,80,46,73,42,73,67,72,78,34,73,70,62,67,72,65,28,70,73,61,69,250,69,63,83,7,62,73,81,72,250,63,76,76,73,76,20},38), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({72,59,80,46,73,42,73,67,72,78,34,73,70,62,67,72,65,28,70,73,61,69,250,69,63,83,7,79,74,250,63,76,76,73,76,20},38), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({49,59,70,69,67,72,65,250,78,73,20},38), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({81,59,70,69,46,73,42,73,67,72,78,250,49,250,62,73,81,72,250,63,76,76,73,76,20},38), err) end
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
debug(_d({46,73,73,69,250,62,59,71,59,65,63,250,81,66,67,70,63,250,81,59,70,69,67,72,65,250,78,73,250,74,73,67,72,78,251,250,45,78,73,74,74,67,72,65,250,81,59,70,69,250,78,73,250,63,72,65,59,65,63,8},38))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({27,76,76,67,80,63,62,250,59,78,20},38), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({45,78,79,61,69,250,62,79,76,67,72,65,250,81,59,70,69,6,250,68,79,71,74,67,72,65,251},38))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({45,78,67,70,70,250,77,78,79,61,69,6,250,78,76,67,65,65,63,76,67,72,65,250,33,63,74,74,73,251},38))
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
debug(_d({39,73,80,67,72,65,250,78,73},38), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({49,59,67,78,67,72,65,250,64,73,76,250,40,42,29,77,250,78,73,250,77,74,59,81,72,250,59,78},38), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({250,250,77,74,59,81,72,250,61,66,63,61,69,20,250,64,73,70,62,63,76,250,63,82,67,77,78,77,250,23},38), folder ~= nil,
_d({6,250,61,66,67,70,62,76,63,72,250,23},38), folder and #folder:GetChildren() or 0,
_d({6,250,59,70,67,80,63,250,23},38), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({40,73,250,40,42,29,77,250,59,74,74,63,59,76,63,62,250,59,78},38), stageName, _d({59,64,78,63,76,250,11,15,77,6,250,71,73,80,67,72,65,250,73,72,250,59,72,83,81,59,83},38))
break
end
end
debug(_d({37,67,70,70,67,72,65,250,40,42,29,77,250,59,78},38), stageName)
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
debug(_d({44,63,78,79,76,72,67,72,65,250,78,73},38), stageName, _d({74,73,77,67,78,67,73,72,250,60,63,64,73,76,63,250,71,73,80,67,72,65,250,73,72},38))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({49,59,67,78,67,72,65,250,15,77,250,59,78},38), stageName, _d({74,73,77,67,78,67,73,72},38))
task.wait(5)
debug(_d({49,59,67,78,67,72,65,250,64,73,76},38), targetHP * 100, _d({255,250,34,42,250,60,63,64,73,76,63,250,71,73,80,67,72,65,250,78,73,250,72,63,82,78,250,77,78,59,65,63},38))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({61,70,63,59,76,63,62},38))
end
local function killNamedNPC(name, targetPos)
debug(_d({39,73,80,67,72,65,250,78,73},38), name)
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
debug(name, _d({62,63,64,63,59,78,63,62},38))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({34,79,71,59,72,73,67,62},38))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({38,63,73,250,74,70,59,83,63,62,250,59,72,67,71,59,78,67,73,72,20},38), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({70,63,73,27,72,67,71,38,73,65,65,63,76,250,74,76,67,72,78,250,63,76,76,73,76,20},38), err2) end
end)
end)
if not ok then debug(_d({77,78,59,76,78,38,63,73,27,72,67,71,38,73,65,65,63,76,250,63,76,76,73,76,20},38), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({39,73,80,67,72,65,250,78,73,250,38,63,73},38))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({38,63,73},38))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({38,63,73},38))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({38,63,73},38))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({38,63,73,250,61,59,77,78,67,72,65},38), which, _d({7,250,62,73,62,65,67,72,65},38))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({38,63,73,250,77,78,59,76,78,63,62,250,60,70,73,61,69,7,60,76,63,59,69,63,76,250,71,67,62,7,60,70,73,61,69,251,250,31,80,59,62,67,72,65,8,8,8},38))
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
if not getNPCByName(_d({38,63,73},38)) then
debug(_d({38,63,73,250,65,73,72,63,250,71,67,62,7,62,73,62,65,63,250,7,250,63,72,62,67,72,65,250,31,72,78,63,67,250,66,73,70,62,250,63,59,76,70,83},38))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({38,63,73},38)) then
setNavNamed(_d({38,63,73},38))
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
debug(_d({38,63,73,250,62,63,64,63,59,78,63,62},38))
stopLeoAnimLogger()
debug(_d({44,63,78,79,76,72,67,72,65,250,78,73,250,38,63,73,250,74,73,77,67,78,67,73,72,250,60,63,64,73,76,63,250,71,73,80,67,72,65,250,73,72},38))
navToPointConfirmed(COORDS.Leo, 30, _d({38,63,73,250,74,73,77,67,78,67,73,72},38))
debug(_d({49,59,67,78,67,72,65,250,15,77,250,59,78,250,38,63,73,250,74,73,77,67,78,67,73,72},38))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({39,73,80,67,72,65,250,78,73},38), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({29,73,79,70,62,250,72,73,78,250,64,67,72,62,250,77,78,59,78,79,63,250,71,73,62,63,70,250,72,63,59,76},38), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({27,78,78,59,61,69,67,72,65},38), coordKey, _d({81,67,78,66},38), weapon or _d({72,73,78,66,67,72,65,250,64,73,79,72,62},38))
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
debug(coordKey, _d({60,59,76,76,63,70,250,62,63,77,78,76,73,83,63,62},38))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({76,63,61,66,63,61,69,45,78,59,78,79,63,20},38), coordKey, _d({7,250,61,73,79,70,62,250,72,73,78,250,64,67,72,62,250,77,78,59,78,79,63,250,71,73,62,63,70,6,250,77,69,67,74,74,67,72,65},38))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({76,63,61,66,63,61,69,45,78,59,78,79,63,20},38), coordKey, _d({77,78,67,70,70,250,59,70,67,80,63,250,2,34,42},38), hp, _d({3,250,7,250,76,63,7,62,63,77,78,76,73,83,67,72,65},38))
destroyStatue(coordKey)
else
debug(_d({76,63,61,66,63,61,69,45,78,59,78,79,63,20},38), coordKey, _d({61,73,72,64,67,76,71,63,62,250,62,63,77,78,76,73,83,63,62},38))
end
end)
if not ok then debug(_d({76,63,61,66,63,61,69,45,78,59,78,79,63,250,63,76,76,73,76,20},38), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({39,73,80,67,72,65,250,78,73,250,43,79,63,63,72},38))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({29,79,74,67,62,250,43,79,63,63,72},38))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38))
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
debug(_d({43,79,63,63,72,250,63,72,78,63,76,63,62,250,74,66,59,77,63,250,12},38))
end
local function finishQueen()
debug(_d({32,67,72,67,77,66,67,72,65,250,43,79,63,63,72},38))
equipSwordOrMelee()
setNavNamed(_d({29,79,74,67,62,250,43,79,63,63,72},38))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({29,79,74,67,62,250,43,79,63,63,72},38))
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
debug(_d({43,79,63,63,72,250,62,63,64,63,59,78,63,62,8,250,42,70,59,72,250,61,73,71,74,70,63,78,63,8},38))
end
local CONFIRMATION_PROMPT_NAME = _d({29,73,72,64,67,76,71,59,78,67,73,72,42,76,73,71,74,78},38)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({42,70,59,83,63,76,33,79,67},38))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({44,63,71,73,78,63,31,80,63,72,78},38), 5)
end)
if ok then return result end
debug(_d({65,63,78,44,63,74,70,59,83,44,63,71,73,78,63,250,63,76,76,73,76,20},38), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({42,70,59,83,63,76,33,79,67},38))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({35,71,59,65,63,28,79,78,78,73,72},38)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({60,79,78,78,73,72,48,59,70,79,63},38)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({64,67,72,62,28,79,78,78,73,72,28,83,48,59,70,79,63,250,63,76,76,73,76,20},38), result)
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
if not ok then debug(_d({61,70,67,61,69,33,79,67,28,79,78,78,73,72,250,63,76,76,73,76,20},38), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({67,77,45,63,76,80,63,76},38))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({44,63,71,73,78,63,31,80,63,72,78},38))
or inst:FindFirstChild(_d({61,70,67,63,72,78,31,80,63,72,78},38))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({64,67,72,62,27,72,77,81,63,76,29,73,72,72,63,61,78,73,76,250,63,76,76,73,76,20},38), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({29,73,79,70,62,250,72,73,78,250,70,73,61,59,78,63,250,44,63,71,73,78,63,31,80,63,72,78,9,61,70,67,63,72,78,31,80,63,72,78,250,72,63,59,76,250,44,63,74,70,59,83,250,60,79,78,78,73,72,6,250,64,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,61,70,67,61,69},38))
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
debug(_d({64,67,76,63,44,63,74,70,59,83,48,59,70,79,63,250,63,76,76,73,76,20},38), err, _d({7,250,64,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,61,70,67,61,69},38))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({32,59,70,70,67,72,65,250,60,59,61,69,250,78,73,250,60,79,78,78,73,72,48,59,70,79,63,250,77,63,59,76,61,66,250,64,73,76,250,44,63,74,70,59,83},38))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({44,63,74,70,59,83,250,60,79,78,78,73,72,250,72,73,78,250,64,73,79,72,62,250,63,67,78,66,63,76,6,250,65,67,80,67,72,65,250,79,74},38))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({49,59,67,78,67,72,65,250,64,73,76,250,29,73,72,64,67,76,71,59,78,67,73,72,42,76,73,71,74,78,8,44,63,71,73,78,63,31,80,63,72,78},38))
local remote = getReplayRemote()
if not remote then
debug(_d({29,73,72,64,67,76,71,59,78,67,73,72,42,76,73,71,74,78,9,44,63,71,73,78,63,31,80,63,72,78,250,72,73,78,250,64,73,79,72,62,250,81,67,78,66,67,72,250,78,67,71,63,73,79,78},38))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({32,67,76,67,72,65,250,44,63,74,70,59,83,250,80,67,59,250,29,73,72,64,67,76,71,59,78,67,73,72,42,76,73,71,74,78,8,44,63,71,73,78,63,31,80,63,72,78},38))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({32,67,76,63,45,63,76,80,63,76,250,63,76,76,73,76,20},38), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({42,70,59,83,63,76,33,79,67},38), 10)
if not playerGui then
debug(_d({81,59,67,78,32,73,76,41,60,68,63,61,78,67,80,63,77,33,79,67,20,250,72,73,250,42,70,59,83,63,76,33,79,67,250,81,67,78,66,67,72,250,78,67,71,63,73,79,78,6,250,74,76,73,61,63,63,62,67,72,65,250,59,72,83,81,59,83},38))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({41,60,68,63,61,78,67,80,63,77,250,33,47,35,250,64,73,79,72,62,250,7,250,77,78,59,65,63,250,70,73,59,62,63,62},38))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({41,60,68,63,61,78,67,80,63,77,250,33,47,35,250,72,73,78,250,64,73,79,72,62,250,81,67,78,66,67,72,250,78,67,71,63,73,79,78,6,250,74,76,73,61,63,63,62,67,72,65,250,59,72,83,81,59,83},38))
return
end
end
end)
if not ok then debug(_d({81,59,67,78,32,73,76,41,60,68,63,61,78,67,80,63,77,33,79,67,250,63,76,76,73,76,20},38), err) end
end
local function runPlan()
debug(_d({42,70,59,72,250,77,78,59,76,78,63,62},38))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({45,78,59,76,78,67,72,65,250,72,59,80,250,70,73,73,74},38))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({74,73,77,250,10,8,12,77,250,27,32,46,31,44,250,77,78,59,76,78,40,59,80,20},38), rootAfter and rootAfter.Position)
end)
debug(_d({49,59,67,78,67,72,65,250,15,77,250,60,63,64,73,76,63,250,71,73,80,67,72,65,250,78,73,250,45,78,59,65,63,11},38))
task.wait(5)
for _, stage in ipairs({_d({45,78,59,65,63,11},38), _d({45,78,59,65,63,12},38), _d({45,78,59,65,63,13},38), _d({45,78,59,65,63,13,28},38)}) do
if not enabled then return end
local hpTarget = (stage == _d({45,78,59,65,63,13,28},38)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({39,73,80,67,72,65,250,78,73,250,59,76,76,73,81,250,64,70,83,7,62,73,81,72,250,59,76,63,59,250,2,29,79,74,67,62,250,44,59,67,72,3},38))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({30,73,62,65,67,72,65,250,59,76,76,73,81,250,76,59,67,72,250,67,72,250,59,250,77,75,79,59,76,63},38))
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
clearStage(_d({45,78,59,65,63,14},38))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({43,79,63,63,72,250,67,72,250,74,66,59,77,63,250,12,250,7,250,69,63,63,74,67,72,65,250,37,63,72,250,34,59,69,67,250,59,61,78,67,80,63,250,64,76,73,71,250,66,63,76,63,250,73,72},38))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({45,78,59,78,79,63,11},38))
if not enabled then return end
recheckStatue(_d({45,78,59,78,79,63,11},38))
destroyStatue(_d({45,78,59,78,79,63,12},38))
if not enabled then return end
recheckStatue(_d({45,78,59,78,79,63,11},38))
recheckStatue(_d({45,78,59,78,79,63,12},38))
destroyStatue(_d({45,78,59,78,79,63,13},38))
if not enabled then return end
recheckStatue(_d({45,78,59,78,79,63,13},38))
recheckStatue(_d({45,78,59,78,79,63,12},38))
recheckStatue(_d({45,78,59,78,79,63,11},38))
if not enabled then return end
debug(_d({49,59,67,78,67,72,65,250,64,73,76,250,74,66,59,77,63,250,12,250,78,73,250,63,72,62},38))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({42,66,59,77,63,250,12,250,63,72,62,250,81,59,67,78,250,78,67,71,63,73,79,78,6,250,74,76,73,61,63,63,62,67,72,65,250,59,72,83,81,59,83},38))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({39,73,80,67,72,65,250,60,59,61,69,250,78,73,250,43,79,63,63,72,250,77,78,59,65,63,250,74,73,77,67,78,67,73,72},38))
navToPointConfirmed(COORDS.Queen, 30, _d({43,79,63,63,72,250,77,78,59,65,63,250,74,73,77,67,78,67,73,72},38))
debug(_d({49,59,67,78,67,72,65,250,15,77,250,59,78,250,43,79,63,63,72,250,77,78,59,65,63,250,74,73,77,67,78,67,73,72},38))
task.wait(5)
if not enabled then return end
debug(_d({39,73,80,67,72,65,250,78,73,250,74,73,77,78,7,43,79,63,63,72,250,74,73,77,67,78,67,73,72},38))
navToPointConfirmed(COORDS.PostQueen, 30, _d({74,73,77,78,7,43,79,63,63,72,250,74,73,77,67,78,67,73,72},38))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({31,72,59,60,70,67,72,65,6,250,74,73,77,250,28,31,32,41,44,31,250,74,70,59,72,20},38), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({42,70,59,72,250,63,76,76,73,76,20},38), err2) end
end)
debug(_d({31,72,59,60,70,63,62,20},38), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({31,72,59,60,70,63,62,20},38), enabled)
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
if not ok then debug(_d({35,72,74,79,78,28,63,65,59,72,250,63,76,76,73,76,20},38), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({33,59,71,63,250,70,73,59,62,63,62,6,250,59,79,78,73,7,77,78,59,76,78,67,72,65,250,78,66,63,250,74,70,59,72},38))
enableBot()
end)
if not ok then debug(_d({27,79,78,73,77,78,59,76,78,250,63,76,76,73,76,20},38), err) end
end)
debug(_d({38,73,59,62,63,62,250,188,90,110,250,59,79,78,73,7,77,78,59,76,78,67,72,65,250,73,72,61,63,250,78,66,63,250,65,59,71,63,250,64,67,72,67,77,66,63,77,250,70,73,59,62,67,72,65,250,2,74,76,63,77,77,250,42,250,78,73,250,78,73,65,65,70,63,250,71,59,72,79,59,70,70,83,3},38))
end)()