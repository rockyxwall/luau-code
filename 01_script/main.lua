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
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)) then
Core = loadstring(readfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
else
Core = loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
end
end)
if not Core then warn(_d({72,48,92,95,82,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
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
local function Core.GetRoot(LocalPlayer)
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
local att = root:FindFirstChild(_d({76,76,53,92,99,82,95,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
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
local root = Core.GetRoot(LocalPlayer)
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
local root = Core.GetRoot(LocalPlayer)
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
local root = Core.GetRoot(LocalPlayer)
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
local currentRoot = Core.GetRoot(LocalPlayer)
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
local rootAfter = Core.GetRoot(LocalPlayer)
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
local CupidDungeon = {
Connections = {}
}
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({50,91,78,79,89,86,91,84,25,13,93,92,96,13,47,50,51,60,63,50,13,93,89,78,91,39},19), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({61,89,78,91,13,82,95,95,92,95,39},19), err2) end
end)
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
if not Safeguard.RequirePlace(11424731604, _d({48,98,93,86,81,13,49,98,91,84,82,92,91},19)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
Core.SetupStandalone(
CupidDungeon,
_d({48,98,93,86,81,13,49,98,91,84,82,92,91},19),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({55,98,103,92,13,97,85,82,13,49,86,78,90,92,91,81,79,78,80,88},19),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)) then
Core = loadstring(readfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
else
Core = loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
end
end)
if not Core then warn(_d({72,48,92,95,82,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)) or (bp and bp:FindFirstChild(_d({53,92,95,92,26,53,92,95,92},19)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum then hum:EquipTool(tool) end
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
if key == _d({53,86,97},19) then return target.CFrame
elseif key == _d({65,78,95,84,82,97},19) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({72,53,92,95,92,51,78,95,90,74,13,58,82,97,78,97,78,79,89,82,13,85,92,92,88,13,83,78,86,89,82,81,39,13},19) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({72,53,92,95,92,51,78,95,90,74,13,64,97,92,93,93,82,81,27},19))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({72,53,92,95,92,51,78,95,90,74,13,46,89,95,82,78,81,102,13,95,98,91,91,86,91,84,14},19)); return end
if not Safeguard then warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({72,53,92,95,92,51,78,95,90,74,13,64,97,78,95,97,82,81,13,97,78,95,84,82,97,86,91,84,39,13},19) .. HoroFarm.Config.SelectedBoss)
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
Core.SetupStandalone(
HoroFarm,
_d({53,92,95,92,51,78,95,90},19),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)) then
Core = loadstring(readfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
else
Core = loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
end
end)
if not Core then warn(_d({72,48,92,95,82,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,64,97,92,93,93,82,81,27},19))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,46,89,95,82,78,81,102,13,95,98,91,91,86,91,84,14},19)); return end
if not Safeguard then warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
if not Safeguard.RequirePlace(3978370137, _d({51,86,95,96,97,13,64,82,78},19)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19), 10)
local hum = char:WaitForChild(_d({53,98,90,78,91,92,86,81},19), 10)
local stats = ReplicatedStorage:WaitForChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({61,82,89,86},19), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({63,86,83,89,82},19)) or (char and char:FindFirstChild(_d({63,86,83,89,82},19)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,48,98,95,95,82,91,97,13,61,82,89,86,13,80,85,82,80,88,39},19), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,59,92,97,13,78,97,13,65,92,100,91,13,92,83,13,47,82,84,86,91,91,86,91,84,96,27,13,61,89,82,78,96,82,13,97,95,78,99,82,89,13,97,85,82,95,82,13,97,92,13,83,78,95,90,13,80,85,82,96,97,96,13,100,85,86,89,82,13,100,78,86,97,86,91,84,13,83,92,95,13,63,86,83,89,82,27},19))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,80,85,82,96,97,76,83,78,95,90,82,95,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,80,85,82,96,97,76,83,78,95,90,82,95,27,89,98,78},19))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,51,78,95,90,86,91,84,13,80,85,82,96,97,96,13,98,91,97,86,89,13,32,29,29,13,61,82,89,86,27,27,27,13,21,48,98,95,95,82,91,97,39,13},19) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({61,82,89,86},19))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({63,86,83,89,82},19)) or (c and c:FindFirstChild(_d({63,86,83,89,82},19))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({47,98,102,78,79,89,82,54,97,82,90,96},19))
local shopItem = buyables and buyables:FindFirstChild(_d({63,86,83,89,82},19))
local shopPart = shopItem and shopItem:FindFirstChild(_d({64,85,92,93,61,78,95,97},19))
if EasyTravel and shopPart and hrp then
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,65,95,78,99,82,89,86,91,84,13,97,92,13,63,86,83,89,82,13,96,85,92,93,13,99,86,78,13,50,78,96,102,65,95,78,99,82,89,27,27,27},19))
local nocollide = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({47,78,96,82,61,78,95,97},19)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({50,99,82,91,97,96},19)) and ReplicatedStorage.Events:FindFirstChild(_d({64,85,92,93},19))
if shopEvent and shopEvent:IsA(_d({63,82,90,92,97,82,51,98,91,80,97,86,92,91},19)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,50,94,98,86,93,93,86,91,84,13,63,86,83,89,82,27,27,27},19))
local args = {
[1] = _d({82,94,98,86,93},19),
[2] = _d({63,86,83,89,82},19)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({50,99,82,91,97,96},19)) and ReplicatedStorage.Events:FindFirstChild(_d({65,92,92,89,96},19))
if toolsEvent and toolsEvent:IsA(_d({63,82,90,92,97,82,51,98,91,80,97,86,92,91},19)) then
pcall(function()
toolsEvent:InvokeServer(unpack(args))
end)
end
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81},19))
local hrp = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({63,86,83,89,82},19))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,51,89,102,86,91,84,13,97,92,13,51,86,96,85,90,78,91,13,48,78,99,82,27,27,27},19))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,82,78,96,102,76,97,95,78,99,82,89,27,89,98,78},19))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,50,96,80,78,93,86,91,84,13,96,85,92,93,13,86,91,97,82,95,86,92,95,13,79,102,13,83,89,102,86,91,84,13,96,97,95,78,86,84,85,97,13,98,93,27,27,27},19))
local nocollide = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({47,78,96,82,61,78,95,97},19)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, 60, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= 58 then break end
task.wait(0.5)
end
nocollide:Disconnect()
local runService = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700 and distPos.X <= 1973 and distPos.Z >= -12403 and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,51,89,102,86,91,84,13,97,92,13,51,86,96,85,90,78,91,13,48,78,99,82,27,27,27},19))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,83,86,96,85,90,78,91,76,90,78,103,82,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,83,86,96,85,90,78,91,76,90,78,103,82,27,89,98,78},19))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp)
end)
else
warn(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,51,78,86,89,82,81,13,97,92,13,86,90,93,92,95,97,13,51,86,96,85,90,78,91,58,78,103,82,13,89,86,79,95,78,95,102,14},19))
end
else
warn(_d({72,57,82,99,82,89,13,52,95,86,91,81,82,95,74,13,60,98,97,96,86,81,82,13,51,86,96,85,90,78,91,13,48,78,99,82,13,79,92,98,91,81,96,25,13,96,88,86,93,93,86,91,84,13,90,78,103,82,27},19))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({57,82,99,82,89,13,52,95,86,91,81,82,95},19),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local RunService       = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)) then
Core = loadstring(readfile(_d({29,30,26,84,93,92,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
else
Core = loadstring(game:HttpGet(_d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,80,92,95,82,27,89,98,78},19)))()
end
end)
if not Core then warn(_d({72,48,92,95,82,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
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
return char, char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)), char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19)
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
local force = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,51,92,95,80,82},19))
local att = root:FindFirstChild(_d({76,76,50,78,96,102,65,95,78,99,82,89,46,97,97},19))
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
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01 and currentPos.X <= 3049.91 and currentPos.Z >= -11748.53 and currentPos.Z <= -9700.63
local moveDir = Vector3.zero
if EasyTravel.DisableRaycasting then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
task.wait(RAYCAST_COOLDOWN)
continue
end
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
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({51,86,96,85,90,78,91,13,48,78,99,82},19))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = {cave}
local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
if hit then
hitCave = true
end
end
EasyTravel.HitCave = hitCave
if hitCave or inRoughWaters then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
continue
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
if not Safeguard then warn(_d({72,64,78,83,82,84,98,78,95,81,74,13,51,78,86,89,82,81,13,97,92,13,89,92,78,81,14},19)); return end
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
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({72,50,78,96,102,13,65,95,78,99,82,89,74,13,51,89,86,84,85,97,13,82,91,78,79,89,82,81,27},19))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({72,50,78,96,102,13,65,95,78,99,82,89,74,13,51,89,86,84,85,97,13,81,86,96,78,79,89,82,81,27},19))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({50,78,96,102,13,65,95,78,99,82,89},19),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)();
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
print(_d({72,60,99,82,95,100,92,95,89,81,65,82,96,97,82,95,74},19), ...)
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
debug(_d({51,86,95,82,81,13,52,82,93,93,92,13,63,82,90,92,97,82},19))
end)
if not ok then debug(_d({86,91,99,92,88,82,52,82,93,93,92,13,82,95,95,92,95,39},19), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19)
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
local force = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,51,92,95,80,82},19))
local att   = root:FindFirstChild(_d({76,76,65,82,96,97,53,92,99,82,95,46,97,97},19))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
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
local currentRoot = Core.GetRoot(LocalPlayer)
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
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({58,92,81,82,89},19)) and item:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19)) and item:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19)) then
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
debug(_d({65,82,96,97,82,95,13,49,86,96,78,79,89,82,81},19))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({65,82,96,97,82,95,13,50,91,78,79,89,82,81,27,13,58,92,81,82,39},19), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({61,89,78,102,82,95,13,81,86,82,81,14,13,49,86,96,78,79,89,86,91,84,13,79,92,97,27},19))
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
elseif mode == _d({81,92,81,84,82},19) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) then
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
local existingGui = playerGui:FindFirstChild(_d({60,99,82,95,100,92,95,89,81,65,82,96,97,52,98,86},19))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({64,80,95,82,82,91,52,98,86},19))
screenGui.Name = _d({60,99,82,95,100,92,95,89,81,65,82,96,97,52,98,86},19)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({51,95,78,90,82},19))
frame.Name = _d({58,78,86,91,51,95,78,90,82},19)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({66,54,48,92,95,91,82,95},19))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({221,140,136,142,220,165,124,13,48,98,93,86,81,13,50,91,84,86,91,82,13,60,99,82,95,100,92,95,89,81,13,65,82,96,97},19)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({64,97,78,97,98,96,39,13,54,81,89,82},19)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({65,82,101,97,47,92,101},19))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({53,92,99,82,95,13,46,79,92,99,82,13,65,78,95,84,82,97},19), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({85,92,99,82,95},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,53,92,99,82,95,86,91,84,13},19) .. val .. _d({13,96,97,98,81,96,13,98,93},19)
end)
createInputBtn(_d({49,92,81,84,82,13,48,89,86,90,79},19), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({81,92,81,84,82},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,49,92,81,84,82,26,85,92,89,81,86,91,84,13,21},19) .. val .. _d({13,96,97,98,81,96,22},19)
end)
createInputBtn(_d({65,82,96,97,13,64,94,98,78,95,82,13,49,92,81,84,82},19), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({96,94,98,78,95,82,76,81,92,81,84,82},19))
statusLabel.Text = _d({64,97,78,97,98,96,39,13,64,94,98,78,95,82,13,68,78,89,88,86,91,84,13,21},19) .. val .. _d({13,96,97,98,81,96,22},19)
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
while enabled and mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({96,94,98,78,95,82,76,81,92,81,84,82},19) then
disableBot()
statusLabel.Text = _d({64,97,78,97,98,96,39,13,54,81,89,82,13,21,64,94,98,78,95,82,13,81,92,81,84,82,13,81,92,91,82,22},19)
end
end)
end)
local stopBtn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({50,58,50,63,52,50,59,48,70,13,64,65,60,61},19)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({66,54,48,92,95,91,82,95},19), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({64,97,78,97,98,96,39,13,64,65,60,61,61,50,49,13,21,54,81,89,82,22},19)
local VIM = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({72,60,99,82,95,100,92,95,89,81,65,82,96,97,82,95,74,13,57,92,78,81,82,81,13,96,98,80,80,82,96,96,83,98,89,89,102,27},19))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({52,61,60,57,78,98,91,80,85,82,95,66,54},19))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({64,80,95,82,82,91,52,98,86},19))
screenGui.Name = _d({52,61,60,57,78,98,91,80,85,82,95,66,54},19)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({51,95,78,90,82},19))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({66,54,48,92,95,91,82,95},19))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({66,54,64,97,95,92,88,82},19))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({221,140,121,121,13,52,61,60,13,53,98,79,13,57,78,98,91,80,85,82,95},19)
title.Parent = main
local closeBtn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({66,54,48,92,95,91,82,95},19), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({48,85,92,92,96,82,13,78,13,79,92,97,13,92,95,13,98,97,86,89,86,97,102,13,97,92,13,95,98,91,39},19)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({65,82,101,97,47,98,97,97,92,91},19))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({13,13},19) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({66,54,48,92,95,91,82,95},19))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({66,54,64,97,95,92,88,82},19))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({65,82,101,97,57,78,79,82,89},19))
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
CreateLaunchButton(_d({48,98,93,86,81,13,49,98,91,84,82,92,91,13,51,78,95,90},19), _d({46,98,97,92,90,78,97,82,13,80,98,93,86,81,13,81,98,91,84,82,92,91,96,13,19,13,79,92,96,96,13,80,102,80,89,82,96},19), loadCupidDungeon)
CreateLaunchButton(_d({53,92,95,92,13,47,92,96,96,13,51,78,95,90,13,21,64,86,89,82,91,97,13,46,86,90,22},19), _d({46,98,97,92,83,78,95,90,13,92,99,82,95,100,92,95,89,81,13,79,92,96,96,82,96,13,98,96,86,91,84,13,53,92,95,92,13,83,95,98,86,97,96},19), loadHoroBossFarm)
CreateLaunchButton(_d({57,82,99,82,89,13,19,13,58,92,79,13,52,95,86,91,81,82,95},19), _d({46,98,97,92,26,89,82,99,82,89,13,78,91,81,13,83,78,95,90,13,89,92,80,78,89,13,59,61,48,13,90,92,79,96},19), loadLevelGrinder)
CreateLaunchButton(_d({50,78,96,102,13,65,95,78,99,82,89,13,21,61,13,65,92,84,84,89,82,22},19), _d({68,46,64,49,13,51,89,86,84,85,97,13,100,86,97,85,13,84,95,92,98,91,81,13,83,92,89,89,92,100,13,19,13,100,78,89,89,13,80,89,86,90,79,86,91,84},19), loadNavigationLab)
CreateLaunchButton(_d({61,85,102,96,86,80,96,13,60,99,82,95,100,92,95,89,81,13,65,82,96,97,82,95},19), _d({65,82,96,97,13,80,92,90,79,78,97,13,85,92,99,82,95,25,13,84,82,93,93,92,13,19,13,81,92,81,84,82,13,85,82,86,84,85,97,96},19), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({72,52,61,60,13,53,98,79,74,13,57,78,98,91,80,85,82,95,13,66,54,13,86,91,86,97,86,78,89,86,103,82,81,27},19))
end)()