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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({48,76,65,89,69,82,83},32))
local UserInputService    = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local RunService          = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM                 = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local ReplicatedStorage    = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,20,20,17,20,17,19,18,23},32)
local LEO_ENTEI_ANIM_ID    = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,20,20,17,19,24,18,23,24},32)
local LEO_HIKEN_ANIM_ID    = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,18,16,25,17,23,20,16,23},32)
local LEO_FIREFLY_ANIM_ID  = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,21,18,18,16,18,19,22,17,21,20},32)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({47,66,74,69,67,84,73,86,69,83},32)
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
local REPLAY_BUTTON_VALUE   = _d({50,69,80,76,65,89},32)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({77,79,86,69},32)
local NavState   = {mode = _d({73,68,76,69},32)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({59,34,79,83,83,34,79,84,61},32), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end)
if ok then return root end
debug(_d({71,69,84,50,79,79,84,0,69,82,82,79,82,26},32), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end)
if ok then return hum end
debug(_d({71,69,84,40,85,77,65,78,79,73,68,0,69,82,82,79,82,26},32), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({63,63,40,79,86,69,82,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,40,79,86,69,82,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,40,79,86,69,82,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,40,79,86,69,82,38,79,82,67,69},32)
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
debug(_d({71,69,84,47,82,35,82,69,65,84,69,38,79,82,67,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local force = root:FindFirstChild(_d({63,63,40,79,86,69,82,38,79,82,67,69},32))
local att   = root:FindFirstChild(_d({63,63,40,79,86,69,82,33,84,84},32))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({67,76,69,65,78,85,80,38,79,82,67,69,0,69,82,82,79,82,26},32), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({34,85,83,79,45,69,76,69,69},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,34,85,83,79,33,67,84,73,86,69,0,69,82,82,79,82,26},32), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({34,85,83,79},32))
end)
if not ok then debug(_d({65,67,84,73,86,65,84,69,34,85,83,79,0,69,82,82,79,82,26},32), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({34,85,83,79,0,78,79,84,0,65,67,84,73,86,69,12,0,65,67,84,73,86,65,84,73,78,71},32))
activateBuso()
end
end)
if not ok then debug(_d({34,85,83,79,43,69,69,80,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({34,85,83,79,0,75,69,69,80,69,82,0,83,84,79,80,80,69,68},32))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({43,69,78,40,65,75,73},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,43,69,78,33,67,84,73,86,69,0,69,82,82,79,82,26},32), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({43,69,78},32), true)
end)
if not ok then debug(_d({65,67,84,73,86,65,84,69,43,69,78,0,69,82,82,79,82,26},32), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({43,69,78,0,78,79,84,0,65,67,84,73,86,69,12,0,65,67,84,73,86,65,84,73,78,71},32))
activateKen()
end
end)
if not ok then debug(_d({43,69,78,43,69,69,80,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({43,69,78,0,75,69,69,80,69,82,0,83,84,79,80,80,69,68},32))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({46,48,35,83},32)) end)
if ok then return folder end
debug(_d({71,69,84,46,48,35,83,38,79,76,68,69,82,0,69,82,82,79,82,26},32), folder)
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
local r = model:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local h = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
debug(_d({71,69,84,46,69,65,82,69,83,84,46,48,35,0,69,82,82,79,82,26},32), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum  = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({71,69,84,46,48,35,34,89,46,65,77,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({78,80,67,83,50,69,77,65,73,78,73,78,71,0,69,82,82,79,82,26},32), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({35,85,80,73,68,0,49,85,69,69,78},32))
return queen ~= nil and queen:FindFirstChild(_d({77,79,84,73,79,78,44,69,83,83},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,49,85,69,69,78,48,72,65,83,69,18,0,69,82,82,79,82,26},32), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,17,18,17,18,25,23,25,20,18,18,25,18,23,22,25},32)
local QUEEN_GRASP_ANIM_ID   = _d({82,66,88,65,83,83,69,84,73,68,26,15,15,17,18,25,24,16,16,16,22,17,16,16,17,23,19,20},32)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
debug(_d({73,83,48,76,65,89,73,78,71,33,78,73,77,38,82,79,77,44,73,83,84,0,69,82,82,79,82,26},32), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({34,76,79,67,75,73,78,71},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,46,48,35,34,76,79,67,75,73,78,71,0,69,82,82,79,82,26},32), result)
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
debug(_d({80,82,69,68,73,67,84,46,48,35,48,79,83,73,84,73,79,78,0,69,82,82,79,82,26},32), result)
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
debug(_d({46,79,0,68,65,77,65,71,69,0,79,78},32), model.Name, _d({70,79,82},32), NPC_STUCK_TIMEOUT, _d({83,0,13,0,83,87,73,84,67,72,73,78,71,0,84,65,82,71,69,84},32))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({84,82,65,67,75,46,48,35,36,65,77,65,71,69,0,69,82,82,79,82,26},32), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({45,79,68,69,76},32)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({34,65,83,69,48,65,82,84},32)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({71,69,84,45,79,68,69,76,38,65,67,69,48,79,83,0,69,82,82,79,82,26},32), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({37,78,86},32))
local folder = env and env:FindFirstChild(_d({51,84,65,84,85,69,83},32))
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
debug(_d({71,69,84,51,84,65,84,85,69,45,79,68,69,76,46,69,65,82,0,69,82,82,79,82,26},32), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({66,65,82,82,69,76,40,48},32))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({71,69,84,51,84,65,84,85,69,40,48,0,69,82,82,79,82,26},32), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,33,84,84,82,73,66,85,84,69,0,69,82,82,79,82,26},32), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({52,79,79,76},32)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,46,65,77,69,0,69,82,82,79,82,26},32), tool)
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
if not ok then debug(_d({69,81,85,73,80,52,79,79,76,0,69,82,82,79,82,26},32), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({52,79,79,76},32)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({70,73,78,68,52,79,79,76,34,89,35,72,73,76,68,46,65,77,69,0,69,82,82,79,82,26},32), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({51,87,79,82,68,37,81,85,73,80},32))
if sword then
equipTool(sword)
return _d({83,87,79,82,68},32)
end
local melee = findToolByAttribute(_d({45,69,76,69,69,52,79,79,76},32))
if melee then
equipTool(melee)
return _d({77,69,76,69,69},32)
end
debug(_d({46,79,0,83,87,79,82,68,0,79,82,0,77,69,76,69,69,0,84,79,79,76,0,70,79,85,78,68},32))
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
if not ok then debug(_d({67,76,73,67,75,45,17,0,69,82,82,79,82,26},32), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
end)
if not ok then debug(_d({73,78,86,79,75,69,39,69,80,80,79,0,69,82,82,79,82,26},32), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({80,82,69,83,83,51,75,73,76,76,50,0,69,82,82,79,82,26},32), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({72,79,76,68,34,76,79,67,75,0,69,82,82,79,82,26},32), err) end
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
if not ok then debug(_d({72,79,76,68,34,76,79,67,75,55,72,73,76,69,0,69,82,82,79,82,26},32), err) end
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
debug(_d({71,69,84,39,65,77,69,39,0,69,82,82,79,82,26},32), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({73,83,50,69,65,76,45,17,34,85,83,89,0,69,82,82,79,82,26},32), result)
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
return char ~= nil and char:FindFirstChild(_d({83,84,85,78},32)) ~= nil
end)
if ok then return result end
debug(_d({73,83,51,84,85,78,78,69,68,0,69,82,82,79,82,26},32), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({80,82,69,83,83,51,84,85,78,34,82,69,65,75,0,69,82,82,79,82,26},32), err) end
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
debug(_d({81,85,69,69,78,36,79,68,71,69,53,78,84,73,76,51,65,70,69,26,0,49,85,69,69,78,0,71,79,78,69,0,13,0,69,78,68,73,78,71,0,68,79,68,71,69,0,69,65,82,76,89},32))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({81,85,69,69,78,36,79,68,71,69,53,78,84,73,76,51,65,70,69,0,83,65,70,69,84,89,0,84,73,77,69,79,85,84},32))
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
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({49,85,69,69,78,0,67,65,83,84,73,78,71,0,68,69,84,69,67,84,69,68,0,13,0,68,79,68,71,73,78,71,0,8,87,65,84,67,72,69,82,9},32))
queenDodgeUntilSafe(function() return getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) end)
if enabled and getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) then
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
end
queenDodging = false
end
end)
if not ok then debug(_d({81,85,69,69,78,36,79,68,71,69,55,65,84,67,72,69,82,0,69,82,82,79,82,26},32), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({80,79,73,78,84},32) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({78,80,67},32) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({78,65,77,69,68},32) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({71,69,84,46,65,86,52,65,82,71,69,84,83,0,69,82,82,79,82,26},32), aimR)
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
debug(_d({67,79,77,80,85,84,69,44,79,67,75,69,68,35,38,82,65,77,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({80,79,73,78,84},32), point = pos}
phase = _d({77,79,86,69},32)
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
if not ok then debug(_d({78,65,86,52,79,48,79,73,78,84,0,71,69,80,80,79,0,67,72,69,67,75,0,69,82,82,79,82,26},32), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({78,80,67},32)}
phase = _d({77,79,86,69},32)
end
function setNavNamed(name)
NavState = {mode = _d({78,65,77,69,68},32), name = name}
phase = _d({77,79,86,69},32)
end
local function setNavIdle()
NavState = {mode = _d({73,68,76,69},32)}
phase = _d({77,79,86,69},32)
end
local function hasArrived()
return phase == _d({72,79,86,69,82},32)
end
local function startNav()
phase = _d({77,79,86,69},32)
debug(_d({46,65,86,0,76,79,79,80,0,47,46},32))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({48,76,65,89,69,82,0,68,73,69,68,1,0,51,84,79,80,80,73,78,71,0,66,79,84,14},32))
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
debug(_d({48,76,65,89,69,82,0,73,83,0,84,79,79,0,70,65,82,0,70,82,79,77,0,84,65,82,71,69,84,0,8,30,18,16,16,16,0,83,84,85,68,83,9,14,0,44,73,75,69,76,89,0,82,69,83,80,65,87,78,69,68,0,65,84,0,76,79,66,66,89,14,0,51,84,79,80,80,73,78,71,0,66,79,84,14},32))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({63,63,80,82,69,86,48,79,83},32))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({44,65,82,71,69,0,80,79,83,73,84,73,79,78,0,74,85,77,80,0,68,69,84,69,67,84,69,68,26},32), delta, _d({83,84,85,68,83,14,0,80,82,69,86,48,79,83,29},32), prevPos, _d({78,69,87,48,79,83,29},32), pos)
end
end
force:SetAttribute(_d({63,63,80,82,69,86,48,79,83},32), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({77,79,86,69},32) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({72,79,86,69,82},32)
debug(_d({48,72,65,83,69,26,0,72,79,86,69,82},32))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({1,1,1,0,50,37,38,53,51,41,46,39,0,52,47,0,33,48,48,44,57,0,33,34,46,47,50,45,33,44,0,54,37,44,47,35,41,52,57,26},32), finalVel, _d({65,73,77,29},32), aim, _d({80,79,83,29},32), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({72,79,86,69,82},32) then
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
debug(_d({35,79,77,66,65,84,0,76,79,67,75,0,83,75,73,80,80,69,68,12},32), snapDist, _d({83,84,85,68,83,0,70,82,79,77,0,84,65,82,71,69,84,0,194,96,116,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,77,79,86,69},32))
phase = _d({77,79,86,69},32)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({40,69,65,82,84,66,69,65,84,0,69,82,82,79,82,26},32), err) end
end)
end
local function stopNav()
debug(_d({46,65,86,0,76,79,79,80,0,47,38,38},32))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({77,79,86,69},32)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({52,69,88,84,35,72,65,84,51,69,82,86,73,67,69},32))
local channels = TextChatService:FindFirstChild(_d({52,69,88,84,35,72,65,78,78,69,76,83},32))
local channel = channels and channels:FindFirstChild(_d({50,34,56,39,69,78,69,82,65,76},32))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({36,69,70,65,85,76,84,35,72,65,84,51,89,83,84,69,77,35,72,65,84,37,86,69,78,84,83},32))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({51,65,89,45,69,83,83,65,71,69,50,69,81,85,69,83,84},32))
if sayEvent then
sayEvent:FireServer(message, _d({33,76,76},32))
return
end
debug(_d({83,69,78,68,35,72,65,84,45,69,83,83,65,71,69,26,0,78,79,0,52,69,88,84,35,72,65,84,51,69,82,86,73,67,69,14,50,34,56,39,69,78,69,82,65,76,0,79,82,0,76,69,71,65,67,89,0,51,65,89,45,69,83,83,65,71,69,50,69,81,85,69,83,84,0,70,79,85,78,68,0,70,79,82},32), message)
end)
if not ok then debug(_d({83,69,78,68,35,72,65,84,45,69,83,83,65,71,69,0,69,82,82,79,82,26},32), err) end
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
debug(_d({46,79,84,0,77,65,75,73,78,71,0,80,82,79,71,82,69,83,83,0,84,79,87,65,82,68,0,78,65,86,0,84,65,82,71,69,84,0,70,79,82},32), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({83,0,13,0,83,69,78,68,73,78,71,0,15,85,78,83,84,85,67,75},32))
sendChatMessage(_d({15,85,78,83,84,85,67,75},32))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({87,65,73,84,53,78,84,73,76,33,82,82,73,86,69,68,0,84,73,77,69,79,85,84},32))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({78,65,86,52,79,48,79,73,78,84,35,79,78,70,73,82,77,69,68,26},32), label or _d({84,65,82,71,69,84},32), _d({13,0,68,73,68,0,78,79,84,0,65,82,82,73,86,69,0,87,73,84,72,73,78},32), timeout, _d({83,12,0,82,69,84,82,89,73,78,71,0,79,78,67,69},32))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({78,65,86,52,79,48,79,73,78,84,35,79,78,70,73,82,77,69,68,26},32), label or _d({84,65,82,71,69,84},32), _d({13,0,83,84,73,76,76,0,78,79,84,0,65,82,82,73,86,69,68,0,65,70,84,69,82,0,82,69,84,82,89,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
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
if not ok then debug(_d({78,65,86,52,79,48,79,73,78,84,40,79,76,68,73,78,71,34,76,79,67,75,0,75,69,89,13,68,79,87,78,0,69,82,82,79,82,26},32), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({78,65,86,52,79,48,79,73,78,84,40,79,76,68,73,78,71,34,76,79,67,75,0,75,69,89,13,85,80,0,69,82,82,79,82,26},32), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({55,65,76,75,73,78,71,0,84,79,26},32), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({87,65,76,75,52,79,48,79,73,78,84,0,55,0,68,79,87,78,0,69,82,82,79,82,26},32), err) end
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
debug(_d({52,79,79,75,0,68,65,77,65,71,69,0,87,72,73,76,69,0,87,65,76,75,73,78,71,0,84,79,0,80,79,73,78,84,1,0,51,84,79,80,80,73,78,71,0,87,65,76,75,0,84,79,0,69,78,71,65,71,69,14},32))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({33,82,82,73,86,69,68,0,65,84,26},32), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({51,84,85,67,75,0,68,85,82,73,78,71,0,87,65,76,75,12,0,74,85,77,80,73,78,71,1},32))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({51,84,73,76,76,0,83,84,85,67,75,12,0,84,82,73,71,71,69,82,73,78,71,0,39,69,80,80,79,1},32))
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
debug(_d({45,79,86,73,78,71,0,84,79},32), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,46,48,35,83,0,84,79,0,83,80,65,87,78,0,65,84},32), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({0,0,83,80,65,87,78,0,67,72,69,67,75,26,0,70,79,76,68,69,82,0,69,88,73,83,84,83,0,29},32), folder ~= nil,
_d({12,0,67,72,73,76,68,82,69,78,0,29},32), folder and #folder:GetChildren() or 0,
_d({12,0,65,76,73,86,69,0,29},32), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({46,79,0,46,48,35,83,0,65,80,80,69,65,82,69,68,0,65,84},32), stageName, _d({65,70,84,69,82,0,17,21,83,12,0,77,79,86,73,78,71,0,79,78,0,65,78,89,87,65,89},32))
break
end
end
debug(_d({43,73,76,76,73,78,71,0,46,48,35,83,0,65,84},32), stageName)
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
debug(_d({50,69,84,85,82,78,73,78,71,0,84,79},32), stageName, _d({80,79,83,73,84,73,79,78,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,79,78},32))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84},32), stageName, _d({80,79,83,73,84,73,79,78},32))
task.wait(5)
debug(_d({55,65,73,84,73,78,71,0,70,79,82},32), targetHP * 100, _d({5,0,40,48,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,84,79,0,78,69,88,84,0,83,84,65,71,69},32))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({67,76,69,65,82,69,68},32))
end
local function killNamedNPC(name, targetPos)
debug(_d({45,79,86,73,78,71,0,84,79},32), name)
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
debug(name, _d({68,69,70,69,65,84,69,68},32))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({44,69,79,0,80,76,65,89,69,68,0,65,78,73,77,65,84,73,79,78,26},32), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({76,69,79,33,78,73,77,44,79,71,71,69,82,0,80,82,73,78,84,0,69,82,82,79,82,26},32), err2) end
end)
end)
if not ok then debug(_d({83,84,65,82,84,44,69,79,33,78,73,77,44,79,71,71,69,82,0,69,82,82,79,82,26},32), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({45,79,86,73,78,71,0,84,79,0,44,69,79},32))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({44,69,79},32))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({44,69,79},32))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({44,69,79},32))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({44,69,79,0,67,65,83,84,73,78,71},32), which, _d({13,0,68,79,68,71,73,78,71},32))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({44,69,79,0,83,84,65,82,84,69,68,0,66,76,79,67,75,13,66,82,69,65,75,69,82,0,77,73,68,13,66,76,79,67,75,1,0,37,86,65,68,73,78,71,14,14,14},32))
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
if not getNPCByName(_d({44,69,79},32)) then
debug(_d({44,69,79,0,71,79,78,69,0,77,73,68,13,68,79,68,71,69,0,13,0,69,78,68,73,78,71,0,37,78,84,69,73,0,72,79,76,68,0,69,65,82,76,89},32))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({44,69,79},32)) then
setNavNamed(_d({44,69,79},32))
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
debug(_d({44,69,79,0,68,69,70,69,65,84,69,68},32))
stopLeoAnimLogger()
debug(_d({50,69,84,85,82,78,73,78,71,0,84,79,0,44,69,79,0,80,79,83,73,84,73,79,78,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,79,78},32))
navToPointConfirmed(COORDS.Leo, 30, _d({44,69,79,0,80,79,83,73,84,73,79,78},32))
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84,0,44,69,79,0,80,79,83,73,84,73,79,78},32))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({45,79,86,73,78,71,0,84,79},32), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({35,79,85,76,68,0,78,79,84,0,70,73,78,68,0,83,84,65,84,85,69,0,77,79,68,69,76,0,78,69,65,82},32), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({33,84,84,65,67,75,73,78,71},32), coordKey, _d({87,73,84,72},32), weapon or _d({78,79,84,72,73,78,71,0,70,79,85,78,68},32))
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
debug(coordKey, _d({66,65,82,82,69,76,0,68,69,83,84,82,79,89,69,68},32))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({13,0,67,79,85,76,68,0,78,79,84,0,70,73,78,68,0,83,84,65,84,85,69,0,77,79,68,69,76,12,0,83,75,73,80,80,73,78,71},32))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({83,84,73,76,76,0,65,76,73,86,69,0,8,40,48},32), hp, _d({9,0,13,0,82,69,13,68,69,83,84,82,79,89,73,78,71},32))
destroyStatue(coordKey)
else
debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,26},32), coordKey, _d({67,79,78,70,73,82,77,69,68,0,68,69,83,84,82,79,89,69,68},32))
end
end)
if not ok then debug(_d({82,69,67,72,69,67,75,51,84,65,84,85,69,0,69,82,82,79,82,26},32), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({45,79,86,73,78,71,0,84,79,0,49,85,69,69,78},32))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
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
debug(_d({49,85,69,69,78,0,69,78,84,69,82,69,68,0,80,72,65,83,69,0,18},32))
end
local function finishQueen()
debug(_d({38,73,78,73,83,72,73,78,71,0,49,85,69,69,78},32))
equipSwordOrMelee()
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
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
debug(_d({49,85,69,69,78,0,68,69,70,69,65,84,69,68,14,0,48,76,65,78,0,67,79,77,80,76,69,84,69,14},32))
end
local CONFIRMATION_PROMPT_NAME = _d({35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84},32)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({50,69,77,79,84,69,37,86,69,78,84},32), 5)
end)
if ok then return result end
debug(_d({71,69,84,50,69,80,76,65,89,50,69,77,79,84,69,0,69,82,82,79,82,26},32), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({48,76,65,89,69,82,39,85,73},32))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({41,77,65,71,69,34,85,84,84,79,78},32)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({66,85,84,84,79,78,54,65,76,85,69},32)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({70,73,78,68,34,85,84,84,79,78,34,89,54,65,76,85,69,0,69,82,82,79,82,26},32), result)
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
if not ok then debug(_d({67,76,73,67,75,39,85,73,34,85,84,84,79,78,0,69,82,82,79,82,26},32), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({73,83,51,69,82,86,69,82},32))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({50,69,77,79,84,69,37,86,69,78,84},32))
or inst:FindFirstChild(_d({67,76,73,69,78,84,37,86,69,78,84},32))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({70,73,78,68,33,78,83,87,69,82,35,79,78,78,69,67,84,79,82,0,69,82,82,79,82,26},32), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({35,79,85,76,68,0,78,79,84,0,76,79,67,65,84,69,0,50,69,77,79,84,69,37,86,69,78,84,15,67,76,73,69,78,84,37,86,69,78,84,0,78,69,65,82,0,50,69,80,76,65,89,0,66,85,84,84,79,78,12,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,67,76,73,67,75},32))
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
debug(_d({70,73,82,69,50,69,80,76,65,89,54,65,76,85,69,0,69,82,82,79,82,26},32), err, _d({13,0,70,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,67,76,73,67,75},32))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({38,65,76,76,73,78,71,0,66,65,67,75,0,84,79,0,66,85,84,84,79,78,54,65,76,85,69,0,83,69,65,82,67,72,0,70,79,82,0,50,69,80,76,65,89},32))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({50,69,80,76,65,89,0,66,85,84,84,79,78,0,78,79,84,0,70,79,85,78,68,0,69,73,84,72,69,82,12,0,71,73,86,73,78,71,0,85,80},32))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,14,50,69,77,79,84,69,37,86,69,78,84},32))
local remote = getReplayRemote()
if not remote then
debug(_d({35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,15,50,69,77,79,84,69,37,86,69,78,84,0,78,79,84,0,70,79,85,78,68,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84},32))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({38,73,82,73,78,71,0,50,69,80,76,65,89,0,86,73,65,0,35,79,78,70,73,82,77,65,84,73,79,78,48,82,79,77,80,84,14,50,69,77,79,84,69,37,86,69,78,84},32))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({38,73,82,69,51,69,82,86,69,82,0,69,82,82,79,82,26},32), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
if not playerGui then
debug(_d({87,65,73,84,38,79,82,47,66,74,69,67,84,73,86,69,83,39,85,73,26,0,78,79,0,48,76,65,89,69,82,39,85,73,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({47,66,74,69,67,84,73,86,69,83,0,39,53,41,0,70,79,85,78,68,0,13,0,83,84,65,71,69,0,76,79,65,68,69,68},32))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({47,66,74,69,67,84,73,86,69,83,0,39,53,41,0,78,79,84,0,70,79,85,78,68,0,87,73,84,72,73,78,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
return
end
end
end)
if not ok then debug(_d({87,65,73,84,38,79,82,47,66,74,69,67,84,73,86,69,83,39,85,73,0,69,82,82,79,82,26},32), err) end
end
local function runPlan()
debug(_d({48,76,65,78,0,83,84,65,82,84,69,68},32))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({51,84,65,82,84,73,78,71,0,78,65,86,0,76,79,79,80},32))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({80,79,83,0,16,14,18,83,0,33,38,52,37,50,0,83,84,65,82,84,46,65,86,26},32), rootAfter and rootAfter.Position)
end)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,84,79,0,51,84,65,71,69,17},32))
task.wait(5)
for _, stage in ipairs({_d({51,84,65,71,69,17},32), _d({51,84,65,71,69,18},32), _d({51,84,65,71,69,19},32), _d({51,84,65,71,69,19,34},32)}) do
if not enabled then return end
local hpTarget = (stage == _d({51,84,65,71,69,19,34},32)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,84,79,0,65,82,82,79,87,0,70,76,89,13,68,79,87,78,0,65,82,69,65,0,8,35,85,80,73,68,0,50,65,73,78,9},32))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({36,79,68,71,73,78,71,0,65,82,82,79,87,0,82,65,73,78,0,73,78,0,65,0,83,81,85,65,82,69},32))
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
clearStage(_d({51,84,65,71,69,20},32))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({49,85,69,69,78,0,73,78,0,80,72,65,83,69,0,18,0,13,0,75,69,69,80,73,78,71,0,43,69,78,0,40,65,75,73,0,65,67,84,73,86,69,0,70,82,79,77,0,72,69,82,69,0,79,78},32))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({51,84,65,84,85,69,17},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,17},32))
destroyStatue(_d({51,84,65,84,85,69,18},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,17},32))
recheckStatue(_d({51,84,65,84,85,69,18},32))
destroyStatue(_d({51,84,65,84,85,69,19},32))
if not enabled then return end
recheckStatue(_d({51,84,65,84,85,69,19},32))
recheckStatue(_d({51,84,65,84,85,69,18},32))
recheckStatue(_d({51,84,65,84,85,69,17},32))
if not enabled then return end
debug(_d({55,65,73,84,73,78,71,0,70,79,82,0,80,72,65,83,69,0,18,0,84,79,0,69,78,68},32))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({48,72,65,83,69,0,18,0,69,78,68,0,87,65,73,84,0,84,73,77,69,79,85,84,12,0,80,82,79,67,69,69,68,73,78,71,0,65,78,89,87,65,89},32))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,66,65,67,75,0,84,79,0,49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
navToPointConfirmed(COORDS.Queen, 30, _d({49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84,0,49,85,69,69,78,0,83,84,65,71,69,0,80,79,83,73,84,73,79,78},32))
task.wait(5)
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,84,79,0,80,79,83,84,13,49,85,69,69,78,0,80,79,83,73,84,73,79,78},32))
navToPointConfirmed(COORDS.PostQueen, 30, _d({80,79,83,84,13,49,85,69,69,78,0,80,79,83,73,84,73,79,78},32))
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
debug(_d({37,78,65,66,76,73,78,71,12,0,80,79,83,0,34,37,38,47,50,37,0,80,76,65,78,26},32), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({48,76,65,78,0,69,82,82,79,82,26},32), err2) end
end)
debug(_d({37,78,65,66,76,69,68,26},32), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({37,78,65,66,76,69,68,26},32), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.RequirePlace(11424731604, _d({35,85,80,73,68,0,36,85,78,71,69,79,78},32)) then
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
_d({35,85,80,73,68,0,36,85,78,71,69,79,78},32),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({42,85,90,79,0,84,72,69,0,36,73,65,77,79,78,68,66,65,67,75},32),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({34,65,67,75,80,65,67,75},32))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)) or (bp and bp:FindFirstChild(_d({40,79,82,79,13,40,79,82,79},32)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({46,48,35,83},32))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hum = boss:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
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
if key == _d({40,73,84},32) then return target.CFrame
elseif key == _d({52,65,82,71,69,84},32) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({59,40,79,82,79,38,65,82,77,61,0,45,69,84,65,84,65,66,76,69,0,72,79,79,75,0,70,65,73,76,69,68,26,0},32) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({59,40,79,82,79,38,65,82,77,61,0,51,84,79,80,80,69,68,14},32))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({59,40,79,82,79,38,65,82,77,61,0,33,76,82,69,65,68,89,0,82,85,78,78,73,78,71,1},32)); return end
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({59,40,79,82,79,38,65,82,77,61,0,51,84,65,82,84,69,68,0,84,65,82,71,69,84,73,78,71,26,0},32) .. HoroFarm.Config.SelectedBoss)
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
_d({40,79,82,79,38,65,82,77},32),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,51,84,79,80,80,69,68,14},32))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,33,76,82,69,65,68,89,0,82,85,78,78,73,78,71,1},32)); return end
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
if not Safeguard.RequirePlace(3978370137, _d({38,73,82,83,84,0,51,69,65},32)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32), 10)
local hum = char:WaitForChild(_d({40,85,77,65,78,79,73,68},32), 10)
local stats = ReplicatedStorage:WaitForChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({48,69,76,73},32), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({50,73,70,76,69},32)) or (char and char:FindFirstChild(_d({50,73,70,76,69},32)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,35,85,82,82,69,78,84,0,48,69,76,73,0,67,72,69,67,75,26},32), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,46,79,84,0,65,84,0,52,79,87,78,0,79,70,0,34,69,71,73,78,78,73,78,71,83,14,0,48,76,69,65,83,69,0,84,82,65,86,69,76,0,84,72,69,82,69,0,84,79,0,70,65,82,77,0,67,72,69,83,84,83,0,87,72,73,76,69,0,87,65,73,84,73,78,71,0,70,79,82,0,50,73,70,76,69,14},32))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,67,72,69,83,84,63,70,65,82,77,69,82,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,72,69,83,84,63,70,65,82,77,69,82,14,76,85,65},32))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,38,65,82,77,73,78,71,0,67,72,69,83,84,83,0,85,78,84,73,76,0,19,16,16,0,48,69,76,73,14,14,14,0,8,35,85,82,82,69,78,84,26,0},32) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({48,69,76,73},32))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({50,73,70,76,69},32)) or (c and c:FindFirstChild(_d({50,73,70,76,69},32))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({34,85,89,65,66,76,69,41,84,69,77,83},32))
local shopItem = buyables and buyables:FindFirstChild(_d({50,73,70,76,69},32))
local shopPart = shopItem and shopItem:FindFirstChild(_d({51,72,79,80,48,65,82,84},32))
if EasyTravel and shopPart and hrp then
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,52,82,65,86,69,76,73,78,71,0,84,79,0,50,73,70,76,69,0,83,72,79,80,0,86,73,65,0,37,65,83,89,52,82,65,86,69,76,14,14,14},32))
local nocollide = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({34,65,83,69,48,65,82,84},32)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({37,86,69,78,84,83},32)) and ReplicatedStorage.Events:FindFirstChild(_d({51,72,79,80},32))
if shopEvent and shopEvent:IsA(_d({50,69,77,79,84,69,38,85,78,67,84,73,79,78},32)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,37,81,85,73,80,80,73,78,71,0,50,73,70,76,69,14,14,14},32))
local args = {
[1] = _d({69,81,85,73,80},32),
[2] = _d({50,73,70,76,69},32)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({37,86,69,78,84,83},32)) and ReplicatedStorage.Events:FindFirstChild(_d({52,79,79,76,83},32))
if toolsEvent and toolsEvent:IsA(_d({50,69,77,79,84,69,38,85,78,67,84,73,79,78},32)) then
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
local hum = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68},32))
local hrp = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({50,73,70,76,69},32))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,38,76,89,73,78,71,0,84,79,0,38,73,83,72,77,65,78,0,35,65,86,69,14,14,14},32))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,69,65,83,89,63,84,82,65,86,69,76,14,76,85,65},32))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,37,83,67,65,80,73,78,71,0,83,72,79,80,0,73,78,84,69,82,73,79,82,0,66,89,0,70,76,89,73,78,71,0,83,84,82,65,73,71,72,84,0,85,80,14,14,14},32))
local nocollide = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({34,65,83,69,48,65,82,84},32)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then break end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
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
print(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,38,76,89,73,78,71,0,84,79,0,38,73,83,72,77,65,78,0,35,65,86,69,14,14,14},32))
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
local FishmanMaze = Core.Import(_d({16,17,13,71,80,79,15,76,73,66,15,70,73,83,72,77,65,78,63,77,65,90,69,14,76,85,65},32), _d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,70,73,83,72,77,65,78,63,77,65,90,69,14,76,85,65},32))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,38,65,73,76,69,68,0,84,79,0,73,77,80,79,82,84,0,38,73,83,72,77,65,78,45,65,90,69,0,76,73,66,82,65,82,89,1},32))
end
else
warn(_d({59,44,69,86,69,76,0,39,82,73,78,68,69,82,61,0,47,85,84,83,73,68,69,0,38,73,83,72,77,65,78,0,35,65,86,69,0,66,79,85,78,68,83,12,0,83,75,73,80,80,73,78,71,0,77,65,90,69,14},32))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({44,69,86,69,76,0,39,82,73,78,68,69,82},32),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local RunService       = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)) then
Core = loadstring(readfile(_d({16,17,13,71,80,79,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
else
Core = loadstring(game:HttpGet(_d({72,84,84,80,83,26,15,15,82,65,87,14,71,73,84,72,85,66,85,83,69,82,67,79,78,84,69,78,84,14,67,79,77,15,82,79,67,75,89,88,87,65,76,76,15,76,85,65,85,13,67,79,68,69,15,77,65,73,78,15,16,17,63,83,67,82,73,80,84,15,76,73,66,15,67,79,82,69,14,76,85,65},32)))()
end
end)
if not Core then warn(_d({59,35,79,82,69,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
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
return char, char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)), char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({63,63,37,65,83,89,52,82,65,86,69,76,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,37,65,83,89,52,82,65,86,69,76,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,37,65,83,89,52,82,65,86,69,76,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,37,65,83,89,52,82,65,86,69,76,38,79,82,67,69},32)
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
local force = root:FindFirstChild(_d({63,63,37,65,83,89,52,82,65,86,69,76,38,79,82,67,69},32))
local att = root:FindFirstChild(_d({63,63,37,65,83,89,52,82,65,86,69,76,33,84,84},32))
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
local cave = Workspace.Islands:FindFirstChild(_d({38,73,83,72,77,65,78,0,35,65,86,69},32))
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
if not Safeguard then warn(_d({59,51,65,70,69,71,85,65,82,68,61,0,38,65,73,76,69,68,0,84,79,0,76,79,65,68,1},32)); return end
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
print(_d({59,37,65,83,89,0,52,82,65,86,69,76,61,0,38,76,73,71,72,84,0,69,78,65,66,76,69,68,14},32))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({59,37,65,83,89,0,52,82,65,86,69,76,61,0,38,76,73,71,72,84,0,68,73,83,65,66,76,69,68,14},32))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({37,65,83,89,0,52,82,65,86,69,76},32),
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
local Players = game:GetService(_d({48,76,65,89,69,82,83},32))
local RunService = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local UserInputService = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local ReplicatedStorage = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({73,68,76,69},32)
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
print(_d({59,47,86,69,82,87,79,82,76,68,52,69,83,84,69,82,61},32), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({51,84,65,84,83},32) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({50,79,75,85,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,69,80,80,79},32), args)
elseif style == _d({34,76,65,67,75,44,69,71},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75},32), args)
elseif style == _d({43,65,77,73,83,72,73,75,73},32) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,65,77,73,83,72,73,75,73,39,69,80,80,79},32), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,75,89,0,55,65,76,75,18},32), args)
end
debug(_d({38,73,82,69,68,0,39,69,80,80,79,0,50,69,77,79,84,69},32))
end)
if not ok then debug(_d({73,78,86,79,75,69,39,69,80,80,79,0,69,82,82,79,82,26},32), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32)) or Instance.new(_d({33,84,84,65,67,72,77,69,78,84},32))
att.Name = _d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32)
att.Parent = root
local force = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32))
if not force then
force = Instance.new(_d({44,73,78,69,65,82,54,69,76,79,67,73,84,89},32))
force.Name = _d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32)
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
local root = char:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32))
if not root then return end
local force = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,38,79,82,67,69},32))
local att   = root:FindFirstChild(_d({63,63,52,69,83,84,40,79,86,69,82,33,84,84},32))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({55,65,76,75,73,78,71,0,84,79,26},32), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({87,65,76,75,52,79,48,79,73,78,84,0,55,0,68,79,87,78,0,69,82,82,79,82,26},32), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({33,82,82,73,86,69,68,0,65,84,26},32), pos)
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
if item:IsA(_d({45,79,68,69,76},32)) and item:FindFirstChild(_d({40,85,77,65,78,79,73,68,50,79,79,84,48,65,82,84},32)) and item:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({40,85,77,65,78,79,73,68},32)).Health > 0 then
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
mode = _d({73,68,76,69},32)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({52,69,83,84,69,82,0,36,73,83,65,66,76,69,68},32))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({52,69,83,84,69,82,0,37,78,65,66,76,69,68,14,0,45,79,68,69,26},32), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({48,76,65,89,69,82,0,68,73,69,68,1,0,36,73,83,65,66,76,73,78,71,0,66,79,84,14},32))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({72,79,86,69,82},32) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({68,79,68,71,69},32) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) then
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
local playerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({47,86,69,82,87,79,82,76,68,52,69,83,84,39,85,73},32))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({51,67,82,69,69,78,39,85,73},32))
screenGui.Name = _d({47,86,69,82,87,79,82,76,68,52,69,83,84,39,85,73},32)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({38,82,65,77,69},32))
frame.Name = _d({45,65,73,78,38,82,65,77,69},32)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({53,41,35,79,82,78,69,82},32))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({208,127,123,129,207,152,111,0,35,85,80,73,68,0,37,78,71,73,78,69,0,47,86,69,82,87,79,82,76,68,0,52,69,83,84},32)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({51,84,65,84,85,83,26,0,41,68,76,69},32)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({52,69,88,84,34,79,88},32))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({40,79,86,69,82,0,33,66,79,86,69,0,52,65,82,71,69,84},32), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({72,79,86,69,82},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,40,79,86,69,82,73,78,71,0},32) .. val .. _d({0,83,84,85,68,83,0,85,80},32)
end)
createInputBtn(_d({36,79,68,71,69,0,35,76,73,77,66},32), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({68,79,68,71,69},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,36,79,68,71,69,13,72,79,76,68,73,78,71,0,8},32) .. val .. _d({0,83,84,85,68,83,9},32)
end)
createInputBtn(_d({52,69,83,84,0,51,81,85,65,82,69,0,36,79,68,71,69},32), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({83,81,85,65,82,69,63,68,79,68,71,69},32))
statusLabel.Text = _d({51,84,65,84,85,83,26,0,51,81,85,65,82,69,0,55,65,76,75,73,78,71,0,8},32) .. val .. _d({0,83,84,85,68,83,9},32)
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
while enabled and mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({83,81,85,65,82,69,63,68,79,68,71,69},32) then
disableBot()
statusLabel.Text = _d({51,84,65,84,85,83,26,0,41,68,76,69,0,8,51,81,85,65,82,69,0,68,79,68,71,69,0,68,79,78,69,9},32)
end
end)
end)
local stopBtn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({37,45,37,50,39,37,46,35,57,0,51,52,47,48},32)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({53,41,35,79,82,78,69,82},32), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({51,84,65,84,85,83,26,0,51,52,47,48,48,37,36,0,8,41,68,76,69,9},32)
local VIM = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({59,47,86,69,82,87,79,82,76,68,52,69,83,84,69,82,61,0,44,79,65,68,69,68,0,83,85,67,67,69,83,83,70,85,76,76,89,14},32))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({48,76,65,89,69,82,39,85,73},32), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({39,48,47,44,65,85,78,67,72,69,82,53,41},32))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({51,67,82,69,69,78,39,85,73},32))
screenGui.Name = _d({39,48,47,44,65,85,78,67,72,69,82,53,41},32)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({38,82,65,77,69},32))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({53,41,35,79,82,78,69,82},32))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({53,41,51,84,82,79,75,69},32))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({208,127,108,108,0,39,48,47,0,40,85,66,0,44,65,85,78,67,72,69,82},32)
title.Parent = main
local closeBtn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({53,41,35,79,82,78,69,82},32), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({35,72,79,79,83,69,0,65,0,66,79,84,0,79,82,0,85,84,73,76,73,84,89,0,84,79,0,82,85,78,26},32)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({52,69,88,84,34,85,84,84,79,78},32))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({0,0},32) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({53,41,35,79,82,78,69,82},32))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({53,41,51,84,82,79,75,69},32))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({52,69,88,84,44,65,66,69,76},32))
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
CreateLaunchButton(_d({35,85,80,73,68,0,36,85,78,71,69,79,78,0,38,65,82,77},32), _d({33,85,84,79,77,65,84,69,0,67,85,80,73,68,0,68,85,78,71,69,79,78,83,0,6,0,66,79,83,83,0,67,89,67,76,69,83},32), loadCupidDungeon)
CreateLaunchButton(_d({40,79,82,79,0,34,79,83,83,0,38,65,82,77,0,8,51,73,76,69,78,84,0,33,73,77,9},32), _d({33,85,84,79,70,65,82,77,0,79,86,69,82,87,79,82,76,68,0,66,79,83,83,69,83,0,85,83,73,78,71,0,40,79,82,79,0,70,82,85,73,84,83},32), loadHoroBossFarm)
CreateLaunchButton(_d({44,69,86,69,76,0,6,0,45,79,66,0,39,82,73,78,68,69,82},32), _d({33,85,84,79,13,76,69,86,69,76,0,65,78,68,0,70,65,82,77,0,76,79,67,65,76,0,46,48,35,0,77,79,66,83},32), loadLevelGrinder)
CreateLaunchButton(_d({37,65,83,89,0,52,82,65,86,69,76,0,8,48,0,52,79,71,71,76,69,9},32), _d({55,33,51,36,0,38,76,73,71,72,84,0,87,73,84,72,0,71,82,79,85,78,68,0,70,79,76,76,79,87,0,6,0,87,65,76,76,0,67,76,73,77,66,73,78,71},32), loadNavigationLab)
CreateLaunchButton(_d({48,72,89,83,73,67,83,0,47,86,69,82,87,79,82,76,68,0,52,69,83,84,69,82},32), _d({52,69,83,84,0,67,79,77,66,65,84,0,72,79,86,69,82,12,0,71,69,80,80,79,0,6,0,68,79,68,71,69,0,72,69,73,71,72,84,83},32), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({59,39,48,47,0,40,85,66,61,0,44,65,85,78,67,72,69,82,0,53,41,0,73,78,73,84,73,65,76,73,90,69,68,14},32))
end)()