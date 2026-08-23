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
local Players            = game:GetService(_d({34,62,51,75,55,68,69},46))
local UserInputService    = game:GetService(_d({39,69,55,68,27,64,66,71,70,37,55,68,72,59,53,55},46))
local RunService          = game:GetService(_d({36,71,64,37,55,68,72,59,53,55},46))
local VIM                 = game:GetService(_d({40,59,68,70,71,51,62,27,64,66,71,70,31,51,64,51,57,55,68},46))
local ReplicatedStorage    = game:GetService(_d({36,55,66,62,59,53,51,70,55,54,37,70,65,68,51,57,55},46))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({45,20,65,69,69,20,65,70,47},46), _d({41,68,65,64,57,242,57,51,63,55,242,180,82,102,242,34,62,51,53,55,27,54,12},46), game.PlaceId, _d({39,64,59,72,55,68,69,55,27,54,12},46), game.GameId, _d({255,242,64,65,70,242,68,71,64,64,59,64,57},46))
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
local LEO_PILLAR_ANIM_ID   = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,7,4,6,6,3,6,3,5,4,9},46)
local LEO_ENTEI_ANIM_ID    = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,7,4,6,6,3,5,10,4,9,10},46)
local LEO_HIKEN_ANIM_ID    = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,7,4,4,2,11,3,9,6,2,9},46)
local LEO_FIREFLY_ANIM_ID  = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,7,4,4,2,4,5,8,3,7,6},46)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({33,52,60,55,53,70,59,72,55,69},46)
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
local REPLAY_BUTTON_VALUE   = _d({36,55,66,62,51,75},46)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({63,65,72,55},46)
local NavState   = {mode = _d({59,54,62,55},46)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({45,20,65,69,69,20,65,70,47},46), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
end)
if ok then return root end
debug(_d({57,55,70,36,65,65,70,242,55,68,68,65,68,12},46), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
end)
if ok then return hum end
debug(_d({57,55,70,26,71,63,51,64,65,59,54,242,55,68,68,65,68,12},46), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({49,49,26,65,72,55,68,19,70,70},46)) or Instance.new(_d({19,70,70,51,53,58,63,55,64,70},46))
att.Name = _d({49,49,26,65,72,55,68,19,70,70},46)
att.Parent = root
local force = root:FindFirstChild(_d({49,49,26,65,72,55,68,24,65,68,53,55},46))
if not force then
force = Instance.new(_d({30,59,64,55,51,68,40,55,62,65,53,59,70,75},46))
force.Name = _d({49,49,26,65,72,55,68,24,65,68,53,55},46)
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
debug(_d({57,55,70,33,68,21,68,55,51,70,55,24,65,68,53,55,242,55,68,68,65,68,12},46), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not root then return end
local force = root:FindFirstChild(_d({49,49,26,65,72,55,68,24,65,68,53,55},46))
local att   = root:FindFirstChild(_d({49,49,26,65,72,55,68,19,70,70},46))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({53,62,55,51,64,71,66,24,65,68,53,55,242,55,68,68,65,68,12},46), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({20,71,69,65,31,55,62,55,55},46)) ~= nil
end)
if ok then return result end
debug(_d({59,69,20,71,69,65,19,53,70,59,72,55,242,55,68,68,65,68,12},46), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({20,71,69,65},46))
end)
if not ok then debug(_d({51,53,70,59,72,51,70,55,20,71,69,65,242,55,68,68,65,68,12},46), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({20,71,69,65,242,64,65,70,242,51,53,70,59,72,55,254,242,51,53,70,59,72,51,70,59,64,57},46))
activateBuso()
end
end)
if not ok then debug(_d({20,71,69,65,29,55,55,66,55,68,242,55,68,68,65,68,12},46), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({20,71,69,65,242,61,55,55,66,55,68,242,69,70,65,66,66,55,54},46))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({29,55,64,26,51,61,59},46)) ~= nil
end)
if ok then return result end
debug(_d({59,69,29,55,64,19,53,70,59,72,55,242,55,68,68,65,68,12},46), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({29,55,64},46), true)
end)
if not ok then debug(_d({51,53,70,59,72,51,70,55,29,55,64,242,55,68,68,65,68,12},46), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({29,55,64,242,64,65,70,242,51,53,70,59,72,55,254,242,51,53,70,59,72,51,70,59,64,57},46))
activateKen()
end
end)
if not ok then debug(_d({29,55,64,29,55,55,66,55,68,242,55,68,68,65,68,12},46), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({29,55,64,242,61,55,55,66,55,68,242,69,70,65,66,66,55,54},46))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({32,34,21,69},46)) end)
if ok then return folder end
debug(_d({57,55,70,32,34,21,69,24,65,62,54,55,68,242,55,68,68,65,68,12},46), folder)
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
local r = model:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
local h = model:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
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
debug(_d({57,55,70,32,55,51,68,55,69,70,32,34,21,242,55,68,68,65,68,12},46), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
local hum  = model:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({57,55,70,32,34,21,20,75,32,51,63,55,242,55,68,68,65,68,12},46), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({64,66,53,69,36,55,63,51,59,64,59,64,57,242,55,68,68,65,68,12},46), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({21,71,66,59,54,242,35,71,55,55,64},46))
return queen ~= nil and queen:FindFirstChild(_d({63,65,70,59,65,64,30,55,69,69},46)) ~= nil
end)
if ok then return result end
debug(_d({59,69,35,71,55,55,64,34,58,51,69,55,4,242,55,68,68,65,68,12},46), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,3,4,3,4,11,9,11,6,4,4,11,4,9,8,11},46)
local QUEEN_GRASP_ANIM_ID   = _d({68,52,74,51,69,69,55,70,59,54,12,1,1,3,4,11,10,2,2,2,8,3,2,2,3,9,5,6},46)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
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
debug(_d({59,69,34,62,51,75,59,64,57,19,64,59,63,24,68,65,63,30,59,69,70,242,55,68,68,65,68,12},46), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({20,62,65,53,61,59,64,57},46)) ~= nil
end)
if ok then return result end
debug(_d({59,69,32,34,21,20,62,65,53,61,59,64,57,242,55,68,68,65,68,12},46), result)
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
debug(_d({66,68,55,54,59,53,70,32,34,21,34,65,69,59,70,59,65,64,242,55,68,68,65,68,12},46), result)
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
debug(_d({32,65,242,54,51,63,51,57,55,242,65,64},46), model.Name, _d({56,65,68},46), NPC_STUCK_TIMEOUT, _d({69,242,255,242,69,73,59,70,53,58,59,64,57,242,70,51,68,57,55,70},46))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({70,68,51,53,61,32,34,21,22,51,63,51,57,55,242,55,68,68,65,68,12},46), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({31,65,54,55,62},46)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({20,51,69,55,34,51,68,70},46)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({57,55,70,31,65,54,55,62,24,51,53,55,34,65,69,242,55,68,68,65,68,12},46), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({23,64,72},46))
local folder = env and env:FindFirstChild(_d({37,70,51,70,71,55,69},46))
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
debug(_d({57,55,70,37,70,51,70,71,55,31,65,54,55,62,32,55,51,68,242,55,68,68,65,68,12},46), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({52,51,68,68,55,62,26,34},46))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({57,55,70,37,70,51,70,71,55,26,34,242,55,68,68,65,68,12},46), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({38,65,65,62},46)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({56,59,64,54,38,65,65,62,20,75,19,70,70,68,59,52,71,70,55,242,55,68,68,65,68,12},46), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({38,65,65,62},46)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({56,59,64,54,38,65,65,62,20,75,32,51,63,55,242,55,68,68,65,68,12},46), tool)
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
if not ok then debug(_d({55,67,71,59,66,38,65,65,62,242,55,68,68,65,68,12},46), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({20,51,53,61,66,51,53,61},46))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({38,65,65,62},46)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({56,59,64,54,38,65,65,62,20,75,21,58,59,62,54,32,51,63,55,242,55,68,68,65,68,12},46), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({37,73,65,68,54,23,67,71,59,66},46))
if sword then
equipTool(sword)
return _d({69,73,65,68,54},46)
end
local melee = findToolByAttribute(_d({31,55,62,55,55,38,65,65,62},46))
if melee then
equipTool(melee)
return _d({63,55,62,55,55},46)
end
debug(_d({32,65,242,69,73,65,68,54,242,65,68,242,63,55,62,55,55,242,70,65,65,62,242,56,65,71,64,54},46))
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
if not ok then debug(_d({53,62,59,53,61,31,3,242,55,68,68,65,68,12},46), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({26,71,63,51,64,65,59,54,36,65,65,70,34,51,68,70},46))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({37,70,51,70,69},46) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({36,65,61,71,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({25,55,66,66,65},46), args)
elseif style == _d({20,62,51,53,61,30,55,57},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61},46), args)
elseif style == _d({29,51,63,59,69,58,59,61,59},46) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({29,51,63,59,69,58,59,61,59,25,55,66,66,65},46), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,61,75,242,41,51,62,61,4},46), args)
end
end)
if not ok then debug(_d({59,64,72,65,61,55,25,55,66,66,65,242,55,68,68,65,68,12},46), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({66,68,55,69,69,37,61,59,62,62,36,242,55,68,68,65,68,12},46), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({58,65,62,54,20,62,65,53,61,242,55,68,68,65,68,12},46), err) end
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
if not ok then debug(_d({58,65,62,54,20,62,65,53,61,41,58,59,62,55,242,55,68,68,65,68,12},46), err) end
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
debug(_d({57,55,70,25,51,63,55,25,242,55,68,68,65,68,12},46), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({59,69,36,55,51,62,31,3,20,71,69,75,242,55,68,68,65,68,12},46), result)
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
return char ~= nil and char:FindFirstChild(_d({69,70,71,64},46)) ~= nil
end)
if ok then return result end
debug(_d({59,69,37,70,71,64,64,55,54,242,55,68,68,65,68,12},46), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({66,68,55,69,69,37,70,71,64,20,68,55,51,61,242,55,68,68,65,68,12},46), err) end
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
debug(_d({67,71,55,55,64,22,65,54,57,55,39,64,70,59,62,37,51,56,55,12,242,35,71,55,55,64,242,57,65,64,55,242,255,242,55,64,54,59,64,57,242,54,65,54,57,55,242,55,51,68,62,75},46))
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
debug(_d({67,71,55,55,64,22,65,54,57,55,39,64,70,59,62,37,51,56,55,242,69,51,56,55,70,75,242,70,59,63,55,65,71,70},46))
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
local info = getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({35,71,55,55,64,242,53,51,69,70,59,64,57,242,54,55,70,55,53,70,55,54,242,255,242,54,65,54,57,59,64,57,242,250,73,51,70,53,58,55,68,251},46))
queenDodgeUntilSafe(function() return getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46)) end)
if enabled and getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46)) then
setNavNamed(_d({21,71,66,59,54,242,35,71,55,55,64},46))
end
queenDodging = false
end
end)
if not ok then debug(_d({67,71,55,55,64,22,65,54,57,55,41,51,70,53,58,55,68,242,55,68,68,65,68,12},46), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({66,65,59,64,70},46) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({64,66,53},46) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({64,51,63,55,54},46) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({57,55,70,32,51,72,38,51,68,57,55,70,69,242,55,68,68,65,68,12},46), aimR)
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
debug(_d({53,65,63,66,71,70,55,30,65,53,61,55,54,21,24,68,51,63,55,242,55,68,68,65,68,12},46), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({66,65,59,64,70},46), point = pos}
phase = _d({63,65,72,55},46)
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
if not ok then debug(_d({64,51,72,38,65,34,65,59,64,70,242,57,55,66,66,65,242,53,58,55,53,61,242,55,68,68,65,68,12},46), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({64,66,53},46)}
phase = _d({63,65,72,55},46)
end
function setNavNamed(name)
NavState = {mode = _d({64,51,63,55,54},46), name = name}
phase = _d({63,65,72,55},46)
end
local function setNavIdle()
NavState = {mode = _d({59,54,62,55},46)}
phase = _d({63,65,72,55},46)
end
local function hasArrived()
return phase == _d({58,65,72,55,68},46)
end
local function startNav()
phase = _d({63,65,72,55},46)
debug(_d({32,51,72,242,62,65,65,66,242,33,32},46))
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
local prevPos = force:GetAttribute(_d({49,49,66,68,55,72,34,65,69},46))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({30,51,68,57,55,242,66,65,69,59,70,59,65,64,242,60,71,63,66,242,54,55,70,55,53,70,55,54,12},46), delta, _d({69,70,71,54,69,0,242,66,68,55,72,34,65,69,15},46), prevPos, _d({64,55,73,34,65,69,15},46), pos)
end
end
force:SetAttribute(_d({49,49,66,68,55,72,34,65,69},46), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({63,65,72,55},46) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({58,65,72,55,68},46)
debug(_d({34,58,51,69,55,12,242,58,65,72,55,68},46))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({243,243,243,242,36,23,24,39,37,27,32,25,242,38,33,242,19,34,34,30,43,242,19,20,32,33,36,31,19,30,242,40,23,30,33,21,27,38,43,12},46), finalVel, _d({51,59,63,15},46), aim, _d({66,65,69,15},46), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({58,65,72,55,68},46) then
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
debug(_d({21,65,63,52,51,70,242,62,65,53,61,242,69,61,59,66,66,55,54,254},46), snapDist, _d({69,70,71,54,69,242,56,68,65,63,242,70,51,68,57,55,70,242,180,82,102,242,56,51,62,62,59,64,57,242,52,51,53,61,242,70,65,242,63,65,72,55},46))
phase = _d({63,65,72,55},46)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({26,55,51,68,70,52,55,51,70,242,55,68,68,65,68,12},46), err) end
end)
end
local function stopNav()
debug(_d({32,51,72,242,62,65,65,66,242,33,24,24},46))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({63,65,72,55},46)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({38,55,74,70,21,58,51,70,37,55,68,72,59,53,55},46))
local channels = TextChatService:FindFirstChild(_d({38,55,74,70,21,58,51,64,64,55,62,69},46))
local channel = channels and channels:FindFirstChild(_d({36,20,42,25,55,64,55,68,51,62},46))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({22,55,56,51,71,62,70,21,58,51,70,37,75,69,70,55,63,21,58,51,70,23,72,55,64,70,69},46))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({37,51,75,31,55,69,69,51,57,55,36,55,67,71,55,69,70},46))
if sayEvent then
sayEvent:FireServer(message, _d({19,62,62},46))
return
end
debug(_d({69,55,64,54,21,58,51,70,31,55,69,69,51,57,55,12,242,64,65,242,38,55,74,70,21,58,51,70,37,55,68,72,59,53,55,0,36,20,42,25,55,64,55,68,51,62,242,65,68,242,62,55,57,51,53,75,242,37,51,75,31,55,69,69,51,57,55,36,55,67,71,55,69,70,242,56,65,71,64,54,242,56,65,68},46), message)
end)
if not ok then debug(_d({69,55,64,54,21,58,51,70,31,55,69,69,51,57,55,242,55,68,68,65,68,12},46), err) end
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
debug(_d({32,65,70,242,63,51,61,59,64,57,242,66,68,65,57,68,55,69,69,242,70,65,73,51,68,54,242,64,51,72,242,70,51,68,57,55,70,242,56,65,68},46), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({69,242,255,242,69,55,64,54,59,64,57,242,1,71,64,69,70,71,53,61},46))
sendChatMessage(_d({1,71,64,69,70,71,53,61},46))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({73,51,59,70,39,64,70,59,62,19,68,68,59,72,55,54,242,70,59,63,55,65,71,70},46))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({64,51,72,38,65,34,65,59,64,70,21,65,64,56,59,68,63,55,54,12},46), label or _d({70,51,68,57,55,70},46), _d({255,242,54,59,54,242,64,65,70,242,51,68,68,59,72,55,242,73,59,70,58,59,64},46), timeout, _d({69,254,242,68,55,70,68,75,59,64,57,242,65,64,53,55},46))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({64,51,72,38,65,34,65,59,64,70,21,65,64,56,59,68,63,55,54,12},46), label or _d({70,51,68,57,55,70},46), _d({255,242,69,70,59,62,62,242,64,65,70,242,51,68,68,59,72,55,54,242,51,56,70,55,68,242,68,55,70,68,75,254,242,66,68,65,53,55,55,54,59,64,57,242,51,64,75,73,51,75},46))
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
if not ok then debug(_d({64,51,72,38,65,34,65,59,64,70,26,65,62,54,59,64,57,20,62,65,53,61,242,61,55,75,255,54,65,73,64,242,55,68,68,65,68,12},46), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({64,51,72,38,65,34,65,59,64,70,26,65,62,54,59,64,57,20,62,65,53,61,242,61,55,75,255,71,66,242,55,68,68,65,68,12},46), err2) end
end
local function clearStage(stageName)
debug(_d({31,65,72,59,64,57,242,70,65},46), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({41,51,59,70,59,64,57,242,56,65,68,242,32,34,21,69,242,70,65,242,69,66,51,73,64,242,51,70},46), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({242,242,69,66,51,73,64,242,53,58,55,53,61,12,242,56,65,62,54,55,68,242,55,74,59,69,70,69,242,15},46), folder ~= nil,
_d({254,242,53,58,59,62,54,68,55,64,242,15},46), folder and #folder:GetChildren() or 0,
_d({254,242,51,62,59,72,55,242,15},46), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({32,65,242,32,34,21,69,242,51,66,66,55,51,68,55,54,242,51,70},46), stageName, _d({51,56,70,55,68,242,3,7,69,254,242,63,65,72,59,64,57,242,65,64,242,51,64,75,73,51,75},46))
break
end
end
debug(_d({29,59,62,62,59,64,57,242,32,34,21,69,242,51,70},46), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({36,55,70,71,68,64,59,64,57,242,70,65},46), stageName, _d({66,65,69,59,70,59,65,64,242,52,55,56,65,68,55,242,63,65,72,59,64,57,242,65,64},46))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({41,51,59,70,59,64,57,242,7,69,242,51,70},46), stageName, _d({66,65,69,59,70,59,65,64},46))
task.wait(5)
debug(stageName, _d({53,62,55,51,68,55,54},46))
end
local function killNamedNPC(name, targetPos)
debug(_d({31,65,72,59,64,57,242,70,65},46), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({54,55,56,55,51,70,55,54},46))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({26,71,63,51,64,65,59,54},46))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({30,55,65,242,66,62,51,75,55,54,242,51,64,59,63,51,70,59,65,64,12},46), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({62,55,65,19,64,59,63,30,65,57,57,55,68,242,66,68,59,64,70,242,55,68,68,65,68,12},46), err2) end
end)
end)
if not ok then debug(_d({69,70,51,68,70,30,55,65,19,64,59,63,30,65,57,57,55,68,242,55,68,68,65,68,12},46), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({31,65,72,59,64,57,242,70,65,242,30,55,65,242,250,52,62,65,53,61,59,64,57,242,51,56,70,55,68},46), LEO_BLOCK_DELAY, _d({69,251},46))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({30,55,65},46))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({30,55,65},46))
while enabled do
local info = getNPCByName(_d({30,55,65},46))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({30,55,65,242,53,51,69,70,59,64,57},46), which, _d({255,242,54,65,54,57,59,64,57},46))
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
if not getNPCByName(_d({30,55,65},46)) then
debug(_d({30,55,65,242,57,65,64,55,242,63,59,54,255,54,65,54,57,55,242,255,242,55,64,54,59,64,57,242,23,64,70,55,59,242,58,65,62,54,242,55,51,68,62,75},46))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({30,55,65},46)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({30,55,65,242,57,65,64,55,242,63,59,54,255,54,65,54,57,55,242,255,242,55,64,54,59,64,57,242,24,62,51,63,55,242,34,59,62,62,51,68,242,58,65,62,54,242,55,51,68,62,75},46))
end
end
end
if enabled and getNPCByName(_d({30,55,65},46)) then
setNavNamed(_d({30,55,65},46))
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
debug(_d({30,55,65,242,54,55,56,55,51,70,55,54},46))
stopLeoAnimLogger()
debug(_d({36,55,70,71,68,64,59,64,57,242,70,65,242,30,55,65,242,66,65,69,59,70,59,65,64,242,52,55,56,65,68,55,242,63,65,72,59,64,57,242,65,64},46))
navToPointConfirmed(COORDS.Leo, 30, _d({30,55,65,242,66,65,69,59,70,59,65,64},46))
debug(_d({41,51,59,70,59,64,57,242,7,69,242,51,70,242,30,55,65,242,66,65,69,59,70,59,65,64},46))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({31,65,72,59,64,57,242,70,65},46), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({21,65,71,62,54,242,64,65,70,242,56,59,64,54,242,69,70,51,70,71,55,242,63,65,54,55,62,242,64,55,51,68},46), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({19,70,70,51,53,61,59,64,57},46), coordKey, _d({73,59,70,58},46), weapon or _d({64,65,70,58,59,64,57,242,56,65,71,64,54},46))
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
debug(coordKey, _d({52,51,68,68,55,62,242,54,55,69,70,68,65,75,55,54},46))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({68,55,53,58,55,53,61,37,70,51,70,71,55,12},46), coordKey, _d({255,242,53,65,71,62,54,242,64,65,70,242,56,59,64,54,242,69,70,51,70,71,55,242,63,65,54,55,62,254,242,69,61,59,66,66,59,64,57},46))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({68,55,53,58,55,53,61,37,70,51,70,71,55,12},46), coordKey, _d({69,70,59,62,62,242,51,62,59,72,55,242,250,26,34},46), hp, _d({251,242,255,242,68,55,255,54,55,69,70,68,65,75,59,64,57},46))
destroyStatue(coordKey)
else
debug(_d({68,55,53,58,55,53,61,37,70,51,70,71,55,12},46), coordKey, _d({53,65,64,56,59,68,63,55,54,242,54,55,69,70,68,65,75,55,54},46))
end
end)
if not ok then debug(_d({68,55,53,58,55,53,61,37,70,51,70,71,55,242,55,68,68,65,68,12},46), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({31,65,72,59,64,57,242,70,65,242,35,71,55,55,64},46))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({21,71,66,59,54,242,35,71,55,55,64},46))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({35,71,55,55,64,242,55,64,70,55,68,55,54,242,66,58,51,69,55,242,4},46))
end
local function finishQueen()
debug(_d({24,59,64,59,69,58,59,64,57,242,35,71,55,55,64},46))
equipSwordOrMelee()
setNavNamed(_d({21,71,66,59,54,242,35,71,55,55,64},46))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({21,71,66,59,54,242,35,71,55,55,64},46))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({35,71,55,55,64,242,54,55,56,55,51,70,55,54,0,242,34,62,51,64,242,53,65,63,66,62,55,70,55,0},46))
end
local CONFIRMATION_PROMPT_NAME = _d({21,65,64,56,59,68,63,51,70,59,65,64,34,68,65,63,66,70},46)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({36,55,63,65,70,55,23,72,55,64,70},46), 5)
end)
if ok then return result end
debug(_d({57,55,70,36,55,66,62,51,75,36,55,63,65,70,55,242,55,68,68,65,68,12},46), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({34,62,51,75,55,68,25,71,59},46))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({27,63,51,57,55,20,71,70,70,65,64},46)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({52,71,70,70,65,64,40,51,62,71,55},46)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({56,59,64,54,20,71,70,70,65,64,20,75,40,51,62,71,55,242,55,68,68,65,68,12},46), result)
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
if not ok then debug(_d({53,62,59,53,61,25,71,59,20,71,70,70,65,64,242,55,68,68,65,68,12},46), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({59,69,37,55,68,72,55,68},46))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({36,55,63,65,70,55,23,72,55,64,70},46))
or inst:FindFirstChild(_d({53,62,59,55,64,70,23,72,55,64,70},46))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({56,59,64,54,19,64,69,73,55,68,21,65,64,64,55,53,70,65,68,242,55,68,68,65,68,12},46), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({21,65,71,62,54,242,64,65,70,242,62,65,53,51,70,55,242,36,55,63,65,70,55,23,72,55,64,70,1,53,62,59,55,64,70,23,72,55,64,70,242,64,55,51,68,242,36,55,66,62,51,75,242,52,71,70,70,65,64,254,242,56,51,62,62,59,64,57,242,52,51,53,61,242,70,65,242,53,62,59,53,61},46))
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
debug(_d({56,59,68,55,36,55,66,62,51,75,40,51,62,71,55,242,55,68,68,65,68,12},46), err, _d({255,242,56,51,62,62,59,64,57,242,52,51,53,61,242,70,65,242,53,62,59,53,61},46))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({24,51,62,62,59,64,57,242,52,51,53,61,242,70,65,242,52,71,70,70,65,64,40,51,62,71,55,242,69,55,51,68,53,58,242,56,65,68,242,36,55,66,62,51,75},46))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({36,55,66,62,51,75,242,52,71,70,70,65,64,242,64,65,70,242,56,65,71,64,54,242,55,59,70,58,55,68,254,242,57,59,72,59,64,57,242,71,66},46))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({41,51,59,70,59,64,57,242,56,65,68,242,21,65,64,56,59,68,63,51,70,59,65,64,34,68,65,63,66,70,0,36,55,63,65,70,55,23,72,55,64,70},46))
local remote = getReplayRemote()
if not remote then
debug(_d({21,65,64,56,59,68,63,51,70,59,65,64,34,68,65,63,66,70,1,36,55,63,65,70,55,23,72,55,64,70,242,64,65,70,242,56,65,71,64,54,242,73,59,70,58,59,64,242,70,59,63,55,65,71,70},46))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({24,59,68,59,64,57,242,36,55,66,62,51,75,242,72,59,51,242,21,65,64,56,59,68,63,51,70,59,65,64,34,68,65,63,66,70,0,36,55,63,65,70,55,23,72,55,64,70},46))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({24,59,68,55,37,55,68,72,55,68,242,55,68,68,65,68,12},46), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({34,62,51,75,55,68,25,71,59},46), 10)
if not playerGui then
debug(_d({73,51,59,70,24,65,68,33,52,60,55,53,70,59,72,55,69,25,71,59,12,242,64,65,242,34,62,51,75,55,68,25,71,59,242,73,59,70,58,59,64,242,70,59,63,55,65,71,70,254,242,66,68,65,53,55,55,54,59,64,57,242,51,64,75,73,51,75},46))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({33,52,60,55,53,70,59,72,55,69,242,25,39,27,242,56,65,71,64,54,242,255,242,69,70,51,57,55,242,62,65,51,54,55,54},46))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({33,52,60,55,53,70,59,72,55,69,242,25,39,27,242,64,65,70,242,56,65,71,64,54,242,73,59,70,58,59,64,242,70,59,63,55,65,71,70,254,242,66,68,65,53,55,55,54,59,64,57,242,51,64,75,73,51,75},46))
return
end
end
end)
if not ok then debug(_d({73,51,59,70,24,65,68,33,52,60,55,53,70,59,72,55,69,25,71,59,242,55,68,68,65,68,12},46), err) end
end
local function runPlan()
debug(_d({34,62,51,64,242,69,70,51,68,70,55,54},46))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({37,70,51,68,70,59,64,57,242,64,51,72,242,62,65,65,66},46))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({66,65,69,242,2,0,4,69,242,19,24,38,23,36,242,69,70,51,68,70,32,51,72,12},46), rootAfter and rootAfter.Position)
end)
debug(_d({41,51,59,70,59,64,57,242,7,69,242,52,55,56,65,68,55,242,63,65,72,59,64,57,242,70,65,242,37,70,51,57,55,3},46))
task.wait(5)
for _, stage in ipairs({_d({37,70,51,57,55,3},46), _d({37,70,51,57,55,4},46), _d({37,70,51,57,55,5},46), _d({37,70,51,57,55,5,20},46)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({31,65,72,59,64,57,242,70,65,242,51,68,68,65,73,242,56,62,75,255,54,65,73,64,242,51,68,55,51},46))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({22,65,54,57,59,64,57,242,51,68,68,65,73,242,68,51,59,64},46))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({37,70,51,57,55,6},46))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({35,71,55,55,64,242,59,64,242,66,58,51,69,55,242,4,242,255,242,61,55,55,66,59,64,57,242,29,55,64,242,26,51,61,59,242,51,53,70,59,72,55,242,56,68,65,63,242,58,55,68,55,242,65,64},46))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({37,70,51,70,71,55,3},46))
if not enabled then return end
recheckStatue(_d({37,70,51,70,71,55,3},46))
destroyStatue(_d({37,70,51,70,71,55,4},46))
if not enabled then return end
recheckStatue(_d({37,70,51,70,71,55,3},46))
recheckStatue(_d({37,70,51,70,71,55,4},46))
destroyStatue(_d({37,70,51,70,71,55,5},46))
if not enabled then return end
recheckStatue(_d({37,70,51,70,71,55,5},46))
recheckStatue(_d({37,70,51,70,71,55,4},46))
recheckStatue(_d({37,70,51,70,71,55,3},46))
if not enabled then return end
debug(_d({41,51,59,70,59,64,57,242,56,65,68,242,66,58,51,69,55,242,4,242,70,65,242,55,64,54},46))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({34,58,51,69,55,242,4,242,55,64,54,242,73,51,59,70,242,70,59,63,55,65,71,70,254,242,66,68,65,53,55,55,54,59,64,57,242,51,64,75,73,51,75},46))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({31,65,72,59,64,57,242,52,51,53,61,242,70,65,242,35,71,55,55,64,242,69,70,51,57,55,242,66,65,69,59,70,59,65,64},46))
navToPointConfirmed(COORDS.Queen, 30, _d({35,71,55,55,64,242,69,70,51,57,55,242,66,65,69,59,70,59,65,64},46))
debug(_d({41,51,59,70,59,64,57,242,7,69,242,51,70,242,35,71,55,55,64,242,69,70,51,57,55,242,66,65,69,59,70,59,65,64},46))
task.wait(5)
if not enabled then return end
debug(_d({31,65,72,59,64,57,242,70,65,242,66,65,69,70,255,35,71,55,55,64,242,66,65,69,59,70,59,65,64},46))
navToPointConfirmed(COORDS.PostQueen, 30, _d({66,65,69,70,255,35,71,55,55,64,242,66,65,69,59,70,59,65,64},46))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({23,64,51,52,62,59,64,57,254,242,66,65,69,242,20,23,24,33,36,23,242,66,62,51,64,12},46), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({34,62,51,64,242,55,68,68,65,68,12},46), err2) end
end)
debug(_d({23,64,51,52,62,55,54,12},46), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({23,64,51,52,62,55,54,12},46), enabled)
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
if not ok then debug(_d({27,64,66,71,70,20,55,57,51,64,242,55,68,68,65,68,12},46), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({25,51,63,55,242,62,65,51,54,55,54,254,242,51,71,70,65,255,69,70,51,68,70,59,64,57,242,70,58,55,242,66,62,51,64},46))
enableBot()
end)
if not ok then debug(_d({19,71,70,65,69,70,51,68,70,242,55,68,68,65,68,12},46), err) end
end)
debug(_d({30,65,51,54,55,54,242,180,82,102,242,51,71,70,65,255,69,70,51,68,70,59,64,57,242,65,64,53,55,242,70,58,55,242,57,51,63,55,242,56,59,64,59,69,58,55,69,242,62,65,51,54,59,64,57,242,250,66,68,55,69,69,242,34,242,70,65,242,70,65,57,57,62,55,242,63,51,64,71,51,62,62,75,251},46))
end)()