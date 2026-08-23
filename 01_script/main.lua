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
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({60,88,77,101,81,94,95},20))
local UserInputService    = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local RunService          = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM                 = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local ReplicatedStorage    = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({71,46,91,95,95,46,91,96,73},20), _d({67,94,91,90,83,12,83,77,89,81,12,206,108,128,12,60,88,77,79,81,53,80,38},20), game.PlaceId, _d({65,90,85,98,81,94,95,81,53,80,38},20), game.GameId, _d({25,12,90,91,96,12,94,97,90,90,85,90,83},20))
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
local LEO_PILLAR_ANIM_ID   = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,33,30,32,32,29,32,29,31,30,35},20)
local LEO_ENTEI_ANIM_ID    = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,33,30,32,32,29,31,36,30,35,36},20)
local LEO_HIKEN_ANIM_ID    = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,33,30,30,28,37,29,35,32,28,35},20)
local LEO_FIREFLY_ANIM_ID  = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,33,30,30,28,30,31,34,29,33,32},20)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({59,78,86,81,79,96,85,98,81,95},20)
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
local REPLAY_BUTTON_VALUE   = _d({62,81,92,88,77,101},20)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({89,91,98,81},20)
local NavState   = {mode = _d({85,80,88,81},20)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({71,46,91,95,95,46,91,96,73},20), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end)
if ok then return root end
debug(_d({83,81,96,62,91,91,96,12,81,94,94,91,94,38},20), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
end)
if ok then return hum end
debug(_d({83,81,96,52,97,89,77,90,91,85,80,12,81,94,94,91,94,38},20), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({21,12,91,94,12,53,90,95,96,77,90,79,81,26,90,81,99,20},20)Attachment")
att.Name = _d({75,75,52,91,98,81,94,45,96,96},20)
att.Parent = root
local force = root:FindFirstChild(_d({75,75,52,91,98,81,94,50,91,94,79,81},20))
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = _d({75,75,52,91,98,81,94,50,91,94,79,81},20)
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
debug(_d({83,81,96,59,94,47,94,81,77,96,81,50,91,94,79,81,12,81,94,94,91,94,38},20), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local force = root:FindFirstChild(_d({75,75,52,91,98,81,94,50,91,94,79,81},20))
local att   = root:FindFirstChild(_d({75,75,52,91,98,81,94,45,96,96},20))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({79,88,81,77,90,97,92,50,91,94,79,81,12,81,94,94,91,94,38},20), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({46,97,95,91,57,81,88,81,81},20)) ~= nil
end)
if ok then return result end
debug(_d({85,95,46,97,95,91,45,79,96,85,98,81,12,81,94,94,91,94,38},20), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({46,97,95,91},20))
end)
if not ok then debug(_d({77,79,96,85,98,77,96,81,46,97,95,91,12,81,94,94,91,94,38},20), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({46,97,95,91,12,90,91,96,12,77,79,96,85,98,81,24,12,77,79,96,85,98,77,96,85,90,83},20))
activateBuso()
end
end)
if not ok then debug(_d({46,97,95,91,55,81,81,92,81,94,12,81,94,94,91,94,38},20), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({46,97,95,91,12,87,81,81,92,81,94,12,95,96,91,92,92,81,80},20))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({55,81,90,52,77,87,85},20)) ~= nil
end)
if ok then return result end
debug(_d({85,95,55,81,90,45,79,96,85,98,81,12,81,94,94,91,94,38},20), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({55,81,90},20), true)
end)
if not ok then debug(_d({77,79,96,85,98,77,96,81,55,81,90,12,81,94,94,91,94,38},20), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({55,81,90,12,90,91,96,12,77,79,96,85,98,81,24,12,77,79,96,85,98,77,96,85,90,83},20))
activateKen()
end
end)
if not ok then debug(_d({55,81,90,55,81,81,92,81,94,12,81,94,94,91,94,38},20), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({55,81,90,12,87,81,81,92,81,94,12,95,96,91,92,92,81,80},20))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({58,60,47,95},20)) end)
if ok then return folder end
debug(_d({83,81,96,58,60,47,95,50,91,88,80,81,94,12,81,94,94,91,94,38},20), folder)
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
local r = model:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local h = model:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
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
debug(_d({83,81,96,58,81,77,94,81,95,96,58,60,47,12,81,94,94,91,94,38},20), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum  = model:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({83,81,96,58,60,47,46,101,58,77,89,81,12,81,94,94,91,94,38},20), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({90,92,79,95,62,81,89,77,85,90,85,90,83,12,81,94,94,91,94,38},20), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({47,97,92,85,80,12,61,97,81,81,90},20))
return queen ~= nil and queen:FindFirstChild(_d({89,91,96,85,91,90,56,81,95,95},20)) ~= nil
end)
if ok then return result end
debug(_d({85,95,61,97,81,81,90,60,84,77,95,81,30,12,81,94,94,91,94,38},20), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,29,30,29,30,37,35,37,32,30,30,37,30,35,34,37},20)
local QUEEN_GRASP_ANIM_ID   = _d({94,78,100,77,95,95,81,96,85,80,38,27,27,29,30,37,36,28,28,28,34,29,28,28,29,35,31,32},20)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
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
debug(_d({85,95,60,88,77,101,85,90,83,45,90,85,89,50,94,91,89,56,85,95,96,12,81,94,94,91,94,38},20), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({46,88,91,79,87,85,90,83},20)) ~= nil
end)
if ok then return result end
debug(_d({85,95,58,60,47,46,88,91,79,87,85,90,83,12,81,94,94,91,94,38},20), result)
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
debug(_d({92,94,81,80,85,79,96,58,60,47,60,91,95,85,96,85,91,90,12,81,94,94,91,94,38},20), result)
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
debug(_d({58,91,12,80,77,89,77,83,81,12,91,90},20), model.Name, _d({82,91,94},20), NPC_STUCK_TIMEOUT, _d({95,12,25,12,95,99,85,96,79,84,85,90,83,12,96,77,94,83,81,96},20))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({96,94,77,79,87,58,60,47,48,77,89,77,83,81,12,81,94,94,91,94,38},20), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({57,91,80,81,88},20)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({46,77,95,81,60,77,94,96},20)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({83,81,96,57,91,80,81,88,50,77,79,81,60,91,95,12,81,94,94,91,94,38},20), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({49,90,98},20))
local folder = env and env:FindFirstChild(_d({63,96,77,96,97,81,95},20))
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
debug(_d({83,81,96,63,96,77,96,97,81,57,91,80,81,88,58,81,77,94,12,81,94,94,91,94,38},20), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({78,77,94,94,81,88,52,60},20))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({83,81,96,63,96,77,96,97,81,52,60,12,81,94,94,91,94,38},20), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({64,91,91,88},20)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({82,85,90,80,64,91,91,88,46,101,45,96,96,94,85,78,97,96,81,12,81,94,94,91,94,38},20), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({64,91,91,88},20)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({82,85,90,80,64,91,91,88,46,101,58,77,89,81,12,81,94,94,91,94,38},20), tool)
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
if not ok then debug(_d({81,93,97,85,92,64,91,91,88,12,81,94,94,91,94,38},20), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({64,91,91,88},20)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({82,85,90,80,64,91,91,88,46,101,47,84,85,88,80,58,77,89,81,12,81,94,94,91,94,38},20), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({63,99,91,94,80,49,93,97,85,92},20))
if sword then
equipTool(sword)
return _d({95,99,91,94,80},20)
end
local melee = findToolByAttribute(_d({57,81,88,81,81,64,91,91,88},20))
if melee then
equipTool(melee)
return _d({89,81,88,81,81},20)
end
debug(_d({58,91,12,95,99,91,94,80,12,91,94,12,89,81,88,81,81,12,96,91,91,88,12,82,91,97,90,80},20))
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
if not ok then debug(_d({79,88,85,79,87,57,29,12,81,94,94,91,94,38},20), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({62,91,87,97,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,81,92,92,91},20), args)
elseif style == _d({46,88,77,79,87,56,81,83},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87},20), args)
elseif style == _d({55,77,89,85,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,77,89,85,95,84,85,87,85,51,81,92,92,91},20), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87,30},20), args)
end
end)
if not ok then debug(_d({85,90,98,91,87,81,51,81,92,92,91,12,81,94,94,91,94,38},20), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({92,94,81,95,95,63,87,85,88,88,62,12,81,94,94,91,94,38},20), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({84,91,88,80,46,88,91,79,87,12,81,94,94,91,94,38},20), err) end
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
if not ok then debug(_d({84,91,88,80,46,88,91,79,87,67,84,85,88,81,12,81,94,94,91,94,38},20), err) end
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
debug(_d({83,81,96,51,77,89,81,51,12,81,94,94,91,94,38},20), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({85,95,62,81,77,88,57,29,46,97,95,101,12,81,94,94,91,94,38},20), result)
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
return char ~= nil and char:FindFirstChild(_d({95,96,97,90},20)) ~= nil
end)
if ok then return result end
debug(_d({85,95,63,96,97,90,90,81,80,12,81,94,94,91,94,38},20), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({92,94,81,95,95,63,96,97,90,46,94,81,77,87,12,81,94,94,91,94,38},20), err) end
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
debug(_d({93,97,81,81,90,48,91,80,83,81,65,90,96,85,88,63,77,82,81,38,12,61,97,81,81,90,12,83,91,90,81,12,25,12,81,90,80,85,90,83,12,80,91,80,83,81,12,81,77,94,88,101},20))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({93,97,81,81,90,48,91,80,83,81,65,90,96,85,88,63,77,82,81,12,95,77,82,81,96,101,12,96,85,89,81,91,97,96},20))
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
local info = getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({61,97,81,81,90,12,79,77,95,96,85,90,83,12,80,81,96,81,79,96,81,80,12,25,12,80,91,80,83,85,90,83,12,20,99,77,96,79,84,81,94,21},20))
queenDodgeUntilSafe(function() return getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20)) end)
if enabled and getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20)) then
setNavNamed(_d({47,97,92,85,80,12,61,97,81,81,90},20))
end
queenDodging = false
end
end)
if not ok then debug(_d({93,97,81,81,90,48,91,80,83,81,67,77,96,79,84,81,94,12,81,94,94,91,94,38},20), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({92,91,85,90,96},20) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({90,92,79},20) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({90,77,89,81,80},20) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({83,81,96,58,77,98,64,77,94,83,81,96,95,12,81,94,94,91,94,38},20), aimR)
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
debug(_d({79,91,89,92,97,96,81,56,91,79,87,81,80,47,50,94,77,89,81,12,81,94,94,91,94,38},20), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({92,91,85,90,96},20), point = pos}
phase = _d({89,91,98,81},20)
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
if not ok then debug(_d({90,77,98,64,91,60,91,85,90,96,12,83,81,92,92,91,12,79,84,81,79,87,12,81,94,94,91,94,38},20), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({90,92,79},20)}
phase = _d({89,91,98,81},20)
end
function setNavNamed(name)
NavState = {mode = _d({90,77,89,81,80},20), name = name}
phase = _d({89,91,98,81},20)
end
local function setNavIdle()
NavState = {mode = _d({85,80,88,81},20)}
phase = _d({89,91,98,81},20)
end
local function hasArrived()
return phase == _d({84,91,98,81,94},20)
end
local function startNav()
phase = _d({89,91,98,81},20)
debug(_d({58,77,98,12,88,91,91,92,12,59,58},20))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({60,88,77,101,81,94,12,80,85,81,80,13,12,63,96,91,92,92,85,90,83,12,78,91,96,26},20))
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
debug(_d({60,88,77,101,81,94,12,85,95,12,96,91,91,12,82,77,94,12,82,94,91,89,12,96,77,94,83,81,96,12,20,42,30,28,28,28,12,95,96,97,80,95,21,26,12,56,85,87,81,88,101,12,94,81,95,92,77,99,90,81,80,12,77,96,12,88,91,78,78,101,26,12,63,96,91,92,92,85,90,83,12,78,91,96,26},20))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({75,75,92,94,81,98,60,91,95},20))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({56,77,94,83,81,12,92,91,95,85,96,85,91,90,12,86,97,89,92,12,80,81,96,81,79,96,81,80,38},20), delta, _d({95,96,97,80,95,26,12,92,94,81,98,60,91,95,41},20), prevPos, _d({90,81,99,60,91,95,41},20), pos)
end
end
force:SetAttribute(_d({75,75,92,94,81,98,60,91,95},20), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({89,91,98,81},20) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({84,91,98,81,94},20)
debug(_d({60,84,77,95,81,38,12,84,91,98,81,94},20))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({13,13,13,12,62,49,50,65,63,53,58,51,12,64,59,12,45,60,60,56,69,12,45,46,58,59,62,57,45,56,12,66,49,56,59,47,53,64,69,38},20), finalVel, _d({77,85,89,41},20), aim, _d({92,91,95,41},20), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({84,91,98,81,94},20) then
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
debug(_d({47,91,89,78,77,96,12,88,91,79,87,12,95,87,85,92,92,81,80,24},20), snapDist, _d({95,96,97,80,95,12,82,94,91,89,12,96,77,94,83,81,96,12,206,108,128,12,82,77,88,88,85,90,83,12,78,77,79,87,12,96,91,12,89,91,98,81},20))
phase = _d({89,91,98,81},20)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({52,81,77,94,96,78,81,77,96,12,81,94,94,91,94,38},20), err) end
end)
end
local function stopNav()
debug(_d({58,77,98,12,88,91,91,92,12,59,50,50},20))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({89,91,98,81},20)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({64,81,100,96,47,84,77,96,63,81,94,98,85,79,81},20))
local channels = TextChatService:FindFirstChild(_d({64,81,100,96,47,84,77,90,90,81,88,95},20))
local channel = channels and channels:FindFirstChild(_d({62,46,68,51,81,90,81,94,77,88},20))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({48,81,82,77,97,88,96,47,84,77,96,63,101,95,96,81,89,47,84,77,96,49,98,81,90,96,95},20))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({63,77,101,57,81,95,95,77,83,81,62,81,93,97,81,95,96},20))
if sayEvent then
sayEvent:FireServer(message, _d({45,88,88},20))
return
end
debug(_d({95,81,90,80,47,84,77,96,57,81,95,95,77,83,81,38,12,90,91,12,64,81,100,96,47,84,77,96,63,81,94,98,85,79,81,26,62,46,68,51,81,90,81,94,77,88,12,91,94,12,88,81,83,77,79,101,12,63,77,101,57,81,95,95,77,83,81,62,81,93,97,81,95,96,12,82,91,97,90,80,12,82,91,94},20), message)
end)
if not ok then debug(_d({95,81,90,80,47,84,77,96,57,81,95,95,77,83,81,12,81,94,94,91,94,38},20), err) end
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
debug(_d({58,91,96,12,89,77,87,85,90,83,12,92,94,91,83,94,81,95,95,12,96,91,99,77,94,80,12,90,77,98,12,96,77,94,83,81,96,12,82,91,94},20), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({95,12,25,12,95,81,90,80,85,90,83,12,27,97,90,95,96,97,79,87},20))
sendChatMessage(_d({27,97,90,95,96,97,79,87},20))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({99,77,85,96,65,90,96,85,88,45,94,94,85,98,81,80,12,96,85,89,81,91,97,96},20))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({90,77,98,64,91,60,91,85,90,96,47,91,90,82,85,94,89,81,80,38},20), label or _d({96,77,94,83,81,96},20), _d({25,12,80,85,80,12,90,91,96,12,77,94,94,85,98,81,12,99,85,96,84,85,90},20), timeout, _d({95,24,12,94,81,96,94,101,85,90,83,12,91,90,79,81},20))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({90,77,98,64,91,60,91,85,90,96,47,91,90,82,85,94,89,81,80,38},20), label or _d({96,77,94,83,81,96},20), _d({25,12,95,96,85,88,88,12,90,91,96,12,77,94,94,85,98,81,80,12,77,82,96,81,94,12,94,81,96,94,101,24,12,92,94,91,79,81,81,80,85,90,83,12,77,90,101,99,77,101},20))
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
if not ok then debug(_d({90,77,98,64,91,60,91,85,90,96,52,91,88,80,85,90,83,46,88,91,79,87,12,87,81,101,25,80,91,99,90,12,81,94,94,91,94,38},20), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({90,77,98,64,91,60,91,85,90,96,52,91,88,80,85,90,83,46,88,91,79,87,12,87,81,101,25,97,92,12,81,94,94,91,94,38},20), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({67,77,88,87,85,90,83,12,96,91,38},20), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({99,77,88,87,64,91,60,91,85,90,96,12,67,12,80,91,99,90,12,81,94,94,91,94,38},20), err) end
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
debug(_d({64,91,91,87,12,80,77,89,77,83,81,12,99,84,85,88,81,12,99,77,88,87,85,90,83,12,96,91,12,92,91,85,90,96,13,12,63,96,91,92,92,85,90,83,12,99,77,88,87,12,96,91,12,81,90,83,77,83,81,26},20))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({45,94,94,85,98,81,80,12,77,96,38},20), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({63,96,97,79,87,12,80,97,94,85,90,83,12,99,77,88,87,24,12,86,97,89,92,85,90,83,13},20))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({63,96,85,88,88,12,95,96,97,79,87,24,12,96,94,85,83,83,81,94,85,90,83,12,51,81,92,92,91,13},20))
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
debug(_d({57,91,98,85,90,83,12,96,91},20), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({67,77,85,96,85,90,83,12,82,91,94,12,58,60,47,95,12,96,91,12,95,92,77,99,90,12,77,96},20), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({12,12,95,92,77,99,90,12,79,84,81,79,87,38,12,82,91,88,80,81,94,12,81,100,85,95,96,95,12,41},20), folder ~= nil,
_d({24,12,79,84,85,88,80,94,81,90,12,41},20), folder and #folder:GetChildren() or 0,
_d({24,12,77,88,85,98,81,12,41},20), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({58,91,12,58,60,47,95,12,77,92,92,81,77,94,81,80,12,77,96},20), stageName, _d({77,82,96,81,94,12,29,33,95,24,12,89,91,98,85,90,83,12,91,90,12,77,90,101,99,77,101},20))
break
end
end
debug(_d({55,85,88,88,85,90,83,12,58,60,47,95,12,77,96},20), stageName)
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
debug(_d({62,81,96,97,94,90,85,90,83,12,96,91},20), stageName, _d({92,91,95,85,96,85,91,90,12,78,81,82,91,94,81,12,89,91,98,85,90,83,12,91,90},20))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({67,77,85,96,85,90,83,12,33,95,12,77,96},20), stageName, _d({92,91,95,85,96,85,91,90},20))
task.wait(5)
debug(_d({67,77,85,96,85,90,83,12,82,91,94},20), targetHP * 100, _d({17,12,52,60,12,78,81,82,91,94,81,12,89,91,98,85,90,83,12,96,91,12,90,81,100,96,12,95,96,77,83,81},20))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({79,88,81,77,94,81,80},20))
end
local function killNamedNPC(name, targetPos)
debug(_d({57,91,98,85,90,83,12,96,91},20), name)
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
debug(name, _d({80,81,82,81,77,96,81,80},20))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({56,81,91,12,92,88,77,101,81,80,12,77,90,85,89,77,96,85,91,90,38},20), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({88,81,91,45,90,85,89,56,91,83,83,81,94,12,92,94,85,90,96,12,81,94,94,91,94,38},20), err2) end
end)
end)
if not ok then debug(_d({95,96,77,94,96,56,81,91,45,90,85,89,56,91,83,83,81,94,12,81,94,94,91,94,38},20), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({57,91,98,85,90,83,12,96,91,12,56,81,91},20))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({56,81,91},20))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({56,81,91},20))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({56,81,91},20))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({56,81,91,12,79,77,95,96,85,90,83},20), which, _d({25,12,80,91,80,83,85,90,83},20))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({56,81,91,12,95,96,77,94,96,81,80,12,78,88,91,79,87,25,78,94,81,77,87,81,94,12,89,85,80,25,78,88,91,79,87,13,12,49,98,77,80,85,90,83,26,26,26},20))
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
if not getNPCByName(_d({56,81,91},20)) then
debug(_d({56,81,91,12,83,91,90,81,12,89,85,80,25,80,91,80,83,81,12,25,12,81,90,80,85,90,83,12,49,90,96,81,85,12,84,91,88,80,12,81,77,94,88,101},20))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({56,81,91},20)) then
setNavNamed(_d({56,81,91},20))
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
debug(_d({56,81,91,12,80,81,82,81,77,96,81,80},20))
stopLeoAnimLogger()
debug(_d({62,81,96,97,94,90,85,90,83,12,96,91,12,56,81,91,12,92,91,95,85,96,85,91,90,12,78,81,82,91,94,81,12,89,91,98,85,90,83,12,91,90},20))
navToPointConfirmed(COORDS.Leo, 30, _d({56,81,91,12,92,91,95,85,96,85,91,90},20))
debug(_d({67,77,85,96,85,90,83,12,33,95,12,77,96,12,56,81,91,12,92,91,95,85,96,85,91,90},20))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({57,91,98,85,90,83,12,96,91},20), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({47,91,97,88,80,12,90,91,96,12,82,85,90,80,12,95,96,77,96,97,81,12,89,91,80,81,88,12,90,81,77,94},20), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({45,96,96,77,79,87,85,90,83},20), coordKey, _d({99,85,96,84},20), weapon or _d({90,91,96,84,85,90,83,12,82,91,97,90,80},20))
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
debug(coordKey, _d({78,77,94,94,81,88,12,80,81,95,96,94,91,101,81,80},20))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({94,81,79,84,81,79,87,63,96,77,96,97,81,38},20), coordKey, _d({25,12,79,91,97,88,80,12,90,91,96,12,82,85,90,80,12,95,96,77,96,97,81,12,89,91,80,81,88,24,12,95,87,85,92,92,85,90,83},20))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({94,81,79,84,81,79,87,63,96,77,96,97,81,38},20), coordKey, _d({95,96,85,88,88,12,77,88,85,98,81,12,20,52,60},20), hp, _d({21,12,25,12,94,81,25,80,81,95,96,94,91,101,85,90,83},20))
destroyStatue(coordKey)
else
debug(_d({94,81,79,84,81,79,87,63,96,77,96,97,81,38},20), coordKey, _d({79,91,90,82,85,94,89,81,80,12,80,81,95,96,94,91,101,81,80},20))
end
end)
if not ok then debug(_d({94,81,79,84,81,79,87,63,96,77,96,97,81,12,81,94,94,91,94,38},20), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({57,91,98,85,90,83,12,96,91,12,61,97,81,81,90},20))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({47,97,92,85,80,12,61,97,81,81,90},20))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20))
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
debug(_d({61,97,81,81,90,12,81,90,96,81,94,81,80,12,92,84,77,95,81,12,30},20))
end
local function finishQueen()
debug(_d({50,85,90,85,95,84,85,90,83,12,61,97,81,81,90},20))
equipSwordOrMelee()
setNavNamed(_d({47,97,92,85,80,12,61,97,81,81,90},20))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({47,97,92,85,80,12,61,97,81,81,90},20))
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
debug(_d({61,97,81,81,90,12,80,81,82,81,77,96,81,80,26,12,60,88,77,90,12,79,91,89,92,88,81,96,81,26},20))
end
local CONFIRMATION_PROMPT_NAME = _d({47,91,90,82,85,94,89,77,96,85,91,90,60,94,91,89,92,96},20)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({62,81,89,91,96,81,49,98,81,90,96},20), 5)
end)
if ok then return result end
debug(_d({83,81,96,62,81,92,88,77,101,62,81,89,91,96,81,12,81,94,94,91,94,38},20), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({60,88,77,101,81,94,51,97,85},20))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({53,89,77,83,81,46,97,96,96,91,90},20)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({78,97,96,96,91,90,66,77,88,97,81},20)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({82,85,90,80,46,97,96,96,91,90,46,101,66,77,88,97,81,12,81,94,94,91,94,38},20), result)
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
if not ok then debug(_d({79,88,85,79,87,51,97,85,46,97,96,96,91,90,12,81,94,94,91,94,38},20), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({85,95,63,81,94,98,81,94},20))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({62,81,89,91,96,81,49,98,81,90,96},20))
or inst:FindFirstChild(_d({79,88,85,81,90,96,49,98,81,90,96},20))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({82,85,90,80,45,90,95,99,81,94,47,91,90,90,81,79,96,91,94,12,81,94,94,91,94,38},20), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({47,91,97,88,80,12,90,91,96,12,88,91,79,77,96,81,12,62,81,89,91,96,81,49,98,81,90,96,27,79,88,85,81,90,96,49,98,81,90,96,12,90,81,77,94,12,62,81,92,88,77,101,12,78,97,96,96,91,90,24,12,82,77,88,88,85,90,83,12,78,77,79,87,12,96,91,12,79,88,85,79,87},20))
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
debug(_d({82,85,94,81,62,81,92,88,77,101,66,77,88,97,81,12,81,94,94,91,94,38},20), err, _d({25,12,82,77,88,88,85,90,83,12,78,77,79,87,12,96,91,12,79,88,85,79,87},20))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({50,77,88,88,85,90,83,12,78,77,79,87,12,96,91,12,78,97,96,96,91,90,66,77,88,97,81,12,95,81,77,94,79,84,12,82,91,94,12,62,81,92,88,77,101},20))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({62,81,92,88,77,101,12,78,97,96,96,91,90,12,90,91,96,12,82,91,97,90,80,12,81,85,96,84,81,94,24,12,83,85,98,85,90,83,12,97,92},20))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({67,77,85,96,85,90,83,12,82,91,94,12,47,91,90,82,85,94,89,77,96,85,91,90,60,94,91,89,92,96,26,62,81,89,91,96,81,49,98,81,90,96},20))
local remote = getReplayRemote()
if not remote then
debug(_d({47,91,90,82,85,94,89,77,96,85,91,90,60,94,91,89,92,96,27,62,81,89,91,96,81,49,98,81,90,96,12,90,91,96,12,82,91,97,90,80,12,99,85,96,84,85,90,12,96,85,89,81,91,97,96},20))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({50,85,94,85,90,83,12,62,81,92,88,77,101,12,98,85,77,12,47,91,90,82,85,94,89,77,96,85,91,90,60,94,91,89,92,96,26,62,81,89,91,96,81,49,98,81,90,96},20))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({50,85,94,81,63,81,94,98,81,94,12,81,94,94,91,94,38},20), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20), 10)
if not playerGui then
debug(_d({99,77,85,96,50,91,94,59,78,86,81,79,96,85,98,81,95,51,97,85,38,12,90,91,12,60,88,77,101,81,94,51,97,85,12,99,85,96,84,85,90,12,96,85,89,81,91,97,96,24,12,92,94,91,79,81,81,80,85,90,83,12,77,90,101,99,77,101},20))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({59,78,86,81,79,96,85,98,81,95,12,51,65,53,12,82,91,97,90,80,12,25,12,95,96,77,83,81,12,88,91,77,80,81,80},20))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({59,78,86,81,79,96,85,98,81,95,12,51,65,53,12,90,91,96,12,82,91,97,90,80,12,99,85,96,84,85,90,12,96,85,89,81,91,97,96,24,12,92,94,91,79,81,81,80,85,90,83,12,77,90,101,99,77,101},20))
return
end
end
end)
if not ok then debug(_d({99,77,85,96,50,91,94,59,78,86,81,79,96,85,98,81,95,51,97,85,12,81,94,94,91,94,38},20), err) end
end
local function runPlan()
debug(_d({60,88,77,90,12,95,96,77,94,96,81,80},20))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({63,96,77,94,96,85,90,83,12,90,77,98,12,88,91,91,92},20))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({92,91,95,12,28,26,30,95,12,45,50,64,49,62,12,95,96,77,94,96,58,77,98,38},20), rootAfter and rootAfter.Position)
end)
debug(_d({67,77,85,96,85,90,83,12,33,95,12,78,81,82,91,94,81,12,89,91,98,85,90,83,12,96,91,12,63,96,77,83,81,29},20))
task.wait(5)
for _, stage in ipairs({_d({63,96,77,83,81,29},20), _d({63,96,77,83,81,30},20), _d({63,96,77,83,81,31},20), _d({63,96,77,83,81,31,46},20)}) do
if not enabled then return end
local hpTarget = (stage == _d({63,96,77,83,81,31,46},20)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({57,91,98,85,90,83,12,96,91,12,77,94,94,91,99,12,82,88,101,25,80,91,99,90,12,77,94,81,77,12,20,47,97,92,85,80,12,62,77,85,90,21},20))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({48,91,80,83,85,90,83,12,77,94,94,91,99,12,94,77,85,90,12,85,90,12,77,12,95,93,97,77,94,81},20))
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
clearStage(_d({63,96,77,83,81,32},20))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({61,97,81,81,90,12,85,90,12,92,84,77,95,81,12,30,12,25,12,87,81,81,92,85,90,83,12,55,81,90,12,52,77,87,85,12,77,79,96,85,98,81,12,82,94,91,89,12,84,81,94,81,12,91,90},20))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({63,96,77,96,97,81,29},20))
if not enabled then return end
recheckStatue(_d({63,96,77,96,97,81,29},20))
destroyStatue(_d({63,96,77,96,97,81,30},20))
if not enabled then return end
recheckStatue(_d({63,96,77,96,97,81,29},20))
recheckStatue(_d({63,96,77,96,97,81,30},20))
destroyStatue(_d({63,96,77,96,97,81,31},20))
if not enabled then return end
recheckStatue(_d({63,96,77,96,97,81,31},20))
recheckStatue(_d({63,96,77,96,97,81,30},20))
recheckStatue(_d({63,96,77,96,97,81,29},20))
if not enabled then return end
debug(_d({67,77,85,96,85,90,83,12,82,91,94,12,92,84,77,95,81,12,30,12,96,91,12,81,90,80},20))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({60,84,77,95,81,12,30,12,81,90,80,12,99,77,85,96,12,96,85,89,81,91,97,96,24,12,92,94,91,79,81,81,80,85,90,83,12,77,90,101,99,77,101},20))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({57,91,98,85,90,83,12,78,77,79,87,12,96,91,12,61,97,81,81,90,12,95,96,77,83,81,12,92,91,95,85,96,85,91,90},20))
navToPointConfirmed(COORDS.Queen, 30, _d({61,97,81,81,90,12,95,96,77,83,81,12,92,91,95,85,96,85,91,90},20))
debug(_d({67,77,85,96,85,90,83,12,33,95,12,77,96,12,61,97,81,81,90,12,95,96,77,83,81,12,92,91,95,85,96,85,91,90},20))
task.wait(5)
if not enabled then return end
debug(_d({57,91,98,85,90,83,12,96,91,12,92,91,95,96,25,61,97,81,81,90,12,92,91,95,85,96,85,91,90},20))
navToPointConfirmed(COORDS.PostQueen, 30, _d({92,91,95,96,25,61,97,81,81,90,12,92,91,95,85,96,85,91,90},20))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({49,90,77,78,88,85,90,83,24,12,92,91,95,12,46,49,50,59,62,49,12,92,88,77,90,38},20), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({60,88,77,90,12,81,94,94,91,94,38},20), err2) end
end)
debug(_d({49,90,77,78,88,81,80,38},20), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({49,90,77,78,88,81,80,38},20), enabled)
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
if not ok then debug(_d({53,90,92,97,96,46,81,83,77,90,12,81,94,94,91,94,38},20), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({51,77,89,81,12,88,91,77,80,81,80,24,12,77,97,96,91,25,95,96,77,94,96,85,90,83,12,96,84,81,12,92,88,77,90},20))
enableBot()
end)
if not ok then debug(_d({45,97,96,91,95,96,77,94,96,12,81,94,94,91,94,38},20), err) end
end)
debug(_d({56,91,77,80,81,80,12,206,108,128,12,77,97,96,91,25,95,96,77,94,96,85,90,83,12,91,90,79,81,12,96,84,81,12,83,77,89,81,12,82,85,90,85,95,84,81,95,12,88,91,77,80,85,90,83,12,20,92,94,81,95,95,12,60,12,96,91,12,96,91,83,83,88,81,12,89,77,90,97,77,88,88,101,21},20))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({84,96,96,92,95,38,27,27,94,77,99,26,83,85,96,84,97,78,97,95,81,94,79,91,90,96,81,90,96,26,79,91,89,27,94,91,79,87,101,100,99,77,88,88,27,62,77,101,82,85,81,88,80,27,89,77,85,90,27,95,91,97,94,79,81,26,88,97,77},20)
}
for _, url in ipairs(rayfieldSources) do
local success, result = pcall(function()
return loadstring(game:HttpGet(url))()
end)
if success and result then
Rayfield = result
break
end
end
if not Rayfield then
error(_d({71,52,91,94,91,12,98,30,73,12,50,77,85,88,81,80,12,96,91,12,88,91,77,80,12,62,77,101,82,85,81,88,80,12,65,53,12,56,85,78,94,77,94,101,26},20))
end
local Window = Rayfield:CreateWindow({
Name = _d({52,91,94,91,12,52,91,94,91,12,70,25,50,77,94,89,12,98,30},20),
LoadingTitle = _d({56,91,77,80,85,90,83,12,52,91,94,91,12,98,30,26,26,26},20),
LoadingSubtitle = _d({63,85,88,81,90,96,12,45,85,89,12,59,92,96,85,89,85,102,81,80},20),
ConfigurationSaving = { Enabled = false },
KeySystem = false
})
_G.HoroSelectedBoss = nil
_G.HoroAutoZLoop = false
local checkSpawnInterval = 60
local useE = true
local useZ = true
local useC = true
local useR = true
local lastE = 0
local lastZ = 0
local lastC = 0
local lastR = 0
local statusLabel = nil
local MainTab = Window:CreateTab(_d({45,97,96,91,12,50,77,94,89},20), 4483362458)
local SkillTab = Window:CreateTab(_d({63,87,85,88,88,12,63,81,96,96,85,90,83,95},20), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)) or (bp and bp:FindFirstChild(_d({52,91,94,91,25,52,91,94,91},20)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = boss:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
if not _G.HoroMouseHooked then
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and _G.HoroAutoZLoop and _G.HoroSelectedBoss then
local target = getBossPart(_G.HoroSelectedBoss)
if target then
if key == _d({52,85,96},20) then
return target.CFrame
elseif key == _d({64,77,94,83,81,96},20) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({71,52,91,94,91,12,98,30,73,12,57,81,96,77,96,77,78,88,81,12,84,91,91,87,12,82,77,85,88,81,80,38,12},20) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({71,52,91,94,91,12,98,30,73,12,47,88,81,77,90,81,80,12,97,92,12,92,94,81,98,85,91,97,95,12,95,81,95,95,85,91,90,26},20))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,67,77,85,96,85,90,83,12,82,91,94,12,46,91,95,95,12,63,92,77,99,90},20)) end
print(_d({71,52,91,94,91,12,98,30,73,12,46,91,95,95},20), _G.HoroSelectedBoss, _d({85,95,12,90,91,96,12,95,92,77,99,90,81,80,26,12,67,77,85,96,85,90,83,26,26,26},20))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,62,97,90,90,85,90,83,12,47,91,89,78,91},20)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,47,12,20,55,77,89,85,87,77,102,81,21},20))
elseif useZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,70,12,20,57,85,90,85,12,46,77,94,94,77,83,81,21},20))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,49,12,20,63,96,97,90,21},20))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({71,52,91,94,91,12,98,30,73,12,50,85,94,81,80,12,62,12,20,48,81,96,91,90,77,96,85,91,90,21},20))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,63,88,81,81,92,85,90,83,12,20},20) .. string.format(_d({17,26,29,82},20), finalSleep) .. _d({95,21},20)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({63,96,77,96,97,95,38,12,53,80,88,81},20))
MainTab:CreateDropdown({
Name = _d({63,81,88,81,79,96,12,46,91,95,95},20),
Options = {_d({45,100,81,12,52,77,90,80,12,56,91,83,77,90},20), _d({46,77,90,80,85,96,12,46,91,95,95},20), _d({54,97,102,91,12,96,84,81,12,48,85,77,89,91,90,80,78,77,79,87},20)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({71,52,91,94,91,12,98,30,73,12,63,81,88,81,79,96,81,80,12,96,77,94,83,81,96,38},20), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({63,96,77,94,96,12,45,97,96,91,12,50,77,94,89},20),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({63,81,88,81,79,96,12,46,91,95,95,12,62,81,93,97,85,94,81,80},20),
Content = _d({69,91,97,12,89,97,95,96,12,95,81,88,81,79,96,12,77,12,78,91,95,95,12,82,85,94,95,96,12,78,81,82,91,94,81,12,81,90,77,78,88,85,90,83,12,45,97,96,91,12,50,77,94,89,13},20),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({63,96,77,96,97,95,38,12,53,80,88,81},20)) end
end
print(_d({71,52,91,94,91,12,98,30,73,12,45,97,96,91,12,50,77,94,89,38},20), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({48,81,95,96,94,91,101,12,65,53},20),
Callback = function()
_G.HoroFarmCleanup()
end,
})
SkillTab:CreateLabel("
SkillTab:CreateToggle({
Name = "Use E (Stun)",
CurrentValue = true,
Callback = function(Value) useE = Value end,
})
SkillTab:CreateToggle({
Name = "Use Z (Mini)",
CurrentValue = true,
Callback = function(Value) useZ = Value end,
})
SkillTab:CreateToggle({
Name = "Use C (Kamikaze)",
CurrentValue = true,
Callback = function(Value) useC = Value end,
})
SkillTab:CreateToggle({
Name = "Use R (Snap)",
CurrentValue = true,
Callback = function(Value) useR = Value end,
})
})();
end
local function loadLevelGrinder()
(function()
_G.EasyTravelHelperMode = true
if _G.GepoGrinderCleanup then
pcall(_G.GepoGrinderCleanup)
end
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = "Bandit"
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild("Stats_d({21,12,77,90,80,12,95,96,77,96,95,50,91,88,80,81,94,26,63,96,77,96,95,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,20},20)Level") and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild("Stats_d({21,12,77,90,80,12,95,96,77,96,95,50,91,88,80,81,94,26,63,96,77,96,95,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,20},20)Peli") and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild("Quest_d({21,12,77,90,80,12,95,96,77,96,95,50,91,88,80,81,94,26,61,97,81,95,96,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,20},20)CurrentQuest_d({21,12,77,90,80,12,95,96,77,96,95,50,91,88,80,81,94,26,61,97,81,95,96,26,47,97,94,94,81,90,96,61,97,81,95,96,26,66,77,88,97,81,12,91,94,12},20)None"
return lvl, peli, quest
end
return 1, 0, "None"
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = npc:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
if root and hum and hum.Health > 0 then
table.insert(targets, npc)
end
end
end
return targets
end
local function setNPCPartsCollision(npc, enabled)
if not npc then return end
for _, part in ipairs(npc:GetDescendants()) do
if part:IsA(_d({46,77,95,81,60,77,94,96},20)) then
part.CanCollide = enabled
end
end
end
local function simulateM1()
pcall(function()
local cam = Workspace.CurrentCamera
local vp = cam and cam.ViewportSize or Vector2.new(1920, 1080)
local x, y = math.floor(vp.X / 2), math.floor(vp.Y / 2)
VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
task.wait(0.01)
VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
end)
end
local function computeHorizontalCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then fwdFlat = Vector3.new(0, 0, 1) end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, root.Position.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function computeLockedCFrame(root, aimPos, facePos)
return computeHorizontalCFrame(root, facePos) + (aimPos - root.Position)
end
local function navigateTo(targetPos)
if not _G.EasyTravel then
pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/rockyxwall/luau-code/main/01_script/features/easy_travel.lua"))()
end)
end
if _G.EasyTravel then
if not _G.EasyTravel.Enabled then
pcall(_G.EasyTravel.Start)
end
_G.EasyTravel.TargetPosition = targetPos
local myRoot = getRoot()
if myRoot and (targetPos - myRoot.Position).Magnitude <= 3.5 then
_G.EasyTravel.TargetPosition = nil
return true
end
else
warn("[Gepo Grinder] _G.EasyTravel is missing. Please ensure easy_travel.lua is running first.")
end
return false
end
local function stopNavigation()
if _G.EasyTravel then
_G.EasyTravel.TargetPosition = nil
pcall(_G.EasyTravel.Stop)
end
end
local function acceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild("UpperTorso")
local prompt = torso and torso:FindFirstChild("Prompt")
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position + (torso.CFrame.LookVector * 5.0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Quest Acceptance] fireproximityprompt not supported by executor!")
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({60,88,77,101,81,94,51,97,85},20))
local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild("go")
local endChatBtn = chatGui.Frame:FindFirstChild("endChat")
if goBtn and goBtn.Visible and goBtn.Text ~= "_d({12,77,90,80,12,83,91,46,96,90,26,64,81,100,96,12,106,41,12},20)..." then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
conn:Fire()
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
conn:Fire()
end
end
end
task.wait(0.4)
end
end
return true
end
return false
end
local function toggleAutoFarm(value)
if value ~= nil then
autoGrind = value
else
autoGrind = not autoGrind
end
if not autoGrind then
stopNavigation()
local targets = getActiveTargetNPCs()
for _, npc in ipairs(targets) do
pcall(setNPCPartsCollision, npc, true)
end
end
end
UserInputService.InputBegan:Connect(function(input, processed)
if not processed then
if input.KeyCode == Enum.KeyCode.P then
toggleAutoFarm()
print("[Gepo Grinder] Auto farm toggled to: " .. tostring(autoGrind))
end
end
end)
task.spawn(function()
while autoGrind ~= nil do
task.wait(0.2)
if autoGrind then
pcall(function()
local myRoot = getRoot()
local myHum = getHumanoid()
if myRoot and myHum then
local lvl, peli, quest = getStats()
local hasRifle = LocalPlayer.Backpack:FindFirstChild("Rifle_d({21,12,91,94,12,56,91,79,77,88,60,88,77,101,81,94,26,47,84,77,94,77,79,96,81,94,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,20},20)Rifle")
if lvl < 5 and peli < 300 and not hasRifle then
targetMob = "Bandit"
if lvl < 3 then
if quest == "None" then
acceptQuest("Daph")
return
end
else
if quest == "None" then
acceptQuest("Sarah")
return
end
end
elseif lvl >= 5 and peli < 300 and not hasRifle then
targetMob = _d({46,77,90,80,85,96,12,46,91,95,95},20)
if quest == "None" then
acceptQuest("Ronny")
return
end
elseif peli >= 300 and not hasRifle then
local buyables = Workspace:FindFirstChild("BuyableItems")
local shopItem = buyables and buyables:FindFirstChild("Rifle")
local shopPart = shopItem and shopItem:FindFirstChild("ShopPart")
if shopPart then
local targetPos = shopPart.Position + Vector3.new(0, 2, 0)
local reached = navigateTo(targetPos)
if reached then
stopNavigation()
task.wait(0.5)
local prompt = shopItem:FindFirstChildWhichIsA("ProximityPrompt", true)
if prompt then
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Rifle Purchase] fireproximityprompt not supported by executor!")
end
task.wait(1.5)
end
end
return
end
elseif hasRifle then
stopNavigation()
print("[Gepo Grinder] Rifle purchased! Starter Island progression completed. Waiting for Fishman Cave travel phase.")
task.wait(5)
return
end
local targets = getActiveTargetNPCs()
local n = #targets
if n > 0 then
local bp = LocalPlayer:FindFirstChild(_d({46,77,79,87,92,77,79,87},20))
local weaponTool = bp and bp:FindFirstChild("Melee")
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({21,12,77,90,80,12,90,92,79,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,67,84,85,79,84,53,95,45,20},20)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, npc, false)
local targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (targetPos - myRoot.Position).Magnitude > 8 and (tick() - startTime) < 1.5 do
targetPos = npcRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(targetPos)
task.wait(0.05)
end
if autoGrind and (targetPos - myRoot.Position).Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, targetPos, npcRoot.Position)
simulateM1()
task.wait(0.15)
end
end
end
end
if autoGrind then
local finalNpc = targets[n]
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({21,12,77,90,80,12,82,85,90,77,88,58,92,79,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,67,84,85,79,84,53,95,45,20},20)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({21,12,77,90,80,12,82,85,90,77,88,58,92,79,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,67,84,85,79,84,53,95,45,20},20)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local dir = (finalTargetPos - myRoot.Position)
if dir.Magnitude < 10 then
stopNavigation()
myRoot.CFrame = computeLockedCFrame(myRoot, finalTargetPos, finalRoot.Position)
for combo = 1, 4 do
if not autoGrind then break end
simulateM1()
task.wait(0.2)
end
task.wait(1.2)
else
navigateTo(finalTargetPos)
task.wait(0.05)
end
end
end
end
else
stopNavigation()
end
else
stopNavigation()
end
end)
end
end
end)
_G.GepoGrinderCleanup = function()
autoGrind = nil
stopNavigation()
local npcsFolder = Workspace:FindFirstChild(_d({58,60,47,95},20))
if npcsFolder then
for _, npc in ipairs(npcsFolder:GetChildren()) do
pcall(setNPCPartsCollision, npc, true)
end
end
print("[Gepo Grinder] Cleaned up previous session.")
end
print("[Gepo Grinder] Automated script loaded. Press 'P' to toggle auto farm.")
})();
end
local function loadNavigationLab()
(function()
if _G.EasyTravelCleanup then
pcall(_G.EasyTravelCleanup)
end
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local FLIGHT_SPEED = 70.0
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local flightEnabled = false
local currentTargetY = 0
local loopConnection = nil
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local inputConnection = nil
_G.EasyTravel = {
TargetPosition = nil,
DisableKeyboard = (_G.EasyTravelHelperMode == true),
Speed = FLIGHT_SPEED,
Enabled = false
}
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
local root = char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
local hum = char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({21,12,91,94,12,53,90,95,96,77,90,79,81,26,90,81,99,20},20)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = "__EasyTravelForce"
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
local force = root:FindFirstChild("__EasyTravelForce")
local att = root:FindFirstChild("__EasyTravelAtt")
if force then force:Destroy() end
if att then att:Destroy() end
end
end
local function getSurfaceY(position, character)
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
while flightEnabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
if _G.EasyTravel.TargetPosition then
isClimbing = false
currentTargetY = _G.EasyTravel.TargetPosition.Y
continue
end
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
if not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
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
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = getSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = getSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = getSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
local function startFlight()
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
flightEnabled = true
_G.EasyTravel.Enabled = true
currentTargetY = getSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, currentHum, currentRoot = getCharacterComponents()
if not currentRoot or not flightEnabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil; end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = currentTargetY
if _G.EasyTravel.TargetPosition then
local diff = _G.EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
finalTargetY = _G.EasyTravel.TargetPosition.Y
else
if not _G.EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
finalTargetY = isClimbing and climbTargetY or currentTargetY
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
local currentSpeed = _G.EasyTravel.Speed or FLIGHT_SPEED
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if isClimbing and yError > 3 then
if distanceToWall < 6 then
speedMultiplier = 0
else
speedMultiplier = 1
end
end
targetVelocity = moveDir.Unit * (currentSpeed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print("[Easy Travel] Flight enabled.")
end
local function stopFlight()
flightEnabled = false
_G.EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect();
loopConnection = nil;
end
cleanupForce()
print("[Easy Travel] Flight disabled.")
end
_G.EasyTravel.Start = startFlight
_G.EasyTravel.Stop = stopFlight
if not _G.EasyTravelHelperMode then
inputConnection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == Enum.KeyCode.P then
if flightEnabled then
stopFlight()
else
startFlight()
end
elseif input.KeyCode == Enum.KeyCode.End then
if _G.EasyTravelCleanup then
_G.EasyTravelCleanup()
end
end
end)
end
_G.EasyTravelCleanup = function()
stopFlight()
if inputConnection then
inputConnection:Disconnect()
inputConnection = nil
end
_G.EasyTravel = nil
_G.EasyTravelCleanup = nil
print("[Easy Travel] Completely unloaded and cleaned up script state.")
end
if _G.EasyTravelHelperMode then
print("[Easy Travel] Loaded in helper mode. Keyboard inputs disabled.")
else
print("[Easy Travel] Loaded. Press 'P' to toggle flight. _G.EasyTravel API registered.")
end
return _G.EasyTravel
})();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({60,88,77,101,81,94,95},20))
local RunService = game:GetService(_d({62,97,90,63,81,94,98,85,79,81},20))
local UserInputService = game:GetService(_d({65,95,81,94,53,90,92,97,96,63,81,94,98,85,79,81},20))
local ReplicatedStorage = game:GetService(_d({62,81,92,88,85,79,77,96,81,80,63,96,91,94,77,83,81},20))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({85,80,88,81},20)
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
print("[OverworldTester]", ...)
end
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({63,96,77,96,95},20) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({62,91,87,97,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,81,92,92,91},20), args)
elseif style == _d({46,88,77,79,87,56,81,83},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87},20), args)
elseif style == _d({55,77,89,85,95,84,85,87,85},20) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,77,89,85,95,84,85,87,85,51,81,92,92,91},20), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({63,87,101,12,67,77,88,87,30},20), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({85,90,98,91,87,81,51,81,92,92,91,12,81,94,94,91,94,38},20), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({21,12,91,94,12,53,90,95,96,77,90,79,81,26,90,81,99,20},20)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({56,85,90,81,77,94,66,81,88,91,79,85,96,101},20))
force.Name = "__TestHoverForce"
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
local root = char:FindFirstChild(_d({52,97,89,77,90,91,85,80,62,91,91,96,60,77,94,96},20))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({67,77,88,87,85,90,83,12,96,91,38},20), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({99,77,88,87,64,91,60,91,85,90,96,12,67,12,80,91,99,90,12,81,94,94,91,94,38},20), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({45,94,94,85,98,81,80,12,77,96,38},20), pos)
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
local root = getRoot()
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA("Model_d({21,12,77,90,80,12,85,96,81,89,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,20},20)HumanoidRootPart_d({21,12,77,90,80,12,85,96,81,89,38,50,85,90,80,50,85,94,95,96,47,84,85,88,80,67,84,85,79,84,53,95,45,20},20)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({52,97,89,77,90,91,85,80},20)).Health > 0 then
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
mode = _d({85,80,88,81},20)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug("Tester Disabled")
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug("Tester Enabled. Mode:", mode)
local initialPos = getRoot() and getRoot().Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug("Player died! Disabling bot.")
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({84,91,98,81,94},20) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == "dodge" then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == "square_dodge" then
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
local playerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild("OverworldTestGui")
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "OverworldTestGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "🛡️ Cupid Engine Overworld Test"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({63,96,77,96,97,95,38,12,53,80,88,81},20)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new("TextBox")
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn("Hover Above Target", 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({84,91,98,81,94},20))
statusLabel.Text = "Status: Hovering _d({12,26,26,12,98,77,88,12,26,26,12},20) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({12,26,26,12,98,77,88,12,26,26,12},20) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({12,26,26,12,98,77,88,12,26,26,12},20) studs)"
task.spawn(function()
local root = getRoot()
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
while enabled and mode == "square_dodge" and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == "square_dodge" then
disableBot()
statusLabel.Text = "Status: Idle (Square dodge done)"
end
end)
end)
local stopBtn = Instance.new("TextButton")
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = "EMERGENCY STOP"
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = "Status: STOPPED (Idle)"
local VIM = game:GetService(_d({66,85,94,96,97,77,88,53,90,92,97,96,57,77,90,77,83,81,94},20))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({60,88,77,101,81,94,51,97,85},20), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild("GPOLauncherUI")
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GPOLauncherUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = "🌌 GPO Hub Launcher"
title.Parent = main
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = "Choose a bot or utility to run:"
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = "  " .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new("TextLabel")
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
CreateLaunchButton("Cupid Dungeon Farm_d({24,12},20)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({24,12},20)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({24,12},20)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({24,12},20)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({24,12},20)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()