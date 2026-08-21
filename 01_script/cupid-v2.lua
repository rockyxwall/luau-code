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
local Players            = game:GetService(_d({65,93,82,106,86,99,100},15))
local UserInputService    = game:GetService(_d({70,100,86,99,58,95,97,102,101,68,86,99,103,90,84,86},15))
local RunService          = game:GetService(_d({67,102,95,68,86,99,103,90,84,86},15))
local VIM                 = game:GetService(_d({71,90,99,101,102,82,93,58,95,97,102,101,62,82,95,82,88,86,99},15))
local ReplicatedStorage    = game:GetService(_d({67,86,97,93,90,84,82,101,86,85,68,101,96,99,82,88,86},15))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({76,51,96,100,100,51,96,101,78},15), _d({72,99,96,95,88,17,88,82,94,86,17,211,113,133,17,65,93,82,84,86,58,85,43},15), game.PlaceId, _d({70,95,90,103,86,99,100,86,58,85,43},15), game.GameId, _d({30,17,95,96,101,17,99,102,95,95,90,95,88},15))
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
local LEO_PILLAR_ANIM_ID   = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,38,35,37,37,34,37,34,36,35,40},15)
local LEO_ENTEI_ANIM_ID    = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,38,35,37,37,34,36,41,35,40,41},15)
local LEO_HIKEN_ANIM_ID    = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,38,35,35,33,42,34,40,37,33,40},15)
local LEO_FIREFLY_ANIM_ID  = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,38,35,35,33,35,36,39,34,38,37},15)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({64,83,91,86,84,101,90,103,86,100},15)
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
local REPLAY_BUTTON_VALUE   = _d({67,86,97,93,82,106},15)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({94,96,103,86},15)
local NavState   = {mode = _d({90,85,93,86},15)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({76,51,96,100,100,51,96,101,78},15), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
end)
if ok then return root end
debug(_d({88,86,101,67,96,96,101,17,86,99,99,96,99,43},15), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
end)
if ok then return hum end
debug(_d({88,86,101,57,102,94,82,95,96,90,85,17,86,99,99,96,99,43},15), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({80,80,57,96,103,86,99,50,101,101},15)) or Instance.new(_d({50,101,101,82,84,89,94,86,95,101},15))
att.Name = _d({80,80,57,96,103,86,99,50,101,101},15)
att.Parent = root
local force = root:FindFirstChild(_d({80,80,57,96,103,86,99,55,96,99,84,86},15))
if not force then
force = Instance.new(_d({61,90,95,86,82,99,71,86,93,96,84,90,101,106},15))
force.Name = _d({80,80,57,96,103,86,99,55,96,99,84,86},15)
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
debug(_d({88,86,101,64,99,52,99,86,82,101,86,55,96,99,84,86,17,86,99,99,96,99,43},15), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not root then return end
local force = root:FindFirstChild(_d({80,80,57,96,103,86,99,55,96,99,84,86},15))
local att   = root:FindFirstChild(_d({80,80,57,96,103,86,99,50,101,101},15))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({84,93,86,82,95,102,97,55,96,99,84,86,17,86,99,99,96,99,43},15), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({51,102,100,96,62,86,93,86,86},15)) ~= nil
end)
if ok then return result end
debug(_d({90,100,51,102,100,96,50,84,101,90,103,86,17,86,99,99,96,99,43},15), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({51,102,100,96},15))
end)
if not ok then debug(_d({82,84,101,90,103,82,101,86,51,102,100,96,17,86,99,99,96,99,43},15), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({51,102,100,96,17,95,96,101,17,82,84,101,90,103,86,29,17,82,84,101,90,103,82,101,90,95,88},15))
activateBuso()
end
end)
if not ok then debug(_d({51,102,100,96,60,86,86,97,86,99,17,86,99,99,96,99,43},15), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({51,102,100,96,17,92,86,86,97,86,99,17,100,101,96,97,97,86,85},15))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({60,86,95,57,82,92,90},15)) ~= nil
end)
if ok then return result end
debug(_d({90,100,60,86,95,50,84,101,90,103,86,17,86,99,99,96,99,43},15), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({60,86,95},15), true)
end)
if not ok then debug(_d({82,84,101,90,103,82,101,86,60,86,95,17,86,99,99,96,99,43},15), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({60,86,95,17,95,96,101,17,82,84,101,90,103,86,29,17,82,84,101,90,103,82,101,90,95,88},15))
activateKen()
end
end)
if not ok then debug(_d({60,86,95,60,86,86,97,86,99,17,86,99,99,96,99,43},15), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({60,86,95,17,92,86,86,97,86,99,17,100,101,96,97,97,86,85},15))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({63,65,52,100},15)) end)
if ok then return folder end
debug(_d({88,86,101,63,65,52,100,55,96,93,85,86,99,17,86,99,99,96,99,43},15), folder)
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
local r = model:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local h = model:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
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
debug(_d({88,86,101,63,86,82,99,86,100,101,63,65,52,17,86,99,99,96,99,43},15), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
local hum  = model:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({88,86,101,63,65,52,51,106,63,82,94,86,17,86,99,99,96,99,43},15), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({95,97,84,100,67,86,94,82,90,95,90,95,88,17,86,99,99,96,99,43},15), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({52,102,97,90,85,17,66,102,86,86,95},15))
return queen ~= nil and queen:FindFirstChild(_d({94,96,101,90,96,95,61,86,100,100},15)) ~= nil
end)
if ok then return result end
debug(_d({90,100,66,102,86,86,95,65,89,82,100,86,35,17,86,99,99,96,99,43},15), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,34,35,34,35,42,40,42,37,35,35,42,35,40,39,42},15)
local QUEEN_GRASP_ANIM_ID   = _d({99,83,105,82,100,100,86,101,90,85,43,32,32,34,35,42,41,33,33,33,39,34,33,33,34,40,36,37},15)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
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
debug(_d({90,100,65,93,82,106,90,95,88,50,95,90,94,55,99,96,94,61,90,100,101,17,86,99,99,96,99,43},15), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({51,93,96,84,92,90,95,88},15)) ~= nil
end)
if ok then return result end
debug(_d({90,100,63,65,52,51,93,96,84,92,90,95,88,17,86,99,99,96,99,43},15), result)
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
debug(_d({97,99,86,85,90,84,101,63,65,52,65,96,100,90,101,90,96,95,17,86,99,99,96,99,43},15), result)
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
debug(_d({63,96,17,85,82,94,82,88,86,17,96,95},15), model.Name, _d({87,96,99},15), NPC_STUCK_TIMEOUT, _d({100,17,30,17,100,104,90,101,84,89,90,95,88,17,101,82,99,88,86,101},15))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({101,99,82,84,92,63,65,52,53,82,94,82,88,86,17,86,99,99,96,99,43},15), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({62,96,85,86,93},15)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({51,82,100,86,65,82,99,101},15)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({88,86,101,62,96,85,86,93,55,82,84,86,65,96,100,17,86,99,99,96,99,43},15), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({54,95,103},15))
local folder = env and env:FindFirstChild(_d({68,101,82,101,102,86,100},15))
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
debug(_d({88,86,101,68,101,82,101,102,86,62,96,85,86,93,63,86,82,99,17,86,99,99,96,99,43},15), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({83,82,99,99,86,93,57,65},15))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({88,86,101,68,101,82,101,102,86,57,65,17,86,99,99,96,99,43},15), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({69,96,96,93},15)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({87,90,95,85,69,96,96,93,51,106,50,101,101,99,90,83,102,101,86,17,86,99,99,96,99,43},15), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({69,96,96,93},15)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({87,90,95,85,69,96,96,93,51,106,63,82,94,86,17,86,99,99,96,99,43},15), tool)
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
if not ok then debug(_d({86,98,102,90,97,69,96,96,93,17,86,99,99,96,99,43},15), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({51,82,84,92,97,82,84,92},15))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({69,96,96,93},15)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({87,90,95,85,69,96,96,93,51,106,52,89,90,93,85,63,82,94,86,17,86,99,99,96,99,43},15), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({68,104,96,99,85,54,98,102,90,97},15))
if sword then
equipTool(sword)
return _d({100,104,96,99,85},15)
end
local melee = findToolByAttribute(_d({62,86,93,86,86,69,96,96,93},15))
if melee then
equipTool(melee)
return _d({94,86,93,86,86},15)
end
debug(_d({63,96,17,100,104,96,99,85,17,96,99,17,94,86,93,86,86,17,101,96,96,93,17,87,96,102,95,85},15))
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
if not ok then debug(_d({84,93,90,84,92,62,34,17,86,99,99,96,99,43},15), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({57,102,94,82,95,96,90,85,67,96,96,101,65,82,99,101},15))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({68,101,82,101,100},15) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({67,96,92,102,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,86,97,97,96},15), args)
elseif style == _d({51,93,82,84,92,61,86,88},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92},15), args)
elseif style == _d({60,82,94,90,100,89,90,92,90},15) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({60,82,94,90,100,89,90,92,90,56,86,97,97,96},15), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({68,92,106,17,72,82,93,92,35},15), args)
end
end)
if not ok then debug(_d({90,95,103,96,92,86,56,86,97,97,96,17,86,99,99,96,99,43},15), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({97,99,86,100,100,68,92,90,93,93,67,17,86,99,99,96,99,43},15), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({89,96,93,85,51,93,96,84,92,17,86,99,99,96,99,43},15), err) end
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
if not ok then debug(_d({89,96,93,85,51,93,96,84,92,72,89,90,93,86,17,86,99,99,96,99,43},15), err) end
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
debug(_d({88,86,101,56,82,94,86,56,17,86,99,99,96,99,43},15), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({90,100,67,86,82,93,62,34,51,102,100,106,17,86,99,99,96,99,43},15), result)
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
return char ~= nil and char:FindFirstChild(_d({100,101,102,95},15)) ~= nil
end)
if ok then return result end
debug(_d({90,100,68,101,102,95,95,86,85,17,86,99,99,96,99,43},15), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({97,99,86,100,100,68,101,102,95,51,99,86,82,92,17,86,99,99,96,99,43},15), err) end
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
debug(_d({98,102,86,86,95,53,96,85,88,86,70,95,101,90,93,68,82,87,86,43,17,66,102,86,86,95,17,88,96,95,86,17,30,17,86,95,85,90,95,88,17,85,96,85,88,86,17,86,82,99,93,106},15))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({98,102,86,86,95,53,96,85,88,86,70,95,101,90,93,68,82,87,86,17,100,82,87,86,101,106,17,101,90,94,86,96,102,101},15))
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
local info = getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({66,102,86,86,95,17,84,82,100,101,90,95,88,17,85,86,101,86,84,101,86,85,17,30,17,85,96,85,88,90,95,88,17,25,104,82,101,84,89,86,99,26},15))
queenDodgeUntilSafe(function() return getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15)) end)
if enabled and getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15)) then
setNavNamed(_d({52,102,97,90,85,17,66,102,86,86,95},15))
end
queenDodging = false
end
end)
if not ok then debug(_d({98,102,86,86,95,53,96,85,88,86,72,82,101,84,89,86,99,17,86,99,99,96,99,43},15), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({97,96,90,95,101},15) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({95,97,84},15) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({95,82,94,86,85},15) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({88,86,101,63,82,103,69,82,99,88,86,101,100,17,86,99,99,96,99,43},15), aimR)
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
debug(_d({84,96,94,97,102,101,86,61,96,84,92,86,85,52,55,99,82,94,86,17,86,99,99,96,99,43},15), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({97,96,90,95,101},15), point = pos}
phase = _d({94,96,103,86},15)
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
if not ok then debug(_d({95,82,103,69,96,65,96,90,95,101,17,88,86,97,97,96,17,84,89,86,84,92,17,86,99,99,96,99,43},15), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({95,97,84},15)}
phase = _d({94,96,103,86},15)
end
function setNavNamed(name)
NavState = {mode = _d({95,82,94,86,85},15), name = name}
phase = _d({94,96,103,86},15)
end
local function setNavIdle()
NavState = {mode = _d({90,85,93,86},15)}
phase = _d({94,96,103,86},15)
end
local function hasArrived()
return phase == _d({89,96,103,86,99},15)
end
local function startNav()
phase = _d({94,96,103,86},15)
debug(_d({63,82,103,17,93,96,96,97,17,64,63},15))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({65,93,82,106,86,99,17,85,90,86,85,18,17,68,101,96,97,97,90,95,88,17,83,96,101,31},15))
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
debug(_d({65,93,82,106,86,99,17,90,100,17,101,96,96,17,87,82,99,17,87,99,96,94,17,101,82,99,88,86,101,17,25,47,35,33,33,33,17,100,101,102,85,100,26,31,17,61,90,92,86,93,106,17,99,86,100,97,82,104,95,86,85,17,82,101,17,93,96,83,83,106,31,17,68,101,96,97,97,90,95,88,17,83,96,101,31},15))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({80,80,97,99,86,103,65,96,100},15))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({61,82,99,88,86,17,97,96,100,90,101,90,96,95,17,91,102,94,97,17,85,86,101,86,84,101,86,85,43},15), delta, _d({100,101,102,85,100,31,17,97,99,86,103,65,96,100,46},15), prevPos, _d({95,86,104,65,96,100,46},15), pos)
end
end
force:SetAttribute(_d({80,80,97,99,86,103,65,96,100},15), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({94,96,103,86},15) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({89,96,103,86,99},15)
debug(_d({65,89,82,100,86,43,17,89,96,103,86,99},15))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({18,18,18,17,67,54,55,70,68,58,63,56,17,69,64,17,50,65,65,61,74,17,50,51,63,64,67,62,50,61,17,71,54,61,64,52,58,69,74,43},15), finalVel, _d({82,90,94,46},15), aim, _d({97,96,100,46},15), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({89,96,103,86,99},15) then
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
debug(_d({52,96,94,83,82,101,17,93,96,84,92,17,100,92,90,97,97,86,85,29},15), snapDist, _d({100,101,102,85,100,17,87,99,96,94,17,101,82,99,88,86,101,17,211,113,133,17,87,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,94,96,103,86},15))
phase = _d({94,96,103,86},15)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({57,86,82,99,101,83,86,82,101,17,86,99,99,96,99,43},15), err) end
end)
end
local function stopNav()
debug(_d({63,82,103,17,93,96,96,97,17,64,55,55},15))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({94,96,103,86},15)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({69,86,105,101,52,89,82,101,68,86,99,103,90,84,86},15))
local channels = TextChatService:FindFirstChild(_d({69,86,105,101,52,89,82,95,95,86,93,100},15))
local channel = channels and channels:FindFirstChild(_d({67,51,73,56,86,95,86,99,82,93},15))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({53,86,87,82,102,93,101,52,89,82,101,68,106,100,101,86,94,52,89,82,101,54,103,86,95,101,100},15))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({68,82,106,62,86,100,100,82,88,86,67,86,98,102,86,100,101},15))
if sayEvent then
sayEvent:FireServer(message, _d({50,93,93},15))
return
end
debug(_d({100,86,95,85,52,89,82,101,62,86,100,100,82,88,86,43,17,95,96,17,69,86,105,101,52,89,82,101,68,86,99,103,90,84,86,31,67,51,73,56,86,95,86,99,82,93,17,96,99,17,93,86,88,82,84,106,17,68,82,106,62,86,100,100,82,88,86,67,86,98,102,86,100,101,17,87,96,102,95,85,17,87,96,99},15), message)
end)
if not ok then debug(_d({100,86,95,85,52,89,82,101,62,86,100,100,82,88,86,17,86,99,99,96,99,43},15), err) end
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
debug(_d({63,96,101,17,94,82,92,90,95,88,17,97,99,96,88,99,86,100,100,17,101,96,104,82,99,85,17,95,82,103,17,101,82,99,88,86,101,17,87,96,99},15), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({100,17,30,17,100,86,95,85,90,95,88,17,32,102,95,100,101,102,84,92},15))
sendChatMessage(_d({32,102,95,100,101,102,84,92},15))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({104,82,90,101,70,95,101,90,93,50,99,99,90,103,86,85,17,101,90,94,86,96,102,101},15))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({95,82,103,69,96,65,96,90,95,101,52,96,95,87,90,99,94,86,85,43},15), label or _d({101,82,99,88,86,101},15), _d({30,17,85,90,85,17,95,96,101,17,82,99,99,90,103,86,17,104,90,101,89,90,95},15), timeout, _d({100,29,17,99,86,101,99,106,90,95,88,17,96,95,84,86},15))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({95,82,103,69,96,65,96,90,95,101,52,96,95,87,90,99,94,86,85,43},15), label or _d({101,82,99,88,86,101},15), _d({30,17,100,101,90,93,93,17,95,96,101,17,82,99,99,90,103,86,85,17,82,87,101,86,99,17,99,86,101,99,106,29,17,97,99,96,84,86,86,85,90,95,88,17,82,95,106,104,82,106},15))
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
if not ok then debug(_d({95,82,103,69,96,65,96,90,95,101,57,96,93,85,90,95,88,51,93,96,84,92,17,92,86,106,30,85,96,104,95,17,86,99,99,96,99,43},15), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({95,82,103,69,96,65,96,90,95,101,57,96,93,85,90,95,88,51,93,96,84,92,17,92,86,106,30,102,97,17,86,99,99,96,99,43},15), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({72,82,93,92,90,95,88,17,101,96,43},15), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({104,82,93,92,69,96,65,96,90,95,101,17,72,17,85,96,104,95,17,86,99,99,96,99,43},15), err) end
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
debug(_d({69,96,96,92,17,85,82,94,82,88,86,17,104,89,90,93,86,17,104,82,93,92,90,95,88,17,101,96,17,97,96,90,95,101,18,17,68,101,96,97,97,90,95,88,17,104,82,93,92,17,101,96,17,86,95,88,82,88,86,31},15))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({50,99,99,90,103,86,85,17,82,101,43},15), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({68,101,102,84,92,17,85,102,99,90,95,88,17,104,82,93,92,29,17,91,102,94,97,90,95,88,18},15))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({68,101,90,93,93,17,100,101,102,84,92,29,17,101,99,90,88,88,86,99,90,95,88,17,56,86,97,97,96,18},15))
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
debug(_d({62,96,103,90,95,88,17,101,96},15), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({72,82,90,101,90,95,88,17,87,96,99,17,63,65,52,100,17,101,96,17,100,97,82,104,95,17,82,101},15), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({17,17,100,97,82,104,95,17,84,89,86,84,92,43,17,87,96,93,85,86,99,17,86,105,90,100,101,100,17,46},15), folder ~= nil,
_d({29,17,84,89,90,93,85,99,86,95,17,46},15), folder and #folder:GetChildren() or 0,
_d({29,17,82,93,90,103,86,17,46},15), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({63,96,17,63,65,52,100,17,82,97,97,86,82,99,86,85,17,82,101},15), stageName, _d({82,87,101,86,99,17,34,38,100,29,17,94,96,103,90,95,88,17,96,95,17,82,95,106,104,82,106},15))
break
end
end
debug(_d({60,90,93,93,90,95,88,17,63,65,52,100,17,82,101},15), stageName)
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
debug(_d({67,86,101,102,99,95,90,95,88,17,101,96},15), stageName, _d({97,96,100,90,101,90,96,95,17,83,86,87,96,99,86,17,94,96,103,90,95,88,17,96,95},15))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({72,82,90,101,90,95,88,17,38,100,17,82,101},15), stageName, _d({97,96,100,90,101,90,96,95},15))
task.wait(5)
debug(_d({72,82,90,101,90,95,88,17,87,96,99},15), targetHP * 100, _d({22,17,57,65,17,83,86,87,96,99,86,17,94,96,103,90,95,88,17,101,96,17,95,86,105,101,17,100,101,82,88,86},15))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({84,93,86,82,99,86,85},15))
end
local function killNamedNPC(name, targetPos)
debug(_d({62,96,103,90,95,88,17,101,96},15), name)
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
debug(name, _d({85,86,87,86,82,101,86,85},15))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({57,102,94,82,95,96,90,85},15))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({61,86,96,17,97,93,82,106,86,85,17,82,95,90,94,82,101,90,96,95,43},15), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({93,86,96,50,95,90,94,61,96,88,88,86,99,17,97,99,90,95,101,17,86,99,99,96,99,43},15), err2) end
end)
end)
if not ok then debug(_d({100,101,82,99,101,61,86,96,50,95,90,94,61,96,88,88,86,99,17,86,99,99,96,99,43},15), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({62,96,103,90,95,88,17,101,96,17,61,86,96},15))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({61,86,96},15))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({61,86,96},15))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({61,86,96},15))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({61,86,96,17,84,82,100,101,90,95,88},15), which, _d({30,17,85,96,85,88,90,95,88},15))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({61,86,96,17,100,101,82,99,101,86,85,17,83,93,96,84,92,30,83,99,86,82,92,86,99,17,94,90,85,30,83,93,96,84,92,18,17,54,103,82,85,90,95,88,31,31,31},15))
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
if not getNPCByName(_d({61,86,96},15)) then
debug(_d({61,86,96,17,88,96,95,86,17,94,90,85,30,85,96,85,88,86,17,30,17,86,95,85,90,95,88,17,54,95,101,86,90,17,89,96,93,85,17,86,82,99,93,106},15))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({61,86,96},15)) then
setNavNamed(_d({61,86,96},15))
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
debug(_d({61,86,96,17,85,86,87,86,82,101,86,85},15))
stopLeoAnimLogger()
debug(_d({67,86,101,102,99,95,90,95,88,17,101,96,17,61,86,96,17,97,96,100,90,101,90,96,95,17,83,86,87,96,99,86,17,94,96,103,90,95,88,17,96,95},15))
navToPointConfirmed(COORDS.Leo, 30, _d({61,86,96,17,97,96,100,90,101,90,96,95},15))
debug(_d({72,82,90,101,90,95,88,17,38,100,17,82,101,17,61,86,96,17,97,96,100,90,101,90,96,95},15))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({62,96,103,90,95,88,17,101,96},15), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({52,96,102,93,85,17,95,96,101,17,87,90,95,85,17,100,101,82,101,102,86,17,94,96,85,86,93,17,95,86,82,99},15), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({50,101,101,82,84,92,90,95,88},15), coordKey, _d({104,90,101,89},15), weapon or _d({95,96,101,89,90,95,88,17,87,96,102,95,85},15))
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
debug(coordKey, _d({83,82,99,99,86,93,17,85,86,100,101,99,96,106,86,85},15))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({99,86,84,89,86,84,92,68,101,82,101,102,86,43},15), coordKey, _d({30,17,84,96,102,93,85,17,95,96,101,17,87,90,95,85,17,100,101,82,101,102,86,17,94,96,85,86,93,29,17,100,92,90,97,97,90,95,88},15))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({99,86,84,89,86,84,92,68,101,82,101,102,86,43},15), coordKey, _d({100,101,90,93,93,17,82,93,90,103,86,17,25,57,65},15), hp, _d({26,17,30,17,99,86,30,85,86,100,101,99,96,106,90,95,88},15))
destroyStatue(coordKey)
else
debug(_d({99,86,84,89,86,84,92,68,101,82,101,102,86,43},15), coordKey, _d({84,96,95,87,90,99,94,86,85,17,85,86,100,101,99,96,106,86,85},15))
end
end)
if not ok then debug(_d({99,86,84,89,86,84,92,68,101,82,101,102,86,17,86,99,99,96,99,43},15), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({62,96,103,90,95,88,17,101,96,17,66,102,86,86,95},15))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({52,102,97,90,85,17,66,102,86,86,95},15))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15))
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
debug(_d({66,102,86,86,95,17,86,95,101,86,99,86,85,17,97,89,82,100,86,17,35},15))
end
local function finishQueen()
debug(_d({55,90,95,90,100,89,90,95,88,17,66,102,86,86,95},15))
equipSwordOrMelee()
setNavNamed(_d({52,102,97,90,85,17,66,102,86,86,95},15))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({52,102,97,90,85,17,66,102,86,86,95},15))
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
debug(_d({66,102,86,86,95,17,85,86,87,86,82,101,86,85,31,17,65,93,82,95,17,84,96,94,97,93,86,101,86,31},15))
end
local CONFIRMATION_PROMPT_NAME = _d({52,96,95,87,90,99,94,82,101,90,96,95,65,99,96,94,97,101},15)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({67,86,94,96,101,86,54,103,86,95,101},15), 5)
end)
if ok then return result end
debug(_d({88,86,101,67,86,97,93,82,106,67,86,94,96,101,86,17,86,99,99,96,99,43},15), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({65,93,82,106,86,99,56,102,90},15))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({58,94,82,88,86,51,102,101,101,96,95},15)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({83,102,101,101,96,95,71,82,93,102,86},15)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({87,90,95,85,51,102,101,101,96,95,51,106,71,82,93,102,86,17,86,99,99,96,99,43},15), result)
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
if not ok then debug(_d({84,93,90,84,92,56,102,90,51,102,101,101,96,95,17,86,99,99,96,99,43},15), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({90,100,68,86,99,103,86,99},15))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({67,86,94,96,101,86,54,103,86,95,101},15))
or inst:FindFirstChild(_d({84,93,90,86,95,101,54,103,86,95,101},15))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({87,90,95,85,50,95,100,104,86,99,52,96,95,95,86,84,101,96,99,17,86,99,99,96,99,43},15), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({52,96,102,93,85,17,95,96,101,17,93,96,84,82,101,86,17,67,86,94,96,101,86,54,103,86,95,101,32,84,93,90,86,95,101,54,103,86,95,101,17,95,86,82,99,17,67,86,97,93,82,106,17,83,102,101,101,96,95,29,17,87,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,84,93,90,84,92},15))
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
debug(_d({87,90,99,86,67,86,97,93,82,106,71,82,93,102,86,17,86,99,99,96,99,43},15), err, _d({30,17,87,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,84,93,90,84,92},15))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({55,82,93,93,90,95,88,17,83,82,84,92,17,101,96,17,83,102,101,101,96,95,71,82,93,102,86,17,100,86,82,99,84,89,17,87,96,99,17,67,86,97,93,82,106},15))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({67,86,97,93,82,106,17,83,102,101,101,96,95,17,95,96,101,17,87,96,102,95,85,17,86,90,101,89,86,99,29,17,88,90,103,90,95,88,17,102,97},15))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({72,82,90,101,90,95,88,17,87,96,99,17,52,96,95,87,90,99,94,82,101,90,96,95,65,99,96,94,97,101,31,67,86,94,96,101,86,54,103,86,95,101},15))
local remote = getReplayRemote()
if not remote then
debug(_d({52,96,95,87,90,99,94,82,101,90,96,95,65,99,96,94,97,101,32,67,86,94,96,101,86,54,103,86,95,101,17,95,96,101,17,87,96,102,95,85,17,104,90,101,89,90,95,17,101,90,94,86,96,102,101},15))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({55,90,99,90,95,88,17,67,86,97,93,82,106,17,103,90,82,17,52,96,95,87,90,99,94,82,101,90,96,95,65,99,96,94,97,101,31,67,86,94,96,101,86,54,103,86,95,101},15))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({55,90,99,86,68,86,99,103,86,99,17,86,99,99,96,99,43},15), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({65,93,82,106,86,99,56,102,90},15), 10)
if not playerGui then
debug(_d({104,82,90,101,55,96,99,64,83,91,86,84,101,90,103,86,100,56,102,90,43,17,95,96,17,65,93,82,106,86,99,56,102,90,17,104,90,101,89,90,95,17,101,90,94,86,96,102,101,29,17,97,99,96,84,86,86,85,90,95,88,17,82,95,106,104,82,106},15))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({64,83,91,86,84,101,90,103,86,100,17,56,70,58,17,87,96,102,95,85,17,30,17,100,101,82,88,86,17,93,96,82,85,86,85},15))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({64,83,91,86,84,101,90,103,86,100,17,56,70,58,17,95,96,101,17,87,96,102,95,85,17,104,90,101,89,90,95,17,101,90,94,86,96,102,101,29,17,97,99,96,84,86,86,85,90,95,88,17,82,95,106,104,82,106},15))
return
end
end
end)
if not ok then debug(_d({104,82,90,101,55,96,99,64,83,91,86,84,101,90,103,86,100,56,102,90,17,86,99,99,96,99,43},15), err) end
end
local function runPlan()
debug(_d({65,93,82,95,17,100,101,82,99,101,86,85},15))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({68,101,82,99,101,90,95,88,17,95,82,103,17,93,96,96,97},15))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({97,96,100,17,33,31,35,100,17,50,55,69,54,67,17,100,101,82,99,101,63,82,103,43},15), rootAfter and rootAfter.Position)
end)
debug(_d({72,82,90,101,90,95,88,17,38,100,17,83,86,87,96,99,86,17,94,96,103,90,95,88,17,101,96,17,68,101,82,88,86,34},15))
task.wait(5)
for _, stage in ipairs({_d({68,101,82,88,86,34},15), _d({68,101,82,88,86,35},15), _d({68,101,82,88,86,36},15), _d({68,101,82,88,86,36,51},15)}) do
if not enabled then return end
local hpTarget = (stage == _d({68,101,82,88,86,36,51},15)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({62,96,103,90,95,88,17,101,96,17,82,99,99,96,104,17,87,93,106,30,85,96,104,95,17,82,99,86,82,17,25,52,102,97,90,85,17,67,82,90,95,26},15))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({53,96,85,88,90,95,88,17,82,99,99,96,104,17,99,82,90,95,17,90,95,17,82,17,100,98,102,82,99,86},15))
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
clearStage(_d({68,101,82,88,86,37},15))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({66,102,86,86,95,17,90,95,17,97,89,82,100,86,17,35,17,30,17,92,86,86,97,90,95,88,17,60,86,95,17,57,82,92,90,17,82,84,101,90,103,86,17,87,99,96,94,17,89,86,99,86,17,96,95},15))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({68,101,82,101,102,86,34},15))
if not enabled then return end
recheckStatue(_d({68,101,82,101,102,86,34},15))
destroyStatue(_d({68,101,82,101,102,86,35},15))
if not enabled then return end
recheckStatue(_d({68,101,82,101,102,86,34},15))
recheckStatue(_d({68,101,82,101,102,86,35},15))
destroyStatue(_d({68,101,82,101,102,86,36},15))
if not enabled then return end
recheckStatue(_d({68,101,82,101,102,86,36},15))
recheckStatue(_d({68,101,82,101,102,86,35},15))
recheckStatue(_d({68,101,82,101,102,86,34},15))
if not enabled then return end
debug(_d({72,82,90,101,90,95,88,17,87,96,99,17,97,89,82,100,86,17,35,17,101,96,17,86,95,85},15))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({65,89,82,100,86,17,35,17,86,95,85,17,104,82,90,101,17,101,90,94,86,96,102,101,29,17,97,99,96,84,86,86,85,90,95,88,17,82,95,106,104,82,106},15))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({62,96,103,90,95,88,17,83,82,84,92,17,101,96,17,66,102,86,86,95,17,100,101,82,88,86,17,97,96,100,90,101,90,96,95},15))
navToPointConfirmed(COORDS.Queen, 30, _d({66,102,86,86,95,17,100,101,82,88,86,17,97,96,100,90,101,90,96,95},15))
debug(_d({72,82,90,101,90,95,88,17,38,100,17,82,101,17,66,102,86,86,95,17,100,101,82,88,86,17,97,96,100,90,101,90,96,95},15))
task.wait(5)
if not enabled then return end
debug(_d({62,96,103,90,95,88,17,101,96,17,97,96,100,101,30,66,102,86,86,95,17,97,96,100,90,101,90,96,95},15))
navToPointConfirmed(COORDS.PostQueen, 30, _d({97,96,100,101,30,66,102,86,86,95,17,97,96,100,90,101,90,96,95},15))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({54,95,82,83,93,90,95,88,29,17,97,96,100,17,51,54,55,64,67,54,17,97,93,82,95,43},15), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({65,93,82,95,17,86,99,99,96,99,43},15), err2) end
end)
debug(_d({54,95,82,83,93,86,85,43},15), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({54,95,82,83,93,86,85,43},15), enabled)
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
if not ok then debug(_d({58,95,97,102,101,51,86,88,82,95,17,86,99,99,96,99,43},15), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({56,82,94,86,17,93,96,82,85,86,85,29,17,82,102,101,96,30,100,101,82,99,101,90,95,88,17,101,89,86,17,97,93,82,95},15))
enableBot()
end)
if not ok then debug(_d({50,102,101,96,100,101,82,99,101,17,86,99,99,96,99,43},15), err) end
end)
debug(_d({61,96,82,85,86,85,17,211,113,133,17,82,102,101,96,30,100,101,82,99,101,90,95,88,17,96,95,84,86,17,101,89,86,17,88,82,94,86,17,87,90,95,90,100,89,86,100,17,93,96,82,85,90,95,88,17,25,97,99,86,100,100,17,65,17,101,96,17,101,96,88,88,93,86,17,94,82,95,102,82,93,93,106,26},15))
end)()