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
local Players            = game:GetService(_d({41,69,58,82,62,75,76},39))
local UserInputService    = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
local RunService          = game:GetService(_d({43,78,71,44,62,75,79,66,60,62},39))
local VIM                 = game:GetService(_d({47,66,75,77,78,58,69,34,71,73,78,77,38,58,71,58,64,62,75},39))
local ReplicatedStorage    = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({52,27,72,76,76,27,72,77,54},39), _d({48,75,72,71,64,249,64,58,70,62,249,187,89,109,249,41,69,58,60,62,34,61,19},39), game.PlaceId, _d({46,71,66,79,62,75,76,62,34,61,19},39), game.GameId, _d({6,249,71,72,77,249,75,78,71,71,66,71,64},39))
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
local LEO_PILLAR_ANIM_ID   = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,14,11,13,13,10,13,10,12,11,16},39)
local LEO_ENTEI_ANIM_ID    = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,14,11,13,13,10,12,17,11,16,17},39)
local LEO_HIKEN_ANIM_ID    = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,14,11,11,9,18,10,16,13,9,16},39)
local LEO_FIREFLY_ANIM_ID  = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,14,11,11,9,11,12,15,10,14,13},39)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({40,59,67,62,60,77,66,79,62,76},39)
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
local REPLAY_BUTTON_VALUE   = _d({43,62,73,69,58,82},39)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({70,72,79,62},39)
local NavState   = {mode = _d({66,61,69,62},39)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({52,27,72,76,76,27,72,77,54},39), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end)
if ok then return root end
debug(_d({64,62,77,43,72,72,77,249,62,75,75,72,75,19},39), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
end)
if ok then return hum end
debug(_d({64,62,77,33,78,70,58,71,72,66,61,249,62,75,75,72,75,19},39), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({56,56,33,72,79,62,75,26,77,77},39)) or Instance.new(_d({26,77,77,58,60,65,70,62,71,77},39))
att.Name = _d({56,56,33,72,79,62,75,26,77,77},39)
att.Parent = root
local force = root:FindFirstChild(_d({56,56,33,72,79,62,75,31,72,75,60,62},39))
if not force then
force = Instance.new(_d({37,66,71,62,58,75,47,62,69,72,60,66,77,82},39))
force.Name = _d({56,56,33,72,79,62,75,31,72,75,60,62},39)
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
debug(_d({64,62,77,40,75,28,75,62,58,77,62,31,72,75,60,62,249,62,75,75,72,75,19},39), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not root then return end
local force = root:FindFirstChild(_d({56,56,33,72,79,62,75,31,72,75,60,62},39))
local att   = root:FindFirstChild(_d({56,56,33,72,79,62,75,26,77,77},39))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({60,69,62,58,71,78,73,31,72,75,60,62,249,62,75,75,72,75,19},39), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({27,78,76,72,38,62,69,62,62},39)) ~= nil
end)
if ok then return result end
debug(_d({66,76,27,78,76,72,26,60,77,66,79,62,249,62,75,75,72,75,19},39), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({27,78,76,72},39))
end)
if not ok then debug(_d({58,60,77,66,79,58,77,62,27,78,76,72,249,62,75,75,72,75,19},39), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({27,78,76,72,249,71,72,77,249,58,60,77,66,79,62,5,249,58,60,77,66,79,58,77,66,71,64},39))
activateBuso()
end
end)
if not ok then debug(_d({27,78,76,72,36,62,62,73,62,75,249,62,75,75,72,75,19},39), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({27,78,76,72,249,68,62,62,73,62,75,249,76,77,72,73,73,62,61},39))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({36,62,71,33,58,68,66},39)) ~= nil
end)
if ok then return result end
debug(_d({66,76,36,62,71,26,60,77,66,79,62,249,62,75,75,72,75,19},39), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({36,62,71},39), true)
end)
if not ok then debug(_d({58,60,77,66,79,58,77,62,36,62,71,249,62,75,75,72,75,19},39), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({36,62,71,249,71,72,77,249,58,60,77,66,79,62,5,249,58,60,77,66,79,58,77,66,71,64},39))
activateKen()
end
end)
if not ok then debug(_d({36,62,71,36,62,62,73,62,75,249,62,75,75,72,75,19},39), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({36,62,71,249,68,62,62,73,62,75,249,76,77,72,73,73,62,61},39))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({39,41,28,76},39)) end)
if ok then return folder end
debug(_d({64,62,77,39,41,28,76,31,72,69,61,62,75,249,62,75,75,72,75,19},39), folder)
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
local r = model:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local h = model:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
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
debug(_d({64,62,77,39,62,58,75,62,76,77,39,41,28,249,62,75,75,72,75,19},39), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
local hum  = model:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({64,62,77,39,41,28,27,82,39,58,70,62,249,62,75,75,72,75,19},39), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({71,73,60,76,43,62,70,58,66,71,66,71,64,249,62,75,75,72,75,19},39), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({28,78,73,66,61,249,42,78,62,62,71},39))
return queen ~= nil and queen:FindFirstChild(_d({70,72,77,66,72,71,37,62,76,76},39)) ~= nil
end)
if ok then return result end
debug(_d({66,76,42,78,62,62,71,41,65,58,76,62,11,249,62,75,75,72,75,19},39), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,10,11,10,11,18,16,18,13,11,11,18,11,16,15,18},39)
local QUEEN_GRASP_ANIM_ID   = _d({75,59,81,58,76,76,62,77,66,61,19,8,8,10,11,18,17,9,9,9,15,10,9,9,10,16,12,13},39)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
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
debug(_d({66,76,41,69,58,82,66,71,64,26,71,66,70,31,75,72,70,37,66,76,77,249,62,75,75,72,75,19},39), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({27,69,72,60,68,66,71,64},39)) ~= nil
end)
if ok then return result end
debug(_d({66,76,39,41,28,27,69,72,60,68,66,71,64,249,62,75,75,72,75,19},39), result)
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
debug(_d({73,75,62,61,66,60,77,39,41,28,41,72,76,66,77,66,72,71,249,62,75,75,72,75,19},39), result)
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
debug(_d({39,72,249,61,58,70,58,64,62,249,72,71},39), model.Name, _d({63,72,75},39), NPC_STUCK_TIMEOUT, _d({76,249,6,249,76,80,66,77,60,65,66,71,64,249,77,58,75,64,62,77},39))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({77,75,58,60,68,39,41,28,29,58,70,58,64,62,249,62,75,75,72,75,19},39), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({38,72,61,62,69},39)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({27,58,76,62,41,58,75,77},39)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({64,62,77,38,72,61,62,69,31,58,60,62,41,72,76,249,62,75,75,72,75,19},39), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({30,71,79},39))
local folder = env and env:FindFirstChild(_d({44,77,58,77,78,62,76},39))
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
debug(_d({64,62,77,44,77,58,77,78,62,38,72,61,62,69,39,62,58,75,249,62,75,75,72,75,19},39), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({59,58,75,75,62,69,33,41},39))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({64,62,77,44,77,58,77,78,62,33,41,249,62,75,75,72,75,19},39), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({45,72,72,69},39)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({63,66,71,61,45,72,72,69,27,82,26,77,77,75,66,59,78,77,62,249,62,75,75,72,75,19},39), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({45,72,72,69},39)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({63,66,71,61,45,72,72,69,27,82,39,58,70,62,249,62,75,75,72,75,19},39), tool)
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
if not ok then debug(_d({62,74,78,66,73,45,72,72,69,249,62,75,75,72,75,19},39), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({27,58,60,68,73,58,60,68},39))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({45,72,72,69},39)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({63,66,71,61,45,72,72,69,27,82,28,65,66,69,61,39,58,70,62,249,62,75,75,72,75,19},39), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({44,80,72,75,61,30,74,78,66,73},39))
if sword then
equipTool(sword)
return _d({76,80,72,75,61},39)
end
local melee = findToolByAttribute(_d({38,62,69,62,62,45,72,72,69},39))
if melee then
equipTool(melee)
return _d({70,62,69,62,62},39)
end
debug(_d({39,72,249,76,80,72,75,61,249,72,75,249,70,62,69,62,62,249,77,72,72,69,249,63,72,78,71,61},39))
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
if not ok then debug(_d({60,69,66,60,68,38,10,249,62,75,75,72,75,19},39), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({43,72,68,78,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,62,73,73,72},39), args)
elseif style == _d({27,69,58,60,68,37,62,64},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68},39), args)
elseif style == _d({36,58,70,66,76,65,66,68,66},39) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({36,58,70,66,76,65,66,68,66,32,62,73,73,72},39), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,68,82,249,48,58,69,68,11},39), args)
end
end)
if not ok then debug(_d({66,71,79,72,68,62,32,62,73,73,72,249,62,75,75,72,75,19},39), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({73,75,62,76,76,44,68,66,69,69,43,249,62,75,75,72,75,19},39), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({65,72,69,61,27,69,72,60,68,249,62,75,75,72,75,19},39), err) end
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
if not ok then debug(_d({65,72,69,61,27,69,72,60,68,48,65,66,69,62,249,62,75,75,72,75,19},39), err) end
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
debug(_d({64,62,77,32,58,70,62,32,249,62,75,75,72,75,19},39), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({66,76,43,62,58,69,38,10,27,78,76,82,249,62,75,75,72,75,19},39), result)
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
return char ~= nil and char:FindFirstChild(_d({76,77,78,71},39)) ~= nil
end)
if ok then return result end
debug(_d({66,76,44,77,78,71,71,62,61,249,62,75,75,72,75,19},39), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({73,75,62,76,76,44,77,78,71,27,75,62,58,68,249,62,75,75,72,75,19},39), err) end
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
debug(_d({74,78,62,62,71,29,72,61,64,62,46,71,77,66,69,44,58,63,62,19,249,42,78,62,62,71,249,64,72,71,62,249,6,249,62,71,61,66,71,64,249,61,72,61,64,62,249,62,58,75,69,82},39))
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
debug(_d({74,78,62,62,71,29,72,61,64,62,46,71,77,66,69,44,58,63,62,249,76,58,63,62,77,82,249,77,66,70,62,72,78,77},39))
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
local info = getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({42,78,62,62,71,249,60,58,76,77,66,71,64,249,61,62,77,62,60,77,62,61,249,6,249,61,72,61,64,66,71,64,249,1,80,58,77,60,65,62,75,2},39))
queenDodgeUntilSafe(function() return getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39)) end)
if enabled and getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39)) then
setNavNamed(_d({28,78,73,66,61,249,42,78,62,62,71},39))
end
queenDodging = false
end
end)
if not ok then debug(_d({74,78,62,62,71,29,72,61,64,62,48,58,77,60,65,62,75,249,62,75,75,72,75,19},39), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({73,72,66,71,77},39) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({71,73,60},39) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({71,58,70,62,61},39) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({64,62,77,39,58,79,45,58,75,64,62,77,76,249,62,75,75,72,75,19},39), aimR)
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
debug(_d({60,72,70,73,78,77,62,37,72,60,68,62,61,28,31,75,58,70,62,249,62,75,75,72,75,19},39), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({73,72,66,71,77},39), point = pos}
phase = _d({70,72,79,62},39)
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
if not ok then debug(_d({71,58,79,45,72,41,72,66,71,77,249,64,62,73,73,72,249,60,65,62,60,68,249,62,75,75,72,75,19},39), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({71,73,60},39)}
phase = _d({70,72,79,62},39)
end
function setNavNamed(name)
NavState = {mode = _d({71,58,70,62,61},39), name = name}
phase = _d({70,72,79,62},39)
end
local function setNavIdle()
NavState = {mode = _d({66,61,69,62},39)}
phase = _d({70,72,79,62},39)
end
local function hasArrived()
return phase == _d({65,72,79,62,75},39)
end
local function startNav()
phase = _d({70,72,79,62},39)
debug(_d({39,58,79,249,69,72,72,73,249,40,39},39))
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
local prevPos = force:GetAttribute(_d({56,56,73,75,62,79,41,72,76},39))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({37,58,75,64,62,249,73,72,76,66,77,66,72,71,249,67,78,70,73,249,61,62,77,62,60,77,62,61,19},39), delta, _d({76,77,78,61,76,7,249,73,75,62,79,41,72,76,22},39), prevPos, _d({71,62,80,41,72,76,22},39), pos)
end
end
force:SetAttribute(_d({56,56,73,75,62,79,41,72,76},39), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({70,72,79,62},39) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({65,72,79,62,75},39)
debug(_d({41,65,58,76,62,19,249,65,72,79,62,75},39))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({250,250,250,249,43,30,31,46,44,34,39,32,249,45,40,249,26,41,41,37,50,249,26,27,39,40,43,38,26,37,249,47,30,37,40,28,34,45,50,19},39), finalVel, _d({58,66,70,22},39), aim, _d({73,72,76,22},39), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({65,72,79,62,75},39) then
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
debug(_d({28,72,70,59,58,77,249,69,72,60,68,249,76,68,66,73,73,62,61,5},39), snapDist, _d({76,77,78,61,76,249,63,75,72,70,249,77,58,75,64,62,77,249,187,89,109,249,63,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,70,72,79,62},39))
phase = _d({70,72,79,62},39)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({33,62,58,75,77,59,62,58,77,249,62,75,75,72,75,19},39), err) end
end)
end
local function stopNav()
debug(_d({39,58,79,249,69,72,72,73,249,40,31,31},39))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({70,72,79,62},39)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({45,62,81,77,28,65,58,77,44,62,75,79,66,60,62},39))
local channels = TextChatService:FindFirstChild(_d({45,62,81,77,28,65,58,71,71,62,69,76},39))
local channel = channels and channels:FindFirstChild(_d({43,27,49,32,62,71,62,75,58,69},39))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({29,62,63,58,78,69,77,28,65,58,77,44,82,76,77,62,70,28,65,58,77,30,79,62,71,77,76},39))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({44,58,82,38,62,76,76,58,64,62,43,62,74,78,62,76,77},39))
if sayEvent then
sayEvent:FireServer(message, _d({26,69,69},39))
return
end
debug(_d({76,62,71,61,28,65,58,77,38,62,76,76,58,64,62,19,249,71,72,249,45,62,81,77,28,65,58,77,44,62,75,79,66,60,62,7,43,27,49,32,62,71,62,75,58,69,249,72,75,249,69,62,64,58,60,82,249,44,58,82,38,62,76,76,58,64,62,43,62,74,78,62,76,77,249,63,72,78,71,61,249,63,72,75},39), message)
end)
if not ok then debug(_d({76,62,71,61,28,65,58,77,38,62,76,76,58,64,62,249,62,75,75,72,75,19},39), err) end
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
debug(_d({39,72,77,249,70,58,68,66,71,64,249,73,75,72,64,75,62,76,76,249,77,72,80,58,75,61,249,71,58,79,249,77,58,75,64,62,77,249,63,72,75},39), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({76,249,6,249,76,62,71,61,66,71,64,249,8,78,71,76,77,78,60,68},39))
sendChatMessage(_d({8,78,71,76,77,78,60,68},39))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({80,58,66,77,46,71,77,66,69,26,75,75,66,79,62,61,249,77,66,70,62,72,78,77},39))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({71,58,79,45,72,41,72,66,71,77,28,72,71,63,66,75,70,62,61,19},39), label or _d({77,58,75,64,62,77},39), _d({6,249,61,66,61,249,71,72,77,249,58,75,75,66,79,62,249,80,66,77,65,66,71},39), timeout, _d({76,5,249,75,62,77,75,82,66,71,64,249,72,71,60,62},39))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({71,58,79,45,72,41,72,66,71,77,28,72,71,63,66,75,70,62,61,19},39), label or _d({77,58,75,64,62,77},39), _d({6,249,76,77,66,69,69,249,71,72,77,249,58,75,75,66,79,62,61,249,58,63,77,62,75,249,75,62,77,75,82,5,249,73,75,72,60,62,62,61,66,71,64,249,58,71,82,80,58,82},39))
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
if not ok then debug(_d({71,58,79,45,72,41,72,66,71,77,33,72,69,61,66,71,64,27,69,72,60,68,249,68,62,82,6,61,72,80,71,249,62,75,75,72,75,19},39), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({71,58,79,45,72,41,72,66,71,77,33,72,69,61,66,71,64,27,69,72,60,68,249,68,62,82,6,78,73,249,62,75,75,72,75,19},39), err2) end
end
local function clearStage(stageName)
debug(_d({38,72,79,66,71,64,249,77,72},39), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({48,58,66,77,66,71,64,249,63,72,75,249,39,41,28,76,249,77,72,249,76,73,58,80,71,249,58,77},39), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({249,249,76,73,58,80,71,249,60,65,62,60,68,19,249,63,72,69,61,62,75,249,62,81,66,76,77,76,249,22},39), folder ~= nil,
_d({5,249,60,65,66,69,61,75,62,71,249,22},39), folder and #folder:GetChildren() or 0,
_d({5,249,58,69,66,79,62,249,22},39), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({39,72,249,39,41,28,76,249,58,73,73,62,58,75,62,61,249,58,77},39), stageName, _d({58,63,77,62,75,249,10,14,76,5,249,70,72,79,66,71,64,249,72,71,249,58,71,82,80,58,82},39))
break
end
end
debug(_d({36,66,69,69,66,71,64,249,39,41,28,76,249,58,77},39), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({43,62,77,78,75,71,66,71,64,249,77,72},39), stageName, _d({73,72,76,66,77,66,72,71,249,59,62,63,72,75,62,249,70,72,79,66,71,64,249,72,71},39))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({48,58,66,77,66,71,64,249,14,76,249,58,77},39), stageName, _d({73,72,76,66,77,66,72,71},39))
task.wait(5)
debug(stageName, _d({60,69,62,58,75,62,61},39))
end
local function killNamedNPC(name, targetPos)
debug(_d({38,72,79,66,71,64,249,77,72},39), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({61,62,63,62,58,77,62,61},39))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({33,78,70,58,71,72,66,61},39))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({37,62,72,249,73,69,58,82,62,61,249,58,71,66,70,58,77,66,72,71,19},39), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({69,62,72,26,71,66,70,37,72,64,64,62,75,249,73,75,66,71,77,249,62,75,75,72,75,19},39), err2) end
end)
end)
if not ok then debug(_d({76,77,58,75,77,37,62,72,26,71,66,70,37,72,64,64,62,75,249,62,75,75,72,75,19},39), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({38,72,79,66,71,64,249,77,72,249,37,62,72,249,1,59,69,72,60,68,66,71,64,249,58,63,77,62,75},39), LEO_BLOCK_DELAY, _d({76,2},39))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({37,62,72},39))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({37,62,72},39))
while enabled do
local info = getNPCByName(_d({37,62,72},39))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({37,62,72,249,60,58,76,77,66,71,64},39), which, _d({6,249,61,72,61,64,66,71,64},39))
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
if not getNPCByName(_d({37,62,72},39)) then
debug(_d({37,62,72,249,64,72,71,62,249,70,66,61,6,61,72,61,64,62,249,6,249,62,71,61,66,71,64,249,30,71,77,62,66,249,65,72,69,61,249,62,58,75,69,82},39))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({37,62,72},39)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({37,62,72,249,64,72,71,62,249,70,66,61,6,61,72,61,64,62,249,6,249,62,71,61,66,71,64,249,31,69,58,70,62,249,41,66,69,69,58,75,249,65,72,69,61,249,62,58,75,69,82},39))
end
end
end
if enabled and getNPCByName(_d({37,62,72},39)) then
setNavNamed(_d({37,62,72},39))
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
debug(_d({37,62,72,249,61,62,63,62,58,77,62,61},39))
stopLeoAnimLogger()
debug(_d({43,62,77,78,75,71,66,71,64,249,77,72,249,37,62,72,249,73,72,76,66,77,66,72,71,249,59,62,63,72,75,62,249,70,72,79,66,71,64,249,72,71},39))
navToPointConfirmed(COORDS.Leo, 30, _d({37,62,72,249,73,72,76,66,77,66,72,71},39))
debug(_d({48,58,66,77,66,71,64,249,14,76,249,58,77,249,37,62,72,249,73,72,76,66,77,66,72,71},39))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({38,72,79,66,71,64,249,77,72},39), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({28,72,78,69,61,249,71,72,77,249,63,66,71,61,249,76,77,58,77,78,62,249,70,72,61,62,69,249,71,62,58,75},39), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({26,77,77,58,60,68,66,71,64},39), coordKey, _d({80,66,77,65},39), weapon or _d({71,72,77,65,66,71,64,249,63,72,78,71,61},39))
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
debug(coordKey, _d({59,58,75,75,62,69,249,61,62,76,77,75,72,82,62,61},39))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({75,62,60,65,62,60,68,44,77,58,77,78,62,19},39), coordKey, _d({6,249,60,72,78,69,61,249,71,72,77,249,63,66,71,61,249,76,77,58,77,78,62,249,70,72,61,62,69,5,249,76,68,66,73,73,66,71,64},39))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({75,62,60,65,62,60,68,44,77,58,77,78,62,19},39), coordKey, _d({76,77,66,69,69,249,58,69,66,79,62,249,1,33,41},39), hp, _d({2,249,6,249,75,62,6,61,62,76,77,75,72,82,66,71,64},39))
destroyStatue(coordKey)
else
debug(_d({75,62,60,65,62,60,68,44,77,58,77,78,62,19},39), coordKey, _d({60,72,71,63,66,75,70,62,61,249,61,62,76,77,75,72,82,62,61},39))
end
end)
if not ok then debug(_d({75,62,60,65,62,60,68,44,77,58,77,78,62,249,62,75,75,72,75,19},39), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({38,72,79,66,71,64,249,77,72,249,42,78,62,62,71},39))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({28,78,73,66,61,249,42,78,62,62,71},39))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({42,78,62,62,71,249,62,71,77,62,75,62,61,249,73,65,58,76,62,249,11},39))
end
local function finishQueen()
debug(_d({31,66,71,66,76,65,66,71,64,249,42,78,62,62,71},39))
equipSwordOrMelee()
setNavNamed(_d({28,78,73,66,61,249,42,78,62,62,71},39))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({28,78,73,66,61,249,42,78,62,62,71},39))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({42,78,62,62,71,249,61,62,63,62,58,77,62,61,7,249,41,69,58,71,249,60,72,70,73,69,62,77,62,7},39))
end
local CONFIRMATION_PROMPT_NAME = _d({28,72,71,63,66,75,70,58,77,66,72,71,41,75,72,70,73,77},39)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({43,62,70,72,77,62,30,79,62,71,77},39), 5)
end)
if ok then return result end
debug(_d({64,62,77,43,62,73,69,58,82,43,62,70,72,77,62,249,62,75,75,72,75,19},39), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({41,69,58,82,62,75,32,78,66},39))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({34,70,58,64,62,27,78,77,77,72,71},39)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({59,78,77,77,72,71,47,58,69,78,62},39)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({63,66,71,61,27,78,77,77,72,71,27,82,47,58,69,78,62,249,62,75,75,72,75,19},39), result)
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
if not ok then debug(_d({60,69,66,60,68,32,78,66,27,78,77,77,72,71,249,62,75,75,72,75,19},39), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({66,76,44,62,75,79,62,75},39))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({43,62,70,72,77,62,30,79,62,71,77},39))
or inst:FindFirstChild(_d({60,69,66,62,71,77,30,79,62,71,77},39))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({63,66,71,61,26,71,76,80,62,75,28,72,71,71,62,60,77,72,75,249,62,75,75,72,75,19},39), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({28,72,78,69,61,249,71,72,77,249,69,72,60,58,77,62,249,43,62,70,72,77,62,30,79,62,71,77,8,60,69,66,62,71,77,30,79,62,71,77,249,71,62,58,75,249,43,62,73,69,58,82,249,59,78,77,77,72,71,5,249,63,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,60,69,66,60,68},39))
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
debug(_d({63,66,75,62,43,62,73,69,58,82,47,58,69,78,62,249,62,75,75,72,75,19},39), err, _d({6,249,63,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,60,69,66,60,68},39))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({31,58,69,69,66,71,64,249,59,58,60,68,249,77,72,249,59,78,77,77,72,71,47,58,69,78,62,249,76,62,58,75,60,65,249,63,72,75,249,43,62,73,69,58,82},39))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({43,62,73,69,58,82,249,59,78,77,77,72,71,249,71,72,77,249,63,72,78,71,61,249,62,66,77,65,62,75,5,249,64,66,79,66,71,64,249,78,73},39))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({48,58,66,77,66,71,64,249,63,72,75,249,28,72,71,63,66,75,70,58,77,66,72,71,41,75,72,70,73,77,7,43,62,70,72,77,62,30,79,62,71,77},39))
local remote = getReplayRemote()
if not remote then
debug(_d({28,72,71,63,66,75,70,58,77,66,72,71,41,75,72,70,73,77,8,43,62,70,72,77,62,30,79,62,71,77,249,71,72,77,249,63,72,78,71,61,249,80,66,77,65,66,71,249,77,66,70,62,72,78,77},39))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({31,66,75,66,71,64,249,43,62,73,69,58,82,249,79,66,58,249,28,72,71,63,66,75,70,58,77,66,72,71,41,75,72,70,73,77,7,43,62,70,72,77,62,30,79,62,71,77},39))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({31,66,75,62,44,62,75,79,62,75,249,62,75,75,72,75,19},39), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({41,69,58,82,62,75,32,78,66},39), 10)
if not playerGui then
debug(_d({80,58,66,77,31,72,75,40,59,67,62,60,77,66,79,62,76,32,78,66,19,249,71,72,249,41,69,58,82,62,75,32,78,66,249,80,66,77,65,66,71,249,77,66,70,62,72,78,77,5,249,73,75,72,60,62,62,61,66,71,64,249,58,71,82,80,58,82},39))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({40,59,67,62,60,77,66,79,62,76,249,32,46,34,249,63,72,78,71,61,249,6,249,76,77,58,64,62,249,69,72,58,61,62,61},39))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({40,59,67,62,60,77,66,79,62,76,249,32,46,34,249,71,72,77,249,63,72,78,71,61,249,80,66,77,65,66,71,249,77,66,70,62,72,78,77,5,249,73,75,72,60,62,62,61,66,71,64,249,58,71,82,80,58,82},39))
return
end
end
end)
if not ok then debug(_d({80,58,66,77,31,72,75,40,59,67,62,60,77,66,79,62,76,32,78,66,249,62,75,75,72,75,19},39), err) end
end
local function runPlan()
debug(_d({41,69,58,71,249,76,77,58,75,77,62,61},39))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({44,77,58,75,77,66,71,64,249,71,58,79,249,69,72,72,73},39))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({73,72,76,249,9,7,11,76,249,26,31,45,30,43,249,76,77,58,75,77,39,58,79,19},39), rootAfter and rootAfter.Position)
end)
debug(_d({48,58,66,77,66,71,64,249,14,76,249,59,62,63,72,75,62,249,70,72,79,66,71,64,249,77,72,249,44,77,58,64,62,10},39))
task.wait(5)
for _, stage in ipairs({_d({44,77,58,64,62,10},39), _d({44,77,58,64,62,11},39), _d({44,77,58,64,62,12},39), _d({44,77,58,64,62,12,27},39)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({38,72,79,66,71,64,249,77,72,249,58,75,75,72,80,249,63,69,82,6,61,72,80,71,249,58,75,62,58},39))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({29,72,61,64,66,71,64,249,58,75,75,72,80,249,75,58,66,71},39))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({44,77,58,64,62,13},39))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({42,78,62,62,71,249,66,71,249,73,65,58,76,62,249,11,249,6,249,68,62,62,73,66,71,64,249,36,62,71,249,33,58,68,66,249,58,60,77,66,79,62,249,63,75,72,70,249,65,62,75,62,249,72,71},39))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({44,77,58,77,78,62,10},39))
if not enabled then return end
recheckStatue(_d({44,77,58,77,78,62,10},39))
destroyStatue(_d({44,77,58,77,78,62,11},39))
if not enabled then return end
recheckStatue(_d({44,77,58,77,78,62,10},39))
recheckStatue(_d({44,77,58,77,78,62,11},39))
destroyStatue(_d({44,77,58,77,78,62,12},39))
if not enabled then return end
recheckStatue(_d({44,77,58,77,78,62,12},39))
recheckStatue(_d({44,77,58,77,78,62,11},39))
recheckStatue(_d({44,77,58,77,78,62,10},39))
if not enabled then return end
debug(_d({48,58,66,77,66,71,64,249,63,72,75,249,73,65,58,76,62,249,11,249,77,72,249,62,71,61},39))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({41,65,58,76,62,249,11,249,62,71,61,249,80,58,66,77,249,77,66,70,62,72,78,77,5,249,73,75,72,60,62,62,61,66,71,64,249,58,71,82,80,58,82},39))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({38,72,79,66,71,64,249,59,58,60,68,249,77,72,249,42,78,62,62,71,249,76,77,58,64,62,249,73,72,76,66,77,66,72,71},39))
navToPointConfirmed(COORDS.Queen, 30, _d({42,78,62,62,71,249,76,77,58,64,62,249,73,72,76,66,77,66,72,71},39))
debug(_d({48,58,66,77,66,71,64,249,14,76,249,58,77,249,42,78,62,62,71,249,76,77,58,64,62,249,73,72,76,66,77,66,72,71},39))
task.wait(5)
if not enabled then return end
debug(_d({38,72,79,66,71,64,249,77,72,249,73,72,76,77,6,42,78,62,62,71,249,73,72,76,66,77,66,72,71},39))
navToPointConfirmed(COORDS.PostQueen, 30, _d({73,72,76,77,6,42,78,62,62,71,249,73,72,76,66,77,66,72,71},39))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({30,71,58,59,69,66,71,64,5,249,73,72,76,249,27,30,31,40,43,30,249,73,69,58,71,19},39), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({41,69,58,71,249,62,75,75,72,75,19},39), err2) end
end)
debug(_d({30,71,58,59,69,62,61,19},39), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({30,71,58,59,69,62,61,19},39), enabled)
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
if not ok then debug(_d({34,71,73,78,77,27,62,64,58,71,249,62,75,75,72,75,19},39), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({32,58,70,62,249,69,72,58,61,62,61,5,249,58,78,77,72,6,76,77,58,75,77,66,71,64,249,77,65,62,249,73,69,58,71},39))
enableBot()
end)
if not ok then debug(_d({26,78,77,72,76,77,58,75,77,249,62,75,75,72,75,19},39), err) end
end)
debug(_d({37,72,58,61,62,61,249,187,89,109,249,58,78,77,72,6,76,77,58,75,77,66,71,64,249,72,71,60,62,249,77,65,62,249,64,58,70,62,249,63,66,71,66,76,65,62,76,249,69,72,58,61,66,71,64,249,1,73,75,62,76,76,249,41,249,77,72,249,77,72,64,64,69,62,249,70,58,71,78,58,69,69,82,2},39))
end)()