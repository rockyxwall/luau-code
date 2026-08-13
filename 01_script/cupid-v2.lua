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
local Players            = game:GetService(_d({43,71,60,84,64,77,78},37))
local UserInputService    = game:GetService(_d({48,78,64,77,36,73,75,80,79,46,64,77,81,68,62,64},37))
local RunService          = game:GetService(_d({45,80,73,46,64,77,81,68,62,64},37))
local VIM                 = game:GetService(_d({49,68,77,79,80,60,71,36,73,75,80,79,40,60,73,60,66,64,77},37))
local ReplicatedStorage    = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({54,29,74,78,78,29,74,79,56},37), _d({50,77,74,73,66,251,66,60,72,64,251,189,91,111,251,43,71,60,62,64,36,63,21},37), game.PlaceId, _d({48,73,68,81,64,77,78,64,36,63,21},37), game.GameId, _d({8,251,73,74,79,251,77,80,73,73,68,73,66},37))
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
local LEO_PILLAR_ANIM_ID   = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,16,13,15,15,12,15,12,14,13,18},37)
local LEO_ENTEI_ANIM_ID    = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,16,13,15,15,12,14,19,13,18,19},37)
local LEO_HIKEN_ANIM_ID    = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,16,13,13,11,20,12,18,15,11,18},37)
local LEO_FIREFLY_ANIM_ID  = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,16,13,13,11,13,14,17,12,16,15},37)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({42,61,69,64,62,79,68,81,64,78},37)
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
local REPLAY_BUTTON_VALUE   = _d({45,64,75,71,60,84},37)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({72,74,81,64},37)
local NavState   = {mode = _d({68,63,71,64},37)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({54,29,74,78,78,29,74,79,56},37), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end)
if ok then return root end
debug(_d({66,64,79,45,74,74,79,251,64,77,77,74,77,21},37), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
end)
if ok then return hum end
debug(_d({66,64,79,35,80,72,60,73,74,68,63,251,64,77,77,74,77,21},37), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({58,58,35,74,81,64,77,28,79,79},37)) or Instance.new(_d({28,79,79,60,62,67,72,64,73,79},37))
att.Name = _d({58,58,35,74,81,64,77,28,79,79},37)
att.Parent = root
local force = root:FindFirstChild(_d({58,58,35,74,81,64,77,33,74,77,62,64},37))
if not force then
force = Instance.new(_d({39,68,73,64,60,77,49,64,71,74,62,68,79,84},37))
force.Name = _d({58,58,35,74,81,64,77,33,74,77,62,64},37)
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
debug(_d({66,64,79,42,77,30,77,64,60,79,64,33,74,77,62,64,251,64,77,77,74,77,21},37), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not root then return end
local force = root:FindFirstChild(_d({58,58,35,74,81,64,77,33,74,77,62,64},37))
local att   = root:FindFirstChild(_d({58,58,35,74,81,64,77,28,79,79},37))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({62,71,64,60,73,80,75,33,74,77,62,64,251,64,77,77,74,77,21},37), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({29,80,78,74,40,64,71,64,64},37)) ~= nil
end)
if ok then return result end
debug(_d({68,78,29,80,78,74,28,62,79,68,81,64,251,64,77,77,74,77,21},37), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({29,80,78,74},37))
end)
if not ok then debug(_d({60,62,79,68,81,60,79,64,29,80,78,74,251,64,77,77,74,77,21},37), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({29,80,78,74,251,73,74,79,251,60,62,79,68,81,64,7,251,60,62,79,68,81,60,79,68,73,66},37))
activateBuso()
end
end)
if not ok then debug(_d({29,80,78,74,38,64,64,75,64,77,251,64,77,77,74,77,21},37), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({29,80,78,74,251,70,64,64,75,64,77,251,78,79,74,75,75,64,63},37))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({38,64,73,35,60,70,68},37)) ~= nil
end)
if ok then return result end
debug(_d({68,78,38,64,73,28,62,79,68,81,64,251,64,77,77,74,77,21},37), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({38,64,73},37), true)
end)
if not ok then debug(_d({60,62,79,68,81,60,79,64,38,64,73,251,64,77,77,74,77,21},37), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({38,64,73,251,73,74,79,251,60,62,79,68,81,64,7,251,60,62,79,68,81,60,79,68,73,66},37))
activateKen()
end
end)
if not ok then debug(_d({38,64,73,38,64,64,75,64,77,251,64,77,77,74,77,21},37), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({38,64,73,251,70,64,64,75,64,77,251,78,79,74,75,75,64,63},37))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({41,43,30,78},37)) end)
if ok then return folder end
debug(_d({66,64,79,41,43,30,78,33,74,71,63,64,77,251,64,77,77,74,77,21},37), folder)
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
local r = model:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local h = model:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
debug(_d({66,64,79,41,64,60,77,64,78,79,41,43,30,251,64,77,77,74,77,21},37), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
local hum  = model:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({66,64,79,41,43,30,29,84,41,60,72,64,251,64,77,77,74,77,21},37), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({73,75,62,78,45,64,72,60,68,73,68,73,66,251,64,77,77,74,77,21},37), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({30,80,75,68,63,251,44,80,64,64,73},37))
return queen ~= nil and queen:FindFirstChild(_d({72,74,79,68,74,73,39,64,78,78},37)) ~= nil
end)
if ok then return result end
debug(_d({68,78,44,80,64,64,73,43,67,60,78,64,13,251,64,77,77,74,77,21},37), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,12,13,12,13,20,18,20,15,13,13,20,13,18,17,20},37)
local QUEEN_GRASP_ANIM_ID   = _d({77,61,83,60,78,78,64,79,68,63,21,10,10,12,13,20,19,11,11,11,17,12,11,11,12,18,14,15},37)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
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
debug(_d({68,78,43,71,60,84,68,73,66,28,73,68,72,33,77,74,72,39,68,78,79,251,64,77,77,74,77,21},37), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({29,71,74,62,70,68,73,66},37)) ~= nil
end)
if ok then return result end
debug(_d({68,78,41,43,30,29,71,74,62,70,68,73,66,251,64,77,77,74,77,21},37), result)
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
debug(_d({75,77,64,63,68,62,79,41,43,30,43,74,78,68,79,68,74,73,251,64,77,77,74,77,21},37), result)
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
debug(_d({41,74,251,63,60,72,60,66,64,251,74,73},37), model.Name, _d({65,74,77},37), NPC_STUCK_TIMEOUT, _d({78,251,8,251,78,82,68,79,62,67,68,73,66,251,79,60,77,66,64,79},37))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({79,77,60,62,70,41,43,30,31,60,72,60,66,64,251,64,77,77,74,77,21},37), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({40,74,63,64,71},37)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({29,60,78,64,43,60,77,79},37)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({66,64,79,40,74,63,64,71,33,60,62,64,43,74,78,251,64,77,77,74,77,21},37), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({32,73,81},37))
local folder = env and env:FindFirstChild(_d({46,79,60,79,80,64,78},37))
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
debug(_d({66,64,79,46,79,60,79,80,64,40,74,63,64,71,41,64,60,77,251,64,77,77,74,77,21},37), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({61,60,77,77,64,71,35,43},37))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({66,64,79,46,79,60,79,80,64,35,43,251,64,77,77,74,77,21},37), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({47,74,74,71},37)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({65,68,73,63,47,74,74,71,29,84,28,79,79,77,68,61,80,79,64,251,64,77,77,74,77,21},37), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({47,74,74,71},37)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({65,68,73,63,47,74,74,71,29,84,41,60,72,64,251,64,77,77,74,77,21},37), tool)
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
if not ok then debug(_d({64,76,80,68,75,47,74,74,71,251,64,77,77,74,77,21},37), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({29,60,62,70,75,60,62,70},37))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({47,74,74,71},37)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({65,68,73,63,47,74,74,71,29,84,30,67,68,71,63,41,60,72,64,251,64,77,77,74,77,21},37), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({46,82,74,77,63,32,76,80,68,75},37))
if sword then
equipTool(sword)
return _d({78,82,74,77,63},37)
end
local melee = findToolByAttribute(_d({40,64,71,64,64,47,74,74,71},37))
if melee then
equipTool(melee)
return _d({72,64,71,64,64},37)
end
debug(_d({41,74,251,78,82,74,77,63,251,74,77,251,72,64,71,64,64,251,79,74,74,71,251,65,74,80,73,63},37))
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
if not ok then debug(_d({62,71,68,62,70,40,12,251,64,77,77,74,77,21},37), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 4.5
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({45,74,70,80,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({34,64,75,75,74},37), args)
elseif style == _d({29,71,60,62,70,39,64,66},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70},37), args)
elseif style == _d({38,60,72,68,78,67,68,70,68},37) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({38,60,72,68,78,67,68,70,68,34,64,75,75,74},37), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,70,84,251,50,60,71,70,13},37), args)
end
end)
if not ok then debug(_d({68,73,81,74,70,64,34,64,75,75,74,251,64,77,77,74,77,21},37), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({75,77,64,78,78,46,70,68,71,71,45,251,64,77,77,74,77,21},37), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({67,74,71,63,29,71,74,62,70,251,64,77,77,74,77,21},37), err) end
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
if not ok then debug(_d({67,74,71,63,29,71,74,62,70,50,67,68,71,64,251,64,77,77,74,77,21},37), err) end
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
debug(_d({66,64,79,34,60,72,64,34,251,64,77,77,74,77,21},37), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({68,78,45,64,60,71,40,12,29,80,78,84,251,64,77,77,74,77,21},37), result)
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
return char ~= nil and char:FindFirstChild(_d({78,79,80,73},37)) ~= nil
end)
if ok then return result end
debug(_d({68,78,46,79,80,73,73,64,63,251,64,77,77,74,77,21},37), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({75,77,64,78,78,46,79,80,73,29,77,64,60,70,251,64,77,77,74,77,21},37), err) end
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
navToPoint(myPos + Vector3.new(0, QUEEN_DODGE_DISTANCE, 0), true)
local t = 0
local sinceGeppo = 0
local geppoCount = 1
while enabled do
if isStunned() then pressStunBreak() end
info = getInfoFn()
if not info then
debug(_d({76,80,64,64,73,31,74,63,66,64,48,73,79,68,71,46,60,65,64,21,251,44,80,64,64,73,251,66,74,73,64,251,8,251,64,73,63,68,73,66,251,63,74,63,66,64,251,64,60,77,71,84},37))
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
if geppoCount < 4 then
invokeGeppo()
geppoCount += 1
end
sinceGeppo = 0
end
if t > 15 then
debug(_d({76,80,64,64,73,31,74,63,66,64,48,73,79,68,71,46,60,65,64,251,78,60,65,64,79,84,251,79,68,72,64,74,80,79},37))
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
local info = getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({44,80,64,64,73,251,62,60,78,79,68,73,66,251,63,64,79,64,62,79,64,63,251,8,251,63,74,63,66,68,73,66,251,3,82,60,79,62,67,64,77,4},37))
queenDodgeUntilSafe(function() return getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37)) end)
if enabled and getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37)) then
setNavNamed(_d({30,80,75,68,63,251,44,80,64,64,73},37))
end
queenDodging = false
end
end)
if not ok then debug(_d({76,80,64,64,73,31,74,63,66,64,50,60,79,62,67,64,77,251,64,77,77,74,77,21},37), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({75,74,68,73,79},37) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({73,75,62},37) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({73,60,72,64,63},37) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({66,64,79,41,60,81,47,60,77,66,64,79,78,251,64,77,77,74,77,21},37), aimR)
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
debug(_d({62,74,72,75,80,79,64,39,74,62,70,64,63,30,33,77,60,72,64,251,64,77,77,74,77,21},37), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({75,74,68,73,79},37), point = pos}
phase = _d({72,74,81,64},37)
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
if not ok then debug(_d({73,60,81,47,74,43,74,68,73,79,251,66,64,75,75,74,251,62,67,64,62,70,251,64,77,77,74,77,21},37), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({73,75,62},37)}
phase = _d({72,74,81,64},37)
end
function setNavNamed(name)
NavState = {mode = _d({73,60,72,64,63},37), name = name}
phase = _d({72,74,81,64},37)
end
local function setNavIdle()
NavState = {mode = _d({68,63,71,64},37)}
phase = _d({72,74,81,64},37)
end
local function hasArrived()
return phase == _d({67,74,81,64,77},37)
end
local function startNav()
phase = _d({72,74,81,64},37)
debug(_d({41,60,81,251,71,74,74,75,251,42,41},37))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({43,71,60,84,64,77,251,63,68,64,63,252,251,46,79,74,75,75,68,73,66,251,61,74,79,9},37))
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
debug(_d({43,71,60,84,64,77,251,68,78,251,79,74,74,251,65,60,77,251,65,77,74,72,251,79,60,77,66,64,79,251,3,25,13,11,11,11,251,78,79,80,63,78,4,9,251,39,68,70,64,71,84,251,77,64,78,75,60,82,73,64,63,251,60,79,251,71,74,61,61,84,9,251,46,79,74,75,75,68,73,66,251,61,74,79,9},37))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({58,58,75,77,64,81,43,74,78},37))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({39,60,77,66,64,251,75,74,78,68,79,68,74,73,251,69,80,72,75,251,63,64,79,64,62,79,64,63,21},37), delta, _d({78,79,80,63,78,9,251,75,77,64,81,43,74,78,24},37), prevPos, _d({73,64,82,43,74,78,24},37), pos)
end
end
force:SetAttribute(_d({58,58,75,77,64,81,43,74,78},37), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({72,74,81,64},37) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({67,74,81,64,77},37)
debug(_d({43,67,60,78,64,21,251,67,74,81,64,77},37))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({252,252,252,251,45,32,33,48,46,36,41,34,251,47,42,251,28,43,43,39,52,251,28,29,41,42,45,40,28,39,251,49,32,39,42,30,36,47,52,21},37), finalVel, _d({60,68,72,24},37), aim, _d({75,74,78,24},37), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({67,74,81,64,77},37) then
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
debug(_d({30,74,72,61,60,79,251,71,74,62,70,251,78,70,68,75,75,64,63,7},37), snapDist, _d({78,79,80,63,78,251,65,77,74,72,251,79,60,77,66,64,79,251,189,91,111,251,65,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,72,74,81,64},37))
phase = _d({72,74,81,64},37)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({35,64,60,77,79,61,64,60,79,251,64,77,77,74,77,21},37), err) end
end)
end
local function stopNav()
debug(_d({41,60,81,251,71,74,74,75,251,42,33,33},37))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({72,74,81,64},37)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({47,64,83,79,30,67,60,79,46,64,77,81,68,62,64},37))
local channels = TextChatService:FindFirstChild(_d({47,64,83,79,30,67,60,73,73,64,71,78},37))
local channel = channels and channels:FindFirstChild(_d({45,29,51,34,64,73,64,77,60,71},37))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({31,64,65,60,80,71,79,30,67,60,79,46,84,78,79,64,72,30,67,60,79,32,81,64,73,79,78},37))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({46,60,84,40,64,78,78,60,66,64,45,64,76,80,64,78,79},37))
if sayEvent then
sayEvent:FireServer(message, _d({28,71,71},37))
return
end
debug(_d({78,64,73,63,30,67,60,79,40,64,78,78,60,66,64,21,251,73,74,251,47,64,83,79,30,67,60,79,46,64,77,81,68,62,64,9,45,29,51,34,64,73,64,77,60,71,251,74,77,251,71,64,66,60,62,84,251,46,60,84,40,64,78,78,60,66,64,45,64,76,80,64,78,79,251,65,74,80,73,63,251,65,74,77},37), message)
end)
if not ok then debug(_d({78,64,73,63,30,67,60,79,40,64,78,78,60,66,64,251,64,77,77,74,77,21},37), err) end
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
debug(_d({41,74,79,251,72,60,70,68,73,66,251,75,77,74,66,77,64,78,78,251,79,74,82,60,77,63,251,73,60,81,251,79,60,77,66,64,79,251,65,74,77},37), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({78,251,8,251,78,64,73,63,68,73,66,251,10,80,73,78,79,80,62,70},37))
sendChatMessage(_d({10,80,73,78,79,80,62,70},37))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({82,60,68,79,48,73,79,68,71,28,77,77,68,81,64,63,251,79,68,72,64,74,80,79},37))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({73,60,81,47,74,43,74,68,73,79,30,74,73,65,68,77,72,64,63,21},37), label or _d({79,60,77,66,64,79},37), _d({8,251,63,68,63,251,73,74,79,251,60,77,77,68,81,64,251,82,68,79,67,68,73},37), timeout, _d({78,7,251,77,64,79,77,84,68,73,66,251,74,73,62,64},37))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({73,60,81,47,74,43,74,68,73,79,30,74,73,65,68,77,72,64,63,21},37), label or _d({79,60,77,66,64,79},37), _d({8,251,78,79,68,71,71,251,73,74,79,251,60,77,77,68,81,64,63,251,60,65,79,64,77,251,77,64,79,77,84,7,251,75,77,74,62,64,64,63,68,73,66,251,60,73,84,82,60,84},37))
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
if not ok then debug(_d({73,60,81,47,74,43,74,68,73,79,35,74,71,63,68,73,66,29,71,74,62,70,251,70,64,84,8,63,74,82,73,251,64,77,77,74,77,21},37), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({73,60,81,47,74,43,74,68,73,79,35,74,71,63,68,73,66,29,71,74,62,70,251,70,64,84,8,80,75,251,64,77,77,74,77,21},37), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({50,60,71,70,68,73,66,251,79,74,21},37), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({82,60,71,70,47,74,43,74,68,73,79,251,50,251,63,74,82,73,251,64,77,77,74,77,21},37), err) end
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
debug(_d({47,74,74,70,251,63,60,72,60,66,64,251,82,67,68,71,64,251,82,60,71,70,68,73,66,251,79,74,251,75,74,68,73,79,252,251,46,79,74,75,75,68,73,66,251,82,60,71,70,251,79,74,251,64,73,66,60,66,64,9},37))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({28,77,77,68,81,64,63,251,60,79,21},37), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({46,79,80,62,70,251,63,80,77,68,73,66,251,82,60,71,70,7,251,69,80,72,75,68,73,66,252},37))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({46,79,68,71,71,251,78,79,80,62,70,7,251,79,77,68,66,66,64,77,68,73,66,251,34,64,75,75,74,252},37))
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
debug(_d({40,74,81,68,73,66,251,79,74},37), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({50,60,68,79,68,73,66,251,65,74,77,251,41,43,30,78,251,79,74,251,78,75,60,82,73,251,60,79},37), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({251,251,78,75,60,82,73,251,62,67,64,62,70,21,251,65,74,71,63,64,77,251,64,83,68,78,79,78,251,24},37), folder ~= nil,
_d({7,251,62,67,68,71,63,77,64,73,251,24},37), folder and #folder:GetChildren() or 0,
_d({7,251,60,71,68,81,64,251,24},37), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({41,74,251,41,43,30,78,251,60,75,75,64,60,77,64,63,251,60,79},37), stageName, _d({60,65,79,64,77,251,12,16,78,7,251,72,74,81,68,73,66,251,74,73,251,60,73,84,82,60,84},37))
break
end
end
debug(_d({38,68,71,71,68,73,66,251,41,43,30,78,251,60,79},37), stageName)
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
debug(_d({45,64,79,80,77,73,68,73,66,251,79,74},37), stageName, _d({75,74,78,68,79,68,74,73,251,61,64,65,74,77,64,251,72,74,81,68,73,66,251,74,73},37))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({50,60,68,79,68,73,66,251,16,78,251,60,79},37), stageName, _d({75,74,78,68,79,68,74,73},37))
task.wait(5)
debug(_d({50,60,68,79,68,73,66,251,65,74,77},37), targetHP * 100, _d({0,251,35,43,251,61,64,65,74,77,64,251,72,74,81,68,73,66,251,79,74,251,73,64,83,79,251,78,79,60,66,64},37))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({62,71,64,60,77,64,63},37))
end
local function killNamedNPC(name, targetPos)
debug(_d({40,74,81,68,73,66,251,79,74},37), name)
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
debug(name, _d({63,64,65,64,60,79,64,63},37))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({35,80,72,60,73,74,68,63},37))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({39,64,74,251,75,71,60,84,64,63,251,60,73,68,72,60,79,68,74,73,21},37), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({71,64,74,28,73,68,72,39,74,66,66,64,77,251,75,77,68,73,79,251,64,77,77,74,77,21},37), err2) end
end)
end)
if not ok then debug(_d({78,79,60,77,79,39,64,74,28,73,68,72,39,74,66,66,64,77,251,64,77,77,74,77,21},37), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({40,74,81,68,73,66,251,79,74,251,39,64,74},37))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({39,64,74},37))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({39,64,74},37))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({39,64,74},37))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({39,64,74,251,62,60,78,79,68,73,66},37), which, _d({8,251,63,74,63,66,68,73,66},37))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({39,64,74,251,78,79,60,77,79,64,63,251,61,71,74,62,70,8,61,77,64,60,70,64,77,251,72,68,63,8,61,71,74,62,70,252,251,32,81,60,63,68,73,66,9,9,9},37))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
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
if not getNPCByName(_d({39,64,74},37)) then
debug(_d({39,64,74,251,66,74,73,64,251,72,68,63,8,63,74,63,66,64,251,8,251,64,73,63,68,73,66,251,32,73,79,64,68,251,67,74,71,63,251,64,60,77,71,84},37))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({39,64,74},37)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({39,64,74,251,66,74,73,64,251,72,68,63,8,63,74,63,66,64,251,8,251,64,73,63,68,73,66,251,33,71,60,72,64,251,43,68,71,71,60,77,251,67,74,71,63,251,64,60,77,71,84},37))
end
end
end
if enabled and getNPCByName(_d({39,64,74},37)) then
setNavNamed(_d({39,64,74},37))
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
debug(_d({39,64,74,251,63,64,65,64,60,79,64,63},37))
stopLeoAnimLogger()
debug(_d({45,64,79,80,77,73,68,73,66,251,79,74,251,39,64,74,251,75,74,78,68,79,68,74,73,251,61,64,65,74,77,64,251,72,74,81,68,73,66,251,74,73},37))
navToPointConfirmed(COORDS.Leo, 30, _d({39,64,74,251,75,74,78,68,79,68,74,73},37))
debug(_d({50,60,68,79,68,73,66,251,16,78,251,60,79,251,39,64,74,251,75,74,78,68,79,68,74,73},37))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({40,74,81,68,73,66,251,79,74},37), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({30,74,80,71,63,251,73,74,79,251,65,68,73,63,251,78,79,60,79,80,64,251,72,74,63,64,71,251,73,64,60,77},37), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({28,79,79,60,62,70,68,73,66},37), coordKey, _d({82,68,79,67},37), weapon or _d({73,74,79,67,68,73,66,251,65,74,80,73,63},37))
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
debug(coordKey, _d({61,60,77,77,64,71,251,63,64,78,79,77,74,84,64,63},37))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({77,64,62,67,64,62,70,46,79,60,79,80,64,21},37), coordKey, _d({8,251,62,74,80,71,63,251,73,74,79,251,65,68,73,63,251,78,79,60,79,80,64,251,72,74,63,64,71,7,251,78,70,68,75,75,68,73,66},37))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({77,64,62,67,64,62,70,46,79,60,79,80,64,21},37), coordKey, _d({78,79,68,71,71,251,60,71,68,81,64,251,3,35,43},37), hp, _d({4,251,8,251,77,64,8,63,64,78,79,77,74,84,68,73,66},37))
destroyStatue(coordKey)
else
debug(_d({77,64,62,67,64,62,70,46,79,60,79,80,64,21},37), coordKey, _d({62,74,73,65,68,77,72,64,63,251,63,64,78,79,77,74,84,64,63},37))
end
end)
if not ok then debug(_d({77,64,62,67,64,62,70,46,79,60,79,80,64,251,64,77,77,74,77,21},37), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({40,74,81,68,73,66,251,79,74,251,44,80,64,64,73},37))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({30,80,75,68,63,251,44,80,64,64,73},37))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37))
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
debug(_d({44,80,64,64,73,251,64,73,79,64,77,64,63,251,75,67,60,78,64,251,13},37))
end
local function finishQueen()
debug(_d({33,68,73,68,78,67,68,73,66,251,44,80,64,64,73},37))
equipSwordOrMelee()
setNavNamed(_d({30,80,75,68,63,251,44,80,64,64,73},37))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({30,80,75,68,63,251,44,80,64,64,73},37))
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
debug(_d({44,80,64,64,73,251,63,64,65,64,60,79,64,63,9,251,43,71,60,73,251,62,74,72,75,71,64,79,64,9},37))
end
local CONFIRMATION_PROMPT_NAME = _d({30,74,73,65,68,77,72,60,79,68,74,73,43,77,74,72,75,79},37)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({45,64,72,74,79,64,32,81,64,73,79},37), 5)
end)
if ok then return result end
debug(_d({66,64,79,45,64,75,71,60,84,45,64,72,74,79,64,251,64,77,77,74,77,21},37), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({43,71,60,84,64,77,34,80,68},37))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({36,72,60,66,64,29,80,79,79,74,73},37)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({61,80,79,79,74,73,49,60,71,80,64},37)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({65,68,73,63,29,80,79,79,74,73,29,84,49,60,71,80,64,251,64,77,77,74,77,21},37), result)
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
if not ok then debug(_d({62,71,68,62,70,34,80,68,29,80,79,79,74,73,251,64,77,77,74,77,21},37), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({68,78,46,64,77,81,64,77},37))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({45,64,72,74,79,64,32,81,64,73,79},37))
or inst:FindFirstChild(_d({62,71,68,64,73,79,32,81,64,73,79},37))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({65,68,73,63,28,73,78,82,64,77,30,74,73,73,64,62,79,74,77,251,64,77,77,74,77,21},37), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({30,74,80,71,63,251,73,74,79,251,71,74,62,60,79,64,251,45,64,72,74,79,64,32,81,64,73,79,10,62,71,68,64,73,79,32,81,64,73,79,251,73,64,60,77,251,45,64,75,71,60,84,251,61,80,79,79,74,73,7,251,65,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,62,71,68,62,70},37))
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
debug(_d({65,68,77,64,45,64,75,71,60,84,49,60,71,80,64,251,64,77,77,74,77,21},37), err, _d({8,251,65,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,62,71,68,62,70},37))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({33,60,71,71,68,73,66,251,61,60,62,70,251,79,74,251,61,80,79,79,74,73,49,60,71,80,64,251,78,64,60,77,62,67,251,65,74,77,251,45,64,75,71,60,84},37))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({45,64,75,71,60,84,251,61,80,79,79,74,73,251,73,74,79,251,65,74,80,73,63,251,64,68,79,67,64,77,7,251,66,68,81,68,73,66,251,80,75},37))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({50,60,68,79,68,73,66,251,65,74,77,251,30,74,73,65,68,77,72,60,79,68,74,73,43,77,74,72,75,79,9,45,64,72,74,79,64,32,81,64,73,79},37))
local remote = getReplayRemote()
if not remote then
debug(_d({30,74,73,65,68,77,72,60,79,68,74,73,43,77,74,72,75,79,10,45,64,72,74,79,64,32,81,64,73,79,251,73,74,79,251,65,74,80,73,63,251,82,68,79,67,68,73,251,79,68,72,64,74,80,79},37))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({33,68,77,68,73,66,251,45,64,75,71,60,84,251,81,68,60,251,30,74,73,65,68,77,72,60,79,68,74,73,43,77,74,72,75,79,9,45,64,72,74,79,64,32,81,64,73,79},37))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({33,68,77,64,46,64,77,81,64,77,251,64,77,77,74,77,21},37), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({43,71,60,84,64,77,34,80,68},37), 10)
if not playerGui then
debug(_d({82,60,68,79,33,74,77,42,61,69,64,62,79,68,81,64,78,34,80,68,21,251,73,74,251,43,71,60,84,64,77,34,80,68,251,82,68,79,67,68,73,251,79,68,72,64,74,80,79,7,251,75,77,74,62,64,64,63,68,73,66,251,60,73,84,82,60,84},37))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({42,61,69,64,62,79,68,81,64,78,251,34,48,36,251,65,74,80,73,63,251,8,251,78,79,60,66,64,251,71,74,60,63,64,63},37))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({42,61,69,64,62,79,68,81,64,78,251,34,48,36,251,73,74,79,251,65,74,80,73,63,251,82,68,79,67,68,73,251,79,68,72,64,74,80,79,7,251,75,77,74,62,64,64,63,68,73,66,251,60,73,84,82,60,84},37))
return
end
end
end)
if not ok then debug(_d({82,60,68,79,33,74,77,42,61,69,64,62,79,68,81,64,78,34,80,68,251,64,77,77,74,77,21},37), err) end
end
local function runPlan()
debug(_d({43,71,60,73,251,78,79,60,77,79,64,63},37))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({46,79,60,77,79,68,73,66,251,73,60,81,251,71,74,74,75},37))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({75,74,78,251,11,9,13,78,251,28,33,47,32,45,251,78,79,60,77,79,41,60,81,21},37), rootAfter and rootAfter.Position)
end)
debug(_d({50,60,68,79,68,73,66,251,16,78,251,61,64,65,74,77,64,251,72,74,81,68,73,66,251,79,74,251,46,79,60,66,64,12},37))
task.wait(5)
for _, stage in ipairs({_d({46,79,60,66,64,12},37), _d({46,79,60,66,64,13},37), _d({46,79,60,66,64,14},37), _d({46,79,60,66,64,14,29},37)}) do
if not enabled then return end
local hpTarget = (stage == _d({46,79,60,66,64,14,29},37)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({40,74,81,68,73,66,251,79,74,251,60,77,77,74,82,251,65,71,84,8,63,74,82,73,251,60,77,64,60,251,3,30,80,75,68,63,251,45,60,68,73,4},37))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({31,74,63,66,68,73,66,251,60,77,77,74,82,251,77,60,68,73,251,68,73,251,60,251,78,76,80,60,77,64},37))
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
clearStage(_d({46,79,60,66,64,15},37))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({44,80,64,64,73,251,68,73,251,75,67,60,78,64,251,13,251,8,251,70,64,64,75,68,73,66,251,38,64,73,251,35,60,70,68,251,60,62,79,68,81,64,251,65,77,74,72,251,67,64,77,64,251,74,73},37))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({46,79,60,79,80,64,12},37))
if not enabled then return end
recheckStatue(_d({46,79,60,79,80,64,12},37))
destroyStatue(_d({46,79,60,79,80,64,13},37))
if not enabled then return end
recheckStatue(_d({46,79,60,79,80,64,12},37))
recheckStatue(_d({46,79,60,79,80,64,13},37))
destroyStatue(_d({46,79,60,79,80,64,14},37))
if not enabled then return end
recheckStatue(_d({46,79,60,79,80,64,14},37))
recheckStatue(_d({46,79,60,79,80,64,13},37))
recheckStatue(_d({46,79,60,79,80,64,12},37))
if not enabled then return end
debug(_d({50,60,68,79,68,73,66,251,65,74,77,251,75,67,60,78,64,251,13,251,79,74,251,64,73,63},37))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({43,67,60,78,64,251,13,251,64,73,63,251,82,60,68,79,251,79,68,72,64,74,80,79,7,251,75,77,74,62,64,64,63,68,73,66,251,60,73,84,82,60,84},37))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({40,74,81,68,73,66,251,61,60,62,70,251,79,74,251,44,80,64,64,73,251,78,79,60,66,64,251,75,74,78,68,79,68,74,73},37))
navToPointConfirmed(COORDS.Queen, 30, _d({44,80,64,64,73,251,78,79,60,66,64,251,75,74,78,68,79,68,74,73},37))
debug(_d({50,60,68,79,68,73,66,251,16,78,251,60,79,251,44,80,64,64,73,251,78,79,60,66,64,251,75,74,78,68,79,68,74,73},37))
task.wait(5)
if not enabled then return end
debug(_d({40,74,81,68,73,66,251,79,74,251,75,74,78,79,8,44,80,64,64,73,251,75,74,78,68,79,68,74,73},37))
navToPointConfirmed(COORDS.PostQueen, 30, _d({75,74,78,79,8,44,80,64,64,73,251,75,74,78,68,79,68,74,73},37))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({32,73,60,61,71,68,73,66,7,251,75,74,78,251,29,32,33,42,45,32,251,75,71,60,73,21},37), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({43,71,60,73,251,64,77,77,74,77,21},37), err2) end
end)
debug(_d({32,73,60,61,71,64,63,21},37), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({32,73,60,61,71,64,63,21},37), enabled)
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
if not ok then debug(_d({36,73,75,80,79,29,64,66,60,73,251,64,77,77,74,77,21},37), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({34,60,72,64,251,71,74,60,63,64,63,7,251,60,80,79,74,8,78,79,60,77,79,68,73,66,251,79,67,64,251,75,71,60,73},37))
enableBot()
end)
if not ok then debug(_d({28,80,79,74,78,79,60,77,79,251,64,77,77,74,77,21},37), err) end
end)
debug(_d({39,74,60,63,64,63,251,189,91,111,251,60,80,79,74,8,78,79,60,77,79,68,73,66,251,74,73,62,64,251,79,67,64,251,66,60,72,64,251,65,68,73,68,78,67,64,78,251,71,74,60,63,68,73,66,251,3,75,77,64,78,78,251,43,251,79,74,251,79,74,66,66,71,64,251,72,60,73,80,60,71,71,84,4},37))
end)()