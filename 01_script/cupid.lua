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
local Players            = game:GetService(_d({44,72,61,85,65,78,79},36))
local UserInputService    = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local RunService          = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM                 = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local ReplicatedStorage    = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({55,30,75,79,79,30,75,80,57},36), _d({51,78,75,74,67,252,67,61,73,65,252,190,92,112,252,44,72,61,63,65,37,64,22},36), game.PlaceId, _d({49,74,69,82,65,78,79,65,37,64,22},36), game.GameId, _d({9,252,74,75,80,252,78,81,74,74,69,74,67},36))
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
local LEO_PILLAR_ANIM_ID   = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,16,16,13,16,13,15,14,19},36)
local LEO_ENTEI_ANIM_ID    = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,16,16,13,15,20,14,19,20},36)
local LEO_HIKEN_ANIM_ID    = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,14,12,21,13,19,16,12,19},36)
local LEO_FIREFLY_ANIM_ID  = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,14,12,14,15,18,13,17,16},36)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({43,62,70,65,63,80,69,82,65,79},36)
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
local REPLAY_BUTTON_VALUE   = _d({46,65,76,72,61,85},36)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({73,75,82,65},36)
local NavState   = {mode = _d({69,64,72,65},36)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({55,30,75,79,79,30,75,80,57},36), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end)
if ok then return root end
debug(_d({67,65,80,46,75,75,80,252,65,78,78,75,78,22},36), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end)
if ok then return hum end
debug(_d({67,65,80,36,81,73,61,74,75,69,64,252,65,78,78,75,78,22},36), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({59,59,36,75,82,65,78,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,36,75,82,65,78,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,36,75,82,65,78,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,36,75,82,65,78,34,75,78,63,65},36)
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
debug(_d({67,65,80,43,78,31,78,65,61,80,65,34,75,78,63,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local force = root:FindFirstChild(_d({59,59,36,75,82,65,78,34,75,78,63,65},36))
local att   = root:FindFirstChild(_d({59,59,36,75,82,65,78,29,80,80},36))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({63,72,65,61,74,81,76,34,75,78,63,65,252,65,78,78,75,78,22},36), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({30,81,79,75,41,65,72,65,65},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,30,81,79,75,29,63,80,69,82,65,252,65,78,78,75,78,22},36), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({30,81,79,75},36))
end)
if not ok then debug(_d({61,63,80,69,82,61,80,65,30,81,79,75,252,65,78,78,75,78,22},36), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({30,81,79,75,252,74,75,80,252,61,63,80,69,82,65,8,252,61,63,80,69,82,61,80,69,74,67},36))
activateBuso()
end
end)
if not ok then debug(_d({30,81,79,75,39,65,65,76,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({30,81,79,75,252,71,65,65,76,65,78,252,79,80,75,76,76,65,64},36))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({39,65,74,36,61,71,69},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,39,65,74,29,63,80,69,82,65,252,65,78,78,75,78,22},36), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({39,65,74},36), true)
end)
if not ok then debug(_d({61,63,80,69,82,61,80,65,39,65,74,252,65,78,78,75,78,22},36), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({39,65,74,252,74,75,80,252,61,63,80,69,82,65,8,252,61,63,80,69,82,61,80,69,74,67},36))
activateKen()
end
end)
if not ok then debug(_d({39,65,74,39,65,65,76,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({39,65,74,252,71,65,65,76,65,78,252,79,80,75,76,76,65,64},36))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({42,44,31,79},36)) end)
if ok then return folder end
debug(_d({67,65,80,42,44,31,79,34,75,72,64,65,78,252,65,78,78,75,78,22},36), folder)
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
local r = model:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local h = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
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
debug(_d({67,65,80,42,65,61,78,65,79,80,42,44,31,252,65,78,78,75,78,22},36), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum  = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({67,65,80,42,44,31,30,85,42,61,73,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({74,76,63,79,46,65,73,61,69,74,69,74,67,252,65,78,78,75,78,22},36), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({31,81,76,69,64,252,45,81,65,65,74},36))
return queen ~= nil and queen:FindFirstChild(_d({73,75,80,69,75,74,40,65,79,79},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,45,81,65,65,74,44,68,61,79,65,14,252,65,78,78,75,78,22},36), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,13,14,13,14,21,19,21,16,14,14,21,14,19,18,21},36)
local QUEEN_GRASP_ANIM_ID   = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,13,14,21,20,12,12,12,18,13,12,12,13,19,15,16},36)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
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
debug(_d({69,79,44,72,61,85,69,74,67,29,74,69,73,34,78,75,73,40,69,79,80,252,65,78,78,75,78,22},36), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({30,72,75,63,71,69,74,67},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,42,44,31,30,72,75,63,71,69,74,67,252,65,78,78,75,78,22},36), result)
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
debug(_d({76,78,65,64,69,63,80,42,44,31,44,75,79,69,80,69,75,74,252,65,78,78,75,78,22},36), result)
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
debug(_d({42,75,252,64,61,73,61,67,65,252,75,74},36), model.Name, _d({66,75,78},36), NPC_STUCK_TIMEOUT, _d({79,252,9,252,79,83,69,80,63,68,69,74,67,252,80,61,78,67,65,80},36))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({80,78,61,63,71,42,44,31,32,61,73,61,67,65,252,65,78,78,75,78,22},36), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({41,75,64,65,72},36)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({30,61,79,65,44,61,78,80},36)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({67,65,80,41,75,64,65,72,34,61,63,65,44,75,79,252,65,78,78,75,78,22},36), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({33,74,82},36))
local folder = env and env:FindFirstChild(_d({47,80,61,80,81,65,79},36))
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
debug(_d({67,65,80,47,80,61,80,81,65,41,75,64,65,72,42,65,61,78,252,65,78,78,75,78,22},36), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({62,61,78,78,65,72,36,44},36))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({67,65,80,47,80,61,80,81,65,36,44,252,65,78,78,75,78,22},36), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({48,75,75,72},36)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,29,80,80,78,69,62,81,80,65,252,65,78,78,75,78,22},36), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({48,75,75,72},36)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,42,61,73,65,252,65,78,78,75,78,22},36), tool)
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
if not ok then debug(_d({65,77,81,69,76,48,75,75,72,252,65,78,78,75,78,22},36), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({48,75,75,72},36)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,31,68,69,72,64,42,61,73,65,252,65,78,78,75,78,22},36), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({47,83,75,78,64,33,77,81,69,76},36))
if sword then
equipTool(sword)
return _d({79,83,75,78,64},36)
end
local melee = findToolByAttribute(_d({41,65,72,65,65,48,75,75,72},36))
if melee then
equipTool(melee)
return _d({73,65,72,65,65},36)
end
debug(_d({42,75,252,79,83,75,78,64,252,75,78,252,73,65,72,65,65,252,80,75,75,72,252,66,75,81,74,64},36))
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
if not ok then debug(_d({63,72,69,63,71,41,13,252,65,78,78,75,78,22},36), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
end
end)
if not ok then debug(_d({69,74,82,75,71,65,35,65,76,76,75,252,65,78,78,75,78,22},36), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({76,78,65,79,79,47,71,69,72,72,46,252,65,78,78,75,78,22},36), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({68,75,72,64,30,72,75,63,71,252,65,78,78,75,78,22},36), err) end
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
if not ok then debug(_d({68,75,72,64,30,72,75,63,71,51,68,69,72,65,252,65,78,78,75,78,22},36), err) end
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
debug(_d({67,65,80,35,61,73,65,35,252,65,78,78,75,78,22},36), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({69,79,46,65,61,72,41,13,30,81,79,85,252,65,78,78,75,78,22},36), result)
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
return char ~= nil and char:FindFirstChild(_d({79,80,81,74},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,47,80,81,74,74,65,64,252,65,78,78,75,78,22},36), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({76,78,65,79,79,47,80,81,74,30,78,65,61,71,252,65,78,78,75,78,22},36), err) end
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
debug(_d({77,81,65,65,74,32,75,64,67,65,49,74,80,69,72,47,61,66,65,22,252,45,81,65,65,74,252,67,75,74,65,252,9,252,65,74,64,69,74,67,252,64,75,64,67,65,252,65,61,78,72,85},36))
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
debug(_d({77,81,65,65,74,32,75,64,67,65,49,74,80,69,72,47,61,66,65,252,79,61,66,65,80,85,252,80,69,73,65,75,81,80},36))
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
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({45,81,65,65,74,252,63,61,79,80,69,74,67,252,64,65,80,65,63,80,65,64,252,9,252,64,75,64,67,69,74,67,252,4,83,61,80,63,68,65,78,5},36))
queenDodgeUntilSafe(function() return getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) end)
if enabled and getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) then
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
end
queenDodging = false
end
end)
if not ok then debug(_d({77,81,65,65,74,32,75,64,67,65,51,61,80,63,68,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({76,75,69,74,80},36) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({74,76,63},36) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({74,61,73,65,64},36) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({67,65,80,42,61,82,48,61,78,67,65,80,79,252,65,78,78,75,78,22},36), aimR)
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
debug(_d({63,75,73,76,81,80,65,40,75,63,71,65,64,31,34,78,61,73,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({76,75,69,74,80},36), point = pos}
phase = _d({73,75,82,65},36)
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
if not ok then debug(_d({74,61,82,48,75,44,75,69,74,80,252,67,65,76,76,75,252,63,68,65,63,71,252,65,78,78,75,78,22},36), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({74,76,63},36)}
phase = _d({73,75,82,65},36)
end
function setNavNamed(name)
NavState = {mode = _d({74,61,73,65,64},36), name = name}
phase = _d({73,75,82,65},36)
end
local function setNavIdle()
NavState = {mode = _d({69,64,72,65},36)}
phase = _d({73,75,82,65},36)
end
local function hasArrived()
return phase == _d({68,75,82,65,78},36)
end
local function startNav()
phase = _d({73,75,82,65},36)
debug(_d({42,61,82,252,72,75,75,76,252,43,42},36))
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
local prevPos = force:GetAttribute(_d({59,59,76,78,65,82,44,75,79},36))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({40,61,78,67,65,252,76,75,79,69,80,69,75,74,252,70,81,73,76,252,64,65,80,65,63,80,65,64,22},36), delta, _d({79,80,81,64,79,10,252,76,78,65,82,44,75,79,25},36), prevPos, _d({74,65,83,44,75,79,25},36), pos)
end
end
force:SetAttribute(_d({59,59,76,78,65,82,44,75,79},36), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({73,75,82,65},36) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({68,75,82,65,78},36)
debug(_d({44,68,61,79,65,22,252,68,75,82,65,78},36))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({253,253,253,252,46,33,34,49,47,37,42,35,252,48,43,252,29,44,44,40,53,252,29,30,42,43,46,41,29,40,252,50,33,40,43,31,37,48,53,22},36), finalVel, _d({61,69,73,25},36), aim, _d({76,75,79,25},36), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({68,75,82,65,78},36) then
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
debug(_d({31,75,73,62,61,80,252,72,75,63,71,252,79,71,69,76,76,65,64,8},36), snapDist, _d({79,80,81,64,79,252,66,78,75,73,252,80,61,78,67,65,80,252,190,92,112,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,73,75,82,65},36))
phase = _d({73,75,82,65},36)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({36,65,61,78,80,62,65,61,80,252,65,78,78,75,78,22},36), err) end
end)
end
local function stopNav()
debug(_d({42,61,82,252,72,75,75,76,252,43,34,34},36))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({73,75,82,65},36)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({48,65,84,80,31,68,61,80,47,65,78,82,69,63,65},36))
local channels = TextChatService:FindFirstChild(_d({48,65,84,80,31,68,61,74,74,65,72,79},36))
local channel = channels and channels:FindFirstChild(_d({46,30,52,35,65,74,65,78,61,72},36))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({32,65,66,61,81,72,80,31,68,61,80,47,85,79,80,65,73,31,68,61,80,33,82,65,74,80,79},36))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({47,61,85,41,65,79,79,61,67,65,46,65,77,81,65,79,80},36))
if sayEvent then
sayEvent:FireServer(message, _d({29,72,72},36))
return
end
debug(_d({79,65,74,64,31,68,61,80,41,65,79,79,61,67,65,22,252,74,75,252,48,65,84,80,31,68,61,80,47,65,78,82,69,63,65,10,46,30,52,35,65,74,65,78,61,72,252,75,78,252,72,65,67,61,63,85,252,47,61,85,41,65,79,79,61,67,65,46,65,77,81,65,79,80,252,66,75,81,74,64,252,66,75,78},36), message)
end)
if not ok then debug(_d({79,65,74,64,31,68,61,80,41,65,79,79,61,67,65,252,65,78,78,75,78,22},36), err) end
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
debug(_d({42,75,80,252,73,61,71,69,74,67,252,76,78,75,67,78,65,79,79,252,80,75,83,61,78,64,252,74,61,82,252,80,61,78,67,65,80,252,66,75,78},36), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({79,252,9,252,79,65,74,64,69,74,67,252,11,81,74,79,80,81,63,71},36))
sendChatMessage(_d({11,81,74,79,80,81,63,71},36))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({83,61,69,80,49,74,80,69,72,29,78,78,69,82,65,64,252,80,69,73,65,75,81,80},36))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({74,61,82,48,75,44,75,69,74,80,31,75,74,66,69,78,73,65,64,22},36), label or _d({80,61,78,67,65,80},36), _d({9,252,64,69,64,252,74,75,80,252,61,78,78,69,82,65,252,83,69,80,68,69,74},36), timeout, _d({79,8,252,78,65,80,78,85,69,74,67,252,75,74,63,65},36))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({74,61,82,48,75,44,75,69,74,80,31,75,74,66,69,78,73,65,64,22},36), label or _d({80,61,78,67,65,80},36), _d({9,252,79,80,69,72,72,252,74,75,80,252,61,78,78,69,82,65,64,252,61,66,80,65,78,252,78,65,80,78,85,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
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
if not ok then debug(_d({74,61,82,48,75,44,75,69,74,80,36,75,72,64,69,74,67,30,72,75,63,71,252,71,65,85,9,64,75,83,74,252,65,78,78,75,78,22},36), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({74,61,82,48,75,44,75,69,74,80,36,75,72,64,69,74,67,30,72,75,63,71,252,71,65,85,9,81,76,252,65,78,78,75,78,22},36), err2) end
end
local function clearStage(stageName)
debug(_d({41,75,82,69,74,67,252,80,75},36), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,42,44,31,79,252,80,75,252,79,76,61,83,74,252,61,80},36), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({252,252,79,76,61,83,74,252,63,68,65,63,71,22,252,66,75,72,64,65,78,252,65,84,69,79,80,79,252,25},36), folder ~= nil,
_d({8,252,63,68,69,72,64,78,65,74,252,25},36), folder and #folder:GetChildren() or 0,
_d({8,252,61,72,69,82,65,252,25},36), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({42,75,252,42,44,31,79,252,61,76,76,65,61,78,65,64,252,61,80},36), stageName, _d({61,66,80,65,78,252,13,17,79,8,252,73,75,82,69,74,67,252,75,74,252,61,74,85,83,61,85},36))
break
end
end
debug(_d({39,69,72,72,69,74,67,252,42,44,31,79,252,61,80},36), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({46,65,80,81,78,74,69,74,67,252,80,75},36), stageName, _d({76,75,79,69,80,69,75,74,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,75,74},36))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80},36), stageName, _d({76,75,79,69,80,69,75,74},36))
task.wait(5)
debug(stageName, _d({63,72,65,61,78,65,64},36))
end
local function killNamedNPC(name, targetPos)
debug(_d({41,75,82,69,74,67,252,80,75},36), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({64,65,66,65,61,80,65,64},36))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({40,65,75,252,76,72,61,85,65,64,252,61,74,69,73,61,80,69,75,74,22},36), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({72,65,75,29,74,69,73,40,75,67,67,65,78,252,76,78,69,74,80,252,65,78,78,75,78,22},36), err2) end
end)
end)
if not ok then debug(_d({79,80,61,78,80,40,65,75,29,74,69,73,40,75,67,67,65,78,252,65,78,78,75,78,22},36), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({41,75,82,69,74,67,252,80,75,252,40,65,75,252,4,62,72,75,63,71,69,74,67,252,61,66,80,65,78},36), LEO_BLOCK_DELAY, _d({79,5},36))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({40,65,75},36))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({40,65,75},36))
while enabled do
local info = getNPCByName(_d({40,65,75},36))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({40,65,75,252,63,61,79,80,69,74,67},36), which, _d({9,252,64,75,64,67,69,74,67},36))
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
if not getNPCByName(_d({40,65,75},36)) then
debug(_d({40,65,75,252,67,75,74,65,252,73,69,64,9,64,75,64,67,65,252,9,252,65,74,64,69,74,67,252,33,74,80,65,69,252,68,75,72,64,252,65,61,78,72,85},36))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({40,65,75},36)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({40,65,75,252,67,75,74,65,252,73,69,64,9,64,75,64,67,65,252,9,252,65,74,64,69,74,67,252,34,72,61,73,65,252,44,69,72,72,61,78,252,68,75,72,64,252,65,61,78,72,85},36))
end
end
end
if enabled and getNPCByName(_d({40,65,75},36)) then
setNavNamed(_d({40,65,75},36))
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
debug(_d({40,65,75,252,64,65,66,65,61,80,65,64},36))
stopLeoAnimLogger()
debug(_d({46,65,80,81,78,74,69,74,67,252,80,75,252,40,65,75,252,76,75,79,69,80,69,75,74,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,75,74},36))
navToPointConfirmed(COORDS.Leo, 30, _d({40,65,75,252,76,75,79,69,80,69,75,74},36))
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80,252,40,65,75,252,76,75,79,69,80,69,75,74},36))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({41,75,82,69,74,67,252,80,75},36), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,79,80,61,80,81,65,252,73,75,64,65,72,252,74,65,61,78},36), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({29,80,80,61,63,71,69,74,67},36), coordKey, _d({83,69,80,68},36), weapon or _d({74,75,80,68,69,74,67,252,66,75,81,74,64},36))
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
debug(coordKey, _d({62,61,78,78,65,72,252,64,65,79,80,78,75,85,65,64},36))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({9,252,63,75,81,72,64,252,74,75,80,252,66,69,74,64,252,79,80,61,80,81,65,252,73,75,64,65,72,8,252,79,71,69,76,76,69,74,67},36))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({79,80,69,72,72,252,61,72,69,82,65,252,4,36,44},36), hp, _d({5,252,9,252,78,65,9,64,65,79,80,78,75,85,69,74,67},36))
destroyStatue(coordKey)
else
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({63,75,74,66,69,78,73,65,64,252,64,65,79,80,78,75,85,65,64},36))
end
end)
if not ok then debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,252,65,78,78,75,78,22},36), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({41,75,82,69,74,67,252,80,75,252,45,81,65,65,74},36))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({45,81,65,65,74,252,65,74,80,65,78,65,64,252,76,68,61,79,65,252,14},36))
end
local function finishQueen()
debug(_d({34,69,74,69,79,68,69,74,67,252,45,81,65,65,74},36))
equipSwordOrMelee()
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({45,81,65,65,74,252,64,65,66,65,61,80,65,64,10,252,44,72,61,74,252,63,75,73,76,72,65,80,65,10},36))
end
local CONFIRMATION_PROMPT_NAME = _d({31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80},36)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({46,65,73,75,80,65,33,82,65,74,80},36), 5)
end)
if ok then return result end
debug(_d({67,65,80,46,65,76,72,61,85,46,65,73,75,80,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({37,73,61,67,65,30,81,80,80,75,74},36)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({62,81,80,80,75,74,50,61,72,81,65},36)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({66,69,74,64,30,81,80,80,75,74,30,85,50,61,72,81,65,252,65,78,78,75,78,22},36), result)
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
if not ok then debug(_d({63,72,69,63,71,35,81,69,30,81,80,80,75,74,252,65,78,78,75,78,22},36), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({69,79,47,65,78,82,65,78},36))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({46,65,73,75,80,65,33,82,65,74,80},36))
or inst:FindFirstChild(_d({63,72,69,65,74,80,33,82,65,74,80},36))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({66,69,74,64,29,74,79,83,65,78,31,75,74,74,65,63,80,75,78,252,65,78,78,75,78,22},36), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({31,75,81,72,64,252,74,75,80,252,72,75,63,61,80,65,252,46,65,73,75,80,65,33,82,65,74,80,11,63,72,69,65,74,80,33,82,65,74,80,252,74,65,61,78,252,46,65,76,72,61,85,252,62,81,80,80,75,74,8,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,63,72,69,63,71},36))
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
debug(_d({66,69,78,65,46,65,76,72,61,85,50,61,72,81,65,252,65,78,78,75,78,22},36), err, _d({9,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,63,72,69,63,71},36))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({34,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,62,81,80,80,75,74,50,61,72,81,65,252,79,65,61,78,63,68,252,66,75,78,252,46,65,76,72,61,85},36))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({46,65,76,72,61,85,252,62,81,80,80,75,74,252,74,75,80,252,66,75,81,74,64,252,65,69,80,68,65,78,8,252,67,69,82,69,74,67,252,81,76},36))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,10,46,65,73,75,80,65,33,82,65,74,80},36))
local remote = getReplayRemote()
if not remote then
debug(_d({31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,11,46,65,73,75,80,65,33,82,65,74,80,252,74,75,80,252,66,75,81,74,64,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80},36))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({34,69,78,69,74,67,252,46,65,76,72,61,85,252,82,69,61,252,31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,10,46,65,73,75,80,65,33,82,65,74,80},36))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({34,69,78,65,47,65,78,82,65,78,252,65,78,78,75,78,22},36), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then
debug(_d({83,61,69,80,34,75,78,43,62,70,65,63,80,69,82,65,79,35,81,69,22,252,74,75,252,44,72,61,85,65,78,35,81,69,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({43,62,70,65,63,80,69,82,65,79,252,35,49,37,252,66,75,81,74,64,252,9,252,79,80,61,67,65,252,72,75,61,64,65,64},36))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({43,62,70,65,63,80,69,82,65,79,252,35,49,37,252,74,75,80,252,66,75,81,74,64,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
return
end
end
end)
if not ok then debug(_d({83,61,69,80,34,75,78,43,62,70,65,63,80,69,82,65,79,35,81,69,252,65,78,78,75,78,22},36), err) end
end
local function runPlan()
debug(_d({44,72,61,74,252,79,80,61,78,80,65,64},36))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({47,80,61,78,80,69,74,67,252,74,61,82,252,72,75,75,76},36))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({76,75,79,252,12,10,14,79,252,29,34,48,33,46,252,79,80,61,78,80,42,61,82,22},36), rootAfter and rootAfter.Position)
end)
debug(_d({51,61,69,80,69,74,67,252,17,79,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,80,75,252,47,80,61,67,65,13},36))
task.wait(5)
for _, stage in ipairs({_d({47,80,61,67,65,13},36), _d({47,80,61,67,65,14},36), _d({47,80,61,67,65,15},36), _d({47,80,61,67,65,15,30},36)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,80,75,252,61,78,78,75,83,252,66,72,85,9,64,75,83,74,252,61,78,65,61},36))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({32,75,64,67,69,74,67,252,61,78,78,75,83,252,78,61,69,74},36))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({47,80,61,67,65,16},36))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({45,81,65,65,74,252,69,74,252,76,68,61,79,65,252,14,252,9,252,71,65,65,76,69,74,67,252,39,65,74,252,36,61,71,69,252,61,63,80,69,82,65,252,66,78,75,73,252,68,65,78,65,252,75,74},36))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({47,80,61,80,81,65,13},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,13},36))
destroyStatue(_d({47,80,61,80,81,65,14},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,13},36))
recheckStatue(_d({47,80,61,80,81,65,14},36))
destroyStatue(_d({47,80,61,80,81,65,15},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,15},36))
recheckStatue(_d({47,80,61,80,81,65,14},36))
recheckStatue(_d({47,80,61,80,81,65,13},36))
if not enabled then return end
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,76,68,61,79,65,252,14,252,80,75,252,65,74,64},36))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({44,68,61,79,65,252,14,252,65,74,64,252,83,61,69,80,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,62,61,63,71,252,80,75,252,45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
navToPointConfirmed(COORDS.Queen, 30, _d({45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80,252,45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
task.wait(5)
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,80,75,252,76,75,79,80,9,45,81,65,65,74,252,76,75,79,69,80,69,75,74},36))
navToPointConfirmed(COORDS.PostQueen, 30, _d({76,75,79,80,9,45,81,65,65,74,252,76,75,79,69,80,69,75,74},36))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({33,74,61,62,72,69,74,67,8,252,76,75,79,252,30,33,34,43,46,33,252,76,72,61,74,22},36), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({44,72,61,74,252,65,78,78,75,78,22},36), err2) end
end)
debug(_d({33,74,61,62,72,65,64,22},36), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({33,74,61,62,72,65,64,22},36), enabled)
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
if not ok then debug(_d({37,74,76,81,80,30,65,67,61,74,252,65,78,78,75,78,22},36), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({35,61,73,65,252,72,75,61,64,65,64,8,252,61,81,80,75,9,79,80,61,78,80,69,74,67,252,80,68,65,252,76,72,61,74},36))
enableBot()
end)
if not ok then debug(_d({29,81,80,75,79,80,61,78,80,252,65,78,78,75,78,22},36), err) end
end)
debug(_d({40,75,61,64,65,64,252,190,92,112,252,61,81,80,75,9,79,80,61,78,80,69,74,67,252,75,74,63,65,252,80,68,65,252,67,61,73,65,252,66,69,74,69,79,68,65,79,252,72,75,61,64,69,74,67,252,4,76,78,65,79,79,252,44,252,80,75,252,80,75,67,67,72,65,252,73,61,74,81,61,72,72,85,5},36))
end)()