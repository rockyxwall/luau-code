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
local Players            = game:GetService(_d({27,55,44,68,48,61,62},53))
local UserInputService    = game:GetService(_d({32,62,48,61,20,57,59,64,63,30,48,61,65,52,46,48},53))
local RunService          = game:GetService(_d({29,64,57,30,48,61,65,52,46,48},53))
local VIM                 = game:GetService(_d({33,52,61,63,64,44,55,20,57,59,64,63,24,44,57,44,50,48,61},53))
local ReplicatedStorage    = game:GetService(_d({29,48,59,55,52,46,44,63,48,47,30,63,58,61,44,50,48},53))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({38,13,58,62,62,13,58,63,40},53), _d({34,61,58,57,50,235,50,44,56,48,235,173,75,95,235,27,55,44,46,48,20,47,5},53), game.PlaceId, _d({32,57,52,65,48,61,62,48,20,47,5},53), game.GameId, _d({248,235,57,58,63,235,61,64,57,57,52,57,50},53))
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
local LEO_PILLAR_ANIM_ID   = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,0,253,255,255,252,255,252,254,253,2},53)
local LEO_ENTEI_ANIM_ID    = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,0,253,255,255,252,254,3,253,2,3},53)
local LEO_HIKEN_ANIM_ID    = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,0,253,253,251,4,252,2,255,251,2},53)
local LEO_FIREFLY_ANIM_ID  = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,0,253,253,251,253,254,1,252,0,255},53)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({26,45,53,48,46,63,52,65,48,62},53)
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
local REPLAY_BUTTON_VALUE   = _d({29,48,59,55,44,68},53)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({56,58,65,48},53)
local NavState   = {mode = _d({52,47,55,48},53)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({38,13,58,62,62,13,58,63,40},53), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
end)
if ok then return root end
debug(_d({50,48,63,29,58,58,63,235,48,61,61,58,61,5},53), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
end)
if ok then return hum end
debug(_d({50,48,63,19,64,56,44,57,58,52,47,235,48,61,61,58,61,5},53), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({42,42,19,58,65,48,61,12,63,63},53)) or Instance.new(_d({12,63,63,44,46,51,56,48,57,63},53))
att.Name = _d({42,42,19,58,65,48,61,12,63,63},53)
att.Parent = root
local force = root:FindFirstChild(_d({42,42,19,58,65,48,61,17,58,61,46,48},53))
if not force then
force = Instance.new(_d({23,52,57,48,44,61,33,48,55,58,46,52,63,68},53))
force.Name = _d({42,42,19,58,65,48,61,17,58,61,46,48},53)
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
debug(_d({50,48,63,26,61,14,61,48,44,63,48,17,58,61,46,48,235,48,61,61,58,61,5},53), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if not root then return end
local force = root:FindFirstChild(_d({42,42,19,58,65,48,61,17,58,61,46,48},53))
local att   = root:FindFirstChild(_d({42,42,19,58,65,48,61,12,63,63},53))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({46,55,48,44,57,64,59,17,58,61,46,48,235,48,61,61,58,61,5},53), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({13,64,62,58,24,48,55,48,48},53)) ~= nil
end)
if ok then return result end
debug(_d({52,62,13,64,62,58,12,46,63,52,65,48,235,48,61,61,58,61,5},53), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({13,64,62,58},53))
end)
if not ok then debug(_d({44,46,63,52,65,44,63,48,13,64,62,58,235,48,61,61,58,61,5},53), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({13,64,62,58,235,57,58,63,235,44,46,63,52,65,48,247,235,44,46,63,52,65,44,63,52,57,50},53))
activateBuso()
end
end)
if not ok then debug(_d({13,64,62,58,22,48,48,59,48,61,235,48,61,61,58,61,5},53), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({13,64,62,58,235,54,48,48,59,48,61,235,62,63,58,59,59,48,47},53))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({22,48,57,19,44,54,52},53)) ~= nil
end)
if ok then return result end
debug(_d({52,62,22,48,57,12,46,63,52,65,48,235,48,61,61,58,61,5},53), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({22,48,57},53), true)
end)
if not ok then debug(_d({44,46,63,52,65,44,63,48,22,48,57,235,48,61,61,58,61,5},53), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({22,48,57,235,57,58,63,235,44,46,63,52,65,48,247,235,44,46,63,52,65,44,63,52,57,50},53))
activateKen()
end
end)
if not ok then debug(_d({22,48,57,22,48,48,59,48,61,235,48,61,61,58,61,5},53), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({22,48,57,235,54,48,48,59,48,61,235,62,63,58,59,59,48,47},53))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({25,27,14,62},53)) end)
if ok then return folder end
debug(_d({50,48,63,25,27,14,62,17,58,55,47,48,61,235,48,61,61,58,61,5},53), folder)
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
local r = model:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local h = model:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
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
debug(_d({50,48,63,25,48,44,61,48,62,63,25,27,14,235,48,61,61,58,61,5},53), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
local hum  = model:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({50,48,63,25,27,14,13,68,25,44,56,48,235,48,61,61,58,61,5},53), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({57,59,46,62,29,48,56,44,52,57,52,57,50,235,48,61,61,58,61,5},53), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({14,64,59,52,47,235,28,64,48,48,57},53))
return queen ~= nil and queen:FindFirstChild(_d({56,58,63,52,58,57,23,48,62,62},53)) ~= nil
end)
if ok then return result end
debug(_d({52,62,28,64,48,48,57,27,51,44,62,48,253,235,48,61,61,58,61,5},53), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,252,253,252,253,4,2,4,255,253,253,4,253,2,1,4},53)
local QUEEN_GRASP_ANIM_ID   = _d({61,45,67,44,62,62,48,63,52,47,5,250,250,252,253,4,3,251,251,251,1,252,251,251,252,2,254,255},53)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
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
debug(_d({52,62,27,55,44,68,52,57,50,12,57,52,56,17,61,58,56,23,52,62,63,235,48,61,61,58,61,5},53), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({13,55,58,46,54,52,57,50},53)) ~= nil
end)
if ok then return result end
debug(_d({52,62,25,27,14,13,55,58,46,54,52,57,50,235,48,61,61,58,61,5},53), result)
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
debug(_d({59,61,48,47,52,46,63,25,27,14,27,58,62,52,63,52,58,57,235,48,61,61,58,61,5},53), result)
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
debug(_d({25,58,235,47,44,56,44,50,48,235,58,57},53), model.Name, _d({49,58,61},53), NPC_STUCK_TIMEOUT, _d({62,235,248,235,62,66,52,63,46,51,52,57,50,235,63,44,61,50,48,63},53))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({63,61,44,46,54,25,27,14,15,44,56,44,50,48,235,48,61,61,58,61,5},53), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({24,58,47,48,55},53)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({13,44,62,48,27,44,61,63},53)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({50,48,63,24,58,47,48,55,17,44,46,48,27,58,62,235,48,61,61,58,61,5},53), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({16,57,65},53))
local folder = env and env:FindFirstChild(_d({30,63,44,63,64,48,62},53))
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
debug(_d({50,48,63,30,63,44,63,64,48,24,58,47,48,55,25,48,44,61,235,48,61,61,58,61,5},53), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({45,44,61,61,48,55,19,27},53))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({50,48,63,30,63,44,63,64,48,19,27,235,48,61,61,58,61,5},53), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({31,58,58,55},53)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({49,52,57,47,31,58,58,55,13,68,12,63,63,61,52,45,64,63,48,235,48,61,61,58,61,5},53), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({31,58,58,55},53)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({49,52,57,47,31,58,58,55,13,68,25,44,56,48,235,48,61,61,58,61,5},53), tool)
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
if not ok then debug(_d({48,60,64,52,59,31,58,58,55,235,48,61,61,58,61,5},53), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({13,44,46,54,59,44,46,54},53))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({31,58,58,55},53)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({49,52,57,47,31,58,58,55,13,68,14,51,52,55,47,25,44,56,48,235,48,61,61,58,61,5},53), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({30,66,58,61,47,16,60,64,52,59},53))
if sword then
equipTool(sword)
return _d({62,66,58,61,47},53)
end
local melee = findToolByAttribute(_d({24,48,55,48,48,31,58,58,55},53))
if melee then
equipTool(melee)
return _d({56,48,55,48,48},53)
end
debug(_d({25,58,235,62,66,58,61,47,235,58,61,235,56,48,55,48,48,235,63,58,58,55,235,49,58,64,57,47},53))
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
if not ok then debug(_d({46,55,52,46,54,24,252,235,48,61,61,58,61,5},53), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({19,64,56,44,57,58,52,47,29,58,58,63,27,44,61,63},53))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({30,63,44,63,62},53) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({29,58,54,64,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({18,48,59,59,58},53), args)
elseif style == _d({13,55,44,46,54,23,48,50},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54},53), args)
elseif style == _d({22,44,56,52,62,51,52,54,52},53) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({22,44,56,52,62,51,52,54,52,18,48,59,59,58},53), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,54,68,235,34,44,55,54,253},53), args)
end
end)
if not ok then debug(_d({52,57,65,58,54,48,18,48,59,59,58,235,48,61,61,58,61,5},53), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({59,61,48,62,62,30,54,52,55,55,29,235,48,61,61,58,61,5},53), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({51,58,55,47,13,55,58,46,54,235,48,61,61,58,61,5},53), err) end
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
if not ok then debug(_d({51,58,55,47,13,55,58,46,54,34,51,52,55,48,235,48,61,61,58,61,5},53), err) end
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
debug(_d({50,48,63,18,44,56,48,18,235,48,61,61,58,61,5},53), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({52,62,29,48,44,55,24,252,13,64,62,68,235,48,61,61,58,61,5},53), result)
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
return char ~= nil and char:FindFirstChild(_d({62,63,64,57},53)) ~= nil
end)
if ok then return result end
debug(_d({52,62,30,63,64,57,57,48,47,235,48,61,61,58,61,5},53), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({59,61,48,62,62,30,63,64,57,13,61,48,44,54,235,48,61,61,58,61,5},53), err) end
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
debug(_d({60,64,48,48,57,15,58,47,50,48,32,57,63,52,55,30,44,49,48,5,235,28,64,48,48,57,235,50,58,57,48,235,248,235,48,57,47,52,57,50,235,47,58,47,50,48,235,48,44,61,55,68},53))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({60,64,48,48,57,15,58,47,50,48,32,57,63,52,55,30,44,49,48,235,62,44,49,48,63,68,235,63,52,56,48,58,64,63},53))
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
local info = getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({28,64,48,48,57,235,46,44,62,63,52,57,50,235,47,48,63,48,46,63,48,47,235,248,235,47,58,47,50,52,57,50,235,243,66,44,63,46,51,48,61,244},53))
queenDodgeUntilSafe(function() return getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53)) end)
if enabled and getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53)) then
setNavNamed(_d({14,64,59,52,47,235,28,64,48,48,57},53))
end
queenDodging = false
end
end)
if not ok then debug(_d({60,64,48,48,57,15,58,47,50,48,34,44,63,46,51,48,61,235,48,61,61,58,61,5},53), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({59,58,52,57,63},53) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({57,59,46},53) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({57,44,56,48,47},53) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({50,48,63,25,44,65,31,44,61,50,48,63,62,235,48,61,61,58,61,5},53), aimR)
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
debug(_d({46,58,56,59,64,63,48,23,58,46,54,48,47,14,17,61,44,56,48,235,48,61,61,58,61,5},53), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({59,58,52,57,63},53), point = pos}
phase = _d({56,58,65,48},53)
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
if not ok then debug(_d({57,44,65,31,58,27,58,52,57,63,235,50,48,59,59,58,235,46,51,48,46,54,235,48,61,61,58,61,5},53), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({57,59,46},53)}
phase = _d({56,58,65,48},53)
end
function setNavNamed(name)
NavState = {mode = _d({57,44,56,48,47},53), name = name}
phase = _d({56,58,65,48},53)
end
local function setNavIdle()
NavState = {mode = _d({52,47,55,48},53)}
phase = _d({56,58,65,48},53)
end
local function hasArrived()
return phase == _d({51,58,65,48,61},53)
end
local function startNav()
phase = _d({56,58,65,48},53)
debug(_d({25,44,65,235,55,58,58,59,235,26,25},53))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({27,55,44,68,48,61,235,47,52,48,47,236,235,30,63,58,59,59,52,57,50,235,45,58,63,249},53))
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
debug(_d({27,55,44,68,48,61,235,52,62,235,63,58,58,235,49,44,61,235,49,61,58,56,235,63,44,61,50,48,63,235,243,9,253,251,251,251,235,62,63,64,47,62,244,249,235,23,52,54,48,55,68,235,61,48,62,59,44,66,57,48,47,235,44,63,235,55,58,45,45,68,249,235,30,63,58,59,59,52,57,50,235,45,58,63,249},53))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({42,42,59,61,48,65,27,58,62},53))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({23,44,61,50,48,235,59,58,62,52,63,52,58,57,235,53,64,56,59,235,47,48,63,48,46,63,48,47,5},53), delta, _d({62,63,64,47,62,249,235,59,61,48,65,27,58,62,8},53), prevPos, _d({57,48,66,27,58,62,8},53), pos)
end
end
force:SetAttribute(_d({42,42,59,61,48,65,27,58,62},53), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({56,58,65,48},53) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({51,58,65,48,61},53)
debug(_d({27,51,44,62,48,5,235,51,58,65,48,61},53))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({236,236,236,235,29,16,17,32,30,20,25,18,235,31,26,235,12,27,27,23,36,235,12,13,25,26,29,24,12,23,235,33,16,23,26,14,20,31,36,5},53), finalVel, _d({44,52,56,8},53), aim, _d({59,58,62,8},53), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({51,58,65,48,61},53) then
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
debug(_d({14,58,56,45,44,63,235,55,58,46,54,235,62,54,52,59,59,48,47,247},53), snapDist, _d({62,63,64,47,62,235,49,61,58,56,235,63,44,61,50,48,63,235,173,75,95,235,49,44,55,55,52,57,50,235,45,44,46,54,235,63,58,235,56,58,65,48},53))
phase = _d({56,58,65,48},53)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({19,48,44,61,63,45,48,44,63,235,48,61,61,58,61,5},53), err) end
end)
end
local function stopNav()
debug(_d({25,44,65,235,55,58,58,59,235,26,17,17},53))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({56,58,65,48},53)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({31,48,67,63,14,51,44,63,30,48,61,65,52,46,48},53))
local channels = TextChatService:FindFirstChild(_d({31,48,67,63,14,51,44,57,57,48,55,62},53))
local channel = channels and channels:FindFirstChild(_d({29,13,35,18,48,57,48,61,44,55},53))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({15,48,49,44,64,55,63,14,51,44,63,30,68,62,63,48,56,14,51,44,63,16,65,48,57,63,62},53))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({30,44,68,24,48,62,62,44,50,48,29,48,60,64,48,62,63},53))
if sayEvent then
sayEvent:FireServer(message, _d({12,55,55},53))
return
end
debug(_d({62,48,57,47,14,51,44,63,24,48,62,62,44,50,48,5,235,57,58,235,31,48,67,63,14,51,44,63,30,48,61,65,52,46,48,249,29,13,35,18,48,57,48,61,44,55,235,58,61,235,55,48,50,44,46,68,235,30,44,68,24,48,62,62,44,50,48,29,48,60,64,48,62,63,235,49,58,64,57,47,235,49,58,61},53), message)
end)
if not ok then debug(_d({62,48,57,47,14,51,44,63,24,48,62,62,44,50,48,235,48,61,61,58,61,5},53), err) end
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
debug(_d({25,58,63,235,56,44,54,52,57,50,235,59,61,58,50,61,48,62,62,235,63,58,66,44,61,47,235,57,44,65,235,63,44,61,50,48,63,235,49,58,61},53), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({62,235,248,235,62,48,57,47,52,57,50,235,250,64,57,62,63,64,46,54},53))
sendChatMessage(_d({250,64,57,62,63,64,46,54},53))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({66,44,52,63,32,57,63,52,55,12,61,61,52,65,48,47,235,63,52,56,48,58,64,63},53))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({57,44,65,31,58,27,58,52,57,63,14,58,57,49,52,61,56,48,47,5},53), label or _d({63,44,61,50,48,63},53), _d({248,235,47,52,47,235,57,58,63,235,44,61,61,52,65,48,235,66,52,63,51,52,57},53), timeout, _d({62,247,235,61,48,63,61,68,52,57,50,235,58,57,46,48},53))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({57,44,65,31,58,27,58,52,57,63,14,58,57,49,52,61,56,48,47,5},53), label or _d({63,44,61,50,48,63},53), _d({248,235,62,63,52,55,55,235,57,58,63,235,44,61,61,52,65,48,47,235,44,49,63,48,61,235,61,48,63,61,68,247,235,59,61,58,46,48,48,47,52,57,50,235,44,57,68,66,44,68},53))
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
if not ok then debug(_d({57,44,65,31,58,27,58,52,57,63,19,58,55,47,52,57,50,13,55,58,46,54,235,54,48,68,248,47,58,66,57,235,48,61,61,58,61,5},53), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({57,44,65,31,58,27,58,52,57,63,19,58,55,47,52,57,50,13,55,58,46,54,235,54,48,68,248,64,59,235,48,61,61,58,61,5},53), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({34,44,55,54,52,57,50,235,63,58,5},53), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({66,44,55,54,31,58,27,58,52,57,63,235,34,235,47,58,66,57,235,48,61,61,58,61,5},53), err) end
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
debug(_d({31,58,58,54,235,47,44,56,44,50,48,235,66,51,52,55,48,235,66,44,55,54,52,57,50,235,63,58,235,59,58,52,57,63,236,235,30,63,58,59,59,52,57,50,235,66,44,55,54,235,63,58,235,48,57,50,44,50,48,249},53))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({12,61,61,52,65,48,47,235,44,63,5},53), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({30,63,64,46,54,235,47,64,61,52,57,50,235,66,44,55,54,247,235,53,64,56,59,52,57,50,236},53))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({30,63,52,55,55,235,62,63,64,46,54,247,235,63,61,52,50,50,48,61,52,57,50,235,18,48,59,59,58,236},53))
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
debug(_d({24,58,65,52,57,50,235,63,58},53), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({34,44,52,63,52,57,50,235,49,58,61,235,25,27,14,62,235,63,58,235,62,59,44,66,57,235,44,63},53), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({235,235,62,59,44,66,57,235,46,51,48,46,54,5,235,49,58,55,47,48,61,235,48,67,52,62,63,62,235,8},53), folder ~= nil,
_d({247,235,46,51,52,55,47,61,48,57,235,8},53), folder and #folder:GetChildren() or 0,
_d({247,235,44,55,52,65,48,235,8},53), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({25,58,235,25,27,14,62,235,44,59,59,48,44,61,48,47,235,44,63},53), stageName, _d({44,49,63,48,61,235,252,0,62,247,235,56,58,65,52,57,50,235,58,57,235,44,57,68,66,44,68},53))
break
end
end
debug(_d({22,52,55,55,52,57,50,235,25,27,14,62,235,44,63},53), stageName)
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
debug(_d({29,48,63,64,61,57,52,57,50,235,63,58},53), stageName, _d({59,58,62,52,63,52,58,57,235,45,48,49,58,61,48,235,56,58,65,52,57,50,235,58,57},53))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({34,44,52,63,52,57,50,235,0,62,235,44,63},53), stageName, _d({59,58,62,52,63,52,58,57},53))
task.wait(5)
debug(_d({34,44,52,63,52,57,50,235,49,58,61},53), targetHP * 100, _d({240,235,19,27,235,45,48,49,58,61,48,235,56,58,65,52,57,50,235,63,58,235,57,48,67,63,235,62,63,44,50,48},53))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({46,55,48,44,61,48,47},53))
end
local function killNamedNPC(name, targetPos)
debug(_d({24,58,65,52,57,50,235,63,58},53), name)
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
debug(name, _d({47,48,49,48,44,63,48,47},53))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({19,64,56,44,57,58,52,47},53))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({23,48,58,235,59,55,44,68,48,47,235,44,57,52,56,44,63,52,58,57,5},53), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({55,48,58,12,57,52,56,23,58,50,50,48,61,235,59,61,52,57,63,235,48,61,61,58,61,5},53), err2) end
end)
end)
if not ok then debug(_d({62,63,44,61,63,23,48,58,12,57,52,56,23,58,50,50,48,61,235,48,61,61,58,61,5},53), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({24,58,65,52,57,50,235,63,58,235,23,48,58},53))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({23,48,58},53))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({23,48,58},53))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({23,48,58},53))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({23,48,58,235,46,44,62,63,52,57,50},53), which, _d({248,235,47,58,47,50,52,57,50},53))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({23,48,58,235,62,63,44,61,63,48,47,235,45,55,58,46,54,248,45,61,48,44,54,48,61,235,56,52,47,248,45,55,58,46,54,236,235,16,65,44,47,52,57,50,249,249,249},53))
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
if not getNPCByName(_d({23,48,58},53)) then
debug(_d({23,48,58,235,50,58,57,48,235,56,52,47,248,47,58,47,50,48,235,248,235,48,57,47,52,57,50,235,16,57,63,48,52,235,51,58,55,47,235,48,44,61,55,68},53))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({23,48,58},53)) then
setNavNamed(_d({23,48,58},53))
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
debug(_d({23,48,58,235,47,48,49,48,44,63,48,47},53))
stopLeoAnimLogger()
debug(_d({29,48,63,64,61,57,52,57,50,235,63,58,235,23,48,58,235,59,58,62,52,63,52,58,57,235,45,48,49,58,61,48,235,56,58,65,52,57,50,235,58,57},53))
navToPointConfirmed(COORDS.Leo, 30, _d({23,48,58,235,59,58,62,52,63,52,58,57},53))
debug(_d({34,44,52,63,52,57,50,235,0,62,235,44,63,235,23,48,58,235,59,58,62,52,63,52,58,57},53))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({24,58,65,52,57,50,235,63,58},53), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({14,58,64,55,47,235,57,58,63,235,49,52,57,47,235,62,63,44,63,64,48,235,56,58,47,48,55,235,57,48,44,61},53), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({12,63,63,44,46,54,52,57,50},53), coordKey, _d({66,52,63,51},53), weapon or _d({57,58,63,51,52,57,50,235,49,58,64,57,47},53))
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
debug(coordKey, _d({45,44,61,61,48,55,235,47,48,62,63,61,58,68,48,47},53))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({61,48,46,51,48,46,54,30,63,44,63,64,48,5},53), coordKey, _d({248,235,46,58,64,55,47,235,57,58,63,235,49,52,57,47,235,62,63,44,63,64,48,235,56,58,47,48,55,247,235,62,54,52,59,59,52,57,50},53))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({61,48,46,51,48,46,54,30,63,44,63,64,48,5},53), coordKey, _d({62,63,52,55,55,235,44,55,52,65,48,235,243,19,27},53), hp, _d({244,235,248,235,61,48,248,47,48,62,63,61,58,68,52,57,50},53))
destroyStatue(coordKey)
else
debug(_d({61,48,46,51,48,46,54,30,63,44,63,64,48,5},53), coordKey, _d({46,58,57,49,52,61,56,48,47,235,47,48,62,63,61,58,68,48,47},53))
end
end)
if not ok then debug(_d({61,48,46,51,48,46,54,30,63,44,63,64,48,235,48,61,61,58,61,5},53), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({24,58,65,52,57,50,235,63,58,235,28,64,48,48,57},53))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({14,64,59,52,47,235,28,64,48,48,57},53))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53))
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
debug(_d({28,64,48,48,57,235,48,57,63,48,61,48,47,235,59,51,44,62,48,235,253},53))
end
local function finishQueen()
debug(_d({17,52,57,52,62,51,52,57,50,235,28,64,48,48,57},53))
equipSwordOrMelee()
setNavNamed(_d({14,64,59,52,47,235,28,64,48,48,57},53))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({14,64,59,52,47,235,28,64,48,48,57},53))
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
debug(_d({28,64,48,48,57,235,47,48,49,48,44,63,48,47,249,235,27,55,44,57,235,46,58,56,59,55,48,63,48,249},53))
end
local CONFIRMATION_PROMPT_NAME = _d({14,58,57,49,52,61,56,44,63,52,58,57,27,61,58,56,59,63},53)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({29,48,56,58,63,48,16,65,48,57,63},53), 5)
end)
if ok then return result end
debug(_d({50,48,63,29,48,59,55,44,68,29,48,56,58,63,48,235,48,61,61,58,61,5},53), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({27,55,44,68,48,61,18,64,52},53))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({20,56,44,50,48,13,64,63,63,58,57},53)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({45,64,63,63,58,57,33,44,55,64,48},53)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({49,52,57,47,13,64,63,63,58,57,13,68,33,44,55,64,48,235,48,61,61,58,61,5},53), result)
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
if not ok then debug(_d({46,55,52,46,54,18,64,52,13,64,63,63,58,57,235,48,61,61,58,61,5},53), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({52,62,30,48,61,65,48,61},53))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({29,48,56,58,63,48,16,65,48,57,63},53))
or inst:FindFirstChild(_d({46,55,52,48,57,63,16,65,48,57,63},53))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({49,52,57,47,12,57,62,66,48,61,14,58,57,57,48,46,63,58,61,235,48,61,61,58,61,5},53), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({14,58,64,55,47,235,57,58,63,235,55,58,46,44,63,48,235,29,48,56,58,63,48,16,65,48,57,63,250,46,55,52,48,57,63,16,65,48,57,63,235,57,48,44,61,235,29,48,59,55,44,68,235,45,64,63,63,58,57,247,235,49,44,55,55,52,57,50,235,45,44,46,54,235,63,58,235,46,55,52,46,54},53))
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
debug(_d({49,52,61,48,29,48,59,55,44,68,33,44,55,64,48,235,48,61,61,58,61,5},53), err, _d({248,235,49,44,55,55,52,57,50,235,45,44,46,54,235,63,58,235,46,55,52,46,54},53))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({17,44,55,55,52,57,50,235,45,44,46,54,235,63,58,235,45,64,63,63,58,57,33,44,55,64,48,235,62,48,44,61,46,51,235,49,58,61,235,29,48,59,55,44,68},53))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({29,48,59,55,44,68,235,45,64,63,63,58,57,235,57,58,63,235,49,58,64,57,47,235,48,52,63,51,48,61,247,235,50,52,65,52,57,50,235,64,59},53))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({34,44,52,63,52,57,50,235,49,58,61,235,14,58,57,49,52,61,56,44,63,52,58,57,27,61,58,56,59,63,249,29,48,56,58,63,48,16,65,48,57,63},53))
local remote = getReplayRemote()
if not remote then
debug(_d({14,58,57,49,52,61,56,44,63,52,58,57,27,61,58,56,59,63,250,29,48,56,58,63,48,16,65,48,57,63,235,57,58,63,235,49,58,64,57,47,235,66,52,63,51,52,57,235,63,52,56,48,58,64,63},53))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({17,52,61,52,57,50,235,29,48,59,55,44,68,235,65,52,44,235,14,58,57,49,52,61,56,44,63,52,58,57,27,61,58,56,59,63,249,29,48,56,58,63,48,16,65,48,57,63},53))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({17,52,61,48,30,48,61,65,48,61,235,48,61,61,58,61,5},53), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({27,55,44,68,48,61,18,64,52},53), 10)
if not playerGui then
debug(_d({66,44,52,63,17,58,61,26,45,53,48,46,63,52,65,48,62,18,64,52,5,235,57,58,235,27,55,44,68,48,61,18,64,52,235,66,52,63,51,52,57,235,63,52,56,48,58,64,63,247,235,59,61,58,46,48,48,47,52,57,50,235,44,57,68,66,44,68},53))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({26,45,53,48,46,63,52,65,48,62,235,18,32,20,235,49,58,64,57,47,235,248,235,62,63,44,50,48,235,55,58,44,47,48,47},53))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({26,45,53,48,46,63,52,65,48,62,235,18,32,20,235,57,58,63,235,49,58,64,57,47,235,66,52,63,51,52,57,235,63,52,56,48,58,64,63,247,235,59,61,58,46,48,48,47,52,57,50,235,44,57,68,66,44,68},53))
return
end
end
end)
if not ok then debug(_d({66,44,52,63,17,58,61,26,45,53,48,46,63,52,65,48,62,18,64,52,235,48,61,61,58,61,5},53), err) end
end
local function runPlan()
debug(_d({27,55,44,57,235,62,63,44,61,63,48,47},53))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({30,63,44,61,63,52,57,50,235,57,44,65,235,55,58,58,59},53))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({59,58,62,235,251,249,253,62,235,12,17,31,16,29,235,62,63,44,61,63,25,44,65,5},53), rootAfter and rootAfter.Position)
end)
debug(_d({34,44,52,63,52,57,50,235,0,62,235,45,48,49,58,61,48,235,56,58,65,52,57,50,235,63,58,235,30,63,44,50,48,252},53))
task.wait(5)
for _, stage in ipairs({_d({30,63,44,50,48,252},53), _d({30,63,44,50,48,253},53), _d({30,63,44,50,48,254},53), _d({30,63,44,50,48,254,13},53)}) do
if not enabled then return end
local hpTarget = (stage == _d({30,63,44,50,48,254,13},53)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({24,58,65,52,57,50,235,63,58,235,44,61,61,58,66,235,49,55,68,248,47,58,66,57,235,44,61,48,44,235,243,14,64,59,52,47,235,29,44,52,57,244},53))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({15,58,47,50,52,57,50,235,44,61,61,58,66,235,61,44,52,57,235,52,57,235,44,235,62,60,64,44,61,48},53))
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
clearStage(_d({30,63,44,50,48,255},53))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({28,64,48,48,57,235,52,57,235,59,51,44,62,48,235,253,235,248,235,54,48,48,59,52,57,50,235,22,48,57,235,19,44,54,52,235,44,46,63,52,65,48,235,49,61,58,56,235,51,48,61,48,235,58,57},53))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({30,63,44,63,64,48,252},53))
if not enabled then return end
recheckStatue(_d({30,63,44,63,64,48,252},53))
destroyStatue(_d({30,63,44,63,64,48,253},53))
if not enabled then return end
recheckStatue(_d({30,63,44,63,64,48,252},53))
recheckStatue(_d({30,63,44,63,64,48,253},53))
destroyStatue(_d({30,63,44,63,64,48,254},53))
if not enabled then return end
recheckStatue(_d({30,63,44,63,64,48,254},53))
recheckStatue(_d({30,63,44,63,64,48,253},53))
recheckStatue(_d({30,63,44,63,64,48,252},53))
if not enabled then return end
debug(_d({34,44,52,63,52,57,50,235,49,58,61,235,59,51,44,62,48,235,253,235,63,58,235,48,57,47},53))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({27,51,44,62,48,235,253,235,48,57,47,235,66,44,52,63,235,63,52,56,48,58,64,63,247,235,59,61,58,46,48,48,47,52,57,50,235,44,57,68,66,44,68},53))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({24,58,65,52,57,50,235,45,44,46,54,235,63,58,235,28,64,48,48,57,235,62,63,44,50,48,235,59,58,62,52,63,52,58,57},53))
navToPointConfirmed(COORDS.Queen, 30, _d({28,64,48,48,57,235,62,63,44,50,48,235,59,58,62,52,63,52,58,57},53))
debug(_d({34,44,52,63,52,57,50,235,0,62,235,44,63,235,28,64,48,48,57,235,62,63,44,50,48,235,59,58,62,52,63,52,58,57},53))
task.wait(5)
if not enabled then return end
debug(_d({24,58,65,52,57,50,235,63,58,235,59,58,62,63,248,28,64,48,48,57,235,59,58,62,52,63,52,58,57},53))
navToPointConfirmed(COORDS.PostQueen, 30, _d({59,58,62,63,248,28,64,48,48,57,235,59,58,62,52,63,52,58,57},53))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({16,57,44,45,55,52,57,50,247,235,59,58,62,235,13,16,17,26,29,16,235,59,55,44,57,5},53), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({27,55,44,57,235,48,61,61,58,61,5},53), err2) end
end)
debug(_d({16,57,44,45,55,48,47,5},53), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({16,57,44,45,55,48,47,5},53), enabled)
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
if not ok then debug(_d({20,57,59,64,63,13,48,50,44,57,235,48,61,61,58,61,5},53), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({18,44,56,48,235,55,58,44,47,48,47,247,235,44,64,63,58,248,62,63,44,61,63,52,57,50,235,63,51,48,235,59,55,44,57},53))
enableBot()
end)
if not ok then debug(_d({12,64,63,58,62,63,44,61,63,235,48,61,61,58,61,5},53), err) end
end)
debug(_d({23,58,44,47,48,47,235,173,75,95,235,44,64,63,58,248,62,63,44,61,63,52,57,50,235,58,57,46,48,235,63,51,48,235,50,44,56,48,235,49,52,57,52,62,51,48,62,235,55,58,44,47,52,57,50,235,243,59,61,48,62,62,235,27,235,63,58,235,63,58,50,50,55,48,235,56,44,57,64,44,55,55,68,244},53))
end)()