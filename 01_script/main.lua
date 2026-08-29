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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({37,65,54,78,58,71,72},43))
local UserInputService    = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local RunService          = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local VIM                 = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
local ReplicatedStorage    = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
end
end)
if not Core then warn(_d({48,24,68,71,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,9,9,6,9,6,8,7,12},43)
local LEO_ENTEI_ANIM_ID    = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,9,9,6,8,13,7,12,13},43)
local LEO_HIKEN_ANIM_ID    = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,7,5,14,6,12,9,5,12},43)
local LEO_FIREFLY_ANIM_ID  = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,7,5,7,8,11,6,10,9},43)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({36,55,63,58,56,73,62,75,58,72},43)
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
local REPLAY_BUTTON_VALUE   = _d({39,58,69,65,54,78},43)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({66,68,75,58},43)
local NavState   = {mode = _d({62,57,65,58},43)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({48,23,68,72,72,23,68,73,50},43), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end)
if ok then return root end
debug(_d({60,58,73,39,68,68,73,245,58,71,71,68,71,15},43), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
end)
if ok then return hum end
debug(_d({60,58,73,29,74,66,54,67,68,62,57,245,58,71,71,68,71,15},43), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({52,52,29,68,75,58,71,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,29,68,75,58,71,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,29,68,75,58,71,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,29,68,75,58,71,27,68,71,56,58},43)
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
debug(_d({60,58,73,36,71,24,71,58,54,73,58,27,68,71,56,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local force = root:FindFirstChild(_d({52,52,29,68,75,58,71,27,68,71,56,58},43))
local att   = root:FindFirstChild(_d({52,52,29,68,75,58,71,22,73,73},43))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({56,65,58,54,67,74,69,27,68,71,56,58,245,58,71,71,68,71,15},43), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({23,74,72,68,34,58,65,58,58},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,23,74,72,68,22,56,73,62,75,58,245,58,71,71,68,71,15},43), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({23,74,72,68},43))
end)
if not ok then debug(_d({54,56,73,62,75,54,73,58,23,74,72,68,245,58,71,71,68,71,15},43), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({23,74,72,68,245,67,68,73,245,54,56,73,62,75,58,1,245,54,56,73,62,75,54,73,62,67,60},43))
activateBuso()
end
end)
if not ok then debug(_d({23,74,72,68,32,58,58,69,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({23,74,72,68,245,64,58,58,69,58,71,245,72,73,68,69,69,58,57},43))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({32,58,67,29,54,64,62},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,32,58,67,22,56,73,62,75,58,245,58,71,71,68,71,15},43), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({32,58,67},43), true)
end)
if not ok then debug(_d({54,56,73,62,75,54,73,58,32,58,67,245,58,71,71,68,71,15},43), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({32,58,67,245,67,68,73,245,54,56,73,62,75,58,1,245,54,56,73,62,75,54,73,62,67,60},43))
activateKen()
end
end)
if not ok then debug(_d({32,58,67,32,58,58,69,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({32,58,67,245,64,58,58,69,58,71,245,72,73,68,69,69,58,57},43))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({35,37,24,72},43)) end)
if ok then return folder end
debug(_d({60,58,73,35,37,24,72,27,68,65,57,58,71,245,58,71,71,68,71,15},43), folder)
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
local r = model:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local h = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
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
debug(_d({60,58,73,35,58,54,71,58,72,73,35,37,24,245,58,71,71,68,71,15},43), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hum  = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({60,58,73,35,37,24,23,78,35,54,66,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({67,69,56,72,39,58,66,54,62,67,62,67,60,245,58,71,71,68,71,15},43), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({24,74,69,62,57,245,38,74,58,58,67},43))
return queen ~= nil and queen:FindFirstChild(_d({66,68,73,62,68,67,33,58,72,72},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,38,74,58,58,67,37,61,54,72,58,7,245,58,71,71,68,71,15},43), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,6,7,6,7,14,12,14,9,7,7,14,7,12,11,14},43)
local QUEEN_GRASP_ANIM_ID   = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,6,7,14,13,5,5,5,11,6,5,5,6,12,8,9},43)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
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
debug(_d({62,72,37,65,54,78,62,67,60,22,67,62,66,27,71,68,66,33,62,72,73,245,58,71,71,68,71,15},43), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({23,65,68,56,64,62,67,60},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,35,37,24,23,65,68,56,64,62,67,60,245,58,71,71,68,71,15},43), result)
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
debug(_d({69,71,58,57,62,56,73,35,37,24,37,68,72,62,73,62,68,67,245,58,71,71,68,71,15},43), result)
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
debug(_d({35,68,245,57,54,66,54,60,58,245,68,67},43), model.Name, _d({59,68,71},43), NPC_STUCK_TIMEOUT, _d({72,245,2,245,72,76,62,73,56,61,62,67,60,245,73,54,71,60,58,73},43))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({73,71,54,56,64,35,37,24,25,54,66,54,60,58,245,58,71,71,68,71,15},43), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({34,68,57,58,65},43)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({23,54,72,58,37,54,71,73},43)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({60,58,73,34,68,57,58,65,27,54,56,58,37,68,72,245,58,71,71,68,71,15},43), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({26,67,75},43))
local folder = env and env:FindFirstChild(_d({40,73,54,73,74,58,72},43))
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
debug(_d({60,58,73,40,73,54,73,74,58,34,68,57,58,65,35,58,54,71,245,58,71,71,68,71,15},43), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({55,54,71,71,58,65,29,37},43))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({60,58,73,40,73,54,73,74,58,29,37,245,58,71,71,68,71,15},43), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({41,68,68,65},43)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,22,73,73,71,62,55,74,73,58,245,58,71,71,68,71,15},43), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({41,68,68,65},43)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,35,54,66,58,245,58,71,71,68,71,15},43), tool)
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
if not ok then debug(_d({58,70,74,62,69,41,68,68,65,245,58,71,71,68,71,15},43), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({41,68,68,65},43)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,24,61,62,65,57,35,54,66,58,245,58,71,71,68,71,15},43), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({40,76,68,71,57,26,70,74,62,69},43))
if sword then
equipTool(sword)
return _d({72,76,68,71,57},43)
end
local melee = findToolByAttribute(_d({34,58,65,58,58,41,68,68,65},43))
if melee then
equipTool(melee)
return _d({66,58,65,58,58},43)
end
debug(_d({35,68,245,72,76,68,71,57,245,68,71,245,66,58,65,58,58,245,73,68,68,65,245,59,68,74,67,57},43))
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
if not ok then debug(_d({56,65,62,56,64,34,6,245,58,71,71,68,71,15},43), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({39,68,64,74,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,58,69,69,68},43), args)
elseif style == _d({23,65,54,56,64,33,58,60},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64},43), args)
elseif style == _d({32,54,66,62,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,54,66,62,72,61,62,64,62,28,58,69,69,68},43), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64,7},43), args)
end
end)
if not ok then debug(_d({62,67,75,68,64,58,28,58,69,69,68,245,58,71,71,68,71,15},43), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({69,71,58,72,72,40,64,62,65,65,39,245,58,71,71,68,71,15},43), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({61,68,65,57,23,65,68,56,64,245,58,71,71,68,71,15},43), err) end
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
if not ok then debug(_d({61,68,65,57,23,65,68,56,64,44,61,62,65,58,245,58,71,71,68,71,15},43), err) end
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
debug(_d({60,58,73,28,54,66,58,28,245,58,71,71,68,71,15},43), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({62,72,39,58,54,65,34,6,23,74,72,78,245,58,71,71,68,71,15},43), result)
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
return char ~= nil and char:FindFirstChild(_d({72,73,74,67},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,40,73,74,67,67,58,57,245,58,71,71,68,71,15},43), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({69,71,58,72,72,40,73,74,67,23,71,58,54,64,245,58,71,71,68,71,15},43), err) end
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
debug(_d({70,74,58,58,67,25,68,57,60,58,42,67,73,62,65,40,54,59,58,15,245,38,74,58,58,67,245,60,68,67,58,245,2,245,58,67,57,62,67,60,245,57,68,57,60,58,245,58,54,71,65,78},43))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({70,74,58,58,67,25,68,57,60,58,42,67,73,62,65,40,54,59,58,245,72,54,59,58,73,78,245,73,62,66,58,68,74,73},43))
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
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({38,74,58,58,67,245,56,54,72,73,62,67,60,245,57,58,73,58,56,73,58,57,245,2,245,57,68,57,60,62,67,60,245,253,76,54,73,56,61,58,71,254},43))
queenDodgeUntilSafe(function() return getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) end)
if enabled and getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) then
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
end
queenDodging = false
end
end)
if not ok then debug(_d({70,74,58,58,67,25,68,57,60,58,44,54,73,56,61,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({69,68,62,67,73},43) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({67,69,56},43) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({67,54,66,58,57},43) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({60,58,73,35,54,75,41,54,71,60,58,73,72,245,58,71,71,68,71,15},43), aimR)
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
debug(_d({56,68,66,69,74,73,58,33,68,56,64,58,57,24,27,71,54,66,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({69,68,62,67,73},43), point = pos}
phase = _d({66,68,75,58},43)
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
if not ok then debug(_d({67,54,75,41,68,37,68,62,67,73,245,60,58,69,69,68,245,56,61,58,56,64,245,58,71,71,68,71,15},43), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({67,69,56},43)}
phase = _d({66,68,75,58},43)
end
function setNavNamed(name)
NavState = {mode = _d({67,54,66,58,57},43), name = name}
phase = _d({66,68,75,58},43)
end
local function setNavIdle()
NavState = {mode = _d({62,57,65,58},43)}
phase = _d({66,68,75,58},43)
end
local function hasArrived()
return phase == _d({61,68,75,58,71},43)
end
local function startNav()
phase = _d({66,68,75,58},43)
debug(_d({35,54,75,245,65,68,68,69,245,36,35},43))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({37,65,54,78,58,71,245,57,62,58,57,246,245,40,73,68,69,69,62,67,60,245,55,68,73,3},43))
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
debug(_d({37,65,54,78,58,71,245,62,72,245,73,68,68,245,59,54,71,245,59,71,68,66,245,73,54,71,60,58,73,245,253,19,7,5,5,5,245,72,73,74,57,72,254,3,245,33,62,64,58,65,78,245,71,58,72,69,54,76,67,58,57,245,54,73,245,65,68,55,55,78,3,245,40,73,68,69,69,62,67,60,245,55,68,73,3},43))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({52,52,69,71,58,75,37,68,72},43))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({33,54,71,60,58,245,69,68,72,62,73,62,68,67,245,63,74,66,69,245,57,58,73,58,56,73,58,57,15},43), delta, _d({72,73,74,57,72,3,245,69,71,58,75,37,68,72,18},43), prevPos, _d({67,58,76,37,68,72,18},43), pos)
end
end
force:SetAttribute(_d({52,52,69,71,58,75,37,68,72},43), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({66,68,75,58},43) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({61,68,75,58,71},43)
debug(_d({37,61,54,72,58,15,245,61,68,75,58,71},43))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({246,246,246,245,39,26,27,42,40,30,35,28,245,41,36,245,22,37,37,33,46,245,22,23,35,36,39,34,22,33,245,43,26,33,36,24,30,41,46,15},43), finalVel, _d({54,62,66,18},43), aim, _d({69,68,72,18},43), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({61,68,75,58,71},43) then
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
debug(_d({24,68,66,55,54,73,245,65,68,56,64,245,72,64,62,69,69,58,57,1},43), snapDist, _d({72,73,74,57,72,245,59,71,68,66,245,73,54,71,60,58,73,245,183,85,105,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,66,68,75,58},43))
phase = _d({66,68,75,58},43)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({29,58,54,71,73,55,58,54,73,245,58,71,71,68,71,15},43), err) end
end)
end
local function stopNav()
debug(_d({35,54,75,245,65,68,68,69,245,36,27,27},43))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({66,68,75,58},43)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({41,58,77,73,24,61,54,73,40,58,71,75,62,56,58},43))
local channels = TextChatService:FindFirstChild(_d({41,58,77,73,24,61,54,67,67,58,65,72},43))
local channel = channels and channels:FindFirstChild(_d({39,23,45,28,58,67,58,71,54,65},43))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({25,58,59,54,74,65,73,24,61,54,73,40,78,72,73,58,66,24,61,54,73,26,75,58,67,73,72},43))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({40,54,78,34,58,72,72,54,60,58,39,58,70,74,58,72,73},43))
if sayEvent then
sayEvent:FireServer(message, _d({22,65,65},43))
return
end
debug(_d({72,58,67,57,24,61,54,73,34,58,72,72,54,60,58,15,245,67,68,245,41,58,77,73,24,61,54,73,40,58,71,75,62,56,58,3,39,23,45,28,58,67,58,71,54,65,245,68,71,245,65,58,60,54,56,78,245,40,54,78,34,58,72,72,54,60,58,39,58,70,74,58,72,73,245,59,68,74,67,57,245,59,68,71},43), message)
end)
if not ok then debug(_d({72,58,67,57,24,61,54,73,34,58,72,72,54,60,58,245,58,71,71,68,71,15},43), err) end
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
debug(_d({35,68,73,245,66,54,64,62,67,60,245,69,71,68,60,71,58,72,72,245,73,68,76,54,71,57,245,67,54,75,245,73,54,71,60,58,73,245,59,68,71},43), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({72,245,2,245,72,58,67,57,62,67,60,245,4,74,67,72,73,74,56,64},43))
sendChatMessage(_d({4,74,67,72,73,74,56,64},43))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({76,54,62,73,42,67,73,62,65,22,71,71,62,75,58,57,245,73,62,66,58,68,74,73},43))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({67,54,75,41,68,37,68,62,67,73,24,68,67,59,62,71,66,58,57,15},43), label or _d({73,54,71,60,58,73},43), _d({2,245,57,62,57,245,67,68,73,245,54,71,71,62,75,58,245,76,62,73,61,62,67},43), timeout, _d({72,1,245,71,58,73,71,78,62,67,60,245,68,67,56,58},43))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({67,54,75,41,68,37,68,62,67,73,24,68,67,59,62,71,66,58,57,15},43), label or _d({73,54,71,60,58,73},43), _d({2,245,72,73,62,65,65,245,67,68,73,245,54,71,71,62,75,58,57,245,54,59,73,58,71,245,71,58,73,71,78,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
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
if not ok then debug(_d({67,54,75,41,68,37,68,62,67,73,29,68,65,57,62,67,60,23,65,68,56,64,245,64,58,78,2,57,68,76,67,245,58,71,71,68,71,15},43), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({67,54,75,41,68,37,68,62,67,73,29,68,65,57,62,67,60,23,65,68,56,64,245,64,58,78,2,74,69,245,58,71,71,68,71,15},43), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({44,54,65,64,62,67,60,245,73,68,15},43), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({76,54,65,64,41,68,37,68,62,67,73,245,44,245,57,68,76,67,245,58,71,71,68,71,15},43), err) end
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
debug(_d({41,68,68,64,245,57,54,66,54,60,58,245,76,61,62,65,58,245,76,54,65,64,62,67,60,245,73,68,245,69,68,62,67,73,246,245,40,73,68,69,69,62,67,60,245,76,54,65,64,245,73,68,245,58,67,60,54,60,58,3},43))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({22,71,71,62,75,58,57,245,54,73,15},43), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({40,73,74,56,64,245,57,74,71,62,67,60,245,76,54,65,64,1,245,63,74,66,69,62,67,60,246},43))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({40,73,62,65,65,245,72,73,74,56,64,1,245,73,71,62,60,60,58,71,62,67,60,245,28,58,69,69,68,246},43))
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
debug(_d({34,68,75,62,67,60,245,73,68},43), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,35,37,24,72,245,73,68,245,72,69,54,76,67,245,54,73},43), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({245,245,72,69,54,76,67,245,56,61,58,56,64,15,245,59,68,65,57,58,71,245,58,77,62,72,73,72,245,18},43), folder ~= nil,
_d({1,245,56,61,62,65,57,71,58,67,245,18},43), folder and #folder:GetChildren() or 0,
_d({1,245,54,65,62,75,58,245,18},43), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({35,68,245,35,37,24,72,245,54,69,69,58,54,71,58,57,245,54,73},43), stageName, _d({54,59,73,58,71,245,6,10,72,1,245,66,68,75,62,67,60,245,68,67,245,54,67,78,76,54,78},43))
break
end
end
debug(_d({32,62,65,65,62,67,60,245,35,37,24,72,245,54,73},43), stageName)
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
debug(_d({39,58,73,74,71,67,62,67,60,245,73,68},43), stageName, _d({69,68,72,62,73,62,68,67,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,68,67},43))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73},43), stageName, _d({69,68,72,62,73,62,68,67},43))
task.wait(5)
debug(_d({44,54,62,73,62,67,60,245,59,68,71},43), targetHP * 100, _d({250,245,29,37,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,73,68,245,67,58,77,73,245,72,73,54,60,58},43))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({56,65,58,54,71,58,57},43))
end
local function killNamedNPC(name, targetPos)
debug(_d({34,68,75,62,67,60,245,73,68},43), name)
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
debug(name, _d({57,58,59,58,54,73,58,57},43))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({33,58,68,245,69,65,54,78,58,57,245,54,67,62,66,54,73,62,68,67,15},43), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({65,58,68,22,67,62,66,33,68,60,60,58,71,245,69,71,62,67,73,245,58,71,71,68,71,15},43), err2) end
end)
end)
if not ok then debug(_d({72,73,54,71,73,33,58,68,22,67,62,66,33,68,60,60,58,71,245,58,71,71,68,71,15},43), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({34,68,75,62,67,60,245,73,68,245,33,58,68},43))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({33,58,68},43))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({33,58,68},43))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({33,58,68},43))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({33,58,68,245,56,54,72,73,62,67,60},43), which, _d({2,245,57,68,57,60,62,67,60},43))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({33,58,68,245,72,73,54,71,73,58,57,245,55,65,68,56,64,2,55,71,58,54,64,58,71,245,66,62,57,2,55,65,68,56,64,246,245,26,75,54,57,62,67,60,3,3,3},43))
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
if not getNPCByName(_d({33,58,68},43)) then
debug(_d({33,58,68,245,60,68,67,58,245,66,62,57,2,57,68,57,60,58,245,2,245,58,67,57,62,67,60,245,26,67,73,58,62,245,61,68,65,57,245,58,54,71,65,78},43))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({33,58,68},43)) then
setNavNamed(_d({33,58,68},43))
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
debug(_d({33,58,68,245,57,58,59,58,54,73,58,57},43))
stopLeoAnimLogger()
debug(_d({39,58,73,74,71,67,62,67,60,245,73,68,245,33,58,68,245,69,68,72,62,73,62,68,67,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,68,67},43))
navToPointConfirmed(COORDS.Leo, 30, _d({33,58,68,245,69,68,72,62,73,62,68,67},43))
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73,245,33,58,68,245,69,68,72,62,73,62,68,67},43))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({34,68,75,62,67,60,245,73,68},43), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({24,68,74,65,57,245,67,68,73,245,59,62,67,57,245,72,73,54,73,74,58,245,66,68,57,58,65,245,67,58,54,71},43), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({22,73,73,54,56,64,62,67,60},43), coordKey, _d({76,62,73,61},43), weapon or _d({67,68,73,61,62,67,60,245,59,68,74,67,57},43))
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
debug(coordKey, _d({55,54,71,71,58,65,245,57,58,72,73,71,68,78,58,57},43))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({2,245,56,68,74,65,57,245,67,68,73,245,59,62,67,57,245,72,73,54,73,74,58,245,66,68,57,58,65,1,245,72,64,62,69,69,62,67,60},43))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({72,73,62,65,65,245,54,65,62,75,58,245,253,29,37},43), hp, _d({254,245,2,245,71,58,2,57,58,72,73,71,68,78,62,67,60},43))
destroyStatue(coordKey)
else
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({56,68,67,59,62,71,66,58,57,245,57,58,72,73,71,68,78,58,57},43))
end
end)
if not ok then debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,245,58,71,71,68,71,15},43), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({34,68,75,62,67,60,245,73,68,245,38,74,58,58,67},43))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
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
debug(_d({38,74,58,58,67,245,58,67,73,58,71,58,57,245,69,61,54,72,58,245,7},43))
end
local function finishQueen()
debug(_d({27,62,67,62,72,61,62,67,60,245,38,74,58,58,67},43))
equipSwordOrMelee()
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
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
debug(_d({38,74,58,58,67,245,57,58,59,58,54,73,58,57,3,245,37,65,54,67,245,56,68,66,69,65,58,73,58,3},43))
end
local CONFIRMATION_PROMPT_NAME = _d({24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73},43)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({39,58,66,68,73,58,26,75,58,67,73},43), 5)
end)
if ok then return result end
debug(_d({60,58,73,39,58,69,65,54,78,39,58,66,68,73,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({37,65,54,78,58,71,28,74,62},43))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({30,66,54,60,58,23,74,73,73,68,67},43)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({55,74,73,73,68,67,43,54,65,74,58},43)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({59,62,67,57,23,74,73,73,68,67,23,78,43,54,65,74,58,245,58,71,71,68,71,15},43), result)
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
if not ok then debug(_d({56,65,62,56,64,28,74,62,23,74,73,73,68,67,245,58,71,71,68,71,15},43), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({62,72,40,58,71,75,58,71},43))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({39,58,66,68,73,58,26,75,58,67,73},43))
or inst:FindFirstChild(_d({56,65,62,58,67,73,26,75,58,67,73},43))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({59,62,67,57,22,67,72,76,58,71,24,68,67,67,58,56,73,68,71,245,58,71,71,68,71,15},43), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({24,68,74,65,57,245,67,68,73,245,65,68,56,54,73,58,245,39,58,66,68,73,58,26,75,58,67,73,4,56,65,62,58,67,73,26,75,58,67,73,245,67,58,54,71,245,39,58,69,65,54,78,245,55,74,73,73,68,67,1,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,56,65,62,56,64},43))
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
debug(_d({59,62,71,58,39,58,69,65,54,78,43,54,65,74,58,245,58,71,71,68,71,15},43), err, _d({2,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,56,65,62,56,64},43))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({27,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,55,74,73,73,68,67,43,54,65,74,58,245,72,58,54,71,56,61,245,59,68,71,245,39,58,69,65,54,78},43))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({39,58,69,65,54,78,245,55,74,73,73,68,67,245,67,68,73,245,59,68,74,67,57,245,58,62,73,61,58,71,1,245,60,62,75,62,67,60,245,74,69},43))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,3,39,58,66,68,73,58,26,75,58,67,73},43))
local remote = getReplayRemote()
if not remote then
debug(_d({24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,4,39,58,66,68,73,58,26,75,58,67,73,245,67,68,73,245,59,68,74,67,57,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73},43))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({27,62,71,62,67,60,245,39,58,69,65,54,78,245,75,62,54,245,24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,3,39,58,66,68,73,58,26,75,58,67,73},43))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({27,62,71,58,40,58,71,75,58,71,245,58,71,71,68,71,15},43), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then
debug(_d({76,54,62,73,27,68,71,36,55,63,58,56,73,62,75,58,72,28,74,62,15,245,67,68,245,37,65,54,78,58,71,28,74,62,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({36,55,63,58,56,73,62,75,58,72,245,28,42,30,245,59,68,74,67,57,245,2,245,72,73,54,60,58,245,65,68,54,57,58,57},43))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({36,55,63,58,56,73,62,75,58,72,245,28,42,30,245,67,68,73,245,59,68,74,67,57,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
return
end
end
end)
if not ok then debug(_d({76,54,62,73,27,68,71,36,55,63,58,56,73,62,75,58,72,28,74,62,245,58,71,71,68,71,15},43), err) end
end
local function runPlan()
debug(_d({37,65,54,67,245,72,73,54,71,73,58,57},43))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({40,73,54,71,73,62,67,60,245,67,54,75,245,65,68,68,69},43))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({69,68,72,245,5,3,7,72,245,22,27,41,26,39,245,72,73,54,71,73,35,54,75,15},43), rootAfter and rootAfter.Position)
end)
debug(_d({44,54,62,73,62,67,60,245,10,72,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,73,68,245,40,73,54,60,58,6},43))
task.wait(5)
for _, stage in ipairs({_d({40,73,54,60,58,6},43), _d({40,73,54,60,58,7},43), _d({40,73,54,60,58,8},43), _d({40,73,54,60,58,8,23},43)}) do
if not enabled then return end
local hpTarget = (stage == _d({40,73,54,60,58,8,23},43)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,73,68,245,54,71,71,68,76,245,59,65,78,2,57,68,76,67,245,54,71,58,54,245,253,24,74,69,62,57,245,39,54,62,67,254},43))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({25,68,57,60,62,67,60,245,54,71,71,68,76,245,71,54,62,67,245,62,67,245,54,245,72,70,74,54,71,58},43))
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
clearStage(_d({40,73,54,60,58,9},43))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({38,74,58,58,67,245,62,67,245,69,61,54,72,58,245,7,245,2,245,64,58,58,69,62,67,60,245,32,58,67,245,29,54,64,62,245,54,56,73,62,75,58,245,59,71,68,66,245,61,58,71,58,245,68,67},43))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({40,73,54,73,74,58,6},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,6},43))
destroyStatue(_d({40,73,54,73,74,58,7},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,6},43))
recheckStatue(_d({40,73,54,73,74,58,7},43))
destroyStatue(_d({40,73,54,73,74,58,8},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,8},43))
recheckStatue(_d({40,73,54,73,74,58,7},43))
recheckStatue(_d({40,73,54,73,74,58,6},43))
if not enabled then return end
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,69,61,54,72,58,245,7,245,73,68,245,58,67,57},43))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({37,61,54,72,58,245,7,245,58,67,57,245,76,54,62,73,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,55,54,56,64,245,73,68,245,38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
navToPointConfirmed(COORDS.Queen, 30, _d({38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73,245,38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
task.wait(5)
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,73,68,245,69,68,72,73,2,38,74,58,58,67,245,69,68,72,62,73,62,68,67},43))
navToPointConfirmed(COORDS.PostQueen, 30, _d({69,68,72,73,2,38,74,58,58,67,245,69,68,72,62,73,62,68,67},43))
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
debug(_d({26,67,54,55,65,62,67,60,1,245,69,68,72,245,23,26,27,36,39,26,245,69,65,54,67,15},43), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({37,65,54,67,245,58,71,71,68,71,15},43), err2) end
end)
debug(_d({26,67,54,55,65,58,57,15},43), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({26,67,54,55,65,58,57,15},43), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({48,40,54,59,58,60,74,54,71,57,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
if not Safeguard.RequirePlace(11424731604, _d({24,74,69,62,57,245,25,74,67,60,58,68,67},43)) then
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
_d({24,74,69,62,57,245,25,74,67,60,58,68,67},43),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local VIM = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({31,74,79,68,245,73,61,58,245,25,62,54,66,68,67,57,55,54,56,64},43),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
end
end)
if not Core then warn(_d({48,24,68,71,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({29,68,71,68,2,29,68,71,68},43)) or (bp and bp:FindFirstChild(_d({29,68,71,68,2,29,68,71,68},43)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({35,37,24,72},43))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hum = boss:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
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
if key == _d({29,62,73},43) then return target.CFrame
elseif key == _d({41,54,71,60,58,73},43) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({48,29,68,71,68,27,54,71,66,50,245,34,58,73,54,73,54,55,65,58,245,61,68,68,64,245,59,54,62,65,58,57,15,245},43) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({48,29,68,71,68,27,54,71,66,50,245,40,73,68,69,69,58,57,3},43))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({48,29,68,71,68,27,54,71,66,50,245,22,65,71,58,54,57,78,245,71,74,67,67,62,67,60,246},43)); return end
if not Safeguard then warn(_d({48,40,54,59,58,60,74,54,71,57,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({48,29,68,71,68,27,54,71,66,50,245,40,73,54,71,73,58,57,245,73,54,71,60,58,73,62,67,60,15,245},43) .. HoroFarm.Config.SelectedBoss)
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
_d({29,68,71,68,27,54,71,66},43),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
end
end)
if not Core then warn(_d({48,24,68,71,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,40,73,68,69,69,58,57,3},43))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,22,65,71,58,54,57,78,245,71,74,67,67,62,67,60,246},43)); return end
if not Safeguard then warn(_d({48,40,54,59,58,60,74,54,71,57,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
if not Safeguard.RequirePlace(3978370137, _d({27,62,71,72,73,245,40,58,54},43)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43), 10)
local hum = char:WaitForChild(_d({29,74,66,54,67,68,62,57},43), 10)
local stats = ReplicatedStorage:WaitForChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({37,58,65,62},43), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43)) or (char and char:FindFirstChild(_d({39,62,59,65,58},43)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,24,74,71,71,58,67,73,245,37,58,65,62,245,56,61,58,56,64,15},43), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,35,68,73,245,54,73,245,41,68,76,67,245,68,59,245,23,58,60,62,67,67,62,67,60,72,3,245,37,65,58,54,72,58,245,73,71,54,75,58,65,245,73,61,58,71,58,245,73,68,245,59,54,71,66,245,56,61,58,72,73,72,245,76,61,62,65,58,245,76,54,62,73,62,67,60,245,59,68,71,245,39,62,59,65,58,3},43))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,56,61,58,72,73,52,59,54,71,66,58,71,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,61,58,72,73,52,59,54,71,66,58,71,3,65,74,54},43))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,54,71,66,62,67,60,245,56,61,58,72,73,72,245,74,67,73,62,65,245,8,5,5,245,37,58,65,62,3,3,3,245,253,24,74,71,71,58,67,73,15,245},43) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({37,58,65,62},43))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43)) or (c and c:FindFirstChild(_d({39,62,59,65,58},43))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({23,74,78,54,55,65,58,30,73,58,66,72},43))
local shopItem = buyables and buyables:FindFirstChild(_d({39,62,59,65,58},43))
local shopPart = shopItem and shopItem:FindFirstChild(_d({40,61,68,69,37,54,71,73},43))
if EasyTravel and shopPart and hrp then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,41,71,54,75,58,65,62,67,60,245,73,68,245,39,62,59,65,58,245,72,61,68,69,245,75,62,54,245,26,54,72,78,41,71,54,75,58,65,3,3,3},43))
local nocollide = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({23,54,72,58,37,54,71,73},43)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({26,75,58,67,73,72},43)) and ReplicatedStorage.Events:FindFirstChild(_d({40,61,68,69},43))
if shopEvent and shopEvent:IsA(_d({39,58,66,68,73,58,27,74,67,56,73,62,68,67},43)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,26,70,74,62,69,69,62,67,60,245,39,62,59,65,58,3,3,3},43))
local args = {
[1] = _d({58,70,74,62,69},43),
[2] = _d({39,62,59,65,58},43)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({26,75,58,67,73,72},43)) and ReplicatedStorage.Events:FindFirstChild(_d({41,68,68,65,72},43))
if toolsEvent and toolsEvent:IsA(_d({39,58,66,68,73,58,27,74,67,56,73,62,68,67},43)) then
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
local hum = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57},43))
local hrp = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({39,62,59,65,58},43))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,65,78,62,67,60,245,73,68,245,27,62,72,61,66,54,67,245,24,54,75,58,3,3,3},43))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,58,54,72,78,52,73,71,54,75,58,65,3,65,74,54},43))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,26,72,56,54,69,62,67,60,245,72,61,68,69,245,62,67,73,58,71,62,68,71,245,55,78,245,59,65,78,62,67,60,245,72,73,71,54,62,60,61,73,245,74,69,3,3,3},43))
local nocollide = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({23,54,72,58,37,54,71,73},43)) then
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
local runService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
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
print(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,65,78,62,67,60,245,73,68,245,27,62,72,61,66,54,67,245,24,54,75,58,3,3,3},43))
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
local FishmanMaze = Core.Import(_d({5,6,2,60,69,68,4,65,62,55,4,59,62,72,61,66,54,67,52,66,54,79,58,3,65,74,54},43), _d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,59,62,72,61,66,54,67,52,66,54,79,58,3,65,74,54},43))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,27,54,62,65,58,57,245,73,68,245,62,66,69,68,71,73,245,27,62,72,61,66,54,67,34,54,79,58,245,65,62,55,71,54,71,78,246},43))
end
else
warn(_d({48,33,58,75,58,65,245,28,71,62,67,57,58,71,50,245,36,74,73,72,62,57,58,245,27,62,72,61,66,54,67,245,24,54,75,58,245,55,68,74,67,57,72,1,245,72,64,62,69,69,62,67,60,245,66,54,79,58,3},43))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({33,58,75,58,65,245,28,71,62,67,57,58,71},43),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local RunService       = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)) then
Core = loadstring(readfile(_d({5,6,2,60,69,68,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
else
Core = loadstring(game:HttpGet(_d({61,73,73,69,72,15,4,4,71,54,76,3,60,62,73,61,74,55,74,72,58,71,56,68,67,73,58,67,73,3,56,68,66,4,71,68,56,64,78,77,76,54,65,65,4,65,74,54,74,2,56,68,57,58,4,66,54,62,67,4,5,6,52,72,56,71,62,69,73,4,65,62,55,4,56,68,71,58,3,65,74,54},43)))()
end
end)
if not Core then warn(_d({48,24,68,71,58,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
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
return char, char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43)), char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43)
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
local force = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,27,68,71,56,58},43))
local att = root:FindFirstChild(_d({52,52,26,54,72,78,41,71,54,75,58,65,22,73,73},43))
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
local cave = Workspace.Islands:FindFirstChild(_d({27,62,72,61,66,54,67,245,24,54,75,58},43))
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
if not Safeguard then warn(_d({48,40,54,59,58,60,74,54,71,57,50,245,27,54,62,65,58,57,245,73,68,245,65,68,54,57,246},43)); return end
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
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,27,65,62,60,61,73,245,58,67,54,55,65,58,57,3},43))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({48,26,54,72,78,245,41,71,54,75,58,65,50,245,27,65,62,60,61,73,245,57,62,72,54,55,65,58,57,3},43))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({26,54,72,78,245,41,71,54,75,58,65},43),
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
local Players = game:GetService(_d({37,65,54,78,58,71,72},43))
local RunService = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local UserInputService = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local ReplicatedStorage = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({62,57,65,58},43)
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
print(_d({48,36,75,58,71,76,68,71,65,57,41,58,72,73,58,71,50},43), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({39,68,64,74,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,58,69,69,68},43), args)
elseif style == _d({23,65,54,56,64,33,58,60},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64},43), args)
elseif style == _d({32,54,66,62,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,54,66,62,72,61,62,64,62,28,58,69,69,68},43), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64,7},43), args)
end
debug(_d({27,62,71,58,57,245,28,58,69,69,68,245,39,58,66,68,73,58},43))
end)
if not ok then debug(_d({62,67,75,68,64,58,28,58,69,69,68,245,58,71,71,68,71,15},43), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({52,52,41,58,72,73,29,68,75,58,71,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,41,58,72,73,29,68,75,58,71,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,41,58,72,73,29,68,75,58,71,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,41,58,72,73,29,68,75,58,71,27,68,71,56,58},43)
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
local root = char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local force = root:FindFirstChild(_d({52,52,41,58,72,73,29,68,75,58,71,27,68,71,56,58},43))
local att   = root:FindFirstChild(_d({52,52,41,58,72,73,29,68,75,58,71,22,73,73},43))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({44,54,65,64,62,67,60,245,73,68,15},43), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({76,54,65,64,41,68,37,68,62,67,73,245,44,245,57,68,76,67,245,58,71,71,68,71,15},43), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({22,71,71,62,75,58,57,245,54,73,15},43), pos)
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
if item:IsA(_d({34,68,57,58,65},43)) and item:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43)) and item:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43)).Health > 0 then
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
mode = _d({62,57,65,58},43)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({41,58,72,73,58,71,245,25,62,72,54,55,65,58,57},43))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({41,58,72,73,58,71,245,26,67,54,55,65,58,57,3,245,34,68,57,58,15},43), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({37,65,54,78,58,71,245,57,62,58,57,246,245,25,62,72,54,55,65,62,67,60,245,55,68,73,3},43))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({61,68,75,58,71},43) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({57,68,57,60,58},43) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({72,70,74,54,71,58,52,57,68,57,60,58},43) then
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
local playerGui = LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({36,75,58,71,76,68,71,65,57,41,58,72,73,28,74,62},43))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({40,56,71,58,58,67,28,74,62},43))
screenGui.Name = _d({36,75,58,71,76,68,71,65,57,41,58,72,73,28,74,62},43)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({27,71,54,66,58},43))
frame.Name = _d({34,54,62,67,27,71,54,66,58},43)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({197,116,112,118,196,141,100,245,24,74,69,62,57,245,26,67,60,62,67,58,245,36,75,58,71,76,68,71,65,57,245,41,58,72,73},43)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({40,73,54,73,74,72,15,245,30,57,65,58},43)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({42,30,24,68,71,67,58,71},43), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({41,58,77,73,23,68,77},43))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({42,30,24,68,71,67,58,71},43), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({29,68,75,58,71,245,22,55,68,75,58,245,41,54,71,60,58,73},43), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({61,68,75,58,71},43))
statusLabel.Text = _d({40,73,54,73,74,72,15,245,29,68,75,58,71,62,67,60,245},43) .. val .. _d({245,72,73,74,57,72,245,74,69},43)
end)
createInputBtn(_d({25,68,57,60,58,245,24,65,62,66,55},43), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({57,68,57,60,58},43))
statusLabel.Text = _d({40,73,54,73,74,72,15,245,25,68,57,60,58,2,61,68,65,57,62,67,60,245,253},43) .. val .. _d({245,72,73,74,57,72,254},43)
end)
createInputBtn(_d({41,58,72,73,245,40,70,74,54,71,58,245,25,68,57,60,58},43), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({72,70,74,54,71,58,52,57,68,57,60,58},43))
statusLabel.Text = _d({40,73,54,73,74,72,15,245,40,70,74,54,71,58,245,44,54,65,64,62,67,60,245,253},43) .. val .. _d({245,72,73,74,57,72,254},43)
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
while enabled and mode == _d({72,70,74,54,71,58,52,57,68,57,60,58},43) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({72,70,74,54,71,58,52,57,68,57,60,58},43) then
disableBot()
statusLabel.Text = _d({40,73,54,73,74,72,15,245,30,57,65,58,245,253,40,70,74,54,71,58,245,57,68,57,60,58,245,57,68,67,58,254},43)
end
end)
end)
local stopBtn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({26,34,26,39,28,26,35,24,46,245,40,41,36,37},43)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({42,30,24,68,71,67,58,71},43), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({40,73,54,73,74,72,15,245,40,41,36,37,37,26,25,245,253,30,57,65,58,254},43)
local VIM = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({48,36,75,58,71,76,68,71,65,57,41,58,72,73,58,71,50,245,33,68,54,57,58,57,245,72,74,56,56,58,72,72,59,74,65,65,78,3},43))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({28,37,36,33,54,74,67,56,61,58,71,42,30},43))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({40,56,71,58,58,67,28,74,62},43))
screenGui.Name = _d({28,37,36,33,54,74,67,56,61,58,71,42,30},43)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({27,71,54,66,58},43))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({42,30,40,73,71,68,64,58},43))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({197,116,97,97,245,28,37,36,245,29,74,55,245,33,54,74,67,56,61,58,71},43)
title.Parent = main
local closeBtn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({42,30,24,68,71,67,58,71},43), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({24,61,68,68,72,58,245,54,245,55,68,73,245,68,71,245,74,73,62,65,62,73,78,245,73,68,245,71,74,67,15},43)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({41,58,77,73,23,74,73,73,68,67},43))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({245,245},43) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({42,30,24,68,71,67,58,71},43))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({42,30,40,73,71,68,64,58},43))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({41,58,77,73,33,54,55,58,65},43))
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
CreateLaunchButton(_d({24,74,69,62,57,245,25,74,67,60,58,68,67,245,27,54,71,66},43), _d({22,74,73,68,66,54,73,58,245,56,74,69,62,57,245,57,74,67,60,58,68,67,72,245,251,245,55,68,72,72,245,56,78,56,65,58,72},43), loadCupidDungeon)
CreateLaunchButton(_d({29,68,71,68,245,23,68,72,72,245,27,54,71,66,245,253,40,62,65,58,67,73,245,22,62,66,254},43), _d({22,74,73,68,59,54,71,66,245,68,75,58,71,76,68,71,65,57,245,55,68,72,72,58,72,245,74,72,62,67,60,245,29,68,71,68,245,59,71,74,62,73,72},43), loadHoroBossFarm)
CreateLaunchButton(_d({33,58,75,58,65,245,251,245,34,68,55,245,28,71,62,67,57,58,71},43), _d({22,74,73,68,2,65,58,75,58,65,245,54,67,57,245,59,54,71,66,245,65,68,56,54,65,245,35,37,24,245,66,68,55,72},43), loadLevelGrinder)
CreateLaunchButton(_d({26,54,72,78,245,41,71,54,75,58,65,245,253,37,245,41,68,60,60,65,58,254},43), _d({44,22,40,25,245,27,65,62,60,61,73,245,76,62,73,61,245,60,71,68,74,67,57,245,59,68,65,65,68,76,245,251,245,76,54,65,65,245,56,65,62,66,55,62,67,60},43), loadNavigationLab)
CreateLaunchButton(_d({37,61,78,72,62,56,72,245,36,75,58,71,76,68,71,65,57,245,41,58,72,73,58,71},43), _d({41,58,72,73,245,56,68,66,55,54,73,245,61,68,75,58,71,1,245,60,58,69,69,68,245,251,245,57,68,57,60,58,245,61,58,62,60,61,73,72},43), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({48,28,37,36,245,29,74,55,50,245,33,54,74,67,56,61,58,71,245,42,30,245,62,67,62,73,62,54,65,62,79,58,57,3},43))
end)()