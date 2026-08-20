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
local Players            = game:GetService(_d({40,68,57,81,61,74,75},40))
local UserInputService    = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
local RunService          = game:GetService(_d({42,77,70,43,61,74,78,65,59,61},40))
local VIM                 = game:GetService(_d({46,65,74,76,77,57,68,33,70,72,77,76,37,57,70,57,63,61,74},40))
local ReplicatedStorage    = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({51,26,71,75,75,26,71,76,53},40), _d({47,74,71,70,63,248,63,57,69,61,248,186,88,108,248,40,68,57,59,61,33,60,18},40), game.PlaceId, _d({45,70,65,78,61,74,75,61,33,60,18},40), game.GameId, _d({5,248,70,71,76,248,74,77,70,70,65,70,63},40))
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
local LEO_PILLAR_ANIM_ID   = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,13,10,12,12,9,12,9,11,10,15},40)
local LEO_ENTEI_ANIM_ID    = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,13,10,12,12,9,11,16,10,15,16},40)
local LEO_HIKEN_ANIM_ID    = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,13,10,10,8,17,9,15,12,8,15},40)
local LEO_FIREFLY_ANIM_ID  = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,13,10,10,8,10,11,14,9,13,12},40)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({39,58,66,61,59,76,65,78,61,75},40)
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
local REPLAY_BUTTON_VALUE   = _d({42,61,72,68,57,81},40)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({69,71,78,61},40)
local NavState   = {mode = _d({65,60,68,61},40)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({51,26,71,75,75,26,71,76,53},40), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end)
if ok then return root end
debug(_d({63,61,76,42,71,71,76,248,61,74,74,71,74,18},40), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
end)
if ok then return hum end
debug(_d({63,61,76,32,77,69,57,70,71,65,60,248,61,74,74,71,74,18},40), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({55,55,32,71,78,61,74,25,76,76},40)) or Instance.new(_d({25,76,76,57,59,64,69,61,70,76},40))
att.Name = _d({55,55,32,71,78,61,74,25,76,76},40)
att.Parent = root
local force = root:FindFirstChild(_d({55,55,32,71,78,61,74,30,71,74,59,61},40))
if not force then
force = Instance.new(_d({36,65,70,61,57,74,46,61,68,71,59,65,76,81},40))
force.Name = _d({55,55,32,71,78,61,74,30,71,74,59,61},40)
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
debug(_d({63,61,76,39,74,27,74,61,57,76,61,30,71,74,59,61,248,61,74,74,71,74,18},40), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not root then return end
local force = root:FindFirstChild(_d({55,55,32,71,78,61,74,30,71,74,59,61},40))
local att   = root:FindFirstChild(_d({55,55,32,71,78,61,74,25,76,76},40))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({59,68,61,57,70,77,72,30,71,74,59,61,248,61,74,74,71,74,18},40), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({26,77,75,71,37,61,68,61,61},40)) ~= nil
end)
if ok then return result end
debug(_d({65,75,26,77,75,71,25,59,76,65,78,61,248,61,74,74,71,74,18},40), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({26,77,75,71},40))
end)
if not ok then debug(_d({57,59,76,65,78,57,76,61,26,77,75,71,248,61,74,74,71,74,18},40), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({26,77,75,71,248,70,71,76,248,57,59,76,65,78,61,4,248,57,59,76,65,78,57,76,65,70,63},40))
activateBuso()
end
end)
if not ok then debug(_d({26,77,75,71,35,61,61,72,61,74,248,61,74,74,71,74,18},40), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({26,77,75,71,248,67,61,61,72,61,74,248,75,76,71,72,72,61,60},40))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({35,61,70,32,57,67,65},40)) ~= nil
end)
if ok then return result end
debug(_d({65,75,35,61,70,25,59,76,65,78,61,248,61,74,74,71,74,18},40), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({35,61,70},40), true)
end)
if not ok then debug(_d({57,59,76,65,78,57,76,61,35,61,70,248,61,74,74,71,74,18},40), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({35,61,70,248,70,71,76,248,57,59,76,65,78,61,4,248,57,59,76,65,78,57,76,65,70,63},40))
activateKen()
end
end)
if not ok then debug(_d({35,61,70,35,61,61,72,61,74,248,61,74,74,71,74,18},40), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({35,61,70,248,67,61,61,72,61,74,248,75,76,71,72,72,61,60},40))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({38,40,27,75},40)) end)
if ok then return folder end
debug(_d({63,61,76,38,40,27,75,30,71,68,60,61,74,248,61,74,74,71,74,18},40), folder)
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
local r = model:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local h = model:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
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
debug(_d({63,61,76,38,61,57,74,61,75,76,38,40,27,248,61,74,74,71,74,18},40), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
local hum  = model:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({63,61,76,38,40,27,26,81,38,57,69,61,248,61,74,74,71,74,18},40), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({70,72,59,75,42,61,69,57,65,70,65,70,63,248,61,74,74,71,74,18},40), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({27,77,72,65,60,248,41,77,61,61,70},40))
return queen ~= nil and queen:FindFirstChild(_d({69,71,76,65,71,70,36,61,75,75},40)) ~= nil
end)
if ok then return result end
debug(_d({65,75,41,77,61,61,70,40,64,57,75,61,10,248,61,74,74,71,74,18},40), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,9,10,9,10,17,15,17,12,10,10,17,10,15,14,17},40)
local QUEEN_GRASP_ANIM_ID   = _d({74,58,80,57,75,75,61,76,65,60,18,7,7,9,10,17,16,8,8,8,14,9,8,8,9,15,11,12},40)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
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
debug(_d({65,75,40,68,57,81,65,70,63,25,70,65,69,30,74,71,69,36,65,75,76,248,61,74,74,71,74,18},40), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({26,68,71,59,67,65,70,63},40)) ~= nil
end)
if ok then return result end
debug(_d({65,75,38,40,27,26,68,71,59,67,65,70,63,248,61,74,74,71,74,18},40), result)
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
debug(_d({72,74,61,60,65,59,76,38,40,27,40,71,75,65,76,65,71,70,248,61,74,74,71,74,18},40), result)
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
debug(_d({38,71,248,60,57,69,57,63,61,248,71,70},40), model.Name, _d({62,71,74},40), NPC_STUCK_TIMEOUT, _d({75,248,5,248,75,79,65,76,59,64,65,70,63,248,76,57,74,63,61,76},40))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({76,74,57,59,67,38,40,27,28,57,69,57,63,61,248,61,74,74,71,74,18},40), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({37,71,60,61,68},40)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({26,57,75,61,40,57,74,76},40)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({63,61,76,37,71,60,61,68,30,57,59,61,40,71,75,248,61,74,74,71,74,18},40), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({29,70,78},40))
local folder = env and env:FindFirstChild(_d({43,76,57,76,77,61,75},40))
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
debug(_d({63,61,76,43,76,57,76,77,61,37,71,60,61,68,38,61,57,74,248,61,74,74,71,74,18},40), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({58,57,74,74,61,68,32,40},40))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({63,61,76,43,76,57,76,77,61,32,40,248,61,74,74,71,74,18},40), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({44,71,71,68},40)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({62,65,70,60,44,71,71,68,26,81,25,76,76,74,65,58,77,76,61,248,61,74,74,71,74,18},40), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({44,71,71,68},40)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({62,65,70,60,44,71,71,68,26,81,38,57,69,61,248,61,74,74,71,74,18},40), tool)
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
if not ok then debug(_d({61,73,77,65,72,44,71,71,68,248,61,74,74,71,74,18},40), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({26,57,59,67,72,57,59,67},40))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({44,71,71,68},40)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({62,65,70,60,44,71,71,68,26,81,27,64,65,68,60,38,57,69,61,248,61,74,74,71,74,18},40), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({43,79,71,74,60,29,73,77,65,72},40))
if sword then
equipTool(sword)
return _d({75,79,71,74,60},40)
end
local melee = findToolByAttribute(_d({37,61,68,61,61,44,71,71,68},40))
if melee then
equipTool(melee)
return _d({69,61,68,61,61},40)
end
debug(_d({38,71,248,75,79,71,74,60,248,71,74,248,69,61,68,61,61,248,76,71,71,68,248,62,71,77,70,60},40))
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
if not ok then debug(_d({59,68,65,59,67,37,9,248,61,74,74,71,74,18},40), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({42,71,67,77,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,61,72,72,71},40), args)
elseif style == _d({26,68,57,59,67,36,61,63},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67},40), args)
elseif style == _d({35,57,69,65,75,64,65,67,65},40) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,57,69,65,75,64,65,67,65,31,61,72,72,71},40), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({43,67,81,248,47,57,68,67,10},40), args)
end
end)
if not ok then debug(_d({65,70,78,71,67,61,31,61,72,72,71,248,61,74,74,71,74,18},40), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({72,74,61,75,75,43,67,65,68,68,42,248,61,74,74,71,74,18},40), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({64,71,68,60,26,68,71,59,67,248,61,74,74,71,74,18},40), err) end
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
if not ok then debug(_d({64,71,68,60,26,68,71,59,67,47,64,65,68,61,248,61,74,74,71,74,18},40), err) end
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
debug(_d({63,61,76,31,57,69,61,31,248,61,74,74,71,74,18},40), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({65,75,42,61,57,68,37,9,26,77,75,81,248,61,74,74,71,74,18},40), result)
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
return char ~= nil and char:FindFirstChild(_d({75,76,77,70},40)) ~= nil
end)
if ok then return result end
debug(_d({65,75,43,76,77,70,70,61,60,248,61,74,74,71,74,18},40), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({72,74,61,75,75,43,76,77,70,26,74,61,57,67,248,61,74,74,71,74,18},40), err) end
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
debug(_d({73,77,61,61,70,28,71,60,63,61,45,70,76,65,68,43,57,62,61,18,248,41,77,61,61,70,248,63,71,70,61,248,5,248,61,70,60,65,70,63,248,60,71,60,63,61,248,61,57,74,68,81},40))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({73,77,61,61,70,28,71,60,63,61,45,70,76,65,68,43,57,62,61,248,75,57,62,61,76,81,248,76,65,69,61,71,77,76},40))
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
local info = getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({41,77,61,61,70,248,59,57,75,76,65,70,63,248,60,61,76,61,59,76,61,60,248,5,248,60,71,60,63,65,70,63,248,0,79,57,76,59,64,61,74,1},40))
queenDodgeUntilSafe(function() return getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40)) end)
if enabled and getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40)) then
setNavNamed(_d({27,77,72,65,60,248,41,77,61,61,70},40))
end
queenDodging = false
end
end)
if not ok then debug(_d({73,77,61,61,70,28,71,60,63,61,47,57,76,59,64,61,74,248,61,74,74,71,74,18},40), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({72,71,65,70,76},40) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({70,72,59},40) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({70,57,69,61,60},40) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({63,61,76,38,57,78,44,57,74,63,61,76,75,248,61,74,74,71,74,18},40), aimR)
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
debug(_d({59,71,69,72,77,76,61,36,71,59,67,61,60,27,30,74,57,69,61,248,61,74,74,71,74,18},40), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({72,71,65,70,76},40), point = pos}
phase = _d({69,71,78,61},40)
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
if not ok then debug(_d({70,57,78,44,71,40,71,65,70,76,248,63,61,72,72,71,248,59,64,61,59,67,248,61,74,74,71,74,18},40), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({70,72,59},40)}
phase = _d({69,71,78,61},40)
end
function setNavNamed(name)
NavState = {mode = _d({70,57,69,61,60},40), name = name}
phase = _d({69,71,78,61},40)
end
local function setNavIdle()
NavState = {mode = _d({65,60,68,61},40)}
phase = _d({69,71,78,61},40)
end
local function hasArrived()
return phase == _d({64,71,78,61,74},40)
end
local function startNav()
phase = _d({69,71,78,61},40)
debug(_d({38,57,78,248,68,71,71,72,248,39,38},40))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({40,68,57,81,61,74,248,60,65,61,60,249,248,43,76,71,72,72,65,70,63,248,58,71,76,6},40))
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
debug(_d({40,68,57,81,61,74,248,65,75,248,76,71,71,248,62,57,74,248,62,74,71,69,248,76,57,74,63,61,76,248,0,22,10,8,8,8,248,75,76,77,60,75,1,6,248,36,65,67,61,68,81,248,74,61,75,72,57,79,70,61,60,248,57,76,248,68,71,58,58,81,6,248,43,76,71,72,72,65,70,63,248,58,71,76,6},40))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({55,55,72,74,61,78,40,71,75},40))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({36,57,74,63,61,248,72,71,75,65,76,65,71,70,248,66,77,69,72,248,60,61,76,61,59,76,61,60,18},40), delta, _d({75,76,77,60,75,6,248,72,74,61,78,40,71,75,21},40), prevPos, _d({70,61,79,40,71,75,21},40), pos)
end
end
force:SetAttribute(_d({55,55,72,74,61,78,40,71,75},40), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({69,71,78,61},40) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({64,71,78,61,74},40)
debug(_d({40,64,57,75,61,18,248,64,71,78,61,74},40))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({249,249,249,248,42,29,30,45,43,33,38,31,248,44,39,248,25,40,40,36,49,248,25,26,38,39,42,37,25,36,248,46,29,36,39,27,33,44,49,18},40), finalVel, _d({57,65,69,21},40), aim, _d({72,71,75,21},40), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({64,71,78,61,74},40) then
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
debug(_d({27,71,69,58,57,76,248,68,71,59,67,248,75,67,65,72,72,61,60,4},40), snapDist, _d({75,76,77,60,75,248,62,74,71,69,248,76,57,74,63,61,76,248,186,88,108,248,62,57,68,68,65,70,63,248,58,57,59,67,248,76,71,248,69,71,78,61},40))
phase = _d({69,71,78,61},40)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({32,61,57,74,76,58,61,57,76,248,61,74,74,71,74,18},40), err) end
end)
end
local function stopNav()
debug(_d({38,57,78,248,68,71,71,72,248,39,30,30},40))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({69,71,78,61},40)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({44,61,80,76,27,64,57,76,43,61,74,78,65,59,61},40))
local channels = TextChatService:FindFirstChild(_d({44,61,80,76,27,64,57,70,70,61,68,75},40))
local channel = channels and channels:FindFirstChild(_d({42,26,48,31,61,70,61,74,57,68},40))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({28,61,62,57,77,68,76,27,64,57,76,43,81,75,76,61,69,27,64,57,76,29,78,61,70,76,75},40))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({43,57,81,37,61,75,75,57,63,61,42,61,73,77,61,75,76},40))
if sayEvent then
sayEvent:FireServer(message, _d({25,68,68},40))
return
end
debug(_d({75,61,70,60,27,64,57,76,37,61,75,75,57,63,61,18,248,70,71,248,44,61,80,76,27,64,57,76,43,61,74,78,65,59,61,6,42,26,48,31,61,70,61,74,57,68,248,71,74,248,68,61,63,57,59,81,248,43,57,81,37,61,75,75,57,63,61,42,61,73,77,61,75,76,248,62,71,77,70,60,248,62,71,74},40), message)
end)
if not ok then debug(_d({75,61,70,60,27,64,57,76,37,61,75,75,57,63,61,248,61,74,74,71,74,18},40), err) end
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
debug(_d({38,71,76,248,69,57,67,65,70,63,248,72,74,71,63,74,61,75,75,248,76,71,79,57,74,60,248,70,57,78,248,76,57,74,63,61,76,248,62,71,74},40), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({75,248,5,248,75,61,70,60,65,70,63,248,7,77,70,75,76,77,59,67},40))
sendChatMessage(_d({7,77,70,75,76,77,59,67},40))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({79,57,65,76,45,70,76,65,68,25,74,74,65,78,61,60,248,76,65,69,61,71,77,76},40))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({70,57,78,44,71,40,71,65,70,76,27,71,70,62,65,74,69,61,60,18},40), label or _d({76,57,74,63,61,76},40), _d({5,248,60,65,60,248,70,71,76,248,57,74,74,65,78,61,248,79,65,76,64,65,70},40), timeout, _d({75,4,248,74,61,76,74,81,65,70,63,248,71,70,59,61},40))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({70,57,78,44,71,40,71,65,70,76,27,71,70,62,65,74,69,61,60,18},40), label or _d({76,57,74,63,61,76},40), _d({5,248,75,76,65,68,68,248,70,71,76,248,57,74,74,65,78,61,60,248,57,62,76,61,74,248,74,61,76,74,81,4,248,72,74,71,59,61,61,60,65,70,63,248,57,70,81,79,57,81},40))
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
if not ok then debug(_d({70,57,78,44,71,40,71,65,70,76,32,71,68,60,65,70,63,26,68,71,59,67,248,67,61,81,5,60,71,79,70,248,61,74,74,71,74,18},40), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({70,57,78,44,71,40,71,65,70,76,32,71,68,60,65,70,63,26,68,71,59,67,248,67,61,81,5,77,72,248,61,74,74,71,74,18},40), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({47,57,68,67,65,70,63,248,76,71,18},40), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({79,57,68,67,44,71,40,71,65,70,76,248,47,248,60,71,79,70,248,61,74,74,71,74,18},40), err) end
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
debug(_d({44,71,71,67,248,60,57,69,57,63,61,248,79,64,65,68,61,248,79,57,68,67,65,70,63,248,76,71,248,72,71,65,70,76,249,248,43,76,71,72,72,65,70,63,248,79,57,68,67,248,76,71,248,61,70,63,57,63,61,6},40))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({25,74,74,65,78,61,60,248,57,76,18},40), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({43,76,77,59,67,248,60,77,74,65,70,63,248,79,57,68,67,4,248,66,77,69,72,65,70,63,249},40))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({43,76,65,68,68,248,75,76,77,59,67,4,248,76,74,65,63,63,61,74,65,70,63,248,31,61,72,72,71,249},40))
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
debug(_d({37,71,78,65,70,63,248,76,71},40), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({47,57,65,76,65,70,63,248,62,71,74,248,38,40,27,75,248,76,71,248,75,72,57,79,70,248,57,76},40), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({248,248,75,72,57,79,70,248,59,64,61,59,67,18,248,62,71,68,60,61,74,248,61,80,65,75,76,75,248,21},40), folder ~= nil,
_d({4,248,59,64,65,68,60,74,61,70,248,21},40), folder and #folder:GetChildren() or 0,
_d({4,248,57,68,65,78,61,248,21},40), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({38,71,248,38,40,27,75,248,57,72,72,61,57,74,61,60,248,57,76},40), stageName, _d({57,62,76,61,74,248,9,13,75,4,248,69,71,78,65,70,63,248,71,70,248,57,70,81,79,57,81},40))
break
end
end
debug(_d({35,65,68,68,65,70,63,248,38,40,27,75,248,57,76},40), stageName)
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
debug(_d({42,61,76,77,74,70,65,70,63,248,76,71},40), stageName, _d({72,71,75,65,76,65,71,70,248,58,61,62,71,74,61,248,69,71,78,65,70,63,248,71,70},40))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({47,57,65,76,65,70,63,248,13,75,248,57,76},40), stageName, _d({72,71,75,65,76,65,71,70},40))
task.wait(5)
debug(_d({47,57,65,76,65,70,63,248,62,71,74},40), targetHP * 100, _d({253,248,32,40,248,58,61,62,71,74,61,248,69,71,78,65,70,63,248,76,71,248,70,61,80,76,248,75,76,57,63,61},40))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({59,68,61,57,74,61,60},40))
end
local function killNamedNPC(name, targetPos)
debug(_d({37,71,78,65,70,63,248,76,71},40), name)
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
debug(name, _d({60,61,62,61,57,76,61,60},40))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({32,77,69,57,70,71,65,60},40))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({36,61,71,248,72,68,57,81,61,60,248,57,70,65,69,57,76,65,71,70,18},40), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({68,61,71,25,70,65,69,36,71,63,63,61,74,248,72,74,65,70,76,248,61,74,74,71,74,18},40), err2) end
end)
end)
if not ok then debug(_d({75,76,57,74,76,36,61,71,25,70,65,69,36,71,63,63,61,74,248,61,74,74,71,74,18},40), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({37,71,78,65,70,63,248,76,71,248,36,61,71},40))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({36,61,71},40))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({36,61,71},40))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({36,61,71},40))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({36,61,71,248,59,57,75,76,65,70,63},40), which, _d({5,248,60,71,60,63,65,70,63},40))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({36,61,71,248,75,76,57,74,76,61,60,248,58,68,71,59,67,5,58,74,61,57,67,61,74,248,69,65,60,5,58,68,71,59,67,249,248,29,78,57,60,65,70,63,6,6,6},40))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = getRoot()
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
if not getNPCByName(_d({36,61,71},40)) then
debug(_d({36,61,71,248,63,71,70,61,248,69,65,60,5,60,71,60,63,61,248,5,248,61,70,60,65,70,63,248,29,70,76,61,65,248,64,71,68,60,248,61,57,74,68,81},40))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({36,61,71},40)) then
setNavNamed(_d({36,61,71},40))
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
debug(_d({36,61,71,248,60,61,62,61,57,76,61,60},40))
stopLeoAnimLogger()
debug(_d({42,61,76,77,74,70,65,70,63,248,76,71,248,36,61,71,248,72,71,75,65,76,65,71,70,248,58,61,62,71,74,61,248,69,71,78,65,70,63,248,71,70},40))
navToPointConfirmed(COORDS.Leo, 30, _d({36,61,71,248,72,71,75,65,76,65,71,70},40))
debug(_d({47,57,65,76,65,70,63,248,13,75,248,57,76,248,36,61,71,248,72,71,75,65,76,65,71,70},40))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({37,71,78,65,70,63,248,76,71},40), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({27,71,77,68,60,248,70,71,76,248,62,65,70,60,248,75,76,57,76,77,61,248,69,71,60,61,68,248,70,61,57,74},40), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({25,76,76,57,59,67,65,70,63},40), coordKey, _d({79,65,76,64},40), weapon or _d({70,71,76,64,65,70,63,248,62,71,77,70,60},40))
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
debug(coordKey, _d({58,57,74,74,61,68,248,60,61,75,76,74,71,81,61,60},40))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({74,61,59,64,61,59,67,43,76,57,76,77,61,18},40), coordKey, _d({5,248,59,71,77,68,60,248,70,71,76,248,62,65,70,60,248,75,76,57,76,77,61,248,69,71,60,61,68,4,248,75,67,65,72,72,65,70,63},40))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({74,61,59,64,61,59,67,43,76,57,76,77,61,18},40), coordKey, _d({75,76,65,68,68,248,57,68,65,78,61,248,0,32,40},40), hp, _d({1,248,5,248,74,61,5,60,61,75,76,74,71,81,65,70,63},40))
destroyStatue(coordKey)
else
debug(_d({74,61,59,64,61,59,67,43,76,57,76,77,61,18},40), coordKey, _d({59,71,70,62,65,74,69,61,60,248,60,61,75,76,74,71,81,61,60},40))
end
end)
if not ok then debug(_d({74,61,59,64,61,59,67,43,76,57,76,77,61,248,61,74,74,71,74,18},40), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({37,71,78,65,70,63,248,76,71,248,41,77,61,61,70},40))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({27,77,72,65,60,248,41,77,61,61,70},40))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40))
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
debug(_d({41,77,61,61,70,248,61,70,76,61,74,61,60,248,72,64,57,75,61,248,10},40))
end
local function finishQueen()
debug(_d({30,65,70,65,75,64,65,70,63,248,41,77,61,61,70},40))
equipSwordOrMelee()
setNavNamed(_d({27,77,72,65,60,248,41,77,61,61,70},40))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({27,77,72,65,60,248,41,77,61,61,70},40))
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
debug(_d({41,77,61,61,70,248,60,61,62,61,57,76,61,60,6,248,40,68,57,70,248,59,71,69,72,68,61,76,61,6},40))
end
local CONFIRMATION_PROMPT_NAME = _d({27,71,70,62,65,74,69,57,76,65,71,70,40,74,71,69,72,76},40)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({42,61,69,71,76,61,29,78,61,70,76},40), 5)
end)
if ok then return result end
debug(_d({63,61,76,42,61,72,68,57,81,42,61,69,71,76,61,248,61,74,74,71,74,18},40), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({40,68,57,81,61,74,31,77,65},40))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({33,69,57,63,61,26,77,76,76,71,70},40)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({58,77,76,76,71,70,46,57,68,77,61},40)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({62,65,70,60,26,77,76,76,71,70,26,81,46,57,68,77,61,248,61,74,74,71,74,18},40), result)
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
if not ok then debug(_d({59,68,65,59,67,31,77,65,26,77,76,76,71,70,248,61,74,74,71,74,18},40), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({65,75,43,61,74,78,61,74},40))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({42,61,69,71,76,61,29,78,61,70,76},40))
or inst:FindFirstChild(_d({59,68,65,61,70,76,29,78,61,70,76},40))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({62,65,70,60,25,70,75,79,61,74,27,71,70,70,61,59,76,71,74,248,61,74,74,71,74,18},40), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({27,71,77,68,60,248,70,71,76,248,68,71,59,57,76,61,248,42,61,69,71,76,61,29,78,61,70,76,7,59,68,65,61,70,76,29,78,61,70,76,248,70,61,57,74,248,42,61,72,68,57,81,248,58,77,76,76,71,70,4,248,62,57,68,68,65,70,63,248,58,57,59,67,248,76,71,248,59,68,65,59,67},40))
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
debug(_d({62,65,74,61,42,61,72,68,57,81,46,57,68,77,61,248,61,74,74,71,74,18},40), err, _d({5,248,62,57,68,68,65,70,63,248,58,57,59,67,248,76,71,248,59,68,65,59,67},40))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({30,57,68,68,65,70,63,248,58,57,59,67,248,76,71,248,58,77,76,76,71,70,46,57,68,77,61,248,75,61,57,74,59,64,248,62,71,74,248,42,61,72,68,57,81},40))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({42,61,72,68,57,81,248,58,77,76,76,71,70,248,70,71,76,248,62,71,77,70,60,248,61,65,76,64,61,74,4,248,63,65,78,65,70,63,248,77,72},40))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({47,57,65,76,65,70,63,248,62,71,74,248,27,71,70,62,65,74,69,57,76,65,71,70,40,74,71,69,72,76,6,42,61,69,71,76,61,29,78,61,70,76},40))
local remote = getReplayRemote()
if not remote then
debug(_d({27,71,70,62,65,74,69,57,76,65,71,70,40,74,71,69,72,76,7,42,61,69,71,76,61,29,78,61,70,76,248,70,71,76,248,62,71,77,70,60,248,79,65,76,64,65,70,248,76,65,69,61,71,77,76},40))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({30,65,74,65,70,63,248,42,61,72,68,57,81,248,78,65,57,248,27,71,70,62,65,74,69,57,76,65,71,70,40,74,71,69,72,76,6,42,61,69,71,76,61,29,78,61,70,76},40))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({30,65,74,61,43,61,74,78,61,74,248,61,74,74,71,74,18},40), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({40,68,57,81,61,74,31,77,65},40), 10)
if not playerGui then
debug(_d({79,57,65,76,30,71,74,39,58,66,61,59,76,65,78,61,75,31,77,65,18,248,70,71,248,40,68,57,81,61,74,31,77,65,248,79,65,76,64,65,70,248,76,65,69,61,71,77,76,4,248,72,74,71,59,61,61,60,65,70,63,248,57,70,81,79,57,81},40))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({39,58,66,61,59,76,65,78,61,75,248,31,45,33,248,62,71,77,70,60,248,5,248,75,76,57,63,61,248,68,71,57,60,61,60},40))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({39,58,66,61,59,76,65,78,61,75,248,31,45,33,248,70,71,76,248,62,71,77,70,60,248,79,65,76,64,65,70,248,76,65,69,61,71,77,76,4,248,72,74,71,59,61,61,60,65,70,63,248,57,70,81,79,57,81},40))
return
end
end
end)
if not ok then debug(_d({79,57,65,76,30,71,74,39,58,66,61,59,76,65,78,61,75,31,77,65,248,61,74,74,71,74,18},40), err) end
end
local function runPlan()
debug(_d({40,68,57,70,248,75,76,57,74,76,61,60},40))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({43,76,57,74,76,65,70,63,248,70,57,78,248,68,71,71,72},40))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({72,71,75,248,8,6,10,75,248,25,30,44,29,42,248,75,76,57,74,76,38,57,78,18},40), rootAfter and rootAfter.Position)
end)
debug(_d({47,57,65,76,65,70,63,248,13,75,248,58,61,62,71,74,61,248,69,71,78,65,70,63,248,76,71,248,43,76,57,63,61,9},40))
task.wait(5)
for _, stage in ipairs({_d({43,76,57,63,61,9},40), _d({43,76,57,63,61,10},40), _d({43,76,57,63,61,11},40), _d({43,76,57,63,61,11,26},40)}) do
if not enabled then return end
local hpTarget = (stage == _d({43,76,57,63,61,11,26},40)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({37,71,78,65,70,63,248,76,71,248,57,74,74,71,79,248,62,68,81,5,60,71,79,70,248,57,74,61,57,248,0,27,77,72,65,60,248,42,57,65,70,1},40))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({28,71,60,63,65,70,63,248,57,74,74,71,79,248,74,57,65,70,248,65,70,248,57,248,75,73,77,57,74,61},40))
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
clearStage(_d({43,76,57,63,61,12},40))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({41,77,61,61,70,248,65,70,248,72,64,57,75,61,248,10,248,5,248,67,61,61,72,65,70,63,248,35,61,70,248,32,57,67,65,248,57,59,76,65,78,61,248,62,74,71,69,248,64,61,74,61,248,71,70},40))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({43,76,57,76,77,61,9},40))
if not enabled then return end
recheckStatue(_d({43,76,57,76,77,61,9},40))
destroyStatue(_d({43,76,57,76,77,61,10},40))
if not enabled then return end
recheckStatue(_d({43,76,57,76,77,61,9},40))
recheckStatue(_d({43,76,57,76,77,61,10},40))
destroyStatue(_d({43,76,57,76,77,61,11},40))
if not enabled then return end
recheckStatue(_d({43,76,57,76,77,61,11},40))
recheckStatue(_d({43,76,57,76,77,61,10},40))
recheckStatue(_d({43,76,57,76,77,61,9},40))
if not enabled then return end
debug(_d({47,57,65,76,65,70,63,248,62,71,74,248,72,64,57,75,61,248,10,248,76,71,248,61,70,60},40))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({40,64,57,75,61,248,10,248,61,70,60,248,79,57,65,76,248,76,65,69,61,71,77,76,4,248,72,74,71,59,61,61,60,65,70,63,248,57,70,81,79,57,81},40))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({37,71,78,65,70,63,248,58,57,59,67,248,76,71,248,41,77,61,61,70,248,75,76,57,63,61,248,72,71,75,65,76,65,71,70},40))
navToPointConfirmed(COORDS.Queen, 30, _d({41,77,61,61,70,248,75,76,57,63,61,248,72,71,75,65,76,65,71,70},40))
debug(_d({47,57,65,76,65,70,63,248,13,75,248,57,76,248,41,77,61,61,70,248,75,76,57,63,61,248,72,71,75,65,76,65,71,70},40))
task.wait(5)
if not enabled then return end
debug(_d({37,71,78,65,70,63,248,76,71,248,72,71,75,76,5,41,77,61,61,70,248,72,71,75,65,76,65,71,70},40))
navToPointConfirmed(COORDS.PostQueen, 30, _d({72,71,75,76,5,41,77,61,61,70,248,72,71,75,65,76,65,71,70},40))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({29,70,57,58,68,65,70,63,4,248,72,71,75,248,26,29,30,39,42,29,248,72,68,57,70,18},40), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({40,68,57,70,248,61,74,74,71,74,18},40), err2) end
end)
debug(_d({29,70,57,58,68,61,60,18},40), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({29,70,57,58,68,61,60,18},40), enabled)
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
if not ok then debug(_d({33,70,72,77,76,26,61,63,57,70,248,61,74,74,71,74,18},40), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({31,57,69,61,248,68,71,57,60,61,60,4,248,57,77,76,71,5,75,76,57,74,76,65,70,63,248,76,64,61,248,72,68,57,70},40))
enableBot()
end)
if not ok then debug(_d({25,77,76,71,75,76,57,74,76,248,61,74,74,71,74,18},40), err) end
end)
debug(_d({36,71,57,60,61,60,248,186,88,108,248,57,77,76,71,5,75,76,57,74,76,65,70,63,248,71,70,59,61,248,76,64,61,248,63,57,69,61,248,62,65,70,65,75,64,61,75,248,68,71,57,60,65,70,63,248,0,72,74,61,75,75,248,40,248,76,71,248,76,71,63,63,68,61,248,69,57,70,77,57,68,68,81,1},40))
end)()