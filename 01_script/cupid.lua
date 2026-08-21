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
local Players            = game:GetService(_d({61,89,78,102,82,95,96},19))
local UserInputService    = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
local RunService          = game:GetService(_d({63,98,91,64,82,95,99,86,80,82},19))
local VIM                 = game:GetService(_d({67,86,95,97,98,78,89,54,91,93,98,97,58,78,91,78,84,82,95},19))
local ReplicatedStorage    = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({72,47,92,96,96,47,92,97,74},19), _d({68,95,92,91,84,13,84,78,90,82,13,207,109,129,13,61,89,78,80,82,54,81,39},19), game.PlaceId, _d({66,91,86,99,82,95,96,82,54,81,39},19), game.GameId, _d({26,13,91,92,97,13,95,98,91,91,86,91,84},19))
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
local LEO_PILLAR_ANIM_ID   = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,33,33,30,33,30,32,31,36},19)
local LEO_ENTEI_ANIM_ID    = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,33,33,30,32,37,31,36,37},19)
local LEO_HIKEN_ANIM_ID    = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,31,29,38,30,36,33,29,36},19)
local LEO_FIREFLY_ANIM_ID  = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,34,31,31,29,31,32,35,30,34,33},19)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({60,79,87,82,80,97,86,99,82,96},19)
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
local REPLAY_BUTTON_VALUE   = _d({63,82,93,89,78,102},19)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({90,92,99,82},19)
local NavState   = {mode = _d({86,81,89,82},19)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({72,47,92,96,96,47,92,97,74},19), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end)
if ok then return root end
debug(_d({84,82,97,63,92,92,97,13,82,95,95,92,95,39},19), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
end)
if ok then return hum end
debug(_d({84,82,97,53,98,90,78,91,92,86,81,13,82,95,95,92,95,39},19), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({76,76,53,92,99,82,95,46,97,97},19)) or Instance.new(_d({46,97,97,78,80,85,90,82,91,97},19))
att.Name = _d({76,76,53,92,99,82,95,46,97,97},19)
att.Parent = root
local force = root:FindFirstChild(_d({76,76,53,92,99,82,95,51,92,95,80,82},19))
if not force then
force = Instance.new(_d({57,86,91,82,78,95,67,82,89,92,80,86,97,102},19))
force.Name = _d({76,76,53,92,99,82,95,51,92,95,80,82},19)
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
debug(_d({84,82,97,60,95,48,95,82,78,97,82,51,92,95,80,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local force = root:FindFirstChild(_d({76,76,53,92,99,82,95,51,92,95,80,82},19))
local att   = root:FindFirstChild(_d({76,76,53,92,99,82,95,46,97,97},19))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({80,89,82,78,91,98,93,51,92,95,80,82,13,82,95,95,92,95,39},19), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({47,98,96,92,58,82,89,82,82},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,47,98,96,92,46,80,97,86,99,82,13,82,95,95,92,95,39},19), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({47,98,96,92},19))
end)
if not ok then debug(_d({78,80,97,86,99,78,97,82,47,98,96,92,13,82,95,95,92,95,39},19), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({47,98,96,92,13,91,92,97,13,78,80,97,86,99,82,25,13,78,80,97,86,99,78,97,86,91,84},19))
activateBuso()
end
end)
if not ok then debug(_d({47,98,96,92,56,82,82,93,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({47,98,96,92,13,88,82,82,93,82,95,13,96,97,92,93,93,82,81},19))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({56,82,91,53,78,88,86},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,56,82,91,46,80,97,86,99,82,13,82,95,95,92,95,39},19), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({56,82,91},19), true)
end)
if not ok then debug(_d({78,80,97,86,99,78,97,82,56,82,91,13,82,95,95,92,95,39},19), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({56,82,91,13,91,92,97,13,78,80,97,86,99,82,25,13,78,80,97,86,99,78,97,86,91,84},19))
activateKen()
end
end)
if not ok then debug(_d({56,82,91,56,82,82,93,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({56,82,91,13,88,82,82,93,82,95,13,96,97,92,93,93,82,81},19))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({59,61,48,96},19)) end)
if ok then return folder end
debug(_d({84,82,97,59,61,48,96,51,92,89,81,82,95,13,82,95,95,92,95,39},19), folder)
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
local r = model:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local h = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
debug(_d({84,82,97,59,82,78,95,82,96,97,59,61,48,13,82,95,95,92,95,39},19), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
local hum  = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({84,82,97,59,61,48,47,102,59,78,90,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({91,93,80,96,63,82,90,78,86,91,86,91,84,13,82,95,95,92,95,39},19), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({48,98,93,86,81,13,62,98,82,82,91},19))
return queen ~= nil and queen:FindFirstChild(_d({90,92,97,86,92,91,57,82,96,96},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,62,98,82,82,91,61,85,78,96,82,31,13,82,95,95,92,95,39},19), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,30,31,30,31,38,36,38,33,31,31,38,31,36,35,38},19)
local QUEEN_GRASP_ANIM_ID   = _d({95,79,101,78,96,96,82,97,86,81,39,28,28,30,31,38,37,29,29,29,35,30,29,29,30,36,32,33},19)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
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
debug(_d({86,96,61,89,78,102,86,91,84,46,91,86,90,51,95,92,90,57,86,96,97,13,82,95,95,92,95,39},19), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({47,89,92,80,88,86,91,84},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,59,61,48,47,89,92,80,88,86,91,84,13,82,95,95,92,95,39},19), result)
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
debug(_d({93,95,82,81,86,80,97,59,61,48,61,92,96,86,97,86,92,91,13,82,95,95,92,95,39},19), result)
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
debug(_d({59,92,13,81,78,90,78,84,82,13,92,91},19), model.Name, _d({83,92,95},19), NPC_STUCK_TIMEOUT, _d({96,13,26,13,96,100,86,97,80,85,86,91,84,13,97,78,95,84,82,97},19))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({97,95,78,80,88,59,61,48,49,78,90,78,84,82,13,82,95,95,92,95,39},19), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({58,92,81,82,89},19)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({47,78,96,82,61,78,95,97},19)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({84,82,97,58,92,81,82,89,51,78,80,82,61,92,96,13,82,95,95,92,95,39},19), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({50,91,99},19))
local folder = env and env:FindFirstChild(_d({64,97,78,97,98,82,96},19))
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
debug(_d({84,82,97,64,97,78,97,98,82,58,92,81,82,89,59,82,78,95,13,82,95,95,92,95,39},19), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({79,78,95,95,82,89,53,61},19))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({84,82,97,64,97,78,97,98,82,53,61,13,82,95,95,92,95,39},19), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,46,97,97,95,86,79,98,97,82,13,82,95,95,92,95,39},19), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({65,92,92,89},19)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,59,78,90,82,13,82,95,95,92,95,39},19), tool)
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
if not ok then debug(_d({82,94,98,86,93,65,92,92,89,13,82,95,95,92,95,39},19), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({47,78,80,88,93,78,80,88},19))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({65,92,92,89},19)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({83,86,91,81,65,92,92,89,47,102,48,85,86,89,81,59,78,90,82,13,82,95,95,92,95,39},19), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({64,100,92,95,81,50,94,98,86,93},19))
if sword then
equipTool(sword)
return _d({96,100,92,95,81},19)
end
local melee = findToolByAttribute(_d({58,82,89,82,82,65,92,92,89},19))
if melee then
equipTool(melee)
return _d({90,82,89,82,82},19)
end
debug(_d({59,92,13,96,100,92,95,81,13,92,95,13,90,82,89,82,82,13,97,92,92,89,13,83,92,98,91,81},19))
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
if not ok then debug(_d({80,89,86,80,88,58,30,13,82,95,95,92,95,39},19), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({63,92,88,98,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({52,82,93,93,92},19), args)
elseif style == _d({47,89,78,80,88,57,82,84},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88},19), args)
elseif style == _d({56,78,90,86,96,85,86,88,86},19) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({56,78,90,86,96,85,86,88,86,52,82,93,93,92},19), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({64,88,102,13,68,78,89,88,31},19), args)
end
end)
if not ok then debug(_d({86,91,99,92,88,82,52,82,93,93,92,13,82,95,95,92,95,39},19), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({93,95,82,96,96,64,88,86,89,89,63,13,82,95,95,92,95,39},19), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({85,92,89,81,47,89,92,80,88,13,82,95,95,92,95,39},19), err) end
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
if not ok then debug(_d({85,92,89,81,47,89,92,80,88,68,85,86,89,82,13,82,95,95,92,95,39},19), err) end
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
debug(_d({84,82,97,52,78,90,82,52,13,82,95,95,92,95,39},19), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({86,96,63,82,78,89,58,30,47,98,96,102,13,82,95,95,92,95,39},19), result)
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
return char ~= nil and char:FindFirstChild(_d({96,97,98,91},19)) ~= nil
end)
if ok then return result end
debug(_d({86,96,64,97,98,91,91,82,81,13,82,95,95,92,95,39},19), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({93,95,82,96,96,64,97,98,91,47,95,82,78,88,13,82,95,95,92,95,39},19), err) end
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
debug(_d({94,98,82,82,91,49,92,81,84,82,66,91,97,86,89,64,78,83,82,39,13,62,98,82,82,91,13,84,92,91,82,13,26,13,82,91,81,86,91,84,13,81,92,81,84,82,13,82,78,95,89,102},19))
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
debug(_d({94,98,82,82,91,49,92,81,84,82,66,91,97,86,89,64,78,83,82,13,96,78,83,82,97,102,13,97,86,90,82,92,98,97},19))
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
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({62,98,82,82,91,13,80,78,96,97,86,91,84,13,81,82,97,82,80,97,82,81,13,26,13,81,92,81,84,86,91,84,13,21,100,78,97,80,85,82,95,22},19))
queenDodgeUntilSafe(function() return getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) end)
if enabled and getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) then
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
end
queenDodging = false
end
end)
if not ok then debug(_d({94,98,82,82,91,49,92,81,84,82,68,78,97,80,85,82,95,13,82,95,95,92,95,39},19), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({93,92,86,91,97},19) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({91,93,80},19) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({91,78,90,82,81},19) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({84,82,97,59,78,99,65,78,95,84,82,97,96,13,82,95,95,92,95,39},19), aimR)
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
debug(_d({80,92,90,93,98,97,82,57,92,80,88,82,81,48,51,95,78,90,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({93,92,86,91,97},19), point = pos}
phase = _d({90,92,99,82},19)
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
if not ok then debug(_d({91,78,99,65,92,61,92,86,91,97,13,84,82,93,93,92,13,80,85,82,80,88,13,82,95,95,92,95,39},19), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({91,93,80},19)}
phase = _d({90,92,99,82},19)
end
function setNavNamed(name)
NavState = {mode = _d({91,78,90,82,81},19), name = name}
phase = _d({90,92,99,82},19)
end
local function setNavIdle()
NavState = {mode = _d({86,81,89,82},19)}
phase = _d({90,92,99,82},19)
end
local function hasArrived()
return phase == _d({85,92,99,82,95},19)
end
local function startNav()
phase = _d({90,92,99,82},19)
debug(_d({59,78,99,13,89,92,92,93,13,60,59},19))
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
local prevPos = force:GetAttribute(_d({76,76,93,95,82,99,61,92,96},19))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({57,78,95,84,82,13,93,92,96,86,97,86,92,91,13,87,98,90,93,13,81,82,97,82,80,97,82,81,39},19), delta, _d({96,97,98,81,96,27,13,93,95,82,99,61,92,96,42},19), prevPos, _d({91,82,100,61,92,96,42},19), pos)
end
end
force:SetAttribute(_d({76,76,93,95,82,99,61,92,96},19), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({90,92,99,82},19) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({85,92,99,82,95},19)
debug(_d({61,85,78,96,82,39,13,85,92,99,82,95},19))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({14,14,14,13,63,50,51,66,64,54,59,52,13,65,60,13,46,61,61,57,70,13,46,47,59,60,63,58,46,57,13,67,50,57,60,48,54,65,70,39},19), finalVel, _d({78,86,90,42},19), aim, _d({93,92,96,42},19), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({85,92,99,82,95},19) then
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
debug(_d({48,92,90,79,78,97,13,89,92,80,88,13,96,88,86,93,93,82,81,25},19), snapDist, _d({96,97,98,81,96,13,83,95,92,90,13,97,78,95,84,82,97,13,207,109,129,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,90,92,99,82},19))
phase = _d({90,92,99,82},19)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({53,82,78,95,97,79,82,78,97,13,82,95,95,92,95,39},19), err) end
end)
end
local function stopNav()
debug(_d({59,78,99,13,89,92,92,93,13,60,51,51},19))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({90,92,99,82},19)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({65,82,101,97,48,85,78,97,64,82,95,99,86,80,82},19))
local channels = TextChatService:FindFirstChild(_d({65,82,101,97,48,85,78,91,91,82,89,96},19))
local channel = channels and channels:FindFirstChild(_d({63,47,69,52,82,91,82,95,78,89},19))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({49,82,83,78,98,89,97,48,85,78,97,64,102,96,97,82,90,48,85,78,97,50,99,82,91,97,96},19))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({64,78,102,58,82,96,96,78,84,82,63,82,94,98,82,96,97},19))
if sayEvent then
sayEvent:FireServer(message, _d({46,89,89},19))
return
end
debug(_d({96,82,91,81,48,85,78,97,58,82,96,96,78,84,82,39,13,91,92,13,65,82,101,97,48,85,78,97,64,82,95,99,86,80,82,27,63,47,69,52,82,91,82,95,78,89,13,92,95,13,89,82,84,78,80,102,13,64,78,102,58,82,96,96,78,84,82,63,82,94,98,82,96,97,13,83,92,98,91,81,13,83,92,95},19), message)
end)
if not ok then debug(_d({96,82,91,81,48,85,78,97,58,82,96,96,78,84,82,13,82,95,95,92,95,39},19), err) end
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
debug(_d({59,92,97,13,90,78,88,86,91,84,13,93,95,92,84,95,82,96,96,13,97,92,100,78,95,81,13,91,78,99,13,97,78,95,84,82,97,13,83,92,95},19), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({96,13,26,13,96,82,91,81,86,91,84,13,28,98,91,96,97,98,80,88},19))
sendChatMessage(_d({28,98,91,96,97,98,80,88},19))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({100,78,86,97,66,91,97,86,89,46,95,95,86,99,82,81,13,97,86,90,82,92,98,97},19))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({91,78,99,65,92,61,92,86,91,97,48,92,91,83,86,95,90,82,81,39},19), label or _d({97,78,95,84,82,97},19), _d({26,13,81,86,81,13,91,92,97,13,78,95,95,86,99,82,13,100,86,97,85,86,91},19), timeout, _d({96,25,13,95,82,97,95,102,86,91,84,13,92,91,80,82},19))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({91,78,99,65,92,61,92,86,91,97,48,92,91,83,86,95,90,82,81,39},19), label or _d({97,78,95,84,82,97},19), _d({26,13,96,97,86,89,89,13,91,92,97,13,78,95,95,86,99,82,81,13,78,83,97,82,95,13,95,82,97,95,102,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
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
if not ok then debug(_d({91,78,99,65,92,61,92,86,91,97,53,92,89,81,86,91,84,47,89,92,80,88,13,88,82,102,26,81,92,100,91,13,82,95,95,92,95,39},19), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({91,78,99,65,92,61,92,86,91,97,53,92,89,81,86,91,84,47,89,92,80,88,13,88,82,102,26,98,93,13,82,95,95,92,95,39},19), err2) end
end
local function clearStage(stageName)
debug(_d({58,92,99,86,91,84,13,97,92},19), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,59,61,48,96,13,97,92,13,96,93,78,100,91,13,78,97},19), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({13,13,96,93,78,100,91,13,80,85,82,80,88,39,13,83,92,89,81,82,95,13,82,101,86,96,97,96,13,42},19), folder ~= nil,
_d({25,13,80,85,86,89,81,95,82,91,13,42},19), folder and #folder:GetChildren() or 0,
_d({25,13,78,89,86,99,82,13,42},19), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({59,92,13,59,61,48,96,13,78,93,93,82,78,95,82,81,13,78,97},19), stageName, _d({78,83,97,82,95,13,30,34,96,25,13,90,92,99,86,91,84,13,92,91,13,78,91,102,100,78,102},19))
break
end
end
debug(_d({56,86,89,89,86,91,84,13,59,61,48,96,13,78,97},19), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({63,82,97,98,95,91,86,91,84,13,97,92},19), stageName, _d({93,92,96,86,97,86,92,91,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,92,91},19))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97},19), stageName, _d({93,92,96,86,97,86,92,91},19))
task.wait(5)
debug(stageName, _d({80,89,82,78,95,82,81},19))
end
local function killNamedNPC(name, targetPos)
debug(_d({58,92,99,86,91,84,13,97,92},19), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({81,82,83,82,78,97,82,81},19))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({53,98,90,78,91,92,86,81},19))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({57,82,92,13,93,89,78,102,82,81,13,78,91,86,90,78,97,86,92,91,39},19), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({89,82,92,46,91,86,90,57,92,84,84,82,95,13,93,95,86,91,97,13,82,95,95,92,95,39},19), err2) end
end)
end)
if not ok then debug(_d({96,97,78,95,97,57,82,92,46,91,86,90,57,92,84,84,82,95,13,82,95,95,92,95,39},19), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({58,92,99,86,91,84,13,97,92,13,57,82,92,13,21,79,89,92,80,88,86,91,84,13,78,83,97,82,95},19), LEO_BLOCK_DELAY, _d({96,22},19))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({57,82,92},19))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({57,82,92},19))
while enabled do
local info = getNPCByName(_d({57,82,92},19))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({57,82,92,13,80,78,96,97,86,91,84},19), which, _d({26,13,81,92,81,84,86,91,84},19))
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
if not getNPCByName(_d({57,82,92},19)) then
debug(_d({57,82,92,13,84,92,91,82,13,90,86,81,26,81,92,81,84,82,13,26,13,82,91,81,86,91,84,13,50,91,97,82,86,13,85,92,89,81,13,82,78,95,89,102},19))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({57,82,92},19)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({57,82,92,13,84,92,91,82,13,90,86,81,26,81,92,81,84,82,13,26,13,82,91,81,86,91,84,13,51,89,78,90,82,13,61,86,89,89,78,95,13,85,92,89,81,13,82,78,95,89,102},19))
end
end
end
if enabled and getNPCByName(_d({57,82,92},19)) then
setNavNamed(_d({57,82,92},19))
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
debug(_d({57,82,92,13,81,82,83,82,78,97,82,81},19))
stopLeoAnimLogger()
debug(_d({63,82,97,98,95,91,86,91,84,13,97,92,13,57,82,92,13,93,92,96,86,97,86,92,91,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,92,91},19))
navToPointConfirmed(COORDS.Leo, 30, _d({57,82,92,13,93,92,96,86,97,86,92,91},19))
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97,13,57,82,92,13,93,92,96,86,97,86,92,91},19))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({58,92,99,86,91,84,13,97,92},19), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({48,92,98,89,81,13,91,92,97,13,83,86,91,81,13,96,97,78,97,98,82,13,90,92,81,82,89,13,91,82,78,95},19), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({46,97,97,78,80,88,86,91,84},19), coordKey, _d({100,86,97,85},19), weapon or _d({91,92,97,85,86,91,84,13,83,92,98,91,81},19))
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
debug(coordKey, _d({79,78,95,95,82,89,13,81,82,96,97,95,92,102,82,81},19))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({26,13,80,92,98,89,81,13,91,92,97,13,83,86,91,81,13,96,97,78,97,98,82,13,90,92,81,82,89,25,13,96,88,86,93,93,86,91,84},19))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({96,97,86,89,89,13,78,89,86,99,82,13,21,53,61},19), hp, _d({22,13,26,13,95,82,26,81,82,96,97,95,92,102,86,91,84},19))
destroyStatue(coordKey)
else
debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,39},19), coordKey, _d({80,92,91,83,86,95,90,82,81,13,81,82,96,97,95,92,102,82,81},19))
end
end)
if not ok then debug(_d({95,82,80,85,82,80,88,64,97,78,97,98,82,13,82,95,95,92,95,39},19), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({58,92,99,86,91,84,13,97,92,13,62,98,82,82,91},19))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({62,98,82,82,91,13,82,91,97,82,95,82,81,13,93,85,78,96,82,13,31},19))
end
local function finishQueen()
debug(_d({51,86,91,86,96,85,86,91,84,13,62,98,82,82,91},19))
equipSwordOrMelee()
setNavNamed(_d({48,98,93,86,81,13,62,98,82,82,91},19))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({48,98,93,86,81,13,62,98,82,82,91},19))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({62,98,82,82,91,13,81,82,83,82,78,97,82,81,27,13,61,89,78,91,13,80,92,90,93,89,82,97,82,27},19))
end
local CONFIRMATION_PROMPT_NAME = _d({48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97},19)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({63,82,90,92,97,82,50,99,82,91,97},19), 5)
end)
if ok then return result end
debug(_d({84,82,97,63,82,93,89,78,102,63,82,90,92,97,82,13,82,95,95,92,95,39},19), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({61,89,78,102,82,95,52,98,86},19))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({54,90,78,84,82,47,98,97,97,92,91},19)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({79,98,97,97,92,91,67,78,89,98,82},19)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({83,86,91,81,47,98,97,97,92,91,47,102,67,78,89,98,82,13,82,95,95,92,95,39},19), result)
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
if not ok then debug(_d({80,89,86,80,88,52,98,86,47,98,97,97,92,91,13,82,95,95,92,95,39},19), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({86,96,64,82,95,99,82,95},19))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({63,82,90,92,97,82,50,99,82,91,97},19))
or inst:FindFirstChild(_d({80,89,86,82,91,97,50,99,82,91,97},19))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({83,86,91,81,46,91,96,100,82,95,48,92,91,91,82,80,97,92,95,13,82,95,95,92,95,39},19), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({48,92,98,89,81,13,91,92,97,13,89,92,80,78,97,82,13,63,82,90,92,97,82,50,99,82,91,97,28,80,89,86,82,91,97,50,99,82,91,97,13,91,82,78,95,13,63,82,93,89,78,102,13,79,98,97,97,92,91,25,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,80,89,86,80,88},19))
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
debug(_d({83,86,95,82,63,82,93,89,78,102,67,78,89,98,82,13,82,95,95,92,95,39},19), err, _d({26,13,83,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,80,89,86,80,88},19))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({51,78,89,89,86,91,84,13,79,78,80,88,13,97,92,13,79,98,97,97,92,91,67,78,89,98,82,13,96,82,78,95,80,85,13,83,92,95,13,63,82,93,89,78,102},19))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({63,82,93,89,78,102,13,79,98,97,97,92,91,13,91,92,97,13,83,92,98,91,81,13,82,86,97,85,82,95,25,13,84,86,99,86,91,84,13,98,93},19))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,27,63,82,90,92,97,82,50,99,82,91,97},19))
local remote = getReplayRemote()
if not remote then
debug(_d({48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,28,63,82,90,92,97,82,50,99,82,91,97,13,91,92,97,13,83,92,98,91,81,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97},19))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({51,86,95,86,91,84,13,63,82,93,89,78,102,13,99,86,78,13,48,92,91,83,86,95,90,78,97,86,92,91,61,95,92,90,93,97,27,63,82,90,92,97,82,50,99,82,91,97},19))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({51,86,95,82,64,82,95,99,82,95,13,82,95,95,92,95,39},19), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({61,89,78,102,82,95,52,98,86},19), 10)
if not playerGui then
debug(_d({100,78,86,97,51,92,95,60,79,87,82,80,97,86,99,82,96,52,98,86,39,13,91,92,13,61,89,78,102,82,95,52,98,86,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({60,79,87,82,80,97,86,99,82,96,13,52,66,54,13,83,92,98,91,81,13,26,13,96,97,78,84,82,13,89,92,78,81,82,81},19))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({60,79,87,82,80,97,86,99,82,96,13,52,66,54,13,91,92,97,13,83,92,98,91,81,13,100,86,97,85,86,91,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
return
end
end
end)
if not ok then debug(_d({100,78,86,97,51,92,95,60,79,87,82,80,97,86,99,82,96,52,98,86,13,82,95,95,92,95,39},19), err) end
end
local function runPlan()
debug(_d({61,89,78,91,13,96,97,78,95,97,82,81},19))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({64,97,78,95,97,86,91,84,13,91,78,99,13,89,92,92,93},19))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({93,92,96,13,29,27,31,96,13,46,51,65,50,63,13,96,97,78,95,97,59,78,99,39},19), rootAfter and rootAfter.Position)
end)
debug(_d({68,78,86,97,86,91,84,13,34,96,13,79,82,83,92,95,82,13,90,92,99,86,91,84,13,97,92,13,64,97,78,84,82,30},19))
task.wait(5)
for _, stage in ipairs({_d({64,97,78,84,82,30},19), _d({64,97,78,84,82,31},19), _d({64,97,78,84,82,32},19), _d({64,97,78,84,82,32,47},19)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,97,92,13,78,95,95,92,100,13,83,89,102,26,81,92,100,91,13,78,95,82,78},19))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({49,92,81,84,86,91,84,13,78,95,95,92,100,13,95,78,86,91},19))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({64,97,78,84,82,33},19))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({62,98,82,82,91,13,86,91,13,93,85,78,96,82,13,31,13,26,13,88,82,82,93,86,91,84,13,56,82,91,13,53,78,88,86,13,78,80,97,86,99,82,13,83,95,92,90,13,85,82,95,82,13,92,91},19))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({64,97,78,97,98,82,30},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,30},19))
destroyStatue(_d({64,97,78,97,98,82,31},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,30},19))
recheckStatue(_d({64,97,78,97,98,82,31},19))
destroyStatue(_d({64,97,78,97,98,82,32},19))
if not enabled then return end
recheckStatue(_d({64,97,78,97,98,82,32},19))
recheckStatue(_d({64,97,78,97,98,82,31},19))
recheckStatue(_d({64,97,78,97,98,82,30},19))
if not enabled then return end
debug(_d({68,78,86,97,86,91,84,13,83,92,95,13,93,85,78,96,82,13,31,13,97,92,13,82,91,81},19))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({61,85,78,96,82,13,31,13,82,91,81,13,100,78,86,97,13,97,86,90,82,92,98,97,25,13,93,95,92,80,82,82,81,86,91,84,13,78,91,102,100,78,102},19))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,79,78,80,88,13,97,92,13,62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
navToPointConfirmed(COORDS.Queen, 30, _d({62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
debug(_d({68,78,86,97,86,91,84,13,34,96,13,78,97,13,62,98,82,82,91,13,96,97,78,84,82,13,93,92,96,86,97,86,92,91},19))
task.wait(5)
if not enabled then return end
debug(_d({58,92,99,86,91,84,13,97,92,13,93,92,96,97,26,62,98,82,82,91,13,93,92,96,86,97,86,92,91},19))
navToPointConfirmed(COORDS.PostQueen, 30, _d({93,92,96,97,26,62,98,82,82,91,13,93,92,96,86,97,86,92,91},19))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({50,91,78,79,89,86,91,84,25,13,93,92,96,13,47,50,51,60,63,50,13,93,89,78,91,39},19), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({61,89,78,91,13,82,95,95,92,95,39},19), err2) end
end)
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({50,91,78,79,89,82,81,39},19), enabled)
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
if not ok then debug(_d({54,91,93,98,97,47,82,84,78,91,13,82,95,95,92,95,39},19), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({52,78,90,82,13,89,92,78,81,82,81,25,13,78,98,97,92,26,96,97,78,95,97,86,91,84,13,97,85,82,13,93,89,78,91},19))
enableBot()
end)
if not ok then debug(_d({46,98,97,92,96,97,78,95,97,13,82,95,95,92,95,39},19), err) end
end)
debug(_d({57,92,78,81,82,81,13,207,109,129,13,78,98,97,92,26,96,97,78,95,97,86,91,84,13,92,91,80,82,13,97,85,82,13,84,78,90,82,13,83,86,91,86,96,85,82,96,13,89,92,78,81,86,91,84,13,21,93,95,82,96,96,13,61,13,97,92,13,97,92,84,84,89,82,13,90,78,91,98,78,89,89,102,22},19))
end)()