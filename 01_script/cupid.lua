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
local Players            = game:GetService(_d({59,87,76,100,80,93,94},21))
local UserInputService    = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local RunService          = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local VIM                 = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local ReplicatedStorage    = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({70,45,90,94,94,45,90,95,72},21), _d({66,93,90,89,82,11,82,76,88,80,11,205,107,127,11,59,87,76,78,80,52,79,37},21), game.PlaceId, _d({64,89,84,97,80,93,94,80,52,79,37},21), game.GameId, _d({24,11,89,90,95,11,93,96,89,89,84,89,82},21))
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
local LEO_PILLAR_ANIM_ID   = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,31,31,28,31,28,30,29,34},21)
local LEO_ENTEI_ANIM_ID    = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,31,31,28,30,35,29,34,35},21)
local LEO_HIKEN_ANIM_ID    = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,29,27,36,28,34,31,27,34},21)
local LEO_FIREFLY_ANIM_ID  = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,29,27,29,30,33,28,32,31},21)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({58,77,85,80,78,95,84,97,80,94},21)
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
local REPLAY_BUTTON_VALUE   = _d({61,80,91,87,76,100},21)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({88,90,97,80},21)
local NavState   = {mode = _d({84,79,87,80},21)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({70,45,90,94,94,45,90,95,72},21), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end)
if ok then return root end
debug(_d({82,80,95,61,90,90,95,11,80,93,93,90,93,37},21), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
end)
if ok then return hum end
debug(_d({82,80,95,51,96,88,76,89,90,84,79,11,80,93,93,90,93,37},21), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({74,74,51,90,97,80,93,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,51,90,97,80,93,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,51,90,97,80,93,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,51,90,97,80,93,49,90,93,78,80},21)
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
debug(_d({82,80,95,58,93,46,93,80,76,95,80,49,90,93,78,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then return end
local force = root:FindFirstChild(_d({74,74,51,90,97,80,93,49,90,93,78,80},21))
local att   = root:FindFirstChild(_d({74,74,51,90,97,80,93,44,95,95},21))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({78,87,80,76,89,96,91,49,90,93,78,80,11,80,93,93,90,93,37},21), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({45,96,94,90,56,80,87,80,80},21)) ~= nil
end)
if ok then return result end
debug(_d({84,94,45,96,94,90,44,78,95,84,97,80,11,80,93,93,90,93,37},21), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({45,96,94,90},21))
end)
if not ok then debug(_d({76,78,95,84,97,76,95,80,45,96,94,90,11,80,93,93,90,93,37},21), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({45,96,94,90,11,89,90,95,11,76,78,95,84,97,80,23,11,76,78,95,84,97,76,95,84,89,82},21))
activateBuso()
end
end)
if not ok then debug(_d({45,96,94,90,54,80,80,91,80,93,11,80,93,93,90,93,37},21), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({45,96,94,90,11,86,80,80,91,80,93,11,94,95,90,91,91,80,79},21))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({54,80,89,51,76,86,84},21)) ~= nil
end)
if ok then return result end
debug(_d({84,94,54,80,89,44,78,95,84,97,80,11,80,93,93,90,93,37},21), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({54,80,89},21), true)
end)
if not ok then debug(_d({76,78,95,84,97,76,95,80,54,80,89,11,80,93,93,90,93,37},21), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({54,80,89,11,89,90,95,11,76,78,95,84,97,80,23,11,76,78,95,84,97,76,95,84,89,82},21))
activateKen()
end
end)
if not ok then debug(_d({54,80,89,54,80,80,91,80,93,11,80,93,93,90,93,37},21), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({54,80,89,11,86,80,80,91,80,93,11,94,95,90,91,91,80,79},21))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({57,59,46,94},21)) end)
if ok then return folder end
debug(_d({82,80,95,57,59,46,94,49,90,87,79,80,93,11,80,93,93,90,93,37},21), folder)
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
local r = model:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local h = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
debug(_d({82,80,95,57,80,76,93,80,94,95,57,59,46,11,80,93,93,90,93,37},21), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hum  = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({82,80,95,57,59,46,45,100,57,76,88,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({89,91,78,94,61,80,88,76,84,89,84,89,82,11,80,93,93,90,93,37},21), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({46,96,91,84,79,11,60,96,80,80,89},21))
return queen ~= nil and queen:FindFirstChild(_d({88,90,95,84,90,89,55,80,94,94},21)) ~= nil
end)
if ok then return result end
debug(_d({84,94,60,96,80,80,89,59,83,76,94,80,29,11,80,93,93,90,93,37},21), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,28,29,28,29,36,34,36,31,29,29,36,29,34,33,36},21)
local QUEEN_GRASP_ANIM_ID   = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,28,29,36,35,27,27,27,33,28,27,27,28,34,30,31},21)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
debug(_d({84,94,59,87,76,100,84,89,82,44,89,84,88,49,93,90,88,55,84,94,95,11,80,93,93,90,93,37},21), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({45,87,90,78,86,84,89,82},21)) ~= nil
end)
if ok then return result end
debug(_d({84,94,57,59,46,45,87,90,78,86,84,89,82,11,80,93,93,90,93,37},21), result)
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
debug(_d({91,93,80,79,84,78,95,57,59,46,59,90,94,84,95,84,90,89,11,80,93,93,90,93,37},21), result)
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
debug(_d({57,90,11,79,76,88,76,82,80,11,90,89},21), model.Name, _d({81,90,93},21), NPC_STUCK_TIMEOUT, _d({94,11,24,11,94,98,84,95,78,83,84,89,82,11,95,76,93,82,80,95},21))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({95,93,76,78,86,57,59,46,47,76,88,76,82,80,11,80,93,93,90,93,37},21), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({56,90,79,80,87},21)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({45,76,94,80,59,76,93,95},21)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({82,80,95,56,90,79,80,87,49,76,78,80,59,90,94,11,80,93,93,90,93,37},21), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({48,89,97},21))
local folder = env and env:FindFirstChild(_d({62,95,76,95,96,80,94},21))
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
debug(_d({82,80,95,62,95,76,95,96,80,56,90,79,80,87,57,80,76,93,11,80,93,93,90,93,37},21), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({77,76,93,93,80,87,51,59},21))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({82,80,95,62,95,76,95,96,80,51,59,11,80,93,93,90,93,37},21), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({63,90,90,87},21)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({81,84,89,79,63,90,90,87,45,100,44,95,95,93,84,77,96,95,80,11,80,93,93,90,93,37},21), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({63,90,90,87},21)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({81,84,89,79,63,90,90,87,45,100,57,76,88,80,11,80,93,93,90,93,37},21), tool)
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
if not ok then debug(_d({80,92,96,84,91,63,90,90,87,11,80,93,93,90,93,37},21), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({63,90,90,87},21)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({81,84,89,79,63,90,90,87,45,100,46,83,84,87,79,57,76,88,80,11,80,93,93,90,93,37},21), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({62,98,90,93,79,48,92,96,84,91},21))
if sword then
equipTool(sword)
return _d({94,98,90,93,79},21)
end
local melee = findToolByAttribute(_d({56,80,87,80,80,63,90,90,87},21))
if melee then
equipTool(melee)
return _d({88,80,87,80,80},21)
end
debug(_d({57,90,11,94,98,90,93,79,11,90,93,11,88,80,87,80,80,11,95,90,90,87,11,81,90,96,89,79},21))
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
if not ok then debug(_d({78,87,84,78,86,56,28,11,80,93,93,90,93,37},21), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({61,90,86,96,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,80,91,91,90},21), args)
elseif style == _d({45,87,76,78,86,55,80,82},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86},21), args)
elseif style == _d({54,76,88,84,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,76,88,84,94,83,84,86,84,50,80,91,91,90},21), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86,29},21), args)
end
end)
if not ok then debug(_d({84,89,97,90,86,80,50,80,91,91,90,11,80,93,93,90,93,37},21), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({91,93,80,94,94,62,86,84,87,87,61,11,80,93,93,90,93,37},21), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({83,90,87,79,45,87,90,78,86,11,80,93,93,90,93,37},21), err) end
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
if not ok then debug(_d({83,90,87,79,45,87,90,78,86,66,83,84,87,80,11,80,93,93,90,93,37},21), err) end
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
debug(_d({82,80,95,50,76,88,80,50,11,80,93,93,90,93,37},21), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({84,94,61,80,76,87,56,28,45,96,94,100,11,80,93,93,90,93,37},21), result)
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
return char ~= nil and char:FindFirstChild(_d({94,95,96,89},21)) ~= nil
end)
if ok then return result end
debug(_d({84,94,62,95,96,89,89,80,79,11,80,93,93,90,93,37},21), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({91,93,80,94,94,62,95,96,89,45,93,80,76,86,11,80,93,93,90,93,37},21), err) end
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
debug(_d({92,96,80,80,89,47,90,79,82,80,64,89,95,84,87,62,76,81,80,37,11,60,96,80,80,89,11,82,90,89,80,11,24,11,80,89,79,84,89,82,11,79,90,79,82,80,11,80,76,93,87,100},21))
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
debug(_d({92,96,80,80,89,47,90,79,82,80,64,89,95,84,87,62,76,81,80,11,94,76,81,80,95,100,11,95,84,88,80,90,96,95},21))
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
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({60,96,80,80,89,11,78,76,94,95,84,89,82,11,79,80,95,80,78,95,80,79,11,24,11,79,90,79,82,84,89,82,11,19,98,76,95,78,83,80,93,20},21))
queenDodgeUntilSafe(function() return getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21)) end)
if enabled and getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21)) then
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
end
queenDodging = false
end
end)
if not ok then debug(_d({92,96,80,80,89,47,90,79,82,80,66,76,95,78,83,80,93,11,80,93,93,90,93,37},21), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({91,90,84,89,95},21) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({89,91,78},21) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({89,76,88,80,79},21) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({82,80,95,57,76,97,63,76,93,82,80,95,94,11,80,93,93,90,93,37},21), aimR)
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
debug(_d({78,90,88,91,96,95,80,55,90,78,86,80,79,46,49,93,76,88,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({91,90,84,89,95},21), point = pos}
phase = _d({88,90,97,80},21)
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
if not ok then debug(_d({89,76,97,63,90,59,90,84,89,95,11,82,80,91,91,90,11,78,83,80,78,86,11,80,93,93,90,93,37},21), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({89,91,78},21)}
phase = _d({88,90,97,80},21)
end
function setNavNamed(name)
NavState = {mode = _d({89,76,88,80,79},21), name = name}
phase = _d({88,90,97,80},21)
end
local function setNavIdle()
NavState = {mode = _d({84,79,87,80},21)}
phase = _d({88,90,97,80},21)
end
local function hasArrived()
return phase == _d({83,90,97,80,93},21)
end
local function startNav()
phase = _d({88,90,97,80},21)
debug(_d({57,76,97,11,87,90,90,91,11,58,57},21))
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
local prevPos = force:GetAttribute(_d({74,74,91,93,80,97,59,90,94},21))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({55,76,93,82,80,11,91,90,94,84,95,84,90,89,11,85,96,88,91,11,79,80,95,80,78,95,80,79,37},21), delta, _d({94,95,96,79,94,25,11,91,93,80,97,59,90,94,40},21), prevPos, _d({89,80,98,59,90,94,40},21), pos)
end
end
force:SetAttribute(_d({74,74,91,93,80,97,59,90,94},21), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({88,90,97,80},21) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({83,90,97,80,93},21)
debug(_d({59,83,76,94,80,37,11,83,90,97,80,93},21))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({12,12,12,11,61,48,49,64,62,52,57,50,11,63,58,11,44,59,59,55,68,11,44,45,57,58,61,56,44,55,11,65,48,55,58,46,52,63,68,37},21), finalVel, _d({76,84,88,40},21), aim, _d({91,90,94,40},21), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({83,90,97,80,93},21) then
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
debug(_d({46,90,88,77,76,95,11,87,90,78,86,11,94,86,84,91,91,80,79,23},21), snapDist, _d({94,95,96,79,94,11,81,93,90,88,11,95,76,93,82,80,95,11,205,107,127,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,88,90,97,80},21))
phase = _d({88,90,97,80},21)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({51,80,76,93,95,77,80,76,95,11,80,93,93,90,93,37},21), err) end
end)
end
local function stopNav()
debug(_d({57,76,97,11,87,90,90,91,11,58,49,49},21))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({88,90,97,80},21)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({63,80,99,95,46,83,76,95,62,80,93,97,84,78,80},21))
local channels = TextChatService:FindFirstChild(_d({63,80,99,95,46,83,76,89,89,80,87,94},21))
local channel = channels and channels:FindFirstChild(_d({61,45,67,50,80,89,80,93,76,87},21))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({47,80,81,76,96,87,95,46,83,76,95,62,100,94,95,80,88,46,83,76,95,48,97,80,89,95,94},21))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({62,76,100,56,80,94,94,76,82,80,61,80,92,96,80,94,95},21))
if sayEvent then
sayEvent:FireServer(message, _d({44,87,87},21))
return
end
debug(_d({94,80,89,79,46,83,76,95,56,80,94,94,76,82,80,37,11,89,90,11,63,80,99,95,46,83,76,95,62,80,93,97,84,78,80,25,61,45,67,50,80,89,80,93,76,87,11,90,93,11,87,80,82,76,78,100,11,62,76,100,56,80,94,94,76,82,80,61,80,92,96,80,94,95,11,81,90,96,89,79,11,81,90,93},21), message)
end)
if not ok then debug(_d({94,80,89,79,46,83,76,95,56,80,94,94,76,82,80,11,80,93,93,90,93,37},21), err) end
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
debug(_d({57,90,95,11,88,76,86,84,89,82,11,91,93,90,82,93,80,94,94,11,95,90,98,76,93,79,11,89,76,97,11,95,76,93,82,80,95,11,81,90,93},21), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({94,11,24,11,94,80,89,79,84,89,82,11,26,96,89,94,95,96,78,86},21))
sendChatMessage(_d({26,96,89,94,95,96,78,86},21))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({98,76,84,95,64,89,95,84,87,44,93,93,84,97,80,79,11,95,84,88,80,90,96,95},21))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({89,76,97,63,90,59,90,84,89,95,46,90,89,81,84,93,88,80,79,37},21), label or _d({95,76,93,82,80,95},21), _d({24,11,79,84,79,11,89,90,95,11,76,93,93,84,97,80,11,98,84,95,83,84,89},21), timeout, _d({94,23,11,93,80,95,93,100,84,89,82,11,90,89,78,80},21))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({89,76,97,63,90,59,90,84,89,95,46,90,89,81,84,93,88,80,79,37},21), label or _d({95,76,93,82,80,95},21), _d({24,11,94,95,84,87,87,11,89,90,95,11,76,93,93,84,97,80,79,11,76,81,95,80,93,11,93,80,95,93,100,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
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
if not ok then debug(_d({89,76,97,63,90,59,90,84,89,95,51,90,87,79,84,89,82,45,87,90,78,86,11,86,80,100,24,79,90,98,89,11,80,93,93,90,93,37},21), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({89,76,97,63,90,59,90,84,89,95,51,90,87,79,84,89,82,45,87,90,78,86,11,86,80,100,24,96,91,11,80,93,93,90,93,37},21), err2) end
end
local function clearStage(stageName)
debug(_d({56,90,97,84,89,82,11,95,90},21), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,57,59,46,94,11,95,90,11,94,91,76,98,89,11,76,95},21), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({11,11,94,91,76,98,89,11,78,83,80,78,86,37,11,81,90,87,79,80,93,11,80,99,84,94,95,94,11,40},21), folder ~= nil,
_d({23,11,78,83,84,87,79,93,80,89,11,40},21), folder and #folder:GetChildren() or 0,
_d({23,11,76,87,84,97,80,11,40},21), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({57,90,11,57,59,46,94,11,76,91,91,80,76,93,80,79,11,76,95},21), stageName, _d({76,81,95,80,93,11,28,32,94,23,11,88,90,97,84,89,82,11,90,89,11,76,89,100,98,76,100},21))
break
end
end
debug(_d({54,84,87,87,84,89,82,11,57,59,46,94,11,76,95},21), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({61,80,95,96,93,89,84,89,82,11,95,90},21), stageName, _d({91,90,94,84,95,84,90,89,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,90,89},21))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95},21), stageName, _d({91,90,94,84,95,84,90,89},21))
task.wait(5)
debug(stageName, _d({78,87,80,76,93,80,79},21))
end
local function killNamedNPC(name, targetPos)
debug(_d({56,90,97,84,89,82,11,95,90},21), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({79,80,81,80,76,95,80,79},21))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({55,80,90,11,91,87,76,100,80,79,11,76,89,84,88,76,95,84,90,89,37},21), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({87,80,90,44,89,84,88,55,90,82,82,80,93,11,91,93,84,89,95,11,80,93,93,90,93,37},21), err2) end
end)
end)
if not ok then debug(_d({94,95,76,93,95,55,80,90,44,89,84,88,55,90,82,82,80,93,11,80,93,93,90,93,37},21), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({56,90,97,84,89,82,11,95,90,11,55,80,90,11,19,77,87,90,78,86,84,89,82,11,76,81,95,80,93},21), LEO_BLOCK_DELAY, _d({94,20},21))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({55,80,90},21))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({55,80,90},21))
while enabled do
local info = getNPCByName(_d({55,80,90},21))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({55,80,90,11,78,76,94,95,84,89,82},21), which, _d({24,11,79,90,79,82,84,89,82},21))
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
if not getNPCByName(_d({55,80,90},21)) then
debug(_d({55,80,90,11,82,90,89,80,11,88,84,79,24,79,90,79,82,80,11,24,11,80,89,79,84,89,82,11,48,89,95,80,84,11,83,90,87,79,11,80,76,93,87,100},21))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({55,80,90},21)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({55,80,90,11,82,90,89,80,11,88,84,79,24,79,90,79,82,80,11,24,11,80,89,79,84,89,82,11,49,87,76,88,80,11,59,84,87,87,76,93,11,83,90,87,79,11,80,76,93,87,100},21))
end
end
end
if enabled and getNPCByName(_d({55,80,90},21)) then
setNavNamed(_d({55,80,90},21))
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
debug(_d({55,80,90,11,79,80,81,80,76,95,80,79},21))
stopLeoAnimLogger()
debug(_d({61,80,95,96,93,89,84,89,82,11,95,90,11,55,80,90,11,91,90,94,84,95,84,90,89,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,90,89},21))
navToPointConfirmed(COORDS.Leo, 30, _d({55,80,90,11,91,90,94,84,95,84,90,89},21))
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95,11,55,80,90,11,91,90,94,84,95,84,90,89},21))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({56,90,97,84,89,82,11,95,90},21), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,94,95,76,95,96,80,11,88,90,79,80,87,11,89,80,76,93},21), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({44,95,95,76,78,86,84,89,82},21), coordKey, _d({98,84,95,83},21), weapon or _d({89,90,95,83,84,89,82,11,81,90,96,89,79},21))
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
debug(coordKey, _d({77,76,93,93,80,87,11,79,80,94,95,93,90,100,80,79},21))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({24,11,78,90,96,87,79,11,89,90,95,11,81,84,89,79,11,94,95,76,95,96,80,11,88,90,79,80,87,23,11,94,86,84,91,91,84,89,82},21))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({94,95,84,87,87,11,76,87,84,97,80,11,19,51,59},21), hp, _d({20,11,24,11,93,80,24,79,80,94,95,93,90,100,84,89,82},21))
destroyStatue(coordKey)
else
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({78,90,89,81,84,93,88,80,79,11,79,80,94,95,93,90,100,80,79},21))
end
end)
if not ok then debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,11,80,93,93,90,93,37},21), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({56,90,97,84,89,82,11,95,90,11,60,96,80,80,89},21))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({60,96,80,80,89,11,80,89,95,80,93,80,79,11,91,83,76,94,80,11,29},21))
end
local function finishQueen()
debug(_d({49,84,89,84,94,83,84,89,82,11,60,96,80,80,89},21))
equipSwordOrMelee()
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({60,96,80,80,89,11,79,80,81,80,76,95,80,79,25,11,59,87,76,89,11,78,90,88,91,87,80,95,80,25},21))
end
local CONFIRMATION_PROMPT_NAME = _d({46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95},21)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({61,80,88,90,95,80,48,97,80,89,95},21), 5)
end)
if ok then return result end
debug(_d({82,80,95,61,80,91,87,76,100,61,80,88,90,95,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({59,87,76,100,80,93,50,96,84},21))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({52,88,76,82,80,45,96,95,95,90,89},21)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({77,96,95,95,90,89,65,76,87,96,80},21)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({81,84,89,79,45,96,95,95,90,89,45,100,65,76,87,96,80,11,80,93,93,90,93,37},21), result)
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
if not ok then debug(_d({78,87,84,78,86,50,96,84,45,96,95,95,90,89,11,80,93,93,90,93,37},21), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({84,94,62,80,93,97,80,93},21))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({61,80,88,90,95,80,48,97,80,89,95},21))
or inst:FindFirstChild(_d({78,87,84,80,89,95,48,97,80,89,95},21))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({81,84,89,79,44,89,94,98,80,93,46,90,89,89,80,78,95,90,93,11,80,93,93,90,93,37},21), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({46,90,96,87,79,11,89,90,95,11,87,90,78,76,95,80,11,61,80,88,90,95,80,48,97,80,89,95,26,78,87,84,80,89,95,48,97,80,89,95,11,89,80,76,93,11,61,80,91,87,76,100,11,77,96,95,95,90,89,23,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,78,87,84,78,86},21))
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
debug(_d({81,84,93,80,61,80,91,87,76,100,65,76,87,96,80,11,80,93,93,90,93,37},21), err, _d({24,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,78,87,84,78,86},21))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({49,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,77,96,95,95,90,89,65,76,87,96,80,11,94,80,76,93,78,83,11,81,90,93,11,61,80,91,87,76,100},21))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({61,80,91,87,76,100,11,77,96,95,95,90,89,11,89,90,95,11,81,90,96,89,79,11,80,84,95,83,80,93,23,11,82,84,97,84,89,82,11,96,91},21))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,25,61,80,88,90,95,80,48,97,80,89,95},21))
local remote = getReplayRemote()
if not remote then
debug(_d({46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,26,61,80,88,90,95,80,48,97,80,89,95,11,89,90,95,11,81,90,96,89,79,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95},21))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({49,84,93,84,89,82,11,61,80,91,87,76,100,11,97,84,76,11,46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,25,61,80,88,90,95,80,48,97,80,89,95},21))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({49,84,93,80,62,80,93,97,80,93,11,80,93,93,90,93,37},21), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21), 10)
if not playerGui then
debug(_d({98,76,84,95,49,90,93,58,77,85,80,78,95,84,97,80,94,50,96,84,37,11,89,90,11,59,87,76,100,80,93,50,96,84,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({58,77,85,80,78,95,84,97,80,94,11,50,64,52,11,81,90,96,89,79,11,24,11,94,95,76,82,80,11,87,90,76,79,80,79},21))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({58,77,85,80,78,95,84,97,80,94,11,50,64,52,11,89,90,95,11,81,90,96,89,79,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
return
end
end
end)
if not ok then debug(_d({98,76,84,95,49,90,93,58,77,85,80,78,95,84,97,80,94,50,96,84,11,80,93,93,90,93,37},21), err) end
end
local function runPlan()
debug(_d({59,87,76,89,11,94,95,76,93,95,80,79},21))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({62,95,76,93,95,84,89,82,11,89,76,97,11,87,90,90,91},21))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({91,90,94,11,27,25,29,94,11,44,49,63,48,61,11,94,95,76,93,95,57,76,97,37},21), rootAfter and rootAfter.Position)
end)
debug(_d({66,76,84,95,84,89,82,11,32,94,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,95,90,11,62,95,76,82,80,28},21))
task.wait(5)
for _, stage in ipairs({_d({62,95,76,82,80,28},21), _d({62,95,76,82,80,29},21), _d({62,95,76,82,80,30},21), _d({62,95,76,82,80,30,45},21)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({56,90,97,84,89,82,11,95,90,11,76,93,93,90,98,11,81,87,100,24,79,90,98,89,11,76,93,80,76},21))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({47,90,79,82,84,89,82,11,76,93,93,90,98,11,93,76,84,89},21))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({62,95,76,82,80,31},21))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({60,96,80,80,89,11,84,89,11,91,83,76,94,80,11,29,11,24,11,86,80,80,91,84,89,82,11,54,80,89,11,51,76,86,84,11,76,78,95,84,97,80,11,81,93,90,88,11,83,80,93,80,11,90,89},21))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({62,95,76,95,96,80,28},21))
if not enabled then return end
recheckStatue(_d({62,95,76,95,96,80,28},21))
destroyStatue(_d({62,95,76,95,96,80,29},21))
if not enabled then return end
recheckStatue(_d({62,95,76,95,96,80,28},21))
recheckStatue(_d({62,95,76,95,96,80,29},21))
destroyStatue(_d({62,95,76,95,96,80,30},21))
if not enabled then return end
recheckStatue(_d({62,95,76,95,96,80,30},21))
recheckStatue(_d({62,95,76,95,96,80,29},21))
recheckStatue(_d({62,95,76,95,96,80,28},21))
if not enabled then return end
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,91,83,76,94,80,11,29,11,95,90,11,80,89,79},21))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({59,83,76,94,80,11,29,11,80,89,79,11,98,76,84,95,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({56,90,97,84,89,82,11,77,76,78,86,11,95,90,11,60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
navToPointConfirmed(COORDS.Queen, 30, _d({60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95,11,60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
task.wait(5)
if not enabled then return end
debug(_d({56,90,97,84,89,82,11,95,90,11,91,90,94,95,24,60,96,80,80,89,11,91,90,94,84,95,84,90,89},21))
navToPointConfirmed(COORDS.PostQueen, 30, _d({91,90,94,95,24,60,96,80,80,89,11,91,90,94,84,95,84,90,89},21))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({48,89,76,77,87,84,89,82,23,11,91,90,94,11,45,48,49,58,61,48,11,91,87,76,89,37},21), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({59,87,76,89,11,80,93,93,90,93,37},21), err2) end
end)
debug(_d({48,89,76,77,87,80,79,37},21), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({48,89,76,77,87,80,79,37},21), enabled)
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
if not ok then debug(_d({52,89,91,96,95,45,80,82,76,89,11,80,93,93,90,93,37},21), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({50,76,88,80,11,87,90,76,79,80,79,23,11,76,96,95,90,24,94,95,76,93,95,84,89,82,11,95,83,80,11,91,87,76,89},21))
enableBot()
end)
if not ok then debug(_d({44,96,95,90,94,95,76,93,95,11,80,93,93,90,93,37},21), err) end
end)
debug(_d({55,90,76,79,80,79,11,205,107,127,11,76,96,95,90,24,94,95,76,93,95,84,89,82,11,90,89,78,80,11,95,83,80,11,82,76,88,80,11,81,84,89,84,94,83,80,94,11,87,90,76,79,84,89,82,11,19,91,93,80,94,94,11,59,11,95,90,11,95,90,82,82,87,80,11,88,76,89,96,76,87,87,100,20},21))
end)()