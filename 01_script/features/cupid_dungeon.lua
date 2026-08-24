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
local Players            = game:GetService(_d({58,86,75,99,79,92,93},22))
local UserInputService    = game:GetService(_d({63,93,79,92,51,88,90,95,94,61,79,92,96,83,77,79},22))
local RunService          = game:GetService(_d({60,95,88,61,79,92,96,83,77,79},22))
local VIM                 = game:GetService(_d({64,83,92,94,95,75,86,51,88,90,95,94,55,75,88,75,81,79,92},22))
local ReplicatedStorage    = game:GetService(_d({60,79,90,86,83,77,75,94,79,78,61,94,89,92,75,81,79},22))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({26,27,23,81,90,89,25,86,83,76,25,77,89,92,79,24,86,95,75},22)) then
Core = loadstring(readfile(_d({26,27,23,81,90,89,25,86,83,76,25,77,89,92,79,24,86,95,75},22)))()
else
Core = loadstring(game:HttpGet(_d({82,94,94,90,93,36,25,25,92,75,97,24,81,83,94,82,95,76,95,93,79,92,77,89,88,94,79,88,94,24,77,89,87,25,92,89,77,85,99,98,97,75,86,86,25,86,95,75,95,23,77,89,78,79,25,87,75,83,88,25,26,27,73,93,77,92,83,90,94,25,86,83,76,25,77,89,92,79,24,86,95,75},22)))()
end
end)
if not Core then warn(_d({69,45,89,92,79,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,11},22)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,31,28,30,30,27,30,27,29,28,33},22)
local LEO_ENTEI_ANIM_ID    = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,31,28,30,30,27,29,34,28,33,34},22)
local LEO_HIKEN_ANIM_ID    = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,31,28,28,26,35,27,33,30,26,33},22)
local LEO_FIREFLY_ANIM_ID  = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,31,28,28,26,28,29,32,27,31,30},22)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({57,76,84,79,77,94,83,96,79,93},22)
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
local REPLAY_BUTTON_VALUE   = _d({60,79,90,86,75,99},22)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({87,89,96,79},22)
local NavState   = {mode = _d({83,78,86,79},22)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({69,44,89,93,93,44,89,94,71},22), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
end)
if ok then return root end
debug(_d({81,79,94,60,89,89,94,10,79,92,92,89,92,36},22), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
end)
if ok then return hum end
debug(_d({81,79,94,50,95,87,75,88,89,83,78,10,79,92,92,89,92,36},22), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({73,73,50,89,96,79,92,43,94,94},22)) or Instance.new(_d({43,94,94,75,77,82,87,79,88,94},22))
att.Name = _d({73,73,50,89,96,79,92,43,94,94},22)
att.Parent = root
local force = root:FindFirstChild(_d({73,73,50,89,96,79,92,48,89,92,77,79},22))
if not force then
force = Instance.new(_d({54,83,88,79,75,92,64,79,86,89,77,83,94,99},22))
force.Name = _d({73,73,50,89,96,79,92,48,89,92,77,79},22)
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
debug(_d({81,79,94,57,92,45,92,79,75,94,79,48,89,92,77,79,10,79,92,92,89,92,36},22), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if not root then return end
local force = root:FindFirstChild(_d({73,73,50,89,96,79,92,48,89,92,77,79},22))
local att   = root:FindFirstChild(_d({73,73,50,89,96,79,92,43,94,94},22))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({77,86,79,75,88,95,90,48,89,92,77,79,10,79,92,92,89,92,36},22), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({44,95,93,89,55,79,86,79,79},22)) ~= nil
end)
if ok then return result end
debug(_d({83,93,44,95,93,89,43,77,94,83,96,79,10,79,92,92,89,92,36},22), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({44,95,93,89},22))
end)
if not ok then debug(_d({75,77,94,83,96,75,94,79,44,95,93,89,10,79,92,92,89,92,36},22), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({44,95,93,89,10,88,89,94,10,75,77,94,83,96,79,22,10,75,77,94,83,96,75,94,83,88,81},22))
activateBuso()
end
end)
if not ok then debug(_d({44,95,93,89,53,79,79,90,79,92,10,79,92,92,89,92,36},22), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({44,95,93,89,10,85,79,79,90,79,92,10,93,94,89,90,90,79,78},22))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({53,79,88,50,75,85,83},22)) ~= nil
end)
if ok then return result end
debug(_d({83,93,53,79,88,43,77,94,83,96,79,10,79,92,92,89,92,36},22), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({53,79,88},22), true)
end)
if not ok then debug(_d({75,77,94,83,96,75,94,79,53,79,88,10,79,92,92,89,92,36},22), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({53,79,88,10,88,89,94,10,75,77,94,83,96,79,22,10,75,77,94,83,96,75,94,83,88,81},22))
activateKen()
end
end)
if not ok then debug(_d({53,79,88,53,79,79,90,79,92,10,79,92,92,89,92,36},22), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({53,79,88,10,85,79,79,90,79,92,10,93,94,89,90,90,79,78},22))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({56,58,45,93},22)) end)
if ok then return folder end
debug(_d({81,79,94,56,58,45,93,48,89,86,78,79,92,10,79,92,92,89,92,36},22), folder)
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
local r = model:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local h = model:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
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
debug(_d({81,79,94,56,79,75,92,79,93,94,56,58,45,10,79,92,92,89,92,36},22), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
local hum  = model:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({81,79,94,56,58,45,44,99,56,75,87,79,10,79,92,92,89,92,36},22), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({88,90,77,93,60,79,87,75,83,88,83,88,81,10,79,92,92,89,92,36},22), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({45,95,90,83,78,10,59,95,79,79,88},22))
return queen ~= nil and queen:FindFirstChild(_d({87,89,94,83,89,88,54,79,93,93},22)) ~= nil
end)
if ok then return result end
debug(_d({83,93,59,95,79,79,88,58,82,75,93,79,28,10,79,92,92,89,92,36},22), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,27,28,27,28,35,33,35,30,28,28,35,28,33,32,35},22)
local QUEEN_GRASP_ANIM_ID   = _d({92,76,98,75,93,93,79,94,83,78,36,25,25,27,28,35,34,26,26,26,32,27,26,26,27,33,29,30},22)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
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
debug(_d({83,93,58,86,75,99,83,88,81,43,88,83,87,48,92,89,87,54,83,93,94,10,79,92,92,89,92,36},22), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({44,86,89,77,85,83,88,81},22)) ~= nil
end)
if ok then return result end
debug(_d({83,93,56,58,45,44,86,89,77,85,83,88,81,10,79,92,92,89,92,36},22), result)
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
debug(_d({90,92,79,78,83,77,94,56,58,45,58,89,93,83,94,83,89,88,10,79,92,92,89,92,36},22), result)
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
debug(_d({56,89,10,78,75,87,75,81,79,10,89,88},22), model.Name, _d({80,89,92},22), NPC_STUCK_TIMEOUT, _d({93,10,23,10,93,97,83,94,77,82,83,88,81,10,94,75,92,81,79,94},22))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({94,92,75,77,85,56,58,45,46,75,87,75,81,79,10,79,92,92,89,92,36},22), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({55,89,78,79,86},22)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({44,75,93,79,58,75,92,94},22)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({81,79,94,55,89,78,79,86,48,75,77,79,58,89,93,10,79,92,92,89,92,36},22), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({47,88,96},22))
local folder = env and env:FindFirstChild(_d({61,94,75,94,95,79,93},22))
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
debug(_d({81,79,94,61,94,75,94,95,79,55,89,78,79,86,56,79,75,92,10,79,92,92,89,92,36},22), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({76,75,92,92,79,86,50,58},22))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({81,79,94,61,94,75,94,95,79,50,58,10,79,92,92,89,92,36},22), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({62,89,89,86},22)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({80,83,88,78,62,89,89,86,44,99,43,94,94,92,83,76,95,94,79,10,79,92,92,89,92,36},22), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({62,89,89,86},22)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({80,83,88,78,62,89,89,86,44,99,56,75,87,79,10,79,92,92,89,92,36},22), tool)
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
if not ok then debug(_d({79,91,95,83,90,62,89,89,86,10,79,92,92,89,92,36},22), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({44,75,77,85,90,75,77,85},22))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({62,89,89,86},22)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({80,83,88,78,62,89,89,86,44,99,45,82,83,86,78,56,75,87,79,10,79,92,92,89,92,36},22), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({61,97,89,92,78,47,91,95,83,90},22))
if sword then
equipTool(sword)
return _d({93,97,89,92,78},22)
end
local melee = findToolByAttribute(_d({55,79,86,79,79,62,89,89,86},22))
if melee then
equipTool(melee)
return _d({87,79,86,79,79},22)
end
debug(_d({56,89,10,93,97,89,92,78,10,89,92,10,87,79,86,79,79,10,94,89,89,86,10,80,89,95,88,78},22))
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
if not ok then debug(_d({77,86,83,77,85,55,27,10,79,92,92,89,92,36},22), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({50,95,87,75,88,89,83,78,60,89,89,94,58,75,92,94},22))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({61,94,75,94,93},22) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({60,89,85,95,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,79,90,90,89},22), args)
elseif style == _d({44,86,75,77,85,54,79,81},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85},22), args)
elseif style == _d({53,75,87,83,93,82,83,85,83},22) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({53,75,87,83,93,82,83,85,83,49,79,90,90,89},22), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({61,85,99,10,65,75,86,85,28},22), args)
end
end)
if not ok then debug(_d({83,88,96,89,85,79,49,79,90,90,89,10,79,92,92,89,92,36},22), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({90,92,79,93,93,61,85,83,86,86,60,10,79,92,92,89,92,36},22), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({82,89,86,78,44,86,89,77,85,10,79,92,92,89,92,36},22), err) end
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
if not ok then debug(_d({82,89,86,78,44,86,89,77,85,65,82,83,86,79,10,79,92,92,89,92,36},22), err) end
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
debug(_d({81,79,94,49,75,87,79,49,10,79,92,92,89,92,36},22), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({83,93,60,79,75,86,55,27,44,95,93,99,10,79,92,92,89,92,36},22), result)
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
return char ~= nil and char:FindFirstChild(_d({93,94,95,88},22)) ~= nil
end)
if ok then return result end
debug(_d({83,93,61,94,95,88,88,79,78,10,79,92,92,89,92,36},22), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({90,92,79,93,93,61,94,95,88,44,92,79,75,85,10,79,92,92,89,92,36},22), err) end
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
debug(_d({91,95,79,79,88,46,89,78,81,79,63,88,94,83,86,61,75,80,79,36,10,59,95,79,79,88,10,81,89,88,79,10,23,10,79,88,78,83,88,81,10,78,89,78,81,79,10,79,75,92,86,99},22))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({91,95,79,79,88,46,89,78,81,79,63,88,94,83,86,61,75,80,79,10,93,75,80,79,94,99,10,94,83,87,79,89,95,94},22))
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
local info = getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({59,95,79,79,88,10,77,75,93,94,83,88,81,10,78,79,94,79,77,94,79,78,10,23,10,78,89,78,81,83,88,81,10,18,97,75,94,77,82,79,92,19},22))
queenDodgeUntilSafe(function() return getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22)) end)
if enabled and getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22)) then
setNavNamed(_d({45,95,90,83,78,10,59,95,79,79,88},22))
end
queenDodging = false
end
end)
if not ok then debug(_d({91,95,79,79,88,46,89,78,81,79,65,75,94,77,82,79,92,10,79,92,92,89,92,36},22), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({90,89,83,88,94},22) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({88,90,77},22) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({88,75,87,79,78},22) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({81,79,94,56,75,96,62,75,92,81,79,94,93,10,79,92,92,89,92,36},22), aimR)
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
debug(_d({77,89,87,90,95,94,79,54,89,77,85,79,78,45,48,92,75,87,79,10,79,92,92,89,92,36},22), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({90,89,83,88,94},22), point = pos}
phase = _d({87,89,96,79},22)
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
if not ok then debug(_d({88,75,96,62,89,58,89,83,88,94,10,81,79,90,90,89,10,77,82,79,77,85,10,79,92,92,89,92,36},22), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({88,90,77},22)}
phase = _d({87,89,96,79},22)
end
function setNavNamed(name)
NavState = {mode = _d({88,75,87,79,78},22), name = name}
phase = _d({87,89,96,79},22)
end
local function setNavIdle()
NavState = {mode = _d({83,78,86,79},22)}
phase = _d({87,89,96,79},22)
end
local function hasArrived()
return phase == _d({82,89,96,79,92},22)
end
local function startNav()
phase = _d({87,89,96,79},22)
debug(_d({56,75,96,10,86,89,89,90,10,57,56},22))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({58,86,75,99,79,92,10,78,83,79,78,11,10,61,94,89,90,90,83,88,81,10,76,89,94,24},22))
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
debug(_d({58,86,75,99,79,92,10,83,93,10,94,89,89,10,80,75,92,10,80,92,89,87,10,94,75,92,81,79,94,10,18,40,28,26,26,26,10,93,94,95,78,93,19,24,10,54,83,85,79,86,99,10,92,79,93,90,75,97,88,79,78,10,75,94,10,86,89,76,76,99,24,10,61,94,89,90,90,83,88,81,10,76,89,94,24},22))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({73,73,90,92,79,96,58,89,93},22))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({54,75,92,81,79,10,90,89,93,83,94,83,89,88,10,84,95,87,90,10,78,79,94,79,77,94,79,78,36},22), delta, _d({93,94,95,78,93,24,10,90,92,79,96,58,89,93,39},22), prevPos, _d({88,79,97,58,89,93,39},22), pos)
end
end
force:SetAttribute(_d({73,73,90,92,79,96,58,89,93},22), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({87,89,96,79},22) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({82,89,96,79,92},22)
debug(_d({58,82,75,93,79,36,10,82,89,96,79,92},22))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({11,11,11,10,60,47,48,63,61,51,56,49,10,62,57,10,43,58,58,54,67,10,43,44,56,57,60,55,43,54,10,64,47,54,57,45,51,62,67,36},22), finalVel, _d({75,83,87,39},22), aim, _d({90,89,93,39},22), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({82,89,96,79,92},22) then
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
debug(_d({45,89,87,76,75,94,10,86,89,77,85,10,93,85,83,90,90,79,78,22},22), snapDist, _d({93,94,95,78,93,10,80,92,89,87,10,94,75,92,81,79,94,10,204,106,126,10,80,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,87,89,96,79},22))
phase = _d({87,89,96,79},22)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({50,79,75,92,94,76,79,75,94,10,79,92,92,89,92,36},22), err) end
end)
end
local function stopNav()
debug(_d({56,75,96,10,86,89,89,90,10,57,48,48},22))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({87,89,96,79},22)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({62,79,98,94,45,82,75,94,61,79,92,96,83,77,79},22))
local channels = TextChatService:FindFirstChild(_d({62,79,98,94,45,82,75,88,88,79,86,93},22))
local channel = channels and channels:FindFirstChild(_d({60,44,66,49,79,88,79,92,75,86},22))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({46,79,80,75,95,86,94,45,82,75,94,61,99,93,94,79,87,45,82,75,94,47,96,79,88,94,93},22))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({61,75,99,55,79,93,93,75,81,79,60,79,91,95,79,93,94},22))
if sayEvent then
sayEvent:FireServer(message, _d({43,86,86},22))
return
end
debug(_d({93,79,88,78,45,82,75,94,55,79,93,93,75,81,79,36,10,88,89,10,62,79,98,94,45,82,75,94,61,79,92,96,83,77,79,24,60,44,66,49,79,88,79,92,75,86,10,89,92,10,86,79,81,75,77,99,10,61,75,99,55,79,93,93,75,81,79,60,79,91,95,79,93,94,10,80,89,95,88,78,10,80,89,92},22), message)
end)
if not ok then debug(_d({93,79,88,78,45,82,75,94,55,79,93,93,75,81,79,10,79,92,92,89,92,36},22), err) end
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
debug(_d({56,89,94,10,87,75,85,83,88,81,10,90,92,89,81,92,79,93,93,10,94,89,97,75,92,78,10,88,75,96,10,94,75,92,81,79,94,10,80,89,92},22), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({93,10,23,10,93,79,88,78,83,88,81,10,25,95,88,93,94,95,77,85},22))
sendChatMessage(_d({25,95,88,93,94,95,77,85},22))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({97,75,83,94,63,88,94,83,86,43,92,92,83,96,79,78,10,94,83,87,79,89,95,94},22))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({88,75,96,62,89,58,89,83,88,94,45,89,88,80,83,92,87,79,78,36},22), label or _d({94,75,92,81,79,94},22), _d({23,10,78,83,78,10,88,89,94,10,75,92,92,83,96,79,10,97,83,94,82,83,88},22), timeout, _d({93,22,10,92,79,94,92,99,83,88,81,10,89,88,77,79},22))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({88,75,96,62,89,58,89,83,88,94,45,89,88,80,83,92,87,79,78,36},22), label or _d({94,75,92,81,79,94},22), _d({23,10,93,94,83,86,86,10,88,89,94,10,75,92,92,83,96,79,78,10,75,80,94,79,92,10,92,79,94,92,99,22,10,90,92,89,77,79,79,78,83,88,81,10,75,88,99,97,75,99},22))
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
if not ok then debug(_d({88,75,96,62,89,58,89,83,88,94,50,89,86,78,83,88,81,44,86,89,77,85,10,85,79,99,23,78,89,97,88,10,79,92,92,89,92,36},22), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({88,75,96,62,89,58,89,83,88,94,50,89,86,78,83,88,81,44,86,89,77,85,10,85,79,99,23,95,90,10,79,92,92,89,92,36},22), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({65,75,86,85,83,88,81,10,94,89,36},22), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({97,75,86,85,62,89,58,89,83,88,94,10,65,10,78,89,97,88,10,79,92,92,89,92,36},22), err) end
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
debug(_d({62,89,89,85,10,78,75,87,75,81,79,10,97,82,83,86,79,10,97,75,86,85,83,88,81,10,94,89,10,90,89,83,88,94,11,10,61,94,89,90,90,83,88,81,10,97,75,86,85,10,94,89,10,79,88,81,75,81,79,24},22))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({43,92,92,83,96,79,78,10,75,94,36},22), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({61,94,95,77,85,10,78,95,92,83,88,81,10,97,75,86,85,22,10,84,95,87,90,83,88,81,11},22))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({61,94,83,86,86,10,93,94,95,77,85,22,10,94,92,83,81,81,79,92,83,88,81,10,49,79,90,90,89,11},22))
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
debug(_d({55,89,96,83,88,81,10,94,89},22), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({65,75,83,94,83,88,81,10,80,89,92,10,56,58,45,93,10,94,89,10,93,90,75,97,88,10,75,94},22), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({10,10,93,90,75,97,88,10,77,82,79,77,85,36,10,80,89,86,78,79,92,10,79,98,83,93,94,93,10,39},22), folder ~= nil,
_d({22,10,77,82,83,86,78,92,79,88,10,39},22), folder and #folder:GetChildren() or 0,
_d({22,10,75,86,83,96,79,10,39},22), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({56,89,10,56,58,45,93,10,75,90,90,79,75,92,79,78,10,75,94},22), stageName, _d({75,80,94,79,92,10,27,31,93,22,10,87,89,96,83,88,81,10,89,88,10,75,88,99,97,75,99},22))
break
end
end
debug(_d({53,83,86,86,83,88,81,10,56,58,45,93,10,75,94},22), stageName)
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
debug(_d({60,79,94,95,92,88,83,88,81,10,94,89},22), stageName, _d({90,89,93,83,94,83,89,88,10,76,79,80,89,92,79,10,87,89,96,83,88,81,10,89,88},22))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({65,75,83,94,83,88,81,10,31,93,10,75,94},22), stageName, _d({90,89,93,83,94,83,89,88},22))
task.wait(5)
debug(_d({65,75,83,94,83,88,81,10,80,89,92},22), targetHP * 100, _d({15,10,50,58,10,76,79,80,89,92,79,10,87,89,96,83,88,81,10,94,89,10,88,79,98,94,10,93,94,75,81,79},22))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({77,86,79,75,92,79,78},22))
end
local function killNamedNPC(name, targetPos)
debug(_d({55,89,96,83,88,81,10,94,89},22), name)
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
debug(name, _d({78,79,80,79,75,94,79,78},22))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({50,95,87,75,88,89,83,78},22))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({54,79,89,10,90,86,75,99,79,78,10,75,88,83,87,75,94,83,89,88,36},22), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({86,79,89,43,88,83,87,54,89,81,81,79,92,10,90,92,83,88,94,10,79,92,92,89,92,36},22), err2) end
end)
end)
if not ok then debug(_d({93,94,75,92,94,54,79,89,43,88,83,87,54,89,81,81,79,92,10,79,92,92,89,92,36},22), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({55,89,96,83,88,81,10,94,89,10,54,79,89},22))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({54,79,89},22))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({54,79,89},22))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({54,79,89},22))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({54,79,89,10,77,75,93,94,83,88,81},22), which, _d({23,10,78,89,78,81,83,88,81},22))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({54,79,89,10,93,94,75,92,94,79,78,10,76,86,89,77,85,23,76,92,79,75,85,79,92,10,87,83,78,23,76,86,89,77,85,11,10,47,96,75,78,83,88,81,24,24,24},22))
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
if not getNPCByName(_d({54,79,89},22)) then
debug(_d({54,79,89,10,81,89,88,79,10,87,83,78,23,78,89,78,81,79,10,23,10,79,88,78,83,88,81,10,47,88,94,79,83,10,82,89,86,78,10,79,75,92,86,99},22))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({54,79,89},22)) then
setNavNamed(_d({54,79,89},22))
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
debug(_d({54,79,89,10,78,79,80,79,75,94,79,78},22))
stopLeoAnimLogger()
debug(_d({60,79,94,95,92,88,83,88,81,10,94,89,10,54,79,89,10,90,89,93,83,94,83,89,88,10,76,79,80,89,92,79,10,87,89,96,83,88,81,10,89,88},22))
navToPointConfirmed(COORDS.Leo, 30, _d({54,79,89,10,90,89,93,83,94,83,89,88},22))
debug(_d({65,75,83,94,83,88,81,10,31,93,10,75,94,10,54,79,89,10,90,89,93,83,94,83,89,88},22))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({55,89,96,83,88,81,10,94,89},22), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({45,89,95,86,78,10,88,89,94,10,80,83,88,78,10,93,94,75,94,95,79,10,87,89,78,79,86,10,88,79,75,92},22), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({43,94,94,75,77,85,83,88,81},22), coordKey, _d({97,83,94,82},22), weapon or _d({88,89,94,82,83,88,81,10,80,89,95,88,78},22))
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
debug(coordKey, _d({76,75,92,92,79,86,10,78,79,93,94,92,89,99,79,78},22))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({92,79,77,82,79,77,85,61,94,75,94,95,79,36},22), coordKey, _d({23,10,77,89,95,86,78,10,88,89,94,10,80,83,88,78,10,93,94,75,94,95,79,10,87,89,78,79,86,22,10,93,85,83,90,90,83,88,81},22))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({92,79,77,82,79,77,85,61,94,75,94,95,79,36},22), coordKey, _d({93,94,83,86,86,10,75,86,83,96,79,10,18,50,58},22), hp, _d({19,10,23,10,92,79,23,78,79,93,94,92,89,99,83,88,81},22))
destroyStatue(coordKey)
else
debug(_d({92,79,77,82,79,77,85,61,94,75,94,95,79,36},22), coordKey, _d({77,89,88,80,83,92,87,79,78,10,78,79,93,94,92,89,99,79,78},22))
end
end)
if not ok then debug(_d({92,79,77,82,79,77,85,61,94,75,94,95,79,10,79,92,92,89,92,36},22), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({55,89,96,83,88,81,10,94,89,10,59,95,79,79,88},22))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({45,95,90,83,78,10,59,95,79,79,88},22))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22))
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
debug(_d({59,95,79,79,88,10,79,88,94,79,92,79,78,10,90,82,75,93,79,10,28},22))
end
local function finishQueen()
debug(_d({48,83,88,83,93,82,83,88,81,10,59,95,79,79,88},22))
equipSwordOrMelee()
setNavNamed(_d({45,95,90,83,78,10,59,95,79,79,88},22))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({45,95,90,83,78,10,59,95,79,79,88},22))
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
debug(_d({59,95,79,79,88,10,78,79,80,79,75,94,79,78,24,10,58,86,75,88,10,77,89,87,90,86,79,94,79,24},22))
end
local CONFIRMATION_PROMPT_NAME = _d({45,89,88,80,83,92,87,75,94,83,89,88,58,92,89,87,90,94},22)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({60,79,87,89,94,79,47,96,79,88,94},22), 5)
end)
if ok then return result end
debug(_d({81,79,94,60,79,90,86,75,99,60,79,87,89,94,79,10,79,92,92,89,92,36},22), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({58,86,75,99,79,92,49,95,83},22))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({51,87,75,81,79,44,95,94,94,89,88},22)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({76,95,94,94,89,88,64,75,86,95,79},22)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({80,83,88,78,44,95,94,94,89,88,44,99,64,75,86,95,79,10,79,92,92,89,92,36},22), result)
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
if not ok then debug(_d({77,86,83,77,85,49,95,83,44,95,94,94,89,88,10,79,92,92,89,92,36},22), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({83,93,61,79,92,96,79,92},22))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({60,79,87,89,94,79,47,96,79,88,94},22))
or inst:FindFirstChild(_d({77,86,83,79,88,94,47,96,79,88,94},22))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({80,83,88,78,43,88,93,97,79,92,45,89,88,88,79,77,94,89,92,10,79,92,92,89,92,36},22), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({45,89,95,86,78,10,88,89,94,10,86,89,77,75,94,79,10,60,79,87,89,94,79,47,96,79,88,94,25,77,86,83,79,88,94,47,96,79,88,94,10,88,79,75,92,10,60,79,90,86,75,99,10,76,95,94,94,89,88,22,10,80,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,77,86,83,77,85},22))
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
debug(_d({80,83,92,79,60,79,90,86,75,99,64,75,86,95,79,10,79,92,92,89,92,36},22), err, _d({23,10,80,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,77,86,83,77,85},22))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({48,75,86,86,83,88,81,10,76,75,77,85,10,94,89,10,76,95,94,94,89,88,64,75,86,95,79,10,93,79,75,92,77,82,10,80,89,92,10,60,79,90,86,75,99},22))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({60,79,90,86,75,99,10,76,95,94,94,89,88,10,88,89,94,10,80,89,95,88,78,10,79,83,94,82,79,92,22,10,81,83,96,83,88,81,10,95,90},22))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({65,75,83,94,83,88,81,10,80,89,92,10,45,89,88,80,83,92,87,75,94,83,89,88,58,92,89,87,90,94,24,60,79,87,89,94,79,47,96,79,88,94},22))
local remote = getReplayRemote()
if not remote then
debug(_d({45,89,88,80,83,92,87,75,94,83,89,88,58,92,89,87,90,94,25,60,79,87,89,94,79,47,96,79,88,94,10,88,89,94,10,80,89,95,88,78,10,97,83,94,82,83,88,10,94,83,87,79,89,95,94},22))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({48,83,92,83,88,81,10,60,79,90,86,75,99,10,96,83,75,10,45,89,88,80,83,92,87,75,94,83,89,88,58,92,89,87,90,94,24,60,79,87,89,94,79,47,96,79,88,94},22))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({48,83,92,79,61,79,92,96,79,92,10,79,92,92,89,92,36},22), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({58,86,75,99,79,92,49,95,83},22), 10)
if not playerGui then
debug(_d({97,75,83,94,48,89,92,57,76,84,79,77,94,83,96,79,93,49,95,83,36,10,88,89,10,58,86,75,99,79,92,49,95,83,10,97,83,94,82,83,88,10,94,83,87,79,89,95,94,22,10,90,92,89,77,79,79,78,83,88,81,10,75,88,99,97,75,99},22))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({57,76,84,79,77,94,83,96,79,93,10,49,63,51,10,80,89,95,88,78,10,23,10,93,94,75,81,79,10,86,89,75,78,79,78},22))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({57,76,84,79,77,94,83,96,79,93,10,49,63,51,10,88,89,94,10,80,89,95,88,78,10,97,83,94,82,83,88,10,94,83,87,79,89,95,94,22,10,90,92,89,77,79,79,78,83,88,81,10,75,88,99,97,75,99},22))
return
end
end
end)
if not ok then debug(_d({97,75,83,94,48,89,92,57,76,84,79,77,94,83,96,79,93,49,95,83,10,79,92,92,89,92,36},22), err) end
end
local function runPlan()
debug(_d({58,86,75,88,10,93,94,75,92,94,79,78},22))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({61,94,75,92,94,83,88,81,10,88,75,96,10,86,89,89,90},22))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({90,89,93,10,26,24,28,93,10,43,48,62,47,60,10,93,94,75,92,94,56,75,96,36},22), rootAfter and rootAfter.Position)
end)
debug(_d({65,75,83,94,83,88,81,10,31,93,10,76,79,80,89,92,79,10,87,89,96,83,88,81,10,94,89,10,61,94,75,81,79,27},22))
task.wait(5)
for _, stage in ipairs({_d({61,94,75,81,79,27},22), _d({61,94,75,81,79,28},22), _d({61,94,75,81,79,29},22), _d({61,94,75,81,79,29,44},22)}) do
if not enabled then return end
local hpTarget = (stage == _d({61,94,75,81,79,29,44},22)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({55,89,96,83,88,81,10,94,89,10,75,92,92,89,97,10,80,86,99,23,78,89,97,88,10,75,92,79,75,10,18,45,95,90,83,78,10,60,75,83,88,19},22))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({46,89,78,81,83,88,81,10,75,92,92,89,97,10,92,75,83,88,10,83,88,10,75,10,93,91,95,75,92,79},22))
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
clearStage(_d({61,94,75,81,79,30},22))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({59,95,79,79,88,10,83,88,10,90,82,75,93,79,10,28,10,23,10,85,79,79,90,83,88,81,10,53,79,88,10,50,75,85,83,10,75,77,94,83,96,79,10,80,92,89,87,10,82,79,92,79,10,89,88},22))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({61,94,75,94,95,79,27},22))
if not enabled then return end
recheckStatue(_d({61,94,75,94,95,79,27},22))
destroyStatue(_d({61,94,75,94,95,79,28},22))
if not enabled then return end
recheckStatue(_d({61,94,75,94,95,79,27},22))
recheckStatue(_d({61,94,75,94,95,79,28},22))
destroyStatue(_d({61,94,75,94,95,79,29},22))
if not enabled then return end
recheckStatue(_d({61,94,75,94,95,79,29},22))
recheckStatue(_d({61,94,75,94,95,79,28},22))
recheckStatue(_d({61,94,75,94,95,79,27},22))
if not enabled then return end
debug(_d({65,75,83,94,83,88,81,10,80,89,92,10,90,82,75,93,79,10,28,10,94,89,10,79,88,78},22))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({58,82,75,93,79,10,28,10,79,88,78,10,97,75,83,94,10,94,83,87,79,89,95,94,22,10,90,92,89,77,79,79,78,83,88,81,10,75,88,99,97,75,99},22))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({55,89,96,83,88,81,10,76,75,77,85,10,94,89,10,59,95,79,79,88,10,93,94,75,81,79,10,90,89,93,83,94,83,89,88},22))
navToPointConfirmed(COORDS.Queen, 30, _d({59,95,79,79,88,10,93,94,75,81,79,10,90,89,93,83,94,83,89,88},22))
debug(_d({65,75,83,94,83,88,81,10,31,93,10,75,94,10,59,95,79,79,88,10,93,94,75,81,79,10,90,89,93,83,94,83,89,88},22))
task.wait(5)
if not enabled then return end
debug(_d({55,89,96,83,88,81,10,94,89,10,90,89,93,94,23,59,95,79,79,88,10,90,89,93,83,94,83,89,88},22))
navToPointConfirmed(COORDS.PostQueen, 30, _d({90,89,93,94,23,59,95,79,79,88,10,90,89,93,83,94,83,89,88},22))
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
debug(_d({47,88,75,76,86,83,88,81,22,10,90,89,93,10,44,47,48,57,60,47,10,90,86,75,88,36},22), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({58,86,75,88,10,79,92,92,89,92,36},22), err2) end
end)
debug(_d({47,88,75,76,86,79,78,36},22), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({47,88,75,76,86,79,78,36},22), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({69,61,75,80,79,81,95,75,92,78,71,10,48,75,83,86,79,78,10,94,89,10,86,89,75,78,11},22)); return end
if not Safeguard.RequirePlace(11424731604, _d({45,95,90,83,78,10,46,95,88,81,79,89,88},22)) then
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
_d({45,95,90,83,78,10,46,95,88,81,79,89,88},22),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)()