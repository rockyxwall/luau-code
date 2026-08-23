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
local Players            = game:GetService(_d({29,57,46,70,50,63,64},51))
local UserInputService    = game:GetService(_d({34,64,50,63,22,59,61,66,65,32,50,63,67,54,48,50},51))
local RunService          = game:GetService(_d({31,66,59,32,50,63,67,54,48,50},51))
local VIM                 = game:GetService(_d({35,54,63,65,66,46,57,22,59,61,66,65,26,46,59,46,52,50,63},51))
local ReplicatedStorage    = game:GetService(_d({31,50,61,57,54,48,46,65,50,49,32,65,60,63,46,52,50},51))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({40,15,60,64,64,15,60,65,42},51), _d({36,63,60,59,52,237,52,46,58,50,237,175,77,97,237,29,57,46,48,50,22,49,7},51), game.PlaceId, _d({34,59,54,67,50,63,64,50,22,49,7},51), game.GameId, _d({250,237,59,60,65,237,63,66,59,59,54,59,52},51))
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
local LEO_PILLAR_ANIM_ID   = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,2,255,1,1,254,1,254,0,255,4},51)
local LEO_ENTEI_ANIM_ID    = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,2,255,1,1,254,0,5,255,4,5},51)
local LEO_HIKEN_ANIM_ID    = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,2,255,255,253,6,254,4,1,253,4},51)
local LEO_FIREFLY_ANIM_ID  = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,2,255,255,253,255,0,3,254,2,1},51)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({28,47,55,50,48,65,54,67,50,64},51)
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
local REPLAY_BUTTON_VALUE   = _d({31,50,61,57,46,70},51)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({58,60,67,50},51)
local NavState   = {mode = _d({54,49,57,50},51)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({40,15,60,64,64,15,60,65,42},51), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
end)
if ok then return root end
debug(_d({52,50,65,31,60,60,65,237,50,63,63,60,63,7},51), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
end)
if ok then return hum end
debug(_d({52,50,65,21,66,58,46,59,60,54,49,237,50,63,63,60,63,7},51), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({44,44,21,60,67,50,63,14,65,65},51)) or Instance.new(_d({14,65,65,46,48,53,58,50,59,65},51))
att.Name = _d({44,44,21,60,67,50,63,14,65,65},51)
att.Parent = root
local force = root:FindFirstChild(_d({44,44,21,60,67,50,63,19,60,63,48,50},51))
if not force then
force = Instance.new(_d({25,54,59,50,46,63,35,50,57,60,48,54,65,70},51))
force.Name = _d({44,44,21,60,67,50,63,19,60,63,48,50},51)
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
debug(_d({52,50,65,28,63,16,63,50,46,65,50,19,60,63,48,50,237,50,63,63,60,63,7},51), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local force = root:FindFirstChild(_d({44,44,21,60,67,50,63,19,60,63,48,50},51))
local att   = root:FindFirstChild(_d({44,44,21,60,67,50,63,14,65,65},51))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({48,57,50,46,59,66,61,19,60,63,48,50,237,50,63,63,60,63,7},51), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({15,66,64,60,26,50,57,50,50},51)) ~= nil
end)
if ok then return result end
debug(_d({54,64,15,66,64,60,14,48,65,54,67,50,237,50,63,63,60,63,7},51), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({15,66,64,60},51))
end)
if not ok then debug(_d({46,48,65,54,67,46,65,50,15,66,64,60,237,50,63,63,60,63,7},51), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({15,66,64,60,237,59,60,65,237,46,48,65,54,67,50,249,237,46,48,65,54,67,46,65,54,59,52},51))
activateBuso()
end
end)
if not ok then debug(_d({15,66,64,60,24,50,50,61,50,63,237,50,63,63,60,63,7},51), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({15,66,64,60,237,56,50,50,61,50,63,237,64,65,60,61,61,50,49},51))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({24,50,59,21,46,56,54},51)) ~= nil
end)
if ok then return result end
debug(_d({54,64,24,50,59,14,48,65,54,67,50,237,50,63,63,60,63,7},51), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({24,50,59},51), true)
end)
if not ok then debug(_d({46,48,65,54,67,46,65,50,24,50,59,237,50,63,63,60,63,7},51), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({24,50,59,237,59,60,65,237,46,48,65,54,67,50,249,237,46,48,65,54,67,46,65,54,59,52},51))
activateKen()
end
end)
if not ok then debug(_d({24,50,59,24,50,50,61,50,63,237,50,63,63,60,63,7},51), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({24,50,59,237,56,50,50,61,50,63,237,64,65,60,61,61,50,49},51))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({27,29,16,64},51)) end)
if ok then return folder end
debug(_d({52,50,65,27,29,16,64,19,60,57,49,50,63,237,50,63,63,60,63,7},51), folder)
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
local r = model:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
local h = model:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
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
debug(_d({52,50,65,27,50,46,63,50,64,65,27,29,16,237,50,63,63,60,63,7},51), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
local hum  = model:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({52,50,65,27,29,16,15,70,27,46,58,50,237,50,63,63,60,63,7},51), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({59,61,48,64,31,50,58,46,54,59,54,59,52,237,50,63,63,60,63,7},51), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({16,66,61,54,49,237,30,66,50,50,59},51))
return queen ~= nil and queen:FindFirstChild(_d({58,60,65,54,60,59,25,50,64,64},51)) ~= nil
end)
if ok then return result end
debug(_d({54,64,30,66,50,50,59,29,53,46,64,50,255,237,50,63,63,60,63,7},51), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,254,255,254,255,6,4,6,1,255,255,6,255,4,3,6},51)
local QUEEN_GRASP_ANIM_ID   = _d({63,47,69,46,64,64,50,65,54,49,7,252,252,254,255,6,5,253,253,253,3,254,253,253,254,4,0,1},51)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
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
debug(_d({54,64,29,57,46,70,54,59,52,14,59,54,58,19,63,60,58,25,54,64,65,237,50,63,63,60,63,7},51), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({15,57,60,48,56,54,59,52},51)) ~= nil
end)
if ok then return result end
debug(_d({54,64,27,29,16,15,57,60,48,56,54,59,52,237,50,63,63,60,63,7},51), result)
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
debug(_d({61,63,50,49,54,48,65,27,29,16,29,60,64,54,65,54,60,59,237,50,63,63,60,63,7},51), result)
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
debug(_d({27,60,237,49,46,58,46,52,50,237,60,59},51), model.Name, _d({51,60,63},51), NPC_STUCK_TIMEOUT, _d({64,237,250,237,64,68,54,65,48,53,54,59,52,237,65,46,63,52,50,65},51))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({65,63,46,48,56,27,29,16,17,46,58,46,52,50,237,50,63,63,60,63,7},51), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({26,60,49,50,57},51)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({15,46,64,50,29,46,63,65},51)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({52,50,65,26,60,49,50,57,19,46,48,50,29,60,64,237,50,63,63,60,63,7},51), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({18,59,67},51))
local folder = env and env:FindFirstChild(_d({32,65,46,65,66,50,64},51))
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
debug(_d({52,50,65,32,65,46,65,66,50,26,60,49,50,57,27,50,46,63,237,50,63,63,60,63,7},51), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({47,46,63,63,50,57,21,29},51))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({52,50,65,32,65,46,65,66,50,21,29,237,50,63,63,60,63,7},51), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({33,60,60,57},51)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({51,54,59,49,33,60,60,57,15,70,14,65,65,63,54,47,66,65,50,237,50,63,63,60,63,7},51), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({33,60,60,57},51)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({51,54,59,49,33,60,60,57,15,70,27,46,58,50,237,50,63,63,60,63,7},51), tool)
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
if not ok then debug(_d({50,62,66,54,61,33,60,60,57,237,50,63,63,60,63,7},51), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({15,46,48,56,61,46,48,56},51))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({33,60,60,57},51)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({51,54,59,49,33,60,60,57,15,70,16,53,54,57,49,27,46,58,50,237,50,63,63,60,63,7},51), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({32,68,60,63,49,18,62,66,54,61},51))
if sword then
equipTool(sword)
return _d({64,68,60,63,49},51)
end
local melee = findToolByAttribute(_d({26,50,57,50,50,33,60,60,57},51))
if melee then
equipTool(melee)
return _d({58,50,57,50,50},51)
end
debug(_d({27,60,237,64,68,60,63,49,237,60,63,237,58,50,57,50,50,237,65,60,60,57,237,51,60,66,59,49},51))
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
if not ok then debug(_d({48,57,54,48,56,26,254,237,50,63,63,60,63,7},51), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({21,66,58,46,59,60,54,49,31,60,60,65,29,46,63,65},51))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({32,65,46,65,64},51) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({31,60,56,66,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({20,50,61,61,60},51), args)
elseif style == _d({15,57,46,48,56,25,50,52},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56},51), args)
elseif style == _d({24,46,58,54,64,53,54,56,54},51) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({24,46,58,54,64,53,54,56,54,20,50,61,61,60},51), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,56,70,237,36,46,57,56,255},51), args)
end
end)
if not ok then debug(_d({54,59,67,60,56,50,20,50,61,61,60,237,50,63,63,60,63,7},51), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({61,63,50,64,64,32,56,54,57,57,31,237,50,63,63,60,63,7},51), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({53,60,57,49,15,57,60,48,56,237,50,63,63,60,63,7},51), err) end
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
if not ok then debug(_d({53,60,57,49,15,57,60,48,56,36,53,54,57,50,237,50,63,63,60,63,7},51), err) end
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
debug(_d({52,50,65,20,46,58,50,20,237,50,63,63,60,63,7},51), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({54,64,31,50,46,57,26,254,15,66,64,70,237,50,63,63,60,63,7},51), result)
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
return char ~= nil and char:FindFirstChild(_d({64,65,66,59},51)) ~= nil
end)
if ok then return result end
debug(_d({54,64,32,65,66,59,59,50,49,237,50,63,63,60,63,7},51), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({61,63,50,64,64,32,65,66,59,15,63,50,46,56,237,50,63,63,60,63,7},51), err) end
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
debug(_d({62,66,50,50,59,17,60,49,52,50,34,59,65,54,57,32,46,51,50,7,237,30,66,50,50,59,237,52,60,59,50,237,250,237,50,59,49,54,59,52,237,49,60,49,52,50,237,50,46,63,57,70},51))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({62,66,50,50,59,17,60,49,52,50,34,59,65,54,57,32,46,51,50,237,64,46,51,50,65,70,237,65,54,58,50,60,66,65},51))
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
local info = getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({30,66,50,50,59,237,48,46,64,65,54,59,52,237,49,50,65,50,48,65,50,49,237,250,237,49,60,49,52,54,59,52,237,245,68,46,65,48,53,50,63,246},51))
queenDodgeUntilSafe(function() return getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51)) end)
if enabled and getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51)) then
setNavNamed(_d({16,66,61,54,49,237,30,66,50,50,59},51))
end
queenDodging = false
end
end)
if not ok then debug(_d({62,66,50,50,59,17,60,49,52,50,36,46,65,48,53,50,63,237,50,63,63,60,63,7},51), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({61,60,54,59,65},51) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({59,61,48},51) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({59,46,58,50,49},51) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({52,50,65,27,46,67,33,46,63,52,50,65,64,237,50,63,63,60,63,7},51), aimR)
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
debug(_d({48,60,58,61,66,65,50,25,60,48,56,50,49,16,19,63,46,58,50,237,50,63,63,60,63,7},51), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({61,60,54,59,65},51), point = pos}
phase = _d({58,60,67,50},51)
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
if not ok then debug(_d({59,46,67,33,60,29,60,54,59,65,237,52,50,61,61,60,237,48,53,50,48,56,237,50,63,63,60,63,7},51), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({59,61,48},51)}
phase = _d({58,60,67,50},51)
end
function setNavNamed(name)
NavState = {mode = _d({59,46,58,50,49},51), name = name}
phase = _d({58,60,67,50},51)
end
local function setNavIdle()
NavState = {mode = _d({54,49,57,50},51)}
phase = _d({58,60,67,50},51)
end
local function hasArrived()
return phase == _d({53,60,67,50,63},51)
end
local function startNav()
phase = _d({58,60,67,50},51)
debug(_d({27,46,67,237,57,60,60,61,237,28,27},51))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({29,57,46,70,50,63,237,49,54,50,49,238,237,32,65,60,61,61,54,59,52,237,47,60,65,251},51))
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
debug(_d({29,57,46,70,50,63,237,54,64,237,65,60,60,237,51,46,63,237,51,63,60,58,237,65,46,63,52,50,65,237,245,11,255,253,253,253,237,64,65,66,49,64,246,251,237,25,54,56,50,57,70,237,63,50,64,61,46,68,59,50,49,237,46,65,237,57,60,47,47,70,251,237,32,65,60,61,61,54,59,52,237,47,60,65,251},51))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({44,44,61,63,50,67,29,60,64},51))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({25,46,63,52,50,237,61,60,64,54,65,54,60,59,237,55,66,58,61,237,49,50,65,50,48,65,50,49,7},51), delta, _d({64,65,66,49,64,251,237,61,63,50,67,29,60,64,10},51), prevPos, _d({59,50,68,29,60,64,10},51), pos)
end
end
force:SetAttribute(_d({44,44,61,63,50,67,29,60,64},51), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({58,60,67,50},51) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({53,60,67,50,63},51)
debug(_d({29,53,46,64,50,7,237,53,60,67,50,63},51))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({238,238,238,237,31,18,19,34,32,22,27,20,237,33,28,237,14,29,29,25,38,237,14,15,27,28,31,26,14,25,237,35,18,25,28,16,22,33,38,7},51), finalVel, _d({46,54,58,10},51), aim, _d({61,60,64,10},51), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({53,60,67,50,63},51) then
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
debug(_d({16,60,58,47,46,65,237,57,60,48,56,237,64,56,54,61,61,50,49,249},51), snapDist, _d({64,65,66,49,64,237,51,63,60,58,237,65,46,63,52,50,65,237,175,77,97,237,51,46,57,57,54,59,52,237,47,46,48,56,237,65,60,237,58,60,67,50},51))
phase = _d({58,60,67,50},51)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({21,50,46,63,65,47,50,46,65,237,50,63,63,60,63,7},51), err) end
end)
end
local function stopNav()
debug(_d({27,46,67,237,57,60,60,61,237,28,19,19},51))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({58,60,67,50},51)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({33,50,69,65,16,53,46,65,32,50,63,67,54,48,50},51))
local channels = TextChatService:FindFirstChild(_d({33,50,69,65,16,53,46,59,59,50,57,64},51))
local channel = channels and channels:FindFirstChild(_d({31,15,37,20,50,59,50,63,46,57},51))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({17,50,51,46,66,57,65,16,53,46,65,32,70,64,65,50,58,16,53,46,65,18,67,50,59,65,64},51))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({32,46,70,26,50,64,64,46,52,50,31,50,62,66,50,64,65},51))
if sayEvent then
sayEvent:FireServer(message, _d({14,57,57},51))
return
end
debug(_d({64,50,59,49,16,53,46,65,26,50,64,64,46,52,50,7,237,59,60,237,33,50,69,65,16,53,46,65,32,50,63,67,54,48,50,251,31,15,37,20,50,59,50,63,46,57,237,60,63,237,57,50,52,46,48,70,237,32,46,70,26,50,64,64,46,52,50,31,50,62,66,50,64,65,237,51,60,66,59,49,237,51,60,63},51), message)
end)
if not ok then debug(_d({64,50,59,49,16,53,46,65,26,50,64,64,46,52,50,237,50,63,63,60,63,7},51), err) end
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
debug(_d({27,60,65,237,58,46,56,54,59,52,237,61,63,60,52,63,50,64,64,237,65,60,68,46,63,49,237,59,46,67,237,65,46,63,52,50,65,237,51,60,63},51), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({64,237,250,237,64,50,59,49,54,59,52,237,252,66,59,64,65,66,48,56},51))
sendChatMessage(_d({252,66,59,64,65,66,48,56},51))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({68,46,54,65,34,59,65,54,57,14,63,63,54,67,50,49,237,65,54,58,50,60,66,65},51))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({59,46,67,33,60,29,60,54,59,65,16,60,59,51,54,63,58,50,49,7},51), label or _d({65,46,63,52,50,65},51), _d({250,237,49,54,49,237,59,60,65,237,46,63,63,54,67,50,237,68,54,65,53,54,59},51), timeout, _d({64,249,237,63,50,65,63,70,54,59,52,237,60,59,48,50},51))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({59,46,67,33,60,29,60,54,59,65,16,60,59,51,54,63,58,50,49,7},51), label or _d({65,46,63,52,50,65},51), _d({250,237,64,65,54,57,57,237,59,60,65,237,46,63,63,54,67,50,49,237,46,51,65,50,63,237,63,50,65,63,70,249,237,61,63,60,48,50,50,49,54,59,52,237,46,59,70,68,46,70},51))
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
if not ok then debug(_d({59,46,67,33,60,29,60,54,59,65,21,60,57,49,54,59,52,15,57,60,48,56,237,56,50,70,250,49,60,68,59,237,50,63,63,60,63,7},51), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({59,46,67,33,60,29,60,54,59,65,21,60,57,49,54,59,52,15,57,60,48,56,237,56,50,70,250,66,61,237,50,63,63,60,63,7},51), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({36,46,57,56,54,59,52,237,65,60,7},51), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({68,46,57,56,33,60,29,60,54,59,65,237,36,237,49,60,68,59,237,50,63,63,60,63,7},51), err) end
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
debug(_d({33,60,60,56,237,49,46,58,46,52,50,237,68,53,54,57,50,237,68,46,57,56,54,59,52,237,65,60,237,61,60,54,59,65,238,237,32,65,60,61,61,54,59,52,237,68,46,57,56,237,65,60,237,50,59,52,46,52,50,251},51))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({14,63,63,54,67,50,49,237,46,65,7},51), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({32,65,66,48,56,237,49,66,63,54,59,52,237,68,46,57,56,249,237,55,66,58,61,54,59,52,238},51))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({32,65,54,57,57,237,64,65,66,48,56,249,237,65,63,54,52,52,50,63,54,59,52,237,20,50,61,61,60,238},51))
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
debug(_d({26,60,67,54,59,52,237,65,60},51), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({36,46,54,65,54,59,52,237,51,60,63,237,27,29,16,64,237,65,60,237,64,61,46,68,59,237,46,65},51), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({237,237,64,61,46,68,59,237,48,53,50,48,56,7,237,51,60,57,49,50,63,237,50,69,54,64,65,64,237,10},51), folder ~= nil,
_d({249,237,48,53,54,57,49,63,50,59,237,10},51), folder and #folder:GetChildren() or 0,
_d({249,237,46,57,54,67,50,237,10},51), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({27,60,237,27,29,16,64,237,46,61,61,50,46,63,50,49,237,46,65},51), stageName, _d({46,51,65,50,63,237,254,2,64,249,237,58,60,67,54,59,52,237,60,59,237,46,59,70,68,46,70},51))
break
end
end
debug(_d({24,54,57,57,54,59,52,237,27,29,16,64,237,46,65},51), stageName)
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
debug(_d({31,50,65,66,63,59,54,59,52,237,65,60},51), stageName, _d({61,60,64,54,65,54,60,59,237,47,50,51,60,63,50,237,58,60,67,54,59,52,237,60,59},51))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({36,46,54,65,54,59,52,237,2,64,237,46,65},51), stageName, _d({61,60,64,54,65,54,60,59},51))
task.wait(5)
debug(_d({36,46,54,65,54,59,52,237,51,60,63},51), targetHP * 100, _d({242,237,21,29,237,47,50,51,60,63,50,237,58,60,67,54,59,52,237,65,60,237,59,50,69,65,237,64,65,46,52,50},51))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({48,57,50,46,63,50,49},51))
end
local function killNamedNPC(name, targetPos)
debug(_d({26,60,67,54,59,52,237,65,60},51), name)
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
debug(name, _d({49,50,51,50,46,65,50,49},51))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({21,66,58,46,59,60,54,49},51))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({25,50,60,237,61,57,46,70,50,49,237,46,59,54,58,46,65,54,60,59,7},51), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({57,50,60,14,59,54,58,25,60,52,52,50,63,237,61,63,54,59,65,237,50,63,63,60,63,7},51), err2) end
end)
end)
if not ok then debug(_d({64,65,46,63,65,25,50,60,14,59,54,58,25,60,52,52,50,63,237,50,63,63,60,63,7},51), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({26,60,67,54,59,52,237,65,60,237,25,50,60},51))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({25,50,60},51))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({25,50,60},51))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({25,50,60},51))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({25,50,60,237,48,46,64,65,54,59,52},51), which, _d({250,237,49,60,49,52,54,59,52},51))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({25,50,60,237,64,65,46,63,65,50,49,237,47,57,60,48,56,250,47,63,50,46,56,50,63,237,58,54,49,250,47,57,60,48,56,238,237,18,67,46,49,54,59,52,251,251,251},51))
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
if not getNPCByName(_d({25,50,60},51)) then
debug(_d({25,50,60,237,52,60,59,50,237,58,54,49,250,49,60,49,52,50,237,250,237,50,59,49,54,59,52,237,18,59,65,50,54,237,53,60,57,49,237,50,46,63,57,70},51))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({25,50,60},51)) then
setNavNamed(_d({25,50,60},51))
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
debug(_d({25,50,60,237,49,50,51,50,46,65,50,49},51))
stopLeoAnimLogger()
debug(_d({31,50,65,66,63,59,54,59,52,237,65,60,237,25,50,60,237,61,60,64,54,65,54,60,59,237,47,50,51,60,63,50,237,58,60,67,54,59,52,237,60,59},51))
navToPointConfirmed(COORDS.Leo, 30, _d({25,50,60,237,61,60,64,54,65,54,60,59},51))
debug(_d({36,46,54,65,54,59,52,237,2,64,237,46,65,237,25,50,60,237,61,60,64,54,65,54,60,59},51))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({26,60,67,54,59,52,237,65,60},51), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({16,60,66,57,49,237,59,60,65,237,51,54,59,49,237,64,65,46,65,66,50,237,58,60,49,50,57,237,59,50,46,63},51), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({14,65,65,46,48,56,54,59,52},51), coordKey, _d({68,54,65,53},51), weapon or _d({59,60,65,53,54,59,52,237,51,60,66,59,49},51))
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
debug(coordKey, _d({47,46,63,63,50,57,237,49,50,64,65,63,60,70,50,49},51))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({63,50,48,53,50,48,56,32,65,46,65,66,50,7},51), coordKey, _d({250,237,48,60,66,57,49,237,59,60,65,237,51,54,59,49,237,64,65,46,65,66,50,237,58,60,49,50,57,249,237,64,56,54,61,61,54,59,52},51))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({63,50,48,53,50,48,56,32,65,46,65,66,50,7},51), coordKey, _d({64,65,54,57,57,237,46,57,54,67,50,237,245,21,29},51), hp, _d({246,237,250,237,63,50,250,49,50,64,65,63,60,70,54,59,52},51))
destroyStatue(coordKey)
else
debug(_d({63,50,48,53,50,48,56,32,65,46,65,66,50,7},51), coordKey, _d({48,60,59,51,54,63,58,50,49,237,49,50,64,65,63,60,70,50,49},51))
end
end)
if not ok then debug(_d({63,50,48,53,50,48,56,32,65,46,65,66,50,237,50,63,63,60,63,7},51), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({26,60,67,54,59,52,237,65,60,237,30,66,50,50,59},51))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({16,66,61,54,49,237,30,66,50,50,59},51))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51))
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
debug(_d({30,66,50,50,59,237,50,59,65,50,63,50,49,237,61,53,46,64,50,237,255},51))
end
local function finishQueen()
debug(_d({19,54,59,54,64,53,54,59,52,237,30,66,50,50,59},51))
equipSwordOrMelee()
setNavNamed(_d({16,66,61,54,49,237,30,66,50,50,59},51))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({16,66,61,54,49,237,30,66,50,50,59},51))
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
debug(_d({30,66,50,50,59,237,49,50,51,50,46,65,50,49,251,237,29,57,46,59,237,48,60,58,61,57,50,65,50,251},51))
end
local CONFIRMATION_PROMPT_NAME = _d({16,60,59,51,54,63,58,46,65,54,60,59,29,63,60,58,61,65},51)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({31,50,58,60,65,50,18,67,50,59,65},51), 5)
end)
if ok then return result end
debug(_d({52,50,65,31,50,61,57,46,70,31,50,58,60,65,50,237,50,63,63,60,63,7},51), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({29,57,46,70,50,63,20,66,54},51))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({22,58,46,52,50,15,66,65,65,60,59},51)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({47,66,65,65,60,59,35,46,57,66,50},51)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({51,54,59,49,15,66,65,65,60,59,15,70,35,46,57,66,50,237,50,63,63,60,63,7},51), result)
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
if not ok then debug(_d({48,57,54,48,56,20,66,54,15,66,65,65,60,59,237,50,63,63,60,63,7},51), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({54,64,32,50,63,67,50,63},51))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({31,50,58,60,65,50,18,67,50,59,65},51))
or inst:FindFirstChild(_d({48,57,54,50,59,65,18,67,50,59,65},51))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({51,54,59,49,14,59,64,68,50,63,16,60,59,59,50,48,65,60,63,237,50,63,63,60,63,7},51), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({16,60,66,57,49,237,59,60,65,237,57,60,48,46,65,50,237,31,50,58,60,65,50,18,67,50,59,65,252,48,57,54,50,59,65,18,67,50,59,65,237,59,50,46,63,237,31,50,61,57,46,70,237,47,66,65,65,60,59,249,237,51,46,57,57,54,59,52,237,47,46,48,56,237,65,60,237,48,57,54,48,56},51))
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
debug(_d({51,54,63,50,31,50,61,57,46,70,35,46,57,66,50,237,50,63,63,60,63,7},51), err, _d({250,237,51,46,57,57,54,59,52,237,47,46,48,56,237,65,60,237,48,57,54,48,56},51))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({19,46,57,57,54,59,52,237,47,46,48,56,237,65,60,237,47,66,65,65,60,59,35,46,57,66,50,237,64,50,46,63,48,53,237,51,60,63,237,31,50,61,57,46,70},51))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({31,50,61,57,46,70,237,47,66,65,65,60,59,237,59,60,65,237,51,60,66,59,49,237,50,54,65,53,50,63,249,237,52,54,67,54,59,52,237,66,61},51))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({36,46,54,65,54,59,52,237,51,60,63,237,16,60,59,51,54,63,58,46,65,54,60,59,29,63,60,58,61,65,251,31,50,58,60,65,50,18,67,50,59,65},51))
local remote = getReplayRemote()
if not remote then
debug(_d({16,60,59,51,54,63,58,46,65,54,60,59,29,63,60,58,61,65,252,31,50,58,60,65,50,18,67,50,59,65,237,59,60,65,237,51,60,66,59,49,237,68,54,65,53,54,59,237,65,54,58,50,60,66,65},51))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({19,54,63,54,59,52,237,31,50,61,57,46,70,237,67,54,46,237,16,60,59,51,54,63,58,46,65,54,60,59,29,63,60,58,61,65,251,31,50,58,60,65,50,18,67,50,59,65},51))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({19,54,63,50,32,50,63,67,50,63,237,50,63,63,60,63,7},51), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({29,57,46,70,50,63,20,66,54},51), 10)
if not playerGui then
debug(_d({68,46,54,65,19,60,63,28,47,55,50,48,65,54,67,50,64,20,66,54,7,237,59,60,237,29,57,46,70,50,63,20,66,54,237,68,54,65,53,54,59,237,65,54,58,50,60,66,65,249,237,61,63,60,48,50,50,49,54,59,52,237,46,59,70,68,46,70},51))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({28,47,55,50,48,65,54,67,50,64,237,20,34,22,237,51,60,66,59,49,237,250,237,64,65,46,52,50,237,57,60,46,49,50,49},51))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({28,47,55,50,48,65,54,67,50,64,237,20,34,22,237,59,60,65,237,51,60,66,59,49,237,68,54,65,53,54,59,237,65,54,58,50,60,66,65,249,237,61,63,60,48,50,50,49,54,59,52,237,46,59,70,68,46,70},51))
return
end
end
end)
if not ok then debug(_d({68,46,54,65,19,60,63,28,47,55,50,48,65,54,67,50,64,20,66,54,237,50,63,63,60,63,7},51), err) end
end
local function runPlan()
debug(_d({29,57,46,59,237,64,65,46,63,65,50,49},51))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({32,65,46,63,65,54,59,52,237,59,46,67,237,57,60,60,61},51))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({61,60,64,237,253,251,255,64,237,14,19,33,18,31,237,64,65,46,63,65,27,46,67,7},51), rootAfter and rootAfter.Position)
end)
debug(_d({36,46,54,65,54,59,52,237,2,64,237,47,50,51,60,63,50,237,58,60,67,54,59,52,237,65,60,237,32,65,46,52,50,254},51))
task.wait(5)
for _, stage in ipairs({_d({32,65,46,52,50,254},51), _d({32,65,46,52,50,255},51), _d({32,65,46,52,50,0},51), _d({32,65,46,52,50,0,15},51)}) do
if not enabled then return end
local hpTarget = (stage == _d({32,65,46,52,50,0,15},51)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({26,60,67,54,59,52,237,65,60,237,46,63,63,60,68,237,51,57,70,250,49,60,68,59,237,46,63,50,46,237,245,16,66,61,54,49,237,31,46,54,59,246},51))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({17,60,49,52,54,59,52,237,46,63,63,60,68,237,63,46,54,59,237,54,59,237,46,237,64,62,66,46,63,50},51))
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
clearStage(_d({32,65,46,52,50,1},51))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({30,66,50,50,59,237,54,59,237,61,53,46,64,50,237,255,237,250,237,56,50,50,61,54,59,52,237,24,50,59,237,21,46,56,54,237,46,48,65,54,67,50,237,51,63,60,58,237,53,50,63,50,237,60,59},51))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({32,65,46,65,66,50,254},51))
if not enabled then return end
recheckStatue(_d({32,65,46,65,66,50,254},51))
destroyStatue(_d({32,65,46,65,66,50,255},51))
if not enabled then return end
recheckStatue(_d({32,65,46,65,66,50,254},51))
recheckStatue(_d({32,65,46,65,66,50,255},51))
destroyStatue(_d({32,65,46,65,66,50,0},51))
if not enabled then return end
recheckStatue(_d({32,65,46,65,66,50,0},51))
recheckStatue(_d({32,65,46,65,66,50,255},51))
recheckStatue(_d({32,65,46,65,66,50,254},51))
if not enabled then return end
debug(_d({36,46,54,65,54,59,52,237,51,60,63,237,61,53,46,64,50,237,255,237,65,60,237,50,59,49},51))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({29,53,46,64,50,237,255,237,50,59,49,237,68,46,54,65,237,65,54,58,50,60,66,65,249,237,61,63,60,48,50,50,49,54,59,52,237,46,59,70,68,46,70},51))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({26,60,67,54,59,52,237,47,46,48,56,237,65,60,237,30,66,50,50,59,237,64,65,46,52,50,237,61,60,64,54,65,54,60,59},51))
navToPointConfirmed(COORDS.Queen, 30, _d({30,66,50,50,59,237,64,65,46,52,50,237,61,60,64,54,65,54,60,59},51))
debug(_d({36,46,54,65,54,59,52,237,2,64,237,46,65,237,30,66,50,50,59,237,64,65,46,52,50,237,61,60,64,54,65,54,60,59},51))
task.wait(5)
if not enabled then return end
debug(_d({26,60,67,54,59,52,237,65,60,237,61,60,64,65,250,30,66,50,50,59,237,61,60,64,54,65,54,60,59},51))
navToPointConfirmed(COORDS.PostQueen, 30, _d({61,60,64,65,250,30,66,50,50,59,237,61,60,64,54,65,54,60,59},51))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({18,59,46,47,57,54,59,52,249,237,61,60,64,237,15,18,19,28,31,18,237,61,57,46,59,7},51), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({29,57,46,59,237,50,63,63,60,63,7},51), err2) end
end)
debug(_d({18,59,46,47,57,50,49,7},51), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({18,59,46,47,57,50,49,7},51), enabled)
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
if not ok then debug(_d({22,59,61,66,65,15,50,52,46,59,237,50,63,63,60,63,7},51), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({20,46,58,50,237,57,60,46,49,50,49,249,237,46,66,65,60,250,64,65,46,63,65,54,59,52,237,65,53,50,237,61,57,46,59},51))
enableBot()
end)
if not ok then debug(_d({14,66,65,60,64,65,46,63,65,237,50,63,63,60,63,7},51), err) end
end)
debug(_d({25,60,46,49,50,49,237,175,77,97,237,46,66,65,60,250,64,65,46,63,65,54,59,52,237,60,59,48,50,237,65,53,50,237,52,46,58,50,237,51,54,59,54,64,53,50,64,237,57,60,46,49,54,59,52,237,245,61,63,50,64,64,237,29,237,65,60,237,65,60,52,52,57,50,237,58,46,59,66,46,57,57,70,246},51))
end)()