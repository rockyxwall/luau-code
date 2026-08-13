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
local Players            = game:GetService(_d({25,53,42,66,46,59,60},55))
local UserInputService    = game:GetService(_d({30,60,46,59,18,55,57,62,61,28,46,59,63,50,44,46},55))
local RunService          = game:GetService(_d({27,62,55,28,46,59,63,50,44,46},55))
local VIM                 = game:GetService(_d({31,50,59,61,62,42,53,18,55,57,62,61,22,42,55,42,48,46,59},55))
local ReplicatedStorage    = game:GetService(_d({27,46,57,53,50,44,42,61,46,45,28,61,56,59,42,48,46},55))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({36,11,56,60,60,11,56,61,38},55), _d({32,59,56,55,48,233,48,42,54,46,233,171,73,93,233,25,53,42,44,46,18,45,3},55), game.PlaceId, _d({30,55,50,63,46,59,60,46,18,45,3},55), game.GameId, _d({246,233,55,56,61,233,59,62,55,55,50,55,48},55))
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
local LEO_PILLAR_ANIM_ID   = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,254,251,253,253,250,253,250,252,251,0},55)
local LEO_ENTEI_ANIM_ID    = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,254,251,253,253,250,252,1,251,0,1},55)
local LEO_HIKEN_ANIM_ID    = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,254,251,251,249,2,250,0,253,249,0},55)
local LEO_FIREFLY_ANIM_ID  = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,254,251,251,249,251,252,255,250,254,253},55)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({24,43,51,46,44,61,50,63,46,60},55)
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
local REPLAY_BUTTON_VALUE   = _d({27,46,57,53,42,66},55)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({54,56,63,46},55)
local NavState   = {mode = _d({50,45,53,46},55)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({36,11,56,60,60,11,56,61,38},55), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
end)
if ok then return root end
debug(_d({48,46,61,27,56,56,61,233,46,59,59,56,59,3},55), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
end)
if ok then return hum end
debug(_d({48,46,61,17,62,54,42,55,56,50,45,233,46,59,59,56,59,3},55), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({40,40,17,56,63,46,59,10,61,61},55)) or Instance.new(_d({10,61,61,42,44,49,54,46,55,61},55))
att.Name = _d({40,40,17,56,63,46,59,10,61,61},55)
att.Parent = root
local force = root:FindFirstChild(_d({40,40,17,56,63,46,59,15,56,59,44,46},55))
if not force then
force = Instance.new(_d({21,50,55,46,42,59,31,46,53,56,44,50,61,66},55))
force.Name = _d({40,40,17,56,63,46,59,15,56,59,44,46},55)
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
debug(_d({48,46,61,24,59,12,59,46,42,61,46,15,56,59,44,46,233,46,59,59,56,59,3},55), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if not root then return end
local force = root:FindFirstChild(_d({40,40,17,56,63,46,59,15,56,59,44,46},55))
local att   = root:FindFirstChild(_d({40,40,17,56,63,46,59,10,61,61},55))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({44,53,46,42,55,62,57,15,56,59,44,46,233,46,59,59,56,59,3},55), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({11,62,60,56,22,46,53,46,46},55)) ~= nil
end)
if ok then return result end
debug(_d({50,60,11,62,60,56,10,44,61,50,63,46,233,46,59,59,56,59,3},55), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({11,62,60,56},55))
end)
if not ok then debug(_d({42,44,61,50,63,42,61,46,11,62,60,56,233,46,59,59,56,59,3},55), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({11,62,60,56,233,55,56,61,233,42,44,61,50,63,46,245,233,42,44,61,50,63,42,61,50,55,48},55))
activateBuso()
end
end)
if not ok then debug(_d({11,62,60,56,20,46,46,57,46,59,233,46,59,59,56,59,3},55), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({11,62,60,56,233,52,46,46,57,46,59,233,60,61,56,57,57,46,45},55))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({20,46,55,17,42,52,50},55)) ~= nil
end)
if ok then return result end
debug(_d({50,60,20,46,55,10,44,61,50,63,46,233,46,59,59,56,59,3},55), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({20,46,55},55), true)
end)
if not ok then debug(_d({42,44,61,50,63,42,61,46,20,46,55,233,46,59,59,56,59,3},55), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({20,46,55,233,55,56,61,233,42,44,61,50,63,46,245,233,42,44,61,50,63,42,61,50,55,48},55))
activateKen()
end
end)
if not ok then debug(_d({20,46,55,20,46,46,57,46,59,233,46,59,59,56,59,3},55), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({20,46,55,233,52,46,46,57,46,59,233,60,61,56,57,57,46,45},55))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({23,25,12,60},55)) end)
if ok then return folder end
debug(_d({48,46,61,23,25,12,60,15,56,53,45,46,59,233,46,59,59,56,59,3},55), folder)
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
local r = model:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local h = model:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
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
debug(_d({48,46,61,23,46,42,59,46,60,61,23,25,12,233,46,59,59,56,59,3},55), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
local hum  = model:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({48,46,61,23,25,12,11,66,23,42,54,46,233,46,59,59,56,59,3},55), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({55,57,44,60,27,46,54,42,50,55,50,55,48,233,46,59,59,56,59,3},55), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({12,62,57,50,45,233,26,62,46,46,55},55))
return queen ~= nil and queen:FindFirstChild(_d({54,56,61,50,56,55,21,46,60,60},55)) ~= nil
end)
if ok then return result end
debug(_d({50,60,26,62,46,46,55,25,49,42,60,46,251,233,46,59,59,56,59,3},55), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,250,251,250,251,2,0,2,253,251,251,2,251,0,255,2},55)
local QUEEN_GRASP_ANIM_ID   = _d({59,43,65,42,60,60,46,61,50,45,3,248,248,250,251,2,1,249,249,249,255,250,249,249,250,0,252,253},55)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
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
debug(_d({50,60,25,53,42,66,50,55,48,10,55,50,54,15,59,56,54,21,50,60,61,233,46,59,59,56,59,3},55), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({11,53,56,44,52,50,55,48},55)) ~= nil
end)
if ok then return result end
debug(_d({50,60,23,25,12,11,53,56,44,52,50,55,48,233,46,59,59,56,59,3},55), result)
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
debug(_d({57,59,46,45,50,44,61,23,25,12,25,56,60,50,61,50,56,55,233,46,59,59,56,59,3},55), result)
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
debug(_d({23,56,233,45,42,54,42,48,46,233,56,55},55), model.Name, _d({47,56,59},55), NPC_STUCK_TIMEOUT, _d({60,233,246,233,60,64,50,61,44,49,50,55,48,233,61,42,59,48,46,61},55))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({61,59,42,44,52,23,25,12,13,42,54,42,48,46,233,46,59,59,56,59,3},55), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({22,56,45,46,53},55)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({11,42,60,46,25,42,59,61},55)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({48,46,61,22,56,45,46,53,15,42,44,46,25,56,60,233,46,59,59,56,59,3},55), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({14,55,63},55))
local folder = env and env:FindFirstChild(_d({28,61,42,61,62,46,60},55))
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
debug(_d({48,46,61,28,61,42,61,62,46,22,56,45,46,53,23,46,42,59,233,46,59,59,56,59,3},55), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({43,42,59,59,46,53,17,25},55))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({48,46,61,28,61,42,61,62,46,17,25,233,46,59,59,56,59,3},55), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({29,56,56,53},55)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({47,50,55,45,29,56,56,53,11,66,10,61,61,59,50,43,62,61,46,233,46,59,59,56,59,3},55), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({29,56,56,53},55)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({47,50,55,45,29,56,56,53,11,66,23,42,54,46,233,46,59,59,56,59,3},55), tool)
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
if not ok then debug(_d({46,58,62,50,57,29,56,56,53,233,46,59,59,56,59,3},55), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({11,42,44,52,57,42,44,52},55))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({29,56,56,53},55)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({47,50,55,45,29,56,56,53,11,66,12,49,50,53,45,23,42,54,46,233,46,59,59,56,59,3},55), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({28,64,56,59,45,14,58,62,50,57},55))
if sword then
equipTool(sword)
return _d({60,64,56,59,45},55)
end
local melee = findToolByAttribute(_d({22,46,53,46,46,29,56,56,53},55))
if melee then
equipTool(melee)
return _d({54,46,53,46,46},55)
end
debug(_d({23,56,233,60,64,56,59,45,233,56,59,233,54,46,53,46,46,233,61,56,56,53,233,47,56,62,55,45},55))
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
if not ok then debug(_d({44,53,50,44,52,22,250,233,46,59,59,56,59,3},55), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({17,62,54,42,55,56,50,45,27,56,56,61,25,42,59,61},55))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({28,61,42,61,60},55) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({27,56,52,62,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,46,57,57,56},55), args)
elseif style == _d({11,53,42,44,52,21,46,48},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52},55), args)
elseif style == _d({20,42,54,50,60,49,50,52,50},55) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,42,54,50,60,49,50,52,50,16,46,57,57,56},55), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,52,66,233,32,42,53,52,251},55), args)
end
end)
if not ok then debug(_d({50,55,63,56,52,46,16,46,57,57,56,233,46,59,59,56,59,3},55), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({57,59,46,60,60,28,52,50,53,53,27,233,46,59,59,56,59,3},55), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({49,56,53,45,11,53,56,44,52,233,46,59,59,56,59,3},55), err) end
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
if not ok then debug(_d({49,56,53,45,11,53,56,44,52,32,49,50,53,46,233,46,59,59,56,59,3},55), err) end
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
debug(_d({48,46,61,16,42,54,46,16,233,46,59,59,56,59,3},55), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({50,60,27,46,42,53,22,250,11,62,60,66,233,46,59,59,56,59,3},55), result)
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
return char ~= nil and char:FindFirstChild(_d({60,61,62,55},55)) ~= nil
end)
if ok then return result end
debug(_d({50,60,28,61,62,55,55,46,45,233,46,59,59,56,59,3},55), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({57,59,46,60,60,28,61,62,55,11,59,46,42,52,233,46,59,59,56,59,3},55), err) end
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
debug(_d({58,62,46,46,55,13,56,45,48,46,30,55,61,50,53,28,42,47,46,3,233,26,62,46,46,55,233,48,56,55,46,233,246,233,46,55,45,50,55,48,233,45,56,45,48,46,233,46,42,59,53,66},55))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({58,62,46,46,55,13,56,45,48,46,30,55,61,50,53,28,42,47,46,233,60,42,47,46,61,66,233,61,50,54,46,56,62,61},55))
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
local info = getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({26,62,46,46,55,233,44,42,60,61,50,55,48,233,45,46,61,46,44,61,46,45,233,246,233,45,56,45,48,50,55,48,233,241,64,42,61,44,49,46,59,242},55))
queenDodgeUntilSafe(function() return getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55)) end)
if enabled and getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55)) then
setNavNamed(_d({12,62,57,50,45,233,26,62,46,46,55},55))
end
queenDodging = false
end
end)
if not ok then debug(_d({58,62,46,46,55,13,56,45,48,46,32,42,61,44,49,46,59,233,46,59,59,56,59,3},55), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({57,56,50,55,61},55) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({55,57,44},55) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({55,42,54,46,45},55) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({48,46,61,23,42,63,29,42,59,48,46,61,60,233,46,59,59,56,59,3},55), aimR)
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
debug(_d({44,56,54,57,62,61,46,21,56,44,52,46,45,12,15,59,42,54,46,233,46,59,59,56,59,3},55), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({57,56,50,55,61},55), point = pos}
phase = _d({54,56,63,46},55)
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
if not ok then debug(_d({55,42,63,29,56,25,56,50,55,61,233,48,46,57,57,56,233,44,49,46,44,52,233,46,59,59,56,59,3},55), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({55,57,44},55)}
phase = _d({54,56,63,46},55)
end
function setNavNamed(name)
NavState = {mode = _d({55,42,54,46,45},55), name = name}
phase = _d({54,56,63,46},55)
end
local function setNavIdle()
NavState = {mode = _d({50,45,53,46},55)}
phase = _d({54,56,63,46},55)
end
local function hasArrived()
return phase == _d({49,56,63,46,59},55)
end
local function startNav()
phase = _d({54,56,63,46},55)
debug(_d({23,42,63,233,53,56,56,57,233,24,23},55))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({25,53,42,66,46,59,233,45,50,46,45,234,233,28,61,56,57,57,50,55,48,233,43,56,61,247},55))
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
debug(_d({25,53,42,66,46,59,233,50,60,233,61,56,56,233,47,42,59,233,47,59,56,54,233,61,42,59,48,46,61,233,241,7,251,249,249,249,233,60,61,62,45,60,242,247,233,21,50,52,46,53,66,233,59,46,60,57,42,64,55,46,45,233,42,61,233,53,56,43,43,66,247,233,28,61,56,57,57,50,55,48,233,43,56,61,247},55))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({40,40,57,59,46,63,25,56,60},55))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({21,42,59,48,46,233,57,56,60,50,61,50,56,55,233,51,62,54,57,233,45,46,61,46,44,61,46,45,3},55), delta, _d({60,61,62,45,60,247,233,57,59,46,63,25,56,60,6},55), prevPos, _d({55,46,64,25,56,60,6},55), pos)
end
end
force:SetAttribute(_d({40,40,57,59,46,63,25,56,60},55), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({54,56,63,46},55) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({49,56,63,46,59},55)
debug(_d({25,49,42,60,46,3,233,49,56,63,46,59},55))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({234,234,234,233,27,14,15,30,28,18,23,16,233,29,24,233,10,25,25,21,34,233,10,11,23,24,27,22,10,21,233,31,14,21,24,12,18,29,34,3},55), finalVel, _d({42,50,54,6},55), aim, _d({57,56,60,6},55), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({49,56,63,46,59},55) then
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
debug(_d({12,56,54,43,42,61,233,53,56,44,52,233,60,52,50,57,57,46,45,245},55), snapDist, _d({60,61,62,45,60,233,47,59,56,54,233,61,42,59,48,46,61,233,171,73,93,233,47,42,53,53,50,55,48,233,43,42,44,52,233,61,56,233,54,56,63,46},55))
phase = _d({54,56,63,46},55)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({17,46,42,59,61,43,46,42,61,233,46,59,59,56,59,3},55), err) end
end)
end
local function stopNav()
debug(_d({23,42,63,233,53,56,56,57,233,24,15,15},55))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({54,56,63,46},55)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({29,46,65,61,12,49,42,61,28,46,59,63,50,44,46},55))
local channels = TextChatService:FindFirstChild(_d({29,46,65,61,12,49,42,55,55,46,53,60},55))
local channel = channels and channels:FindFirstChild(_d({27,11,33,16,46,55,46,59,42,53},55))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({13,46,47,42,62,53,61,12,49,42,61,28,66,60,61,46,54,12,49,42,61,14,63,46,55,61,60},55))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({28,42,66,22,46,60,60,42,48,46,27,46,58,62,46,60,61},55))
if sayEvent then
sayEvent:FireServer(message, _d({10,53,53},55))
return
end
debug(_d({60,46,55,45,12,49,42,61,22,46,60,60,42,48,46,3,233,55,56,233,29,46,65,61,12,49,42,61,28,46,59,63,50,44,46,247,27,11,33,16,46,55,46,59,42,53,233,56,59,233,53,46,48,42,44,66,233,28,42,66,22,46,60,60,42,48,46,27,46,58,62,46,60,61,233,47,56,62,55,45,233,47,56,59},55), message)
end)
if not ok then debug(_d({60,46,55,45,12,49,42,61,22,46,60,60,42,48,46,233,46,59,59,56,59,3},55), err) end
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
debug(_d({23,56,61,233,54,42,52,50,55,48,233,57,59,56,48,59,46,60,60,233,61,56,64,42,59,45,233,55,42,63,233,61,42,59,48,46,61,233,47,56,59},55), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({60,233,246,233,60,46,55,45,50,55,48,233,248,62,55,60,61,62,44,52},55))
sendChatMessage(_d({248,62,55,60,61,62,44,52},55))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({64,42,50,61,30,55,61,50,53,10,59,59,50,63,46,45,233,61,50,54,46,56,62,61},55))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({55,42,63,29,56,25,56,50,55,61,12,56,55,47,50,59,54,46,45,3},55), label or _d({61,42,59,48,46,61},55), _d({246,233,45,50,45,233,55,56,61,233,42,59,59,50,63,46,233,64,50,61,49,50,55},55), timeout, _d({60,245,233,59,46,61,59,66,50,55,48,233,56,55,44,46},55))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({55,42,63,29,56,25,56,50,55,61,12,56,55,47,50,59,54,46,45,3},55), label or _d({61,42,59,48,46,61},55), _d({246,233,60,61,50,53,53,233,55,56,61,233,42,59,59,50,63,46,45,233,42,47,61,46,59,233,59,46,61,59,66,245,233,57,59,56,44,46,46,45,50,55,48,233,42,55,66,64,42,66},55))
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
if not ok then debug(_d({55,42,63,29,56,25,56,50,55,61,17,56,53,45,50,55,48,11,53,56,44,52,233,52,46,66,246,45,56,64,55,233,46,59,59,56,59,3},55), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({55,42,63,29,56,25,56,50,55,61,17,56,53,45,50,55,48,11,53,56,44,52,233,52,46,66,246,62,57,233,46,59,59,56,59,3},55), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({32,42,53,52,50,55,48,233,61,56,3},55), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({64,42,53,52,29,56,25,56,50,55,61,233,32,233,45,56,64,55,233,46,59,59,56,59,3},55), err) end
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
debug(_d({29,56,56,52,233,45,42,54,42,48,46,233,64,49,50,53,46,233,64,42,53,52,50,55,48,233,61,56,233,57,56,50,55,61,234,233,28,61,56,57,57,50,55,48,233,64,42,53,52,233,61,56,233,46,55,48,42,48,46,247},55))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({10,59,59,50,63,46,45,233,42,61,3},55), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({28,61,62,44,52,233,45,62,59,50,55,48,233,64,42,53,52,245,233,51,62,54,57,50,55,48,234},55))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({28,61,50,53,53,233,60,61,62,44,52,245,233,61,59,50,48,48,46,59,50,55,48,233,16,46,57,57,56,234},55))
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
debug(_d({22,56,63,50,55,48,233,61,56},55), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({32,42,50,61,50,55,48,233,47,56,59,233,23,25,12,60,233,61,56,233,60,57,42,64,55,233,42,61},55), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({233,233,60,57,42,64,55,233,44,49,46,44,52,3,233,47,56,53,45,46,59,233,46,65,50,60,61,60,233,6},55), folder ~= nil,
_d({245,233,44,49,50,53,45,59,46,55,233,6},55), folder and #folder:GetChildren() or 0,
_d({245,233,42,53,50,63,46,233,6},55), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({23,56,233,23,25,12,60,233,42,57,57,46,42,59,46,45,233,42,61},55), stageName, _d({42,47,61,46,59,233,250,254,60,245,233,54,56,63,50,55,48,233,56,55,233,42,55,66,64,42,66},55))
break
end
end
debug(_d({20,50,53,53,50,55,48,233,23,25,12,60,233,42,61},55), stageName)
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
debug(_d({27,46,61,62,59,55,50,55,48,233,61,56},55), stageName, _d({57,56,60,50,61,50,56,55,233,43,46,47,56,59,46,233,54,56,63,50,55,48,233,56,55},55))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({32,42,50,61,50,55,48,233,254,60,233,42,61},55), stageName, _d({57,56,60,50,61,50,56,55},55))
task.wait(5)
debug(_d({32,42,50,61,50,55,48,233,47,56,59},55), targetHP * 100, _d({238,233,17,25,233,43,46,47,56,59,46,233,54,56,63,50,55,48,233,61,56,233,55,46,65,61,233,60,61,42,48,46},55))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({44,53,46,42,59,46,45},55))
end
local function killNamedNPC(name, targetPos)
debug(_d({22,56,63,50,55,48,233,61,56},55), name)
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
debug(name, _d({45,46,47,46,42,61,46,45},55))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({17,62,54,42,55,56,50,45},55))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({21,46,56,233,57,53,42,66,46,45,233,42,55,50,54,42,61,50,56,55,3},55), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({53,46,56,10,55,50,54,21,56,48,48,46,59,233,57,59,50,55,61,233,46,59,59,56,59,3},55), err2) end
end)
end)
if not ok then debug(_d({60,61,42,59,61,21,46,56,10,55,50,54,21,56,48,48,46,59,233,46,59,59,56,59,3},55), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({22,56,63,50,55,48,233,61,56,233,21,46,56},55))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({21,46,56},55))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({21,46,56},55))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({21,46,56},55))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({21,46,56,233,44,42,60,61,50,55,48},55), which, _d({246,233,45,56,45,48,50,55,48},55))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({21,46,56,233,60,61,42,59,61,46,45,233,43,53,56,44,52,246,43,59,46,42,52,46,59,233,54,50,45,246,43,53,56,44,52,234,233,14,63,42,45,50,55,48,247,247,247},55))
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
if not getNPCByName(_d({21,46,56},55)) then
debug(_d({21,46,56,233,48,56,55,46,233,54,50,45,246,45,56,45,48,46,233,246,233,46,55,45,50,55,48,233,14,55,61,46,50,233,49,56,53,45,233,46,42,59,53,66},55))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({21,46,56},55)) then
setNavNamed(_d({21,46,56},55))
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
debug(_d({21,46,56,233,45,46,47,46,42,61,46,45},55))
stopLeoAnimLogger()
debug(_d({27,46,61,62,59,55,50,55,48,233,61,56,233,21,46,56,233,57,56,60,50,61,50,56,55,233,43,46,47,56,59,46,233,54,56,63,50,55,48,233,56,55},55))
navToPointConfirmed(COORDS.Leo, 30, _d({21,46,56,233,57,56,60,50,61,50,56,55},55))
debug(_d({32,42,50,61,50,55,48,233,254,60,233,42,61,233,21,46,56,233,57,56,60,50,61,50,56,55},55))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({22,56,63,50,55,48,233,61,56},55), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({12,56,62,53,45,233,55,56,61,233,47,50,55,45,233,60,61,42,61,62,46,233,54,56,45,46,53,233,55,46,42,59},55), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({10,61,61,42,44,52,50,55,48},55), coordKey, _d({64,50,61,49},55), weapon or _d({55,56,61,49,50,55,48,233,47,56,62,55,45},55))
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
debug(coordKey, _d({43,42,59,59,46,53,233,45,46,60,61,59,56,66,46,45},55))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({59,46,44,49,46,44,52,28,61,42,61,62,46,3},55), coordKey, _d({246,233,44,56,62,53,45,233,55,56,61,233,47,50,55,45,233,60,61,42,61,62,46,233,54,56,45,46,53,245,233,60,52,50,57,57,50,55,48},55))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({59,46,44,49,46,44,52,28,61,42,61,62,46,3},55), coordKey, _d({60,61,50,53,53,233,42,53,50,63,46,233,241,17,25},55), hp, _d({242,233,246,233,59,46,246,45,46,60,61,59,56,66,50,55,48},55))
destroyStatue(coordKey)
else
debug(_d({59,46,44,49,46,44,52,28,61,42,61,62,46,3},55), coordKey, _d({44,56,55,47,50,59,54,46,45,233,45,46,60,61,59,56,66,46,45},55))
end
end)
if not ok then debug(_d({59,46,44,49,46,44,52,28,61,42,61,62,46,233,46,59,59,56,59,3},55), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({22,56,63,50,55,48,233,61,56,233,26,62,46,46,55},55))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({12,62,57,50,45,233,26,62,46,46,55},55))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55))
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
debug(_d({26,62,46,46,55,233,46,55,61,46,59,46,45,233,57,49,42,60,46,233,251},55))
end
local function finishQueen()
debug(_d({15,50,55,50,60,49,50,55,48,233,26,62,46,46,55},55))
equipSwordOrMelee()
setNavNamed(_d({12,62,57,50,45,233,26,62,46,46,55},55))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({12,62,57,50,45,233,26,62,46,46,55},55))
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
debug(_d({26,62,46,46,55,233,45,46,47,46,42,61,46,45,247,233,25,53,42,55,233,44,56,54,57,53,46,61,46,247},55))
end
local CONFIRMATION_PROMPT_NAME = _d({12,56,55,47,50,59,54,42,61,50,56,55,25,59,56,54,57,61},55)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({27,46,54,56,61,46,14,63,46,55,61},55), 5)
end)
if ok then return result end
debug(_d({48,46,61,27,46,57,53,42,66,27,46,54,56,61,46,233,46,59,59,56,59,3},55), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({25,53,42,66,46,59,16,62,50},55))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({18,54,42,48,46,11,62,61,61,56,55},55)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({43,62,61,61,56,55,31,42,53,62,46},55)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({47,50,55,45,11,62,61,61,56,55,11,66,31,42,53,62,46,233,46,59,59,56,59,3},55), result)
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
if not ok then debug(_d({44,53,50,44,52,16,62,50,11,62,61,61,56,55,233,46,59,59,56,59,3},55), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({50,60,28,46,59,63,46,59},55))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({27,46,54,56,61,46,14,63,46,55,61},55))
or inst:FindFirstChild(_d({44,53,50,46,55,61,14,63,46,55,61},55))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({47,50,55,45,10,55,60,64,46,59,12,56,55,55,46,44,61,56,59,233,46,59,59,56,59,3},55), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({12,56,62,53,45,233,55,56,61,233,53,56,44,42,61,46,233,27,46,54,56,61,46,14,63,46,55,61,248,44,53,50,46,55,61,14,63,46,55,61,233,55,46,42,59,233,27,46,57,53,42,66,233,43,62,61,61,56,55,245,233,47,42,53,53,50,55,48,233,43,42,44,52,233,61,56,233,44,53,50,44,52},55))
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
debug(_d({47,50,59,46,27,46,57,53,42,66,31,42,53,62,46,233,46,59,59,56,59,3},55), err, _d({246,233,47,42,53,53,50,55,48,233,43,42,44,52,233,61,56,233,44,53,50,44,52},55))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({15,42,53,53,50,55,48,233,43,42,44,52,233,61,56,233,43,62,61,61,56,55,31,42,53,62,46,233,60,46,42,59,44,49,233,47,56,59,233,27,46,57,53,42,66},55))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({27,46,57,53,42,66,233,43,62,61,61,56,55,233,55,56,61,233,47,56,62,55,45,233,46,50,61,49,46,59,245,233,48,50,63,50,55,48,233,62,57},55))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({32,42,50,61,50,55,48,233,47,56,59,233,12,56,55,47,50,59,54,42,61,50,56,55,25,59,56,54,57,61,247,27,46,54,56,61,46,14,63,46,55,61},55))
local remote = getReplayRemote()
if not remote then
debug(_d({12,56,55,47,50,59,54,42,61,50,56,55,25,59,56,54,57,61,248,27,46,54,56,61,46,14,63,46,55,61,233,55,56,61,233,47,56,62,55,45,233,64,50,61,49,50,55,233,61,50,54,46,56,62,61},55))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({15,50,59,50,55,48,233,27,46,57,53,42,66,233,63,50,42,233,12,56,55,47,50,59,54,42,61,50,56,55,25,59,56,54,57,61,247,27,46,54,56,61,46,14,63,46,55,61},55))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({15,50,59,46,28,46,59,63,46,59,233,46,59,59,56,59,3},55), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({25,53,42,66,46,59,16,62,50},55), 10)
if not playerGui then
debug(_d({64,42,50,61,15,56,59,24,43,51,46,44,61,50,63,46,60,16,62,50,3,233,55,56,233,25,53,42,66,46,59,16,62,50,233,64,50,61,49,50,55,233,61,50,54,46,56,62,61,245,233,57,59,56,44,46,46,45,50,55,48,233,42,55,66,64,42,66},55))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({24,43,51,46,44,61,50,63,46,60,233,16,30,18,233,47,56,62,55,45,233,246,233,60,61,42,48,46,233,53,56,42,45,46,45},55))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({24,43,51,46,44,61,50,63,46,60,233,16,30,18,233,55,56,61,233,47,56,62,55,45,233,64,50,61,49,50,55,233,61,50,54,46,56,62,61,245,233,57,59,56,44,46,46,45,50,55,48,233,42,55,66,64,42,66},55))
return
end
end
end)
if not ok then debug(_d({64,42,50,61,15,56,59,24,43,51,46,44,61,50,63,46,60,16,62,50,233,46,59,59,56,59,3},55), err) end
end
local function runPlan()
debug(_d({25,53,42,55,233,60,61,42,59,61,46,45},55))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({28,61,42,59,61,50,55,48,233,55,42,63,233,53,56,56,57},55))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({57,56,60,233,249,247,251,60,233,10,15,29,14,27,233,60,61,42,59,61,23,42,63,3},55), rootAfter and rootAfter.Position)
end)
debug(_d({32,42,50,61,50,55,48,233,254,60,233,43,46,47,56,59,46,233,54,56,63,50,55,48,233,61,56,233,28,61,42,48,46,250},55))
task.wait(5)
for _, stage in ipairs({_d({28,61,42,48,46,250},55), _d({28,61,42,48,46,251},55), _d({28,61,42,48,46,252},55), _d({28,61,42,48,46,252,11},55)}) do
if not enabled then return end
local hpTarget = (stage == _d({28,61,42,48,46,252,11},55)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({22,56,63,50,55,48,233,61,56,233,42,59,59,56,64,233,47,53,66,246,45,56,64,55,233,42,59,46,42,233,241,12,62,57,50,45,233,27,42,50,55,242},55))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({13,56,45,48,50,55,48,233,42,59,59,56,64,233,59,42,50,55,233,50,55,233,42,233,60,58,62,42,59,46},55))
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
clearStage(_d({28,61,42,48,46,253},55))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({26,62,46,46,55,233,50,55,233,57,49,42,60,46,233,251,233,246,233,52,46,46,57,50,55,48,233,20,46,55,233,17,42,52,50,233,42,44,61,50,63,46,233,47,59,56,54,233,49,46,59,46,233,56,55},55))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({28,61,42,61,62,46,250},55))
if not enabled then return end
recheckStatue(_d({28,61,42,61,62,46,250},55))
destroyStatue(_d({28,61,42,61,62,46,251},55))
if not enabled then return end
recheckStatue(_d({28,61,42,61,62,46,250},55))
recheckStatue(_d({28,61,42,61,62,46,251},55))
destroyStatue(_d({28,61,42,61,62,46,252},55))
if not enabled then return end
recheckStatue(_d({28,61,42,61,62,46,252},55))
recheckStatue(_d({28,61,42,61,62,46,251},55))
recheckStatue(_d({28,61,42,61,62,46,250},55))
if not enabled then return end
debug(_d({32,42,50,61,50,55,48,233,47,56,59,233,57,49,42,60,46,233,251,233,61,56,233,46,55,45},55))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({25,49,42,60,46,233,251,233,46,55,45,233,64,42,50,61,233,61,50,54,46,56,62,61,245,233,57,59,56,44,46,46,45,50,55,48,233,42,55,66,64,42,66},55))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({22,56,63,50,55,48,233,43,42,44,52,233,61,56,233,26,62,46,46,55,233,60,61,42,48,46,233,57,56,60,50,61,50,56,55},55))
navToPointConfirmed(COORDS.Queen, 30, _d({26,62,46,46,55,233,60,61,42,48,46,233,57,56,60,50,61,50,56,55},55))
debug(_d({32,42,50,61,50,55,48,233,254,60,233,42,61,233,26,62,46,46,55,233,60,61,42,48,46,233,57,56,60,50,61,50,56,55},55))
task.wait(5)
if not enabled then return end
debug(_d({22,56,63,50,55,48,233,61,56,233,57,56,60,61,246,26,62,46,46,55,233,57,56,60,50,61,50,56,55},55))
navToPointConfirmed(COORDS.PostQueen, 30, _d({57,56,60,61,246,26,62,46,46,55,233,57,56,60,50,61,50,56,55},55))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({14,55,42,43,53,50,55,48,245,233,57,56,60,233,11,14,15,24,27,14,233,57,53,42,55,3},55), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({25,53,42,55,233,46,59,59,56,59,3},55), err2) end
end)
debug(_d({14,55,42,43,53,46,45,3},55), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({14,55,42,43,53,46,45,3},55), enabled)
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
if not ok then debug(_d({18,55,57,62,61,11,46,48,42,55,233,46,59,59,56,59,3},55), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({16,42,54,46,233,53,56,42,45,46,45,245,233,42,62,61,56,246,60,61,42,59,61,50,55,48,233,61,49,46,233,57,53,42,55},55))
enableBot()
end)
if not ok then debug(_d({10,62,61,56,60,61,42,59,61,233,46,59,59,56,59,3},55), err) end
end)
debug(_d({21,56,42,45,46,45,233,171,73,93,233,42,62,61,56,246,60,61,42,59,61,50,55,48,233,56,55,44,46,233,61,49,46,233,48,42,54,46,233,47,50,55,50,60,49,46,60,233,53,56,42,45,50,55,48,233,241,57,59,46,60,60,233,25,233,61,56,233,61,56,48,48,53,46,233,54,42,55,62,42,53,53,66,242},55))
end)()