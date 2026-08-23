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
local Players            = game:GetService(_d({26,54,43,67,47,60,61},54))
local UserInputService    = game:GetService(_d({31,61,47,60,19,56,58,63,62,29,47,60,64,51,45,47},54))
local RunService          = game:GetService(_d({28,63,56,29,47,60,64,51,45,47},54))
local VIM                 = game:GetService(_d({32,51,60,62,63,43,54,19,56,58,63,62,23,43,56,43,49,47,60},54))
local ReplicatedStorage    = game:GetService(_d({28,47,58,54,51,45,43,62,47,46,29,62,57,60,43,49,47},54))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({37,12,57,61,61,12,57,62,39},54), _d({33,60,57,56,49,234,49,43,55,47,234,172,74,94,234,26,54,43,45,47,19,46,4},54), game.PlaceId, _d({31,56,51,64,47,60,61,47,19,46,4},54), game.GameId, _d({247,234,56,57,62,234,60,63,56,56,51,56,49},54))
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
local LEO_PILLAR_ANIM_ID   = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,254,254,251,254,251,253,252,1},54)
local LEO_ENTEI_ANIM_ID    = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,254,254,251,253,2,252,1,2},54)
local LEO_HIKEN_ANIM_ID    = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,252,250,3,251,1,254,250,1},54)
local LEO_FIREFLY_ANIM_ID  = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,255,252,252,250,252,253,0,251,255,254},54)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({25,44,52,47,45,62,51,64,47,61},54)
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
local REPLAY_BUTTON_VALUE   = _d({28,47,58,54,43,67},54)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({55,57,64,47},54)
local NavState   = {mode = _d({51,46,54,47},54)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({37,12,57,61,61,12,57,62,39},54), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
end)
if ok then return root end
debug(_d({49,47,62,28,57,57,62,234,47,60,60,57,60,4},54), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
end)
if ok then return hum end
debug(_d({49,47,62,18,63,55,43,56,57,51,46,234,47,60,60,57,60,4},54), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({41,41,18,57,64,47,60,11,62,62},54)) or Instance.new(_d({11,62,62,43,45,50,55,47,56,62},54))
att.Name = _d({41,41,18,57,64,47,60,11,62,62},54)
att.Parent = root
local force = root:FindFirstChild(_d({41,41,18,57,64,47,60,16,57,60,45,47},54))
if not force then
force = Instance.new(_d({22,51,56,47,43,60,32,47,54,57,45,51,62,67},54))
force.Name = _d({41,41,18,57,64,47,60,16,57,60,45,47},54)
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
debug(_d({49,47,62,25,60,13,60,47,43,62,47,16,57,60,45,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local force = root:FindFirstChild(_d({41,41,18,57,64,47,60,16,57,60,45,47},54))
local att   = root:FindFirstChild(_d({41,41,18,57,64,47,60,11,62,62},54))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({45,54,47,43,56,63,58,16,57,60,45,47,234,47,60,60,57,60,4},54), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({12,63,61,57,23,47,54,47,47},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,12,63,61,57,11,45,62,51,64,47,234,47,60,60,57,60,4},54), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({12,63,61,57},54))
end)
if not ok then debug(_d({43,45,62,51,64,43,62,47,12,63,61,57,234,47,60,60,57,60,4},54), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({12,63,61,57,234,56,57,62,234,43,45,62,51,64,47,246,234,43,45,62,51,64,43,62,51,56,49},54))
activateBuso()
end
end)
if not ok then debug(_d({12,63,61,57,21,47,47,58,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({12,63,61,57,234,53,47,47,58,47,60,234,61,62,57,58,58,47,46},54))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({21,47,56,18,43,53,51},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,21,47,56,11,45,62,51,64,47,234,47,60,60,57,60,4},54), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({21,47,56},54), true)
end)
if not ok then debug(_d({43,45,62,51,64,43,62,47,21,47,56,234,47,60,60,57,60,4},54), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({21,47,56,234,56,57,62,234,43,45,62,51,64,47,246,234,43,45,62,51,64,43,62,51,56,49},54))
activateKen()
end
end)
if not ok then debug(_d({21,47,56,21,47,47,58,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({21,47,56,234,53,47,47,58,47,60,234,61,62,57,58,58,47,46},54))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({24,26,13,61},54)) end)
if ok then return folder end
debug(_d({49,47,62,24,26,13,61,16,57,54,46,47,60,234,47,60,60,57,60,4},54), folder)
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
local r = model:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local h = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
debug(_d({49,47,62,24,47,43,60,47,61,62,24,26,13,234,47,60,60,57,60,4},54), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
local hum  = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({49,47,62,24,26,13,12,67,24,43,55,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({56,58,45,61,28,47,55,43,51,56,51,56,49,234,47,60,60,57,60,4},54), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({13,63,58,51,46,234,27,63,47,47,56},54))
return queen ~= nil and queen:FindFirstChild(_d({55,57,62,51,57,56,22,47,61,61},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,27,63,47,47,56,26,50,43,61,47,252,234,47,60,60,57,60,4},54), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,251,252,251,252,3,1,3,254,252,252,3,252,1,0,3},54)
local QUEEN_GRASP_ANIM_ID   = _d({60,44,66,43,61,61,47,62,51,46,4,249,249,251,252,3,2,250,250,250,0,251,250,250,251,1,253,254},54)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
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
debug(_d({51,61,26,54,43,67,51,56,49,11,56,51,55,16,60,57,55,22,51,61,62,234,47,60,60,57,60,4},54), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({12,54,57,45,53,51,56,49},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,24,26,13,12,54,57,45,53,51,56,49,234,47,60,60,57,60,4},54), result)
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
debug(_d({58,60,47,46,51,45,62,24,26,13,26,57,61,51,62,51,57,56,234,47,60,60,57,60,4},54), result)
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
debug(_d({24,57,234,46,43,55,43,49,47,234,57,56},54), model.Name, _d({48,57,60},54), NPC_STUCK_TIMEOUT, _d({61,234,247,234,61,65,51,62,45,50,51,56,49,234,62,43,60,49,47,62},54))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({62,60,43,45,53,24,26,13,14,43,55,43,49,47,234,47,60,60,57,60,4},54), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({23,57,46,47,54},54)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({12,43,61,47,26,43,60,62},54)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({49,47,62,23,57,46,47,54,16,43,45,47,26,57,61,234,47,60,60,57,60,4},54), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({15,56,64},54))
local folder = env and env:FindFirstChild(_d({29,62,43,62,63,47,61},54))
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
debug(_d({49,47,62,29,62,43,62,63,47,23,57,46,47,54,24,47,43,60,234,47,60,60,57,60,4},54), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({44,43,60,60,47,54,18,26},54))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({49,47,62,29,62,43,62,63,47,18,26,234,47,60,60,57,60,4},54), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,11,62,62,60,51,44,63,62,47,234,47,60,60,57,60,4},54), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({30,57,57,54},54)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,24,43,55,47,234,47,60,60,57,60,4},54), tool)
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
if not ok then debug(_d({47,59,63,51,58,30,57,57,54,234,47,60,60,57,60,4},54), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({12,43,45,53,58,43,45,53},54))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({30,57,57,54},54)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({48,51,56,46,30,57,57,54,12,67,13,50,51,54,46,24,43,55,47,234,47,60,60,57,60,4},54), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({29,65,57,60,46,15,59,63,51,58},54))
if sword then
equipTool(sword)
return _d({61,65,57,60,46},54)
end
local melee = findToolByAttribute(_d({23,47,54,47,47,30,57,57,54},54))
if melee then
equipTool(melee)
return _d({55,47,54,47,47},54)
end
debug(_d({24,57,234,61,65,57,60,46,234,57,60,234,55,47,54,47,47,234,62,57,57,54,234,48,57,63,56,46},54))
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
if not ok then debug(_d({45,54,51,45,53,23,251,234,47,60,60,57,60,4},54), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({18,63,55,43,56,57,51,46,28,57,57,62,26,43,60,62},54))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({29,62,43,62,61},54) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({28,57,53,63,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({17,47,58,58,57},54), args)
elseif style == _d({12,54,43,45,53,22,47,49},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53},54), args)
elseif style == _d({21,43,55,51,61,50,51,53,51},54) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,43,55,51,61,50,51,53,51,17,47,58,58,57},54), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,53,67,234,33,43,54,53,252},54), args)
end
end)
if not ok then debug(_d({51,56,64,57,53,47,17,47,58,58,57,234,47,60,60,57,60,4},54), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({58,60,47,61,61,29,53,51,54,54,28,234,47,60,60,57,60,4},54), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({50,57,54,46,12,54,57,45,53,234,47,60,60,57,60,4},54), err) end
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
if not ok then debug(_d({50,57,54,46,12,54,57,45,53,33,50,51,54,47,234,47,60,60,57,60,4},54), err) end
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
debug(_d({49,47,62,17,43,55,47,17,234,47,60,60,57,60,4},54), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({51,61,28,47,43,54,23,251,12,63,61,67,234,47,60,60,57,60,4},54), result)
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
return char ~= nil and char:FindFirstChild(_d({61,62,63,56},54)) ~= nil
end)
if ok then return result end
debug(_d({51,61,29,62,63,56,56,47,46,234,47,60,60,57,60,4},54), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({58,60,47,61,61,29,62,63,56,12,60,47,43,53,234,47,60,60,57,60,4},54), err) end
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
debug(_d({59,63,47,47,56,14,57,46,49,47,31,56,62,51,54,29,43,48,47,4,234,27,63,47,47,56,234,49,57,56,47,234,247,234,47,56,46,51,56,49,234,46,57,46,49,47,234,47,43,60,54,67},54))
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
debug(_d({59,63,47,47,56,14,57,46,49,47,31,56,62,51,54,29,43,48,47,234,61,43,48,47,62,67,234,62,51,55,47,57,63,62},54))
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
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({27,63,47,47,56,234,45,43,61,62,51,56,49,234,46,47,62,47,45,62,47,46,234,247,234,46,57,46,49,51,56,49,234,242,65,43,62,45,50,47,60,243},54))
queenDodgeUntilSafe(function() return getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) end)
if enabled and getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) then
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
end
queenDodging = false
end
end)
if not ok then debug(_d({59,63,47,47,56,14,57,46,49,47,33,43,62,45,50,47,60,234,47,60,60,57,60,4},54), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({58,57,51,56,62},54) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({56,58,45},54) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({56,43,55,47,46},54) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({49,47,62,24,43,64,30,43,60,49,47,62,61,234,47,60,60,57,60,4},54), aimR)
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
debug(_d({45,57,55,58,63,62,47,22,57,45,53,47,46,13,16,60,43,55,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({58,57,51,56,62},54), point = pos}
phase = _d({55,57,64,47},54)
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
if not ok then debug(_d({56,43,64,30,57,26,57,51,56,62,234,49,47,58,58,57,234,45,50,47,45,53,234,47,60,60,57,60,4},54), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({56,58,45},54)}
phase = _d({55,57,64,47},54)
end
function setNavNamed(name)
NavState = {mode = _d({56,43,55,47,46},54), name = name}
phase = _d({55,57,64,47},54)
end
local function setNavIdle()
NavState = {mode = _d({51,46,54,47},54)}
phase = _d({55,57,64,47},54)
end
local function hasArrived()
return phase == _d({50,57,64,47,60},54)
end
local function startNav()
phase = _d({55,57,64,47},54)
debug(_d({24,43,64,234,54,57,57,58,234,25,24},54))
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
local prevPos = force:GetAttribute(_d({41,41,58,60,47,64,26,57,61},54))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({22,43,60,49,47,234,58,57,61,51,62,51,57,56,234,52,63,55,58,234,46,47,62,47,45,62,47,46,4},54), delta, _d({61,62,63,46,61,248,234,58,60,47,64,26,57,61,7},54), prevPos, _d({56,47,65,26,57,61,7},54), pos)
end
end
force:SetAttribute(_d({41,41,58,60,47,64,26,57,61},54), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({55,57,64,47},54) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({50,57,64,47,60},54)
debug(_d({26,50,43,61,47,4,234,50,57,64,47,60},54))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({235,235,235,234,28,15,16,31,29,19,24,17,234,30,25,234,11,26,26,22,35,234,11,12,24,25,28,23,11,22,234,32,15,22,25,13,19,30,35,4},54), finalVel, _d({43,51,55,7},54), aim, _d({58,57,61,7},54), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({50,57,64,47,60},54) then
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
debug(_d({13,57,55,44,43,62,234,54,57,45,53,234,61,53,51,58,58,47,46,246},54), snapDist, _d({61,62,63,46,61,234,48,60,57,55,234,62,43,60,49,47,62,234,172,74,94,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,55,57,64,47},54))
phase = _d({55,57,64,47},54)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({18,47,43,60,62,44,47,43,62,234,47,60,60,57,60,4},54), err) end
end)
end
local function stopNav()
debug(_d({24,43,64,234,54,57,57,58,234,25,16,16},54))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({55,57,64,47},54)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({30,47,66,62,13,50,43,62,29,47,60,64,51,45,47},54))
local channels = TextChatService:FindFirstChild(_d({30,47,66,62,13,50,43,56,56,47,54,61},54))
local channel = channels and channels:FindFirstChild(_d({28,12,34,17,47,56,47,60,43,54},54))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({14,47,48,43,63,54,62,13,50,43,62,29,67,61,62,47,55,13,50,43,62,15,64,47,56,62,61},54))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({29,43,67,23,47,61,61,43,49,47,28,47,59,63,47,61,62},54))
if sayEvent then
sayEvent:FireServer(message, _d({11,54,54},54))
return
end
debug(_d({61,47,56,46,13,50,43,62,23,47,61,61,43,49,47,4,234,56,57,234,30,47,66,62,13,50,43,62,29,47,60,64,51,45,47,248,28,12,34,17,47,56,47,60,43,54,234,57,60,234,54,47,49,43,45,67,234,29,43,67,23,47,61,61,43,49,47,28,47,59,63,47,61,62,234,48,57,63,56,46,234,48,57,60},54), message)
end)
if not ok then debug(_d({61,47,56,46,13,50,43,62,23,47,61,61,43,49,47,234,47,60,60,57,60,4},54), err) end
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
debug(_d({24,57,62,234,55,43,53,51,56,49,234,58,60,57,49,60,47,61,61,234,62,57,65,43,60,46,234,56,43,64,234,62,43,60,49,47,62,234,48,57,60},54), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({61,234,247,234,61,47,56,46,51,56,49,234,249,63,56,61,62,63,45,53},54))
sendChatMessage(_d({249,63,56,61,62,63,45,53},54))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({65,43,51,62,31,56,62,51,54,11,60,60,51,64,47,46,234,62,51,55,47,57,63,62},54))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({56,43,64,30,57,26,57,51,56,62,13,57,56,48,51,60,55,47,46,4},54), label or _d({62,43,60,49,47,62},54), _d({247,234,46,51,46,234,56,57,62,234,43,60,60,51,64,47,234,65,51,62,50,51,56},54), timeout, _d({61,246,234,60,47,62,60,67,51,56,49,234,57,56,45,47},54))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({56,43,64,30,57,26,57,51,56,62,13,57,56,48,51,60,55,47,46,4},54), label or _d({62,43,60,49,47,62},54), _d({247,234,61,62,51,54,54,234,56,57,62,234,43,60,60,51,64,47,46,234,43,48,62,47,60,234,60,47,62,60,67,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
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
if not ok then debug(_d({56,43,64,30,57,26,57,51,56,62,18,57,54,46,51,56,49,12,54,57,45,53,234,53,47,67,247,46,57,65,56,234,47,60,60,57,60,4},54), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({56,43,64,30,57,26,57,51,56,62,18,57,54,46,51,56,49,12,54,57,45,53,234,53,47,67,247,63,58,234,47,60,60,57,60,4},54), err2) end
end
local function clearStage(stageName)
debug(_d({23,57,64,51,56,49,234,62,57},54), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,24,26,13,61,234,62,57,234,61,58,43,65,56,234,43,62},54), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({234,234,61,58,43,65,56,234,45,50,47,45,53,4,234,48,57,54,46,47,60,234,47,66,51,61,62,61,234,7},54), folder ~= nil,
_d({246,234,45,50,51,54,46,60,47,56,234,7},54), folder and #folder:GetChildren() or 0,
_d({246,234,43,54,51,64,47,234,7},54), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({24,57,234,24,26,13,61,234,43,58,58,47,43,60,47,46,234,43,62},54), stageName, _d({43,48,62,47,60,234,251,255,61,246,234,55,57,64,51,56,49,234,57,56,234,43,56,67,65,43,67},54))
break
end
end
debug(_d({21,51,54,54,51,56,49,234,24,26,13,61,234,43,62},54), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({28,47,62,63,60,56,51,56,49,234,62,57},54), stageName, _d({58,57,61,51,62,51,57,56,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,57,56},54))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62},54), stageName, _d({58,57,61,51,62,51,57,56},54))
task.wait(5)
debug(stageName, _d({45,54,47,43,60,47,46},54))
end
local function killNamedNPC(name, targetPos)
debug(_d({23,57,64,51,56,49,234,62,57},54), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({46,47,48,47,43,62,47,46},54))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({18,63,55,43,56,57,51,46},54))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({22,47,57,234,58,54,43,67,47,46,234,43,56,51,55,43,62,51,57,56,4},54), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({54,47,57,11,56,51,55,22,57,49,49,47,60,234,58,60,51,56,62,234,47,60,60,57,60,4},54), err2) end
end)
end)
if not ok then debug(_d({61,62,43,60,62,22,47,57,11,56,51,55,22,57,49,49,47,60,234,47,60,60,57,60,4},54), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({23,57,64,51,56,49,234,62,57,234,22,47,57,234,242,44,54,57,45,53,51,56,49,234,43,48,62,47,60},54), LEO_BLOCK_DELAY, _d({61,243},54))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({22,47,57},54))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({22,47,57},54))
while enabled do
local info = getNPCByName(_d({22,47,57},54))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({22,47,57,234,45,43,61,62,51,56,49},54), which, _d({247,234,46,57,46,49,51,56,49},54))
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
if not getNPCByName(_d({22,47,57},54)) then
debug(_d({22,47,57,234,49,57,56,47,234,55,51,46,247,46,57,46,49,47,234,247,234,47,56,46,51,56,49,234,15,56,62,47,51,234,50,57,54,46,234,47,43,60,54,67},54))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({22,47,57},54)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({22,47,57,234,49,57,56,47,234,55,51,46,247,46,57,46,49,47,234,247,234,47,56,46,51,56,49,234,16,54,43,55,47,234,26,51,54,54,43,60,234,50,57,54,46,234,47,43,60,54,67},54))
end
end
end
if enabled and getNPCByName(_d({22,47,57},54)) then
setNavNamed(_d({22,47,57},54))
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
debug(_d({22,47,57,234,46,47,48,47,43,62,47,46},54))
stopLeoAnimLogger()
debug(_d({28,47,62,63,60,56,51,56,49,234,62,57,234,22,47,57,234,58,57,61,51,62,51,57,56,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,57,56},54))
navToPointConfirmed(COORDS.Leo, 30, _d({22,47,57,234,58,57,61,51,62,51,57,56},54))
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62,234,22,47,57,234,58,57,61,51,62,51,57,56},54))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({23,57,64,51,56,49,234,62,57},54), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({13,57,63,54,46,234,56,57,62,234,48,51,56,46,234,61,62,43,62,63,47,234,55,57,46,47,54,234,56,47,43,60},54), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({11,62,62,43,45,53,51,56,49},54), coordKey, _d({65,51,62,50},54), weapon or _d({56,57,62,50,51,56,49,234,48,57,63,56,46},54))
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
debug(coordKey, _d({44,43,60,60,47,54,234,46,47,61,62,60,57,67,47,46},54))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({247,234,45,57,63,54,46,234,56,57,62,234,48,51,56,46,234,61,62,43,62,63,47,234,55,57,46,47,54,246,234,61,53,51,58,58,51,56,49},54))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({61,62,51,54,54,234,43,54,51,64,47,234,242,18,26},54), hp, _d({243,234,247,234,60,47,247,46,47,61,62,60,57,67,51,56,49},54))
destroyStatue(coordKey)
else
debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,4},54), coordKey, _d({45,57,56,48,51,60,55,47,46,234,46,47,61,62,60,57,67,47,46},54))
end
end)
if not ok then debug(_d({60,47,45,50,47,45,53,29,62,43,62,63,47,234,47,60,60,57,60,4},54), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({23,57,64,51,56,49,234,62,57,234,27,63,47,47,56},54))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({27,63,47,47,56,234,47,56,62,47,60,47,46,234,58,50,43,61,47,234,252},54))
end
local function finishQueen()
debug(_d({16,51,56,51,61,50,51,56,49,234,27,63,47,47,56},54))
equipSwordOrMelee()
setNavNamed(_d({13,63,58,51,46,234,27,63,47,47,56},54))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({13,63,58,51,46,234,27,63,47,47,56},54))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({27,63,47,47,56,234,46,47,48,47,43,62,47,46,248,234,26,54,43,56,234,45,57,55,58,54,47,62,47,248},54))
end
local CONFIRMATION_PROMPT_NAME = _d({13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62},54)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({28,47,55,57,62,47,15,64,47,56,62},54), 5)
end)
if ok then return result end
debug(_d({49,47,62,28,47,58,54,43,67,28,47,55,57,62,47,234,47,60,60,57,60,4},54), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({26,54,43,67,47,60,17,63,51},54))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({19,55,43,49,47,12,63,62,62,57,56},54)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({44,63,62,62,57,56,32,43,54,63,47},54)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({48,51,56,46,12,63,62,62,57,56,12,67,32,43,54,63,47,234,47,60,60,57,60,4},54), result)
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
if not ok then debug(_d({45,54,51,45,53,17,63,51,12,63,62,62,57,56,234,47,60,60,57,60,4},54), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({51,61,29,47,60,64,47,60},54))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({28,47,55,57,62,47,15,64,47,56,62},54))
or inst:FindFirstChild(_d({45,54,51,47,56,62,15,64,47,56,62},54))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({48,51,56,46,11,56,61,65,47,60,13,57,56,56,47,45,62,57,60,234,47,60,60,57,60,4},54), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({13,57,63,54,46,234,56,57,62,234,54,57,45,43,62,47,234,28,47,55,57,62,47,15,64,47,56,62,249,45,54,51,47,56,62,15,64,47,56,62,234,56,47,43,60,234,28,47,58,54,43,67,234,44,63,62,62,57,56,246,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,45,54,51,45,53},54))
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
debug(_d({48,51,60,47,28,47,58,54,43,67,32,43,54,63,47,234,47,60,60,57,60,4},54), err, _d({247,234,48,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,45,54,51,45,53},54))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({16,43,54,54,51,56,49,234,44,43,45,53,234,62,57,234,44,63,62,62,57,56,32,43,54,63,47,234,61,47,43,60,45,50,234,48,57,60,234,28,47,58,54,43,67},54))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({28,47,58,54,43,67,234,44,63,62,62,57,56,234,56,57,62,234,48,57,63,56,46,234,47,51,62,50,47,60,246,234,49,51,64,51,56,49,234,63,58},54))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,248,28,47,55,57,62,47,15,64,47,56,62},54))
local remote = getReplayRemote()
if not remote then
debug(_d({13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,249,28,47,55,57,62,47,15,64,47,56,62,234,56,57,62,234,48,57,63,56,46,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62},54))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({16,51,60,51,56,49,234,28,47,58,54,43,67,234,64,51,43,234,13,57,56,48,51,60,55,43,62,51,57,56,26,60,57,55,58,62,248,28,47,55,57,62,47,15,64,47,56,62},54))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({16,51,60,47,29,47,60,64,47,60,234,47,60,60,57,60,4},54), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({26,54,43,67,47,60,17,63,51},54), 10)
if not playerGui then
debug(_d({65,43,51,62,16,57,60,25,44,52,47,45,62,51,64,47,61,17,63,51,4,234,56,57,234,26,54,43,67,47,60,17,63,51,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({25,44,52,47,45,62,51,64,47,61,234,17,31,19,234,48,57,63,56,46,234,247,234,61,62,43,49,47,234,54,57,43,46,47,46},54))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({25,44,52,47,45,62,51,64,47,61,234,17,31,19,234,56,57,62,234,48,57,63,56,46,234,65,51,62,50,51,56,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
return
end
end
end)
if not ok then debug(_d({65,43,51,62,16,57,60,25,44,52,47,45,62,51,64,47,61,17,63,51,234,47,60,60,57,60,4},54), err) end
end
local function runPlan()
debug(_d({26,54,43,56,234,61,62,43,60,62,47,46},54))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({29,62,43,60,62,51,56,49,234,56,43,64,234,54,57,57,58},54))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({58,57,61,234,250,248,252,61,234,11,16,30,15,28,234,61,62,43,60,62,24,43,64,4},54), rootAfter and rootAfter.Position)
end)
debug(_d({33,43,51,62,51,56,49,234,255,61,234,44,47,48,57,60,47,234,55,57,64,51,56,49,234,62,57,234,29,62,43,49,47,251},54))
task.wait(5)
for _, stage in ipairs({_d({29,62,43,49,47,251},54), _d({29,62,43,49,47,252},54), _d({29,62,43,49,47,253},54), _d({29,62,43,49,47,253,12},54)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,62,57,234,43,60,60,57,65,234,48,54,67,247,46,57,65,56,234,43,60,47,43},54))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({14,57,46,49,51,56,49,234,43,60,60,57,65,234,60,43,51,56},54))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({29,62,43,49,47,254},54))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({27,63,47,47,56,234,51,56,234,58,50,43,61,47,234,252,234,247,234,53,47,47,58,51,56,49,234,21,47,56,234,18,43,53,51,234,43,45,62,51,64,47,234,48,60,57,55,234,50,47,60,47,234,57,56},54))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({29,62,43,62,63,47,251},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,251},54))
destroyStatue(_d({29,62,43,62,63,47,252},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,251},54))
recheckStatue(_d({29,62,43,62,63,47,252},54))
destroyStatue(_d({29,62,43,62,63,47,253},54))
if not enabled then return end
recheckStatue(_d({29,62,43,62,63,47,253},54))
recheckStatue(_d({29,62,43,62,63,47,252},54))
recheckStatue(_d({29,62,43,62,63,47,251},54))
if not enabled then return end
debug(_d({33,43,51,62,51,56,49,234,48,57,60,234,58,50,43,61,47,234,252,234,62,57,234,47,56,46},54))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({26,50,43,61,47,234,252,234,47,56,46,234,65,43,51,62,234,62,51,55,47,57,63,62,246,234,58,60,57,45,47,47,46,51,56,49,234,43,56,67,65,43,67},54))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,44,43,45,53,234,62,57,234,27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
navToPointConfirmed(COORDS.Queen, 30, _d({27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
debug(_d({33,43,51,62,51,56,49,234,255,61,234,43,62,234,27,63,47,47,56,234,61,62,43,49,47,234,58,57,61,51,62,51,57,56},54))
task.wait(5)
if not enabled then return end
debug(_d({23,57,64,51,56,49,234,62,57,234,58,57,61,62,247,27,63,47,47,56,234,58,57,61,51,62,51,57,56},54))
navToPointConfirmed(COORDS.PostQueen, 30, _d({58,57,61,62,247,27,63,47,47,56,234,58,57,61,51,62,51,57,56},54))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({15,56,43,44,54,51,56,49,246,234,58,57,61,234,12,15,16,25,28,15,234,58,54,43,56,4},54), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({26,54,43,56,234,47,60,60,57,60,4},54), err2) end
end)
debug(_d({15,56,43,44,54,47,46,4},54), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({15,56,43,44,54,47,46,4},54), enabled)
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
if not ok then debug(_d({19,56,58,63,62,12,47,49,43,56,234,47,60,60,57,60,4},54), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({17,43,55,47,234,54,57,43,46,47,46,246,234,43,63,62,57,247,61,62,43,60,62,51,56,49,234,62,50,47,234,58,54,43,56},54))
enableBot()
end)
if not ok then debug(_d({11,63,62,57,61,62,43,60,62,234,47,60,60,57,60,4},54), err) end
end)
debug(_d({22,57,43,46,47,46,234,172,74,94,234,43,63,62,57,247,61,62,43,60,62,51,56,49,234,57,56,45,47,234,62,50,47,234,49,43,55,47,234,48,51,56,51,61,50,47,61,234,54,57,43,46,51,56,49,234,242,58,60,47,61,61,234,26,234,62,57,234,62,57,49,49,54,47,234,55,43,56,63,43,54,54,67,243},54))
end)()