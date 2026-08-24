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
local Players            = game:GetService(_d({18,46,35,59,39,52,53},62))
local UserInputService    = game:GetService(_d({23,53,39,52,11,48,50,55,54,21,39,52,56,43,37,39},62))
local RunService          = game:GetService(_d({20,55,48,21,39,52,56,43,37,39},62))
local VIM                 = game:GetService(_d({24,43,52,54,55,35,46,11,48,50,55,54,15,35,48,35,41,39,52},62))
local ReplicatedStorage    = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({29,4,49,53,53,4,49,54,31},62), _d({25,52,49,48,41,226,41,35,47,39,226,164,66,86,226,18,46,35,37,39,11,38,252},62), game.PlaceId, _d({23,48,43,56,39,52,53,39,11,38,252},62), game.GameId, _d({239,226,48,49,54,226,52,55,48,48,43,48,41},62))
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
local LEO_PILLAR_ANIM_ID   = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,247,244,246,246,243,246,243,245,244,249},62)
local LEO_ENTEI_ANIM_ID    = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,247,244,246,246,243,245,250,244,249,250},62)
local LEO_HIKEN_ANIM_ID    = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,247,244,244,242,251,243,249,246,242,249},62)
local LEO_FIREFLY_ANIM_ID  = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,247,244,244,242,244,245,248,243,247,246},62)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({17,36,44,39,37,54,43,56,39,53},62)
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
local REPLAY_BUTTON_VALUE   = _d({20,39,50,46,35,59},62)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({47,49,56,39},62)
local NavState   = {mode = _d({43,38,46,39},62)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({29,4,49,53,53,4,49,54,31},62), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
end)
if ok then return root end
debug(_d({41,39,54,20,49,49,54,226,39,52,52,49,52,252},62), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
end)
if ok then return hum end
debug(_d({41,39,54,10,55,47,35,48,49,43,38,226,39,52,52,49,52,252},62), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({33,33,10,49,56,39,52,3,54,54},62)) or Instance.new(_d({3,54,54,35,37,42,47,39,48,54},62))
att.Name = _d({33,33,10,49,56,39,52,3,54,54},62)
att.Parent = root
local force = root:FindFirstChild(_d({33,33,10,49,56,39,52,8,49,52,37,39},62))
if not force then
force = Instance.new(_d({14,43,48,39,35,52,24,39,46,49,37,43,54,59},62))
force.Name = _d({33,33,10,49,56,39,52,8,49,52,37,39},62)
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
debug(_d({41,39,54,17,52,5,52,39,35,54,39,8,49,52,37,39,226,39,52,52,49,52,252},62), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if not root then return end
local force = root:FindFirstChild(_d({33,33,10,49,56,39,52,8,49,52,37,39},62))
local att   = root:FindFirstChild(_d({33,33,10,49,56,39,52,3,54,54},62))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({37,46,39,35,48,55,50,8,49,52,37,39,226,39,52,52,49,52,252},62), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({4,55,53,49,15,39,46,39,39},62)) ~= nil
end)
if ok then return result end
debug(_d({43,53,4,55,53,49,3,37,54,43,56,39,226,39,52,52,49,52,252},62), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({4,55,53,49},62))
end)
if not ok then debug(_d({35,37,54,43,56,35,54,39,4,55,53,49,226,39,52,52,49,52,252},62), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({4,55,53,49,226,48,49,54,226,35,37,54,43,56,39,238,226,35,37,54,43,56,35,54,43,48,41},62))
activateBuso()
end
end)
if not ok then debug(_d({4,55,53,49,13,39,39,50,39,52,226,39,52,52,49,52,252},62), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({4,55,53,49,226,45,39,39,50,39,52,226,53,54,49,50,50,39,38},62))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({13,39,48,10,35,45,43},62)) ~= nil
end)
if ok then return result end
debug(_d({43,53,13,39,48,3,37,54,43,56,39,226,39,52,52,49,52,252},62), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({13,39,48},62), true)
end)
if not ok then debug(_d({35,37,54,43,56,35,54,39,13,39,48,226,39,52,52,49,52,252},62), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({13,39,48,226,48,49,54,226,35,37,54,43,56,39,238,226,35,37,54,43,56,35,54,43,48,41},62))
activateKen()
end
end)
if not ok then debug(_d({13,39,48,13,39,39,50,39,52,226,39,52,52,49,52,252},62), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({13,39,48,226,45,39,39,50,39,52,226,53,54,49,50,50,39,38},62))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({16,18,5,53},62)) end)
if ok then return folder end
debug(_d({41,39,54,16,18,5,53,8,49,46,38,39,52,226,39,52,52,49,52,252},62), folder)
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
local r = model:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local h = model:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
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
debug(_d({41,39,54,16,39,35,52,39,53,54,16,18,5,226,39,52,52,49,52,252},62), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
local hum  = model:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({41,39,54,16,18,5,4,59,16,35,47,39,226,39,52,52,49,52,252},62), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({48,50,37,53,20,39,47,35,43,48,43,48,41,226,39,52,52,49,52,252},62), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({5,55,50,43,38,226,19,55,39,39,48},62))
return queen ~= nil and queen:FindFirstChild(_d({47,49,54,43,49,48,14,39,53,53},62)) ~= nil
end)
if ok then return result end
debug(_d({43,53,19,55,39,39,48,18,42,35,53,39,244,226,39,52,52,49,52,252},62), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,243,244,243,244,251,249,251,246,244,244,251,244,249,248,251},62)
local QUEEN_GRASP_ANIM_ID   = _d({52,36,58,35,53,53,39,54,43,38,252,241,241,243,244,251,250,242,242,242,248,243,242,242,243,249,245,246},62)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
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
debug(_d({43,53,18,46,35,59,43,48,41,3,48,43,47,8,52,49,47,14,43,53,54,226,39,52,52,49,52,252},62), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({4,46,49,37,45,43,48,41},62)) ~= nil
end)
if ok then return result end
debug(_d({43,53,16,18,5,4,46,49,37,45,43,48,41,226,39,52,52,49,52,252},62), result)
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
debug(_d({50,52,39,38,43,37,54,16,18,5,18,49,53,43,54,43,49,48,226,39,52,52,49,52,252},62), result)
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
debug(_d({16,49,226,38,35,47,35,41,39,226,49,48},62), model.Name, _d({40,49,52},62), NPC_STUCK_TIMEOUT, _d({53,226,239,226,53,57,43,54,37,42,43,48,41,226,54,35,52,41,39,54},62))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({54,52,35,37,45,16,18,5,6,35,47,35,41,39,226,39,52,52,49,52,252},62), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({15,49,38,39,46},62)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({4,35,53,39,18,35,52,54},62)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({41,39,54,15,49,38,39,46,8,35,37,39,18,49,53,226,39,52,52,49,52,252},62), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({7,48,56},62))
local folder = env and env:FindFirstChild(_d({21,54,35,54,55,39,53},62))
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
debug(_d({41,39,54,21,54,35,54,55,39,15,49,38,39,46,16,39,35,52,226,39,52,52,49,52,252},62), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({36,35,52,52,39,46,10,18},62))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({41,39,54,21,54,35,54,55,39,10,18,226,39,52,52,49,52,252},62), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({40,43,48,38,22,49,49,46,4,59,3,54,54,52,43,36,55,54,39,226,39,52,52,49,52,252},62), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({22,49,49,46},62)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({40,43,48,38,22,49,49,46,4,59,16,35,47,39,226,39,52,52,49,52,252},62), tool)
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
if not ok then debug(_d({39,51,55,43,50,22,49,49,46,226,39,52,52,49,52,252},62), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({4,35,37,45,50,35,37,45},62))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({22,49,49,46},62)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({40,43,48,38,22,49,49,46,4,59,5,42,43,46,38,16,35,47,39,226,39,52,52,49,52,252},62), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({21,57,49,52,38,7,51,55,43,50},62))
if sword then
equipTool(sword)
return _d({53,57,49,52,38},62)
end
local melee = findToolByAttribute(_d({15,39,46,39,39,22,49,49,46},62))
if melee then
equipTool(melee)
return _d({47,39,46,39,39},62)
end
debug(_d({16,49,226,53,57,49,52,38,226,49,52,226,47,39,46,39,39,226,54,49,49,46,226,40,49,55,48,38},62))
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
if not ok then debug(_d({37,46,43,37,45,15,243,226,39,52,52,49,52,252},62), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({10,55,47,35,48,49,43,38,20,49,49,54,18,35,52,54},62))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({21,54,35,54,53},62) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({20,49,45,55,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({9,39,50,50,49},62), args)
elseif style == _d({4,46,35,37,45,14,39,41},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45},62), args)
elseif style == _d({13,35,47,43,53,42,43,45,43},62) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({13,35,47,43,53,42,43,45,43,9,39,50,50,49},62), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,45,59,226,25,35,46,45,244},62), args)
end
end)
if not ok then debug(_d({43,48,56,49,45,39,9,39,50,50,49,226,39,52,52,49,52,252},62), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({50,52,39,53,53,21,45,43,46,46,20,226,39,52,52,49,52,252},62), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({42,49,46,38,4,46,49,37,45,226,39,52,52,49,52,252},62), err) end
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
if not ok then debug(_d({42,49,46,38,4,46,49,37,45,25,42,43,46,39,226,39,52,52,49,52,252},62), err) end
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
debug(_d({41,39,54,9,35,47,39,9,226,39,52,52,49,52,252},62), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({43,53,20,39,35,46,15,243,4,55,53,59,226,39,52,52,49,52,252},62), result)
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
return char ~= nil and char:FindFirstChild(_d({53,54,55,48},62)) ~= nil
end)
if ok then return result end
debug(_d({43,53,21,54,55,48,48,39,38,226,39,52,52,49,52,252},62), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({50,52,39,53,53,21,54,55,48,4,52,39,35,45,226,39,52,52,49,52,252},62), err) end
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
local root = Core.GetRoot(LocalPlayer)
local myPos = root and root.Position or info.root.Position
navToPoint(myPos + Vector3.new(0, QUEEN_DODGE_DISTANCE, 0), true)
local t = 0
local sinceGeppo = 0
while enabled do
if isStunned() then pressStunBreak() end
info = getInfoFn()
if not info then
debug(_d({51,55,39,39,48,6,49,38,41,39,23,48,54,43,46,21,35,40,39,252,226,19,55,39,39,48,226,41,49,48,39,226,239,226,39,48,38,43,48,41,226,38,49,38,41,39,226,39,35,52,46,59},62))
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
debug(_d({51,55,39,39,48,6,49,38,41,39,23,48,54,43,46,21,35,40,39,226,53,35,40,39,54,59,226,54,43,47,39,49,55,54},62))
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
local info = getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({19,55,39,39,48,226,37,35,53,54,43,48,41,226,38,39,54,39,37,54,39,38,226,239,226,38,49,38,41,43,48,41,226,234,57,35,54,37,42,39,52,235},62))
queenDodgeUntilSafe(function() return getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62)) end)
if enabled and getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62)) then
setNavNamed(_d({5,55,50,43,38,226,19,55,39,39,48},62))
end
queenDodging = false
end
end)
if not ok then debug(_d({51,55,39,39,48,6,49,38,41,39,25,35,54,37,42,39,52,226,39,52,52,49,52,252},62), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({50,49,43,48,54},62) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({48,50,37},62) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({48,35,47,39,38},62) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({41,39,54,16,35,56,22,35,52,41,39,54,53,226,39,52,52,49,52,252},62), aimR)
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
debug(_d({37,49,47,50,55,54,39,14,49,37,45,39,38,5,8,52,35,47,39,226,39,52,52,49,52,252},62), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({50,49,43,48,54},62), point = pos}
phase = _d({47,49,56,39},62)
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
if not ok then debug(_d({48,35,56,22,49,18,49,43,48,54,226,41,39,50,50,49,226,37,42,39,37,45,226,39,52,52,49,52,252},62), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({48,50,37},62)}
phase = _d({47,49,56,39},62)
end
function setNavNamed(name)
NavState = {mode = _d({48,35,47,39,38},62), name = name}
phase = _d({47,49,56,39},62)
end
local function setNavIdle()
NavState = {mode = _d({43,38,46,39},62)}
phase = _d({47,49,56,39},62)
end
local function hasArrived()
return phase == _d({42,49,56,39,52},62)
end
local function startNav()
phase = _d({47,49,56,39},62)
debug(_d({16,35,56,226,46,49,49,50,226,17,16},62))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
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
local prevPos = force:GetAttribute(_d({33,33,50,52,39,56,18,49,53},62))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({14,35,52,41,39,226,50,49,53,43,54,43,49,48,226,44,55,47,50,226,38,39,54,39,37,54,39,38,252},62), delta, _d({53,54,55,38,53,240,226,50,52,39,56,18,49,53,255},62), prevPos, _d({48,39,57,18,49,53,255},62), pos)
end
end
force:SetAttribute(_d({33,33,50,52,39,56,18,49,53},62), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({47,49,56,39},62) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({42,49,56,39,52},62)
debug(_d({18,42,35,53,39,252,226,42,49,56,39,52},62))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({227,227,227,226,20,7,8,23,21,11,16,9,226,22,17,226,3,18,18,14,27,226,3,4,16,17,20,15,3,14,226,24,7,14,17,5,11,22,27,252},62), finalVel, _d({35,43,47,255},62), aim, _d({50,49,53,255},62), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({42,49,56,39,52},62) then
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
debug(_d({5,49,47,36,35,54,226,46,49,37,45,226,53,45,43,50,50,39,38,238},62), snapDist, _d({53,54,55,38,53,226,40,52,49,47,226,54,35,52,41,39,54,226,164,66,86,226,40,35,46,46,43,48,41,226,36,35,37,45,226,54,49,226,47,49,56,39},62))
phase = _d({47,49,56,39},62)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({10,39,35,52,54,36,39,35,54,226,39,52,52,49,52,252},62), err) end
end)
end
local function stopNav()
debug(_d({16,35,56,226,46,49,49,50,226,17,8,8},62))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({47,49,56,39},62)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({22,39,58,54,5,42,35,54,21,39,52,56,43,37,39},62))
local channels = TextChatService:FindFirstChild(_d({22,39,58,54,5,42,35,48,48,39,46,53},62))
local channel = channels and channels:FindFirstChild(_d({20,4,26,9,39,48,39,52,35,46},62))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({6,39,40,35,55,46,54,5,42,35,54,21,59,53,54,39,47,5,42,35,54,7,56,39,48,54,53},62))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({21,35,59,15,39,53,53,35,41,39,20,39,51,55,39,53,54},62))
if sayEvent then
sayEvent:FireServer(message, _d({3,46,46},62))
return
end
debug(_d({53,39,48,38,5,42,35,54,15,39,53,53,35,41,39,252,226,48,49,226,22,39,58,54,5,42,35,54,21,39,52,56,43,37,39,240,20,4,26,9,39,48,39,52,35,46,226,49,52,226,46,39,41,35,37,59,226,21,35,59,15,39,53,53,35,41,39,20,39,51,55,39,53,54,226,40,49,55,48,38,226,40,49,52},62), message)
end)
if not ok then debug(_d({53,39,48,38,5,42,35,54,15,39,53,53,35,41,39,226,39,52,52,49,52,252},62), err) end
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
debug(_d({16,49,54,226,47,35,45,43,48,41,226,50,52,49,41,52,39,53,53,226,54,49,57,35,52,38,226,48,35,56,226,54,35,52,41,39,54,226,40,49,52},62), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({53,226,239,226,53,39,48,38,43,48,41,226,241,55,48,53,54,55,37,45},62))
sendChatMessage(_d({241,55,48,53,54,55,37,45},62))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({57,35,43,54,23,48,54,43,46,3,52,52,43,56,39,38,226,54,43,47,39,49,55,54},62))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({48,35,56,22,49,18,49,43,48,54,5,49,48,40,43,52,47,39,38,252},62), label or _d({54,35,52,41,39,54},62), _d({239,226,38,43,38,226,48,49,54,226,35,52,52,43,56,39,226,57,43,54,42,43,48},62), timeout, _d({53,238,226,52,39,54,52,59,43,48,41,226,49,48,37,39},62))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({48,35,56,22,49,18,49,43,48,54,5,49,48,40,43,52,47,39,38,252},62), label or _d({54,35,52,41,39,54},62), _d({239,226,53,54,43,46,46,226,48,49,54,226,35,52,52,43,56,39,38,226,35,40,54,39,52,226,52,39,54,52,59,238,226,50,52,49,37,39,39,38,43,48,41,226,35,48,59,57,35,59},62))
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
if not ok then debug(_d({48,35,56,22,49,18,49,43,48,54,10,49,46,38,43,48,41,4,46,49,37,45,226,45,39,59,239,38,49,57,48,226,39,52,52,49,52,252},62), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({48,35,56,22,49,18,49,43,48,54,10,49,46,38,43,48,41,4,46,49,37,45,226,45,39,59,239,55,50,226,39,52,52,49,52,252},62), err2) end
end
local function clearStage(stageName)
debug(_d({15,49,56,43,48,41,226,54,49},62), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({25,35,43,54,43,48,41,226,40,49,52,226,16,18,5,53,226,54,49,226,53,50,35,57,48,226,35,54},62), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({226,226,53,50,35,57,48,226,37,42,39,37,45,252,226,40,49,46,38,39,52,226,39,58,43,53,54,53,226,255},62), folder ~= nil,
_d({238,226,37,42,43,46,38,52,39,48,226,255},62), folder and #folder:GetChildren() or 0,
_d({238,226,35,46,43,56,39,226,255},62), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({16,49,226,16,18,5,53,226,35,50,50,39,35,52,39,38,226,35,54},62), stageName, _d({35,40,54,39,52,226,243,247,53,238,226,47,49,56,43,48,41,226,49,48,226,35,48,59,57,35,59},62))
break
end
end
debug(_d({13,43,46,46,43,48,41,226,16,18,5,53,226,35,54},62), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({20,39,54,55,52,48,43,48,41,226,54,49},62), stageName, _d({50,49,53,43,54,43,49,48,226,36,39,40,49,52,39,226,47,49,56,43,48,41,226,49,48},62))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({25,35,43,54,43,48,41,226,247,53,226,35,54},62), stageName, _d({50,49,53,43,54,43,49,48},62))
task.wait(5)
debug(stageName, _d({37,46,39,35,52,39,38},62))
end
local function killNamedNPC(name, targetPos)
debug(_d({15,49,56,43,48,41,226,54,49},62), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({38,39,40,39,35,54,39,38},62))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({10,55,47,35,48,49,43,38},62))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({14,39,49,226,50,46,35,59,39,38,226,35,48,43,47,35,54,43,49,48,252},62), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({46,39,49,3,48,43,47,14,49,41,41,39,52,226,50,52,43,48,54,226,39,52,52,49,52,252},62), err2) end
end)
end)
if not ok then debug(_d({53,54,35,52,54,14,39,49,3,48,43,47,14,49,41,41,39,52,226,39,52,52,49,52,252},62), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({15,49,56,43,48,41,226,54,49,226,14,39,49,226,234,36,46,49,37,45,43,48,41,226,35,40,54,39,52},62), LEO_BLOCK_DELAY, _d({53,235},62))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({14,39,49},62))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({14,39,49},62))
while enabled do
local info = getNPCByName(_d({14,39,49},62))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({14,39,49,226,37,35,53,54,43,48,41},62), which, _d({239,226,38,49,38,41,43,48,41},62))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
holdBlock(LEO_QUICK_BLOCK_DURATION)
else
local root = Core.GetRoot(LocalPlayer)
local myPos = root and root.Position or info.root.Position
local awayPoint = myPos + Vector3.new(0, LEO_DODGE_DISTANCE, 0)
navToPoint(awayPoint, true)
if which == LEO_ENTEI_ANIM_ID then
local held = 0
while enabled and held < 6 do
task.wait(GEPPO_HOLD_INTERVAL)
held += GEPPO_HOLD_INTERVAL
if not getNPCByName(_d({14,39,49},62)) then
debug(_d({14,39,49,226,41,49,48,39,226,47,43,38,239,38,49,38,41,39,226,239,226,39,48,38,43,48,41,226,7,48,54,39,43,226,42,49,46,38,226,39,35,52,46,59},62))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({14,39,49},62)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({14,39,49,226,41,49,48,39,226,47,43,38,239,38,49,38,41,39,226,239,226,39,48,38,43,48,41,226,8,46,35,47,39,226,18,43,46,46,35,52,226,42,49,46,38,226,39,35,52,46,59},62))
end
end
end
if enabled and getNPCByName(_d({14,39,49},62)) then
setNavNamed(_d({14,39,49},62))
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
debug(_d({14,39,49,226,38,39,40,39,35,54,39,38},62))
stopLeoAnimLogger()
debug(_d({20,39,54,55,52,48,43,48,41,226,54,49,226,14,39,49,226,50,49,53,43,54,43,49,48,226,36,39,40,49,52,39,226,47,49,56,43,48,41,226,49,48},62))
navToPointConfirmed(COORDS.Leo, 30, _d({14,39,49,226,50,49,53,43,54,43,49,48},62))
debug(_d({25,35,43,54,43,48,41,226,247,53,226,35,54,226,14,39,49,226,50,49,53,43,54,43,49,48},62))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({15,49,56,43,48,41,226,54,49},62), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({5,49,55,46,38,226,48,49,54,226,40,43,48,38,226,53,54,35,54,55,39,226,47,49,38,39,46,226,48,39,35,52},62), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({3,54,54,35,37,45,43,48,41},62), coordKey, _d({57,43,54,42},62), weapon or _d({48,49,54,42,43,48,41,226,40,49,55,48,38},62))
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
debug(coordKey, _d({36,35,52,52,39,46,226,38,39,53,54,52,49,59,39,38},62))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({52,39,37,42,39,37,45,21,54,35,54,55,39,252},62), coordKey, _d({239,226,37,49,55,46,38,226,48,49,54,226,40,43,48,38,226,53,54,35,54,55,39,226,47,49,38,39,46,238,226,53,45,43,50,50,43,48,41},62))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({52,39,37,42,39,37,45,21,54,35,54,55,39,252},62), coordKey, _d({53,54,43,46,46,226,35,46,43,56,39,226,234,10,18},62), hp, _d({235,226,239,226,52,39,239,38,39,53,54,52,49,59,43,48,41},62))
destroyStatue(coordKey)
else
debug(_d({52,39,37,42,39,37,45,21,54,35,54,55,39,252},62), coordKey, _d({37,49,48,40,43,52,47,39,38,226,38,39,53,54,52,49,59,39,38},62))
end
end)
if not ok then debug(_d({52,39,37,42,39,37,45,21,54,35,54,55,39,226,39,52,52,49,52,252},62), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({15,49,56,43,48,41,226,54,49,226,19,55,39,39,48},62))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({5,55,50,43,38,226,19,55,39,39,48},62))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({19,55,39,39,48,226,39,48,54,39,52,39,38,226,50,42,35,53,39,226,244},62))
end
local function finishQueen()
debug(_d({8,43,48,43,53,42,43,48,41,226,19,55,39,39,48},62))
equipSwordOrMelee()
setNavNamed(_d({5,55,50,43,38,226,19,55,39,39,48},62))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({5,55,50,43,38,226,19,55,39,39,48},62))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({19,55,39,39,48,226,38,39,40,39,35,54,39,38,240,226,18,46,35,48,226,37,49,47,50,46,39,54,39,240},62))
end
local CONFIRMATION_PROMPT_NAME = _d({5,49,48,40,43,52,47,35,54,43,49,48,18,52,49,47,50,54},62)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({20,39,47,49,54,39,7,56,39,48,54},62), 5)
end)
if ok then return result end
debug(_d({41,39,54,20,39,50,46,35,59,20,39,47,49,54,39,226,39,52,52,49,52,252},62), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({18,46,35,59,39,52,9,55,43},62))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({11,47,35,41,39,4,55,54,54,49,48},62)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({36,55,54,54,49,48,24,35,46,55,39},62)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({40,43,48,38,4,55,54,54,49,48,4,59,24,35,46,55,39,226,39,52,52,49,52,252},62), result)
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
if not ok then debug(_d({37,46,43,37,45,9,55,43,4,55,54,54,49,48,226,39,52,52,49,52,252},62), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({43,53,21,39,52,56,39,52},62))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({20,39,47,49,54,39,7,56,39,48,54},62))
or inst:FindFirstChild(_d({37,46,43,39,48,54,7,56,39,48,54},62))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({40,43,48,38,3,48,53,57,39,52,5,49,48,48,39,37,54,49,52,226,39,52,52,49,52,252},62), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({5,49,55,46,38,226,48,49,54,226,46,49,37,35,54,39,226,20,39,47,49,54,39,7,56,39,48,54,241,37,46,43,39,48,54,7,56,39,48,54,226,48,39,35,52,226,20,39,50,46,35,59,226,36,55,54,54,49,48,238,226,40,35,46,46,43,48,41,226,36,35,37,45,226,54,49,226,37,46,43,37,45},62))
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
debug(_d({40,43,52,39,20,39,50,46,35,59,24,35,46,55,39,226,39,52,52,49,52,252},62), err, _d({239,226,40,35,46,46,43,48,41,226,36,35,37,45,226,54,49,226,37,46,43,37,45},62))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({8,35,46,46,43,48,41,226,36,35,37,45,226,54,49,226,36,55,54,54,49,48,24,35,46,55,39,226,53,39,35,52,37,42,226,40,49,52,226,20,39,50,46,35,59},62))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({20,39,50,46,35,59,226,36,55,54,54,49,48,226,48,49,54,226,40,49,55,48,38,226,39,43,54,42,39,52,238,226,41,43,56,43,48,41,226,55,50},62))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({25,35,43,54,43,48,41,226,40,49,52,226,5,49,48,40,43,52,47,35,54,43,49,48,18,52,49,47,50,54,240,20,39,47,49,54,39,7,56,39,48,54},62))
local remote = getReplayRemote()
if not remote then
debug(_d({5,49,48,40,43,52,47,35,54,43,49,48,18,52,49,47,50,54,241,20,39,47,49,54,39,7,56,39,48,54,226,48,49,54,226,40,49,55,48,38,226,57,43,54,42,43,48,226,54,43,47,39,49,55,54},62))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({8,43,52,43,48,41,226,20,39,50,46,35,59,226,56,43,35,226,5,49,48,40,43,52,47,35,54,43,49,48,18,52,49,47,50,54,240,20,39,47,49,54,39,7,56,39,48,54},62))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({8,43,52,39,21,39,52,56,39,52,226,39,52,52,49,52,252},62), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({18,46,35,59,39,52,9,55,43},62), 10)
if not playerGui then
debug(_d({57,35,43,54,8,49,52,17,36,44,39,37,54,43,56,39,53,9,55,43,252,226,48,49,226,18,46,35,59,39,52,9,55,43,226,57,43,54,42,43,48,226,54,43,47,39,49,55,54,238,226,50,52,49,37,39,39,38,43,48,41,226,35,48,59,57,35,59},62))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({17,36,44,39,37,54,43,56,39,53,226,9,23,11,226,40,49,55,48,38,226,239,226,53,54,35,41,39,226,46,49,35,38,39,38},62))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({17,36,44,39,37,54,43,56,39,53,226,9,23,11,226,48,49,54,226,40,49,55,48,38,226,57,43,54,42,43,48,226,54,43,47,39,49,55,54,238,226,50,52,49,37,39,39,38,43,48,41,226,35,48,59,57,35,59},62))
return
end
end
end)
if not ok then debug(_d({57,35,43,54,8,49,52,17,36,44,39,37,54,43,56,39,53,9,55,43,226,39,52,52,49,52,252},62), err) end
end
local function runPlan()
debug(_d({18,46,35,48,226,53,54,35,52,54,39,38},62))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({21,54,35,52,54,43,48,41,226,48,35,56,226,46,49,49,50},62))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({50,49,53,226,242,240,244,53,226,3,8,22,7,20,226,53,54,35,52,54,16,35,56,252},62), rootAfter and rootAfter.Position)
end)
debug(_d({25,35,43,54,43,48,41,226,247,53,226,36,39,40,49,52,39,226,47,49,56,43,48,41,226,54,49,226,21,54,35,41,39,243},62))
task.wait(5)
for _, stage in ipairs({_d({21,54,35,41,39,243},62), _d({21,54,35,41,39,244},62), _d({21,54,35,41,39,245},62), _d({21,54,35,41,39,245,4},62)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({15,49,56,43,48,41,226,54,49,226,35,52,52,49,57,226,40,46,59,239,38,49,57,48,226,35,52,39,35},62))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({6,49,38,41,43,48,41,226,35,52,52,49,57,226,52,35,43,48},62))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({21,54,35,41,39,246},62))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({19,55,39,39,48,226,43,48,226,50,42,35,53,39,226,244,226,239,226,45,39,39,50,43,48,41,226,13,39,48,226,10,35,45,43,226,35,37,54,43,56,39,226,40,52,49,47,226,42,39,52,39,226,49,48},62))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({21,54,35,54,55,39,243},62))
if not enabled then return end
recheckStatue(_d({21,54,35,54,55,39,243},62))
destroyStatue(_d({21,54,35,54,55,39,244},62))
if not enabled then return end
recheckStatue(_d({21,54,35,54,55,39,243},62))
recheckStatue(_d({21,54,35,54,55,39,244},62))
destroyStatue(_d({21,54,35,54,55,39,245},62))
if not enabled then return end
recheckStatue(_d({21,54,35,54,55,39,245},62))
recheckStatue(_d({21,54,35,54,55,39,244},62))
recheckStatue(_d({21,54,35,54,55,39,243},62))
if not enabled then return end
debug(_d({25,35,43,54,43,48,41,226,40,49,52,226,50,42,35,53,39,226,244,226,54,49,226,39,48,38},62))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({18,42,35,53,39,226,244,226,39,48,38,226,57,35,43,54,226,54,43,47,39,49,55,54,238,226,50,52,49,37,39,39,38,43,48,41,226,35,48,59,57,35,59},62))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({15,49,56,43,48,41,226,36,35,37,45,226,54,49,226,19,55,39,39,48,226,53,54,35,41,39,226,50,49,53,43,54,43,49,48},62))
navToPointConfirmed(COORDS.Queen, 30, _d({19,55,39,39,48,226,53,54,35,41,39,226,50,49,53,43,54,43,49,48},62))
debug(_d({25,35,43,54,43,48,41,226,247,53,226,35,54,226,19,55,39,39,48,226,53,54,35,41,39,226,50,49,53,43,54,43,49,48},62))
task.wait(5)
if not enabled then return end
debug(_d({15,49,56,43,48,41,226,54,49,226,50,49,53,54,239,19,55,39,39,48,226,50,49,53,43,54,43,49,48},62))
navToPointConfirmed(COORDS.PostQueen, 30, _d({50,49,53,54,239,19,55,39,39,48,226,50,49,53,43,54,43,49,48},62))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({7,48,35,36,46,43,48,41,238,226,50,49,53,226,4,7,8,17,20,7,226,50,46,35,48,252},62), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({18,46,35,48,226,39,52,52,49,52,252},62), err2) end
end)
debug(_d({7,48,35,36,46,39,38,252},62), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({7,48,35,36,46,39,38,252},62), enabled)
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
if not ok then debug(_d({11,48,50,55,54,4,39,41,35,48,226,39,52,52,49,52,252},62), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({9,35,47,39,226,46,49,35,38,39,38,238,226,35,55,54,49,239,53,54,35,52,54,43,48,41,226,54,42,39,226,50,46,35,48},62))
enableBot()
end)
if not ok then debug(_d({3,55,54,49,53,54,35,52,54,226,39,52,52,49,52,252},62), err) end
end)
debug(_d({14,49,35,38,39,38,226,164,66,86,226,35,55,54,49,239,53,54,35,52,54,43,48,41,226,49,48,37,39,226,54,42,39,226,41,35,47,39,226,40,43,48,43,53,42,39,53,226,46,49,35,38,43,48,41,226,234,50,52,39,53,53,226,18,226,54,49,226,54,49,41,41,46,39,226,47,35,48,55,35,46,46,59,235},62))
end)()