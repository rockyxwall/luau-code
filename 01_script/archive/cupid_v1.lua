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
local Players            = game:GetService(_d({62,90,79,103,83,96,97},18))
local UserInputService    = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
local RunService          = game:GetService(_d({64,99,92,65,83,96,100,87,81,83},18))
local VIM                 = game:GetService(_d({68,87,96,98,99,79,90,55,92,94,99,98,59,79,92,79,85,83,96},18))
local ReplicatedStorage    = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({73,48,93,97,97,48,93,98,75},18), _d({69,96,93,92,85,14,85,79,91,83,14,208,110,130,14,62,90,79,81,83,55,82,40},18), game.PlaceId, _d({67,92,87,100,83,96,97,83,55,82,40},18), game.GameId, _d({27,14,92,93,98,14,96,99,92,92,87,92,85},18))
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
local LEO_PILLAR_ANIM_ID   = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,34,34,31,34,31,33,32,37},18)
local LEO_ENTEI_ANIM_ID    = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,34,34,31,33,38,32,37,38},18)
local LEO_HIKEN_ANIM_ID    = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,32,30,39,31,37,34,30,37},18)
local LEO_FIREFLY_ANIM_ID  = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,35,32,32,30,32,33,36,31,35,34},18)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({61,80,88,83,81,98,87,100,83,97},18)
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
local REPLAY_BUTTON_VALUE   = _d({64,83,94,90,79,103},18)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({91,93,100,83},18)
local NavState   = {mode = _d({87,82,90,83},18)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({73,48,93,97,97,48,93,98,75},18), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end)
if ok then return root end
debug(_d({85,83,98,64,93,93,98,14,83,96,96,93,96,40},18), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
end)
if ok then return hum end
debug(_d({85,83,98,54,99,91,79,92,93,87,82,14,83,96,96,93,96,40},18), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({77,77,54,93,100,83,96,47,98,98},18)) or Instance.new(_d({47,98,98,79,81,86,91,83,92,98},18))
att.Name = _d({77,77,54,93,100,83,96,47,98,98},18)
att.Parent = root
local force = root:FindFirstChild(_d({77,77,54,93,100,83,96,52,93,96,81,83},18))
if not force then
force = Instance.new(_d({58,87,92,83,79,96,68,83,90,93,81,87,98,103},18))
force.Name = _d({77,77,54,93,100,83,96,52,93,96,81,83},18)
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
debug(_d({85,83,98,61,96,49,96,83,79,98,83,52,93,96,81,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local force = root:FindFirstChild(_d({77,77,54,93,100,83,96,52,93,96,81,83},18))
local att   = root:FindFirstChild(_d({77,77,54,93,100,83,96,47,98,98},18))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({81,90,83,79,92,99,94,52,93,96,81,83,14,83,96,96,93,96,40},18), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({48,99,97,93,59,83,90,83,83},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,48,99,97,93,47,81,98,87,100,83,14,83,96,96,93,96,40},18), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({48,99,97,93},18))
end)
if not ok then debug(_d({79,81,98,87,100,79,98,83,48,99,97,93,14,83,96,96,93,96,40},18), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({48,99,97,93,14,92,93,98,14,79,81,98,87,100,83,26,14,79,81,98,87,100,79,98,87,92,85},18))
activateBuso()
end
end)
if not ok then debug(_d({48,99,97,93,57,83,83,94,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({48,99,97,93,14,89,83,83,94,83,96,14,97,98,93,94,94,83,82},18))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({57,83,92,54,79,89,87},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,57,83,92,47,81,98,87,100,83,14,83,96,96,93,96,40},18), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({57,83,92},18), true)
end)
if not ok then debug(_d({79,81,98,87,100,79,98,83,57,83,92,14,83,96,96,93,96,40},18), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({57,83,92,14,92,93,98,14,79,81,98,87,100,83,26,14,79,81,98,87,100,79,98,87,92,85},18))
activateKen()
end
end)
if not ok then debug(_d({57,83,92,57,83,83,94,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({57,83,92,14,89,83,83,94,83,96,14,97,98,93,94,94,83,82},18))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({60,62,49,97},18)) end)
if ok then return folder end
debug(_d({85,83,98,60,62,49,97,52,93,90,82,83,96,14,83,96,96,93,96,40},18), folder)
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
local r = model:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local h = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
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
debug(_d({85,83,98,60,83,79,96,83,97,98,60,62,49,14,83,96,96,93,96,40},18), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
local hum  = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({85,83,98,60,62,49,48,103,60,79,91,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({92,94,81,97,64,83,91,79,87,92,87,92,85,14,83,96,96,93,96,40},18), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({49,99,94,87,82,14,63,99,83,83,92},18))
return queen ~= nil and queen:FindFirstChild(_d({91,93,98,87,93,92,58,83,97,97},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,63,99,83,83,92,62,86,79,97,83,32,14,83,96,96,93,96,40},18), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,31,32,31,32,39,37,39,34,32,32,39,32,37,36,39},18)
local QUEEN_GRASP_ANIM_ID   = _d({96,80,102,79,97,97,83,98,87,82,40,29,29,31,32,39,38,30,30,30,36,31,30,30,31,37,33,34},18)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
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
debug(_d({87,97,62,90,79,103,87,92,85,47,92,87,91,52,96,93,91,58,87,97,98,14,83,96,96,93,96,40},18), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({48,90,93,81,89,87,92,85},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,60,62,49,48,90,93,81,89,87,92,85,14,83,96,96,93,96,40},18), result)
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
debug(_d({94,96,83,82,87,81,98,60,62,49,62,93,97,87,98,87,93,92,14,83,96,96,93,96,40},18), result)
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
debug(_d({60,93,14,82,79,91,79,85,83,14,93,92},18), model.Name, _d({84,93,96},18), NPC_STUCK_TIMEOUT, _d({97,14,27,14,97,101,87,98,81,86,87,92,85,14,98,79,96,85,83,98},18))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({98,96,79,81,89,60,62,49,50,79,91,79,85,83,14,83,96,96,93,96,40},18), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({59,93,82,83,90},18)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({48,79,97,83,62,79,96,98},18)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({85,83,98,59,93,82,83,90,52,79,81,83,62,93,97,14,83,96,96,93,96,40},18), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({51,92,100},18))
local folder = env and env:FindFirstChild(_d({65,98,79,98,99,83,97},18))
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
debug(_d({85,83,98,65,98,79,98,99,83,59,93,82,83,90,60,83,79,96,14,83,96,96,93,96,40},18), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({80,79,96,96,83,90,54,62},18))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({85,83,98,65,98,79,98,99,83,54,62,14,83,96,96,93,96,40},18), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,47,98,98,96,87,80,99,98,83,14,83,96,96,93,96,40},18), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({66,93,93,90},18)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,60,79,91,83,14,83,96,96,93,96,40},18), tool)
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
if not ok then debug(_d({83,95,99,87,94,66,93,93,90,14,83,96,96,93,96,40},18), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({48,79,81,89,94,79,81,89},18))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({66,93,93,90},18)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({84,87,92,82,66,93,93,90,48,103,49,86,87,90,82,60,79,91,83,14,83,96,96,93,96,40},18), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({65,101,93,96,82,51,95,99,87,94},18))
if sword then
equipTool(sword)
return _d({97,101,93,96,82},18)
end
local melee = findToolByAttribute(_d({59,83,90,83,83,66,93,93,90},18))
if melee then
equipTool(melee)
return _d({91,83,90,83,83},18)
end
debug(_d({60,93,14,97,101,93,96,82,14,93,96,14,91,83,90,83,83,14,98,93,93,90,14,84,93,99,92,82},18))
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
if not ok then debug(_d({81,90,87,81,89,59,31,14,83,96,96,93,96,40},18), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({64,93,89,99,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,83,94,94,93},18), args)
elseif style == _d({48,90,79,81,89,58,83,85},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89},18), args)
elseif style == _d({57,79,91,87,97,86,87,89,87},18) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,79,91,87,97,86,87,89,87,53,83,94,94,93},18), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({65,89,103,14,69,79,90,89,32},18), args)
end
end)
if not ok then debug(_d({87,92,100,93,89,83,53,83,94,94,93,14,83,96,96,93,96,40},18), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({94,96,83,97,97,65,89,87,90,90,64,14,83,96,96,93,96,40},18), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({86,93,90,82,48,90,93,81,89,14,83,96,96,93,96,40},18), err) end
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
if not ok then debug(_d({86,93,90,82,48,90,93,81,89,69,86,87,90,83,14,83,96,96,93,96,40},18), err) end
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
debug(_d({85,83,98,53,79,91,83,53,14,83,96,96,93,96,40},18), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({87,97,64,83,79,90,59,31,48,99,97,103,14,83,96,96,93,96,40},18), result)
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
return char ~= nil and char:FindFirstChild(_d({97,98,99,92},18)) ~= nil
end)
if ok then return result end
debug(_d({87,97,65,98,99,92,92,83,82,14,83,96,96,93,96,40},18), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({94,96,83,97,97,65,98,99,92,48,96,83,79,89,14,83,96,96,93,96,40},18), err) end
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
debug(_d({95,99,83,83,92,50,93,82,85,83,67,92,98,87,90,65,79,84,83,40,14,63,99,83,83,92,14,85,93,92,83,14,27,14,83,92,82,87,92,85,14,82,93,82,85,83,14,83,79,96,90,103},18))
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
debug(_d({95,99,83,83,92,50,93,82,85,83,67,92,98,87,90,65,79,84,83,14,97,79,84,83,98,103,14,98,87,91,83,93,99,98},18))
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
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({63,99,83,83,92,14,81,79,97,98,87,92,85,14,82,83,98,83,81,98,83,82,14,27,14,82,93,82,85,87,92,85,14,22,101,79,98,81,86,83,96,23},18))
queenDodgeUntilSafe(function() return getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) end)
if enabled and getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) then
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
end
queenDodging = false
end
end)
if not ok then debug(_d({95,99,83,83,92,50,93,82,85,83,69,79,98,81,86,83,96,14,83,96,96,93,96,40},18), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({94,93,87,92,98},18) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({92,94,81},18) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({92,79,91,83,82},18) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({85,83,98,60,79,100,66,79,96,85,83,98,97,14,83,96,96,93,96,40},18), aimR)
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
debug(_d({81,93,91,94,99,98,83,58,93,81,89,83,82,49,52,96,79,91,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({94,93,87,92,98},18), point = pos}
phase = _d({91,93,100,83},18)
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
if not ok then debug(_d({92,79,100,66,93,62,93,87,92,98,14,85,83,94,94,93,14,81,86,83,81,89,14,83,96,96,93,96,40},18), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({92,94,81},18)}
phase = _d({91,93,100,83},18)
end
function setNavNamed(name)
NavState = {mode = _d({92,79,91,83,82},18), name = name}
phase = _d({91,93,100,83},18)
end
local function setNavIdle()
NavState = {mode = _d({87,82,90,83},18)}
phase = _d({91,93,100,83},18)
end
local function hasArrived()
return phase == _d({86,93,100,83,96},18)
end
local function startNav()
phase = _d({91,93,100,83},18)
debug(_d({60,79,100,14,90,93,93,94,14,61,60},18))
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
local prevPos = force:GetAttribute(_d({77,77,94,96,83,100,62,93,97},18))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({58,79,96,85,83,14,94,93,97,87,98,87,93,92,14,88,99,91,94,14,82,83,98,83,81,98,83,82,40},18), delta, _d({97,98,99,82,97,28,14,94,96,83,100,62,93,97,43},18), prevPos, _d({92,83,101,62,93,97,43},18), pos)
end
end
force:SetAttribute(_d({77,77,94,96,83,100,62,93,97},18), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({91,93,100,83},18) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({86,93,100,83,96},18)
debug(_d({62,86,79,97,83,40,14,86,93,100,83,96},18))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({15,15,15,14,64,51,52,67,65,55,60,53,14,66,61,14,47,62,62,58,71,14,47,48,60,61,64,59,47,58,14,68,51,58,61,49,55,66,71,40},18), finalVel, _d({79,87,91,43},18), aim, _d({94,93,97,43},18), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({86,93,100,83,96},18) then
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
debug(_d({49,93,91,80,79,98,14,90,93,81,89,14,97,89,87,94,94,83,82,26},18), snapDist, _d({97,98,99,82,97,14,84,96,93,91,14,98,79,96,85,83,98,14,208,110,130,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,91,93,100,83},18))
phase = _d({91,93,100,83},18)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({54,83,79,96,98,80,83,79,98,14,83,96,96,93,96,40},18), err) end
end)
end
local function stopNav()
debug(_d({60,79,100,14,90,93,93,94,14,61,52,52},18))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({91,93,100,83},18)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({66,83,102,98,49,86,79,98,65,83,96,100,87,81,83},18))
local channels = TextChatService:FindFirstChild(_d({66,83,102,98,49,86,79,92,92,83,90,97},18))
local channel = channels and channels:FindFirstChild(_d({64,48,70,53,83,92,83,96,79,90},18))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({50,83,84,79,99,90,98,49,86,79,98,65,103,97,98,83,91,49,86,79,98,51,100,83,92,98,97},18))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({65,79,103,59,83,97,97,79,85,83,64,83,95,99,83,97,98},18))
if sayEvent then
sayEvent:FireServer(message, _d({47,90,90},18))
return
end
debug(_d({97,83,92,82,49,86,79,98,59,83,97,97,79,85,83,40,14,92,93,14,66,83,102,98,49,86,79,98,65,83,96,100,87,81,83,28,64,48,70,53,83,92,83,96,79,90,14,93,96,14,90,83,85,79,81,103,14,65,79,103,59,83,97,97,79,85,83,64,83,95,99,83,97,98,14,84,93,99,92,82,14,84,93,96},18), message)
end)
if not ok then debug(_d({97,83,92,82,49,86,79,98,59,83,97,97,79,85,83,14,83,96,96,93,96,40},18), err) end
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
debug(_d({60,93,98,14,91,79,89,87,92,85,14,94,96,93,85,96,83,97,97,14,98,93,101,79,96,82,14,92,79,100,14,98,79,96,85,83,98,14,84,93,96},18), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({97,14,27,14,97,83,92,82,87,92,85,14,29,99,92,97,98,99,81,89},18))
sendChatMessage(_d({29,99,92,97,98,99,81,89},18))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({101,79,87,98,67,92,98,87,90,47,96,96,87,100,83,82,14,98,87,91,83,93,99,98},18))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({92,79,100,66,93,62,93,87,92,98,49,93,92,84,87,96,91,83,82,40},18), label or _d({98,79,96,85,83,98},18), _d({27,14,82,87,82,14,92,93,98,14,79,96,96,87,100,83,14,101,87,98,86,87,92},18), timeout, _d({97,26,14,96,83,98,96,103,87,92,85,14,93,92,81,83},18))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({92,79,100,66,93,62,93,87,92,98,49,93,92,84,87,96,91,83,82,40},18), label or _d({98,79,96,85,83,98},18), _d({27,14,97,98,87,90,90,14,92,93,98,14,79,96,96,87,100,83,82,14,79,84,98,83,96,14,96,83,98,96,103,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
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
if not ok then debug(_d({92,79,100,66,93,62,93,87,92,98,54,93,90,82,87,92,85,48,90,93,81,89,14,89,83,103,27,82,93,101,92,14,83,96,96,93,96,40},18), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({92,79,100,66,93,62,93,87,92,98,54,93,90,82,87,92,85,48,90,93,81,89,14,89,83,103,27,99,94,14,83,96,96,93,96,40},18), err2) end
end
local function clearStage(stageName)
debug(_d({59,93,100,87,92,85,14,98,93},18), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,60,62,49,97,14,98,93,14,97,94,79,101,92,14,79,98},18), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({14,14,97,94,79,101,92,14,81,86,83,81,89,40,14,84,93,90,82,83,96,14,83,102,87,97,98,97,14,43},18), folder ~= nil,
_d({26,14,81,86,87,90,82,96,83,92,14,43},18), folder and #folder:GetChildren() or 0,
_d({26,14,79,90,87,100,83,14,43},18), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({60,93,14,60,62,49,97,14,79,94,94,83,79,96,83,82,14,79,98},18), stageName, _d({79,84,98,83,96,14,31,35,97,26,14,91,93,100,87,92,85,14,93,92,14,79,92,103,101,79,103},18))
break
end
end
debug(_d({57,87,90,90,87,92,85,14,60,62,49,97,14,79,98},18), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({64,83,98,99,96,92,87,92,85,14,98,93},18), stageName, _d({94,93,97,87,98,87,93,92,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,93,92},18))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98},18), stageName, _d({94,93,97,87,98,87,93,92},18))
task.wait(5)
debug(stageName, _d({81,90,83,79,96,83,82},18))
end
local function killNamedNPC(name, targetPos)
debug(_d({59,93,100,87,92,85,14,98,93},18), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({82,83,84,83,79,98,83,82},18))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({54,99,91,79,92,93,87,82},18))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({58,83,93,14,94,90,79,103,83,82,14,79,92,87,91,79,98,87,93,92,40},18), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({90,83,93,47,92,87,91,58,93,85,85,83,96,14,94,96,87,92,98,14,83,96,96,93,96,40},18), err2) end
end)
end)
if not ok then debug(_d({97,98,79,96,98,58,83,93,47,92,87,91,58,93,85,85,83,96,14,83,96,96,93,96,40},18), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({59,93,100,87,92,85,14,98,93,14,58,83,93,14,22,80,90,93,81,89,87,92,85,14,79,84,98,83,96},18), LEO_BLOCK_DELAY, _d({97,23},18))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({58,83,93},18))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({58,83,93},18))
while enabled do
local info = getNPCByName(_d({58,83,93},18))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({58,83,93,14,81,79,97,98,87,92,85},18), which, _d({27,14,82,93,82,85,87,92,85},18))
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
if not getNPCByName(_d({58,83,93},18)) then
debug(_d({58,83,93,14,85,93,92,83,14,91,87,82,27,82,93,82,85,83,14,27,14,83,92,82,87,92,85,14,51,92,98,83,87,14,86,93,90,82,14,83,79,96,90,103},18))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({58,83,93},18)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({58,83,93,14,85,93,92,83,14,91,87,82,27,82,93,82,85,83,14,27,14,83,92,82,87,92,85,14,52,90,79,91,83,14,62,87,90,90,79,96,14,86,93,90,82,14,83,79,96,90,103},18))
end
end
end
if enabled and getNPCByName(_d({58,83,93},18)) then
setNavNamed(_d({58,83,93},18))
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
debug(_d({58,83,93,14,82,83,84,83,79,98,83,82},18))
stopLeoAnimLogger()
debug(_d({64,83,98,99,96,92,87,92,85,14,98,93,14,58,83,93,14,94,93,97,87,98,87,93,92,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,93,92},18))
navToPointConfirmed(COORDS.Leo, 30, _d({58,83,93,14,94,93,97,87,98,87,93,92},18))
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98,14,58,83,93,14,94,93,97,87,98,87,93,92},18))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({59,93,100,87,92,85,14,98,93},18), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,97,98,79,98,99,83,14,91,93,82,83,90,14,92,83,79,96},18), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({47,98,98,79,81,89,87,92,85},18), coordKey, _d({101,87,98,86},18), weapon or _d({92,93,98,86,87,92,85,14,84,93,99,92,82},18))
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
debug(coordKey, _d({80,79,96,96,83,90,14,82,83,97,98,96,93,103,83,82},18))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({27,14,81,93,99,90,82,14,92,93,98,14,84,87,92,82,14,97,98,79,98,99,83,14,91,93,82,83,90,26,14,97,89,87,94,94,87,92,85},18))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({97,98,87,90,90,14,79,90,87,100,83,14,22,54,62},18), hp, _d({23,14,27,14,96,83,27,82,83,97,98,96,93,103,87,92,85},18))
destroyStatue(coordKey)
else
debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,40},18), coordKey, _d({81,93,92,84,87,96,91,83,82,14,82,83,97,98,96,93,103,83,82},18))
end
end)
if not ok then debug(_d({96,83,81,86,83,81,89,65,98,79,98,99,83,14,83,96,96,93,96,40},18), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({59,93,100,87,92,85,14,98,93,14,63,99,83,83,92},18))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({63,99,83,83,92,14,83,92,98,83,96,83,82,14,94,86,79,97,83,14,32},18))
end
local function finishQueen()
debug(_d({52,87,92,87,97,86,87,92,85,14,63,99,83,83,92},18))
equipSwordOrMelee()
setNavNamed(_d({49,99,94,87,82,14,63,99,83,83,92},18))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({49,99,94,87,82,14,63,99,83,83,92},18))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({63,99,83,83,92,14,82,83,84,83,79,98,83,82,28,14,62,90,79,92,14,81,93,91,94,90,83,98,83,28},18))
end
local CONFIRMATION_PROMPT_NAME = _d({49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98},18)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({64,83,91,93,98,83,51,100,83,92,98},18), 5)
end)
if ok then return result end
debug(_d({85,83,98,64,83,94,90,79,103,64,83,91,93,98,83,14,83,96,96,93,96,40},18), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({62,90,79,103,83,96,53,99,87},18))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({55,91,79,85,83,48,99,98,98,93,92},18)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({80,99,98,98,93,92,68,79,90,99,83},18)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({84,87,92,82,48,99,98,98,93,92,48,103,68,79,90,99,83,14,83,96,96,93,96,40},18), result)
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
if not ok then debug(_d({81,90,87,81,89,53,99,87,48,99,98,98,93,92,14,83,96,96,93,96,40},18), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({87,97,65,83,96,100,83,96},18))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({64,83,91,93,98,83,51,100,83,92,98},18))
or inst:FindFirstChild(_d({81,90,87,83,92,98,51,100,83,92,98},18))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({84,87,92,82,47,92,97,101,83,96,49,93,92,92,83,81,98,93,96,14,83,96,96,93,96,40},18), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({49,93,99,90,82,14,92,93,98,14,90,93,81,79,98,83,14,64,83,91,93,98,83,51,100,83,92,98,29,81,90,87,83,92,98,51,100,83,92,98,14,92,83,79,96,14,64,83,94,90,79,103,14,80,99,98,98,93,92,26,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,81,90,87,81,89},18))
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
debug(_d({84,87,96,83,64,83,94,90,79,103,68,79,90,99,83,14,83,96,96,93,96,40},18), err, _d({27,14,84,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,81,90,87,81,89},18))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({52,79,90,90,87,92,85,14,80,79,81,89,14,98,93,14,80,99,98,98,93,92,68,79,90,99,83,14,97,83,79,96,81,86,14,84,93,96,14,64,83,94,90,79,103},18))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({64,83,94,90,79,103,14,80,99,98,98,93,92,14,92,93,98,14,84,93,99,92,82,14,83,87,98,86,83,96,26,14,85,87,100,87,92,85,14,99,94},18))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,28,64,83,91,93,98,83,51,100,83,92,98},18))
local remote = getReplayRemote()
if not remote then
debug(_d({49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,29,64,83,91,93,98,83,51,100,83,92,98,14,92,93,98,14,84,93,99,92,82,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98},18))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({52,87,96,87,92,85,14,64,83,94,90,79,103,14,100,87,79,14,49,93,92,84,87,96,91,79,98,87,93,92,62,96,93,91,94,98,28,64,83,91,93,98,83,51,100,83,92,98},18))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({52,87,96,83,65,83,96,100,83,96,14,83,96,96,93,96,40},18), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({62,90,79,103,83,96,53,99,87},18), 10)
if not playerGui then
debug(_d({101,79,87,98,52,93,96,61,80,88,83,81,98,87,100,83,97,53,99,87,40,14,92,93,14,62,90,79,103,83,96,53,99,87,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({61,80,88,83,81,98,87,100,83,97,14,53,67,55,14,84,93,99,92,82,14,27,14,97,98,79,85,83,14,90,93,79,82,83,82},18))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({61,80,88,83,81,98,87,100,83,97,14,53,67,55,14,92,93,98,14,84,93,99,92,82,14,101,87,98,86,87,92,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
return
end
end
end)
if not ok then debug(_d({101,79,87,98,52,93,96,61,80,88,83,81,98,87,100,83,97,53,99,87,14,83,96,96,93,96,40},18), err) end
end
local function runPlan()
debug(_d({62,90,79,92,14,97,98,79,96,98,83,82},18))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({65,98,79,96,98,87,92,85,14,92,79,100,14,90,93,93,94},18))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({94,93,97,14,30,28,32,97,14,47,52,66,51,64,14,97,98,79,96,98,60,79,100,40},18), rootAfter and rootAfter.Position)
end)
debug(_d({69,79,87,98,87,92,85,14,35,97,14,80,83,84,93,96,83,14,91,93,100,87,92,85,14,98,93,14,65,98,79,85,83,31},18))
task.wait(5)
for _, stage in ipairs({_d({65,98,79,85,83,31},18), _d({65,98,79,85,83,32},18), _d({65,98,79,85,83,33},18), _d({65,98,79,85,83,33,48},18)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,98,93,14,79,96,96,93,101,14,84,90,103,27,82,93,101,92,14,79,96,83,79},18))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({50,93,82,85,87,92,85,14,79,96,96,93,101,14,96,79,87,92},18))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({65,98,79,85,83,34},18))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({63,99,83,83,92,14,87,92,14,94,86,79,97,83,14,32,14,27,14,89,83,83,94,87,92,85,14,57,83,92,14,54,79,89,87,14,79,81,98,87,100,83,14,84,96,93,91,14,86,83,96,83,14,93,92},18))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({65,98,79,98,99,83,31},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,31},18))
destroyStatue(_d({65,98,79,98,99,83,32},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,31},18))
recheckStatue(_d({65,98,79,98,99,83,32},18))
destroyStatue(_d({65,98,79,98,99,83,33},18))
if not enabled then return end
recheckStatue(_d({65,98,79,98,99,83,33},18))
recheckStatue(_d({65,98,79,98,99,83,32},18))
recheckStatue(_d({65,98,79,98,99,83,31},18))
if not enabled then return end
debug(_d({69,79,87,98,87,92,85,14,84,93,96,14,94,86,79,97,83,14,32,14,98,93,14,83,92,82},18))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({62,86,79,97,83,14,32,14,83,92,82,14,101,79,87,98,14,98,87,91,83,93,99,98,26,14,94,96,93,81,83,83,82,87,92,85,14,79,92,103,101,79,103},18))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,80,79,81,89,14,98,93,14,63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
navToPointConfirmed(COORDS.Queen, 30, _d({63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
debug(_d({69,79,87,98,87,92,85,14,35,97,14,79,98,14,63,99,83,83,92,14,97,98,79,85,83,14,94,93,97,87,98,87,93,92},18))
task.wait(5)
if not enabled then return end
debug(_d({59,93,100,87,92,85,14,98,93,14,94,93,97,98,27,63,99,83,83,92,14,94,93,97,87,98,87,93,92},18))
navToPointConfirmed(COORDS.PostQueen, 30, _d({94,93,97,98,27,63,99,83,83,92,14,94,93,97,87,98,87,93,92},18))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({51,92,79,80,90,87,92,85,26,14,94,93,97,14,48,51,52,61,64,51,14,94,90,79,92,40},18), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({62,90,79,92,14,83,96,96,93,96,40},18), err2) end
end)
debug(_d({51,92,79,80,90,83,82,40},18), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({51,92,79,80,90,83,82,40},18), enabled)
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
if not ok then debug(_d({55,92,94,99,98,48,83,85,79,92,14,83,96,96,93,96,40},18), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({53,79,91,83,14,90,93,79,82,83,82,26,14,79,99,98,93,27,97,98,79,96,98,87,92,85,14,98,86,83,14,94,90,79,92},18))
enableBot()
end)
if not ok then debug(_d({47,99,98,93,97,98,79,96,98,14,83,96,96,93,96,40},18), err) end
end)
debug(_d({58,93,79,82,83,82,14,208,110,130,14,79,99,98,93,27,97,98,79,96,98,87,92,85,14,93,92,81,83,14,98,86,83,14,85,79,91,83,14,84,87,92,87,97,86,83,97,14,90,93,79,82,87,92,85,14,22,94,96,83,97,97,14,62,14,98,93,14,98,93,85,85,90,83,14,91,79,92,99,79,90,90,103,23},18))
end)()