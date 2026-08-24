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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({21,49,38,62,42,55,56},59))
local UserInputService    = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local RunService          = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM                 = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local ReplicatedStorage    = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)) then
Core = loadstring(readfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
else
Core = loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
end
end)
if not Core then warn(_d({32,8,52,55,42,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,249,249,246,249,246,248,247,252},59)
local LEO_ENTEI_ANIM_ID    = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,249,249,246,248,253,247,252,253},59)
local LEO_HIKEN_ANIM_ID    = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,247,245,254,246,252,249,245,252},59)
local LEO_FIREFLY_ANIM_ID  = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,247,245,247,248,251,246,250,249},59)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({20,39,47,42,40,57,46,59,42,56},59)
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
local REPLAY_BUTTON_VALUE   = _d({23,42,53,49,38,62},59)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({50,52,59,42},59)
local NavState   = {mode = _d({46,41,49,42},59)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({32,7,52,56,56,7,52,57,34},59), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end)
if ok then return root end
debug(_d({44,42,57,23,52,52,57,229,42,55,55,52,55,255},59), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end)
if ok then return hum end
debug(_d({44,42,57,13,58,50,38,51,52,46,41,229,42,55,55,52,55,255},59), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({36,36,13,52,59,42,55,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,13,52,59,42,55,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,13,52,59,42,55,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,13,52,59,42,55,11,52,55,40,42},59)
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
debug(_d({44,42,57,20,55,8,55,42,38,57,42,11,52,55,40,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local force = root:FindFirstChild(_d({36,36,13,52,59,42,55,11,52,55,40,42},59))
local att   = root:FindFirstChild(_d({36,36,13,52,59,42,55,6,57,57},59))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({40,49,42,38,51,58,53,11,52,55,40,42,229,42,55,55,52,55,255},59), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({7,58,56,52,18,42,49,42,42},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,7,58,56,52,6,40,57,46,59,42,229,42,55,55,52,55,255},59), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({7,58,56,52},59))
end)
if not ok then debug(_d({38,40,57,46,59,38,57,42,7,58,56,52,229,42,55,55,52,55,255},59), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({7,58,56,52,229,51,52,57,229,38,40,57,46,59,42,241,229,38,40,57,46,59,38,57,46,51,44},59))
activateBuso()
end
end)
if not ok then debug(_d({7,58,56,52,16,42,42,53,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({7,58,56,52,229,48,42,42,53,42,55,229,56,57,52,53,53,42,41},59))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({16,42,51,13,38,48,46},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,16,42,51,6,40,57,46,59,42,229,42,55,55,52,55,255},59), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({16,42,51},59), true)
end)
if not ok then debug(_d({38,40,57,46,59,38,57,42,16,42,51,229,42,55,55,52,55,255},59), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({16,42,51,229,51,52,57,229,38,40,57,46,59,42,241,229,38,40,57,46,59,38,57,46,51,44},59))
activateKen()
end
end)
if not ok then debug(_d({16,42,51,16,42,42,53,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({16,42,51,229,48,42,42,53,42,55,229,56,57,52,53,53,42,41},59))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({19,21,8,56},59)) end)
if ok then return folder end
debug(_d({44,42,57,19,21,8,56,11,52,49,41,42,55,229,42,55,55,52,55,255},59), folder)
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
local r = model:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local h = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
debug(_d({44,42,57,19,42,38,55,42,56,57,19,21,8,229,42,55,55,52,55,255},59), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum  = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({44,42,57,19,21,8,7,62,19,38,50,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({51,53,40,56,23,42,50,38,46,51,46,51,44,229,42,55,55,52,55,255},59), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({8,58,53,46,41,229,22,58,42,42,51},59))
return queen ~= nil and queen:FindFirstChild(_d({50,52,57,46,52,51,17,42,56,56},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,22,58,42,42,51,21,45,38,56,42,247,229,42,55,55,52,55,255},59), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,246,247,246,247,254,252,254,249,247,247,254,247,252,251,254},59)
local QUEEN_GRASP_ANIM_ID   = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,246,247,254,253,245,245,245,251,246,245,245,246,252,248,249},59)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
debug(_d({46,56,21,49,38,62,46,51,44,6,51,46,50,11,55,52,50,17,46,56,57,229,42,55,55,52,55,255},59), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({7,49,52,40,48,46,51,44},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,19,21,8,7,49,52,40,48,46,51,44,229,42,55,55,52,55,255},59), result)
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
debug(_d({53,55,42,41,46,40,57,19,21,8,21,52,56,46,57,46,52,51,229,42,55,55,52,55,255},59), result)
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
debug(_d({19,52,229,41,38,50,38,44,42,229,52,51},59), model.Name, _d({43,52,55},59), NPC_STUCK_TIMEOUT, _d({56,229,242,229,56,60,46,57,40,45,46,51,44,229,57,38,55,44,42,57},59))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({57,55,38,40,48,19,21,8,9,38,50,38,44,42,229,42,55,55,52,55,255},59), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({18,52,41,42,49},59)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({7,38,56,42,21,38,55,57},59)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({44,42,57,18,52,41,42,49,11,38,40,42,21,52,56,229,42,55,55,52,55,255},59), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({10,51,59},59))
local folder = env and env:FindFirstChild(_d({24,57,38,57,58,42,56},59))
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
debug(_d({44,42,57,24,57,38,57,58,42,18,52,41,42,49,19,42,38,55,229,42,55,55,52,55,255},59), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({39,38,55,55,42,49,13,21},59))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({44,42,57,24,57,38,57,58,42,13,21,229,42,55,55,52,55,255},59), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,6,57,57,55,46,39,58,57,42,229,42,55,55,52,55,255},59), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({25,52,52,49},59)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,19,38,50,42,229,42,55,55,52,55,255},59), tool)
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
if not ok then debug(_d({42,54,58,46,53,25,52,52,49,229,42,55,55,52,55,255},59), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,8,45,46,49,41,19,38,50,42,229,42,55,55,52,55,255},59), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({24,60,52,55,41,10,54,58,46,53},59))
if sword then
equipTool(sword)
return _d({56,60,52,55,41},59)
end
local melee = findToolByAttribute(_d({18,42,49,42,42,25,52,52,49},59))
if melee then
equipTool(melee)
return _d({50,42,49,42,42},59)
end
debug(_d({19,52,229,56,60,52,55,41,229,52,55,229,50,42,49,42,42,229,57,52,52,49,229,43,52,58,51,41},59))
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
if not ok then debug(_d({40,49,46,40,48,18,246,229,42,55,55,52,55,255},59), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({23,52,48,58,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,42,53,53,52},59), args)
elseif style == _d({7,49,38,40,48,17,42,44},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48},59), args)
elseif style == _d({16,38,50,46,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,38,50,46,56,45,46,48,46,12,42,53,53,52},59), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48,247},59), args)
end
end)
if not ok then debug(_d({46,51,59,52,48,42,12,42,53,53,52,229,42,55,55,52,55,255},59), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({53,55,42,56,56,24,48,46,49,49,23,229,42,55,55,52,55,255},59), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({45,52,49,41,7,49,52,40,48,229,42,55,55,52,55,255},59), err) end
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
if not ok then debug(_d({45,52,49,41,7,49,52,40,48,28,45,46,49,42,229,42,55,55,52,55,255},59), err) end
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
debug(_d({44,42,57,12,38,50,42,12,229,42,55,55,52,55,255},59), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({46,56,23,42,38,49,18,246,7,58,56,62,229,42,55,55,52,55,255},59), result)
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
return char ~= nil and char:FindFirstChild(_d({56,57,58,51},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,24,57,58,51,51,42,41,229,42,55,55,52,55,255},59), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({53,55,42,56,56,24,57,58,51,7,55,42,38,48,229,42,55,55,52,55,255},59), err) end
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
debug(_d({54,58,42,42,51,9,52,41,44,42,26,51,57,46,49,24,38,43,42,255,229,22,58,42,42,51,229,44,52,51,42,229,242,229,42,51,41,46,51,44,229,41,52,41,44,42,229,42,38,55,49,62},59))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({54,58,42,42,51,9,52,41,44,42,26,51,57,46,49,24,38,43,42,229,56,38,43,42,57,62,229,57,46,50,42,52,58,57},59))
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
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({22,58,42,42,51,229,40,38,56,57,46,51,44,229,41,42,57,42,40,57,42,41,229,242,229,41,52,41,44,46,51,44,229,237,60,38,57,40,45,42,55,238},59))
queenDodgeUntilSafe(function() return getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) end)
if enabled and getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) then
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
end
queenDodging = false
end
end)
if not ok then debug(_d({54,58,42,42,51,9,52,41,44,42,28,38,57,40,45,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({53,52,46,51,57},59) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({51,53,40},59) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({51,38,50,42,41},59) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({44,42,57,19,38,59,25,38,55,44,42,57,56,229,42,55,55,52,55,255},59), aimR)
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
debug(_d({40,52,50,53,58,57,42,17,52,40,48,42,41,8,11,55,38,50,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({53,52,46,51,57},59), point = pos}
phase = _d({50,52,59,42},59)
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
if not ok then debug(_d({51,38,59,25,52,21,52,46,51,57,229,44,42,53,53,52,229,40,45,42,40,48,229,42,55,55,52,55,255},59), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({51,53,40},59)}
phase = _d({50,52,59,42},59)
end
function setNavNamed(name)
NavState = {mode = _d({51,38,50,42,41},59), name = name}
phase = _d({50,52,59,42},59)
end
local function setNavIdle()
NavState = {mode = _d({46,41,49,42},59)}
phase = _d({50,52,59,42},59)
end
local function hasArrived()
return phase == _d({45,52,59,42,55},59)
end
local function startNav()
phase = _d({50,52,59,42},59)
debug(_d({19,38,59,229,49,52,52,53,229,20,19},59))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({21,49,38,62,42,55,229,41,46,42,41,230,229,24,57,52,53,53,46,51,44,229,39,52,57,243},59))
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
debug(_d({21,49,38,62,42,55,229,46,56,229,57,52,52,229,43,38,55,229,43,55,52,50,229,57,38,55,44,42,57,229,237,3,247,245,245,245,229,56,57,58,41,56,238,243,229,17,46,48,42,49,62,229,55,42,56,53,38,60,51,42,41,229,38,57,229,49,52,39,39,62,243,229,24,57,52,53,53,46,51,44,229,39,52,57,243},59))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({36,36,53,55,42,59,21,52,56},59))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({17,38,55,44,42,229,53,52,56,46,57,46,52,51,229,47,58,50,53,229,41,42,57,42,40,57,42,41,255},59), delta, _d({56,57,58,41,56,243,229,53,55,42,59,21,52,56,2},59), prevPos, _d({51,42,60,21,52,56,2},59), pos)
end
end
force:SetAttribute(_d({36,36,53,55,42,59,21,52,56},59), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({50,52,59,42},59) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({45,52,59,42,55},59)
debug(_d({21,45,38,56,42,255,229,45,52,59,42,55},59))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({230,230,230,229,23,10,11,26,24,14,19,12,229,25,20,229,6,21,21,17,30,229,6,7,19,20,23,18,6,17,229,27,10,17,20,8,14,25,30,255},59), finalVel, _d({38,46,50,2},59), aim, _d({53,52,56,2},59), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({45,52,59,42,55},59) then
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
debug(_d({8,52,50,39,38,57,229,49,52,40,48,229,56,48,46,53,53,42,41,241},59), snapDist, _d({56,57,58,41,56,229,43,55,52,50,229,57,38,55,44,42,57,229,167,69,89,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,50,52,59,42},59))
phase = _d({50,52,59,42},59)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({13,42,38,55,57,39,42,38,57,229,42,55,55,52,55,255},59), err) end
end)
end
local function stopNav()
debug(_d({19,38,59,229,49,52,52,53,229,20,11,11},59))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({50,52,59,42},59)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({25,42,61,57,8,45,38,57,24,42,55,59,46,40,42},59))
local channels = TextChatService:FindFirstChild(_d({25,42,61,57,8,45,38,51,51,42,49,56},59))
local channel = channels and channels:FindFirstChild(_d({23,7,29,12,42,51,42,55,38,49},59))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({9,42,43,38,58,49,57,8,45,38,57,24,62,56,57,42,50,8,45,38,57,10,59,42,51,57,56},59))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({24,38,62,18,42,56,56,38,44,42,23,42,54,58,42,56,57},59))
if sayEvent then
sayEvent:FireServer(message, _d({6,49,49},59))
return
end
debug(_d({56,42,51,41,8,45,38,57,18,42,56,56,38,44,42,255,229,51,52,229,25,42,61,57,8,45,38,57,24,42,55,59,46,40,42,243,23,7,29,12,42,51,42,55,38,49,229,52,55,229,49,42,44,38,40,62,229,24,38,62,18,42,56,56,38,44,42,23,42,54,58,42,56,57,229,43,52,58,51,41,229,43,52,55},59), message)
end)
if not ok then debug(_d({56,42,51,41,8,45,38,57,18,42,56,56,38,44,42,229,42,55,55,52,55,255},59), err) end
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
debug(_d({19,52,57,229,50,38,48,46,51,44,229,53,55,52,44,55,42,56,56,229,57,52,60,38,55,41,229,51,38,59,229,57,38,55,44,42,57,229,43,52,55},59), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({56,229,242,229,56,42,51,41,46,51,44,229,244,58,51,56,57,58,40,48},59))
sendChatMessage(_d({244,58,51,56,57,58,40,48},59))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({60,38,46,57,26,51,57,46,49,6,55,55,46,59,42,41,229,57,46,50,42,52,58,57},59))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({51,38,59,25,52,21,52,46,51,57,8,52,51,43,46,55,50,42,41,255},59), label or _d({57,38,55,44,42,57},59), _d({242,229,41,46,41,229,51,52,57,229,38,55,55,46,59,42,229,60,46,57,45,46,51},59), timeout, _d({56,241,229,55,42,57,55,62,46,51,44,229,52,51,40,42},59))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({51,38,59,25,52,21,52,46,51,57,8,52,51,43,46,55,50,42,41,255},59), label or _d({57,38,55,44,42,57},59), _d({242,229,56,57,46,49,49,229,51,52,57,229,38,55,55,46,59,42,41,229,38,43,57,42,55,229,55,42,57,55,62,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
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
if not ok then debug(_d({51,38,59,25,52,21,52,46,51,57,13,52,49,41,46,51,44,7,49,52,40,48,229,48,42,62,242,41,52,60,51,229,42,55,55,52,55,255},59), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({51,38,59,25,52,21,52,46,51,57,13,52,49,41,46,51,44,7,49,52,40,48,229,48,42,62,242,58,53,229,42,55,55,52,55,255},59), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({28,38,49,48,46,51,44,229,57,52,255},59), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({60,38,49,48,25,52,21,52,46,51,57,229,28,229,41,52,60,51,229,42,55,55,52,55,255},59), err) end
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
debug(_d({25,52,52,48,229,41,38,50,38,44,42,229,60,45,46,49,42,229,60,38,49,48,46,51,44,229,57,52,229,53,52,46,51,57,230,229,24,57,52,53,53,46,51,44,229,60,38,49,48,229,57,52,229,42,51,44,38,44,42,243},59))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({6,55,55,46,59,42,41,229,38,57,255},59), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({24,57,58,40,48,229,41,58,55,46,51,44,229,60,38,49,48,241,229,47,58,50,53,46,51,44,230},59))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({24,57,46,49,49,229,56,57,58,40,48,241,229,57,55,46,44,44,42,55,46,51,44,229,12,42,53,53,52,230},59))
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
debug(_d({18,52,59,46,51,44,229,57,52},59), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,19,21,8,56,229,57,52,229,56,53,38,60,51,229,38,57},59), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({229,229,56,53,38,60,51,229,40,45,42,40,48,255,229,43,52,49,41,42,55,229,42,61,46,56,57,56,229,2},59), folder ~= nil,
_d({241,229,40,45,46,49,41,55,42,51,229,2},59), folder and #folder:GetChildren() or 0,
_d({241,229,38,49,46,59,42,229,2},59), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({19,52,229,19,21,8,56,229,38,53,53,42,38,55,42,41,229,38,57},59), stageName, _d({38,43,57,42,55,229,246,250,56,241,229,50,52,59,46,51,44,229,52,51,229,38,51,62,60,38,62},59))
break
end
end
debug(_d({16,46,49,49,46,51,44,229,19,21,8,56,229,38,57},59), stageName)
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
debug(_d({23,42,57,58,55,51,46,51,44,229,57,52},59), stageName, _d({53,52,56,46,57,46,52,51,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,52,51},59))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57},59), stageName, _d({53,52,56,46,57,46,52,51},59))
task.wait(5)
debug(_d({28,38,46,57,46,51,44,229,43,52,55},59), targetHP * 100, _d({234,229,13,21,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,57,52,229,51,42,61,57,229,56,57,38,44,42},59))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({40,49,42,38,55,42,41},59))
end
local function killNamedNPC(name, targetPos)
debug(_d({18,52,59,46,51,44,229,57,52},59), name)
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
debug(name, _d({41,42,43,42,38,57,42,41},59))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({17,42,52,229,53,49,38,62,42,41,229,38,51,46,50,38,57,46,52,51,255},59), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({49,42,52,6,51,46,50,17,52,44,44,42,55,229,53,55,46,51,57,229,42,55,55,52,55,255},59), err2) end
end)
end)
if not ok then debug(_d({56,57,38,55,57,17,42,52,6,51,46,50,17,52,44,44,42,55,229,42,55,55,52,55,255},59), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({18,52,59,46,51,44,229,57,52,229,17,42,52},59))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({17,42,52},59))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({17,42,52},59))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({17,42,52},59))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({17,42,52,229,40,38,56,57,46,51,44},59), which, _d({242,229,41,52,41,44,46,51,44},59))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({17,42,52,229,56,57,38,55,57,42,41,229,39,49,52,40,48,242,39,55,42,38,48,42,55,229,50,46,41,242,39,49,52,40,48,230,229,10,59,38,41,46,51,44,243,243,243},59))
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
if not getNPCByName(_d({17,42,52},59)) then
debug(_d({17,42,52,229,44,52,51,42,229,50,46,41,242,41,52,41,44,42,229,242,229,42,51,41,46,51,44,229,10,51,57,42,46,229,45,52,49,41,229,42,38,55,49,62},59))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({17,42,52},59)) then
setNavNamed(_d({17,42,52},59))
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
debug(_d({17,42,52,229,41,42,43,42,38,57,42,41},59))
stopLeoAnimLogger()
debug(_d({23,42,57,58,55,51,46,51,44,229,57,52,229,17,42,52,229,53,52,56,46,57,46,52,51,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,52,51},59))
navToPointConfirmed(COORDS.Leo, 30, _d({17,42,52,229,53,52,56,46,57,46,52,51},59))
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57,229,17,42,52,229,53,52,56,46,57,46,52,51},59))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({18,52,59,46,51,44,229,57,52},59), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({8,52,58,49,41,229,51,52,57,229,43,46,51,41,229,56,57,38,57,58,42,229,50,52,41,42,49,229,51,42,38,55},59), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({6,57,57,38,40,48,46,51,44},59), coordKey, _d({60,46,57,45},59), weapon or _d({51,52,57,45,46,51,44,229,43,52,58,51,41},59))
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
debug(coordKey, _d({39,38,55,55,42,49,229,41,42,56,57,55,52,62,42,41},59))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({242,229,40,52,58,49,41,229,51,52,57,229,43,46,51,41,229,56,57,38,57,58,42,229,50,52,41,42,49,241,229,56,48,46,53,53,46,51,44},59))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({56,57,46,49,49,229,38,49,46,59,42,229,237,13,21},59), hp, _d({238,229,242,229,55,42,242,41,42,56,57,55,52,62,46,51,44},59))
destroyStatue(coordKey)
else
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({40,52,51,43,46,55,50,42,41,229,41,42,56,57,55,52,62,42,41},59))
end
end)
if not ok then debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,229,42,55,55,52,55,255},59), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({18,52,59,46,51,44,229,57,52,229,22,58,42,42,51},59))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
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
debug(_d({22,58,42,42,51,229,42,51,57,42,55,42,41,229,53,45,38,56,42,229,247},59))
end
local function finishQueen()
debug(_d({11,46,51,46,56,45,46,51,44,229,22,58,42,42,51},59))
equipSwordOrMelee()
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
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
debug(_d({22,58,42,42,51,229,41,42,43,42,38,57,42,41,243,229,21,49,38,51,229,40,52,50,53,49,42,57,42,243},59))
end
local CONFIRMATION_PROMPT_NAME = _d({8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57},59)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({23,42,50,52,57,42,10,59,42,51,57},59), 5)
end)
if ok then return result end
debug(_d({44,42,57,23,42,53,49,38,62,23,42,50,52,57,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({21,49,38,62,42,55,12,58,46},59))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({14,50,38,44,42,7,58,57,57,52,51},59)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({39,58,57,57,52,51,27,38,49,58,42},59)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({43,46,51,41,7,58,57,57,52,51,7,62,27,38,49,58,42,229,42,55,55,52,55,255},59), result)
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
if not ok then debug(_d({40,49,46,40,48,12,58,46,7,58,57,57,52,51,229,42,55,55,52,55,255},59), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({46,56,24,42,55,59,42,55},59))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({23,42,50,52,57,42,10,59,42,51,57},59))
or inst:FindFirstChild(_d({40,49,46,42,51,57,10,59,42,51,57},59))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({43,46,51,41,6,51,56,60,42,55,8,52,51,51,42,40,57,52,55,229,42,55,55,52,55,255},59), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({8,52,58,49,41,229,51,52,57,229,49,52,40,38,57,42,229,23,42,50,52,57,42,10,59,42,51,57,244,40,49,46,42,51,57,10,59,42,51,57,229,51,42,38,55,229,23,42,53,49,38,62,229,39,58,57,57,52,51,241,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,40,49,46,40,48},59))
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
debug(_d({43,46,55,42,23,42,53,49,38,62,27,38,49,58,42,229,42,55,55,52,55,255},59), err, _d({242,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,40,49,46,40,48},59))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({11,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,39,58,57,57,52,51,27,38,49,58,42,229,56,42,38,55,40,45,229,43,52,55,229,23,42,53,49,38,62},59))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({23,42,53,49,38,62,229,39,58,57,57,52,51,229,51,52,57,229,43,52,58,51,41,229,42,46,57,45,42,55,241,229,44,46,59,46,51,44,229,58,53},59))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,243,23,42,50,52,57,42,10,59,42,51,57},59))
local remote = getReplayRemote()
if not remote then
debug(_d({8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,244,23,42,50,52,57,42,10,59,42,51,57,229,51,52,57,229,43,52,58,51,41,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57},59))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({11,46,55,46,51,44,229,23,42,53,49,38,62,229,59,46,38,229,8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,243,23,42,50,52,57,42,10,59,42,51,57},59))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({11,46,55,42,24,42,55,59,42,55,229,42,55,55,52,55,255},59), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59), 10)
if not playerGui then
debug(_d({60,38,46,57,11,52,55,20,39,47,42,40,57,46,59,42,56,12,58,46,255,229,51,52,229,21,49,38,62,42,55,12,58,46,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({20,39,47,42,40,57,46,59,42,56,229,12,26,14,229,43,52,58,51,41,229,242,229,56,57,38,44,42,229,49,52,38,41,42,41},59))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({20,39,47,42,40,57,46,59,42,56,229,12,26,14,229,51,52,57,229,43,52,58,51,41,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
return
end
end
end)
if not ok then debug(_d({60,38,46,57,11,52,55,20,39,47,42,40,57,46,59,42,56,12,58,46,229,42,55,55,52,55,255},59), err) end
end
local function runPlan()
debug(_d({21,49,38,51,229,56,57,38,55,57,42,41},59))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({24,57,38,55,57,46,51,44,229,51,38,59,229,49,52,52,53},59))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({53,52,56,229,245,243,247,56,229,6,11,25,10,23,229,56,57,38,55,57,19,38,59,255},59), rootAfter and rootAfter.Position)
end)
debug(_d({28,38,46,57,46,51,44,229,250,56,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,57,52,229,24,57,38,44,42,246},59))
task.wait(5)
for _, stage in ipairs({_d({24,57,38,44,42,246},59), _d({24,57,38,44,42,247},59), _d({24,57,38,44,42,248},59), _d({24,57,38,44,42,248,7},59)}) do
if not enabled then return end
local hpTarget = (stage == _d({24,57,38,44,42,248,7},59)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,57,52,229,38,55,55,52,60,229,43,49,62,242,41,52,60,51,229,38,55,42,38,229,237,8,58,53,46,41,229,23,38,46,51,238},59))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({9,52,41,44,46,51,44,229,38,55,55,52,60,229,55,38,46,51,229,46,51,229,38,229,56,54,58,38,55,42},59))
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
clearStage(_d({24,57,38,44,42,249},59))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({22,58,42,42,51,229,46,51,229,53,45,38,56,42,229,247,229,242,229,48,42,42,53,46,51,44,229,16,42,51,229,13,38,48,46,229,38,40,57,46,59,42,229,43,55,52,50,229,45,42,55,42,229,52,51},59))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({24,57,38,57,58,42,246},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,246},59))
destroyStatue(_d({24,57,38,57,58,42,247},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,246},59))
recheckStatue(_d({24,57,38,57,58,42,247},59))
destroyStatue(_d({24,57,38,57,58,42,248},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,248},59))
recheckStatue(_d({24,57,38,57,58,42,247},59))
recheckStatue(_d({24,57,38,57,58,42,246},59))
if not enabled then return end
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,53,45,38,56,42,229,247,229,57,52,229,42,51,41},59))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({21,45,38,56,42,229,247,229,42,51,41,229,60,38,46,57,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,39,38,40,48,229,57,52,229,22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
navToPointConfirmed(COORDS.Queen, 30, _d({22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57,229,22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
task.wait(5)
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,57,52,229,53,52,56,57,242,22,58,42,42,51,229,53,52,56,46,57,46,52,51},59))
navToPointConfirmed(COORDS.PostQueen, 30, _d({53,52,56,57,242,22,58,42,42,51,229,53,52,56,46,57,46,52,51},59))
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
debug(_d({10,51,38,39,49,46,51,44,241,229,53,52,56,229,7,10,11,20,23,10,229,53,49,38,51,255},59), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({21,49,38,51,229,42,55,55,52,55,255},59), err2) end
end)
debug(_d({10,51,38,39,49,42,41,255},59), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({10,51,38,39,49,42,41,255},59), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
if not Safeguard.RequirePlace(11424731604, _d({8,58,53,46,41,229,9,58,51,44,42,52,51},59)) then
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
_d({8,58,53,46,41,229,9,58,51,44,42,52,51},59),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({15,58,63,52,229,57,45,42,229,9,46,38,50,52,51,41,39,38,40,48},59),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)) then
Core = loadstring(readfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
else
Core = loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
end
end)
if not Core then warn(_d({32,8,52,55,42,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)) or (bp and bp:FindFirstChild(_d({13,52,55,52,242,13,52,55,52},59)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({19,21,8,56},59))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum = boss:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
if key == _d({13,46,57},59) then return target.CFrame
elseif key == _d({25,38,55,44,42,57},59) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({32,13,52,55,52,11,38,55,50,34,229,18,42,57,38,57,38,39,49,42,229,45,52,52,48,229,43,38,46,49,42,41,255,229},59) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({32,13,52,55,52,11,38,55,50,34,229,24,57,52,53,53,42,41,243},59))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({32,13,52,55,52,11,38,55,50,34,229,6,49,55,42,38,41,62,229,55,58,51,51,46,51,44,230},59)); return end
if not Safeguard then warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({32,13,52,55,52,11,38,55,50,34,229,24,57,38,55,57,42,41,229,57,38,55,44,42,57,46,51,44,255,229},59) .. HoroFarm.Config.SelectedBoss)
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
_d({13,52,55,52,11,38,55,50},59),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)) then
Core = loadstring(readfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
else
Core = loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
end
end)
if not Core then warn(_d({32,8,52,55,42,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,24,57,52,53,53,42,41,243},59))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,6,49,55,42,38,41,62,229,55,58,51,51,46,51,44,230},59)); return end
if not Safeguard then warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
if not Safeguard.RequirePlace(3978370137, _d({11,46,55,56,57,229,24,42,38},59)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59), 10)
local hum = char:WaitForChild(_d({13,58,50,38,51,52,46,41},59), 10)
local stats = ReplicatedStorage:WaitForChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({21,42,49,46},59), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59)) or (char and char:FindFirstChild(_d({23,46,43,49,42},59)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,8,58,55,55,42,51,57,229,21,42,49,46,229,40,45,42,40,48,255},59), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,19,52,57,229,38,57,229,25,52,60,51,229,52,43,229,7,42,44,46,51,51,46,51,44,56,243,229,21,49,42,38,56,42,229,57,55,38,59,42,49,229,57,45,42,55,42,229,57,52,229,43,38,55,50,229,40,45,42,56,57,56,229,60,45,46,49,42,229,60,38,46,57,46,51,44,229,43,52,55,229,23,46,43,49,42,243},59))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,40,45,42,56,57,36,43,38,55,50,42,55,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,45,42,56,57,36,43,38,55,50,42,55,243,49,58,38},59))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,38,55,50,46,51,44,229,40,45,42,56,57,56,229,58,51,57,46,49,229,248,245,245,229,21,42,49,46,243,243,243,229,237,8,58,55,55,42,51,57,255,229},59) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({21,42,49,46},59))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59)) or (c and c:FindFirstChild(_d({23,46,43,49,42},59))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({7,58,62,38,39,49,42,14,57,42,50,56},59))
local shopItem = buyables and buyables:FindFirstChild(_d({23,46,43,49,42},59))
local shopPart = shopItem and shopItem:FindFirstChild(_d({24,45,52,53,21,38,55,57},59))
if EasyTravel and shopPart and hrp then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,25,55,38,59,42,49,46,51,44,229,57,52,229,23,46,43,49,42,229,56,45,52,53,229,59,46,38,229,10,38,56,62,25,55,38,59,42,49,243,243,243},59))
local nocollide = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({10,59,42,51,57,56},59)) and ReplicatedStorage.Events:FindFirstChild(_d({24,45,52,53},59))
if shopEvent and shopEvent:IsA(_d({23,42,50,52,57,42,11,58,51,40,57,46,52,51},59)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,10,54,58,46,53,53,46,51,44,229,23,46,43,49,42,243,243,243},59))
local args = {
[1] = _d({42,54,58,46,53},59),
[2] = _d({23,46,43,49,42},59)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({10,59,42,51,57,56},59)) and ReplicatedStorage.Events:FindFirstChild(_d({25,52,52,49,56},59))
if toolsEvent and toolsEvent:IsA(_d({23,42,50,52,57,42,11,58,51,40,57,46,52,51},59)) then
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
local hum = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41},59))
local hrp = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({23,46,43,49,42},59))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,49,62,46,51,44,229,57,52,229,11,46,56,45,50,38,51,229,8,38,59,42,243,243,243},59))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,42,38,56,62,36,57,55,38,59,42,49,243,49,58,38},59))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,10,56,40,38,53,46,51,44,229,56,45,52,53,229,46,51,57,42,55,46,52,55,229,39,62,229,43,49,62,46,51,44,229,56,57,55,38,46,44,45,57,229,58,53,243,243,243},59))
local nocollide = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({7,38,56,42,21,38,55,57},59)) then
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
local runService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
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
print(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,49,62,46,51,44,229,57,52,229,11,46,56,45,50,38,51,229,8,38,59,42,243,243,243},59))
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
local FishmanMaze = Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,43,46,56,45,50,38,51,36,50,38,63,42,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,43,46,56,45,50,38,51,36,50,38,63,42,243,49,58,38},59))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,11,38,46,49,42,41,229,57,52,229,46,50,53,52,55,57,229,11,46,56,45,50,38,51,18,38,63,42,229,49,46,39,55,38,55,62,230},59))
end
else
warn(_d({32,17,42,59,42,49,229,12,55,46,51,41,42,55,34,229,20,58,57,56,46,41,42,229,11,46,56,45,50,38,51,229,8,38,59,42,229,39,52,58,51,41,56,241,229,56,48,46,53,53,46,51,44,229,50,38,63,42,243},59))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({17,42,59,42,49,229,12,55,46,51,41,42,55},59),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local RunService       = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)) then
Core = loadstring(readfile(_d({245,246,242,44,53,52,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
else
Core = loadstring(game:HttpGet(_d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,40,52,55,42,243,49,58,38},59)))()
end
end)
if not Core then warn(_d({32,8,52,55,42,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
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
return char, char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)), char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({36,36,10,38,56,62,25,55,38,59,42,49,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,10,38,56,62,25,55,38,59,42,49,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,10,38,56,62,25,55,38,59,42,49,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,10,38,56,62,25,55,38,59,42,49,11,52,55,40,42},59)
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
local force = root:FindFirstChild(_d({36,36,10,38,56,62,25,55,38,59,42,49,11,52,55,40,42},59))
local att = root:FindFirstChild(_d({36,36,10,38,56,62,25,55,38,59,42,49,6,57,57},59))
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
local cave = Workspace.Islands:FindFirstChild(_d({11,46,56,45,50,38,51,229,8,38,59,42},59))
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
if not Safeguard then warn(_d({32,24,38,43,42,44,58,38,55,41,34,229,11,38,46,49,42,41,229,57,52,229,49,52,38,41,230},59)); return end
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
print(_d({32,10,38,56,62,229,25,55,38,59,42,49,34,229,11,49,46,44,45,57,229,42,51,38,39,49,42,41,243},59))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({32,10,38,56,62,229,25,55,38,59,42,49,34,229,11,49,46,44,45,57,229,41,46,56,38,39,49,42,41,243},59))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({10,38,56,62,229,25,55,38,59,42,49},59),
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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local RunService = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({46,41,49,42},59)
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
print(_d({32,20,59,42,55,60,52,55,49,41,25,42,56,57,42,55,34},59), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({23,52,48,58,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,42,53,53,52},59), args)
elseif style == _d({7,49,38,40,48,17,42,44},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48},59), args)
elseif style == _d({16,38,50,46,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,38,50,46,56,45,46,48,46,12,42,53,53,52},59), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48,247},59), args)
end
debug(_d({11,46,55,42,41,229,12,42,53,53,52,229,23,42,50,52,57,42},59))
end)
if not ok then debug(_d({46,51,59,52,48,42,12,42,53,53,52,229,42,55,55,52,55,255},59), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({36,36,25,42,56,57,13,52,59,42,55,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,25,42,56,57,13,52,59,42,55,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,25,42,56,57,13,52,59,42,55,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,25,42,56,57,13,52,59,42,55,11,52,55,40,42},59)
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
local root = char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local force = root:FindFirstChild(_d({36,36,25,42,56,57,13,52,59,42,55,11,52,55,40,42},59))
local att   = root:FindFirstChild(_d({36,36,25,42,56,57,13,52,59,42,55,6,57,57},59))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({28,38,49,48,46,51,44,229,57,52,255},59), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({60,38,49,48,25,52,21,52,46,51,57,229,28,229,41,52,60,51,229,42,55,55,52,55,255},59), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({6,55,55,46,59,42,41,229,38,57,255},59), pos)
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
if item:IsA(_d({18,52,41,42,49},59)) and item:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59)) and item:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59)).Health > 0 then
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
mode = _d({46,41,49,42},59)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({25,42,56,57,42,55,229,9,46,56,38,39,49,42,41},59))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({25,42,56,57,42,55,229,10,51,38,39,49,42,41,243,229,18,52,41,42,255},59), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({21,49,38,62,42,55,229,41,46,42,41,230,229,9,46,56,38,39,49,46,51,44,229,39,52,57,243},59))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({45,52,59,42,55},59) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({41,52,41,44,42},59) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({56,54,58,38,55,42,36,41,52,41,44,42},59) then
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
local playerGui = LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({20,59,42,55,60,52,55,49,41,25,42,56,57,12,58,46},59))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({24,40,55,42,42,51,12,58,46},59))
screenGui.Name = _d({20,59,42,55,60,52,55,49,41,25,42,56,57,12,58,46},59)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({11,55,38,50,42},59))
frame.Name = _d({18,38,46,51,11,55,38,50,42},59)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({26,14,8,52,55,51,42,55},59))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({181,100,96,102,180,125,84,229,8,58,53,46,41,229,10,51,44,46,51,42,229,20,59,42,55,60,52,55,49,41,229,25,42,56,57},59)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({24,57,38,57,58,56,255,229,14,41,49,42},59)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({26,14,8,52,55,51,42,55},59), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({25,42,61,57,7,52,61},59))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({26,14,8,52,55,51,42,55},59), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({13,52,59,42,55,229,6,39,52,59,42,229,25,38,55,44,42,57},59), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({45,52,59,42,55},59))
statusLabel.Text = _d({24,57,38,57,58,56,255,229,13,52,59,42,55,46,51,44,229},59) .. val .. _d({229,56,57,58,41,56,229,58,53},59)
end)
createInputBtn(_d({9,52,41,44,42,229,8,49,46,50,39},59), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({41,52,41,44,42},59))
statusLabel.Text = _d({24,57,38,57,58,56,255,229,9,52,41,44,42,242,45,52,49,41,46,51,44,229,237},59) .. val .. _d({229,56,57,58,41,56,238},59)
end)
createInputBtn(_d({25,42,56,57,229,24,54,58,38,55,42,229,9,52,41,44,42},59), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({56,54,58,38,55,42,36,41,52,41,44,42},59))
statusLabel.Text = _d({24,57,38,57,58,56,255,229,24,54,58,38,55,42,229,28,38,49,48,46,51,44,229,237},59) .. val .. _d({229,56,57,58,41,56,238},59)
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
while enabled and mode == _d({56,54,58,38,55,42,36,41,52,41,44,42},59) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({56,54,58,38,55,42,36,41,52,41,44,42},59) then
disableBot()
statusLabel.Text = _d({24,57,38,57,58,56,255,229,14,41,49,42,229,237,24,54,58,38,55,42,229,41,52,41,44,42,229,41,52,51,42,238},59)
end
end)
end)
local stopBtn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({10,18,10,23,12,10,19,8,30,229,24,25,20,21},59)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({26,14,8,52,55,51,42,55},59), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({24,57,38,57,58,56,255,229,24,25,20,21,21,10,9,229,237,14,41,49,42,238},59)
local VIM = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({32,20,59,42,55,60,52,55,49,41,25,42,56,57,42,55,34,229,17,52,38,41,42,41,229,56,58,40,40,42,56,56,43,58,49,49,62,243},59))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({12,21,20,17,38,58,51,40,45,42,55,26,14},59))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({24,40,55,42,42,51,12,58,46},59))
screenGui.Name = _d({12,21,20,17,38,58,51,40,45,42,55,26,14},59)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({11,55,38,50,42},59))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({26,14,8,52,55,51,42,55},59))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({26,14,24,57,55,52,48,42},59))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({181,100,81,81,229,12,21,20,229,13,58,39,229,17,38,58,51,40,45,42,55},59)
title.Parent = main
local closeBtn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({26,14,8,52,55,51,42,55},59), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({8,45,52,52,56,42,229,38,229,39,52,57,229,52,55,229,58,57,46,49,46,57,62,229,57,52,229,55,58,51,255},59)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({25,42,61,57,7,58,57,57,52,51},59))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({229,229},59) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({26,14,8,52,55,51,42,55},59))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({26,14,24,57,55,52,48,42},59))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({25,42,61,57,17,38,39,42,49},59))
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
CreateLaunchButton(_d({8,58,53,46,41,229,9,58,51,44,42,52,51,229,11,38,55,50},59), _d({6,58,57,52,50,38,57,42,229,40,58,53,46,41,229,41,58,51,44,42,52,51,56,229,235,229,39,52,56,56,229,40,62,40,49,42,56},59), loadCupidDungeon)
CreateLaunchButton(_d({13,52,55,52,229,7,52,56,56,229,11,38,55,50,229,237,24,46,49,42,51,57,229,6,46,50,238},59), _d({6,58,57,52,43,38,55,50,229,52,59,42,55,60,52,55,49,41,229,39,52,56,56,42,56,229,58,56,46,51,44,229,13,52,55,52,229,43,55,58,46,57,56},59), loadHoroBossFarm)
CreateLaunchButton(_d({17,42,59,42,49,229,235,229,18,52,39,229,12,55,46,51,41,42,55},59), _d({6,58,57,52,242,49,42,59,42,49,229,38,51,41,229,43,38,55,50,229,49,52,40,38,49,229,19,21,8,229,50,52,39,56},59), loadLevelGrinder)
CreateLaunchButton(_d({10,38,56,62,229,25,55,38,59,42,49,229,237,21,229,25,52,44,44,49,42,238},59), _d({28,6,24,9,229,11,49,46,44,45,57,229,60,46,57,45,229,44,55,52,58,51,41,229,43,52,49,49,52,60,229,235,229,60,38,49,49,229,40,49,46,50,39,46,51,44},59), loadNavigationLab)
CreateLaunchButton(_d({21,45,62,56,46,40,56,229,20,59,42,55,60,52,55,49,41,229,25,42,56,57,42,55},59), _d({25,42,56,57,229,40,52,50,39,38,57,229,45,52,59,42,55,241,229,44,42,53,53,52,229,235,229,41,52,41,44,42,229,45,42,46,44,45,57,56},59), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({32,12,21,20,229,13,58,39,34,229,17,38,58,51,40,45,42,55,229,26,14,229,46,51,46,57,46,38,49,46,63,42,41,243},59))
end)()