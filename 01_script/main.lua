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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({48,76,65,89,69,82,83},32))
local UserInputService    = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local RunService          = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM                 = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local ReplicatedStorage    = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({59,34,79,83,83,34,79,84,61},32), _d({55,82,79,78,71,0,71,65,77,69,0,194,96,116,0,48,76,65,67,69,41,68,26},32), game.PlaceId, _d({53,78,73,86,69,82,83,69,41,68,26},32), game.GameId, _d({13,0,78,79,84,0,82,85,78,78,73,78,71},32))
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
local LEO_PILLAR_ANIM_ID   = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,20,20,17,20,17,19,18,23},32)
local LEO_ENTEI_ANIM_ID    = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,20,20,17,19,24,18,23,24},32)
local LEO_HIKEN_ANIM_ID    = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,18,16,25,17,23,20,16,23},32)
local LEO_FIREFLY_ANIM_ID  = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,18,16,18,19,22,17,21,20},32)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({47,66,74,69,67,84,73,86,69,83},32)
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
local REPLAY_BUTTON_VALUE   = _d({50,69,80,76,65,89},32)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({77,79,86,69},32)
local NavState   = {mode = _d({73,68,76,69},32)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({59,34,79,83,83,34,79,84,61},32), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end)
if ok then return root end
debug(_d({71,69,84,50,79,79,84,0,69,82,82,79,82,26},32), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end)
if ok then return hum end
debug(_d({71,69,84,40,85,77,65,78,79,73,68,0,69,82,82,79,82,26},32), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({9,0,79,82,0,41,78,83,84,65,78,67,69,14,78,69,87,8},32)Attachment")
att.Name = _d({63,63,40,79,86,69,82,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,40,79,86,69,82,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,40,79,86,69,82,38,79,82,67,69},32)
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
debug(_d({71,69,84,47,82,35,82,69,65,84,69,38,79,82,67,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local force = root:FindFirstChild(_d({63,63,40,79,86,69,82,38,79,82,67,69},32))
local att   = root:FindFirstChild(_d({63,63,40,79,86,69,82,33,84,84},32))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({67,76,69,65,78,85,80,38,79,82,67,69,0,69,82,82,79,82,26},32), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({34,85,83,79,45,69,76,69,69},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,34,85,83,79,33,67,84,73,86,69,0,69,82,82,79,82,26},32), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({34,85,83,79},32))
end)
if not ok then debug(_d({65,67,84,73,86,65,84,69,34,85,83,79,0,69,82,82,79,82,26},32), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({34,85,83,79,0,78,79,84,0,65,67,84,73,86,69,12,0,65,67,84,73,86,65,84,73,78,71},32))
activateBuso()
end
end)
if not ok then debug(_d({34,85,83,79,43,69,69,80,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({34,85,83,79,0,75,69,69,80,69,82,0,83,84,79,80,80,69,68},32))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({43,69,78,40,65,75,73},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,43,69,78,33,67,84,73,86,69,0,69,82,82,79,82,26},32), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({43,69,78},32), true)
end)
if not ok then debug(_d({65,67,84,73,86,65,84,69,43,69,78,0,69,82,82,79,82,26},32), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({43,69,78,0,78,79,84,0,65,67,84,73,86,69,12,0,65,67,84,73,86,65,84,73,78,71},32))
activateKen()
end
end)
if not ok then debug(_d({43,69,78,43,69,69,80,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({43,69,78,0,75,69,69,80,69,82,0,83,84,79,80,80,69,68},32))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({46,48,35,83},32)) end)
if ok then return folder end
debug(_d({71,69,84,46,48,35,83,38,79,76,68,69,82,0,69,82,82,79,82,26},32), folder)
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
local r = model:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local h = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
debug(_d({71,69,84,46,69,65,82,69,83,84,46,48,35,0,69,82,82,79,82,26},32), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum  = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({71,69,84,46,48,35,34,89,46,65,77,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({78,80,67,83,50,69,77,65,73,78,73,78,71,0,69,82,82,79,82,26},32), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({35,85,80,73,68,0,49,85,69,69,78},32))
return queen ~= nil and queen:FindFirstChild(_d({77,79,84,73,79,78,44,69,83,83},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,49,85,69,69,78,48,72,65,83,69,18,0,69,82,82,79,82,26},32), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,17,18,17,18,25,23,25,20,18,18,25,18,23,22,25},32)
local QUEEN_GRASP_ANIM_ID   = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,17,18,25,24,16,16,16,22,17,16,16,17,23,19,20},32)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
debug(_d({73,83,48,76,65,89,73,78,71,33,78,73,77,38,82,79,77,44,73,83,84,0,69,82,82,79,82,26},32), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({34,76,79,67,75,73,78,71},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,46,48,35,34,76,79,67,75,73,78,71,0,69,82,82,79,82,26},32), result)
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
debug(_d({80,82,69,68,73,67,84,46,48,35,48,79,83,73,84,73,79,78,0,69,82,82,79,82,26},32), result)
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
debug(_d({46,79,0,68,65,77,65,71,69,0,79,78},32), model.Name, _d({70,79,82},32), NPC_STUCK_TIMEOUT, _d({83,0,13,0,83,87,73,84,67,72,73,78,71,0,84,65,82,71,69,84},32))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({84,82,65,67,75,46,48,35,36,65,77,65,71,69,0,69,82,82,79,82,26},32), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({45,79,68,69,76},32)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({34,65,83,69,48,65,82,84},32)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({71,69,84,45,79,68,69,76,38,65,67,69,48,79,83,0,69,82,82,79,82,26},32), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({37,78,86},32))
local folder = env and env:FindFirstChild(_d({51,84,65,84,85,69,83},32))
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
debug(_d({71,69,84,51,84,65,84,85,69,45,79,68,69,76,46,69,65,82,0,69,82,82,79,82,26},32), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({66,65,82,82,69,76,40,48},32))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({71,69,84,51,84,65,84,85,69,40,48,0,69,82,82,79,82,26},32), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,33,84,84,82,73,66,85,84,69,0,69,82,82,79,82,26},32), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({52,79,79,76},32)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,46,65,77,69,0,69,82,82,79,82,26},32), tool)
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
if not ok then debug(_d({69,81,85,73,80,52,79,79,76,0,69,82,82,79,82,26},32), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,35,72,73,76,68,46,65,77,69,0,69,82,82,79,82,26},32), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({51,87,79,82,68,37,81,85,73,80},32))
if sword then
equipTool(sword)
return _d({83,87,79,82,68},32)
end
local melee = findToolByAttribute(_d({45,69,76,69,69,52,79,79,76},32))
if melee then
equipTool(melee)
return _d({77,69,76,69,69},32)
end
debug(_d({46,79,0,83,87,79,82,68,0,79,82,0,77,69,76,69,69,0,84,79,79,76,0,70,79,85,78,68},32))
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
if not ok then debug(_d({67,76,73,67,75,45,17,0,69,82,82,79,82,26},32), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
end)
if not ok then debug(_d({73,78,86,79,75,69,39,69,80,80,79,0,69,82,82,79,82,26},32), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({80,82,69,83,83,51,75,73,76,76,50,0,69,82,82,79,82,26},32), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({72,79,76,68,34,76,79,67,75,0,69,82,82,79,82,26},32), err) end
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
if not ok then debug(_d({72,79,76,68,34,76,79,67,75,55,72,73,76,69,0,69,82,82,79,82,26},32), err) end
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
debug(_d({71,69,84,39,65,77,69,39,0,69,82,82,79,82,26},32), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({73,83,50,69,65,76,45,17,34,85,83,89,0,69,82,82,79,82,26},32), result)
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
return char ~= nil and char:FindFirstChild(_d({83,84,85,78},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,51,84,85,78,78,69,68,0,69,82,82,79,82,26},32), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({80,82,69,83,83,51,84,85,78,34,82,69,65,75,0,69,82,82,79,82,26},32), err) end
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
debug(_d({81,85,69,69,78,36,79,68,71,69,53,78,84,73,76,51,65,70,69,26,0,49,85,69,69,78,0,71,79,78,69,0,13,0,69,78,68,73,78,71,0,68,79,68,71,69,0,69,65,82,76,89},32))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({81,85,69,69,78,36,79,68,71,69,53,78,84,73,76,51,65,70,69,0,83,65,70,69,84,89,0,84,73,77,69,79,85,84},32))
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
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({49,85,69,69,78,0,67,65,83,84,73,78,71,0,68,69,84,69,67,84,69,68,0,13,0,68,79,68,71,73,78,71,0,8,87,65,84,67,72,69,82,9},32))
queenDodgeUntilSafe(function() return getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) end)
if enabled and getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) then
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
end
queenDodging = false
end
end)
if not ok then debug(_d({81,85,69,69,78,36,79,68,71,69,55,65,84,67,72,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({80,79,73,78,84},32) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({78,80,67},32) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({78,65,77,69,68},32) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({71,69,84,46,65,86,52,65,82,71,69,84,83,0,69,82,82,79,82,26},32), aimR)
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
debug(_d({67,79,77,80,85,84,69,44,79,67,75,69,68,35,38,82,65,77,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({80,79,73,78,84},32), point = pos}
phase = _d({77,79,86,69},32)
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
if not ok then debug(_d({78,65,86,52,79,48,79,73,78,84,0,71,69,80,80,79,0,67,72,69,67,75,0,69,82,82,79,82,26},32), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({78,80,67},32)}
phase = _d({77,79,86,69},32)
end
function setNavNamed(name)
NavState = {mode = _d({78,65,77,69,68},32), name = name}
phase = _d({77,79,86,69},32)
end
local function setNavIdle()
NavState = {mode = _d({73,68,76,69},32)}
phase = _d({77,79,86,69},32)
end
local function hasArrived()
return phase == _d({72,79,86,69,82},32)
end
local function startNav()
phase = _d({77,79,86,69},32)
debug(_d({46,65,86,0,76,79,79,80,0,47,46},32))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({48,76,65,89,69,82,0,68,73,69,68,1,0,51,84,79,80,80,73,78,71,0,66,79,84,14},32))
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
debug(_d({48,76,65,89,69,82,0,73,83,0,84,79,79,0,70,65,82,0,70,82,79,77,0,84,65,82,71,69,84,0,8,30,18,16,16,16,0,83,84,85,68,83,9,14,0,44,73,75,69,76,89,0,82,69,83,80,65,87,78,69,68,0,65,84,0,76,79,66,66,89,14,0,51,84,79,80,80,73,78,71,0,66,79,84,14},32))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({63,63,80,82,69,86,48,79,83},32))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({44,65,82,71,69,0,80,79,83,73,84,73,79,78,0,74,85,77,80,0,68,69,84,69,67,84,69,68,26},32), delta, _d({83,84,85,68,83,14,0,80,82,69,86,48,79,83,29},32), prevPos, _d({78,69,87,48,79,83,29},32), pos)
end
end
force:SetAttribute(_d({63,63,80,82,69,86,48,79,83},32), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({77,79,86,69},32) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({72,79,86,69,82},32)
debug(_d({48,72,65,83,69,26,0,72,79,86,69,82},32))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({1,1,1,0,50,37,38,53,51,41,46,39,0,52,47,0,33,48,48,44,57,0,33,34,46,47,50,45,33,44,0,54,37,44,47,35,41,52,57,26},32), finalVel, _d({65,73,77,29},32), aim, _d({80,79,83,29},32), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({72,79,86,69,82},32) then
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
debug(_d({35,79,77,66,65,84,0,76,79,67,75,0,83,75,73,80,80,69,68,12},32), snapDist, _d({83,84,85,68,83,0,70,82,79,77,0,84,65,82,71,69,84,0,194,96,116,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,77,79,86,69},32))
phase = _d({77,79,86,69},32)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({40,69,65,82,84,66,69,65,84,0,69,82,82,79,82,26},32), err) end
end)
end
local function stopNav()
debug(_d({46,65,86,0,76,79,79,80,0,47,38,38},32))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({77,79,86,69},32)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({52,69,88,84,35,72,65,84,51,69,82,86,73,67,69},32))
local channels = TextChatService:FindFirstChild(_d({52,69,88,84,35,72,65,78,78,69,76,83},32))
local channel = channels and channels:FindFirstChild(_d({50,34,56,39,69,78,69,82,65,76},32))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({36,69,70,65,85,76,84,35,72,65,84,51,89,83,84,69,77,35,72,65,84,37,86,69,78,84,83},32))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({51,65,89,45,69,83,83,65,71,69,50,69,81,85,69,83,84},32))
if sayEvent then
sayEvent:FireServer(message, _d({33,76,76},32))
return
end
debug(_d({83,69,78,68,35,72,65,84,45,69,83,83,65,71,69,26,0,78,79,0,52,69,88,84,35,72,65,84,51,69,82,86,73,67,69,14,50,34,56,39,69,78,69,82,65,76,0,79,82,0,76,69,71,65,67,89,0,51,65,89,45,69,83,83,65,71,69,50,69,81,85,69,83,84,0,70,79,85,78,68,0,70,79,82},32), message)
end)
if not ok then debug(_d({83,69,78,68,35,72,65,84,45,69,83,83,65,71,69,0,69,82,82,79,82,26},32), err) end
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
debug(_d({46,79,84,0,77,65,75,73,78,71,0,80,82,79,71,82,69,83,83,0,84,79,87,65,82,68,0,78,65,86,0,84,65,82,71,69,84,0,70,79,82},32), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({83,0,13,0,83,69,78,68,73,78,71,0,15,85,78,83,84,85,67,75},32))
sendChatMessage(_d({15,85,78,83,84,85,67,75},32))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({87,65,73,84,53,78,84,73,76,33,82,82,73,86,69,68,0,84,73,77,69,79,85,84},32))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({78,65,86,52,79,48,79,73,78,84,35,79,78,70,73,82,77,69,68,26},32), label or _d({84,65,82,71,69,84},32), _d({13,0,68,73,68,0,78,79,84,0,65,82,82,73,86,69,0,87,73,84,72,73,78},32), timeout, _d({83,12,0,82,69,84,82,89,73,78,71,0,79,78,67,69},32))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({78,65,86,52,79,48,79,73,78,84,35,79,78,70,73,82,77,69,68,26},32), label or _d({84,65,82,71,69,84},32), _d({13,0,83,84,73,76,76,0,78,79,84,0,65,82,82,73,86,69,68,0,65,70,84,69,82,0,82,69,84,82,89,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
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
if not ok then debug(_d({78,65,86,52,79,48,79,73,78,84,40,79,76,68,73,78,71,34,76,79,67,75,0,75,69,89,13,68,79,87,78,0,69,82,82,79,82,26},32), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({78,65,86,52,79,48,79,73,78,84,40,79,76,68,73,78,71,34,76,79,67,75,0,75,69,89,13,85,80,0,69,82,82,79,82,26},32), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({55,65,76,75,73,78,71,0,84,79,26},32), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({87,65,76,75,52,79,48,79,73,78,84,0,55,0,68,79,87,78,0,69,82,82,79,82,26},32), err) end
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
debug(_d({52,79,79,75,0,68,65,77,65,71,69,0,87,72,73,76,69,0,87,65,76,75,73,78,71,0,84,79,0,80,79,73,78,84,1,0,51,84,79,80,80,73,78,71,0,87,65,76,75,0,84,79,0,69,78,71,65,71,69,14},32))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({33,82,82,73,86,69,68,0,65,84,26},32), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({51,84,85,67,75,0,68,85,82,73,78,71,0,87,65,76,75,12,0,74,85,77,80,73,78,71,1},32))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({51,84,73,76,76,0,83,84,85,67,75,12,0,84,82,73,71,71,69,82,73,78,71,0,39,69,80,80,79,1},32))
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
debug(_d({45,79,86,73,78,71,0,84,79},32), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,46,48,35,83,0,84,79,0,83,80,65,87,78,0,65,84},32), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({0,0,83,80,65,87,78,0,67,72,69,67,75,26,0,70,79,76,68,69,82,0,69,88,73,83,84,83,0,29},32), folder ~= nil,
_d({12,0,67,72,73,76,68,82,69,78,0,29},32), folder and #folder:GetChildren() or 0,
_d({12,0,65,76,73,86,69,0,29},32), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({46,79,0,46,48,35,83,0,65,80,80,69,65,82,69,68,0,65,84},32), stageName, _d({65,70,84,69,82,0,17,21,83,12,0,77,79,86,73,78,71,0,79,78,0,65,78,89,87,65,89},32))
break
end
end
debug(_d({43,73,76,76,73,78,71,0,46,48,35,83,0,65,84},32), stageName)
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
debug(_d({50,69,84,85,82,78,73,78,71,0,84,79},32), stageName, _d({80,79,83,73,84,73,79,78,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,79,78},32))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84},32), stageName, _d({80,79,83,73,84,73,79,78},32))
task.wait(5)
debug(_d({55,65,73,84,73,78,71,0,70,79,82},32), targetHP * 100, _d({5,0,40,48,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,84,79,0,78,69,88,84,0,83,84,65,71,69},32))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({67,76,69,65,82,69,68},32))
end
local function killNamedNPC(name, targetPos)
debug(_d({45,79,86,73,78,71,0,84,79},32), name)
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
debug(name, _d({68,69,70,69,65,84,69,68},32))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({44,69,79,0,80,76,65,89,69,68,0,65,78,73,77,65,84,73,79,78,26},32), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({76,69,79,33,78,73,77,44,79,71,71,69,82,0,80,82,73,78,84,0,69,82,82,79,82,26},32), err2) end
end)
end)
if not ok then debug(_d({83,84,65,82,84,44,69,79,33,78,73,77,44,79,71,71,69,82,0,69,82,82,79,82,26},32), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({45,79,86,73,78,71,0,84,79,0,44,69,79},32))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({44,69,79},32))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({44,69,79},32))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({44,69,79},32))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({44,69,79,0,67,65,83,84,73,78,71},32), which, _d({13,0,68,79,68,71,73,78,71},32))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({44,69,79,0,83,84,65,82,84,69,68,0,66,76,79,67,75,13,66,82,69,65,75,69,82,0,77,73,68,13,66,76,79,67,75,1,0,37,86,65,68,73,78,71,14,14,14},32))
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
if not getNPCByName(_d({44,69,79},32)) then
debug(_d({44,69,79,0,71,79,78,69,0,77,73,68,13,68,79,68,71,69,0,13,0,69,78,68,73,78,71,0,37,78,84,69,73,0,72,79,76,68,0,69,65,82,76,89},32))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({44,69,79},32)) then
setNavNamed(_d({44,69,79},32))
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
debug(_d({44,69,79,0,68,69,70,69,65,84,69,68},32))
stopLeoAnimLogger()
debug(_d({50,69,84,85,82,78,73,78,71,0,84,79,0,44,69,79,0,80,79,83,73,84,73,79,78,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,79,78},32))
navToPointConfirmed(COORDS.Leo, 30, _d({44,69,79,0,80,79,83,73,84,73,79,78},32))
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84,0,44,69,79,0,80,79,83,73,84,73,79,78},32))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({45,79,86,73,78,71,0,84,79},32), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({35,79,85,76,68,0,78,79,84,0,70,73,78,68,0,83,84,65,84,85,69,0,77,79,68,69,76,0,78,69,65,82},32), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({33,84,84,65,67,75,73,78,71},32), coordKey, _d({87,73,84,72},32), weapon or _d({78,79,84,72,73,78,71,0,70,79,85,78,68},32))
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
debug(coordKey, _d({66,65,82,82,69,76,0,68,69,83,84,82,79,89,69,68},32))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({13,0,67,79,85,76,68,0,78,79,84,0,70,73,78,68,0,83,84,65,84,85,69,0,77,79,68,69,76,12,0,83,75,73,80,80,73,78,71},32))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({83,84,73,76,76,0,65,76,73,86,69,0,8,40,48},32), hp, _d({9,0,13,0,82,69,13,68,69,83,84,82,79,89,73,78,71},32))
destroyStatue(coordKey)
else
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({67,79,78,70,73,82,77,69,68,0,68,69,83,84,82,79,89,69,68},32))
end
end)
if not ok then debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,0,69,82,82,79,82,26},32), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({45,79,86,73,78,71,0,84,79,0,49,85,69,69,78},32))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
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
debug(_d({49,85,69,69,78,0,69,78,84,69,82,69,68,0,80,72,65,83,69,0,18},32))
end
local function finishQueen()
debug(_d({38,73,78,73,83,72,73,78,71,0,49,85,69,69,78},32))
equipSwordOrMelee()
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
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
debug(_d({49,85,69,69,78,0,68,69,70,69,65,84,69,68,14,0,48,76,65,78,0,67,79,77,80,76,69,84,69,14},32))
end
local CONFIRMATION_PROMPT_NAME = _d({35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84},32)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({50,69,77,79,84,69,37,86,69,78,84},32), 5)
end)
if ok then return result end
debug(_d({71,69,84,50,69,80,76,65,89,50,69,77,79,84,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({41,77,65,71,69,34,85,84,84,79,78},32)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({66,85,84,84,79,78,54,65,76,85,69},32)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({70,73,78,68,34,85,84,84,79,78,34,89,54,65,76,85,69,0,69,82,82,79,82,26},32), result)
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
if not ok then debug(_d({67,76,73,67,75,39,85,73,34,85,84,84,79,78,0,69,82,82,79,82,26},32), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({73,83,51,69,82,86,69,82},32))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({50,69,77,79,84,69,37,86,69,78,84},32))
or inst:FindFirstChild(_d({67,76,73,69,78,84,37,86,69,78,84},32))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({70,73,78,68,33,78,83,87,69,82,35,79,78,78,69,67,84,79,82,0,69,82,82,79,82,26},32), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({35,79,85,76,68,0,78,79,84,0,76,79,67,65,84,69,0,50,69,77,79,84,69,37,86,69,78,84,15,67,76,73,69,78,84,37,86,69,78,84,0,78,69,65,82,0,50,69,80,76,65,89,0,66,85,84,84,79,78,12,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,67,76,73,67,75},32))
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
debug(_d({70,73,82,69,50,69,80,76,65,89,54,65,76,85,69,0,69,82,82,79,82,26},32), err, _d({13,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,67,76,73,67,75},32))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({38,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,66,85,84,84,79,78,54,65,76,85,69,0,83,69,65,82,67,72,0,70,79,82,0,50,69,80,76,65,89},32))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({50,69,80,76,65,89,0,66,85,84,84,79,78,0,78,79,84,0,70,79,85,78,68,0,69,73,84,72,69,82,12,0,71,73,86,73,78,71,0,85,80},32))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,14,50,69,77,79,84,69,37,86,69,78,84},32))
local remote = getReplayRemote()
if not remote then
debug(_d({35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,15,50,69,77,79,84,69,37,86,69,78,84,0,78,79,84,0,70,79,85,78,68,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84},32))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({38,73,82,73,78,71,0,50,69,80,76,65,89,0,86,73,65,0,35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,14,50,69,77,79,84,69,37,86,69,78,84},32))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({38,73,82,69,51,69,82,86,69,82,0,69,82,82,79,82,26},32), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
if not playerGui then
debug(_d({87,65,73,84,38,79,82,47,66,74,69,67,84,73,86,69,83,39,85,73,26,0,78,79,0,48,76,65,89,69,82,39,85,73,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({47,66,74,69,67,84,73,86,69,83,0,39,53,41,0,70,79,85,78,68,0,13,0,83,84,65,71,69,0,76,79,65,68,69,68},32))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({47,66,74,69,67,84,73,86,69,83,0,39,53,41,0,78,79,84,0,70,79,85,78,68,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
return
end
end
end)
if not ok then debug(_d({87,65,73,84,38,79,82,47,66,74,69,67,84,73,86,69,83,39,85,73,0,69,82,82,79,82,26},32), err) end
end
local function runPlan()
debug(_d({48,76,65,78,0,83,84,65,82,84,69,68},32))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({51,84,65,82,84,73,78,71,0,78,65,86,0,76,79,79,80},32))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({80,79,83,0,16,14,18,83,0,33,38,52,37,50,0,83,84,65,82,84,46,65,86,26},32), rootAfter and rootAfter.Position)
end)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,84,79,0,51,84,65,71,69,17},32))
task.wait(5)
for _, stage in ipairs({_d({51,84,65,71,69,17},32), _d({51,84,65,71,69,18},32), _d({51,84,65,71,69,19},32), _d({51,84,65,71,69,19,34},32)}) do
if not enabled then return end
local hpTarget = (stage == _d({51,84,65,71,69,19,34},32)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,84,79,0,65,82,82,79,87,0,70,76,89,13,68,79,87,78,0,65,82,69,65,0,8,35,85,80,73,68,0,50,65,73,78,9},32))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({36,79,68,71,73,78,71,0,65,82,82,79,87,0,82,65,73,78,0,73,78,0,65,0,83,81,85,65,82,69},32))
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
clearStage(_d({51,84,65,71,69,20},32))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({49,85,69,69,78,0,73,78,0,80,72,65,83,69,0,18,0,13,0,75,69,69,80,73,78,71,0,43,69,78,0,40,65,75,73,0,65,67,84,73,86,69,0,70,82,79,77,0,72,69,82,69,0,79,78},32))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({51,84,65,84,85,69,17},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,17},32))
destroyStatue(_d({51,84,65,84,85,69,18},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,17},32))
recheckStatue(_d({51,84,65,84,85,69,18},32))
destroyStatue(_d({51,84,65,84,85,69,19},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,19},32))
recheckStatue(_d({51,84,65,84,85,69,18},32))
recheckStatue(_d({51,84,65,84,85,69,17},32))
if not enabled then return end
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,80,72,65,83,69,0,18,0,84,79,0,69,78,68},32))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({48,72,65,83,69,0,18,0,69,78,68,0,87,65,73,84,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,66,65,67,75,0,84,79,0,49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
navToPointConfirmed(COORDS.Queen, 30, _d({49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84,0,49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
task.wait(5)
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,84,79,0,80,79,83,84,13,49,85,69,69,78,0,80,79,83,73,84,73,79,78},32))
navToPointConfirmed(COORDS.PostQueen, 30, _d({80,79,83,84,13,49,85,69,69,78,0,80,79,83,73,84,73,79,78},32))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({37,78,65,66,76,73,78,71,12,0,80,79,83,0,34,37,38,47,50,37,0,80,76,65,78,26},32), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({48,76,65,78,0,69,82,82,79,82,26},32), err2) end
end)
debug(_d({37,78,65,66,76,69,68,26},32), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({37,78,65,66,76,69,68,26},32), enabled)
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
if not ok then debug(_d({41,78,80,85,84,34,69,71,65,78,0,69,82,82,79,82,26},32), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({39,65,77,69,0,76,79,65,68,69,68,12,0,65,85,84,79,13,83,84,65,82,84,73,78,71,0,84,72,69,0,80,76,65,78},32))
enableBot()
end)
if not ok then debug(_d({33,85,84,79,83,84,65,82,84,0,69,82,82,79,82,26},32), err) end
end)
debug(_d({44,79,65,68,69,68,0,194,96,116,0,65,85,84,79,13,83,84,65,82,84,73,78,71,0,79,78,67,69,0,84,72,69,0,71,65,77,69,0,70,73,78,73,83,72,69,83,0,76,79,65,68,73,78,71,0,8,80,82,69,83,83,0,48,0,84,79,0,84,79,71,71,76,69,0,77,65,78,85,65,76,76,89,9},32))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,50,65,89,70,73,69,76,68,15,77,65,73,78,15,83,79,85,82,67,69,14,76,85,65},32)
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
error(_d({59,40,79,82,79,0,86,18,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,0,50,65,89,70,73,69,76,68,0,53,41,0,44,73,66,82,65,82,89,14},32))
end
local Window = Rayfield:CreateWindow({
Name = _d({40,79,82,79,0,40,79,82,79,0,58,13,38,65,82,77,0,86,18},32),
LoadingTitle = _d({44,79,65,68,73,78,71,0,40,79,82,79,0,86,18,14,14,14},32),
LoadingSubtitle = _d({51,73,76,69,78,84,0,33,73,77,0,47,80,84,73,77,73,90,69,68},32),
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
local MainTab = Window:CreateTab(_d({33,85,84,79,0,38,65,82,77},32), 4483362458)
local SkillTab = Window:CreateTab(_d({51,75,73,76,76,0,51,69,84,84,73,78,71,83},32), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)) or (bp and bp:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = boss:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
if key == _d({40,73,84},32) then
return target.CFrame
elseif key == _d({52,65,82,71,69,84},32) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({59,40,79,82,79,0,86,18,61,0,45,69,84,65,84,65,66,76,69,0,72,79,79,75,0,70,65,73,76,69,68,26,0},32) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({59,40,79,82,79,0,86,18,61,0,35,76,69,65,78,69,68,0,85,80,0,80,82,69,86,73,79,85,83,0,83,69,83,83,73,79,78,14},32))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,55,65,73,84,73,78,71,0,70,79,82,0,34,79,83,83,0,51,80,65,87,78},32)) end
print(_d({59,40,79,82,79,0,86,18,61,0,34,79,83,83},32), _G.HoroSelectedBoss, _d({73,83,0,78,79,84,0,83,80,65,87,78,69,68,14,0,55,65,73,84,73,78,71,14,14,14},32))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,50,85,78,78,73,78,71,0,35,79,77,66,79},32)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,35,0,8,43,65,77,73,75,65,90,69,9},32))
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
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,58,0,8,45,73,78,73,0,34,65,82,82,65,71,69,9},32))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,37,0,8,51,84,85,78,9},32))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({59,40,79,82,79,0,86,18,61,0,38,73,82,69,68,0,50,0,8,36,69,84,79,78,65,84,73,79,78,9},32))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,51,76,69,69,80,73,78,71,0,8},32) .. string.format(_d({5,14,17,70},32), finalSleep) .. _d({83,9},32)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({51,84,65,84,85,83,26,0,41,68,76,69},32))
MainTab:CreateDropdown({
Name = _d({51,69,76,69,67,84,0,34,79,83,83},32),
Options = {_d({33,88,69,0,40,65,78,68,0,44,79,71,65,78},32), _d({34,65,78,68,73,84,0,34,79,83,83},32), _d({42,85,90,79,0,84,72,69,0,36,73,65,77,79,78,68,66,65,67,75},32)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({59,40,79,82,79,0,86,18,61,0,51,69,76,69,67,84,69,68,0,84,65,82,71,69,84,26},32), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({51,84,65,82,84,0,33,85,84,79,0,38,65,82,77},32),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({51,69,76,69,67,84,0,34,79,83,83,0,50,69,81,85,73,82,69,68},32),
Content = _d({57,79,85,0,77,85,83,84,0,83,69,76,69,67,84,0,65,0,66,79,83,83,0,70,73,82,83,84,0,66,69,70,79,82,69,0,69,78,65,66,76,73,78,71,0,33,85,84,79,0,38,65,82,77,1},32),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({51,84,65,84,85,83,26,0,41,68,76,69},32)) end
end
print(_d({59,40,79,82,79,0,86,18,61,0,33,85,84,79,0,38,65,82,77,26},32), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({36,69,83,84,82,79,89,0,53,41},32),
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
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = "Bandit"
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild("Stats_d({9,0,65,78,68,0,83,84,65,84,83,38,79,76,68,69,82,14,51,84,65,84,83,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,8},32)Level") and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild("Stats_d({9,0,65,78,68,0,83,84,65,84,83,38,79,76,68,69,82,14,51,84,65,84,83,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,8},32)Peli") and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild("Quest_d({9,0,65,78,68,0,83,84,65,84,83,38,79,76,68,69,82,14,49,85,69,83,84,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,8},32)CurrentQuest_d({9,0,65,78,68,0,83,84,65,84,83,38,79,76,68,69,82,14,49,85,69,83,84,14,35,85,82,82,69,78,84,49,85,69,83,84,14,54,65,76,85,69,0,79,82,0},32)None"
return lvl, peli, quest
end
return 1, 0, "None"
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = npc:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({34,65,83,69,48,65,82,84},32)) then
part.CanCollide = enabled
end
end
end
local function simulateM1()
pcall(function()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.01)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
end
local function computeHorizontalCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, root.Position.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function computeLockedCFrame(root, aimPos, facePos)
return computeHorizontalCFrame(root, facePos) + (aimPos - root.Position)
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/features/easy_travel.lua"))()
end)
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 3.5 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn("[Gepo Grinder] _G.EasyTravel is missing. Please ensure easy_travel.lua is running first.")
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function acceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild("UpperTorso")
local prompt = torso and torso:FindFirstChild("Prompt")
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position - Vector3.new(0, 3.0, 0) + (torso.CFrame.LookVector * 4.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Quest Acceptance] fireproximityprompt not supported by executor!")
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild("go")
local endChatBtn = chatGui.Frame:FindFirstChild("endChat")
if goBtn and goBtn.Visible and goBtn.Text ~= "_d({0,65,78,68,0,71,79,34,84,78,14,52,69,88,84,0,94,29,0},32)..." then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
conn:Fire()
end
end
end
task.wait(0.4)
end
end
return true
end
return false
end
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if not autoGrind then
stopNavigation()
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
end
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed then
if input.KeyCode == Enum.KeyCode.P then
toggleAutoFarm()
print("[Gepo Grinder] Auto farm toggled to: " .. tostring(autoGrind))
end
end
end)
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local lvl, peli, quest = getStats()
local hasRifle = LocalPlayer.Backpack:FindFirstChild("Rifle_d({9,0,79,82,0,44,79,67,65,76,48,76,65,89,69,82,14,35,72,65,82,65,67,84,69,82,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,8},32)Rifle")
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = "Bandit"
if lvl < 3 then
if quest == "None" then
acceptQuest("Daph")
return
end
else
if quest == "None" then
acceptQuest("Sarah")
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({34,65,78,68,73,84,0,34,79,83,83},32)
if quest == "None" then
acceptQuest("Ronny")
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild("BuyableItems")
local shopItem = buyables and buyables:FindFirstChild("Rifle")
local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")
if shopPart then
local targetPos = shopPart.Position - Vector3.new(0, 3.0, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Rifle Purchase] fireproximityprompt not supported by executor!")
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print("[Gepo Grinder] Rifle purchased! Starter Island progression completed. Waiting for Fishman Cave travel phase.")
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local weaponTool = bp and bp:FindFirstChild("Melee")
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({9,0,65,78,68,0,78,80,67,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,55,72,73,67,72,41,83,33,8},32)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(targetPos)
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({9,0,65,78,68,0,70,73,78,65,76,46,80,67,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,55,72,73,67,72,41,83,33,8},32)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({9,0,65,78,68,0,70,73,78,65,76,46,80,67,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,55,72,73,67,72,41,83,33,8},32)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
navigateTo(finalTargetPos)
task.wait(0.05)
end
end
end
end
else
stopNavigation()
end
else
stopNavigation()
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
stopNavigation()
local npcsFolder = Workspace:FindFirstChild(_d({46,48,35,83},32))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print("[Gepo Grinder] Cleaned up previous session.")
end
print("[Gepo Grinder] Automated script loaded. Press 'P' to toggle auto farm.")
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
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
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({9,0,79,82,0,41,78,83,84,65,78,67,69,14,78,69,87,8},32)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
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
if _G.EasyTravel and _G.EasyTravel.TargetPosition then
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if _G.EasyTravel and not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
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
finalTargetY = _G.EasyTravel.TargetPosition.Y
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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({73,68,76,69},32)
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
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({73,78,86,79,75,69,39,69,80,80,79,0,69,82,82,79,82,26},32), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({9,0,79,82,0,41,78,83,84,65,78,67,69,14,78,69,87,8},32)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
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
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({55,65,76,75,73,78,71,0,84,79,26},32), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({87,65,76,75,52,79,48,79,73,78,84,0,55,0,68,79,87,78,0,69,82,82,79,82,26},32), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({33,82,82,73,86,69,68,0,65,84,26},32), pos)
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
if item:IsA("Model_d({9,0,65,78,68,0,73,84,69,77,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,8},32)HumanoidRootPart_d({9,0,65,78,68,0,73,84,69,77,26,38,73,78,68,38,73,82,83,84,35,72,73,76,68,55,72,73,67,72,41,83,33,8},32)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
mode = _d({73,68,76,69},32)
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
if mode == _d({72,79,86,69,82},32) then
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
local playerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
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
statusLabel.Text = _d({51,84,65,84,85,83,26,0,41,68,76,69},32)
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
enableBot(_d({72,79,86,69,82},32))
statusLabel.Text = "Status: Hovering _d({0,14,14,0,86,65,76,0,14,14,0},32) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({0,14,14,0,86,65,76,0,14,14,0},32) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({0,14,14,0,86,65,76,0,14,14,0},32) studs)"
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
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({12,0},32)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({12,0},32)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({12,0},32)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({12,0},32)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({12,0},32)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()