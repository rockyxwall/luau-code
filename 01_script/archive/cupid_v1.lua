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
local Players            = game:GetService(_d({48,76,65,89,69,82,83},32))
local UserInputService    = game:GetService(_d({53,83,69,82,41,78,80,85,84,51,69,82,86,73,67,69},32))
local RunService          = game:GetService(_d({50,85,78,51,69,82,86,73,67,69},32))
local VIM                 = game:GetService(_d({54,73,82,84,85,65,76,41,78,80,85,84,45,65,78,65,71,69,82},32))
local ReplicatedStorage    = game:GetService(_d({50,69,80,76,73,67,65,84,69,68,51,84,79,82,65,71,69},32))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({59,34,79,83,83,34,79,84,61},32), _d({55,82,79,78,71,0,71,65,77,69,0,194,96,116,0,48,76,65,67,69,41,68,26},32), game.PlaceId, _d({53,78,73,86,69,82,83,69,41,68,26},32), game.GameId, _d({13,0,78,79,84,0,82,85,78,78,73,78,71},32))
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
local function getRoot()
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
local root = getRoot()
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
local function invokeGeppo()
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
debug(_d({81,85,69,69,78,36,79,68,71,69,53,78,84,73,76,51,65,70,69,26,0,49,85,69,69,78,0,71,79,78,69,0,13,0,69,78,68,73,78,71,0,68,79,68,71,69,0,69,65,82,76,89},32))
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
local function clearStage(stageName)
debug(_d({45,79,86,73,78,71,0,84,79},32), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
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
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({50,69,84,85,82,78,73,78,71,0,84,79},32), stageName, _d({80,79,83,73,84,73,79,78,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,79,78},32))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,65,84},32), stageName, _d({80,79,83,73,84,73,79,78},32))
task.wait(5)
debug(stageName, _d({67,76,69,65,82,69,68},32))
end
local function killNamedNPC(name, targetPos)
debug(_d({45,79,86,73,78,71,0,84,79},32), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
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
debug(_d({45,79,86,73,78,71,0,84,79,0,44,69,79,0,8,66,76,79,67,75,73,78,71,0,65,70,84,69,82},32), LEO_BLOCK_DELAY, _d({83,9},32))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({44,69,79},32))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({44,69,79},32))
while enabled do
local info = getNPCByName(_d({44,69,79},32))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({44,69,79,0,67,65,83,84,73,78,71},32), which, _d({13,0,68,79,68,71,73,78,71},32))
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
if not getNPCByName(_d({44,69,79},32)) then
debug(_d({44,69,79,0,71,79,78,69,0,77,73,68,13,68,79,68,71,69,0,13,0,69,78,68,73,78,71,0,37,78,84,69,73,0,72,79,76,68,0,69,65,82,76,89},32))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({44,69,79},32)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({44,69,79,0,71,79,78,69,0,77,73,68,13,68,79,68,71,69,0,13,0,69,78,68,73,78,71,0,38,76,65,77,69,0,48,73,76,76,65,82,0,72,79,76,68,0,69,65,82,76,89},32))
end
end
end
if enabled and getNPCByName(_d({44,69,79},32)) then
setNavNamed(_d({44,69,79},32))
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
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({35,85,80,73,68,0,49,85,69,69,78},32))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
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
while enabled and getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({35,85,80,73,68,0,49,85,69,69,78},32))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
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
local rootAfter = getRoot()
debug(_d({80,79,83,0,16,14,18,83,0,33,38,52,37,50,0,83,84,65,82,84,46,65,86,26},32), rootAfter and rootAfter.Position)
end)
debug(_d({55,65,73,84,73,78,71,0,21,83,0,66,69,70,79,82,69,0,77,79,86,73,78,71,0,84,79,0,51,84,65,71,69,17},32))
task.wait(5)
for _, stage in ipairs({_d({51,84,65,71,69,17},32), _d({51,84,65,71,69,18},32), _d({51,84,65,71,69,19},32), _d({51,84,65,71,69,19,34},32)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({45,79,86,73,78,71,0,84,79,0,65,82,82,79,87,0,70,76,89,13,68,79,87,78,0,65,82,69,65},32))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({36,79,68,71,73,78,71,0,65,82,82,79,87,0,82,65,73,78},32))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
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
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
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
if not ok then debug(_d({41,78,80,85,84,34,69,71,65,78,0,69,82,82,79,82,26},32), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({39,65,77,69,0,76,79,65,68,69,68,12,0,65,85,84,79,13,83,84,65,82,84,73,78,71,0,84,72,69,0,80,76,65,78},32))
enableBot()
end)
if not ok then debug(_d({33,85,84,79,83,84,65,82,84,0,69,82,82,79,82,26},32), err) end
end)
debug(_d({44,79,65,68,69,68,0,194,96,116,0,65,85,84,79,13,83,84,65,82,84,73,78,71,0,79,78,67,69,0,84,72,69,0,71,65,77,69,0,70,73,78,73,83,72,69,83,0,76,79,65,68,73,78,71,0,8,80,82,69,83,83,0,48,0,84,79,0,84,79,71,71,76,69,0,77,65,78,85,65,76,76,89,9},32))
end)()