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
local Players            = game:GetService(_d({36,64,53,77,57,70,71},44))
local UserInputService    = game:GetService(_d({41,71,57,70,29,66,68,73,72,39,57,70,74,61,55,57},44))
local RunService          = game:GetService(_d({38,73,66,39,57,70,74,61,55,57},44))
local VIM                 = game:GetService(_d({42,61,70,72,73,53,64,29,66,68,73,72,33,53,66,53,59,57,70},44))
local ReplicatedStorage    = game:GetService(_d({38,57,68,64,61,55,53,72,57,56,39,72,67,70,53,59,57},44))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({47,22,67,71,71,22,67,72,49},44), _d({43,70,67,66,59,244,59,53,65,57,244,182,84,104,244,36,64,53,55,57,29,56,14},44), game.PlaceId, _d({41,66,61,74,57,70,71,57,29,56,14},44), game.GameId, _d({1,244,66,67,72,244,70,73,66,66,61,66,59},44))
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
local LEO_PILLAR_ANIM_ID   = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,9,6,8,8,5,8,5,7,6,11},44)
local LEO_ENTEI_ANIM_ID    = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,9,6,8,8,5,7,12,6,11,12},44)
local LEO_HIKEN_ANIM_ID    = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,9,6,6,4,13,5,11,8,4,11},44)
local LEO_FIREFLY_ANIM_ID  = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,9,6,6,4,6,7,10,5,9,8},44)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({35,54,62,57,55,72,61,74,57,71},44)
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
local REPLAY_BUTTON_VALUE   = _d({38,57,68,64,53,77},44)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({65,67,74,57},44)
local NavState   = {mode = _d({61,56,64,57},44)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({47,22,67,71,71,22,67,72,49},44), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
end)
if ok then return root end
debug(_d({59,57,72,38,67,67,72,244,57,70,70,67,70,14},44), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
end)
if ok then return hum end
debug(_d({59,57,72,28,73,65,53,66,67,61,56,244,57,70,70,67,70,14},44), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({51,51,28,67,74,57,70,21,72,72},44)) or Instance.new(_d({21,72,72,53,55,60,65,57,66,72},44))
att.Name = _d({51,51,28,67,74,57,70,21,72,72},44)
att.Parent = root
local force = root:FindFirstChild(_d({51,51,28,67,74,57,70,26,67,70,55,57},44))
if not force then
force = Instance.new(_d({32,61,66,57,53,70,42,57,64,67,55,61,72,77},44))
force.Name = _d({51,51,28,67,74,57,70,26,67,70,55,57},44)
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
debug(_d({59,57,72,35,70,23,70,57,53,72,57,26,67,70,55,57,244,57,70,70,67,70,14},44), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if not root then return end
local force = root:FindFirstChild(_d({51,51,28,67,74,57,70,26,67,70,55,57},44))
local att   = root:FindFirstChild(_d({51,51,28,67,74,57,70,21,72,72},44))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({55,64,57,53,66,73,68,26,67,70,55,57,244,57,70,70,67,70,14},44), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({22,73,71,67,33,57,64,57,57},44)) ~= nil
end)
if ok then return result end
debug(_d({61,71,22,73,71,67,21,55,72,61,74,57,244,57,70,70,67,70,14},44), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({22,73,71,67},44))
end)
if not ok then debug(_d({53,55,72,61,74,53,72,57,22,73,71,67,244,57,70,70,67,70,14},44), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({22,73,71,67,244,66,67,72,244,53,55,72,61,74,57,0,244,53,55,72,61,74,53,72,61,66,59},44))
activateBuso()
end
end)
if not ok then debug(_d({22,73,71,67,31,57,57,68,57,70,244,57,70,70,67,70,14},44), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({22,73,71,67,244,63,57,57,68,57,70,244,71,72,67,68,68,57,56},44))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({31,57,66,28,53,63,61},44)) ~= nil
end)
if ok then return result end
debug(_d({61,71,31,57,66,21,55,72,61,74,57,244,57,70,70,67,70,14},44), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({31,57,66},44), true)
end)
if not ok then debug(_d({53,55,72,61,74,53,72,57,31,57,66,244,57,70,70,67,70,14},44), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({31,57,66,244,66,67,72,244,53,55,72,61,74,57,0,244,53,55,72,61,74,53,72,61,66,59},44))
activateKen()
end
end)
if not ok then debug(_d({31,57,66,31,57,57,68,57,70,244,57,70,70,67,70,14},44), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({31,57,66,244,63,57,57,68,57,70,244,71,72,67,68,68,57,56},44))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({34,36,23,71},44)) end)
if ok then return folder end
debug(_d({59,57,72,34,36,23,71,26,67,64,56,57,70,244,57,70,70,67,70,14},44), folder)
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
local r = model:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
local h = model:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
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
debug(_d({59,57,72,34,57,53,70,57,71,72,34,36,23,244,57,70,70,67,70,14},44), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
local hum  = model:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({59,57,72,34,36,23,22,77,34,53,65,57,244,57,70,70,67,70,14},44), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({66,68,55,71,38,57,65,53,61,66,61,66,59,244,57,70,70,67,70,14},44), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({23,73,68,61,56,244,37,73,57,57,66},44))
return queen ~= nil and queen:FindFirstChild(_d({65,67,72,61,67,66,32,57,71,71},44)) ~= nil
end)
if ok then return result end
debug(_d({61,71,37,73,57,57,66,36,60,53,71,57,6,244,57,70,70,67,70,14},44), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,5,6,5,6,13,11,13,8,6,6,13,6,11,10,13},44)
local QUEEN_GRASP_ANIM_ID   = _d({70,54,76,53,71,71,57,72,61,56,14,3,3,5,6,13,12,4,4,4,10,5,4,4,5,11,7,8},44)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
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
debug(_d({61,71,36,64,53,77,61,66,59,21,66,61,65,26,70,67,65,32,61,71,72,244,57,70,70,67,70,14},44), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({22,64,67,55,63,61,66,59},44)) ~= nil
end)
if ok then return result end
debug(_d({61,71,34,36,23,22,64,67,55,63,61,66,59,244,57,70,70,67,70,14},44), result)
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
debug(_d({68,70,57,56,61,55,72,34,36,23,36,67,71,61,72,61,67,66,244,57,70,70,67,70,14},44), result)
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
debug(_d({34,67,244,56,53,65,53,59,57,244,67,66},44), model.Name, _d({58,67,70},44), NPC_STUCK_TIMEOUT, _d({71,244,1,244,71,75,61,72,55,60,61,66,59,244,72,53,70,59,57,72},44))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({72,70,53,55,63,34,36,23,24,53,65,53,59,57,244,57,70,70,67,70,14},44), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({33,67,56,57,64},44)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({22,53,71,57,36,53,70,72},44)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({59,57,72,33,67,56,57,64,26,53,55,57,36,67,71,244,57,70,70,67,70,14},44), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({25,66,74},44))
local folder = env and env:FindFirstChild(_d({39,72,53,72,73,57,71},44))
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
debug(_d({59,57,72,39,72,53,72,73,57,33,67,56,57,64,34,57,53,70,244,57,70,70,67,70,14},44), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({54,53,70,70,57,64,28,36},44))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({59,57,72,39,72,53,72,73,57,28,36,244,57,70,70,67,70,14},44), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({22,53,55,63,68,53,55,63},44))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({40,67,67,64},44)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({58,61,66,56,40,67,67,64,22,77,21,72,72,70,61,54,73,72,57,244,57,70,70,67,70,14},44), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({22,53,55,63,68,53,55,63},44))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({40,67,67,64},44)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({58,61,66,56,40,67,67,64,22,77,34,53,65,57,244,57,70,70,67,70,14},44), tool)
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
if not ok then debug(_d({57,69,73,61,68,40,67,67,64,244,57,70,70,67,70,14},44), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({22,53,55,63,68,53,55,63},44))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({40,67,67,64},44)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({58,61,66,56,40,67,67,64,22,77,23,60,61,64,56,34,53,65,57,244,57,70,70,67,70,14},44), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({39,75,67,70,56,25,69,73,61,68},44))
if sword then
equipTool(sword)
return _d({71,75,67,70,56},44)
end
local melee = findToolByAttribute(_d({33,57,64,57,57,40,67,67,64},44))
if melee then
equipTool(melee)
return _d({65,57,64,57,57},44)
end
debug(_d({34,67,244,71,75,67,70,56,244,67,70,244,65,57,64,57,57,244,72,67,67,64,244,58,67,73,66,56},44))
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
if not ok then debug(_d({55,64,61,55,63,33,5,244,57,70,70,67,70,14},44), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({28,73,65,53,66,67,61,56,38,67,67,72,36,53,70,72},44))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({39,72,53,72,71},44) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({38,67,63,73,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({27,57,68,68,67},44), args)
elseif style == _d({22,64,53,55,63,32,57,59},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63},44), args)
elseif style == _d({31,53,65,61,71,60,61,63,61},44) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,53,65,61,71,60,61,63,61,27,57,68,68,67},44), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,63,77,244,43,53,64,63,6},44), args)
end
end)
if not ok then debug(_d({61,66,74,67,63,57,27,57,68,68,67,244,57,70,70,67,70,14},44), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({68,70,57,71,71,39,63,61,64,64,38,244,57,70,70,67,70,14},44), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({60,67,64,56,22,64,67,55,63,244,57,70,70,67,70,14},44), err) end
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
if not ok then debug(_d({60,67,64,56,22,64,67,55,63,43,60,61,64,57,244,57,70,70,67,70,14},44), err) end
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
debug(_d({59,57,72,27,53,65,57,27,244,57,70,70,67,70,14},44), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({61,71,38,57,53,64,33,5,22,73,71,77,244,57,70,70,67,70,14},44), result)
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
return char ~= nil and char:FindFirstChild(_d({71,72,73,66},44)) ~= nil
end)
if ok then return result end
debug(_d({61,71,39,72,73,66,66,57,56,244,57,70,70,67,70,14},44), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({68,70,57,71,71,39,72,73,66,22,70,57,53,63,244,57,70,70,67,70,14},44), err) end
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
debug(_d({69,73,57,57,66,24,67,56,59,57,41,66,72,61,64,39,53,58,57,14,244,37,73,57,57,66,244,59,67,66,57,244,1,244,57,66,56,61,66,59,244,56,67,56,59,57,244,57,53,70,64,77},44))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({69,73,57,57,66,24,67,56,59,57,41,66,72,61,64,39,53,58,57,244,71,53,58,57,72,77,244,72,61,65,57,67,73,72},44))
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
local info = getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({37,73,57,57,66,244,55,53,71,72,61,66,59,244,56,57,72,57,55,72,57,56,244,1,244,56,67,56,59,61,66,59,244,252,75,53,72,55,60,57,70,253},44))
queenDodgeUntilSafe(function() return getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44)) end)
if enabled and getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44)) then
setNavNamed(_d({23,73,68,61,56,244,37,73,57,57,66},44))
end
queenDodging = false
end
end)
if not ok then debug(_d({69,73,57,57,66,24,67,56,59,57,43,53,72,55,60,57,70,244,57,70,70,67,70,14},44), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({68,67,61,66,72},44) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({66,68,55},44) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({66,53,65,57,56},44) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({59,57,72,34,53,74,40,53,70,59,57,72,71,244,57,70,70,67,70,14},44), aimR)
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
debug(_d({55,67,65,68,73,72,57,32,67,55,63,57,56,23,26,70,53,65,57,244,57,70,70,67,70,14},44), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({68,67,61,66,72},44), point = pos}
phase = _d({65,67,74,57},44)
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
if not ok then debug(_d({66,53,74,40,67,36,67,61,66,72,244,59,57,68,68,67,244,55,60,57,55,63,244,57,70,70,67,70,14},44), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({66,68,55},44)}
phase = _d({65,67,74,57},44)
end
function setNavNamed(name)
NavState = {mode = _d({66,53,65,57,56},44), name = name}
phase = _d({65,67,74,57},44)
end
local function setNavIdle()
NavState = {mode = _d({61,56,64,57},44)}
phase = _d({65,67,74,57},44)
end
local function hasArrived()
return phase == _d({60,67,74,57,70},44)
end
local function startNav()
phase = _d({65,67,74,57},44)
debug(_d({34,53,74,244,64,67,67,68,244,35,34},44))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({36,64,53,77,57,70,244,56,61,57,56,245,244,39,72,67,68,68,61,66,59,244,54,67,72,2},44))
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
debug(_d({36,64,53,77,57,70,244,61,71,244,72,67,67,244,58,53,70,244,58,70,67,65,244,72,53,70,59,57,72,244,252,18,6,4,4,4,244,71,72,73,56,71,253,2,244,32,61,63,57,64,77,244,70,57,71,68,53,75,66,57,56,244,53,72,244,64,67,54,54,77,2,244,39,72,67,68,68,61,66,59,244,54,67,72,2},44))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({51,51,68,70,57,74,36,67,71},44))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({32,53,70,59,57,244,68,67,71,61,72,61,67,66,244,62,73,65,68,244,56,57,72,57,55,72,57,56,14},44), delta, _d({71,72,73,56,71,2,244,68,70,57,74,36,67,71,17},44), prevPos, _d({66,57,75,36,67,71,17},44), pos)
end
end
force:SetAttribute(_d({51,51,68,70,57,74,36,67,71},44), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({65,67,74,57},44) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({60,67,74,57,70},44)
debug(_d({36,60,53,71,57,14,244,60,67,74,57,70},44))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({245,245,245,244,38,25,26,41,39,29,34,27,244,40,35,244,21,36,36,32,45,244,21,22,34,35,38,33,21,32,244,42,25,32,35,23,29,40,45,14},44), finalVel, _d({53,61,65,17},44), aim, _d({68,67,71,17},44), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({60,67,74,57,70},44) then
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
debug(_d({23,67,65,54,53,72,244,64,67,55,63,244,71,63,61,68,68,57,56,0},44), snapDist, _d({71,72,73,56,71,244,58,70,67,65,244,72,53,70,59,57,72,244,182,84,104,244,58,53,64,64,61,66,59,244,54,53,55,63,244,72,67,244,65,67,74,57},44))
phase = _d({65,67,74,57},44)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({28,57,53,70,72,54,57,53,72,244,57,70,70,67,70,14},44), err) end
end)
end
local function stopNav()
debug(_d({34,53,74,244,64,67,67,68,244,35,26,26},44))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({65,67,74,57},44)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({40,57,76,72,23,60,53,72,39,57,70,74,61,55,57},44))
local channels = TextChatService:FindFirstChild(_d({40,57,76,72,23,60,53,66,66,57,64,71},44))
local channel = channels and channels:FindFirstChild(_d({38,22,44,27,57,66,57,70,53,64},44))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({24,57,58,53,73,64,72,23,60,53,72,39,77,71,72,57,65,23,60,53,72,25,74,57,66,72,71},44))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({39,53,77,33,57,71,71,53,59,57,38,57,69,73,57,71,72},44))
if sayEvent then
sayEvent:FireServer(message, _d({21,64,64},44))
return
end
debug(_d({71,57,66,56,23,60,53,72,33,57,71,71,53,59,57,14,244,66,67,244,40,57,76,72,23,60,53,72,39,57,70,74,61,55,57,2,38,22,44,27,57,66,57,70,53,64,244,67,70,244,64,57,59,53,55,77,244,39,53,77,33,57,71,71,53,59,57,38,57,69,73,57,71,72,244,58,67,73,66,56,244,58,67,70},44), message)
end)
if not ok then debug(_d({71,57,66,56,23,60,53,72,33,57,71,71,53,59,57,244,57,70,70,67,70,14},44), err) end
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
debug(_d({34,67,72,244,65,53,63,61,66,59,244,68,70,67,59,70,57,71,71,244,72,67,75,53,70,56,244,66,53,74,244,72,53,70,59,57,72,244,58,67,70},44), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({71,244,1,244,71,57,66,56,61,66,59,244,3,73,66,71,72,73,55,63},44))
sendChatMessage(_d({3,73,66,71,72,73,55,63},44))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({75,53,61,72,41,66,72,61,64,21,70,70,61,74,57,56,244,72,61,65,57,67,73,72},44))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({66,53,74,40,67,36,67,61,66,72,23,67,66,58,61,70,65,57,56,14},44), label or _d({72,53,70,59,57,72},44), _d({1,244,56,61,56,244,66,67,72,244,53,70,70,61,74,57,244,75,61,72,60,61,66},44), timeout, _d({71,0,244,70,57,72,70,77,61,66,59,244,67,66,55,57},44))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({66,53,74,40,67,36,67,61,66,72,23,67,66,58,61,70,65,57,56,14},44), label or _d({72,53,70,59,57,72},44), _d({1,244,71,72,61,64,64,244,66,67,72,244,53,70,70,61,74,57,56,244,53,58,72,57,70,244,70,57,72,70,77,0,244,68,70,67,55,57,57,56,61,66,59,244,53,66,77,75,53,77},44))
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
if not ok then debug(_d({66,53,74,40,67,36,67,61,66,72,28,67,64,56,61,66,59,22,64,67,55,63,244,63,57,77,1,56,67,75,66,244,57,70,70,67,70,14},44), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({66,53,74,40,67,36,67,61,66,72,28,67,64,56,61,66,59,22,64,67,55,63,244,63,57,77,1,73,68,244,57,70,70,67,70,14},44), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({43,53,64,63,61,66,59,244,72,67,14},44), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({75,53,64,63,40,67,36,67,61,66,72,244,43,244,56,67,75,66,244,57,70,70,67,70,14},44), err) end
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
debug(_d({40,67,67,63,244,56,53,65,53,59,57,244,75,60,61,64,57,244,75,53,64,63,61,66,59,244,72,67,244,68,67,61,66,72,245,244,39,72,67,68,68,61,66,59,244,75,53,64,63,244,72,67,244,57,66,59,53,59,57,2},44))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({21,70,70,61,74,57,56,244,53,72,14},44), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({39,72,73,55,63,244,56,73,70,61,66,59,244,75,53,64,63,0,244,62,73,65,68,61,66,59,245},44))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({39,72,61,64,64,244,71,72,73,55,63,0,244,72,70,61,59,59,57,70,61,66,59,244,27,57,68,68,67,245},44))
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
debug(_d({33,67,74,61,66,59,244,72,67},44), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({43,53,61,72,61,66,59,244,58,67,70,244,34,36,23,71,244,72,67,244,71,68,53,75,66,244,53,72},44), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({244,244,71,68,53,75,66,244,55,60,57,55,63,14,244,58,67,64,56,57,70,244,57,76,61,71,72,71,244,17},44), folder ~= nil,
_d({0,244,55,60,61,64,56,70,57,66,244,17},44), folder and #folder:GetChildren() or 0,
_d({0,244,53,64,61,74,57,244,17},44), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({34,67,244,34,36,23,71,244,53,68,68,57,53,70,57,56,244,53,72},44), stageName, _d({53,58,72,57,70,244,5,9,71,0,244,65,67,74,61,66,59,244,67,66,244,53,66,77,75,53,77},44))
break
end
end
debug(_d({31,61,64,64,61,66,59,244,34,36,23,71,244,53,72},44), stageName)
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
debug(_d({38,57,72,73,70,66,61,66,59,244,72,67},44), stageName, _d({68,67,71,61,72,61,67,66,244,54,57,58,67,70,57,244,65,67,74,61,66,59,244,67,66},44))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({43,53,61,72,61,66,59,244,9,71,244,53,72},44), stageName, _d({68,67,71,61,72,61,67,66},44))
task.wait(5)
debug(_d({43,53,61,72,61,66,59,244,58,67,70},44), targetHP * 100, _d({249,244,28,36,244,54,57,58,67,70,57,244,65,67,74,61,66,59,244,72,67,244,66,57,76,72,244,71,72,53,59,57},44))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({55,64,57,53,70,57,56},44))
end
local function killNamedNPC(name, targetPos)
debug(_d({33,67,74,61,66,59,244,72,67},44), name)
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
debug(name, _d({56,57,58,57,53,72,57,56},44))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({28,73,65,53,66,67,61,56},44))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({32,57,67,244,68,64,53,77,57,56,244,53,66,61,65,53,72,61,67,66,14},44), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({64,57,67,21,66,61,65,32,67,59,59,57,70,244,68,70,61,66,72,244,57,70,70,67,70,14},44), err2) end
end)
end)
if not ok then debug(_d({71,72,53,70,72,32,57,67,21,66,61,65,32,67,59,59,57,70,244,57,70,70,67,70,14},44), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({33,67,74,61,66,59,244,72,67,244,32,57,67},44))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({32,57,67},44))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({32,57,67},44))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({32,57,67},44))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({32,57,67,244,55,53,71,72,61,66,59},44), which, _d({1,244,56,67,56,59,61,66,59},44))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({32,57,67,244,71,72,53,70,72,57,56,244,54,64,67,55,63,1,54,70,57,53,63,57,70,244,65,61,56,1,54,64,67,55,63,245,244,25,74,53,56,61,66,59,2,2,2},44))
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
if not getNPCByName(_d({32,57,67},44)) then
debug(_d({32,57,67,244,59,67,66,57,244,65,61,56,1,56,67,56,59,57,244,1,244,57,66,56,61,66,59,244,25,66,72,57,61,244,60,67,64,56,244,57,53,70,64,77},44))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({32,57,67},44)) then
setNavNamed(_d({32,57,67},44))
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
debug(_d({32,57,67,244,56,57,58,57,53,72,57,56},44))
stopLeoAnimLogger()
debug(_d({38,57,72,73,70,66,61,66,59,244,72,67,244,32,57,67,244,68,67,71,61,72,61,67,66,244,54,57,58,67,70,57,244,65,67,74,61,66,59,244,67,66},44))
navToPointConfirmed(COORDS.Leo, 30, _d({32,57,67,244,68,67,71,61,72,61,67,66},44))
debug(_d({43,53,61,72,61,66,59,244,9,71,244,53,72,244,32,57,67,244,68,67,71,61,72,61,67,66},44))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({33,67,74,61,66,59,244,72,67},44), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({23,67,73,64,56,244,66,67,72,244,58,61,66,56,244,71,72,53,72,73,57,244,65,67,56,57,64,244,66,57,53,70},44), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({21,72,72,53,55,63,61,66,59},44), coordKey, _d({75,61,72,60},44), weapon or _d({66,67,72,60,61,66,59,244,58,67,73,66,56},44))
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
debug(coordKey, _d({54,53,70,70,57,64,244,56,57,71,72,70,67,77,57,56},44))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({70,57,55,60,57,55,63,39,72,53,72,73,57,14},44), coordKey, _d({1,244,55,67,73,64,56,244,66,67,72,244,58,61,66,56,244,71,72,53,72,73,57,244,65,67,56,57,64,0,244,71,63,61,68,68,61,66,59},44))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({70,57,55,60,57,55,63,39,72,53,72,73,57,14},44), coordKey, _d({71,72,61,64,64,244,53,64,61,74,57,244,252,28,36},44), hp, _d({253,244,1,244,70,57,1,56,57,71,72,70,67,77,61,66,59},44))
destroyStatue(coordKey)
else
debug(_d({70,57,55,60,57,55,63,39,72,53,72,73,57,14},44), coordKey, _d({55,67,66,58,61,70,65,57,56,244,56,57,71,72,70,67,77,57,56},44))
end
end)
if not ok then debug(_d({70,57,55,60,57,55,63,39,72,53,72,73,57,244,57,70,70,67,70,14},44), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({33,67,74,61,66,59,244,72,67,244,37,73,57,57,66},44))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({23,73,68,61,56,244,37,73,57,57,66},44))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44))
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
debug(_d({37,73,57,57,66,244,57,66,72,57,70,57,56,244,68,60,53,71,57,244,6},44))
end
local function finishQueen()
debug(_d({26,61,66,61,71,60,61,66,59,244,37,73,57,57,66},44))
equipSwordOrMelee()
setNavNamed(_d({23,73,68,61,56,244,37,73,57,57,66},44))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({23,73,68,61,56,244,37,73,57,57,66},44))
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
debug(_d({37,73,57,57,66,244,56,57,58,57,53,72,57,56,2,244,36,64,53,66,244,55,67,65,68,64,57,72,57,2},44))
end
local CONFIRMATION_PROMPT_NAME = _d({23,67,66,58,61,70,65,53,72,61,67,66,36,70,67,65,68,72},44)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({38,57,65,67,72,57,25,74,57,66,72},44), 5)
end)
if ok then return result end
debug(_d({59,57,72,38,57,68,64,53,77,38,57,65,67,72,57,244,57,70,70,67,70,14},44), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({36,64,53,77,57,70,27,73,61},44))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({29,65,53,59,57,22,73,72,72,67,66},44)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({54,73,72,72,67,66,42,53,64,73,57},44)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({58,61,66,56,22,73,72,72,67,66,22,77,42,53,64,73,57,244,57,70,70,67,70,14},44), result)
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
if not ok then debug(_d({55,64,61,55,63,27,73,61,22,73,72,72,67,66,244,57,70,70,67,70,14},44), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({61,71,39,57,70,74,57,70},44))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({38,57,65,67,72,57,25,74,57,66,72},44))
or inst:FindFirstChild(_d({55,64,61,57,66,72,25,74,57,66,72},44))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({58,61,66,56,21,66,71,75,57,70,23,67,66,66,57,55,72,67,70,244,57,70,70,67,70,14},44), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({23,67,73,64,56,244,66,67,72,244,64,67,55,53,72,57,244,38,57,65,67,72,57,25,74,57,66,72,3,55,64,61,57,66,72,25,74,57,66,72,244,66,57,53,70,244,38,57,68,64,53,77,244,54,73,72,72,67,66,0,244,58,53,64,64,61,66,59,244,54,53,55,63,244,72,67,244,55,64,61,55,63},44))
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
debug(_d({58,61,70,57,38,57,68,64,53,77,42,53,64,73,57,244,57,70,70,67,70,14},44), err, _d({1,244,58,53,64,64,61,66,59,244,54,53,55,63,244,72,67,244,55,64,61,55,63},44))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({26,53,64,64,61,66,59,244,54,53,55,63,244,72,67,244,54,73,72,72,67,66,42,53,64,73,57,244,71,57,53,70,55,60,244,58,67,70,244,38,57,68,64,53,77},44))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({38,57,68,64,53,77,244,54,73,72,72,67,66,244,66,67,72,244,58,67,73,66,56,244,57,61,72,60,57,70,0,244,59,61,74,61,66,59,244,73,68},44))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({43,53,61,72,61,66,59,244,58,67,70,244,23,67,66,58,61,70,65,53,72,61,67,66,36,70,67,65,68,72,2,38,57,65,67,72,57,25,74,57,66,72},44))
local remote = getReplayRemote()
if not remote then
debug(_d({23,67,66,58,61,70,65,53,72,61,67,66,36,70,67,65,68,72,3,38,57,65,67,72,57,25,74,57,66,72,244,66,67,72,244,58,67,73,66,56,244,75,61,72,60,61,66,244,72,61,65,57,67,73,72},44))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({26,61,70,61,66,59,244,38,57,68,64,53,77,244,74,61,53,244,23,67,66,58,61,70,65,53,72,61,67,66,36,70,67,65,68,72,2,38,57,65,67,72,57,25,74,57,66,72},44))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({26,61,70,57,39,57,70,74,57,70,244,57,70,70,67,70,14},44), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({36,64,53,77,57,70,27,73,61},44), 10)
if not playerGui then
debug(_d({75,53,61,72,26,67,70,35,54,62,57,55,72,61,74,57,71,27,73,61,14,244,66,67,244,36,64,53,77,57,70,27,73,61,244,75,61,72,60,61,66,244,72,61,65,57,67,73,72,0,244,68,70,67,55,57,57,56,61,66,59,244,53,66,77,75,53,77},44))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({35,54,62,57,55,72,61,74,57,71,244,27,41,29,244,58,67,73,66,56,244,1,244,71,72,53,59,57,244,64,67,53,56,57,56},44))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({35,54,62,57,55,72,61,74,57,71,244,27,41,29,244,66,67,72,244,58,67,73,66,56,244,75,61,72,60,61,66,244,72,61,65,57,67,73,72,0,244,68,70,67,55,57,57,56,61,66,59,244,53,66,77,75,53,77},44))
return
end
end
end)
if not ok then debug(_d({75,53,61,72,26,67,70,35,54,62,57,55,72,61,74,57,71,27,73,61,244,57,70,70,67,70,14},44), err) end
end
local function runPlan()
debug(_d({36,64,53,66,244,71,72,53,70,72,57,56},44))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({39,72,53,70,72,61,66,59,244,66,53,74,244,64,67,67,68},44))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({68,67,71,244,4,2,6,71,244,21,26,40,25,38,244,71,72,53,70,72,34,53,74,14},44), rootAfter and rootAfter.Position)
end)
debug(_d({43,53,61,72,61,66,59,244,9,71,244,54,57,58,67,70,57,244,65,67,74,61,66,59,244,72,67,244,39,72,53,59,57,5},44))
task.wait(5)
for _, stage in ipairs({_d({39,72,53,59,57,5},44), _d({39,72,53,59,57,6},44), _d({39,72,53,59,57,7},44), _d({39,72,53,59,57,7,22},44)}) do
if not enabled then return end
local hpTarget = (stage == _d({39,72,53,59,57,7,22},44)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({33,67,74,61,66,59,244,72,67,244,53,70,70,67,75,244,58,64,77,1,56,67,75,66,244,53,70,57,53,244,252,23,73,68,61,56,244,38,53,61,66,253},44))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({24,67,56,59,61,66,59,244,53,70,70,67,75,244,70,53,61,66,244,61,66,244,53,244,71,69,73,53,70,57},44))
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
clearStage(_d({39,72,53,59,57,8},44))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({37,73,57,57,66,244,61,66,244,68,60,53,71,57,244,6,244,1,244,63,57,57,68,61,66,59,244,31,57,66,244,28,53,63,61,244,53,55,72,61,74,57,244,58,70,67,65,244,60,57,70,57,244,67,66},44))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({39,72,53,72,73,57,5},44))
if not enabled then return end
recheckStatue(_d({39,72,53,72,73,57,5},44))
destroyStatue(_d({39,72,53,72,73,57,6},44))
if not enabled then return end
recheckStatue(_d({39,72,53,72,73,57,5},44))
recheckStatue(_d({39,72,53,72,73,57,6},44))
destroyStatue(_d({39,72,53,72,73,57,7},44))
if not enabled then return end
recheckStatue(_d({39,72,53,72,73,57,7},44))
recheckStatue(_d({39,72,53,72,73,57,6},44))
recheckStatue(_d({39,72,53,72,73,57,5},44))
if not enabled then return end
debug(_d({43,53,61,72,61,66,59,244,58,67,70,244,68,60,53,71,57,244,6,244,72,67,244,57,66,56},44))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({36,60,53,71,57,244,6,244,57,66,56,244,75,53,61,72,244,72,61,65,57,67,73,72,0,244,68,70,67,55,57,57,56,61,66,59,244,53,66,77,75,53,77},44))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({33,67,74,61,66,59,244,54,53,55,63,244,72,67,244,37,73,57,57,66,244,71,72,53,59,57,244,68,67,71,61,72,61,67,66},44))
navToPointConfirmed(COORDS.Queen, 30, _d({37,73,57,57,66,244,71,72,53,59,57,244,68,67,71,61,72,61,67,66},44))
debug(_d({43,53,61,72,61,66,59,244,9,71,244,53,72,244,37,73,57,57,66,244,71,72,53,59,57,244,68,67,71,61,72,61,67,66},44))
task.wait(5)
if not enabled then return end
debug(_d({33,67,74,61,66,59,244,72,67,244,68,67,71,72,1,37,73,57,57,66,244,68,67,71,61,72,61,67,66},44))
navToPointConfirmed(COORDS.PostQueen, 30, _d({68,67,71,72,1,37,73,57,57,66,244,68,67,71,61,72,61,67,66},44))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({25,66,53,54,64,61,66,59,0,244,68,67,71,244,22,25,26,35,38,25,244,68,64,53,66,14},44), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({36,64,53,66,244,57,70,70,67,70,14},44), err2) end
end)
debug(_d({25,66,53,54,64,57,56,14},44), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({25,66,53,54,64,57,56,14},44), enabled)
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
if not ok then debug(_d({29,66,68,73,72,22,57,59,53,66,244,57,70,70,67,70,14},44), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({27,53,65,57,244,64,67,53,56,57,56,0,244,53,73,72,67,1,71,72,53,70,72,61,66,59,244,72,60,57,244,68,64,53,66},44))
enableBot()
end)
if not ok then debug(_d({21,73,72,67,71,72,53,70,72,244,57,70,70,67,70,14},44), err) end
end)
debug(_d({32,67,53,56,57,56,244,182,84,104,244,53,73,72,67,1,71,72,53,70,72,61,66,59,244,67,66,55,57,244,72,60,57,244,59,53,65,57,244,58,61,66,61,71,60,57,71,244,64,67,53,56,61,66,59,244,252,68,70,57,71,71,244,36,244,72,67,244,72,67,59,59,64,57,244,65,53,66,73,53,64,64,77,253},44))
end)()