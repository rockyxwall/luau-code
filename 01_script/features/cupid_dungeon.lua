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
local Players            = game:GetService(_d({49,77,66,90,70,83,84},31))
local UserInputService    = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
local RunService          = game:GetService(_d({51,86,79,52,70,83,87,74,68,70},31))
local VIM                 = game:GetService(_d({55,74,83,85,86,66,77,42,79,81,86,85,46,66,79,66,72,70,83},31))
local ReplicatedStorage    = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({60,35,80,84,84,35,80,85,62},31), _d({56,83,80,79,72,1,72,66,78,70,1,195,97,117,1,49,77,66,68,70,42,69,27},31), game.PlaceId, _d({54,79,74,87,70,83,84,70,42,69,27},31), game.GameId, _d({14,1,79,80,85,1,83,86,79,79,74,79,72},31))
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
local LEO_PILLAR_ANIM_ID   = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,22,19,21,21,18,21,18,20,19,24},31)
local LEO_ENTEI_ANIM_ID    = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,22,19,21,21,18,20,25,19,24,25},31)
local LEO_HIKEN_ANIM_ID    = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,22,19,19,17,26,18,24,21,17,24},31)
local LEO_FIREFLY_ANIM_ID  = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,22,19,19,17,19,20,23,18,22,21},31)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({48,67,75,70,68,85,74,87,70,84},31)
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
local REPLAY_BUTTON_VALUE   = _d({51,70,81,77,66,90},31)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({78,80,87,70},31)
local NavState   = {mode = _d({74,69,77,70},31)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({60,35,80,84,84,35,80,85,62},31), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end)
if ok then return root end
debug(_d({72,70,85,51,80,80,85,1,70,83,83,80,83,27},31), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
end)
if ok then return hum end
debug(_d({72,70,85,41,86,78,66,79,80,74,69,1,70,83,83,80,83,27},31), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({64,64,41,80,87,70,83,34,85,85},31)) or Instance.new(_d({34,85,85,66,68,73,78,70,79,85},31))
att.Name = _d({64,64,41,80,87,70,83,34,85,85},31)
att.Parent = root
local force = root:FindFirstChild(_d({64,64,41,80,87,70,83,39,80,83,68,70},31))
if not force then
force = Instance.new(_d({45,74,79,70,66,83,55,70,77,80,68,74,85,90},31))
force.Name = _d({64,64,41,80,87,70,83,39,80,83,68,70},31)
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
debug(_d({72,70,85,48,83,36,83,70,66,85,70,39,80,83,68,70,1,70,83,83,80,83,27},31), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not root then return end
local force = root:FindFirstChild(_d({64,64,41,80,87,70,83,39,80,83,68,70},31))
local att   = root:FindFirstChild(_d({64,64,41,80,87,70,83,34,85,85},31))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({68,77,70,66,79,86,81,39,80,83,68,70,1,70,83,83,80,83,27},31), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({35,86,84,80,46,70,77,70,70},31)) ~= nil
end)
if ok then return result end
debug(_d({74,84,35,86,84,80,34,68,85,74,87,70,1,70,83,83,80,83,27},31), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({35,86,84,80},31))
end)
if not ok then debug(_d({66,68,85,74,87,66,85,70,35,86,84,80,1,70,83,83,80,83,27},31), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({35,86,84,80,1,79,80,85,1,66,68,85,74,87,70,13,1,66,68,85,74,87,66,85,74,79,72},31))
activateBuso()
end
end)
if not ok then debug(_d({35,86,84,80,44,70,70,81,70,83,1,70,83,83,80,83,27},31), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({35,86,84,80,1,76,70,70,81,70,83,1,84,85,80,81,81,70,69},31))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({44,70,79,41,66,76,74},31)) ~= nil
end)
if ok then return result end
debug(_d({74,84,44,70,79,34,68,85,74,87,70,1,70,83,83,80,83,27},31), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({44,70,79},31), true)
end)
if not ok then debug(_d({66,68,85,74,87,66,85,70,44,70,79,1,70,83,83,80,83,27},31), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({44,70,79,1,79,80,85,1,66,68,85,74,87,70,13,1,66,68,85,74,87,66,85,74,79,72},31))
activateKen()
end
end)
if not ok then debug(_d({44,70,79,44,70,70,81,70,83,1,70,83,83,80,83,27},31), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({44,70,79,1,76,70,70,81,70,83,1,84,85,80,81,81,70,69},31))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({47,49,36,84},31)) end)
if ok then return folder end
debug(_d({72,70,85,47,49,36,84,39,80,77,69,70,83,1,70,83,83,80,83,27},31), folder)
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
local r = model:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local h = model:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
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
debug(_d({72,70,85,47,70,66,83,70,84,85,47,49,36,1,70,83,83,80,83,27},31), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
local hum  = model:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({72,70,85,47,49,36,35,90,47,66,78,70,1,70,83,83,80,83,27},31), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({79,81,68,84,51,70,78,66,74,79,74,79,72,1,70,83,83,80,83,27},31), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({36,86,81,74,69,1,50,86,70,70,79},31))
return queen ~= nil and queen:FindFirstChild(_d({78,80,85,74,80,79,45,70,84,84},31)) ~= nil
end)
if ok then return result end
debug(_d({74,84,50,86,70,70,79,49,73,66,84,70,19,1,70,83,83,80,83,27},31), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,18,19,18,19,26,24,26,21,19,19,26,19,24,23,26},31)
local QUEEN_GRASP_ANIM_ID   = _d({83,67,89,66,84,84,70,85,74,69,27,16,16,18,19,26,25,17,17,17,23,18,17,17,18,24,20,21},31)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
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
debug(_d({74,84,49,77,66,90,74,79,72,34,79,74,78,39,83,80,78,45,74,84,85,1,70,83,83,80,83,27},31), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({35,77,80,68,76,74,79,72},31)) ~= nil
end)
if ok then return result end
debug(_d({74,84,47,49,36,35,77,80,68,76,74,79,72,1,70,83,83,80,83,27},31), result)
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
debug(_d({81,83,70,69,74,68,85,47,49,36,49,80,84,74,85,74,80,79,1,70,83,83,80,83,27},31), result)
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
debug(_d({47,80,1,69,66,78,66,72,70,1,80,79},31), model.Name, _d({71,80,83},31), NPC_STUCK_TIMEOUT, _d({84,1,14,1,84,88,74,85,68,73,74,79,72,1,85,66,83,72,70,85},31))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({85,83,66,68,76,47,49,36,37,66,78,66,72,70,1,70,83,83,80,83,27},31), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({46,80,69,70,77},31)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({35,66,84,70,49,66,83,85},31)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({72,70,85,46,80,69,70,77,39,66,68,70,49,80,84,1,70,83,83,80,83,27},31), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({38,79,87},31))
local folder = env and env:FindFirstChild(_d({52,85,66,85,86,70,84},31))
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
debug(_d({72,70,85,52,85,66,85,86,70,46,80,69,70,77,47,70,66,83,1,70,83,83,80,83,27},31), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({67,66,83,83,70,77,41,49},31))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({72,70,85,52,85,66,85,86,70,41,49,1,70,83,83,80,83,27},31), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({53,80,80,77},31)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({71,74,79,69,53,80,80,77,35,90,34,85,85,83,74,67,86,85,70,1,70,83,83,80,83,27},31), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({53,80,80,77},31)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({71,74,79,69,53,80,80,77,35,90,47,66,78,70,1,70,83,83,80,83,27},31), tool)
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
if not ok then debug(_d({70,82,86,74,81,53,80,80,77,1,70,83,83,80,83,27},31), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({35,66,68,76,81,66,68,76},31))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({53,80,80,77},31)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({71,74,79,69,53,80,80,77,35,90,36,73,74,77,69,47,66,78,70,1,70,83,83,80,83,27},31), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({52,88,80,83,69,38,82,86,74,81},31))
if sword then
equipTool(sword)
return _d({84,88,80,83,69},31)
end
local melee = findToolByAttribute(_d({46,70,77,70,70,53,80,80,77},31))
if melee then
equipTool(melee)
return _d({78,70,77,70,70},31)
end
debug(_d({47,80,1,84,88,80,83,69,1,80,83,1,78,70,77,70,70,1,85,80,80,77,1,71,80,86,79,69},31))
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
if not ok then debug(_d({68,77,74,68,76,46,18,1,70,83,83,80,83,27},31), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({51,80,76,86,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,70,81,81,80},31), args)
elseif style == _d({35,77,66,68,76,45,70,72},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76},31), args)
elseif style == _d({44,66,78,74,84,73,74,76,74},31) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({44,66,78,74,84,73,74,76,74,40,70,81,81,80},31), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,76,90,1,56,66,77,76,19},31), args)
end
end)
if not ok then debug(_d({74,79,87,80,76,70,40,70,81,81,80,1,70,83,83,80,83,27},31), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({81,83,70,84,84,52,76,74,77,77,51,1,70,83,83,80,83,27},31), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({73,80,77,69,35,77,80,68,76,1,70,83,83,80,83,27},31), err) end
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
if not ok then debug(_d({73,80,77,69,35,77,80,68,76,56,73,74,77,70,1,70,83,83,80,83,27},31), err) end
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
debug(_d({72,70,85,40,66,78,70,40,1,70,83,83,80,83,27},31), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({74,84,51,70,66,77,46,18,35,86,84,90,1,70,83,83,80,83,27},31), result)
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
return char ~= nil and char:FindFirstChild(_d({84,85,86,79},31)) ~= nil
end)
if ok then return result end
debug(_d({74,84,52,85,86,79,79,70,69,1,70,83,83,80,83,27},31), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({81,83,70,84,84,52,85,86,79,35,83,70,66,76,1,70,83,83,80,83,27},31), err) end
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
debug(_d({82,86,70,70,79,37,80,69,72,70,54,79,85,74,77,52,66,71,70,27,1,50,86,70,70,79,1,72,80,79,70,1,14,1,70,79,69,74,79,72,1,69,80,69,72,70,1,70,66,83,77,90},31))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({82,86,70,70,79,37,80,69,72,70,54,79,85,74,77,52,66,71,70,1,84,66,71,70,85,90,1,85,74,78,70,80,86,85},31))
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
local info = getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({50,86,70,70,79,1,68,66,84,85,74,79,72,1,69,70,85,70,68,85,70,69,1,14,1,69,80,69,72,74,79,72,1,9,88,66,85,68,73,70,83,10},31))
queenDodgeUntilSafe(function() return getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31)) end)
if enabled and getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31)) then
setNavNamed(_d({36,86,81,74,69,1,50,86,70,70,79},31))
end
queenDodging = false
end
end)
if not ok then debug(_d({82,86,70,70,79,37,80,69,72,70,56,66,85,68,73,70,83,1,70,83,83,80,83,27},31), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({81,80,74,79,85},31) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({79,81,68},31) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({79,66,78,70,69},31) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({72,70,85,47,66,87,53,66,83,72,70,85,84,1,70,83,83,80,83,27},31), aimR)
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
debug(_d({68,80,78,81,86,85,70,45,80,68,76,70,69,36,39,83,66,78,70,1,70,83,83,80,83,27},31), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({81,80,74,79,85},31), point = pos}
phase = _d({78,80,87,70},31)
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
if not ok then debug(_d({79,66,87,53,80,49,80,74,79,85,1,72,70,81,81,80,1,68,73,70,68,76,1,70,83,83,80,83,27},31), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({79,81,68},31)}
phase = _d({78,80,87,70},31)
end
function setNavNamed(name)
NavState = {mode = _d({79,66,78,70,69},31), name = name}
phase = _d({78,80,87,70},31)
end
local function setNavIdle()
NavState = {mode = _d({74,69,77,70},31)}
phase = _d({78,80,87,70},31)
end
local function hasArrived()
return phase == _d({73,80,87,70,83},31)
end
local function startNav()
phase = _d({78,80,87,70},31)
debug(_d({47,66,87,1,77,80,80,81,1,48,47},31))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({49,77,66,90,70,83,1,69,74,70,69,2,1,52,85,80,81,81,74,79,72,1,67,80,85,15},31))
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
debug(_d({49,77,66,90,70,83,1,74,84,1,85,80,80,1,71,66,83,1,71,83,80,78,1,85,66,83,72,70,85,1,9,31,19,17,17,17,1,84,85,86,69,84,10,15,1,45,74,76,70,77,90,1,83,70,84,81,66,88,79,70,69,1,66,85,1,77,80,67,67,90,15,1,52,85,80,81,81,74,79,72,1,67,80,85,15},31))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({64,64,81,83,70,87,49,80,84},31))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({45,66,83,72,70,1,81,80,84,74,85,74,80,79,1,75,86,78,81,1,69,70,85,70,68,85,70,69,27},31), delta, _d({84,85,86,69,84,15,1,81,83,70,87,49,80,84,30},31), prevPos, _d({79,70,88,49,80,84,30},31), pos)
end
end
force:SetAttribute(_d({64,64,81,83,70,87,49,80,84},31), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({78,80,87,70},31) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({73,80,87,70,83},31)
debug(_d({49,73,66,84,70,27,1,73,80,87,70,83},31))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({2,2,2,1,51,38,39,54,52,42,47,40,1,53,48,1,34,49,49,45,58,1,34,35,47,48,51,46,34,45,1,55,38,45,48,36,42,53,58,27},31), finalVel, _d({66,74,78,30},31), aim, _d({81,80,84,30},31), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({73,80,87,70,83},31) then
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
debug(_d({36,80,78,67,66,85,1,77,80,68,76,1,84,76,74,81,81,70,69,13},31), snapDist, _d({84,85,86,69,84,1,71,83,80,78,1,85,66,83,72,70,85,1,195,97,117,1,71,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,78,80,87,70},31))
phase = _d({78,80,87,70},31)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({41,70,66,83,85,67,70,66,85,1,70,83,83,80,83,27},31), err) end
end)
end
local function stopNav()
debug(_d({47,66,87,1,77,80,80,81,1,48,39,39},31))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({78,80,87,70},31)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({53,70,89,85,36,73,66,85,52,70,83,87,74,68,70},31))
local channels = TextChatService:FindFirstChild(_d({53,70,89,85,36,73,66,79,79,70,77,84},31))
local channel = channels and channels:FindFirstChild(_d({51,35,57,40,70,79,70,83,66,77},31))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({37,70,71,66,86,77,85,36,73,66,85,52,90,84,85,70,78,36,73,66,85,38,87,70,79,85,84},31))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({52,66,90,46,70,84,84,66,72,70,51,70,82,86,70,84,85},31))
if sayEvent then
sayEvent:FireServer(message, _d({34,77,77},31))
return
end
debug(_d({84,70,79,69,36,73,66,85,46,70,84,84,66,72,70,27,1,79,80,1,53,70,89,85,36,73,66,85,52,70,83,87,74,68,70,15,51,35,57,40,70,79,70,83,66,77,1,80,83,1,77,70,72,66,68,90,1,52,66,90,46,70,84,84,66,72,70,51,70,82,86,70,84,85,1,71,80,86,79,69,1,71,80,83},31), message)
end)
if not ok then debug(_d({84,70,79,69,36,73,66,85,46,70,84,84,66,72,70,1,70,83,83,80,83,27},31), err) end
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
debug(_d({47,80,85,1,78,66,76,74,79,72,1,81,83,80,72,83,70,84,84,1,85,80,88,66,83,69,1,79,66,87,1,85,66,83,72,70,85,1,71,80,83},31), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({84,1,14,1,84,70,79,69,74,79,72,1,16,86,79,84,85,86,68,76},31))
sendChatMessage(_d({16,86,79,84,85,86,68,76},31))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({88,66,74,85,54,79,85,74,77,34,83,83,74,87,70,69,1,85,74,78,70,80,86,85},31))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({79,66,87,53,80,49,80,74,79,85,36,80,79,71,74,83,78,70,69,27},31), label or _d({85,66,83,72,70,85},31), _d({14,1,69,74,69,1,79,80,85,1,66,83,83,74,87,70,1,88,74,85,73,74,79},31), timeout, _d({84,13,1,83,70,85,83,90,74,79,72,1,80,79,68,70},31))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({79,66,87,53,80,49,80,74,79,85,36,80,79,71,74,83,78,70,69,27},31), label or _d({85,66,83,72,70,85},31), _d({14,1,84,85,74,77,77,1,79,80,85,1,66,83,83,74,87,70,69,1,66,71,85,70,83,1,83,70,85,83,90,13,1,81,83,80,68,70,70,69,74,79,72,1,66,79,90,88,66,90},31))
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
if not ok then debug(_d({79,66,87,53,80,49,80,74,79,85,41,80,77,69,74,79,72,35,77,80,68,76,1,76,70,90,14,69,80,88,79,1,70,83,83,80,83,27},31), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({79,66,87,53,80,49,80,74,79,85,41,80,77,69,74,79,72,35,77,80,68,76,1,76,70,90,14,86,81,1,70,83,83,80,83,27},31), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({56,66,77,76,74,79,72,1,85,80,27},31), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({88,66,77,76,53,80,49,80,74,79,85,1,56,1,69,80,88,79,1,70,83,83,80,83,27},31), err) end
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
debug(_d({53,80,80,76,1,69,66,78,66,72,70,1,88,73,74,77,70,1,88,66,77,76,74,79,72,1,85,80,1,81,80,74,79,85,2,1,52,85,80,81,81,74,79,72,1,88,66,77,76,1,85,80,1,70,79,72,66,72,70,15},31))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({34,83,83,74,87,70,69,1,66,85,27},31), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({52,85,86,68,76,1,69,86,83,74,79,72,1,88,66,77,76,13,1,75,86,78,81,74,79,72,2},31))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({52,85,74,77,77,1,84,85,86,68,76,13,1,85,83,74,72,72,70,83,74,79,72,1,40,70,81,81,80,2},31))
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
debug(_d({46,80,87,74,79,72,1,85,80},31), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({56,66,74,85,74,79,72,1,71,80,83,1,47,49,36,84,1,85,80,1,84,81,66,88,79,1,66,85},31), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({1,1,84,81,66,88,79,1,68,73,70,68,76,27,1,71,80,77,69,70,83,1,70,89,74,84,85,84,1,30},31), folder ~= nil,
_d({13,1,68,73,74,77,69,83,70,79,1,30},31), folder and #folder:GetChildren() or 0,
_d({13,1,66,77,74,87,70,1,30},31), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({47,80,1,47,49,36,84,1,66,81,81,70,66,83,70,69,1,66,85},31), stageName, _d({66,71,85,70,83,1,18,22,84,13,1,78,80,87,74,79,72,1,80,79,1,66,79,90,88,66,90},31))
break
end
end
debug(_d({44,74,77,77,74,79,72,1,47,49,36,84,1,66,85},31), stageName)
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
debug(_d({51,70,85,86,83,79,74,79,72,1,85,80},31), stageName, _d({81,80,84,74,85,74,80,79,1,67,70,71,80,83,70,1,78,80,87,74,79,72,1,80,79},31))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({56,66,74,85,74,79,72,1,22,84,1,66,85},31), stageName, _d({81,80,84,74,85,74,80,79},31))
task.wait(5)
debug(_d({56,66,74,85,74,79,72,1,71,80,83},31), targetHP * 100, _d({6,1,41,49,1,67,70,71,80,83,70,1,78,80,87,74,79,72,1,85,80,1,79,70,89,85,1,84,85,66,72,70},31))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({68,77,70,66,83,70,69},31))
end
local function killNamedNPC(name, targetPos)
debug(_d({46,80,87,74,79,72,1,85,80},31), name)
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
debug(name, _d({69,70,71,70,66,85,70,69},31))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({41,86,78,66,79,80,74,69},31))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({45,70,80,1,81,77,66,90,70,69,1,66,79,74,78,66,85,74,80,79,27},31), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({77,70,80,34,79,74,78,45,80,72,72,70,83,1,81,83,74,79,85,1,70,83,83,80,83,27},31), err2) end
end)
end)
if not ok then debug(_d({84,85,66,83,85,45,70,80,34,79,74,78,45,80,72,72,70,83,1,70,83,83,80,83,27},31), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({46,80,87,74,79,72,1,85,80,1,45,70,80},31))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({45,70,80},31))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({45,70,80},31))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({45,70,80},31))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({45,70,80,1,68,66,84,85,74,79,72},31), which, _d({14,1,69,80,69,72,74,79,72},31))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({45,70,80,1,84,85,66,83,85,70,69,1,67,77,80,68,76,14,67,83,70,66,76,70,83,1,78,74,69,14,67,77,80,68,76,2,1,38,87,66,69,74,79,72,15,15,15},31))
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
if not getNPCByName(_d({45,70,80},31)) then
debug(_d({45,70,80,1,72,80,79,70,1,78,74,69,14,69,80,69,72,70,1,14,1,70,79,69,74,79,72,1,38,79,85,70,74,1,73,80,77,69,1,70,66,83,77,90},31))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({45,70,80},31)) then
setNavNamed(_d({45,70,80},31))
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
debug(_d({45,70,80,1,69,70,71,70,66,85,70,69},31))
stopLeoAnimLogger()
debug(_d({51,70,85,86,83,79,74,79,72,1,85,80,1,45,70,80,1,81,80,84,74,85,74,80,79,1,67,70,71,80,83,70,1,78,80,87,74,79,72,1,80,79},31))
navToPointConfirmed(COORDS.Leo, 30, _d({45,70,80,1,81,80,84,74,85,74,80,79},31))
debug(_d({56,66,74,85,74,79,72,1,22,84,1,66,85,1,45,70,80,1,81,80,84,74,85,74,80,79},31))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({46,80,87,74,79,72,1,85,80},31), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({36,80,86,77,69,1,79,80,85,1,71,74,79,69,1,84,85,66,85,86,70,1,78,80,69,70,77,1,79,70,66,83},31), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({34,85,85,66,68,76,74,79,72},31), coordKey, _d({88,74,85,73},31), weapon or _d({79,80,85,73,74,79,72,1,71,80,86,79,69},31))
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
debug(coordKey, _d({67,66,83,83,70,77,1,69,70,84,85,83,80,90,70,69},31))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({83,70,68,73,70,68,76,52,85,66,85,86,70,27},31), coordKey, _d({14,1,68,80,86,77,69,1,79,80,85,1,71,74,79,69,1,84,85,66,85,86,70,1,78,80,69,70,77,13,1,84,76,74,81,81,74,79,72},31))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({83,70,68,73,70,68,76,52,85,66,85,86,70,27},31), coordKey, _d({84,85,74,77,77,1,66,77,74,87,70,1,9,41,49},31), hp, _d({10,1,14,1,83,70,14,69,70,84,85,83,80,90,74,79,72},31))
destroyStatue(coordKey)
else
debug(_d({83,70,68,73,70,68,76,52,85,66,85,86,70,27},31), coordKey, _d({68,80,79,71,74,83,78,70,69,1,69,70,84,85,83,80,90,70,69},31))
end
end)
if not ok then debug(_d({83,70,68,73,70,68,76,52,85,66,85,86,70,1,70,83,83,80,83,27},31), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({46,80,87,74,79,72,1,85,80,1,50,86,70,70,79},31))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({36,86,81,74,69,1,50,86,70,70,79},31))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31))
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
debug(_d({50,86,70,70,79,1,70,79,85,70,83,70,69,1,81,73,66,84,70,1,19},31))
end
local function finishQueen()
debug(_d({39,74,79,74,84,73,74,79,72,1,50,86,70,70,79},31))
equipSwordOrMelee()
setNavNamed(_d({36,86,81,74,69,1,50,86,70,70,79},31))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({36,86,81,74,69,1,50,86,70,70,79},31))
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
debug(_d({50,86,70,70,79,1,69,70,71,70,66,85,70,69,15,1,49,77,66,79,1,68,80,78,81,77,70,85,70,15},31))
end
local CONFIRMATION_PROMPT_NAME = _d({36,80,79,71,74,83,78,66,85,74,80,79,49,83,80,78,81,85},31)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({51,70,78,80,85,70,38,87,70,79,85},31), 5)
end)
if ok then return result end
debug(_d({72,70,85,51,70,81,77,66,90,51,70,78,80,85,70,1,70,83,83,80,83,27},31), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({42,78,66,72,70,35,86,85,85,80,79},31)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({67,86,85,85,80,79,55,66,77,86,70},31)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({71,74,79,69,35,86,85,85,80,79,35,90,55,66,77,86,70,1,70,83,83,80,83,27},31), result)
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
if not ok then debug(_d({68,77,74,68,76,40,86,74,35,86,85,85,80,79,1,70,83,83,80,83,27},31), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({74,84,52,70,83,87,70,83},31))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({51,70,78,80,85,70,38,87,70,79,85},31))
or inst:FindFirstChild(_d({68,77,74,70,79,85,38,87,70,79,85},31))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({71,74,79,69,34,79,84,88,70,83,36,80,79,79,70,68,85,80,83,1,70,83,83,80,83,27},31), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({36,80,86,77,69,1,79,80,85,1,77,80,68,66,85,70,1,51,70,78,80,85,70,38,87,70,79,85,16,68,77,74,70,79,85,38,87,70,79,85,1,79,70,66,83,1,51,70,81,77,66,90,1,67,86,85,85,80,79,13,1,71,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,68,77,74,68,76},31))
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
debug(_d({71,74,83,70,51,70,81,77,66,90,55,66,77,86,70,1,70,83,83,80,83,27},31), err, _d({14,1,71,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,68,77,74,68,76},31))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({39,66,77,77,74,79,72,1,67,66,68,76,1,85,80,1,67,86,85,85,80,79,55,66,77,86,70,1,84,70,66,83,68,73,1,71,80,83,1,51,70,81,77,66,90},31))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({51,70,81,77,66,90,1,67,86,85,85,80,79,1,79,80,85,1,71,80,86,79,69,1,70,74,85,73,70,83,13,1,72,74,87,74,79,72,1,86,81},31))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({56,66,74,85,74,79,72,1,71,80,83,1,36,80,79,71,74,83,78,66,85,74,80,79,49,83,80,78,81,85,15,51,70,78,80,85,70,38,87,70,79,85},31))
local remote = getReplayRemote()
if not remote then
debug(_d({36,80,79,71,74,83,78,66,85,74,80,79,49,83,80,78,81,85,16,51,70,78,80,85,70,38,87,70,79,85,1,79,80,85,1,71,80,86,79,69,1,88,74,85,73,74,79,1,85,74,78,70,80,86,85},31))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({39,74,83,74,79,72,1,51,70,81,77,66,90,1,87,74,66,1,36,80,79,71,74,83,78,66,85,74,80,79,49,83,80,78,81,85,15,51,70,78,80,85,70,38,87,70,79,85},31))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({39,74,83,70,52,70,83,87,70,83,1,70,83,83,80,83,27},31), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({49,77,66,90,70,83,40,86,74},31), 10)
if not playerGui then
debug(_d({88,66,74,85,39,80,83,48,67,75,70,68,85,74,87,70,84,40,86,74,27,1,79,80,1,49,77,66,90,70,83,40,86,74,1,88,74,85,73,74,79,1,85,74,78,70,80,86,85,13,1,81,83,80,68,70,70,69,74,79,72,1,66,79,90,88,66,90},31))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({48,67,75,70,68,85,74,87,70,84,1,40,54,42,1,71,80,86,79,69,1,14,1,84,85,66,72,70,1,77,80,66,69,70,69},31))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({48,67,75,70,68,85,74,87,70,84,1,40,54,42,1,79,80,85,1,71,80,86,79,69,1,88,74,85,73,74,79,1,85,74,78,70,80,86,85,13,1,81,83,80,68,70,70,69,74,79,72,1,66,79,90,88,66,90},31))
return
end
end
end)
if not ok then debug(_d({88,66,74,85,39,80,83,48,67,75,70,68,85,74,87,70,84,40,86,74,1,70,83,83,80,83,27},31), err) end
end
local function runPlan()
debug(_d({49,77,66,79,1,84,85,66,83,85,70,69},31))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({52,85,66,83,85,74,79,72,1,79,66,87,1,77,80,80,81},31))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({81,80,84,1,17,15,19,84,1,34,39,53,38,51,1,84,85,66,83,85,47,66,87,27},31), rootAfter and rootAfter.Position)
end)
debug(_d({56,66,74,85,74,79,72,1,22,84,1,67,70,71,80,83,70,1,78,80,87,74,79,72,1,85,80,1,52,85,66,72,70,18},31))
task.wait(5)
for _, stage in ipairs({_d({52,85,66,72,70,18},31), _d({52,85,66,72,70,19},31), _d({52,85,66,72,70,20},31), _d({52,85,66,72,70,20,35},31)}) do
if not enabled then return end
local hpTarget = (stage == _d({52,85,66,72,70,20,35},31)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({46,80,87,74,79,72,1,85,80,1,66,83,83,80,88,1,71,77,90,14,69,80,88,79,1,66,83,70,66,1,9,36,86,81,74,69,1,51,66,74,79,10},31))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({37,80,69,72,74,79,72,1,66,83,83,80,88,1,83,66,74,79,1,74,79,1,66,1,84,82,86,66,83,70},31))
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
clearStage(_d({52,85,66,72,70,21},31))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({50,86,70,70,79,1,74,79,1,81,73,66,84,70,1,19,1,14,1,76,70,70,81,74,79,72,1,44,70,79,1,41,66,76,74,1,66,68,85,74,87,70,1,71,83,80,78,1,73,70,83,70,1,80,79},31))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({52,85,66,85,86,70,18},31))
if not enabled then return end
recheckStatue(_d({52,85,66,85,86,70,18},31))
destroyStatue(_d({52,85,66,85,86,70,19},31))
if not enabled then return end
recheckStatue(_d({52,85,66,85,86,70,18},31))
recheckStatue(_d({52,85,66,85,86,70,19},31))
destroyStatue(_d({52,85,66,85,86,70,20},31))
if not enabled then return end
recheckStatue(_d({52,85,66,85,86,70,20},31))
recheckStatue(_d({52,85,66,85,86,70,19},31))
recheckStatue(_d({52,85,66,85,86,70,18},31))
if not enabled then return end
debug(_d({56,66,74,85,74,79,72,1,71,80,83,1,81,73,66,84,70,1,19,1,85,80,1,70,79,69},31))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({49,73,66,84,70,1,19,1,70,79,69,1,88,66,74,85,1,85,74,78,70,80,86,85,13,1,81,83,80,68,70,70,69,74,79,72,1,66,79,90,88,66,90},31))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({46,80,87,74,79,72,1,67,66,68,76,1,85,80,1,50,86,70,70,79,1,84,85,66,72,70,1,81,80,84,74,85,74,80,79},31))
navToPointConfirmed(COORDS.Queen, 30, _d({50,86,70,70,79,1,84,85,66,72,70,1,81,80,84,74,85,74,80,79},31))
debug(_d({56,66,74,85,74,79,72,1,22,84,1,66,85,1,50,86,70,70,79,1,84,85,66,72,70,1,81,80,84,74,85,74,80,79},31))
task.wait(5)
if not enabled then return end
debug(_d({46,80,87,74,79,72,1,85,80,1,81,80,84,85,14,50,86,70,70,79,1,81,80,84,74,85,74,80,79},31))
navToPointConfirmed(COORDS.PostQueen, 30, _d({81,80,84,85,14,50,86,70,70,79,1,81,80,84,74,85,74,80,79},31))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({38,79,66,67,77,74,79,72,13,1,81,80,84,1,35,38,39,48,51,38,1,81,77,66,79,27},31), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({49,77,66,79,1,70,83,83,80,83,27},31), err2) end
end)
debug(_d({38,79,66,67,77,70,69,27},31), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({38,79,66,67,77,70,69,27},31), enabled)
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
if not ok then debug(_d({42,79,81,86,85,35,70,72,66,79,1,70,83,83,80,83,27},31), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({40,66,78,70,1,77,80,66,69,70,69,13,1,66,86,85,80,14,84,85,66,83,85,74,79,72,1,85,73,70,1,81,77,66,79},31))
enableBot()
end)
if not ok then debug(_d({34,86,85,80,84,85,66,83,85,1,70,83,83,80,83,27},31), err) end
end)
debug(_d({45,80,66,69,70,69,1,195,97,117,1,66,86,85,80,14,84,85,66,83,85,74,79,72,1,80,79,68,70,1,85,73,70,1,72,66,78,70,1,71,74,79,74,84,73,70,84,1,77,80,66,69,74,79,72,1,9,81,83,70,84,84,1,49,1,85,80,1,85,80,72,72,77,70,1,78,66,79,86,66,77,77,90,10},31))
end)()