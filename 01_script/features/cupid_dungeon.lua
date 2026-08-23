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
local Players            = game:GetService(_d({56,84,73,97,77,90,91},24))
local UserInputService    = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
local RunService          = game:GetService(_d({58,93,86,59,77,90,94,81,75,77},24))
local VIM                 = game:GetService(_d({62,81,90,92,93,73,84,49,86,88,93,92,53,73,86,73,79,77,90},24))
local ReplicatedStorage    = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({67,42,87,91,91,42,87,92,69},24), _d({63,90,87,86,79,8,79,73,85,77,8,202,104,124,8,56,84,73,75,77,49,76,34},24), game.PlaceId, _d({61,86,81,94,77,90,91,77,49,76,34},24), game.GameId, _d({21,8,86,87,92,8,90,93,86,86,81,86,79},24))
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
local LEO_PILLAR_ANIM_ID   = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,29,26,28,28,25,28,25,27,26,31},24)
local LEO_ENTEI_ANIM_ID    = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,29,26,28,28,25,27,32,26,31,32},24)
local LEO_HIKEN_ANIM_ID    = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,29,26,26,24,33,25,31,28,24,31},24)
local LEO_FIREFLY_ANIM_ID  = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,29,26,26,24,26,27,30,25,29,28},24)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({55,74,82,77,75,92,81,94,77,91},24)
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
local REPLAY_BUTTON_VALUE   = _d({58,77,88,84,73,97},24)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({85,87,94,77},24)
local NavState   = {mode = _d({81,76,84,77},24)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({67,42,87,91,91,42,87,92,69},24), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end)
if ok then return root end
debug(_d({79,77,92,58,87,87,92,8,77,90,90,87,90,34},24), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
end)
if ok then return hum end
debug(_d({79,77,92,48,93,85,73,86,87,81,76,8,77,90,90,87,90,34},24), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({71,71,48,87,94,77,90,41,92,92},24)) or Instance.new(_d({41,92,92,73,75,80,85,77,86,92},24))
att.Name = _d({71,71,48,87,94,77,90,41,92,92},24)
att.Parent = root
local force = root:FindFirstChild(_d({71,71,48,87,94,77,90,46,87,90,75,77},24))
if not force then
force = Instance.new(_d({52,81,86,77,73,90,62,77,84,87,75,81,92,97},24))
force.Name = _d({71,71,48,87,94,77,90,46,87,90,75,77},24)
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
debug(_d({79,77,92,55,90,43,90,77,73,92,77,46,87,90,75,77,8,77,90,90,87,90,34},24), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if not root then return end
local force = root:FindFirstChild(_d({71,71,48,87,94,77,90,46,87,90,75,77},24))
local att   = root:FindFirstChild(_d({71,71,48,87,94,77,90,41,92,92},24))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({75,84,77,73,86,93,88,46,87,90,75,77,8,77,90,90,87,90,34},24), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({42,93,91,87,53,77,84,77,77},24)) ~= nil
end)
if ok then return result end
debug(_d({81,91,42,93,91,87,41,75,92,81,94,77,8,77,90,90,87,90,34},24), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({42,93,91,87},24))
end)
if not ok then debug(_d({73,75,92,81,94,73,92,77,42,93,91,87,8,77,90,90,87,90,34},24), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({42,93,91,87,8,86,87,92,8,73,75,92,81,94,77,20,8,73,75,92,81,94,73,92,81,86,79},24))
activateBuso()
end
end)
if not ok then debug(_d({42,93,91,87,51,77,77,88,77,90,8,77,90,90,87,90,34},24), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({42,93,91,87,8,83,77,77,88,77,90,8,91,92,87,88,88,77,76},24))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({51,77,86,48,73,83,81},24)) ~= nil
end)
if ok then return result end
debug(_d({81,91,51,77,86,41,75,92,81,94,77,8,77,90,90,87,90,34},24), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({51,77,86},24), true)
end)
if not ok then debug(_d({73,75,92,81,94,73,92,77,51,77,86,8,77,90,90,87,90,34},24), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({51,77,86,8,86,87,92,8,73,75,92,81,94,77,20,8,73,75,92,81,94,73,92,81,86,79},24))
activateKen()
end
end)
if not ok then debug(_d({51,77,86,51,77,77,88,77,90,8,77,90,90,87,90,34},24), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({51,77,86,8,83,77,77,88,77,90,8,91,92,87,88,88,77,76},24))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({54,56,43,91},24)) end)
if ok then return folder end
debug(_d({79,77,92,54,56,43,91,46,87,84,76,77,90,8,77,90,90,87,90,34},24), folder)
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
local r = model:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local h = model:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
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
debug(_d({79,77,92,54,77,73,90,77,91,92,54,56,43,8,77,90,90,87,90,34},24), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
local hum  = model:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({79,77,92,54,56,43,42,97,54,73,85,77,8,77,90,90,87,90,34},24), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({86,88,75,91,58,77,85,73,81,86,81,86,79,8,77,90,90,87,90,34},24), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({43,93,88,81,76,8,57,93,77,77,86},24))
return queen ~= nil and queen:FindFirstChild(_d({85,87,92,81,87,86,52,77,91,91},24)) ~= nil
end)
if ok then return result end
debug(_d({81,91,57,93,77,77,86,56,80,73,91,77,26,8,77,90,90,87,90,34},24), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,25,26,25,26,33,31,33,28,26,26,33,26,31,30,33},24)
local QUEEN_GRASP_ANIM_ID   = _d({90,74,96,73,91,91,77,92,81,76,34,23,23,25,26,33,32,24,24,24,30,25,24,24,25,31,27,28},24)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
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
debug(_d({81,91,56,84,73,97,81,86,79,41,86,81,85,46,90,87,85,52,81,91,92,8,77,90,90,87,90,34},24), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({42,84,87,75,83,81,86,79},24)) ~= nil
end)
if ok then return result end
debug(_d({81,91,54,56,43,42,84,87,75,83,81,86,79,8,77,90,90,87,90,34},24), result)
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
debug(_d({88,90,77,76,81,75,92,54,56,43,56,87,91,81,92,81,87,86,8,77,90,90,87,90,34},24), result)
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
debug(_d({54,87,8,76,73,85,73,79,77,8,87,86},24), model.Name, _d({78,87,90},24), NPC_STUCK_TIMEOUT, _d({91,8,21,8,91,95,81,92,75,80,81,86,79,8,92,73,90,79,77,92},24))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({92,90,73,75,83,54,56,43,44,73,85,73,79,77,8,77,90,90,87,90,34},24), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({53,87,76,77,84},24)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({42,73,91,77,56,73,90,92},24)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({79,77,92,53,87,76,77,84,46,73,75,77,56,87,91,8,77,90,90,87,90,34},24), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({45,86,94},24))
local folder = env and env:FindFirstChild(_d({59,92,73,92,93,77,91},24))
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
debug(_d({79,77,92,59,92,73,92,93,77,53,87,76,77,84,54,77,73,90,8,77,90,90,87,90,34},24), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({74,73,90,90,77,84,48,56},24))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({79,77,92,59,92,73,92,93,77,48,56,8,77,90,90,87,90,34},24), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({60,87,87,84},24)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({78,81,86,76,60,87,87,84,42,97,41,92,92,90,81,74,93,92,77,8,77,90,90,87,90,34},24), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({60,87,87,84},24)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({78,81,86,76,60,87,87,84,42,97,54,73,85,77,8,77,90,90,87,90,34},24), tool)
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
if not ok then debug(_d({77,89,93,81,88,60,87,87,84,8,77,90,90,87,90,34},24), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({42,73,75,83,88,73,75,83},24))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({60,87,87,84},24)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({78,81,86,76,60,87,87,84,42,97,43,80,81,84,76,54,73,85,77,8,77,90,90,87,90,34},24), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({59,95,87,90,76,45,89,93,81,88},24))
if sword then
equipTool(sword)
return _d({91,95,87,90,76},24)
end
local melee = findToolByAttribute(_d({53,77,84,77,77,60,87,87,84},24))
if melee then
equipTool(melee)
return _d({85,77,84,77,77},24)
end
debug(_d({54,87,8,91,95,87,90,76,8,87,90,8,85,77,84,77,77,8,92,87,87,84,8,78,87,93,86,76},24))
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
if not ok then debug(_d({75,84,81,75,83,53,25,8,77,90,90,87,90,34},24), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({58,87,83,93,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,77,88,88,87},24), args)
elseif style == _d({42,84,73,75,83,52,77,79},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83},24), args)
elseif style == _d({51,73,85,81,91,80,81,83,81},24) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({51,73,85,81,91,80,81,83,81,47,77,88,88,87},24), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,83,97,8,63,73,84,83,26},24), args)
end
end)
if not ok then debug(_d({81,86,94,87,83,77,47,77,88,88,87,8,77,90,90,87,90,34},24), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({88,90,77,91,91,59,83,81,84,84,58,8,77,90,90,87,90,34},24), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({80,87,84,76,42,84,87,75,83,8,77,90,90,87,90,34},24), err) end
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
if not ok then debug(_d({80,87,84,76,42,84,87,75,83,63,80,81,84,77,8,77,90,90,87,90,34},24), err) end
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
debug(_d({79,77,92,47,73,85,77,47,8,77,90,90,87,90,34},24), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({81,91,58,77,73,84,53,25,42,93,91,97,8,77,90,90,87,90,34},24), result)
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
return char ~= nil and char:FindFirstChild(_d({91,92,93,86},24)) ~= nil
end)
if ok then return result end
debug(_d({81,91,59,92,93,86,86,77,76,8,77,90,90,87,90,34},24), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({88,90,77,91,91,59,92,93,86,42,90,77,73,83,8,77,90,90,87,90,34},24), err) end
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
debug(_d({89,93,77,77,86,44,87,76,79,77,61,86,92,81,84,59,73,78,77,34,8,57,93,77,77,86,8,79,87,86,77,8,21,8,77,86,76,81,86,79,8,76,87,76,79,77,8,77,73,90,84,97},24))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({89,93,77,77,86,44,87,76,79,77,61,86,92,81,84,59,73,78,77,8,91,73,78,77,92,97,8,92,81,85,77,87,93,92},24))
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
local info = getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({57,93,77,77,86,8,75,73,91,92,81,86,79,8,76,77,92,77,75,92,77,76,8,21,8,76,87,76,79,81,86,79,8,16,95,73,92,75,80,77,90,17},24))
queenDodgeUntilSafe(function() return getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24)) end)
if enabled and getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24)) then
setNavNamed(_d({43,93,88,81,76,8,57,93,77,77,86},24))
end
queenDodging = false
end
end)
if not ok then debug(_d({89,93,77,77,86,44,87,76,79,77,63,73,92,75,80,77,90,8,77,90,90,87,90,34},24), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({88,87,81,86,92},24) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({86,88,75},24) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({86,73,85,77,76},24) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({79,77,92,54,73,94,60,73,90,79,77,92,91,8,77,90,90,87,90,34},24), aimR)
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
debug(_d({75,87,85,88,93,92,77,52,87,75,83,77,76,43,46,90,73,85,77,8,77,90,90,87,90,34},24), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({88,87,81,86,92},24), point = pos}
phase = _d({85,87,94,77},24)
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
if not ok then debug(_d({86,73,94,60,87,56,87,81,86,92,8,79,77,88,88,87,8,75,80,77,75,83,8,77,90,90,87,90,34},24), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({86,88,75},24)}
phase = _d({85,87,94,77},24)
end
function setNavNamed(name)
NavState = {mode = _d({86,73,85,77,76},24), name = name}
phase = _d({85,87,94,77},24)
end
local function setNavIdle()
NavState = {mode = _d({81,76,84,77},24)}
phase = _d({85,87,94,77},24)
end
local function hasArrived()
return phase == _d({80,87,94,77,90},24)
end
local function startNav()
phase = _d({85,87,94,77},24)
debug(_d({54,73,94,8,84,87,87,88,8,55,54},24))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({56,84,73,97,77,90,8,76,81,77,76,9,8,59,92,87,88,88,81,86,79,8,74,87,92,22},24))
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
debug(_d({56,84,73,97,77,90,8,81,91,8,92,87,87,8,78,73,90,8,78,90,87,85,8,92,73,90,79,77,92,8,16,38,26,24,24,24,8,91,92,93,76,91,17,22,8,52,81,83,77,84,97,8,90,77,91,88,73,95,86,77,76,8,73,92,8,84,87,74,74,97,22,8,59,92,87,88,88,81,86,79,8,74,87,92,22},24))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({71,71,88,90,77,94,56,87,91},24))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({52,73,90,79,77,8,88,87,91,81,92,81,87,86,8,82,93,85,88,8,76,77,92,77,75,92,77,76,34},24), delta, _d({91,92,93,76,91,22,8,88,90,77,94,56,87,91,37},24), prevPos, _d({86,77,95,56,87,91,37},24), pos)
end
end
force:SetAttribute(_d({71,71,88,90,77,94,56,87,91},24), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({85,87,94,77},24) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({80,87,94,77,90},24)
debug(_d({56,80,73,91,77,34,8,80,87,94,77,90},24))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({9,9,9,8,58,45,46,61,59,49,54,47,8,60,55,8,41,56,56,52,65,8,41,42,54,55,58,53,41,52,8,62,45,52,55,43,49,60,65,34},24), finalVel, _d({73,81,85,37},24), aim, _d({88,87,91,37},24), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({80,87,94,77,90},24) then
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
debug(_d({43,87,85,74,73,92,8,84,87,75,83,8,91,83,81,88,88,77,76,20},24), snapDist, _d({91,92,93,76,91,8,78,90,87,85,8,92,73,90,79,77,92,8,202,104,124,8,78,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,85,87,94,77},24))
phase = _d({85,87,94,77},24)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({48,77,73,90,92,74,77,73,92,8,77,90,90,87,90,34},24), err) end
end)
end
local function stopNav()
debug(_d({54,73,94,8,84,87,87,88,8,55,46,46},24))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({85,87,94,77},24)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({60,77,96,92,43,80,73,92,59,77,90,94,81,75,77},24))
local channels = TextChatService:FindFirstChild(_d({60,77,96,92,43,80,73,86,86,77,84,91},24))
local channel = channels and channels:FindFirstChild(_d({58,42,64,47,77,86,77,90,73,84},24))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({44,77,78,73,93,84,92,43,80,73,92,59,97,91,92,77,85,43,80,73,92,45,94,77,86,92,91},24))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({59,73,97,53,77,91,91,73,79,77,58,77,89,93,77,91,92},24))
if sayEvent then
sayEvent:FireServer(message, _d({41,84,84},24))
return
end
debug(_d({91,77,86,76,43,80,73,92,53,77,91,91,73,79,77,34,8,86,87,8,60,77,96,92,43,80,73,92,59,77,90,94,81,75,77,22,58,42,64,47,77,86,77,90,73,84,8,87,90,8,84,77,79,73,75,97,8,59,73,97,53,77,91,91,73,79,77,58,77,89,93,77,91,92,8,78,87,93,86,76,8,78,87,90},24), message)
end)
if not ok then debug(_d({91,77,86,76,43,80,73,92,53,77,91,91,73,79,77,8,77,90,90,87,90,34},24), err) end
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
debug(_d({54,87,92,8,85,73,83,81,86,79,8,88,90,87,79,90,77,91,91,8,92,87,95,73,90,76,8,86,73,94,8,92,73,90,79,77,92,8,78,87,90},24), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({91,8,21,8,91,77,86,76,81,86,79,8,23,93,86,91,92,93,75,83},24))
sendChatMessage(_d({23,93,86,91,92,93,75,83},24))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({95,73,81,92,61,86,92,81,84,41,90,90,81,94,77,76,8,92,81,85,77,87,93,92},24))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({86,73,94,60,87,56,87,81,86,92,43,87,86,78,81,90,85,77,76,34},24), label or _d({92,73,90,79,77,92},24), _d({21,8,76,81,76,8,86,87,92,8,73,90,90,81,94,77,8,95,81,92,80,81,86},24), timeout, _d({91,20,8,90,77,92,90,97,81,86,79,8,87,86,75,77},24))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({86,73,94,60,87,56,87,81,86,92,43,87,86,78,81,90,85,77,76,34},24), label or _d({92,73,90,79,77,92},24), _d({21,8,91,92,81,84,84,8,86,87,92,8,73,90,90,81,94,77,76,8,73,78,92,77,90,8,90,77,92,90,97,20,8,88,90,87,75,77,77,76,81,86,79,8,73,86,97,95,73,97},24))
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
if not ok then debug(_d({86,73,94,60,87,56,87,81,86,92,48,87,84,76,81,86,79,42,84,87,75,83,8,83,77,97,21,76,87,95,86,8,77,90,90,87,90,34},24), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({86,73,94,60,87,56,87,81,86,92,48,87,84,76,81,86,79,42,84,87,75,83,8,83,77,97,21,93,88,8,77,90,90,87,90,34},24), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({63,73,84,83,81,86,79,8,92,87,34},24), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({95,73,84,83,60,87,56,87,81,86,92,8,63,8,76,87,95,86,8,77,90,90,87,90,34},24), err) end
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
debug(_d({60,87,87,83,8,76,73,85,73,79,77,8,95,80,81,84,77,8,95,73,84,83,81,86,79,8,92,87,8,88,87,81,86,92,9,8,59,92,87,88,88,81,86,79,8,95,73,84,83,8,92,87,8,77,86,79,73,79,77,22},24))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({41,90,90,81,94,77,76,8,73,92,34},24), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({59,92,93,75,83,8,76,93,90,81,86,79,8,95,73,84,83,20,8,82,93,85,88,81,86,79,9},24))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({59,92,81,84,84,8,91,92,93,75,83,20,8,92,90,81,79,79,77,90,81,86,79,8,47,77,88,88,87,9},24))
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
debug(_d({53,87,94,81,86,79,8,92,87},24), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({63,73,81,92,81,86,79,8,78,87,90,8,54,56,43,91,8,92,87,8,91,88,73,95,86,8,73,92},24), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({8,8,91,88,73,95,86,8,75,80,77,75,83,34,8,78,87,84,76,77,90,8,77,96,81,91,92,91,8,37},24), folder ~= nil,
_d({20,8,75,80,81,84,76,90,77,86,8,37},24), folder and #folder:GetChildren() or 0,
_d({20,8,73,84,81,94,77,8,37},24), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({54,87,8,54,56,43,91,8,73,88,88,77,73,90,77,76,8,73,92},24), stageName, _d({73,78,92,77,90,8,25,29,91,20,8,85,87,94,81,86,79,8,87,86,8,73,86,97,95,73,97},24))
break
end
end
debug(_d({51,81,84,84,81,86,79,8,54,56,43,91,8,73,92},24), stageName)
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
debug(_d({58,77,92,93,90,86,81,86,79,8,92,87},24), stageName, _d({88,87,91,81,92,81,87,86,8,74,77,78,87,90,77,8,85,87,94,81,86,79,8,87,86},24))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({63,73,81,92,81,86,79,8,29,91,8,73,92},24), stageName, _d({88,87,91,81,92,81,87,86},24))
task.wait(5)
debug(_d({63,73,81,92,81,86,79,8,78,87,90},24), targetHP * 100, _d({13,8,48,56,8,74,77,78,87,90,77,8,85,87,94,81,86,79,8,92,87,8,86,77,96,92,8,91,92,73,79,77},24))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({75,84,77,73,90,77,76},24))
end
local function killNamedNPC(name, targetPos)
debug(_d({53,87,94,81,86,79,8,92,87},24), name)
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
debug(name, _d({76,77,78,77,73,92,77,76},24))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({48,93,85,73,86,87,81,76},24))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({52,77,87,8,88,84,73,97,77,76,8,73,86,81,85,73,92,81,87,86,34},24), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({84,77,87,41,86,81,85,52,87,79,79,77,90,8,88,90,81,86,92,8,77,90,90,87,90,34},24), err2) end
end)
end)
if not ok then debug(_d({91,92,73,90,92,52,77,87,41,86,81,85,52,87,79,79,77,90,8,77,90,90,87,90,34},24), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({53,87,94,81,86,79,8,92,87,8,52,77,87},24))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({52,77,87},24))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({52,77,87},24))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({52,77,87},24))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({52,77,87,8,75,73,91,92,81,86,79},24), which, _d({21,8,76,87,76,79,81,86,79},24))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({52,77,87,8,91,92,73,90,92,77,76,8,74,84,87,75,83,21,74,90,77,73,83,77,90,8,85,81,76,21,74,84,87,75,83,9,8,45,94,73,76,81,86,79,22,22,22},24))
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
if not getNPCByName(_d({52,77,87},24)) then
debug(_d({52,77,87,8,79,87,86,77,8,85,81,76,21,76,87,76,79,77,8,21,8,77,86,76,81,86,79,8,45,86,92,77,81,8,80,87,84,76,8,77,73,90,84,97},24))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({52,77,87},24)) then
setNavNamed(_d({52,77,87},24))
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
debug(_d({52,77,87,8,76,77,78,77,73,92,77,76},24))
stopLeoAnimLogger()
debug(_d({58,77,92,93,90,86,81,86,79,8,92,87,8,52,77,87,8,88,87,91,81,92,81,87,86,8,74,77,78,87,90,77,8,85,87,94,81,86,79,8,87,86},24))
navToPointConfirmed(COORDS.Leo, 30, _d({52,77,87,8,88,87,91,81,92,81,87,86},24))
debug(_d({63,73,81,92,81,86,79,8,29,91,8,73,92,8,52,77,87,8,88,87,91,81,92,81,87,86},24))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({53,87,94,81,86,79,8,92,87},24), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({43,87,93,84,76,8,86,87,92,8,78,81,86,76,8,91,92,73,92,93,77,8,85,87,76,77,84,8,86,77,73,90},24), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({41,92,92,73,75,83,81,86,79},24), coordKey, _d({95,81,92,80},24), weapon or _d({86,87,92,80,81,86,79,8,78,87,93,86,76},24))
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
debug(coordKey, _d({74,73,90,90,77,84,8,76,77,91,92,90,87,97,77,76},24))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({90,77,75,80,77,75,83,59,92,73,92,93,77,34},24), coordKey, _d({21,8,75,87,93,84,76,8,86,87,92,8,78,81,86,76,8,91,92,73,92,93,77,8,85,87,76,77,84,20,8,91,83,81,88,88,81,86,79},24))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({90,77,75,80,77,75,83,59,92,73,92,93,77,34},24), coordKey, _d({91,92,81,84,84,8,73,84,81,94,77,8,16,48,56},24), hp, _d({17,8,21,8,90,77,21,76,77,91,92,90,87,97,81,86,79},24))
destroyStatue(coordKey)
else
debug(_d({90,77,75,80,77,75,83,59,92,73,92,93,77,34},24), coordKey, _d({75,87,86,78,81,90,85,77,76,8,76,77,91,92,90,87,97,77,76},24))
end
end)
if not ok then debug(_d({90,77,75,80,77,75,83,59,92,73,92,93,77,8,77,90,90,87,90,34},24), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({53,87,94,81,86,79,8,92,87,8,57,93,77,77,86},24))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({43,93,88,81,76,8,57,93,77,77,86},24))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24))
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
debug(_d({57,93,77,77,86,8,77,86,92,77,90,77,76,8,88,80,73,91,77,8,26},24))
end
local function finishQueen()
debug(_d({46,81,86,81,91,80,81,86,79,8,57,93,77,77,86},24))
equipSwordOrMelee()
setNavNamed(_d({43,93,88,81,76,8,57,93,77,77,86},24))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({43,93,88,81,76,8,57,93,77,77,86},24))
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
debug(_d({57,93,77,77,86,8,76,77,78,77,73,92,77,76,22,8,56,84,73,86,8,75,87,85,88,84,77,92,77,22},24))
end
local CONFIRMATION_PROMPT_NAME = _d({43,87,86,78,81,90,85,73,92,81,87,86,56,90,87,85,88,92},24)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({58,77,85,87,92,77,45,94,77,86,92},24), 5)
end)
if ok then return result end
debug(_d({79,77,92,58,77,88,84,73,97,58,77,85,87,92,77,8,77,90,90,87,90,34},24), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({56,84,73,97,77,90,47,93,81},24))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({49,85,73,79,77,42,93,92,92,87,86},24)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({74,93,92,92,87,86,62,73,84,93,77},24)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({78,81,86,76,42,93,92,92,87,86,42,97,62,73,84,93,77,8,77,90,90,87,90,34},24), result)
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
if not ok then debug(_d({75,84,81,75,83,47,93,81,42,93,92,92,87,86,8,77,90,90,87,90,34},24), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({81,91,59,77,90,94,77,90},24))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({58,77,85,87,92,77,45,94,77,86,92},24))
or inst:FindFirstChild(_d({75,84,81,77,86,92,45,94,77,86,92},24))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({78,81,86,76,41,86,91,95,77,90,43,87,86,86,77,75,92,87,90,8,77,90,90,87,90,34},24), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({43,87,93,84,76,8,86,87,92,8,84,87,75,73,92,77,8,58,77,85,87,92,77,45,94,77,86,92,23,75,84,81,77,86,92,45,94,77,86,92,8,86,77,73,90,8,58,77,88,84,73,97,8,74,93,92,92,87,86,20,8,78,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,75,84,81,75,83},24))
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
debug(_d({78,81,90,77,58,77,88,84,73,97,62,73,84,93,77,8,77,90,90,87,90,34},24), err, _d({21,8,78,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,75,84,81,75,83},24))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({46,73,84,84,81,86,79,8,74,73,75,83,8,92,87,8,74,93,92,92,87,86,62,73,84,93,77,8,91,77,73,90,75,80,8,78,87,90,8,58,77,88,84,73,97},24))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({58,77,88,84,73,97,8,74,93,92,92,87,86,8,86,87,92,8,78,87,93,86,76,8,77,81,92,80,77,90,20,8,79,81,94,81,86,79,8,93,88},24))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({63,73,81,92,81,86,79,8,78,87,90,8,43,87,86,78,81,90,85,73,92,81,87,86,56,90,87,85,88,92,22,58,77,85,87,92,77,45,94,77,86,92},24))
local remote = getReplayRemote()
if not remote then
debug(_d({43,87,86,78,81,90,85,73,92,81,87,86,56,90,87,85,88,92,23,58,77,85,87,92,77,45,94,77,86,92,8,86,87,92,8,78,87,93,86,76,8,95,81,92,80,81,86,8,92,81,85,77,87,93,92},24))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({46,81,90,81,86,79,8,58,77,88,84,73,97,8,94,81,73,8,43,87,86,78,81,90,85,73,92,81,87,86,56,90,87,85,88,92,22,58,77,85,87,92,77,45,94,77,86,92},24))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({46,81,90,77,59,77,90,94,77,90,8,77,90,90,87,90,34},24), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({56,84,73,97,77,90,47,93,81},24), 10)
if not playerGui then
debug(_d({95,73,81,92,46,87,90,55,74,82,77,75,92,81,94,77,91,47,93,81,34,8,86,87,8,56,84,73,97,77,90,47,93,81,8,95,81,92,80,81,86,8,92,81,85,77,87,93,92,20,8,88,90,87,75,77,77,76,81,86,79,8,73,86,97,95,73,97},24))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({55,74,82,77,75,92,81,94,77,91,8,47,61,49,8,78,87,93,86,76,8,21,8,91,92,73,79,77,8,84,87,73,76,77,76},24))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({55,74,82,77,75,92,81,94,77,91,8,47,61,49,8,86,87,92,8,78,87,93,86,76,8,95,81,92,80,81,86,8,92,81,85,77,87,93,92,20,8,88,90,87,75,77,77,76,81,86,79,8,73,86,97,95,73,97},24))
return
end
end
end)
if not ok then debug(_d({95,73,81,92,46,87,90,55,74,82,77,75,92,81,94,77,91,47,93,81,8,77,90,90,87,90,34},24), err) end
end
local function runPlan()
debug(_d({56,84,73,86,8,91,92,73,90,92,77,76},24))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({59,92,73,90,92,81,86,79,8,86,73,94,8,84,87,87,88},24))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({88,87,91,8,24,22,26,91,8,41,46,60,45,58,8,91,92,73,90,92,54,73,94,34},24), rootAfter and rootAfter.Position)
end)
debug(_d({63,73,81,92,81,86,79,8,29,91,8,74,77,78,87,90,77,8,85,87,94,81,86,79,8,92,87,8,59,92,73,79,77,25},24))
task.wait(5)
for _, stage in ipairs({_d({59,92,73,79,77,25},24), _d({59,92,73,79,77,26},24), _d({59,92,73,79,77,27},24), _d({59,92,73,79,77,27,42},24)}) do
if not enabled then return end
local hpTarget = (stage == _d({59,92,73,79,77,27,42},24)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({53,87,94,81,86,79,8,92,87,8,73,90,90,87,95,8,78,84,97,21,76,87,95,86,8,73,90,77,73,8,16,43,93,88,81,76,8,58,73,81,86,17},24))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({44,87,76,79,81,86,79,8,73,90,90,87,95,8,90,73,81,86,8,81,86,8,73,8,91,89,93,73,90,77},24))
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
clearStage(_d({59,92,73,79,77,28},24))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({57,93,77,77,86,8,81,86,8,88,80,73,91,77,8,26,8,21,8,83,77,77,88,81,86,79,8,51,77,86,8,48,73,83,81,8,73,75,92,81,94,77,8,78,90,87,85,8,80,77,90,77,8,87,86},24))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({59,92,73,92,93,77,25},24))
if not enabled then return end
recheckStatue(_d({59,92,73,92,93,77,25},24))
destroyStatue(_d({59,92,73,92,93,77,26},24))
if not enabled then return end
recheckStatue(_d({59,92,73,92,93,77,25},24))
recheckStatue(_d({59,92,73,92,93,77,26},24))
destroyStatue(_d({59,92,73,92,93,77,27},24))
if not enabled then return end
recheckStatue(_d({59,92,73,92,93,77,27},24))
recheckStatue(_d({59,92,73,92,93,77,26},24))
recheckStatue(_d({59,92,73,92,93,77,25},24))
if not enabled then return end
debug(_d({63,73,81,92,81,86,79,8,78,87,90,8,88,80,73,91,77,8,26,8,92,87,8,77,86,76},24))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({56,80,73,91,77,8,26,8,77,86,76,8,95,73,81,92,8,92,81,85,77,87,93,92,20,8,88,90,87,75,77,77,76,81,86,79,8,73,86,97,95,73,97},24))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({53,87,94,81,86,79,8,74,73,75,83,8,92,87,8,57,93,77,77,86,8,91,92,73,79,77,8,88,87,91,81,92,81,87,86},24))
navToPointConfirmed(COORDS.Queen, 30, _d({57,93,77,77,86,8,91,92,73,79,77,8,88,87,91,81,92,81,87,86},24))
debug(_d({63,73,81,92,81,86,79,8,29,91,8,73,92,8,57,93,77,77,86,8,91,92,73,79,77,8,88,87,91,81,92,81,87,86},24))
task.wait(5)
if not enabled then return end
debug(_d({53,87,94,81,86,79,8,92,87,8,88,87,91,92,21,57,93,77,77,86,8,88,87,91,81,92,81,87,86},24))
navToPointConfirmed(COORDS.PostQueen, 30, _d({88,87,91,92,21,57,93,77,77,86,8,88,87,91,81,92,81,87,86},24))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({45,86,73,74,84,81,86,79,20,8,88,87,91,8,42,45,46,55,58,45,8,88,84,73,86,34},24), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({56,84,73,86,8,77,90,90,87,90,34},24), err2) end
end)
debug(_d({45,86,73,74,84,77,76,34},24), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({45,86,73,74,84,77,76,34},24), enabled)
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
if not ok then debug(_d({49,86,88,93,92,42,77,79,73,86,8,77,90,90,87,90,34},24), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({47,73,85,77,8,84,87,73,76,77,76,20,8,73,93,92,87,21,91,92,73,90,92,81,86,79,8,92,80,77,8,88,84,73,86},24))
enableBot()
end)
if not ok then debug(_d({41,93,92,87,91,92,73,90,92,8,77,90,90,87,90,34},24), err) end
end)
debug(_d({52,87,73,76,77,76,8,202,104,124,8,73,93,92,87,21,91,92,73,90,92,81,86,79,8,87,86,75,77,8,92,80,77,8,79,73,85,77,8,78,81,86,81,91,80,77,91,8,84,87,73,76,81,86,79,8,16,88,90,77,91,91,8,56,8,92,87,8,92,87,79,79,84,77,8,85,73,86,93,73,84,84,97,17},24))
end)()