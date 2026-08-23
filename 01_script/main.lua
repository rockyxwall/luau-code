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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({61,89,78,102,82,95,96},19))
local UserInputService    = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local RunService          = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM                 = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local ReplicatedStorage    = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({72,47,92,96,96,47,92,97,74},19), _d({68,95,92,91,84,13,84,78,90,82,13,207,109,129,13,61,89,78,80,82,54,81,39},19), game.PlaceId, _d({66,91,86,99,82,95,96,82,54,81,39},19), game.GameId, _d({26,13,91,92,97,13,95,98,91,91,86,91,84},19))
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
local LEO_PILLAR_ANIM_ID   = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,33,33,30,33,30,32,31,36},19)
local LEO_ENTEI_ANIM_ID    = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,33,33,30,32,37,31,36,37},19)
local LEO_HIKEN_ANIM_ID    = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,31,29,38,30,36,33,29,36},19)
local LEO_FIREFLY_ANIM_ID  = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,31,29,31,32,35,30,34,33},19)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({60,79,87,82,80,97,86,99,82,96},19)
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
local REPLAY_BUTTON_VALUE   = _d({63,82,93,89,78,102},19)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({90,92,99,82},19)
local NavState   = {mode = _d({86,81,89,82},19)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({72,47,92,96,96,47,92,97,74},19), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end)
if ok then return root end
debug(_d({84,82,97,63,92,92,97,13,82,95,95,92,95,39},19), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end)
if ok then return hum end
debug(_d({84,82,97,53,98,90,78,91,92,86,81,13,82,95,95,92,95,39},19), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({22,13,92,95,13,54,91,96,97,78,91,80,82,27,91,82,100,21},19)Attachment")
att.Name = _d({76,76,53,92,99,82,95,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,53,92,99,82,95,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,53,92,99,82,95,51,92,95,80,82},19)
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
debug(_d({84,82,97,60,95,48,95,82,78,97,82,51,92,95,80,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local force = root:FindFirstChild(_d({76,76,53,92,99,82,95,51,92,95,80,82},19))
local att   = root:FindFirstChild(_d({76,76,53,92,99,82,95,46,97,97},19))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({80,89,82,78,91,98,93,51,92,95,80,82,13,82,95,95,92,95,39},19), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({47,98,96,92,58,82,89,82,82},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,47,98,96,92,46,80,97,86,99,82,13,82,95,95,92,95,39},19), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({47,98,96,92},19))
end)
if not ok then debug(_d({78,80,97,86,99,78,97,82,47,98,96,92,13,82,95,95,92,95,39},19), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({47,98,96,92,13,91,92,97,13,78,80,97,86,99,82,25,13,78,80,97,86,99,78,97,86,91,84},19))
activateBuso()
end
end)
if not ok then debug(_d({47,98,96,92,56,82,82,93,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({47,98,96,92,13,88,82,82,93,82,95,13,96,97,92,93,93,82,81},19))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({56,82,91,53,78,88,86},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,56,82,91,46,80,97,86,99,82,13,82,95,95,92,95,39},19), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({56,82,91},19), true)
end)
if not ok then debug(_d({78,80,97,86,99,78,97,82,56,82,91,13,82,95,95,92,95,39},19), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({56,82,91,13,91,92,97,13,78,80,97,86,99,82,25,13,78,80,97,86,99,78,97,86,91,84},19))
activateKen()
end
end)
if not ok then debug(_d({56,82,91,56,82,82,93,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({56,82,91,13,88,82,82,93,82,95,13,96,97,92,93,93,82,81},19))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({59,61,48,96},19)) end)
if ok then return folder end
debug(_d({84,82,97,59,61,48,96,51,92,89,81,82,95,13,82,95,95,92,95,39},19), folder)
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
local r = model:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local h = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
debug(_d({84,82,97,59,82,78,95,82,96,97,59,61,48,13,82,95,95,92,95,39},19), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum  = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({84,82,97,59,61,48,47,102,59,78,90,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({91,93,80,96,63,82,90,78,86,91,86,91,84,13,82,95,95,92,95,39},19), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({48,98,93,86,81,13,62,98,82,82,91},19))
return queen ~= nil and queen:FindFirstChild(_d({90,92,97,86,92,91,57,82,96,96},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,62,98,82,82,91,61,85,78,96,82,31,13,82,95,95,92,95,39},19), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,30,31,30,31,38,36,38,33,31,31,38,31,36,35,38},19)
local QUEEN_GRASP_ANIM_ID   = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,30,31,38,37,29,29,29,35,30,29,29,30,36,32,33},19)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
debug(_d({86,96,61,89,78,102,86,91,84,46,91,86,90,51,95,92,90,57,86,96,97,13,82,95,95,92,95,39},19), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({47,89,92,80,88,86,91,84},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,59,61,48,47,89,92,80,88,86,91,84,13,82,95,95,92,95,39},19), result)
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
debug(_d({93,95,82,81,86,80,97,59,61,48,61,92,96,86,97,86,92,91,13,82,95,95,92,95,39},19), result)
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
debug(_d({59,92,13,81,78,90,78,84,82,13,92,91},19), model.Name, _d({83,92,95},19), NPC_STUCK_TIMEOUT, _d({96,13,26,13,96,100,86,97,80,85,86,91,84,13,97,78,95,84,82,97},19))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({97,95,78,80,88,59,61,48,49,78,90,78,84,82,13,82,95,95,92,95,39},19), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({58,92,81,82,89},19)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({47,78,96,82,61,78,95,97},19)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({84,82,97,58,92,81,82,89,51,78,80,82,61,92,96,13,82,95,95,92,95,39},19), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({50,91,99},19))
local folder = env and env:FindFirstChild(_d({64,97,78,97,98,82,96},19))
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
debug(_d({84,82,97,64,97,78,97,98,82,58,92,81,82,89,59,82,78,95,13,82,95,95,92,95,39},19), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({79,78,95,95,82,89,53,61},19))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({84,82,97,64,97,78,97,98,82,53,61,13,82,95,95,92,95,39},19), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,46,97,97,95,86,79,98,97,82,13,82,95,95,92,95,39},19), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({65,92,92,89},19)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,59,78,90,82,13,82,95,95,92,95,39},19), tool)
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
if not ok then debug(_d({82,94,98,86,93,65,92,92,89,13,82,95,95,92,95,39},19), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,48,85,86,89,81,59,78,90,82,13,82,95,95,92,95,39},19), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({64,100,92,95,81,50,94,98,86,93},19))
if sword then
equipTool(sword)
return _d({96,100,92,95,81},19)
end
local melee = findToolByAttribute(_d({58,82,89,82,82,65,92,92,89},19))
if melee then
equipTool(melee)
return _d({90,82,89,82,82},19)
end
debug(_d({59,92,13,96,100,92,95,81,13,92,95,13,90,82,89,82,82,13,97,92,92,89,13,83,92,98,91,81},19))
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
if not ok then debug(_d({80,89,86,80,88,58,30,13,82,95,95,92,95,39},19), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
end
end)
if not ok then debug(_d({86,91,99,92,88,82,52,82,93,93,92,13,82,95,95,92,95,39},19), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({93,95,82,96,96,64,88,86,89,89,63,13,82,95,95,92,95,39},19), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({85,92,89,81,47,89,92,80,88,13,82,95,95,92,95,39},19), err) end
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
if not ok then debug(_d({85,92,89,81,47,89,92,80,88,68,85,86,89,82,13,82,95,95,92,95,39},19), err) end
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
debug(_d({84,82,97,52,78,90,82,52,13,82,95,95,92,95,39},19), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({86,96,63,82,78,89,58,30,47,98,96,102,13,82,95,95,92,95,39},19), result)
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
return char ~= nil and char:FindFirstChild(_d({96,97,98,91},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,64,97,98,91,91,82,81,13,82,95,95,92,95,39},19), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({93,95,82,96,96,64,97,98,91,47,95,82,78,88,13,82,95,95,92,95,39},19), err) end
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
debug(_d({94,98,82,82,91,49,92,81,84,82,66,91,97,86,89,64,78,83,82,39,13,62,98,82,82,91,13,84,92,91,82,13,26,13,82,91,81,86,91,84,13,81,92,81,84,82,13,82,78,95,89,102},19))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({94,98,82,82,91,49,92,81,84,82,66,91,97,86,89,64,78,83,82,13,96,78,83,82,97,102,13,97,86,90,82,92,98,97},19))
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
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({62,98,82,82,91,13,80,78,96,97,86,91,84,13,81,82,97,82,80,97,82,81,13,26,13,81,92,81,84,86,91,84,13,21,100,78,97,80,85,82,95,22},19))
queenDodgeUntilSafe(function() return getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) end)
if enabled and getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) then
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
end
queenDodging = false
end
end)
if not ok then debug(_d({94,98,82,82,91,49,92,81,84,82,68,78,97,80,85,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({93,92,86,91,97},19) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({91,93,80},19) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({91,78,90,82,81},19) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({84,82,97,59,78,99,65,78,95,84,82,97,96,13,82,95,95,92,95,39},19), aimR)
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
debug(_d({80,92,90,93,98,97,82,57,92,80,88,82,81,48,51,95,78,90,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({93,92,86,91,97},19), point = pos}
phase = _d({90,92,99,82},19)
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
if not ok then debug(_d({91,78,99,65,92,61,92,86,91,97,13,84,82,93,93,92,13,80,85,82,80,88,13,82,95,95,92,95,39},19), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({91,93,80},19)}
phase = _d({90,92,99,82},19)
end
function setNavNamed(name)
NavState = {mode = _d({91,78,90,82,81},19), name = name}
phase = _d({90,92,99,82},19)
end
local function setNavIdle()
NavState = {mode = _d({86,81,89,82},19)}
phase = _d({90,92,99,82},19)
end
local function hasArrived()
return phase == _d({85,92,99,82,95},19)
end
local function startNav()
phase = _d({90,92,99,82},19)
debug(_d({59,78,99,13,89,92,92,93,13,60,59},19))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({61,89,78,102,82,95,13,81,86,82,81,14,13,64,97,92,93,93,86,91,84,13,79,92,97,27},19))
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
debug(_d({61,89,78,102,82,95,13,86,96,13,97,92,92,13,83,78,95,13,83,95,92,90,13,97,78,95,84,82,97,13,21,43,31,29,29,29,13,96,97,98,81,96,22,27,13,57,86,88,82,89,102,13,95,82,96,93,78,100,91,82,81,13,78,97,13,89,92,79,79,102,27,13,64,97,92,93,93,86,91,84,13,79,92,97,27},19))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({76,76,93,95,82,99,61,92,96},19))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({57,78,95,84,82,13,93,92,96,86,97,86,92,91,13,87,98,90,93,13,81,82,97,82,80,97,82,81,39},19), delta, _d({96,97,98,81,96,27,13,93,95,82,99,61,92,96,42},19), prevPos, _d({91,82,100,61,92,96,42},19), pos)
end
end
force:SetAttribute(_d({76,76,93,95,82,99,61,92,96},19), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({90,92,99,82},19) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({85,92,99,82,95},19)
debug(_d({61,85,78,96,82,39,13,85,92,99,82,95},19))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({14,14,14,13,63,50,51,66,64,54,59,52,13,65,60,13,46,61,61,57,70,13,46,47,59,60,63,58,46,57,13,67,50,57,60,48,54,65,70,39},19), finalVel, _d({78,86,90,42},19), aim, _d({93,92,96,42},19), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({85,92,99,82,95},19) then
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
debug(_d({48,92,90,79,78,97,13,89,92,80,88,13,96,88,86,93,93,82,81,25},19), snapDist, _d({96,97,98,81,96,13,83,95,92,90,13,97,78,95,84,82,97,13,207,109,129,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,90,92,99,82},19))
phase = _d({90,92,99,82},19)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({53,82,78,95,97,79,82,78,97,13,82,95,95,92,95,39},19), err) end
end)
end
local function stopNav()
debug(_d({59,78,99,13,89,92,92,93,13,60,51,51},19))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({90,92,99,82},19)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({65,82,101,97,48,85,78,97,64,82,95,99,86,80,82},19))
local channels = TextChatService:FindFirstChild(_d({65,82,101,97,48,85,78,91,91,82,89,96},19))
local channel = channels and channels:FindFirstChild(_d({63,47,69,52,82,91,82,95,78,89},19))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({49,82,83,78,98,89,97,48,85,78,97,64,102,96,97,82,90,48,85,78,97,50,99,82,91,97,96},19))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({64,78,102,58,82,96,96,78,84,82,63,82,94,98,82,96,97},19))
if sayEvent then
sayEvent:FireServer(message, _d({46,89,89},19))
return
end
debug(_d({96,82,91,81,48,85,78,97,58,82,96,96,78,84,82,39,13,91,92,13,65,82,101,97,48,85,78,97,64,82,95,99,86,80,82,27,63,47,69,52,82,91,82,95,78,89,13,92,95,13,89,82,84,78,80,102,13,64,78,102,58,82,96,96,78,84,82,63,82,94,98,82,96,97,13,83,92,98,91,81,13,83,92,95},19), message)
end)
if not ok then debug(_d({96,82,91,81,48,85,78,97,58,82,96,96,78,84,82,13,82,95,95,92,95,39},19), err) end
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
debug(_d({59,92,97,13,90,78,88,86,91,84,13,93,95,92,84,95,82,96,96,13,97,92,100,78,95,81,13,91,78,99,13,97,78,95,84,82,97,13,83,92,95},19), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({96,13,26,13,96,82,91,81,86,91,84,13,28,98,91,96,97,98,80,88},19))
sendChatMessage(_d({28,98,91,96,97,98,80,88},19))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({100,78,86,97,66,91,97,86,89,46,95,95,86,99,82,81,13,97,86,90,82,92,98,97},19))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({91,78,99,65,92,61,92,86,91,97,48,92,91,83,86,95,90,82,81,39},19), label or _d({97,78,95,84,82,97},19), _d({26,13,81,86,81,13,91,92,97,13,78,95,95,86,99,82,13,100,86,97,85,86,91},19), timeout, _d({96,25,13,95,82,97,95,102,86,91,84,13,92,91,80,82},19))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({91,78,99,65,92,61,92,86,91,97,48,92,91,83,86,95,90,82,81,39},19), label or _d({97,78,95,84,82,97},19), _d({26,13,96,97,86,89,89,13,91,92,97,13,78,95,95,86,99,82,81,13,78,83,97,82,95,13,95,82,97,95,102,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
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
if not ok then debug(_d({91,78,99,65,92,61,92,86,91,97,53,92,89,81,86,91,84,47,89,92,80,88,13,88,82,102,26,81,92,100,91,13,82,95,95,92,95,39},19), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({91,78,99,65,92,61,92,86,91,97,53,92,89,81,86,91,84,47,89,92,80,88,13,88,82,102,26,98,93,13,82,95,95,92,95,39},19), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({68,78,89,88,86,91,84,13,97,92,39},19), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({100,78,89,88,65,92,61,92,86,91,97,13,68,13,81,92,100,91,13,82,95,95,92,95,39},19), err) end
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
debug(_d({65,92,92,88,13,81,78,90,78,84,82,13,100,85,86,89,82,13,100,78,89,88,86,91,84,13,97,92,13,93,92,86,91,97,14,13,64,97,92,93,93,86,91,84,13,100,78,89,88,13,97,92,13,82,91,84,78,84,82,27},19))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({46,95,95,86,99,82,81,13,78,97,39},19), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({64,97,98,80,88,13,81,98,95,86,91,84,13,100,78,89,88,25,13,87,98,90,93,86,91,84,14},19))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({64,97,86,89,89,13,96,97,98,80,88,25,13,97,95,86,84,84,82,95,86,91,84,13,52,82,93,93,92,14},19))
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
debug(_d({58,92,99,86,91,84,13,97,92},19), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,59,61,48,96,13,97,92,13,96,93,78,100,91,13,78,97},19), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({13,13,96,93,78,100,91,13,80,85,82,80,88,39,13,83,92,89,81,82,95,13,82,101,86,96,97,96,13,42},19), folder ~= nil,
_d({25,13,80,85,86,89,81,95,82,91,13,42},19), folder and #folder:GetChildren() or 0,
_d({25,13,78,89,86,99,82,13,42},19), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({59,92,13,59,61,48,96,13,78,93,93,82,78,95,82,81,13,78,97},19), stageName, _d({78,83,97,82,95,13,30,34,96,25,13,90,92,99,86,91,84,13,92,91,13,78,91,102,100,78,102},19))
break
end
end
debug(_d({56,86,89,89,86,91,84,13,59,61,48,96,13,78,97},19), stageName)
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
debug(_d({63,82,97,98,95,91,86,91,84,13,97,92},19), stageName, _d({93,92,96,86,97,86,92,91,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,92,91},19))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97},19), stageName, _d({93,92,96,86,97,86,92,91},19))
task.wait(5)
debug(_d({68,78,86,97,86,91,84,13,83,92,95},19), targetHP * 100, _d({18,13,53,61,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,97,92,13,91,82,101,97,13,96,97,78,84,82},19))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({80,89,82,78,95,82,81},19))
end
local function killNamedNPC(name, targetPos)
debug(_d({58,92,99,86,91,84,13,97,92},19), name)
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
debug(name, _d({81,82,83,82,78,97,82,81},19))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({57,82,92,13,93,89,78,102,82,81,13,78,91,86,90,78,97,86,92,91,39},19), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({89,82,92,46,91,86,90,57,92,84,84,82,95,13,93,95,86,91,97,13,82,95,95,92,95,39},19), err2) end
end)
end)
if not ok then debug(_d({96,97,78,95,97,57,82,92,46,91,86,90,57,92,84,84,82,95,13,82,95,95,92,95,39},19), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({58,92,99,86,91,84,13,97,92,13,57,82,92},19))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({57,82,92},19))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({57,82,92},19))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({57,82,92},19))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({57,82,92,13,80,78,96,97,86,91,84},19), which, _d({26,13,81,92,81,84,86,91,84},19))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({57,82,92,13,96,97,78,95,97,82,81,13,79,89,92,80,88,26,79,95,82,78,88,82,95,13,90,86,81,26,79,89,92,80,88,14,13,50,99,78,81,86,91,84,27,27,27},19))
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
if not getNPCByName(_d({57,82,92},19)) then
debug(_d({57,82,92,13,84,92,91,82,13,90,86,81,26,81,92,81,84,82,13,26,13,82,91,81,86,91,84,13,50,91,97,82,86,13,85,92,89,81,13,82,78,95,89,102},19))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({57,82,92},19)) then
setNavNamed(_d({57,82,92},19))
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
debug(_d({57,82,92,13,81,82,83,82,78,97,82,81},19))
stopLeoAnimLogger()
debug(_d({63,82,97,98,95,91,86,91,84,13,97,92,13,57,82,92,13,93,92,96,86,97,86,92,91,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,92,91},19))
navToPointConfirmed(COORDS.Leo, 30, _d({57,82,92,13,93,92,96,86,97,86,92,91},19))
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97,13,57,82,92,13,93,92,96,86,97,86,92,91},19))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({58,92,99,86,91,84,13,97,92},19), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,96,97,78,97,98,82,13,90,92,81,82,89,13,91,82,78,95},19), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({46,97,97,78,80,88,86,91,84},19), coordKey, _d({100,86,97,85},19), weapon or _d({91,92,97,85,86,91,84,13,83,92,98,91,81},19))
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
debug(coordKey, _d({79,78,95,95,82,89,13,81,82,96,97,95,92,102,82,81},19))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({26,13,80,92,98,89,81,13,91,92,97,13,83,86,91,81,13,96,97,78,97,98,82,13,90,92,81,82,89,25,13,96,88,86,93,93,86,91,84},19))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({96,97,86,89,89,13,78,89,86,99,82,13,21,53,61},19), hp, _d({22,13,26,13,95,82,26,81,82,96,97,95,92,102,86,91,84},19))
destroyStatue(coordKey)
else
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({80,92,91,83,86,95,90,82,81,13,81,82,96,97,95,92,102,82,81},19))
end
end)
if not ok then debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,13,82,95,95,92,95,39},19), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({58,92,99,86,91,84,13,97,92,13,62,98,82,82,91},19))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
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
debug(_d({62,98,82,82,91,13,82,91,97,82,95,82,81,13,93,85,78,96,82,13,31},19))
end
local function finishQueen()
debug(_d({51,86,91,86,96,85,86,91,84,13,62,98,82,82,91},19))
equipSwordOrMelee()
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
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
debug(_d({62,98,82,82,91,13,81,82,83,82,78,97,82,81,27,13,61,89,78,91,13,80,92,90,93,89,82,97,82,27},19))
end
local CONFIRMATION_PROMPT_NAME = _d({48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97},19)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({63,82,90,92,97,82,50,99,82,91,97},19), 5)
end)
if ok then return result end
debug(_d({84,82,97,63,82,93,89,78,102,63,82,90,92,97,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({54,90,78,84,82,47,98,97,97,92,91},19)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({79,98,97,97,92,91,67,78,89,98,82},19)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({83,86,91,81,47,98,97,97,92,91,47,102,67,78,89,98,82,13,82,95,95,92,95,39},19), result)
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
if not ok then debug(_d({80,89,86,80,88,52,98,86,47,98,97,97,92,91,13,82,95,95,92,95,39},19), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({86,96,64,82,95,99,82,95},19))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({63,82,90,92,97,82,50,99,82,91,97},19))
or inst:FindFirstChild(_d({80,89,86,82,91,97,50,99,82,91,97},19))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({83,86,91,81,46,91,96,100,82,95,48,92,91,91,82,80,97,92,95,13,82,95,95,92,95,39},19), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({48,92,98,89,81,13,91,92,97,13,89,92,80,78,97,82,13,63,82,90,92,97,82,50,99,82,91,97,28,80,89,86,82,91,97,50,99,82,91,97,13,91,82,78,95,13,63,82,93,89,78,102,13,79,98,97,97,92,91,25,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,80,89,86,80,88},19))
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
debug(_d({83,86,95,82,63,82,93,89,78,102,67,78,89,98,82,13,82,95,95,92,95,39},19), err, _d({26,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,80,89,86,80,88},19))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({51,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,79,98,97,97,92,91,67,78,89,98,82,13,96,82,78,95,80,85,13,83,92,95,13,63,82,93,89,78,102},19))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({63,82,93,89,78,102,13,79,98,97,97,92,91,13,91,92,97,13,83,92,98,91,81,13,82,86,97,85,82,95,25,13,84,86,99,86,91,84,13,98,93},19))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,27,63,82,90,92,97,82,50,99,82,91,97},19))
local remote = getReplayRemote()
if not remote then
debug(_d({48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,28,63,82,90,92,97,82,50,99,82,91,97,13,91,92,97,13,83,92,98,91,81,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97},19))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({51,86,95,86,91,84,13,63,82,93,89,78,102,13,99,86,78,13,48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,27,63,82,90,92,97,82,50,99,82,91,97},19))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({51,86,95,82,64,82,95,99,82,95,13,82,95,95,92,95,39},19), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
if not playerGui then
debug(_d({100,78,86,97,51,92,95,60,79,87,82,80,97,86,99,82,96,52,98,86,39,13,91,92,13,61,89,78,102,82,95,52,98,86,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({60,79,87,82,80,97,86,99,82,96,13,52,66,54,13,83,92,98,91,81,13,26,13,96,97,78,84,82,13,89,92,78,81,82,81},19))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({60,79,87,82,80,97,86,99,82,96,13,52,66,54,13,91,92,97,13,83,92,98,91,81,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
return
end
end
end)
if not ok then debug(_d({100,78,86,97,51,92,95,60,79,87,82,80,97,86,99,82,96,52,98,86,13,82,95,95,92,95,39},19), err) end
end
local function runPlan()
debug(_d({61,89,78,91,13,96,97,78,95,97,82,81},19))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({64,97,78,95,97,86,91,84,13,91,78,99,13,89,92,92,93},19))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({93,92,96,13,29,27,31,96,13,46,51,65,50,63,13,96,97,78,95,97,59,78,99,39},19), rootAfter and rootAfter.Position)
end)
debug(_d({68,78,86,97,86,91,84,13,34,96,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,97,92,13,64,97,78,84,82,30},19))
task.wait(5)
for _, stage in ipairs({_d({64,97,78,84,82,30},19), _d({64,97,78,84,82,31},19), _d({64,97,78,84,82,32},19), _d({64,97,78,84,82,32,47},19)}) do
if not enabled then return end
local hpTarget = (stage == _d({64,97,78,84,82,32,47},19)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,97,92,13,78,95,95,92,100,13,83,89,102,26,81,92,100,91,13,78,95,82,78,13,21,48,98,93,86,81,13,63,78,86,91,22},19))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({49,92,81,84,86,91,84,13,78,95,95,92,100,13,95,78,86,91,13,86,91,13,78,13,96,94,98,78,95,82},19))
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
clearStage(_d({64,97,78,84,82,33},19))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({62,98,82,82,91,13,86,91,13,93,85,78,96,82,13,31,13,26,13,88,82,82,93,86,91,84,13,56,82,91,13,53,78,88,86,13,78,80,97,86,99,82,13,83,95,92,90,13,85,82,95,82,13,92,91},19))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({64,97,78,97,98,82,30},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,30},19))
destroyStatue(_d({64,97,78,97,98,82,31},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,30},19))
recheckStatue(_d({64,97,78,97,98,82,31},19))
destroyStatue(_d({64,97,78,97,98,82,32},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,32},19))
recheckStatue(_d({64,97,78,97,98,82,31},19))
recheckStatue(_d({64,97,78,97,98,82,30},19))
if not enabled then return end
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,93,85,78,96,82,13,31,13,97,92,13,82,91,81},19))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({61,85,78,96,82,13,31,13,82,91,81,13,100,78,86,97,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,79,78,80,88,13,97,92,13,62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
navToPointConfirmed(COORDS.Queen, 30, _d({62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97,13,62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
task.wait(5)
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,97,92,13,93,92,96,97,26,62,98,82,82,91,13,93,92,96,86,97,86,92,91},19))
navToPointConfirmed(COORDS.PostQueen, 30, _d({93,92,96,97,26,62,98,82,82,91,13,93,92,96,86,97,86,92,91},19))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({50,91,78,79,89,86,91,84,25,13,93,92,96,13,47,50,51,60,63,50,13,93,89,78,91,39},19), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({61,89,78,91,13,82,95,95,92,95,39},19), err2) end
end)
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
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
if not ok then debug(_d({54,91,93,98,97,47,82,84,78,91,13,82,95,95,92,95,39},19), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({52,78,90,82,13,89,92,78,81,82,81,25,13,78,98,97,92,26,96,97,78,95,97,86,91,84,13,97,85,82,13,93,89,78,91},19))
enableBot()
end)
if not ok then debug(_d({46,98,97,92,96,97,78,95,97,13,82,95,95,92,95,39},19), err) end
end)
debug(_d({57,92,78,81,82,81,13,207,109,129,13,78,98,97,92,26,96,97,78,95,97,86,91,84,13,92,91,80,82,13,97,85,82,13,84,78,90,82,13,83,86,91,86,96,85,82,96,13,89,92,78,81,86,91,84,13,21,93,95,82,96,96,13,61,13,97,92,13,97,92,84,84,89,82,13,90,78,91,98,78,89,89,102,22},19))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,63,78,102,83,86,82,89,81,28,90,78,86,91,28,96,92,98,95,80,82,27,89,98,78},19)
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
error(_d({72,53,92,95,92,13,99,31,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,13,63,78,102,83,86,82,89,81,13,66,54,13,57,86,79,95,78,95,102,27},19))
end
local Window = Rayfield:CreateWindow({
Name = _d({53,92,95,92,13,53,92,95,92,13,71,26,51,78,95,90,13,99,31},19),
LoadingTitle = _d({57,92,78,81,86,91,84,13,53,92,95,92,13,99,31,27,27,27},19),
LoadingSubtitle = _d({64,86,89,82,91,97,13,46,86,90,13,60,93,97,86,90,86,103,82,81},19),
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
local MainTab = Window:CreateTab(_d({46,98,97,92,13,51,78,95,90},19), 4483362458)
local SkillTab = Window:CreateTab(_d({64,88,86,89,89,13,64,82,97,97,86,91,84,96},19), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)) or (bp and bp:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = boss:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
if key == _d({53,86,97},19) then
return target.CFrame
elseif key == _d({65,78,95,84,82,97},19) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({72,53,92,95,92,13,99,31,74,13,58,82,97,78,97,78,79,89,82,13,85,92,92,88,13,83,78,86,89,82,81,39,13},19) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({72,53,92,95,92,13,99,31,74,13,48,89,82,78,91,82,81,13,98,93,13,93,95,82,99,86,92,98,96,13,96,82,96,96,86,92,91,27},19))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,68,78,86,97,86,91,84,13,83,92,95,13,47,92,96,96,13,64,93,78,100,91},19)) end
print(_d({72,53,92,95,92,13,99,31,74,13,47,92,96,96},19), _G.HoroSelectedBoss, _d({86,96,13,91,92,97,13,96,93,78,100,91,82,81,27,13,68,78,86,97,86,91,84,27,27,27},19))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,63,98,91,91,86,91,84,13,48,92,90,79,92},19)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,48,13,21,56,78,90,86,88,78,103,82,22},19))
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
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,71,13,21,58,86,91,86,13,47,78,95,95,78,84,82,22},19))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,50,13,21,64,97,98,91,22},19))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({72,53,92,95,92,13,99,31,74,13,51,86,95,82,81,13,63,13,21,49,82,97,92,91,78,97,86,92,91,22},19))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,64,89,82,82,93,86,91,84,13,21},19) .. string.format(_d({18,27,30,83},19), finalSleep) .. _d({96,22},19)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({64,97,78,97,98,96,39,13,54,81,89,82},19))
MainTab:CreateDropdown({
Name = _d({64,82,89,82,80,97,13,47,92,96,96},19),
Options = {_d({46,101,82,13,53,78,91,81,13,57,92,84,78,91},19), _d({47,78,91,81,86,97,13,47,92,96,96},19), _d({55,98,103,92,13,97,85,82,13,49,86,78,90,92,91,81,79,78,80,88},19)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({72,53,92,95,92,13,99,31,74,13,64,82,89,82,80,97,82,81,13,97,78,95,84,82,97,39},19), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({64,97,78,95,97,13,46,98,97,92,13,51,78,95,90},19),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({64,82,89,82,80,97,13,47,92,96,96,13,63,82,94,98,86,95,82,81},19),
Content = _d({70,92,98,13,90,98,96,97,13,96,82,89,82,80,97,13,78,13,79,92,96,96,13,83,86,95,96,97,13,79,82,83,92,95,82,13,82,91,78,79,89,86,91,84,13,46,98,97,92,13,51,78,95,90,14},19),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({64,97,78,97,98,96,39,13,54,81,89,82},19)) end
end
print(_d({72,53,92,95,92,13,99,31,74,13,46,98,97,92,13,51,78,95,90,39},19), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({49,82,96,97,95,92,102,13,66,54},19),
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
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local function scanTools()
local toolNames = {}
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
if bp then
for _, item in ipairs(bp:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
table.insert(toolNames, item.Name)
end
end
end
local char = LocalPlayer.Character
if char then
for _, item in ipairs(char:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
table.insert(toolNames, item.Name)
end
end
end
if #toolNames == 0 then
table.insert(toolNames, "Combat")
end
return toolNames
end
local availableWeapons = scanTools()
local autoGrind = false
local autoBuyGeppo = false
local bypassPeliCheck = false
local selectedMob = "Bandit"
local selectedWeapon = availableWeapons[1] or "Combat"
local hoverHeight = 6.5
local geppoCooldown = 3.5
local targetNPC = nil
local lastGeppoTime = 0
local boughtGeppo = false
local lastPosition = Vector3.zero
local stuckTime = 0
local unstuckActive = false
local mobList = {"Bandit", _d({47,78,91,81,86,97,13,47,92,96,96},19), "Daph_d({25,13},19)Haku_d({25,13},19)Lily_d({25,13},19)Lion Pride_d({25,13},19)Marquan_d({25,13},19)Robo_d({25,13},19)Ronny_d({25,13},19)Sarah"}
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end
local function getPeli()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder and statsFolder:FindFirstChild("Stats_d({22,13,78,91,81,13,96,97,78,97,96,51,92,89,81,82,95,27,64,97,78,97,96,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,21},19)Peli") then
return statsFolder.Stats.Peli.Value
end
return 0
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == selectedMob then
local root = npc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = npc:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function findYiNPC()
local folder = Workspace:FindFirstChild(_d({59,61,48,96},19))
local yi = folder and folder:FindFirstChild("Yi")
if yi then return yi end
for _, obj in ipairs(Workspace:GetDescendants()) do
if obj.Name == "Yi_d({13,78,91,81,13,92,79,87,39,54,96,46,21},19)Model") then
return obj
end
end
return nil
end
local function getSafeHeightAdjustment(pos)
local raycastParams = RaycastParams.new()
local excludeList = {LocalPlayer.Character}
local npcsFolder = Workspace:FindFirstChild(_d({59,61,48,96},19))
if npcsFolder then
table.insert(excludeList, npcsFolder)
end
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = excludeList
local raycastResult = Workspace:Raycast(pos, Vector3.new(0, -300, 0), raycastParams)
if raycastResult then
local hitName = raycastResult.Instance.Name:lower()
local isWater = hitName:find("water_d({22,13,92,95,13,85,86,97,59,78,90,82,39,83,86,91,81,21},19)sea_d({22,13,92,95,13,85,86,97,59,78,90,82,39,83,86,91,81,21},19)ocean") or raycastResult.Material == Enum.Material.Water
local currentHeight = pos.Y - raycastResult.Position.Y
if currentHeight < 20 then
return 20 - currentHeight
end
else
if pos.Y < 50 then
return 50 - pos.Y
end
end
return 0
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({47,78,96,82,61,78,95,97},19)) then
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
local function getOrCreateForce(root)
local att = root:FindFirstChild("__GrinderAtt_d({22,13,92,95,13,54,91,96,97,78,91,80,82,27,91,82,100,21},19)Attachment")
att.Name = "__GrinderAtt"
att.Parent = root
local force = root:FindFirstChild("__GrinderForce")
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = "__GrinderForce"
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.zero
force.Parent = root
end
return force
end
local function cleanupForce()
if not autoGrind then
local root = getRoot()
if root then
local force = root:FindFirstChild("__GrinderForce")
local att = root:FindFirstChild("__GrinderAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
end
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
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if not autoGrind then
cleanupForce()
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
end
end
end)
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < geppoCooldown then return end
lastGeppoTime = now
pcall(function()
local char = LocalPlayer.Character
local root = getRoot()
if not char or not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
local style = statsFolder and statsFolder.Stats.FightingStyle.Value or "None"
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
end
end)
end
local function checkStuck(currentPos, targetPos, deltaTime)
deltaTime = deltaTime or 0.2
if (targetPos - currentPos).Magnitude > 5 then
if (currentPos - lastPosition).Magnitude < 1 then
stuckTime = stuckTime + deltaTime
if stuckTime > 1.5 then
unstuckActive = true
stuckTime = 0
end
else
stuckTime = 0
end
else
stuckTime = 0
end
lastPosition = currentPos
end
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local peli = getPeli()
if autoBuyGeppo and (peli >= 50000 or bypassPeliCheck) and not boughtGeppo then
local yi = findYiNPC()
if yi then
local yiRoot = yi:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if yiRoot then
local targetPos = yiRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local dir = (targetPos - myRoot.Position)
if dir.Magnitude > 8 then
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
else
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, yiRoot.Position)
local prompt = yi:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Gepo Grinder] fireproximityprompt not supported by executor!")
end
task.wait(1.5)
if getPeli() < 50000 and not bypassPeliCheck then
boughtGeppo = true
end
end
end
return
end
end
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local weaponTool = bp and bp:FindFirstChild(selectedWeapon)
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({22,13,78,91,81,13,91,93,80,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,68,85,86,80,85,54,96,46,21},19)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, targetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (targetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({22,13,78,91,81,13,83,86,91,78,89,59,93,80,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,68,85,86,80,85,54,96,46,21},19)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local force = getOrCreateForce(myRoot)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
checkStuck(myRoot.Position, finalTargetPos, 0.05)
if unstuckActive then
force.VectorVelocity = Vector3.new(0, 40, 0)
task.wait(1)
unstuckActive = false
else
local dir = (finalTargetPos - myRoot.Position)
local velocityVec = dir.Unit * 60
local heightAdjust = getSafeHeightAdjustment(myRoot.Position)
if heightAdjust > 0 then
velocityVec = velocityVec + Vector3.new(0, heightAdjust * 2, 0)
end
force.VectorVelocity = velocityVec
end
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({22,13,78,91,81,13,83,86,91,78,89,59,93,80,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,68,85,86,80,85,54,96,46,21},19)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
force.VectorVelocity = Vector3.zero
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
force.VectorVelocity = dir.Unit * 30
task.wait(0.05)
end
end
end
end
else
cleanupForce()
end
else
cleanupForce()
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
cleanupForce()
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
local playerGui = LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
if playerGui then
local oldUI = playerGui:FindFirstChild("GPOGrinderNativeUI")
if oldUI then pcall(function() oldUI:Destroy() end) end
local mobileBtn = playerGui:FindFirstChild("GrinderMobileToggle")
if mobileBtn then pcall(function() mobileBtn:Destroy() end) end
end
if _G.GrinderLibrary then
pcall(function() _G.GrinderLibrary:Unload() end)
_G.GrinderLibrary = nil
end
print("[Gepo Grinder] Cleaned up previous session.")
end
local function buildWindUI()
local ok, WindUI = pcall(function()
return loadstring(game:HttpGet("https://raw.githubusercontent.com/rockyxwall/WindUI/main/dist/main.lua"))()
end)
if not ok or type(WindUI) ~= "table" then
warn("[Gepo Grinder] Failed to load WindUI.")
return
end
local Window = WindUI:CreateWindow({
Title = "Gepo Grinder v0.0.18",
Icon = _d({96,100,92,95,81},19),
Folder = "GepoGrinder",
Size = UDim2.fromOffset(500, 400),
Transparent = true,
Theme = "Dark",
OpenButton = {
Title = "Gepo Grinder",
Enabled = true,
Draggable = true,
OnlyMobile = false,
},
})
_G.GrinderLibrary = Window
local tabFarm = Window:Tab({ Title = _d({46,98,97,92,13,51,78,95,90},19), Icon = _d({96,100,92,95,81},19) })
local tabGeppo = Window:Tab({ Title = "Geppo Buyer_d({25,13,54,80,92,91,13,42,13},19)shopping-cart" })
local tabSettings = Window:Tab({ Title = "Settings_d({25,13,54,80,92,91,13,42,13},19)settings" })
tabFarm:Toggle({
Title = "Auto Grind Mobs [P]",
Value = false,
Callback = function(val)
toggleAutoFarm(val)
end
})
tabFarm:Dropdown({
Title = "Target Mob",
Values = mobList,
Value = selectedMob,
Callback = function(val)
selectedMob = tostring(val)
targetNPC = nil
end
})
tabFarm:Dropdown({
Title = "Weapon / Melee",
Values = availableWeapons,
Value = selectedWeapon,
Callback = function(val)
selectedWeapon = tostring(val)
end
})
local peliLabel = tabFarm:Paragraph({
Title = "Peli Wallet",
Desc = "Loading..."
})
task.spawn(function()
while _G.GrinderLibrary do
task.wait(1)
pcall(function()
local peli = getPeli()
if peliLabel and peliLabel.Set then
peliLabel:Set({ Title = "Peli Wallet_d({25,13,49,82,96,80,13,42,13,97,92,96,97,95,86,91,84,21,93,82,89,86,22,13,27,27,13,21,93,82,89,86,13,43,42,13,34,29,29,29,29,13,78,91,81,13},19) [READY!]_d({13,92,95,13},19)") })
end
end)
end
end)
tabGeppo:Toggle({
Title = "Auto Buy Geppo",
Value = false,
Callback = function(val)
autoBuyGeppo = val
end
})
tabGeppo:Toggle({
Title = "Bypass 50k Peli Check",
Value = false,
Callback = function(val)
bypassPeliCheck = val
end
})
tabSettings:Button({
Title = "Destroy UI & Stop Everything",
Callback = function()
if _G.GepoGrinderCleanup then pcall(_G.GepoGrinderCleanup) end
end
})
end
task.spawn(buildWindUI)
print("[Gepo Grinder Hub] v0.0.18 loaded with WindUI.")
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local inputConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum = char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({22,13,92,95,13,54,91,96,97,78,91,80,82,27,91,82,100,21},19)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
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
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local currentPos = root.Position
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {char}
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * 8, raycastParams)
if forwardHit then
local clearanceY = nil
for heightOffset = 4, 100, 4 do
local scanOrigin = currentPos + Vector3.new(0, heightOffset, 0)
local scanHit = Workspace:Raycast(scanOrigin, moveUnit * 8, raycastParams)
if not scanHit then
clearanceY = scanOrigin.Y
break
end
end
if clearanceY then
isClimbing = true
climbTargetY = clearanceY + HEIGHT_OFFSET
else
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
local finalTargetY = isClimbing and climbTargetY or currentTargetY
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (FLIGHT_SPEED * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -15, 15)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + Vector3.new(look.X, 0, look.Z).Unit)
end
end)
print("[Easy Travel] Flight enabled.")
end
local function stopFlight()
flightEnabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print("[Easy Travel] Flight disabled.")
end
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
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravelCleanup = nil
print("[Easy Travel] Completely unloaded and cleaned up script state.")
end
print("[Easy Travel] Loaded. Press 'P' to toggle flight. Press _d({50,91,81},19) to completely unload.")
return {
Start = startFlight,
Stop = stopFlight,
}
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({86,81,89,82},19)
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
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({86,91,99,92,88,82,52,82,93,93,92,13,82,95,95,92,95,39},19), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({22,13,92,95,13,54,91,96,97,78,91,80,82,27,91,82,100,21},19)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
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
local root = char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({68,78,89,88,86,91,84,13,97,92,39},19), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({100,78,89,88,65,92,61,92,86,91,97,13,68,13,81,92,100,91,13,82,95,95,92,95,39},19), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({46,95,95,86,99,82,81,13,78,97,39},19), pos)
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
if item:IsA("Model_d({22,13,78,91,81,13,86,97,82,90,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,21},19)HumanoidRootPart_d({22,13,78,91,81,13,86,97,82,90,39,51,86,91,81,51,86,95,96,97,48,85,86,89,81,68,85,86,80,85,54,96,46,21},19)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)).Health > 0 then
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
mode = _d({86,81,89,82},19)
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
if mode == _d({85,92,99,82,95},19) then
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
local playerGui = LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
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
statusLabel.Text = _d({64,97,78,97,98,96,39,13,54,81,89,82},19)
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
enableBot(_d({85,92,99,82,95},19))
statusLabel.Text = "Status: Hovering _d({13,27,27,13,99,78,89,13,27,27,13},19) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({13,27,27,13,99,78,89,13,27,27,13},19) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({13,27,27,13,99,78,89,13,27,27,13},19) studs)"
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
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({25,13},19)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({25,13},19)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({25,13},19)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({25,13},19)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({25,13},19)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()