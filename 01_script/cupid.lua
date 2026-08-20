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
local Players            = game:GetService(_d({64,92,81,105,85,98,99},16))
local UserInputService    = game:GetService(_d({69,99,85,98,57,94,96,101,100,67,85,98,102,89,83,85},16))
local RunService          = game:GetService(_d({66,101,94,67,85,98,102,89,83,85},16))
local VIM                 = game:GetService(_d({70,89,98,100,101,81,92,57,94,96,101,100,61,81,94,81,87,85,98},16))
local ReplicatedStorage    = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({75,50,95,99,99,50,95,100,77},16), _d({71,98,95,94,87,16,87,81,93,85,16,210,112,132,16,64,92,81,83,85,57,84,42},16), game.PlaceId, _d({69,94,89,102,85,98,99,85,57,84,42},16), game.GameId, _d({29,16,94,95,100,16,98,101,94,94,89,94,87},16))
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
local LEO_PILLAR_ANIM_ID   = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,37,34,36,36,33,36,33,35,34,39},16)
local LEO_ENTEI_ANIM_ID    = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,37,34,36,36,33,35,40,34,39,40},16)
local LEO_HIKEN_ANIM_ID    = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,37,34,34,32,41,33,39,36,32,39},16)
local LEO_FIREFLY_ANIM_ID  = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,37,34,34,32,34,35,38,33,37,36},16)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({63,82,90,85,83,100,89,102,85,99},16)
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
local REPLAY_BUTTON_VALUE   = _d({66,85,96,92,81,105},16)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({93,95,102,85},16)
local NavState   = {mode = _d({89,84,92,85},16)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({75,50,95,99,99,50,95,100,77},16), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
end)
if ok then return root end
debug(_d({87,85,100,66,95,95,100,16,85,98,98,95,98,42},16), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
end)
if ok then return hum end
debug(_d({87,85,100,56,101,93,81,94,95,89,84,16,85,98,98,95,98,42},16), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({79,79,56,95,102,85,98,49,100,100},16)) or Instance.new(_d({49,100,100,81,83,88,93,85,94,100},16))
att.Name = _d({79,79,56,95,102,85,98,49,100,100},16)
att.Parent = root
local force = root:FindFirstChild(_d({79,79,56,95,102,85,98,54,95,98,83,85},16))
if not force then
force = Instance.new(_d({60,89,94,85,81,98,70,85,92,95,83,89,100,105},16))
force.Name = _d({79,79,56,95,102,85,98,54,95,98,83,85},16)
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
debug(_d({87,85,100,63,98,51,98,85,81,100,85,54,95,98,83,85,16,85,98,98,95,98,42},16), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if not root then return end
local force = root:FindFirstChild(_d({79,79,56,95,102,85,98,54,95,98,83,85},16))
local att   = root:FindFirstChild(_d({79,79,56,95,102,85,98,49,100,100},16))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({83,92,85,81,94,101,96,54,95,98,83,85,16,85,98,98,95,98,42},16), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({50,101,99,95,61,85,92,85,85},16)) ~= nil
end)
if ok then return result end
debug(_d({89,99,50,101,99,95,49,83,100,89,102,85,16,85,98,98,95,98,42},16), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({50,101,99,95},16))
end)
if not ok then debug(_d({81,83,100,89,102,81,100,85,50,101,99,95,16,85,98,98,95,98,42},16), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({50,101,99,95,16,94,95,100,16,81,83,100,89,102,85,28,16,81,83,100,89,102,81,100,89,94,87},16))
activateBuso()
end
end)
if not ok then debug(_d({50,101,99,95,59,85,85,96,85,98,16,85,98,98,95,98,42},16), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({50,101,99,95,16,91,85,85,96,85,98,16,99,100,95,96,96,85,84},16))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({59,85,94,56,81,91,89},16)) ~= nil
end)
if ok then return result end
debug(_d({89,99,59,85,94,49,83,100,89,102,85,16,85,98,98,95,98,42},16), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({59,85,94},16), true)
end)
if not ok then debug(_d({81,83,100,89,102,81,100,85,59,85,94,16,85,98,98,95,98,42},16), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({59,85,94,16,94,95,100,16,81,83,100,89,102,85,28,16,81,83,100,89,102,81,100,89,94,87},16))
activateKen()
end
end)
if not ok then debug(_d({59,85,94,59,85,85,96,85,98,16,85,98,98,95,98,42},16), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({59,85,94,16,91,85,85,96,85,98,16,99,100,95,96,96,85,84},16))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({62,64,51,99},16)) end)
if ok then return folder end
debug(_d({87,85,100,62,64,51,99,54,95,92,84,85,98,16,85,98,98,95,98,42},16), folder)
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
local r = model:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local h = model:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
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
debug(_d({87,85,100,62,85,81,98,85,99,100,62,64,51,16,85,98,98,95,98,42},16), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
local hum  = model:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({87,85,100,62,64,51,50,105,62,81,93,85,16,85,98,98,95,98,42},16), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({94,96,83,99,66,85,93,81,89,94,89,94,87,16,85,98,98,95,98,42},16), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({51,101,96,89,84,16,65,101,85,85,94},16))
return queen ~= nil and queen:FindFirstChild(_d({93,95,100,89,95,94,60,85,99,99},16)) ~= nil
end)
if ok then return result end
debug(_d({89,99,65,101,85,85,94,64,88,81,99,85,34,16,85,98,98,95,98,42},16), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,33,34,33,34,41,39,41,36,34,34,41,34,39,38,41},16)
local QUEEN_GRASP_ANIM_ID   = _d({98,82,104,81,99,99,85,100,89,84,42,31,31,33,34,41,40,32,32,32,38,33,32,32,33,39,35,36},16)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
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
debug(_d({89,99,64,92,81,105,89,94,87,49,94,89,93,54,98,95,93,60,89,99,100,16,85,98,98,95,98,42},16), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({50,92,95,83,91,89,94,87},16)) ~= nil
end)
if ok then return result end
debug(_d({89,99,62,64,51,50,92,95,83,91,89,94,87,16,85,98,98,95,98,42},16), result)
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
debug(_d({96,98,85,84,89,83,100,62,64,51,64,95,99,89,100,89,95,94,16,85,98,98,95,98,42},16), result)
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
debug(_d({62,95,16,84,81,93,81,87,85,16,95,94},16), model.Name, _d({86,95,98},16), NPC_STUCK_TIMEOUT, _d({99,16,29,16,99,103,89,100,83,88,89,94,87,16,100,81,98,87,85,100},16))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({100,98,81,83,91,62,64,51,52,81,93,81,87,85,16,85,98,98,95,98,42},16), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({61,95,84,85,92},16)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({50,81,99,85,64,81,98,100},16)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({87,85,100,61,95,84,85,92,54,81,83,85,64,95,99,16,85,98,98,95,98,42},16), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({53,94,102},16))
local folder = env and env:FindFirstChild(_d({67,100,81,100,101,85,99},16))
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
debug(_d({87,85,100,67,100,81,100,101,85,61,95,84,85,92,62,85,81,98,16,85,98,98,95,98,42},16), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({82,81,98,98,85,92,56,64},16))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({87,85,100,67,100,81,100,101,85,56,64,16,85,98,98,95,98,42},16), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({68,95,95,92},16)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({86,89,94,84,68,95,95,92,50,105,49,100,100,98,89,82,101,100,85,16,85,98,98,95,98,42},16), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({68,95,95,92},16)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({86,89,94,84,68,95,95,92,50,105,62,81,93,85,16,85,98,98,95,98,42},16), tool)
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
if not ok then debug(_d({85,97,101,89,96,68,95,95,92,16,85,98,98,95,98,42},16), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({50,81,83,91,96,81,83,91},16))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({68,95,95,92},16)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({86,89,94,84,68,95,95,92,50,105,51,88,89,92,84,62,81,93,85,16,85,98,98,95,98,42},16), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({67,103,95,98,84,53,97,101,89,96},16))
if sword then
equipTool(sword)
return _d({99,103,95,98,84},16)
end
local melee = findToolByAttribute(_d({61,85,92,85,85,68,95,95,92},16))
if melee then
equipTool(melee)
return _d({93,85,92,85,85},16)
end
debug(_d({62,95,16,99,103,95,98,84,16,95,98,16,93,85,92,85,85,16,100,95,95,92,16,86,95,101,94,84},16))
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
if not ok then debug(_d({83,92,89,83,91,61,33,16,85,98,98,95,98,42},16), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({56,101,93,81,94,95,89,84,66,95,95,100,64,81,98,100},16))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({67,100,81,100,99},16) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({66,95,91,101,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({55,85,96,96,95},16), args)
elseif style == _d({50,92,81,83,91,60,85,87},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91},16), args)
elseif style == _d({59,81,93,89,99,88,89,91,89},16) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({59,81,93,89,99,88,89,91,89,55,85,96,96,95},16), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({67,91,105,16,71,81,92,91,34},16), args)
end
end)
if not ok then debug(_d({89,94,102,95,91,85,55,85,96,96,95,16,85,98,98,95,98,42},16), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({96,98,85,99,99,67,91,89,92,92,66,16,85,98,98,95,98,42},16), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({88,95,92,84,50,92,95,83,91,16,85,98,98,95,98,42},16), err) end
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
if not ok then debug(_d({88,95,92,84,50,92,95,83,91,71,88,89,92,85,16,85,98,98,95,98,42},16), err) end
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
debug(_d({87,85,100,55,81,93,85,55,16,85,98,98,95,98,42},16), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({89,99,66,85,81,92,61,33,50,101,99,105,16,85,98,98,95,98,42},16), result)
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
return char ~= nil and char:FindFirstChild(_d({99,100,101,94},16)) ~= nil
end)
if ok then return result end
debug(_d({89,99,67,100,101,94,94,85,84,16,85,98,98,95,98,42},16), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({96,98,85,99,99,67,100,101,94,50,98,85,81,91,16,85,98,98,95,98,42},16), err) end
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
debug(_d({97,101,85,85,94,52,95,84,87,85,69,94,100,89,92,67,81,86,85,42,16,65,101,85,85,94,16,87,95,94,85,16,29,16,85,94,84,89,94,87,16,84,95,84,87,85,16,85,81,98,92,105},16))
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
debug(_d({97,101,85,85,94,52,95,84,87,85,69,94,100,89,92,67,81,86,85,16,99,81,86,85,100,105,16,100,89,93,85,95,101,100},16))
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
local info = getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({65,101,85,85,94,16,83,81,99,100,89,94,87,16,84,85,100,85,83,100,85,84,16,29,16,84,95,84,87,89,94,87,16,24,103,81,100,83,88,85,98,25},16))
queenDodgeUntilSafe(function() return getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16)) end)
if enabled and getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16)) then
setNavNamed(_d({51,101,96,89,84,16,65,101,85,85,94},16))
end
queenDodging = false
end
end)
if not ok then debug(_d({97,101,85,85,94,52,95,84,87,85,71,81,100,83,88,85,98,16,85,98,98,95,98,42},16), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({96,95,89,94,100},16) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({94,96,83},16) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({94,81,93,85,84},16) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({87,85,100,62,81,102,68,81,98,87,85,100,99,16,85,98,98,95,98,42},16), aimR)
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
debug(_d({83,95,93,96,101,100,85,60,95,83,91,85,84,51,54,98,81,93,85,16,85,98,98,95,98,42},16), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({96,95,89,94,100},16), point = pos}
phase = _d({93,95,102,85},16)
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
if not ok then debug(_d({94,81,102,68,95,64,95,89,94,100,16,87,85,96,96,95,16,83,88,85,83,91,16,85,98,98,95,98,42},16), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({94,96,83},16)}
phase = _d({93,95,102,85},16)
end
function setNavNamed(name)
NavState = {mode = _d({94,81,93,85,84},16), name = name}
phase = _d({93,95,102,85},16)
end
local function setNavIdle()
NavState = {mode = _d({89,84,92,85},16)}
phase = _d({93,95,102,85},16)
end
local function hasArrived()
return phase == _d({88,95,102,85,98},16)
end
local function startNav()
phase = _d({93,95,102,85},16)
debug(_d({62,81,102,16,92,95,95,96,16,63,62},16))
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
local prevPos = force:GetAttribute(_d({79,79,96,98,85,102,64,95,99},16))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({60,81,98,87,85,16,96,95,99,89,100,89,95,94,16,90,101,93,96,16,84,85,100,85,83,100,85,84,42},16), delta, _d({99,100,101,84,99,30,16,96,98,85,102,64,95,99,45},16), prevPos, _d({94,85,103,64,95,99,45},16), pos)
end
end
force:SetAttribute(_d({79,79,96,98,85,102,64,95,99},16), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({93,95,102,85},16) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({88,95,102,85,98},16)
debug(_d({64,88,81,99,85,42,16,88,95,102,85,98},16))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({17,17,17,16,66,53,54,69,67,57,62,55,16,68,63,16,49,64,64,60,73,16,49,50,62,63,66,61,49,60,16,70,53,60,63,51,57,68,73,42},16), finalVel, _d({81,89,93,45},16), aim, _d({96,95,99,45},16), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({88,95,102,85,98},16) then
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
debug(_d({51,95,93,82,81,100,16,92,95,83,91,16,99,91,89,96,96,85,84,28},16), snapDist, _d({99,100,101,84,99,16,86,98,95,93,16,100,81,98,87,85,100,16,210,112,132,16,86,81,92,92,89,94,87,16,82,81,83,91,16,100,95,16,93,95,102,85},16))
phase = _d({93,95,102,85},16)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({56,85,81,98,100,82,85,81,100,16,85,98,98,95,98,42},16), err) end
end)
end
local function stopNav()
debug(_d({62,81,102,16,92,95,95,96,16,63,54,54},16))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({93,95,102,85},16)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({68,85,104,100,51,88,81,100,67,85,98,102,89,83,85},16))
local channels = TextChatService:FindFirstChild(_d({68,85,104,100,51,88,81,94,94,85,92,99},16))
local channel = channels and channels:FindFirstChild(_d({66,50,72,55,85,94,85,98,81,92},16))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({52,85,86,81,101,92,100,51,88,81,100,67,105,99,100,85,93,51,88,81,100,53,102,85,94,100,99},16))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({67,81,105,61,85,99,99,81,87,85,66,85,97,101,85,99,100},16))
if sayEvent then
sayEvent:FireServer(message, _d({49,92,92},16))
return
end
debug(_d({99,85,94,84,51,88,81,100,61,85,99,99,81,87,85,42,16,94,95,16,68,85,104,100,51,88,81,100,67,85,98,102,89,83,85,30,66,50,72,55,85,94,85,98,81,92,16,95,98,16,92,85,87,81,83,105,16,67,81,105,61,85,99,99,81,87,85,66,85,97,101,85,99,100,16,86,95,101,94,84,16,86,95,98},16), message)
end)
if not ok then debug(_d({99,85,94,84,51,88,81,100,61,85,99,99,81,87,85,16,85,98,98,95,98,42},16), err) end
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
debug(_d({62,95,100,16,93,81,91,89,94,87,16,96,98,95,87,98,85,99,99,16,100,95,103,81,98,84,16,94,81,102,16,100,81,98,87,85,100,16,86,95,98},16), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({99,16,29,16,99,85,94,84,89,94,87,16,31,101,94,99,100,101,83,91},16))
sendChatMessage(_d({31,101,94,99,100,101,83,91},16))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({103,81,89,100,69,94,100,89,92,49,98,98,89,102,85,84,16,100,89,93,85,95,101,100},16))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({94,81,102,68,95,64,95,89,94,100,51,95,94,86,89,98,93,85,84,42},16), label or _d({100,81,98,87,85,100},16), _d({29,16,84,89,84,16,94,95,100,16,81,98,98,89,102,85,16,103,89,100,88,89,94},16), timeout, _d({99,28,16,98,85,100,98,105,89,94,87,16,95,94,83,85},16))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({94,81,102,68,95,64,95,89,94,100,51,95,94,86,89,98,93,85,84,42},16), label or _d({100,81,98,87,85,100},16), _d({29,16,99,100,89,92,92,16,94,95,100,16,81,98,98,89,102,85,84,16,81,86,100,85,98,16,98,85,100,98,105,28,16,96,98,95,83,85,85,84,89,94,87,16,81,94,105,103,81,105},16))
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
if not ok then debug(_d({94,81,102,68,95,64,95,89,94,100,56,95,92,84,89,94,87,50,92,95,83,91,16,91,85,105,29,84,95,103,94,16,85,98,98,95,98,42},16), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({94,81,102,68,95,64,95,89,94,100,56,95,92,84,89,94,87,50,92,95,83,91,16,91,85,105,29,101,96,16,85,98,98,95,98,42},16), err2) end
end
local function clearStage(stageName)
debug(_d({61,95,102,89,94,87,16,100,95},16), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({71,81,89,100,89,94,87,16,86,95,98,16,62,64,51,99,16,100,95,16,99,96,81,103,94,16,81,100},16), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({16,16,99,96,81,103,94,16,83,88,85,83,91,42,16,86,95,92,84,85,98,16,85,104,89,99,100,99,16,45},16), folder ~= nil,
_d({28,16,83,88,89,92,84,98,85,94,16,45},16), folder and #folder:GetChildren() or 0,
_d({28,16,81,92,89,102,85,16,45},16), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({62,95,16,62,64,51,99,16,81,96,96,85,81,98,85,84,16,81,100},16), stageName, _d({81,86,100,85,98,16,33,37,99,28,16,93,95,102,89,94,87,16,95,94,16,81,94,105,103,81,105},16))
break
end
end
debug(_d({59,89,92,92,89,94,87,16,62,64,51,99,16,81,100},16), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({66,85,100,101,98,94,89,94,87,16,100,95},16), stageName, _d({96,95,99,89,100,89,95,94,16,82,85,86,95,98,85,16,93,95,102,89,94,87,16,95,94},16))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({71,81,89,100,89,94,87,16,37,99,16,81,100},16), stageName, _d({96,95,99,89,100,89,95,94},16))
task.wait(5)
debug(stageName, _d({83,92,85,81,98,85,84},16))
end
local function killNamedNPC(name, targetPos)
debug(_d({61,95,102,89,94,87,16,100,95},16), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({84,85,86,85,81,100,85,84},16))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({56,101,93,81,94,95,89,84},16))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({60,85,95,16,96,92,81,105,85,84,16,81,94,89,93,81,100,89,95,94,42},16), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({92,85,95,49,94,89,93,60,95,87,87,85,98,16,96,98,89,94,100,16,85,98,98,95,98,42},16), err2) end
end)
end)
if not ok then debug(_d({99,100,81,98,100,60,85,95,49,94,89,93,60,95,87,87,85,98,16,85,98,98,95,98,42},16), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({61,95,102,89,94,87,16,100,95,16,60,85,95,16,24,82,92,95,83,91,89,94,87,16,81,86,100,85,98},16), LEO_BLOCK_DELAY, _d({99,25},16))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({60,85,95},16))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({60,85,95},16))
while enabled do
local info = getNPCByName(_d({60,85,95},16))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({60,85,95,16,83,81,99,100,89,94,87},16), which, _d({29,16,84,95,84,87,89,94,87},16))
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
if not getNPCByName(_d({60,85,95},16)) then
debug(_d({60,85,95,16,87,95,94,85,16,93,89,84,29,84,95,84,87,85,16,29,16,85,94,84,89,94,87,16,53,94,100,85,89,16,88,95,92,84,16,85,81,98,92,105},16))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({60,85,95},16)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({60,85,95,16,87,95,94,85,16,93,89,84,29,84,95,84,87,85,16,29,16,85,94,84,89,94,87,16,54,92,81,93,85,16,64,89,92,92,81,98,16,88,95,92,84,16,85,81,98,92,105},16))
end
end
end
if enabled and getNPCByName(_d({60,85,95},16)) then
setNavNamed(_d({60,85,95},16))
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
debug(_d({60,85,95,16,84,85,86,85,81,100,85,84},16))
stopLeoAnimLogger()
debug(_d({66,85,100,101,98,94,89,94,87,16,100,95,16,60,85,95,16,96,95,99,89,100,89,95,94,16,82,85,86,95,98,85,16,93,95,102,89,94,87,16,95,94},16))
navToPointConfirmed(COORDS.Leo, 30, _d({60,85,95,16,96,95,99,89,100,89,95,94},16))
debug(_d({71,81,89,100,89,94,87,16,37,99,16,81,100,16,60,85,95,16,96,95,99,89,100,89,95,94},16))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({61,95,102,89,94,87,16,100,95},16), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({51,95,101,92,84,16,94,95,100,16,86,89,94,84,16,99,100,81,100,101,85,16,93,95,84,85,92,16,94,85,81,98},16), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({49,100,100,81,83,91,89,94,87},16), coordKey, _d({103,89,100,88},16), weapon or _d({94,95,100,88,89,94,87,16,86,95,101,94,84},16))
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
debug(coordKey, _d({82,81,98,98,85,92,16,84,85,99,100,98,95,105,85,84},16))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({98,85,83,88,85,83,91,67,100,81,100,101,85,42},16), coordKey, _d({29,16,83,95,101,92,84,16,94,95,100,16,86,89,94,84,16,99,100,81,100,101,85,16,93,95,84,85,92,28,16,99,91,89,96,96,89,94,87},16))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({98,85,83,88,85,83,91,67,100,81,100,101,85,42},16), coordKey, _d({99,100,89,92,92,16,81,92,89,102,85,16,24,56,64},16), hp, _d({25,16,29,16,98,85,29,84,85,99,100,98,95,105,89,94,87},16))
destroyStatue(coordKey)
else
debug(_d({98,85,83,88,85,83,91,67,100,81,100,101,85,42},16), coordKey, _d({83,95,94,86,89,98,93,85,84,16,84,85,99,100,98,95,105,85,84},16))
end
end)
if not ok then debug(_d({98,85,83,88,85,83,91,67,100,81,100,101,85,16,85,98,98,95,98,42},16), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({61,95,102,89,94,87,16,100,95,16,65,101,85,85,94},16))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({51,101,96,89,84,16,65,101,85,85,94},16))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({65,101,85,85,94,16,85,94,100,85,98,85,84,16,96,88,81,99,85,16,34},16))
end
local function finishQueen()
debug(_d({54,89,94,89,99,88,89,94,87,16,65,101,85,85,94},16))
equipSwordOrMelee()
setNavNamed(_d({51,101,96,89,84,16,65,101,85,85,94},16))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({51,101,96,89,84,16,65,101,85,85,94},16))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({65,101,85,85,94,16,84,85,86,85,81,100,85,84,30,16,64,92,81,94,16,83,95,93,96,92,85,100,85,30},16))
end
local CONFIRMATION_PROMPT_NAME = _d({51,95,94,86,89,98,93,81,100,89,95,94,64,98,95,93,96,100},16)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({64,92,81,105,85,98,55,101,89},16))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({66,85,93,95,100,85,53,102,85,94,100},16), 5)
end)
if ok then return result end
debug(_d({87,85,100,66,85,96,92,81,105,66,85,93,95,100,85,16,85,98,98,95,98,42},16), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({64,92,81,105,85,98,55,101,89},16))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({57,93,81,87,85,50,101,100,100,95,94},16)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({82,101,100,100,95,94,70,81,92,101,85},16)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({86,89,94,84,50,101,100,100,95,94,50,105,70,81,92,101,85,16,85,98,98,95,98,42},16), result)
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
if not ok then debug(_d({83,92,89,83,91,55,101,89,50,101,100,100,95,94,16,85,98,98,95,98,42},16), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({89,99,67,85,98,102,85,98},16))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({66,85,93,95,100,85,53,102,85,94,100},16))
or inst:FindFirstChild(_d({83,92,89,85,94,100,53,102,85,94,100},16))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({86,89,94,84,49,94,99,103,85,98,51,95,94,94,85,83,100,95,98,16,85,98,98,95,98,42},16), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({51,95,101,92,84,16,94,95,100,16,92,95,83,81,100,85,16,66,85,93,95,100,85,53,102,85,94,100,31,83,92,89,85,94,100,53,102,85,94,100,16,94,85,81,98,16,66,85,96,92,81,105,16,82,101,100,100,95,94,28,16,86,81,92,92,89,94,87,16,82,81,83,91,16,100,95,16,83,92,89,83,91},16))
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
debug(_d({86,89,98,85,66,85,96,92,81,105,70,81,92,101,85,16,85,98,98,95,98,42},16), err, _d({29,16,86,81,92,92,89,94,87,16,82,81,83,91,16,100,95,16,83,92,89,83,91},16))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({54,81,92,92,89,94,87,16,82,81,83,91,16,100,95,16,82,101,100,100,95,94,70,81,92,101,85,16,99,85,81,98,83,88,16,86,95,98,16,66,85,96,92,81,105},16))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({66,85,96,92,81,105,16,82,101,100,100,95,94,16,94,95,100,16,86,95,101,94,84,16,85,89,100,88,85,98,28,16,87,89,102,89,94,87,16,101,96},16))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({71,81,89,100,89,94,87,16,86,95,98,16,51,95,94,86,89,98,93,81,100,89,95,94,64,98,95,93,96,100,30,66,85,93,95,100,85,53,102,85,94,100},16))
local remote = getReplayRemote()
if not remote then
debug(_d({51,95,94,86,89,98,93,81,100,89,95,94,64,98,95,93,96,100,31,66,85,93,95,100,85,53,102,85,94,100,16,94,95,100,16,86,95,101,94,84,16,103,89,100,88,89,94,16,100,89,93,85,95,101,100},16))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({54,89,98,89,94,87,16,66,85,96,92,81,105,16,102,89,81,16,51,95,94,86,89,98,93,81,100,89,95,94,64,98,95,93,96,100,30,66,85,93,95,100,85,53,102,85,94,100},16))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({54,89,98,85,67,85,98,102,85,98,16,85,98,98,95,98,42},16), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({64,92,81,105,85,98,55,101,89},16), 10)
if not playerGui then
debug(_d({103,81,89,100,54,95,98,63,82,90,85,83,100,89,102,85,99,55,101,89,42,16,94,95,16,64,92,81,105,85,98,55,101,89,16,103,89,100,88,89,94,16,100,89,93,85,95,101,100,28,16,96,98,95,83,85,85,84,89,94,87,16,81,94,105,103,81,105},16))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({63,82,90,85,83,100,89,102,85,99,16,55,69,57,16,86,95,101,94,84,16,29,16,99,100,81,87,85,16,92,95,81,84,85,84},16))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({63,82,90,85,83,100,89,102,85,99,16,55,69,57,16,94,95,100,16,86,95,101,94,84,16,103,89,100,88,89,94,16,100,89,93,85,95,101,100,28,16,96,98,95,83,85,85,84,89,94,87,16,81,94,105,103,81,105},16))
return
end
end
end)
if not ok then debug(_d({103,81,89,100,54,95,98,63,82,90,85,83,100,89,102,85,99,55,101,89,16,85,98,98,95,98,42},16), err) end
end
local function runPlan()
debug(_d({64,92,81,94,16,99,100,81,98,100,85,84},16))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({67,100,81,98,100,89,94,87,16,94,81,102,16,92,95,95,96},16))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({96,95,99,16,32,30,34,99,16,49,54,68,53,66,16,99,100,81,98,100,62,81,102,42},16), rootAfter and rootAfter.Position)
end)
debug(_d({71,81,89,100,89,94,87,16,37,99,16,82,85,86,95,98,85,16,93,95,102,89,94,87,16,100,95,16,67,100,81,87,85,33},16))
task.wait(5)
for _, stage in ipairs({_d({67,100,81,87,85,33},16), _d({67,100,81,87,85,34},16), _d({67,100,81,87,85,35},16), _d({67,100,81,87,85,35,50},16)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({61,95,102,89,94,87,16,100,95,16,81,98,98,95,103,16,86,92,105,29,84,95,103,94,16,81,98,85,81},16))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({52,95,84,87,89,94,87,16,81,98,98,95,103,16,98,81,89,94},16))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({67,100,81,87,85,36},16))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({65,101,85,85,94,16,89,94,16,96,88,81,99,85,16,34,16,29,16,91,85,85,96,89,94,87,16,59,85,94,16,56,81,91,89,16,81,83,100,89,102,85,16,86,98,95,93,16,88,85,98,85,16,95,94},16))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({67,100,81,100,101,85,33},16))
if not enabled then return end
recheckStatue(_d({67,100,81,100,101,85,33},16))
destroyStatue(_d({67,100,81,100,101,85,34},16))
if not enabled then return end
recheckStatue(_d({67,100,81,100,101,85,33},16))
recheckStatue(_d({67,100,81,100,101,85,34},16))
destroyStatue(_d({67,100,81,100,101,85,35},16))
if not enabled then return end
recheckStatue(_d({67,100,81,100,101,85,35},16))
recheckStatue(_d({67,100,81,100,101,85,34},16))
recheckStatue(_d({67,100,81,100,101,85,33},16))
if not enabled then return end
debug(_d({71,81,89,100,89,94,87,16,86,95,98,16,96,88,81,99,85,16,34,16,100,95,16,85,94,84},16))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({64,88,81,99,85,16,34,16,85,94,84,16,103,81,89,100,16,100,89,93,85,95,101,100,28,16,96,98,95,83,85,85,84,89,94,87,16,81,94,105,103,81,105},16))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({61,95,102,89,94,87,16,82,81,83,91,16,100,95,16,65,101,85,85,94,16,99,100,81,87,85,16,96,95,99,89,100,89,95,94},16))
navToPointConfirmed(COORDS.Queen, 30, _d({65,101,85,85,94,16,99,100,81,87,85,16,96,95,99,89,100,89,95,94},16))
debug(_d({71,81,89,100,89,94,87,16,37,99,16,81,100,16,65,101,85,85,94,16,99,100,81,87,85,16,96,95,99,89,100,89,95,94},16))
task.wait(5)
if not enabled then return end
debug(_d({61,95,102,89,94,87,16,100,95,16,96,95,99,100,29,65,101,85,85,94,16,96,95,99,89,100,89,95,94},16))
navToPointConfirmed(COORDS.PostQueen, 30, _d({96,95,99,100,29,65,101,85,85,94,16,96,95,99,89,100,89,95,94},16))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({53,94,81,82,92,89,94,87,28,16,96,95,99,16,50,53,54,63,66,53,16,96,92,81,94,42},16), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({64,92,81,94,16,85,98,98,95,98,42},16), err2) end
end)
debug(_d({53,94,81,82,92,85,84,42},16), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({53,94,81,82,92,85,84,42},16), enabled)
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
if not ok then debug(_d({57,94,96,101,100,50,85,87,81,94,16,85,98,98,95,98,42},16), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({55,81,93,85,16,92,95,81,84,85,84,28,16,81,101,100,95,29,99,100,81,98,100,89,94,87,16,100,88,85,16,96,92,81,94},16))
enableBot()
end)
if not ok then debug(_d({49,101,100,95,99,100,81,98,100,16,85,98,98,95,98,42},16), err) end
end)
debug(_d({60,95,81,84,85,84,16,210,112,132,16,81,101,100,95,29,99,100,81,98,100,89,94,87,16,95,94,83,85,16,100,88,85,16,87,81,93,85,16,86,89,94,89,99,88,85,99,16,92,95,81,84,89,94,87,16,24,96,98,85,99,99,16,64,16,100,95,16,100,95,87,87,92,85,16,93,81,94,101,81,92,92,105,25},16))
end)()