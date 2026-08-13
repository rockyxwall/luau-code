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
local Players            = game:GetService(_d({35,63,52,76,56,69,70},45))
local UserInputService    = game:GetService(_d({40,70,56,69,28,65,67,72,71,38,56,69,73,60,54,56},45))
local RunService          = game:GetService(_d({37,72,65,38,56,69,73,60,54,56},45))
local VIM                 = game:GetService(_d({41,60,69,71,72,52,63,28,65,67,72,71,32,52,65,52,58,56,69},45))
local ReplicatedStorage    = game:GetService(_d({37,56,67,63,60,54,52,71,56,55,38,71,66,69,52,58,56},45))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({46,21,66,70,70,21,66,71,48},45), _d({42,69,66,65,58,243,58,52,64,56,243,181,83,103,243,35,63,52,54,56,28,55,13},45), game.PlaceId, _d({40,65,60,73,56,69,70,56,28,55,13},45), game.GameId, _d({0,243,65,66,71,243,69,72,65,65,60,65,58},45))
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
local LEO_PILLAR_ANIM_ID   = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,8,5,7,7,4,7,4,6,5,10},45)
local LEO_ENTEI_ANIM_ID    = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,8,5,7,7,4,6,11,5,10,11},45)
local LEO_HIKEN_ANIM_ID    = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,8,5,5,3,12,4,10,7,3,10},45)
local LEO_FIREFLY_ANIM_ID  = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,8,5,5,3,5,6,9,4,8,7},45)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({34,53,61,56,54,71,60,73,56,70},45)
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
local REPLAY_BUTTON_VALUE   = _d({37,56,67,63,52,76},45)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({64,66,73,56},45)
local NavState   = {mode = _d({60,55,63,56},45)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({46,21,66,70,70,21,66,71,48},45), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
end)
if ok then return root end
debug(_d({58,56,71,37,66,66,71,243,56,69,69,66,69,13},45), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
end)
if ok then return hum end
debug(_d({58,56,71,27,72,64,52,65,66,60,55,243,56,69,69,66,69,13},45), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({50,50,27,66,73,56,69,20,71,71},45)) or Instance.new(_d({20,71,71,52,54,59,64,56,65,71},45))
att.Name = _d({50,50,27,66,73,56,69,20,71,71},45)
att.Parent = root
local force = root:FindFirstChild(_d({50,50,27,66,73,56,69,25,66,69,54,56},45))
if not force then
force = Instance.new(_d({31,60,65,56,52,69,41,56,63,66,54,60,71,76},45))
force.Name = _d({50,50,27,66,73,56,69,25,66,69,54,56},45)
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
debug(_d({58,56,71,34,69,22,69,56,52,71,56,25,66,69,54,56,243,56,69,69,66,69,13},45), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not root then return end
local force = root:FindFirstChild(_d({50,50,27,66,73,56,69,25,66,69,54,56},45))
local att   = root:FindFirstChild(_d({50,50,27,66,73,56,69,20,71,71},45))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({54,63,56,52,65,72,67,25,66,69,54,56,243,56,69,69,66,69,13},45), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({21,72,70,66,32,56,63,56,56},45)) ~= nil
end)
if ok then return result end
debug(_d({60,70,21,72,70,66,20,54,71,60,73,56,243,56,69,69,66,69,13},45), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({21,72,70,66},45))
end)
if not ok then debug(_d({52,54,71,60,73,52,71,56,21,72,70,66,243,56,69,69,66,69,13},45), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({21,72,70,66,243,65,66,71,243,52,54,71,60,73,56,255,243,52,54,71,60,73,52,71,60,65,58},45))
activateBuso()
end
end)
if not ok then debug(_d({21,72,70,66,30,56,56,67,56,69,243,56,69,69,66,69,13},45), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({21,72,70,66,243,62,56,56,67,56,69,243,70,71,66,67,67,56,55},45))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({30,56,65,27,52,62,60},45)) ~= nil
end)
if ok then return result end
debug(_d({60,70,30,56,65,20,54,71,60,73,56,243,56,69,69,66,69,13},45), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({30,56,65},45), true)
end)
if not ok then debug(_d({52,54,71,60,73,52,71,56,30,56,65,243,56,69,69,66,69,13},45), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({30,56,65,243,65,66,71,243,52,54,71,60,73,56,255,243,52,54,71,60,73,52,71,60,65,58},45))
activateKen()
end
end)
if not ok then debug(_d({30,56,65,30,56,56,67,56,69,243,56,69,69,66,69,13},45), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({30,56,65,243,62,56,56,67,56,69,243,70,71,66,67,67,56,55},45))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({33,35,22,70},45)) end)
if ok then return folder end
debug(_d({58,56,71,33,35,22,70,25,66,63,55,56,69,243,56,69,69,66,69,13},45), folder)
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
local r = model:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local h = model:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
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
debug(_d({58,56,71,33,56,52,69,56,70,71,33,35,22,243,56,69,69,66,69,13},45), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
local hum  = model:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({58,56,71,33,35,22,21,76,33,52,64,56,243,56,69,69,66,69,13},45), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({65,67,54,70,37,56,64,52,60,65,60,65,58,243,56,69,69,66,69,13},45), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({22,72,67,60,55,243,36,72,56,56,65},45))
return queen ~= nil and queen:FindFirstChild(_d({64,66,71,60,66,65,31,56,70,70},45)) ~= nil
end)
if ok then return result end
debug(_d({60,70,36,72,56,56,65,35,59,52,70,56,5,243,56,69,69,66,69,13},45), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,4,5,4,5,12,10,12,7,5,5,12,5,10,9,12},45)
local QUEEN_GRASP_ANIM_ID   = _d({69,53,75,52,70,70,56,71,60,55,13,2,2,4,5,12,11,3,3,3,9,4,3,3,4,10,6,7},45)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
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
debug(_d({60,70,35,63,52,76,60,65,58,20,65,60,64,25,69,66,64,31,60,70,71,243,56,69,69,66,69,13},45), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({21,63,66,54,62,60,65,58},45)) ~= nil
end)
if ok then return result end
debug(_d({60,70,33,35,22,21,63,66,54,62,60,65,58,243,56,69,69,66,69,13},45), result)
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
debug(_d({67,69,56,55,60,54,71,33,35,22,35,66,70,60,71,60,66,65,243,56,69,69,66,69,13},45), result)
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
debug(_d({33,66,243,55,52,64,52,58,56,243,66,65},45), model.Name, _d({57,66,69},45), NPC_STUCK_TIMEOUT, _d({70,243,0,243,70,74,60,71,54,59,60,65,58,243,71,52,69,58,56,71},45))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({71,69,52,54,62,33,35,22,23,52,64,52,58,56,243,56,69,69,66,69,13},45), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({32,66,55,56,63},45)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({21,52,70,56,35,52,69,71},45)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({58,56,71,32,66,55,56,63,25,52,54,56,35,66,70,243,56,69,69,66,69,13},45), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({24,65,73},45))
local folder = env and env:FindFirstChild(_d({38,71,52,71,72,56,70},45))
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
debug(_d({58,56,71,38,71,52,71,72,56,32,66,55,56,63,33,56,52,69,243,56,69,69,66,69,13},45), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({53,52,69,69,56,63,27,35},45))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({58,56,71,38,71,52,71,72,56,27,35,243,56,69,69,66,69,13},45), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({39,66,66,63},45)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({57,60,65,55,39,66,66,63,21,76,20,71,71,69,60,53,72,71,56,243,56,69,69,66,69,13},45), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({39,66,66,63},45)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({57,60,65,55,39,66,66,63,21,76,33,52,64,56,243,56,69,69,66,69,13},45), tool)
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
if not ok then debug(_d({56,68,72,60,67,39,66,66,63,243,56,69,69,66,69,13},45), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({21,52,54,62,67,52,54,62},45))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({39,66,66,63},45)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({57,60,65,55,39,66,66,63,21,76,22,59,60,63,55,33,52,64,56,243,56,69,69,66,69,13},45), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({38,74,66,69,55,24,68,72,60,67},45))
if sword then
equipTool(sword)
return _d({70,74,66,69,55},45)
end
local melee = findToolByAttribute(_d({32,56,63,56,56,39,66,66,63},45))
if melee then
equipTool(melee)
return _d({64,56,63,56,56},45)
end
debug(_d({33,66,243,70,74,66,69,55,243,66,69,243,64,56,63,56,56,243,71,66,66,63,243,57,66,72,65,55},45))
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
if not ok then debug(_d({54,63,60,54,62,32,4,243,56,69,69,66,69,13},45), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({27,72,64,52,65,66,60,55,37,66,66,71,35,52,69,71},45))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({38,71,52,71,70},45) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({37,66,62,72,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({26,56,67,67,66},45), args)
elseif style == _d({21,63,52,54,62,31,56,58},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62},45), args)
elseif style == _d({30,52,64,60,70,59,60,62,60},45) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,52,64,60,70,59,60,62,60,26,56,67,67,66},45), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,62,76,243,42,52,63,62,5},45), args)
end
end)
if not ok then debug(_d({60,65,73,66,62,56,26,56,67,67,66,243,56,69,69,66,69,13},45), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({67,69,56,70,70,38,62,60,63,63,37,243,56,69,69,66,69,13},45), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({59,66,63,55,21,63,66,54,62,243,56,69,69,66,69,13},45), err) end
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
if not ok then debug(_d({59,66,63,55,21,63,66,54,62,42,59,60,63,56,243,56,69,69,66,69,13},45), err) end
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
debug(_d({58,56,71,26,52,64,56,26,243,56,69,69,66,69,13},45), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({60,70,37,56,52,63,32,4,21,72,70,76,243,56,69,69,66,69,13},45), result)
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
return char ~= nil and char:FindFirstChild(_d({70,71,72,65},45)) ~= nil
end)
if ok then return result end
debug(_d({60,70,38,71,72,65,65,56,55,243,56,69,69,66,69,13},45), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({67,69,56,70,70,38,71,72,65,21,69,56,52,62,243,56,69,69,66,69,13},45), err) end
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
debug(_d({68,72,56,56,65,23,66,55,58,56,40,65,71,60,63,38,52,57,56,13,243,36,72,56,56,65,243,58,66,65,56,243,0,243,56,65,55,60,65,58,243,55,66,55,58,56,243,56,52,69,63,76},45))
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
debug(_d({68,72,56,56,65,23,66,55,58,56,40,65,71,60,63,38,52,57,56,243,70,52,57,56,71,76,243,71,60,64,56,66,72,71},45))
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
local info = getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({36,72,56,56,65,243,54,52,70,71,60,65,58,243,55,56,71,56,54,71,56,55,243,0,243,55,66,55,58,60,65,58,243,251,74,52,71,54,59,56,69,252},45))
queenDodgeUntilSafe(function() return getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45)) end)
if enabled and getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45)) then
setNavNamed(_d({22,72,67,60,55,243,36,72,56,56,65},45))
end
queenDodging = false
end
end)
if not ok then debug(_d({68,72,56,56,65,23,66,55,58,56,42,52,71,54,59,56,69,243,56,69,69,66,69,13},45), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({67,66,60,65,71},45) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({65,67,54},45) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({65,52,64,56,55},45) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({58,56,71,33,52,73,39,52,69,58,56,71,70,243,56,69,69,66,69,13},45), aimR)
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
debug(_d({54,66,64,67,72,71,56,31,66,54,62,56,55,22,25,69,52,64,56,243,56,69,69,66,69,13},45), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({67,66,60,65,71},45), point = pos}
phase = _d({64,66,73,56},45)
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
if not ok then debug(_d({65,52,73,39,66,35,66,60,65,71,243,58,56,67,67,66,243,54,59,56,54,62,243,56,69,69,66,69,13},45), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({65,67,54},45)}
phase = _d({64,66,73,56},45)
end
function setNavNamed(name)
NavState = {mode = _d({65,52,64,56,55},45), name = name}
phase = _d({64,66,73,56},45)
end
local function setNavIdle()
NavState = {mode = _d({60,55,63,56},45)}
phase = _d({64,66,73,56},45)
end
local function hasArrived()
return phase == _d({59,66,73,56,69},45)
end
local function startNav()
phase = _d({64,66,73,56},45)
debug(_d({33,52,73,243,63,66,66,67,243,34,33},45))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({35,63,52,76,56,69,243,55,60,56,55,244,243,38,71,66,67,67,60,65,58,243,53,66,71,1},45))
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
local prevPos = force:GetAttribute(_d({50,50,67,69,56,73,35,66,70},45))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({31,52,69,58,56,243,67,66,70,60,71,60,66,65,243,61,72,64,67,243,55,56,71,56,54,71,56,55,13},45), delta, _d({70,71,72,55,70,1,243,67,69,56,73,35,66,70,16},45), prevPos, _d({65,56,74,35,66,70,16},45), pos)
end
end
force:SetAttribute(_d({50,50,67,69,56,73,35,66,70},45), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({64,66,73,56},45) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({59,66,73,56,69},45)
debug(_d({35,59,52,70,56,13,243,59,66,73,56,69},45))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({244,244,244,243,37,24,25,40,38,28,33,26,243,39,34,243,20,35,35,31,44,243,20,21,33,34,37,32,20,31,243,41,24,31,34,22,28,39,44,13},45), finalVel, _d({52,60,64,16},45), aim, _d({67,66,70,16},45), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({59,66,73,56,69},45) then
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
debug(_d({22,66,64,53,52,71,243,63,66,54,62,243,70,62,60,67,67,56,55,255},45), snapDist, _d({70,71,72,55,70,243,57,69,66,64,243,71,52,69,58,56,71,243,181,83,103,243,57,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,64,66,73,56},45))
phase = _d({64,66,73,56},45)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({27,56,52,69,71,53,56,52,71,243,56,69,69,66,69,13},45), err) end
end)
end
local function stopNav()
debug(_d({33,52,73,243,63,66,66,67,243,34,25,25},45))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({64,66,73,56},45)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({39,56,75,71,22,59,52,71,38,56,69,73,60,54,56},45))
local channels = TextChatService:FindFirstChild(_d({39,56,75,71,22,59,52,65,65,56,63,70},45))
local channel = channels and channels:FindFirstChild(_d({37,21,43,26,56,65,56,69,52,63},45))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({23,56,57,52,72,63,71,22,59,52,71,38,76,70,71,56,64,22,59,52,71,24,73,56,65,71,70},45))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({38,52,76,32,56,70,70,52,58,56,37,56,68,72,56,70,71},45))
if sayEvent then
sayEvent:FireServer(message, _d({20,63,63},45))
return
end
debug(_d({70,56,65,55,22,59,52,71,32,56,70,70,52,58,56,13,243,65,66,243,39,56,75,71,22,59,52,71,38,56,69,73,60,54,56,1,37,21,43,26,56,65,56,69,52,63,243,66,69,243,63,56,58,52,54,76,243,38,52,76,32,56,70,70,52,58,56,37,56,68,72,56,70,71,243,57,66,72,65,55,243,57,66,69},45), message)
end)
if not ok then debug(_d({70,56,65,55,22,59,52,71,32,56,70,70,52,58,56,243,56,69,69,66,69,13},45), err) end
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
debug(_d({33,66,71,243,64,52,62,60,65,58,243,67,69,66,58,69,56,70,70,243,71,66,74,52,69,55,243,65,52,73,243,71,52,69,58,56,71,243,57,66,69},45), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({70,243,0,243,70,56,65,55,60,65,58,243,2,72,65,70,71,72,54,62},45))
sendChatMessage(_d({2,72,65,70,71,72,54,62},45))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({74,52,60,71,40,65,71,60,63,20,69,69,60,73,56,55,243,71,60,64,56,66,72,71},45))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({65,52,73,39,66,35,66,60,65,71,22,66,65,57,60,69,64,56,55,13},45), label or _d({71,52,69,58,56,71},45), _d({0,243,55,60,55,243,65,66,71,243,52,69,69,60,73,56,243,74,60,71,59,60,65},45), timeout, _d({70,255,243,69,56,71,69,76,60,65,58,243,66,65,54,56},45))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({65,52,73,39,66,35,66,60,65,71,22,66,65,57,60,69,64,56,55,13},45), label or _d({71,52,69,58,56,71},45), _d({0,243,70,71,60,63,63,243,65,66,71,243,52,69,69,60,73,56,55,243,52,57,71,56,69,243,69,56,71,69,76,255,243,67,69,66,54,56,56,55,60,65,58,243,52,65,76,74,52,76},45))
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
if not ok then debug(_d({65,52,73,39,66,35,66,60,65,71,27,66,63,55,60,65,58,21,63,66,54,62,243,62,56,76,0,55,66,74,65,243,56,69,69,66,69,13},45), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({65,52,73,39,66,35,66,60,65,71,27,66,63,55,60,65,58,21,63,66,54,62,243,62,56,76,0,72,67,243,56,69,69,66,69,13},45), err2) end
end
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({42,52,63,62,60,65,58,243,71,66,13},45), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({74,52,63,62,39,66,35,66,60,65,71,243,42,243,55,66,74,65,243,56,69,69,66,69,13},45), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({20,69,69,60,73,56,55,243,52,71,13},45), pos)
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
local function clearStage(stageName)
debug(_d({32,66,73,60,65,58,243,71,66},45), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({42,52,60,71,60,65,58,243,57,66,69,243,33,35,22,70,243,71,66,243,70,67,52,74,65,243,52,71},45), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({243,243,70,67,52,74,65,243,54,59,56,54,62,13,243,57,66,63,55,56,69,243,56,75,60,70,71,70,243,16},45), folder ~= nil,
_d({255,243,54,59,60,63,55,69,56,65,243,16},45), folder and #folder:GetChildren() or 0,
_d({255,243,52,63,60,73,56,243,16},45), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({33,66,243,33,35,22,70,243,52,67,67,56,52,69,56,55,243,52,71},45), stageName, _d({52,57,71,56,69,243,4,8,70,255,243,64,66,73,60,65,58,243,66,65,243,52,65,76,74,52,76},45))
break
end
end
debug(_d({30,60,63,63,60,65,58,243,33,35,22,70,243,52,71},45), stageName)
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
debug(_d({37,56,71,72,69,65,60,65,58,243,71,66},45), stageName, _d({67,66,70,60,71,60,66,65,243,53,56,57,66,69,56,243,64,66,73,60,65,58,243,66,65},45))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({42,52,60,71,60,65,58,243,8,70,243,52,71},45), stageName, _d({67,66,70,60,71,60,66,65},45))
task.wait(5)
debug(_d({42,52,60,71,60,65,58,243,57,66,69,243,12,8,248,243,27,35,243,53,56,57,66,69,56,243,64,66,73,60,65,58,243,71,66,243,65,56,75,71,243,70,71,52,58,56},45))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * 0.95 do
task.wait(1)
end
end
debug(stageName, _d({54,63,56,52,69,56,55},45))
end
local function killNamedNPC(name, targetPos)
debug(_d({32,66,73,60,65,58,243,71,66},45), name)
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
debug(name, _d({55,56,57,56,52,71,56,55},45))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({27,72,64,52,65,66,60,55},45))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({31,56,66,243,67,63,52,76,56,55,243,52,65,60,64,52,71,60,66,65,13},45), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({63,56,66,20,65,60,64,31,66,58,58,56,69,243,67,69,60,65,71,243,56,69,69,66,69,13},45), err2) end
end)
end)
if not ok then debug(_d({70,71,52,69,71,31,56,66,20,65,60,64,31,66,58,58,56,69,243,56,69,69,66,69,13},45), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({32,66,73,60,65,58,243,71,66,243,31,56,66},45))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({31,56,66},45))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({31,56,66},45))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({31,56,66},45))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({31,56,66,243,54,52,70,71,60,65,58},45), which, _d({0,243,55,66,55,58,60,65,58},45))
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
if not getNPCByName(_d({31,56,66},45)) then
debug(_d({31,56,66,243,58,66,65,56,243,64,60,55,0,55,66,55,58,56,243,0,243,56,65,55,60,65,58,243,24,65,71,56,60,243,59,66,63,55,243,56,52,69,63,76},45))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({31,56,66},45)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({31,56,66,243,58,66,65,56,243,64,60,55,0,55,66,55,58,56,243,0,243,56,65,55,60,65,58,243,25,63,52,64,56,243,35,60,63,63,52,69,243,59,66,63,55,243,56,52,69,63,76},45))
end
end
end
if enabled and getNPCByName(_d({31,56,66},45)) then
setNavNamed(_d({31,56,66},45))
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
debug(_d({31,56,66,243,55,56,57,56,52,71,56,55},45))
stopLeoAnimLogger()
debug(_d({37,56,71,72,69,65,60,65,58,243,71,66,243,31,56,66,243,67,66,70,60,71,60,66,65,243,53,56,57,66,69,56,243,64,66,73,60,65,58,243,66,65},45))
navToPointConfirmed(COORDS.Leo, 30, _d({31,56,66,243,67,66,70,60,71,60,66,65},45))
debug(_d({42,52,60,71,60,65,58,243,8,70,243,52,71,243,31,56,66,243,67,66,70,60,71,60,66,65},45))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({32,66,73,60,65,58,243,71,66},45), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({22,66,72,63,55,243,65,66,71,243,57,60,65,55,243,70,71,52,71,72,56,243,64,66,55,56,63,243,65,56,52,69},45), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({20,71,71,52,54,62,60,65,58},45), coordKey, _d({74,60,71,59},45), weapon or _d({65,66,71,59,60,65,58,243,57,66,72,65,55},45))
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
debug(coordKey, _d({53,52,69,69,56,63,243,55,56,70,71,69,66,76,56,55},45))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({69,56,54,59,56,54,62,38,71,52,71,72,56,13},45), coordKey, _d({0,243,54,66,72,63,55,243,65,66,71,243,57,60,65,55,243,70,71,52,71,72,56,243,64,66,55,56,63,255,243,70,62,60,67,67,60,65,58},45))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({69,56,54,59,56,54,62,38,71,52,71,72,56,13},45), coordKey, _d({70,71,60,63,63,243,52,63,60,73,56,243,251,27,35},45), hp, _d({252,243,0,243,69,56,0,55,56,70,71,69,66,76,60,65,58},45))
destroyStatue(coordKey)
else
debug(_d({69,56,54,59,56,54,62,38,71,52,71,72,56,13},45), coordKey, _d({54,66,65,57,60,69,64,56,55,243,55,56,70,71,69,66,76,56,55},45))
end
end)
if not ok then debug(_d({69,56,54,59,56,54,62,38,71,52,71,72,56,243,56,69,69,66,69,13},45), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({32,66,73,60,65,58,243,71,66,243,36,72,56,56,65},45))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({22,72,67,60,55,243,36,72,56,56,65},45))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45))
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
debug(_d({36,72,56,56,65,243,56,65,71,56,69,56,55,243,67,59,52,70,56,243,5},45))
end
local function finishQueen()
debug(_d({25,60,65,60,70,59,60,65,58,243,36,72,56,56,65},45))
equipSwordOrMelee()
setNavNamed(_d({22,72,67,60,55,243,36,72,56,56,65},45))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({22,72,67,60,55,243,36,72,56,56,65},45))
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
debug(_d({36,72,56,56,65,243,55,56,57,56,52,71,56,55,1,243,35,63,52,65,243,54,66,64,67,63,56,71,56,1},45))
end
local CONFIRMATION_PROMPT_NAME = _d({22,66,65,57,60,69,64,52,71,60,66,65,35,69,66,64,67,71},45)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({37,56,64,66,71,56,24,73,56,65,71},45), 5)
end)
if ok then return result end
debug(_d({58,56,71,37,56,67,63,52,76,37,56,64,66,71,56,243,56,69,69,66,69,13},45), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({35,63,52,76,56,69,26,72,60},45))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({28,64,52,58,56,21,72,71,71,66,65},45)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({53,72,71,71,66,65,41,52,63,72,56},45)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({57,60,65,55,21,72,71,71,66,65,21,76,41,52,63,72,56,243,56,69,69,66,69,13},45), result)
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
if not ok then debug(_d({54,63,60,54,62,26,72,60,21,72,71,71,66,65,243,56,69,69,66,69,13},45), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({60,70,38,56,69,73,56,69},45))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({37,56,64,66,71,56,24,73,56,65,71},45))
or inst:FindFirstChild(_d({54,63,60,56,65,71,24,73,56,65,71},45))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({57,60,65,55,20,65,70,74,56,69,22,66,65,65,56,54,71,66,69,243,56,69,69,66,69,13},45), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({22,66,72,63,55,243,65,66,71,243,63,66,54,52,71,56,243,37,56,64,66,71,56,24,73,56,65,71,2,54,63,60,56,65,71,24,73,56,65,71,243,65,56,52,69,243,37,56,67,63,52,76,243,53,72,71,71,66,65,255,243,57,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,54,63,60,54,62},45))
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
debug(_d({57,60,69,56,37,56,67,63,52,76,41,52,63,72,56,243,56,69,69,66,69,13},45), err, _d({0,243,57,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,54,63,60,54,62},45))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({25,52,63,63,60,65,58,243,53,52,54,62,243,71,66,243,53,72,71,71,66,65,41,52,63,72,56,243,70,56,52,69,54,59,243,57,66,69,243,37,56,67,63,52,76},45))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({37,56,67,63,52,76,243,53,72,71,71,66,65,243,65,66,71,243,57,66,72,65,55,243,56,60,71,59,56,69,255,243,58,60,73,60,65,58,243,72,67},45))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({42,52,60,71,60,65,58,243,57,66,69,243,22,66,65,57,60,69,64,52,71,60,66,65,35,69,66,64,67,71,1,37,56,64,66,71,56,24,73,56,65,71},45))
local remote = getReplayRemote()
if not remote then
debug(_d({22,66,65,57,60,69,64,52,71,60,66,65,35,69,66,64,67,71,2,37,56,64,66,71,56,24,73,56,65,71,243,65,66,71,243,57,66,72,65,55,243,74,60,71,59,60,65,243,71,60,64,56,66,72,71},45))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({25,60,69,60,65,58,243,37,56,67,63,52,76,243,73,60,52,243,22,66,65,57,60,69,64,52,71,60,66,65,35,69,66,64,67,71,1,37,56,64,66,71,56,24,73,56,65,71},45))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({25,60,69,56,38,56,69,73,56,69,243,56,69,69,66,69,13},45), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({35,63,52,76,56,69,26,72,60},45), 10)
if not playerGui then
debug(_d({74,52,60,71,25,66,69,34,53,61,56,54,71,60,73,56,70,26,72,60,13,243,65,66,243,35,63,52,76,56,69,26,72,60,243,74,60,71,59,60,65,243,71,60,64,56,66,72,71,255,243,67,69,66,54,56,56,55,60,65,58,243,52,65,76,74,52,76},45))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({34,53,61,56,54,71,60,73,56,70,243,26,40,28,243,57,66,72,65,55,243,0,243,70,71,52,58,56,243,63,66,52,55,56,55},45))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({34,53,61,56,54,71,60,73,56,70,243,26,40,28,243,65,66,71,243,57,66,72,65,55,243,74,60,71,59,60,65,243,71,60,64,56,66,72,71,255,243,67,69,66,54,56,56,55,60,65,58,243,52,65,76,74,52,76},45))
return
end
end
end)
if not ok then debug(_d({74,52,60,71,25,66,69,34,53,61,56,54,71,60,73,56,70,26,72,60,243,56,69,69,66,69,13},45), err) end
end
local function runPlan()
debug(_d({35,63,52,65,243,70,71,52,69,71,56,55},45))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({38,71,52,69,71,60,65,58,243,65,52,73,243,63,66,66,67},45))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({67,66,70,243,3,1,5,70,243,20,25,39,24,37,243,70,71,52,69,71,33,52,73,13},45), rootAfter and rootAfter.Position)
end)
debug(_d({42,52,60,71,60,65,58,243,8,70,243,53,56,57,66,69,56,243,64,66,73,60,65,58,243,71,66,243,38,71,52,58,56,4},45))
task.wait(5)
for _, stage in ipairs({_d({38,71,52,58,56,4},45), _d({38,71,52,58,56,5},45), _d({38,71,52,58,56,6},45), _d({38,71,52,58,56,6,21},45)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({32,66,73,60,65,58,243,71,66,243,52,69,69,66,74,243,57,63,76,0,55,66,74,65,243,52,69,56,52},45))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
walkToPoint(COORDS.ArrowFlyDown, 30)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({23,66,55,58,60,65,58,243,52,69,69,66,74,243,69,52,60,65},45))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({38,71,52,58,56,7},45))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({36,72,56,56,65,243,60,65,243,67,59,52,70,56,243,5,243,0,243,62,56,56,67,60,65,58,243,30,56,65,243,27,52,62,60,243,52,54,71,60,73,56,243,57,69,66,64,243,59,56,69,56,243,66,65},45))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({38,71,52,71,72,56,4},45))
if not enabled then return end
recheckStatue(_d({38,71,52,71,72,56,4},45))
destroyStatue(_d({38,71,52,71,72,56,5},45))
if not enabled then return end
recheckStatue(_d({38,71,52,71,72,56,4},45))
recheckStatue(_d({38,71,52,71,72,56,5},45))
destroyStatue(_d({38,71,52,71,72,56,6},45))
if not enabled then return end
recheckStatue(_d({38,71,52,71,72,56,6},45))
recheckStatue(_d({38,71,52,71,72,56,5},45))
recheckStatue(_d({38,71,52,71,72,56,4},45))
if not enabled then return end
debug(_d({42,52,60,71,60,65,58,243,57,66,69,243,67,59,52,70,56,243,5,243,71,66,243,56,65,55},45))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({35,59,52,70,56,243,5,243,56,65,55,243,74,52,60,71,243,71,60,64,56,66,72,71,255,243,67,69,66,54,56,56,55,60,65,58,243,52,65,76,74,52,76},45))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({32,66,73,60,65,58,243,53,52,54,62,243,71,66,243,36,72,56,56,65,243,70,71,52,58,56,243,67,66,70,60,71,60,66,65},45))
navToPointConfirmed(COORDS.Queen, 30, _d({36,72,56,56,65,243,70,71,52,58,56,243,67,66,70,60,71,60,66,65},45))
debug(_d({42,52,60,71,60,65,58,243,8,70,243,52,71,243,36,72,56,56,65,243,70,71,52,58,56,243,67,66,70,60,71,60,66,65},45))
task.wait(5)
if not enabled then return end
debug(_d({32,66,73,60,65,58,243,71,66,243,67,66,70,71,0,36,72,56,56,65,243,67,66,70,60,71,60,66,65},45))
navToPointConfirmed(COORDS.PostQueen, 30, _d({67,66,70,71,0,36,72,56,56,65,243,67,66,70,60,71,60,66,65},45))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({24,65,52,53,63,60,65,58,255,243,67,66,70,243,21,24,25,34,37,24,243,67,63,52,65,13},45), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({35,63,52,65,243,56,69,69,66,69,13},45), err2) end
end)
debug(_d({24,65,52,53,63,56,55,13},45), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({24,65,52,53,63,56,55,13},45), enabled)
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
if not ok then debug(_d({28,65,67,72,71,21,56,58,52,65,243,56,69,69,66,69,13},45), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({26,52,64,56,243,63,66,52,55,56,55,255,243,52,72,71,66,0,70,71,52,69,71,60,65,58,243,71,59,56,243,67,63,52,65},45))
enableBot()
end)
if not ok then debug(_d({20,72,71,66,70,71,52,69,71,243,56,69,69,66,69,13},45), err) end
end)
debug(_d({31,66,52,55,56,55,243,181,83,103,243,52,72,71,66,0,70,71,52,69,71,60,65,58,243,66,65,54,56,243,71,59,56,243,58,52,64,56,243,57,60,65,60,70,59,56,70,243,63,66,52,55,60,65,58,243,251,67,69,56,70,70,243,35,243,71,66,243,71,66,58,58,63,56,243,64,52,65,72,52,63,63,76,252},45))
end)()