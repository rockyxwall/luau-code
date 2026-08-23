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
local Players            = game:GetService(_d({23,51,40,64,44,57,58},57))
local UserInputService    = game:GetService(_d({28,58,44,57,16,53,55,60,59,26,44,57,61,48,42,44},57))
local RunService          = game:GetService(_d({25,60,53,26,44,57,61,48,42,44},57))
local VIM                 = game:GetService(_d({29,48,57,59,60,40,51,16,53,55,60,59,20,40,53,40,46,44,57},57))
local ReplicatedStorage    = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({34,9,54,58,58,9,54,59,36},57), _d({30,57,54,53,46,231,46,40,52,44,231,169,71,91,231,23,51,40,42,44,16,43,1},57), game.PlaceId, _d({28,53,48,61,44,57,58,44,16,43,1},57), game.GameId, _d({244,231,53,54,59,231,57,60,53,53,48,53,46},57))
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
local LEO_PILLAR_ANIM_ID   = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,251,251,248,251,248,250,249,254},57)
local LEO_ENTEI_ANIM_ID    = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,251,251,248,250,255,249,254,255},57)
local LEO_HIKEN_ANIM_ID    = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,249,247,0,248,254,251,247,254},57)
local LEO_FIREFLY_ANIM_ID  = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,252,249,249,247,249,250,253,248,252,251},57)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({22,41,49,44,42,59,48,61,44,58},57)
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
local REPLAY_BUTTON_VALUE   = _d({25,44,55,51,40,64},57)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({52,54,61,44},57)
local NavState   = {mode = _d({48,43,51,44},57)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({34,9,54,58,58,9,54,59,36},57), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end)
if ok then return root end
debug(_d({46,44,59,25,54,54,59,231,44,57,57,54,57,1},57), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
end)
if ok then return hum end
debug(_d({46,44,59,15,60,52,40,53,54,48,43,231,44,57,57,54,57,1},57), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({38,38,15,54,61,44,57,8,59,59},57)) or Instance.new(_d({8,59,59,40,42,47,52,44,53,59},57))
att.Name = _d({38,38,15,54,61,44,57,8,59,59},57)
att.Parent = root
local force = root:FindFirstChild(_d({38,38,15,54,61,44,57,13,54,57,42,44},57))
if not force then
force = Instance.new(_d({19,48,53,44,40,57,29,44,51,54,42,48,59,64},57))
force.Name = _d({38,38,15,54,61,44,57,13,54,57,42,44},57)
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
debug(_d({46,44,59,22,57,10,57,44,40,59,44,13,54,57,42,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local force = root:FindFirstChild(_d({38,38,15,54,61,44,57,13,54,57,42,44},57))
local att   = root:FindFirstChild(_d({38,38,15,54,61,44,57,8,59,59},57))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({42,51,44,40,53,60,55,13,54,57,42,44,231,44,57,57,54,57,1},57), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({9,60,58,54,20,44,51,44,44},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,9,60,58,54,8,42,59,48,61,44,231,44,57,57,54,57,1},57), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({9,60,58,54},57))
end)
if not ok then debug(_d({40,42,59,48,61,40,59,44,9,60,58,54,231,44,57,57,54,57,1},57), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({9,60,58,54,231,53,54,59,231,40,42,59,48,61,44,243,231,40,42,59,48,61,40,59,48,53,46},57))
activateBuso()
end
end)
if not ok then debug(_d({9,60,58,54,18,44,44,55,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({9,60,58,54,231,50,44,44,55,44,57,231,58,59,54,55,55,44,43},57))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({18,44,53,15,40,50,48},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,18,44,53,8,42,59,48,61,44,231,44,57,57,54,57,1},57), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({18,44,53},57), true)
end)
if not ok then debug(_d({40,42,59,48,61,40,59,44,18,44,53,231,44,57,57,54,57,1},57), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({18,44,53,231,53,54,59,231,40,42,59,48,61,44,243,231,40,42,59,48,61,40,59,48,53,46},57))
activateKen()
end
end)
if not ok then debug(_d({18,44,53,18,44,44,55,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({18,44,53,231,50,44,44,55,44,57,231,58,59,54,55,55,44,43},57))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({21,23,10,58},57)) end)
if ok then return folder end
debug(_d({46,44,59,21,23,10,58,13,54,51,43,44,57,231,44,57,57,54,57,1},57), folder)
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
local r = model:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local h = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
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
debug(_d({46,44,59,21,44,40,57,44,58,59,21,23,10,231,44,57,57,54,57,1},57), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
local hum  = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({46,44,59,21,23,10,9,64,21,40,52,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({53,55,42,58,25,44,52,40,48,53,48,53,46,231,44,57,57,54,57,1},57), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({10,60,55,48,43,231,24,60,44,44,53},57))
return queen ~= nil and queen:FindFirstChild(_d({52,54,59,48,54,53,19,44,58,58},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,24,60,44,44,53,23,47,40,58,44,249,231,44,57,57,54,57,1},57), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,248,249,248,249,0,254,0,251,249,249,0,249,254,253,0},57)
local QUEEN_GRASP_ANIM_ID   = _d({57,41,63,40,58,58,44,59,48,43,1,246,246,248,249,0,255,247,247,247,253,248,247,247,248,254,250,251},57)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
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
debug(_d({48,58,23,51,40,64,48,53,46,8,53,48,52,13,57,54,52,19,48,58,59,231,44,57,57,54,57,1},57), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({9,51,54,42,50,48,53,46},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,21,23,10,9,51,54,42,50,48,53,46,231,44,57,57,54,57,1},57), result)
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
debug(_d({55,57,44,43,48,42,59,21,23,10,23,54,58,48,59,48,54,53,231,44,57,57,54,57,1},57), result)
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
debug(_d({21,54,231,43,40,52,40,46,44,231,54,53},57), model.Name, _d({45,54,57},57), NPC_STUCK_TIMEOUT, _d({58,231,244,231,58,62,48,59,42,47,48,53,46,231,59,40,57,46,44,59},57))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({59,57,40,42,50,21,23,10,11,40,52,40,46,44,231,44,57,57,54,57,1},57), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({20,54,43,44,51},57)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({9,40,58,44,23,40,57,59},57)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({46,44,59,20,54,43,44,51,13,40,42,44,23,54,58,231,44,57,57,54,57,1},57), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({12,53,61},57))
local folder = env and env:FindFirstChild(_d({26,59,40,59,60,44,58},57))
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
debug(_d({46,44,59,26,59,40,59,60,44,20,54,43,44,51,21,44,40,57,231,44,57,57,54,57,1},57), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({41,40,57,57,44,51,15,23},57))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({46,44,59,26,59,40,59,60,44,15,23,231,44,57,57,54,57,1},57), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,8,59,59,57,48,41,60,59,44,231,44,57,57,54,57,1},57), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({27,54,54,51},57)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,21,40,52,44,231,44,57,57,54,57,1},57), tool)
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
if not ok then debug(_d({44,56,60,48,55,27,54,54,51,231,44,57,57,54,57,1},57), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({9,40,42,50,55,40,42,50},57))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({27,54,54,51},57)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({45,48,53,43,27,54,54,51,9,64,10,47,48,51,43,21,40,52,44,231,44,57,57,54,57,1},57), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({26,62,54,57,43,12,56,60,48,55},57))
if sword then
equipTool(sword)
return _d({58,62,54,57,43},57)
end
local melee = findToolByAttribute(_d({20,44,51,44,44,27,54,54,51},57))
if melee then
equipTool(melee)
return _d({52,44,51,44,44},57)
end
debug(_d({21,54,231,58,62,54,57,43,231,54,57,231,52,44,51,44,44,231,59,54,54,51,231,45,54,60,53,43},57))
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
if not ok then debug(_d({42,51,48,42,50,20,248,231,44,57,57,54,57,1},57), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({25,54,50,60,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({14,44,55,55,54},57), args)
elseif style == _d({9,51,40,42,50,19,44,46},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50},57), args)
elseif style == _d({18,40,52,48,58,47,48,50,48},57) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,40,52,48,58,47,48,50,48,14,44,55,55,54},57), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,50,64,231,30,40,51,50,249},57), args)
end
end)
if not ok then debug(_d({48,53,61,54,50,44,14,44,55,55,54,231,44,57,57,54,57,1},57), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({55,57,44,58,58,26,50,48,51,51,25,231,44,57,57,54,57,1},57), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({47,54,51,43,9,51,54,42,50,231,44,57,57,54,57,1},57), err) end
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
if not ok then debug(_d({47,54,51,43,9,51,54,42,50,30,47,48,51,44,231,44,57,57,54,57,1},57), err) end
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
debug(_d({46,44,59,14,40,52,44,14,231,44,57,57,54,57,1},57), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({48,58,25,44,40,51,20,248,9,60,58,64,231,44,57,57,54,57,1},57), result)
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
return char ~= nil and char:FindFirstChild(_d({58,59,60,53},57)) ~= nil
end)
if ok then return result end
debug(_d({48,58,26,59,60,53,53,44,43,231,44,57,57,54,57,1},57), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({55,57,44,58,58,26,59,60,53,9,57,44,40,50,231,44,57,57,54,57,1},57), err) end
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
debug(_d({56,60,44,44,53,11,54,43,46,44,28,53,59,48,51,26,40,45,44,1,231,24,60,44,44,53,231,46,54,53,44,231,244,231,44,53,43,48,53,46,231,43,54,43,46,44,231,44,40,57,51,64},57))
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
debug(_d({56,60,44,44,53,11,54,43,46,44,28,53,59,48,51,26,40,45,44,231,58,40,45,44,59,64,231,59,48,52,44,54,60,59},57))
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
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({24,60,44,44,53,231,42,40,58,59,48,53,46,231,43,44,59,44,42,59,44,43,231,244,231,43,54,43,46,48,53,46,231,239,62,40,59,42,47,44,57,240},57))
queenDodgeUntilSafe(function() return getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) end)
if enabled and getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) then
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
end
queenDodging = false
end
end)
if not ok then debug(_d({56,60,44,44,53,11,54,43,46,44,30,40,59,42,47,44,57,231,44,57,57,54,57,1},57), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({55,54,48,53,59},57) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({53,55,42},57) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({53,40,52,44,43},57) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({46,44,59,21,40,61,27,40,57,46,44,59,58,231,44,57,57,54,57,1},57), aimR)
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
debug(_d({42,54,52,55,60,59,44,19,54,42,50,44,43,10,13,57,40,52,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({55,54,48,53,59},57), point = pos}
phase = _d({52,54,61,44},57)
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
if not ok then debug(_d({53,40,61,27,54,23,54,48,53,59,231,46,44,55,55,54,231,42,47,44,42,50,231,44,57,57,54,57,1},57), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({53,55,42},57)}
phase = _d({52,54,61,44},57)
end
function setNavNamed(name)
NavState = {mode = _d({53,40,52,44,43},57), name = name}
phase = _d({52,54,61,44},57)
end
local function setNavIdle()
NavState = {mode = _d({48,43,51,44},57)}
phase = _d({52,54,61,44},57)
end
local function hasArrived()
return phase == _d({47,54,61,44,57},57)
end
local function startNav()
phase = _d({52,54,61,44},57)
debug(_d({21,40,61,231,51,54,54,55,231,22,21},57))
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
local prevPos = force:GetAttribute(_d({38,38,55,57,44,61,23,54,58},57))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({19,40,57,46,44,231,55,54,58,48,59,48,54,53,231,49,60,52,55,231,43,44,59,44,42,59,44,43,1},57), delta, _d({58,59,60,43,58,245,231,55,57,44,61,23,54,58,4},57), prevPos, _d({53,44,62,23,54,58,4},57), pos)
end
end
force:SetAttribute(_d({38,38,55,57,44,61,23,54,58},57), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({52,54,61,44},57) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({47,54,61,44,57},57)
debug(_d({23,47,40,58,44,1,231,47,54,61,44,57},57))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({232,232,232,231,25,12,13,28,26,16,21,14,231,27,22,231,8,23,23,19,32,231,8,9,21,22,25,20,8,19,231,29,12,19,22,10,16,27,32,1},57), finalVel, _d({40,48,52,4},57), aim, _d({55,54,58,4},57), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({47,54,61,44,57},57) then
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
debug(_d({10,54,52,41,40,59,231,51,54,42,50,231,58,50,48,55,55,44,43,243},57), snapDist, _d({58,59,60,43,58,231,45,57,54,52,231,59,40,57,46,44,59,231,169,71,91,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,52,54,61,44},57))
phase = _d({52,54,61,44},57)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({15,44,40,57,59,41,44,40,59,231,44,57,57,54,57,1},57), err) end
end)
end
local function stopNav()
debug(_d({21,40,61,231,51,54,54,55,231,22,13,13},57))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({52,54,61,44},57)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({27,44,63,59,10,47,40,59,26,44,57,61,48,42,44},57))
local channels = TextChatService:FindFirstChild(_d({27,44,63,59,10,47,40,53,53,44,51,58},57))
local channel = channels and channels:FindFirstChild(_d({25,9,31,14,44,53,44,57,40,51},57))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({11,44,45,40,60,51,59,10,47,40,59,26,64,58,59,44,52,10,47,40,59,12,61,44,53,59,58},57))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({26,40,64,20,44,58,58,40,46,44,25,44,56,60,44,58,59},57))
if sayEvent then
sayEvent:FireServer(message, _d({8,51,51},57))
return
end
debug(_d({58,44,53,43,10,47,40,59,20,44,58,58,40,46,44,1,231,53,54,231,27,44,63,59,10,47,40,59,26,44,57,61,48,42,44,245,25,9,31,14,44,53,44,57,40,51,231,54,57,231,51,44,46,40,42,64,231,26,40,64,20,44,58,58,40,46,44,25,44,56,60,44,58,59,231,45,54,60,53,43,231,45,54,57},57), message)
end)
if not ok then debug(_d({58,44,53,43,10,47,40,59,20,44,58,58,40,46,44,231,44,57,57,54,57,1},57), err) end
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
debug(_d({21,54,59,231,52,40,50,48,53,46,231,55,57,54,46,57,44,58,58,231,59,54,62,40,57,43,231,53,40,61,231,59,40,57,46,44,59,231,45,54,57},57), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({58,231,244,231,58,44,53,43,48,53,46,231,246,60,53,58,59,60,42,50},57))
sendChatMessage(_d({246,60,53,58,59,60,42,50},57))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({62,40,48,59,28,53,59,48,51,8,57,57,48,61,44,43,231,59,48,52,44,54,60,59},57))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({53,40,61,27,54,23,54,48,53,59,10,54,53,45,48,57,52,44,43,1},57), label or _d({59,40,57,46,44,59},57), _d({244,231,43,48,43,231,53,54,59,231,40,57,57,48,61,44,231,62,48,59,47,48,53},57), timeout, _d({58,243,231,57,44,59,57,64,48,53,46,231,54,53,42,44},57))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({53,40,61,27,54,23,54,48,53,59,10,54,53,45,48,57,52,44,43,1},57), label or _d({59,40,57,46,44,59},57), _d({244,231,58,59,48,51,51,231,53,54,59,231,40,57,57,48,61,44,43,231,40,45,59,44,57,231,57,44,59,57,64,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
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
if not ok then debug(_d({53,40,61,27,54,23,54,48,53,59,15,54,51,43,48,53,46,9,51,54,42,50,231,50,44,64,244,43,54,62,53,231,44,57,57,54,57,1},57), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({53,40,61,27,54,23,54,48,53,59,15,54,51,43,48,53,46,9,51,54,42,50,231,50,44,64,244,60,55,231,44,57,57,54,57,1},57), err2) end
end
local function clearStage(stageName)
debug(_d({20,54,61,48,53,46,231,59,54},57), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,21,23,10,58,231,59,54,231,58,55,40,62,53,231,40,59},57), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({231,231,58,55,40,62,53,231,42,47,44,42,50,1,231,45,54,51,43,44,57,231,44,63,48,58,59,58,231,4},57), folder ~= nil,
_d({243,231,42,47,48,51,43,57,44,53,231,4},57), folder and #folder:GetChildren() or 0,
_d({243,231,40,51,48,61,44,231,4},57), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({21,54,231,21,23,10,58,231,40,55,55,44,40,57,44,43,231,40,59},57), stageName, _d({40,45,59,44,57,231,248,252,58,243,231,52,54,61,48,53,46,231,54,53,231,40,53,64,62,40,64},57))
break
end
end
debug(_d({18,48,51,51,48,53,46,231,21,23,10,58,231,40,59},57), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({25,44,59,60,57,53,48,53,46,231,59,54},57), stageName, _d({55,54,58,48,59,48,54,53,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,54,53},57))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59},57), stageName, _d({55,54,58,48,59,48,54,53},57))
task.wait(5)
debug(stageName, _d({42,51,44,40,57,44,43},57))
end
local function killNamedNPC(name, targetPos)
debug(_d({20,54,61,48,53,46,231,59,54},57), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({43,44,45,44,40,59,44,43},57))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({15,60,52,40,53,54,48,43},57))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({19,44,54,231,55,51,40,64,44,43,231,40,53,48,52,40,59,48,54,53,1},57), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({51,44,54,8,53,48,52,19,54,46,46,44,57,231,55,57,48,53,59,231,44,57,57,54,57,1},57), err2) end
end)
end)
if not ok then debug(_d({58,59,40,57,59,19,44,54,8,53,48,52,19,54,46,46,44,57,231,44,57,57,54,57,1},57), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({20,54,61,48,53,46,231,59,54,231,19,44,54,231,239,41,51,54,42,50,48,53,46,231,40,45,59,44,57},57), LEO_BLOCK_DELAY, _d({58,240},57))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({19,44,54},57))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({19,44,54},57))
while enabled do
local info = getNPCByName(_d({19,44,54},57))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({19,44,54,231,42,40,58,59,48,53,46},57), which, _d({244,231,43,54,43,46,48,53,46},57))
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
if not getNPCByName(_d({19,44,54},57)) then
debug(_d({19,44,54,231,46,54,53,44,231,52,48,43,244,43,54,43,46,44,231,244,231,44,53,43,48,53,46,231,12,53,59,44,48,231,47,54,51,43,231,44,40,57,51,64},57))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({19,44,54},57)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({19,44,54,231,46,54,53,44,231,52,48,43,244,43,54,43,46,44,231,244,231,44,53,43,48,53,46,231,13,51,40,52,44,231,23,48,51,51,40,57,231,47,54,51,43,231,44,40,57,51,64},57))
end
end
end
if enabled and getNPCByName(_d({19,44,54},57)) then
setNavNamed(_d({19,44,54},57))
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
debug(_d({19,44,54,231,43,44,45,44,40,59,44,43},57))
stopLeoAnimLogger()
debug(_d({25,44,59,60,57,53,48,53,46,231,59,54,231,19,44,54,231,55,54,58,48,59,48,54,53,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,54,53},57))
navToPointConfirmed(COORDS.Leo, 30, _d({19,44,54,231,55,54,58,48,59,48,54,53},57))
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59,231,19,44,54,231,55,54,58,48,59,48,54,53},57))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({20,54,61,48,53,46,231,59,54},57), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({10,54,60,51,43,231,53,54,59,231,45,48,53,43,231,58,59,40,59,60,44,231,52,54,43,44,51,231,53,44,40,57},57), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({8,59,59,40,42,50,48,53,46},57), coordKey, _d({62,48,59,47},57), weapon or _d({53,54,59,47,48,53,46,231,45,54,60,53,43},57))
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
debug(coordKey, _d({41,40,57,57,44,51,231,43,44,58,59,57,54,64,44,43},57))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({244,231,42,54,60,51,43,231,53,54,59,231,45,48,53,43,231,58,59,40,59,60,44,231,52,54,43,44,51,243,231,58,50,48,55,55,48,53,46},57))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({58,59,48,51,51,231,40,51,48,61,44,231,239,15,23},57), hp, _d({240,231,244,231,57,44,244,43,44,58,59,57,54,64,48,53,46},57))
destroyStatue(coordKey)
else
debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,1},57), coordKey, _d({42,54,53,45,48,57,52,44,43,231,43,44,58,59,57,54,64,44,43},57))
end
end)
if not ok then debug(_d({57,44,42,47,44,42,50,26,59,40,59,60,44,231,44,57,57,54,57,1},57), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({20,54,61,48,53,46,231,59,54,231,24,60,44,44,53},57))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({24,60,44,44,53,231,44,53,59,44,57,44,43,231,55,47,40,58,44,231,249},57))
end
local function finishQueen()
debug(_d({13,48,53,48,58,47,48,53,46,231,24,60,44,44,53},57))
equipSwordOrMelee()
setNavNamed(_d({10,60,55,48,43,231,24,60,44,44,53},57))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({10,60,55,48,43,231,24,60,44,44,53},57))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({24,60,44,44,53,231,43,44,45,44,40,59,44,43,245,231,23,51,40,53,231,42,54,52,55,51,44,59,44,245},57))
end
local CONFIRMATION_PROMPT_NAME = _d({10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59},57)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({25,44,52,54,59,44,12,61,44,53,59},57), 5)
end)
if ok then return result end
debug(_d({46,44,59,25,44,55,51,40,64,25,44,52,54,59,44,231,44,57,57,54,57,1},57), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({23,51,40,64,44,57,14,60,48},57))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({16,52,40,46,44,9,60,59,59,54,53},57)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({41,60,59,59,54,53,29,40,51,60,44},57)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({45,48,53,43,9,60,59,59,54,53,9,64,29,40,51,60,44,231,44,57,57,54,57,1},57), result)
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
if not ok then debug(_d({42,51,48,42,50,14,60,48,9,60,59,59,54,53,231,44,57,57,54,57,1},57), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({48,58,26,44,57,61,44,57},57))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({25,44,52,54,59,44,12,61,44,53,59},57))
or inst:FindFirstChild(_d({42,51,48,44,53,59,12,61,44,53,59},57))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({45,48,53,43,8,53,58,62,44,57,10,54,53,53,44,42,59,54,57,231,44,57,57,54,57,1},57), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({10,54,60,51,43,231,53,54,59,231,51,54,42,40,59,44,231,25,44,52,54,59,44,12,61,44,53,59,246,42,51,48,44,53,59,12,61,44,53,59,231,53,44,40,57,231,25,44,55,51,40,64,231,41,60,59,59,54,53,243,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,42,51,48,42,50},57))
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
debug(_d({45,48,57,44,25,44,55,51,40,64,29,40,51,60,44,231,44,57,57,54,57,1},57), err, _d({244,231,45,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,42,51,48,42,50},57))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({13,40,51,51,48,53,46,231,41,40,42,50,231,59,54,231,41,60,59,59,54,53,29,40,51,60,44,231,58,44,40,57,42,47,231,45,54,57,231,25,44,55,51,40,64},57))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({25,44,55,51,40,64,231,41,60,59,59,54,53,231,53,54,59,231,45,54,60,53,43,231,44,48,59,47,44,57,243,231,46,48,61,48,53,46,231,60,55},57))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,245,25,44,52,54,59,44,12,61,44,53,59},57))
local remote = getReplayRemote()
if not remote then
debug(_d({10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,246,25,44,52,54,59,44,12,61,44,53,59,231,53,54,59,231,45,54,60,53,43,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59},57))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({13,48,57,48,53,46,231,25,44,55,51,40,64,231,61,48,40,231,10,54,53,45,48,57,52,40,59,48,54,53,23,57,54,52,55,59,245,25,44,52,54,59,44,12,61,44,53,59},57))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({13,48,57,44,26,44,57,61,44,57,231,44,57,57,54,57,1},57), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({23,51,40,64,44,57,14,60,48},57), 10)
if not playerGui then
debug(_d({62,40,48,59,13,54,57,22,41,49,44,42,59,48,61,44,58,14,60,48,1,231,53,54,231,23,51,40,64,44,57,14,60,48,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({22,41,49,44,42,59,48,61,44,58,231,14,28,16,231,45,54,60,53,43,231,244,231,58,59,40,46,44,231,51,54,40,43,44,43},57))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({22,41,49,44,42,59,48,61,44,58,231,14,28,16,231,53,54,59,231,45,54,60,53,43,231,62,48,59,47,48,53,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
return
end
end
end)
if not ok then debug(_d({62,40,48,59,13,54,57,22,41,49,44,42,59,48,61,44,58,14,60,48,231,44,57,57,54,57,1},57), err) end
end
local function runPlan()
debug(_d({23,51,40,53,231,58,59,40,57,59,44,43},57))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({26,59,40,57,59,48,53,46,231,53,40,61,231,51,54,54,55},57))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({55,54,58,231,247,245,249,58,231,8,13,27,12,25,231,58,59,40,57,59,21,40,61,1},57), rootAfter and rootAfter.Position)
end)
debug(_d({30,40,48,59,48,53,46,231,252,58,231,41,44,45,54,57,44,231,52,54,61,48,53,46,231,59,54,231,26,59,40,46,44,248},57))
task.wait(5)
for _, stage in ipairs({_d({26,59,40,46,44,248},57), _d({26,59,40,46,44,249},57), _d({26,59,40,46,44,250},57), _d({26,59,40,46,44,250,9},57)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,59,54,231,40,57,57,54,62,231,45,51,64,244,43,54,62,53,231,40,57,44,40},57))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({11,54,43,46,48,53,46,231,40,57,57,54,62,231,57,40,48,53},57))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({26,59,40,46,44,251},57))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({24,60,44,44,53,231,48,53,231,55,47,40,58,44,231,249,231,244,231,50,44,44,55,48,53,46,231,18,44,53,231,15,40,50,48,231,40,42,59,48,61,44,231,45,57,54,52,231,47,44,57,44,231,54,53},57))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({26,59,40,59,60,44,248},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,248},57))
destroyStatue(_d({26,59,40,59,60,44,249},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,248},57))
recheckStatue(_d({26,59,40,59,60,44,249},57))
destroyStatue(_d({26,59,40,59,60,44,250},57))
if not enabled then return end
recheckStatue(_d({26,59,40,59,60,44,250},57))
recheckStatue(_d({26,59,40,59,60,44,249},57))
recheckStatue(_d({26,59,40,59,60,44,248},57))
if not enabled then return end
debug(_d({30,40,48,59,48,53,46,231,45,54,57,231,55,47,40,58,44,231,249,231,59,54,231,44,53,43},57))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({23,47,40,58,44,231,249,231,44,53,43,231,62,40,48,59,231,59,48,52,44,54,60,59,243,231,55,57,54,42,44,44,43,48,53,46,231,40,53,64,62,40,64},57))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,41,40,42,50,231,59,54,231,24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
navToPointConfirmed(COORDS.Queen, 30, _d({24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
debug(_d({30,40,48,59,48,53,46,231,252,58,231,40,59,231,24,60,44,44,53,231,58,59,40,46,44,231,55,54,58,48,59,48,54,53},57))
task.wait(5)
if not enabled then return end
debug(_d({20,54,61,48,53,46,231,59,54,231,55,54,58,59,244,24,60,44,44,53,231,55,54,58,48,59,48,54,53},57))
navToPointConfirmed(COORDS.PostQueen, 30, _d({55,54,58,59,244,24,60,44,44,53,231,55,54,58,48,59,48,54,53},57))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({12,53,40,41,51,48,53,46,243,231,55,54,58,231,9,12,13,22,25,12,231,55,51,40,53,1},57), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({23,51,40,53,231,44,57,57,54,57,1},57), err2) end
end)
debug(_d({12,53,40,41,51,44,43,1},57), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({12,53,40,41,51,44,43,1},57), enabled)
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
if not ok then debug(_d({16,53,55,60,59,9,44,46,40,53,231,44,57,57,54,57,1},57), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({14,40,52,44,231,51,54,40,43,44,43,243,231,40,60,59,54,244,58,59,40,57,59,48,53,46,231,59,47,44,231,55,51,40,53},57))
enableBot()
end)
if not ok then debug(_d({8,60,59,54,58,59,40,57,59,231,44,57,57,54,57,1},57), err) end
end)
debug(_d({19,54,40,43,44,43,231,169,71,91,231,40,60,59,54,244,58,59,40,57,59,48,53,46,231,54,53,42,44,231,59,47,44,231,46,40,52,44,231,45,48,53,48,58,47,44,58,231,51,54,40,43,48,53,46,231,239,55,57,44,58,58,231,23,231,59,54,231,59,54,46,46,51,44,231,52,40,53,60,40,51,51,64,240},57))
end)()