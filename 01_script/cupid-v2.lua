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
local Players            = game:GetService(_d({28,56,45,69,49,62,63},52))
local UserInputService    = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local RunService          = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM                 = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local ReplicatedStorage    = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({39,14,59,63,63,14,59,64,41},52), _d({35,62,59,58,51,236,51,45,57,49,236,174,76,96,236,28,56,45,47,49,21,48,6},52), game.PlaceId, _d({33,58,53,66,49,62,63,49,21,48,6},52), game.GameId, _d({249,236,58,59,64,236,62,65,58,58,53,58,51},52))
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
local LEO_PILLAR_ANIM_ID   = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,0,0,253,0,253,255,254,3},52)
local LEO_ENTEI_ANIM_ID    = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,0,0,253,255,4,254,3,4},52)
local LEO_HIKEN_ANIM_ID    = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,254,252,5,253,3,0,252,3},52)
local LEO_FIREFLY_ANIM_ID  = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,254,252,254,255,2,253,1,0},52)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({27,46,54,49,47,64,53,66,49,63},52)
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
local REPLAY_BUTTON_VALUE   = _d({30,49,60,56,45,69},52)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({57,59,66,49},52)
local NavState   = {mode = _d({53,48,56,49},52)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({39,14,59,63,63,14,59,64,41},52), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end)
if ok then return root end
debug(_d({51,49,64,30,59,59,64,236,49,62,62,59,62,6},52), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
end)
if ok then return hum end
debug(_d({51,49,64,20,65,57,45,58,59,53,48,236,49,62,62,59,62,6},52), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({43,43,20,59,66,49,62,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,20,59,66,49,62,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,20,59,66,49,62,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,20,59,66,49,62,18,59,62,47,49},52)
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
debug(_d({51,49,64,27,62,15,62,49,45,64,49,18,59,62,47,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then return end
local force = root:FindFirstChild(_d({43,43,20,59,66,49,62,18,59,62,47,49},52))
local att   = root:FindFirstChild(_d({43,43,20,59,66,49,62,13,64,64},52))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({47,56,49,45,58,65,60,18,59,62,47,49,236,49,62,62,59,62,6},52), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({14,65,63,59,25,49,56,49,49},52)) ~= nil
end)
if ok then return result end
debug(_d({53,63,14,65,63,59,13,47,64,53,66,49,236,49,62,62,59,62,6},52), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({14,65,63,59},52))
end)
if not ok then debug(_d({45,47,64,53,66,45,64,49,14,65,63,59,236,49,62,62,59,62,6},52), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({14,65,63,59,236,58,59,64,236,45,47,64,53,66,49,248,236,45,47,64,53,66,45,64,53,58,51},52))
activateBuso()
end
end)
if not ok then debug(_d({14,65,63,59,23,49,49,60,49,62,236,49,62,62,59,62,6},52), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({14,65,63,59,236,55,49,49,60,49,62,236,63,64,59,60,60,49,48},52))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({23,49,58,20,45,55,53},52)) ~= nil
end)
if ok then return result end
debug(_d({53,63,23,49,58,13,47,64,53,66,49,236,49,62,62,59,62,6},52), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({23,49,58},52), true)
end)
if not ok then debug(_d({45,47,64,53,66,45,64,49,23,49,58,236,49,62,62,59,62,6},52), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({23,49,58,236,58,59,64,236,45,47,64,53,66,49,248,236,45,47,64,53,66,45,64,53,58,51},52))
activateKen()
end
end)
if not ok then debug(_d({23,49,58,23,49,49,60,49,62,236,49,62,62,59,62,6},52), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({23,49,58,236,55,49,49,60,49,62,236,63,64,59,60,60,49,48},52))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({26,28,15,63},52)) end)
if ok then return folder end
debug(_d({51,49,64,26,28,15,63,18,59,56,48,49,62,236,49,62,62,59,62,6},52), folder)
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
local r = model:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local h = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
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
debug(_d({51,49,64,26,49,45,62,49,63,64,26,28,15,236,49,62,62,59,62,6},52), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum  = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({51,49,64,26,28,15,14,69,26,45,57,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({58,60,47,63,30,49,57,45,53,58,53,58,51,236,49,62,62,59,62,6},52), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({15,65,60,53,48,236,29,65,49,49,58},52))
return queen ~= nil and queen:FindFirstChild(_d({57,59,64,53,59,58,24,49,63,63},52)) ~= nil
end)
if ok then return result end
debug(_d({53,63,29,65,49,49,58,28,52,45,63,49,254,236,49,62,62,59,62,6},52), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,253,254,253,254,5,3,5,0,254,254,5,254,3,2,5},52)
local QUEEN_GRASP_ANIM_ID   = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,253,254,5,4,252,252,252,2,253,252,252,253,3,255,0},52)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
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
debug(_d({53,63,28,56,45,69,53,58,51,13,58,53,57,18,62,59,57,24,53,63,64,236,49,62,62,59,62,6},52), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({14,56,59,47,55,53,58,51},52)) ~= nil
end)
if ok then return result end
debug(_d({53,63,26,28,15,14,56,59,47,55,53,58,51,236,49,62,62,59,62,6},52), result)
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
debug(_d({60,62,49,48,53,47,64,26,28,15,28,59,63,53,64,53,59,58,236,49,62,62,59,62,6},52), result)
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
debug(_d({26,59,236,48,45,57,45,51,49,236,59,58},52), model.Name, _d({50,59,62},52), NPC_STUCK_TIMEOUT, _d({63,236,249,236,63,67,53,64,47,52,53,58,51,236,64,45,62,51,49,64},52))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({64,62,45,47,55,26,28,15,16,45,57,45,51,49,236,49,62,62,59,62,6},52), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({25,59,48,49,56},52)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({14,45,63,49,28,45,62,64},52)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({51,49,64,25,59,48,49,56,18,45,47,49,28,59,63,236,49,62,62,59,62,6},52), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({17,58,66},52))
local folder = env and env:FindFirstChild(_d({31,64,45,64,65,49,63},52))
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
debug(_d({51,49,64,31,64,45,64,65,49,25,59,48,49,56,26,49,45,62,236,49,62,62,59,62,6},52), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({46,45,62,62,49,56,20,28},52))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({51,49,64,31,64,45,64,65,49,20,28,236,49,62,62,59,62,6},52), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({50,53,58,48,32,59,59,56,14,69,13,64,64,62,53,46,65,64,49,236,49,62,62,59,62,6},52), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({32,59,59,56},52)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({50,53,58,48,32,59,59,56,14,69,26,45,57,49,236,49,62,62,59,62,6},52), tool)
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
if not ok then debug(_d({49,61,65,53,60,32,59,59,56,236,49,62,62,59,62,6},52), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({50,53,58,48,32,59,59,56,14,69,15,52,53,56,48,26,45,57,49,236,49,62,62,59,62,6},52), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({31,67,59,62,48,17,61,65,53,60},52))
if sword then
equipTool(sword)
return _d({63,67,59,62,48},52)
end
local melee = findToolByAttribute(_d({25,49,56,49,49,32,59,59,56},52))
if melee then
equipTool(melee)
return _d({57,49,56,49,49},52)
end
debug(_d({26,59,236,63,67,59,62,48,236,59,62,236,57,49,56,49,49,236,64,59,59,56,236,50,59,65,58,48},52))
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
if not ok then debug(_d({47,56,53,47,55,25,253,236,49,62,62,59,62,6},52), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({30,59,55,65,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,49,60,60,59},52), args)
elseif style == _d({14,56,45,47,55,24,49,51},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55},52), args)
elseif style == _d({23,45,57,53,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,45,57,53,63,52,53,55,53,19,49,60,60,59},52), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55,254},52), args)
end
end)
if not ok then debug(_d({53,58,66,59,55,49,19,49,60,60,59,236,49,62,62,59,62,6},52), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({60,62,49,63,63,31,55,53,56,56,30,236,49,62,62,59,62,6},52), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({52,59,56,48,14,56,59,47,55,236,49,62,62,59,62,6},52), err) end
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
if not ok then debug(_d({52,59,56,48,14,56,59,47,55,35,52,53,56,49,236,49,62,62,59,62,6},52), err) end
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
debug(_d({51,49,64,19,45,57,49,19,236,49,62,62,59,62,6},52), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({53,63,30,49,45,56,25,253,14,65,63,69,236,49,62,62,59,62,6},52), result)
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
return char ~= nil and char:FindFirstChild(_d({63,64,65,58},52)) ~= nil
end)
if ok then return result end
debug(_d({53,63,31,64,65,58,58,49,48,236,49,62,62,59,62,6},52), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({60,62,49,63,63,31,64,65,58,14,62,49,45,55,236,49,62,62,59,62,6},52), err) end
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
debug(_d({61,65,49,49,58,16,59,48,51,49,33,58,64,53,56,31,45,50,49,6,236,29,65,49,49,58,236,51,59,58,49,236,249,236,49,58,48,53,58,51,236,48,59,48,51,49,236,49,45,62,56,69},52))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({61,65,49,49,58,16,59,48,51,49,33,58,64,53,56,31,45,50,49,236,63,45,50,49,64,69,236,64,53,57,49,59,65,64},52))
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
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({29,65,49,49,58,236,47,45,63,64,53,58,51,236,48,49,64,49,47,64,49,48,236,249,236,48,59,48,51,53,58,51,236,244,67,45,64,47,52,49,62,245},52))
queenDodgeUntilSafe(function() return getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52)) end)
if enabled and getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52)) then
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
end
queenDodging = false
end
end)
if not ok then debug(_d({61,65,49,49,58,16,59,48,51,49,35,45,64,47,52,49,62,236,49,62,62,59,62,6},52), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({60,59,53,58,64},52) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({58,60,47},52) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({58,45,57,49,48},52) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({51,49,64,26,45,66,32,45,62,51,49,64,63,236,49,62,62,59,62,6},52), aimR)
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
debug(_d({47,59,57,60,65,64,49,24,59,47,55,49,48,15,18,62,45,57,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({60,59,53,58,64},52), point = pos}
phase = _d({57,59,66,49},52)
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
if not ok then debug(_d({58,45,66,32,59,28,59,53,58,64,236,51,49,60,60,59,236,47,52,49,47,55,236,49,62,62,59,62,6},52), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({58,60,47},52)}
phase = _d({57,59,66,49},52)
end
function setNavNamed(name)
NavState = {mode = _d({58,45,57,49,48},52), name = name}
phase = _d({57,59,66,49},52)
end
local function setNavIdle()
NavState = {mode = _d({53,48,56,49},52)}
phase = _d({57,59,66,49},52)
end
local function hasArrived()
return phase == _d({52,59,66,49,62},52)
end
local function startNav()
phase = _d({57,59,66,49},52)
debug(_d({26,45,66,236,56,59,59,60,236,27,26},52))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({28,56,45,69,49,62,236,48,53,49,48,237,236,31,64,59,60,60,53,58,51,236,46,59,64,250},52))
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
debug(_d({28,56,45,69,49,62,236,53,63,236,64,59,59,236,50,45,62,236,50,62,59,57,236,64,45,62,51,49,64,236,244,10,254,252,252,252,236,63,64,65,48,63,245,250,236,24,53,55,49,56,69,236,62,49,63,60,45,67,58,49,48,236,45,64,236,56,59,46,46,69,250,236,31,64,59,60,60,53,58,51,236,46,59,64,250},52))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({43,43,60,62,49,66,28,59,63},52))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({24,45,62,51,49,236,60,59,63,53,64,53,59,58,236,54,65,57,60,236,48,49,64,49,47,64,49,48,6},52), delta, _d({63,64,65,48,63,250,236,60,62,49,66,28,59,63,9},52), prevPos, _d({58,49,67,28,59,63,9},52), pos)
end
end
force:SetAttribute(_d({43,43,60,62,49,66,28,59,63},52), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({57,59,66,49},52) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({52,59,66,49,62},52)
debug(_d({28,52,45,63,49,6,236,52,59,66,49,62},52))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({237,237,237,236,30,17,18,33,31,21,26,19,236,32,27,236,13,28,28,24,37,236,13,14,26,27,30,25,13,24,236,34,17,24,27,15,21,32,37,6},52), finalVel, _d({45,53,57,9},52), aim, _d({60,59,63,9},52), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({52,59,66,49,62},52) then
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
debug(_d({15,59,57,46,45,64,236,56,59,47,55,236,63,55,53,60,60,49,48,248},52), snapDist, _d({63,64,65,48,63,236,50,62,59,57,236,64,45,62,51,49,64,236,174,76,96,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,57,59,66,49},52))
phase = _d({57,59,66,49},52)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({20,49,45,62,64,46,49,45,64,236,49,62,62,59,62,6},52), err) end
end)
end
local function stopNav()
debug(_d({26,45,66,236,56,59,59,60,236,27,18,18},52))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({57,59,66,49},52)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({32,49,68,64,15,52,45,64,31,49,62,66,53,47,49},52))
local channels = TextChatService:FindFirstChild(_d({32,49,68,64,15,52,45,58,58,49,56,63},52))
local channel = channels and channels:FindFirstChild(_d({30,14,36,19,49,58,49,62,45,56},52))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({16,49,50,45,65,56,64,15,52,45,64,31,69,63,64,49,57,15,52,45,64,17,66,49,58,64,63},52))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({31,45,69,25,49,63,63,45,51,49,30,49,61,65,49,63,64},52))
if sayEvent then
sayEvent:FireServer(message, _d({13,56,56},52))
return
end
debug(_d({63,49,58,48,15,52,45,64,25,49,63,63,45,51,49,6,236,58,59,236,32,49,68,64,15,52,45,64,31,49,62,66,53,47,49,250,30,14,36,19,49,58,49,62,45,56,236,59,62,236,56,49,51,45,47,69,236,31,45,69,25,49,63,63,45,51,49,30,49,61,65,49,63,64,236,50,59,65,58,48,236,50,59,62},52), message)
end)
if not ok then debug(_d({63,49,58,48,15,52,45,64,25,49,63,63,45,51,49,236,49,62,62,59,62,6},52), err) end
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
debug(_d({26,59,64,236,57,45,55,53,58,51,236,60,62,59,51,62,49,63,63,236,64,59,67,45,62,48,236,58,45,66,236,64,45,62,51,49,64,236,50,59,62},52), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({63,236,249,236,63,49,58,48,53,58,51,236,251,65,58,63,64,65,47,55},52))
sendChatMessage(_d({251,65,58,63,64,65,47,55},52))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({67,45,53,64,33,58,64,53,56,13,62,62,53,66,49,48,236,64,53,57,49,59,65,64},52))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({58,45,66,32,59,28,59,53,58,64,15,59,58,50,53,62,57,49,48,6},52), label or _d({64,45,62,51,49,64},52), _d({249,236,48,53,48,236,58,59,64,236,45,62,62,53,66,49,236,67,53,64,52,53,58},52), timeout, _d({63,248,236,62,49,64,62,69,53,58,51,236,59,58,47,49},52))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({58,45,66,32,59,28,59,53,58,64,15,59,58,50,53,62,57,49,48,6},52), label or _d({64,45,62,51,49,64},52), _d({249,236,63,64,53,56,56,236,58,59,64,236,45,62,62,53,66,49,48,236,45,50,64,49,62,236,62,49,64,62,69,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
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
if not ok then debug(_d({58,45,66,32,59,28,59,53,58,64,20,59,56,48,53,58,51,14,56,59,47,55,236,55,49,69,249,48,59,67,58,236,49,62,62,59,62,6},52), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({58,45,66,32,59,28,59,53,58,64,20,59,56,48,53,58,51,14,56,59,47,55,236,55,49,69,249,65,60,236,49,62,62,59,62,6},52), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({35,45,56,55,53,58,51,236,64,59,6},52), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({67,45,56,55,32,59,28,59,53,58,64,236,35,236,48,59,67,58,236,49,62,62,59,62,6},52), err) end
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
debug(_d({32,59,59,55,236,48,45,57,45,51,49,236,67,52,53,56,49,236,67,45,56,55,53,58,51,236,64,59,236,60,59,53,58,64,237,236,31,64,59,60,60,53,58,51,236,67,45,56,55,236,64,59,236,49,58,51,45,51,49,250},52))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({13,62,62,53,66,49,48,236,45,64,6},52), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({31,64,65,47,55,236,48,65,62,53,58,51,236,67,45,56,55,248,236,54,65,57,60,53,58,51,237},52))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({31,64,53,56,56,236,63,64,65,47,55,248,236,64,62,53,51,51,49,62,53,58,51,236,19,49,60,60,59,237},52))
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
debug(_d({25,59,66,53,58,51,236,64,59},52), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,26,28,15,63,236,64,59,236,63,60,45,67,58,236,45,64},52), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({236,236,63,60,45,67,58,236,47,52,49,47,55,6,236,50,59,56,48,49,62,236,49,68,53,63,64,63,236,9},52), folder ~= nil,
_d({248,236,47,52,53,56,48,62,49,58,236,9},52), folder and #folder:GetChildren() or 0,
_d({248,236,45,56,53,66,49,236,9},52), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({26,59,236,26,28,15,63,236,45,60,60,49,45,62,49,48,236,45,64},52), stageName, _d({45,50,64,49,62,236,253,1,63,248,236,57,59,66,53,58,51,236,59,58,236,45,58,69,67,45,69},52))
break
end
end
debug(_d({23,53,56,56,53,58,51,236,26,28,15,63,236,45,64},52), stageName)
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
debug(_d({30,49,64,65,62,58,53,58,51,236,64,59},52), stageName, _d({60,59,63,53,64,53,59,58,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,59,58},52))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64},52), stageName, _d({60,59,63,53,64,53,59,58},52))
task.wait(5)
debug(_d({35,45,53,64,53,58,51,236,50,59,62},52), targetHP * 100, _d({241,236,20,28,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,64,59,236,58,49,68,64,236,63,64,45,51,49},52))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({47,56,49,45,62,49,48},52))
end
local function killNamedNPC(name, targetPos)
debug(_d({25,59,66,53,58,51,236,64,59},52), name)
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
debug(name, _d({48,49,50,49,45,64,49,48},52))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({24,49,59,236,60,56,45,69,49,48,236,45,58,53,57,45,64,53,59,58,6},52), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({56,49,59,13,58,53,57,24,59,51,51,49,62,236,60,62,53,58,64,236,49,62,62,59,62,6},52), err2) end
end)
end)
if not ok then debug(_d({63,64,45,62,64,24,49,59,13,58,53,57,24,59,51,51,49,62,236,49,62,62,59,62,6},52), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({25,59,66,53,58,51,236,64,59,236,24,49,59},52))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({24,49,59},52))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({24,49,59},52))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({24,49,59},52))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({24,49,59,236,47,45,63,64,53,58,51},52), which, _d({249,236,48,59,48,51,53,58,51},52))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({24,49,59,236,63,64,45,62,64,49,48,236,46,56,59,47,55,249,46,62,49,45,55,49,62,236,57,53,48,249,46,56,59,47,55,237,236,17,66,45,48,53,58,51,250,250,250},52))
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
if not getNPCByName(_d({24,49,59},52)) then
debug(_d({24,49,59,236,51,59,58,49,236,57,53,48,249,48,59,48,51,49,236,249,236,49,58,48,53,58,51,236,17,58,64,49,53,236,52,59,56,48,236,49,45,62,56,69},52))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({24,49,59},52)) then
setNavNamed(_d({24,49,59},52))
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
debug(_d({24,49,59,236,48,49,50,49,45,64,49,48},52))
stopLeoAnimLogger()
debug(_d({30,49,64,65,62,58,53,58,51,236,64,59,236,24,49,59,236,60,59,63,53,64,53,59,58,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,59,58},52))
navToPointConfirmed(COORDS.Leo, 30, _d({24,49,59,236,60,59,63,53,64,53,59,58},52))
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64,236,24,49,59,236,60,59,63,53,64,53,59,58},52))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({25,59,66,53,58,51,236,64,59},52), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,63,64,45,64,65,49,236,57,59,48,49,56,236,58,49,45,62},52), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({13,64,64,45,47,55,53,58,51},52), coordKey, _d({67,53,64,52},52), weapon or _d({58,59,64,52,53,58,51,236,50,59,65,58,48},52))
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
debug(coordKey, _d({46,45,62,62,49,56,236,48,49,63,64,62,59,69,49,48},52))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({249,236,47,59,65,56,48,236,58,59,64,236,50,53,58,48,236,63,64,45,64,65,49,236,57,59,48,49,56,248,236,63,55,53,60,60,53,58,51},52))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({63,64,53,56,56,236,45,56,53,66,49,236,244,20,28},52), hp, _d({245,236,249,236,62,49,249,48,49,63,64,62,59,69,53,58,51},52))
destroyStatue(coordKey)
else
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({47,59,58,50,53,62,57,49,48,236,48,49,63,64,62,59,69,49,48},52))
end
end)
if not ok then debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,236,49,62,62,59,62,6},52), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({25,59,66,53,58,51,236,64,59,236,29,65,49,49,58},52))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
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
debug(_d({29,65,49,49,58,236,49,58,64,49,62,49,48,236,60,52,45,63,49,236,254},52))
end
local function finishQueen()
debug(_d({18,53,58,53,63,52,53,58,51,236,29,65,49,49,58},52))
equipSwordOrMelee()
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
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
debug(_d({29,65,49,49,58,236,48,49,50,49,45,64,49,48,250,236,28,56,45,58,236,47,59,57,60,56,49,64,49,250},52))
end
local CONFIRMATION_PROMPT_NAME = _d({15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64},52)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({30,49,57,59,64,49,17,66,49,58,64},52), 5)
end)
if ok then return result end
debug(_d({51,49,64,30,49,60,56,45,69,30,49,57,59,64,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({28,56,45,69,49,62,19,65,53},52))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({21,57,45,51,49,14,65,64,64,59,58},52)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({46,65,64,64,59,58,34,45,56,65,49},52)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({50,53,58,48,14,65,64,64,59,58,14,69,34,45,56,65,49,236,49,62,62,59,62,6},52), result)
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
if not ok then debug(_d({47,56,53,47,55,19,65,53,14,65,64,64,59,58,236,49,62,62,59,62,6},52), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({53,63,31,49,62,66,49,62},52))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({30,49,57,59,64,49,17,66,49,58,64},52))
or inst:FindFirstChild(_d({47,56,53,49,58,64,17,66,49,58,64},52))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({50,53,58,48,13,58,63,67,49,62,15,59,58,58,49,47,64,59,62,236,49,62,62,59,62,6},52), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({15,59,65,56,48,236,58,59,64,236,56,59,47,45,64,49,236,30,49,57,59,64,49,17,66,49,58,64,251,47,56,53,49,58,64,17,66,49,58,64,236,58,49,45,62,236,30,49,60,56,45,69,236,46,65,64,64,59,58,248,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,47,56,53,47,55},52))
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
debug(_d({50,53,62,49,30,49,60,56,45,69,34,45,56,65,49,236,49,62,62,59,62,6},52), err, _d({249,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,47,56,53,47,55},52))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({18,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,46,65,64,64,59,58,34,45,56,65,49,236,63,49,45,62,47,52,236,50,59,62,236,30,49,60,56,45,69},52))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({30,49,60,56,45,69,236,46,65,64,64,59,58,236,58,59,64,236,50,59,65,58,48,236,49,53,64,52,49,62,248,236,51,53,66,53,58,51,236,65,60},52))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,250,30,49,57,59,64,49,17,66,49,58,64},52))
local remote = getReplayRemote()
if not remote then
debug(_d({15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,251,30,49,57,59,64,49,17,66,49,58,64,236,58,59,64,236,50,59,65,58,48,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64},52))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({18,53,62,53,58,51,236,30,49,60,56,45,69,236,66,53,45,236,15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,250,30,49,57,59,64,49,17,66,49,58,64},52))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({18,53,62,49,31,49,62,66,49,62,236,49,62,62,59,62,6},52), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52), 10)
if not playerGui then
debug(_d({67,45,53,64,18,59,62,27,46,54,49,47,64,53,66,49,63,19,65,53,6,236,58,59,236,28,56,45,69,49,62,19,65,53,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({27,46,54,49,47,64,53,66,49,63,236,19,33,21,236,50,59,65,58,48,236,249,236,63,64,45,51,49,236,56,59,45,48,49,48},52))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({27,46,54,49,47,64,53,66,49,63,236,19,33,21,236,58,59,64,236,50,59,65,58,48,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
return
end
end
end)
if not ok then debug(_d({67,45,53,64,18,59,62,27,46,54,49,47,64,53,66,49,63,19,65,53,236,49,62,62,59,62,6},52), err) end
end
local function runPlan()
debug(_d({28,56,45,58,236,63,64,45,62,64,49,48},52))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({31,64,45,62,64,53,58,51,236,58,45,66,236,56,59,59,60},52))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({60,59,63,236,252,250,254,63,236,13,18,32,17,30,236,63,64,45,62,64,26,45,66,6},52), rootAfter and rootAfter.Position)
end)
debug(_d({35,45,53,64,53,58,51,236,1,63,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,64,59,236,31,64,45,51,49,253},52))
task.wait(5)
for _, stage in ipairs({_d({31,64,45,51,49,253},52), _d({31,64,45,51,49,254},52), _d({31,64,45,51,49,255},52), _d({31,64,45,51,49,255,14},52)}) do
if not enabled then return end
local hpTarget = (stage == _d({31,64,45,51,49,255,14},52)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({25,59,66,53,58,51,236,64,59,236,45,62,62,59,67,236,50,56,69,249,48,59,67,58,236,45,62,49,45,236,244,15,65,60,53,48,236,30,45,53,58,245},52))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({16,59,48,51,53,58,51,236,45,62,62,59,67,236,62,45,53,58,236,53,58,236,45,236,63,61,65,45,62,49},52))
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
clearStage(_d({31,64,45,51,49,0},52))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({29,65,49,49,58,236,53,58,236,60,52,45,63,49,236,254,236,249,236,55,49,49,60,53,58,51,236,23,49,58,236,20,45,55,53,236,45,47,64,53,66,49,236,50,62,59,57,236,52,49,62,49,236,59,58},52))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({31,64,45,64,65,49,253},52))
if not enabled then return end
recheckStatue(_d({31,64,45,64,65,49,253},52))
destroyStatue(_d({31,64,45,64,65,49,254},52))
if not enabled then return end
recheckStatue(_d({31,64,45,64,65,49,253},52))
recheckStatue(_d({31,64,45,64,65,49,254},52))
destroyStatue(_d({31,64,45,64,65,49,255},52))
if not enabled then return end
recheckStatue(_d({31,64,45,64,65,49,255},52))
recheckStatue(_d({31,64,45,64,65,49,254},52))
recheckStatue(_d({31,64,45,64,65,49,253},52))
if not enabled then return end
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,60,52,45,63,49,236,254,236,64,59,236,49,58,48},52))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({28,52,45,63,49,236,254,236,49,58,48,236,67,45,53,64,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({25,59,66,53,58,51,236,46,45,47,55,236,64,59,236,29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
navToPointConfirmed(COORDS.Queen, 30, _d({29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64,236,29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
task.wait(5)
if not enabled then return end
debug(_d({25,59,66,53,58,51,236,64,59,236,60,59,63,64,249,29,65,49,49,58,236,60,59,63,53,64,53,59,58},52))
navToPointConfirmed(COORDS.PostQueen, 30, _d({60,59,63,64,249,29,65,49,49,58,236,60,59,63,53,64,53,59,58},52))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({17,58,45,46,56,53,58,51,248,236,60,59,63,236,14,17,18,27,30,17,236,60,56,45,58,6},52), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({28,56,45,58,236,49,62,62,59,62,6},52), err2) end
end)
debug(_d({17,58,45,46,56,49,48,6},52), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({17,58,45,46,56,49,48,6},52), enabled)
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
if not ok then debug(_d({21,58,60,65,64,14,49,51,45,58,236,49,62,62,59,62,6},52), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({19,45,57,49,236,56,59,45,48,49,48,248,236,45,65,64,59,249,63,64,45,62,64,53,58,51,236,64,52,49,236,60,56,45,58},52))
enableBot()
end)
if not ok then debug(_d({13,65,64,59,63,64,45,62,64,236,49,62,62,59,62,6},52), err) end
end)
debug(_d({24,59,45,48,49,48,236,174,76,96,236,45,65,64,59,249,63,64,45,62,64,53,58,51,236,59,58,47,49,236,64,52,49,236,51,45,57,49,236,50,53,58,53,63,52,49,63,236,56,59,45,48,53,58,51,236,244,60,62,49,63,63,236,28,236,64,59,236,64,59,51,51,56,49,236,57,45,58,65,45,56,56,69,245},52))
end)()