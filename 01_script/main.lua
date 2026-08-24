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
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({45,73,62,86,66,79,80},35))
local UserInputService    = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local RunService          = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM                 = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local ReplicatedStorage    = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({56,31,76,80,80,31,76,81,58},35), _d({52,79,76,75,68,253,68,62,74,66,253,191,93,113,253,45,73,62,64,66,38,65,23},35), game.PlaceId, _d({50,75,70,83,66,79,80,66,38,65,23},35), game.GameId, _d({10,253,75,76,81,253,79,82,75,75,70,75,68},35))
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
local LEO_PILLAR_ANIM_ID   = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,18,15,17,17,14,17,14,16,15,20},35)
local LEO_ENTEI_ANIM_ID    = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,18,15,17,17,14,16,21,15,20,21},35)
local LEO_HIKEN_ANIM_ID    = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,18,15,15,13,22,14,20,17,13,20},35)
local LEO_FIREFLY_ANIM_ID  = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,18,15,15,13,15,16,19,14,18,17},35)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({44,63,71,66,64,81,70,83,66,80},35)
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
local REPLAY_BUTTON_VALUE   = _d({47,66,77,73,62,86},35)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({74,76,83,66},35)
local NavState   = {mode = _d({70,65,73,66},35)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({56,31,76,80,80,31,76,81,58},35), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end)
if ok then return root end
debug(_d({68,66,81,47,76,76,81,253,66,79,79,76,79,23},35), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
end)
if ok then return hum end
debug(_d({68,66,81,37,82,74,62,75,76,70,65,253,66,79,79,76,79,23},35), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({60,60,37,76,83,66,79,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,37,76,83,66,79,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,37,76,83,66,79,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,37,76,83,66,79,35,76,79,64,66},35)
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
debug(_d({68,66,81,44,79,32,79,66,62,81,66,35,76,79,64,66,253,66,79,79,76,79,23},35), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local force = root:FindFirstChild(_d({60,60,37,76,83,66,79,35,76,79,64,66},35))
local att   = root:FindFirstChild(_d({60,60,37,76,83,66,79,30,81,81},35))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({64,73,66,62,75,82,77,35,76,79,64,66,253,66,79,79,76,79,23},35), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({31,82,80,76,42,66,73,66,66},35)) ~= nil
end)
if ok then return result end
debug(_d({70,80,31,82,80,76,30,64,81,70,83,66,253,66,79,79,76,79,23},35), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({31,82,80,76},35))
end)
if not ok then debug(_d({62,64,81,70,83,62,81,66,31,82,80,76,253,66,79,79,76,79,23},35), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({31,82,80,76,253,75,76,81,253,62,64,81,70,83,66,9,253,62,64,81,70,83,62,81,70,75,68},35))
activateBuso()
end
end)
if not ok then debug(_d({31,82,80,76,40,66,66,77,66,79,253,66,79,79,76,79,23},35), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({31,82,80,76,253,72,66,66,77,66,79,253,80,81,76,77,77,66,65},35))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({40,66,75,37,62,72,70},35)) ~= nil
end)
if ok then return result end
debug(_d({70,80,40,66,75,30,64,81,70,83,66,253,66,79,79,76,79,23},35), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({40,66,75},35), true)
end)
if not ok then debug(_d({62,64,81,70,83,62,81,66,40,66,75,253,66,79,79,76,79,23},35), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({40,66,75,253,75,76,81,253,62,64,81,70,83,66,9,253,62,64,81,70,83,62,81,70,75,68},35))
activateKen()
end
end)
if not ok then debug(_d({40,66,75,40,66,66,77,66,79,253,66,79,79,76,79,23},35), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({40,66,75,253,72,66,66,77,66,79,253,80,81,76,77,77,66,65},35))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({43,45,32,80},35)) end)
if ok then return folder end
debug(_d({68,66,81,43,45,32,80,35,76,73,65,66,79,253,66,79,79,76,79,23},35), folder)
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
local r = model:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local h = model:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
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
debug(_d({68,66,81,43,66,62,79,66,80,81,43,45,32,253,66,79,79,76,79,23},35), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum  = model:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({68,66,81,43,45,32,31,86,43,62,74,66,253,66,79,79,76,79,23},35), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({75,77,64,80,47,66,74,62,70,75,70,75,68,253,66,79,79,76,79,23},35), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({32,82,77,70,65,253,46,82,66,66,75},35))
return queen ~= nil and queen:FindFirstChild(_d({74,76,81,70,76,75,41,66,80,80},35)) ~= nil
end)
if ok then return result end
debug(_d({70,80,46,82,66,66,75,45,69,62,80,66,15,253,66,79,79,76,79,23},35), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,14,15,14,15,22,20,22,17,15,15,22,15,20,19,22},35)
local QUEEN_GRASP_ANIM_ID   = _d({79,63,85,62,80,80,66,81,70,65,23,12,12,14,15,22,21,13,13,13,19,14,13,13,14,20,16,17},35)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
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
debug(_d({70,80,45,73,62,86,70,75,68,30,75,70,74,35,79,76,74,41,70,80,81,253,66,79,79,76,79,23},35), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({31,73,76,64,72,70,75,68},35)) ~= nil
end)
if ok then return result end
debug(_d({70,80,43,45,32,31,73,76,64,72,70,75,68,253,66,79,79,76,79,23},35), result)
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
debug(_d({77,79,66,65,70,64,81,43,45,32,45,76,80,70,81,70,76,75,253,66,79,79,76,79,23},35), result)
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
debug(_d({43,76,253,65,62,74,62,68,66,253,76,75},35), model.Name, _d({67,76,79},35), NPC_STUCK_TIMEOUT, _d({80,253,10,253,80,84,70,81,64,69,70,75,68,253,81,62,79,68,66,81},35))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({81,79,62,64,72,43,45,32,33,62,74,62,68,66,253,66,79,79,76,79,23},35), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({42,76,65,66,73},35)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({31,62,80,66,45,62,79,81},35)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({68,66,81,42,76,65,66,73,35,62,64,66,45,76,80,253,66,79,79,76,79,23},35), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({34,75,83},35))
local folder = env and env:FindFirstChild(_d({48,81,62,81,82,66,80},35))
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
debug(_d({68,66,81,48,81,62,81,82,66,42,76,65,66,73,43,66,62,79,253,66,79,79,76,79,23},35), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({63,62,79,79,66,73,37,45},35))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({68,66,81,48,81,62,81,82,66,37,45,253,66,79,79,76,79,23},35), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({49,76,76,73},35)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({67,70,75,65,49,76,76,73,31,86,30,81,81,79,70,63,82,81,66,253,66,79,79,76,79,23},35), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({49,76,76,73},35)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({67,70,75,65,49,76,76,73,31,86,43,62,74,66,253,66,79,79,76,79,23},35), tool)
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
if not ok then debug(_d({66,78,82,70,77,49,76,76,73,253,66,79,79,76,79,23},35), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({49,76,76,73},35)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({67,70,75,65,49,76,76,73,31,86,32,69,70,73,65,43,62,74,66,253,66,79,79,76,79,23},35), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({48,84,76,79,65,34,78,82,70,77},35))
if sword then
equipTool(sword)
return _d({80,84,76,79,65},35)
end
local melee = findToolByAttribute(_d({42,66,73,66,66,49,76,76,73},35))
if melee then
equipTool(melee)
return _d({74,66,73,66,66},35)
end
debug(_d({43,76,253,80,84,76,79,65,253,76,79,253,74,66,73,66,66,253,81,76,76,73,253,67,76,82,75,65},35))
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
if not ok then debug(_d({64,73,70,64,72,42,14,253,66,79,79,76,79,23},35), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({47,76,72,82,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,66,77,77,76},35), args)
elseif style == _d({31,73,62,64,72,41,66,68},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72},35), args)
elseif style == _d({40,62,74,70,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,62,74,70,80,69,70,72,70,36,66,77,77,76},35), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72,15},35), args)
end
end)
if not ok then debug(_d({70,75,83,76,72,66,36,66,77,77,76,253,66,79,79,76,79,23},35), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({77,79,66,80,80,48,72,70,73,73,47,253,66,79,79,76,79,23},35), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({69,76,73,65,31,73,76,64,72,253,66,79,79,76,79,23},35), err) end
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
if not ok then debug(_d({69,76,73,65,31,73,76,64,72,52,69,70,73,66,253,66,79,79,76,79,23},35), err) end
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
debug(_d({68,66,81,36,62,74,66,36,253,66,79,79,76,79,23},35), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({70,80,47,66,62,73,42,14,31,82,80,86,253,66,79,79,76,79,23},35), result)
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
return char ~= nil and char:FindFirstChild(_d({80,81,82,75},35)) ~= nil
end)
if ok then return result end
debug(_d({70,80,48,81,82,75,75,66,65,253,66,79,79,76,79,23},35), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({77,79,66,80,80,48,81,82,75,31,79,66,62,72,253,66,79,79,76,79,23},35), err) end
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
debug(_d({78,82,66,66,75,33,76,65,68,66,50,75,81,70,73,48,62,67,66,23,253,46,82,66,66,75,253,68,76,75,66,253,10,253,66,75,65,70,75,68,253,65,76,65,68,66,253,66,62,79,73,86},35))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({78,82,66,66,75,33,76,65,68,66,50,75,81,70,73,48,62,67,66,253,80,62,67,66,81,86,253,81,70,74,66,76,82,81},35))
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
local info = getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({46,82,66,66,75,253,64,62,80,81,70,75,68,253,65,66,81,66,64,81,66,65,253,10,253,65,76,65,68,70,75,68,253,5,84,62,81,64,69,66,79,6},35))
queenDodgeUntilSafe(function() return getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35)) end)
if enabled and getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35)) then
setNavNamed(_d({32,82,77,70,65,253,46,82,66,66,75},35))
end
queenDodging = false
end
end)
if not ok then debug(_d({78,82,66,66,75,33,76,65,68,66,52,62,81,64,69,66,79,253,66,79,79,76,79,23},35), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({77,76,70,75,81},35) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({75,77,64},35) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({75,62,74,66,65},35) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({68,66,81,43,62,83,49,62,79,68,66,81,80,253,66,79,79,76,79,23},35), aimR)
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
debug(_d({64,76,74,77,82,81,66,41,76,64,72,66,65,32,35,79,62,74,66,253,66,79,79,76,79,23},35), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({77,76,70,75,81},35), point = pos}
phase = _d({74,76,83,66},35)
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
if not ok then debug(_d({75,62,83,49,76,45,76,70,75,81,253,68,66,77,77,76,253,64,69,66,64,72,253,66,79,79,76,79,23},35), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({75,77,64},35)}
phase = _d({74,76,83,66},35)
end
function setNavNamed(name)
NavState = {mode = _d({75,62,74,66,65},35), name = name}
phase = _d({74,76,83,66},35)
end
local function setNavIdle()
NavState = {mode = _d({70,65,73,66},35)}
phase = _d({74,76,83,66},35)
end
local function hasArrived()
return phase == _d({69,76,83,66,79},35)
end
local function startNav()
phase = _d({74,76,83,66},35)
debug(_d({43,62,83,253,73,76,76,77,253,44,43},35))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({45,73,62,86,66,79,253,65,70,66,65,254,253,48,81,76,77,77,70,75,68,253,63,76,81,11},35))
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
debug(_d({45,73,62,86,66,79,253,70,80,253,81,76,76,253,67,62,79,253,67,79,76,74,253,81,62,79,68,66,81,253,5,27,15,13,13,13,253,80,81,82,65,80,6,11,253,41,70,72,66,73,86,253,79,66,80,77,62,84,75,66,65,253,62,81,253,73,76,63,63,86,11,253,48,81,76,77,77,70,75,68,253,63,76,81,11},35))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({60,60,77,79,66,83,45,76,80},35))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({41,62,79,68,66,253,77,76,80,70,81,70,76,75,253,71,82,74,77,253,65,66,81,66,64,81,66,65,23},35), delta, _d({80,81,82,65,80,11,253,77,79,66,83,45,76,80,26},35), prevPos, _d({75,66,84,45,76,80,26},35), pos)
end
end
force:SetAttribute(_d({60,60,77,79,66,83,45,76,80},35), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({74,76,83,66},35) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({69,76,83,66,79},35)
debug(_d({45,69,62,80,66,23,253,69,76,83,66,79},35))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({254,254,254,253,47,34,35,50,48,38,43,36,253,49,44,253,30,45,45,41,54,253,30,31,43,44,47,42,30,41,253,51,34,41,44,32,38,49,54,23},35), finalVel, _d({62,70,74,26},35), aim, _d({77,76,80,26},35), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({69,76,83,66,79},35) then
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
debug(_d({32,76,74,63,62,81,253,73,76,64,72,253,80,72,70,77,77,66,65,9},35), snapDist, _d({80,81,82,65,80,253,67,79,76,74,253,81,62,79,68,66,81,253,191,93,113,253,67,62,73,73,70,75,68,253,63,62,64,72,253,81,76,253,74,76,83,66},35))
phase = _d({74,76,83,66},35)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({37,66,62,79,81,63,66,62,81,253,66,79,79,76,79,23},35), err) end
end)
end
local function stopNav()
debug(_d({43,62,83,253,73,76,76,77,253,44,35,35},35))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({74,76,83,66},35)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({49,66,85,81,32,69,62,81,48,66,79,83,70,64,66},35))
local channels = TextChatService:FindFirstChild(_d({49,66,85,81,32,69,62,75,75,66,73,80},35))
local channel = channels and channels:FindFirstChild(_d({47,31,53,36,66,75,66,79,62,73},35))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({33,66,67,62,82,73,81,32,69,62,81,48,86,80,81,66,74,32,69,62,81,34,83,66,75,81,80},35))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({48,62,86,42,66,80,80,62,68,66,47,66,78,82,66,80,81},35))
if sayEvent then
sayEvent:FireServer(message, _d({30,73,73},35))
return
end
debug(_d({80,66,75,65,32,69,62,81,42,66,80,80,62,68,66,23,253,75,76,253,49,66,85,81,32,69,62,81,48,66,79,83,70,64,66,11,47,31,53,36,66,75,66,79,62,73,253,76,79,253,73,66,68,62,64,86,253,48,62,86,42,66,80,80,62,68,66,47,66,78,82,66,80,81,253,67,76,82,75,65,253,67,76,79},35), message)
end)
if not ok then debug(_d({80,66,75,65,32,69,62,81,42,66,80,80,62,68,66,253,66,79,79,76,79,23},35), err) end
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
debug(_d({43,76,81,253,74,62,72,70,75,68,253,77,79,76,68,79,66,80,80,253,81,76,84,62,79,65,253,75,62,83,253,81,62,79,68,66,81,253,67,76,79},35), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({80,253,10,253,80,66,75,65,70,75,68,253,12,82,75,80,81,82,64,72},35))
sendChatMessage(_d({12,82,75,80,81,82,64,72},35))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({84,62,70,81,50,75,81,70,73,30,79,79,70,83,66,65,253,81,70,74,66,76,82,81},35))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({75,62,83,49,76,45,76,70,75,81,32,76,75,67,70,79,74,66,65,23},35), label or _d({81,62,79,68,66,81},35), _d({10,253,65,70,65,253,75,76,81,253,62,79,79,70,83,66,253,84,70,81,69,70,75},35), timeout, _d({80,9,253,79,66,81,79,86,70,75,68,253,76,75,64,66},35))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({75,62,83,49,76,45,76,70,75,81,32,76,75,67,70,79,74,66,65,23},35), label or _d({81,62,79,68,66,81},35), _d({10,253,80,81,70,73,73,253,75,76,81,253,62,79,79,70,83,66,65,253,62,67,81,66,79,253,79,66,81,79,86,9,253,77,79,76,64,66,66,65,70,75,68,253,62,75,86,84,62,86},35))
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
if not ok then debug(_d({75,62,83,49,76,45,76,70,75,81,37,76,73,65,70,75,68,31,73,76,64,72,253,72,66,86,10,65,76,84,75,253,66,79,79,76,79,23},35), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({75,62,83,49,76,45,76,70,75,81,37,76,73,65,70,75,68,31,73,76,64,72,253,72,66,86,10,82,77,253,66,79,79,76,79,23},35), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({52,62,73,72,70,75,68,253,81,76,23},35), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({84,62,73,72,49,76,45,76,70,75,81,253,52,253,65,76,84,75,253,66,79,79,76,79,23},35), err) end
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
debug(_d({49,76,76,72,253,65,62,74,62,68,66,253,84,69,70,73,66,253,84,62,73,72,70,75,68,253,81,76,253,77,76,70,75,81,254,253,48,81,76,77,77,70,75,68,253,84,62,73,72,253,81,76,253,66,75,68,62,68,66,11},35))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({30,79,79,70,83,66,65,253,62,81,23},35), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({48,81,82,64,72,253,65,82,79,70,75,68,253,84,62,73,72,9,253,71,82,74,77,70,75,68,254},35))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({48,81,70,73,73,253,80,81,82,64,72,9,253,81,79,70,68,68,66,79,70,75,68,253,36,66,77,77,76,254},35))
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
debug(_d({42,76,83,70,75,68,253,81,76},35), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({52,62,70,81,70,75,68,253,67,76,79,253,43,45,32,80,253,81,76,253,80,77,62,84,75,253,62,81},35), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({253,253,80,77,62,84,75,253,64,69,66,64,72,23,253,67,76,73,65,66,79,253,66,85,70,80,81,80,253,26},35), folder ~= nil,
_d({9,253,64,69,70,73,65,79,66,75,253,26},35), folder and #folder:GetChildren() or 0,
_d({9,253,62,73,70,83,66,253,26},35), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({43,76,253,43,45,32,80,253,62,77,77,66,62,79,66,65,253,62,81},35), stageName, _d({62,67,81,66,79,253,14,18,80,9,253,74,76,83,70,75,68,253,76,75,253,62,75,86,84,62,86},35))
break
end
end
debug(_d({40,70,73,73,70,75,68,253,43,45,32,80,253,62,81},35), stageName)
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
debug(_d({47,66,81,82,79,75,70,75,68,253,81,76},35), stageName, _d({77,76,80,70,81,70,76,75,253,63,66,67,76,79,66,253,74,76,83,70,75,68,253,76,75},35))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({52,62,70,81,70,75,68,253,18,80,253,62,81},35), stageName, _d({77,76,80,70,81,70,76,75},35))
task.wait(5)
debug(_d({52,62,70,81,70,75,68,253,67,76,79},35), targetHP * 100, _d({2,253,37,45,253,63,66,67,76,79,66,253,74,76,83,70,75,68,253,81,76,253,75,66,85,81,253,80,81,62,68,66},35))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({64,73,66,62,79,66,65},35))
end
local function killNamedNPC(name, targetPos)
debug(_d({42,76,83,70,75,68,253,81,76},35), name)
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
debug(name, _d({65,66,67,66,62,81,66,65},35))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({41,66,76,253,77,73,62,86,66,65,253,62,75,70,74,62,81,70,76,75,23},35), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({73,66,76,30,75,70,74,41,76,68,68,66,79,253,77,79,70,75,81,253,66,79,79,76,79,23},35), err2) end
end)
end)
if not ok then debug(_d({80,81,62,79,81,41,66,76,30,75,70,74,41,76,68,68,66,79,253,66,79,79,76,79,23},35), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({42,76,83,70,75,68,253,81,76,253,41,66,76},35))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({41,66,76},35))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({41,66,76},35))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({41,66,76},35))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({41,66,76,253,64,62,80,81,70,75,68},35), which, _d({10,253,65,76,65,68,70,75,68},35))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({41,66,76,253,80,81,62,79,81,66,65,253,63,73,76,64,72,10,63,79,66,62,72,66,79,253,74,70,65,10,63,73,76,64,72,254,253,34,83,62,65,70,75,68,11,11,11},35))
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
if not getNPCByName(_d({41,66,76},35)) then
debug(_d({41,66,76,253,68,76,75,66,253,74,70,65,10,65,76,65,68,66,253,10,253,66,75,65,70,75,68,253,34,75,81,66,70,253,69,76,73,65,253,66,62,79,73,86},35))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({41,66,76},35)) then
setNavNamed(_d({41,66,76},35))
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
debug(_d({41,66,76,253,65,66,67,66,62,81,66,65},35))
stopLeoAnimLogger()
debug(_d({47,66,81,82,79,75,70,75,68,253,81,76,253,41,66,76,253,77,76,80,70,81,70,76,75,253,63,66,67,76,79,66,253,74,76,83,70,75,68,253,76,75},35))
navToPointConfirmed(COORDS.Leo, 30, _d({41,66,76,253,77,76,80,70,81,70,76,75},35))
debug(_d({52,62,70,81,70,75,68,253,18,80,253,62,81,253,41,66,76,253,77,76,80,70,81,70,76,75},35))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({42,76,83,70,75,68,253,81,76},35), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({32,76,82,73,65,253,75,76,81,253,67,70,75,65,253,80,81,62,81,82,66,253,74,76,65,66,73,253,75,66,62,79},35), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({30,81,81,62,64,72,70,75,68},35), coordKey, _d({84,70,81,69},35), weapon or _d({75,76,81,69,70,75,68,253,67,76,82,75,65},35))
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
debug(coordKey, _d({63,62,79,79,66,73,253,65,66,80,81,79,76,86,66,65},35))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({79,66,64,69,66,64,72,48,81,62,81,82,66,23},35), coordKey, _d({10,253,64,76,82,73,65,253,75,76,81,253,67,70,75,65,253,80,81,62,81,82,66,253,74,76,65,66,73,9,253,80,72,70,77,77,70,75,68},35))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({79,66,64,69,66,64,72,48,81,62,81,82,66,23},35), coordKey, _d({80,81,70,73,73,253,62,73,70,83,66,253,5,37,45},35), hp, _d({6,253,10,253,79,66,10,65,66,80,81,79,76,86,70,75,68},35))
destroyStatue(coordKey)
else
debug(_d({79,66,64,69,66,64,72,48,81,62,81,82,66,23},35), coordKey, _d({64,76,75,67,70,79,74,66,65,253,65,66,80,81,79,76,86,66,65},35))
end
end)
if not ok then debug(_d({79,66,64,69,66,64,72,48,81,62,81,82,66,253,66,79,79,76,79,23},35), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({42,76,83,70,75,68,253,81,76,253,46,82,66,66,75},35))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({32,82,77,70,65,253,46,82,66,66,75},35))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35))
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
debug(_d({46,82,66,66,75,253,66,75,81,66,79,66,65,253,77,69,62,80,66,253,15},35))
end
local function finishQueen()
debug(_d({35,70,75,70,80,69,70,75,68,253,46,82,66,66,75},35))
equipSwordOrMelee()
setNavNamed(_d({32,82,77,70,65,253,46,82,66,66,75},35))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({32,82,77,70,65,253,46,82,66,66,75},35))
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
debug(_d({46,82,66,66,75,253,65,66,67,66,62,81,66,65,11,253,45,73,62,75,253,64,76,74,77,73,66,81,66,11},35))
end
local CONFIRMATION_PROMPT_NAME = _d({32,76,75,67,70,79,74,62,81,70,76,75,45,79,76,74,77,81},35)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({47,66,74,76,81,66,34,83,66,75,81},35), 5)
end)
if ok then return result end
debug(_d({68,66,81,47,66,77,73,62,86,47,66,74,76,81,66,253,66,79,79,76,79,23},35), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({45,73,62,86,66,79,36,82,70},35))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({38,74,62,68,66,31,82,81,81,76,75},35)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({63,82,81,81,76,75,51,62,73,82,66},35)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({67,70,75,65,31,82,81,81,76,75,31,86,51,62,73,82,66,253,66,79,79,76,79,23},35), result)
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
if not ok then debug(_d({64,73,70,64,72,36,82,70,31,82,81,81,76,75,253,66,79,79,76,79,23},35), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({70,80,48,66,79,83,66,79},35))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({47,66,74,76,81,66,34,83,66,75,81},35))
or inst:FindFirstChild(_d({64,73,70,66,75,81,34,83,66,75,81},35))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({67,70,75,65,30,75,80,84,66,79,32,76,75,75,66,64,81,76,79,253,66,79,79,76,79,23},35), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({32,76,82,73,65,253,75,76,81,253,73,76,64,62,81,66,253,47,66,74,76,81,66,34,83,66,75,81,12,64,73,70,66,75,81,34,83,66,75,81,253,75,66,62,79,253,47,66,77,73,62,86,253,63,82,81,81,76,75,9,253,67,62,73,73,70,75,68,253,63,62,64,72,253,81,76,253,64,73,70,64,72},35))
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
debug(_d({67,70,79,66,47,66,77,73,62,86,51,62,73,82,66,253,66,79,79,76,79,23},35), err, _d({10,253,67,62,73,73,70,75,68,253,63,62,64,72,253,81,76,253,64,73,70,64,72},35))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({35,62,73,73,70,75,68,253,63,62,64,72,253,81,76,253,63,82,81,81,76,75,51,62,73,82,66,253,80,66,62,79,64,69,253,67,76,79,253,47,66,77,73,62,86},35))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({47,66,77,73,62,86,253,63,82,81,81,76,75,253,75,76,81,253,67,76,82,75,65,253,66,70,81,69,66,79,9,253,68,70,83,70,75,68,253,82,77},35))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({52,62,70,81,70,75,68,253,67,76,79,253,32,76,75,67,70,79,74,62,81,70,76,75,45,79,76,74,77,81,11,47,66,74,76,81,66,34,83,66,75,81},35))
local remote = getReplayRemote()
if not remote then
debug(_d({32,76,75,67,70,79,74,62,81,70,76,75,45,79,76,74,77,81,12,47,66,74,76,81,66,34,83,66,75,81,253,75,76,81,253,67,76,82,75,65,253,84,70,81,69,70,75,253,81,70,74,66,76,82,81},35))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({35,70,79,70,75,68,253,47,66,77,73,62,86,253,83,70,62,253,32,76,75,67,70,79,74,62,81,70,76,75,45,79,76,74,77,81,11,47,66,74,76,81,66,34,83,66,75,81},35))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({35,70,79,66,48,66,79,83,66,79,253,66,79,79,76,79,23},35), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35), 10)
if not playerGui then
debug(_d({84,62,70,81,35,76,79,44,63,71,66,64,81,70,83,66,80,36,82,70,23,253,75,76,253,45,73,62,86,66,79,36,82,70,253,84,70,81,69,70,75,253,81,70,74,66,76,82,81,9,253,77,79,76,64,66,66,65,70,75,68,253,62,75,86,84,62,86},35))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({44,63,71,66,64,81,70,83,66,80,253,36,50,38,253,67,76,82,75,65,253,10,253,80,81,62,68,66,253,73,76,62,65,66,65},35))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({44,63,71,66,64,81,70,83,66,80,253,36,50,38,253,75,76,81,253,67,76,82,75,65,253,84,70,81,69,70,75,253,81,70,74,66,76,82,81,9,253,77,79,76,64,66,66,65,70,75,68,253,62,75,86,84,62,86},35))
return
end
end
end)
if not ok then debug(_d({84,62,70,81,35,76,79,44,63,71,66,64,81,70,83,66,80,36,82,70,253,66,79,79,76,79,23},35), err) end
end
local function runPlan()
debug(_d({45,73,62,75,253,80,81,62,79,81,66,65},35))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({48,81,62,79,81,70,75,68,253,75,62,83,253,73,76,76,77},35))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({77,76,80,253,13,11,15,80,253,30,35,49,34,47,253,80,81,62,79,81,43,62,83,23},35), rootAfter and rootAfter.Position)
end)
debug(_d({52,62,70,81,70,75,68,253,18,80,253,63,66,67,76,79,66,253,74,76,83,70,75,68,253,81,76,253,48,81,62,68,66,14},35))
task.wait(5)
for _, stage in ipairs({_d({48,81,62,68,66,14},35), _d({48,81,62,68,66,15},35), _d({48,81,62,68,66,16},35), _d({48,81,62,68,66,16,31},35)}) do
if not enabled then return end
local hpTarget = (stage == _d({48,81,62,68,66,16,31},35)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({42,76,83,70,75,68,253,81,76,253,62,79,79,76,84,253,67,73,86,10,65,76,84,75,253,62,79,66,62,253,5,32,82,77,70,65,253,47,62,70,75,6},35))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({33,76,65,68,70,75,68,253,62,79,79,76,84,253,79,62,70,75,253,70,75,253,62,253,80,78,82,62,79,66},35))
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
clearStage(_d({48,81,62,68,66,17},35))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({46,82,66,66,75,253,70,75,253,77,69,62,80,66,253,15,253,10,253,72,66,66,77,70,75,68,253,40,66,75,253,37,62,72,70,253,62,64,81,70,83,66,253,67,79,76,74,253,69,66,79,66,253,76,75},35))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({48,81,62,81,82,66,14},35))
if not enabled then return end
recheckStatue(_d({48,81,62,81,82,66,14},35))
destroyStatue(_d({48,81,62,81,82,66,15},35))
if not enabled then return end
recheckStatue(_d({48,81,62,81,82,66,14},35))
recheckStatue(_d({48,81,62,81,82,66,15},35))
destroyStatue(_d({48,81,62,81,82,66,16},35))
if not enabled then return end
recheckStatue(_d({48,81,62,81,82,66,16},35))
recheckStatue(_d({48,81,62,81,82,66,15},35))
recheckStatue(_d({48,81,62,81,82,66,14},35))
if not enabled then return end
debug(_d({52,62,70,81,70,75,68,253,67,76,79,253,77,69,62,80,66,253,15,253,81,76,253,66,75,65},35))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({45,69,62,80,66,253,15,253,66,75,65,253,84,62,70,81,253,81,70,74,66,76,82,81,9,253,77,79,76,64,66,66,65,70,75,68,253,62,75,86,84,62,86},35))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({42,76,83,70,75,68,253,63,62,64,72,253,81,76,253,46,82,66,66,75,253,80,81,62,68,66,253,77,76,80,70,81,70,76,75},35))
navToPointConfirmed(COORDS.Queen, 30, _d({46,82,66,66,75,253,80,81,62,68,66,253,77,76,80,70,81,70,76,75},35))
debug(_d({52,62,70,81,70,75,68,253,18,80,253,62,81,253,46,82,66,66,75,253,80,81,62,68,66,253,77,76,80,70,81,70,76,75},35))
task.wait(5)
if not enabled then return end
debug(_d({42,76,83,70,75,68,253,81,76,253,77,76,80,81,10,46,82,66,66,75,253,77,76,80,70,81,70,76,75},35))
navToPointConfirmed(COORDS.PostQueen, 30, _d({77,76,80,81,10,46,82,66,66,75,253,77,76,80,70,81,70,76,75},35))
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
local rootBefore = getRoot()
debug(_d({34,75,62,63,73,70,75,68,9,253,77,76,80,253,31,34,35,44,47,34,253,77,73,62,75,23},35), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({45,73,62,75,253,66,79,79,76,79,23},35), err2) end
end)
debug(_d({34,75,62,63,73,66,65,23},35), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({34,75,62,63,73,66,65,23},35), enabled)
end
function CupidDungeon.Start()
if enabled then return end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
if not _G.lazyhub then
table.insert(CupidDungeon.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if enabled then
CupidDungeon.Stop()
else
CupidDungeon.Start()
end
end
end))
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({36,62,74,66,253,73,76,62,65,66,65,9,253,62,82,81,76,10,80,81,62,79,81,70,75,68,253,81,69,66,253,77,73,62,75},35))
CupidDungeon.Start()
end)
debug(_d({48,81,62,75,65,62,73,76,75,66,253,42,76,65,66,23,253,62,82,81,76,10,80,81,62,79,81,70,75,68,253,5,77,79,66,80,80,253,58,253,81,76,253,81,76,68,68,73,66,6},35))
end
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({39,82,87,76,253,81,69,66,253,33,70,62,74,76,75,65,63,62,64,72},35),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({31,62,64,72,77,62,64,72},35))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)) or (bp and bp:FindFirstChild(_d({37,76,79,76,10,37,76,79,76},35)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({43,45,32,80},35))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
local hum = boss:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
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
if key == _d({37,70,81},35) then return target.CFrame
elseif key == _d({49,62,79,68,66,81},35) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({56,37,76,79,76,35,62,79,74,58,253,42,66,81,62,81,62,63,73,66,253,69,76,76,72,253,67,62,70,73,66,65,23,253},35) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,76,77,77,66,65,11},35))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({56,37,76,79,76,35,62,79,74,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254},35)); return end
HoroFarm.Running = true
setupHook()
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,62,79,81,66,65,253,81,62,79,68,66,81,70,75,68,23,253},35) .. HoroFarm.Config.SelectedBoss)
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
if not _G.lazyhub then
table.insert(HoroFarm.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if HoroFarm.Running then
HoroFarm.Stop()
else
HoroFarm.Start()
end
end
end))
HoroFarm.Start()
print(_d({56,37,76,79,76,35,62,79,74,58,253,48,81,62,75,65,62,73,76,75,66,253,42,76,65,66,23,253,45,79,66,80,80,253,4,58,4,253,81,76,253,81,76,68,68,73,66,11},35))
end
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local function importLib(localPath, rawUrl)
local loaded = false
local result = nil
local oldLazyHub = _G.lazyhub
_G.lazyhub = true
if isfile and readfile then
pcall(function()
if isfile(localPath) then
result = loadstring(readfile(localPath))()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(rawUrl))() end)
end
_G.lazyhub = oldLazyHub
return result
end
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,48,81,76,77,77,66,65,11},35))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,30,73,79,66,62,65,86,253,79,82,75,75,70,75,68,254},35)); return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35), 10)
local hum = char:WaitForChild(_d({37,82,74,62,75,76,70,65},35), 10)
ReplicatedStorage:WaitForChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name, 30)
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35)) or char:FindFirstChild(_d({47,70,67,73,66},35))
if hasRifle then break end
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,43,76,81,253,62,81,253,49,76,84,75,253,76,67,253,31,66,68,70,75,75,70,75,68,80,11,253,45,73,66,62,80,66,253,81,79,62,83,66,73,253,81,69,66,79,66,253,81,76,253,67,62,79,74,253,64,69,66,80,81,80,253,84,69,70,73,66,253,84,62,70,81,70,75,68,253,67,76,79,253,47,70,67,73,66,11},35))
task.wait(2)
continue
end
if not ChestFarmer then
ChestFarmer = importLib(_d({73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,64,69,66,80,81,60,67,62,79,74,66,79,11,73,82,62},35))
end
if ChestFarmer then
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,35,62,79,74,70,75,68,253,64,69,66,80,81,80,253,82,75,81,70,73,253,47,70,67,73,66,253,70,80,253,66,78,82,70,77,77,66,65,11,11,11},35))
ChestFarmer.FarmUntilPeli(9999999, function() return 0 end, function()
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35)) or char:FindFirstChild(_d({47,70,67,73,66},35)))
end)
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({47,70,67,73,66},35))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,35,73,86,70,75,68,253,81,76,253,35,70,80,69,74,62,75,253,32,62,83,66,11,11,11},35))
if not EasyTravel then
EasyTravel = importLib(_d({73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35), _d({69,81,81,77,80,23,12,12,79,62,84,11,68,70,81,69,82,63,82,80,66,79,64,76,75,81,66,75,81,11,64,76,74,12,79,76,64,72,86,85,84,62,73,73,12,73,82,62,82,10,64,76,65,66,12,74,62,70,75,12,13,14,60,80,64,79,70,77,81,12,73,70,63,12,66,62,80,86,60,81,79,62,83,66,73,11,73,82,62},35))
end
if EasyTravel then
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 50 then break end
task.wait(1)
end
pcall(EasyTravel.Stop)
end
LevelGrinder.Stop()
end)
end
if not _G.lazyhub then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
print(_d({56,41,66,83,66,73,253,36,79,70,75,65,66,79,58,253,48,81,62,75,65,62,73,76,75,66,253,42,76,65,66,23,253,45,79,66,80,80,253,4,58,4,253,81,76,253,80,81,76,77,11},35))
end
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
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
return char, char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)), char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35)
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
local force = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,35,76,79,64,66},35))
local att = root:FindFirstChild(_d({60,60,34,62,80,86,49,79,62,83,66,73,30,81,81},35))
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
local moveDir = Vector3.zero
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
if isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,35,73,70,68,69,81,253,66,75,62,63,73,66,65,11},35))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,35,73,70,68,69,81,253,65,70,80,62,63,73,66,65,11},35))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
if not _G.lazyhub then
table.insert(EasyTravel.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if EasyTravel.Enabled then
EasyTravel.Stop()
else
EasyTravel.Start()
end
end
end))
print(_d({56,34,62,80,86,253,49,79,62,83,66,73,58,253,48,81,62,75,65,62,73,76,75,66,253,42,76,65,66,23,253,45,79,66,80,80,253,4,58,4,253,81,76,253,81,76,68,68,73,66,253,67,73,70,68,69,81,11},35))
end
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({45,73,62,86,66,79,80},35))
local RunService = game:GetService(_d({47,82,75,48,66,79,83,70,64,66},35))
local UserInputService = game:GetService(_d({50,80,66,79,38,75,77,82,81,48,66,79,83,70,64,66},35))
local ReplicatedStorage = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({70,65,73,66},35)
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
print(_d({56,44,83,66,79,84,76,79,73,65,49,66,80,81,66,79,58},35), ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({48,81,62,81,80},35) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({47,76,72,82,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,66,77,77,76},35), args)
elseif style == _d({31,73,62,64,72,41,66,68},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72},35), args)
elseif style == _d({40,62,74,70,80,69,70,72,70},35) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,62,74,70,80,69,70,72,70,36,66,77,77,76},35), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,72,86,253,52,62,73,72,15},35), args)
end
debug(_d({35,70,79,66,65,253,36,66,77,77,76,253,47,66,74,76,81,66},35))
end)
if not ok then debug(_d({70,75,83,76,72,66,36,66,77,77,76,253,66,79,79,76,79,23},35), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35)) or Instance.new(_d({30,81,81,62,64,69,74,66,75,81},35))
att.Name = _d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35)
att.Parent = root
local force = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35))
if not force then
force = Instance.new(_d({41,70,75,66,62,79,51,66,73,76,64,70,81,86},35))
force.Name = _d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35)
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
local root = char:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35))
if not root then return end
local force = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,35,76,79,64,66},35))
local att   = root:FindFirstChild(_d({60,60,49,66,80,81,37,76,83,66,79,30,81,81},35))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({52,62,73,72,70,75,68,253,81,76,23},35), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({84,62,73,72,49,76,45,76,70,75,81,253,52,253,65,76,84,75,253,66,79,79,76,79,23},35), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({30,79,79,70,83,66,65,253,62,81,23},35), pos)
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
if item:IsA(_d({42,76,65,66,73},35)) and item:FindFirstChild(_d({37,82,74,62,75,76,70,65,47,76,76,81,45,62,79,81},35)) and item:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({37,82,74,62,75,76,70,65},35)).Health > 0 then
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
mode = _d({70,65,73,66},35)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({49,66,80,81,66,79,253,33,70,80,62,63,73,66,65},35))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({49,66,80,81,66,79,253,34,75,62,63,73,66,65,11,253,42,76,65,66,23},35), mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({45,73,62,86,66,79,253,65,70,66,65,254,253,33,70,80,62,63,73,70,75,68,253,63,76,81,11},35))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({69,76,83,66,79},35) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({65,76,65,68,66},35) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) then
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
local playerGui = LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({44,83,66,79,84,76,79,73,65,49,66,80,81,36,82,70},35))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({48,64,79,66,66,75,36,82,70},35))
screenGui.Name = _d({44,83,66,79,84,76,79,73,65,49,66,80,81,36,82,70},35)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({35,79,62,74,66},35))
frame.Name = _d({42,62,70,75,35,79,62,74,66},35)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({205,124,120,126,204,149,108,253,32,82,77,70,65,253,34,75,68,70,75,66,253,44,83,66,79,84,76,79,73,65,253,49,66,80,81},35)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({48,81,62,81,82,80,23,253,38,65,73,66},35)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({49,66,85,81,31,76,85},35))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({37,76,83,66,79,253,30,63,76,83,66,253,49,62,79,68,66,81},35), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({69,76,83,66,79},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,37,76,83,66,79,70,75,68,253},35) .. val .. _d({253,80,81,82,65,80,253,82,77},35)
end)
createInputBtn(_d({33,76,65,68,66,253,32,73,70,74,63},35), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({65,76,65,68,66},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,33,76,65,68,66,10,69,76,73,65,70,75,68,253,5},35) .. val .. _d({253,80,81,82,65,80,6},35)
end)
createInputBtn(_d({49,66,80,81,253,48,78,82,62,79,66,253,33,76,65,68,66},35), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({80,78,82,62,79,66,60,65,76,65,68,66},35))
statusLabel.Text = _d({48,81,62,81,82,80,23,253,48,78,82,62,79,66,253,52,62,73,72,70,75,68,253,5},35) .. val .. _d({253,80,81,82,65,80,6},35)
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
while enabled and mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({80,78,82,62,79,66,60,65,76,65,68,66},35) then
disableBot()
statusLabel.Text = _d({48,81,62,81,82,80,23,253,38,65,73,66,253,5,48,78,82,62,79,66,253,65,76,65,68,66,253,65,76,75,66,6},35)
end
end)
end)
local stopBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({34,42,34,47,36,34,43,32,54,253,48,49,44,45},35)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({50,38,32,76,79,75,66,79},35), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({48,81,62,81,82,80,23,253,48,49,44,45,45,34,33,253,5,38,65,73,66,6},35)
local VIM = game:GetService(_d({51,70,79,81,82,62,73,38,75,77,82,81,42,62,75,62,68,66,79},35))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({56,44,83,66,79,84,76,79,73,65,49,66,80,81,66,79,58,253,41,76,62,65,66,65,253,80,82,64,64,66,80,80,67,82,73,73,86,11},35))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({45,73,62,86,66,79,36,82,70},35), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({36,45,44,41,62,82,75,64,69,66,79,50,38},35))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({48,64,79,66,66,75,36,82,70},35))
screenGui.Name = _d({36,45,44,41,62,82,75,64,69,66,79,50,38},35)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({35,79,62,74,66},35))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({205,124,105,105,253,36,45,44,253,37,82,63,253,41,62,82,75,64,69,66,79},35)
title.Parent = main
local closeBtn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({50,38,32,76,79,75,66,79},35), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({32,69,76,76,80,66,253,62,253,63,76,81,253,76,79,253,82,81,70,73,70,81,86,253,81,76,253,79,82,75,23},35)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({49,66,85,81,31,82,81,81,76,75},35))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({253,253},35) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({50,38,32,76,79,75,66,79},35))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({50,38,48,81,79,76,72,66},35))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({49,66,85,81,41,62,63,66,73},35))
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
CreateLaunchButton(_d({32,82,77,70,65,253,33,82,75,68,66,76,75,253,35,62,79,74},35), _d({30,82,81,76,74,62,81,66,253,64,82,77,70,65,253,65,82,75,68,66,76,75,80,253,3,253,63,76,80,80,253,64,86,64,73,66,80},35), loadCupidDungeon)
CreateLaunchButton(_d({37,76,79,76,253,31,76,80,80,253,35,62,79,74,253,5,48,70,73,66,75,81,253,30,70,74,6},35), _d({30,82,81,76,67,62,79,74,253,76,83,66,79,84,76,79,73,65,253,63,76,80,80,66,80,253,82,80,70,75,68,253,37,76,79,76,253,67,79,82,70,81,80},35), loadHoroBossFarm)
CreateLaunchButton(_d({41,66,83,66,73,253,3,253,42,76,63,253,36,79,70,75,65,66,79},35), _d({30,82,81,76,10,73,66,83,66,73,253,62,75,65,253,67,62,79,74,253,73,76,64,62,73,253,43,45,32,253,74,76,63,80},35), loadLevelGrinder)
CreateLaunchButton(_d({34,62,80,86,253,49,79,62,83,66,73,253,5,45,253,49,76,68,68,73,66,6},35), _d({52,30,48,33,253,35,73,70,68,69,81,253,84,70,81,69,253,68,79,76,82,75,65,253,67,76,73,73,76,84,253,3,253,84,62,73,73,253,64,73,70,74,63,70,75,68},35), loadNavigationLab)
CreateLaunchButton(_d({45,69,86,80,70,64,80,253,44,83,66,79,84,76,79,73,65,253,49,66,80,81,66,79},35), _d({49,66,80,81,253,64,76,74,63,62,81,253,69,76,83,66,79,9,253,68,66,77,77,76,253,3,253,65,76,65,68,66,253,69,66,70,68,69,81,80},35), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({56,36,45,44,253,37,82,63,58,253,41,62,82,75,64,69,66,79,253,50,38,253,70,75,70,81,70,62,73,70,87,66,65,11},35))
end)()