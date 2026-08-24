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
local Players            = game:GetService(_d({51,79,68,92,72,85,86},29))
local UserInputService    = game:GetService(_d({56,86,72,85,44,81,83,88,87,54,72,85,89,76,70,72},29))
local RunService          = game:GetService(_d({53,88,81,54,72,85,89,76,70,72},29))
local VIM                 = game:GetService(_d({57,76,85,87,88,68,79,44,81,83,88,87,48,68,81,68,74,72,85},29))
local ReplicatedStorage    = game:GetService(_d({53,72,83,79,76,70,68,87,72,71,54,87,82,85,68,74,72},29))
local Workspace            = workspace
local Core = nil
pcall(function()
if isfile and readfile and isfile(_d({19,20,16,74,83,82,18,79,76,69,18,70,82,85,72,17,79,88,68},29)) then
Core = loadstring(readfile(_d({19,20,16,74,83,82,18,79,76,69,18,70,82,85,72,17,79,88,68},29)))()
else
Core = loadstring(game:HttpGet(_d({75,87,87,83,86,29,18,18,85,68,90,17,74,76,87,75,88,69,88,86,72,85,70,82,81,87,72,81,87,17,70,82,80,18,85,82,70,78,92,91,90,68,79,79,18,79,88,68,88,16,70,82,71,72,18,80,68,76,81,18,19,20,66,86,70,85,76,83,87,18,79,76,69,18,70,82,85,72,17,79,88,68},29)))()
end
end)
if not Core then warn(_d({62,38,82,85,72,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,4},29)); return end
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
local LEO_PILLAR_ANIM_ID   = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,24,21,23,23,20,23,20,22,21,26},29)
local LEO_ENTEI_ANIM_ID    = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,24,21,23,23,20,22,27,21,26,27},29)
local LEO_HIKEN_ANIM_ID    = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,24,21,21,19,28,20,26,23,19,26},29)
local LEO_FIREFLY_ANIM_ID  = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,24,21,21,19,21,22,25,20,24,23},29)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({50,69,77,72,70,87,76,89,72,86},29)
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
local REPLAY_BUTTON_VALUE   = _d({53,72,83,79,68,92},29)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({80,82,89,72},29)
local NavState   = {mode = _d({76,71,79,72},29)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({62,37,82,86,86,37,82,87,64},29), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
end)
if ok then return root end
debug(_d({74,72,87,53,82,82,87,3,72,85,85,82,85,29},29), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
end)
if ok then return hum end
debug(_d({74,72,87,43,88,80,68,81,82,76,71,3,72,85,85,82,85,29},29), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({66,66,43,82,89,72,85,36,87,87},29)) or Instance.new(_d({36,87,87,68,70,75,80,72,81,87},29))
att.Name = _d({66,66,43,82,89,72,85,36,87,87},29)
att.Parent = root
local force = root:FindFirstChild(_d({66,66,43,82,89,72,85,41,82,85,70,72},29))
if not force then
force = Instance.new(_d({47,76,81,72,68,85,57,72,79,82,70,76,87,92},29))
force.Name = _d({66,66,43,82,89,72,85,41,82,85,70,72},29)
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
debug(_d({74,72,87,50,85,38,85,72,68,87,72,41,82,85,70,72,3,72,85,85,82,85,29},29), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if not root then return end
local force = root:FindFirstChild(_d({66,66,43,82,89,72,85,41,82,85,70,72},29))
local att   = root:FindFirstChild(_d({66,66,43,82,89,72,85,36,87,87},29))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({70,79,72,68,81,88,83,41,82,85,70,72,3,72,85,85,82,85,29},29), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({37,88,86,82,48,72,79,72,72},29)) ~= nil
end)
if ok then return result end
debug(_d({76,86,37,88,86,82,36,70,87,76,89,72,3,72,85,85,82,85,29},29), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({37,88,86,82},29))
end)
if not ok then debug(_d({68,70,87,76,89,68,87,72,37,88,86,82,3,72,85,85,82,85,29},29), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({37,88,86,82,3,81,82,87,3,68,70,87,76,89,72,15,3,68,70,87,76,89,68,87,76,81,74},29))
activateBuso()
end
end)
if not ok then debug(_d({37,88,86,82,46,72,72,83,72,85,3,72,85,85,82,85,29},29), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({37,88,86,82,3,78,72,72,83,72,85,3,86,87,82,83,83,72,71},29))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({46,72,81,43,68,78,76},29)) ~= nil
end)
if ok then return result end
debug(_d({76,86,46,72,81,36,70,87,76,89,72,3,72,85,85,82,85,29},29), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({46,72,81},29), true)
end)
if not ok then debug(_d({68,70,87,76,89,68,87,72,46,72,81,3,72,85,85,82,85,29},29), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({46,72,81,3,81,82,87,3,68,70,87,76,89,72,15,3,68,70,87,76,89,68,87,76,81,74},29))
activateKen()
end
end)
if not ok then debug(_d({46,72,81,46,72,72,83,72,85,3,72,85,85,82,85,29},29), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({46,72,81,3,78,72,72,83,72,85,3,86,87,82,83,83,72,71},29))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({49,51,38,86},29)) end)
if ok then return folder end
debug(_d({74,72,87,49,51,38,86,41,82,79,71,72,85,3,72,85,85,82,85,29},29), folder)
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
local r = model:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local h = model:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
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
debug(_d({74,72,87,49,72,68,85,72,86,87,49,51,38,3,72,85,85,82,85,29},29), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
local hum  = model:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({74,72,87,49,51,38,37,92,49,68,80,72,3,72,85,85,82,85,29},29), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({81,83,70,86,53,72,80,68,76,81,76,81,74,3,72,85,85,82,85,29},29), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({38,88,83,76,71,3,52,88,72,72,81},29))
return queen ~= nil and queen:FindFirstChild(_d({80,82,87,76,82,81,47,72,86,86},29)) ~= nil
end)
if ok then return result end
debug(_d({76,86,52,88,72,72,81,51,75,68,86,72,21,3,72,85,85,82,85,29},29), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,20,21,20,21,28,26,28,23,21,21,28,21,26,25,28},29)
local QUEEN_GRASP_ANIM_ID   = _d({85,69,91,68,86,86,72,87,76,71,29,18,18,20,21,28,27,19,19,19,25,20,19,19,20,26,22,23},29)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
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
debug(_d({76,86,51,79,68,92,76,81,74,36,81,76,80,41,85,82,80,47,76,86,87,3,72,85,85,82,85,29},29), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({37,79,82,70,78,76,81,74},29)) ~= nil
end)
if ok then return result end
debug(_d({76,86,49,51,38,37,79,82,70,78,76,81,74,3,72,85,85,82,85,29},29), result)
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
debug(_d({83,85,72,71,76,70,87,49,51,38,51,82,86,76,87,76,82,81,3,72,85,85,82,85,29},29), result)
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
debug(_d({49,82,3,71,68,80,68,74,72,3,82,81},29), model.Name, _d({73,82,85},29), NPC_STUCK_TIMEOUT, _d({86,3,16,3,86,90,76,87,70,75,76,81,74,3,87,68,85,74,72,87},29))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({87,85,68,70,78,49,51,38,39,68,80,68,74,72,3,72,85,85,82,85,29},29), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({48,82,71,72,79},29)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({37,68,86,72,51,68,85,87},29)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({74,72,87,48,82,71,72,79,41,68,70,72,51,82,86,3,72,85,85,82,85,29},29), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({40,81,89},29))
local folder = env and env:FindFirstChild(_d({54,87,68,87,88,72,86},29))
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
debug(_d({74,72,87,54,87,68,87,88,72,48,82,71,72,79,49,72,68,85,3,72,85,85,82,85,29},29), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({69,68,85,85,72,79,43,51},29))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({74,72,87,54,87,68,87,88,72,43,51,3,72,85,85,82,85,29},29), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({55,82,82,79},29)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({73,76,81,71,55,82,82,79,37,92,36,87,87,85,76,69,88,87,72,3,72,85,85,82,85,29},29), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({55,82,82,79},29)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({73,76,81,71,55,82,82,79,37,92,49,68,80,72,3,72,85,85,82,85,29},29), tool)
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
if not ok then debug(_d({72,84,88,76,83,55,82,82,79,3,72,85,85,82,85,29},29), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({37,68,70,78,83,68,70,78},29))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({55,82,82,79},29)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({73,76,81,71,55,82,82,79,37,92,38,75,76,79,71,49,68,80,72,3,72,85,85,82,85,29},29), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({54,90,82,85,71,40,84,88,76,83},29))
if sword then
equipTool(sword)
return _d({86,90,82,85,71},29)
end
local melee = findToolByAttribute(_d({48,72,79,72,72,55,82,82,79},29))
if melee then
equipTool(melee)
return _d({80,72,79,72,72},29)
end
debug(_d({49,82,3,86,90,82,85,71,3,82,85,3,80,72,79,72,72,3,87,82,82,79,3,73,82,88,81,71},29))
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
if not ok then debug(_d({70,79,76,70,78,48,20,3,72,85,85,82,85,29},29), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({43,88,80,68,81,82,76,71,53,82,82,87,51,68,85,87},29))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({54,87,68,87,86},29) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({53,82,78,88,86,75,76,78,76},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({42,72,83,83,82},29), args)
elseif style == _d({37,79,68,70,78,47,72,74},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,78,92,3,58,68,79,78},29), args)
elseif style == _d({46,68,80,76,86,75,76,78,76},29) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({46,68,80,76,86,75,76,78,76,42,72,83,83,82},29), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,78,92,3,58,68,79,78,21},29), args)
end
end)
if not ok then debug(_d({76,81,89,82,78,72,42,72,83,83,82,3,72,85,85,82,85,29},29), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({83,85,72,86,86,54,78,76,79,79,53,3,72,85,85,82,85,29},29), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({75,82,79,71,37,79,82,70,78,3,72,85,85,82,85,29},29), err) end
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
if not ok then debug(_d({75,82,79,71,37,79,82,70,78,58,75,76,79,72,3,72,85,85,82,85,29},29), err) end
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
debug(_d({74,72,87,42,68,80,72,42,3,72,85,85,82,85,29},29), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({76,86,53,72,68,79,48,20,37,88,86,92,3,72,85,85,82,85,29},29), result)
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
return char ~= nil and char:FindFirstChild(_d({86,87,88,81},29)) ~= nil
end)
if ok then return result end
debug(_d({76,86,54,87,88,81,81,72,71,3,72,85,85,82,85,29},29), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({83,85,72,86,86,54,87,88,81,37,85,72,68,78,3,72,85,85,82,85,29},29), err) end
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
debug(_d({84,88,72,72,81,39,82,71,74,72,56,81,87,76,79,54,68,73,72,29,3,52,88,72,72,81,3,74,82,81,72,3,16,3,72,81,71,76,81,74,3,71,82,71,74,72,3,72,68,85,79,92},29))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({84,88,72,72,81,39,82,71,74,72,56,81,87,76,79,54,68,73,72,3,86,68,73,72,87,92,3,87,76,80,72,82,88,87},29))
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
local info = getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({52,88,72,72,81,3,70,68,86,87,76,81,74,3,71,72,87,72,70,87,72,71,3,16,3,71,82,71,74,76,81,74,3,11,90,68,87,70,75,72,85,12},29))
queenDodgeUntilSafe(function() return getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29)) end)
if enabled and getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29)) then
setNavNamed(_d({38,88,83,76,71,3,52,88,72,72,81},29))
end
queenDodging = false
end
end)
if not ok then debug(_d({84,88,72,72,81,39,82,71,74,72,58,68,87,70,75,72,85,3,72,85,85,82,85,29},29), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({83,82,76,81,87},29) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({81,83,70},29) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({81,68,80,72,71},29) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({74,72,87,49,68,89,55,68,85,74,72,87,86,3,72,85,85,82,85,29},29), aimR)
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
debug(_d({70,82,80,83,88,87,72,47,82,70,78,72,71,38,41,85,68,80,72,3,72,85,85,82,85,29},29), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({83,82,76,81,87},29), point = pos}
phase = _d({80,82,89,72},29)
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
if not ok then debug(_d({81,68,89,55,82,51,82,76,81,87,3,74,72,83,83,82,3,70,75,72,70,78,3,72,85,85,82,85,29},29), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({81,83,70},29)}
phase = _d({80,82,89,72},29)
end
function setNavNamed(name)
NavState = {mode = _d({81,68,80,72,71},29), name = name}
phase = _d({80,82,89,72},29)
end
local function setNavIdle()
NavState = {mode = _d({76,71,79,72},29)}
phase = _d({80,82,89,72},29)
end
local function hasArrived()
return phase == _d({75,82,89,72,85},29)
end
local function startNav()
phase = _d({80,82,89,72},29)
debug(_d({49,68,89,3,79,82,82,83,3,50,49},29))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({51,79,68,92,72,85,3,71,76,72,71,4,3,54,87,82,83,83,76,81,74,3,69,82,87,17},29))
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
debug(_d({51,79,68,92,72,85,3,76,86,3,87,82,82,3,73,68,85,3,73,85,82,80,3,87,68,85,74,72,87,3,11,33,21,19,19,19,3,86,87,88,71,86,12,17,3,47,76,78,72,79,92,3,85,72,86,83,68,90,81,72,71,3,68,87,3,79,82,69,69,92,17,3,54,87,82,83,83,76,81,74,3,69,82,87,17},29))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({66,66,83,85,72,89,51,82,86},29))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({47,68,85,74,72,3,83,82,86,76,87,76,82,81,3,77,88,80,83,3,71,72,87,72,70,87,72,71,29},29), delta, _d({86,87,88,71,86,17,3,83,85,72,89,51,82,86,32},29), prevPos, _d({81,72,90,51,82,86,32},29), pos)
end
end
force:SetAttribute(_d({66,66,83,85,72,89,51,82,86},29), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({80,82,89,72},29) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({75,82,89,72,85},29)
debug(_d({51,75,68,86,72,29,3,75,82,89,72,85},29))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({4,4,4,3,53,40,41,56,54,44,49,42,3,55,50,3,36,51,51,47,60,3,36,37,49,50,53,48,36,47,3,57,40,47,50,38,44,55,60,29},29), finalVel, _d({68,76,80,32},29), aim, _d({83,82,86,32},29), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({75,82,89,72,85},29) then
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
debug(_d({38,82,80,69,68,87,3,79,82,70,78,3,86,78,76,83,83,72,71,15},29), snapDist, _d({86,87,88,71,86,3,73,85,82,80,3,87,68,85,74,72,87,3,197,99,119,3,73,68,79,79,76,81,74,3,69,68,70,78,3,87,82,3,80,82,89,72},29))
phase = _d({80,82,89,72},29)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({43,72,68,85,87,69,72,68,87,3,72,85,85,82,85,29},29), err) end
end)
end
local function stopNav()
debug(_d({49,68,89,3,79,82,82,83,3,50,41,41},29))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({80,82,89,72},29)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({55,72,91,87,38,75,68,87,54,72,85,89,76,70,72},29))
local channels = TextChatService:FindFirstChild(_d({55,72,91,87,38,75,68,81,81,72,79,86},29))
local channel = channels and channels:FindFirstChild(_d({53,37,59,42,72,81,72,85,68,79},29))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({39,72,73,68,88,79,87,38,75,68,87,54,92,86,87,72,80,38,75,68,87,40,89,72,81,87,86},29))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({54,68,92,48,72,86,86,68,74,72,53,72,84,88,72,86,87},29))
if sayEvent then
sayEvent:FireServer(message, _d({36,79,79},29))
return
end
debug(_d({86,72,81,71,38,75,68,87,48,72,86,86,68,74,72,29,3,81,82,3,55,72,91,87,38,75,68,87,54,72,85,89,76,70,72,17,53,37,59,42,72,81,72,85,68,79,3,82,85,3,79,72,74,68,70,92,3,54,68,92,48,72,86,86,68,74,72,53,72,84,88,72,86,87,3,73,82,88,81,71,3,73,82,85},29), message)
end)
if not ok then debug(_d({86,72,81,71,38,75,68,87,48,72,86,86,68,74,72,3,72,85,85,82,85,29},29), err) end
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
debug(_d({49,82,87,3,80,68,78,76,81,74,3,83,85,82,74,85,72,86,86,3,87,82,90,68,85,71,3,81,68,89,3,87,68,85,74,72,87,3,73,82,85},29), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({86,3,16,3,86,72,81,71,76,81,74,3,18,88,81,86,87,88,70,78},29))
sendChatMessage(_d({18,88,81,86,87,88,70,78},29))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({90,68,76,87,56,81,87,76,79,36,85,85,76,89,72,71,3,87,76,80,72,82,88,87},29))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({81,68,89,55,82,51,82,76,81,87,38,82,81,73,76,85,80,72,71,29},29), label or _d({87,68,85,74,72,87},29), _d({16,3,71,76,71,3,81,82,87,3,68,85,85,76,89,72,3,90,76,87,75,76,81},29), timeout, _d({86,15,3,85,72,87,85,92,76,81,74,3,82,81,70,72},29))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({81,68,89,55,82,51,82,76,81,87,38,82,81,73,76,85,80,72,71,29},29), label or _d({87,68,85,74,72,87},29), _d({16,3,86,87,76,79,79,3,81,82,87,3,68,85,85,76,89,72,71,3,68,73,87,72,85,3,85,72,87,85,92,15,3,83,85,82,70,72,72,71,76,81,74,3,68,81,92,90,68,92},29))
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
if not ok then debug(_d({81,68,89,55,82,51,82,76,81,87,43,82,79,71,76,81,74,37,79,82,70,78,3,78,72,92,16,71,82,90,81,3,72,85,85,82,85,29},29), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({81,68,89,55,82,51,82,76,81,87,43,82,79,71,76,81,74,37,79,82,70,78,3,78,72,92,16,88,83,3,72,85,85,82,85,29},29), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({58,68,79,78,76,81,74,3,87,82,29},29), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({90,68,79,78,55,82,51,82,76,81,87,3,58,3,71,82,90,81,3,72,85,85,82,85,29},29), err) end
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
debug(_d({55,82,82,78,3,71,68,80,68,74,72,3,90,75,76,79,72,3,90,68,79,78,76,81,74,3,87,82,3,83,82,76,81,87,4,3,54,87,82,83,83,76,81,74,3,90,68,79,78,3,87,82,3,72,81,74,68,74,72,17},29))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({36,85,85,76,89,72,71,3,68,87,29},29), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({54,87,88,70,78,3,71,88,85,76,81,74,3,90,68,79,78,15,3,77,88,80,83,76,81,74,4},29))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({54,87,76,79,79,3,86,87,88,70,78,15,3,87,85,76,74,74,72,85,76,81,74,3,42,72,83,83,82,4},29))
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
debug(_d({48,82,89,76,81,74,3,87,82},29), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({58,68,76,87,76,81,74,3,73,82,85,3,49,51,38,86,3,87,82,3,86,83,68,90,81,3,68,87},29), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({3,3,86,83,68,90,81,3,70,75,72,70,78,29,3,73,82,79,71,72,85,3,72,91,76,86,87,86,3,32},29), folder ~= nil,
_d({15,3,70,75,76,79,71,85,72,81,3,32},29), folder and #folder:GetChildren() or 0,
_d({15,3,68,79,76,89,72,3,32},29), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({49,82,3,49,51,38,86,3,68,83,83,72,68,85,72,71,3,68,87},29), stageName, _d({68,73,87,72,85,3,20,24,86,15,3,80,82,89,76,81,74,3,82,81,3,68,81,92,90,68,92},29))
break
end
end
debug(_d({46,76,79,79,76,81,74,3,49,51,38,86,3,68,87},29), stageName)
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
debug(_d({53,72,87,88,85,81,76,81,74,3,87,82},29), stageName, _d({83,82,86,76,87,76,82,81,3,69,72,73,82,85,72,3,80,82,89,76,81,74,3,82,81},29))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({58,68,76,87,76,81,74,3,24,86,3,68,87},29), stageName, _d({83,82,86,76,87,76,82,81},29))
task.wait(5)
debug(_d({58,68,76,87,76,81,74,3,73,82,85},29), targetHP * 100, _d({8,3,43,51,3,69,72,73,82,85,72,3,80,82,89,76,81,74,3,87,82,3,81,72,91,87,3,86,87,68,74,72},29))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({70,79,72,68,85,72,71},29))
end
local function killNamedNPC(name, targetPos)
debug(_d({48,82,89,76,81,74,3,87,82},29), name)
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
debug(name, _d({71,72,73,72,68,87,72,71},29))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({43,88,80,68,81,82,76,71},29))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({47,72,82,3,83,79,68,92,72,71,3,68,81,76,80,68,87,76,82,81,29},29), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({79,72,82,36,81,76,80,47,82,74,74,72,85,3,83,85,76,81,87,3,72,85,85,82,85,29},29), err2) end
end)
end)
if not ok then debug(_d({86,87,68,85,87,47,72,82,36,81,76,80,47,82,74,74,72,85,3,72,85,85,82,85,29},29), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({48,82,89,76,81,74,3,87,82,3,47,72,82},29))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({47,72,82},29))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({47,72,82},29))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({47,72,82},29))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({47,72,82,3,70,68,86,87,76,81,74},29), which, _d({16,3,71,82,71,74,76,81,74},29))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({47,72,82,3,86,87,68,85,87,72,71,3,69,79,82,70,78,16,69,85,72,68,78,72,85,3,80,76,71,16,69,79,82,70,78,4,3,40,89,68,71,76,81,74,17,17,17},29))
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
if not getNPCByName(_d({47,72,82},29)) then
debug(_d({47,72,82,3,74,82,81,72,3,80,76,71,16,71,82,71,74,72,3,16,3,72,81,71,76,81,74,3,40,81,87,72,76,3,75,82,79,71,3,72,68,85,79,92},29))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({47,72,82},29)) then
setNavNamed(_d({47,72,82},29))
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
debug(_d({47,72,82,3,71,72,73,72,68,87,72,71},29))
stopLeoAnimLogger()
debug(_d({53,72,87,88,85,81,76,81,74,3,87,82,3,47,72,82,3,83,82,86,76,87,76,82,81,3,69,72,73,82,85,72,3,80,82,89,76,81,74,3,82,81},29))
navToPointConfirmed(COORDS.Leo, 30, _d({47,72,82,3,83,82,86,76,87,76,82,81},29))
debug(_d({58,68,76,87,76,81,74,3,24,86,3,68,87,3,47,72,82,3,83,82,86,76,87,76,82,81},29))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({48,82,89,76,81,74,3,87,82},29), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({38,82,88,79,71,3,81,82,87,3,73,76,81,71,3,86,87,68,87,88,72,3,80,82,71,72,79,3,81,72,68,85},29), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({36,87,87,68,70,78,76,81,74},29), coordKey, _d({90,76,87,75},29), weapon or _d({81,82,87,75,76,81,74,3,73,82,88,81,71},29))
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
debug(coordKey, _d({69,68,85,85,72,79,3,71,72,86,87,85,82,92,72,71},29))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({85,72,70,75,72,70,78,54,87,68,87,88,72,29},29), coordKey, _d({16,3,70,82,88,79,71,3,81,82,87,3,73,76,81,71,3,86,87,68,87,88,72,3,80,82,71,72,79,15,3,86,78,76,83,83,76,81,74},29))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({85,72,70,75,72,70,78,54,87,68,87,88,72,29},29), coordKey, _d({86,87,76,79,79,3,68,79,76,89,72,3,11,43,51},29), hp, _d({12,3,16,3,85,72,16,71,72,86,87,85,82,92,76,81,74},29))
destroyStatue(coordKey)
else
debug(_d({85,72,70,75,72,70,78,54,87,68,87,88,72,29},29), coordKey, _d({70,82,81,73,76,85,80,72,71,3,71,72,86,87,85,82,92,72,71},29))
end
end)
if not ok then debug(_d({85,72,70,75,72,70,78,54,87,68,87,88,72,3,72,85,85,82,85,29},29), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({48,82,89,76,81,74,3,87,82,3,52,88,72,72,81},29))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({38,88,83,76,71,3,52,88,72,72,81},29))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29))
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
debug(_d({52,88,72,72,81,3,72,81,87,72,85,72,71,3,83,75,68,86,72,3,21},29))
end
local function finishQueen()
debug(_d({41,76,81,76,86,75,76,81,74,3,52,88,72,72,81},29))
equipSwordOrMelee()
setNavNamed(_d({38,88,83,76,71,3,52,88,72,72,81},29))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({38,88,83,76,71,3,52,88,72,72,81},29))
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
debug(_d({52,88,72,72,81,3,71,72,73,72,68,87,72,71,17,3,51,79,68,81,3,70,82,80,83,79,72,87,72,17},29))
end
local CONFIRMATION_PROMPT_NAME = _d({38,82,81,73,76,85,80,68,87,76,82,81,51,85,82,80,83,87},29)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({53,72,80,82,87,72,40,89,72,81,87},29), 5)
end)
if ok then return result end
debug(_d({74,72,87,53,72,83,79,68,92,53,72,80,82,87,72,3,72,85,85,82,85,29},29), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({51,79,68,92,72,85,42,88,76},29))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({44,80,68,74,72,37,88,87,87,82,81},29)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({69,88,87,87,82,81,57,68,79,88,72},29)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({73,76,81,71,37,88,87,87,82,81,37,92,57,68,79,88,72,3,72,85,85,82,85,29},29), result)
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
if not ok then debug(_d({70,79,76,70,78,42,88,76,37,88,87,87,82,81,3,72,85,85,82,85,29},29), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({76,86,54,72,85,89,72,85},29))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({53,72,80,82,87,72,40,89,72,81,87},29))
or inst:FindFirstChild(_d({70,79,76,72,81,87,40,89,72,81,87},29))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({73,76,81,71,36,81,86,90,72,85,38,82,81,81,72,70,87,82,85,3,72,85,85,82,85,29},29), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({38,82,88,79,71,3,81,82,87,3,79,82,70,68,87,72,3,53,72,80,82,87,72,40,89,72,81,87,18,70,79,76,72,81,87,40,89,72,81,87,3,81,72,68,85,3,53,72,83,79,68,92,3,69,88,87,87,82,81,15,3,73,68,79,79,76,81,74,3,69,68,70,78,3,87,82,3,70,79,76,70,78},29))
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
debug(_d({73,76,85,72,53,72,83,79,68,92,57,68,79,88,72,3,72,85,85,82,85,29},29), err, _d({16,3,73,68,79,79,76,81,74,3,69,68,70,78,3,87,82,3,70,79,76,70,78},29))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({41,68,79,79,76,81,74,3,69,68,70,78,3,87,82,3,69,88,87,87,82,81,57,68,79,88,72,3,86,72,68,85,70,75,3,73,82,85,3,53,72,83,79,68,92},29))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({53,72,83,79,68,92,3,69,88,87,87,82,81,3,81,82,87,3,73,82,88,81,71,3,72,76,87,75,72,85,15,3,74,76,89,76,81,74,3,88,83},29))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({58,68,76,87,76,81,74,3,73,82,85,3,38,82,81,73,76,85,80,68,87,76,82,81,51,85,82,80,83,87,17,53,72,80,82,87,72,40,89,72,81,87},29))
local remote = getReplayRemote()
if not remote then
debug(_d({38,82,81,73,76,85,80,68,87,76,82,81,51,85,82,80,83,87,18,53,72,80,82,87,72,40,89,72,81,87,3,81,82,87,3,73,82,88,81,71,3,90,76,87,75,76,81,3,87,76,80,72,82,88,87},29))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({41,76,85,76,81,74,3,53,72,83,79,68,92,3,89,76,68,3,38,82,81,73,76,85,80,68,87,76,82,81,51,85,82,80,83,87,17,53,72,80,82,87,72,40,89,72,81,87},29))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({41,76,85,72,54,72,85,89,72,85,3,72,85,85,82,85,29},29), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({51,79,68,92,72,85,42,88,76},29), 10)
if not playerGui then
debug(_d({90,68,76,87,41,82,85,50,69,77,72,70,87,76,89,72,86,42,88,76,29,3,81,82,3,51,79,68,92,72,85,42,88,76,3,90,76,87,75,76,81,3,87,76,80,72,82,88,87,15,3,83,85,82,70,72,72,71,76,81,74,3,68,81,92,90,68,92},29))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({50,69,77,72,70,87,76,89,72,86,3,42,56,44,3,73,82,88,81,71,3,16,3,86,87,68,74,72,3,79,82,68,71,72,71},29))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({50,69,77,72,70,87,76,89,72,86,3,42,56,44,3,81,82,87,3,73,82,88,81,71,3,90,76,87,75,76,81,3,87,76,80,72,82,88,87,15,3,83,85,82,70,72,72,71,76,81,74,3,68,81,92,90,68,92},29))
return
end
end
end)
if not ok then debug(_d({90,68,76,87,41,82,85,50,69,77,72,70,87,76,89,72,86,42,88,76,3,72,85,85,82,85,29},29), err) end
end
local function runPlan()
debug(_d({51,79,68,81,3,86,87,68,85,87,72,71},29))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({54,87,68,85,87,76,81,74,3,81,68,89,3,79,82,82,83},29))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({83,82,86,3,19,17,21,86,3,36,41,55,40,53,3,86,87,68,85,87,49,68,89,29},29), rootAfter and rootAfter.Position)
end)
debug(_d({58,68,76,87,76,81,74,3,24,86,3,69,72,73,82,85,72,3,80,82,89,76,81,74,3,87,82,3,54,87,68,74,72,20},29))
task.wait(5)
for _, stage in ipairs({_d({54,87,68,74,72,20},29), _d({54,87,68,74,72,21},29), _d({54,87,68,74,72,22},29), _d({54,87,68,74,72,22,37},29)}) do
if not enabled then return end
local hpTarget = (stage == _d({54,87,68,74,72,22,37},29)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({48,82,89,76,81,74,3,87,82,3,68,85,85,82,90,3,73,79,92,16,71,82,90,81,3,68,85,72,68,3,11,38,88,83,76,71,3,53,68,76,81,12},29))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({39,82,71,74,76,81,74,3,68,85,85,82,90,3,85,68,76,81,3,76,81,3,68,3,86,84,88,68,85,72},29))
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
clearStage(_d({54,87,68,74,72,23},29))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({52,88,72,72,81,3,76,81,3,83,75,68,86,72,3,21,3,16,3,78,72,72,83,76,81,74,3,46,72,81,3,43,68,78,76,3,68,70,87,76,89,72,3,73,85,82,80,3,75,72,85,72,3,82,81},29))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({54,87,68,87,88,72,20},29))
if not enabled then return end
recheckStatue(_d({54,87,68,87,88,72,20},29))
destroyStatue(_d({54,87,68,87,88,72,21},29))
if not enabled then return end
recheckStatue(_d({54,87,68,87,88,72,20},29))
recheckStatue(_d({54,87,68,87,88,72,21},29))
destroyStatue(_d({54,87,68,87,88,72,22},29))
if not enabled then return end
recheckStatue(_d({54,87,68,87,88,72,22},29))
recheckStatue(_d({54,87,68,87,88,72,21},29))
recheckStatue(_d({54,87,68,87,88,72,20},29))
if not enabled then return end
debug(_d({58,68,76,87,76,81,74,3,73,82,85,3,83,75,68,86,72,3,21,3,87,82,3,72,81,71},29))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({51,75,68,86,72,3,21,3,72,81,71,3,90,68,76,87,3,87,76,80,72,82,88,87,15,3,83,85,82,70,72,72,71,76,81,74,3,68,81,92,90,68,92},29))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({48,82,89,76,81,74,3,69,68,70,78,3,87,82,3,52,88,72,72,81,3,86,87,68,74,72,3,83,82,86,76,87,76,82,81},29))
navToPointConfirmed(COORDS.Queen, 30, _d({52,88,72,72,81,3,86,87,68,74,72,3,83,82,86,76,87,76,82,81},29))
debug(_d({58,68,76,87,76,81,74,3,24,86,3,68,87,3,52,88,72,72,81,3,86,87,68,74,72,3,83,82,86,76,87,76,82,81},29))
task.wait(5)
if not enabled then return end
debug(_d({48,82,89,76,81,74,3,87,82,3,83,82,86,87,16,52,88,72,72,81,3,83,82,86,76,87,76,82,81},29))
navToPointConfirmed(COORDS.PostQueen, 30, _d({83,82,86,87,16,52,88,72,72,81,3,83,82,86,76,87,76,82,81},29))
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
debug(_d({40,81,68,69,79,76,81,74,15,3,83,82,86,3,37,40,41,50,53,40,3,83,79,68,81,29},29), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({51,79,68,81,3,72,85,85,82,85,29},29), err2) end
end)
debug(_d({40,81,68,69,79,72,71,29},29), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({40,81,68,69,79,72,71,29},29), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({62,54,68,73,72,74,88,68,85,71,64,3,41,68,76,79,72,71,3,87,82,3,79,82,68,71,4},29)); return end
if not Safeguard.RequirePlace(11424731604, _d({38,88,83,76,71,3,39,88,81,74,72,82,81},29)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then return end
disableBot()
end
if not _G.DisableStandalone then
table.insert(CupidDungeon.Connections, UserInputService.InputBegan:Connect(function(input, gpe)
if gpe then return end
if input.KeyCode == Enum.KeyCode.P then
if enabled then
CupidDungeon.Stop()
else
CupidDungeon.Start()
end
end
end))
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({42,68,80,72,3,79,82,68,71,72,71,15,3,68,88,87,82,16,86,87,68,85,87,76,81,74,3,87,75,72,3,83,79,68,81},29))
CupidDungeon.Start()
end)
debug(_d({54,87,68,81,71,68,79,82,81,72,3,48,82,71,72,29,3,68,88,87,82,16,86,87,68,85,87,76,81,74,3,11,83,85,72,86,86,3,51,3,87,82,3,87,82,74,74,79,72,12},29))
end
return CupidDungeon
end)()