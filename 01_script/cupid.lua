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
local Players            = game:GetService(_d({32,60,49,73,53,66,67},48))
local UserInputService    = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local RunService          = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM                 = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local ReplicatedStorage    = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({43,18,63,67,67,18,63,68,45},48), _d({39,66,63,62,55,240,55,49,61,53,240,178,80,100,240,32,60,49,51,53,25,52,10},48), game.PlaceId, _d({37,62,57,70,53,66,67,53,25,52,10},48), game.GameId, _d({253,240,62,63,68,240,66,69,62,62,57,62,55},48))
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
local LEO_PILLAR_ANIM_ID   = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,5,2,4,4,1,4,1,3,2,7},48)
local LEO_ENTEI_ANIM_ID    = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,5,2,4,4,1,3,8,2,7,8},48)
local LEO_HIKEN_ANIM_ID    = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,5,2,2,0,9,1,7,4,0,7},48)
local LEO_FIREFLY_ANIM_ID  = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,5,2,2,0,2,3,6,1,5,4},48)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({31,50,58,53,51,68,57,70,53,67},48)
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
local REPLAY_BUTTON_VALUE   = _d({34,53,64,60,49,73},48)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({61,63,70,53},48)
local NavState   = {mode = _d({57,52,60,53},48)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({43,18,63,67,67,18,63,68,45},48), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end)
if ok then return root end
debug(_d({55,53,68,34,63,63,68,240,53,66,66,63,66,10},48), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
end)
if ok then return hum end
debug(_d({55,53,68,24,69,61,49,62,63,57,52,240,53,66,66,63,66,10},48), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({47,47,24,63,70,53,66,17,68,68},48)) or Instance.new(_d({17,68,68,49,51,56,61,53,62,68},48))
att.Name = _d({47,47,24,63,70,53,66,17,68,68},48)
att.Parent = root
local force = root:FindFirstChild(_d({47,47,24,63,70,53,66,22,63,66,51,53},48))
if not force then
force = Instance.new(_d({28,57,62,53,49,66,38,53,60,63,51,57,68,73},48))
force.Name = _d({47,47,24,63,70,53,66,22,63,66,51,53},48)
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
debug(_d({55,53,68,31,66,19,66,53,49,68,53,22,63,66,51,53,240,53,66,66,63,66,10},48), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local force = root:FindFirstChild(_d({47,47,24,63,70,53,66,22,63,66,51,53},48))
local att   = root:FindFirstChild(_d({47,47,24,63,70,53,66,17,68,68},48))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({51,60,53,49,62,69,64,22,63,66,51,53,240,53,66,66,63,66,10},48), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({18,69,67,63,29,53,60,53,53},48)) ~= nil
end)
if ok then return result end
debug(_d({57,67,18,69,67,63,17,51,68,57,70,53,240,53,66,66,63,66,10},48), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({18,69,67,63},48))
end)
if not ok then debug(_d({49,51,68,57,70,49,68,53,18,69,67,63,240,53,66,66,63,66,10},48), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({18,69,67,63,240,62,63,68,240,49,51,68,57,70,53,252,240,49,51,68,57,70,49,68,57,62,55},48))
activateBuso()
end
end)
if not ok then debug(_d({18,69,67,63,27,53,53,64,53,66,240,53,66,66,63,66,10},48), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({18,69,67,63,240,59,53,53,64,53,66,240,67,68,63,64,64,53,52},48))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({27,53,62,24,49,59,57},48)) ~= nil
end)
if ok then return result end
debug(_d({57,67,27,53,62,17,51,68,57,70,53,240,53,66,66,63,66,10},48), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({27,53,62},48), true)
end)
if not ok then debug(_d({49,51,68,57,70,49,68,53,27,53,62,240,53,66,66,63,66,10},48), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({27,53,62,240,62,63,68,240,49,51,68,57,70,53,252,240,49,51,68,57,70,49,68,57,62,55},48))
activateKen()
end
end)
if not ok then debug(_d({27,53,62,27,53,53,64,53,66,240,53,66,66,63,66,10},48), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({27,53,62,240,59,53,53,64,53,66,240,67,68,63,64,64,53,52},48))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({30,32,19,67},48)) end)
if ok then return folder end
debug(_d({55,53,68,30,32,19,67,22,63,60,52,53,66,240,53,66,66,63,66,10},48), folder)
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
local r = model:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local h = model:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
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
debug(_d({55,53,68,30,53,49,66,53,67,68,30,32,19,240,53,66,66,63,66,10},48), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hum  = model:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({55,53,68,30,32,19,18,73,30,49,61,53,240,53,66,66,63,66,10},48), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({62,64,51,67,34,53,61,49,57,62,57,62,55,240,53,66,66,63,66,10},48), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({19,69,64,57,52,240,33,69,53,53,62},48))
return queen ~= nil and queen:FindFirstChild(_d({61,63,68,57,63,62,28,53,67,67},48)) ~= nil
end)
if ok then return result end
debug(_d({57,67,33,69,53,53,62,32,56,49,67,53,2,240,53,66,66,63,66,10},48), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,1,2,1,2,9,7,9,4,2,2,9,2,7,6,9},48)
local QUEEN_GRASP_ANIM_ID   = _d({66,50,72,49,67,67,53,68,57,52,10,255,255,1,2,9,8,0,0,0,6,1,0,0,1,7,3,4},48)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
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
debug(_d({57,67,32,60,49,73,57,62,55,17,62,57,61,22,66,63,61,28,57,67,68,240,53,66,66,63,66,10},48), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({18,60,63,51,59,57,62,55},48)) ~= nil
end)
if ok then return result end
debug(_d({57,67,30,32,19,18,60,63,51,59,57,62,55,240,53,66,66,63,66,10},48), result)
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
debug(_d({64,66,53,52,57,51,68,30,32,19,32,63,67,57,68,57,63,62,240,53,66,66,63,66,10},48), result)
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
debug(_d({30,63,240,52,49,61,49,55,53,240,63,62},48), model.Name, _d({54,63,66},48), NPC_STUCK_TIMEOUT, _d({67,240,253,240,67,71,57,68,51,56,57,62,55,240,68,49,66,55,53,68},48))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({68,66,49,51,59,30,32,19,20,49,61,49,55,53,240,53,66,66,63,66,10},48), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({29,63,52,53,60},48)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({18,49,67,53,32,49,66,68},48)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({55,53,68,29,63,52,53,60,22,49,51,53,32,63,67,240,53,66,66,63,66,10},48), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({21,62,70},48))
local folder = env and env:FindFirstChild(_d({35,68,49,68,69,53,67},48))
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
debug(_d({55,53,68,35,68,49,68,69,53,29,63,52,53,60,30,53,49,66,240,53,66,66,63,66,10},48), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({50,49,66,66,53,60,24,32},48))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({55,53,68,35,68,49,68,69,53,24,32,240,53,66,66,63,66,10},48), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({36,63,63,60},48)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({54,57,62,52,36,63,63,60,18,73,17,68,68,66,57,50,69,68,53,240,53,66,66,63,66,10},48), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({36,63,63,60},48)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({54,57,62,52,36,63,63,60,18,73,30,49,61,53,240,53,66,66,63,66,10},48), tool)
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
if not ok then debug(_d({53,65,69,57,64,36,63,63,60,240,53,66,66,63,66,10},48), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({36,63,63,60},48)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({54,57,62,52,36,63,63,60,18,73,19,56,57,60,52,30,49,61,53,240,53,66,66,63,66,10},48), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({35,71,63,66,52,21,65,69,57,64},48))
if sword then
equipTool(sword)
return _d({67,71,63,66,52},48)
end
local melee = findToolByAttribute(_d({29,53,60,53,53,36,63,63,60},48))
if melee then
equipTool(melee)
return _d({61,53,60,53,53},48)
end
debug(_d({30,63,240,67,71,63,66,52,240,63,66,240,61,53,60,53,53,240,68,63,63,60,240,54,63,69,62,52},48))
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
if not ok then debug(_d({51,60,57,51,59,29,1,240,53,66,66,63,66,10},48), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({34,63,59,69,67,56,57,59,57},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,53,64,64,63},48), args)
elseif style == _d({18,60,49,51,59,28,53,55},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,59,73,240,39,49,60,59},48), args)
elseif style == _d({27,49,61,57,67,56,57,59,57},48) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,49,61,57,67,56,57,59,57,23,53,64,64,63},48), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,59,73,240,39,49,60,59,2},48), args)
end
end)
if not ok then debug(_d({57,62,70,63,59,53,23,53,64,64,63,240,53,66,66,63,66,10},48), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({64,66,53,67,67,35,59,57,60,60,34,240,53,66,66,63,66,10},48), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({56,63,60,52,18,60,63,51,59,240,53,66,66,63,66,10},48), err) end
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
if not ok then debug(_d({56,63,60,52,18,60,63,51,59,39,56,57,60,53,240,53,66,66,63,66,10},48), err) end
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
debug(_d({55,53,68,23,49,61,53,23,240,53,66,66,63,66,10},48), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({57,67,34,53,49,60,29,1,18,69,67,73,240,53,66,66,63,66,10},48), result)
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
return char ~= nil and char:FindFirstChild(_d({67,68,69,62},48)) ~= nil
end)
if ok then return result end
debug(_d({57,67,35,68,69,62,62,53,52,240,53,66,66,63,66,10},48), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({64,66,53,67,67,35,68,69,62,18,66,53,49,59,240,53,66,66,63,66,10},48), err) end
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
debug(_d({65,69,53,53,62,20,63,52,55,53,37,62,68,57,60,35,49,54,53,10,240,33,69,53,53,62,240,55,63,62,53,240,253,240,53,62,52,57,62,55,240,52,63,52,55,53,240,53,49,66,60,73},48))
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
debug(_d({65,69,53,53,62,20,63,52,55,53,37,62,68,57,60,35,49,54,53,240,67,49,54,53,68,73,240,68,57,61,53,63,69,68},48))
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
local info = getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({33,69,53,53,62,240,51,49,67,68,57,62,55,240,52,53,68,53,51,68,53,52,240,253,240,52,63,52,55,57,62,55,240,248,71,49,68,51,56,53,66,249},48))
queenDodgeUntilSafe(function() return getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48)) end)
if enabled and getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48)) then
setNavNamed(_d({19,69,64,57,52,240,33,69,53,53,62},48))
end
queenDodging = false
end
end)
if not ok then debug(_d({65,69,53,53,62,20,63,52,55,53,39,49,68,51,56,53,66,240,53,66,66,63,66,10},48), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({64,63,57,62,68},48) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({62,64,51},48) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({62,49,61,53,52},48) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({55,53,68,30,49,70,36,49,66,55,53,68,67,240,53,66,66,63,66,10},48), aimR)
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
debug(_d({51,63,61,64,69,68,53,28,63,51,59,53,52,19,22,66,49,61,53,240,53,66,66,63,66,10},48), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({64,63,57,62,68},48), point = pos}
phase = _d({61,63,70,53},48)
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
if not ok then debug(_d({62,49,70,36,63,32,63,57,62,68,240,55,53,64,64,63,240,51,56,53,51,59,240,53,66,66,63,66,10},48), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({62,64,51},48)}
phase = _d({61,63,70,53},48)
end
function setNavNamed(name)
NavState = {mode = _d({62,49,61,53,52},48), name = name}
phase = _d({61,63,70,53},48)
end
local function setNavIdle()
NavState = {mode = _d({57,52,60,53},48)}
phase = _d({61,63,70,53},48)
end
local function hasArrived()
return phase == _d({56,63,70,53,66},48)
end
local function startNav()
phase = _d({61,63,70,53},48)
debug(_d({30,49,70,240,60,63,63,64,240,31,30},48))
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
local prevPos = force:GetAttribute(_d({47,47,64,66,53,70,32,63,67},48))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({28,49,66,55,53,240,64,63,67,57,68,57,63,62,240,58,69,61,64,240,52,53,68,53,51,68,53,52,10},48), delta, _d({67,68,69,52,67,254,240,64,66,53,70,32,63,67,13},48), prevPos, _d({62,53,71,32,63,67,13},48), pos)
end
end
force:SetAttribute(_d({47,47,64,66,53,70,32,63,67},48), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({61,63,70,53},48) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({56,63,70,53,66},48)
debug(_d({32,56,49,67,53,10,240,56,63,70,53,66},48))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({241,241,241,240,34,21,22,37,35,25,30,23,240,36,31,240,17,32,32,28,41,240,17,18,30,31,34,29,17,28,240,38,21,28,31,19,25,36,41,10},48), finalVel, _d({49,57,61,13},48), aim, _d({64,63,67,13},48), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({56,63,70,53,66},48) then
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
debug(_d({19,63,61,50,49,68,240,60,63,51,59,240,67,59,57,64,64,53,52,252},48), snapDist, _d({67,68,69,52,67,240,54,66,63,61,240,68,49,66,55,53,68,240,178,80,100,240,54,49,60,60,57,62,55,240,50,49,51,59,240,68,63,240,61,63,70,53},48))
phase = _d({61,63,70,53},48)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({24,53,49,66,68,50,53,49,68,240,53,66,66,63,66,10},48), err) end
end)
end
local function stopNav()
debug(_d({30,49,70,240,60,63,63,64,240,31,22,22},48))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({61,63,70,53},48)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({36,53,72,68,19,56,49,68,35,53,66,70,57,51,53},48))
local channels = TextChatService:FindFirstChild(_d({36,53,72,68,19,56,49,62,62,53,60,67},48))
local channel = channels and channels:FindFirstChild(_d({34,18,40,23,53,62,53,66,49,60},48))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({20,53,54,49,69,60,68,19,56,49,68,35,73,67,68,53,61,19,56,49,68,21,70,53,62,68,67},48))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({35,49,73,29,53,67,67,49,55,53,34,53,65,69,53,67,68},48))
if sayEvent then
sayEvent:FireServer(message, _d({17,60,60},48))
return
end
debug(_d({67,53,62,52,19,56,49,68,29,53,67,67,49,55,53,10,240,62,63,240,36,53,72,68,19,56,49,68,35,53,66,70,57,51,53,254,34,18,40,23,53,62,53,66,49,60,240,63,66,240,60,53,55,49,51,73,240,35,49,73,29,53,67,67,49,55,53,34,53,65,69,53,67,68,240,54,63,69,62,52,240,54,63,66},48), message)
end)
if not ok then debug(_d({67,53,62,52,19,56,49,68,29,53,67,67,49,55,53,240,53,66,66,63,66,10},48), err) end
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
debug(_d({30,63,68,240,61,49,59,57,62,55,240,64,66,63,55,66,53,67,67,240,68,63,71,49,66,52,240,62,49,70,240,68,49,66,55,53,68,240,54,63,66},48), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({67,240,253,240,67,53,62,52,57,62,55,240,255,69,62,67,68,69,51,59},48))
sendChatMessage(_d({255,69,62,67,68,69,51,59},48))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({71,49,57,68,37,62,68,57,60,17,66,66,57,70,53,52,240,68,57,61,53,63,69,68},48))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({62,49,70,36,63,32,63,57,62,68,19,63,62,54,57,66,61,53,52,10},48), label or _d({68,49,66,55,53,68},48), _d({253,240,52,57,52,240,62,63,68,240,49,66,66,57,70,53,240,71,57,68,56,57,62},48), timeout, _d({67,252,240,66,53,68,66,73,57,62,55,240,63,62,51,53},48))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({62,49,70,36,63,32,63,57,62,68,19,63,62,54,57,66,61,53,52,10},48), label or _d({68,49,66,55,53,68},48), _d({253,240,67,68,57,60,60,240,62,63,68,240,49,66,66,57,70,53,52,240,49,54,68,53,66,240,66,53,68,66,73,252,240,64,66,63,51,53,53,52,57,62,55,240,49,62,73,71,49,73},48))
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
if not ok then debug(_d({62,49,70,36,63,32,63,57,62,68,24,63,60,52,57,62,55,18,60,63,51,59,240,59,53,73,253,52,63,71,62,240,53,66,66,63,66,10},48), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({62,49,70,36,63,32,63,57,62,68,24,63,60,52,57,62,55,18,60,63,51,59,240,59,53,73,253,69,64,240,53,66,66,63,66,10},48), err2) end
end
local function clearStage(stageName)
debug(_d({29,63,70,57,62,55,240,68,63},48), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({39,49,57,68,57,62,55,240,54,63,66,240,30,32,19,67,240,68,63,240,67,64,49,71,62,240,49,68},48), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({240,240,67,64,49,71,62,240,51,56,53,51,59,10,240,54,63,60,52,53,66,240,53,72,57,67,68,67,240,13},48), folder ~= nil,
_d({252,240,51,56,57,60,52,66,53,62,240,13},48), folder and #folder:GetChildren() or 0,
_d({252,240,49,60,57,70,53,240,13},48), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({30,63,240,30,32,19,67,240,49,64,64,53,49,66,53,52,240,49,68},48), stageName, _d({49,54,68,53,66,240,1,5,67,252,240,61,63,70,57,62,55,240,63,62,240,49,62,73,71,49,73},48))
break
end
end
debug(_d({27,57,60,60,57,62,55,240,30,32,19,67,240,49,68},48), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({34,53,68,69,66,62,57,62,55,240,68,63},48), stageName, _d({64,63,67,57,68,57,63,62,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,63,62},48))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({39,49,57,68,57,62,55,240,5,67,240,49,68},48), stageName, _d({64,63,67,57,68,57,63,62},48))
task.wait(5)
debug(stageName, _d({51,60,53,49,66,53,52},48))
end
local function killNamedNPC(name, targetPos)
debug(_d({29,63,70,57,62,55,240,68,63},48), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({52,53,54,53,49,68,53,52},48))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({28,53,63,240,64,60,49,73,53,52,240,49,62,57,61,49,68,57,63,62,10},48), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({60,53,63,17,62,57,61,28,63,55,55,53,66,240,64,66,57,62,68,240,53,66,66,63,66,10},48), err2) end
end)
end)
if not ok then debug(_d({67,68,49,66,68,28,53,63,17,62,57,61,28,63,55,55,53,66,240,53,66,66,63,66,10},48), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({29,63,70,57,62,55,240,68,63,240,28,53,63,240,248,50,60,63,51,59,57,62,55,240,49,54,68,53,66},48), LEO_BLOCK_DELAY, _d({67,249},48))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({28,53,63},48))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({28,53,63},48))
while enabled do
local info = getNPCByName(_d({28,53,63},48))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({28,53,63,240,51,49,67,68,57,62,55},48), which, _d({253,240,52,63,52,55,57,62,55},48))
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
if not getNPCByName(_d({28,53,63},48)) then
debug(_d({28,53,63,240,55,63,62,53,240,61,57,52,253,52,63,52,55,53,240,253,240,53,62,52,57,62,55,240,21,62,68,53,57,240,56,63,60,52,240,53,49,66,60,73},48))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({28,53,63},48)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({28,53,63,240,55,63,62,53,240,61,57,52,253,52,63,52,55,53,240,253,240,53,62,52,57,62,55,240,22,60,49,61,53,240,32,57,60,60,49,66,240,56,63,60,52,240,53,49,66,60,73},48))
end
end
end
if enabled and getNPCByName(_d({28,53,63},48)) then
setNavNamed(_d({28,53,63},48))
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
debug(_d({28,53,63,240,52,53,54,53,49,68,53,52},48))
stopLeoAnimLogger()
debug(_d({34,53,68,69,66,62,57,62,55,240,68,63,240,28,53,63,240,64,63,67,57,68,57,63,62,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,63,62},48))
navToPointConfirmed(COORDS.Leo, 30, _d({28,53,63,240,64,63,67,57,68,57,63,62},48))
debug(_d({39,49,57,68,57,62,55,240,5,67,240,49,68,240,28,53,63,240,64,63,67,57,68,57,63,62},48))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({29,63,70,57,62,55,240,68,63},48), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({19,63,69,60,52,240,62,63,68,240,54,57,62,52,240,67,68,49,68,69,53,240,61,63,52,53,60,240,62,53,49,66},48), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({17,68,68,49,51,59,57,62,55},48), coordKey, _d({71,57,68,56},48), weapon or _d({62,63,68,56,57,62,55,240,54,63,69,62,52},48))
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
debug(coordKey, _d({50,49,66,66,53,60,240,52,53,67,68,66,63,73,53,52},48))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({66,53,51,56,53,51,59,35,68,49,68,69,53,10},48), coordKey, _d({253,240,51,63,69,60,52,240,62,63,68,240,54,57,62,52,240,67,68,49,68,69,53,240,61,63,52,53,60,252,240,67,59,57,64,64,57,62,55},48))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({66,53,51,56,53,51,59,35,68,49,68,69,53,10},48), coordKey, _d({67,68,57,60,60,240,49,60,57,70,53,240,248,24,32},48), hp, _d({249,240,253,240,66,53,253,52,53,67,68,66,63,73,57,62,55},48))
destroyStatue(coordKey)
else
debug(_d({66,53,51,56,53,51,59,35,68,49,68,69,53,10},48), coordKey, _d({51,63,62,54,57,66,61,53,52,240,52,53,67,68,66,63,73,53,52},48))
end
end)
if not ok then debug(_d({66,53,51,56,53,51,59,35,68,49,68,69,53,240,53,66,66,63,66,10},48), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({29,63,70,57,62,55,240,68,63,240,33,69,53,53,62},48))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({19,69,64,57,52,240,33,69,53,53,62},48))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({33,69,53,53,62,240,53,62,68,53,66,53,52,240,64,56,49,67,53,240,2},48))
end
local function finishQueen()
debug(_d({22,57,62,57,67,56,57,62,55,240,33,69,53,53,62},48))
equipSwordOrMelee()
setNavNamed(_d({19,69,64,57,52,240,33,69,53,53,62},48))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({33,69,53,53,62,240,52,53,54,53,49,68,53,52,254,240,32,60,49,62,240,51,63,61,64,60,53,68,53,254},48))
end
local CONFIRMATION_PROMPT_NAME = _d({19,63,62,54,57,66,61,49,68,57,63,62,32,66,63,61,64,68},48)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({34,53,61,63,68,53,21,70,53,62,68},48), 5)
end)
if ok then return result end
debug(_d({55,53,68,34,53,64,60,49,73,34,53,61,63,68,53,240,53,66,66,63,66,10},48), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({32,60,49,73,53,66,23,69,57},48))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({25,61,49,55,53,18,69,68,68,63,62},48)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({50,69,68,68,63,62,38,49,60,69,53},48)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({54,57,62,52,18,69,68,68,63,62,18,73,38,49,60,69,53,240,53,66,66,63,66,10},48), result)
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
if not ok then debug(_d({51,60,57,51,59,23,69,57,18,69,68,68,63,62,240,53,66,66,63,66,10},48), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({57,67,35,53,66,70,53,66},48))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({34,53,61,63,68,53,21,70,53,62,68},48))
or inst:FindFirstChild(_d({51,60,57,53,62,68,21,70,53,62,68},48))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({54,57,62,52,17,62,67,71,53,66,19,63,62,62,53,51,68,63,66,240,53,66,66,63,66,10},48), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({19,63,69,60,52,240,62,63,68,240,60,63,51,49,68,53,240,34,53,61,63,68,53,21,70,53,62,68,255,51,60,57,53,62,68,21,70,53,62,68,240,62,53,49,66,240,34,53,64,60,49,73,240,50,69,68,68,63,62,252,240,54,49,60,60,57,62,55,240,50,49,51,59,240,68,63,240,51,60,57,51,59},48))
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
debug(_d({54,57,66,53,34,53,64,60,49,73,38,49,60,69,53,240,53,66,66,63,66,10},48), err, _d({253,240,54,49,60,60,57,62,55,240,50,49,51,59,240,68,63,240,51,60,57,51,59},48))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({22,49,60,60,57,62,55,240,50,49,51,59,240,68,63,240,50,69,68,68,63,62,38,49,60,69,53,240,67,53,49,66,51,56,240,54,63,66,240,34,53,64,60,49,73},48))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({34,53,64,60,49,73,240,50,69,68,68,63,62,240,62,63,68,240,54,63,69,62,52,240,53,57,68,56,53,66,252,240,55,57,70,57,62,55,240,69,64},48))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({39,49,57,68,57,62,55,240,54,63,66,240,19,63,62,54,57,66,61,49,68,57,63,62,32,66,63,61,64,68,254,34,53,61,63,68,53,21,70,53,62,68},48))
local remote = getReplayRemote()
if not remote then
debug(_d({19,63,62,54,57,66,61,49,68,57,63,62,32,66,63,61,64,68,255,34,53,61,63,68,53,21,70,53,62,68,240,62,63,68,240,54,63,69,62,52,240,71,57,68,56,57,62,240,68,57,61,53,63,69,68},48))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({22,57,66,57,62,55,240,34,53,64,60,49,73,240,70,57,49,240,19,63,62,54,57,66,61,49,68,57,63,62,32,66,63,61,64,68,254,34,53,61,63,68,53,21,70,53,62,68},48))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({22,57,66,53,35,53,66,70,53,66,240,53,66,66,63,66,10},48), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48), 10)
if not playerGui then
debug(_d({71,49,57,68,22,63,66,31,50,58,53,51,68,57,70,53,67,23,69,57,10,240,62,63,240,32,60,49,73,53,66,23,69,57,240,71,57,68,56,57,62,240,68,57,61,53,63,69,68,252,240,64,66,63,51,53,53,52,57,62,55,240,49,62,73,71,49,73},48))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({31,50,58,53,51,68,57,70,53,67,240,23,37,25,240,54,63,69,62,52,240,253,240,67,68,49,55,53,240,60,63,49,52,53,52},48))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({31,50,58,53,51,68,57,70,53,67,240,23,37,25,240,62,63,68,240,54,63,69,62,52,240,71,57,68,56,57,62,240,68,57,61,53,63,69,68,252,240,64,66,63,51,53,53,52,57,62,55,240,49,62,73,71,49,73},48))
return
end
end
end)
if not ok then debug(_d({71,49,57,68,22,63,66,31,50,58,53,51,68,57,70,53,67,23,69,57,240,53,66,66,63,66,10},48), err) end
end
local function runPlan()
debug(_d({32,60,49,62,240,67,68,49,66,68,53,52},48))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({35,68,49,66,68,57,62,55,240,62,49,70,240,60,63,63,64},48))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({64,63,67,240,0,254,2,67,240,17,22,36,21,34,240,67,68,49,66,68,30,49,70,10},48), rootAfter and rootAfter.Position)
end)
debug(_d({39,49,57,68,57,62,55,240,5,67,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,68,63,240,35,68,49,55,53,1},48))
task.wait(5)
for _, stage in ipairs({_d({35,68,49,55,53,1},48), _d({35,68,49,55,53,2},48), _d({35,68,49,55,53,3},48), _d({35,68,49,55,53,3,18},48)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({29,63,70,57,62,55,240,68,63,240,49,66,66,63,71,240,54,60,73,253,52,63,71,62,240,49,66,53,49},48))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({20,63,52,55,57,62,55,240,49,66,66,63,71,240,66,49,57,62},48))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({35,68,49,55,53,4},48))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({33,69,53,53,62,240,57,62,240,64,56,49,67,53,240,2,240,253,240,59,53,53,64,57,62,55,240,27,53,62,240,24,49,59,57,240,49,51,68,57,70,53,240,54,66,63,61,240,56,53,66,53,240,63,62},48))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({35,68,49,68,69,53,1},48))
if not enabled then return end
recheckStatue(_d({35,68,49,68,69,53,1},48))
destroyStatue(_d({35,68,49,68,69,53,2},48))
if not enabled then return end
recheckStatue(_d({35,68,49,68,69,53,1},48))
recheckStatue(_d({35,68,49,68,69,53,2},48))
destroyStatue(_d({35,68,49,68,69,53,3},48))
if not enabled then return end
recheckStatue(_d({35,68,49,68,69,53,3},48))
recheckStatue(_d({35,68,49,68,69,53,2},48))
recheckStatue(_d({35,68,49,68,69,53,1},48))
if not enabled then return end
debug(_d({39,49,57,68,57,62,55,240,54,63,66,240,64,56,49,67,53,240,2,240,68,63,240,53,62,52},48))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({32,56,49,67,53,240,2,240,53,62,52,240,71,49,57,68,240,68,57,61,53,63,69,68,252,240,64,66,63,51,53,53,52,57,62,55,240,49,62,73,71,49,73},48))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({29,63,70,57,62,55,240,50,49,51,59,240,68,63,240,33,69,53,53,62,240,67,68,49,55,53,240,64,63,67,57,68,57,63,62},48))
navToPointConfirmed(COORDS.Queen, 30, _d({33,69,53,53,62,240,67,68,49,55,53,240,64,63,67,57,68,57,63,62},48))
debug(_d({39,49,57,68,57,62,55,240,5,67,240,49,68,240,33,69,53,53,62,240,67,68,49,55,53,240,64,63,67,57,68,57,63,62},48))
task.wait(5)
if not enabled then return end
debug(_d({29,63,70,57,62,55,240,68,63,240,64,63,67,68,253,33,69,53,53,62,240,64,63,67,57,68,57,63,62},48))
navToPointConfirmed(COORDS.PostQueen, 30, _d({64,63,67,68,253,33,69,53,53,62,240,64,63,67,57,68,57,63,62},48))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({21,62,49,50,60,57,62,55,252,240,64,63,67,240,18,21,22,31,34,21,240,64,60,49,62,10},48), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({32,60,49,62,240,53,66,66,63,66,10},48), err2) end
end)
debug(_d({21,62,49,50,60,53,52,10},48), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({21,62,49,50,60,53,52,10},48), enabled)
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
if not ok then debug(_d({25,62,64,69,68,18,53,55,49,62,240,53,66,66,63,66,10},48), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({23,49,61,53,240,60,63,49,52,53,52,252,240,49,69,68,63,253,67,68,49,66,68,57,62,55,240,68,56,53,240,64,60,49,62},48))
enableBot()
end)
if not ok then debug(_d({17,69,68,63,67,68,49,66,68,240,53,66,66,63,66,10},48), err) end
end)
debug(_d({28,63,49,52,53,52,240,178,80,100,240,49,69,68,63,253,67,68,49,66,68,57,62,55,240,63,62,51,53,240,68,56,53,240,55,49,61,53,240,54,57,62,57,67,56,53,67,240,60,63,49,52,57,62,55,240,248,64,66,53,67,67,240,32,240,68,63,240,68,63,55,55,60,53,240,61,49,62,69,49,60,60,73,249},48))
end)()