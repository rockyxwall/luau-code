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
local Players            = game:GetService(_d({20,48,37,61,41,54,55},60))
local UserInputService    = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
local RunService          = game:GetService(_d({22,57,50,23,41,54,58,45,39,41},60))
local VIM                 = game:GetService(_d({26,45,54,56,57,37,48,13,50,52,57,56,17,37,50,37,43,41,54},60))
local ReplicatedStorage    = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({31,6,51,55,55,6,51,56,33},60), _d({27,54,51,50,43,228,43,37,49,41,228,166,68,88,228,20,48,37,39,41,13,40,254},60), game.PlaceId, _d({25,50,45,58,41,54,55,41,13,40,254},60), game.GameId, _d({241,228,50,51,56,228,54,57,50,50,45,50,43},60))
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
local LEO_PILLAR_ANIM_ID   = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,249,246,248,248,245,248,245,247,246,251},60)
local LEO_ENTEI_ANIM_ID    = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,249,246,248,248,245,247,252,246,251,252},60)
local LEO_HIKEN_ANIM_ID    = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,249,246,246,244,253,245,251,248,244,251},60)
local LEO_FIREFLY_ANIM_ID  = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,249,246,246,244,246,247,250,245,249,248},60)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({19,38,46,41,39,56,45,58,41,55},60)
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
local REPLAY_BUTTON_VALUE   = _d({22,41,52,48,37,61},60)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({49,51,58,41},60)
local NavState   = {mode = _d({45,40,48,41},60)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({31,6,51,55,55,6,51,56,33},60), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end)
if ok then return root end
debug(_d({43,41,56,22,51,51,56,228,41,54,54,51,54,254},60), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
end)
if ok then return hum end
debug(_d({43,41,56,12,57,49,37,50,51,45,40,228,41,54,54,51,54,254},60), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({35,35,12,51,58,41,54,5,56,56},60)) or Instance.new(_d({5,56,56,37,39,44,49,41,50,56},60))
att.Name = _d({35,35,12,51,58,41,54,5,56,56},60)
att.Parent = root
local force = root:FindFirstChild(_d({35,35,12,51,58,41,54,10,51,54,39,41},60))
if not force then
force = Instance.new(_d({16,45,50,41,37,54,26,41,48,51,39,45,56,61},60))
force.Name = _d({35,35,12,51,58,41,54,10,51,54,39,41},60)
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
debug(_d({43,41,56,19,54,7,54,41,37,56,41,10,51,54,39,41,228,41,54,54,51,54,254},60), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if not root then return end
local force = root:FindFirstChild(_d({35,35,12,51,58,41,54,10,51,54,39,41},60))
local att   = root:FindFirstChild(_d({35,35,12,51,58,41,54,5,56,56},60))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({39,48,41,37,50,57,52,10,51,54,39,41,228,41,54,54,51,54,254},60), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({6,57,55,51,17,41,48,41,41},60)) ~= nil
end)
if ok then return result end
debug(_d({45,55,6,57,55,51,5,39,56,45,58,41,228,41,54,54,51,54,254},60), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({6,57,55,51},60))
end)
if not ok then debug(_d({37,39,56,45,58,37,56,41,6,57,55,51,228,41,54,54,51,54,254},60), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({6,57,55,51,228,50,51,56,228,37,39,56,45,58,41,240,228,37,39,56,45,58,37,56,45,50,43},60))
activateBuso()
end
end)
if not ok then debug(_d({6,57,55,51,15,41,41,52,41,54,228,41,54,54,51,54,254},60), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({6,57,55,51,228,47,41,41,52,41,54,228,55,56,51,52,52,41,40},60))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({15,41,50,12,37,47,45},60)) ~= nil
end)
if ok then return result end
debug(_d({45,55,15,41,50,5,39,56,45,58,41,228,41,54,54,51,54,254},60), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({15,41,50},60), true)
end)
if not ok then debug(_d({37,39,56,45,58,37,56,41,15,41,50,228,41,54,54,51,54,254},60), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({15,41,50,228,50,51,56,228,37,39,56,45,58,41,240,228,37,39,56,45,58,37,56,45,50,43},60))
activateKen()
end
end)
if not ok then debug(_d({15,41,50,15,41,41,52,41,54,228,41,54,54,51,54,254},60), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({15,41,50,228,47,41,41,52,41,54,228,55,56,51,52,52,41,40},60))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({18,20,7,55},60)) end)
if ok then return folder end
debug(_d({43,41,56,18,20,7,55,10,51,48,40,41,54,228,41,54,54,51,54,254},60), folder)
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
local r = model:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local h = model:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
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
debug(_d({43,41,56,18,41,37,54,41,55,56,18,20,7,228,41,54,54,51,54,254},60), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
local hum  = model:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({43,41,56,18,20,7,6,61,18,37,49,41,228,41,54,54,51,54,254},60), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({50,52,39,55,22,41,49,37,45,50,45,50,43,228,41,54,54,51,54,254},60), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({7,57,52,45,40,228,21,57,41,41,50},60))
return queen ~= nil and queen:FindFirstChild(_d({49,51,56,45,51,50,16,41,55,55},60)) ~= nil
end)
if ok then return result end
debug(_d({45,55,21,57,41,41,50,20,44,37,55,41,246,228,41,54,54,51,54,254},60), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,245,246,245,246,253,251,253,248,246,246,253,246,251,250,253},60)
local QUEEN_GRASP_ANIM_ID   = _d({54,38,60,37,55,55,41,56,45,40,254,243,243,245,246,253,252,244,244,244,250,245,244,244,245,251,247,248},60)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
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
debug(_d({45,55,20,48,37,61,45,50,43,5,50,45,49,10,54,51,49,16,45,55,56,228,41,54,54,51,54,254},60), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({6,48,51,39,47,45,50,43},60)) ~= nil
end)
if ok then return result end
debug(_d({45,55,18,20,7,6,48,51,39,47,45,50,43,228,41,54,54,51,54,254},60), result)
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
debug(_d({52,54,41,40,45,39,56,18,20,7,20,51,55,45,56,45,51,50,228,41,54,54,51,54,254},60), result)
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
debug(_d({18,51,228,40,37,49,37,43,41,228,51,50},60), model.Name, _d({42,51,54},60), NPC_STUCK_TIMEOUT, _d({55,228,241,228,55,59,45,56,39,44,45,50,43,228,56,37,54,43,41,56},60))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({56,54,37,39,47,18,20,7,8,37,49,37,43,41,228,41,54,54,51,54,254},60), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({17,51,40,41,48},60)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({6,37,55,41,20,37,54,56},60)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({43,41,56,17,51,40,41,48,10,37,39,41,20,51,55,228,41,54,54,51,54,254},60), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({9,50,58},60))
local folder = env and env:FindFirstChild(_d({23,56,37,56,57,41,55},60))
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
debug(_d({43,41,56,23,56,37,56,57,41,17,51,40,41,48,18,41,37,54,228,41,54,54,51,54,254},60), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({38,37,54,54,41,48,12,20},60))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({43,41,56,23,56,37,56,57,41,12,20,228,41,54,54,51,54,254},60), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({24,51,51,48},60)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({42,45,50,40,24,51,51,48,6,61,5,56,56,54,45,38,57,56,41,228,41,54,54,51,54,254},60), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({24,51,51,48},60)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({42,45,50,40,24,51,51,48,6,61,18,37,49,41,228,41,54,54,51,54,254},60), tool)
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
if not ok then debug(_d({41,53,57,45,52,24,51,51,48,228,41,54,54,51,54,254},60), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({6,37,39,47,52,37,39,47},60))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({24,51,51,48},60)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({42,45,50,40,24,51,51,48,6,61,7,44,45,48,40,18,37,49,41,228,41,54,54,51,54,254},60), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({23,59,51,54,40,9,53,57,45,52},60))
if sword then
equipTool(sword)
return _d({55,59,51,54,40},60)
end
local melee = findToolByAttribute(_d({17,41,48,41,41,24,51,51,48},60))
if melee then
equipTool(melee)
return _d({49,41,48,41,41},60)
end
debug(_d({18,51,228,55,59,51,54,40,228,51,54,228,49,41,48,41,41,228,56,51,51,48,228,42,51,57,50,40},60))
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
if not ok then debug(_d({39,48,45,39,47,17,245,228,41,54,54,51,54,254},60), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({22,51,47,57,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,41,52,52,51},60), args)
elseif style == _d({6,48,37,39,47,16,41,43},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47},60), args)
elseif style == _d({15,37,49,45,55,44,45,47,45},60) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,37,49,45,55,44,45,47,45,11,41,52,52,51},60), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,47,61,228,27,37,48,47,246},60), args)
end
end)
if not ok then debug(_d({45,50,58,51,47,41,11,41,52,52,51,228,41,54,54,51,54,254},60), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({52,54,41,55,55,23,47,45,48,48,22,228,41,54,54,51,54,254},60), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({44,51,48,40,6,48,51,39,47,228,41,54,54,51,54,254},60), err) end
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
if not ok then debug(_d({44,51,48,40,6,48,51,39,47,27,44,45,48,41,228,41,54,54,51,54,254},60), err) end
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
debug(_d({43,41,56,11,37,49,41,11,228,41,54,54,51,54,254},60), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({45,55,22,41,37,48,17,245,6,57,55,61,228,41,54,54,51,54,254},60), result)
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
return char ~= nil and char:FindFirstChild(_d({55,56,57,50},60)) ~= nil
end)
if ok then return result end
debug(_d({45,55,23,56,57,50,50,41,40,228,41,54,54,51,54,254},60), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({52,54,41,55,55,23,56,57,50,6,54,41,37,47,228,41,54,54,51,54,254},60), err) end
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
debug(_d({53,57,41,41,50,8,51,40,43,41,25,50,56,45,48,23,37,42,41,254,228,21,57,41,41,50,228,43,51,50,41,228,241,228,41,50,40,45,50,43,228,40,51,40,43,41,228,41,37,54,48,61},60))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({53,57,41,41,50,8,51,40,43,41,25,50,56,45,48,23,37,42,41,228,55,37,42,41,56,61,228,56,45,49,41,51,57,56},60))
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
local info = getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({21,57,41,41,50,228,39,37,55,56,45,50,43,228,40,41,56,41,39,56,41,40,228,241,228,40,51,40,43,45,50,43,228,236,59,37,56,39,44,41,54,237},60))
queenDodgeUntilSafe(function() return getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60)) end)
if enabled and getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60)) then
setNavNamed(_d({7,57,52,45,40,228,21,57,41,41,50},60))
end
queenDodging = false
end
end)
if not ok then debug(_d({53,57,41,41,50,8,51,40,43,41,27,37,56,39,44,41,54,228,41,54,54,51,54,254},60), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({52,51,45,50,56},60) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({50,52,39},60) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({50,37,49,41,40},60) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({43,41,56,18,37,58,24,37,54,43,41,56,55,228,41,54,54,51,54,254},60), aimR)
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
debug(_d({39,51,49,52,57,56,41,16,51,39,47,41,40,7,10,54,37,49,41,228,41,54,54,51,54,254},60), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({52,51,45,50,56},60), point = pos}
phase = _d({49,51,58,41},60)
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
if not ok then debug(_d({50,37,58,24,51,20,51,45,50,56,228,43,41,52,52,51,228,39,44,41,39,47,228,41,54,54,51,54,254},60), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({50,52,39},60)}
phase = _d({49,51,58,41},60)
end
function setNavNamed(name)
NavState = {mode = _d({50,37,49,41,40},60), name = name}
phase = _d({49,51,58,41},60)
end
local function setNavIdle()
NavState = {mode = _d({45,40,48,41},60)}
phase = _d({49,51,58,41},60)
end
local function hasArrived()
return phase == _d({44,51,58,41,54},60)
end
local function startNav()
phase = _d({49,51,58,41},60)
debug(_d({18,37,58,228,48,51,51,52,228,19,18},60))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({20,48,37,61,41,54,228,40,45,41,40,229,228,23,56,51,52,52,45,50,43,228,38,51,56,242},60))
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
debug(_d({20,48,37,61,41,54,228,45,55,228,56,51,51,228,42,37,54,228,42,54,51,49,228,56,37,54,43,41,56,228,236,2,246,244,244,244,228,55,56,57,40,55,237,242,228,16,45,47,41,48,61,228,54,41,55,52,37,59,50,41,40,228,37,56,228,48,51,38,38,61,242,228,23,56,51,52,52,45,50,43,228,38,51,56,242},60))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({35,35,52,54,41,58,20,51,55},60))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({16,37,54,43,41,228,52,51,55,45,56,45,51,50,228,46,57,49,52,228,40,41,56,41,39,56,41,40,254},60), delta, _d({55,56,57,40,55,242,228,52,54,41,58,20,51,55,1},60), prevPos, _d({50,41,59,20,51,55,1},60), pos)
end
end
force:SetAttribute(_d({35,35,52,54,41,58,20,51,55},60), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({49,51,58,41},60) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({44,51,58,41,54},60)
debug(_d({20,44,37,55,41,254,228,44,51,58,41,54},60))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({229,229,229,228,22,9,10,25,23,13,18,11,228,24,19,228,5,20,20,16,29,228,5,6,18,19,22,17,5,16,228,26,9,16,19,7,13,24,29,254},60), finalVel, _d({37,45,49,1},60), aim, _d({52,51,55,1},60), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({44,51,58,41,54},60) then
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
debug(_d({7,51,49,38,37,56,228,48,51,39,47,228,55,47,45,52,52,41,40,240},60), snapDist, _d({55,56,57,40,55,228,42,54,51,49,228,56,37,54,43,41,56,228,166,68,88,228,42,37,48,48,45,50,43,228,38,37,39,47,228,56,51,228,49,51,58,41},60))
phase = _d({49,51,58,41},60)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({12,41,37,54,56,38,41,37,56,228,41,54,54,51,54,254},60), err) end
end)
end
local function stopNav()
debug(_d({18,37,58,228,48,51,51,52,228,19,10,10},60))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({49,51,58,41},60)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({24,41,60,56,7,44,37,56,23,41,54,58,45,39,41},60))
local channels = TextChatService:FindFirstChild(_d({24,41,60,56,7,44,37,50,50,41,48,55},60))
local channel = channels and channels:FindFirstChild(_d({22,6,28,11,41,50,41,54,37,48},60))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({8,41,42,37,57,48,56,7,44,37,56,23,61,55,56,41,49,7,44,37,56,9,58,41,50,56,55},60))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({23,37,61,17,41,55,55,37,43,41,22,41,53,57,41,55,56},60))
if sayEvent then
sayEvent:FireServer(message, _d({5,48,48},60))
return
end
debug(_d({55,41,50,40,7,44,37,56,17,41,55,55,37,43,41,254,228,50,51,228,24,41,60,56,7,44,37,56,23,41,54,58,45,39,41,242,22,6,28,11,41,50,41,54,37,48,228,51,54,228,48,41,43,37,39,61,228,23,37,61,17,41,55,55,37,43,41,22,41,53,57,41,55,56,228,42,51,57,50,40,228,42,51,54},60), message)
end)
if not ok then debug(_d({55,41,50,40,7,44,37,56,17,41,55,55,37,43,41,228,41,54,54,51,54,254},60), err) end
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
debug(_d({18,51,56,228,49,37,47,45,50,43,228,52,54,51,43,54,41,55,55,228,56,51,59,37,54,40,228,50,37,58,228,56,37,54,43,41,56,228,42,51,54},60), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({55,228,241,228,55,41,50,40,45,50,43,228,243,57,50,55,56,57,39,47},60))
sendChatMessage(_d({243,57,50,55,56,57,39,47},60))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({59,37,45,56,25,50,56,45,48,5,54,54,45,58,41,40,228,56,45,49,41,51,57,56},60))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({50,37,58,24,51,20,51,45,50,56,7,51,50,42,45,54,49,41,40,254},60), label or _d({56,37,54,43,41,56},60), _d({241,228,40,45,40,228,50,51,56,228,37,54,54,45,58,41,228,59,45,56,44,45,50},60), timeout, _d({55,240,228,54,41,56,54,61,45,50,43,228,51,50,39,41},60))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({50,37,58,24,51,20,51,45,50,56,7,51,50,42,45,54,49,41,40,254},60), label or _d({56,37,54,43,41,56},60), _d({241,228,55,56,45,48,48,228,50,51,56,228,37,54,54,45,58,41,40,228,37,42,56,41,54,228,54,41,56,54,61,240,228,52,54,51,39,41,41,40,45,50,43,228,37,50,61,59,37,61},60))
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
if not ok then debug(_d({50,37,58,24,51,20,51,45,50,56,12,51,48,40,45,50,43,6,48,51,39,47,228,47,41,61,241,40,51,59,50,228,41,54,54,51,54,254},60), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({50,37,58,24,51,20,51,45,50,56,12,51,48,40,45,50,43,6,48,51,39,47,228,47,41,61,241,57,52,228,41,54,54,51,54,254},60), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({27,37,48,47,45,50,43,228,56,51,254},60), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({59,37,48,47,24,51,20,51,45,50,56,228,27,228,40,51,59,50,228,41,54,54,51,54,254},60), err) end
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
debug(_d({24,51,51,47,228,40,37,49,37,43,41,228,59,44,45,48,41,228,59,37,48,47,45,50,43,228,56,51,228,52,51,45,50,56,229,228,23,56,51,52,52,45,50,43,228,59,37,48,47,228,56,51,228,41,50,43,37,43,41,242},60))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({5,54,54,45,58,41,40,228,37,56,254},60), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({23,56,57,39,47,228,40,57,54,45,50,43,228,59,37,48,47,240,228,46,57,49,52,45,50,43,229},60))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({23,56,45,48,48,228,55,56,57,39,47,240,228,56,54,45,43,43,41,54,45,50,43,228,11,41,52,52,51,229},60))
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
debug(_d({17,51,58,45,50,43,228,56,51},60), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({27,37,45,56,45,50,43,228,42,51,54,228,18,20,7,55,228,56,51,228,55,52,37,59,50,228,37,56},60), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({228,228,55,52,37,59,50,228,39,44,41,39,47,254,228,42,51,48,40,41,54,228,41,60,45,55,56,55,228,1},60), folder ~= nil,
_d({240,228,39,44,45,48,40,54,41,50,228,1},60), folder and #folder:GetChildren() or 0,
_d({240,228,37,48,45,58,41,228,1},60), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({18,51,228,18,20,7,55,228,37,52,52,41,37,54,41,40,228,37,56},60), stageName, _d({37,42,56,41,54,228,245,249,55,240,228,49,51,58,45,50,43,228,51,50,228,37,50,61,59,37,61},60))
break
end
end
debug(_d({15,45,48,48,45,50,43,228,18,20,7,55,228,37,56},60), stageName)
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
debug(_d({22,41,56,57,54,50,45,50,43,228,56,51},60), stageName, _d({52,51,55,45,56,45,51,50,228,38,41,42,51,54,41,228,49,51,58,45,50,43,228,51,50},60))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({27,37,45,56,45,50,43,228,249,55,228,37,56},60), stageName, _d({52,51,55,45,56,45,51,50},60))
task.wait(5)
debug(_d({27,37,45,56,45,50,43,228,42,51,54},60), targetHP * 100, _d({233,228,12,20,228,38,41,42,51,54,41,228,49,51,58,45,50,43,228,56,51,228,50,41,60,56,228,55,56,37,43,41},60))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({39,48,41,37,54,41,40},60))
end
local function killNamedNPC(name, targetPos)
debug(_d({17,51,58,45,50,43,228,56,51},60), name)
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
debug(name, _d({40,41,42,41,37,56,41,40},60))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({12,57,49,37,50,51,45,40},60))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({16,41,51,228,52,48,37,61,41,40,228,37,50,45,49,37,56,45,51,50,254},60), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({48,41,51,5,50,45,49,16,51,43,43,41,54,228,52,54,45,50,56,228,41,54,54,51,54,254},60), err2) end
end)
end)
if not ok then debug(_d({55,56,37,54,56,16,41,51,5,50,45,49,16,51,43,43,41,54,228,41,54,54,51,54,254},60), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({17,51,58,45,50,43,228,56,51,228,16,41,51},60))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({16,41,51},60))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({16,41,51},60))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({16,41,51},60))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({16,41,51,228,39,37,55,56,45,50,43},60), which, _d({241,228,40,51,40,43,45,50,43},60))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({16,41,51,228,55,56,37,54,56,41,40,228,38,48,51,39,47,241,38,54,41,37,47,41,54,228,49,45,40,241,38,48,51,39,47,229,228,9,58,37,40,45,50,43,242,242,242},60))
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
if not getNPCByName(_d({16,41,51},60)) then
debug(_d({16,41,51,228,43,51,50,41,228,49,45,40,241,40,51,40,43,41,228,241,228,41,50,40,45,50,43,228,9,50,56,41,45,228,44,51,48,40,228,41,37,54,48,61},60))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({16,41,51},60)) then
setNavNamed(_d({16,41,51},60))
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
debug(_d({16,41,51,228,40,41,42,41,37,56,41,40},60))
stopLeoAnimLogger()
debug(_d({22,41,56,57,54,50,45,50,43,228,56,51,228,16,41,51,228,52,51,55,45,56,45,51,50,228,38,41,42,51,54,41,228,49,51,58,45,50,43,228,51,50},60))
navToPointConfirmed(COORDS.Leo, 30, _d({16,41,51,228,52,51,55,45,56,45,51,50},60))
debug(_d({27,37,45,56,45,50,43,228,249,55,228,37,56,228,16,41,51,228,52,51,55,45,56,45,51,50},60))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({17,51,58,45,50,43,228,56,51},60), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({7,51,57,48,40,228,50,51,56,228,42,45,50,40,228,55,56,37,56,57,41,228,49,51,40,41,48,228,50,41,37,54},60), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({5,56,56,37,39,47,45,50,43},60), coordKey, _d({59,45,56,44},60), weapon or _d({50,51,56,44,45,50,43,228,42,51,57,50,40},60))
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
debug(coordKey, _d({38,37,54,54,41,48,228,40,41,55,56,54,51,61,41,40},60))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({54,41,39,44,41,39,47,23,56,37,56,57,41,254},60), coordKey, _d({241,228,39,51,57,48,40,228,50,51,56,228,42,45,50,40,228,55,56,37,56,57,41,228,49,51,40,41,48,240,228,55,47,45,52,52,45,50,43},60))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({54,41,39,44,41,39,47,23,56,37,56,57,41,254},60), coordKey, _d({55,56,45,48,48,228,37,48,45,58,41,228,236,12,20},60), hp, _d({237,228,241,228,54,41,241,40,41,55,56,54,51,61,45,50,43},60))
destroyStatue(coordKey)
else
debug(_d({54,41,39,44,41,39,47,23,56,37,56,57,41,254},60), coordKey, _d({39,51,50,42,45,54,49,41,40,228,40,41,55,56,54,51,61,41,40},60))
end
end)
if not ok then debug(_d({54,41,39,44,41,39,47,23,56,37,56,57,41,228,41,54,54,51,54,254},60), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({17,51,58,45,50,43,228,56,51,228,21,57,41,41,50},60))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({7,57,52,45,40,228,21,57,41,41,50},60))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60))
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
debug(_d({21,57,41,41,50,228,41,50,56,41,54,41,40,228,52,44,37,55,41,228,246},60))
end
local function finishQueen()
debug(_d({10,45,50,45,55,44,45,50,43,228,21,57,41,41,50},60))
equipSwordOrMelee()
setNavNamed(_d({7,57,52,45,40,228,21,57,41,41,50},60))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({7,57,52,45,40,228,21,57,41,41,50},60))
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
debug(_d({21,57,41,41,50,228,40,41,42,41,37,56,41,40,242,228,20,48,37,50,228,39,51,49,52,48,41,56,41,242},60))
end
local CONFIRMATION_PROMPT_NAME = _d({7,51,50,42,45,54,49,37,56,45,51,50,20,54,51,49,52,56},60)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({22,41,49,51,56,41,9,58,41,50,56},60), 5)
end)
if ok then return result end
debug(_d({43,41,56,22,41,52,48,37,61,22,41,49,51,56,41,228,41,54,54,51,54,254},60), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({20,48,37,61,41,54,11,57,45},60))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({13,49,37,43,41,6,57,56,56,51,50},60)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({38,57,56,56,51,50,26,37,48,57,41},60)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({42,45,50,40,6,57,56,56,51,50,6,61,26,37,48,57,41,228,41,54,54,51,54,254},60), result)
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
if not ok then debug(_d({39,48,45,39,47,11,57,45,6,57,56,56,51,50,228,41,54,54,51,54,254},60), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({45,55,23,41,54,58,41,54},60))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({22,41,49,51,56,41,9,58,41,50,56},60))
or inst:FindFirstChild(_d({39,48,45,41,50,56,9,58,41,50,56},60))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({42,45,50,40,5,50,55,59,41,54,7,51,50,50,41,39,56,51,54,228,41,54,54,51,54,254},60), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({7,51,57,48,40,228,50,51,56,228,48,51,39,37,56,41,228,22,41,49,51,56,41,9,58,41,50,56,243,39,48,45,41,50,56,9,58,41,50,56,228,50,41,37,54,228,22,41,52,48,37,61,228,38,57,56,56,51,50,240,228,42,37,48,48,45,50,43,228,38,37,39,47,228,56,51,228,39,48,45,39,47},60))
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
debug(_d({42,45,54,41,22,41,52,48,37,61,26,37,48,57,41,228,41,54,54,51,54,254},60), err, _d({241,228,42,37,48,48,45,50,43,228,38,37,39,47,228,56,51,228,39,48,45,39,47},60))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({10,37,48,48,45,50,43,228,38,37,39,47,228,56,51,228,38,57,56,56,51,50,26,37,48,57,41,228,55,41,37,54,39,44,228,42,51,54,228,22,41,52,48,37,61},60))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({22,41,52,48,37,61,228,38,57,56,56,51,50,228,50,51,56,228,42,51,57,50,40,228,41,45,56,44,41,54,240,228,43,45,58,45,50,43,228,57,52},60))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({27,37,45,56,45,50,43,228,42,51,54,228,7,51,50,42,45,54,49,37,56,45,51,50,20,54,51,49,52,56,242,22,41,49,51,56,41,9,58,41,50,56},60))
local remote = getReplayRemote()
if not remote then
debug(_d({7,51,50,42,45,54,49,37,56,45,51,50,20,54,51,49,52,56,243,22,41,49,51,56,41,9,58,41,50,56,228,50,51,56,228,42,51,57,50,40,228,59,45,56,44,45,50,228,56,45,49,41,51,57,56},60))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({10,45,54,45,50,43,228,22,41,52,48,37,61,228,58,45,37,228,7,51,50,42,45,54,49,37,56,45,51,50,20,54,51,49,52,56,242,22,41,49,51,56,41,9,58,41,50,56},60))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({10,45,54,41,23,41,54,58,41,54,228,41,54,54,51,54,254},60), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({20,48,37,61,41,54,11,57,45},60), 10)
if not playerGui then
debug(_d({59,37,45,56,10,51,54,19,38,46,41,39,56,45,58,41,55,11,57,45,254,228,50,51,228,20,48,37,61,41,54,11,57,45,228,59,45,56,44,45,50,228,56,45,49,41,51,57,56,240,228,52,54,51,39,41,41,40,45,50,43,228,37,50,61,59,37,61},60))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({19,38,46,41,39,56,45,58,41,55,228,11,25,13,228,42,51,57,50,40,228,241,228,55,56,37,43,41,228,48,51,37,40,41,40},60))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({19,38,46,41,39,56,45,58,41,55,228,11,25,13,228,50,51,56,228,42,51,57,50,40,228,59,45,56,44,45,50,228,56,45,49,41,51,57,56,240,228,52,54,51,39,41,41,40,45,50,43,228,37,50,61,59,37,61},60))
return
end
end
end)
if not ok then debug(_d({59,37,45,56,10,51,54,19,38,46,41,39,56,45,58,41,55,11,57,45,228,41,54,54,51,54,254},60), err) end
end
local function runPlan()
debug(_d({20,48,37,50,228,55,56,37,54,56,41,40},60))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({23,56,37,54,56,45,50,43,228,50,37,58,228,48,51,51,52},60))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({52,51,55,228,244,242,246,55,228,5,10,24,9,22,228,55,56,37,54,56,18,37,58,254},60), rootAfter and rootAfter.Position)
end)
debug(_d({27,37,45,56,45,50,43,228,249,55,228,38,41,42,51,54,41,228,49,51,58,45,50,43,228,56,51,228,23,56,37,43,41,245},60))
task.wait(5)
for _, stage in ipairs({_d({23,56,37,43,41,245},60), _d({23,56,37,43,41,246},60), _d({23,56,37,43,41,247},60), _d({23,56,37,43,41,247,6},60)}) do
if not enabled then return end
local hpTarget = (stage == _d({23,56,37,43,41,247,6},60)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({17,51,58,45,50,43,228,56,51,228,37,54,54,51,59,228,42,48,61,241,40,51,59,50,228,37,54,41,37,228,236,7,57,52,45,40,228,22,37,45,50,237},60))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({8,51,40,43,45,50,43,228,37,54,54,51,59,228,54,37,45,50,228,45,50,228,37,228,55,53,57,37,54,41},60))
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
clearStage(_d({23,56,37,43,41,248},60))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({21,57,41,41,50,228,45,50,228,52,44,37,55,41,228,246,228,241,228,47,41,41,52,45,50,43,228,15,41,50,228,12,37,47,45,228,37,39,56,45,58,41,228,42,54,51,49,228,44,41,54,41,228,51,50},60))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({23,56,37,56,57,41,245},60))
if not enabled then return end
recheckStatue(_d({23,56,37,56,57,41,245},60))
destroyStatue(_d({23,56,37,56,57,41,246},60))
if not enabled then return end
recheckStatue(_d({23,56,37,56,57,41,245},60))
recheckStatue(_d({23,56,37,56,57,41,246},60))
destroyStatue(_d({23,56,37,56,57,41,247},60))
if not enabled then return end
recheckStatue(_d({23,56,37,56,57,41,247},60))
recheckStatue(_d({23,56,37,56,57,41,246},60))
recheckStatue(_d({23,56,37,56,57,41,245},60))
if not enabled then return end
debug(_d({27,37,45,56,45,50,43,228,42,51,54,228,52,44,37,55,41,228,246,228,56,51,228,41,50,40},60))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({20,44,37,55,41,228,246,228,41,50,40,228,59,37,45,56,228,56,45,49,41,51,57,56,240,228,52,54,51,39,41,41,40,45,50,43,228,37,50,61,59,37,61},60))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({17,51,58,45,50,43,228,38,37,39,47,228,56,51,228,21,57,41,41,50,228,55,56,37,43,41,228,52,51,55,45,56,45,51,50},60))
navToPointConfirmed(COORDS.Queen, 30, _d({21,57,41,41,50,228,55,56,37,43,41,228,52,51,55,45,56,45,51,50},60))
debug(_d({27,37,45,56,45,50,43,228,249,55,228,37,56,228,21,57,41,41,50,228,55,56,37,43,41,228,52,51,55,45,56,45,51,50},60))
task.wait(5)
if not enabled then return end
debug(_d({17,51,58,45,50,43,228,56,51,228,52,51,55,56,241,21,57,41,41,50,228,52,51,55,45,56,45,51,50},60))
navToPointConfirmed(COORDS.PostQueen, 30, _d({52,51,55,56,241,21,57,41,41,50,228,52,51,55,45,56,45,51,50},60))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({9,50,37,38,48,45,50,43,240,228,52,51,55,228,6,9,10,19,22,9,228,52,48,37,50,254},60), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({20,48,37,50,228,41,54,54,51,54,254},60), err2) end
end)
debug(_d({9,50,37,38,48,41,40,254},60), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({9,50,37,38,48,41,40,254},60), enabled)
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
if not ok then debug(_d({13,50,52,57,56,6,41,43,37,50,228,41,54,54,51,54,254},60), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({11,37,49,41,228,48,51,37,40,41,40,240,228,37,57,56,51,241,55,56,37,54,56,45,50,43,228,56,44,41,228,52,48,37,50},60))
enableBot()
end)
if not ok then debug(_d({5,57,56,51,55,56,37,54,56,228,41,54,54,51,54,254},60), err) end
end)
debug(_d({16,51,37,40,41,40,228,166,68,88,228,37,57,56,51,241,55,56,37,54,56,45,50,43,228,51,50,39,41,228,56,44,41,228,43,37,49,41,228,42,45,50,45,55,44,41,55,228,48,51,37,40,45,50,43,228,236,52,54,41,55,55,228,20,228,56,51,228,56,51,43,43,48,41,228,49,37,50,57,37,48,48,61,237},60))
end)()