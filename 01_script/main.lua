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
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({24,52,41,65,45,58,59},56))
local UserInputService    = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local RunService          = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local VIM                 = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local ReplicatedStorage    = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)) then
Core = loadstring(readfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
else
Core = loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
end
end)
if not Core then warn(_d({35,11,55,58,45,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
local Safeguard = Core.GetSafeguard()
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
local LEO_PILLAR_ANIM_ID   = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,253,250,252,252,249,252,249,251,250,255},56)
local LEO_ENTEI_ANIM_ID    = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,253,250,252,252,249,251,0,250,255,0},56)
local LEO_HIKEN_ANIM_ID    = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,253,250,250,248,1,249,255,252,248,255},56)
local LEO_FIREFLY_ANIM_ID  = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,253,250,250,248,250,251,254,249,253,252},56)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({23,42,50,45,43,60,49,62,45,59},56)
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
local REPLAY_BUTTON_VALUE   = _d({26,45,56,52,41,65},56)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({53,55,62,45},56)
local NavState   = {mode = _d({49,44,52,45},56)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({35,10,55,59,59,10,55,60,37},56), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end)
if ok then return root end
debug(_d({47,45,60,26,55,55,60,232,45,58,58,55,58,2},56), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
end)
if ok then return hum end
debug(_d({47,45,60,16,61,53,41,54,55,49,44,232,45,58,58,55,58,2},56), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({39,39,16,55,62,45,58,9,60,60},56)) or Instance.new(_d({9,60,60,41,43,48,53,45,54,60},56))
att.Name = _d({39,39,16,55,62,45,58,9,60,60},56)
att.Parent = root
local force = root:FindFirstChild(_d({39,39,16,55,62,45,58,14,55,58,43,45},56))
if not force then
force = Instance.new(_d({20,49,54,45,41,58,30,45,52,55,43,49,60,65},56))
force.Name = _d({39,39,16,55,62,45,58,14,55,58,43,45},56)
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
debug(_d({47,45,60,23,58,11,58,45,41,60,45,14,55,58,43,45,232,45,58,58,55,58,2},56), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local force = root:FindFirstChild(_d({39,39,16,55,62,45,58,14,55,58,43,45},56))
local att   = root:FindFirstChild(_d({39,39,16,55,62,45,58,9,60,60},56))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({43,52,45,41,54,61,56,14,55,58,43,45,232,45,58,58,55,58,2},56), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({10,61,59,55,21,45,52,45,45},56)) ~= nil
end)
if ok then return result end
debug(_d({49,59,10,61,59,55,9,43,60,49,62,45,232,45,58,58,55,58,2},56), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({10,61,59,55},56))
end)
if not ok then debug(_d({41,43,60,49,62,41,60,45,10,61,59,55,232,45,58,58,55,58,2},56), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({10,61,59,55,232,54,55,60,232,41,43,60,49,62,45,244,232,41,43,60,49,62,41,60,49,54,47},56))
activateBuso()
end
end)
if not ok then debug(_d({10,61,59,55,19,45,45,56,45,58,232,45,58,58,55,58,2},56), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({10,61,59,55,232,51,45,45,56,45,58,232,59,60,55,56,56,45,44},56))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({19,45,54,16,41,51,49},56)) ~= nil
end)
if ok then return result end
debug(_d({49,59,19,45,54,9,43,60,49,62,45,232,45,58,58,55,58,2},56), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({19,45,54},56), true)
end)
if not ok then debug(_d({41,43,60,49,62,41,60,45,19,45,54,232,45,58,58,55,58,2},56), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({19,45,54,232,54,55,60,232,41,43,60,49,62,45,244,232,41,43,60,49,62,41,60,49,54,47},56))
activateKen()
end
end)
if not ok then debug(_d({19,45,54,19,45,45,56,45,58,232,45,58,58,55,58,2},56), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({19,45,54,232,51,45,45,56,45,58,232,59,60,55,56,56,45,44},56))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({22,24,11,59},56)) end)
if ok then return folder end
debug(_d({47,45,60,22,24,11,59,14,55,52,44,45,58,232,45,58,58,55,58,2},56), folder)
return nil
end
local function getNearestNPC(exclude)
local ok, result = pcall(function()
local root = Core.GetRoot(LocalPlayer)
local folder = getNPCsFolder()
if not root or not folder then return nil end
local nearest, nearestDist = nil, math.huge
local fallbackNearest, fallbackDist = nil, math.huge
for _, model in ipairs(folder:GetChildren()) do
local okp, info = pcall(function()
local r = model:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local h = model:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
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
debug(_d({47,45,60,22,45,41,58,45,59,60,22,24,11,232,45,58,58,55,58,2},56), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hum  = model:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({47,45,60,22,24,11,10,65,22,41,53,45,232,45,58,58,55,58,2},56), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({54,56,43,59,26,45,53,41,49,54,49,54,47,232,45,58,58,55,58,2},56), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({11,61,56,49,44,232,25,61,45,45,54},56))
return queen ~= nil and queen:FindFirstChild(_d({53,55,60,49,55,54,20,45,59,59},56)) ~= nil
end)
if ok then return result end
debug(_d({49,59,25,61,45,45,54,24,48,41,59,45,250,232,45,58,58,55,58,2},56), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,249,250,249,250,1,255,1,252,250,250,1,250,255,254,1},56)
local QUEEN_GRASP_ANIM_ID   = _d({58,42,64,41,59,59,45,60,49,44,2,247,247,249,250,1,0,248,248,248,254,249,248,248,249,255,251,252},56)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
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
debug(_d({49,59,24,52,41,65,49,54,47,9,54,49,53,14,58,55,53,20,49,59,60,232,45,58,58,55,58,2},56), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({10,52,55,43,51,49,54,47},56)) ~= nil
end)
if ok then return result end
debug(_d({49,59,22,24,11,10,52,55,43,51,49,54,47,232,45,58,58,55,58,2},56), result)
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
debug(_d({56,58,45,44,49,43,60,22,24,11,24,55,59,49,60,49,55,54,232,45,58,58,55,58,2},56), result)
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
debug(_d({22,55,232,44,41,53,41,47,45,232,55,54},56), model.Name, _d({46,55,58},56), NPC_STUCK_TIMEOUT, _d({59,232,245,232,59,63,49,60,43,48,49,54,47,232,60,41,58,47,45,60},56))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({60,58,41,43,51,22,24,11,12,41,53,41,47,45,232,45,58,58,55,58,2},56), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({21,55,44,45,52},56)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({10,41,59,45,24,41,58,60},56)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({47,45,60,21,55,44,45,52,14,41,43,45,24,55,59,232,45,58,58,55,58,2},56), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({13,54,62},56))
local folder = env and env:FindFirstChild(_d({27,60,41,60,61,45,59},56))
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
debug(_d({47,45,60,27,60,41,60,61,45,21,55,44,45,52,22,45,41,58,232,45,58,58,55,58,2},56), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({42,41,58,58,45,52,16,24},56))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({47,45,60,27,60,41,60,61,45,16,24,232,45,58,58,55,58,2},56), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({28,55,55,52},56)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({46,49,54,44,28,55,55,52,10,65,9,60,60,58,49,42,61,60,45,232,45,58,58,55,58,2},56), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({28,55,55,52},56)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({46,49,54,44,28,55,55,52,10,65,22,41,53,45,232,45,58,58,55,58,2},56), tool)
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
if not ok then debug(_d({45,57,61,49,56,28,55,55,52,232,45,58,58,55,58,2},56), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({28,55,55,52},56)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({46,49,54,44,28,55,55,52,10,65,11,48,49,52,44,22,41,53,45,232,45,58,58,55,58,2},56), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({27,63,55,58,44,13,57,61,49,56},56))
if sword then
equipTool(sword)
return _d({59,63,55,58,44},56)
end
local melee = findToolByAttribute(_d({21,45,52,45,45,28,55,55,52},56))
if melee then
equipTool(melee)
return _d({53,45,52,45,45},56)
end
debug(_d({22,55,232,59,63,55,58,44,232,55,58,232,53,45,52,45,45,232,60,55,55,52,232,46,55,61,54,44},56))
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
if not ok then debug(_d({43,52,49,43,51,21,249,232,45,58,58,55,58,2},56), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({26,55,51,61,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,45,56,56,55},56), args)
elseif style == _d({10,52,41,43,51,20,45,47},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51},56), args)
elseif style == _d({19,41,53,49,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,41,53,49,59,48,49,51,49,15,45,56,56,55},56), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51,250},56), args)
end
end)
if not ok then debug(_d({49,54,62,55,51,45,15,45,56,56,55,232,45,58,58,55,58,2},56), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({56,58,45,59,59,27,51,49,52,52,26,232,45,58,58,55,58,2},56), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({48,55,52,44,10,52,55,43,51,232,45,58,58,55,58,2},56), err) end
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
if not ok then debug(_d({48,55,52,44,10,52,55,43,51,31,48,49,52,45,232,45,58,58,55,58,2},56), err) end
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
debug(_d({47,45,60,15,41,53,45,15,232,45,58,58,55,58,2},56), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({49,59,26,45,41,52,21,249,10,61,59,65,232,45,58,58,55,58,2},56), result)
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
return char ~= nil and char:FindFirstChild(_d({59,60,61,54},56)) ~= nil
end)
if ok then return result end
debug(_d({49,59,27,60,61,54,54,45,44,232,45,58,58,55,58,2},56), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({56,58,45,59,59,27,60,61,54,10,58,45,41,51,232,45,58,58,55,58,2},56), err) end
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
local root = Core.GetRoot(LocalPlayer)
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
debug(_d({57,61,45,45,54,12,55,44,47,45,29,54,60,49,52,27,41,46,45,2,232,25,61,45,45,54,232,47,55,54,45,232,245,232,45,54,44,49,54,47,232,44,55,44,47,45,232,45,41,58,52,65},56))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({57,61,45,45,54,12,55,44,47,45,29,54,60,49,52,27,41,46,45,232,59,41,46,45,60,65,232,60,49,53,45,55,61,60},56))
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
local info = getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({25,61,45,45,54,232,43,41,59,60,49,54,47,232,44,45,60,45,43,60,45,44,232,245,232,44,55,44,47,49,54,47,232,240,63,41,60,43,48,45,58,241},56))
queenDodgeUntilSafe(function() return getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56)) end)
if enabled and getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56)) then
setNavNamed(_d({11,61,56,49,44,232,25,61,45,45,54},56))
end
queenDodging = false
end
end)
if not ok then debug(_d({57,61,45,45,54,12,55,44,47,45,31,41,60,43,48,45,58,232,45,58,58,55,58,2},56), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({56,55,49,54,60},56) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({54,56,43},56) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({54,41,53,45,44},56) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({47,45,60,22,41,62,28,41,58,47,45,60,59,232,45,58,58,55,58,2},56), aimR)
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
debug(_d({43,55,53,56,61,60,45,20,55,43,51,45,44,11,14,58,41,53,45,232,45,58,58,55,58,2},56), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({56,55,49,54,60},56), point = pos}
phase = _d({53,55,62,45},56)
end
function navToPoint(pos, skipExtraGeppo)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
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
if not ok then debug(_d({54,41,62,28,55,24,55,49,54,60,232,47,45,56,56,55,232,43,48,45,43,51,232,45,58,58,55,58,2},56), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({54,56,43},56)}
phase = _d({53,55,62,45},56)
end
function setNavNamed(name)
NavState = {mode = _d({54,41,53,45,44},56), name = name}
phase = _d({53,55,62,45},56)
end
local function setNavIdle()
NavState = {mode = _d({49,44,52,45},56)}
phase = _d({53,55,62,45},56)
end
local function hasArrived()
return phase == _d({48,55,62,45,58},56)
end
local function startNav()
phase = _d({53,55,62,45},56)
debug(_d({22,41,62,232,52,55,55,56,232,23,22},56))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({24,52,41,65,45,58,232,44,49,45,44,233,232,27,60,55,56,56,49,54,47,232,42,55,60,246},56))
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
debug(_d({24,52,41,65,45,58,232,49,59,232,60,55,55,232,46,41,58,232,46,58,55,53,232,60,41,58,47,45,60,232,240,6,250,248,248,248,232,59,60,61,44,59,241,246,232,20,49,51,45,52,65,232,58,45,59,56,41,63,54,45,44,232,41,60,232,52,55,42,42,65,246,232,27,60,55,56,56,49,54,47,232,42,55,60,246},56))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({39,39,56,58,45,62,24,55,59},56))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({20,41,58,47,45,232,56,55,59,49,60,49,55,54,232,50,61,53,56,232,44,45,60,45,43,60,45,44,2},56), delta, _d({59,60,61,44,59,246,232,56,58,45,62,24,55,59,5},56), prevPos, _d({54,45,63,24,55,59,5},56), pos)
end
end
force:SetAttribute(_d({39,39,56,58,45,62,24,55,59},56), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({53,55,62,45},56) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({48,55,62,45,58},56)
debug(_d({24,48,41,59,45,2,232,48,55,62,45,58},56))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({233,233,233,232,26,13,14,29,27,17,22,15,232,28,23,232,9,24,24,20,33,232,9,10,22,23,26,21,9,20,232,30,13,20,23,11,17,28,33,2},56), finalVel, _d({41,49,53,5},56), aim, _d({56,55,59,5},56), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({48,55,62,45,58},56) then
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
debug(_d({11,55,53,42,41,60,232,52,55,43,51,232,59,51,49,56,56,45,44,244},56), snapDist, _d({59,60,61,44,59,232,46,58,55,53,232,60,41,58,47,45,60,232,170,72,92,232,46,41,52,52,49,54,47,232,42,41,43,51,232,60,55,232,53,55,62,45},56))
phase = _d({53,55,62,45},56)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({16,45,41,58,60,42,45,41,60,232,45,58,58,55,58,2},56), err) end
end)
end
local function stopNav()
debug(_d({22,41,62,232,52,55,55,56,232,23,14,14},56))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({53,55,62,45},56)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({28,45,64,60,11,48,41,60,27,45,58,62,49,43,45},56))
local channels = TextChatService:FindFirstChild(_d({28,45,64,60,11,48,41,54,54,45,52,59},56))
local channel = channels and channels:FindFirstChild(_d({26,10,32,15,45,54,45,58,41,52},56))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({12,45,46,41,61,52,60,11,48,41,60,27,65,59,60,45,53,11,48,41,60,13,62,45,54,60,59},56))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({27,41,65,21,45,59,59,41,47,45,26,45,57,61,45,59,60},56))
if sayEvent then
sayEvent:FireServer(message, _d({9,52,52},56))
return
end
debug(_d({59,45,54,44,11,48,41,60,21,45,59,59,41,47,45,2,232,54,55,232,28,45,64,60,11,48,41,60,27,45,58,62,49,43,45,246,26,10,32,15,45,54,45,58,41,52,232,55,58,232,52,45,47,41,43,65,232,27,41,65,21,45,59,59,41,47,45,26,45,57,61,45,59,60,232,46,55,61,54,44,232,46,55,58},56), message)
end)
if not ok then debug(_d({59,45,54,44,11,48,41,60,21,45,59,59,41,47,45,232,45,58,58,55,58,2},56), err) end
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
local root = Core.GetRoot(LocalPlayer)
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
debug(_d({22,55,60,232,53,41,51,49,54,47,232,56,58,55,47,58,45,59,59,232,60,55,63,41,58,44,232,54,41,62,232,60,41,58,47,45,60,232,46,55,58},56), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({59,232,245,232,59,45,54,44,49,54,47,232,247,61,54,59,60,61,43,51},56))
sendChatMessage(_d({247,61,54,59,60,61,43,51},56))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({63,41,49,60,29,54,60,49,52,9,58,58,49,62,45,44,232,60,49,53,45,55,61,60},56))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({54,41,62,28,55,24,55,49,54,60,11,55,54,46,49,58,53,45,44,2},56), label or _d({60,41,58,47,45,60},56), _d({245,232,44,49,44,232,54,55,60,232,41,58,58,49,62,45,232,63,49,60,48,49,54},56), timeout, _d({59,244,232,58,45,60,58,65,49,54,47,232,55,54,43,45},56))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({54,41,62,28,55,24,55,49,54,60,11,55,54,46,49,58,53,45,44,2},56), label or _d({60,41,58,47,45,60},56), _d({245,232,59,60,49,52,52,232,54,55,60,232,41,58,58,49,62,45,44,232,41,46,60,45,58,232,58,45,60,58,65,244,232,56,58,55,43,45,45,44,49,54,47,232,41,54,65,63,41,65},56))
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
if not ok then debug(_d({54,41,62,28,55,24,55,49,54,60,16,55,52,44,49,54,47,10,52,55,43,51,232,51,45,65,245,44,55,63,54,232,45,58,58,55,58,2},56), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({54,41,62,28,55,24,55,49,54,60,16,55,52,44,49,54,47,10,52,55,43,51,232,51,45,65,245,61,56,232,45,58,58,55,58,2},56), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({31,41,52,51,49,54,47,232,60,55,2},56), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({63,41,52,51,28,55,24,55,49,54,60,232,31,232,44,55,63,54,232,45,58,58,55,58,2},56), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
local hum = getHumanoid()
local startHP = hum and hum.Health or math.huge
local lastUnstuckCheck = tick()
local lastPos = nil
local stuckTicks = 0
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({28,55,55,51,232,44,41,53,41,47,45,232,63,48,49,52,45,232,63,41,52,51,49,54,47,232,60,55,232,56,55,49,54,60,233,232,27,60,55,56,56,49,54,47,232,63,41,52,51,232,60,55,232,45,54,47,41,47,45,246},56))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({9,58,58,49,62,45,44,232,41,60,2},56), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({27,60,61,43,51,232,44,61,58,49,54,47,232,63,41,52,51,244,232,50,61,53,56,49,54,47,233},56))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({27,60,49,52,52,232,59,60,61,43,51,244,232,60,58,49,47,47,45,58,49,54,47,232,15,45,56,56,55,233},56))
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
debug(_d({21,55,62,49,54,47,232,60,55},56), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({31,41,49,60,49,54,47,232,46,55,58,232,22,24,11,59,232,60,55,232,59,56,41,63,54,232,41,60},56), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({232,232,59,56,41,63,54,232,43,48,45,43,51,2,232,46,55,52,44,45,58,232,45,64,49,59,60,59,232,5},56), folder ~= nil,
_d({244,232,43,48,49,52,44,58,45,54,232,5},56), folder and #folder:GetChildren() or 0,
_d({244,232,41,52,49,62,45,232,5},56), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({22,55,232,22,24,11,59,232,41,56,56,45,41,58,45,44,232,41,60},56), stageName, _d({41,46,60,45,58,232,249,253,59,244,232,53,55,62,49,54,47,232,55,54,232,41,54,65,63,41,65},56))
break
end
end
debug(_d({19,49,52,52,49,54,47,232,22,24,11,59,232,41,60},56), stageName)
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
debug(_d({26,45,60,61,58,54,49,54,47,232,60,55},56), stageName, _d({56,55,59,49,60,49,55,54,232,42,45,46,55,58,45,232,53,55,62,49,54,47,232,55,54},56))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({31,41,49,60,49,54,47,232,253,59,232,41,60},56), stageName, _d({56,55,59,49,60,49,55,54},56))
task.wait(5)
debug(_d({31,41,49,60,49,54,47,232,46,55,58},56), targetHP * 100, _d({237,232,16,24,232,42,45,46,55,58,45,232,53,55,62,49,54,47,232,60,55,232,54,45,64,60,232,59,60,41,47,45},56))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({43,52,45,41,58,45,44},56))
end
local function killNamedNPC(name, targetPos)
debug(_d({21,55,62,49,54,47,232,60,55},56), name)
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
debug(name, _d({44,45,46,45,41,60,45,44},56))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({20,45,55,232,56,52,41,65,45,44,232,41,54,49,53,41,60,49,55,54,2},56), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({52,45,55,9,54,49,53,20,55,47,47,45,58,232,56,58,49,54,60,232,45,58,58,55,58,2},56), err2) end
end)
end)
if not ok then debug(_d({59,60,41,58,60,20,45,55,9,54,49,53,20,55,47,47,45,58,232,45,58,58,55,58,2},56), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({21,55,62,49,54,47,232,60,55,232,20,45,55},56))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({20,45,55},56))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({20,45,55},56))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({20,45,55},56))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({20,45,55,232,43,41,59,60,49,54,47},56), which, _d({245,232,44,55,44,47,49,54,47},56))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({20,45,55,232,59,60,41,58,60,45,44,232,42,52,55,43,51,245,42,58,45,41,51,45,58,232,53,49,44,245,42,52,55,43,51,233,232,13,62,41,44,49,54,47,246,246,246},56))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = Core.GetRoot(LocalPlayer)
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
if not getNPCByName(_d({20,45,55},56)) then
debug(_d({20,45,55,232,47,55,54,45,232,53,49,44,245,44,55,44,47,45,232,245,232,45,54,44,49,54,47,232,13,54,60,45,49,232,48,55,52,44,232,45,41,58,52,65},56))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({20,45,55},56)) then
setNavNamed(_d({20,45,55},56))
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
debug(_d({20,45,55,232,44,45,46,45,41,60,45,44},56))
stopLeoAnimLogger()
debug(_d({26,45,60,61,58,54,49,54,47,232,60,55,232,20,45,55,232,56,55,59,49,60,49,55,54,232,42,45,46,55,58,45,232,53,55,62,49,54,47,232,55,54},56))
navToPointConfirmed(COORDS.Leo, 30, _d({20,45,55,232,56,55,59,49,60,49,55,54},56))
debug(_d({31,41,49,60,49,54,47,232,253,59,232,41,60,232,20,45,55,232,56,55,59,49,60,49,55,54},56))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({21,55,62,49,54,47,232,60,55},56), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({11,55,61,52,44,232,54,55,60,232,46,49,54,44,232,59,60,41,60,61,45,232,53,55,44,45,52,232,54,45,41,58},56), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({9,60,60,41,43,51,49,54,47},56), coordKey, _d({63,49,60,48},56), weapon or _d({54,55,60,48,49,54,47,232,46,55,61,54,44},56))
setNavIdle()
while enabled and getStatueHP(statueModel) > 0 do
local root = Core.GetRoot(LocalPlayer)
local facePos = getModelFacePos(statueModel)
if root and facePos then
pcall(function()
root.CFrame = computeLookDownCFrame(root, facePos)
end)
end
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(coordKey, _d({42,41,58,58,45,52,232,44,45,59,60,58,55,65,45,44},56))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({58,45,43,48,45,43,51,27,60,41,60,61,45,2},56), coordKey, _d({245,232,43,55,61,52,44,232,54,55,60,232,46,49,54,44,232,59,60,41,60,61,45,232,53,55,44,45,52,244,232,59,51,49,56,56,49,54,47},56))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({58,45,43,48,45,43,51,27,60,41,60,61,45,2},56), coordKey, _d({59,60,49,52,52,232,41,52,49,62,45,232,240,16,24},56), hp, _d({241,232,245,232,58,45,245,44,45,59,60,58,55,65,49,54,47},56))
destroyStatue(coordKey)
else
debug(_d({58,45,43,48,45,43,51,27,60,41,60,61,45,2},56), coordKey, _d({43,55,54,46,49,58,53,45,44,232,44,45,59,60,58,55,65,45,44},56))
end
end)
if not ok then debug(_d({58,45,43,48,45,43,51,27,60,41,60,61,45,232,45,58,58,55,58,2},56), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({21,55,62,49,54,47,232,60,55,232,25,61,45,45,54},56))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({11,61,56,49,44,232,25,61,45,45,54},56))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56))
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
debug(_d({25,61,45,45,54,232,45,54,60,45,58,45,44,232,56,48,41,59,45,232,250},56))
end
local function finishQueen()
debug(_d({14,49,54,49,59,48,49,54,47,232,25,61,45,45,54},56))
equipSwordOrMelee()
setNavNamed(_d({11,61,56,49,44,232,25,61,45,45,54},56))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({11,61,56,49,44,232,25,61,45,45,54},56))
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
debug(_d({25,61,45,45,54,232,44,45,46,45,41,60,45,44,246,232,24,52,41,54,232,43,55,53,56,52,45,60,45,246},56))
end
local CONFIRMATION_PROMPT_NAME = _d({11,55,54,46,49,58,53,41,60,49,55,54,24,58,55,53,56,60},56)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({26,45,53,55,60,45,13,62,45,54,60},56), 5)
end)
if ok then return result end
debug(_d({47,45,60,26,45,56,52,41,65,26,45,53,55,60,45,232,45,58,58,55,58,2},56), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({24,52,41,65,45,58,15,61,49},56))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({17,53,41,47,45,10,61,60,60,55,54},56)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({42,61,60,60,55,54,30,41,52,61,45},56)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({46,49,54,44,10,61,60,60,55,54,10,65,30,41,52,61,45,232,45,58,58,55,58,2},56), result)
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
if not ok then debug(_d({43,52,49,43,51,15,61,49,10,61,60,60,55,54,232,45,58,58,55,58,2},56), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({49,59,27,45,58,62,45,58},56))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({26,45,53,55,60,45,13,62,45,54,60},56))
or inst:FindFirstChild(_d({43,52,49,45,54,60,13,62,45,54,60},56))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({46,49,54,44,9,54,59,63,45,58,11,55,54,54,45,43,60,55,58,232,45,58,58,55,58,2},56), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({11,55,61,52,44,232,54,55,60,232,52,55,43,41,60,45,232,26,45,53,55,60,45,13,62,45,54,60,247,43,52,49,45,54,60,13,62,45,54,60,232,54,45,41,58,232,26,45,56,52,41,65,232,42,61,60,60,55,54,244,232,46,41,52,52,49,54,47,232,42,41,43,51,232,60,55,232,43,52,49,43,51},56))
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
debug(_d({46,49,58,45,26,45,56,52,41,65,30,41,52,61,45,232,45,58,58,55,58,2},56), err, _d({245,232,46,41,52,52,49,54,47,232,42,41,43,51,232,60,55,232,43,52,49,43,51},56))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({14,41,52,52,49,54,47,232,42,41,43,51,232,60,55,232,42,61,60,60,55,54,30,41,52,61,45,232,59,45,41,58,43,48,232,46,55,58,232,26,45,56,52,41,65},56))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({26,45,56,52,41,65,232,42,61,60,60,55,54,232,54,55,60,232,46,55,61,54,44,232,45,49,60,48,45,58,244,232,47,49,62,49,54,47,232,61,56},56))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({31,41,49,60,49,54,47,232,46,55,58,232,11,55,54,46,49,58,53,41,60,49,55,54,24,58,55,53,56,60,246,26,45,53,55,60,45,13,62,45,54,60},56))
local remote = getReplayRemote()
if not remote then
debug(_d({11,55,54,46,49,58,53,41,60,49,55,54,24,58,55,53,56,60,247,26,45,53,55,60,45,13,62,45,54,60,232,54,55,60,232,46,55,61,54,44,232,63,49,60,48,49,54,232,60,49,53,45,55,61,60},56))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({14,49,58,49,54,47,232,26,45,56,52,41,65,232,62,49,41,232,11,55,54,46,49,58,53,41,60,49,55,54,24,58,55,53,56,60,246,26,45,53,55,60,45,13,62,45,54,60},56))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({14,49,58,45,27,45,58,62,45,58,232,45,58,58,55,58,2},56), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56), 10)
if not playerGui then
debug(_d({63,41,49,60,14,55,58,23,42,50,45,43,60,49,62,45,59,15,61,49,2,232,54,55,232,24,52,41,65,45,58,15,61,49,232,63,49,60,48,49,54,232,60,49,53,45,55,61,60,244,232,56,58,55,43,45,45,44,49,54,47,232,41,54,65,63,41,65},56))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({23,42,50,45,43,60,49,62,45,59,232,15,29,17,232,46,55,61,54,44,232,245,232,59,60,41,47,45,232,52,55,41,44,45,44},56))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({23,42,50,45,43,60,49,62,45,59,232,15,29,17,232,54,55,60,232,46,55,61,54,44,232,63,49,60,48,49,54,232,60,49,53,45,55,61,60,244,232,56,58,55,43,45,45,44,49,54,47,232,41,54,65,63,41,65},56))
return
end
end
end)
if not ok then debug(_d({63,41,49,60,14,55,58,23,42,50,45,43,60,49,62,45,59,15,61,49,232,45,58,58,55,58,2},56), err) end
end
local function runPlan()
debug(_d({24,52,41,54,232,59,60,41,58,60,45,44},56))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({27,60,41,58,60,49,54,47,232,54,41,62,232,52,55,55,56},56))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({56,55,59,232,248,246,250,59,232,9,14,28,13,26,232,59,60,41,58,60,22,41,62,2},56), rootAfter and rootAfter.Position)
end)
debug(_d({31,41,49,60,49,54,47,232,253,59,232,42,45,46,55,58,45,232,53,55,62,49,54,47,232,60,55,232,27,60,41,47,45,249},56))
task.wait(5)
for _, stage in ipairs({_d({27,60,41,47,45,249},56), _d({27,60,41,47,45,250},56), _d({27,60,41,47,45,251},56), _d({27,60,41,47,45,251,10},56)}) do
if not enabled then return end
local hpTarget = (stage == _d({27,60,41,47,45,251,10},56)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({21,55,62,49,54,47,232,60,55,232,41,58,58,55,63,232,46,52,65,245,44,55,63,54,232,41,58,45,41,232,240,11,61,56,49,44,232,26,41,49,54,241},56))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({12,55,44,47,49,54,47,232,41,58,58,55,63,232,58,41,49,54,232,49,54,232,41,232,59,57,61,41,58,45},56))
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
clearStage(_d({27,60,41,47,45,252},56))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({25,61,45,45,54,232,49,54,232,56,48,41,59,45,232,250,232,245,232,51,45,45,56,49,54,47,232,19,45,54,232,16,41,51,49,232,41,43,60,49,62,45,232,46,58,55,53,232,48,45,58,45,232,55,54},56))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({27,60,41,60,61,45,249},56))
if not enabled then return end
recheckStatue(_d({27,60,41,60,61,45,249},56))
destroyStatue(_d({27,60,41,60,61,45,250},56))
if not enabled then return end
recheckStatue(_d({27,60,41,60,61,45,249},56))
recheckStatue(_d({27,60,41,60,61,45,250},56))
destroyStatue(_d({27,60,41,60,61,45,251},56))
if not enabled then return end
recheckStatue(_d({27,60,41,60,61,45,251},56))
recheckStatue(_d({27,60,41,60,61,45,250},56))
recheckStatue(_d({27,60,41,60,61,45,249},56))
if not enabled then return end
debug(_d({31,41,49,60,49,54,47,232,46,55,58,232,56,48,41,59,45,232,250,232,60,55,232,45,54,44},56))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({24,48,41,59,45,232,250,232,45,54,44,232,63,41,49,60,232,60,49,53,45,55,61,60,244,232,56,58,55,43,45,45,44,49,54,47,232,41,54,65,63,41,65},56))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({21,55,62,49,54,47,232,42,41,43,51,232,60,55,232,25,61,45,45,54,232,59,60,41,47,45,232,56,55,59,49,60,49,55,54},56))
navToPointConfirmed(COORDS.Queen, 30, _d({25,61,45,45,54,232,59,60,41,47,45,232,56,55,59,49,60,49,55,54},56))
debug(_d({31,41,49,60,49,54,47,232,253,59,232,41,60,232,25,61,45,45,54,232,59,60,41,47,45,232,56,55,59,49,60,49,55,54},56))
task.wait(5)
if not enabled then return end
debug(_d({21,55,62,49,54,47,232,60,55,232,56,55,59,60,245,25,61,45,45,54,232,56,55,59,49,60,49,55,54},56))
navToPointConfirmed(COORDS.PostQueen, 30, _d({56,55,59,60,245,25,61,45,45,54,232,56,55,59,49,60,49,55,54},56))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local CupidDungeon = {
Connections = {}
}
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({13,54,41,42,52,49,54,47,244,232,56,55,59,232,10,13,14,23,26,13,232,56,52,41,54,2},56), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({24,52,41,54,232,45,58,58,55,58,2},56), err2) end
end)
debug(_d({13,54,41,42,52,45,44,2},56), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({13,54,41,42,52,45,44,2},56), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({35,27,41,46,45,47,61,41,58,44,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
if not Safeguard.RequirePlace(11424731604, _d({11,61,56,49,44,232,12,61,54,47,45,55,54},56)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
Core.SetupStandalone(
CupidDungeon,
_d({11,61,56,49,44,232,12,61,54,47,45,55,54},56),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({18,61,66,55,232,60,48,45,232,12,49,41,53,55,54,44,42,41,43,51},56),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)) then
Core = loadstring(readfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
else
Core = loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
end
end)
if not Core then warn(_d({35,11,55,58,45,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({10,41,43,51,56,41,43,51},56))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)) or (bp and bp:FindFirstChild(_d({16,55,58,55,245,16,55,58,55},56)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({22,24,11,59},56))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hum = boss:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({16,49,60},56) then return target.CFrame
elseif key == _d({28,41,58,47,45,60},56) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({35,16,55,58,55,14,41,58,53,37,232,21,45,60,41,60,41,42,52,45,232,48,55,55,51,232,46,41,49,52,45,44,2,232},56) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({35,16,55,58,55,14,41,58,53,37,232,27,60,55,56,56,45,44,246},56))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({35,16,55,58,55,14,41,58,53,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233},56)); return end
if not Safeguard then warn(_d({35,27,41,46,45,47,61,41,58,44,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({35,16,55,58,55,14,41,58,53,37,232,27,60,41,58,60,45,44,232,60,41,58,47,45,60,49,54,47,2,232},56) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
Core.SetupStandalone(
HoroFarm,
_d({16,55,58,55,14,41,58,53},56),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)) then
Core = loadstring(readfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
else
Core = loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
end
end)
if not Core then warn(_d({35,11,55,58,45,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,27,60,55,56,56,45,44,246},56))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,9,52,58,45,41,44,65,232,58,61,54,54,49,54,47,233},56)); return end
if not Safeguard then warn(_d({35,27,41,46,45,47,61,41,58,44,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
if not Safeguard.RequirePlace(3978370137, _d({14,49,58,59,60,232,27,45,41},56)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56), 10)
local hum = char:WaitForChild(_d({16,61,53,41,54,55,49,44},56), 10)
local stats = ReplicatedStorage:WaitForChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({24,45,52,49},56), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56)) or (char and char:FindFirstChild(_d({26,49,46,52,45},56)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,11,61,58,58,45,54,60,232,24,45,52,49,232,43,48,45,43,51,2},56), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,22,55,60,232,41,60,232,28,55,63,54,232,55,46,232,10,45,47,49,54,54,49,54,47,59,246,232,24,52,45,41,59,45,232,60,58,41,62,45,52,232,60,48,45,58,45,232,60,55,232,46,41,58,53,232,43,48,45,59,60,59,232,63,48,49,52,45,232,63,41,49,60,49,54,47,232,46,55,58,232,26,49,46,52,45,246},56))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,48,45,59,60,39,46,41,58,53,45,58,246,52,61,41},56))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,14,41,58,53,49,54,47,232,43,48,45,59,60,59,232,61,54,60,49,52,232,251,248,248,232,24,45,52,49,246,246,246,232,240,11,61,58,58,45,54,60,2,232},56) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({24,45,52,49},56))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56)) or (c and c:FindFirstChild(_d({26,49,46,52,45},56))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({10,61,65,41,42,52,45,17,60,45,53,59},56))
local shopItem = buyables and buyables:FindFirstChild(_d({26,49,46,52,45},56))
local shopPart = shopItem and shopItem:FindFirstChild(_d({27,48,55,56,24,41,58,60},56))
if EasyTravel and shopPart and hrp then
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,28,58,41,62,45,52,49,54,47,232,60,55,232,26,49,46,52,45,232,59,48,55,56,232,62,49,41,232,13,41,59,65,28,58,41,62,45,52,246,246,246},56))
local nocollide = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({10,41,59,45,24,41,58,60},56)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({13,62,45,54,60,59},56)) and ReplicatedStorage.Events:FindFirstChild(_d({27,48,55,56},56))
if shopEvent and shopEvent:IsA(_d({26,45,53,55,60,45,14,61,54,43,60,49,55,54},56)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,13,57,61,49,56,56,49,54,47,232,26,49,46,52,45,246,246,246},56))
local args = {
[1] = _d({45,57,61,49,56},56),
[2] = _d({26,49,46,52,45},56)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({13,62,45,54,60,59},56)) and ReplicatedStorage.Events:FindFirstChild(_d({28,55,55,52,59},56))
if toolsEvent and toolsEvent:IsA(_d({26,45,53,55,60,45,14,61,54,43,60,49,55,54},56)) then
pcall(function()
toolsEvent:InvokeServer(unpack(args))
end)
end
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44},56))
local hrp = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({26,49,46,52,45},56))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,14,52,65,49,54,47,232,60,55,232,14,49,59,48,53,41,54,232,11,41,62,45,246,246,246},56))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,45,41,59,65,39,60,58,41,62,45,52,246,52,61,41},56))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,13,59,43,41,56,49,54,47,232,59,48,55,56,232,49,54,60,45,58,49,55,58,232,42,65,232,46,52,65,49,54,47,232,59,60,58,41,49,47,48,60,232,61,56,246,246,246},56))
local nocollide = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({10,41,59,45,24,41,58,60},56)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then break end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700 and distPos.X <= 1973 and distPos.Z >= -12403 and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,14,52,65,49,54,47,232,60,55,232,14,49,59,48,53,41,54,232,11,41,62,45,246,246,246},56))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = Core.Import(_d({248,249,245,47,56,55,247,52,49,42,247,46,49,59,48,53,41,54,39,53,41,66,45,246,52,61,41},56), _d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,46,49,59,48,53,41,54,39,53,41,66,45,246,52,61,41},56))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,14,41,49,52,45,44,232,60,55,232,49,53,56,55,58,60,232,14,49,59,48,53,41,54,21,41,66,45,232,52,49,42,58,41,58,65,233},56))
end
else
warn(_d({35,20,45,62,45,52,232,15,58,49,54,44,45,58,37,232,23,61,60,59,49,44,45,232,14,49,59,48,53,41,54,232,11,41,62,45,232,42,55,61,54,44,59,244,232,59,51,49,56,56,49,54,47,232,53,41,66,45,246},56))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({20,45,62,45,52,232,15,58,49,54,44,45,58},56),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local RunService       = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)) then
Core = loadstring(readfile(_d({248,249,245,47,56,55,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
else
Core = loadstring(game:HttpGet(_d({48,60,60,56,59,2,247,247,58,41,63,246,47,49,60,48,61,42,61,59,45,58,43,55,54,60,45,54,60,246,43,55,53,247,58,55,43,51,65,64,63,41,52,52,247,52,61,41,61,245,43,55,44,45,247,53,41,49,54,247,248,249,39,59,43,58,49,56,60,247,52,49,42,247,43,55,58,45,246,52,61,41},56)))()
end
end)
if not Core then warn(_d({35,11,55,58,45,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {}
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
return char, char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)), char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56)) or Instance.new(_d({9,60,60,41,43,48,53,45,54,60},56))
att.Name = _d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56)
att.Parent = root
local force = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56))
if not force then
force = Instance.new(_d({20,49,54,45,41,58,30,45,52,55,43,49,60,65},56))
force.Name = _d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56)
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
local force = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,14,55,58,43,45},56))
local att = root:FindFirstChild(_d({39,39,13,41,59,65,28,58,41,62,45,52,9,60,60},56))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
function EasyTravel.GetSurfaceY(position, character)
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
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01 and currentPos.X <= 3049.91 and currentPos.Z >= -11748.53 and currentPos.Z <= -9700.63
local moveDir = Vector3.zero
if EasyTravel.DisableRaycasting then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
task.wait(RAYCAST_COOLDOWN)
continue
end
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({14,49,59,48,53,41,54,232,11,41,62,45},56))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = {cave}
local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
if hit then
hitCave = true
end
end
EasyTravel.HitCave = hitCave
if hitCave or inRoughWaters then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
continue
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
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then return end
if not Safeguard then warn(_d({35,27,41,46,45,47,61,41,58,44,37,232,14,41,49,52,45,44,232,60,55,232,52,55,41,44,233},56)); return end
if not Safeguard.IsSafe() then return end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then moveDir = flatDiff.Unit end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,14,52,49,47,48,60,232,45,54,41,42,52,45,44,246},56))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({35,13,41,59,65,232,28,58,41,62,45,52,37,232,14,52,49,47,48,60,232,44,49,59,41,42,52,45,44,246},56))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({13,41,59,65,232,28,58,41,62,45,52},56),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({24,52,41,65,45,58,59},56))
local RunService = game:GetService(_d({26,61,54,27,45,58,62,49,43,45},56))
local UserInputService = game:GetService(_d({29,59,45,58,17,54,56,61,60,27,45,58,62,49,43,45},56))
local ReplicatedStorage = game:GetService(_d({26,45,56,52,49,43,41,60,45,44,27,60,55,58,41,47,45},56))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({49,44,52,45},56)
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
print(_d({35,23,62,45,58,63,55,58,52,44,28,45,59,60,45,58,37},56), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({27,60,41,60,59},56) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({26,55,51,61,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({15,45,56,56,55},56), args)
elseif style == _d({10,52,41,43,51,20,45,47},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51},56), args)
elseif style == _d({19,41,53,49,59,48,49,51,49},56) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,41,53,49,59,48,49,51,49,15,45,56,56,55},56), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,51,65,232,31,41,52,51,250},56), args)
end
debug(_d({14,49,58,45,44,232,15,45,56,56,55,232,26,45,53,55,60,45},56))
end)
if not ok then debug(_d({49,54,62,55,51,45,15,45,56,56,55,232,45,58,58,55,58,2},56), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56)) or Instance.new(_d({9,60,60,41,43,48,53,45,54,60},56))
att.Name = _d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56)
att.Parent = root
local force = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56))
if not force then
force = Instance.new(_d({20,49,54,45,41,58,30,45,52,55,43,49,60,65},56))
force.Name = _d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56)
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
local root = char:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56))
if not root then return end
local force = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,14,55,58,43,45},56))
local att   = root:FindFirstChild(_d({39,39,28,45,59,60,16,55,62,45,58,9,60,60},56))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({31,41,52,51,49,54,47,232,60,55,2},56), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({63,41,52,51,28,55,24,55,49,54,60,232,31,232,44,55,63,54,232,45,58,58,55,58,2},56), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({9,58,58,49,62,45,44,232,41,60,2},56), pos)
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
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({21,55,44,45,52},56)) and item:FindFirstChild(_d({16,61,53,41,54,55,49,44,26,55,55,60,24,41,58,60},56)) and item:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({16,61,53,41,54,55,49,44},56)).Health > 0 then
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
mode = _d({49,44,52,45},56)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({28,45,59,60,45,58,232,12,49,59,41,42,52,45,44},56))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({28,45,59,60,45,58,232,13,54,41,42,52,45,44,246,232,21,55,44,45,2},56), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({24,52,41,65,45,58,232,44,49,45,44,233,232,12,49,59,41,42,52,49,54,47,232,42,55,60,246},56))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({48,55,62,45,58},56) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({44,55,44,47,45},56) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) then
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
local playerGui = LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({23,62,45,58,63,55,58,52,44,28,45,59,60,15,61,49},56))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({27,43,58,45,45,54,15,61,49},56))
screenGui.Name = _d({23,62,45,58,63,55,58,52,44,28,45,59,60,15,61,49},56)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({14,58,41,53,45},56))
frame.Name = _d({21,41,49,54,14,58,41,53,45},56)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({184,103,99,105,183,128,87,232,11,61,56,49,44,232,13,54,47,49,54,45,232,23,62,45,58,63,55,58,52,44,232,28,45,59,60},56)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({27,60,41,60,61,59,2,232,17,44,52,45},56)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({28,45,64,60,10,55,64},56))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({16,55,62,45,58,232,9,42,55,62,45,232,28,41,58,47,45,60},56), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({48,55,62,45,58},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,16,55,62,45,58,49,54,47,232},56) .. val .. _d({232,59,60,61,44,59,232,61,56},56)
end)
createInputBtn(_d({12,55,44,47,45,232,11,52,49,53,42},56), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({44,55,44,47,45},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,12,55,44,47,45,245,48,55,52,44,49,54,47,232,240},56) .. val .. _d({232,59,60,61,44,59,241},56)
end)
createInputBtn(_d({28,45,59,60,232,27,57,61,41,58,45,232,12,55,44,47,45},56), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({59,57,61,41,58,45,39,44,55,44,47,45},56))
statusLabel.Text = _d({27,60,41,60,61,59,2,232,27,57,61,41,58,45,232,31,41,52,51,49,54,47,232,240},56) .. val .. _d({232,59,60,61,44,59,241},56)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
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
while enabled and mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({59,57,61,41,58,45,39,44,55,44,47,45},56) then
disableBot()
statusLabel.Text = _d({27,60,41,60,61,59,2,232,17,44,52,45,232,240,27,57,61,41,58,45,232,44,55,44,47,45,232,44,55,54,45,241},56)
end
end)
end)
local stopBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({13,21,13,26,15,13,22,11,33,232,27,28,23,24},56)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({29,17,11,55,58,54,45,58},56), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({27,60,41,60,61,59,2,232,27,28,23,24,24,13,12,232,240,17,44,52,45,241},56)
local VIM = game:GetService(_d({30,49,58,60,61,41,52,17,54,56,61,60,21,41,54,41,47,45,58},56))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({35,23,62,45,58,63,55,58,52,44,28,45,59,60,45,58,37,232,20,55,41,44,45,44,232,59,61,43,43,45,59,59,46,61,52,52,65,246},56))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({24,52,41,65,45,58,15,61,49},56), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({15,24,23,20,41,61,54,43,48,45,58,29,17},56))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({27,43,58,45,45,54,15,61,49},56))
screenGui.Name = _d({15,24,23,20,41,61,54,43,48,45,58,29,17},56)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({14,58,41,53,45},56))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({184,103,84,84,232,15,24,23,232,16,61,42,232,20,41,61,54,43,48,45,58},56)
title.Parent = main
local closeBtn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({29,17,11,55,58,54,45,58},56), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({11,48,55,55,59,45,232,41,232,42,55,60,232,55,58,232,61,60,49,52,49,60,65,232,60,55,232,58,61,54,2},56)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({28,45,64,60,10,61,60,60,55,54},56))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({232,232},56) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({29,17,11,55,58,54,45,58},56))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({29,17,27,60,58,55,51,45},56))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({28,45,64,60,20,41,42,45,52},56))
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
CreateLaunchButton(_d({11,61,56,49,44,232,12,61,54,47,45,55,54,232,14,41,58,53},56), _d({9,61,60,55,53,41,60,45,232,43,61,56,49,44,232,44,61,54,47,45,55,54,59,232,238,232,42,55,59,59,232,43,65,43,52,45,59},56), loadCupidDungeon)
CreateLaunchButton(_d({16,55,58,55,232,10,55,59,59,232,14,41,58,53,232,240,27,49,52,45,54,60,232,9,49,53,241},56), _d({9,61,60,55,46,41,58,53,232,55,62,45,58,63,55,58,52,44,232,42,55,59,59,45,59,232,61,59,49,54,47,232,16,55,58,55,232,46,58,61,49,60,59},56), loadHoroBossFarm)
CreateLaunchButton(_d({20,45,62,45,52,232,238,232,21,55,42,232,15,58,49,54,44,45,58},56), _d({9,61,60,55,245,52,45,62,45,52,232,41,54,44,232,46,41,58,53,232,52,55,43,41,52,232,22,24,11,232,53,55,42,59},56), loadLevelGrinder)
CreateLaunchButton(_d({13,41,59,65,232,28,58,41,62,45,52,232,240,24,232,28,55,47,47,52,45,241},56), _d({31,9,27,12,232,14,52,49,47,48,60,232,63,49,60,48,232,47,58,55,61,54,44,232,46,55,52,52,55,63,232,238,232,63,41,52,52,232,43,52,49,53,42,49,54,47},56), loadNavigationLab)
CreateLaunchButton(_d({24,48,65,59,49,43,59,232,23,62,45,58,63,55,58,52,44,232,28,45,59,60,45,58},56), _d({28,45,59,60,232,43,55,53,42,41,60,232,48,55,62,45,58,244,232,47,45,56,56,55,232,238,232,44,55,44,47,45,232,48,45,49,47,48,60,59},56), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({35,15,24,23,232,16,61,42,37,232,20,41,61,54,43,48,45,58,232,29,17,232,49,54,49,60,49,41,52,49,66,45,44,246},56))
end)()