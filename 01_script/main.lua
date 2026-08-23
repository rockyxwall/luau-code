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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({62,90,79,103,83,96,97},18))
local UserInputService    = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local RunService          = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local VIM                 = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local ReplicatedStorage    = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({73,48,93,97,97,48,93,98,75},18), _d({69,96,93,92,85,14,85,79,91,83,14,208,110,130,14,62,90,79,81,83,55,82,40},18), game.PlaceId, _d({67,92,87,100,83,96,97,83,55,82,40},18), game.GameId, _d({27,14,92,93,98,14,96,99,92,92,87,92,85},18))
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
local LEO_PILLAR_ANIM_ID   = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,34,34,31,34,31,33,32,37},18)
local LEO_ENTEI_ANIM_ID    = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,34,34,31,33,38,32,37,38},18)
local LEO_HIKEN_ANIM_ID    = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,32,30,39,31,37,34,30,37},18)
local LEO_FIREFLY_ANIM_ID  = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,32,30,32,33,36,31,35,34},18)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({61,80,88,83,81,98,87,100,83,97},18)
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
local REPLAY_BUTTON_VALUE   = _d({64,83,94,90,79,103},18)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({91,93,100,83},18)
local NavState   = {mode = _d({87,82,90,83},18)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({73,48,93,97,97,48,93,98,75},18), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end)
if ok then return root end
debug(_d({85,83,98,64,93,93,98,14,83,96,96,93,96,40},18), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end)
if ok then return hum end
debug(_d({85,83,98,54,99,91,79,92,93,87,82,14,83,96,96,93,96,40},18), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({23,14,93,96,14,55,92,97,98,79,92,81,83,28,92,83,101,22},18)Attachment")
att.Name = _d({77,77,54,93,100,83,96,47,98,98},18)
att.Parent = root
local force = root:FindFirstChild(_d({77,77,54,93,100,83,96,52,93,96,81,83},18))
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = _d({77,77,54,93,100,83,96,52,93,96,81,83},18)
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
debug(_d({85,83,98,61,96,49,96,83,79,98,83,52,93,96,81,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local force = root:FindFirstChild(_d({77,77,54,93,100,83,96,52,93,96,81,83},18))
local att   = root:FindFirstChild(_d({77,77,54,93,100,83,96,47,98,98},18))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({81,90,83,79,92,99,94,52,93,96,81,83,14,83,96,96,93,96,40},18), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({48,99,97,93,59,83,90,83,83},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,48,99,97,93,47,81,98,87,100,83,14,83,96,96,93,96,40},18), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({48,99,97,93},18))
end)
if not ok then debug(_d({79,81,98,87,100,79,98,83,48,99,97,93,14,83,96,96,93,96,40},18), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({48,99,97,93,14,92,93,98,14,79,81,98,87,100,83,26,14,79,81,98,87,100,79,98,87,92,85},18))
activateBuso()
end
end)
if not ok then debug(_d({48,99,97,93,57,83,83,94,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({48,99,97,93,14,89,83,83,94,83,96,14,97,98,93,94,94,83,82},18))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({57,83,92,54,79,89,87},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,57,83,92,47,81,98,87,100,83,14,83,96,96,93,96,40},18), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({57,83,92},18), true)
end)
if not ok then debug(_d({79,81,98,87,100,79,98,83,57,83,92,14,83,96,96,93,96,40},18), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({57,83,92,14,92,93,98,14,79,81,98,87,100,83,26,14,79,81,98,87,100,79,98,87,92,85},18))
activateKen()
end
end)
if not ok then debug(_d({57,83,92,57,83,83,94,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({57,83,92,14,89,83,83,94,83,96,14,97,98,93,94,94,83,82},18))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({60,62,49,97},18)) end)
if ok then return folder end
debug(_d({85,83,98,60,62,49,97,52,93,90,82,83,96,14,83,96,96,93,96,40},18), folder)
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
local r = model:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local h = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
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
debug(_d({85,83,98,60,83,79,96,83,97,98,60,62,49,14,83,96,96,93,96,40},18), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum  = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({85,83,98,60,62,49,48,103,60,79,91,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({92,94,81,97,64,83,91,79,87,92,87,92,85,14,83,96,96,93,96,40},18), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({49,99,94,87,82,14,63,99,83,83,92},18))
return queen ~= nil and queen:FindFirstChild(_d({91,93,98,87,93,92,58,83,97,97},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,63,99,83,83,92,62,86,79,97,83,32,14,83,96,96,93,96,40},18), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,31,32,31,32,39,37,39,34,32,32,39,32,37,36,39},18)
local QUEEN_GRASP_ANIM_ID   = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,31,32,39,38,30,30,30,36,31,30,30,31,37,33,34},18)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
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
debug(_d({87,97,62,90,79,103,87,92,85,47,92,87,91,52,96,93,91,58,87,97,98,14,83,96,96,93,96,40},18), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({48,90,93,81,89,87,92,85},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,60,62,49,48,90,93,81,89,87,92,85,14,83,96,96,93,96,40},18), result)
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
debug(_d({94,96,83,82,87,81,98,60,62,49,62,93,97,87,98,87,93,92,14,83,96,96,93,96,40},18), result)
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
debug(_d({60,93,14,82,79,91,79,85,83,14,93,92},18), model.Name, _d({84,93,96},18), NPC_STUCK_TIMEOUT, _d({97,14,27,14,97,101,87,98,81,86,87,92,85,14,98,79,96,85,83,98},18))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({98,96,79,81,89,60,62,49,50,79,91,79,85,83,14,83,96,96,93,96,40},18), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({59,93,82,83,90},18)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({48,79,97,83,62,79,96,98},18)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({85,83,98,59,93,82,83,90,52,79,81,83,62,93,97,14,83,96,96,93,96,40},18), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({51,92,100},18))
local folder = env and env:FindFirstChild(_d({65,98,79,98,99,83,97},18))
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
debug(_d({85,83,98,65,98,79,98,99,83,59,93,82,83,90,60,83,79,96,14,83,96,96,93,96,40},18), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({80,79,96,96,83,90,54,62},18))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({85,83,98,65,98,79,98,99,83,54,62,14,83,96,96,93,96,40},18), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,47,98,98,96,87,80,99,98,83,14,83,96,96,93,96,40},18), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({66,93,93,90},18)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,60,79,91,83,14,83,96,96,93,96,40},18), tool)
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
if not ok then debug(_d({83,95,99,87,94,66,93,93,90,14,83,96,96,93,96,40},18), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,49,86,87,90,82,60,79,91,83,14,83,96,96,93,96,40},18), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({65,101,93,96,82,51,95,99,87,94},18))
if sword then
equipTool(sword)
return _d({97,101,93,96,82},18)
end
local melee = findToolByAttribute(_d({59,83,90,83,83,66,93,93,90},18))
if melee then
equipTool(melee)
return _d({91,83,90,83,83},18)
end
debug(_d({60,93,14,97,101,93,96,82,14,93,96,14,91,83,90,83,83,14,98,93,93,90,14,84,93,99,92,82},18))
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
if not ok then debug(_d({81,90,87,81,89,59,31,14,83,96,96,93,96,40},18), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
end
end)
if not ok then debug(_d({87,92,100,93,89,83,53,83,94,94,93,14,83,96,96,93,96,40},18), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({94,96,83,97,97,65,89,87,90,90,64,14,83,96,96,93,96,40},18), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({86,93,90,82,48,90,93,81,89,14,83,96,96,93,96,40},18), err) end
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
if not ok then debug(_d({86,93,90,82,48,90,93,81,89,69,86,87,90,83,14,83,96,96,93,96,40},18), err) end
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
debug(_d({85,83,98,53,79,91,83,53,14,83,96,96,93,96,40},18), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({87,97,64,83,79,90,59,31,48,99,97,103,14,83,96,96,93,96,40},18), result)
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
return char ~= nil and char:FindFirstChild(_d({97,98,99,92},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,65,98,99,92,92,83,82,14,83,96,96,93,96,40},18), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({94,96,83,97,97,65,98,99,92,48,96,83,79,89,14,83,96,96,93,96,40},18), err) end
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
debug(_d({95,99,83,83,92,50,93,82,85,83,67,92,98,87,90,65,79,84,83,40,14,63,99,83,83,92,14,85,93,92,83,14,27,14,83,92,82,87,92,85,14,82,93,82,85,83,14,83,79,96,90,103},18))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({95,99,83,83,92,50,93,82,85,83,67,92,98,87,90,65,79,84,83,14,97,79,84,83,98,103,14,98,87,91,83,93,99,98},18))
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
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({63,99,83,83,92,14,81,79,97,98,87,92,85,14,82,83,98,83,81,98,83,82,14,27,14,82,93,82,85,87,92,85,14,22,101,79,98,81,86,83,96,23},18))
queenDodgeUntilSafe(function() return getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) end)
if enabled and getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) then
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
end
queenDodging = false
end
end)
if not ok then debug(_d({95,99,83,83,92,50,93,82,85,83,69,79,98,81,86,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({94,93,87,92,98},18) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({92,94,81},18) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({92,79,91,83,82},18) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({85,83,98,60,79,100,66,79,96,85,83,98,97,14,83,96,96,93,96,40},18), aimR)
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
debug(_d({81,93,91,94,99,98,83,58,93,81,89,83,82,49,52,96,79,91,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({94,93,87,92,98},18), point = pos}
phase = _d({91,93,100,83},18)
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
if not ok then debug(_d({92,79,100,66,93,62,93,87,92,98,14,85,83,94,94,93,14,81,86,83,81,89,14,83,96,96,93,96,40},18), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({92,94,81},18)}
phase = _d({91,93,100,83},18)
end
function setNavNamed(name)
NavState = {mode = _d({92,79,91,83,82},18), name = name}
phase = _d({91,93,100,83},18)
end
local function setNavIdle()
NavState = {mode = _d({87,82,90,83},18)}
phase = _d({91,93,100,83},18)
end
local function hasArrived()
return phase == _d({86,93,100,83,96},18)
end
local function startNav()
phase = _d({91,93,100,83},18)
debug(_d({60,79,100,14,90,93,93,94,14,61,60},18))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({62,90,79,103,83,96,14,82,87,83,82,15,14,65,98,93,94,94,87,92,85,14,80,93,98,28},18))
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
debug(_d({62,90,79,103,83,96,14,87,97,14,98,93,93,14,84,79,96,14,84,96,93,91,14,98,79,96,85,83,98,14,22,44,32,30,30,30,14,97,98,99,82,97,23,28,14,58,87,89,83,90,103,14,96,83,97,94,79,101,92,83,82,14,79,98,14,90,93,80,80,103,28,14,65,98,93,94,94,87,92,85,14,80,93,98,28},18))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({77,77,94,96,83,100,62,93,97},18))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({58,79,96,85,83,14,94,93,97,87,98,87,93,92,14,88,99,91,94,14,82,83,98,83,81,98,83,82,40},18), delta, _d({97,98,99,82,97,28,14,94,96,83,100,62,93,97,43},18), prevPos, _d({92,83,101,62,93,97,43},18), pos)
end
end
force:SetAttribute(_d({77,77,94,96,83,100,62,93,97},18), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({91,93,100,83},18) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({86,93,100,83,96},18)
debug(_d({62,86,79,97,83,40,14,86,93,100,83,96},18))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({15,15,15,14,64,51,52,67,65,55,60,53,14,66,61,14,47,62,62,58,71,14,47,48,60,61,64,59,47,58,14,68,51,58,61,49,55,66,71,40},18), finalVel, _d({79,87,91,43},18), aim, _d({94,93,97,43},18), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({86,93,100,83,96},18) then
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
debug(_d({49,93,91,80,79,98,14,90,93,81,89,14,97,89,87,94,94,83,82,26},18), snapDist, _d({97,98,99,82,97,14,84,96,93,91,14,98,79,96,85,83,98,14,208,110,130,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,91,93,100,83},18))
phase = _d({91,93,100,83},18)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({54,83,79,96,98,80,83,79,98,14,83,96,96,93,96,40},18), err) end
end)
end
local function stopNav()
debug(_d({60,79,100,14,90,93,93,94,14,61,52,52},18))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({91,93,100,83},18)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({66,83,102,98,49,86,79,98,65,83,96,100,87,81,83},18))
local channels = TextChatService:FindFirstChild(_d({66,83,102,98,49,86,79,92,92,83,90,97},18))
local channel = channels and channels:FindFirstChild(_d({64,48,70,53,83,92,83,96,79,90},18))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({50,83,84,79,99,90,98,49,86,79,98,65,103,97,98,83,91,49,86,79,98,51,100,83,92,98,97},18))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({65,79,103,59,83,97,97,79,85,83,64,83,95,99,83,97,98},18))
if sayEvent then
sayEvent:FireServer(message, _d({47,90,90},18))
return
end
debug(_d({97,83,92,82,49,86,79,98,59,83,97,97,79,85,83,40,14,92,93,14,66,83,102,98,49,86,79,98,65,83,96,100,87,81,83,28,64,48,70,53,83,92,83,96,79,90,14,93,96,14,90,83,85,79,81,103,14,65,79,103,59,83,97,97,79,85,83,64,83,95,99,83,97,98,14,84,93,99,92,82,14,84,93,96},18), message)
end)
if not ok then debug(_d({97,83,92,82,49,86,79,98,59,83,97,97,79,85,83,14,83,96,96,93,96,40},18), err) end
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
debug(_d({60,93,98,14,91,79,89,87,92,85,14,94,96,93,85,96,83,97,97,14,98,93,101,79,96,82,14,92,79,100,14,98,79,96,85,83,98,14,84,93,96},18), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({97,14,27,14,97,83,92,82,87,92,85,14,29,99,92,97,98,99,81,89},18))
sendChatMessage(_d({29,99,92,97,98,99,81,89},18))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({101,79,87,98,67,92,98,87,90,47,96,96,87,100,83,82,14,98,87,91,83,93,99,98},18))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({92,79,100,66,93,62,93,87,92,98,49,93,92,84,87,96,91,83,82,40},18), label or _d({98,79,96,85,83,98},18), _d({27,14,82,87,82,14,92,93,98,14,79,96,96,87,100,83,14,101,87,98,86,87,92},18), timeout, _d({97,26,14,96,83,98,96,103,87,92,85,14,93,92,81,83},18))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({92,79,100,66,93,62,93,87,92,98,49,93,92,84,87,96,91,83,82,40},18), label or _d({98,79,96,85,83,98},18), _d({27,14,97,98,87,90,90,14,92,93,98,14,79,96,96,87,100,83,82,14,79,84,98,83,96,14,96,83,98,96,103,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
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
if not ok then debug(_d({92,79,100,66,93,62,93,87,92,98,54,93,90,82,87,92,85,48,90,93,81,89,14,89,83,103,27,82,93,101,92,14,83,96,96,93,96,40},18), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({92,79,100,66,93,62,93,87,92,98,54,93,90,82,87,92,85,48,90,93,81,89,14,89,83,103,27,99,94,14,83,96,96,93,96,40},18), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({69,79,90,89,87,92,85,14,98,93,40},18), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({101,79,90,89,66,93,62,93,87,92,98,14,69,14,82,93,101,92,14,83,96,96,93,96,40},18), err) end
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
debug(_d({66,93,93,89,14,82,79,91,79,85,83,14,101,86,87,90,83,14,101,79,90,89,87,92,85,14,98,93,14,94,93,87,92,98,15,14,65,98,93,94,94,87,92,85,14,101,79,90,89,14,98,93,14,83,92,85,79,85,83,28},18))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({47,96,96,87,100,83,82,14,79,98,40},18), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({65,98,99,81,89,14,82,99,96,87,92,85,14,101,79,90,89,26,14,88,99,91,94,87,92,85,15},18))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({65,98,87,90,90,14,97,98,99,81,89,26,14,98,96,87,85,85,83,96,87,92,85,14,53,83,94,94,93,15},18))
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
debug(_d({59,93,100,87,92,85,14,98,93},18), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,60,62,49,97,14,98,93,14,97,94,79,101,92,14,79,98},18), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({14,14,97,94,79,101,92,14,81,86,83,81,89,40,14,84,93,90,82,83,96,14,83,102,87,97,98,97,14,43},18), folder ~= nil,
_d({26,14,81,86,87,90,82,96,83,92,14,43},18), folder and #folder:GetChildren() or 0,
_d({26,14,79,90,87,100,83,14,43},18), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({60,93,14,60,62,49,97,14,79,94,94,83,79,96,83,82,14,79,98},18), stageName, _d({79,84,98,83,96,14,31,35,97,26,14,91,93,100,87,92,85,14,93,92,14,79,92,103,101,79,103},18))
break
end
end
debug(_d({57,87,90,90,87,92,85,14,60,62,49,97,14,79,98},18), stageName)
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
debug(_d({64,83,98,99,96,92,87,92,85,14,98,93},18), stageName, _d({94,93,97,87,98,87,93,92,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,93,92},18))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98},18), stageName, _d({94,93,97,87,98,87,93,92},18))
task.wait(5)
debug(_d({69,79,87,98,87,92,85,14,84,93,96},18), targetHP * 100, _d({19,14,54,62,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,98,93,14,92,83,102,98,14,97,98,79,85,83},18))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({81,90,83,79,96,83,82},18))
end
local function killNamedNPC(name, targetPos)
debug(_d({59,93,100,87,92,85,14,98,93},18), name)
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
debug(name, _d({82,83,84,83,79,98,83,82},18))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({58,83,93,14,94,90,79,103,83,82,14,79,92,87,91,79,98,87,93,92,40},18), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({90,83,93,47,92,87,91,58,93,85,85,83,96,14,94,96,87,92,98,14,83,96,96,93,96,40},18), err2) end
end)
end)
if not ok then debug(_d({97,98,79,96,98,58,83,93,47,92,87,91,58,93,85,85,83,96,14,83,96,96,93,96,40},18), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({59,93,100,87,92,85,14,98,93,14,58,83,93},18))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({58,83,93},18))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({58,83,93},18))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({58,83,93},18))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({58,83,93,14,81,79,97,98,87,92,85},18), which, _d({27,14,82,93,82,85,87,92,85},18))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({58,83,93,14,97,98,79,96,98,83,82,14,80,90,93,81,89,27,80,96,83,79,89,83,96,14,91,87,82,27,80,90,93,81,89,15,14,51,100,79,82,87,92,85,28,28,28},18))
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
if not getNPCByName(_d({58,83,93},18)) then
debug(_d({58,83,93,14,85,93,92,83,14,91,87,82,27,82,93,82,85,83,14,27,14,83,92,82,87,92,85,14,51,92,98,83,87,14,86,93,90,82,14,83,79,96,90,103},18))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({58,83,93},18)) then
setNavNamed(_d({58,83,93},18))
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
debug(_d({58,83,93,14,82,83,84,83,79,98,83,82},18))
stopLeoAnimLogger()
debug(_d({64,83,98,99,96,92,87,92,85,14,98,93,14,58,83,93,14,94,93,97,87,98,87,93,92,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,93,92},18))
navToPointConfirmed(COORDS.Leo, 30, _d({58,83,93,14,94,93,97,87,98,87,93,92},18))
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98,14,58,83,93,14,94,93,97,87,98,87,93,92},18))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({59,93,100,87,92,85,14,98,93},18), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,97,98,79,98,99,83,14,91,93,82,83,90,14,92,83,79,96},18), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({47,98,98,79,81,89,87,92,85},18), coordKey, _d({101,87,98,86},18), weapon or _d({92,93,98,86,87,92,85,14,84,93,99,92,82},18))
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
debug(coordKey, _d({80,79,96,96,83,90,14,82,83,97,98,96,93,103,83,82},18))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({27,14,81,93,99,90,82,14,92,93,98,14,84,87,92,82,14,97,98,79,98,99,83,14,91,93,82,83,90,26,14,97,89,87,94,94,87,92,85},18))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({97,98,87,90,90,14,79,90,87,100,83,14,22,54,62},18), hp, _d({23,14,27,14,96,83,27,82,83,97,98,96,93,103,87,92,85},18))
destroyStatue(coordKey)
else
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({81,93,92,84,87,96,91,83,82,14,82,83,97,98,96,93,103,83,82},18))
end
end)
if not ok then debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,14,83,96,96,93,96,40},18), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({59,93,100,87,92,85,14,98,93,14,63,99,83,83,92},18))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
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
debug(_d({63,99,83,83,92,14,83,92,98,83,96,83,82,14,94,86,79,97,83,14,32},18))
end
local function finishQueen()
debug(_d({52,87,92,87,97,86,87,92,85,14,63,99,83,83,92},18))
equipSwordOrMelee()
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
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
debug(_d({63,99,83,83,92,14,82,83,84,83,79,98,83,82,28,14,62,90,79,92,14,81,93,91,94,90,83,98,83,28},18))
end
local CONFIRMATION_PROMPT_NAME = _d({49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98},18)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({64,83,91,93,98,83,51,100,83,92,98},18), 5)
end)
if ok then return result end
debug(_d({85,83,98,64,83,94,90,79,103,64,83,91,93,98,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({55,91,79,85,83,48,99,98,98,93,92},18)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({80,99,98,98,93,92,68,79,90,99,83},18)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({84,87,92,82,48,99,98,98,93,92,48,103,68,79,90,99,83,14,83,96,96,93,96,40},18), result)
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
if not ok then debug(_d({81,90,87,81,89,53,99,87,48,99,98,98,93,92,14,83,96,96,93,96,40},18), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({87,97,65,83,96,100,83,96},18))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({64,83,91,93,98,83,51,100,83,92,98},18))
or inst:FindFirstChild(_d({81,90,87,83,92,98,51,100,83,92,98},18))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({84,87,92,82,47,92,97,101,83,96,49,93,92,92,83,81,98,93,96,14,83,96,96,93,96,40},18), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({49,93,99,90,82,14,92,93,98,14,90,93,81,79,98,83,14,64,83,91,93,98,83,51,100,83,92,98,29,81,90,87,83,92,98,51,100,83,92,98,14,92,83,79,96,14,64,83,94,90,79,103,14,80,99,98,98,93,92,26,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,81,90,87,81,89},18))
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
debug(_d({84,87,96,83,64,83,94,90,79,103,68,79,90,99,83,14,83,96,96,93,96,40},18), err, _d({27,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,81,90,87,81,89},18))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({52,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,80,99,98,98,93,92,68,79,90,99,83,14,97,83,79,96,81,86,14,84,93,96,14,64,83,94,90,79,103},18))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({64,83,94,90,79,103,14,80,99,98,98,93,92,14,92,93,98,14,84,93,99,92,82,14,83,87,98,86,83,96,26,14,85,87,100,87,92,85,14,99,94},18))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,28,64,83,91,93,98,83,51,100,83,92,98},18))
local remote = getReplayRemote()
if not remote then
debug(_d({49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,29,64,83,91,93,98,83,51,100,83,92,98,14,92,93,98,14,84,93,99,92,82,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98},18))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({52,87,96,87,92,85,14,64,83,94,90,79,103,14,100,87,79,14,49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,28,64,83,91,93,98,83,51,100,83,92,98},18))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({52,87,96,83,65,83,96,100,83,96,14,83,96,96,93,96,40},18), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then
debug(_d({101,79,87,98,52,93,96,61,80,88,83,81,98,87,100,83,97,53,99,87,40,14,92,93,14,62,90,79,103,83,96,53,99,87,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({61,80,88,83,81,98,87,100,83,97,14,53,67,55,14,84,93,99,92,82,14,27,14,97,98,79,85,83,14,90,93,79,82,83,82},18))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({61,80,88,83,81,98,87,100,83,97,14,53,67,55,14,92,93,98,14,84,93,99,92,82,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
return
end
end
end)
if not ok then debug(_d({101,79,87,98,52,93,96,61,80,88,83,81,98,87,100,83,97,53,99,87,14,83,96,96,93,96,40},18), err) end
end
local function runPlan()
debug(_d({62,90,79,92,14,97,98,79,96,98,83,82},18))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({65,98,79,96,98,87,92,85,14,92,79,100,14,90,93,93,94},18))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({94,93,97,14,30,28,32,97,14,47,52,66,51,64,14,97,98,79,96,98,60,79,100,40},18), rootAfter and rootAfter.Position)
end)
debug(_d({69,79,87,98,87,92,85,14,35,97,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,98,93,14,65,98,79,85,83,31},18))
task.wait(5)
for _, stage in ipairs({_d({65,98,79,85,83,31},18), _d({65,98,79,85,83,32},18), _d({65,98,79,85,83,33},18), _d({65,98,79,85,83,33,48},18)}) do
if not enabled then return end
local hpTarget = (stage == _d({65,98,79,85,83,33,48},18)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,98,93,14,79,96,96,93,101,14,84,90,103,27,82,93,101,92,14,79,96,83,79,14,22,49,99,94,87,82,14,64,79,87,92,23},18))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({50,93,82,85,87,92,85,14,79,96,96,93,101,14,96,79,87,92,14,87,92,14,79,14,97,95,99,79,96,83},18))
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
clearStage(_d({65,98,79,85,83,34},18))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({63,99,83,83,92,14,87,92,14,94,86,79,97,83,14,32,14,27,14,89,83,83,94,87,92,85,14,57,83,92,14,54,79,89,87,14,79,81,98,87,100,83,14,84,96,93,91,14,86,83,96,83,14,93,92},18))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({65,98,79,98,99,83,31},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,31},18))
destroyStatue(_d({65,98,79,98,99,83,32},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,31},18))
recheckStatue(_d({65,98,79,98,99,83,32},18))
destroyStatue(_d({65,98,79,98,99,83,33},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,33},18))
recheckStatue(_d({65,98,79,98,99,83,32},18))
recheckStatue(_d({65,98,79,98,99,83,31},18))
if not enabled then return end
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,94,86,79,97,83,14,32,14,98,93,14,83,92,82},18))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({62,86,79,97,83,14,32,14,83,92,82,14,101,79,87,98,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,80,79,81,89,14,98,93,14,63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
navToPointConfirmed(COORDS.Queen, 30, _d({63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98,14,63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
task.wait(5)
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,98,93,14,94,93,97,98,27,63,99,83,83,92,14,94,93,97,87,98,87,93,92},18))
navToPointConfirmed(COORDS.PostQueen, 30, _d({94,93,97,98,27,63,99,83,83,92,14,94,93,97,87,98,87,93,92},18))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({51,92,79,80,90,87,92,85,26,14,94,93,97,14,48,51,52,61,64,51,14,94,90,79,92,40},18), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({62,90,79,92,14,83,96,96,93,96,40},18), err2) end
end)
debug(_d({51,92,79,80,90,83,82,40},18), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({51,92,79,80,90,83,82,40},18), enabled)
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
if not ok then debug(_d({55,92,94,99,98,48,83,85,79,92,14,83,96,96,93,96,40},18), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({53,79,91,83,14,90,93,79,82,83,82,26,14,79,99,98,93,27,97,98,79,96,98,87,92,85,14,98,86,83,14,94,90,79,92},18))
enableBot()
end)
if not ok then debug(_d({47,99,98,93,97,98,79,96,98,14,83,96,96,93,96,40},18), err) end
end)
debug(_d({58,93,79,82,83,82,14,208,110,130,14,79,99,98,93,27,97,98,79,96,98,87,92,85,14,93,92,81,83,14,98,86,83,14,85,79,91,83,14,84,87,92,87,97,86,83,97,14,90,93,79,82,87,92,85,14,22,94,96,83,97,97,14,62,14,98,93,14,98,93,85,85,90,83,14,91,79,92,99,79,90,90,103,23},18))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,64,79,103,84,87,83,90,82,29,91,79,87,92,29,97,93,99,96,81,83,28,90,99,79},18)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({73,54,93,96,93,14,100,32,75,14,52,79,87,90,83,82,14,98,93,14,90,93,79,82,14,64,79,103,84,87,83,90,82,14,67,55,14,58,87,80,96,79,96,103,28},18))
end
local Window = Rayfield:CreateWindow({
Name = _d({54,93,96,93,14,54,93,96,93,14,72,27,52,79,96,91,14,100,32},18),
LoadingTitle = _d({58,93,79,82,87,92,85,14,54,93,96,93,14,100,32,28,28,28},18),
LoadingSubtitle = _d({65,87,90,83,92,98,14,47,87,91,14,61,94,98,87,91,87,104,83,82},18),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.HoroSelectedBoss = nil
_G.HoroAutoZLoop = false
local checkSpawnInterval = 60
local useE = true
local useZ = true
local useC = true
local useR = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({47,99,98,93,14,52,79,96,91},18), 4483362458)
local SkillTab = Window:CreateTab(_d({65,89,87,90,90,14,65,83,98,98,87,92,85,97},18), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({54,93,96,93,27,54,93,96,93},18)) or (bp and bp:FindFirstChild(_d({54,93,96,93,27,54,93,96,93},18)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({60,62,49,97},18))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum = boss:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
if not _G.HoroMouseHooked then
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and _G.HoroAutoZLoop and _G.HoroSelectedBoss then
local target = getBossPart(_G.HoroSelectedBoss)
if target then
if key == _d({54,87,98},18) then
return target.CFrame
elseif key == _d({66,79,96,85,83,98},18) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({73,54,93,96,93,14,100,32,75,14,59,83,98,79,98,79,80,90,83,14,86,93,93,89,14,84,79,87,90,83,82,40,14},18) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({73,54,93,96,93,14,100,32,75,14,49,90,83,79,92,83,82,14,99,94,14,94,96,83,100,87,93,99,97,14,97,83,97,97,87,93,92,28},18))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({65,98,79,98,99,97,40,14,69,79,87,98,87,92,85,14,84,93,96,14,48,93,97,97,14,65,94,79,101,92},18)) end
print(_d({73,54,93,96,93,14,100,32,75,14,48,93,97,97},18), _G.HoroSelectedBoss, _d({87,97,14,92,93,98,14,97,94,79,101,92,83,82,28,14,69,79,87,98,87,92,85,28,28,28},18))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({65,98,79,98,99,97,40,14,64,99,92,92,87,92,85,14,49,93,91,80,93},18)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({73,54,93,96,93,14,100,32,75,14,52,87,96,83,82,14,49,14,22,57,79,91,87,89,79,104,83,23},18))
elseif useZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
print(_d({73,54,93,96,93,14,100,32,75,14,52,87,96,83,82,14,72,14,22,59,87,92,87,14,48,79,96,96,79,85,83,23},18))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({73,54,93,96,93,14,100,32,75,14,52,87,96,83,82,14,51,14,22,65,98,99,92,23},18))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({73,54,93,96,93,14,100,32,75,14,52,87,96,83,82,14,64,14,22,50,83,98,93,92,79,98,87,93,92,23},18))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({65,98,79,98,99,97,40,14,65,90,83,83,94,87,92,85,14,22},18) .. string.format(_d({19,28,31,84},18), finalSleep) .. _d({97,23},18)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({65,98,79,98,99,97,40,14,55,82,90,83},18))
MainTab:CreateDropdown({
Name = _d({65,83,90,83,81,98,14,48,93,97,97},18),
Options = {_d({47,102,83,14,54,79,92,82,14,58,93,85,79,92},18), _d({48,79,92,82,87,98,14,48,93,97,97},18), _d({56,99,104,93,14,98,86,83,14,50,87,79,91,93,92,82,80,79,81,89},18)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({73,54,93,96,93,14,100,32,75,14,65,83,90,83,81,98,83,82,14,98,79,96,85,83,98,40},18), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({65,98,79,96,98,14,47,99,98,93,14,52,79,96,91},18),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({65,83,90,83,81,98,14,48,93,97,97,14,64,83,95,99,87,96,83,82},18),
Content = _d({71,93,99,14,91,99,97,98,14,97,83,90,83,81,98,14,79,14,80,93,97,97,14,84,87,96,97,98,14,80,83,84,93,96,83,14,83,92,79,80,90,87,92,85,14,47,99,98,93,14,52,79,96,91,15},18),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({65,98,79,98,99,97,40,14,55,82,90,83},18)) end
end
print(_d({73,54,93,96,93,14,100,32,75,14,47,99,98,93,14,52,79,96,91,40},18), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({50,83,97,98,96,93,103,14,67,55},18),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Use E (Stun)",
CurrentValue = true,
Callback = function(Value) useE = Value end,
})
SkillTab:CreateToggle({
Name = "Use Z (Mini)",
CurrentValue = true,
Callback = function(Value) useZ = Value end,
})
SkillTab:CreateToggle({
Name = "Use C (Kamikaze)",
CurrentValue = true,
Callback = function(Value) useC = Value end,
})
SkillTab:CreateToggle({
Name = "Use R (Snap)",
CurrentValue = true,
Callback = function(Value) useR = Value end,
})
})();
end
local function loadLevelGrinder()
(function()
_G.EasyTravelHelperMode = true
if _G.GepoGrinderRunning then
warn("[Gepo Grinder] Already running! Aborting duplicate launch.")
return
end
_G.GepoGrinderRunning = true
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local running = true
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X
and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end
local function waitForGameLoad()
print("[Gepo Grinder] Waiting for game to load...")
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart_d({23,14,93,96,14,92,93,98,14,58,93,81,79,90,62,90,79,103,83,96,28,49,86,79,96,79,81,98,83,96,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,69,86,87,81,86,55,97,47,22},18)Humanoid") do
task.wait(0.5)
end
local folderName = _d({65,98,79,98,97},18) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error("[Gepo Grinder] Stats folder not found in ReplicatedStorage!")
end
statsFolder:WaitForChild(_d({65,98,79,98,97},18), 10)
statsFolder:WaitForChild("Inventory", 10)
statsFolder:WaitForChild("Settings", 10)
print("[Gepo Grinder] Game fully loaded!")
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({65,98,79,98,97},18)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild("Level") and stats.Level.Value or 1
local peli = stats:FindFirstChild("Peli") and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild("Rifle_d({23,14,93,96,14,22,58,93,81,79,90,62,90,79,103,83,96,28,49,86,79,96,79,81,98,83,96,14,79,92,82,14,58,93,81,79,90,62,90,79,103,83,96,28,49,86,79,96,79,81,98,83,96,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,22},18)Rifle"))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild("Inventory_d({23,14,79,92,82,14,97,98,79,98,97,52,93,90,82,83,96,28,55,92,100,83,92,98,93,96,103,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,22},18)Inventory")
if invVal then
return invVal.Value:find('"Rifle"') ~= nil
end
return false
end
local function importLib(localPath, rawUrl)
local loaded = false
if isfile and readfile then
pcall(function()
if isfile(localPath) then
local content = readfile(localPath)
if content and content ~= "" then
loadstring(content)()
loaded = true
end
end
end)
end
if not loaded then
pcall(function()
loadstring(game:HttpGet(rawUrl))()
end)
end
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
importLib("lib/easy_travel.lua_d({26,14},18)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 4.0 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn("[Gepo Grinder] _G.EasyTravel is missing. Cannot navigate.")
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function getHotbarMapping()
local slots = {"Zero_d({26,14},18)One_d({26,14},18)Two_d({26,14},18)Three_d({26,14},18)Four_d({26,14},18)Five_d({26,14},18)Six_d({26,14},18)Seven_d({26,14},18)Eight_d({26,14},18)Nine"}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = "None"
end
local pgui = LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
local backpackGui = pgui and pgui:FindFirstChild("BackpackGui")
local hotbar = backpackGui and backpackGui:FindFirstChild("Hotbar")
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= "Design_d({14,79,92,82,14,81,86,87,90,82,28,60,79,91,83,14,108,43,14},18)Number_d({14,79,92,82,14,81,86,87,90,82,28,60,79,91,83,14,108,43,14},18)UIListLayout_d({14,79,92,82,14,81,86,87,90,82,28,60,79,91,83,14,108,43,14},18)UIPadding" then
mapping[slot] = child.Name
break
end
end
end
end
end
return mapping
end
local function syncClientHotbar(mapping)
local hotbarRemote = ReplicatedStorage.Events:FindFirstChild("Hotbar")
if hotbarRemote then
hotbarRemote:FireServer(mapping)
end
local synced = false
if filtergc then
pcall(function()
local cache = filtergc("table_d({26,14,105,14,57,83,103,97,14,43,14,105},18)One_d({26,14},18)Two_d({26,14},18)Three"} }, true)
if cache and type(cache) == "table" then
for slot, toolName in pairs(mapping) do
rawset(cache, slot, toolName)
end
synced = true
end
end)
end
if not synced and getgc then
pcall(function()
for _, v in ipairs(getgc(true)) do
if type(v) == "table" then
if rawget(v, "One_d({23,14,108,43,14,92,87,90,14,79,92,82,14,96,79,101,85,83,98,22,100,26,14},18)Two_d({23,14,108,43,14,92,87,90,14,79,92,82,14,96,79,101,85,83,98,22,100,26,14},18)Three") ~= nil then
for slot, toolName in pairs(mapping) do
rawset(v, slot, toolName)
end
end
end
end
end)
end
end
local function cleanup(reason)
running = false
stopNavigation()
_G.EasyTravelHelperMode = nil
_G.GepoGrinderRunning = false
print("[Gepo Grinder] Stopped: _d({14,28,28,14,22,96,83,79,97,93,92,14,93,96,14},18)done_d({23,14,28,28,14},18).")
end
_G.GepoGrinderCleanup = function()
cleanup("manual cleanup hook")
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.P then
if running then
print("[Gepo Grinder] P pressed — aborting!")
cleanup("P key abort")
end
end
end)
task.spawn(function()
local ok, err = pcall(function()
waitForGameLoad()
if not running then return end
if hasRifleTool() then
print("[Gepo Grinder] Rifle already equipped/owned.")
local rifle = LocalPlayer.Backpack:FindFirstChild("Rifle")
local hum = getHumanoid()
if rifle and hum then
hum:EquipTool(rifle)
print("[Gepo Grinder] Rifle equipped!")
end
cleanup("Rifle already owned")
return
end
local _, peli = getStats()
local ownsRifleInInventory = hasRifleInInventory()
if peli < 300 and not ownsRifleInInventory then
local myRoot = getRoot()
if not myRoot or not isInsideTownOfBeginnings(myRoot.Position) then
warn("[Gepo Grinder] Not enough Peli to buy a Rifle (300) and not at Town of Beginnings. Please travel to Town of Beginnings to chest farm.")
cleanup("Invalid location for chest farming")
return
end
if not _G.EasyTravel then
importLib("lib/easy_travel.lua_d({26,14},18)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
end
if not _G.ChestFarmer then
importLib("lib/chest_farmer.lua_d({26,14},18)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/chest_farmer.lua")
end
if _G.ChestFarmer then
local getPeli = function()
local _, p = getStats()
return p
end
local isRunning = function()
return running
end
local farmSuccess = _G.ChestFarmer.FarmUntilPeli(300, getPeli, isRunning)
if not farmSuccess or not running then
cleanup("Chest farm failed or stopped")
return
end
else
error("[Gepo Grinder] Failed to load lib/chest_farmer.lua!")
end
end
if not running then return end
if not hasRifleInInventory() then
print("[Gepo Grinder] Navigating to buy Rifle...")
local buyables = Workspace:FindFirstChild("BuyableItems")
local shopItem = buyables and buyables:FindFirstChild("Rifle")
local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")
if not shopPart then
error("[Gepo Grinder] Rifle ShopPart not found under BuyableItems!")
end
local shopTarget = shopPart.Position - Vector3.new(0, 3.0, 0)
local elapsed = 0
local reached = false
while running and elapsed < 30 do
task.wait(0.1)
elapsed = elapsed + 0.1
if navigateTo(shopTarget) then
reached = true
break
end
end
if not reached or not running then
cleanup("Failed to reach Rifle shop")
return
end
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
print("[Gepo Grinder] Purchased Rifle prompt triggered.")
else
warn("[Gepo Grinder] fireproximityprompt not supported by executor!")
end
else
error("[Gepo Grinder] ProximityPrompt not found on Rifle shop item!")
end
local purchaseElapsed = 0
while running and purchaseElapsed < 5 do
task.wait(0.2)
purchaseElapsed = purchaseElapsed + 0.2
local shopEvent = ReplicatedStorage:FindFirstChild("Events_d({23,14,79,92,82,14,64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83,28,51,100,83,92,98,97,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,22},18)Shop")
if shopEvent and shopEvent:IsA("RemoteFunction") then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
if hasRifleInInventory() then
break
end
end
end
if not running then return end
print("[Gepo Grinder] Equipping Rifle from inventory...")
local mapping = getHotbarMapping()
local currentSlot = nil
for slot, toolName in pairs(mapping) do
if toolName == "Rifle" then
currentSlot = slot
break
end
end
if not currentSlot then
local slotsOrder = {"One_d({26,14},18)Two_d({26,14},18)Three_d({26,14},18)Four_d({26,14},18)Five_d({26,14},18)Six_d({26,14},18)Seven_d({26,14},18)Eight_d({26,14},18)Nine_d({26,14},18)Zero"}
for _, slot in ipairs(slotsOrder) do
if mapping[slot] == "None" then
currentSlot = slot
break
end
end
if not currentSlot then
currentSlot = "Nine"
end
mapping[currentSlot] = "Rifle"
print("[Gepo Grinder] Binding Rifle to hotbar slot: " .. tostring(currentSlot))
syncClientHotbar(mapping)
else
print("[Gepo Grinder] Rifle is already mapped to hotbar slot: " .. tostring(currentSlot))
end
local replicaElapsed = 0
local rifleTool = nil
while running and replicaElapsed < 10 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild("Rifle_d({23,14,93,96,14,22,58,93,81,79,90,62,90,79,103,83,96,28,49,86,79,96,79,81,98,83,96,14,79,92,82,14,58,93,81,79,90,62,90,79,103,83,96,28,49,86,79,96,79,81,98,83,96,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,22},18)Rifle"))
if rifleTool then
break
end
end
if not rifleTool then
warn("[Gepo Grinder] Rifle was bound to hotbar but did not appear in Backpack/Character within 10 seconds.")
cleanup("Rifle replication timeout")
return
end
local finalRifle = LocalPlayer.Backpack:FindFirstChild("Rifle")
local hum = getHumanoid()
if finalRifle and hum then
hum:EquipTool(finalRifle)
print("[Gepo Grinder] Rifle successfully equipped!")
end
cleanup("Rifle purchased, hotbar bound, and equipped")
end)
if not ok then
warn("[Gepo Grinder] Fatal error: " .. tostring(err))
cleanup("fatal error")
end
end)
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil
_G.EasyTravel = {
TargetPosition = nil,
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum = char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({23,14,93,96,14,55,92,97,98,79,92,81,83,28,92,83,101,22},18)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = "__EasyTravelForce"
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
local force = root:FindFirstChild("__EasyTravelForce")
local att = root:FindFirstChild("__EasyTravelAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function getSurfaceY(position, character)
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
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local moveDir = Vector3.zero
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
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
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
else
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (currentSpeed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print("[Easy Travel] Flight enabled.")
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print("[Easy Travel] Flight disabled.")
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
_G.EasyTravel.GetSurfaceY = getSurfaceY
if not _G.EasyTravelHelperMode then
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
elseif input.KeyCode == Enum.KeyCode.End then
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end
end)
end
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
print("[Easy Travel] Completely unloaded and cleaned up script state.")
end
if _G.EasyTravelHelperMode then
print("[Easy Travel] Loaded in helper mode. Keyboard inputs disabled.")
else
print("[Easy Travel] Loaded. Press 'P' to toggle flight. _G.EasyTravel API registered.")
end
return _G.EasyTravel
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local RunService = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({87,82,90,83},18)
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
print("[OverworldTester]", ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({87,92,100,93,89,83,53,83,94,94,93,14,83,96,96,93,96,40},18), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({23,14,93,96,14,55,92,97,98,79,92,81,83,28,92,83,101,22},18)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = "__TestHoverForce"
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
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({69,79,90,89,87,92,85,14,98,93,40},18), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({101,79,90,89,66,93,62,93,87,92,98,14,69,14,82,93,101,92,14,83,96,96,93,96,40},18), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({47,96,96,87,100,83,82,14,79,98,40},18), pos)
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
local root = getRoot()
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA("Model_d({23,14,79,92,82,14,87,98,83,91,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,22},18)HumanoidRootPart_d({23,14,79,92,82,14,87,98,83,91,40,52,87,92,82,52,87,96,97,98,49,86,87,90,82,69,86,87,81,86,55,97,47,22},18)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18)).Health > 0 then
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
mode = _d({87,82,90,83},18)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug("Tester Disabled")
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug("Tester Enabled. Mode:", mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug("Player died! Disabling bot.")
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({86,93,100,83,96},18) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == "dodge" then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == "square_dodge" then
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
local playerGui = LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild("OverworldTestGui")
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OverworldTestGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🛡️ Cupid Engine Overworld Test"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({65,98,79,98,99,97,40,14,55,82,90,83},18)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn("Hover Above Target", 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({86,93,100,83,96},18))
statusLabel.Text = "Status: Hovering _d({14,28,28,14,100,79,90,14,28,28,14},18) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({14,28,28,14,100,79,90,14,28,28,14},18) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({14,28,28,14,100,79,90,14,28,28,14},18) studs)"
task.spawn(function()
local root = getRoot()
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
while enabled and mode == "square_dodge" and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == "square_dodge" then
disableBot()
statusLabel.Text = "Status: Idle (Square dodge done)"
end
end)
end)
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = "EMERGENCY STOP"
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = "Status: STOPPED (Idle)"
local VIM = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild("GPOLauncherUI")
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GPOLauncherUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "🌌 GPO Hub Launcher"
title.Parent = main
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = "Choose a bot or utility to run:"
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = "  " .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new("TextLabel")
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
CreateLaunchButton("Cupid Dungeon Farm_d({26,14},18)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({26,14},18)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({26,14},18)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({26,14},18)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({26,14},18)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()