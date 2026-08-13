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
local Players            = game:GetService(_d({55,83,72,96,76,89,90},25))
local UserInputService    = game:GetService(_d({60,90,76,89,48,85,87,92,91,58,76,89,93,80,74,76},25))
local RunService          = game:GetService(_d({57,92,85,58,76,89,93,80,74,76},25))
local VIM                 = game:GetService(_d({61,80,89,91,92,72,83,48,85,87,92,91,52,72,85,72,78,76,89},25))
local ReplicatedStorage    = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({66,41,86,90,90,41,86,91,68},25), _d({62,89,86,85,78,7,78,72,84,76,7,201,103,123,7,55,83,72,74,76,48,75,33},25), game.PlaceId, _d({60,85,80,93,76,89,90,76,48,75,33},25), game.GameId, _d({20,7,85,86,91,7,89,92,85,85,80,85,78},25))
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
local LEO_PILLAR_ANIM_ID   = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,28,25,27,27,24,27,24,26,25,30},25)
local LEO_ENTEI_ANIM_ID    = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,28,25,27,27,24,26,31,25,30,31},25)
local LEO_HIKEN_ANIM_ID    = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,28,25,25,23,32,24,30,27,23,30},25)
local LEO_FIREFLY_ANIM_ID  = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,28,25,25,23,25,26,29,24,28,27},25)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({54,73,81,76,74,91,80,93,76,90},25)
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
local REPLAY_BUTTON_VALUE   = _d({57,76,87,83,72,96},25)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({84,86,93,76},25)
local NavState   = {mode = _d({80,75,83,76},25)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({66,41,86,90,90,41,86,91,68},25), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
end)
if ok then return root end
debug(_d({78,76,91,57,86,86,91,7,76,89,89,86,89,33},25), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
end)
if ok then return hum end
debug(_d({78,76,91,47,92,84,72,85,86,80,75,7,76,89,89,86,89,33},25), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({70,70,47,86,93,76,89,40,91,91},25)) or Instance.new(_d({40,91,91,72,74,79,84,76,85,91},25))
att.Name = _d({70,70,47,86,93,76,89,40,91,91},25)
att.Parent = root
local force = root:FindFirstChild(_d({70,70,47,86,93,76,89,45,86,89,74,76},25))
if not force then
force = Instance.new(_d({51,80,85,76,72,89,61,76,83,86,74,80,91,96},25))
force.Name = _d({70,70,47,86,93,76,89,45,86,89,74,76},25)
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
debug(_d({78,76,91,54,89,42,89,76,72,91,76,45,86,89,74,76,7,76,89,89,86,89,33},25), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not root then return end
local force = root:FindFirstChild(_d({70,70,47,86,93,76,89,45,86,89,74,76},25))
local att   = root:FindFirstChild(_d({70,70,47,86,93,76,89,40,91,91},25))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({74,83,76,72,85,92,87,45,86,89,74,76,7,76,89,89,86,89,33},25), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({41,92,90,86,52,76,83,76,76},25)) ~= nil
end)
if ok then return result end
debug(_d({80,90,41,92,90,86,40,74,91,80,93,76,7,76,89,89,86,89,33},25), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({41,92,90,86},25))
end)
if not ok then debug(_d({72,74,91,80,93,72,91,76,41,92,90,86,7,76,89,89,86,89,33},25), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({41,92,90,86,7,85,86,91,7,72,74,91,80,93,76,19,7,72,74,91,80,93,72,91,80,85,78},25))
activateBuso()
end
end)
if not ok then debug(_d({41,92,90,86,50,76,76,87,76,89,7,76,89,89,86,89,33},25), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({41,92,90,86,7,82,76,76,87,76,89,7,90,91,86,87,87,76,75},25))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({50,76,85,47,72,82,80},25)) ~= nil
end)
if ok then return result end
debug(_d({80,90,50,76,85,40,74,91,80,93,76,7,76,89,89,86,89,33},25), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({50,76,85},25), true)
end)
if not ok then debug(_d({72,74,91,80,93,72,91,76,50,76,85,7,76,89,89,86,89,33},25), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({50,76,85,7,85,86,91,7,72,74,91,80,93,76,19,7,72,74,91,80,93,72,91,80,85,78},25))
activateKen()
end
end)
if not ok then debug(_d({50,76,85,50,76,76,87,76,89,7,76,89,89,86,89,33},25), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({50,76,85,7,82,76,76,87,76,89,7,90,91,86,87,87,76,75},25))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({53,55,42,90},25)) end)
if ok then return folder end
debug(_d({78,76,91,53,55,42,90,45,86,83,75,76,89,7,76,89,89,86,89,33},25), folder)
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
local r = model:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local h = model:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
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
debug(_d({78,76,91,53,76,72,89,76,90,91,53,55,42,7,76,89,89,86,89,33},25), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
local hum  = model:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({78,76,91,53,55,42,41,96,53,72,84,76,7,76,89,89,86,89,33},25), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({85,87,74,90,57,76,84,72,80,85,80,85,78,7,76,89,89,86,89,33},25), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({42,92,87,80,75,7,56,92,76,76,85},25))
return queen ~= nil and queen:FindFirstChild(_d({84,86,91,80,86,85,51,76,90,90},25)) ~= nil
end)
if ok then return result end
debug(_d({80,90,56,92,76,76,85,55,79,72,90,76,25,7,76,89,89,86,89,33},25), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,24,25,24,25,32,30,32,27,25,25,32,25,30,29,32},25)
local QUEEN_GRASP_ANIM_ID   = _d({89,73,95,72,90,90,76,91,80,75,33,22,22,24,25,32,31,23,23,23,29,24,23,23,24,30,26,27},25)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
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
debug(_d({80,90,55,83,72,96,80,85,78,40,85,80,84,45,89,86,84,51,80,90,91,7,76,89,89,86,89,33},25), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({41,83,86,74,82,80,85,78},25)) ~= nil
end)
if ok then return result end
debug(_d({80,90,53,55,42,41,83,86,74,82,80,85,78,7,76,89,89,86,89,33},25), result)
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
debug(_d({87,89,76,75,80,74,91,53,55,42,55,86,90,80,91,80,86,85,7,76,89,89,86,89,33},25), result)
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
debug(_d({53,86,7,75,72,84,72,78,76,7,86,85},25), model.Name, _d({77,86,89},25), NPC_STUCK_TIMEOUT, _d({90,7,20,7,90,94,80,91,74,79,80,85,78,7,91,72,89,78,76,91},25))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({91,89,72,74,82,53,55,42,43,72,84,72,78,76,7,76,89,89,86,89,33},25), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({52,86,75,76,83},25)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({41,72,90,76,55,72,89,91},25)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({78,76,91,52,86,75,76,83,45,72,74,76,55,86,90,7,76,89,89,86,89,33},25), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({44,85,93},25))
local folder = env and env:FindFirstChild(_d({58,91,72,91,92,76,90},25))
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
debug(_d({78,76,91,58,91,72,91,92,76,52,86,75,76,83,53,76,72,89,7,76,89,89,86,89,33},25), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({73,72,89,89,76,83,47,55},25))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({78,76,91,58,91,72,91,92,76,47,55,7,76,89,89,86,89,33},25), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({59,86,86,83},25)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({77,80,85,75,59,86,86,83,41,96,40,91,91,89,80,73,92,91,76,7,76,89,89,86,89,33},25), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({59,86,86,83},25)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({77,80,85,75,59,86,86,83,41,96,53,72,84,76,7,76,89,89,86,89,33},25), tool)
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
if not ok then debug(_d({76,88,92,80,87,59,86,86,83,7,76,89,89,86,89,33},25), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({41,72,74,82,87,72,74,82},25))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({59,86,86,83},25)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({77,80,85,75,59,86,86,83,41,96,42,79,80,83,75,53,72,84,76,7,76,89,89,86,89,33},25), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({58,94,86,89,75,44,88,92,80,87},25))
if sword then
equipTool(sword)
return _d({90,94,86,89,75},25)
end
local melee = findToolByAttribute(_d({52,76,83,76,76,59,86,86,83},25))
if melee then
equipTool(melee)
return _d({84,76,83,76,76},25)
end
debug(_d({53,86,7,90,94,86,89,75,7,86,89,7,84,76,83,76,76,7,91,86,86,83,7,77,86,92,85,75},25))
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
if not ok then debug(_d({74,83,80,74,82,52,24,7,76,89,89,86,89,33},25), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({47,92,84,72,85,86,80,75,57,86,86,91,55,72,89,91},25))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({58,91,72,91,90},25) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({57,86,82,92,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,76,87,87,86},25), args)
elseif style == _d({41,83,72,74,82,51,76,78},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82},25), args)
elseif style == _d({50,72,84,80,90,79,80,82,80},25) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,72,84,80,90,79,80,82,80,46,76,87,87,86},25), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({58,82,96,7,62,72,83,82,25},25), args)
end
end)
if not ok then debug(_d({80,85,93,86,82,76,46,76,87,87,86,7,76,89,89,86,89,33},25), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({87,89,76,90,90,58,82,80,83,83,57,7,76,89,89,86,89,33},25), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({79,86,83,75,41,83,86,74,82,7,76,89,89,86,89,33},25), err) end
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
if not ok then debug(_d({79,86,83,75,41,83,86,74,82,62,79,80,83,76,7,76,89,89,86,89,33},25), err) end
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
debug(_d({78,76,91,46,72,84,76,46,7,76,89,89,86,89,33},25), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({80,90,57,76,72,83,52,24,41,92,90,96,7,76,89,89,86,89,33},25), result)
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
return char ~= nil and char:FindFirstChild(_d({90,91,92,85},25)) ~= nil
end)
if ok then return result end
debug(_d({80,90,58,91,92,85,85,76,75,7,76,89,89,86,89,33},25), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({87,89,76,90,90,58,91,92,85,41,89,76,72,82,7,76,89,89,86,89,33},25), err) end
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
debug(_d({88,92,76,76,85,43,86,75,78,76,60,85,91,80,83,58,72,77,76,33,7,56,92,76,76,85,7,78,86,85,76,7,20,7,76,85,75,80,85,78,7,75,86,75,78,76,7,76,72,89,83,96},25))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({88,92,76,76,85,43,86,75,78,76,60,85,91,80,83,58,72,77,76,7,90,72,77,76,91,96,7,91,80,84,76,86,92,91},25))
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
local info = getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({56,92,76,76,85,7,74,72,90,91,80,85,78,7,75,76,91,76,74,91,76,75,7,20,7,75,86,75,78,80,85,78,7,15,94,72,91,74,79,76,89,16},25))
queenDodgeUntilSafe(function() return getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25)) end)
if enabled and getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25)) then
setNavNamed(_d({42,92,87,80,75,7,56,92,76,76,85},25))
end
queenDodging = false
end
end)
if not ok then debug(_d({88,92,76,76,85,43,86,75,78,76,62,72,91,74,79,76,89,7,76,89,89,86,89,33},25), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({87,86,80,85,91},25) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({85,87,74},25) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({85,72,84,76,75},25) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({78,76,91,53,72,93,59,72,89,78,76,91,90,7,76,89,89,86,89,33},25), aimR)
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
debug(_d({74,86,84,87,92,91,76,51,86,74,82,76,75,42,45,89,72,84,76,7,76,89,89,86,89,33},25), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({87,86,80,85,91},25), point = pos}
phase = _d({84,86,93,76},25)
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
if not ok then debug(_d({85,72,93,59,86,55,86,80,85,91,7,78,76,87,87,86,7,74,79,76,74,82,7,76,89,89,86,89,33},25), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({85,87,74},25)}
phase = _d({84,86,93,76},25)
end
function setNavNamed(name)
NavState = {mode = _d({85,72,84,76,75},25), name = name}
phase = _d({84,86,93,76},25)
end
local function setNavIdle()
NavState = {mode = _d({80,75,83,76},25)}
phase = _d({84,86,93,76},25)
end
local function hasArrived()
return phase == _d({79,86,93,76,89},25)
end
local function startNav()
phase = _d({84,86,93,76},25)
debug(_d({53,72,93,7,83,86,86,87,7,54,53},25))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({55,83,72,96,76,89,7,75,80,76,75,8,7,58,91,86,87,87,80,85,78,7,73,86,91,21},25))
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
debug(_d({55,83,72,96,76,89,7,80,90,7,91,86,86,7,77,72,89,7,77,89,86,84,7,91,72,89,78,76,91,7,15,37,25,23,23,23,7,90,91,92,75,90,16,21,7,51,80,82,76,83,96,7,89,76,90,87,72,94,85,76,75,7,72,91,7,83,86,73,73,96,21,7,58,91,86,87,87,80,85,78,7,73,86,91,21},25))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({70,70,87,89,76,93,55,86,90},25))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({51,72,89,78,76,7,87,86,90,80,91,80,86,85,7,81,92,84,87,7,75,76,91,76,74,91,76,75,33},25), delta, _d({90,91,92,75,90,21,7,87,89,76,93,55,86,90,36},25), prevPos, _d({85,76,94,55,86,90,36},25), pos)
end
end
force:SetAttribute(_d({70,70,87,89,76,93,55,86,90},25), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({84,86,93,76},25) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({79,86,93,76,89},25)
debug(_d({55,79,72,90,76,33,7,79,86,93,76,89},25))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({8,8,8,7,57,44,45,60,58,48,53,46,7,59,54,7,40,55,55,51,64,7,40,41,53,54,57,52,40,51,7,61,44,51,54,42,48,59,64,33},25), finalVel, _d({72,80,84,36},25), aim, _d({87,86,90,36},25), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({79,86,93,76,89},25) then
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
debug(_d({42,86,84,73,72,91,7,83,86,74,82,7,90,82,80,87,87,76,75,19},25), snapDist, _d({90,91,92,75,90,7,77,89,86,84,7,91,72,89,78,76,91,7,201,103,123,7,77,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,84,86,93,76},25))
phase = _d({84,86,93,76},25)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({47,76,72,89,91,73,76,72,91,7,76,89,89,86,89,33},25), err) end
end)
end
local function stopNav()
debug(_d({53,72,93,7,83,86,86,87,7,54,45,45},25))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({84,86,93,76},25)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({59,76,95,91,42,79,72,91,58,76,89,93,80,74,76},25))
local channels = TextChatService:FindFirstChild(_d({59,76,95,91,42,79,72,85,85,76,83,90},25))
local channel = channels and channels:FindFirstChild(_d({57,41,63,46,76,85,76,89,72,83},25))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({43,76,77,72,92,83,91,42,79,72,91,58,96,90,91,76,84,42,79,72,91,44,93,76,85,91,90},25))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({58,72,96,52,76,90,90,72,78,76,57,76,88,92,76,90,91},25))
if sayEvent then
sayEvent:FireServer(message, _d({40,83,83},25))
return
end
debug(_d({90,76,85,75,42,79,72,91,52,76,90,90,72,78,76,33,7,85,86,7,59,76,95,91,42,79,72,91,58,76,89,93,80,74,76,21,57,41,63,46,76,85,76,89,72,83,7,86,89,7,83,76,78,72,74,96,7,58,72,96,52,76,90,90,72,78,76,57,76,88,92,76,90,91,7,77,86,92,85,75,7,77,86,89},25), message)
end)
if not ok then debug(_d({90,76,85,75,42,79,72,91,52,76,90,90,72,78,76,7,76,89,89,86,89,33},25), err) end
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
debug(_d({53,86,91,7,84,72,82,80,85,78,7,87,89,86,78,89,76,90,90,7,91,86,94,72,89,75,7,85,72,93,7,91,72,89,78,76,91,7,77,86,89},25), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({90,7,20,7,90,76,85,75,80,85,78,7,22,92,85,90,91,92,74,82},25))
sendChatMessage(_d({22,92,85,90,91,92,74,82},25))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({94,72,80,91,60,85,91,80,83,40,89,89,80,93,76,75,7,91,80,84,76,86,92,91},25))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({85,72,93,59,86,55,86,80,85,91,42,86,85,77,80,89,84,76,75,33},25), label or _d({91,72,89,78,76,91},25), _d({20,7,75,80,75,7,85,86,91,7,72,89,89,80,93,76,7,94,80,91,79,80,85},25), timeout, _d({90,19,7,89,76,91,89,96,80,85,78,7,86,85,74,76},25))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({85,72,93,59,86,55,86,80,85,91,42,86,85,77,80,89,84,76,75,33},25), label or _d({91,72,89,78,76,91},25), _d({20,7,90,91,80,83,83,7,85,86,91,7,72,89,89,80,93,76,75,7,72,77,91,76,89,7,89,76,91,89,96,19,7,87,89,86,74,76,76,75,80,85,78,7,72,85,96,94,72,96},25))
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
if not ok then debug(_d({85,72,93,59,86,55,86,80,85,91,47,86,83,75,80,85,78,41,83,86,74,82,7,82,76,96,20,75,86,94,85,7,76,89,89,86,89,33},25), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({85,72,93,59,86,55,86,80,85,91,47,86,83,75,80,85,78,41,83,86,74,82,7,82,76,96,20,92,87,7,76,89,89,86,89,33},25), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck, ignoreDamage)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({62,72,83,82,80,85,78,7,91,86,33},25), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({94,72,83,82,59,86,55,86,80,85,91,7,62,7,75,86,94,85,7,76,89,89,86,89,33},25), err) end
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
if not ignoreDamage and currentHum and currentHum.Health < startHP then
debug(_d({59,86,86,82,7,75,72,84,72,78,76,7,94,79,80,83,76,7,94,72,83,82,80,85,78,7,91,86,7,87,86,80,85,91,8,7,58,91,86,87,87,80,85,78,7,94,72,83,82,7,91,86,7,76,85,78,72,78,76,21},25))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({40,89,89,80,93,76,75,7,72,91,33},25), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({58,91,92,74,82,7,75,92,89,80,85,78,7,94,72,83,82,19,7,81,92,84,87,80,85,78,8},25))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({58,91,80,83,83,7,90,91,92,74,82,19,7,91,89,80,78,78,76,89,80,85,78,7,46,76,87,87,86,8},25))
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
debug(_d({52,86,93,80,85,78,7,91,86},25), stageName)
walkToPoint(COORDS[stageName], 30, false, true)
debug(_d({62,72,80,91,80,85,78,7,77,86,89,7,53,55,42,90,7,91,86,7,90,87,72,94,85,7,72,91},25), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({7,7,90,87,72,94,85,7,74,79,76,74,82,33,7,77,86,83,75,76,89,7,76,95,80,90,91,90,7,36},25), folder ~= nil,
_d({19,7,74,79,80,83,75,89,76,85,7,36},25), folder and #folder:GetChildren() or 0,
_d({19,7,72,83,80,93,76,7,36},25), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({53,86,7,53,55,42,90,7,72,87,87,76,72,89,76,75,7,72,91},25), stageName, _d({72,77,91,76,89,7,24,28,90,19,7,84,86,93,80,85,78,7,86,85,7,72,85,96,94,72,96},25))
break
end
end
debug(_d({50,80,83,83,80,85,78,7,53,55,42,90,7,72,91},25), stageName)
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
debug(_d({57,76,91,92,89,85,80,85,78,7,91,86},25), stageName, _d({87,86,90,80,91,80,86,85,7,73,76,77,86,89,76,7,84,86,93,80,85,78,7,86,85},25))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({62,72,80,91,80,85,78,7,28,90,7,72,91},25), stageName, _d({87,86,90,80,91,80,86,85},25))
task.wait(5)
debug(_d({62,72,80,91,80,85,78,7,77,86,89},25), targetHP * 100, _d({12,7,47,55,7,73,76,77,86,89,76,7,84,86,93,80,85,78,7,91,86,7,85,76,95,91,7,90,91,72,78,76},25))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({74,83,76,72,89,76,75},25))
end
local function killNamedNPC(name, targetPos)
debug(_d({52,86,93,80,85,78,7,91,86},25), name)
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
debug(name, _d({75,76,77,76,72,91,76,75},25))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({47,92,84,72,85,86,80,75},25))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
local animId = track.Animation and track.Animation.AnimationId
debug(_d({51,76,86,7,87,83,72,96,76,75,7,72,85,80,84,72,91,80,86,85,33},25), track.Animation and track.Animation.Name, "-", animId)
for _, id in ipairs(LEO_DODGE_ANIMS) do
if animId == id then
task.spawn(function()
triggerLeoDodge(animId)
end)
break
end
end
end)
if not ok2 then debug(_d({83,76,86,40,85,80,84,51,86,78,78,76,89,7,76,89,89,86,89,33},25), err2) end
end)
end)
if not ok then debug(_d({90,91,72,89,91,51,76,86,40,85,80,84,51,86,78,78,76,89,7,76,89,89,86,89,33},25), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local leoDodging = false
local LEO_DODGE_CORNERS = {
Vector3.new(-1091.222778, 506.074921, -4336.774902),
Vector3.new(-1203.214355, 506.074890, -4211.559570),
Vector3.new(-1092.562988, 506.074446, -4160.0),
Vector3.new(-981.911621, 506.074890, -4284.88)
}
local function triggerLeoDodge(whichAnim)
if leoDodging then return end
leoDodging = true
debug(_d({43,86,75,78,76,22,73,83,86,74,82,7,91,89,80,78,78,76,89,76,75,7,77,86,89,7,51,76,86,7,72,85,80,84,72,91,80,86,85,33},25), whichAnim)
local ok, err = pcall(function()
if whichAnim == LEO_HIKEN_ANIM_ID or whichAnim == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and leoDodging and holdTime < 3.5 do
local info = getNPCByName(_d({51,76,86},25))
if info then
local casting, currentWhich = isCastingDodgeSkill(info.model)
if casting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({51,76,86,7,90,91,72,89,91,76,75,7,73,83,86,74,82,20,73,89,76,72,82,76,89,7,84,80,75,20,73,83,86,74,82,8,7,44,93,72,75,80,85,78,21,21,21},25))
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
whichAnim = currentWhich
break
end
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end
if whichAnim == LEO_ENTEI_ANIM_ID or whichAnim == LEO_PILLAR_ANIM_ID then
local root = getRoot()
if not root then return end
local currentPos = root.Position
local startCornerIdx = 1
local minCornerDist = math.huge
for idx, corner in ipairs(LEO_DODGE_CORNERS) do
local d = (currentPos - corner).Magnitude
if d < minCornerDist then
minCornerDist = d
startCornerIdx = idx
end
end
local duration = (whichAnim == LEO_ENTEI_ANIM_ID) and 6.0 or 4.0
local startT = tick()
local currentIdx = startCornerIdx
while enabled and leoDodging and (tick() - startT < duration) do
local targetPoint = LEO_DODGE_CORNERS[currentIdx]
navToPoint(targetPoint, true)
local waitT = 0
local lastPos = root.Position
local stuckTime = 0
while enabled and leoDodging and not hasArrived() and (tick() - startT < duration) and waitT < 2.0 do
task.wait(0.1)
waitT += 0.1
local moved = (root.Position - lastPos).Magnitude
if moved < 0.3 then
stuckTime += 0.1
else
stuckTime = 0
end
lastPos = root.Position
if stuckTime >= 0.5 then
debug(_d({43,86,75,78,76,7,87,72,91,79,7,73,83,86,74,82,76,75,22,90,91,92,74,82,8,7,40,73,86,89,91,80,85,78,7,77,86,89,74,76,20,87,92,90,79,7,91,86,7,72,93,86,80,75,7,85,86,74,83,80,87,7,82,80,74,82,21},25))
setNavIdle()
break
end
end
currentIdx = (currentIdx % 4) + 1
end
end
end)
if not ok then debug(_d({91,89,80,78,78,76,89,51,76,86,43,86,75,78,76,7,76,89,89,86,89,33},25), err) end
if enabled and getNPCByName(_d({51,76,86},25)) then
setNavNamed(_d({51,76,86},25))
end
leoDodging = false
end
local function fightLeo()
debug(_d({52,86,93,80,85,78,7,91,86,7,51,76,86},25))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30, false, true)
local leoModel = getNPCByName(_d({51,76,86},25))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({51,76,86},25))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({51,76,86},25))
if not info then break end
if leoDodging then
task.wait(0.05)
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
return leoDodging or isNPCBlocking(info.model)
end)
end
end
debug(_d({51,76,86,7,75,76,77,76,72,91,76,75},25))
stopLeoAnimLogger()
debug(_d({57,76,91,92,89,85,80,85,78,7,91,86,7,51,76,86,7,87,86,90,80,91,80,86,85,7,73,76,77,86,89,76,7,84,86,93,80,85,78,7,86,85},25))
navToPointConfirmed(COORDS.Leo, 30, _d({51,76,86,7,87,86,90,80,91,80,86,85},25))
debug(_d({62,72,80,91,80,85,78,7,28,90,7,72,91,7,51,76,86,7,87,86,90,80,91,80,86,85},25))
task.wait(5)
debug(_d({62,72,80,91,80,85,78,7,77,86,89,7,32,28,12,7,47,55,7,73,76,77,86,89,76,7,84,86,93,80,85,78,7,91,86,7,85,76,95,91,7,90,91,72,78,76},25))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * 0.95 do
task.wait(1)
end
end
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({52,86,93,80,85,78,7,91,86},25), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({42,86,92,83,75,7,85,86,91,7,77,80,85,75,7,90,91,72,91,92,76,7,84,86,75,76,83,7,85,76,72,89},25), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({40,91,91,72,74,82,80,85,78},25), coordKey, _d({94,80,91,79},25), weapon or _d({85,86,91,79,80,85,78,7,77,86,92,85,75},25))
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
debug(coordKey, _d({73,72,89,89,76,83,7,75,76,90,91,89,86,96,76,75},25))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({89,76,74,79,76,74,82,58,91,72,91,92,76,33},25), coordKey, _d({20,7,74,86,92,83,75,7,85,86,91,7,77,80,85,75,7,90,91,72,91,92,76,7,84,86,75,76,83,19,7,90,82,80,87,87,80,85,78},25))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({89,76,74,79,76,74,82,58,91,72,91,92,76,33},25), coordKey, _d({90,91,80,83,83,7,72,83,80,93,76,7,15,47,55},25), hp, _d({16,7,20,7,89,76,20,75,76,90,91,89,86,96,80,85,78},25))
destroyStatue(coordKey)
else
debug(_d({89,76,74,79,76,74,82,58,91,72,91,92,76,33},25), coordKey, _d({74,86,85,77,80,89,84,76,75,7,75,76,90,91,89,86,96,76,75},25))
end
end)
if not ok then debug(_d({89,76,74,79,76,74,82,58,91,72,91,92,76,7,76,89,89,86,89,33},25), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({52,86,93,80,85,78,7,91,86,7,56,92,76,76,85},25))
walkToPoint(COORDS.Queen, 30, false, true)
equipSwordOrMelee()
setNavNamed(_d({42,92,87,80,75,7,56,92,76,76,85},25))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25))
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
debug(_d({56,92,76,76,85,7,76,85,91,76,89,76,75,7,87,79,72,90,76,7,25},25))
end
local function finishQueen()
debug(_d({45,80,85,80,90,79,80,85,78,7,56,92,76,76,85},25))
equipSwordOrMelee()
setNavNamed(_d({42,92,87,80,75,7,56,92,76,76,85},25))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({42,92,87,80,75,7,56,92,76,76,85},25))
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
debug(_d({56,92,76,76,85,7,75,76,77,76,72,91,76,75,21,7,55,83,72,85,7,74,86,84,87,83,76,91,76,21},25))
end
local CONFIRMATION_PROMPT_NAME = _d({42,86,85,77,80,89,84,72,91,80,86,85,55,89,86,84,87,91},25)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({57,76,84,86,91,76,44,93,76,85,91},25), 5)
end)
if ok then return result end
debug(_d({78,76,91,57,76,87,83,72,96,57,76,84,86,91,76,7,76,89,89,86,89,33},25), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({55,83,72,96,76,89,46,92,80},25))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({48,84,72,78,76,41,92,91,91,86,85},25)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({73,92,91,91,86,85,61,72,83,92,76},25)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({77,80,85,75,41,92,91,91,86,85,41,96,61,72,83,92,76,7,76,89,89,86,89,33},25), result)
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
if not ok then debug(_d({74,83,80,74,82,46,92,80,41,92,91,91,86,85,7,76,89,89,86,89,33},25), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({80,90,58,76,89,93,76,89},25))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({57,76,84,86,91,76,44,93,76,85,91},25))
or inst:FindFirstChild(_d({74,83,80,76,85,91,44,93,76,85,91},25))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({77,80,85,75,40,85,90,94,76,89,42,86,85,85,76,74,91,86,89,7,76,89,89,86,89,33},25), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({42,86,92,83,75,7,85,86,91,7,83,86,74,72,91,76,7,57,76,84,86,91,76,44,93,76,85,91,22,74,83,80,76,85,91,44,93,76,85,91,7,85,76,72,89,7,57,76,87,83,72,96,7,73,92,91,91,86,85,19,7,77,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,74,83,80,74,82},25))
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
debug(_d({77,80,89,76,57,76,87,83,72,96,61,72,83,92,76,7,76,89,89,86,89,33},25), err, _d({20,7,77,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,74,83,80,74,82},25))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({45,72,83,83,80,85,78,7,73,72,74,82,7,91,86,7,73,92,91,91,86,85,61,72,83,92,76,7,90,76,72,89,74,79,7,77,86,89,7,57,76,87,83,72,96},25))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({57,76,87,83,72,96,7,73,92,91,91,86,85,7,85,86,91,7,77,86,92,85,75,7,76,80,91,79,76,89,19,7,78,80,93,80,85,78,7,92,87},25))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({62,72,80,91,80,85,78,7,77,86,89,7,42,86,85,77,80,89,84,72,91,80,86,85,55,89,86,84,87,91,21,57,76,84,86,91,76,44,93,76,85,91},25))
local remote = getReplayRemote()
if not remote then
debug(_d({42,86,85,77,80,89,84,72,91,80,86,85,55,89,86,84,87,91,22,57,76,84,86,91,76,44,93,76,85,91,7,85,86,91,7,77,86,92,85,75,7,94,80,91,79,80,85,7,91,80,84,76,86,92,91},25))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({45,80,89,80,85,78,7,57,76,87,83,72,96,7,93,80,72,7,42,86,85,77,80,89,84,72,91,80,86,85,55,89,86,84,87,91,21,57,76,84,86,91,76,44,93,76,85,91},25))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({45,80,89,76,58,76,89,93,76,89,7,76,89,89,86,89,33},25), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({55,83,72,96,76,89,46,92,80},25), 10)
if not playerGui then
debug(_d({94,72,80,91,45,86,89,54,73,81,76,74,91,80,93,76,90,46,92,80,33,7,85,86,7,55,83,72,96,76,89,46,92,80,7,94,80,91,79,80,85,7,91,80,84,76,86,92,91,19,7,87,89,86,74,76,76,75,80,85,78,7,72,85,96,94,72,96},25))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({54,73,81,76,74,91,80,93,76,90,7,46,60,48,7,77,86,92,85,75,7,20,7,90,91,72,78,76,7,83,86,72,75,76,75},25))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({54,73,81,76,74,91,80,93,76,90,7,46,60,48,7,85,86,91,7,77,86,92,85,75,7,94,80,91,79,80,85,7,91,80,84,76,86,92,91,19,7,87,89,86,74,76,76,75,80,85,78,7,72,85,96,94,72,96},25))
return
end
end
end)
if not ok then debug(_d({94,72,80,91,45,86,89,54,73,81,76,74,91,80,93,76,90,46,92,80,7,76,89,89,86,89,33},25), err) end
end
local function runPlan()
debug(_d({55,83,72,85,7,90,91,72,89,91,76,75},25))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({58,91,72,89,91,80,85,78,7,85,72,93,7,83,86,86,87},25))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({87,86,90,7,23,21,25,90,7,40,45,59,44,57,7,90,91,72,89,91,53,72,93,33},25), rootAfter and rootAfter.Position)
end)
debug(_d({62,72,80,91,80,85,78,7,28,90,7,73,76,77,86,89,76,7,84,86,93,80,85,78,7,91,86,7,58,91,72,78,76,24},25))
task.wait(5)
for _, stage in ipairs({_d({58,91,72,78,76,24},25), _d({58,91,72,78,76,25},25), _d({58,91,72,78,76,26},25), _d({58,91,72,78,76,26,41},25)}) do
if not enabled then return end
local hpTarget = (stage == _d({58,91,72,78,76,26,41},25)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({52,86,93,80,85,78,7,91,86,7,72,89,89,86,94,7,77,83,96,20,75,86,94,85,7,72,89,76,72,7,15,42,92,87,80,75,7,57,72,80,85,16},25))
walkToPoint(COORDS.ArrowFlyDown, 30, true, true)
debug(_d({43,86,75,78,80,85,78,7,72,89,89,86,94,7,89,72,80,85,7,80,85,7,72,7,90,88,92,72,89,76},25))
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
clearStage(_d({58,91,72,78,76,27},25))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({56,92,76,76,85,7,80,85,7,87,79,72,90,76,7,25,7,20,7,82,76,76,87,80,85,78,7,50,76,85,7,47,72,82,80,7,72,74,91,80,93,76,7,77,89,86,84,7,79,76,89,76,7,86,85},25))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({58,91,72,91,92,76,24},25))
if not enabled then return end
recheckStatue(_d({58,91,72,91,92,76,24},25))
destroyStatue(_d({58,91,72,91,92,76,25},25))
if not enabled then return end
recheckStatue(_d({58,91,72,91,92,76,24},25))
recheckStatue(_d({58,91,72,91,92,76,25},25))
destroyStatue(_d({58,91,72,91,92,76,26},25))
if not enabled then return end
recheckStatue(_d({58,91,72,91,92,76,26},25))
recheckStatue(_d({58,91,72,91,92,76,25},25))
recheckStatue(_d({58,91,72,91,92,76,24},25))
if not enabled then return end
debug(_d({62,72,80,91,80,85,78,7,77,86,89,7,87,79,72,90,76,7,25,7,91,86,7,76,85,75},25))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({55,79,72,90,76,7,25,7,76,85,75,7,94,72,80,91,7,91,80,84,76,86,92,91,19,7,87,89,86,74,76,76,75,80,85,78,7,72,85,96,94,72,96},25))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({52,86,93,80,85,78,7,73,72,74,82,7,91,86,7,56,92,76,76,85,7,90,91,72,78,76,7,87,86,90,80,91,80,86,85},25))
navToPointConfirmed(COORDS.Queen, 30, _d({56,92,76,76,85,7,90,91,72,78,76,7,87,86,90,80,91,80,86,85},25))
debug(_d({62,72,80,91,80,85,78,7,28,90,7,72,91,7,56,92,76,76,85,7,90,91,72,78,76,7,87,86,90,80,91,80,86,85},25))
task.wait(5)
if not enabled then return end
debug(_d({52,86,93,80,85,78,7,91,86,7,87,86,90,91,20,56,92,76,76,85,7,87,86,90,80,91,80,86,85},25))
navToPointConfirmed(COORDS.PostQueen, 30, _d({87,86,90,91,20,56,92,76,76,85,7,87,86,90,80,91,80,86,85},25))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({44,85,72,73,83,80,85,78,19,7,87,86,90,7,41,44,45,54,57,44,7,87,83,72,85,33},25), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({55,83,72,85,7,76,89,89,86,89,33},25), err2) end
end)
debug(_d({44,85,72,73,83,76,75,33},25), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
stopLeoAnimLogger()
debug(_d({44,85,72,73,83,76,75,33},25), enabled)
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
if not ok then debug(_d({48,85,87,92,91,41,76,78,72,85,7,76,89,89,86,89,33},25), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({46,72,84,76,7,83,86,72,75,76,75,19,7,72,92,91,86,20,90,91,72,89,91,80,85,78,7,91,79,76,7,87,83,72,85},25))
enableBot()
end)
if not ok then debug(_d({40,92,91,86,90,91,72,89,91,7,76,89,89,86,89,33},25), err) end
end)
debug(_d({51,86,72,75,76,75,7,201,103,123,7,72,92,91,86,20,90,91,72,89,91,80,85,78,7,86,85,74,76,7,91,79,76,7,78,72,84,76,7,77,80,85,80,90,79,76,90,7,83,86,72,75,80,85,78,7,15,87,89,76,90,90,7,55,7,91,86,7,91,86,78,78,83,76,7,84,72,85,92,72,83,83,96,16},25))
end)()