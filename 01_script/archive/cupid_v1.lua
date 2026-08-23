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
local Players            = game:GetService(_d({30,58,47,71,51,64,65},50))
local UserInputService    = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
local RunService          = game:GetService(_d({32,67,60,33,51,64,68,55,49,51},50))
local VIM                 = game:GetService(_d({36,55,64,66,67,47,58,23,60,62,67,66,27,47,60,47,53,51,64},50))
local ReplicatedStorage    = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({41,16,61,65,65,16,61,66,43},50), _d({37,64,61,60,53,238,53,47,59,51,238,176,78,98,238,30,58,47,49,51,23,50,8},50), game.PlaceId, _d({35,60,55,68,51,64,65,51,23,50,8},50), game.GameId, _d({251,238,60,61,66,238,64,67,60,60,55,60,53},50))
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
local LEO_PILLAR_ANIM_ID   = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,3,0,2,2,255,2,255,1,0,5},50)
local LEO_ENTEI_ANIM_ID    = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,3,0,2,2,255,1,6,0,5,6},50)
local LEO_HIKEN_ANIM_ID    = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,3,0,0,254,7,255,5,2,254,5},50)
local LEO_FIREFLY_ANIM_ID  = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,3,0,0,254,0,1,4,255,3,2},50)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({29,48,56,51,49,66,55,68,51,65},50)
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
local REPLAY_BUTTON_VALUE   = _d({32,51,62,58,47,71},50)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({59,61,68,51},50)
local NavState   = {mode = _d({55,50,58,51},50)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({41,16,61,65,65,16,61,66,43},50), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end)
if ok then return root end
debug(_d({53,51,66,32,61,61,66,238,51,64,64,61,64,8},50), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
end)
if ok then return hum end
debug(_d({53,51,66,22,67,59,47,60,61,55,50,238,51,64,64,61,64,8},50), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({45,45,22,61,68,51,64,15,66,66},50)) or Instance.new(_d({15,66,66,47,49,54,59,51,60,66},50))
att.Name = _d({45,45,22,61,68,51,64,15,66,66},50)
att.Parent = root
local force = root:FindFirstChild(_d({45,45,22,61,68,51,64,20,61,64,49,51},50))
if not force then
force = Instance.new(_d({26,55,60,51,47,64,36,51,58,61,49,55,66,71},50))
force.Name = _d({45,45,22,61,68,51,64,20,61,64,49,51},50)
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
debug(_d({53,51,66,29,64,17,64,51,47,66,51,20,61,64,49,51,238,51,64,64,61,64,8},50), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not root then return end
local force = root:FindFirstChild(_d({45,45,22,61,68,51,64,20,61,64,49,51},50))
local att   = root:FindFirstChild(_d({45,45,22,61,68,51,64,15,66,66},50))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({49,58,51,47,60,67,62,20,61,64,49,51,238,51,64,64,61,64,8},50), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({16,67,65,61,27,51,58,51,51},50)) ~= nil
end)
if ok then return result end
debug(_d({55,65,16,67,65,61,15,49,66,55,68,51,238,51,64,64,61,64,8},50), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({16,67,65,61},50))
end)
if not ok then debug(_d({47,49,66,55,68,47,66,51,16,67,65,61,238,51,64,64,61,64,8},50), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({16,67,65,61,238,60,61,66,238,47,49,66,55,68,51,250,238,47,49,66,55,68,47,66,55,60,53},50))
activateBuso()
end
end)
if not ok then debug(_d({16,67,65,61,25,51,51,62,51,64,238,51,64,64,61,64,8},50), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({16,67,65,61,238,57,51,51,62,51,64,238,65,66,61,62,62,51,50},50))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({25,51,60,22,47,57,55},50)) ~= nil
end)
if ok then return result end
debug(_d({55,65,25,51,60,15,49,66,55,68,51,238,51,64,64,61,64,8},50), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({25,51,60},50), true)
end)
if not ok then debug(_d({47,49,66,55,68,47,66,51,25,51,60,238,51,64,64,61,64,8},50), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({25,51,60,238,60,61,66,238,47,49,66,55,68,51,250,238,47,49,66,55,68,47,66,55,60,53},50))
activateKen()
end
end)
if not ok then debug(_d({25,51,60,25,51,51,62,51,64,238,51,64,64,61,64,8},50), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({25,51,60,238,57,51,51,62,51,64,238,65,66,61,62,62,51,50},50))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({28,30,17,65},50)) end)
if ok then return folder end
debug(_d({53,51,66,28,30,17,65,20,61,58,50,51,64,238,51,64,64,61,64,8},50), folder)
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
local r = model:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local h = model:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
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
debug(_d({53,51,66,28,51,47,64,51,65,66,28,30,17,238,51,64,64,61,64,8},50), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
local hum  = model:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({53,51,66,28,30,17,16,71,28,47,59,51,238,51,64,64,61,64,8},50), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({60,62,49,65,32,51,59,47,55,60,55,60,53,238,51,64,64,61,64,8},50), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({17,67,62,55,50,238,31,67,51,51,60},50))
return queen ~= nil and queen:FindFirstChild(_d({59,61,66,55,61,60,26,51,65,65},50)) ~= nil
end)
if ok then return result end
debug(_d({55,65,31,67,51,51,60,30,54,47,65,51,0,238,51,64,64,61,64,8},50), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,255,0,255,0,7,5,7,2,0,0,7,0,5,4,7},50)
local QUEEN_GRASP_ANIM_ID   = _d({64,48,70,47,65,65,51,66,55,50,8,253,253,255,0,7,6,254,254,254,4,255,254,254,255,5,1,2},50)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
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
debug(_d({55,65,30,58,47,71,55,60,53,15,60,55,59,20,64,61,59,26,55,65,66,238,51,64,64,61,64,8},50), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({16,58,61,49,57,55,60,53},50)) ~= nil
end)
if ok then return result end
debug(_d({55,65,28,30,17,16,58,61,49,57,55,60,53,238,51,64,64,61,64,8},50), result)
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
debug(_d({62,64,51,50,55,49,66,28,30,17,30,61,65,55,66,55,61,60,238,51,64,64,61,64,8},50), result)
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
debug(_d({28,61,238,50,47,59,47,53,51,238,61,60},50), model.Name, _d({52,61,64},50), NPC_STUCK_TIMEOUT, _d({65,238,251,238,65,69,55,66,49,54,55,60,53,238,66,47,64,53,51,66},50))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({66,64,47,49,57,28,30,17,18,47,59,47,53,51,238,51,64,64,61,64,8},50), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({27,61,50,51,58},50)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({16,47,65,51,30,47,64,66},50)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({53,51,66,27,61,50,51,58,20,47,49,51,30,61,65,238,51,64,64,61,64,8},50), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({19,60,68},50))
local folder = env and env:FindFirstChild(_d({33,66,47,66,67,51,65},50))
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
debug(_d({53,51,66,33,66,47,66,67,51,27,61,50,51,58,28,51,47,64,238,51,64,64,61,64,8},50), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({48,47,64,64,51,58,22,30},50))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({53,51,66,33,66,47,66,67,51,22,30,238,51,64,64,61,64,8},50), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({34,61,61,58},50)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({52,55,60,50,34,61,61,58,16,71,15,66,66,64,55,48,67,66,51,238,51,64,64,61,64,8},50), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({34,61,61,58},50)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({52,55,60,50,34,61,61,58,16,71,28,47,59,51,238,51,64,64,61,64,8},50), tool)
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
if not ok then debug(_d({51,63,67,55,62,34,61,61,58,238,51,64,64,61,64,8},50), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({16,47,49,57,62,47,49,57},50))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({34,61,61,58},50)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({52,55,60,50,34,61,61,58,16,71,17,54,55,58,50,28,47,59,51,238,51,64,64,61,64,8},50), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({33,69,61,64,50,19,63,67,55,62},50))
if sword then
equipTool(sword)
return _d({65,69,61,64,50},50)
end
local melee = findToolByAttribute(_d({27,51,58,51,51,34,61,61,58},50))
if melee then
equipTool(melee)
return _d({59,51,58,51,51},50)
end
debug(_d({28,61,238,65,69,61,64,50,238,61,64,238,59,51,58,51,51,238,66,61,61,58,238,52,61,67,60,50},50))
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
if not ok then debug(_d({49,58,55,49,57,27,255,238,51,64,64,61,64,8},50), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({32,61,57,67,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({21,51,62,62,61},50), args)
elseif style == _d({16,58,47,49,57,26,51,53},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57},50), args)
elseif style == _d({25,47,59,55,65,54,55,57,55},50) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,47,59,55,65,54,55,57,55,21,51,62,62,61},50), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({33,57,71,238,37,47,58,57,0},50), args)
end
end)
if not ok then debug(_d({55,60,68,61,57,51,21,51,62,62,61,238,51,64,64,61,64,8},50), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({62,64,51,65,65,33,57,55,58,58,32,238,51,64,64,61,64,8},50), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({54,61,58,50,16,58,61,49,57,238,51,64,64,61,64,8},50), err) end
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
if not ok then debug(_d({54,61,58,50,16,58,61,49,57,37,54,55,58,51,238,51,64,64,61,64,8},50), err) end
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
debug(_d({53,51,66,21,47,59,51,21,238,51,64,64,61,64,8},50), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({55,65,32,51,47,58,27,255,16,67,65,71,238,51,64,64,61,64,8},50), result)
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
return char ~= nil and char:FindFirstChild(_d({65,66,67,60},50)) ~= nil
end)
if ok then return result end
debug(_d({55,65,33,66,67,60,60,51,50,238,51,64,64,61,64,8},50), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({62,64,51,65,65,33,66,67,60,16,64,51,47,57,238,51,64,64,61,64,8},50), err) end
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
debug(_d({63,67,51,51,60,18,61,50,53,51,35,60,66,55,58,33,47,52,51,8,238,31,67,51,51,60,238,53,61,60,51,238,251,238,51,60,50,55,60,53,238,50,61,50,53,51,238,51,47,64,58,71},50))
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
debug(_d({63,67,51,51,60,18,61,50,53,51,35,60,66,55,58,33,47,52,51,238,65,47,52,51,66,71,238,66,55,59,51,61,67,66},50))
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
local info = getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({31,67,51,51,60,238,49,47,65,66,55,60,53,238,50,51,66,51,49,66,51,50,238,251,238,50,61,50,53,55,60,53,238,246,69,47,66,49,54,51,64,247},50))
queenDodgeUntilSafe(function() return getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50)) end)
if enabled and getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50)) then
setNavNamed(_d({17,67,62,55,50,238,31,67,51,51,60},50))
end
queenDodging = false
end
end)
if not ok then debug(_d({63,67,51,51,60,18,61,50,53,51,37,47,66,49,54,51,64,238,51,64,64,61,64,8},50), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({62,61,55,60,66},50) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({60,62,49},50) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({60,47,59,51,50},50) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({53,51,66,28,47,68,34,47,64,53,51,66,65,238,51,64,64,61,64,8},50), aimR)
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
debug(_d({49,61,59,62,67,66,51,26,61,49,57,51,50,17,20,64,47,59,51,238,51,64,64,61,64,8},50), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({62,61,55,60,66},50), point = pos}
phase = _d({59,61,68,51},50)
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
if not ok then debug(_d({60,47,68,34,61,30,61,55,60,66,238,53,51,62,62,61,238,49,54,51,49,57,238,51,64,64,61,64,8},50), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({60,62,49},50)}
phase = _d({59,61,68,51},50)
end
function setNavNamed(name)
NavState = {mode = _d({60,47,59,51,50},50), name = name}
phase = _d({59,61,68,51},50)
end
local function setNavIdle()
NavState = {mode = _d({55,50,58,51},50)}
phase = _d({59,61,68,51},50)
end
local function hasArrived()
return phase == _d({54,61,68,51,64},50)
end
local function startNav()
phase = _d({59,61,68,51},50)
debug(_d({28,47,68,238,58,61,61,62,238,29,28},50))
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
local prevPos = force:GetAttribute(_d({45,45,62,64,51,68,30,61,65},50))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({26,47,64,53,51,238,62,61,65,55,66,55,61,60,238,56,67,59,62,238,50,51,66,51,49,66,51,50,8},50), delta, _d({65,66,67,50,65,252,238,62,64,51,68,30,61,65,11},50), prevPos, _d({60,51,69,30,61,65,11},50), pos)
end
end
force:SetAttribute(_d({45,45,62,64,51,68,30,61,65},50), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({59,61,68,51},50) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({54,61,68,51,64},50)
debug(_d({30,54,47,65,51,8,238,54,61,68,51,64},50))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({239,239,239,238,32,19,20,35,33,23,28,21,238,34,29,238,15,30,30,26,39,238,15,16,28,29,32,27,15,26,238,36,19,26,29,17,23,34,39,8},50), finalVel, _d({47,55,59,11},50), aim, _d({62,61,65,11},50), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({54,61,68,51,64},50) then
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
debug(_d({17,61,59,48,47,66,238,58,61,49,57,238,65,57,55,62,62,51,50,250},50), snapDist, _d({65,66,67,50,65,238,52,64,61,59,238,66,47,64,53,51,66,238,176,78,98,238,52,47,58,58,55,60,53,238,48,47,49,57,238,66,61,238,59,61,68,51},50))
phase = _d({59,61,68,51},50)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({22,51,47,64,66,48,51,47,66,238,51,64,64,61,64,8},50), err) end
end)
end
local function stopNav()
debug(_d({28,47,68,238,58,61,61,62,238,29,20,20},50))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({59,61,68,51},50)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({34,51,70,66,17,54,47,66,33,51,64,68,55,49,51},50))
local channels = TextChatService:FindFirstChild(_d({34,51,70,66,17,54,47,60,60,51,58,65},50))
local channel = channels and channels:FindFirstChild(_d({32,16,38,21,51,60,51,64,47,58},50))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({18,51,52,47,67,58,66,17,54,47,66,33,71,65,66,51,59,17,54,47,66,19,68,51,60,66,65},50))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({33,47,71,27,51,65,65,47,53,51,32,51,63,67,51,65,66},50))
if sayEvent then
sayEvent:FireServer(message, _d({15,58,58},50))
return
end
debug(_d({65,51,60,50,17,54,47,66,27,51,65,65,47,53,51,8,238,60,61,238,34,51,70,66,17,54,47,66,33,51,64,68,55,49,51,252,32,16,38,21,51,60,51,64,47,58,238,61,64,238,58,51,53,47,49,71,238,33,47,71,27,51,65,65,47,53,51,32,51,63,67,51,65,66,238,52,61,67,60,50,238,52,61,64},50), message)
end)
if not ok then debug(_d({65,51,60,50,17,54,47,66,27,51,65,65,47,53,51,238,51,64,64,61,64,8},50), err) end
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
debug(_d({28,61,66,238,59,47,57,55,60,53,238,62,64,61,53,64,51,65,65,238,66,61,69,47,64,50,238,60,47,68,238,66,47,64,53,51,66,238,52,61,64},50), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({65,238,251,238,65,51,60,50,55,60,53,238,253,67,60,65,66,67,49,57},50))
sendChatMessage(_d({253,67,60,65,66,67,49,57},50))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({69,47,55,66,35,60,66,55,58,15,64,64,55,68,51,50,238,66,55,59,51,61,67,66},50))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({60,47,68,34,61,30,61,55,60,66,17,61,60,52,55,64,59,51,50,8},50), label or _d({66,47,64,53,51,66},50), _d({251,238,50,55,50,238,60,61,66,238,47,64,64,55,68,51,238,69,55,66,54,55,60},50), timeout, _d({65,250,238,64,51,66,64,71,55,60,53,238,61,60,49,51},50))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({60,47,68,34,61,30,61,55,60,66,17,61,60,52,55,64,59,51,50,8},50), label or _d({66,47,64,53,51,66},50), _d({251,238,65,66,55,58,58,238,60,61,66,238,47,64,64,55,68,51,50,238,47,52,66,51,64,238,64,51,66,64,71,250,238,62,64,61,49,51,51,50,55,60,53,238,47,60,71,69,47,71},50))
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
if not ok then debug(_d({60,47,68,34,61,30,61,55,60,66,22,61,58,50,55,60,53,16,58,61,49,57,238,57,51,71,251,50,61,69,60,238,51,64,64,61,64,8},50), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({60,47,68,34,61,30,61,55,60,66,22,61,58,50,55,60,53,16,58,61,49,57,238,57,51,71,251,67,62,238,51,64,64,61,64,8},50), err2) end
end
local function clearStage(stageName)
debug(_d({27,61,68,55,60,53,238,66,61},50), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({37,47,55,66,55,60,53,238,52,61,64,238,28,30,17,65,238,66,61,238,65,62,47,69,60,238,47,66},50), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({238,238,65,62,47,69,60,238,49,54,51,49,57,8,238,52,61,58,50,51,64,238,51,70,55,65,66,65,238,11},50), folder ~= nil,
_d({250,238,49,54,55,58,50,64,51,60,238,11},50), folder and #folder:GetChildren() or 0,
_d({250,238,47,58,55,68,51,238,11},50), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({28,61,238,28,30,17,65,238,47,62,62,51,47,64,51,50,238,47,66},50), stageName, _d({47,52,66,51,64,238,255,3,65,250,238,59,61,68,55,60,53,238,61,60,238,47,60,71,69,47,71},50))
break
end
end
debug(_d({25,55,58,58,55,60,53,238,28,30,17,65,238,47,66},50), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({32,51,66,67,64,60,55,60,53,238,66,61},50), stageName, _d({62,61,65,55,66,55,61,60,238,48,51,52,61,64,51,238,59,61,68,55,60,53,238,61,60},50))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({37,47,55,66,55,60,53,238,3,65,238,47,66},50), stageName, _d({62,61,65,55,66,55,61,60},50))
task.wait(5)
debug(stageName, _d({49,58,51,47,64,51,50},50))
end
local function killNamedNPC(name, targetPos)
debug(_d({27,61,68,55,60,53,238,66,61},50), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({50,51,52,51,47,66,51,50},50))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({22,67,59,47,60,61,55,50},50))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({26,51,61,238,62,58,47,71,51,50,238,47,60,55,59,47,66,55,61,60,8},50), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({58,51,61,15,60,55,59,26,61,53,53,51,64,238,62,64,55,60,66,238,51,64,64,61,64,8},50), err2) end
end)
end)
if not ok then debug(_d({65,66,47,64,66,26,51,61,15,60,55,59,26,61,53,53,51,64,238,51,64,64,61,64,8},50), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({27,61,68,55,60,53,238,66,61,238,26,51,61,238,246,48,58,61,49,57,55,60,53,238,47,52,66,51,64},50), LEO_BLOCK_DELAY, _d({65,247},50))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({26,51,61},50))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({26,51,61},50))
while enabled do
local info = getNPCByName(_d({26,51,61},50))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({26,51,61,238,49,47,65,66,55,60,53},50), which, _d({251,238,50,61,50,53,55,60,53},50))
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
if not getNPCByName(_d({26,51,61},50)) then
debug(_d({26,51,61,238,53,61,60,51,238,59,55,50,251,50,61,50,53,51,238,251,238,51,60,50,55,60,53,238,19,60,66,51,55,238,54,61,58,50,238,51,47,64,58,71},50))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({26,51,61},50)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({26,51,61,238,53,61,60,51,238,59,55,50,251,50,61,50,53,51,238,251,238,51,60,50,55,60,53,238,20,58,47,59,51,238,30,55,58,58,47,64,238,54,61,58,50,238,51,47,64,58,71},50))
end
end
end
if enabled and getNPCByName(_d({26,51,61},50)) then
setNavNamed(_d({26,51,61},50))
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
debug(_d({26,51,61,238,50,51,52,51,47,66,51,50},50))
stopLeoAnimLogger()
debug(_d({32,51,66,67,64,60,55,60,53,238,66,61,238,26,51,61,238,62,61,65,55,66,55,61,60,238,48,51,52,61,64,51,238,59,61,68,55,60,53,238,61,60},50))
navToPointConfirmed(COORDS.Leo, 30, _d({26,51,61,238,62,61,65,55,66,55,61,60},50))
debug(_d({37,47,55,66,55,60,53,238,3,65,238,47,66,238,26,51,61,238,62,61,65,55,66,55,61,60},50))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({27,61,68,55,60,53,238,66,61},50), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({17,61,67,58,50,238,60,61,66,238,52,55,60,50,238,65,66,47,66,67,51,238,59,61,50,51,58,238,60,51,47,64},50), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({15,66,66,47,49,57,55,60,53},50), coordKey, _d({69,55,66,54},50), weapon or _d({60,61,66,54,55,60,53,238,52,61,67,60,50},50))
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
debug(coordKey, _d({48,47,64,64,51,58,238,50,51,65,66,64,61,71,51,50},50))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({64,51,49,54,51,49,57,33,66,47,66,67,51,8},50), coordKey, _d({251,238,49,61,67,58,50,238,60,61,66,238,52,55,60,50,238,65,66,47,66,67,51,238,59,61,50,51,58,250,238,65,57,55,62,62,55,60,53},50))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({64,51,49,54,51,49,57,33,66,47,66,67,51,8},50), coordKey, _d({65,66,55,58,58,238,47,58,55,68,51,238,246,22,30},50), hp, _d({247,238,251,238,64,51,251,50,51,65,66,64,61,71,55,60,53},50))
destroyStatue(coordKey)
else
debug(_d({64,51,49,54,51,49,57,33,66,47,66,67,51,8},50), coordKey, _d({49,61,60,52,55,64,59,51,50,238,50,51,65,66,64,61,71,51,50},50))
end
end)
if not ok then debug(_d({64,51,49,54,51,49,57,33,66,47,66,67,51,238,51,64,64,61,64,8},50), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({27,61,68,55,60,53,238,66,61,238,31,67,51,51,60},50))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({17,67,62,55,50,238,31,67,51,51,60},50))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({31,67,51,51,60,238,51,60,66,51,64,51,50,238,62,54,47,65,51,238,0},50))
end
local function finishQueen()
debug(_d({20,55,60,55,65,54,55,60,53,238,31,67,51,51,60},50))
equipSwordOrMelee()
setNavNamed(_d({17,67,62,55,50,238,31,67,51,51,60},50))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({17,67,62,55,50,238,31,67,51,51,60},50))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({31,67,51,51,60,238,50,51,52,51,47,66,51,50,252,238,30,58,47,60,238,49,61,59,62,58,51,66,51,252},50))
end
local CONFIRMATION_PROMPT_NAME = _d({17,61,60,52,55,64,59,47,66,55,61,60,30,64,61,59,62,66},50)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({32,51,59,61,66,51,19,68,51,60,66},50), 5)
end)
if ok then return result end
debug(_d({53,51,66,32,51,62,58,47,71,32,51,59,61,66,51,238,51,64,64,61,64,8},50), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({23,59,47,53,51,16,67,66,66,61,60},50)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({48,67,66,66,61,60,36,47,58,67,51},50)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({52,55,60,50,16,67,66,66,61,60,16,71,36,47,58,67,51,238,51,64,64,61,64,8},50), result)
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
if not ok then debug(_d({49,58,55,49,57,21,67,55,16,67,66,66,61,60,238,51,64,64,61,64,8},50), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({55,65,33,51,64,68,51,64},50))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({32,51,59,61,66,51,19,68,51,60,66},50))
or inst:FindFirstChild(_d({49,58,55,51,60,66,19,68,51,60,66},50))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({52,55,60,50,15,60,65,69,51,64,17,61,60,60,51,49,66,61,64,238,51,64,64,61,64,8},50), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({17,61,67,58,50,238,60,61,66,238,58,61,49,47,66,51,238,32,51,59,61,66,51,19,68,51,60,66,253,49,58,55,51,60,66,19,68,51,60,66,238,60,51,47,64,238,32,51,62,58,47,71,238,48,67,66,66,61,60,250,238,52,47,58,58,55,60,53,238,48,47,49,57,238,66,61,238,49,58,55,49,57},50))
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
debug(_d({52,55,64,51,32,51,62,58,47,71,36,47,58,67,51,238,51,64,64,61,64,8},50), err, _d({251,238,52,47,58,58,55,60,53,238,48,47,49,57,238,66,61,238,49,58,55,49,57},50))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({20,47,58,58,55,60,53,238,48,47,49,57,238,66,61,238,48,67,66,66,61,60,36,47,58,67,51,238,65,51,47,64,49,54,238,52,61,64,238,32,51,62,58,47,71},50))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({32,51,62,58,47,71,238,48,67,66,66,61,60,238,60,61,66,238,52,61,67,60,50,238,51,55,66,54,51,64,250,238,53,55,68,55,60,53,238,67,62},50))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({37,47,55,66,55,60,53,238,52,61,64,238,17,61,60,52,55,64,59,47,66,55,61,60,30,64,61,59,62,66,252,32,51,59,61,66,51,19,68,51,60,66},50))
local remote = getReplayRemote()
if not remote then
debug(_d({17,61,60,52,55,64,59,47,66,55,61,60,30,64,61,59,62,66,253,32,51,59,61,66,51,19,68,51,60,66,238,60,61,66,238,52,61,67,60,50,238,69,55,66,54,55,60,238,66,55,59,51,61,67,66},50))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({20,55,64,55,60,53,238,32,51,62,58,47,71,238,68,55,47,238,17,61,60,52,55,64,59,47,66,55,61,60,30,64,61,59,62,66,252,32,51,59,61,66,51,19,68,51,60,66},50))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({20,55,64,51,33,51,64,68,51,64,238,51,64,64,61,64,8},50), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({30,58,47,71,51,64,21,67,55},50), 10)
if not playerGui then
debug(_d({69,47,55,66,20,61,64,29,48,56,51,49,66,55,68,51,65,21,67,55,8,238,60,61,238,30,58,47,71,51,64,21,67,55,238,69,55,66,54,55,60,238,66,55,59,51,61,67,66,250,238,62,64,61,49,51,51,50,55,60,53,238,47,60,71,69,47,71},50))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({29,48,56,51,49,66,55,68,51,65,238,21,35,23,238,52,61,67,60,50,238,251,238,65,66,47,53,51,238,58,61,47,50,51,50},50))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({29,48,56,51,49,66,55,68,51,65,238,21,35,23,238,60,61,66,238,52,61,67,60,50,238,69,55,66,54,55,60,238,66,55,59,51,61,67,66,250,238,62,64,61,49,51,51,50,55,60,53,238,47,60,71,69,47,71},50))
return
end
end
end)
if not ok then debug(_d({69,47,55,66,20,61,64,29,48,56,51,49,66,55,68,51,65,21,67,55,238,51,64,64,61,64,8},50), err) end
end
local function runPlan()
debug(_d({30,58,47,60,238,65,66,47,64,66,51,50},50))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({33,66,47,64,66,55,60,53,238,60,47,68,238,58,61,61,62},50))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({62,61,65,238,254,252,0,65,238,15,20,34,19,32,238,65,66,47,64,66,28,47,68,8},50), rootAfter and rootAfter.Position)
end)
debug(_d({37,47,55,66,55,60,53,238,3,65,238,48,51,52,61,64,51,238,59,61,68,55,60,53,238,66,61,238,33,66,47,53,51,255},50))
task.wait(5)
for _, stage in ipairs({_d({33,66,47,53,51,255},50), _d({33,66,47,53,51,0},50), _d({33,66,47,53,51,1},50), _d({33,66,47,53,51,1,16},50)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({27,61,68,55,60,53,238,66,61,238,47,64,64,61,69,238,52,58,71,251,50,61,69,60,238,47,64,51,47},50))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({18,61,50,53,55,60,53,238,47,64,64,61,69,238,64,47,55,60},50))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({33,66,47,53,51,2},50))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({31,67,51,51,60,238,55,60,238,62,54,47,65,51,238,0,238,251,238,57,51,51,62,55,60,53,238,25,51,60,238,22,47,57,55,238,47,49,66,55,68,51,238,52,64,61,59,238,54,51,64,51,238,61,60},50))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({33,66,47,66,67,51,255},50))
if not enabled then return end
recheckStatue(_d({33,66,47,66,67,51,255},50))
destroyStatue(_d({33,66,47,66,67,51,0},50))
if not enabled then return end
recheckStatue(_d({33,66,47,66,67,51,255},50))
recheckStatue(_d({33,66,47,66,67,51,0},50))
destroyStatue(_d({33,66,47,66,67,51,1},50))
if not enabled then return end
recheckStatue(_d({33,66,47,66,67,51,1},50))
recheckStatue(_d({33,66,47,66,67,51,0},50))
recheckStatue(_d({33,66,47,66,67,51,255},50))
if not enabled then return end
debug(_d({37,47,55,66,55,60,53,238,52,61,64,238,62,54,47,65,51,238,0,238,66,61,238,51,60,50},50))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({30,54,47,65,51,238,0,238,51,60,50,238,69,47,55,66,238,66,55,59,51,61,67,66,250,238,62,64,61,49,51,51,50,55,60,53,238,47,60,71,69,47,71},50))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({27,61,68,55,60,53,238,48,47,49,57,238,66,61,238,31,67,51,51,60,238,65,66,47,53,51,238,62,61,65,55,66,55,61,60},50))
navToPointConfirmed(COORDS.Queen, 30, _d({31,67,51,51,60,238,65,66,47,53,51,238,62,61,65,55,66,55,61,60},50))
debug(_d({37,47,55,66,55,60,53,238,3,65,238,47,66,238,31,67,51,51,60,238,65,66,47,53,51,238,62,61,65,55,66,55,61,60},50))
task.wait(5)
if not enabled then return end
debug(_d({27,61,68,55,60,53,238,66,61,238,62,61,65,66,251,31,67,51,51,60,238,62,61,65,55,66,55,61,60},50))
navToPointConfirmed(COORDS.PostQueen, 30, _d({62,61,65,66,251,31,67,51,51,60,238,62,61,65,55,66,55,61,60},50))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({19,60,47,48,58,55,60,53,250,238,62,61,65,238,16,19,20,29,32,19,238,62,58,47,60,8},50), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({30,58,47,60,238,51,64,64,61,64,8},50), err2) end
end)
debug(_d({19,60,47,48,58,51,50,8},50), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({19,60,47,48,58,51,50,8},50), enabled)
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
if not ok then debug(_d({23,60,62,67,66,16,51,53,47,60,238,51,64,64,61,64,8},50), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({21,47,59,51,238,58,61,47,50,51,50,250,238,47,67,66,61,251,65,66,47,64,66,55,60,53,238,66,54,51,238,62,58,47,60},50))
enableBot()
end)
if not ok then debug(_d({15,67,66,61,65,66,47,64,66,238,51,64,64,61,64,8},50), err) end
end)
debug(_d({26,61,47,50,51,50,238,176,78,98,238,47,67,66,61,251,65,66,47,64,66,55,60,53,238,61,60,49,51,238,66,54,51,238,53,47,59,51,238,52,55,60,55,65,54,51,65,238,58,61,47,50,55,60,53,238,246,62,64,51,65,65,238,30,238,66,61,238,66,61,53,53,58,51,238,59,47,60,67,47,58,58,71,247},50))
end)()