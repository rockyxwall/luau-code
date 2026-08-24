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
local Players            = game:GetService(_d({39,67,56,80,60,73,74},41))
local UserInputService    = game:GetService(_d({44,74,60,73,32,69,71,76,75,42,60,73,77,64,58,60},41))
local RunService          = game:GetService(_d({41,76,69,42,60,73,77,64,58,60},41))
local VIM                 = game:GetService(_d({45,64,73,75,76,56,67,32,69,71,76,75,36,56,69,56,62,60,73},41))
local ReplicatedStorage    = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({7,8,4,62,71,70,6,67,64,57,6,58,70,73,60,5,67,76,56},41)) then
Core = loadstring(readfile(_d({7,8,4,62,71,70,6,67,64,57,6,58,70,73,60,5,67,76,56},41)))()
else
Core = loadstring(game:HttpGet(_d({63,75,75,71,74,17,6,6,73,56,78,5,62,64,75,63,76,57,76,74,60,73,58,70,69,75,60,69,75,5,58,70,68,6,73,70,58,66,80,79,78,56,67,67,6,67,76,56,76,4,58,70,59,60,6,68,56,64,69,6,7,8,54,74,58,73,64,71,75,6,67,64,57,6,58,70,73,60,5,67,76,56},41)))()
end
end)
if not Core then warn(_d({50,26,70,73,60,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,248},41)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,12,9,11,11,8,11,8,10,9,14},41)
local LEO_ENTEI_ANIM_ID    = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,12,9,11,11,8,10,15,9,14,15},41)
local LEO_HIKEN_ANIM_ID    = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,12,9,9,7,16,8,14,11,7,14},41)
local LEO_FIREFLY_ANIM_ID  = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,12,9,9,7,9,10,13,8,12,11},41)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({38,57,65,60,58,75,64,77,60,74},41)
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
local REPLAY_BUTTON_VALUE   = _d({41,60,71,67,56,80},41)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({68,70,77,60},41)
local NavState   = {mode = _d({64,59,67,60},41)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({50,25,70,74,74,25,70,75,52},41), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
end)
if ok then return root end
debug(_d({62,60,75,41,70,70,75,247,60,73,73,70,73,17},41), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
end)
if ok then return hum end
debug(_d({62,60,75,31,76,68,56,69,70,64,59,247,60,73,73,70,73,17},41), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({54,54,31,70,77,60,73,24,75,75},41)) or Instance.new(_d({24,75,75,56,58,63,68,60,69,75},41))
att.Name = _d({54,54,31,70,77,60,73,24,75,75},41)
att.Parent = root
local force = root:FindFirstChild(_d({54,54,31,70,77,60,73,29,70,73,58,60},41))
if not force then
force = Instance.new(_d({35,64,69,60,56,73,45,60,67,70,58,64,75,80},41))
force.Name = _d({54,54,31,70,77,60,73,29,70,73,58,60},41)
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
debug(_d({62,60,75,38,73,26,73,60,56,75,60,29,70,73,58,60,247,60,73,73,70,73,17},41), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not root then return end
local force = root:FindFirstChild(_d({54,54,31,70,77,60,73,29,70,73,58,60},41))
local att   = root:FindFirstChild(_d({54,54,31,70,77,60,73,24,75,75},41))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({58,67,60,56,69,76,71,29,70,73,58,60,247,60,73,73,70,73,17},41), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({25,76,74,70,36,60,67,60,60},41)) ~= nil
end)
if ok then return result end
debug(_d({64,74,25,76,74,70,24,58,75,64,77,60,247,60,73,73,70,73,17},41), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({25,76,74,70},41))
end)
if not ok then debug(_d({56,58,75,64,77,56,75,60,25,76,74,70,247,60,73,73,70,73,17},41), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({25,76,74,70,247,69,70,75,247,56,58,75,64,77,60,3,247,56,58,75,64,77,56,75,64,69,62},41))
activateBuso()
end
end)
if not ok then debug(_d({25,76,74,70,34,60,60,71,60,73,247,60,73,73,70,73,17},41), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({25,76,74,70,247,66,60,60,71,60,73,247,74,75,70,71,71,60,59},41))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({34,60,69,31,56,66,64},41)) ~= nil
end)
if ok then return result end
debug(_d({64,74,34,60,69,24,58,75,64,77,60,247,60,73,73,70,73,17},41), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({34,60,69},41), true)
end)
if not ok then debug(_d({56,58,75,64,77,56,75,60,34,60,69,247,60,73,73,70,73,17},41), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({34,60,69,247,69,70,75,247,56,58,75,64,77,60,3,247,56,58,75,64,77,56,75,64,69,62},41))
activateKen()
end
end)
if not ok then debug(_d({34,60,69,34,60,60,71,60,73,247,60,73,73,70,73,17},41), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({34,60,69,247,66,60,60,71,60,73,247,74,75,70,71,71,60,59},41))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({37,39,26,74},41)) end)
if ok then return folder end
debug(_d({62,60,75,37,39,26,74,29,70,67,59,60,73,247,60,73,73,70,73,17},41), folder)
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
local r = model:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local h = model:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
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
debug(_d({62,60,75,37,60,56,73,60,74,75,37,39,26,247,60,73,73,70,73,17},41), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
local hum  = model:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({62,60,75,37,39,26,25,80,37,56,68,60,247,60,73,73,70,73,17},41), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({69,71,58,74,41,60,68,56,64,69,64,69,62,247,60,73,73,70,73,17},41), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({26,76,71,64,59,247,40,76,60,60,69},41))
return queen ~= nil and queen:FindFirstChild(_d({68,70,75,64,70,69,35,60,74,74},41)) ~= nil
end)
if ok then return result end
debug(_d({64,74,40,76,60,60,69,39,63,56,74,60,9,247,60,73,73,70,73,17},41), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,8,9,8,9,16,14,16,11,9,9,16,9,14,13,16},41)
local QUEEN_GRASP_ANIM_ID   = _d({73,57,79,56,74,74,60,75,64,59,17,6,6,8,9,16,15,7,7,7,13,8,7,7,8,14,10,11},41)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
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
debug(_d({64,74,39,67,56,80,64,69,62,24,69,64,68,29,73,70,68,35,64,74,75,247,60,73,73,70,73,17},41), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({25,67,70,58,66,64,69,62},41)) ~= nil
end)
if ok then return result end
debug(_d({64,74,37,39,26,25,67,70,58,66,64,69,62,247,60,73,73,70,73,17},41), result)
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
debug(_d({71,73,60,59,64,58,75,37,39,26,39,70,74,64,75,64,70,69,247,60,73,73,70,73,17},41), result)
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
debug(_d({37,70,247,59,56,68,56,62,60,247,70,69},41), model.Name, _d({61,70,73},41), NPC_STUCK_TIMEOUT, _d({74,247,4,247,74,78,64,75,58,63,64,69,62,247,75,56,73,62,60,75},41))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({75,73,56,58,66,37,39,26,27,56,68,56,62,60,247,60,73,73,70,73,17},41), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({36,70,59,60,67},41)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({25,56,74,60,39,56,73,75},41)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({62,60,75,36,70,59,60,67,29,56,58,60,39,70,74,247,60,73,73,70,73,17},41), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({28,69,77},41))
local folder = env and env:FindFirstChild(_d({42,75,56,75,76,60,74},41))
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
debug(_d({62,60,75,42,75,56,75,76,60,36,70,59,60,67,37,60,56,73,247,60,73,73,70,73,17},41), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({57,56,73,73,60,67,31,39},41))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({62,60,75,42,75,56,75,76,60,31,39,247,60,73,73,70,73,17},41), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({61,64,69,59,43,70,70,67,25,80,24,75,75,73,64,57,76,75,60,247,60,73,73,70,73,17},41), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({43,70,70,67},41)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({61,64,69,59,43,70,70,67,25,80,37,56,68,60,247,60,73,73,70,73,17},41), tool)
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
if not ok then debug(_d({60,72,76,64,71,43,70,70,67,247,60,73,73,70,73,17},41), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({25,56,58,66,71,56,58,66},41))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({43,70,70,67},41)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({61,64,69,59,43,70,70,67,25,80,26,63,64,67,59,37,56,68,60,247,60,73,73,70,73,17},41), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({42,78,70,73,59,28,72,76,64,71},41))
if sword then
equipTool(sword)
return _d({74,78,70,73,59},41)
end
local melee = findToolByAttribute(_d({36,60,67,60,60,43,70,70,67},41))
if melee then
equipTool(melee)
return _d({68,60,67,60,60},41)
end
debug(_d({37,70,247,74,78,70,73,59,247,70,73,247,68,60,67,60,60,247,75,70,70,67,247,61,70,76,69,59},41))
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
if not ok then debug(_d({58,67,64,58,66,36,8,247,60,73,73,70,73,17},41), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({31,76,68,56,69,70,64,59,41,70,70,75,39,56,73,75},41))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({42,75,56,75,74},41) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({41,70,66,76,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({30,60,71,71,70},41), args)
elseif style == _d({25,67,56,58,66,35,60,62},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66},41), args)
elseif style == _d({34,56,68,64,74,63,64,66,64},41) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,56,68,64,74,63,64,66,64,30,60,71,71,70},41), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,66,80,247,46,56,67,66,9},41), args)
end
end)
if not ok then debug(_d({64,69,77,70,66,60,30,60,71,71,70,247,60,73,73,70,73,17},41), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({71,73,60,74,74,42,66,64,67,67,41,247,60,73,73,70,73,17},41), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({63,70,67,59,25,67,70,58,66,247,60,73,73,70,73,17},41), err) end
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
if not ok then debug(_d({63,70,67,59,25,67,70,58,66,46,63,64,67,60,247,60,73,73,70,73,17},41), err) end
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
debug(_d({62,60,75,30,56,68,60,30,247,60,73,73,70,73,17},41), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({64,74,41,60,56,67,36,8,25,76,74,80,247,60,73,73,70,73,17},41), result)
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
return char ~= nil and char:FindFirstChild(_d({74,75,76,69},41)) ~= nil
end)
if ok then return result end
debug(_d({64,74,42,75,76,69,69,60,59,247,60,73,73,70,73,17},41), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({71,73,60,74,74,42,75,76,69,25,73,60,56,66,247,60,73,73,70,73,17},41), err) end
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
debug(_d({72,76,60,60,69,27,70,59,62,60,44,69,75,64,67,42,56,61,60,17,247,40,76,60,60,69,247,62,70,69,60,247,4,247,60,69,59,64,69,62,247,59,70,59,62,60,247,60,56,73,67,80},41))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({72,76,60,60,69,27,70,59,62,60,44,69,75,64,67,42,56,61,60,247,74,56,61,60,75,80,247,75,64,68,60,70,76,75},41))
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
local info = getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({40,76,60,60,69,247,58,56,74,75,64,69,62,247,59,60,75,60,58,75,60,59,247,4,247,59,70,59,62,64,69,62,247,255,78,56,75,58,63,60,73,0},41))
queenDodgeUntilSafe(function() return getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41)) end)
if enabled and getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41)) then
setNavNamed(_d({26,76,71,64,59,247,40,76,60,60,69},41))
end
queenDodging = false
end
end)
if not ok then debug(_d({72,76,60,60,69,27,70,59,62,60,46,56,75,58,63,60,73,247,60,73,73,70,73,17},41), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({71,70,64,69,75},41) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({69,71,58},41) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({69,56,68,60,59},41) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({62,60,75,37,56,77,43,56,73,62,60,75,74,247,60,73,73,70,73,17},41), aimR)
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
debug(_d({58,70,68,71,76,75,60,35,70,58,66,60,59,26,29,73,56,68,60,247,60,73,73,70,73,17},41), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({71,70,64,69,75},41), point = pos}
phase = _d({68,70,77,60},41)
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
if not ok then debug(_d({69,56,77,43,70,39,70,64,69,75,247,62,60,71,71,70,247,58,63,60,58,66,247,60,73,73,70,73,17},41), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({69,71,58},41)}
phase = _d({68,70,77,60},41)
end
function setNavNamed(name)
NavState = {mode = _d({69,56,68,60,59},41), name = name}
phase = _d({68,70,77,60},41)
end
local function setNavIdle()
NavState = {mode = _d({64,59,67,60},41)}
phase = _d({68,70,77,60},41)
end
local function hasArrived()
return phase == _d({63,70,77,60,73},41)
end
local function startNav()
phase = _d({68,70,77,60},41)
debug(_d({37,56,77,247,67,70,70,71,247,38,37},41))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({39,67,56,80,60,73,247,59,64,60,59,248,247,42,75,70,71,71,64,69,62,247,57,70,75,5},41))
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
debug(_d({39,67,56,80,60,73,247,64,74,247,75,70,70,247,61,56,73,247,61,73,70,68,247,75,56,73,62,60,75,247,255,21,9,7,7,7,247,74,75,76,59,74,0,5,247,35,64,66,60,67,80,247,73,60,74,71,56,78,69,60,59,247,56,75,247,67,70,57,57,80,5,247,42,75,70,71,71,64,69,62,247,57,70,75,5},41))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({54,54,71,73,60,77,39,70,74},41))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({35,56,73,62,60,247,71,70,74,64,75,64,70,69,247,65,76,68,71,247,59,60,75,60,58,75,60,59,17},41), delta, _d({74,75,76,59,74,5,247,71,73,60,77,39,70,74,20},41), prevPos, _d({69,60,78,39,70,74,20},41), pos)
end
end
force:SetAttribute(_d({54,54,71,73,60,77,39,70,74},41), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({68,70,77,60},41) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({63,70,77,60,73},41)
debug(_d({39,63,56,74,60,17,247,63,70,77,60,73},41))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({248,248,248,247,41,28,29,44,42,32,37,30,247,43,38,247,24,39,39,35,48,247,24,25,37,38,41,36,24,35,247,45,28,35,38,26,32,43,48,17},41), finalVel, _d({56,64,68,20},41), aim, _d({71,70,74,20},41), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({63,70,77,60,73},41) then
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
debug(_d({26,70,68,57,56,75,247,67,70,58,66,247,74,66,64,71,71,60,59,3},41), snapDist, _d({74,75,76,59,74,247,61,73,70,68,247,75,56,73,62,60,75,247,185,87,107,247,61,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,68,70,77,60},41))
phase = _d({68,70,77,60},41)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({31,60,56,73,75,57,60,56,75,247,60,73,73,70,73,17},41), err) end
end)
end
local function stopNav()
debug(_d({37,56,77,247,67,70,70,71,247,38,29,29},41))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({68,70,77,60},41)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({43,60,79,75,26,63,56,75,42,60,73,77,64,58,60},41))
local channels = TextChatService:FindFirstChild(_d({43,60,79,75,26,63,56,69,69,60,67,74},41))
local channel = channels and channels:FindFirstChild(_d({41,25,47,30,60,69,60,73,56,67},41))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({27,60,61,56,76,67,75,26,63,56,75,42,80,74,75,60,68,26,63,56,75,28,77,60,69,75,74},41))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({42,56,80,36,60,74,74,56,62,60,41,60,72,76,60,74,75},41))
if sayEvent then
sayEvent:FireServer(message, _d({24,67,67},41))
return
end
debug(_d({74,60,69,59,26,63,56,75,36,60,74,74,56,62,60,17,247,69,70,247,43,60,79,75,26,63,56,75,42,60,73,77,64,58,60,5,41,25,47,30,60,69,60,73,56,67,247,70,73,247,67,60,62,56,58,80,247,42,56,80,36,60,74,74,56,62,60,41,60,72,76,60,74,75,247,61,70,76,69,59,247,61,70,73},41), message)
end)
if not ok then debug(_d({74,60,69,59,26,63,56,75,36,60,74,74,56,62,60,247,60,73,73,70,73,17},41), err) end
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
debug(_d({37,70,75,247,68,56,66,64,69,62,247,71,73,70,62,73,60,74,74,247,75,70,78,56,73,59,247,69,56,77,247,75,56,73,62,60,75,247,61,70,73},41), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({74,247,4,247,74,60,69,59,64,69,62,247,6,76,69,74,75,76,58,66},41))
sendChatMessage(_d({6,76,69,74,75,76,58,66},41))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({78,56,64,75,44,69,75,64,67,24,73,73,64,77,60,59,247,75,64,68,60,70,76,75},41))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({69,56,77,43,70,39,70,64,69,75,26,70,69,61,64,73,68,60,59,17},41), label or _d({75,56,73,62,60,75},41), _d({4,247,59,64,59,247,69,70,75,247,56,73,73,64,77,60,247,78,64,75,63,64,69},41), timeout, _d({74,3,247,73,60,75,73,80,64,69,62,247,70,69,58,60},41))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({69,56,77,43,70,39,70,64,69,75,26,70,69,61,64,73,68,60,59,17},41), label or _d({75,56,73,62,60,75},41), _d({4,247,74,75,64,67,67,247,69,70,75,247,56,73,73,64,77,60,59,247,56,61,75,60,73,247,73,60,75,73,80,3,247,71,73,70,58,60,60,59,64,69,62,247,56,69,80,78,56,80},41))
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
if not ok then debug(_d({69,56,77,43,70,39,70,64,69,75,31,70,67,59,64,69,62,25,67,70,58,66,247,66,60,80,4,59,70,78,69,247,60,73,73,70,73,17},41), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({69,56,77,43,70,39,70,64,69,75,31,70,67,59,64,69,62,25,67,70,58,66,247,66,60,80,4,76,71,247,60,73,73,70,73,17},41), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({46,56,67,66,64,69,62,247,75,70,17},41), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({78,56,67,66,43,70,39,70,64,69,75,247,46,247,59,70,78,69,247,60,73,73,70,73,17},41), err) end
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
debug(_d({43,70,70,66,247,59,56,68,56,62,60,247,78,63,64,67,60,247,78,56,67,66,64,69,62,247,75,70,247,71,70,64,69,75,248,247,42,75,70,71,71,64,69,62,247,78,56,67,66,247,75,70,247,60,69,62,56,62,60,5},41))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({24,73,73,64,77,60,59,247,56,75,17},41), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({42,75,76,58,66,247,59,76,73,64,69,62,247,78,56,67,66,3,247,65,76,68,71,64,69,62,248},41))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({42,75,64,67,67,247,74,75,76,58,66,3,247,75,73,64,62,62,60,73,64,69,62,247,30,60,71,71,70,248},41))
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
debug(_d({36,70,77,64,69,62,247,75,70},41), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({46,56,64,75,64,69,62,247,61,70,73,247,37,39,26,74,247,75,70,247,74,71,56,78,69,247,56,75},41), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({247,247,74,71,56,78,69,247,58,63,60,58,66,17,247,61,70,67,59,60,73,247,60,79,64,74,75,74,247,20},41), folder ~= nil,
_d({3,247,58,63,64,67,59,73,60,69,247,20},41), folder and #folder:GetChildren() or 0,
_d({3,247,56,67,64,77,60,247,20},41), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({37,70,247,37,39,26,74,247,56,71,71,60,56,73,60,59,247,56,75},41), stageName, _d({56,61,75,60,73,247,8,12,74,3,247,68,70,77,64,69,62,247,70,69,247,56,69,80,78,56,80},41))
break
end
end
debug(_d({34,64,67,67,64,69,62,247,37,39,26,74,247,56,75},41), stageName)
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
debug(_d({41,60,75,76,73,69,64,69,62,247,75,70},41), stageName, _d({71,70,74,64,75,64,70,69,247,57,60,61,70,73,60,247,68,70,77,64,69,62,247,70,69},41))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({46,56,64,75,64,69,62,247,12,74,247,56,75},41), stageName, _d({71,70,74,64,75,64,70,69},41))
task.wait(5)
debug(_d({46,56,64,75,64,69,62,247,61,70,73},41), targetHP * 100, _d({252,247,31,39,247,57,60,61,70,73,60,247,68,70,77,64,69,62,247,75,70,247,69,60,79,75,247,74,75,56,62,60},41))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({58,67,60,56,73,60,59},41))
end
local function killNamedNPC(name, targetPos)
debug(_d({36,70,77,64,69,62,247,75,70},41), name)
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
debug(name, _d({59,60,61,60,56,75,60,59},41))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({31,76,68,56,69,70,64,59},41))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({35,60,70,247,71,67,56,80,60,59,247,56,69,64,68,56,75,64,70,69,17},41), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({67,60,70,24,69,64,68,35,70,62,62,60,73,247,71,73,64,69,75,247,60,73,73,70,73,17},41), err2) end
end)
end)
if not ok then debug(_d({74,75,56,73,75,35,60,70,24,69,64,68,35,70,62,62,60,73,247,60,73,73,70,73,17},41), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({36,70,77,64,69,62,247,75,70,247,35,60,70},41))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({35,60,70},41))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({35,60,70},41))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({35,60,70},41))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({35,60,70,247,58,56,74,75,64,69,62},41), which, _d({4,247,59,70,59,62,64,69,62},41))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({35,60,70,247,74,75,56,73,75,60,59,247,57,67,70,58,66,4,57,73,60,56,66,60,73,247,68,64,59,4,57,67,70,58,66,248,247,28,77,56,59,64,69,62,5,5,5},41))
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
if not getNPCByName(_d({35,60,70},41)) then
debug(_d({35,60,70,247,62,70,69,60,247,68,64,59,4,59,70,59,62,60,247,4,247,60,69,59,64,69,62,247,28,69,75,60,64,247,63,70,67,59,247,60,56,73,67,80},41))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({35,60,70},41)) then
setNavNamed(_d({35,60,70},41))
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
debug(_d({35,60,70,247,59,60,61,60,56,75,60,59},41))
stopLeoAnimLogger()
debug(_d({41,60,75,76,73,69,64,69,62,247,75,70,247,35,60,70,247,71,70,74,64,75,64,70,69,247,57,60,61,70,73,60,247,68,70,77,64,69,62,247,70,69},41))
navToPointConfirmed(COORDS.Leo, 30, _d({35,60,70,247,71,70,74,64,75,64,70,69},41))
debug(_d({46,56,64,75,64,69,62,247,12,74,247,56,75,247,35,60,70,247,71,70,74,64,75,64,70,69},41))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({36,70,77,64,69,62,247,75,70},41), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({26,70,76,67,59,247,69,70,75,247,61,64,69,59,247,74,75,56,75,76,60,247,68,70,59,60,67,247,69,60,56,73},41), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({24,75,75,56,58,66,64,69,62},41), coordKey, _d({78,64,75,63},41), weapon or _d({69,70,75,63,64,69,62,247,61,70,76,69,59},41))
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
debug(coordKey, _d({57,56,73,73,60,67,247,59,60,74,75,73,70,80,60,59},41))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({73,60,58,63,60,58,66,42,75,56,75,76,60,17},41), coordKey, _d({4,247,58,70,76,67,59,247,69,70,75,247,61,64,69,59,247,74,75,56,75,76,60,247,68,70,59,60,67,3,247,74,66,64,71,71,64,69,62},41))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({73,60,58,63,60,58,66,42,75,56,75,76,60,17},41), coordKey, _d({74,75,64,67,67,247,56,67,64,77,60,247,255,31,39},41), hp, _d({0,247,4,247,73,60,4,59,60,74,75,73,70,80,64,69,62},41))
destroyStatue(coordKey)
else
debug(_d({73,60,58,63,60,58,66,42,75,56,75,76,60,17},41), coordKey, _d({58,70,69,61,64,73,68,60,59,247,59,60,74,75,73,70,80,60,59},41))
end
end)
if not ok then debug(_d({73,60,58,63,60,58,66,42,75,56,75,76,60,247,60,73,73,70,73,17},41), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({36,70,77,64,69,62,247,75,70,247,40,76,60,60,69},41))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({26,76,71,64,59,247,40,76,60,60,69},41))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41))
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
debug(_d({40,76,60,60,69,247,60,69,75,60,73,60,59,247,71,63,56,74,60,247,9},41))
end
local function finishQueen()
debug(_d({29,64,69,64,74,63,64,69,62,247,40,76,60,60,69},41))
equipSwordOrMelee()
setNavNamed(_d({26,76,71,64,59,247,40,76,60,60,69},41))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({26,76,71,64,59,247,40,76,60,60,69},41))
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
debug(_d({40,76,60,60,69,247,59,60,61,60,56,75,60,59,5,247,39,67,56,69,247,58,70,68,71,67,60,75,60,5},41))
end
local CONFIRMATION_PROMPT_NAME = _d({26,70,69,61,64,73,68,56,75,64,70,69,39,73,70,68,71,75},41)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({41,60,68,70,75,60,28,77,60,69,75},41), 5)
end)
if ok then return result end
debug(_d({62,60,75,41,60,71,67,56,80,41,60,68,70,75,60,247,60,73,73,70,73,17},41), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({39,67,56,80,60,73,30,76,64},41))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({32,68,56,62,60,25,76,75,75,70,69},41)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({57,76,75,75,70,69,45,56,67,76,60},41)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({61,64,69,59,25,76,75,75,70,69,25,80,45,56,67,76,60,247,60,73,73,70,73,17},41), result)
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
if not ok then debug(_d({58,67,64,58,66,30,76,64,25,76,75,75,70,69,247,60,73,73,70,73,17},41), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({64,74,42,60,73,77,60,73},41))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({41,60,68,70,75,60,28,77,60,69,75},41))
or inst:FindFirstChild(_d({58,67,64,60,69,75,28,77,60,69,75},41))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({61,64,69,59,24,69,74,78,60,73,26,70,69,69,60,58,75,70,73,247,60,73,73,70,73,17},41), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({26,70,76,67,59,247,69,70,75,247,67,70,58,56,75,60,247,41,60,68,70,75,60,28,77,60,69,75,6,58,67,64,60,69,75,28,77,60,69,75,247,69,60,56,73,247,41,60,71,67,56,80,247,57,76,75,75,70,69,3,247,61,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,58,67,64,58,66},41))
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
debug(_d({61,64,73,60,41,60,71,67,56,80,45,56,67,76,60,247,60,73,73,70,73,17},41), err, _d({4,247,61,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,58,67,64,58,66},41))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({29,56,67,67,64,69,62,247,57,56,58,66,247,75,70,247,57,76,75,75,70,69,45,56,67,76,60,247,74,60,56,73,58,63,247,61,70,73,247,41,60,71,67,56,80},41))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({41,60,71,67,56,80,247,57,76,75,75,70,69,247,69,70,75,247,61,70,76,69,59,247,60,64,75,63,60,73,3,247,62,64,77,64,69,62,247,76,71},41))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({46,56,64,75,64,69,62,247,61,70,73,247,26,70,69,61,64,73,68,56,75,64,70,69,39,73,70,68,71,75,5,41,60,68,70,75,60,28,77,60,69,75},41))
local remote = getReplayRemote()
if not remote then
debug(_d({26,70,69,61,64,73,68,56,75,64,70,69,39,73,70,68,71,75,6,41,60,68,70,75,60,28,77,60,69,75,247,69,70,75,247,61,70,76,69,59,247,78,64,75,63,64,69,247,75,64,68,60,70,76,75},41))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({29,64,73,64,69,62,247,41,60,71,67,56,80,247,77,64,56,247,26,70,69,61,64,73,68,56,75,64,70,69,39,73,70,68,71,75,5,41,60,68,70,75,60,28,77,60,69,75},41))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({29,64,73,60,42,60,73,77,60,73,247,60,73,73,70,73,17},41), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({39,67,56,80,60,73,30,76,64},41), 10)
if not playerGui then
debug(_d({78,56,64,75,29,70,73,38,57,65,60,58,75,64,77,60,74,30,76,64,17,247,69,70,247,39,67,56,80,60,73,30,76,64,247,78,64,75,63,64,69,247,75,64,68,60,70,76,75,3,247,71,73,70,58,60,60,59,64,69,62,247,56,69,80,78,56,80},41))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({38,57,65,60,58,75,64,77,60,74,247,30,44,32,247,61,70,76,69,59,247,4,247,74,75,56,62,60,247,67,70,56,59,60,59},41))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({38,57,65,60,58,75,64,77,60,74,247,30,44,32,247,69,70,75,247,61,70,76,69,59,247,78,64,75,63,64,69,247,75,64,68,60,70,76,75,3,247,71,73,70,58,60,60,59,64,69,62,247,56,69,80,78,56,80},41))
return
end
end
end)
if not ok then debug(_d({78,56,64,75,29,70,73,38,57,65,60,58,75,64,77,60,74,30,76,64,247,60,73,73,70,73,17},41), err) end
end
local function runPlan()
debug(_d({39,67,56,69,247,74,75,56,73,75,60,59},41))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({42,75,56,73,75,64,69,62,247,69,56,77,247,67,70,70,71},41))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({71,70,74,247,7,5,9,74,247,24,29,43,28,41,247,74,75,56,73,75,37,56,77,17},41), rootAfter and rootAfter.Position)
end)
debug(_d({46,56,64,75,64,69,62,247,12,74,247,57,60,61,70,73,60,247,68,70,77,64,69,62,247,75,70,247,42,75,56,62,60,8},41))
task.wait(5)
for _, stage in ipairs({_d({42,75,56,62,60,8},41), _d({42,75,56,62,60,9},41), _d({42,75,56,62,60,10},41), _d({42,75,56,62,60,10,25},41)}) do
if not enabled then return end
local hpTarget = (stage == _d({42,75,56,62,60,10,25},41)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({36,70,77,64,69,62,247,75,70,247,56,73,73,70,78,247,61,67,80,4,59,70,78,69,247,56,73,60,56,247,255,26,76,71,64,59,247,41,56,64,69,0},41))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({27,70,59,62,64,69,62,247,56,73,73,70,78,247,73,56,64,69,247,64,69,247,56,247,74,72,76,56,73,60},41))
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
clearStage(_d({42,75,56,62,60,11},41))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({40,76,60,60,69,247,64,69,247,71,63,56,74,60,247,9,247,4,247,66,60,60,71,64,69,62,247,34,60,69,247,31,56,66,64,247,56,58,75,64,77,60,247,61,73,70,68,247,63,60,73,60,247,70,69},41))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({42,75,56,75,76,60,8},41))
if not enabled then return end
recheckStatue(_d({42,75,56,75,76,60,8},41))
destroyStatue(_d({42,75,56,75,76,60,9},41))
if not enabled then return end
recheckStatue(_d({42,75,56,75,76,60,8},41))
recheckStatue(_d({42,75,56,75,76,60,9},41))
destroyStatue(_d({42,75,56,75,76,60,10},41))
if not enabled then return end
recheckStatue(_d({42,75,56,75,76,60,10},41))
recheckStatue(_d({42,75,56,75,76,60,9},41))
recheckStatue(_d({42,75,56,75,76,60,8},41))
if not enabled then return end
debug(_d({46,56,64,75,64,69,62,247,61,70,73,247,71,63,56,74,60,247,9,247,75,70,247,60,69,59},41))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({39,63,56,74,60,247,9,247,60,69,59,247,78,56,64,75,247,75,64,68,60,70,76,75,3,247,71,73,70,58,60,60,59,64,69,62,247,56,69,80,78,56,80},41))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({36,70,77,64,69,62,247,57,56,58,66,247,75,70,247,40,76,60,60,69,247,74,75,56,62,60,247,71,70,74,64,75,64,70,69},41))
navToPointConfirmed(COORDS.Queen, 30, _d({40,76,60,60,69,247,74,75,56,62,60,247,71,70,74,64,75,64,70,69},41))
debug(_d({46,56,64,75,64,69,62,247,12,74,247,56,75,247,40,76,60,60,69,247,74,75,56,62,60,247,71,70,74,64,75,64,70,69},41))
task.wait(5)
if not enabled then return end
debug(_d({36,70,77,64,69,62,247,75,70,247,71,70,74,75,4,40,76,60,60,69,247,71,70,74,64,75,64,70,69},41))
navToPointConfirmed(COORDS.PostQueen, 30, _d({71,70,74,75,4,40,76,60,60,69,247,71,70,74,64,75,64,70,69},41))
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
debug(_d({28,69,56,57,67,64,69,62,3,247,71,70,74,247,25,28,29,38,41,28,247,71,67,56,69,17},41), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({39,67,56,69,247,60,73,73,70,73,17},41), err2) end
end)
debug(_d({28,69,56,57,67,60,59,17},41), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({28,69,56,57,67,60,59,17},41), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,29,56,64,67,60,59,247,75,70,247,67,70,56,59,248},41)); return end
if not Safeguard.RequirePlace(11424731604, _d({26,76,71,64,59,247,27,76,69,62,60,70,69},41)) then
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
_d({26,76,71,64,59,247,27,76,69,62,60,70,69},41),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)()