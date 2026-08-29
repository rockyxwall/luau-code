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
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({50,78,67,91,71,84,85},30))
local UserInputService    = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local RunService          = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local VIM                 = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local ReplicatedStorage    = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
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
local LEO_PILLAR_ANIM_ID   = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,23,20,22,22,19,22,19,21,20,25},30)
local LEO_ENTEI_ANIM_ID    = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,23,20,22,22,19,21,26,20,25,26},30)
local LEO_HIKEN_ANIM_ID    = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,23,20,20,18,27,19,25,22,18,25},30)
local LEO_FIREFLY_ANIM_ID  = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,23,20,20,18,20,21,24,19,23,22},30)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({49,68,76,71,69,86,75,88,71,85},30)
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
local REPLAY_BUTTON_VALUE   = _d({52,71,82,78,67,91},30)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({79,81,88,71},30)
local NavState   = {mode = _d({75,70,78,71},30)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({61,36,81,85,85,36,81,86,63},30), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end)
if ok then return root end
debug(_d({73,71,86,52,81,81,86,2,71,84,84,81,84,28},30), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
end)
if ok then return hum end
debug(_d({73,71,86,42,87,79,67,80,81,75,70,2,71,84,84,81,84,28},30), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({65,65,42,81,88,71,84,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,42,81,88,71,84,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,42,81,88,71,84,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,42,81,88,71,84,40,81,84,69,71},30)
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
debug(_d({73,71,86,49,84,37,84,71,67,86,71,40,81,84,69,71,2,71,84,84,81,84,28},30), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local force = root:FindFirstChild(_d({65,65,42,81,88,71,84,40,81,84,69,71},30))
local att   = root:FindFirstChild(_d({65,65,42,81,88,71,84,35,86,86},30))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({69,78,71,67,80,87,82,40,81,84,69,71,2,71,84,84,81,84,28},30), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({36,87,85,81,47,71,78,71,71},30)) ~= nil
end)
if ok then return result end
debug(_d({75,85,36,87,85,81,35,69,86,75,88,71,2,71,84,84,81,84,28},30), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({36,87,85,81},30))
end)
if not ok then debug(_d({67,69,86,75,88,67,86,71,36,87,85,81,2,71,84,84,81,84,28},30), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({36,87,85,81,2,80,81,86,2,67,69,86,75,88,71,14,2,67,69,86,75,88,67,86,75,80,73},30))
activateBuso()
end
end)
if not ok then debug(_d({36,87,85,81,45,71,71,82,71,84,2,71,84,84,81,84,28},30), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({36,87,85,81,2,77,71,71,82,71,84,2,85,86,81,82,82,71,70},30))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({45,71,80,42,67,77,75},30)) ~= nil
end)
if ok then return result end
debug(_d({75,85,45,71,80,35,69,86,75,88,71,2,71,84,84,81,84,28},30), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({45,71,80},30), true)
end)
if not ok then debug(_d({67,69,86,75,88,67,86,71,45,71,80,2,71,84,84,81,84,28},30), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({45,71,80,2,80,81,86,2,67,69,86,75,88,71,14,2,67,69,86,75,88,67,86,75,80,73},30))
activateKen()
end
end)
if not ok then debug(_d({45,71,80,45,71,71,82,71,84,2,71,84,84,81,84,28},30), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({45,71,80,2,77,71,71,82,71,84,2,85,86,81,82,82,71,70},30))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({48,50,37,85},30)) end)
if ok then return folder end
debug(_d({73,71,86,48,50,37,85,40,81,78,70,71,84,2,71,84,84,81,84,28},30), folder)
return nil
end
local function getNearestNPC(exclude)
local ok, result = pcall(function()
local root = Core.GetRoot(LocalPlayer)
local folder = getNPCsFolder()
if not root or not folder then return nil end
local nearest, nearestDist = nil, math.huge
local fallbackNearest, fallbackDist = nil, math.huge
for _, model in ipairs(folder:GetChildren()) do
local okp, info = pcall(function()
local r = model:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local h = model:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
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
debug(_d({73,71,86,48,71,67,84,71,85,86,48,50,37,2,71,84,84,81,84,28},30), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum  = model:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({73,71,86,48,50,37,36,91,48,67,79,71,2,71,84,84,81,84,28},30), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({80,82,69,85,52,71,79,67,75,80,75,80,73,2,71,84,84,81,84,28},30), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({37,87,82,75,70,2,51,87,71,71,80},30))
return queen ~= nil and queen:FindFirstChild(_d({79,81,86,75,81,80,46,71,85,85},30)) ~= nil
end)
if ok then return result end
debug(_d({75,85,51,87,71,71,80,50,74,67,85,71,20,2,71,84,84,81,84,28},30), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,19,20,19,20,27,25,27,22,20,20,27,20,25,24,27},30)
local QUEEN_GRASP_ANIM_ID   = _d({84,68,90,67,85,85,71,86,75,70,28,17,17,19,20,27,26,18,18,18,24,19,18,18,19,25,21,22},30)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
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
debug(_d({75,85,50,78,67,91,75,80,73,35,80,75,79,40,84,81,79,46,75,85,86,2,71,84,84,81,84,28},30), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({36,78,81,69,77,75,80,73},30)) ~= nil
end)
if ok then return result end
debug(_d({75,85,48,50,37,36,78,81,69,77,75,80,73,2,71,84,84,81,84,28},30), result)
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
debug(_d({82,84,71,70,75,69,86,48,50,37,50,81,85,75,86,75,81,80,2,71,84,84,81,84,28},30), result)
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
debug(_d({48,81,2,70,67,79,67,73,71,2,81,80},30), model.Name, _d({72,81,84},30), NPC_STUCK_TIMEOUT, _d({85,2,15,2,85,89,75,86,69,74,75,80,73,2,86,67,84,73,71,86},30))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({86,84,67,69,77,48,50,37,38,67,79,67,73,71,2,71,84,84,81,84,28},30), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({47,81,70,71,78},30)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({36,67,85,71,50,67,84,86},30)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({73,71,86,47,81,70,71,78,40,67,69,71,50,81,85,2,71,84,84,81,84,28},30), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({39,80,88},30))
local folder = env and env:FindFirstChild(_d({53,86,67,86,87,71,85},30))
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
debug(_d({73,71,86,53,86,67,86,87,71,47,81,70,71,78,48,71,67,84,2,71,84,84,81,84,28},30), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({68,67,84,84,71,78,42,50},30))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({73,71,86,53,86,67,86,87,71,42,50,2,71,84,84,81,84,28},30), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({54,81,81,78},30)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({72,75,80,70,54,81,81,78,36,91,35,86,86,84,75,68,87,86,71,2,71,84,84,81,84,28},30), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({54,81,81,78},30)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({72,75,80,70,54,81,81,78,36,91,48,67,79,71,2,71,84,84,81,84,28},30), tool)
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
if not ok then debug(_d({71,83,87,75,82,54,81,81,78,2,71,84,84,81,84,28},30), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({54,81,81,78},30)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({72,75,80,70,54,81,81,78,36,91,37,74,75,78,70,48,67,79,71,2,71,84,84,81,84,28},30), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({53,89,81,84,70,39,83,87,75,82},30))
if sword then
equipTool(sword)
return _d({85,89,81,84,70},30)
end
local melee = findToolByAttribute(_d({47,71,78,71,71,54,81,81,78},30))
if melee then
equipTool(melee)
return _d({79,71,78,71,71},30)
end
debug(_d({48,81,2,85,89,81,84,70,2,81,84,2,79,71,78,71,71,2,86,81,81,78,2,72,81,87,80,70},30))
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
if not ok then debug(_d({69,78,75,69,77,47,19,2,71,84,84,81,84,28},30), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({53,86,67,86,85},30) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({52,81,77,87,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,71,82,82,81},30), args)
elseif style == _d({36,78,67,69,77,46,71,73},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77},30), args)
elseif style == _d({45,67,79,75,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,67,79,75,85,74,75,77,75,41,71,82,82,81},30), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77,20},30), args)
end
end)
if not ok then debug(_d({75,80,88,81,77,71,41,71,82,82,81,2,71,84,84,81,84,28},30), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({82,84,71,85,85,53,77,75,78,78,52,2,71,84,84,81,84,28},30), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({74,81,78,70,36,78,81,69,77,2,71,84,84,81,84,28},30), err) end
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
if not ok then debug(_d({74,81,78,70,36,78,81,69,77,57,74,75,78,71,2,71,84,84,81,84,28},30), err) end
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
debug(_d({73,71,86,41,67,79,71,41,2,71,84,84,81,84,28},30), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({75,85,52,71,67,78,47,19,36,87,85,91,2,71,84,84,81,84,28},30), result)
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
return char ~= nil and char:FindFirstChild(_d({85,86,87,80},30)) ~= nil
end)
if ok then return result end
debug(_d({75,85,53,86,87,80,80,71,70,2,71,84,84,81,84,28},30), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({82,84,71,85,85,53,86,87,80,36,84,71,67,77,2,71,84,84,81,84,28},30), err) end
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
local root = Core.GetRoot(LocalPlayer)
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
debug(_d({83,87,71,71,80,38,81,70,73,71,55,80,86,75,78,53,67,72,71,28,2,51,87,71,71,80,2,73,81,80,71,2,15,2,71,80,70,75,80,73,2,70,81,70,73,71,2,71,67,84,78,91},30))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({83,87,71,71,80,38,81,70,73,71,55,80,86,75,78,53,67,72,71,2,85,67,72,71,86,91,2,86,75,79,71,81,87,86},30))
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
local info = getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({51,87,71,71,80,2,69,67,85,86,75,80,73,2,70,71,86,71,69,86,71,70,2,15,2,70,81,70,73,75,80,73,2,10,89,67,86,69,74,71,84,11},30))
queenDodgeUntilSafe(function() return getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30)) end)
if enabled and getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30)) then
setNavNamed(_d({37,87,82,75,70,2,51,87,71,71,80},30))
end
queenDodging = false
end
end)
if not ok then debug(_d({83,87,71,71,80,38,81,70,73,71,57,67,86,69,74,71,84,2,71,84,84,81,84,28},30), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({82,81,75,80,86},30) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({80,82,69},30) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({80,67,79,71,70},30) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({73,71,86,48,67,88,54,67,84,73,71,86,85,2,71,84,84,81,84,28},30), aimR)
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
debug(_d({69,81,79,82,87,86,71,46,81,69,77,71,70,37,40,84,67,79,71,2,71,84,84,81,84,28},30), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({82,81,75,80,86},30), point = pos}
phase = _d({79,81,88,71},30)
end
function navToPoint(pos, skipExtraGeppo)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
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
if not ok then debug(_d({80,67,88,54,81,50,81,75,80,86,2,73,71,82,82,81,2,69,74,71,69,77,2,71,84,84,81,84,28},30), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({80,82,69},30)}
phase = _d({79,81,88,71},30)
end
function setNavNamed(name)
NavState = {mode = _d({80,67,79,71,70},30), name = name}
phase = _d({79,81,88,71},30)
end
local function setNavIdle()
NavState = {mode = _d({75,70,78,71},30)}
phase = _d({79,81,88,71},30)
end
local function hasArrived()
return phase == _d({74,81,88,71,84},30)
end
local function startNav()
phase = _d({79,81,88,71},30)
debug(_d({48,67,88,2,78,81,81,82,2,49,48},30))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({50,78,67,91,71,84,2,70,75,71,70,3,2,53,86,81,82,82,75,80,73,2,68,81,86,16},30))
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
debug(_d({50,78,67,91,71,84,2,75,85,2,86,81,81,2,72,67,84,2,72,84,81,79,2,86,67,84,73,71,86,2,10,32,20,18,18,18,2,85,86,87,70,85,11,16,2,46,75,77,71,78,91,2,84,71,85,82,67,89,80,71,70,2,67,86,2,78,81,68,68,91,16,2,53,86,81,82,82,75,80,73,2,68,81,86,16},30))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({65,65,82,84,71,88,50,81,85},30))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({46,67,84,73,71,2,82,81,85,75,86,75,81,80,2,76,87,79,82,2,70,71,86,71,69,86,71,70,28},30), delta, _d({85,86,87,70,85,16,2,82,84,71,88,50,81,85,31},30), prevPos, _d({80,71,89,50,81,85,31},30), pos)
end
end
force:SetAttribute(_d({65,65,82,84,71,88,50,81,85},30), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({79,81,88,71},30) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({74,81,88,71,84},30)
debug(_d({50,74,67,85,71,28,2,74,81,88,71,84},30))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({3,3,3,2,52,39,40,55,53,43,48,41,2,54,49,2,35,50,50,46,59,2,35,36,48,49,52,47,35,46,2,56,39,46,49,37,43,54,59,28},30), finalVel, _d({67,75,79,31},30), aim, _d({82,81,85,31},30), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({74,81,88,71,84},30) then
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
debug(_d({37,81,79,68,67,86,2,78,81,69,77,2,85,77,75,82,82,71,70,14},30), snapDist, _d({85,86,87,70,85,2,72,84,81,79,2,86,67,84,73,71,86,2,196,98,118,2,72,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,79,81,88,71},30))
phase = _d({79,81,88,71},30)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({42,71,67,84,86,68,71,67,86,2,71,84,84,81,84,28},30), err) end
end)
end
local function stopNav()
debug(_d({48,67,88,2,78,81,81,82,2,49,40,40},30))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({79,81,88,71},30)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({54,71,90,86,37,74,67,86,53,71,84,88,75,69,71},30))
local channels = TextChatService:FindFirstChild(_d({54,71,90,86,37,74,67,80,80,71,78,85},30))
local channel = channels and channels:FindFirstChild(_d({52,36,58,41,71,80,71,84,67,78},30))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({38,71,72,67,87,78,86,37,74,67,86,53,91,85,86,71,79,37,74,67,86,39,88,71,80,86,85},30))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({53,67,91,47,71,85,85,67,73,71,52,71,83,87,71,85,86},30))
if sayEvent then
sayEvent:FireServer(message, _d({35,78,78},30))
return
end
debug(_d({85,71,80,70,37,74,67,86,47,71,85,85,67,73,71,28,2,80,81,2,54,71,90,86,37,74,67,86,53,71,84,88,75,69,71,16,52,36,58,41,71,80,71,84,67,78,2,81,84,2,78,71,73,67,69,91,2,53,67,91,47,71,85,85,67,73,71,52,71,83,87,71,85,86,2,72,81,87,80,70,2,72,81,84},30), message)
end)
if not ok then debug(_d({85,71,80,70,37,74,67,86,47,71,85,85,67,73,71,2,71,84,84,81,84,28},30), err) end
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
local root = Core.GetRoot(LocalPlayer)
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
debug(_d({48,81,86,2,79,67,77,75,80,73,2,82,84,81,73,84,71,85,85,2,86,81,89,67,84,70,2,80,67,88,2,86,67,84,73,71,86,2,72,81,84},30), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({85,2,15,2,85,71,80,70,75,80,73,2,17,87,80,85,86,87,69,77},30))
sendChatMessage(_d({17,87,80,85,86,87,69,77},30))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({89,67,75,86,55,80,86,75,78,35,84,84,75,88,71,70,2,86,75,79,71,81,87,86},30))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({80,67,88,54,81,50,81,75,80,86,37,81,80,72,75,84,79,71,70,28},30), label or _d({86,67,84,73,71,86},30), _d({15,2,70,75,70,2,80,81,86,2,67,84,84,75,88,71,2,89,75,86,74,75,80},30), timeout, _d({85,14,2,84,71,86,84,91,75,80,73,2,81,80,69,71},30))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({80,67,88,54,81,50,81,75,80,86,37,81,80,72,75,84,79,71,70,28},30), label or _d({86,67,84,73,71,86},30), _d({15,2,85,86,75,78,78,2,80,81,86,2,67,84,84,75,88,71,70,2,67,72,86,71,84,2,84,71,86,84,91,14,2,82,84,81,69,71,71,70,75,80,73,2,67,80,91,89,67,91},30))
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
if not ok then debug(_d({80,67,88,54,81,50,81,75,80,86,42,81,78,70,75,80,73,36,78,81,69,77,2,77,71,91,15,70,81,89,80,2,71,84,84,81,84,28},30), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({80,67,88,54,81,50,81,75,80,86,42,81,78,70,75,80,73,36,78,81,69,77,2,77,71,91,15,87,82,2,71,84,84,81,84,28},30), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({57,67,78,77,75,80,73,2,86,81,28},30), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({89,67,78,77,54,81,50,81,75,80,86,2,57,2,70,81,89,80,2,71,84,84,81,84,28},30), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
local hum = getHumanoid()
local startHP = hum and hum.Health or math.huge
local lastUnstuckCheck = tick()
local lastPos = nil
local stuckTicks = 0
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({54,81,81,77,2,70,67,79,67,73,71,2,89,74,75,78,71,2,89,67,78,77,75,80,73,2,86,81,2,82,81,75,80,86,3,2,53,86,81,82,82,75,80,73,2,89,67,78,77,2,86,81,2,71,80,73,67,73,71,16},30))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({35,84,84,75,88,71,70,2,67,86,28},30), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({53,86,87,69,77,2,70,87,84,75,80,73,2,89,67,78,77,14,2,76,87,79,82,75,80,73,3},30))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({53,86,75,78,78,2,85,86,87,69,77,14,2,86,84,75,73,73,71,84,75,80,73,2,41,71,82,82,81,3},30))
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
debug(_d({47,81,88,75,80,73,2,86,81},30), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({57,67,75,86,75,80,73,2,72,81,84,2,48,50,37,85,2,86,81,2,85,82,67,89,80,2,67,86},30), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({2,2,85,82,67,89,80,2,69,74,71,69,77,28,2,72,81,78,70,71,84,2,71,90,75,85,86,85,2,31},30), folder ~= nil,
_d({14,2,69,74,75,78,70,84,71,80,2,31},30), folder and #folder:GetChildren() or 0,
_d({14,2,67,78,75,88,71,2,31},30), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({48,81,2,48,50,37,85,2,67,82,82,71,67,84,71,70,2,67,86},30), stageName, _d({67,72,86,71,84,2,19,23,85,14,2,79,81,88,75,80,73,2,81,80,2,67,80,91,89,67,91},30))
break
end
end
debug(_d({45,75,78,78,75,80,73,2,48,50,37,85,2,67,86},30), stageName)
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
debug(_d({52,71,86,87,84,80,75,80,73,2,86,81},30), stageName, _d({82,81,85,75,86,75,81,80,2,68,71,72,81,84,71,2,79,81,88,75,80,73,2,81,80},30))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({57,67,75,86,75,80,73,2,23,85,2,67,86},30), stageName, _d({82,81,85,75,86,75,81,80},30))
task.wait(5)
debug(_d({57,67,75,86,75,80,73,2,72,81,84},30), targetHP * 100, _d({7,2,42,50,2,68,71,72,81,84,71,2,79,81,88,75,80,73,2,86,81,2,80,71,90,86,2,85,86,67,73,71},30))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({69,78,71,67,84,71,70},30))
end
local function killNamedNPC(name, targetPos)
debug(_d({47,81,88,75,80,73,2,86,81},30), name)
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
debug(name, _d({70,71,72,71,67,86,71,70},30))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({46,71,81,2,82,78,67,91,71,70,2,67,80,75,79,67,86,75,81,80,28},30), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({78,71,81,35,80,75,79,46,81,73,73,71,84,2,82,84,75,80,86,2,71,84,84,81,84,28},30), err2) end
end)
end)
if not ok then debug(_d({85,86,67,84,86,46,71,81,35,80,75,79,46,81,73,73,71,84,2,71,84,84,81,84,28},30), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({47,81,88,75,80,73,2,86,81,2,46,71,81},30))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({46,71,81},30))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({46,71,81},30))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({46,71,81},30))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({46,71,81,2,69,67,85,86,75,80,73},30), which, _d({15,2,70,81,70,73,75,80,73},30))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({46,71,81,2,85,86,67,84,86,71,70,2,68,78,81,69,77,15,68,84,71,67,77,71,84,2,79,75,70,15,68,78,81,69,77,3,2,39,88,67,70,75,80,73,16,16,16},30))
break
end
task.wait(0.1)
holdTime += 0.1
end
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
else
local root = Core.GetRoot(LocalPlayer)
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
if not getNPCByName(_d({46,71,81},30)) then
debug(_d({46,71,81,2,73,81,80,71,2,79,75,70,15,70,81,70,73,71,2,15,2,71,80,70,75,80,73,2,39,80,86,71,75,2,74,81,78,70,2,71,67,84,78,91},30))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({46,71,81},30)) then
setNavNamed(_d({46,71,81},30))
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
debug(_d({46,71,81,2,70,71,72,71,67,86,71,70},30))
stopLeoAnimLogger()
debug(_d({52,71,86,87,84,80,75,80,73,2,86,81,2,46,71,81,2,82,81,85,75,86,75,81,80,2,68,71,72,81,84,71,2,79,81,88,75,80,73,2,81,80},30))
navToPointConfirmed(COORDS.Leo, 30, _d({46,71,81,2,82,81,85,75,86,75,81,80},30))
debug(_d({57,67,75,86,75,80,73,2,23,85,2,67,86,2,46,71,81,2,82,81,85,75,86,75,81,80},30))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({47,81,88,75,80,73,2,86,81},30), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({37,81,87,78,70,2,80,81,86,2,72,75,80,70,2,85,86,67,86,87,71,2,79,81,70,71,78,2,80,71,67,84},30), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({35,86,86,67,69,77,75,80,73},30), coordKey, _d({89,75,86,74},30), weapon or _d({80,81,86,74,75,80,73,2,72,81,87,80,70},30))
setNavIdle()
while enabled and getStatueHP(statueModel) > 0 do
local root = Core.GetRoot(LocalPlayer)
local facePos = getModelFacePos(statueModel)
if root and facePos then
pcall(function()
root.CFrame = computeLookDownCFrame(root, facePos)
end)
end
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(coordKey, _d({68,67,84,84,71,78,2,70,71,85,86,84,81,91,71,70},30))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({84,71,69,74,71,69,77,53,86,67,86,87,71,28},30), coordKey, _d({15,2,69,81,87,78,70,2,80,81,86,2,72,75,80,70,2,85,86,67,86,87,71,2,79,81,70,71,78,14,2,85,77,75,82,82,75,80,73},30))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({84,71,69,74,71,69,77,53,86,67,86,87,71,28},30), coordKey, _d({85,86,75,78,78,2,67,78,75,88,71,2,10,42,50},30), hp, _d({11,2,15,2,84,71,15,70,71,85,86,84,81,91,75,80,73},30))
destroyStatue(coordKey)
else
debug(_d({84,71,69,74,71,69,77,53,86,67,86,87,71,28},30), coordKey, _d({69,81,80,72,75,84,79,71,70,2,70,71,85,86,84,81,91,71,70},30))
end
end)
if not ok then debug(_d({84,71,69,74,71,69,77,53,86,67,86,87,71,2,71,84,84,81,84,28},30), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({47,81,88,75,80,73,2,86,81,2,51,87,71,71,80},30))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({37,87,82,75,70,2,51,87,71,71,80},30))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30))
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
debug(_d({51,87,71,71,80,2,71,80,86,71,84,71,70,2,82,74,67,85,71,2,20},30))
end
local function finishQueen()
debug(_d({40,75,80,75,85,74,75,80,73,2,51,87,71,71,80},30))
equipSwordOrMelee()
setNavNamed(_d({37,87,82,75,70,2,51,87,71,71,80},30))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({37,87,82,75,70,2,51,87,71,71,80},30))
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
debug(_d({51,87,71,71,80,2,70,71,72,71,67,86,71,70,16,2,50,78,67,80,2,69,81,79,82,78,71,86,71,16},30))
end
local CONFIRMATION_PROMPT_NAME = _d({37,81,80,72,75,84,79,67,86,75,81,80,50,84,81,79,82,86},30)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({52,71,79,81,86,71,39,88,71,80,86},30), 5)
end)
if ok then return result end
debug(_d({73,71,86,52,71,82,78,67,91,52,71,79,81,86,71,2,71,84,84,81,84,28},30), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({50,78,67,91,71,84,41,87,75},30))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({43,79,67,73,71,36,87,86,86,81,80},30)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({68,87,86,86,81,80,56,67,78,87,71},30)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({72,75,80,70,36,87,86,86,81,80,36,91,56,67,78,87,71,2,71,84,84,81,84,28},30), result)
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
if not ok then debug(_d({69,78,75,69,77,41,87,75,36,87,86,86,81,80,2,71,84,84,81,84,28},30), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({75,85,53,71,84,88,71,84},30))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({52,71,79,81,86,71,39,88,71,80,86},30))
or inst:FindFirstChild(_d({69,78,75,71,80,86,39,88,71,80,86},30))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({72,75,80,70,35,80,85,89,71,84,37,81,80,80,71,69,86,81,84,2,71,84,84,81,84,28},30), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({37,81,87,78,70,2,80,81,86,2,78,81,69,67,86,71,2,52,71,79,81,86,71,39,88,71,80,86,17,69,78,75,71,80,86,39,88,71,80,86,2,80,71,67,84,2,52,71,82,78,67,91,2,68,87,86,86,81,80,14,2,72,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,69,78,75,69,77},30))
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
debug(_d({72,75,84,71,52,71,82,78,67,91,56,67,78,87,71,2,71,84,84,81,84,28},30), err, _d({15,2,72,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,69,78,75,69,77},30))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({40,67,78,78,75,80,73,2,68,67,69,77,2,86,81,2,68,87,86,86,81,80,56,67,78,87,71,2,85,71,67,84,69,74,2,72,81,84,2,52,71,82,78,67,91},30))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({52,71,82,78,67,91,2,68,87,86,86,81,80,2,80,81,86,2,72,81,87,80,70,2,71,75,86,74,71,84,14,2,73,75,88,75,80,73,2,87,82},30))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({57,67,75,86,75,80,73,2,72,81,84,2,37,81,80,72,75,84,79,67,86,75,81,80,50,84,81,79,82,86,16,52,71,79,81,86,71,39,88,71,80,86},30))
local remote = getReplayRemote()
if not remote then
debug(_d({37,81,80,72,75,84,79,67,86,75,81,80,50,84,81,79,82,86,17,52,71,79,81,86,71,39,88,71,80,86,2,80,81,86,2,72,81,87,80,70,2,89,75,86,74,75,80,2,86,75,79,71,81,87,86},30))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({40,75,84,75,80,73,2,52,71,82,78,67,91,2,88,75,67,2,37,81,80,72,75,84,79,67,86,75,81,80,50,84,81,79,82,86,16,52,71,79,81,86,71,39,88,71,80,86},30))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({40,75,84,71,53,71,84,88,71,84,2,71,84,84,81,84,28},30), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30), 10)
if not playerGui then
debug(_d({89,67,75,86,40,81,84,49,68,76,71,69,86,75,88,71,85,41,87,75,28,2,80,81,2,50,78,67,91,71,84,41,87,75,2,89,75,86,74,75,80,2,86,75,79,71,81,87,86,14,2,82,84,81,69,71,71,70,75,80,73,2,67,80,91,89,67,91},30))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({49,68,76,71,69,86,75,88,71,85,2,41,55,43,2,72,81,87,80,70,2,15,2,85,86,67,73,71,2,78,81,67,70,71,70},30))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({49,68,76,71,69,86,75,88,71,85,2,41,55,43,2,80,81,86,2,72,81,87,80,70,2,89,75,86,74,75,80,2,86,75,79,71,81,87,86,14,2,82,84,81,69,71,71,70,75,80,73,2,67,80,91,89,67,91},30))
return
end
end
end)
if not ok then debug(_d({89,67,75,86,40,81,84,49,68,76,71,69,86,75,88,71,85,41,87,75,2,71,84,84,81,84,28},30), err) end
end
local function runPlan()
debug(_d({50,78,67,80,2,85,86,67,84,86,71,70},30))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({53,86,67,84,86,75,80,73,2,80,67,88,2,78,81,81,82},30))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({82,81,85,2,18,16,20,85,2,35,40,54,39,52,2,85,86,67,84,86,48,67,88,28},30), rootAfter and rootAfter.Position)
end)
debug(_d({57,67,75,86,75,80,73,2,23,85,2,68,71,72,81,84,71,2,79,81,88,75,80,73,2,86,81,2,53,86,67,73,71,19},30))
task.wait(5)
for _, stage in ipairs({_d({53,86,67,73,71,19},30), _d({53,86,67,73,71,20},30), _d({53,86,67,73,71,21},30), _d({53,86,67,73,71,21,36},30)}) do
if not enabled then return end
local hpTarget = (stage == _d({53,86,67,73,71,21,36},30)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({47,81,88,75,80,73,2,86,81,2,67,84,84,81,89,2,72,78,91,15,70,81,89,80,2,67,84,71,67,2,10,37,87,82,75,70,2,52,67,75,80,11},30))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({38,81,70,73,75,80,73,2,67,84,84,81,89,2,84,67,75,80,2,75,80,2,67,2,85,83,87,67,84,71},30))
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
clearStage(_d({53,86,67,73,71,22},30))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({51,87,71,71,80,2,75,80,2,82,74,67,85,71,2,20,2,15,2,77,71,71,82,75,80,73,2,45,71,80,2,42,67,77,75,2,67,69,86,75,88,71,2,72,84,81,79,2,74,71,84,71,2,81,80},30))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({53,86,67,86,87,71,19},30))
if not enabled then return end
recheckStatue(_d({53,86,67,86,87,71,19},30))
destroyStatue(_d({53,86,67,86,87,71,20},30))
if not enabled then return end
recheckStatue(_d({53,86,67,86,87,71,19},30))
recheckStatue(_d({53,86,67,86,87,71,20},30))
destroyStatue(_d({53,86,67,86,87,71,21},30))
if not enabled then return end
recheckStatue(_d({53,86,67,86,87,71,21},30))
recheckStatue(_d({53,86,67,86,87,71,20},30))
recheckStatue(_d({53,86,67,86,87,71,19},30))
if not enabled then return end
debug(_d({57,67,75,86,75,80,73,2,72,81,84,2,82,74,67,85,71,2,20,2,86,81,2,71,80,70},30))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({50,74,67,85,71,2,20,2,71,80,70,2,89,67,75,86,2,86,75,79,71,81,87,86,14,2,82,84,81,69,71,71,70,75,80,73,2,67,80,91,89,67,91},30))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({47,81,88,75,80,73,2,68,67,69,77,2,86,81,2,51,87,71,71,80,2,85,86,67,73,71,2,82,81,85,75,86,75,81,80},30))
navToPointConfirmed(COORDS.Queen, 30, _d({51,87,71,71,80,2,85,86,67,73,71,2,82,81,85,75,86,75,81,80},30))
debug(_d({57,67,75,86,75,80,73,2,23,85,2,67,86,2,51,87,71,71,80,2,85,86,67,73,71,2,82,81,85,75,86,75,81,80},30))
task.wait(5)
if not enabled then return end
debug(_d({47,81,88,75,80,73,2,86,81,2,82,81,85,86,15,51,87,71,71,80,2,82,81,85,75,86,75,81,80},30))
navToPointConfirmed(COORDS.PostQueen, 30, _d({82,81,85,86,15,51,87,71,71,80,2,82,81,85,75,86,75,81,80},30))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local CupidDungeon = {
Connections = {}
}
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({39,80,67,68,78,75,80,73,14,2,82,81,85,2,36,39,40,49,52,39,2,82,78,67,80,28},30), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({50,78,67,80,2,71,84,84,81,84,28},30), err2) end
end)
debug(_d({39,80,67,68,78,71,70,28},30), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({39,80,67,68,78,71,70,28},30), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.RequirePlace(11424731604, _d({37,87,82,75,70,2,38,87,80,73,71,81,80},30)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
Core.SetupStandalone(
CupidDungeon,
_d({37,87,82,75,70,2,38,87,80,73,71,81,80},30),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)();
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({44,87,92,81,2,86,74,71,2,38,75,67,79,81,80,70,68,67,69,77},30),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({36,67,69,77,82,67,69,77},30))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)) or (bp and bp:FindFirstChild(_d({42,81,84,81,15,42,81,84,81},30)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({48,50,37,85},30))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hum = boss:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then return end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then setreadonly(mt, false) elseif make_writeable then make_writeable(mt) end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({42,75,86},30) then return target.CFrame
elseif key == _d({54,67,84,73,71,86},30) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({61,42,81,84,81,40,67,84,79,63,2,47,71,86,67,86,67,68,78,71,2,74,81,81,77,2,72,67,75,78,71,70,28,2},30) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({61,42,81,84,81,40,67,84,79,63,2,53,86,81,82,82,71,70,16},30))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({61,42,81,84,81,40,67,84,79,63,2,35,78,84,71,67,70,91,2,84,87,80,80,75,80,73,3},30)); return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({61,42,81,84,81,40,67,84,79,63,2,53,86,67,84,86,71,70,2,86,67,84,73,71,86,75,80,73,28,2},30) .. HoroFarm.Config.SelectedBoss)
task.spawn(function()
while HoroFarm.Running do
local targetRoot = getBossPart(HoroFarm.Config.SelectedBoss)
if not targetRoot then
task.wait(5)
else
equipHoroTool()
local comboStart = tick()
local hollowsAttached = false
if HoroFarm.Config.UseC and (tick() - lastC >= 60) then
VIM:SendKeyEvent(true, Enum.KeyCode.C, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.C, false, game)
lastC = tick()
hollowsAttached = true
elseif HoroFarm.Config.UseZ then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
task.wait(0.3)
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.Z, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Z, false, game)
lastZ = tick()
hollowsAttached = true
end
end
if HoroFarm.Config.UseE then
if getBossPart(HoroFarm.Config.SelectedBoss) then
VIM:SendKeyEvent(true, Enum.KeyCode.E, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.E, false, game)
lastE = tick()
end
end
if HoroFarm.Config.UseR and hollowsAttached then
task.wait(2.0)
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
lastR = tick()
end
local baseCD = 5
if HoroFarm.Config.UseE then baseCD = 17
elseif HoroFarm.Config.UseZ then baseCD = 10 end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
Core.SetupStandalone(
HoroFarm,
_d({42,81,84,81,40,67,84,79},30),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)();
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,53,86,81,82,82,71,70,16},30))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,35,78,84,71,67,70,91,2,84,87,80,80,75,80,73,3},30)); return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.RequirePlace(3978370137, _d({40,75,84,85,86,2,53,71,67},30)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30), 10)
local hum = char:WaitForChild(_d({42,87,79,67,80,81,75,70},30), 10)
local stats = ReplicatedStorage:WaitForChild(_d({53,86,67,86,85},30) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({50,71,78,75},30), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({52,75,72,78,71},30)) or (char and char:FindFirstChild(_d({52,75,72,78,71},30)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,37,87,84,84,71,80,86,2,50,71,78,75,2,69,74,71,69,77,28},30), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,48,81,86,2,67,86,2,54,81,89,80,2,81,72,2,36,71,73,75,80,80,75,80,73,85,16,2,50,78,71,67,85,71,2,86,84,67,88,71,78,2,86,74,71,84,71,2,86,81,2,72,67,84,79,2,69,74,71,85,86,85,2,89,74,75,78,71,2,89,67,75,86,75,80,73,2,72,81,84,2,52,75,72,78,71,16},30))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({18,19,15,73,82,81,17,78,75,68,17,69,74,71,85,86,65,72,67,84,79,71,84,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,74,71,85,86,65,72,67,84,79,71,84,16,78,87,67},30))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,40,67,84,79,75,80,73,2,69,74,71,85,86,85,2,87,80,86,75,78,2,21,18,18,2,50,71,78,75,16,16,16,2,10,37,87,84,84,71,80,86,28,2},30) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({53,86,67,86,85},30) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({50,71,78,75},30))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({52,75,72,78,71},30)) or (c and c:FindFirstChild(_d({52,75,72,78,71},30))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({18,19,15,73,82,81,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({36,87,91,67,68,78,71,43,86,71,79,85},30))
local shopItem = buyables and buyables:FindFirstChild(_d({52,75,72,78,71},30))
local shopPart = shopItem and shopItem:FindFirstChild(_d({53,74,81,82,50,67,84,86},30))
if EasyTravel and shopPart and hrp then
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,54,84,67,88,71,78,75,80,73,2,86,81,2,52,75,72,78,71,2,85,74,81,82,2,88,75,67,2,39,67,85,91,54,84,67,88,71,78,16,16,16},30))
local nocollide = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({36,67,85,71,50,67,84,86},30)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({39,88,71,80,86,85},30)) and ReplicatedStorage.Events:FindFirstChild(_d({53,74,81,82},30))
if shopEvent and shopEvent:IsA(_d({52,71,79,81,86,71,40,87,80,69,86,75,81,80},30)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,39,83,87,75,82,82,75,80,73,2,52,75,72,78,71,16,16,16},30))
local args = {
[1] = _d({71,83,87,75,82},30),
[2] = _d({52,75,72,78,71},30)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({39,88,71,80,86,85},30)) and ReplicatedStorage.Events:FindFirstChild(_d({54,81,81,78,85},30))
if toolsEvent and toolsEvent:IsA(_d({52,71,79,81,86,71,40,87,80,69,86,75,81,80},30)) then
pcall(function()
toolsEvent:InvokeServer(unpack(args))
end)
end
task.wait(1)
end
end
end
task.wait(1)
end
if not LevelGrinder.Running then return end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70},30))
local hrp = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({52,75,72,78,71},30))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,40,78,91,75,80,73,2,86,81,2,40,75,85,74,79,67,80,2,37,67,88,71,16,16,16},30))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({18,19,15,73,82,81,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,71,67,85,91,65,86,84,67,88,71,78,16,78,87,67},30))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,39,85,69,67,82,75,80,73,2,85,74,81,82,2,75,80,86,71,84,75,81,84,2,68,91,2,72,78,91,75,80,73,2,85,86,84,67,75,73,74,86,2,87,82,16,16,16},30))
local nocollide = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({36,67,85,71,50,67,84,86},30)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then break end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700 and distPos.X <= 1973 and distPos.Z >= -12403 and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,40,78,91,75,80,73,2,86,81,2,40,75,85,74,79,67,80,2,37,67,88,71,16,16,16},30))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then break end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = Core.Import(_d({18,19,15,73,82,81,17,78,75,68,17,72,75,85,74,79,67,80,65,79,67,92,71,16,78,87,67},30), _d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,72,75,85,74,79,67,80,65,79,67,92,71,16,78,87,67},30))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,40,67,75,78,71,70,2,86,81,2,75,79,82,81,84,86,2,40,75,85,74,79,67,80,47,67,92,71,2,78,75,68,84,67,84,91,3},30))
end
else
warn(_d({61,46,71,88,71,78,2,41,84,75,80,70,71,84,63,2,49,87,86,85,75,70,71,2,40,75,85,74,79,67,80,2,37,67,88,71,2,68,81,87,80,70,85,14,2,85,77,75,82,82,75,80,73,2,79,67,92,71,16},30))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({46,71,88,71,78,2,41,84,75,80,70,71,84},30),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)();
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local RunService       = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)) then
Core = loadstring(readfile(_d({18,19,15,73,82,81,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
else
Core = loadstring(game:HttpGet(_d({74,86,86,82,85,28,17,17,84,67,89,16,73,75,86,74,87,68,87,85,71,84,69,81,80,86,71,80,86,16,69,81,79,17,84,81,69,77,91,90,89,67,78,78,17,78,87,67,87,15,69,81,70,71,17,79,67,75,80,17,18,19,65,85,69,84,75,82,86,17,78,75,68,17,69,81,84,71,16,78,87,67},30)))()
end
end)
if not Core then warn(_d({61,37,81,84,71,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {}
}
local HEIGHT_OFFSET = 6.0
local SEA_LEVEL_Y = -2.63
local RAYCAST_COOLDOWN = 0.05
local HOVER_LIFT_GAIN = 20.0
local FORWARD_SCAN_DISTANCE = 50.0
local currentTargetY = 0
local isClimbing = false
local climbTargetY = 0
local distanceToWall = 999
local loopConnection = nil
local function getCharacterComponents()
local char = LocalPlayer.Character
if not char then return nil, nil, nil end
return char, char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)), char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30)
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
local force = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,40,81,84,69,71},30))
local att = root:FindFirstChild(_d({65,65,39,67,85,91,54,84,67,88,71,78,35,86,86},30))
if force then force:Destroy() end
if att then att:Destroy() end
end
end
function EasyTravel.GetSurfaceY(position, character)
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
while EasyTravel.Enabled do
task.wait(RAYCAST_COOLDOWN)
local char, _, root = getCharacterComponents()
if not char or not root then continue end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01 and currentPos.X <= 3049.91 and currentPos.Z >= -11748.53 and currentPos.Z <= -9700.63
local moveDir = Vector3.zero
if EasyTravel.DisableRaycasting then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
task.wait(RAYCAST_COOLDOWN)
continue
end
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - root.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
else
isClimbing = false
currentTargetY = EasyTravel.TargetPosition.Y
continue
end
else
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({40,75,85,74,79,67,80,2,37,67,88,71},30))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = {cave}
local hit = Workspace:Raycast(currentPos, moveDir.Unit * FORWARD_SCAN_DISTANCE, caveRayParams)
if hit then
hitCave = true
end
end
EasyTravel.HitCave = hitCave
if hitCave or inRoughWaters then
isClimbing = false
distanceToWall = 999
currentTargetY = EasyTravel.TargetPosition and EasyTravel.TargetPosition.Y or currentPos.Y
continue
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
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
local groundY = EasyTravel.GetSurfaceY(currentPos, char)
local aheadPos = currentPos + moveUnit * 4
local aheadY = EasyTravel.GetSurfaceY(aheadPos, char)
currentTargetY = math.max(groundY, aheadY) + HEIGHT_OFFSET
end
else
distanceToWall = 999
isClimbing = false
currentTargetY = EasyTravel.GetSurfaceY(currentPos, char) + HEIGHT_OFFSET
end
end
end
function EasyTravel.Start()
if EasyTravel.Enabled then return end
if not Safeguard then warn(_d({61,53,67,72,71,73,87,67,84,70,63,2,40,67,75,78,71,70,2,86,81,2,78,81,67,70,3},30)); return end
if not Safeguard.IsSafe() then return end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then return end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
return
end
local force = getOrCreateForce(currentRoot)
local camera = Workspace.CurrentCamera
local look = camera.CFrame.LookVector
local right = camera.CFrame.RightVector
local moveDir = Vector3.zero
local finalTargetY = isClimbing and climbTargetY or currentTargetY
if EasyTravel.TargetPosition then
local diff = EasyTravel.TargetPosition - currentRoot.Position
local flatDiff = Vector3.new(diff.X, 0, diff.Z)
if flatDiff.Magnitude > 2 then moveDir = flatDiff.Unit end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then speedMultiplier = 0 end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({61,39,67,85,91,2,54,84,67,88,71,78,63,2,40,78,75,73,74,86,2,71,80,67,68,78,71,70,16},30))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({61,39,67,85,91,2,54,84,67,88,71,78,63,2,40,78,75,73,74,86,2,70,75,85,67,68,78,71,70,16},30))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({39,67,85,91,2,54,84,67,88,71,78},30),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)();
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({50,78,67,91,71,84,85},30))
local RunService = game:GetService(_d({52,87,80,53,71,84,88,75,69,71},30))
local UserInputService = game:GetService(_d({55,85,71,84,43,80,82,87,86,53,71,84,88,75,69,71},30))
local ReplicatedStorage = game:GetService(_d({52,71,82,78,75,69,67,86,71,70,53,86,81,84,67,73,71},30))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({75,70,78,71},30)
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
print(_d({61,49,88,71,84,89,81,84,78,70,54,71,85,86,71,84,63},30), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({53,86,67,86,85},30) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({52,81,77,87,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,71,82,82,81},30), args)
elseif style == _d({36,78,67,69,77,46,71,73},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77},30), args)
elseif style == _d({45,67,79,75,85,74,75,77,75},30) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({45,67,79,75,85,74,75,77,75,41,71,82,82,81},30), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,77,91,2,57,67,78,77,20},30), args)
end
debug(_d({40,75,84,71,70,2,41,71,82,82,81,2,52,71,79,81,86,71},30))
end)
if not ok then debug(_d({75,80,88,81,77,71,41,71,82,82,81,2,71,84,84,81,84,28},30), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30)) or Instance.new(_d({35,86,86,67,69,74,79,71,80,86},30))
att.Name = _d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30)
att.Parent = root
local force = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30))
if not force then
force = Instance.new(_d({46,75,80,71,67,84,56,71,78,81,69,75,86,91},30))
force.Name = _d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30)
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
local root = char:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30))
if not root then return end
local force = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,40,81,84,69,71},30))
local att   = root:FindFirstChild(_d({65,65,54,71,85,86,42,81,88,71,84,35,86,86},30))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({57,67,78,77,75,80,73,2,86,81,28},30), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({89,67,78,77,54,81,50,81,75,80,86,2,57,2,70,81,89,80,2,71,84,84,81,84,28},30), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({35,84,84,75,88,71,70,2,67,86,28},30), pos)
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
local root = Core.GetRoot(LocalPlayer)
if not root then return nil end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if item:IsA(_d({47,81,70,71,78},30)) and item:FindFirstChild(_d({42,87,79,67,80,81,75,70,52,81,81,86,50,67,84,86},30)) and item:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({42,87,79,67,80,81,75,70},30)).Health > 0 then
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
mode = _d({75,70,78,71},30)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({54,71,85,86,71,84,2,38,75,85,67,68,78,71,70},30))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({54,71,85,86,71,84,2,39,80,67,68,78,71,70,16,2,47,81,70,71,28},30), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({50,78,67,91,71,84,2,70,75,71,70,3,2,38,75,85,67,68,78,75,80,73,2,68,81,86,16},30))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({74,81,88,71,84},30) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({70,81,70,73,71},30) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) then
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
local playerGui = LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({49,88,71,84,89,81,84,78,70,54,71,85,86,41,87,75},30))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({53,69,84,71,71,80,41,87,75},30))
screenGui.Name = _d({49,88,71,84,89,81,84,78,70,54,71,85,86,41,87,75},30)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({40,84,67,79,71},30))
frame.Name = _d({47,67,75,80,40,84,67,79,71},30)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({210,129,125,131,209,154,113,2,37,87,82,75,70,2,39,80,73,75,80,71,2,49,88,71,84,89,81,84,78,70,2,54,71,85,86},30)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({53,86,67,86,87,85,28,2,43,70,78,71},30)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({54,71,90,86,36,81,90},30))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({42,81,88,71,84,2,35,68,81,88,71,2,54,67,84,73,71,86},30), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({74,81,88,71,84},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,42,81,88,71,84,75,80,73,2},30) .. val .. _d({2,85,86,87,70,85,2,87,82},30)
end)
createInputBtn(_d({38,81,70,73,71,2,37,78,75,79,68},30), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({70,81,70,73,71},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,38,81,70,73,71,15,74,81,78,70,75,80,73,2,10},30) .. val .. _d({2,85,86,87,70,85,11},30)
end)
createInputBtn(_d({54,71,85,86,2,53,83,87,67,84,71,2,38,81,70,73,71},30), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({85,83,87,67,84,71,65,70,81,70,73,71},30))
statusLabel.Text = _d({53,86,67,86,87,85,28,2,53,83,87,67,84,71,2,57,67,78,77,75,80,73,2,10},30) .. val .. _d({2,85,86,87,70,85,11},30)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
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
while enabled and mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({85,83,87,67,84,71,65,70,81,70,73,71},30) then
disableBot()
statusLabel.Text = _d({53,86,67,86,87,85,28,2,43,70,78,71,2,10,53,83,87,67,84,71,2,70,81,70,73,71,2,70,81,80,71,11},30)
end
end)
end)
local stopBtn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({39,47,39,52,41,39,48,37,59,2,53,54,49,50},30)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({55,43,37,81,84,80,71,84},30), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({53,86,67,86,87,85,28,2,53,54,49,50,50,39,38,2,10,43,70,78,71,11},30)
local VIM = game:GetService(_d({56,75,84,86,87,67,78,43,80,82,87,86,47,67,80,67,73,71,84},30))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({61,49,88,71,84,89,81,84,78,70,54,71,85,86,71,84,63,2,46,81,67,70,71,70,2,85,87,69,69,71,85,85,72,87,78,78,91,16},30))
end)();
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({50,78,67,91,71,84,41,87,75},30), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({41,50,49,46,67,87,80,69,74,71,84,55,43},30))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({53,69,84,71,71,80,41,87,75},30))
screenGui.Name = _d({41,50,49,46,67,87,80,69,74,71,84,55,43},30)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({40,84,67,79,71},30))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({55,43,53,86,84,81,77,71},30))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({210,129,110,110,2,41,50,49,2,42,87,68,2,46,67,87,80,69,74,71,84},30)
title.Parent = main
local closeBtn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({55,43,37,81,84,80,71,84},30), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({37,74,81,81,85,71,2,67,2,68,81,86,2,81,84,2,87,86,75,78,75,86,91,2,86,81,2,84,87,80,28},30)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({54,71,90,86,36,87,86,86,81,80},30))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({2,2},30) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({55,43,37,81,84,80,71,84},30))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({55,43,53,86,84,81,77,71},30))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({54,71,90,86,46,67,68,71,78},30))
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
CreateLaunchButton(_d({37,87,82,75,70,2,38,87,80,73,71,81,80,2,40,67,84,79},30), _d({35,87,86,81,79,67,86,71,2,69,87,82,75,70,2,70,87,80,73,71,81,80,85,2,8,2,68,81,85,85,2,69,91,69,78,71,85},30), loadCupidDungeon)
CreateLaunchButton(_d({42,81,84,81,2,36,81,85,85,2,40,67,84,79,2,10,53,75,78,71,80,86,2,35,75,79,11},30), _d({35,87,86,81,72,67,84,79,2,81,88,71,84,89,81,84,78,70,2,68,81,85,85,71,85,2,87,85,75,80,73,2,42,81,84,81,2,72,84,87,75,86,85},30), loadHoroBossFarm)
CreateLaunchButton(_d({46,71,88,71,78,2,8,2,47,81,68,2,41,84,75,80,70,71,84},30), _d({35,87,86,81,15,78,71,88,71,78,2,67,80,70,2,72,67,84,79,2,78,81,69,67,78,2,48,50,37,2,79,81,68,85},30), loadLevelGrinder)
CreateLaunchButton(_d({39,67,85,91,2,54,84,67,88,71,78,2,10,50,2,54,81,73,73,78,71,11},30), _d({57,35,53,38,2,40,78,75,73,74,86,2,89,75,86,74,2,73,84,81,87,80,70,2,72,81,78,78,81,89,2,8,2,89,67,78,78,2,69,78,75,79,68,75,80,73},30), loadNavigationLab)
CreateLaunchButton(_d({50,74,91,85,75,69,85,2,49,88,71,84,89,81,84,78,70,2,54,71,85,86,71,84},30), _d({54,71,85,86,2,69,81,79,68,67,86,2,74,81,88,71,84,14,2,73,71,82,82,81,2,8,2,70,81,70,73,71,2,74,71,75,73,74,86,85},30), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({61,41,50,49,2,42,87,68,63,2,46,67,87,80,69,74,71,84,2,55,43,2,75,80,75,86,75,67,78,75,92,71,70,16},30))
end)()