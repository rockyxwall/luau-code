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
local Players            = game:GetService(_d({47,75,64,88,68,81,82},33))
local UserInputService    = game:GetService(_d({52,82,68,81,40,77,79,84,83,50,68,81,85,72,66,68},33))
local RunService          = game:GetService(_d({49,84,77,50,68,81,85,72,66,68},33))
local VIM                 = game:GetService(_d({53,72,81,83,84,64,75,40,77,79,84,83,44,64,77,64,70,68,81},33))
local ReplicatedStorage    = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({58,33,78,82,82,33,78,83,60},33), _d({54,81,78,77,70,255,70,64,76,68,255,193,95,115,255,47,75,64,66,68,40,67,25},33), game.PlaceId, _d({52,77,72,85,68,81,82,68,40,67,25},33), game.GameId, _d({12,255,77,78,83,255,81,84,77,77,72,77,70},33))
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
local LEO_PILLAR_ANIM_ID   = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,20,17,19,19,16,19,16,18,17,22},33)
local LEO_ENTEI_ANIM_ID    = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,20,17,19,19,16,18,23,17,22,23},33)
local LEO_HIKEN_ANIM_ID    = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,20,17,17,15,24,16,22,19,15,22},33)
local LEO_FIREFLY_ANIM_ID  = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,20,17,17,15,17,18,21,16,20,19},33)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({46,65,73,68,66,83,72,85,68,82},33)
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
local REPLAY_BUTTON_VALUE   = _d({49,68,79,75,64,88},33)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({76,78,85,68},33)
local NavState   = {mode = _d({72,67,75,68},33)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({58,33,78,82,82,33,78,83,60},33), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end)
if ok then return root end
debug(_d({70,68,83,49,78,78,83,255,68,81,81,78,81,25},33), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
end)
if ok then return hum end
debug(_d({70,68,83,39,84,76,64,77,78,72,67,255,68,81,81,78,81,25},33), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({62,62,39,78,85,68,81,32,83,83},33)) or Instance.new(_d({32,83,83,64,66,71,76,68,77,83},33))
att.Name = _d({62,62,39,78,85,68,81,32,83,83},33)
att.Parent = root
local force = root:FindFirstChild(_d({62,62,39,78,85,68,81,37,78,81,66,68},33))
if not force then
force = Instance.new(_d({43,72,77,68,64,81,53,68,75,78,66,72,83,88},33))
force.Name = _d({62,62,39,78,85,68,81,37,78,81,66,68},33)
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
debug(_d({70,68,83,46,81,34,81,68,64,83,68,37,78,81,66,68,255,68,81,81,78,81,25},33), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not root then return end
local force = root:FindFirstChild(_d({62,62,39,78,85,68,81,37,78,81,66,68},33))
local att   = root:FindFirstChild(_d({62,62,39,78,85,68,81,32,83,83},33))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({66,75,68,64,77,84,79,37,78,81,66,68,255,68,81,81,78,81,25},33), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({33,84,82,78,44,68,75,68,68},33)) ~= nil
end)
if ok then return result end
debug(_d({72,82,33,84,82,78,32,66,83,72,85,68,255,68,81,81,78,81,25},33), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({33,84,82,78},33))
end)
if not ok then debug(_d({64,66,83,72,85,64,83,68,33,84,82,78,255,68,81,81,78,81,25},33), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({33,84,82,78,255,77,78,83,255,64,66,83,72,85,68,11,255,64,66,83,72,85,64,83,72,77,70},33))
activateBuso()
end
end)
if not ok then debug(_d({33,84,82,78,42,68,68,79,68,81,255,68,81,81,78,81,25},33), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({33,84,82,78,255,74,68,68,79,68,81,255,82,83,78,79,79,68,67},33))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({42,68,77,39,64,74,72},33)) ~= nil
end)
if ok then return result end
debug(_d({72,82,42,68,77,32,66,83,72,85,68,255,68,81,81,78,81,25},33), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({42,68,77},33), true)
end)
if not ok then debug(_d({64,66,83,72,85,64,83,68,42,68,77,255,68,81,81,78,81,25},33), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({42,68,77,255,77,78,83,255,64,66,83,72,85,68,11,255,64,66,83,72,85,64,83,72,77,70},33))
activateKen()
end
end)
if not ok then debug(_d({42,68,77,42,68,68,79,68,81,255,68,81,81,78,81,25},33), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({42,68,77,255,74,68,68,79,68,81,255,82,83,78,79,79,68,67},33))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({45,47,34,82},33)) end)
if ok then return folder end
debug(_d({70,68,83,45,47,34,82,37,78,75,67,68,81,255,68,81,81,78,81,25},33), folder)
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
local r = model:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local h = model:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
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
debug(_d({70,68,83,45,68,64,81,68,82,83,45,47,34,255,68,81,81,78,81,25},33), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
local hum  = model:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({70,68,83,45,47,34,33,88,45,64,76,68,255,68,81,81,78,81,25},33), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({77,79,66,82,49,68,76,64,72,77,72,77,70,255,68,81,81,78,81,25},33), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({34,84,79,72,67,255,48,84,68,68,77},33))
return queen ~= nil and queen:FindFirstChild(_d({76,78,83,72,78,77,43,68,82,82},33)) ~= nil
end)
if ok then return result end
debug(_d({72,82,48,84,68,68,77,47,71,64,82,68,17,255,68,81,81,78,81,25},33), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,16,17,16,17,24,22,24,19,17,17,24,17,22,21,24},33)
local QUEEN_GRASP_ANIM_ID   = _d({81,65,87,64,82,82,68,83,72,67,25,14,14,16,17,24,23,15,15,15,21,16,15,15,16,22,18,19},33)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
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
debug(_d({72,82,47,75,64,88,72,77,70,32,77,72,76,37,81,78,76,43,72,82,83,255,68,81,81,78,81,25},33), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({33,75,78,66,74,72,77,70},33)) ~= nil
end)
if ok then return result end
debug(_d({72,82,45,47,34,33,75,78,66,74,72,77,70,255,68,81,81,78,81,25},33), result)
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
debug(_d({79,81,68,67,72,66,83,45,47,34,47,78,82,72,83,72,78,77,255,68,81,81,78,81,25},33), result)
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
debug(_d({45,78,255,67,64,76,64,70,68,255,78,77},33), model.Name, _d({69,78,81},33), NPC_STUCK_TIMEOUT, _d({82,255,12,255,82,86,72,83,66,71,72,77,70,255,83,64,81,70,68,83},33))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({83,81,64,66,74,45,47,34,35,64,76,64,70,68,255,68,81,81,78,81,25},33), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({44,78,67,68,75},33)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({33,64,82,68,47,64,81,83},33)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({70,68,83,44,78,67,68,75,37,64,66,68,47,78,82,255,68,81,81,78,81,25},33), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({36,77,85},33))
local folder = env and env:FindFirstChild(_d({50,83,64,83,84,68,82},33))
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
debug(_d({70,68,83,50,83,64,83,84,68,44,78,67,68,75,45,68,64,81,255,68,81,81,78,81,25},33), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({65,64,81,81,68,75,39,47},33))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({70,68,83,50,83,64,83,84,68,39,47,255,68,81,81,78,81,25},33), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({51,78,78,75},33)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({69,72,77,67,51,78,78,75,33,88,32,83,83,81,72,65,84,83,68,255,68,81,81,78,81,25},33), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({51,78,78,75},33)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({69,72,77,67,51,78,78,75,33,88,45,64,76,68,255,68,81,81,78,81,25},33), tool)
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
if not ok then debug(_d({68,80,84,72,79,51,78,78,75,255,68,81,81,78,81,25},33), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({33,64,66,74,79,64,66,74},33))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({51,78,78,75},33)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({69,72,77,67,51,78,78,75,33,88,34,71,72,75,67,45,64,76,68,255,68,81,81,78,81,25},33), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({50,86,78,81,67,36,80,84,72,79},33))
if sword then
equipTool(sword)
return _d({82,86,78,81,67},33)
end
local melee = findToolByAttribute(_d({44,68,75,68,68,51,78,78,75},33))
if melee then
equipTool(melee)
return _d({76,68,75,68,68},33)
end
debug(_d({45,78,255,82,86,78,81,67,255,78,81,255,76,68,75,68,68,255,83,78,78,75,255,69,78,84,77,67},33))
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
if not ok then debug(_d({66,75,72,66,74,44,16,255,68,81,81,78,81,25},33), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({49,78,74,84,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,68,79,79,78},33), args)
elseif style == _d({33,75,64,66,74,43,68,70},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74},33), args)
elseif style == _d({42,64,76,72,82,71,72,74,72},33) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,64,76,72,82,71,72,74,72,38,68,79,79,78},33), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,74,88,255,54,64,75,74,17},33), args)
end
end)
if not ok then debug(_d({72,77,85,78,74,68,38,68,79,79,78,255,68,81,81,78,81,25},33), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({79,81,68,82,82,50,74,72,75,75,49,255,68,81,81,78,81,25},33), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({71,78,75,67,33,75,78,66,74,255,68,81,81,78,81,25},33), err) end
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
if not ok then debug(_d({71,78,75,67,33,75,78,66,74,54,71,72,75,68,255,68,81,81,78,81,25},33), err) end
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
debug(_d({70,68,83,38,64,76,68,38,255,68,81,81,78,81,25},33), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({72,82,49,68,64,75,44,16,33,84,82,88,255,68,81,81,78,81,25},33), result)
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
return char ~= nil and char:FindFirstChild(_d({82,83,84,77},33)) ~= nil
end)
if ok then return result end
debug(_d({72,82,50,83,84,77,77,68,67,255,68,81,81,78,81,25},33), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({79,81,68,82,82,50,83,84,77,33,81,68,64,74,255,68,81,81,78,81,25},33), err) end
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
debug(_d({80,84,68,68,77,35,78,67,70,68,52,77,83,72,75,50,64,69,68,25,255,48,84,68,68,77,255,70,78,77,68,255,12,255,68,77,67,72,77,70,255,67,78,67,70,68,255,68,64,81,75,88},33))
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
debug(_d({80,84,68,68,77,35,78,67,70,68,52,77,83,72,75,50,64,69,68,255,82,64,69,68,83,88,255,83,72,76,68,78,84,83},33))
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
local info = getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({48,84,68,68,77,255,66,64,82,83,72,77,70,255,67,68,83,68,66,83,68,67,255,12,255,67,78,67,70,72,77,70,255,7,86,64,83,66,71,68,81,8},33))
queenDodgeUntilSafe(function() return getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33)) end)
if enabled and getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33)) then
setNavNamed(_d({34,84,79,72,67,255,48,84,68,68,77},33))
end
queenDodging = false
end
end)
if not ok then debug(_d({80,84,68,68,77,35,78,67,70,68,54,64,83,66,71,68,81,255,68,81,81,78,81,25},33), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({79,78,72,77,83},33) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({77,79,66},33) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({77,64,76,68,67},33) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({70,68,83,45,64,85,51,64,81,70,68,83,82,255,68,81,81,78,81,25},33), aimR)
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
debug(_d({66,78,76,79,84,83,68,43,78,66,74,68,67,34,37,81,64,76,68,255,68,81,81,78,81,25},33), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({79,78,72,77,83},33), point = pos}
phase = _d({76,78,85,68},33)
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
if not ok then debug(_d({77,64,85,51,78,47,78,72,77,83,255,70,68,79,79,78,255,66,71,68,66,74,255,68,81,81,78,81,25},33), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({77,79,66},33)}
phase = _d({76,78,85,68},33)
end
function setNavNamed(name)
NavState = {mode = _d({77,64,76,68,67},33), name = name}
phase = _d({76,78,85,68},33)
end
local function setNavIdle()
NavState = {mode = _d({72,67,75,68},33)}
phase = _d({76,78,85,68},33)
end
local function hasArrived()
return phase == _d({71,78,85,68,81},33)
end
local function startNav()
phase = _d({76,78,85,68},33)
debug(_d({45,64,85,255,75,78,78,79,255,46,45},33))
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
local prevPos = force:GetAttribute(_d({62,62,79,81,68,85,47,78,82},33))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({43,64,81,70,68,255,79,78,82,72,83,72,78,77,255,73,84,76,79,255,67,68,83,68,66,83,68,67,25},33), delta, _d({82,83,84,67,82,13,255,79,81,68,85,47,78,82,28},33), prevPos, _d({77,68,86,47,78,82,28},33), pos)
end
end
force:SetAttribute(_d({62,62,79,81,68,85,47,78,82},33), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({76,78,85,68},33) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({71,78,85,68,81},33)
debug(_d({47,71,64,82,68,25,255,71,78,85,68,81},33))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({0,0,0,255,49,36,37,52,50,40,45,38,255,51,46,255,32,47,47,43,56,255,32,33,45,46,49,44,32,43,255,53,36,43,46,34,40,51,56,25},33), finalVel, _d({64,72,76,28},33), aim, _d({79,78,82,28},33), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({71,78,85,68,81},33) then
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
debug(_d({34,78,76,65,64,83,255,75,78,66,74,255,82,74,72,79,79,68,67,11},33), snapDist, _d({82,83,84,67,82,255,69,81,78,76,255,83,64,81,70,68,83,255,193,95,115,255,69,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,76,78,85,68},33))
phase = _d({76,78,85,68},33)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({39,68,64,81,83,65,68,64,83,255,68,81,81,78,81,25},33), err) end
end)
end
local function stopNav()
debug(_d({45,64,85,255,75,78,78,79,255,46,37,37},33))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({76,78,85,68},33)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({51,68,87,83,34,71,64,83,50,68,81,85,72,66,68},33))
local channels = TextChatService:FindFirstChild(_d({51,68,87,83,34,71,64,77,77,68,75,82},33))
local channel = channels and channels:FindFirstChild(_d({49,33,55,38,68,77,68,81,64,75},33))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({35,68,69,64,84,75,83,34,71,64,83,50,88,82,83,68,76,34,71,64,83,36,85,68,77,83,82},33))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({50,64,88,44,68,82,82,64,70,68,49,68,80,84,68,82,83},33))
if sayEvent then
sayEvent:FireServer(message, _d({32,75,75},33))
return
end
debug(_d({82,68,77,67,34,71,64,83,44,68,82,82,64,70,68,25,255,77,78,255,51,68,87,83,34,71,64,83,50,68,81,85,72,66,68,13,49,33,55,38,68,77,68,81,64,75,255,78,81,255,75,68,70,64,66,88,255,50,64,88,44,68,82,82,64,70,68,49,68,80,84,68,82,83,255,69,78,84,77,67,255,69,78,81},33), message)
end)
if not ok then debug(_d({82,68,77,67,34,71,64,83,44,68,82,82,64,70,68,255,68,81,81,78,81,25},33), err) end
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
debug(_d({45,78,83,255,76,64,74,72,77,70,255,79,81,78,70,81,68,82,82,255,83,78,86,64,81,67,255,77,64,85,255,83,64,81,70,68,83,255,69,78,81},33), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({82,255,12,255,82,68,77,67,72,77,70,255,14,84,77,82,83,84,66,74},33))
sendChatMessage(_d({14,84,77,82,83,84,66,74},33))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({86,64,72,83,52,77,83,72,75,32,81,81,72,85,68,67,255,83,72,76,68,78,84,83},33))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({77,64,85,51,78,47,78,72,77,83,34,78,77,69,72,81,76,68,67,25},33), label or _d({83,64,81,70,68,83},33), _d({12,255,67,72,67,255,77,78,83,255,64,81,81,72,85,68,255,86,72,83,71,72,77},33), timeout, _d({82,11,255,81,68,83,81,88,72,77,70,255,78,77,66,68},33))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({77,64,85,51,78,47,78,72,77,83,34,78,77,69,72,81,76,68,67,25},33), label or _d({83,64,81,70,68,83},33), _d({12,255,82,83,72,75,75,255,77,78,83,255,64,81,81,72,85,68,67,255,64,69,83,68,81,255,81,68,83,81,88,11,255,79,81,78,66,68,68,67,72,77,70,255,64,77,88,86,64,88},33))
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
if not ok then debug(_d({77,64,85,51,78,47,78,72,77,83,39,78,75,67,72,77,70,33,75,78,66,74,255,74,68,88,12,67,78,86,77,255,68,81,81,78,81,25},33), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({77,64,85,51,78,47,78,72,77,83,39,78,75,67,72,77,70,33,75,78,66,74,255,74,68,88,12,84,79,255,68,81,81,78,81,25},33), err2) end
end
local function clearStage(stageName)
debug(_d({44,78,85,72,77,70,255,83,78},33), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({54,64,72,83,72,77,70,255,69,78,81,255,45,47,34,82,255,83,78,255,82,79,64,86,77,255,64,83},33), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({255,255,82,79,64,86,77,255,66,71,68,66,74,25,255,69,78,75,67,68,81,255,68,87,72,82,83,82,255,28},33), folder ~= nil,
_d({11,255,66,71,72,75,67,81,68,77,255,28},33), folder and #folder:GetChildren() or 0,
_d({11,255,64,75,72,85,68,255,28},33), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({45,78,255,45,47,34,82,255,64,79,79,68,64,81,68,67,255,64,83},33), stageName, _d({64,69,83,68,81,255,16,20,82,11,255,76,78,85,72,77,70,255,78,77,255,64,77,88,86,64,88},33))
break
end
end
debug(_d({42,72,75,75,72,77,70,255,45,47,34,82,255,64,83},33), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({49,68,83,84,81,77,72,77,70,255,83,78},33), stageName, _d({79,78,82,72,83,72,78,77,255,65,68,69,78,81,68,255,76,78,85,72,77,70,255,78,77},33))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({54,64,72,83,72,77,70,255,20,82,255,64,83},33), stageName, _d({79,78,82,72,83,72,78,77},33))
task.wait(5)
debug(stageName, _d({66,75,68,64,81,68,67},33))
end
local function killNamedNPC(name, targetPos)
debug(_d({44,78,85,72,77,70,255,83,78},33), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({67,68,69,68,64,83,68,67},33))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({39,84,76,64,77,78,72,67},33))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({43,68,78,255,79,75,64,88,68,67,255,64,77,72,76,64,83,72,78,77,25},33), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({75,68,78,32,77,72,76,43,78,70,70,68,81,255,79,81,72,77,83,255,68,81,81,78,81,25},33), err2) end
end)
end)
if not ok then debug(_d({82,83,64,81,83,43,68,78,32,77,72,76,43,78,70,70,68,81,255,68,81,81,78,81,25},33), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({44,78,85,72,77,70,255,83,78,255,43,68,78,255,7,65,75,78,66,74,72,77,70,255,64,69,83,68,81},33), LEO_BLOCK_DELAY, _d({82,8},33))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({43,68,78},33))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({43,68,78},33))
while enabled do
local info = getNPCByName(_d({43,68,78},33))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({43,68,78,255,66,64,82,83,72,77,70},33), which, _d({12,255,67,78,67,70,72,77,70},33))
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
if not getNPCByName(_d({43,68,78},33)) then
debug(_d({43,68,78,255,70,78,77,68,255,76,72,67,12,67,78,67,70,68,255,12,255,68,77,67,72,77,70,255,36,77,83,68,72,255,71,78,75,67,255,68,64,81,75,88},33))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({43,68,78},33)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({43,68,78,255,70,78,77,68,255,76,72,67,12,67,78,67,70,68,255,12,255,68,77,67,72,77,70,255,37,75,64,76,68,255,47,72,75,75,64,81,255,71,78,75,67,255,68,64,81,75,88},33))
end
end
end
if enabled and getNPCByName(_d({43,68,78},33)) then
setNavNamed(_d({43,68,78},33))
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
debug(_d({43,68,78,255,67,68,69,68,64,83,68,67},33))
stopLeoAnimLogger()
debug(_d({49,68,83,84,81,77,72,77,70,255,83,78,255,43,68,78,255,79,78,82,72,83,72,78,77,255,65,68,69,78,81,68,255,76,78,85,72,77,70,255,78,77},33))
navToPointConfirmed(COORDS.Leo, 30, _d({43,68,78,255,79,78,82,72,83,72,78,77},33))
debug(_d({54,64,72,83,72,77,70,255,20,82,255,64,83,255,43,68,78,255,79,78,82,72,83,72,78,77},33))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({44,78,85,72,77,70,255,83,78},33), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({34,78,84,75,67,255,77,78,83,255,69,72,77,67,255,82,83,64,83,84,68,255,76,78,67,68,75,255,77,68,64,81},33), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({32,83,83,64,66,74,72,77,70},33), coordKey, _d({86,72,83,71},33), weapon or _d({77,78,83,71,72,77,70,255,69,78,84,77,67},33))
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
debug(coordKey, _d({65,64,81,81,68,75,255,67,68,82,83,81,78,88,68,67},33))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({81,68,66,71,68,66,74,50,83,64,83,84,68,25},33), coordKey, _d({12,255,66,78,84,75,67,255,77,78,83,255,69,72,77,67,255,82,83,64,83,84,68,255,76,78,67,68,75,11,255,82,74,72,79,79,72,77,70},33))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({81,68,66,71,68,66,74,50,83,64,83,84,68,25},33), coordKey, _d({82,83,72,75,75,255,64,75,72,85,68,255,7,39,47},33), hp, _d({8,255,12,255,81,68,12,67,68,82,83,81,78,88,72,77,70},33))
destroyStatue(coordKey)
else
debug(_d({81,68,66,71,68,66,74,50,83,64,83,84,68,25},33), coordKey, _d({66,78,77,69,72,81,76,68,67,255,67,68,82,83,81,78,88,68,67},33))
end
end)
if not ok then debug(_d({81,68,66,71,68,66,74,50,83,64,83,84,68,255,68,81,81,78,81,25},33), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({44,78,85,72,77,70,255,83,78,255,48,84,68,68,77},33))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({34,84,79,72,67,255,48,84,68,68,77},33))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({48,84,68,68,77,255,68,77,83,68,81,68,67,255,79,71,64,82,68,255,17},33))
end
local function finishQueen()
debug(_d({37,72,77,72,82,71,72,77,70,255,48,84,68,68,77},33))
equipSwordOrMelee()
setNavNamed(_d({34,84,79,72,67,255,48,84,68,68,77},33))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({34,84,79,72,67,255,48,84,68,68,77},33))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({48,84,68,68,77,255,67,68,69,68,64,83,68,67,13,255,47,75,64,77,255,66,78,76,79,75,68,83,68,13},33))
end
local CONFIRMATION_PROMPT_NAME = _d({34,78,77,69,72,81,76,64,83,72,78,77,47,81,78,76,79,83},33)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({49,68,76,78,83,68,36,85,68,77,83},33), 5)
end)
if ok then return result end
debug(_d({70,68,83,49,68,79,75,64,88,49,68,76,78,83,68,255,68,81,81,78,81,25},33), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({47,75,64,88,68,81,38,84,72},33))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({40,76,64,70,68,33,84,83,83,78,77},33)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({65,84,83,83,78,77,53,64,75,84,68},33)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({69,72,77,67,33,84,83,83,78,77,33,88,53,64,75,84,68,255,68,81,81,78,81,25},33), result)
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
if not ok then debug(_d({66,75,72,66,74,38,84,72,33,84,83,83,78,77,255,68,81,81,78,81,25},33), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({72,82,50,68,81,85,68,81},33))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({49,68,76,78,83,68,36,85,68,77,83},33))
or inst:FindFirstChild(_d({66,75,72,68,77,83,36,85,68,77,83},33))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({69,72,77,67,32,77,82,86,68,81,34,78,77,77,68,66,83,78,81,255,68,81,81,78,81,25},33), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({34,78,84,75,67,255,77,78,83,255,75,78,66,64,83,68,255,49,68,76,78,83,68,36,85,68,77,83,14,66,75,72,68,77,83,36,85,68,77,83,255,77,68,64,81,255,49,68,79,75,64,88,255,65,84,83,83,78,77,11,255,69,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,66,75,72,66,74},33))
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
debug(_d({69,72,81,68,49,68,79,75,64,88,53,64,75,84,68,255,68,81,81,78,81,25},33), err, _d({12,255,69,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,66,75,72,66,74},33))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({37,64,75,75,72,77,70,255,65,64,66,74,255,83,78,255,65,84,83,83,78,77,53,64,75,84,68,255,82,68,64,81,66,71,255,69,78,81,255,49,68,79,75,64,88},33))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({49,68,79,75,64,88,255,65,84,83,83,78,77,255,77,78,83,255,69,78,84,77,67,255,68,72,83,71,68,81,11,255,70,72,85,72,77,70,255,84,79},33))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({54,64,72,83,72,77,70,255,69,78,81,255,34,78,77,69,72,81,76,64,83,72,78,77,47,81,78,76,79,83,13,49,68,76,78,83,68,36,85,68,77,83},33))
local remote = getReplayRemote()
if not remote then
debug(_d({34,78,77,69,72,81,76,64,83,72,78,77,47,81,78,76,79,83,14,49,68,76,78,83,68,36,85,68,77,83,255,77,78,83,255,69,78,84,77,67,255,86,72,83,71,72,77,255,83,72,76,68,78,84,83},33))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({37,72,81,72,77,70,255,49,68,79,75,64,88,255,85,72,64,255,34,78,77,69,72,81,76,64,83,72,78,77,47,81,78,76,79,83,13,49,68,76,78,83,68,36,85,68,77,83},33))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({37,72,81,68,50,68,81,85,68,81,255,68,81,81,78,81,25},33), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({47,75,64,88,68,81,38,84,72},33), 10)
if not playerGui then
debug(_d({86,64,72,83,37,78,81,46,65,73,68,66,83,72,85,68,82,38,84,72,25,255,77,78,255,47,75,64,88,68,81,38,84,72,255,86,72,83,71,72,77,255,83,72,76,68,78,84,83,11,255,79,81,78,66,68,68,67,72,77,70,255,64,77,88,86,64,88},33))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({46,65,73,68,66,83,72,85,68,82,255,38,52,40,255,69,78,84,77,67,255,12,255,82,83,64,70,68,255,75,78,64,67,68,67},33))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({46,65,73,68,66,83,72,85,68,82,255,38,52,40,255,77,78,83,255,69,78,84,77,67,255,86,72,83,71,72,77,255,83,72,76,68,78,84,83,11,255,79,81,78,66,68,68,67,72,77,70,255,64,77,88,86,64,88},33))
return
end
end
end)
if not ok then debug(_d({86,64,72,83,37,78,81,46,65,73,68,66,83,72,85,68,82,38,84,72,255,68,81,81,78,81,25},33), err) end
end
local function runPlan()
debug(_d({47,75,64,77,255,82,83,64,81,83,68,67},33))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({50,83,64,81,83,72,77,70,255,77,64,85,255,75,78,78,79},33))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({79,78,82,255,15,13,17,82,255,32,37,51,36,49,255,82,83,64,81,83,45,64,85,25},33), rootAfter and rootAfter.Position)
end)
debug(_d({54,64,72,83,72,77,70,255,20,82,255,65,68,69,78,81,68,255,76,78,85,72,77,70,255,83,78,255,50,83,64,70,68,16},33))
task.wait(5)
for _, stage in ipairs({_d({50,83,64,70,68,16},33), _d({50,83,64,70,68,17},33), _d({50,83,64,70,68,18},33), _d({50,83,64,70,68,18,33},33)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({44,78,85,72,77,70,255,83,78,255,64,81,81,78,86,255,69,75,88,12,67,78,86,77,255,64,81,68,64},33))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({35,78,67,70,72,77,70,255,64,81,81,78,86,255,81,64,72,77},33))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({50,83,64,70,68,19},33))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({48,84,68,68,77,255,72,77,255,79,71,64,82,68,255,17,255,12,255,74,68,68,79,72,77,70,255,42,68,77,255,39,64,74,72,255,64,66,83,72,85,68,255,69,81,78,76,255,71,68,81,68,255,78,77},33))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({50,83,64,83,84,68,16},33))
if not enabled then return end
recheckStatue(_d({50,83,64,83,84,68,16},33))
destroyStatue(_d({50,83,64,83,84,68,17},33))
if not enabled then return end
recheckStatue(_d({50,83,64,83,84,68,16},33))
recheckStatue(_d({50,83,64,83,84,68,17},33))
destroyStatue(_d({50,83,64,83,84,68,18},33))
if not enabled then return end
recheckStatue(_d({50,83,64,83,84,68,18},33))
recheckStatue(_d({50,83,64,83,84,68,17},33))
recheckStatue(_d({50,83,64,83,84,68,16},33))
if not enabled then return end
debug(_d({54,64,72,83,72,77,70,255,69,78,81,255,79,71,64,82,68,255,17,255,83,78,255,68,77,67},33))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({47,71,64,82,68,255,17,255,68,77,67,255,86,64,72,83,255,83,72,76,68,78,84,83,11,255,79,81,78,66,68,68,67,72,77,70,255,64,77,88,86,64,88},33))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({44,78,85,72,77,70,255,65,64,66,74,255,83,78,255,48,84,68,68,77,255,82,83,64,70,68,255,79,78,82,72,83,72,78,77},33))
navToPointConfirmed(COORDS.Queen, 30, _d({48,84,68,68,77,255,82,83,64,70,68,255,79,78,82,72,83,72,78,77},33))
debug(_d({54,64,72,83,72,77,70,255,20,82,255,64,83,255,48,84,68,68,77,255,82,83,64,70,68,255,79,78,82,72,83,72,78,77},33))
task.wait(5)
if not enabled then return end
debug(_d({44,78,85,72,77,70,255,83,78,255,79,78,82,83,12,48,84,68,68,77,255,79,78,82,72,83,72,78,77},33))
navToPointConfirmed(COORDS.PostQueen, 30, _d({79,78,82,83,12,48,84,68,68,77,255,79,78,82,72,83,72,78,77},33))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({36,77,64,65,75,72,77,70,11,255,79,78,82,255,33,36,37,46,49,36,255,79,75,64,77,25},33), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({47,75,64,77,255,68,81,81,78,81,25},33), err2) end
end)
debug(_d({36,77,64,65,75,68,67,25},33), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({36,77,64,65,75,68,67,25},33), enabled)
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
if not ok then debug(_d({40,77,79,84,83,33,68,70,64,77,255,68,81,81,78,81,25},33), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({38,64,76,68,255,75,78,64,67,68,67,11,255,64,84,83,78,12,82,83,64,81,83,72,77,70,255,83,71,68,255,79,75,64,77},33))
enableBot()
end)
if not ok then debug(_d({32,84,83,78,82,83,64,81,83,255,68,81,81,78,81,25},33), err) end
end)
debug(_d({43,78,64,67,68,67,255,193,95,115,255,64,84,83,78,12,82,83,64,81,83,72,77,70,255,78,77,66,68,255,83,71,68,255,70,64,76,68,255,69,72,77,72,82,71,68,82,255,75,78,64,67,72,77,70,255,7,79,81,68,82,82,255,47,255,83,78,255,83,78,70,70,75,68,255,76,64,77,84,64,75,75,88,8},33))
end)()