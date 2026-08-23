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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({54,82,71,95,75,88,89},26))
local UserInputService    = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local RunService          = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM                 = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local ReplicatedStorage    = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({65,40,85,89,89,40,85,90,67},26), _d({61,88,85,84,77,6,77,71,83,75,6,200,102,122,6,54,82,71,73,75,47,74,32},26), game.PlaceId, _d({59,84,79,92,75,88,89,75,47,74,32},26), game.GameId, _d({19,6,84,85,90,6,88,91,84,84,79,84,77},26))
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
local LEO_PILLAR_ANIM_ID   = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,27,24,26,26,23,26,23,25,24,29},26)
local LEO_ENTEI_ANIM_ID    = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,27,24,26,26,23,25,30,24,29,30},26)
local LEO_HIKEN_ANIM_ID    = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,27,24,24,22,31,23,29,26,22,29},26)
local LEO_FIREFLY_ANIM_ID  = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,27,24,24,22,24,25,28,23,27,26},26)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({53,72,80,75,73,90,79,92,75,89},26)
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
local REPLAY_BUTTON_VALUE   = _d({56,75,86,82,71,95},26)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({83,85,92,75},26)
local NavState   = {mode = _d({79,74,82,75},26)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({65,40,85,89,89,40,85,90,67},26), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end)
if ok then return root end
debug(_d({77,75,90,56,85,85,90,6,75,88,88,85,88,32},26), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end)
if ok then return hum end
debug(_d({77,75,90,46,91,83,71,84,85,79,74,6,75,88,88,85,88,32},26), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__HoverAtt_d({15,6,85,88,6,47,84,89,90,71,84,73,75,20,84,75,93,14},26)Attachment")
att.Name = _d({69,69,46,85,92,75,88,39,90,90},26)
att.Parent = root
local force = root:FindFirstChild(_d({69,69,46,85,92,75,88,44,85,88,73,75},26))
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
force.Name = _d({69,69,46,85,92,75,88,44,85,88,73,75},26)
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
debug(_d({77,75,90,53,88,41,88,75,71,90,75,44,85,88,73,75,6,75,88,88,85,88,32},26), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local force = root:FindFirstChild(_d({69,69,46,85,92,75,88,44,85,88,73,75},26))
local att   = root:FindFirstChild(_d({69,69,46,85,92,75,88,39,90,90},26))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({73,82,75,71,84,91,86,44,85,88,73,75,6,75,88,88,85,88,32},26), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({40,91,89,85,51,75,82,75,75},26)) ~= nil
end)
if ok then return result end
debug(_d({79,89,40,91,89,85,39,73,90,79,92,75,6,75,88,88,85,88,32},26), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({40,91,89,85},26))
end)
if not ok then debug(_d({71,73,90,79,92,71,90,75,40,91,89,85,6,75,88,88,85,88,32},26), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({40,91,89,85,6,84,85,90,6,71,73,90,79,92,75,18,6,71,73,90,79,92,71,90,79,84,77},26))
activateBuso()
end
end)
if not ok then debug(_d({40,91,89,85,49,75,75,86,75,88,6,75,88,88,85,88,32},26), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({40,91,89,85,6,81,75,75,86,75,88,6,89,90,85,86,86,75,74},26))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({49,75,84,46,71,81,79},26)) ~= nil
end)
if ok then return result end
debug(_d({79,89,49,75,84,39,73,90,79,92,75,6,75,88,88,85,88,32},26), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({49,75,84},26), true)
end)
if not ok then debug(_d({71,73,90,79,92,71,90,75,49,75,84,6,75,88,88,85,88,32},26), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({49,75,84,6,84,85,90,6,71,73,90,79,92,75,18,6,71,73,90,79,92,71,90,79,84,77},26))
activateKen()
end
end)
if not ok then debug(_d({49,75,84,49,75,75,86,75,88,6,75,88,88,85,88,32},26), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({49,75,84,6,81,75,75,86,75,88,6,89,90,85,86,86,75,74},26))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({52,54,41,89},26)) end)
if ok then return folder end
debug(_d({77,75,90,52,54,41,89,44,85,82,74,75,88,6,75,88,88,85,88,32},26), folder)
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
local r = model:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local h = model:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
debug(_d({77,75,90,52,75,71,88,75,89,90,52,54,41,6,75,88,88,85,88,32},26), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum  = model:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({77,75,90,52,54,41,40,95,52,71,83,75,6,75,88,88,85,88,32},26), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({84,86,73,89,56,75,83,71,79,84,79,84,77,6,75,88,88,85,88,32},26), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({41,91,86,79,74,6,55,91,75,75,84},26))
return queen ~= nil and queen:FindFirstChild(_d({83,85,90,79,85,84,50,75,89,89},26)) ~= nil
end)
if ok then return result end
debug(_d({79,89,55,91,75,75,84,54,78,71,89,75,24,6,75,88,88,85,88,32},26), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,23,24,23,24,31,29,31,26,24,24,31,24,29,28,31},26)
local QUEEN_GRASP_ANIM_ID   = _d({88,72,94,71,89,89,75,90,79,74,32,21,21,23,24,31,30,22,22,22,28,23,22,22,23,29,25,26},26)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
debug(_d({79,89,54,82,71,95,79,84,77,39,84,79,83,44,88,85,83,50,79,89,90,6,75,88,88,85,88,32},26), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({40,82,85,73,81,79,84,77},26)) ~= nil
end)
if ok then return result end
debug(_d({79,89,52,54,41,40,82,85,73,81,79,84,77,6,75,88,88,85,88,32},26), result)
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
debug(_d({86,88,75,74,79,73,90,52,54,41,54,85,89,79,90,79,85,84,6,75,88,88,85,88,32},26), result)
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
debug(_d({52,85,6,74,71,83,71,77,75,6,85,84},26), model.Name, _d({76,85,88},26), NPC_STUCK_TIMEOUT, _d({89,6,19,6,89,93,79,90,73,78,79,84,77,6,90,71,88,77,75,90},26))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({90,88,71,73,81,52,54,41,42,71,83,71,77,75,6,75,88,88,85,88,32},26), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({51,85,74,75,82},26)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({40,71,89,75,54,71,88,90},26)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({77,75,90,51,85,74,75,82,44,71,73,75,54,85,89,6,75,88,88,85,88,32},26), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({43,84,92},26))
local folder = env and env:FindFirstChild(_d({57,90,71,90,91,75,89},26))
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
debug(_d({77,75,90,57,90,71,90,91,75,51,85,74,75,82,52,75,71,88,6,75,88,88,85,88,32},26), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({72,71,88,88,75,82,46,54},26))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({77,75,90,57,90,71,90,91,75,46,54,6,75,88,88,85,88,32},26), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({58,85,85,82},26)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({76,79,84,74,58,85,85,82,40,95,39,90,90,88,79,72,91,90,75,6,75,88,88,85,88,32},26), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({58,85,85,82},26)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({76,79,84,74,58,85,85,82,40,95,52,71,83,75,6,75,88,88,85,88,32},26), tool)
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
if not ok then debug(_d({75,87,91,79,86,58,85,85,82,6,75,88,88,85,88,32},26), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({58,85,85,82},26)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({76,79,84,74,58,85,85,82,40,95,41,78,79,82,74,52,71,83,75,6,75,88,88,85,88,32},26), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({57,93,85,88,74,43,87,91,79,86},26))
if sword then
equipTool(sword)
return _d({89,93,85,88,74},26)
end
local melee = findToolByAttribute(_d({51,75,82,75,75,58,85,85,82},26))
if melee then
equipTool(melee)
return _d({83,75,82,75,75},26)
end
debug(_d({52,85,6,89,93,85,88,74,6,85,88,6,83,75,82,75,75,6,90,85,85,82,6,76,85,91,84,74},26))
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
if not ok then debug(_d({73,82,79,73,81,51,23,6,75,88,88,85,88,32},26), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({56,85,81,91,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,75,86,86,85},26), args)
elseif style == _d({40,82,71,73,81,50,75,77},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81},26), args)
elseif style == _d({49,71,83,79,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,71,83,79,89,78,79,81,79,45,75,86,86,85},26), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81,24},26), args)
end
end)
if not ok then debug(_d({79,84,92,85,81,75,45,75,86,86,85,6,75,88,88,85,88,32},26), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({86,88,75,89,89,57,81,79,82,82,56,6,75,88,88,85,88,32},26), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({78,85,82,74,40,82,85,73,81,6,75,88,88,85,88,32},26), err) end
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
if not ok then debug(_d({78,85,82,74,40,82,85,73,81,61,78,79,82,75,6,75,88,88,85,88,32},26), err) end
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
debug(_d({77,75,90,45,71,83,75,45,6,75,88,88,85,88,32},26), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({79,89,56,75,71,82,51,23,40,91,89,95,6,75,88,88,85,88,32},26), result)
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
return char ~= nil and char:FindFirstChild(_d({89,90,91,84},26)) ~= nil
end)
if ok then return result end
debug(_d({79,89,57,90,91,84,84,75,74,6,75,88,88,85,88,32},26), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({86,88,75,89,89,57,90,91,84,40,88,75,71,81,6,75,88,88,85,88,32},26), err) end
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
debug(_d({87,91,75,75,84,42,85,74,77,75,59,84,90,79,82,57,71,76,75,32,6,55,91,75,75,84,6,77,85,84,75,6,19,6,75,84,74,79,84,77,6,74,85,74,77,75,6,75,71,88,82,95},26))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({87,91,75,75,84,42,85,74,77,75,59,84,90,79,82,57,71,76,75,6,89,71,76,75,90,95,6,90,79,83,75,85,91,90},26))
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
local info = getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({55,91,75,75,84,6,73,71,89,90,79,84,77,6,74,75,90,75,73,90,75,74,6,19,6,74,85,74,77,79,84,77,6,14,93,71,90,73,78,75,88,15},26))
queenDodgeUntilSafe(function() return getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26)) end)
if enabled and getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26)) then
setNavNamed(_d({41,91,86,79,74,6,55,91,75,75,84},26))
end
queenDodging = false
end
end)
if not ok then debug(_d({87,91,75,75,84,42,85,74,77,75,61,71,90,73,78,75,88,6,75,88,88,85,88,32},26), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({86,85,79,84,90},26) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({84,86,73},26) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({84,71,83,75,74},26) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({77,75,90,52,71,92,58,71,88,77,75,90,89,6,75,88,88,85,88,32},26), aimR)
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
debug(_d({73,85,83,86,91,90,75,50,85,73,81,75,74,41,44,88,71,83,75,6,75,88,88,85,88,32},26), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({86,85,79,84,90},26), point = pos}
phase = _d({83,85,92,75},26)
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
if not ok then debug(_d({84,71,92,58,85,54,85,79,84,90,6,77,75,86,86,85,6,73,78,75,73,81,6,75,88,88,85,88,32},26), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({84,86,73},26)}
phase = _d({83,85,92,75},26)
end
function setNavNamed(name)
NavState = {mode = _d({84,71,83,75,74},26), name = name}
phase = _d({83,85,92,75},26)
end
local function setNavIdle()
NavState = {mode = _d({79,74,82,75},26)}
phase = _d({83,85,92,75},26)
end
local function hasArrived()
return phase == _d({78,85,92,75,88},26)
end
local function startNav()
phase = _d({83,85,92,75},26)
debug(_d({52,71,92,6,82,85,85,86,6,53,52},26))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = getRoot()
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({54,82,71,95,75,88,6,74,79,75,74,7,6,57,90,85,86,86,79,84,77,6,72,85,90,20},26))
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
debug(_d({54,82,71,95,75,88,6,79,89,6,90,85,85,6,76,71,88,6,76,88,85,83,6,90,71,88,77,75,90,6,14,36,24,22,22,22,6,89,90,91,74,89,15,20,6,50,79,81,75,82,95,6,88,75,89,86,71,93,84,75,74,6,71,90,6,82,85,72,72,95,20,6,57,90,85,86,86,79,84,77,6,72,85,90,20},26))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({69,69,86,88,75,92,54,85,89},26))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({50,71,88,77,75,6,86,85,89,79,90,79,85,84,6,80,91,83,86,6,74,75,90,75,73,90,75,74,32},26), delta, _d({89,90,91,74,89,20,6,86,88,75,92,54,85,89,35},26), prevPos, _d({84,75,93,54,85,89,35},26), pos)
end
end
force:SetAttribute(_d({69,69,86,88,75,92,54,85,89},26), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({83,85,92,75},26) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({78,85,92,75,88},26)
debug(_d({54,78,71,89,75,32,6,78,85,92,75,88},26))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({7,7,7,6,56,43,44,59,57,47,52,45,6,58,53,6,39,54,54,50,63,6,39,40,52,53,56,51,39,50,6,60,43,50,53,41,47,58,63,32},26), finalVel, _d({71,79,83,35},26), aim, _d({86,85,89,35},26), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({78,85,92,75,88},26) then
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
debug(_d({41,85,83,72,71,90,6,82,85,73,81,6,89,81,79,86,86,75,74,18},26), snapDist, _d({89,90,91,74,89,6,76,88,85,83,6,90,71,88,77,75,90,6,200,102,122,6,76,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,83,85,92,75},26))
phase = _d({83,85,92,75},26)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({46,75,71,88,90,72,75,71,90,6,75,88,88,85,88,32},26), err) end
end)
end
local function stopNav()
debug(_d({52,71,92,6,82,85,85,86,6,53,44,44},26))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({83,85,92,75},26)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({58,75,94,90,41,78,71,90,57,75,88,92,79,73,75},26))
local channels = TextChatService:FindFirstChild(_d({58,75,94,90,41,78,71,84,84,75,82,89},26))
local channel = channels and channels:FindFirstChild(_d({56,40,62,45,75,84,75,88,71,82},26))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({42,75,76,71,91,82,90,41,78,71,90,57,95,89,90,75,83,41,78,71,90,43,92,75,84,90,89},26))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({57,71,95,51,75,89,89,71,77,75,56,75,87,91,75,89,90},26))
if sayEvent then
sayEvent:FireServer(message, _d({39,82,82},26))
return
end
debug(_d({89,75,84,74,41,78,71,90,51,75,89,89,71,77,75,32,6,84,85,6,58,75,94,90,41,78,71,90,57,75,88,92,79,73,75,20,56,40,62,45,75,84,75,88,71,82,6,85,88,6,82,75,77,71,73,95,6,57,71,95,51,75,89,89,71,77,75,56,75,87,91,75,89,90,6,76,85,91,84,74,6,76,85,88},26), message)
end)
if not ok then debug(_d({89,75,84,74,41,78,71,90,51,75,89,89,71,77,75,6,75,88,88,85,88,32},26), err) end
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
debug(_d({52,85,90,6,83,71,81,79,84,77,6,86,88,85,77,88,75,89,89,6,90,85,93,71,88,74,6,84,71,92,6,90,71,88,77,75,90,6,76,85,88},26), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({89,6,19,6,89,75,84,74,79,84,77,6,21,91,84,89,90,91,73,81},26))
sendChatMessage(_d({21,91,84,89,90,91,73,81},26))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({93,71,79,90,59,84,90,79,82,39,88,88,79,92,75,74,6,90,79,83,75,85,91,90},26))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({84,71,92,58,85,54,85,79,84,90,41,85,84,76,79,88,83,75,74,32},26), label or _d({90,71,88,77,75,90},26), _d({19,6,74,79,74,6,84,85,90,6,71,88,88,79,92,75,6,93,79,90,78,79,84},26), timeout, _d({89,18,6,88,75,90,88,95,79,84,77,6,85,84,73,75},26))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({84,71,92,58,85,54,85,79,84,90,41,85,84,76,79,88,83,75,74,32},26), label or _d({90,71,88,77,75,90},26), _d({19,6,89,90,79,82,82,6,84,85,90,6,71,88,88,79,92,75,74,6,71,76,90,75,88,6,88,75,90,88,95,18,6,86,88,85,73,75,75,74,79,84,77,6,71,84,95,93,71,95},26))
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
if not ok then debug(_d({84,71,92,58,85,54,85,79,84,90,46,85,82,74,79,84,77,40,82,85,73,81,6,81,75,95,19,74,85,93,84,6,75,88,88,85,88,32},26), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({84,71,92,58,85,54,85,79,84,90,46,85,82,74,79,84,77,40,82,85,73,81,6,81,75,95,19,91,86,6,75,88,88,85,88,32},26), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({61,71,82,81,79,84,77,6,90,85,32},26), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({93,71,82,81,58,85,54,85,79,84,90,6,61,6,74,85,93,84,6,75,88,88,85,88,32},26), err) end
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
debug(_d({58,85,85,81,6,74,71,83,71,77,75,6,93,78,79,82,75,6,93,71,82,81,79,84,77,6,90,85,6,86,85,79,84,90,7,6,57,90,85,86,86,79,84,77,6,93,71,82,81,6,90,85,6,75,84,77,71,77,75,20},26))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({39,88,88,79,92,75,74,6,71,90,32},26), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({57,90,91,73,81,6,74,91,88,79,84,77,6,93,71,82,81,18,6,80,91,83,86,79,84,77,7},26))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({57,90,79,82,82,6,89,90,91,73,81,18,6,90,88,79,77,77,75,88,79,84,77,6,45,75,86,86,85,7},26))
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
debug(_d({51,85,92,79,84,77,6,90,85},26), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({61,71,79,90,79,84,77,6,76,85,88,6,52,54,41,89,6,90,85,6,89,86,71,93,84,6,71,90},26), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({6,6,89,86,71,93,84,6,73,78,75,73,81,32,6,76,85,82,74,75,88,6,75,94,79,89,90,89,6,35},26), folder ~= nil,
_d({18,6,73,78,79,82,74,88,75,84,6,35},26), folder and #folder:GetChildren() or 0,
_d({18,6,71,82,79,92,75,6,35},26), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({52,85,6,52,54,41,89,6,71,86,86,75,71,88,75,74,6,71,90},26), stageName, _d({71,76,90,75,88,6,23,27,89,18,6,83,85,92,79,84,77,6,85,84,6,71,84,95,93,71,95},26))
break
end
end
debug(_d({49,79,82,82,79,84,77,6,52,54,41,89,6,71,90},26), stageName)
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
debug(_d({56,75,90,91,88,84,79,84,77,6,90,85},26), stageName, _d({86,85,89,79,90,79,85,84,6,72,75,76,85,88,75,6,83,85,92,79,84,77,6,85,84},26))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({61,71,79,90,79,84,77,6,27,89,6,71,90},26), stageName, _d({86,85,89,79,90,79,85,84},26))
task.wait(5)
debug(_d({61,71,79,90,79,84,77,6,76,85,88},26), targetHP * 100, _d({11,6,46,54,6,72,75,76,85,88,75,6,83,85,92,79,84,77,6,90,85,6,84,75,94,90,6,89,90,71,77,75},26))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({73,82,75,71,88,75,74},26))
end
local function killNamedNPC(name, targetPos)
debug(_d({51,85,92,79,84,77,6,90,85},26), name)
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
debug(name, _d({74,75,76,75,71,90,75,74},26))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({50,75,85,6,86,82,71,95,75,74,6,71,84,79,83,71,90,79,85,84,32},26), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({82,75,85,39,84,79,83,50,85,77,77,75,88,6,86,88,79,84,90,6,75,88,88,85,88,32},26), err2) end
end)
end)
if not ok then debug(_d({89,90,71,88,90,50,75,85,39,84,79,83,50,85,77,77,75,88,6,75,88,88,85,88,32},26), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({51,85,92,79,84,77,6,90,85,6,50,75,85},26))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({50,75,85},26))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({50,75,85},26))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({50,75,85},26))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({50,75,85,6,73,71,89,90,79,84,77},26), which, _d({19,6,74,85,74,77,79,84,77},26))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({50,75,85,6,89,90,71,88,90,75,74,6,72,82,85,73,81,19,72,88,75,71,81,75,88,6,83,79,74,19,72,82,85,73,81,7,6,43,92,71,74,79,84,77,20,20,20},26))
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
if not getNPCByName(_d({50,75,85},26)) then
debug(_d({50,75,85,6,77,85,84,75,6,83,79,74,19,74,85,74,77,75,6,19,6,75,84,74,79,84,77,6,43,84,90,75,79,6,78,85,82,74,6,75,71,88,82,95},26))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({50,75,85},26)) then
setNavNamed(_d({50,75,85},26))
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
debug(_d({50,75,85,6,74,75,76,75,71,90,75,74},26))
stopLeoAnimLogger()
debug(_d({56,75,90,91,88,84,79,84,77,6,90,85,6,50,75,85,6,86,85,89,79,90,79,85,84,6,72,75,76,85,88,75,6,83,85,92,79,84,77,6,85,84},26))
navToPointConfirmed(COORDS.Leo, 30, _d({50,75,85,6,86,85,89,79,90,79,85,84},26))
debug(_d({61,71,79,90,79,84,77,6,27,89,6,71,90,6,50,75,85,6,86,85,89,79,90,79,85,84},26))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({51,85,92,79,84,77,6,90,85},26), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({41,85,91,82,74,6,84,85,90,6,76,79,84,74,6,89,90,71,90,91,75,6,83,85,74,75,82,6,84,75,71,88},26), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({39,90,90,71,73,81,79,84,77},26), coordKey, _d({93,79,90,78},26), weapon or _d({84,85,90,78,79,84,77,6,76,85,91,84,74},26))
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
debug(coordKey, _d({72,71,88,88,75,82,6,74,75,89,90,88,85,95,75,74},26))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({88,75,73,78,75,73,81,57,90,71,90,91,75,32},26), coordKey, _d({19,6,73,85,91,82,74,6,84,85,90,6,76,79,84,74,6,89,90,71,90,91,75,6,83,85,74,75,82,18,6,89,81,79,86,86,79,84,77},26))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({88,75,73,78,75,73,81,57,90,71,90,91,75,32},26), coordKey, _d({89,90,79,82,82,6,71,82,79,92,75,6,14,46,54},26), hp, _d({15,6,19,6,88,75,19,74,75,89,90,88,85,95,79,84,77},26))
destroyStatue(coordKey)
else
debug(_d({88,75,73,78,75,73,81,57,90,71,90,91,75,32},26), coordKey, _d({73,85,84,76,79,88,83,75,74,6,74,75,89,90,88,85,95,75,74},26))
end
end)
if not ok then debug(_d({88,75,73,78,75,73,81,57,90,71,90,91,75,6,75,88,88,85,88,32},26), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({51,85,92,79,84,77,6,90,85,6,55,91,75,75,84},26))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({41,91,86,79,74,6,55,91,75,75,84},26))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26))
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
debug(_d({55,91,75,75,84,6,75,84,90,75,88,75,74,6,86,78,71,89,75,6,24},26))
end
local function finishQueen()
debug(_d({44,79,84,79,89,78,79,84,77,6,55,91,75,75,84},26))
equipSwordOrMelee()
setNavNamed(_d({41,91,86,79,74,6,55,91,75,75,84},26))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({41,91,86,79,74,6,55,91,75,75,84},26))
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
debug(_d({55,91,75,75,84,6,74,75,76,75,71,90,75,74,20,6,54,82,71,84,6,73,85,83,86,82,75,90,75,20},26))
end
local CONFIRMATION_PROMPT_NAME = _d({41,85,84,76,79,88,83,71,90,79,85,84,54,88,85,83,86,90},26)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({56,75,83,85,90,75,43,92,75,84,90},26), 5)
end)
if ok then return result end
debug(_d({77,75,90,56,75,86,82,71,95,56,75,83,85,90,75,6,75,88,88,85,88,32},26), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({54,82,71,95,75,88,45,91,79},26))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({47,83,71,77,75,40,91,90,90,85,84},26)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({72,91,90,90,85,84,60,71,82,91,75},26)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({76,79,84,74,40,91,90,90,85,84,40,95,60,71,82,91,75,6,75,88,88,85,88,32},26), result)
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
if not ok then debug(_d({73,82,79,73,81,45,91,79,40,91,90,90,85,84,6,75,88,88,85,88,32},26), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({79,89,57,75,88,92,75,88},26))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({56,75,83,85,90,75,43,92,75,84,90},26))
or inst:FindFirstChild(_d({73,82,79,75,84,90,43,92,75,84,90},26))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({76,79,84,74,39,84,89,93,75,88,41,85,84,84,75,73,90,85,88,6,75,88,88,85,88,32},26), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({41,85,91,82,74,6,84,85,90,6,82,85,73,71,90,75,6,56,75,83,85,90,75,43,92,75,84,90,21,73,82,79,75,84,90,43,92,75,84,90,6,84,75,71,88,6,56,75,86,82,71,95,6,72,91,90,90,85,84,18,6,76,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,73,82,79,73,81},26))
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
debug(_d({76,79,88,75,56,75,86,82,71,95,60,71,82,91,75,6,75,88,88,85,88,32},26), err, _d({19,6,76,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,73,82,79,73,81},26))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({44,71,82,82,79,84,77,6,72,71,73,81,6,90,85,6,72,91,90,90,85,84,60,71,82,91,75,6,89,75,71,88,73,78,6,76,85,88,6,56,75,86,82,71,95},26))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({56,75,86,82,71,95,6,72,91,90,90,85,84,6,84,85,90,6,76,85,91,84,74,6,75,79,90,78,75,88,18,6,77,79,92,79,84,77,6,91,86},26))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({61,71,79,90,79,84,77,6,76,85,88,6,41,85,84,76,79,88,83,71,90,79,85,84,54,88,85,83,86,90,20,56,75,83,85,90,75,43,92,75,84,90},26))
local remote = getReplayRemote()
if not remote then
debug(_d({41,85,84,76,79,88,83,71,90,79,85,84,54,88,85,83,86,90,21,56,75,83,85,90,75,43,92,75,84,90,6,84,85,90,6,76,85,91,84,74,6,93,79,90,78,79,84,6,90,79,83,75,85,91,90},26))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({44,79,88,79,84,77,6,56,75,86,82,71,95,6,92,79,71,6,41,85,84,76,79,88,83,71,90,79,85,84,54,88,85,83,86,90,20,56,75,83,85,90,75,43,92,75,84,90},26))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({44,79,88,75,57,75,88,92,75,88,6,75,88,88,85,88,32},26), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26), 10)
if not playerGui then
debug(_d({93,71,79,90,44,85,88,53,72,80,75,73,90,79,92,75,89,45,91,79,32,6,84,85,6,54,82,71,95,75,88,45,91,79,6,93,79,90,78,79,84,6,90,79,83,75,85,91,90,18,6,86,88,85,73,75,75,74,79,84,77,6,71,84,95,93,71,95},26))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({53,72,80,75,73,90,79,92,75,89,6,45,59,47,6,76,85,91,84,74,6,19,6,89,90,71,77,75,6,82,85,71,74,75,74},26))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({53,72,80,75,73,90,79,92,75,89,6,45,59,47,6,84,85,90,6,76,85,91,84,74,6,93,79,90,78,79,84,6,90,79,83,75,85,91,90,18,6,86,88,85,73,75,75,74,79,84,77,6,71,84,95,93,71,95},26))
return
end
end
end)
if not ok then debug(_d({93,71,79,90,44,85,88,53,72,80,75,73,90,79,92,75,89,45,91,79,6,75,88,88,85,88,32},26), err) end
end
local function runPlan()
debug(_d({54,82,71,84,6,89,90,71,88,90,75,74},26))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({57,90,71,88,90,79,84,77,6,84,71,92,6,82,85,85,86},26))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({86,85,89,6,22,20,24,89,6,39,44,58,43,56,6,89,90,71,88,90,52,71,92,32},26), rootAfter and rootAfter.Position)
end)
debug(_d({61,71,79,90,79,84,77,6,27,89,6,72,75,76,85,88,75,6,83,85,92,79,84,77,6,90,85,6,57,90,71,77,75,23},26))
task.wait(5)
for _, stage in ipairs({_d({57,90,71,77,75,23},26), _d({57,90,71,77,75,24},26), _d({57,90,71,77,75,25},26), _d({57,90,71,77,75,25,40},26)}) do
if not enabled then return end
local hpTarget = (stage == _d({57,90,71,77,75,25,40},26)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({51,85,92,79,84,77,6,90,85,6,71,88,88,85,93,6,76,82,95,19,74,85,93,84,6,71,88,75,71,6,14,41,91,86,79,74,6,56,71,79,84,15},26))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({42,85,74,77,79,84,77,6,71,88,88,85,93,6,88,71,79,84,6,79,84,6,71,6,89,87,91,71,88,75},26))
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
clearStage(_d({57,90,71,77,75,26},26))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({55,91,75,75,84,6,79,84,6,86,78,71,89,75,6,24,6,19,6,81,75,75,86,79,84,77,6,49,75,84,6,46,71,81,79,6,71,73,90,79,92,75,6,76,88,85,83,6,78,75,88,75,6,85,84},26))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({57,90,71,90,91,75,23},26))
if not enabled then return end
recheckStatue(_d({57,90,71,90,91,75,23},26))
destroyStatue(_d({57,90,71,90,91,75,24},26))
if not enabled then return end
recheckStatue(_d({57,90,71,90,91,75,23},26))
recheckStatue(_d({57,90,71,90,91,75,24},26))
destroyStatue(_d({57,90,71,90,91,75,25},26))
if not enabled then return end
recheckStatue(_d({57,90,71,90,91,75,25},26))
recheckStatue(_d({57,90,71,90,91,75,24},26))
recheckStatue(_d({57,90,71,90,91,75,23},26))
if not enabled then return end
debug(_d({61,71,79,90,79,84,77,6,76,85,88,6,86,78,71,89,75,6,24,6,90,85,6,75,84,74},26))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({54,78,71,89,75,6,24,6,75,84,74,6,93,71,79,90,6,90,79,83,75,85,91,90,18,6,86,88,85,73,75,75,74,79,84,77,6,71,84,95,93,71,95},26))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({51,85,92,79,84,77,6,72,71,73,81,6,90,85,6,55,91,75,75,84,6,89,90,71,77,75,6,86,85,89,79,90,79,85,84},26))
navToPointConfirmed(COORDS.Queen, 30, _d({55,91,75,75,84,6,89,90,71,77,75,6,86,85,89,79,90,79,85,84},26))
debug(_d({61,71,79,90,79,84,77,6,27,89,6,71,90,6,55,91,75,75,84,6,89,90,71,77,75,6,86,85,89,79,90,79,85,84},26))
task.wait(5)
if not enabled then return end
debug(_d({51,85,92,79,84,77,6,90,85,6,86,85,89,90,19,55,91,75,75,84,6,86,85,89,79,90,79,85,84},26))
navToPointConfirmed(COORDS.PostQueen, 30, _d({86,85,89,90,19,55,91,75,75,84,6,86,85,89,79,90,79,85,84},26))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({43,84,71,72,82,79,84,77,18,6,86,85,89,6,40,43,44,53,56,43,6,86,82,71,84,32},26), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({54,82,71,84,6,75,88,88,85,88,32},26), err2) end
end)
debug(_d({43,84,71,72,82,75,74,32},26), enabled)
end
function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({43,84,71,72,82,75,74,32},26), enabled)
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
if not ok then debug(_d({47,84,86,91,90,40,75,77,71,84,6,75,88,88,85,88,32},26), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({45,71,83,75,6,82,85,71,74,75,74,18,6,71,91,90,85,19,89,90,71,88,90,79,84,77,6,90,78,75,6,86,82,71,84},26))
enableBot()
end)
if not ok then debug(_d({39,91,90,85,89,90,71,88,90,6,75,88,88,85,88,32},26), err) end
end)
debug(_d({50,85,71,74,75,74,6,200,102,122,6,71,91,90,85,19,89,90,71,88,90,79,84,77,6,85,84,73,75,6,90,78,75,6,77,71,83,75,6,76,79,84,79,89,78,75,89,6,82,85,71,74,79,84,77,6,14,86,88,75,89,89,6,54,6,90,85,6,90,85,77,77,82,75,6,83,71,84,91,71,82,82,95,15},26))
})();
end
local function loadHoroBossFarm()
(function()
if _G.HoroFarmCleanup then
pcall(_G.HoroFarmCleanup)
end
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local Rayfield = nil
local rayfieldSources = {
_d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,56,71,95,76,79,75,82,74,21,83,71,79,84,21,89,85,91,88,73,75,20,82,91,71},26)
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
error(_d({65,46,85,88,85,6,92,24,67,6,44,71,79,82,75,74,6,90,85,6,82,85,71,74,6,56,71,95,76,79,75,82,74,6,59,47,6,50,79,72,88,71,88,95,20},26))
end
local Window = Rayfield:CreateWindow({
Name = _d({46,85,88,85,6,46,85,88,85,6,64,19,44,71,88,83,6,92,24},26),
LoadingTitle = _d({50,85,71,74,79,84,77,6,46,85,88,85,6,92,24,20,20,20},26),
LoadingSubtitle = _d({57,79,82,75,84,90,6,39,79,83,6,53,86,90,79,83,79,96,75,74},26),
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
local MainTab = Window:CreateTab(_d({39,91,90,85,6,44,71,88,83},26), 4483362458)
local SkillTab = Window:CreateTab(_d({57,81,79,82,82,6,57,75,90,90,79,84,77,89},26), 4483362458)
local function getRoot()
local char = LocalPlayer.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)) or (bp and bp:FindFirstChild(_d({46,85,88,85,19,46,85,88,85},26)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = boss:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
if key == _d({46,79,90},26) then
return target.CFrame
elseif key == _d({58,71,88,77,75,90},26) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then
warn(_d({65,46,85,88,85,6,92,24,67,6,51,75,90,71,90,71,72,82,75,6,78,85,85,81,6,76,71,79,82,75,74,32,6},26) .. tostring(err))
end
end
_G.HoroFarmCleanup = function()
_G.HoroAutoZLoop = nil
_G.HoroSelectedBoss = nil
pcall(function() Rayfield:Destroy() end)
print(_d({65,46,85,88,85,6,92,24,67,6,41,82,75,71,84,75,74,6,91,86,6,86,88,75,92,79,85,91,89,6,89,75,89,89,79,85,84,20},26))
end
task.spawn(function()
while _G.HoroAutoZLoop ~= nil do
if _G.HoroAutoZLoop then
local targetRoot = getBossPart(_G.HoroSelectedBoss)
if not targetRoot then
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,61,71,79,90,79,84,77,6,76,85,88,6,40,85,89,89,6,57,86,71,93,84},26)) end
print(_d({65,46,85,88,85,6,92,24,67,6,40,85,89,89},26), _G.HoroSelectedBoss, _d({79,89,6,84,85,90,6,89,86,71,93,84,75,74,20,6,61,71,79,90,79,84,77,20,20,20},26))
task.wait(5)
else
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,56,91,84,84,79,84,77,6,41,85,83,72,85},26)) end
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if useC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,41,6,14,49,71,83,79,81,71,96,75,15},26))
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
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,64,6,14,51,79,84,79,6,40,71,88,88,71,77,75,15},26))
end
end
if useE then
local currentTarget = getBossPart(_G.HoroSelectedBoss)
if currentTarget then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,43,6,14,57,90,91,84,15},26))
end
end
if useR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
print(_d({65,46,85,88,85,6,92,24,67,6,44,79,88,75,74,6,56,6,14,42,75,90,85,84,71,90,79,85,84,15},26))
end
local baseCD = 5
if useE then
baseCD = 17
elseif useZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,57,82,75,75,86,79,84,77,6,14},26) .. string.format(_d({11,20,23,76},26), finalSleep) .. _d({89,15},26)) end
task.wait(finalSleep)
end
else
task.wait(1)
end
end
end)
statusLabel = MainTab:CreateLabel(_d({57,90,71,90,91,89,32,6,47,74,82,75},26))
MainTab:CreateDropdown({
Name = _d({57,75,82,75,73,90,6,40,85,89,89},26),
Options = {_d({39,94,75,6,46,71,84,74,6,50,85,77,71,84},26), _d({40,71,84,74,79,90,6,40,85,89,89},26), _d({48,91,96,85,6,90,78,75,6,42,79,71,83,85,84,74,72,71,73,81},26)},
CurrentOption = "",
MultipleOptions = false,
Callback = function(Option)
_G.HoroSelectedBoss = Option[1] or Option
print(_d({65,46,85,88,85,6,92,24,67,6,57,75,82,75,73,90,75,74,6,90,71,88,77,75,90,32},26), _G.HoroSelectedBoss)
end,
})
local AutoZToggle
AutoZToggle = MainTab:CreateToggle({
Name = _d({57,90,71,88,90,6,39,91,90,85,6,44,71,88,83},26),
CurrentValue = false,
Callback = function(Value)
if Value and (not _G.HoroSelectedBoss or _G.HoroSelectedBoss == "") then
Rayfield:Notify({
Title = _d({57,75,82,75,73,90,6,40,85,89,89,6,56,75,87,91,79,88,75,74},26),
Content = _d({63,85,91,6,83,91,89,90,6,89,75,82,75,73,90,6,71,6,72,85,89,89,6,76,79,88,89,90,6,72,75,76,85,88,75,6,75,84,71,72,82,79,84,77,6,39,91,90,85,6,44,71,88,83,7},26),
Duration = 5,
Image = 4483362458
})
AutoZToggle:Set(false)
return
end
_G.HoroAutoZLoop = Value
if not _G.HoroAutoZLoop then
if statusLabel then statusLabel:Set(_d({57,90,71,90,91,89,32,6,47,74,82,75},26)) end
end
print(_d({65,46,85,88,85,6,92,24,67,6,39,91,90,85,6,44,71,88,83,32},26), _G.HoroAutoZLoop)
end,
})
MainTab:CreateButton({
Name = _d({42,75,89,90,88,85,95,6,59,47},26),
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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local autoGrind = true
local hoverHeight = 6.5
local targetMob = "Bandit"
local function getRoot(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function getHumanoid(player)
local char = (player or LocalPlayer).Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end
local function getStats()
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if statsFolder then
local lvl = statsFolder:FindFirstChild("Stats_d({15,6,71,84,74,6,89,90,71,90,89,44,85,82,74,75,88,20,57,90,71,90,89,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,14},26)Level") and statsFolder.Stats.Level.Value or 1
local peli = statsFolder:FindFirstChild("Stats_d({15,6,71,84,74,6,89,90,71,90,89,44,85,82,74,75,88,20,57,90,71,90,89,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,14},26)Peli") and statsFolder.Stats.Peli.Value or 0
local quest = statsFolder:FindFirstChild("Quest_d({15,6,71,84,74,6,89,90,71,90,89,44,85,82,74,75,88,20,55,91,75,89,90,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,14},26)CurrentQuest_d({15,6,71,84,74,6,89,90,71,90,89,44,85,82,74,75,88,20,55,91,75,89,90,20,41,91,88,88,75,84,90,55,91,75,89,90,20,60,71,82,91,75,6,85,88,6},26)None"
return lvl, peli, quest
end
return 1, 0, "None"
end
local function getActiveTargetNPCs()
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
if not npcsFolder then return {} end
local targets = {}
for _, npc in ipairs(npcsFolder:GetChildren()) do
if npc.Name == targetMob then
local root = npc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = npc:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
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
if part:IsA(_d({40,71,89,75,54,71,88,90},26)) then
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
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild("UpperTorso")
local prompt = torso and torso:FindFirstChild("Prompt")
if not prompt then return false end
local myRoot = getRoot()
if not myRoot then return false end
local targetPos = torso.Position + (torso.CFrame.LookVector * 5.0)
local reached = navigateTo(targetPos)
if reached then
task.wait(0.3)
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn("[Quest Acceptance] fireproximityprompt not supported by executor!")
end
task.wait(0.8)
local playerGui = LocalPlayer:FindFirstChild(_d({54,82,71,95,75,88,45,91,79},26))
local chatGui = playerGui and playerGui:FindFirstChild("NPCCHAT")
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 6 do
tries = tries + 1
local goBtn = chatGui.Frame:FindFirstChild("go")
local endChatBtn = chatGui.Frame:FindFirstChild("endChat")
if goBtn and goBtn.Visible and goBtn.Text ~= "_d({6,71,84,74,6,77,85,40,90,84,20,58,75,94,90,6,100,35,6},26)..." then
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
local hasRifle = LocalPlayer.Backpack:FindFirstChild("Rifle_d({15,6,85,88,6,50,85,73,71,82,54,82,71,95,75,88,20,41,78,71,88,71,73,90,75,88,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,14},26)Rifle")
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
targetMob = _d({40,71,84,74,79,90,6,40,85,89,89},26)
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
local bp = LocalPlayer:FindFirstChild(_d({40,71,73,81,86,71,73,81},26))
local weaponTool = bp and bp:FindFirstChild("Melee")
if weaponTool then
myHum:EquipTool(weaponTool)
end
if n > 1 then
for i = 1, n - 1 do
if not autoGrind then break end
local npc = targets[i]
local npcRoot = npc and npc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if npcRoot and npc:FindFirstChildWhichIsA("Humanoid_d({15,6,71,84,74,6,84,86,73,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,61,78,79,73,78,47,89,39,14},26)Humanoid").Health > 0 then
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
local finalRoot = finalNpc and finalNpc:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({15,6,71,84,74,6,76,79,84,71,82,52,86,73,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,61,78,79,73,78,47,89,39,14},26)Humanoid").Health > 0 then
pcall(setNPCPartsCollision, finalNpc, false)
local finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
local startTime = tick()
while autoGrind and (finalTargetPos - myRoot.Position).Magnitude > 5 and (tick() - startTime) < 2 do
finalTargetPos = finalRoot.Position + Vector3.new(0, hoverHeight, 0)
navigateTo(finalTargetPos)
task.wait(0.05)
end
local combatStartTime = tick()
while autoGrind and finalNpc.Parent and finalRoot and finalNpc:FindFirstChildWhichIsA("Humanoid_d({15,6,71,84,74,6,76,79,84,71,82,52,86,73,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,61,78,79,73,78,47,89,39,14},26)Humanoid").Health > 0 and (tick() - combatStartTime) < 8 do
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
local npcsFolder = Workspace:FindFirstChild(_d({52,54,41,89},26))
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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
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
local root = char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
local hum = char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
return char, hum, root
end
local function getOrCreateForce(root)
local att = root:FindFirstChild("__EasyTravelAtt_d({15,6,85,88,6,47,84,89,90,71,84,73,75,20,84,75,93,14},26)Attachment")
att.Name = "__EasyTravelAtt"
att.Parent = root
local force = root:FindFirstChild("__EasyTravelForce")
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local RunService = game:GetService(_d({56,91,84,57,75,88,92,79,73,75},26))
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({79,74,82,75},26)
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
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({56,85,81,91,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,75,86,86,85},26), args)
elseif style == _d({40,82,71,73,81,50,75,77},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81},26), args)
elseif style == _d({49,71,83,79,89,78,79,81,79},26) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,71,83,79,89,78,79,81,79,45,75,86,86,85},26), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({57,81,95,6,61,71,82,81,24},26), args)
end
debug("Fired Geppo Remote")
end)
if not ok then debug(_d({79,84,92,85,81,75,45,75,86,86,85,6,75,88,88,85,88,32},26), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild("__TestHoverAtt_d({15,6,85,88,6,47,84,89,90,71,84,73,75,20,84,75,93,14},26)Attachment")
att.Name = "__TestHoverAtt"
att.Parent = root
local force = root:FindFirstChild("__TestHoverForce")
if not force then
force = Instance.new(_d({50,79,84,75,71,88,60,75,82,85,73,79,90,95},26))
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
local root = char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
if not root then return end
local force = root:FindFirstChild("__TestHoverForce")
local att   = root:FindFirstChild("__TestHoverAtt")
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = getRoot()
if not root then return end
debug(_d({61,71,82,81,79,84,77,6,90,85,32},26), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({93,71,82,81,58,85,54,85,79,84,90,6,61,6,74,85,93,84,6,75,88,88,85,88,32},26), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = getRoot()
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({39,88,88,79,92,75,74,6,71,90,32},26), pos)
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
if item:IsA("Model_d({15,6,71,84,74,6,79,90,75,83,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,14},26)HumanoidRootPart_d({15,6,71,84,74,6,79,90,75,83,32,44,79,84,74,44,79,88,89,90,41,78,79,82,74,61,78,79,73,78,47,89,39,14},26)Humanoid") then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({46,91,83,71,84,85,79,74},26)).Health > 0 then
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
mode = _d({79,74,82,75},26)
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
if mode == _d({78,85,92,75,88},26) then
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
local playerGui = LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26), 10)
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
statusLabel.Text = _d({57,90,71,90,91,89,32,6,47,74,82,75},26)
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
enableBot(_d({78,85,92,75,88},26))
statusLabel.Text = "Status: Hovering _d({6,20,20,6,92,71,82,6,20,20,6},26) studs up"
end)
createInputBtn("Dodge Climb", 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot("dodge")
statusLabel.Text = "Status: Dodge-holding (_d({6,20,20,6,92,71,82,6,20,20,6},26) studs)"
end)
createInputBtn("Test Square Dodge", 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot("square_dodge")
statusLabel.Text = "Status: Square Walking (_d({6,20,20,6,92,71,82,6,20,20,6},26) studs)"
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
local VIM = game:GetService(_d({60,79,88,90,91,71,82,47,84,86,91,90,51,71,84,71,77,75,88},26))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print("[OverworldTester] Loaded successfully.")
})();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({54,82,71,95,75,88,45,91,79},26), 10)
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
CreateLaunchButton("Cupid Dungeon Farm_d({18,6},26)Automate cupid dungeons & boss cycles", loadCupidDungeon)
CreateLaunchButton("Horo Boss Farm (Silent Aim)_d({18,6},26)Autofarm overworld bosses using Horo fruits", loadHoroBossFarm)
CreateLaunchButton("Level & Mob Grinder_d({18,6},26)Auto-level and farm local NPC mobs", loadLevelGrinder)
CreateLaunchButton("Easy Travel (P Toggle)_d({18,6},26)WASD Flight with ground follow & wall climbing", loadNavigationLab)
CreateLaunchButton("Physics Overworld Tester_d({18,6},26)Test combat hover, geppo & dodge heights", loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print("[GPO Hub] Launcher UI initialized.")
end)()