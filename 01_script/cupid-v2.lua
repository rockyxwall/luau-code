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
local att = root:FindFirstChild(_d({75,75,52,91,98,81,94,45,96,96},20)) or Instance.new(_d({45,96,96,77,79,84,89,81,90,96},20))
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
end)()