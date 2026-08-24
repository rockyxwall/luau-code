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
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({32,60,49,73,53,66,67},48))
local UserInputService    = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local RunService          = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM                 = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local ReplicatedStorage    = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
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
local function Core.GetRoot(LocalPlayer)
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
local root = Core.GetRoot(LocalPlayer)
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
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
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
local navToPoint, setNavNamed, disableBot
local function queenDodgeUntilSafe(getInfoFn)
local info = getInfoFn()
if not info then return end
local root = Core.GetRoot(LocalPlayer)
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
debug(_d({65,69,53,53,62,20,63,52,55,53,37,62,68,57,60,35,49,54,53,10,240,33,69,53,53,62,240,55,63,62,53,240,253,240,53,62,52,57,62,55,240,52,63,52,55,53,240,53,49,66,60,73},48))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
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
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({32,60,49,73,53,66,240,52,57,53,52,241,240,35,68,63,64,64,57,62,55,240,50,63,68,254},48))
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
debug(_d({32,60,49,73,53,66,240,57,67,240,68,63,63,240,54,49,66,240,54,66,63,61,240,68,49,66,55,53,68,240,248,14,2,0,0,0,240,67,68,69,52,67,249,254,240,28,57,59,53,60,73,240,66,53,67,64,49,71,62,53,52,240,49,68,240,60,63,50,50,73,254,240,35,68,63,64,64,57,62,55,240,50,63,68,254},48))
disableBot()
return
end
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
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({39,49,60,59,57,62,55,240,68,63,10},48), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({71,49,60,59,36,63,32,63,57,62,68,240,39,240,52,63,71,62,240,53,66,66,63,66,10},48), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
local hum = getHumanoid()
local startHP = hum and hum.Health or math.huge
local lastUnstuckCheck = tick()
local lastPos = nil
local stuckTicks = 0
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({36,63,63,59,240,52,49,61,49,55,53,240,71,56,57,60,53,240,71,49,60,59,57,62,55,240,68,63,240,64,63,57,62,68,241,240,35,68,63,64,64,57,62,55,240,71,49,60,59,240,68,63,240,53,62,55,49,55,53,254},48))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({17,66,66,57,70,53,52,240,49,68,10},48), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({35,68,69,51,59,240,52,69,66,57,62,55,240,71,49,60,59,252,240,58,69,61,64,57,62,55,241},48))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({35,68,57,60,60,240,67,68,69,51,59,252,240,68,66,57,55,55,53,66,57,62,55,240,23,53,64,64,63,241},48))
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
debug(_d({29,63,70,57,62,55,240,68,63},48), stageName)
walkToPoint(COORDS[stageName], 30)
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
debug(_d({34,53,68,69,66,62,57,62,55,240,68,63},48), stageName, _d({64,63,67,57,68,57,63,62,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,63,62},48))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({39,49,57,68,57,62,55,240,5,67,240,49,68},48), stageName, _d({64,63,67,57,68,57,63,62},48))
task.wait(5)
debug(_d({39,49,57,68,57,62,55,240,54,63,66},48), targetHP * 100, _d({245,240,24,32,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,68,63,240,62,53,72,68,240,67,68,49,55,53},48))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({51,60,53,49,66,53,52},48))
end
local function killNamedNPC(name, targetPos)
debug(_d({29,63,70,57,62,55,240,68,63},48), name)
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
debug(_d({29,63,70,57,62,55,240,68,63,240,28,53,63},48))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({28,53,63},48))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({28,53,63},48))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({28,53,63},48))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({28,53,63,240,51,49,67,68,57,62,55},48), which, _d({253,240,52,63,52,55,57,62,55},48))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({28,53,63,240,67,68,49,66,68,53,52,240,50,60,63,51,59,253,50,66,53,49,59,53,66,240,61,57,52,253,50,60,63,51,59,241,240,21,70,49,52,57,62,55,254,254,254},48))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = Core.GetRoot(LocalPlayer)
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
if not getNPCByName(_d({28,53,63},48)) then
debug(_d({28,53,63,240,55,63,62,53,240,61,57,52,253,52,63,52,55,53,240,253,240,53,62,52,57,62,55,240,21,62,68,53,57,240,56,63,60,52,240,53,49,66,60,73},48))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({28,53,63},48)) then
setNavNamed(_d({28,53,63},48))
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
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({19,69,64,57,52,240,33,69,53,53,62},48))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48))
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
debug(_d({33,69,53,53,62,240,53,62,68,53,66,53,52,240,64,56,49,67,53,240,2},48))
end
local function finishQueen()
debug(_d({22,57,62,57,67,56,57,62,55,240,33,69,53,53,62},48))
equipSwordOrMelee()
setNavNamed(_d({19,69,64,57,52,240,33,69,53,53,62},48))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({19,69,64,57,52,240,33,69,53,53,62},48))
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
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({64,63,67,240,0,254,2,67,240,17,22,36,21,34,240,67,68,49,66,68,30,49,70,10},48), rootAfter and rootAfter.Position)
end)
debug(_d({39,49,57,68,57,62,55,240,5,67,240,50,53,54,63,66,53,240,61,63,70,57,62,55,240,68,63,240,35,68,49,55,53,1},48))
task.wait(5)
for _, stage in ipairs({_d({35,68,49,55,53,1},48), _d({35,68,49,55,53,2},48), _d({35,68,49,55,53,3},48), _d({35,68,49,55,53,3,18},48)}) do
if not enabled then return end
local hpTarget = (stage == _d({35,68,49,55,53,3,18},48)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({29,63,70,57,62,55,240,68,63,240,49,66,66,63,71,240,54,60,73,253,52,63,71,62,240,49,66,53,49,240,248,19,69,64,57,52,240,34,49,57,62,249},48))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({20,63,52,55,57,62,55,240,49,66,66,63,71,240,66,49,57,62,240,57,62,240,49,240,67,65,69,49,66,53},48))
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
local CupidDungeon = {
Connections = {}
}
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
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
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.RequirePlace(11424731604, _d({19,69,64,57,52,240,20,69,62,55,53,63,62},48)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
if not _G.DisableStandalone then
table.insert(CupidDungeon.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if enabled then
CupidDungeon.Stop()
else
CupidDungeon.Start()
end
end
end))
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({23,49,61,53,240,60,63,49,52,53,52,252,240,49,69,68,63,253,67,68,49,66,68,57,62,55,240,68,56,53,240,64,60,49,62},48))
CupidDungeon.Start()
end)
debug(_d({35,68,49,62,52,49,60,63,62,53,240,29,63,52,53,10,240,49,69,68,63,253,67,68,49,66,68,57,62,55,240,248,64,66,53,67,67,240,45,240,68,63,240,68,63,55,55,60,53,249},48))
end
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({26,69,74,63,240,68,56,53,240,20,57,49,61,63,62,52,50,49,51,59},48),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({18,49,51,59,64,49,51,59},48))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)) or (bp and bp:FindFirstChild(_d({24,63,66,63,253,24,63,66,63},48)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({30,32,19,67},48))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hum = boss:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({24,57,68},48) then return target.CFrame
elseif key == _d({36,49,66,55,53,68},48) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({43,24,63,66,63,22,49,66,61,45,240,29,53,68,49,68,49,50,60,53,240,56,63,63,59,240,54,49,57,60,53,52,10,240},48) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({43,24,63,66,63,22,49,66,61,45,240,35,68,63,64,64,53,52,254},48))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({43,24,63,66,63,22,49,66,61,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241},48)); return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({43,24,63,66,63,22,49,66,61,45,240,35,68,49,66,68,53,52,240,68,49,66,55,53,68,57,62,55,10,240},48) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
if not _G.DisableStandalone then
table.insert(HoroFarm.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if HoroFarm.Running then
HoroFarm.Stop()
else
HoroFarm.Start()
end
end
end))
HoroFarm.Start()
print(_d({43,24,63,66,63,22,49,66,61,45,240,35,68,49,62,52,49,60,63,62,53,240,29,63,52,53,10,240,32,66,53,67,67,240,247,45,247,240,68,63,240,68,63,55,55,60,53,254},48))
end
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,35,68,63,64,64,53,52,254},48))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,17,60,66,53,49,52,73,240,66,69,62,62,57,62,55,241},48)); return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.RequirePlace(3978370137, _d({22,57,66,67,68,240,35,53,49},48)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48), 10)
local hum = char:WaitForChild(_d({24,69,61,49,62,63,57,52},48), 10)
local stats = ReplicatedStorage:WaitForChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({32,53,60,57},48), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (char and char:FindFirstChild(_d({34,57,54,60,53},48)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,19,69,66,66,53,62,68,240,32,53,60,57,240,51,56,53,51,59,10},48), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,30,63,68,240,49,68,240,36,63,71,62,240,63,54,240,18,53,55,57,62,62,57,62,55,67,254,240,32,60,53,49,67,53,240,68,66,49,70,53,60,240,68,56,53,66,53,240,68,63,240,54,49,66,61,240,51,56,53,67,68,67,240,71,56,57,60,53,240,71,49,57,68,57,62,55,240,54,63,66,240,34,57,54,60,53,254},48))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,56,53,67,68,47,54,49,66,61,53,66,254,60,69,49},48))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,49,66,61,57,62,55,240,51,56,53,67,68,67,240,69,62,68,57,60,240,3,0,0,240,32,53,60,57,254,254,254,240,248,19,69,66,66,53,62,68,10,240},48) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({32,53,60,57},48))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48)) or (c and c:FindFirstChild(_d({34,57,54,60,53},48))))
end)
else
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,30,49,70,57,55,49,68,57,62,55,240,68,63,240,50,69,73,240,34,57,54,60,53,254,254,254},48))
local buyables = workspace:FindFirstChild(_d({18,69,73,49,50,60,53,25,68,53,61,67},48))
local shopItem = buyables and buyables:FindFirstChild(_d({34,57,54,60,53},48))
local shopPart = shopItem and shopItem:FindFirstChild(_d({35,56,63,64,32,49,66,68},48))
if shopPart and hrp then
hrp.CFrame = shopPart.CFrame * CFrame.new(0, 3, 0)
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({21,70,53,62,68,67},48)) and ReplicatedStorage.Events:FindFirstChild(_d({35,56,63,64},48))
if shopEvent and shopEvent:IsA(_d({34,53,61,63,68,53,22,69,62,51,68,57,63,62},48)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,21,65,69,57,64,64,57,62,55,240,34,57,54,60,53,254,254,254},48))
local args = {
[1] = _d({53,65,69,57,64},48),
[2] = _d({34,57,54,60,53},48)
}
pcall(function()
game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48)):WaitForChild(_d({21,70,53,62,68,67},48)):WaitForChild(_d({36,63,63,60,67},48)):InvokeServer(unpack(args))
end)
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52},48))
local hrp = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({34,57,54,60,53},48))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,22,60,73,57,62,55,240,68,63,240,22,57,67,56,61,49,62,240,19,49,70,53,254,254,254},48))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({0,1,253,55,64,63,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48), _d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,53,49,67,73,47,68,66,49,70,53,60,254,60,69,49},48))
_G.DisableStandalone = old
end
if EasyTravel then
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 50 then break end
task.wait(1)
end
pcall(EasyTravel.Stop)
end
LevelGrinder.Stop()
end)
end
if not _G.DisableStandalone then
table.insert(LevelGrinder.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if not processed and input.KeyCode == Enum.KeyCode.RightBracket then
LevelGrinder.Stop()
end
end))
LevelGrinder.Start()
if LevelGrinder.Running then
print(_d({43,28,53,70,53,60,240,23,66,57,62,52,53,66,45,240,35,68,49,62,52,49,60,63,62,53,240,29,63,52,53,10,240,32,66,53,67,67,240,247,45,247,240,68,63,240,67,68,63,64,254},48))
end
end
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local RunService       = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)) then
Core = loadstring(readfile(_d({0,1,253,55,64,63,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
else
Core = loadstring(game:HttpGet(_d({56,68,68,64,67,10,255,255,66,49,71,254,55,57,68,56,69,50,69,67,53,66,51,63,62,68,53,62,68,254,51,63,61,255,66,63,51,59,73,72,71,49,60,60,255,60,69,49,69,253,51,63,52,53,255,61,49,57,62,255,0,1,47,67,51,66,57,64,68,255,60,57,50,255,51,63,66,53,254,60,69,49},48)))()
end
end)
if not Core then warn(_d({43,19,63,66,53,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
Connections = {}
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
return char, char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)), char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48)) or Instance.new(_d({17,68,68,49,51,56,61,53,62,68},48))
att.Name = _d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48)
att.Parent = root
local force = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48))
if not force then
force = Instance.new(_d({28,57,62,53,49,66,38,53,60,63,51,57,68,73},48))
force.Name = _d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48)
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
local force = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,22,63,66,51,53},48))
local att = root:FindFirstChild(_d({47,47,21,49,67,73,36,66,49,70,53,60,17,68,68},48))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
function EasyTravel.GetSurfaceY(position, character)
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
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local moveDir = Vector3.zero
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
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
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then return end
if not Safeguard then warn(_d({43,35,49,54,53,55,69,49,66,52,45,240,22,49,57,60,53,52,240,68,63,240,60,63,49,52,241},48)); return end
if not Safeguard.IsSafe() then return end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then moveDir = flatDiff.Unit end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({43,21,49,67,73,240,36,66,49,70,53,60,45,240,22,60,57,55,56,68,240,53,62,49,50,60,53,52,254},48))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({43,21,49,67,73,240,36,66,49,70,53,60,45,240,22,60,57,55,56,68,240,52,57,67,49,50,60,53,52,254},48))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
if not _G.DisableStandalone then
table.insert(EasyTravel.Connections, UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.RightBracket then
if EasyTravel.Enabled then
EasyTravel.Stop()
else
EasyTravel.Start()
end
end
end))
print(_d({43,21,49,67,73,240,36,66,49,70,53,60,45,240,35,68,49,62,52,49,60,63,62,53,240,29,63,52,53,10,240,32,66,53,67,67,240,247,45,247,240,68,63,240,68,63,55,55,60,53,240,54,60,57,55,56,68,254},48))
end
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({32,60,49,73,53,66,67},48))
local RunService = game:GetService(_d({34,69,62,35,53,66,70,57,51,53},48))
local UserInputService = game:GetService(_d({37,67,53,66,25,62,64,69,68,35,53,66,70,57,51,53},48))
local ReplicatedStorage = game:GetService(_d({34,53,64,60,57,51,49,68,53,52,35,68,63,66,49,55,53},48))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({57,52,60,53},48)
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
print(_d({43,31,70,53,66,71,63,66,60,52,36,53,67,68,53,66,45},48), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({35,68,49,68,67},48) .. LocalPlayer.Name)
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
debug(_d({22,57,66,53,52,240,23,53,64,64,63,240,34,53,61,63,68,53},48))
end)
if not ok then debug(_d({57,62,70,63,59,53,23,53,64,64,63,240,53,66,66,63,66,10},48), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48)) or Instance.new(_d({17,68,68,49,51,56,61,53,62,68},48))
att.Name = _d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48)
att.Parent = root
local force = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48))
if not force then
force = Instance.new(_d({28,57,62,53,49,66,38,53,60,63,51,57,68,73},48))
force.Name = _d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48)
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
local root = char:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48))
if not root then return end
local force = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,22,63,66,51,53},48))
local att   = root:FindFirstChild(_d({47,47,36,53,67,68,24,63,70,53,66,17,68,68},48))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({39,49,60,59,57,62,55,240,68,63,10},48), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({71,49,60,59,36,63,32,63,57,62,68,240,39,240,52,63,71,62,240,53,66,66,63,66,10},48), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({17,66,66,57,70,53,52,240,49,68,10},48), pos)
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
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({29,63,52,53,60},48)) and item:FindFirstChild(_d({24,69,61,49,62,63,57,52,34,63,63,68,32,49,66,68},48)) and item:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({24,69,61,49,62,63,57,52},48)).Health > 0 then
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
mode = _d({57,52,60,53},48)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({36,53,67,68,53,66,240,20,57,67,49,50,60,53,52},48))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({36,53,67,68,53,66,240,21,62,49,50,60,53,52,254,240,29,63,52,53,10},48), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({32,60,49,73,53,66,240,52,57,53,52,241,240,20,57,67,49,50,60,57,62,55,240,50,63,68,254},48))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({56,63,70,53,66},48) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({52,63,52,55,53},48) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) then
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
local playerGui = LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({31,70,53,66,71,63,66,60,52,36,53,67,68,23,69,57},48))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({35,51,66,53,53,62,23,69,57},48))
screenGui.Name = _d({31,70,53,66,71,63,66,60,52,36,53,67,68,23,69,57},48)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({22,66,49,61,53},48))
frame.Name = _d({29,49,57,62,22,66,49,61,53},48)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({37,25,19,63,66,62,53,66},48))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({192,111,107,113,191,136,95,240,19,69,64,57,52,240,21,62,55,57,62,53,240,31,70,53,66,71,63,66,60,52,240,36,53,67,68},48)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({35,68,49,68,69,67,10,240,25,52,60,53},48)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({36,53,72,68,18,63,72},48))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({24,63,70,53,66,240,17,50,63,70,53,240,36,49,66,55,53,68},48), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({56,63,70,53,66},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,24,63,70,53,66,57,62,55,240},48) .. val .. _d({240,67,68,69,52,67,240,69,64},48)
end)
createInputBtn(_d({20,63,52,55,53,240,19,60,57,61,50},48), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({52,63,52,55,53},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,20,63,52,55,53,253,56,63,60,52,57,62,55,240,248},48) .. val .. _d({240,67,68,69,52,67,249},48)
end)
createInputBtn(_d({36,53,67,68,240,35,65,69,49,66,53,240,20,63,52,55,53},48), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({67,65,69,49,66,53,47,52,63,52,55,53},48))
statusLabel.Text = _d({35,68,49,68,69,67,10,240,35,65,69,49,66,53,240,39,49,60,59,57,62,55,240,248},48) .. val .. _d({240,67,68,69,52,67,249},48)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
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
while enabled and mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({67,65,69,49,66,53,47,52,63,52,55,53},48) then
disableBot()
statusLabel.Text = _d({35,68,49,68,69,67,10,240,25,52,60,53,240,248,35,65,69,49,66,53,240,52,63,52,55,53,240,52,63,62,53,249},48)
end
end)
end)
local stopBtn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({21,29,21,34,23,21,30,19,41,240,35,36,31,32},48)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({37,25,19,63,66,62,53,66},48), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({35,68,49,68,69,67,10,240,35,36,31,32,32,21,20,240,248,25,52,60,53,249},48)
local VIM = game:GetService(_d({38,57,66,68,69,49,60,25,62,64,69,68,29,49,62,49,55,53,66},48))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({43,31,70,53,66,71,63,66,60,52,36,53,67,68,53,66,45,240,28,63,49,52,53,52,240,67,69,51,51,53,67,67,54,69,60,60,73,254},48))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({32,60,49,73,53,66,23,69,57},48), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({23,32,31,28,49,69,62,51,56,53,66,37,25},48))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({35,51,66,53,53,62,23,69,57},48))
screenGui.Name = _d({23,32,31,28,49,69,62,51,56,53,66,37,25},48)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({22,66,49,61,53},48))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({37,25,19,63,66,62,53,66},48))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({37,25,35,68,66,63,59,53},48))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({192,111,92,92,240,23,32,31,240,24,69,50,240,28,49,69,62,51,56,53,66},48)
title.Parent = main
local closeBtn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({37,25,19,63,66,62,53,66},48), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({19,56,63,63,67,53,240,49,240,50,63,68,240,63,66,240,69,68,57,60,57,68,73,240,68,63,240,66,69,62,10},48)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({36,53,72,68,18,69,68,68,63,62},48))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({240,240},48) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({37,25,19,63,66,62,53,66},48))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({37,25,35,68,66,63,59,53},48))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({36,53,72,68,28,49,50,53,60},48))
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
CreateLaunchButton(_d({19,69,64,57,52,240,20,69,62,55,53,63,62,240,22,49,66,61},48), _d({17,69,68,63,61,49,68,53,240,51,69,64,57,52,240,52,69,62,55,53,63,62,67,240,246,240,50,63,67,67,240,51,73,51,60,53,67},48), loadCupidDungeon)
CreateLaunchButton(_d({24,63,66,63,240,18,63,67,67,240,22,49,66,61,240,248,35,57,60,53,62,68,240,17,57,61,249},48), _d({17,69,68,63,54,49,66,61,240,63,70,53,66,71,63,66,60,52,240,50,63,67,67,53,67,240,69,67,57,62,55,240,24,63,66,63,240,54,66,69,57,68,67},48), loadHoroBossFarm)
CreateLaunchButton(_d({28,53,70,53,60,240,246,240,29,63,50,240,23,66,57,62,52,53,66},48), _d({17,69,68,63,253,60,53,70,53,60,240,49,62,52,240,54,49,66,61,240,60,63,51,49,60,240,30,32,19,240,61,63,50,67},48), loadLevelGrinder)
CreateLaunchButton(_d({21,49,67,73,240,36,66,49,70,53,60,240,248,32,240,36,63,55,55,60,53,249},48), _d({39,17,35,20,240,22,60,57,55,56,68,240,71,57,68,56,240,55,66,63,69,62,52,240,54,63,60,60,63,71,240,246,240,71,49,60,60,240,51,60,57,61,50,57,62,55},48), loadNavigationLab)
CreateLaunchButton(_d({32,56,73,67,57,51,67,240,31,70,53,66,71,63,66,60,52,240,36,53,67,68,53,66},48), _d({36,53,67,68,240,51,63,61,50,49,68,240,56,63,70,53,66,252,240,55,53,64,64,63,240,246,240,52,63,52,55,53,240,56,53,57,55,56,68,67},48), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({43,23,32,31,240,24,69,50,45,240,28,49,69,62,51,56,53,66,240,37,25,240,57,62,57,68,57,49,60,57,74,53,52,254},48))
end)()