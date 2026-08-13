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
local Players            = game:GetService(_d({37,65,54,78,58,71,72},43))
local UserInputService    = game:GetService(_d({42,72,58,71,30,67,69,74,73,40,58,71,75,62,56,58},43))
local RunService          = game:GetService(_d({39,74,67,40,58,71,75,62,56,58},43))
local VIM                 = game:GetService(_d({43,62,71,73,74,54,65,30,67,69,74,73,34,54,67,54,60,58,71},43))
local ReplicatedStorage    = game:GetService(_d({39,58,69,65,62,56,54,73,58,57,40,73,68,71,54,60,58},43))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({48,23,68,72,72,23,68,73,50},43), _d({44,71,68,67,60,245,60,54,66,58,245,183,85,105,245,37,65,54,56,58,30,57,15},43), game.PlaceId, _d({42,67,62,75,58,71,72,58,30,57,15},43), game.GameId, _d({2,245,67,68,73,245,71,74,67,67,62,67,60},43))
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
local LEO_PILLAR_ANIM_ID   = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,9,9,6,9,6,8,7,12},43)
local LEO_ENTEI_ANIM_ID    = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,9,9,6,8,13,7,12,13},43)
local LEO_HIKEN_ANIM_ID    = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,7,5,14,6,12,9,5,12},43)
local LEO_FIREFLY_ANIM_ID  = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,10,7,7,5,7,8,11,6,10,9},43)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({36,55,63,58,56,73,62,75,58,72},43)
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
local REPLAY_BUTTON_VALUE   = _d({39,58,69,65,54,78},43)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({66,68,75,58},43)
local NavState   = {mode = _d({62,57,65,58},43)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({48,23,68,72,72,23,68,73,50},43), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
end)
if ok then return root end
debug(_d({60,58,73,39,68,68,73,245,58,71,71,68,71,15},43), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
end)
if ok then return hum end
debug(_d({60,58,73,29,74,66,54,67,68,62,57,245,58,71,71,68,71,15},43), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({52,52,29,68,75,58,71,22,73,73},43)) or Instance.new(_d({22,73,73,54,56,61,66,58,67,73},43))
att.Name = _d({52,52,29,68,75,58,71,22,73,73},43)
att.Parent = root
local force = root:FindFirstChild(_d({52,52,29,68,75,58,71,27,68,71,56,58},43))
if not force then
force = Instance.new(_d({33,62,67,58,54,71,43,58,65,68,56,62,73,78},43))
force.Name = _d({52,52,29,68,75,58,71,27,68,71,56,58},43)
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
debug(_d({60,58,73,36,71,24,71,58,54,73,58,27,68,71,56,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local force = root:FindFirstChild(_d({52,52,29,68,75,58,71,27,68,71,56,58},43))
local att   = root:FindFirstChild(_d({52,52,29,68,75,58,71,22,73,73},43))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({56,65,58,54,67,74,69,27,68,71,56,58,245,58,71,71,68,71,15},43), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({23,74,72,68,34,58,65,58,58},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,23,74,72,68,22,56,73,62,75,58,245,58,71,71,68,71,15},43), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({23,74,72,68},43))
end)
if not ok then debug(_d({54,56,73,62,75,54,73,58,23,74,72,68,245,58,71,71,68,71,15},43), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({23,74,72,68,245,67,68,73,245,54,56,73,62,75,58,1,245,54,56,73,62,75,54,73,62,67,60},43))
activateBuso()
end
end)
if not ok then debug(_d({23,74,72,68,32,58,58,69,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({23,74,72,68,245,64,58,58,69,58,71,245,72,73,68,69,69,58,57},43))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({32,58,67,29,54,64,62},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,32,58,67,22,56,73,62,75,58,245,58,71,71,68,71,15},43), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({32,58,67},43), true)
end)
if not ok then debug(_d({54,56,73,62,75,54,73,58,32,58,67,245,58,71,71,68,71,15},43), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({32,58,67,245,67,68,73,245,54,56,73,62,75,58,1,245,54,56,73,62,75,54,73,62,67,60},43))
activateKen()
end
end)
if not ok then debug(_d({32,58,67,32,58,58,69,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({32,58,67,245,64,58,58,69,58,71,245,72,73,68,69,69,58,57},43))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({35,37,24,72},43)) end)
if ok then return folder end
debug(_d({60,58,73,35,37,24,72,27,68,65,57,58,71,245,58,71,71,68,71,15},43), folder)
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
local r = model:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local h = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
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
debug(_d({60,58,73,35,58,54,71,58,72,73,35,37,24,245,58,71,71,68,71,15},43), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
local hum  = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({60,58,73,35,37,24,23,78,35,54,66,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({67,69,56,72,39,58,66,54,62,67,62,67,60,245,58,71,71,68,71,15},43), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({24,74,69,62,57,245,38,74,58,58,67},43))
return queen ~= nil and queen:FindFirstChild(_d({66,68,73,62,68,67,33,58,72,72},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,38,74,58,58,67,37,61,54,72,58,7,245,58,71,71,68,71,15},43), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,6,7,6,7,14,12,14,9,7,7,14,7,12,11,14},43)
local QUEEN_GRASP_ANIM_ID   = _d({71,55,77,54,72,72,58,73,62,57,15,4,4,6,7,14,13,5,5,5,11,6,5,5,6,12,8,9},43)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
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
debug(_d({62,72,37,65,54,78,62,67,60,22,67,62,66,27,71,68,66,33,62,72,73,245,58,71,71,68,71,15},43), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({23,65,68,56,64,62,67,60},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,35,37,24,23,65,68,56,64,62,67,60,245,58,71,71,68,71,15},43), result)
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
debug(_d({69,71,58,57,62,56,73,35,37,24,37,68,72,62,73,62,68,67,245,58,71,71,68,71,15},43), result)
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
debug(_d({35,68,245,57,54,66,54,60,58,245,68,67},43), model.Name, _d({59,68,71},43), NPC_STUCK_TIMEOUT, _d({72,245,2,245,72,76,62,73,56,61,62,67,60,245,73,54,71,60,58,73},43))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({73,71,54,56,64,35,37,24,25,54,66,54,60,58,245,58,71,71,68,71,15},43), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({34,68,57,58,65},43)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({23,54,72,58,37,54,71,73},43)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({60,58,73,34,68,57,58,65,27,54,56,58,37,68,72,245,58,71,71,68,71,15},43), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({26,67,75},43))
local folder = env and env:FindFirstChild(_d({40,73,54,73,74,58,72},43))
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
debug(_d({60,58,73,40,73,54,73,74,58,34,68,57,58,65,35,58,54,71,245,58,71,71,68,71,15},43), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({55,54,71,71,58,65,29,37},43))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({60,58,73,40,73,54,73,74,58,29,37,245,58,71,71,68,71,15},43), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({41,68,68,65},43)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,22,73,73,71,62,55,74,73,58,245,58,71,71,68,71,15},43), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({41,68,68,65},43)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,35,54,66,58,245,58,71,71,68,71,15},43), tool)
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
if not ok then debug(_d({58,70,74,62,69,41,68,68,65,245,58,71,71,68,71,15},43), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({23,54,56,64,69,54,56,64},43))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({41,68,68,65},43)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({59,62,67,57,41,68,68,65,23,78,24,61,62,65,57,35,54,66,58,245,58,71,71,68,71,15},43), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({40,76,68,71,57,26,70,74,62,69},43))
if sword then
equipTool(sword)
return _d({72,76,68,71,57},43)
end
local melee = findToolByAttribute(_d({34,58,65,58,58,41,68,68,65},43))
if melee then
equipTool(melee)
return _d({66,58,65,58,58},43)
end
debug(_d({35,68,245,72,76,68,71,57,245,68,71,245,66,58,65,58,58,245,73,68,68,65,245,59,68,74,67,57},43))
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
if not ok then debug(_d({56,65,62,56,64,34,6,245,58,71,71,68,71,15},43), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({29,74,66,54,67,68,62,57,39,68,68,73,37,54,71,73},43))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({40,73,54,73,72},43) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({39,68,64,74,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({28,58,69,69,68},43), args)
elseif style == _d({23,65,54,56,64,33,58,60},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64},43), args)
elseif style == _d({32,54,66,62,72,61,62,64,62},43) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({32,54,66,62,72,61,62,64,62,28,58,69,69,68},43), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({40,64,78,245,44,54,65,64,7},43), args)
end
end)
if not ok then debug(_d({62,67,75,68,64,58,28,58,69,69,68,245,58,71,71,68,71,15},43), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({69,71,58,72,72,40,64,62,65,65,39,245,58,71,71,68,71,15},43), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({61,68,65,57,23,65,68,56,64,245,58,71,71,68,71,15},43), err) end
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
if not ok then debug(_d({61,68,65,57,23,65,68,56,64,44,61,62,65,58,245,58,71,71,68,71,15},43), err) end
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
debug(_d({60,58,73,28,54,66,58,28,245,58,71,71,68,71,15},43), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({62,72,39,58,54,65,34,6,23,74,72,78,245,58,71,71,68,71,15},43), result)
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
return char ~= nil and char:FindFirstChild(_d({72,73,74,67},43)) ~= nil
end)
if ok then return result end
debug(_d({62,72,40,73,74,67,67,58,57,245,58,71,71,68,71,15},43), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({69,71,58,72,72,40,73,74,67,23,71,58,54,64,245,58,71,71,68,71,15},43), err) end
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
debug(_d({70,74,58,58,67,25,68,57,60,58,42,67,73,62,65,40,54,59,58,15,245,38,74,58,58,67,245,60,68,67,58,245,2,245,58,67,57,62,67,60,245,57,68,57,60,58,245,58,54,71,65,78},43))
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
debug(_d({70,74,58,58,67,25,68,57,60,58,42,67,73,62,65,40,54,59,58,245,72,54,59,58,73,78,245,73,62,66,58,68,74,73},43))
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
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({38,74,58,58,67,245,56,54,72,73,62,67,60,245,57,58,73,58,56,73,58,57,245,2,245,57,68,57,60,62,67,60,245,253,76,54,73,56,61,58,71,254},43))
queenDodgeUntilSafe(function() return getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) end)
if enabled and getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) then
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
end
queenDodging = false
end
end)
if not ok then debug(_d({70,74,58,58,67,25,68,57,60,58,44,54,73,56,61,58,71,245,58,71,71,68,71,15},43), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({69,68,62,67,73},43) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({67,69,56},43) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({67,54,66,58,57},43) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({60,58,73,35,54,75,41,54,71,60,58,73,72,245,58,71,71,68,71,15},43), aimR)
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
debug(_d({56,68,66,69,74,73,58,33,68,56,64,58,57,24,27,71,54,66,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({69,68,62,67,73},43), point = pos}
phase = _d({66,68,75,58},43)
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
if not ok then debug(_d({67,54,75,41,68,37,68,62,67,73,245,60,58,69,69,68,245,56,61,58,56,64,245,58,71,71,68,71,15},43), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({67,69,56},43)}
phase = _d({66,68,75,58},43)
end
function setNavNamed(name)
NavState = {mode = _d({67,54,66,58,57},43), name = name}
phase = _d({66,68,75,58},43)
end
local function setNavIdle()
NavState = {mode = _d({62,57,65,58},43)}
phase = _d({66,68,75,58},43)
end
local function hasArrived()
return phase == _d({61,68,75,58,71},43)
end
local function startNav()
phase = _d({66,68,75,58},43)
debug(_d({35,54,75,245,65,68,68,69,245,36,35},43))
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
local prevPos = force:GetAttribute(_d({52,52,69,71,58,75,37,68,72},43))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({33,54,71,60,58,245,69,68,72,62,73,62,68,67,245,63,74,66,69,245,57,58,73,58,56,73,58,57,15},43), delta, _d({72,73,74,57,72,3,245,69,71,58,75,37,68,72,18},43), prevPos, _d({67,58,76,37,68,72,18},43), pos)
end
end
force:SetAttribute(_d({52,52,69,71,58,75,37,68,72},43), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({66,68,75,58},43) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({61,68,75,58,71},43)
debug(_d({37,61,54,72,58,15,245,61,68,75,58,71},43))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({246,246,246,245,39,26,27,42,40,30,35,28,245,41,36,245,22,37,37,33,46,245,22,23,35,36,39,34,22,33,245,43,26,33,36,24,30,41,46,15},43), finalVel, _d({54,62,66,18},43), aim, _d({69,68,72,18},43), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({61,68,75,58,71},43) then
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
debug(_d({24,68,66,55,54,73,245,65,68,56,64,245,72,64,62,69,69,58,57,1},43), snapDist, _d({72,73,74,57,72,245,59,71,68,66,245,73,54,71,60,58,73,245,183,85,105,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,66,68,75,58},43))
phase = _d({66,68,75,58},43)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({29,58,54,71,73,55,58,54,73,245,58,71,71,68,71,15},43), err) end
end)
end
local function stopNav()
debug(_d({35,54,75,245,65,68,68,69,245,36,27,27},43))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({66,68,75,58},43)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({41,58,77,73,24,61,54,73,40,58,71,75,62,56,58},43))
local channels = TextChatService:FindFirstChild(_d({41,58,77,73,24,61,54,67,67,58,65,72},43))
local channel = channels and channels:FindFirstChild(_d({39,23,45,28,58,67,58,71,54,65},43))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({25,58,59,54,74,65,73,24,61,54,73,40,78,72,73,58,66,24,61,54,73,26,75,58,67,73,72},43))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({40,54,78,34,58,72,72,54,60,58,39,58,70,74,58,72,73},43))
if sayEvent then
sayEvent:FireServer(message, _d({22,65,65},43))
return
end
debug(_d({72,58,67,57,24,61,54,73,34,58,72,72,54,60,58,15,245,67,68,245,41,58,77,73,24,61,54,73,40,58,71,75,62,56,58,3,39,23,45,28,58,67,58,71,54,65,245,68,71,245,65,58,60,54,56,78,245,40,54,78,34,58,72,72,54,60,58,39,58,70,74,58,72,73,245,59,68,74,67,57,245,59,68,71},43), message)
end)
if not ok then debug(_d({72,58,67,57,24,61,54,73,34,58,72,72,54,60,58,245,58,71,71,68,71,15},43), err) end
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
debug(_d({35,68,73,245,66,54,64,62,67,60,245,69,71,68,60,71,58,72,72,245,73,68,76,54,71,57,245,67,54,75,245,73,54,71,60,58,73,245,59,68,71},43), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({72,245,2,245,72,58,67,57,62,67,60,245,4,74,67,72,73,74,56,64},43))
sendChatMessage(_d({4,74,67,72,73,74,56,64},43))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({76,54,62,73,42,67,73,62,65,22,71,71,62,75,58,57,245,73,62,66,58,68,74,73},43))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({67,54,75,41,68,37,68,62,67,73,24,68,67,59,62,71,66,58,57,15},43), label or _d({73,54,71,60,58,73},43), _d({2,245,57,62,57,245,67,68,73,245,54,71,71,62,75,58,245,76,62,73,61,62,67},43), timeout, _d({72,1,245,71,58,73,71,78,62,67,60,245,68,67,56,58},43))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({67,54,75,41,68,37,68,62,67,73,24,68,67,59,62,71,66,58,57,15},43), label or _d({73,54,71,60,58,73},43), _d({2,245,72,73,62,65,65,245,67,68,73,245,54,71,71,62,75,58,57,245,54,59,73,58,71,245,71,58,73,71,78,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
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
if not ok then debug(_d({67,54,75,41,68,37,68,62,67,73,29,68,65,57,62,67,60,23,65,68,56,64,245,64,58,78,2,57,68,76,67,245,58,71,71,68,71,15},43), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({67,54,75,41,68,37,68,62,67,73,29,68,65,57,62,67,60,23,65,68,56,64,245,64,58,78,2,74,69,245,58,71,71,68,71,15},43), err2) end
end
local function clearStage(stageName)
debug(_d({34,68,75,62,67,60,245,73,68},43), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,35,37,24,72,245,73,68,245,72,69,54,76,67,245,54,73},43), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({245,245,72,69,54,76,67,245,56,61,58,56,64,15,245,59,68,65,57,58,71,245,58,77,62,72,73,72,245,18},43), folder ~= nil,
_d({1,245,56,61,62,65,57,71,58,67,245,18},43), folder and #folder:GetChildren() or 0,
_d({1,245,54,65,62,75,58,245,18},43), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({35,68,245,35,37,24,72,245,54,69,69,58,54,71,58,57,245,54,73},43), stageName, _d({54,59,73,58,71,245,6,10,72,1,245,66,68,75,62,67,60,245,68,67,245,54,67,78,76,54,78},43))
break
end
end
debug(_d({32,62,65,65,62,67,60,245,35,37,24,72,245,54,73},43), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({39,58,73,74,71,67,62,67,60,245,73,68},43), stageName, _d({69,68,72,62,73,62,68,67,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,68,67},43))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73},43), stageName, _d({69,68,72,62,73,62,68,67},43))
task.wait(5)
debug(stageName, _d({56,65,58,54,71,58,57},43))
end
local function killNamedNPC(name, targetPos)
debug(_d({34,68,75,62,67,60,245,73,68},43), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({57,58,59,58,54,73,58,57},43))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({29,74,66,54,67,68,62,57},43))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({33,58,68,245,69,65,54,78,58,57,245,54,67,62,66,54,73,62,68,67,15},43), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({65,58,68,22,67,62,66,33,68,60,60,58,71,245,69,71,62,67,73,245,58,71,71,68,71,15},43), err2) end
end)
end)
if not ok then debug(_d({72,73,54,71,73,33,58,68,22,67,62,66,33,68,60,60,58,71,245,58,71,71,68,71,15},43), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({34,68,75,62,67,60,245,73,68,245,33,58,68,245,253,55,65,68,56,64,62,67,60,245,54,59,73,58,71},43), LEO_BLOCK_DELAY, _d({72,254},43))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({33,58,68},43))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({33,58,68},43))
while enabled do
local info = getNPCByName(_d({33,58,68},43))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({33,58,68,245,56,54,72,73,62,67,60},43), which, _d({2,245,57,68,57,60,62,67,60},43))
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
if not getNPCByName(_d({33,58,68},43)) then
debug(_d({33,58,68,245,60,68,67,58,245,66,62,57,2,57,68,57,60,58,245,2,245,58,67,57,62,67,60,245,26,67,73,58,62,245,61,68,65,57,245,58,54,71,65,78},43))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({33,58,68},43)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({33,58,68,245,60,68,67,58,245,66,62,57,2,57,68,57,60,58,245,2,245,58,67,57,62,67,60,245,27,65,54,66,58,245,37,62,65,65,54,71,245,61,68,65,57,245,58,54,71,65,78},43))
end
end
end
if enabled and getNPCByName(_d({33,58,68},43)) then
setNavNamed(_d({33,58,68},43))
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
debug(_d({33,58,68,245,57,58,59,58,54,73,58,57},43))
stopLeoAnimLogger()
debug(_d({39,58,73,74,71,67,62,67,60,245,73,68,245,33,58,68,245,69,68,72,62,73,62,68,67,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,68,67},43))
navToPointConfirmed(COORDS.Leo, 30, _d({33,58,68,245,69,68,72,62,73,62,68,67},43))
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73,245,33,58,68,245,69,68,72,62,73,62,68,67},43))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({34,68,75,62,67,60,245,73,68},43), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({24,68,74,65,57,245,67,68,73,245,59,62,67,57,245,72,73,54,73,74,58,245,66,68,57,58,65,245,67,58,54,71},43), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({22,73,73,54,56,64,62,67,60},43), coordKey, _d({76,62,73,61},43), weapon or _d({67,68,73,61,62,67,60,245,59,68,74,67,57},43))
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
debug(coordKey, _d({55,54,71,71,58,65,245,57,58,72,73,71,68,78,58,57},43))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({2,245,56,68,74,65,57,245,67,68,73,245,59,62,67,57,245,72,73,54,73,74,58,245,66,68,57,58,65,1,245,72,64,62,69,69,62,67,60},43))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({72,73,62,65,65,245,54,65,62,75,58,245,253,29,37},43), hp, _d({254,245,2,245,71,58,2,57,58,72,73,71,68,78,62,67,60},43))
destroyStatue(coordKey)
else
debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,15},43), coordKey, _d({56,68,67,59,62,71,66,58,57,245,57,58,72,73,71,68,78,58,57},43))
end
end)
if not ok then debug(_d({71,58,56,61,58,56,64,40,73,54,73,74,58,245,58,71,71,68,71,15},43), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({34,68,75,62,67,60,245,73,68,245,38,74,58,58,67},43))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({38,74,58,58,67,245,58,67,73,58,71,58,57,245,69,61,54,72,58,245,7},43))
end
local function finishQueen()
debug(_d({27,62,67,62,72,61,62,67,60,245,38,74,58,58,67},43))
equipSwordOrMelee()
setNavNamed(_d({24,74,69,62,57,245,38,74,58,58,67},43))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({24,74,69,62,57,245,38,74,58,58,67},43))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({38,74,58,58,67,245,57,58,59,58,54,73,58,57,3,245,37,65,54,67,245,56,68,66,69,65,58,73,58,3},43))
end
local CONFIRMATION_PROMPT_NAME = _d({24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73},43)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({39,58,66,68,73,58,26,75,58,67,73},43), 5)
end)
if ok then return result end
debug(_d({60,58,73,39,58,69,65,54,78,39,58,66,68,73,58,245,58,71,71,68,71,15},43), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({37,65,54,78,58,71,28,74,62},43))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({30,66,54,60,58,23,74,73,73,68,67},43)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({55,74,73,73,68,67,43,54,65,74,58},43)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({59,62,67,57,23,74,73,73,68,67,23,78,43,54,65,74,58,245,58,71,71,68,71,15},43), result)
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
if not ok then debug(_d({56,65,62,56,64,28,74,62,23,74,73,73,68,67,245,58,71,71,68,71,15},43), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({62,72,40,58,71,75,58,71},43))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({39,58,66,68,73,58,26,75,58,67,73},43))
or inst:FindFirstChild(_d({56,65,62,58,67,73,26,75,58,67,73},43))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({59,62,67,57,22,67,72,76,58,71,24,68,67,67,58,56,73,68,71,245,58,71,71,68,71,15},43), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({24,68,74,65,57,245,67,68,73,245,65,68,56,54,73,58,245,39,58,66,68,73,58,26,75,58,67,73,4,56,65,62,58,67,73,26,75,58,67,73,245,67,58,54,71,245,39,58,69,65,54,78,245,55,74,73,73,68,67,1,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,56,65,62,56,64},43))
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
debug(_d({59,62,71,58,39,58,69,65,54,78,43,54,65,74,58,245,58,71,71,68,71,15},43), err, _d({2,245,59,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,56,65,62,56,64},43))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({27,54,65,65,62,67,60,245,55,54,56,64,245,73,68,245,55,74,73,73,68,67,43,54,65,74,58,245,72,58,54,71,56,61,245,59,68,71,245,39,58,69,65,54,78},43))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({39,58,69,65,54,78,245,55,74,73,73,68,67,245,67,68,73,245,59,68,74,67,57,245,58,62,73,61,58,71,1,245,60,62,75,62,67,60,245,74,69},43))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,3,39,58,66,68,73,58,26,75,58,67,73},43))
local remote = getReplayRemote()
if not remote then
debug(_d({24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,4,39,58,66,68,73,58,26,75,58,67,73,245,67,68,73,245,59,68,74,67,57,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73},43))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({27,62,71,62,67,60,245,39,58,69,65,54,78,245,75,62,54,245,24,68,67,59,62,71,66,54,73,62,68,67,37,71,68,66,69,73,3,39,58,66,68,73,58,26,75,58,67,73},43))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({27,62,71,58,40,58,71,75,58,71,245,58,71,71,68,71,15},43), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({37,65,54,78,58,71,28,74,62},43), 10)
if not playerGui then
debug(_d({76,54,62,73,27,68,71,36,55,63,58,56,73,62,75,58,72,28,74,62,15,245,67,68,245,37,65,54,78,58,71,28,74,62,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({36,55,63,58,56,73,62,75,58,72,245,28,42,30,245,59,68,74,67,57,245,2,245,72,73,54,60,58,245,65,68,54,57,58,57},43))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({36,55,63,58,56,73,62,75,58,72,245,28,42,30,245,67,68,73,245,59,68,74,67,57,245,76,62,73,61,62,67,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
return
end
end
end)
if not ok then debug(_d({76,54,62,73,27,68,71,36,55,63,58,56,73,62,75,58,72,28,74,62,245,58,71,71,68,71,15},43), err) end
end
local function runPlan()
debug(_d({37,65,54,67,245,72,73,54,71,73,58,57},43))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({40,73,54,71,73,62,67,60,245,67,54,75,245,65,68,68,69},43))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({69,68,72,245,5,3,7,72,245,22,27,41,26,39,245,72,73,54,71,73,35,54,75,15},43), rootAfter and rootAfter.Position)
end)
debug(_d({44,54,62,73,62,67,60,245,10,72,245,55,58,59,68,71,58,245,66,68,75,62,67,60,245,73,68,245,40,73,54,60,58,6},43))
task.wait(5)
for _, stage in ipairs({_d({40,73,54,60,58,6},43), _d({40,73,54,60,58,7},43), _d({40,73,54,60,58,8},43), _d({40,73,54,60,58,8,23},43)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,73,68,245,54,71,71,68,76,245,59,65,78,2,57,68,76,67,245,54,71,58,54},43))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({25,68,57,60,62,67,60,245,54,71,71,68,76,245,71,54,62,67},43))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({40,73,54,60,58,9},43))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({38,74,58,58,67,245,62,67,245,69,61,54,72,58,245,7,245,2,245,64,58,58,69,62,67,60,245,32,58,67,245,29,54,64,62,245,54,56,73,62,75,58,245,59,71,68,66,245,61,58,71,58,245,68,67},43))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({40,73,54,73,74,58,6},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,6},43))
destroyStatue(_d({40,73,54,73,74,58,7},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,6},43))
recheckStatue(_d({40,73,54,73,74,58,7},43))
destroyStatue(_d({40,73,54,73,74,58,8},43))
if not enabled then return end
recheckStatue(_d({40,73,54,73,74,58,8},43))
recheckStatue(_d({40,73,54,73,74,58,7},43))
recheckStatue(_d({40,73,54,73,74,58,6},43))
if not enabled then return end
debug(_d({44,54,62,73,62,67,60,245,59,68,71,245,69,61,54,72,58,245,7,245,73,68,245,58,67,57},43))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({37,61,54,72,58,245,7,245,58,67,57,245,76,54,62,73,245,73,62,66,58,68,74,73,1,245,69,71,68,56,58,58,57,62,67,60,245,54,67,78,76,54,78},43))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,55,54,56,64,245,73,68,245,38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
navToPointConfirmed(COORDS.Queen, 30, _d({38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
debug(_d({44,54,62,73,62,67,60,245,10,72,245,54,73,245,38,74,58,58,67,245,72,73,54,60,58,245,69,68,72,62,73,62,68,67},43))
task.wait(5)
if not enabled then return end
debug(_d({34,68,75,62,67,60,245,73,68,245,69,68,72,73,2,38,74,58,58,67,245,69,68,72,62,73,62,68,67},43))
navToPointConfirmed(COORDS.PostQueen, 30, _d({69,68,72,73,2,38,74,58,58,67,245,69,68,72,62,73,62,68,67},43))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({26,67,54,55,65,62,67,60,1,245,69,68,72,245,23,26,27,36,39,26,245,69,65,54,67,15},43), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({37,65,54,67,245,58,71,71,68,71,15},43), err2) end
end)
debug(_d({26,67,54,55,65,58,57,15},43), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({26,67,54,55,65,58,57,15},43), enabled)
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
if not ok then debug(_d({30,67,69,74,73,23,58,60,54,67,245,58,71,71,68,71,15},43), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({28,54,66,58,245,65,68,54,57,58,57,1,245,54,74,73,68,2,72,73,54,71,73,62,67,60,245,73,61,58,245,69,65,54,67},43))
enableBot()
end)
if not ok then debug(_d({22,74,73,68,72,73,54,71,73,245,58,71,71,68,71,15},43), err) end
end)
debug(_d({33,68,54,57,58,57,245,183,85,105,245,54,74,73,68,2,72,73,54,71,73,62,67,60,245,68,67,56,58,245,73,61,58,245,60,54,66,58,245,59,62,67,62,72,61,58,72,245,65,68,54,57,62,67,60,245,253,69,71,58,72,72,245,37,245,73,68,245,73,68,60,60,65,58,245,66,54,67,74,54,65,65,78,254},43))
end)()