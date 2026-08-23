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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({53,81,70,94,74,87,88},27))
local UserInputService    = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local RunService          = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local VIM                 = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local ReplicatedStorage    = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({64,39,84,88,88,39,84,89,66},27), _d({60,87,84,83,76,5,76,70,82,74,5,199,101,121,5,53,81,70,72,74,46,73,31},27), game.PlaceId, _d({58,83,78,91,74,87,88,74,46,73,31},27), game.GameId, _d({18,5,83,84,89,5,87,90,83,83,78,83,76},27))
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
local LEO_PILLAR_ANIM_ID   = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,26,23,25,25,22,25,22,24,23,28},27)
local LEO_ENTEI_ANIM_ID    = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,26,23,25,25,22,24,29,23,28,29},27)
local LEO_HIKEN_ANIM_ID    = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,26,23,23,21,30,22,28,25,21,28},27)
local LEO_FIREFLY_ANIM_ID  = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,26,23,23,21,23,24,27,22,26,25},27)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({52,71,79,74,72,89,78,91,74,88},27)
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
local REPLAY_BUTTON_VALUE   = _d({55,74,85,81,70,94},27)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({82,84,91,74},27)
local NavState   = {mode = _d({78,73,81,74},27)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({64,39,84,88,88,39,84,89,66},27), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end)
if ok then return root end
debug(_d({76,74,89,55,84,84,89,5,74,87,87,84,87,31},27), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end)
if ok then return hum end
debug(_d({76,74,89,45,90,82,70,83,84,78,73,5,74,87,87,84,87,31},27), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({14,5,84,87,5,46,83,88,89,70,83,72,74,19,83,74,92,13},27)Attachment")
att.Name = _d({68,68,45,84,91,74,87,38,89,89},27)
att.Parent = root
local force = root:FindFirstChild(_d({68,68,45,84,91,74,87,43,84,87,72,74},27))
if not force then
force = Instance.new(_d({49,78,83,74,70,87,59,74,81,84,72,78,89,94},27))
force.Name = _d({68,68,45,84,91,74,87,43,84,87,72,74},27)
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
debug(_d({76,74,89,52,87,40,87,74,70,89,74,43,84,87,72,74,5,74,87,87,84,87,31},27), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local force = root:FindFirstChild(_d({68,68,45,84,91,74,87,43,84,87,72,74},27))
local att   = root:FindFirstChild(_d({68,68,45,84,91,74,87,38,89,89},27))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({72,81,74,70,83,90,85,43,84,87,72,74,5,74,87,87,84,87,31},27), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({39,90,88,84,50,74,81,74,74},27)) ~= nil
end)
if ok then return result end
debug(_d({78,88,39,90,88,84,38,72,89,78,91,74,5,74,87,87,84,87,31},27), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({39,90,88,84},27))
end)
if not ok then debug(_d({70,72,89,78,91,70,89,74,39,90,88,84,5,74,87,87,84,87,31},27), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({39,90,88,84,5,83,84,89,5,70,72,89,78,91,74,17,5,70,72,89,78,91,70,89,78,83,76},27))
activateBuso()
end
end)
if not ok then debug(_d({39,90,88,84,48,74,74,85,74,87,5,74,87,87,84,87,31},27), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({39,90,88,84,5,80,74,74,85,74,87,5,88,89,84,85,85,74,73},27))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({48,74,83,45,70,80,78},27)) ~= nil
end)
if ok then return result end
debug(_d({78,88,48,74,83,38,72,89,78,91,74,5,74,87,87,84,87,31},27), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({48,74,83},27), true)
end)
if not ok then debug(_d({70,72,89,78,91,70,89,74,48,74,83,5,74,87,87,84,87,31},27), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({48,74,83,5,83,84,89,5,70,72,89,78,91,74,17,5,70,72,89,78,91,70,89,78,83,76},27))
activateKen()
end
end)
if not ok then debug(_d({48,74,83,48,74,74,85,74,87,5,74,87,87,84,87,31},27), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({48,74,83,5,80,74,74,85,74,87,5,88,89,84,85,85,74,73},27))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({51,53,40,88},27)) end)
if ok then return folder end
debug(_d({76,74,89,51,53,40,88,43,84,81,73,74,87,5,74,87,87,84,87,31},27), folder)
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
local r = model:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local h = model:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
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
debug(_d({76,74,89,51,74,70,87,74,88,89,51,53,40,5,74,87,87,84,87,31},27), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum  = model:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({76,74,89,51,53,40,39,94,51,70,82,74,5,74,87,87,84,87,31},27), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({83,85,72,88,55,74,82,70,78,83,78,83,76,5,74,87,87,84,87,31},27), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({40,90,85,78,73,5,54,90,74,74,83},27))
return queen ~= nil and queen:FindFirstChild(_d({82,84,89,78,84,83,49,74,88,88},27)) ~= nil
end)
if ok then return result end
debug(_d({78,88,54,90,74,74,83,53,77,70,88,74,23,5,74,87,87,84,87,31},27), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,22,23,22,23,30,28,30,25,23,23,30,23,28,27,30},27)
local QUEEN_GRASP_ANIM_ID   = _d({87,71,93,70,88,88,74,89,78,73,31,20,20,22,23,30,29,21,21,21,27,22,21,21,22,28,24,25},27)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
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
debug(_d({78,88,53,81,70,94,78,83,76,38,83,78,82,43,87,84,82,49,78,88,89,5,74,87,87,84,87,31},27), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({39,81,84,72,80,78,83,76},27)) ~= nil
end)
if ok then return result end
debug(_d({78,88,51,53,40,39,81,84,72,80,78,83,76,5,74,87,87,84,87,31},27), result)
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
debug(_d({85,87,74,73,78,72,89,51,53,40,53,84,88,78,89,78,84,83,5,74,87,87,84,87,31},27), result)
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
debug(_d({51,84,5,73,70,82,70,76,74,5,84,83},27), model.Name, _d({75,84,87},27), NPC_STUCK_TIMEOUT, _d({88,5,18,5,88,92,78,89,72,77,78,83,76,5,89,70,87,76,74,89},27))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({89,87,70,72,80,51,53,40,41,70,82,70,76,74,5,74,87,87,84,87,31},27), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({50,84,73,74,81},27)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({39,70,88,74,53,70,87,89},27)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({76,74,89,50,84,73,74,81,43,70,72,74,53,84,88,5,74,87,87,84,87,31},27), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({42,83,91},27))
local folder = env and env:FindFirstChild(_d({56,89,70,89,90,74,88},27))
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
debug(_d({76,74,89,56,89,70,89,90,74,50,84,73,74,81,51,74,70,87,5,74,87,87,84,87,31},27), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({71,70,87,87,74,81,45,53},27))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({76,74,89,56,89,70,89,90,74,45,53,5,74,87,87,84,87,31},27), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({57,84,84,81},27)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({75,78,83,73,57,84,84,81,39,94,38,89,89,87,78,71,90,89,74,5,74,87,87,84,87,31},27), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({57,84,84,81},27)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({75,78,83,73,57,84,84,81,39,94,51,70,82,74,5,74,87,87,84,87,31},27), tool)
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
if not ok then debug(_d({74,86,90,78,85,57,84,84,81,5,74,87,87,84,87,31},27), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({57,84,84,81},27)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({75,78,83,73,57,84,84,81,39,94,40,77,78,81,73,51,70,82,74,5,74,87,87,84,87,31},27), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({56,92,84,87,73,42,86,90,78,85},27))
if sword then
equipTool(sword)
return _d({88,92,84,87,73},27)
end
local melee = findToolByAttribute(_d({50,74,81,74,74,57,84,84,81},27))
if melee then
equipTool(melee)
return _d({82,74,81,74,74},27)
end
debug(_d({51,84,5,88,92,84,87,73,5,84,87,5,82,74,81,74,74,5,89,84,84,81,5,75,84,90,83,73},27))
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
if not ok then debug(_d({72,81,78,72,80,50,22,5,74,87,87,84,87,31},27), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({55,84,80,90,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,74,85,85,84},27), args)
elseif style == _d({39,81,70,72,80,49,74,76},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80},27), args)
elseif style == _d({48,70,82,78,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,70,82,78,88,77,78,80,78,44,74,85,85,84},27), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80,23},27), args)
end
end)
if not ok then debug(_d({78,83,91,84,80,74,44,74,85,85,84,5,74,87,87,84,87,31},27), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({85,87,74,88,88,56,80,78,81,81,55,5,74,87,87,84,87,31},27), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({77,84,81,73,39,81,84,72,80,5,74,87,87,84,87,31},27), err) end
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
if not ok then debug(_d({77,84,81,73,39,81,84,72,80,60,77,78,81,74,5,74,87,87,84,87,31},27), err) end
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
debug(_d({76,74,89,44,70,82,74,44,5,74,87,87,84,87,31},27), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({78,88,55,74,70,81,50,22,39,90,88,94,5,74,87,87,84,87,31},27), result)
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
return char ~= nil and char:FindFirstChild(_d({88,89,90,83},27)) ~= nil
end)
if ok then return result end
debug(_d({78,88,56,89,90,83,83,74,73,5,74,87,87,84,87,31},27), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({85,87,74,88,88,56,89,90,83,39,87,74,70,80,5,74,87,87,84,87,31},27), err) end
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
debug(_d({86,90,74,74,83,41,84,73,76,74,58,83,89,78,81,56,70,75,74,31,5,54,90,74,74,83,5,76,84,83,74,5,18,5,74,83,73,78,83,76,5,73,84,73,76,74,5,74,70,87,81,94},27))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({86,90,74,74,83,41,84,73,76,74,58,83,89,78,81,56,70,75,74,5,88,70,75,74,89,94,5,89,78,82,74,84,90,89},27))
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
local info = getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({54,90,74,74,83,5,72,70,88,89,78,83,76,5,73,74,89,74,72,89,74,73,5,18,5,73,84,73,76,78,83,76,5,13,92,70,89,72,77,74,87,14},27))
queenDodgeUntilSafe(function() return getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27)) end)
if enabled and getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27)) then
setNavNamed(_d({40,90,85,78,73,5,54,90,74,74,83},27))
end
queenDodging = false
end
end)
if not ok then debug(_d({86,90,74,74,83,41,84,73,76,74,60,70,89,72,77,74,87,5,74,87,87,84,87,31},27), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({85,84,78,83,89},27) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({83,85,72},27) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({83,70,82,74,73},27) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({76,74,89,51,70,91,57,70,87,76,74,89,88,5,74,87,87,84,87,31},27), aimR)
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
debug(_d({72,84,82,85,90,89,74,49,84,72,80,74,73,40,43,87,70,82,74,5,74,87,87,84,87,31},27), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({85,84,78,83,89},27), point = pos}
phase = _d({82,84,91,74},27)
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
if not ok then debug(_d({83,70,91,57,84,53,84,78,83,89,5,76,74,85,85,84,5,72,77,74,72,80,5,74,87,87,84,87,31},27), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({83,85,72},27)}
phase = _d({82,84,91,74},27)
end
function setNavNamed(name)
NavState = {mode = _d({83,70,82,74,73},27), name = name}
phase = _d({82,84,91,74},27)
end
local function setNavIdle()
NavState = {mode = _d({78,73,81,74},27)}
phase = _d({82,84,91,74},27)
end
local function hasArrived()
return phase == _d({77,84,91,74,87},27)
end
local function startNav()
phase = _d({82,84,91,74},27)
debug(_d({51,70,91,5,81,84,84,85,5,52,51},27))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({53,81,70,94,74,87,5,73,78,74,73,6,5,56,89,84,85,85,78,83,76,5,71,84,89,19},27))
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
debug(_d({53,81,70,94,74,87,5,78,88,5,89,84,84,5,75,70,87,5,75,87,84,82,5,89,70,87,76,74,89,5,13,35,23,21,21,21,5,88,89,90,73,88,14,19,5,49,78,80,74,81,94,5,87,74,88,85,70,92,83,74,73,5,70,89,5,81,84,71,71,94,19,5,56,89,84,85,85,78,83,76,5,71,84,89,19},27))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({68,68,85,87,74,91,53,84,88},27))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({49,70,87,76,74,5,85,84,88,78,89,78,84,83,5,79,90,82,85,5,73,74,89,74,72,89,74,73,31},27), delta, _d({88,89,90,73,88,19,5,85,87,74,91,53,84,88,34},27), prevPos, _d({83,74,92,53,84,88,34},27), pos)
end
end
force:SetAttribute(_d({68,68,85,87,74,91,53,84,88},27), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({82,84,91,74},27) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({77,84,91,74,87},27)
debug(_d({53,77,70,88,74,31,5,77,84,91,74,87},27))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({6,6,6,5,55,42,43,58,56,46,51,44,5,57,52,5,38,53,53,49,62,5,38,39,51,52,55,50,38,49,5,59,42,49,52,40,46,57,62,31},27), finalVel, _d({70,78,82,34},27), aim, _d({85,84,88,34},27), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({77,84,91,74,87},27) then
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
debug(_d({40,84,82,71,70,89,5,81,84,72,80,5,88,80,78,85,85,74,73,17},27), snapDist, _d({88,89,90,73,88,5,75,87,84,82,5,89,70,87,76,74,89,5,199,101,121,5,75,70,81,81,78,83,76,5,71,70,72,80,5,89,84,5,82,84,91,74},27))
phase = _d({82,84,91,74},27)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({45,74,70,87,89,71,74,70,89,5,74,87,87,84,87,31},27), err) end
end)
end
local function stopNav()
debug(_d({51,70,91,5,81,84,84,85,5,52,43,43},27))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({82,84,91,74},27)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({57,74,93,89,40,77,70,89,56,74,87,91,78,72,74},27))
local channels = TextChatService:FindFirstChild(_d({57,74,93,89,40,77,70,83,83,74,81,88},27))
local channel = channels and channels:FindFirstChild(_d({55,39,61,44,74,83,74,87,70,81},27))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({41,74,75,70,90,81,89,40,77,70,89,56,94,88,89,74,82,40,77,70,89,42,91,74,83,89,88},27))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({56,70,94,50,74,88,88,70,76,74,55,74,86,90,74,88,89},27))
if sayEvent then
sayEvent:FireServer(message, _d({38,81,81},27))
return
end
debug(_d({88,74,83,73,40,77,70,89,50,74,88,88,70,76,74,31,5,83,84,5,57,74,93,89,40,77,70,89,56,74,87,91,78,72,74,19,55,39,61,44,74,83,74,87,70,81,5,84,87,5,81,74,76,70,72,94,5,56,70,94,50,74,88,88,70,76,74,55,74,86,90,74,88,89,5,75,84,90,83,73,5,75,84,87},27), message)
end)
if not ok then debug(_d({88,74,83,73,40,77,70,89,50,74,88,88,70,76,74,5,74,87,87,84,87,31},27), err) end
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
debug(_d({51,84,89,5,82,70,80,78,83,76,5,85,87,84,76,87,74,88,88,5,89,84,92,70,87,73,5,83,70,91,5,89,70,87,76,74,89,5,75,84,87},27), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({88,5,18,5,88,74,83,73,78,83,76,5,20,90,83,88,89,90,72,80},27))
sendChatMessage(_d({20,90,83,88,89,90,72,80},27))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({92,70,78,89,58,83,89,78,81,38,87,87,78,91,74,73,5,89,78,82,74,84,90,89},27))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({83,70,91,57,84,53,84,78,83,89,40,84,83,75,78,87,82,74,73,31},27), label or _d({89,70,87,76,74,89},27), _d({18,5,73,78,73,5,83,84,89,5,70,87,87,78,91,74,5,92,78,89,77,78,83},27), timeout, _d({88,17,5,87,74,89,87,94,78,83,76,5,84,83,72,74},27))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({83,70,91,57,84,53,84,78,83,89,40,84,83,75,78,87,82,74,73,31},27), label or _d({89,70,87,76,74,89},27), _d({18,5,88,89,78,81,81,5,83,84,89,5,70,87,87,78,91,74,73,5,70,75,89,74,87,5,87,74,89,87,94,17,5,85,87,84,72,74,74,73,78,83,76,5,70,83,94,92,70,94},27))
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
if not ok then debug(_d({83,70,91,57,84,53,84,78,83,89,45,84,81,73,78,83,76,39,81,84,72,80,5,80,74,94,18,73,84,92,83,5,74,87,87,84,87,31},27), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({83,70,91,57,84,53,84,78,83,89,45,84,81,73,78,83,76,39,81,84,72,80,5,80,74,94,18,90,85,5,74,87,87,84,87,31},27), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({60,70,81,80,78,83,76,5,89,84,31},27), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({92,70,81,80,57,84,53,84,78,83,89,5,60,5,73,84,92,83,5,74,87,87,84,87,31},27), err) end
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
debug(_d({57,84,84,80,5,73,70,82,70,76,74,5,92,77,78,81,74,5,92,70,81,80,78,83,76,5,89,84,5,85,84,78,83,89,6,5,56,89,84,85,85,78,83,76,5,92,70,81,80,5,89,84,5,74,83,76,70,76,74,19},27))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({38,87,87,78,91,74,73,5,70,89,31},27), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({56,89,90,72,80,5,73,90,87,78,83,76,5,92,70,81,80,17,5,79,90,82,85,78,83,76,6},27))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({56,89,78,81,81,5,88,89,90,72,80,17,5,89,87,78,76,76,74,87,78,83,76,5,44,74,85,85,84,6},27))
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
debug(_d({50,84,91,78,83,76,5,89,84},27), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({60,70,78,89,78,83,76,5,75,84,87,5,51,53,40,88,5,89,84,5,88,85,70,92,83,5,70,89},27), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({5,5,88,85,70,92,83,5,72,77,74,72,80,31,5,75,84,81,73,74,87,5,74,93,78,88,89,88,5,34},27), folder ~= nil,
_d({17,5,72,77,78,81,73,87,74,83,5,34},27), folder and #folder:GetChildren() or 0,
_d({17,5,70,81,78,91,74,5,34},27), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({51,84,5,51,53,40,88,5,70,85,85,74,70,87,74,73,5,70,89},27), stageName, _d({70,75,89,74,87,5,22,26,88,17,5,82,84,91,78,83,76,5,84,83,5,70,83,94,92,70,94},27))
break
end
end
debug(_d({48,78,81,81,78,83,76,5,51,53,40,88,5,70,89},27), stageName)
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
debug(_d({55,74,89,90,87,83,78,83,76,5,89,84},27), stageName, _d({85,84,88,78,89,78,84,83,5,71,74,75,84,87,74,5,82,84,91,78,83,76,5,84,83},27))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({60,70,78,89,78,83,76,5,26,88,5,70,89},27), stageName, _d({85,84,88,78,89,78,84,83},27))
task.wait(5)
debug(_d({60,70,78,89,78,83,76,5,75,84,87},27), targetHP * 100, _d({10,5,45,53,5,71,74,75,84,87,74,5,82,84,91,78,83,76,5,89,84,5,83,74,93,89,5,88,89,70,76,74},27))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({72,81,74,70,87,74,73},27))
end
local function killNamedNPC(name, targetPos)
debug(_d({50,84,91,78,83,76,5,89,84},27), name)
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
debug(name, _d({73,74,75,74,70,89,74,73},27))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({49,74,84,5,85,81,70,94,74,73,5,70,83,78,82,70,89,78,84,83,31},27), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({81,74,84,38,83,78,82,49,84,76,76,74,87,5,85,87,78,83,89,5,74,87,87,84,87,31},27), err2) end
end)
end)
if not ok then debug(_d({88,89,70,87,89,49,74,84,38,83,78,82,49,84,76,76,74,87,5,74,87,87,84,87,31},27), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({50,84,91,78,83,76,5,89,84,5,49,74,84},27))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({49,74,84},27))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({49,74,84},27))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({49,74,84},27))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({49,74,84,5,72,70,88,89,78,83,76},27), which, _d({18,5,73,84,73,76,78,83,76},27))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({49,74,84,5,88,89,70,87,89,74,73,5,71,81,84,72,80,18,71,87,74,70,80,74,87,5,82,78,73,18,71,81,84,72,80,6,5,42,91,70,73,78,83,76,19,19,19},27))
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
if not getNPCByName(_d({49,74,84},27)) then
debug(_d({49,74,84,5,76,84,83,74,5,82,78,73,18,73,84,73,76,74,5,18,5,74,83,73,78,83,76,5,42,83,89,74,78,5,77,84,81,73,5,74,70,87,81,94},27))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({49,74,84},27)) then
setNavNamed(_d({49,74,84},27))
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
debug(_d({49,74,84,5,73,74,75,74,70,89,74,73},27))
stopLeoAnimLogger()
debug(_d({55,74,89,90,87,83,78,83,76,5,89,84,5,49,74,84,5,85,84,88,78,89,78,84,83,5,71,74,75,84,87,74,5,82,84,91,78,83,76,5,84,83},27))
navToPointConfirmed(COORDS.Leo, 30, _d({49,74,84,5,85,84,88,78,89,78,84,83},27))
debug(_d({60,70,78,89,78,83,76,5,26,88,5,70,89,5,49,74,84,5,85,84,88,78,89,78,84,83},27))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({50,84,91,78,83,76,5,89,84},27), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({40,84,90,81,73,5,83,84,89,5,75,78,83,73,5,88,89,70,89,90,74,5,82,84,73,74,81,5,83,74,70,87},27), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({38,89,89,70,72,80,78,83,76},27), coordKey, _d({92,78,89,77},27), weapon or _d({83,84,89,77,78,83,76,5,75,84,90,83,73},27))
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
debug(coordKey, _d({71,70,87,87,74,81,5,73,74,88,89,87,84,94,74,73},27))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({87,74,72,77,74,72,80,56,89,70,89,90,74,31},27), coordKey, _d({18,5,72,84,90,81,73,5,83,84,89,5,75,78,83,73,5,88,89,70,89,90,74,5,82,84,73,74,81,17,5,88,80,78,85,85,78,83,76},27))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({87,74,72,77,74,72,80,56,89,70,89,90,74,31},27), coordKey, _d({88,89,78,81,81,5,70,81,78,91,74,5,13,45,53},27), hp, _d({14,5,18,5,87,74,18,73,74,88,89,87,84,94,78,83,76},27))
destroyStatue(coordKey)
else
debug(_d({87,74,72,77,74,72,80,56,89,70,89,90,74,31},27), coordKey, _d({72,84,83,75,78,87,82,74,73,5,73,74,88,89,87,84,94,74,73},27))
end
end)
if not ok then debug(_d({87,74,72,77,74,72,80,56,89,70,89,90,74,5,74,87,87,84,87,31},27), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({50,84,91,78,83,76,5,89,84,5,54,90,74,74,83},27))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({40,90,85,78,73,5,54,90,74,74,83},27))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27))
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
debug(_d({54,90,74,74,83,5,74,83,89,74,87,74,73,5,85,77,70,88,74,5,23},27))
end
local function finishQueen()
debug(_d({43,78,83,78,88,77,78,83,76,5,54,90,74,74,83},27))
equipSwordOrMelee()
setNavNamed(_d({40,90,85,78,73,5,54,90,74,74,83},27))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({40,90,85,78,73,5,54,90,74,74,83},27))
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
debug(_d({54,90,74,74,83,5,73,74,75,74,70,89,74,73,19,5,53,81,70,83,5,72,84,82,85,81,74,89,74,19},27))
end
local CONFIRMATION_PROMPT_NAME = _d({40,84,83,75,78,87,82,70,89,78,84,83,53,87,84,82,85,89},27)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({55,74,82,84,89,74,42,91,74,83,89},27), 5)
end)
if ok then return result end
debug(_d({76,74,89,55,74,85,81,70,94,55,74,82,84,89,74,5,74,87,87,84,87,31},27), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({46,82,70,76,74,39,90,89,89,84,83},27)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({71,90,89,89,84,83,59,70,81,90,74},27)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({75,78,83,73,39,90,89,89,84,83,39,94,59,70,81,90,74,5,74,87,87,84,87,31},27), result)
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
if not ok then debug(_d({72,81,78,72,80,44,90,78,39,90,89,89,84,83,5,74,87,87,84,87,31},27), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({78,88,56,74,87,91,74,87},27))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({55,74,82,84,89,74,42,91,74,83,89},27))
or inst:FindFirstChild(_d({72,81,78,74,83,89,42,91,74,83,89},27))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({75,78,83,73,38,83,88,92,74,87,40,84,83,83,74,72,89,84,87,5,74,87,87,84,87,31},27), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({40,84,90,81,73,5,83,84,89,5,81,84,72,70,89,74,5,55,74,82,84,89,74,42,91,74,83,89,20,72,81,78,74,83,89,42,91,74,83,89,5,83,74,70,87,5,55,74,85,81,70,94,5,71,90,89,89,84,83,17,5,75,70,81,81,78,83,76,5,71,70,72,80,5,89,84,5,72,81,78,72,80},27))
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
debug(_d({75,78,87,74,55,74,85,81,70,94,59,70,81,90,74,5,74,87,87,84,87,31},27), err, _d({18,5,75,70,81,81,78,83,76,5,71,70,72,80,5,89,84,5,72,81,78,72,80},27))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({43,70,81,81,78,83,76,5,71,70,72,80,5,89,84,5,71,90,89,89,84,83,59,70,81,90,74,5,88,74,70,87,72,77,5,75,84,87,5,55,74,85,81,70,94},27))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({55,74,85,81,70,94,5,71,90,89,89,84,83,5,83,84,89,5,75,84,90,83,73,5,74,78,89,77,74,87,17,5,76,78,91,78,83,76,5,90,85},27))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({60,70,78,89,78,83,76,5,75,84,87,5,40,84,83,75,78,87,82,70,89,78,84,83,53,87,84,82,85,89,19,55,74,82,84,89,74,42,91,74,83,89},27))
local remote = getReplayRemote()
if not remote then
debug(_d({40,84,83,75,78,87,82,70,89,78,84,83,53,87,84,82,85,89,20,55,74,82,84,89,74,42,91,74,83,89,5,83,84,89,5,75,84,90,83,73,5,92,78,89,77,78,83,5,89,78,82,74,84,90,89},27))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({43,78,87,78,83,76,5,55,74,85,81,70,94,5,91,78,70,5,40,84,83,75,78,87,82,70,89,78,84,83,53,87,84,82,85,89,19,55,74,82,84,89,74,42,91,74,83,89},27))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({43,78,87,74,56,74,87,91,74,87,5,74,87,87,84,87,31},27), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
if not playerGui then
debug(_d({92,70,78,89,43,84,87,52,71,79,74,72,89,78,91,74,88,44,90,78,31,5,83,84,5,53,81,70,94,74,87,44,90,78,5,92,78,89,77,78,83,5,89,78,82,74,84,90,89,17,5,85,87,84,72,74,74,73,78,83,76,5,70,83,94,92,70,94},27))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({52,71,79,74,72,89,78,91,74,88,5,44,58,46,5,75,84,90,83,73,5,18,5,88,89,70,76,74,5,81,84,70,73,74,73},27))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({52,71,79,74,72,89,78,91,74,88,5,44,58,46,5,83,84,89,5,75,84,90,83,73,5,92,78,89,77,78,83,5,89,78,82,74,84,90,89,17,5,85,87,84,72,74,74,73,78,83,76,5,70,83,94,92,70,94},27))
return
end
end
end)
if not ok then debug(_d({92,70,78,89,43,84,87,52,71,79,74,72,89,78,91,74,88,44,90,78,5,74,87,87,84,87,31},27), err) end
end
local function runPlan()
debug(_d({53,81,70,83,5,88,89,70,87,89,74,73},27))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({56,89,70,87,89,78,83,76,5,83,70,91,5,81,84,84,85},27))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({85,84,88,5,21,19,23,88,5,38,43,57,42,55,5,88,89,70,87,89,51,70,91,31},27), rootAfter and rootAfter.Position)
end)
debug(_d({60,70,78,89,78,83,76,5,26,88,5,71,74,75,84,87,74,5,82,84,91,78,83,76,5,89,84,5,56,89,70,76,74,22},27))
task.wait(5)
for _, stage in ipairs({_d({56,89,70,76,74,22},27), _d({56,89,70,76,74,23},27), _d({56,89,70,76,74,24},27), _d({56,89,70,76,74,24,39},27)}) do
if not enabled then return end
local hpTarget = (stage == _d({56,89,70,76,74,24,39},27)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({50,84,91,78,83,76,5,89,84,5,70,87,87,84,92,5,75,81,94,18,73,84,92,83,5,70,87,74,70,5,13,40,90,85,78,73,5,55,70,78,83,14},27))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({41,84,73,76,78,83,76,5,70,87,87,84,92,5,87,70,78,83,5,78,83,5,70,5,88,86,90,70,87,74},27))
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
clearStage(_d({56,89,70,76,74,25},27))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({54,90,74,74,83,5,78,83,5,85,77,70,88,74,5,23,5,18,5,80,74,74,85,78,83,76,5,48,74,83,5,45,70,80,78,5,70,72,89,78,91,74,5,75,87,84,82,5,77,74,87,74,5,84,83},27))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({56,89,70,89,90,74,22},27))
if not enabled then return end
recheckStatue(_d({56,89,70,89,90,74,22},27))
destroyStatue(_d({56,89,70,89,90,74,23},27))
if not enabled then return end
recheckStatue(_d({56,89,70,89,90,74,22},27))
recheckStatue(_d({56,89,70,89,90,74,23},27))
destroyStatue(_d({56,89,70,89,90,74,24},27))
if not enabled then return end
recheckStatue(_d({56,89,70,89,90,74,24},27))
recheckStatue(_d({56,89,70,89,90,74,23},27))
recheckStatue(_d({56,89,70,89,90,74,22},27))
if not enabled then return end
debug(_d({60,70,78,89,78,83,76,5,75,84,87,5,85,77,70,88,74,5,23,5,89,84,5,74,83,73},27))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({53,77,70,88,74,5,23,5,74,83,73,5,92,70,78,89,5,89,78,82,74,84,90,89,17,5,85,87,84,72,74,74,73,78,83,76,5,70,83,94,92,70,94},27))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({50,84,91,78,83,76,5,71,70,72,80,5,89,84,5,54,90,74,74,83,5,88,89,70,76,74,5,85,84,88,78,89,78,84,83},27))
navToPointConfirmed(COORDS.Queen, 30, _d({54,90,74,74,83,5,88,89,70,76,74,5,85,84,88,78,89,78,84,83},27))
debug(_d({60,70,78,89,78,83,76,5,26,88,5,70,89,5,54,90,74,74,83,5,88,89,70,76,74,5,85,84,88,78,89,78,84,83},27))
task.wait(5)
if not enabled then return end
debug(_d({50,84,91,78,83,76,5,89,84,5,85,84,88,89,18,54,90,74,74,83,5,85,84,88,78,89,78,84,83},27))
navToPointConfirmed(COORDS.PostQueen, 30, _d({85,84,88,89,18,54,90,74,74,83,5,85,84,88,78,89,78,84,83},27))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({42,83,70,71,81,78,83,76,17,5,85,84,88,5,39,42,43,52,55,42,5,85,81,70,83,31},27), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({53,81,70,83,5,74,87,87,84,87,31},27), err2) end
end)
debug(_d({42,83,70,71,81,74,73,31},27), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({42,83,70,71,81,74,73,31},27), enabled)
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
if not ok then debug(_d({46,83,85,90,89,39,74,76,70,83,5,74,87,87,84,87,31},27), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({44,70,82,74,5,81,84,70,73,74,73,17,5,70,90,89,84,18,88,89,70,87,89,78,83,76,5,89,77,74,5,85,81,70,83},27))
enableBot()
end)
if not ok then debug(_d({38,90,89,84,88,89,70,87,89,5,74,87,87,84,87,31},27), err) end
end)
debug(_d({49,84,70,73,74,73,5,199,101,121,5,70,90,89,84,18,88,89,70,87,89,78,83,76,5,84,83,72,74,5,89,77,74,5,76,70,82,74,5,75,78,83,78,88,77,74,88,5,81,84,70,73,78,83,76,5,13,85,87,74,88,88,5,53,5,89,84,5,89,84,76,76,81,74,5,82,70,83,90,70,81,81,94,14},27))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({77,89,89,85,88,31,20,20,87,70,92,19,76,78,89,77,90,71,90,88,74,87,72,84,83,89,74,83,89,19,72,84,82,20,87,84,72,80,94,93,92,70,81,81,20,55,70,94,75,78,74,81,73,20,82,70,78,83,20,88,84,90,87,72,74,19,81,90,70},27)
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
error(_d({64,45,84,87,84,5,91,23,66,5,43,70,78,81,74,73,5,89,84,5,81,84,70,73,5,55,70,94,75,78,74,81,73,5,58,46,5,49,78,71,87,70,87,94,19},27))
end
local Window = Rayfield:CreateWindow({
Name = _d({45,84,87,84,5,45,84,87,84,5,63,18,43,70,87,82,5,91,23},27),
LoadingTitle = _d({49,84,70,73,78,83,76,5,45,84,87,84,5,91,23,19,19,19},27),
LoadingSubtitle = _d({56,78,81,74,83,89,5,38,78,82,5,52,85,89,78,82,78,95,74,73},27),
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
local MainTab = Window:CreateTab(_d({38,90,89,84,5,43,70,87,82},27), 4483362458)
local SkillTab = Window:CreateTab(_d({56,80,78,81,81,5,56,74,89,89,78,83,76,88},27), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({39,70,72,80,85,70,72,80},27))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)) or (bp and bp:FindFirstChild(_d({45,84,87,84,18,45,84,87,84},27)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({51,53,40,88},27))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum = boss:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
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
if key == _d({45,78,89},27) then
return target.CFrame
elseif key == _d({57,70,87,76,74,89},27) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({64,45,84,87,84,5,91,23,66,5,50,74,89,70,89,70,71,81,74,5,77,84,84,80,5,75,70,78,81,74,73,31,5},27) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({64,45,84,87,84,5,91,23,66,5,40,81,74,70,83,74,73,5,90,85,5,85,87,74,91,78,84,90,88,5,88,74,88,88,78,84,83,19},27))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,60,70,78,89,78,83,76,5,75,84,87,5,39,84,88,88,5,56,85,70,92,83},27)) end
print(_d({64,45,84,87,84,5,91,23,66,5,39,84,88,88},27), _G.HoroSelectedBoss, _d({78,88,5,83,84,89,5,88,85,70,92,83,74,73,19,5,60,70,78,89,78,83,76,19,19,19},27))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,55,90,83,83,78,83,76,5,40,84,82,71,84},27)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,40,5,13,48,70,82,78,80,70,95,74,14},27))
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
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,63,5,13,50,78,83,78,5,39,70,87,87,70,76,74,14},27))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,42,5,13,56,89,90,83,14},27))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({64,45,84,87,84,5,91,23,66,5,43,78,87,74,73,5,55,5,13,41,74,89,84,83,70,89,78,84,83,14},27))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,56,81,74,74,85,78,83,76,5,13},27) .. string.format(_d({10,19,22,75},27), finalSleep) .. _d({88,14},27)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({56,89,70,89,90,88,31,5,46,73,81,74},27))
MainTab:CreateDropdown({
Name = _d({56,74,81,74,72,89,5,39,84,88,88},27),
Options = {_d({38,93,74,5,45,70,83,73,5,49,84,76,70,83},27), _d({39,70,83,73,78,89,5,39,84,88,88},27), _d({47,90,95,84,5,89,77,74,5,41,78,70,82,84,83,73,71,70,72,80},27)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({64,45,84,87,84,5,91,23,66,5,56,74,81,74,72,89,74,73,5,89,70,87,76,74,89,31},27), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({56,89,70,87,89,5,38,90,89,84,5,43,70,87,82},27),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({56,74,81,74,72,89,5,39,84,88,88,5,55,74,86,90,78,87,74,73},27),
Content = _d({62,84,90,5,82,90,88,89,5,88,74,81,74,72,89,5,70,5,71,84,88,88,5,75,78,87,88,89,5,71,74,75,84,87,74,5,74,83,70,71,81,78,83,76,5,38,90,89,84,5,43,70,87,82,6},27),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({56,89,70,89,90,88,31,5,46,73,81,74},27)) end
end
print(_d({64,45,84,87,84,5,91,23,66,5,38,90,89,84,5,43,70,87,82,31},27), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({41,74,88,89,87,84,94,5,58,46},27),
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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
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
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function waitForGameLoad()
print("[Gepo Grinder] Waiting for game to load...")
if not game:IsLoaded() then
game.Loaded:Wait()
end
while not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart_d({14,5,84,87,5,83,84,89,5,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,60,77,78,72,77,46,88,38,13},27)Humanoid") do
task.wait(0.5)
end
local folderName = _d({56,89,70,89,88},27) .. LocalPlayer.Name
local statsFolder = ReplicatedStorage:WaitForChild(folderName, 30)
if not statsFolder then
error("[Gepo Grinder] Stats folder not found in ReplicatedStorage!")
end
statsFolder:WaitForChild(_d({56,89,70,89,88},27), 10)
statsFolder:WaitForChild("Inventory", 10)
statsFolder:WaitForChild("Settings", 10)
print("[Gepo Grinder] Game fully loaded!")
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild(_d({56,89,70,89,88},27)) then
local stats = statsFolder.Stats
local lvl = stats:FindFirstChild("Level") and stats.Level.Value or 1
local peli = stats:FindFirstChild("Peli") and stats.Peli.Value or 0
return lvl, peli
end
return 1, 0
end
local function hasRifleTool()
return LocalPlayer.Backpack:FindFirstChild("Rifle_d({14,5,84,87,5,13,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,5,70,83,73,5,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)Rifle"))
end
local function hasRifleInInventory()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
local invVal = statsFolder and statsFolder:FindFirstChild("Inventory_d({14,5,70,83,73,5,88,89,70,89,88,43,84,81,73,74,87,19,46,83,91,74,83,89,84,87,94,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)Inventory")
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
importLib("lib/easy_travel.lua_d({17,5},27)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
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
local slots = {"Zero_d({17,5},27)One_d({17,5},27)Two_d({17,5},27)Three_d({17,5},27)Four_d({17,5},27)Five_d({17,5},27)Six_d({17,5},27)Seven_d({17,5},27)Eight_d({17,5},27)Nine"}
local mapping = {}
for _, slot in ipairs(slots) do
mapping[slot] = "None"
end
local pgui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local backpackGui = pgui and pgui:FindFirstChild("BackpackGui")
local hotbar = backpackGui and backpackGui:FindFirstChild("Hotbar")
if hotbar then
for _, slot in ipairs(slots) do
local slotFrame = hotbar:FindFirstChild(slot)
if slotFrame then
for _, child in ipairs(slotFrame:GetChildren()) do
if child.Name ~= "Design_d({5,70,83,73,5,72,77,78,81,73,19,51,70,82,74,5,99,34,5},27)Number_d({5,70,83,73,5,72,77,78,81,73,19,51,70,82,74,5,99,34,5},27)UIListLayout_d({5,70,83,73,5,72,77,78,81,73,19,51,70,82,74,5,99,34,5},27)UIPadding" then
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
local cache = filtergc("table_d({17,5,96,5,48,74,94,88,5,34,5,96},27)One_d({17,5},27)Two_d({17,5},27)Three"} }, true)
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
if rawget(v, "One_d({14,5,99,34,5,83,78,81,5,70,83,73,5,87,70,92,76,74,89,13,91,17,5},27)Two_d({14,5,99,34,5,83,78,81,5,70,83,73,5,87,70,92,76,74,89,13,91,17,5},27)Three") ~= nil then
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
print("[Gepo Grinder] Stopped: _d({5,19,19,5,13,87,74,70,88,84,83,5,84,87,5},27)done_d({14,5,19,19,5},27).")
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
importLib("lib/easy_travel.lua_d({17,5},27)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/easy_travel.lua")
end
if not _G.ChestFarmer then
importLib("lib/chest_farmer.lua_d({17,5},27)https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/lib/chest_farmer.lua")
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
local shopEvent = ReplicatedStorage:FindFirstChild("Events_d({14,5,70,83,73,5,55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74,19,42,91,74,83,89,88,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)Shop")
if shopEvent and shopEvent:IsA("RemoteFunction") then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
local pgui = LocalPlayer:FindFirstChild(_d({53,81,70,94,74,87,44,90,78},27))
local diag = pgui and pgui:FindFirstChild("Dialogue")
if diag then
local closeBtn = diag:FindFirstChild("Close", true)
if closeBtn and getconnections then
pcall(function()
for _, conn in ipairs(getconnections(closeBtn.MouseButton1Click)) do
conn:Fire()
end
for _, conn in ipairs(getconnections(closeBtn.Activated)) do
conn:Fire()
end
end)
end
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
local slotsOrder = {"One_d({17,5},27)Two_d({17,5},27)Three_d({17,5},27)Four_d({17,5},27)Five_d({17,5},27)Six_d({17,5},27)Seven_d({17,5},27)Eight_d({17,5},27)Nine_d({17,5},27)Zero"}
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
while running and replicaElapsed < 3 do
task.wait(0.2)
replicaElapsed = replicaElapsed + 0.2
rifleTool = LocalPlayer.Backpack:FindFirstChild("Rifle_d({14,5,84,87,5,13,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,5,70,83,73,5,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)Rifle"))
if rifleTool then
break
end
end
if not rifleTool then
print("[Gepo Grinder] Rifle hasn't replicated yet. Resetting character to force inventory sync...")
local hum = getHumanoid()
if hum then
hum.Health = 0
end
task.wait(6)
rifleTool = LocalPlayer.Backpack:FindFirstChild("Rifle_d({14,5,84,87,5,13,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,5,70,83,73,5,49,84,72,70,81,53,81,70,94,74,87,19,40,77,70,87,70,72,89,74,87,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)Rifle"))
if not rifleTool then
warn("[Gepo Grinder] Rifle was bound to hotbar but did not appear in Backpack/Character even after reset.")
cleanup("Rifle replication timeout")
return
end
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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
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
local root = char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
local hum = char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({14,5,84,87,5,46,83,88,89,70,83,72,74,19,83,74,92,13},27)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({49,78,83,74,70,87,59,74,81,84,72,78,89,94},27))
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
local Players = game:GetService(_d({53,81,70,94,74,87,88},27))
local RunService = game:GetService(_d({55,90,83,56,74,87,91,78,72,74},27))
local UserInputService = game:GetService(_d({58,88,74,87,46,83,85,90,89,56,74,87,91,78,72,74},27))
local ReplicatedStorage = game:GetService(_d({55,74,85,81,78,72,70,89,74,73,56,89,84,87,70,76,74},27))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({78,73,81,74},27)
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
return char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({56,89,70,89,88},27) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({55,84,80,90,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,74,85,85,84},27), args)
elseif style == _d({39,81,70,72,80,49,74,76},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80},27), args)
elseif style == _d({48,70,82,78,88,77,78,80,78},27) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({48,70,82,78,88,77,78,80,78,44,74,85,85,84},27), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,80,94,5,60,70,81,80,23},27), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({78,83,91,84,80,74,44,74,85,85,84,5,74,87,87,84,87,31},27), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({14,5,84,87,5,46,83,88,89,70,83,72,74,19,83,74,92,13},27)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({49,78,83,74,70,87,59,74,81,84,72,78,89,94},27))
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
local root = char:FindFirstChild(_d({45,90,82,70,83,84,78,73,55,84,84,89,53,70,87,89},27))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({60,70,81,80,78,83,76,5,89,84,31},27), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({92,70,81,80,57,84,53,84,78,83,89,5,60,5,73,84,92,83,5,74,87,87,84,87,31},27), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({38,87,87,78,91,74,73,5,70,89,31},27), pos)
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
if item:IsA("Model_d({14,5,70,83,73,5,78,89,74,82,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,13},27)HumanoidRootPart_d({14,5,70,83,73,5,78,89,74,82,31,43,78,83,73,43,78,87,88,89,40,77,78,81,73,60,77,78,72,77,46,88,38,13},27)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({45,90,82,70,83,84,78,73},27)).Health > 0 then
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
mode = _d({78,73,81,74},27)
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
if mode == _d({77,84,91,74,87},27) then
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
local playerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
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
statusLabel.Text = _d({56,89,70,89,90,88,31,5,46,73,81,74},27)
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
enableBot(_d({77,84,91,74,87},27))
statusLabel.Text = "Status: Hovering _d({5,19,19,5,91,70,81,5,19,19,5},27) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({5,19,19,5,91,70,81,5,19,19,5},27) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({5,19,19,5,91,70,81,5,19,19,5},27) studs)"
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
local VIM = game:GetService(_d({59,78,87,89,90,70,81,46,83,85,90,89,50,70,83,70,76,74,87},27))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({53,81,70,94,74,87,44,90,78},27), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({17,5},27)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({17,5},27)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({17,5},27)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({17,5},27)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({17,5},27)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()