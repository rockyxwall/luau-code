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
local Players            = game:GetService(_d({21,49,38,62,42,55,56},59))
local UserInputService    = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
local RunService          = game:GetService(_d({23,58,51,24,42,55,59,46,40,42},59))
local VIM                 = game:GetService(_d({27,46,55,57,58,38,49,14,51,53,58,57,18,38,51,38,44,42,55},59))
local ReplicatedStorage    = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({32,7,52,56,56,7,52,57,34},59), _d({28,55,52,51,44,229,44,38,50,42,229,167,69,89,229,21,49,38,40,42,14,41,255},59), game.PlaceId, _d({26,51,46,59,42,55,56,42,14,41,255},59), game.GameId, _d({242,229,51,52,57,229,55,58,51,51,46,51,44},59))
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
local LEO_PILLAR_ANIM_ID   = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,249,249,246,249,246,248,247,252},59)
local LEO_ENTEI_ANIM_ID    = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,249,249,246,248,253,247,252,253},59)
local LEO_HIKEN_ANIM_ID    = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,247,245,254,246,252,249,245,252},59)
local LEO_FIREFLY_ANIM_ID  = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,250,247,247,245,247,248,251,246,250,249},59)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({20,39,47,42,40,57,46,59,42,56},59)
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
local REPLAY_BUTTON_VALUE   = _d({23,42,53,49,38,62},59)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({50,52,59,42},59)
local NavState   = {mode = _d({46,41,49,42},59)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({32,7,52,56,56,7,52,57,34},59), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end)
if ok then return root end
debug(_d({44,42,57,23,52,52,57,229,42,55,55,52,55,255},59), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
end)
if ok then return hum end
debug(_d({44,42,57,13,58,50,38,51,52,46,41,229,42,55,55,52,55,255},59), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({36,36,13,52,59,42,55,6,57,57},59)) or Instance.new(_d({6,57,57,38,40,45,50,42,51,57},59))
att.Name = _d({36,36,13,52,59,42,55,6,57,57},59)
att.Parent = root
local force = root:FindFirstChild(_d({36,36,13,52,59,42,55,11,52,55,40,42},59))
if not force then
force = Instance.new(_d({17,46,51,42,38,55,27,42,49,52,40,46,57,62},59))
force.Name = _d({36,36,13,52,59,42,55,11,52,55,40,42},59)
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
debug(_d({44,42,57,20,55,8,55,42,38,57,42,11,52,55,40,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local force = root:FindFirstChild(_d({36,36,13,52,59,42,55,11,52,55,40,42},59))
local att   = root:FindFirstChild(_d({36,36,13,52,59,42,55,6,57,57},59))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({40,49,42,38,51,58,53,11,52,55,40,42,229,42,55,55,52,55,255},59), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({7,58,56,52,18,42,49,42,42},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,7,58,56,52,6,40,57,46,59,42,229,42,55,55,52,55,255},59), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({7,58,56,52},59))
end)
if not ok then debug(_d({38,40,57,46,59,38,57,42,7,58,56,52,229,42,55,55,52,55,255},59), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({7,58,56,52,229,51,52,57,229,38,40,57,46,59,42,241,229,38,40,57,46,59,38,57,46,51,44},59))
activateBuso()
end
end)
if not ok then debug(_d({7,58,56,52,16,42,42,53,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({7,58,56,52,229,48,42,42,53,42,55,229,56,57,52,53,53,42,41},59))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({16,42,51,13,38,48,46},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,16,42,51,6,40,57,46,59,42,229,42,55,55,52,55,255},59), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({16,42,51},59), true)
end)
if not ok then debug(_d({38,40,57,46,59,38,57,42,16,42,51,229,42,55,55,52,55,255},59), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({16,42,51,229,51,52,57,229,38,40,57,46,59,42,241,229,38,40,57,46,59,38,57,46,51,44},59))
activateKen()
end
end)
if not ok then debug(_d({16,42,51,16,42,42,53,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({16,42,51,229,48,42,42,53,42,55,229,56,57,52,53,53,42,41},59))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({19,21,8,56},59)) end)
if ok then return folder end
debug(_d({44,42,57,19,21,8,56,11,52,49,41,42,55,229,42,55,55,52,55,255},59), folder)
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
local r = model:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local h = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
debug(_d({44,42,57,19,42,38,55,42,56,57,19,21,8,229,42,55,55,52,55,255},59), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
local hum  = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({44,42,57,19,21,8,7,62,19,38,50,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({51,53,40,56,23,42,50,38,46,51,46,51,44,229,42,55,55,52,55,255},59), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({8,58,53,46,41,229,22,58,42,42,51},59))
return queen ~= nil and queen:FindFirstChild(_d({50,52,57,46,52,51,17,42,56,56},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,22,58,42,42,51,21,45,38,56,42,247,229,42,55,55,52,55,255},59), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,246,247,246,247,254,252,254,249,247,247,254,247,252,251,254},59)
local QUEEN_GRASP_ANIM_ID   = _d({55,39,61,38,56,56,42,57,46,41,255,244,244,246,247,254,253,245,245,245,251,246,245,245,246,252,248,249},59)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
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
debug(_d({46,56,21,49,38,62,46,51,44,6,51,46,50,11,55,52,50,17,46,56,57,229,42,55,55,52,55,255},59), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({7,49,52,40,48,46,51,44},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,19,21,8,7,49,52,40,48,46,51,44,229,42,55,55,52,55,255},59), result)
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
debug(_d({53,55,42,41,46,40,57,19,21,8,21,52,56,46,57,46,52,51,229,42,55,55,52,55,255},59), result)
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
debug(_d({19,52,229,41,38,50,38,44,42,229,52,51},59), model.Name, _d({43,52,55},59), NPC_STUCK_TIMEOUT, _d({56,229,242,229,56,60,46,57,40,45,46,51,44,229,57,38,55,44,42,57},59))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({57,55,38,40,48,19,21,8,9,38,50,38,44,42,229,42,55,55,52,55,255},59), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({18,52,41,42,49},59)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({7,38,56,42,21,38,55,57},59)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({44,42,57,18,52,41,42,49,11,38,40,42,21,52,56,229,42,55,55,52,55,255},59), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({10,51,59},59))
local folder = env and env:FindFirstChild(_d({24,57,38,57,58,42,56},59))
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
debug(_d({44,42,57,24,57,38,57,58,42,18,52,41,42,49,19,42,38,55,229,42,55,55,52,55,255},59), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({39,38,55,55,42,49,13,21},59))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({44,42,57,24,57,38,57,58,42,13,21,229,42,55,55,52,55,255},59), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,6,57,57,55,46,39,58,57,42,229,42,55,55,52,55,255},59), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({25,52,52,49},59)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,19,38,50,42,229,42,55,55,52,55,255},59), tool)
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
if not ok then debug(_d({42,54,58,46,53,25,52,52,49,229,42,55,55,52,55,255},59), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({7,38,40,48,53,38,40,48},59))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({25,52,52,49},59)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({43,46,51,41,25,52,52,49,7,62,8,45,46,49,41,19,38,50,42,229,42,55,55,52,55,255},59), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({24,60,52,55,41,10,54,58,46,53},59))
if sword then
equipTool(sword)
return _d({56,60,52,55,41},59)
end
local melee = findToolByAttribute(_d({18,42,49,42,42,25,52,52,49},59))
if melee then
equipTool(melee)
return _d({50,42,49,42,42},59)
end
debug(_d({19,52,229,56,60,52,55,41,229,52,55,229,50,42,49,42,42,229,57,52,52,49,229,43,52,58,51,41},59))
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
if not ok then debug(_d({40,49,46,40,48,18,246,229,42,55,55,52,55,255},59), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({23,52,48,58,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({12,42,53,53,52},59), args)
elseif style == _d({7,49,38,40,48,17,42,44},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48},59), args)
elseif style == _d({16,38,50,46,56,45,46,48,46},59) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({16,38,50,46,56,45,46,48,46,12,42,53,53,52},59), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,48,62,229,28,38,49,48,247},59), args)
end
end)
if not ok then debug(_d({46,51,59,52,48,42,12,42,53,53,52,229,42,55,55,52,55,255},59), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({53,55,42,56,56,24,48,46,49,49,23,229,42,55,55,52,55,255},59), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({45,52,49,41,7,49,52,40,48,229,42,55,55,52,55,255},59), err) end
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
if not ok then debug(_d({45,52,49,41,7,49,52,40,48,28,45,46,49,42,229,42,55,55,52,55,255},59), err) end
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
debug(_d({44,42,57,12,38,50,42,12,229,42,55,55,52,55,255},59), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({46,56,23,42,38,49,18,246,7,58,56,62,229,42,55,55,52,55,255},59), result)
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
return char ~= nil and char:FindFirstChild(_d({56,57,58,51},59)) ~= nil
end)
if ok then return result end
debug(_d({46,56,24,57,58,51,51,42,41,229,42,55,55,52,55,255},59), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({53,55,42,56,56,24,57,58,51,7,55,42,38,48,229,42,55,55,52,55,255},59), err) end
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
debug(_d({54,58,42,42,51,9,52,41,44,42,26,51,57,46,49,24,38,43,42,255,229,22,58,42,42,51,229,44,52,51,42,229,242,229,42,51,41,46,51,44,229,41,52,41,44,42,229,42,38,55,49,62},59))
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
debug(_d({54,58,42,42,51,9,52,41,44,42,26,51,57,46,49,24,38,43,42,229,56,38,43,42,57,62,229,57,46,50,42,52,58,57},59))
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
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({22,58,42,42,51,229,40,38,56,57,46,51,44,229,41,42,57,42,40,57,42,41,229,242,229,41,52,41,44,46,51,44,229,237,60,38,57,40,45,42,55,238},59))
queenDodgeUntilSafe(function() return getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) end)
if enabled and getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) then
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
end
queenDodging = false
end
end)
if not ok then debug(_d({54,58,42,42,51,9,52,41,44,42,28,38,57,40,45,42,55,229,42,55,55,52,55,255},59), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({53,52,46,51,57},59) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({51,53,40},59) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({51,38,50,42,41},59) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({44,42,57,19,38,59,25,38,55,44,42,57,56,229,42,55,55,52,55,255},59), aimR)
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
debug(_d({40,52,50,53,58,57,42,17,52,40,48,42,41,8,11,55,38,50,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({53,52,46,51,57},59), point = pos}
phase = _d({50,52,59,42},59)
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
if not ok then debug(_d({51,38,59,25,52,21,52,46,51,57,229,44,42,53,53,52,229,40,45,42,40,48,229,42,55,55,52,55,255},59), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({51,53,40},59)}
phase = _d({50,52,59,42},59)
end
function setNavNamed(name)
NavState = {mode = _d({51,38,50,42,41},59), name = name}
phase = _d({50,52,59,42},59)
end
local function setNavIdle()
NavState = {mode = _d({46,41,49,42},59)}
phase = _d({50,52,59,42},59)
end
local function hasArrived()
return phase == _d({45,52,59,42,55},59)
end
local function startNav()
phase = _d({50,52,59,42},59)
debug(_d({19,38,59,229,49,52,52,53,229,20,19},59))
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
local prevPos = force:GetAttribute(_d({36,36,53,55,42,59,21,52,56},59))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({17,38,55,44,42,229,53,52,56,46,57,46,52,51,229,47,58,50,53,229,41,42,57,42,40,57,42,41,255},59), delta, _d({56,57,58,41,56,243,229,53,55,42,59,21,52,56,2},59), prevPos, _d({51,42,60,21,52,56,2},59), pos)
end
end
force:SetAttribute(_d({36,36,53,55,42,59,21,52,56},59), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({50,52,59,42},59) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({45,52,59,42,55},59)
debug(_d({21,45,38,56,42,255,229,45,52,59,42,55},59))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({230,230,230,229,23,10,11,26,24,14,19,12,229,25,20,229,6,21,21,17,30,229,6,7,19,20,23,18,6,17,229,27,10,17,20,8,14,25,30,255},59), finalVel, _d({38,46,50,2},59), aim, _d({53,52,56,2},59), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({45,52,59,42,55},59) then
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
debug(_d({8,52,50,39,38,57,229,49,52,40,48,229,56,48,46,53,53,42,41,241},59), snapDist, _d({56,57,58,41,56,229,43,55,52,50,229,57,38,55,44,42,57,229,167,69,89,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,50,52,59,42},59))
phase = _d({50,52,59,42},59)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({13,42,38,55,57,39,42,38,57,229,42,55,55,52,55,255},59), err) end
end)
end
local function stopNav()
debug(_d({19,38,59,229,49,52,52,53,229,20,11,11},59))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({50,52,59,42},59)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({25,42,61,57,8,45,38,57,24,42,55,59,46,40,42},59))
local channels = TextChatService:FindFirstChild(_d({25,42,61,57,8,45,38,51,51,42,49,56},59))
local channel = channels and channels:FindFirstChild(_d({23,7,29,12,42,51,42,55,38,49},59))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({9,42,43,38,58,49,57,8,45,38,57,24,62,56,57,42,50,8,45,38,57,10,59,42,51,57,56},59))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({24,38,62,18,42,56,56,38,44,42,23,42,54,58,42,56,57},59))
if sayEvent then
sayEvent:FireServer(message, _d({6,49,49},59))
return
end
debug(_d({56,42,51,41,8,45,38,57,18,42,56,56,38,44,42,255,229,51,52,229,25,42,61,57,8,45,38,57,24,42,55,59,46,40,42,243,23,7,29,12,42,51,42,55,38,49,229,52,55,229,49,42,44,38,40,62,229,24,38,62,18,42,56,56,38,44,42,23,42,54,58,42,56,57,229,43,52,58,51,41,229,43,52,55},59), message)
end)
if not ok then debug(_d({56,42,51,41,8,45,38,57,18,42,56,56,38,44,42,229,42,55,55,52,55,255},59), err) end
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
debug(_d({19,52,57,229,50,38,48,46,51,44,229,53,55,52,44,55,42,56,56,229,57,52,60,38,55,41,229,51,38,59,229,57,38,55,44,42,57,229,43,52,55},59), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({56,229,242,229,56,42,51,41,46,51,44,229,244,58,51,56,57,58,40,48},59))
sendChatMessage(_d({244,58,51,56,57,58,40,48},59))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({60,38,46,57,26,51,57,46,49,6,55,55,46,59,42,41,229,57,46,50,42,52,58,57},59))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({51,38,59,25,52,21,52,46,51,57,8,52,51,43,46,55,50,42,41,255},59), label or _d({57,38,55,44,42,57},59), _d({242,229,41,46,41,229,51,52,57,229,38,55,55,46,59,42,229,60,46,57,45,46,51},59), timeout, _d({56,241,229,55,42,57,55,62,46,51,44,229,52,51,40,42},59))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({51,38,59,25,52,21,52,46,51,57,8,52,51,43,46,55,50,42,41,255},59), label or _d({57,38,55,44,42,57},59), _d({242,229,56,57,46,49,49,229,51,52,57,229,38,55,55,46,59,42,41,229,38,43,57,42,55,229,55,42,57,55,62,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
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
if not ok then debug(_d({51,38,59,25,52,21,52,46,51,57,13,52,49,41,46,51,44,7,49,52,40,48,229,48,42,62,242,41,52,60,51,229,42,55,55,52,55,255},59), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({51,38,59,25,52,21,52,46,51,57,13,52,49,41,46,51,44,7,49,52,40,48,229,48,42,62,242,58,53,229,42,55,55,52,55,255},59), err2) end
end
local function clearStage(stageName)
debug(_d({18,52,59,46,51,44,229,57,52},59), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,19,21,8,56,229,57,52,229,56,53,38,60,51,229,38,57},59), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({229,229,56,53,38,60,51,229,40,45,42,40,48,255,229,43,52,49,41,42,55,229,42,61,46,56,57,56,229,2},59), folder ~= nil,
_d({241,229,40,45,46,49,41,55,42,51,229,2},59), folder and #folder:GetChildren() or 0,
_d({241,229,38,49,46,59,42,229,2},59), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({19,52,229,19,21,8,56,229,38,53,53,42,38,55,42,41,229,38,57},59), stageName, _d({38,43,57,42,55,229,246,250,56,241,229,50,52,59,46,51,44,229,52,51,229,38,51,62,60,38,62},59))
break
end
end
debug(_d({16,46,49,49,46,51,44,229,19,21,8,56,229,38,57},59), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({23,42,57,58,55,51,46,51,44,229,57,52},59), stageName, _d({53,52,56,46,57,46,52,51,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,52,51},59))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57},59), stageName, _d({53,52,56,46,57,46,52,51},59))
task.wait(5)
debug(stageName, _d({40,49,42,38,55,42,41},59))
end
local function killNamedNPC(name, targetPos)
debug(_d({18,52,59,46,51,44,229,57,52},59), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({41,42,43,42,38,57,42,41},59))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({13,58,50,38,51,52,46,41},59))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({17,42,52,229,53,49,38,62,42,41,229,38,51,46,50,38,57,46,52,51,255},59), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({49,42,52,6,51,46,50,17,52,44,44,42,55,229,53,55,46,51,57,229,42,55,55,52,55,255},59), err2) end
end)
end)
if not ok then debug(_d({56,57,38,55,57,17,42,52,6,51,46,50,17,52,44,44,42,55,229,42,55,55,52,55,255},59), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({18,52,59,46,51,44,229,57,52,229,17,42,52,229,237,39,49,52,40,48,46,51,44,229,38,43,57,42,55},59), LEO_BLOCK_DELAY, _d({56,238},59))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({17,42,52},59))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({17,42,52},59))
while enabled do
local info = getNPCByName(_d({17,42,52},59))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({17,42,52,229,40,38,56,57,46,51,44},59), which, _d({242,229,41,52,41,44,46,51,44},59))
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
if not getNPCByName(_d({17,42,52},59)) then
debug(_d({17,42,52,229,44,52,51,42,229,50,46,41,242,41,52,41,44,42,229,242,229,42,51,41,46,51,44,229,10,51,57,42,46,229,45,52,49,41,229,42,38,55,49,62},59))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({17,42,52},59)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({17,42,52,229,44,52,51,42,229,50,46,41,242,41,52,41,44,42,229,242,229,42,51,41,46,51,44,229,11,49,38,50,42,229,21,46,49,49,38,55,229,45,52,49,41,229,42,38,55,49,62},59))
end
end
end
if enabled and getNPCByName(_d({17,42,52},59)) then
setNavNamed(_d({17,42,52},59))
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
debug(_d({17,42,52,229,41,42,43,42,38,57,42,41},59))
stopLeoAnimLogger()
debug(_d({23,42,57,58,55,51,46,51,44,229,57,52,229,17,42,52,229,53,52,56,46,57,46,52,51,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,52,51},59))
navToPointConfirmed(COORDS.Leo, 30, _d({17,42,52,229,53,52,56,46,57,46,52,51},59))
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57,229,17,42,52,229,53,52,56,46,57,46,52,51},59))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({18,52,59,46,51,44,229,57,52},59), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({8,52,58,49,41,229,51,52,57,229,43,46,51,41,229,56,57,38,57,58,42,229,50,52,41,42,49,229,51,42,38,55},59), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({6,57,57,38,40,48,46,51,44},59), coordKey, _d({60,46,57,45},59), weapon or _d({51,52,57,45,46,51,44,229,43,52,58,51,41},59))
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
debug(coordKey, _d({39,38,55,55,42,49,229,41,42,56,57,55,52,62,42,41},59))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({242,229,40,52,58,49,41,229,51,52,57,229,43,46,51,41,229,56,57,38,57,58,42,229,50,52,41,42,49,241,229,56,48,46,53,53,46,51,44},59))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({56,57,46,49,49,229,38,49,46,59,42,229,237,13,21},59), hp, _d({238,229,242,229,55,42,242,41,42,56,57,55,52,62,46,51,44},59))
destroyStatue(coordKey)
else
debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,255},59), coordKey, _d({40,52,51,43,46,55,50,42,41,229,41,42,56,57,55,52,62,42,41},59))
end
end)
if not ok then debug(_d({55,42,40,45,42,40,48,24,57,38,57,58,42,229,42,55,55,52,55,255},59), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({18,52,59,46,51,44,229,57,52,229,22,58,42,42,51},59))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({22,58,42,42,51,229,42,51,57,42,55,42,41,229,53,45,38,56,42,229,247},59))
end
local function finishQueen()
debug(_d({11,46,51,46,56,45,46,51,44,229,22,58,42,42,51},59))
equipSwordOrMelee()
setNavNamed(_d({8,58,53,46,41,229,22,58,42,42,51},59))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({8,58,53,46,41,229,22,58,42,42,51},59))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({22,58,42,42,51,229,41,42,43,42,38,57,42,41,243,229,21,49,38,51,229,40,52,50,53,49,42,57,42,243},59))
end
local CONFIRMATION_PROMPT_NAME = _d({8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57},59)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({23,42,50,52,57,42,10,59,42,51,57},59), 5)
end)
if ok then return result end
debug(_d({44,42,57,23,42,53,49,38,62,23,42,50,52,57,42,229,42,55,55,52,55,255},59), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({21,49,38,62,42,55,12,58,46},59))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({14,50,38,44,42,7,58,57,57,52,51},59)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({39,58,57,57,52,51,27,38,49,58,42},59)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({43,46,51,41,7,58,57,57,52,51,7,62,27,38,49,58,42,229,42,55,55,52,55,255},59), result)
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
if not ok then debug(_d({40,49,46,40,48,12,58,46,7,58,57,57,52,51,229,42,55,55,52,55,255},59), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({46,56,24,42,55,59,42,55},59))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({23,42,50,52,57,42,10,59,42,51,57},59))
or inst:FindFirstChild(_d({40,49,46,42,51,57,10,59,42,51,57},59))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({43,46,51,41,6,51,56,60,42,55,8,52,51,51,42,40,57,52,55,229,42,55,55,52,55,255},59), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({8,52,58,49,41,229,51,52,57,229,49,52,40,38,57,42,229,23,42,50,52,57,42,10,59,42,51,57,244,40,49,46,42,51,57,10,59,42,51,57,229,51,42,38,55,229,23,42,53,49,38,62,229,39,58,57,57,52,51,241,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,40,49,46,40,48},59))
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
debug(_d({43,46,55,42,23,42,53,49,38,62,27,38,49,58,42,229,42,55,55,52,55,255},59), err, _d({242,229,43,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,40,49,46,40,48},59))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({11,38,49,49,46,51,44,229,39,38,40,48,229,57,52,229,39,58,57,57,52,51,27,38,49,58,42,229,56,42,38,55,40,45,229,43,52,55,229,23,42,53,49,38,62},59))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({23,42,53,49,38,62,229,39,58,57,57,52,51,229,51,52,57,229,43,52,58,51,41,229,42,46,57,45,42,55,241,229,44,46,59,46,51,44,229,58,53},59))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,243,23,42,50,52,57,42,10,59,42,51,57},59))
local remote = getReplayRemote()
if not remote then
debug(_d({8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,244,23,42,50,52,57,42,10,59,42,51,57,229,51,52,57,229,43,52,58,51,41,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57},59))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({11,46,55,46,51,44,229,23,42,53,49,38,62,229,59,46,38,229,8,52,51,43,46,55,50,38,57,46,52,51,21,55,52,50,53,57,243,23,42,50,52,57,42,10,59,42,51,57},59))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({11,46,55,42,24,42,55,59,42,55,229,42,55,55,52,55,255},59), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({21,49,38,62,42,55,12,58,46},59), 10)
if not playerGui then
debug(_d({60,38,46,57,11,52,55,20,39,47,42,40,57,46,59,42,56,12,58,46,255,229,51,52,229,21,49,38,62,42,55,12,58,46,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({20,39,47,42,40,57,46,59,42,56,229,12,26,14,229,43,52,58,51,41,229,242,229,56,57,38,44,42,229,49,52,38,41,42,41},59))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({20,39,47,42,40,57,46,59,42,56,229,12,26,14,229,51,52,57,229,43,52,58,51,41,229,60,46,57,45,46,51,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
return
end
end
end)
if not ok then debug(_d({60,38,46,57,11,52,55,20,39,47,42,40,57,46,59,42,56,12,58,46,229,42,55,55,52,55,255},59), err) end
end
local function runPlan()
debug(_d({21,49,38,51,229,56,57,38,55,57,42,41},59))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({24,57,38,55,57,46,51,44,229,51,38,59,229,49,52,52,53},59))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({53,52,56,229,245,243,247,56,229,6,11,25,10,23,229,56,57,38,55,57,19,38,59,255},59), rootAfter and rootAfter.Position)
end)
debug(_d({28,38,46,57,46,51,44,229,250,56,229,39,42,43,52,55,42,229,50,52,59,46,51,44,229,57,52,229,24,57,38,44,42,246},59))
task.wait(5)
for _, stage in ipairs({_d({24,57,38,44,42,246},59), _d({24,57,38,44,42,247},59), _d({24,57,38,44,42,248},59), _d({24,57,38,44,42,248,7},59)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,57,52,229,38,55,55,52,60,229,43,49,62,242,41,52,60,51,229,38,55,42,38},59))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({9,52,41,44,46,51,44,229,38,55,55,52,60,229,55,38,46,51},59))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({24,57,38,44,42,249},59))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({22,58,42,42,51,229,46,51,229,53,45,38,56,42,229,247,229,242,229,48,42,42,53,46,51,44,229,16,42,51,229,13,38,48,46,229,38,40,57,46,59,42,229,43,55,52,50,229,45,42,55,42,229,52,51},59))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({24,57,38,57,58,42,246},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,246},59))
destroyStatue(_d({24,57,38,57,58,42,247},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,246},59))
recheckStatue(_d({24,57,38,57,58,42,247},59))
destroyStatue(_d({24,57,38,57,58,42,248},59))
if not enabled then return end
recheckStatue(_d({24,57,38,57,58,42,248},59))
recheckStatue(_d({24,57,38,57,58,42,247},59))
recheckStatue(_d({24,57,38,57,58,42,246},59))
if not enabled then return end
debug(_d({28,38,46,57,46,51,44,229,43,52,55,229,53,45,38,56,42,229,247,229,57,52,229,42,51,41},59))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({21,45,38,56,42,229,247,229,42,51,41,229,60,38,46,57,229,57,46,50,42,52,58,57,241,229,53,55,52,40,42,42,41,46,51,44,229,38,51,62,60,38,62},59))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,39,38,40,48,229,57,52,229,22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
navToPointConfirmed(COORDS.Queen, 30, _d({22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
debug(_d({28,38,46,57,46,51,44,229,250,56,229,38,57,229,22,58,42,42,51,229,56,57,38,44,42,229,53,52,56,46,57,46,52,51},59))
task.wait(5)
if not enabled then return end
debug(_d({18,52,59,46,51,44,229,57,52,229,53,52,56,57,242,22,58,42,42,51,229,53,52,56,46,57,46,52,51},59))
navToPointConfirmed(COORDS.PostQueen, 30, _d({53,52,56,57,242,22,58,42,42,51,229,53,52,56,46,57,46,52,51},59))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({10,51,38,39,49,46,51,44,241,229,53,52,56,229,7,10,11,20,23,10,229,53,49,38,51,255},59), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({21,49,38,51,229,42,55,55,52,55,255},59), err2) end
end)
debug(_d({10,51,38,39,49,42,41,255},59), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({10,51,38,39,49,42,41,255},59), enabled)
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
if not ok then debug(_d({14,51,53,58,57,7,42,44,38,51,229,42,55,55,52,55,255},59), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({12,38,50,42,229,49,52,38,41,42,41,241,229,38,58,57,52,242,56,57,38,55,57,46,51,44,229,57,45,42,229,53,49,38,51},59))
enableBot()
end)
if not ok then debug(_d({6,58,57,52,56,57,38,55,57,229,42,55,55,52,55,255},59), err) end
end)
debug(_d({17,52,38,41,42,41,229,167,69,89,229,38,58,57,52,242,56,57,38,55,57,46,51,44,229,52,51,40,42,229,57,45,42,229,44,38,50,42,229,43,46,51,46,56,45,42,56,229,49,52,38,41,46,51,44,229,237,53,55,42,56,56,229,21,229,57,52,229,57,52,44,44,49,42,229,50,38,51,58,38,49,49,62,238},59))
end)()