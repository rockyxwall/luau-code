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
local Players            = game:GetService(_d({16,44,33,57,37,50,51},64))
local UserInputService    = game:GetService(_d({21,51,37,50,9,46,48,53,52,19,37,50,54,41,35,37},64))
local RunService          = game:GetService(_d({18,53,46,19,37,50,54,41,35,37},64))
local VIM                 = game:GetService(_d({22,41,50,52,53,33,44,9,46,48,53,52,13,33,46,33,39,37,50},64))
local ReplicatedStorage    = game:GetService(_d({18,37,48,44,41,35,33,52,37,36,19,52,47,50,33,39,37},64))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({27,2,47,51,51,2,47,52,29},64), _d({23,50,47,46,39,224,39,33,45,37,224,162,64,84,224,16,44,33,35,37,9,36,250},64), game.PlaceId, _d({21,46,41,54,37,50,51,37,9,36,250},64), game.GameId, _d({237,224,46,47,52,224,50,53,46,46,41,46,39},64))
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
local LEO_PILLAR_ANIM_ID   = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,245,242,244,244,241,244,241,243,242,247},64)
local LEO_ENTEI_ANIM_ID    = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,245,242,244,244,241,243,248,242,247,248},64)
local LEO_HIKEN_ANIM_ID    = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,245,242,242,240,249,241,247,244,240,247},64)
local LEO_FIREFLY_ANIM_ID  = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,245,242,242,240,242,243,246,241,245,244},64)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({15,34,42,37,35,52,41,54,37,51},64)
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
local REPLAY_BUTTON_VALUE   = _d({18,37,48,44,33,57},64)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({45,47,54,37},64)
local NavState   = {mode = _d({41,36,44,37},64)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({27,2,47,51,51,2,47,52,29},64), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
end)
if ok then return root end
debug(_d({39,37,52,18,47,47,52,224,37,50,50,47,50,250},64), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
end)
if ok then return hum end
debug(_d({39,37,52,8,53,45,33,46,47,41,36,224,37,50,50,47,50,250},64), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({31,31,8,47,54,37,50,1,52,52},64)) or Instance.new(_d({1,52,52,33,35,40,45,37,46,52},64))
att.Name = _d({31,31,8,47,54,37,50,1,52,52},64)
att.Parent = root
local force = root:FindFirstChild(_d({31,31,8,47,54,37,50,6,47,50,35,37},64))
if not force then
force = Instance.new(_d({12,41,46,37,33,50,22,37,44,47,35,41,52,57},64))
force.Name = _d({31,31,8,47,54,37,50,6,47,50,35,37},64)
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
debug(_d({39,37,52,15,50,3,50,37,33,52,37,6,47,50,35,37,224,37,50,50,47,50,250},64), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not root then return end
local force = root:FindFirstChild(_d({31,31,8,47,54,37,50,6,47,50,35,37},64))
local att   = root:FindFirstChild(_d({31,31,8,47,54,37,50,1,52,52},64))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({35,44,37,33,46,53,48,6,47,50,35,37,224,37,50,50,47,50,250},64), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({2,53,51,47,13,37,44,37,37},64)) ~= nil
end)
if ok then return result end
debug(_d({41,51,2,53,51,47,1,35,52,41,54,37,224,37,50,50,47,50,250},64), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({2,53,51,47},64))
end)
if not ok then debug(_d({33,35,52,41,54,33,52,37,2,53,51,47,224,37,50,50,47,50,250},64), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({2,53,51,47,224,46,47,52,224,33,35,52,41,54,37,236,224,33,35,52,41,54,33,52,41,46,39},64))
activateBuso()
end
end)
if not ok then debug(_d({2,53,51,47,11,37,37,48,37,50,224,37,50,50,47,50,250},64), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({2,53,51,47,224,43,37,37,48,37,50,224,51,52,47,48,48,37,36},64))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({11,37,46,8,33,43,41},64)) ~= nil
end)
if ok then return result end
debug(_d({41,51,11,37,46,1,35,52,41,54,37,224,37,50,50,47,50,250},64), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({11,37,46},64), true)
end)
if not ok then debug(_d({33,35,52,41,54,33,52,37,11,37,46,224,37,50,50,47,50,250},64), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({11,37,46,224,46,47,52,224,33,35,52,41,54,37,236,224,33,35,52,41,54,33,52,41,46,39},64))
activateKen()
end
end)
if not ok then debug(_d({11,37,46,11,37,37,48,37,50,224,37,50,50,47,50,250},64), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({11,37,46,224,43,37,37,48,37,50,224,51,52,47,48,48,37,36},64))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({14,16,3,51},64)) end)
if ok then return folder end
debug(_d({39,37,52,14,16,3,51,6,47,44,36,37,50,224,37,50,50,47,50,250},64), folder)
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
local r = model:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local h = model:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
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
debug(_d({39,37,52,14,37,33,50,37,51,52,14,16,3,224,37,50,50,47,50,250},64), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
local hum  = model:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({39,37,52,14,16,3,2,57,14,33,45,37,224,37,50,50,47,50,250},64), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({46,48,35,51,18,37,45,33,41,46,41,46,39,224,37,50,50,47,50,250},64), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({3,53,48,41,36,224,17,53,37,37,46},64))
return queen ~= nil and queen:FindFirstChild(_d({45,47,52,41,47,46,12,37,51,51},64)) ~= nil
end)
if ok then return result end
debug(_d({41,51,17,53,37,37,46,16,40,33,51,37,242,224,37,50,50,47,50,250},64), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,241,242,241,242,249,247,249,244,242,242,249,242,247,246,249},64)
local QUEEN_GRASP_ANIM_ID   = _d({50,34,56,33,51,51,37,52,41,36,250,239,239,241,242,249,248,240,240,240,246,241,240,240,241,247,243,244},64)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
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
debug(_d({41,51,16,44,33,57,41,46,39,1,46,41,45,6,50,47,45,12,41,51,52,224,37,50,50,47,50,250},64), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({2,44,47,35,43,41,46,39},64)) ~= nil
end)
if ok then return result end
debug(_d({41,51,14,16,3,2,44,47,35,43,41,46,39,224,37,50,50,47,50,250},64), result)
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
debug(_d({48,50,37,36,41,35,52,14,16,3,16,47,51,41,52,41,47,46,224,37,50,50,47,50,250},64), result)
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
debug(_d({14,47,224,36,33,45,33,39,37,224,47,46},64), model.Name, _d({38,47,50},64), NPC_STUCK_TIMEOUT, _d({51,224,237,224,51,55,41,52,35,40,41,46,39,224,52,33,50,39,37,52},64))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({52,50,33,35,43,14,16,3,4,33,45,33,39,37,224,37,50,50,47,50,250},64), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({13,47,36,37,44},64)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({2,33,51,37,16,33,50,52},64)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({39,37,52,13,47,36,37,44,6,33,35,37,16,47,51,224,37,50,50,47,50,250},64), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({5,46,54},64))
local folder = env and env:FindFirstChild(_d({19,52,33,52,53,37,51},64))
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
debug(_d({39,37,52,19,52,33,52,53,37,13,47,36,37,44,14,37,33,50,224,37,50,50,47,50,250},64), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({34,33,50,50,37,44,8,16},64))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({39,37,52,19,52,33,52,53,37,8,16,224,37,50,50,47,50,250},64), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({20,47,47,44},64)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({38,41,46,36,20,47,47,44,2,57,1,52,52,50,41,34,53,52,37,224,37,50,50,47,50,250},64), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({20,47,47,44},64)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({38,41,46,36,20,47,47,44,2,57,14,33,45,37,224,37,50,50,47,50,250},64), tool)
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
if not ok then debug(_d({37,49,53,41,48,20,47,47,44,224,37,50,50,47,50,250},64), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({2,33,35,43,48,33,35,43},64))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({20,47,47,44},64)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({38,41,46,36,20,47,47,44,2,57,3,40,41,44,36,14,33,45,37,224,37,50,50,47,50,250},64), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({19,55,47,50,36,5,49,53,41,48},64))
if sword then
equipTool(sword)
return _d({51,55,47,50,36},64)
end
local melee = findToolByAttribute(_d({13,37,44,37,37,20,47,47,44},64))
if melee then
equipTool(melee)
return _d({45,37,44,37,37},64)
end
debug(_d({14,47,224,51,55,47,50,36,224,47,50,224,45,37,44,37,37,224,52,47,47,44,224,38,47,53,46,36},64))
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
if not ok then debug(_d({35,44,41,35,43,13,241,224,37,50,50,47,50,250},64), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({8,53,45,33,46,47,41,36,18,47,47,52,16,33,50,52},64))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({19,52,33,52,51},64) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({18,47,43,53,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({7,37,48,48,47},64), args)
elseif style == _d({2,44,33,35,43,12,37,39},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43},64), args)
elseif style == _d({11,33,45,41,51,40,41,43,41},64) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({11,33,45,41,51,40,41,43,41,7,37,48,48,47},64), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,43,57,224,23,33,44,43,242},64), args)
end
end)
if not ok then debug(_d({41,46,54,47,43,37,7,37,48,48,47,224,37,50,50,47,50,250},64), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({48,50,37,51,51,19,43,41,44,44,18,224,37,50,50,47,50,250},64), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({40,47,44,36,2,44,47,35,43,224,37,50,50,47,50,250},64), err) end
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
if not ok then debug(_d({40,47,44,36,2,44,47,35,43,23,40,41,44,37,224,37,50,50,47,50,250},64), err) end
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
debug(_d({39,37,52,7,33,45,37,7,224,37,50,50,47,50,250},64), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({41,51,18,37,33,44,13,241,2,53,51,57,224,37,50,50,47,50,250},64), result)
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
return char ~= nil and char:FindFirstChild(_d({51,52,53,46},64)) ~= nil
end)
if ok then return result end
debug(_d({41,51,19,52,53,46,46,37,36,224,37,50,50,47,50,250},64), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({48,50,37,51,51,19,52,53,46,2,50,37,33,43,224,37,50,50,47,50,250},64), err) end
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
navToPoint(myPos + Vector3.new(0, QUEEN_DODGE_DISTANCE, 0), true)
local t = 0
local sinceGeppo = 0
local geppoCount = 1
while enabled do
if isStunned() then pressStunBreak() end
info = getInfoFn()
if not info then
debug(_d({49,53,37,37,46,4,47,36,39,37,21,46,52,41,44,19,33,38,37,250,224,17,53,37,37,46,224,39,47,46,37,224,237,224,37,46,36,41,46,39,224,36,47,36,39,37,224,37,33,50,44,57},64))
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
if geppoCount < 4 then
invokeGeppo()
geppoCount += 1
end
sinceGeppo = 0
end
if t > 15 then
debug(_d({49,53,37,37,46,4,47,36,39,37,21,46,52,41,44,19,33,38,37,224,51,33,38,37,52,57,224,52,41,45,37,47,53,52},64))
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
local info = getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({17,53,37,37,46,224,35,33,51,52,41,46,39,224,36,37,52,37,35,52,37,36,224,237,224,36,47,36,39,41,46,39,224,232,55,33,52,35,40,37,50,233},64))
queenDodgeUntilSafe(function() return getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64)) end)
if enabled and getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64)) then
setNavNamed(_d({3,53,48,41,36,224,17,53,37,37,46},64))
end
queenDodging = false
end
end)
if not ok then debug(_d({49,53,37,37,46,4,47,36,39,37,23,33,52,35,40,37,50,224,37,50,50,47,50,250},64), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({48,47,41,46,52},64) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({46,48,35},64) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({46,33,45,37,36},64) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({39,37,52,14,33,54,20,33,50,39,37,52,51,224,37,50,50,47,50,250},64), aimR)
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
debug(_d({35,47,45,48,53,52,37,12,47,35,43,37,36,3,6,50,33,45,37,224,37,50,50,47,50,250},64), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({48,47,41,46,52},64), point = pos}
phase = _d({45,47,54,37},64)
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
if not ok then debug(_d({46,33,54,20,47,16,47,41,46,52,224,39,37,48,48,47,224,35,40,37,35,43,224,37,50,50,47,50,250},64), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({46,48,35},64)}
phase = _d({45,47,54,37},64)
end
function setNavNamed(name)
NavState = {mode = _d({46,33,45,37,36},64), name = name}
phase = _d({45,47,54,37},64)
end
local function setNavIdle()
NavState = {mode = _d({41,36,44,37},64)}
phase = _d({45,47,54,37},64)
end
local function hasArrived()
return phase == _d({40,47,54,37,50},64)
end
local function startNav()
phase = _d({45,47,54,37},64)
debug(_d({14,33,54,224,44,47,47,48,224,15,14},64))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({16,44,33,57,37,50,224,36,41,37,36,225,224,19,52,47,48,48,41,46,39,224,34,47,52,238},64))
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
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({31,31,48,50,37,54,16,47,51},64))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({12,33,50,39,37,224,48,47,51,41,52,41,47,46,224,42,53,45,48,224,36,37,52,37,35,52,37,36,250},64), delta, _d({51,52,53,36,51,238,224,48,50,37,54,16,47,51,253},64), prevPos, _d({46,37,55,16,47,51,253},64), pos)
end
end
force:SetAttribute(_d({31,31,48,50,37,54,16,47,51},64), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({45,47,54,37},64) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({40,47,54,37,50},64)
debug(_d({16,40,33,51,37,250,224,40,47,54,37,50},64))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({225,225,225,224,18,5,6,21,19,9,14,7,224,20,15,224,1,16,16,12,25,224,1,2,14,15,18,13,1,12,224,22,5,12,15,3,9,20,25,250},64), finalVel, _d({33,41,45,253},64), aim, _d({48,47,51,253},64), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({40,47,54,37,50},64) then
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
debug(_d({3,47,45,34,33,52,224,44,47,35,43,224,51,43,41,48,48,37,36,236},64), snapDist, _d({51,52,53,36,51,224,38,50,47,45,224,52,33,50,39,37,52,224,162,64,84,224,38,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,45,47,54,37},64))
phase = _d({45,47,54,37},64)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({8,37,33,50,52,34,37,33,52,224,37,50,50,47,50,250},64), err) end
end)
end
local function stopNav()
debug(_d({14,33,54,224,44,47,47,48,224,15,6,6},64))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({45,47,54,37},64)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({20,37,56,52,3,40,33,52,19,37,50,54,41,35,37},64))
local channels = TextChatService:FindFirstChild(_d({20,37,56,52,3,40,33,46,46,37,44,51},64))
local channel = channels and channels:FindFirstChild(_d({18,2,24,7,37,46,37,50,33,44},64))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({4,37,38,33,53,44,52,3,40,33,52,19,57,51,52,37,45,3,40,33,52,5,54,37,46,52,51},64))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({19,33,57,13,37,51,51,33,39,37,18,37,49,53,37,51,52},64))
if sayEvent then
sayEvent:FireServer(message, _d({1,44,44},64))
return
end
debug(_d({51,37,46,36,3,40,33,52,13,37,51,51,33,39,37,250,224,46,47,224,20,37,56,52,3,40,33,52,19,37,50,54,41,35,37,238,18,2,24,7,37,46,37,50,33,44,224,47,50,224,44,37,39,33,35,57,224,19,33,57,13,37,51,51,33,39,37,18,37,49,53,37,51,52,224,38,47,53,46,36,224,38,47,50},64), message)
end)
if not ok then debug(_d({51,37,46,36,3,40,33,52,13,37,51,51,33,39,37,224,37,50,50,47,50,250},64), err) end
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
debug(_d({14,47,52,224,45,33,43,41,46,39,224,48,50,47,39,50,37,51,51,224,52,47,55,33,50,36,224,46,33,54,224,52,33,50,39,37,52,224,38,47,50},64), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({51,224,237,224,51,37,46,36,41,46,39,224,239,53,46,51,52,53,35,43},64))
sendChatMessage(_d({239,53,46,51,52,53,35,43},64))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({55,33,41,52,21,46,52,41,44,1,50,50,41,54,37,36,224,52,41,45,37,47,53,52},64))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({46,33,54,20,47,16,47,41,46,52,3,47,46,38,41,50,45,37,36,250},64), label or _d({52,33,50,39,37,52},64), _d({237,224,36,41,36,224,46,47,52,224,33,50,50,41,54,37,224,55,41,52,40,41,46},64), timeout, _d({51,236,224,50,37,52,50,57,41,46,39,224,47,46,35,37},64))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({46,33,54,20,47,16,47,41,46,52,3,47,46,38,41,50,45,37,36,250},64), label or _d({52,33,50,39,37,52},64), _d({237,224,51,52,41,44,44,224,46,47,52,224,33,50,50,41,54,37,36,224,33,38,52,37,50,224,50,37,52,50,57,236,224,48,50,47,35,37,37,36,41,46,39,224,33,46,57,55,33,57},64))
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
if not ok then debug(_d({46,33,54,20,47,16,47,41,46,52,8,47,44,36,41,46,39,2,44,47,35,43,224,43,37,57,237,36,47,55,46,224,37,50,50,47,50,250},64), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({46,33,54,20,47,16,47,41,46,52,8,47,44,36,41,46,39,2,44,47,35,43,224,43,37,57,237,53,48,224,37,50,50,47,50,250},64), err2) end
end
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({23,33,44,43,41,46,39,224,52,47,250},64), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({55,33,44,43,20,47,16,47,41,46,52,224,23,224,36,47,55,46,224,37,50,50,47,50,250},64), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({1,50,50,41,54,37,36,224,33,52,250},64), pos)
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
if wasNavActive and enabled then
startNav()
end
end
local function clearStage(stageName)
debug(_d({13,47,54,41,46,39,224,52,47},64), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({23,33,41,52,41,46,39,224,38,47,50,224,14,16,3,51,224,52,47,224,51,48,33,55,46,224,33,52},64), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({224,224,51,48,33,55,46,224,35,40,37,35,43,250,224,38,47,44,36,37,50,224,37,56,41,51,52,51,224,253},64), folder ~= nil,
_d({236,224,35,40,41,44,36,50,37,46,224,253},64), folder and #folder:GetChildren() or 0,
_d({236,224,33,44,41,54,37,224,253},64), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({14,47,224,14,16,3,51,224,33,48,48,37,33,50,37,36,224,33,52},64), stageName, _d({33,38,52,37,50,224,241,245,51,236,224,45,47,54,41,46,39,224,47,46,224,33,46,57,55,33,57},64))
break
end
end
debug(_d({11,41,44,44,41,46,39,224,14,16,3,51,224,33,52},64), stageName)
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
debug(_d({18,37,52,53,50,46,41,46,39,224,52,47},64), stageName, _d({48,47,51,41,52,41,47,46,224,34,37,38,47,50,37,224,45,47,54,41,46,39,224,47,46},64))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({23,33,41,52,41,46,39,224,245,51,224,33,52},64), stageName, _d({48,47,51,41,52,41,47,46},64))
task.wait(5)
debug(_d({23,33,41,52,41,46,39,224,38,47,50,224,249,245,229,224,8,16,224,34,37,38,47,50,37,224,45,47,54,41,46,39,224,52,47,224,46,37,56,52,224,51,52,33,39,37},64))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * 0.95 do
task.wait(1)
end
end
debug(stageName, _d({35,44,37,33,50,37,36},64))
end
local function killNamedNPC(name, targetPos)
debug(_d({13,47,54,41,46,39,224,52,47},64), name)
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
debug(name, _d({36,37,38,37,33,52,37,36},64))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({8,53,45,33,46,47,41,36},64))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({12,37,47,224,48,44,33,57,37,36,224,33,46,41,45,33,52,41,47,46,250},64), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({44,37,47,1,46,41,45,12,47,39,39,37,50,224,48,50,41,46,52,224,37,50,50,47,50,250},64), err2) end
end)
end)
if not ok then debug(_d({51,52,33,50,52,12,37,47,1,46,41,45,12,47,39,39,37,50,224,37,50,50,47,50,250},64), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({13,47,54,41,46,39,224,52,47,224,12,37,47},64))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({12,37,47},64))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({12,37,47},64))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({12,37,47},64))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({12,37,47,224,35,33,51,52,41,46,39},64), which, _d({237,224,36,47,36,39,41,46,39},64))
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
if not getNPCByName(_d({12,37,47},64)) then
debug(_d({12,37,47,224,39,47,46,37,224,45,41,36,237,36,47,36,39,37,224,237,224,37,46,36,41,46,39,224,5,46,52,37,41,224,40,47,44,36,224,37,33,50,44,57},64))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({12,37,47},64)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({12,37,47,224,39,47,46,37,224,45,41,36,237,36,47,36,39,37,224,237,224,37,46,36,41,46,39,224,6,44,33,45,37,224,16,41,44,44,33,50,224,40,47,44,36,224,37,33,50,44,57},64))
end
end
end
if enabled and getNPCByName(_d({12,37,47},64)) then
setNavNamed(_d({12,37,47},64))
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
debug(_d({12,37,47,224,36,37,38,37,33,52,37,36},64))
stopLeoAnimLogger()
debug(_d({18,37,52,53,50,46,41,46,39,224,52,47,224,12,37,47,224,48,47,51,41,52,41,47,46,224,34,37,38,47,50,37,224,45,47,54,41,46,39,224,47,46},64))
navToPointConfirmed(COORDS.Leo, 30, _d({12,37,47,224,48,47,51,41,52,41,47,46},64))
debug(_d({23,33,41,52,41,46,39,224,245,51,224,33,52,224,12,37,47,224,48,47,51,41,52,41,47,46},64))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({13,47,54,41,46,39,224,52,47},64), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({3,47,53,44,36,224,46,47,52,224,38,41,46,36,224,51,52,33,52,53,37,224,45,47,36,37,44,224,46,37,33,50},64), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({1,52,52,33,35,43,41,46,39},64), coordKey, _d({55,41,52,40},64), weapon or _d({46,47,52,40,41,46,39,224,38,47,53,46,36},64))
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
debug(coordKey, _d({34,33,50,50,37,44,224,36,37,51,52,50,47,57,37,36},64))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({50,37,35,40,37,35,43,19,52,33,52,53,37,250},64), coordKey, _d({237,224,35,47,53,44,36,224,46,47,52,224,38,41,46,36,224,51,52,33,52,53,37,224,45,47,36,37,44,236,224,51,43,41,48,48,41,46,39},64))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({50,37,35,40,37,35,43,19,52,33,52,53,37,250},64), coordKey, _d({51,52,41,44,44,224,33,44,41,54,37,224,232,8,16},64), hp, _d({233,224,237,224,50,37,237,36,37,51,52,50,47,57,41,46,39},64))
destroyStatue(coordKey)
else
debug(_d({50,37,35,40,37,35,43,19,52,33,52,53,37,250},64), coordKey, _d({35,47,46,38,41,50,45,37,36,224,36,37,51,52,50,47,57,37,36},64))
end
end)
if not ok then debug(_d({50,37,35,40,37,35,43,19,52,33,52,53,37,224,37,50,50,47,50,250},64), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({13,47,54,41,46,39,224,52,47,224,17,53,37,37,46},64))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({3,53,48,41,36,224,17,53,37,37,46},64))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64))
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
debug(_d({17,53,37,37,46,224,37,46,52,37,50,37,36,224,48,40,33,51,37,224,242},64))
end
local function finishQueen()
debug(_d({6,41,46,41,51,40,41,46,39,224,17,53,37,37,46},64))
equipSwordOrMelee()
setNavNamed(_d({3,53,48,41,36,224,17,53,37,37,46},64))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({3,53,48,41,36,224,17,53,37,37,46},64))
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
debug(_d({17,53,37,37,46,224,36,37,38,37,33,52,37,36,238,224,16,44,33,46,224,35,47,45,48,44,37,52,37,238},64))
end
local CONFIRMATION_PROMPT_NAME = _d({3,47,46,38,41,50,45,33,52,41,47,46,16,50,47,45,48,52},64)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({18,37,45,47,52,37,5,54,37,46,52},64), 5)
end)
if ok then return result end
debug(_d({39,37,52,18,37,48,44,33,57,18,37,45,47,52,37,224,37,50,50,47,50,250},64), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({16,44,33,57,37,50,7,53,41},64))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({9,45,33,39,37,2,53,52,52,47,46},64)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({34,53,52,52,47,46,22,33,44,53,37},64)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({38,41,46,36,2,53,52,52,47,46,2,57,22,33,44,53,37,224,37,50,50,47,50,250},64), result)
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
if not ok then debug(_d({35,44,41,35,43,7,53,41,2,53,52,52,47,46,224,37,50,50,47,50,250},64), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({41,51,19,37,50,54,37,50},64))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({18,37,45,47,52,37,5,54,37,46,52},64))
or inst:FindFirstChild(_d({35,44,41,37,46,52,5,54,37,46,52},64))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({38,41,46,36,1,46,51,55,37,50,3,47,46,46,37,35,52,47,50,224,37,50,50,47,50,250},64), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({3,47,53,44,36,224,46,47,52,224,44,47,35,33,52,37,224,18,37,45,47,52,37,5,54,37,46,52,239,35,44,41,37,46,52,5,54,37,46,52,224,46,37,33,50,224,18,37,48,44,33,57,224,34,53,52,52,47,46,236,224,38,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,35,44,41,35,43},64))
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
debug(_d({38,41,50,37,18,37,48,44,33,57,22,33,44,53,37,224,37,50,50,47,50,250},64), err, _d({237,224,38,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,35,44,41,35,43},64))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({6,33,44,44,41,46,39,224,34,33,35,43,224,52,47,224,34,53,52,52,47,46,22,33,44,53,37,224,51,37,33,50,35,40,224,38,47,50,224,18,37,48,44,33,57},64))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({18,37,48,44,33,57,224,34,53,52,52,47,46,224,46,47,52,224,38,47,53,46,36,224,37,41,52,40,37,50,236,224,39,41,54,41,46,39,224,53,48},64))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({23,33,41,52,41,46,39,224,38,47,50,224,3,47,46,38,41,50,45,33,52,41,47,46,16,50,47,45,48,52,238,18,37,45,47,52,37,5,54,37,46,52},64))
local remote = getReplayRemote()
if not remote then
debug(_d({3,47,46,38,41,50,45,33,52,41,47,46,16,50,47,45,48,52,239,18,37,45,47,52,37,5,54,37,46,52,224,46,47,52,224,38,47,53,46,36,224,55,41,52,40,41,46,224,52,41,45,37,47,53,52},64))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({6,41,50,41,46,39,224,18,37,48,44,33,57,224,54,41,33,224,3,47,46,38,41,50,45,33,52,41,47,46,16,50,47,45,48,52,238,18,37,45,47,52,37,5,54,37,46,52},64))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({6,41,50,37,19,37,50,54,37,50,224,37,50,50,47,50,250},64), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({16,44,33,57,37,50,7,53,41},64), 10)
if not playerGui then
debug(_d({55,33,41,52,6,47,50,15,34,42,37,35,52,41,54,37,51,7,53,41,250,224,46,47,224,16,44,33,57,37,50,7,53,41,224,55,41,52,40,41,46,224,52,41,45,37,47,53,52,236,224,48,50,47,35,37,37,36,41,46,39,224,33,46,57,55,33,57},64))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({15,34,42,37,35,52,41,54,37,51,224,7,21,9,224,38,47,53,46,36,224,237,224,51,52,33,39,37,224,44,47,33,36,37,36},64))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({15,34,42,37,35,52,41,54,37,51,224,7,21,9,224,46,47,52,224,38,47,53,46,36,224,55,41,52,40,41,46,224,52,41,45,37,47,53,52,236,224,48,50,47,35,37,37,36,41,46,39,224,33,46,57,55,33,57},64))
return
end
end
end)
if not ok then debug(_d({55,33,41,52,6,47,50,15,34,42,37,35,52,41,54,37,51,7,53,41,224,37,50,50,47,50,250},64), err) end
end
local function runPlan()
debug(_d({16,44,33,46,224,51,52,33,50,52,37,36},64))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({19,52,33,50,52,41,46,39,224,46,33,54,224,44,47,47,48},64))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({48,47,51,224,240,238,242,51,224,1,6,20,5,18,224,51,52,33,50,52,14,33,54,250},64), rootAfter and rootAfter.Position)
end)
debug(_d({23,33,41,52,41,46,39,224,245,51,224,34,37,38,47,50,37,224,45,47,54,41,46,39,224,52,47,224,19,52,33,39,37,241},64))
task.wait(5)
for _, stage in ipairs({_d({19,52,33,39,37,241},64), _d({19,52,33,39,37,242},64), _d({19,52,33,39,37,243},64), _d({19,52,33,39,37,243,2},64)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({13,47,54,41,46,39,224,52,47,224,33,50,50,47,55,224,38,44,57,237,36,47,55,46,224,33,50,37,33},64))
walkToPoint(COORDS.ArrowFlyDown, 30)
debug(_d({4,47,36,39,41,46,39,224,33,50,50,47,55,224,50,33,41,46,224,41,46,224,33,224,51,49,53,33,50,37},64))
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
clearStage(_d({19,52,33,39,37,244},64))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({17,53,37,37,46,224,41,46,224,48,40,33,51,37,224,242,224,237,224,43,37,37,48,41,46,39,224,11,37,46,224,8,33,43,41,224,33,35,52,41,54,37,224,38,50,47,45,224,40,37,50,37,224,47,46},64))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({19,52,33,52,53,37,241},64))
if not enabled then return end
recheckStatue(_d({19,52,33,52,53,37,241},64))
destroyStatue(_d({19,52,33,52,53,37,242},64))
if not enabled then return end
recheckStatue(_d({19,52,33,52,53,37,241},64))
recheckStatue(_d({19,52,33,52,53,37,242},64))
destroyStatue(_d({19,52,33,52,53,37,243},64))
if not enabled then return end
recheckStatue(_d({19,52,33,52,53,37,243},64))
recheckStatue(_d({19,52,33,52,53,37,242},64))
recheckStatue(_d({19,52,33,52,53,37,241},64))
if not enabled then return end
debug(_d({23,33,41,52,41,46,39,224,38,47,50,224,48,40,33,51,37,224,242,224,52,47,224,37,46,36},64))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({16,40,33,51,37,224,242,224,37,46,36,224,55,33,41,52,224,52,41,45,37,47,53,52,236,224,48,50,47,35,37,37,36,41,46,39,224,33,46,57,55,33,57},64))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({13,47,54,41,46,39,224,34,33,35,43,224,52,47,224,17,53,37,37,46,224,51,52,33,39,37,224,48,47,51,41,52,41,47,46},64))
navToPointConfirmed(COORDS.Queen, 30, _d({17,53,37,37,46,224,51,52,33,39,37,224,48,47,51,41,52,41,47,46},64))
debug(_d({23,33,41,52,41,46,39,224,245,51,224,33,52,224,17,53,37,37,46,224,51,52,33,39,37,224,48,47,51,41,52,41,47,46},64))
task.wait(5)
if not enabled then return end
debug(_d({13,47,54,41,46,39,224,52,47,224,48,47,51,52,237,17,53,37,37,46,224,48,47,51,41,52,41,47,46},64))
navToPointConfirmed(COORDS.PostQueen, 30, _d({48,47,51,52,237,17,53,37,37,46,224,48,47,51,41,52,41,47,46},64))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({5,46,33,34,44,41,46,39,236,224,48,47,51,224,2,5,6,15,18,5,224,48,44,33,46,250},64), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({16,44,33,46,224,37,50,50,47,50,250},64), err2) end
end)
debug(_d({5,46,33,34,44,37,36,250},64), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({5,46,33,34,44,37,36,250},64), enabled)
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
if not ok then debug(_d({9,46,48,53,52,2,37,39,33,46,224,37,50,50,47,50,250},64), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({7,33,45,37,224,44,47,33,36,37,36,236,224,33,53,52,47,237,51,52,33,50,52,41,46,39,224,52,40,37,224,48,44,33,46},64))
enableBot()
end)
if not ok then debug(_d({1,53,52,47,51,52,33,50,52,224,37,50,50,47,50,250},64), err) end
end)
debug(_d({12,47,33,36,37,36,224,162,64,84,224,33,53,52,47,237,51,52,33,50,52,41,46,39,224,47,46,35,37,224,52,40,37,224,39,33,45,37,224,38,41,46,41,51,40,37,51,224,44,47,33,36,41,46,39,224,232,48,50,37,51,51,224,16,224,52,47,224,52,47,39,39,44,37,224,45,33,46,53,33,44,44,57,233},64))
end)()