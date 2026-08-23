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
local Players            = game:GetService(_d({46,74,63,87,67,80,81},34))
local UserInputService    = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
local RunService          = game:GetService(_d({48,83,76,49,67,80,84,71,65,67},34))
local VIM                 = game:GetService(_d({52,71,80,82,83,63,74,39,76,78,83,82,43,63,76,63,69,67,80},34))
local ReplicatedStorage    = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local Workspace            = workspace
local TARGET_PLACE_ID    = 11424731604
local TARGET_UNIVERSE_ID = 648454481
if game.PlaceId ~= TARGET_PLACE_ID or game.GameId ~= TARGET_UNIVERSE_ID then
print(_d({57,32,77,81,81,32,77,82,59},34), _d({53,80,77,76,69,254,69,63,75,67,254,192,94,114,254,46,74,63,65,67,39,66,24},34), game.PlaceId, _d({51,76,71,84,67,80,81,67,39,66,24},34), game.GameId, _d({11,254,76,77,82,254,80,83,76,76,71,76,69},34))
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
local LEO_PILLAR_ANIM_ID   = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,19,16,18,18,15,18,15,17,16,21},34)
local LEO_ENTEI_ANIM_ID    = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,19,16,18,18,15,17,22,16,21,22},34)
local LEO_HIKEN_ANIM_ID    = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,19,16,16,14,23,15,21,18,14,21},34)
local LEO_FIREFLY_ANIM_ID  = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,19,16,16,14,16,17,20,15,19,18},34)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({45,64,72,67,65,82,71,84,67,81},34)
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
local REPLAY_BUTTON_VALUE   = _d({48,67,78,74,63,87},34)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({75,77,84,67},34)
local NavState   = {mode = _d({71,66,74,67},34)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({57,32,77,81,81,32,77,82,59},34), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end)
if ok then return root end
debug(_d({69,67,82,48,77,77,82,254,67,80,80,77,80,24},34), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
end)
if ok then return hum end
debug(_d({69,67,82,38,83,75,63,76,77,71,66,254,67,80,80,77,80,24},34), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({61,61,38,77,84,67,80,31,82,82},34)) or Instance.new(_d({31,82,82,63,65,70,75,67,76,82},34))
att.Name = _d({61,61,38,77,84,67,80,31,82,82},34)
att.Parent = root
local force = root:FindFirstChild(_d({61,61,38,77,84,67,80,36,77,80,65,67},34))
if not force then
force = Instance.new(_d({42,71,76,67,63,80,52,67,74,77,65,71,82,87},34))
force.Name = _d({61,61,38,77,84,67,80,36,77,80,65,67},34)
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
debug(_d({69,67,82,45,80,33,80,67,63,82,67,36,77,80,65,67,254,67,80,80,77,80,24},34), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not root then return end
local force = root:FindFirstChild(_d({61,61,38,77,84,67,80,36,77,80,65,67},34))
local att   = root:FindFirstChild(_d({61,61,38,77,84,67,80,31,82,82},34))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({65,74,67,63,76,83,78,36,77,80,65,67,254,67,80,80,77,80,24},34), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({32,83,81,77,43,67,74,67,67},34)) ~= nil
end)
if ok then return result end
debug(_d({71,81,32,83,81,77,31,65,82,71,84,67,254,67,80,80,77,80,24},34), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({32,83,81,77},34))
end)
if not ok then debug(_d({63,65,82,71,84,63,82,67,32,83,81,77,254,67,80,80,77,80,24},34), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({32,83,81,77,254,76,77,82,254,63,65,82,71,84,67,10,254,63,65,82,71,84,63,82,71,76,69},34))
activateBuso()
end
end)
if not ok then debug(_d({32,83,81,77,41,67,67,78,67,80,254,67,80,80,77,80,24},34), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({32,83,81,77,254,73,67,67,78,67,80,254,81,82,77,78,78,67,66},34))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({41,67,76,38,63,73,71},34)) ~= nil
end)
if ok then return result end
debug(_d({71,81,41,67,76,31,65,82,71,84,67,254,67,80,80,77,80,24},34), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({41,67,76},34), true)
end)
if not ok then debug(_d({63,65,82,71,84,63,82,67,41,67,76,254,67,80,80,77,80,24},34), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({41,67,76,254,76,77,82,254,63,65,82,71,84,67,10,254,63,65,82,71,84,63,82,71,76,69},34))
activateKen()
end
end)
if not ok then debug(_d({41,67,76,41,67,67,78,67,80,254,67,80,80,77,80,24},34), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({41,67,76,254,73,67,67,78,67,80,254,81,82,77,78,78,67,66},34))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({44,46,33,81},34)) end)
if ok then return folder end
debug(_d({69,67,82,44,46,33,81,36,77,74,66,67,80,254,67,80,80,77,80,24},34), folder)
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
local r = model:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local h = model:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
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
debug(_d({69,67,82,44,67,63,80,67,81,82,44,46,33,254,67,80,80,77,80,24},34), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
local hum  = model:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({69,67,82,44,46,33,32,87,44,63,75,67,254,67,80,80,77,80,24},34), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({76,78,65,81,48,67,75,63,71,76,71,76,69,254,67,80,80,77,80,24},34), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({33,83,78,71,66,254,47,83,67,67,76},34))
return queen ~= nil and queen:FindFirstChild(_d({75,77,82,71,77,76,42,67,81,81},34)) ~= nil
end)
if ok then return result end
debug(_d({71,81,47,83,67,67,76,46,70,63,81,67,16,254,67,80,80,77,80,24},34), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,15,16,15,16,23,21,23,18,16,16,23,16,21,20,23},34)
local QUEEN_GRASP_ANIM_ID   = _d({80,64,86,63,81,81,67,82,71,66,24,13,13,15,16,23,22,14,14,14,20,15,14,14,15,21,17,18},34)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
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
debug(_d({71,81,46,74,63,87,71,76,69,31,76,71,75,36,80,77,75,42,71,81,82,254,67,80,80,77,80,24},34), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({32,74,77,65,73,71,76,69},34)) ~= nil
end)
if ok then return result end
debug(_d({71,81,44,46,33,32,74,77,65,73,71,76,69,254,67,80,80,77,80,24},34), result)
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
debug(_d({78,80,67,66,71,65,82,44,46,33,46,77,81,71,82,71,77,76,254,67,80,80,77,80,24},34), result)
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
debug(_d({44,77,254,66,63,75,63,69,67,254,77,76},34), model.Name, _d({68,77,80},34), NPC_STUCK_TIMEOUT, _d({81,254,11,254,81,85,71,82,65,70,71,76,69,254,82,63,80,69,67,82},34))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({82,80,63,65,73,44,46,33,34,63,75,63,69,67,254,67,80,80,77,80,24},34), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({43,77,66,67,74},34)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({32,63,81,67,46,63,80,82},34)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({69,67,82,43,77,66,67,74,36,63,65,67,46,77,81,254,67,80,80,77,80,24},34), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({35,76,84},34))
local folder = env and env:FindFirstChild(_d({49,82,63,82,83,67,81},34))
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
debug(_d({69,67,82,49,82,63,82,83,67,43,77,66,67,74,44,67,63,80,254,67,80,80,77,80,24},34), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({64,63,80,80,67,74,38,46},34))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({69,67,82,49,82,63,82,83,67,38,46,254,67,80,80,77,80,24},34), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({50,77,77,74},34)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({68,71,76,66,50,77,77,74,32,87,31,82,82,80,71,64,83,82,67,254,67,80,80,77,80,24},34), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({50,77,77,74},34)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({68,71,76,66,50,77,77,74,32,87,44,63,75,67,254,67,80,80,77,80,24},34), tool)
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
if not ok then debug(_d({67,79,83,71,78,50,77,77,74,254,67,80,80,77,80,24},34), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({32,63,65,73,78,63,65,73},34))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({50,77,77,74},34)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({68,71,76,66,50,77,77,74,32,87,33,70,71,74,66,44,63,75,67,254,67,80,80,77,80,24},34), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({49,85,77,80,66,35,79,83,71,78},34))
if sword then
equipTool(sword)
return _d({81,85,77,80,66},34)
end
local melee = findToolByAttribute(_d({43,67,74,67,67,50,77,77,74},34))
if melee then
equipTool(melee)
return _d({75,67,74,67,67},34)
end
debug(_d({44,77,254,81,85,77,80,66,254,77,80,254,75,67,74,67,67,254,82,77,77,74,254,68,77,83,76,66},34))
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
if not ok then debug(_d({65,74,71,65,73,43,15,254,67,80,80,77,80,24},34), err) end
end
local function invokeGeppo()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({48,77,73,83,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({37,67,78,78,77},34), args)
elseif style == _d({32,74,63,65,73,42,67,69},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73},34), args)
elseif style == _d({41,63,75,71,81,70,71,73,71},34) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({41,63,75,71,81,70,71,73,71,37,67,78,78,77},34), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({49,73,87,254,53,63,74,73,16},34), args)
end
end)
if not ok then debug(_d({71,76,84,77,73,67,37,67,78,78,77,254,67,80,80,77,80,24},34), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({78,80,67,81,81,49,73,71,74,74,48,254,67,80,80,77,80,24},34), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({70,77,74,66,32,74,77,65,73,254,67,80,80,77,80,24},34), err) end
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
if not ok then debug(_d({70,77,74,66,32,74,77,65,73,53,70,71,74,67,254,67,80,80,77,80,24},34), err) end
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
debug(_d({69,67,82,37,63,75,67,37,254,67,80,80,77,80,24},34), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({71,81,48,67,63,74,43,15,32,83,81,87,254,67,80,80,77,80,24},34), result)
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
return char ~= nil and char:FindFirstChild(_d({81,82,83,76},34)) ~= nil
end)
if ok then return result end
debug(_d({71,81,49,82,83,76,76,67,66,254,67,80,80,77,80,24},34), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({78,80,67,81,81,49,82,83,76,32,80,67,63,73,254,67,80,80,77,80,24},34), err) end
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
debug(_d({79,83,67,67,76,34,77,66,69,67,51,76,82,71,74,49,63,68,67,24,254,47,83,67,67,76,254,69,77,76,67,254,11,254,67,76,66,71,76,69,254,66,77,66,69,67,254,67,63,80,74,87},34))
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
debug(_d({79,83,67,67,76,34,77,66,69,67,51,76,82,71,74,49,63,68,67,254,81,63,68,67,82,87,254,82,71,75,67,77,83,82},34))
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
local info = getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({47,83,67,67,76,254,65,63,81,82,71,76,69,254,66,67,82,67,65,82,67,66,254,11,254,66,77,66,69,71,76,69,254,6,85,63,82,65,70,67,80,7},34))
queenDodgeUntilSafe(function() return getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34)) end)
if enabled and getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34)) then
setNavNamed(_d({33,83,78,71,66,254,47,83,67,67,76},34))
end
queenDodging = false
end
end)
if not ok then debug(_d({79,83,67,67,76,34,77,66,69,67,53,63,82,65,70,67,80,254,67,80,80,77,80,24},34), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({78,77,71,76,82},34) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({76,78,65},34) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({76,63,75,67,66},34) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({69,67,82,44,63,84,50,63,80,69,67,82,81,254,67,80,80,77,80,24},34), aimR)
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
debug(_d({65,77,75,78,83,82,67,42,77,65,73,67,66,33,36,80,63,75,67,254,67,80,80,77,80,24},34), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({78,77,71,76,82},34), point = pos}
phase = _d({75,77,84,67},34)
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
if not ok then debug(_d({76,63,84,50,77,46,77,71,76,82,254,69,67,78,78,77,254,65,70,67,65,73,254,67,80,80,77,80,24},34), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({76,78,65},34)}
phase = _d({75,77,84,67},34)
end
function setNavNamed(name)
NavState = {mode = _d({76,63,75,67,66},34), name = name}
phase = _d({75,77,84,67},34)
end
local function setNavIdle()
NavState = {mode = _d({71,66,74,67},34)}
phase = _d({75,77,84,67},34)
end
local function hasArrived()
return phase == _d({70,77,84,67,80},34)
end
local function startNav()
phase = _d({75,77,84,67},34)
debug(_d({44,63,84,254,74,77,77,78,254,45,44},34))
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
local prevPos = force:GetAttribute(_d({61,61,78,80,67,84,46,77,81},34))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({42,63,80,69,67,254,78,77,81,71,82,71,77,76,254,72,83,75,78,254,66,67,82,67,65,82,67,66,24},34), delta, _d({81,82,83,66,81,12,254,78,80,67,84,46,77,81,27},34), prevPos, _d({76,67,85,46,77,81,27},34), pos)
end
end
force:SetAttribute(_d({61,61,78,80,67,84,46,77,81},34), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({75,77,84,67},34) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({70,77,84,67,80},34)
debug(_d({46,70,63,81,67,24,254,70,77,84,67,80},34))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({255,255,255,254,48,35,36,51,49,39,44,37,254,50,45,254,31,46,46,42,55,254,31,32,44,45,48,43,31,42,254,52,35,42,45,33,39,50,55,24},34), finalVel, _d({63,71,75,27},34), aim, _d({78,77,81,27},34), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({70,77,84,67,80},34) then
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
debug(_d({33,77,75,64,63,82,254,74,77,65,73,254,81,73,71,78,78,67,66,10},34), snapDist, _d({81,82,83,66,81,254,68,80,77,75,254,82,63,80,69,67,82,254,192,94,114,254,68,63,74,74,71,76,69,254,64,63,65,73,254,82,77,254,75,77,84,67},34))
phase = _d({75,77,84,67},34)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({38,67,63,80,82,64,67,63,82,254,67,80,80,77,80,24},34), err) end
end)
end
local function stopNav()
debug(_d({44,63,84,254,74,77,77,78,254,45,36,36},34))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({75,77,84,67},34)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({50,67,86,82,33,70,63,82,49,67,80,84,71,65,67},34))
local channels = TextChatService:FindFirstChild(_d({50,67,86,82,33,70,63,76,76,67,74,81},34))
local channel = channels and channels:FindFirstChild(_d({48,32,54,37,67,76,67,80,63,74},34))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({34,67,68,63,83,74,82,33,70,63,82,49,87,81,82,67,75,33,70,63,82,35,84,67,76,82,81},34))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({49,63,87,43,67,81,81,63,69,67,48,67,79,83,67,81,82},34))
if sayEvent then
sayEvent:FireServer(message, _d({31,74,74},34))
return
end
debug(_d({81,67,76,66,33,70,63,82,43,67,81,81,63,69,67,24,254,76,77,254,50,67,86,82,33,70,63,82,49,67,80,84,71,65,67,12,48,32,54,37,67,76,67,80,63,74,254,77,80,254,74,67,69,63,65,87,254,49,63,87,43,67,81,81,63,69,67,48,67,79,83,67,81,82,254,68,77,83,76,66,254,68,77,80},34), message)
end)
if not ok then debug(_d({81,67,76,66,33,70,63,82,43,67,81,81,63,69,67,254,67,80,80,77,80,24},34), err) end
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
debug(_d({44,77,82,254,75,63,73,71,76,69,254,78,80,77,69,80,67,81,81,254,82,77,85,63,80,66,254,76,63,84,254,82,63,80,69,67,82,254,68,77,80},34), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({81,254,11,254,81,67,76,66,71,76,69,254,13,83,76,81,82,83,65,73},34))
sendChatMessage(_d({13,83,76,81,82,83,65,73},34))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({85,63,71,82,51,76,82,71,74,31,80,80,71,84,67,66,254,82,71,75,67,77,83,82},34))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({76,63,84,50,77,46,77,71,76,82,33,77,76,68,71,80,75,67,66,24},34), label or _d({82,63,80,69,67,82},34), _d({11,254,66,71,66,254,76,77,82,254,63,80,80,71,84,67,254,85,71,82,70,71,76},34), timeout, _d({81,10,254,80,67,82,80,87,71,76,69,254,77,76,65,67},34))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({76,63,84,50,77,46,77,71,76,82,33,77,76,68,71,80,75,67,66,24},34), label or _d({82,63,80,69,67,82},34), _d({11,254,81,82,71,74,74,254,76,77,82,254,63,80,80,71,84,67,66,254,63,68,82,67,80,254,80,67,82,80,87,10,254,78,80,77,65,67,67,66,71,76,69,254,63,76,87,85,63,87},34))
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
if not ok then debug(_d({76,63,84,50,77,46,77,71,76,82,38,77,74,66,71,76,69,32,74,77,65,73,254,73,67,87,11,66,77,85,76,254,67,80,80,77,80,24},34), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({76,63,84,50,77,46,77,71,76,82,38,77,74,66,71,76,69,32,74,77,65,73,254,73,67,87,11,83,78,254,67,80,80,77,80,24},34), err2) end
end
local function clearStage(stageName)
debug(_d({43,77,84,71,76,69,254,82,77},34), stageName)
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({53,63,71,82,71,76,69,254,68,77,80,254,44,46,33,81,254,82,77,254,81,78,63,85,76,254,63,82},34), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({254,254,81,78,63,85,76,254,65,70,67,65,73,24,254,68,77,74,66,67,80,254,67,86,71,81,82,81,254,27},34), folder ~= nil,
_d({10,254,65,70,71,74,66,80,67,76,254,27},34), folder and #folder:GetChildren() or 0,
_d({10,254,63,74,71,84,67,254,27},34), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({44,77,254,44,46,33,81,254,63,78,78,67,63,80,67,66,254,63,82},34), stageName, _d({63,68,82,67,80,254,15,19,81,10,254,75,77,84,71,76,69,254,77,76,254,63,76,87,85,63,87},34))
break
end
end
debug(_d({41,71,74,74,71,76,69,254,44,46,33,81,254,63,82},34), stageName)
equipSwordOrMelee()
setNavNPCNearest()
while enabled and npcsRemaining() > 0 do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(_d({48,67,82,83,80,76,71,76,69,254,82,77},34), stageName, _d({78,77,81,71,82,71,77,76,254,64,67,68,77,80,67,254,75,77,84,71,76,69,254,77,76},34))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({53,63,71,82,71,76,69,254,19,81,254,63,82},34), stageName, _d({78,77,81,71,82,71,77,76},34))
task.wait(5)
debug(stageName, _d({65,74,67,63,80,67,66},34))
end
local function killNamedNPC(name, targetPos)
debug(_d({43,77,84,71,76,69,254,82,77},34), name)
navToPoint(targetPos)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(name)
while enabled and getNPCByName(name) do
equipSwordOrMelee()
clickM1(0.05)
task.wait(MELEE_CLICK_INTERVAL)
end
debug(name, _d({66,67,68,67,63,82,67,66},34))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({38,83,75,63,76,77,71,66},34))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({42,67,77,254,78,74,63,87,67,66,254,63,76,71,75,63,82,71,77,76,24},34), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({74,67,77,31,76,71,75,42,77,69,69,67,80,254,78,80,71,76,82,254,67,80,80,77,80,24},34), err2) end
end)
end)
if not ok then debug(_d({81,82,63,80,82,42,67,77,31,76,71,75,42,77,69,69,67,80,254,67,80,80,77,80,24},34), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({43,77,84,71,76,69,254,82,77,254,42,67,77,254,6,64,74,77,65,73,71,76,69,254,63,68,82,67,80},34), LEO_BLOCK_DELAY, _d({81,7},34))
navToPointHoldingBlock(COORDS.Leo, 30, LEO_BLOCK_DELAY)
local leoModel = getNPCByName(_d({42,67,77},34))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({42,67,77},34))
while enabled do
local info = getNPCByName(_d({42,67,77},34))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({42,67,77,254,65,63,81,82,71,76,69},34), which, _d({11,254,66,77,66,69,71,76,69},34))
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
if not getNPCByName(_d({42,67,77},34)) then
debug(_d({42,67,77,254,69,77,76,67,254,75,71,66,11,66,77,66,69,67,254,11,254,67,76,66,71,76,69,254,35,76,82,67,71,254,70,77,74,66,254,67,63,80,74,87},34))
break
end
invokeGeppo()
end
else
task.wait(GEPPO_HOLD_INTERVAL)
if getNPCByName(_d({42,67,77},34)) then
invokeGeppo()
task.wait(GEPPO_HOLD_INTERVAL)
else
debug(_d({42,67,77,254,69,77,76,67,254,75,71,66,11,66,77,66,69,67,254,11,254,67,76,66,71,76,69,254,36,74,63,75,67,254,46,71,74,74,63,80,254,70,77,74,66,254,67,63,80,74,87},34))
end
end
end
if enabled and getNPCByName(_d({42,67,77},34)) then
setNavNamed(_d({42,67,77},34))
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
debug(_d({42,67,77,254,66,67,68,67,63,82,67,66},34))
stopLeoAnimLogger()
debug(_d({48,67,82,83,80,76,71,76,69,254,82,77,254,42,67,77,254,78,77,81,71,82,71,77,76,254,64,67,68,77,80,67,254,75,77,84,71,76,69,254,77,76},34))
navToPointConfirmed(COORDS.Leo, 30, _d({42,67,77,254,78,77,81,71,82,71,77,76},34))
debug(_d({53,63,71,82,71,76,69,254,19,81,254,63,82,254,42,67,77,254,78,77,81,71,82,71,77,76},34))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({43,77,84,71,76,69,254,82,77},34), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({33,77,83,74,66,254,76,77,82,254,68,71,76,66,254,81,82,63,82,83,67,254,75,77,66,67,74,254,76,67,63,80},34), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({31,82,82,63,65,73,71,76,69},34), coordKey, _d({85,71,82,70},34), weapon or _d({76,77,82,70,71,76,69,254,68,77,83,76,66},34))
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
debug(coordKey, _d({64,63,80,80,67,74,254,66,67,81,82,80,77,87,67,66},34))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({80,67,65,70,67,65,73,49,82,63,82,83,67,24},34), coordKey, _d({11,254,65,77,83,74,66,254,76,77,82,254,68,71,76,66,254,81,82,63,82,83,67,254,75,77,66,67,74,10,254,81,73,71,78,78,71,76,69},34))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({80,67,65,70,67,65,73,49,82,63,82,83,67,24},34), coordKey, _d({81,82,71,74,74,254,63,74,71,84,67,254,6,38,46},34), hp, _d({7,254,11,254,80,67,11,66,67,81,82,80,77,87,71,76,69},34))
destroyStatue(coordKey)
else
debug(_d({80,67,65,70,67,65,73,49,82,63,82,83,67,24},34), coordKey, _d({65,77,76,68,71,80,75,67,66,254,66,67,81,82,80,77,87,67,66},34))
end
end)
if not ok then debug(_d({80,67,65,70,67,65,73,49,82,63,82,83,67,254,67,80,80,77,80,24},34), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({43,77,84,71,76,69,254,82,77,254,47,83,67,67,76},34))
navToPoint(COORDS.Queen)
waitUntilArrived(30)
equipSwordOrMelee()
setNavNamed(_d({33,83,78,71,66,254,47,83,67,67,76},34))
startQueenDodgeWatcher()
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({47,83,67,67,76,254,67,76,82,67,80,67,66,254,78,70,63,81,67,254,16},34))
end
local function finishQueen()
debug(_d({36,71,76,71,81,70,71,76,69,254,47,83,67,67,76},34))
equipSwordOrMelee()
setNavNamed(_d({33,83,78,71,66,254,47,83,67,67,76},34))
startQueenDodgeWatcher()
while enabled and getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({33,83,78,71,66,254,47,83,67,67,76},34))
equipSwordOrMelee()
if info and isNPCBlocking(info.model) then
pressSkillR()
else
clickM1(0.05)
end
task.wait(MELEE_CLICK_INTERVAL)
end
end
debug(_d({47,83,67,67,76,254,66,67,68,67,63,82,67,66,12,254,46,74,63,76,254,65,77,75,78,74,67,82,67,12},34))
end
local CONFIRMATION_PROMPT_NAME = _d({33,77,76,68,71,80,75,63,82,71,77,76,46,80,77,75,78,82},34)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({48,67,75,77,82,67,35,84,67,76,82},34), 5)
end)
if ok then return result end
debug(_d({69,67,82,48,67,78,74,63,87,48,67,75,77,82,67,254,67,80,80,77,80,24},34), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({46,74,63,87,67,80,37,83,71},34))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({39,75,63,69,67,32,83,82,82,77,76},34)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({64,83,82,82,77,76,52,63,74,83,67},34)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({68,71,76,66,32,83,82,82,77,76,32,87,52,63,74,83,67,254,67,80,80,77,80,24},34), result)
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
if not ok then debug(_d({65,74,71,65,73,37,83,71,32,83,82,82,77,76,254,67,80,80,77,80,24},34), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({71,81,49,67,80,84,67,80},34))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({48,67,75,77,82,67,35,84,67,76,82},34))
or inst:FindFirstChild(_d({65,74,71,67,76,82,35,84,67,76,82},34))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({68,71,76,66,31,76,81,85,67,80,33,77,76,76,67,65,82,77,80,254,67,80,80,77,80,24},34), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({33,77,83,74,66,254,76,77,82,254,74,77,65,63,82,67,254,48,67,75,77,82,67,35,84,67,76,82,13,65,74,71,67,76,82,35,84,67,76,82,254,76,67,63,80,254,48,67,78,74,63,87,254,64,83,82,82,77,76,10,254,68,63,74,74,71,76,69,254,64,63,65,73,254,82,77,254,65,74,71,65,73},34))
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
debug(_d({68,71,80,67,48,67,78,74,63,87,52,63,74,83,67,254,67,80,80,77,80,24},34), err, _d({11,254,68,63,74,74,71,76,69,254,64,63,65,73,254,82,77,254,65,74,71,65,73},34))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({36,63,74,74,71,76,69,254,64,63,65,73,254,82,77,254,64,83,82,82,77,76,52,63,74,83,67,254,81,67,63,80,65,70,254,68,77,80,254,48,67,78,74,63,87},34))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({48,67,78,74,63,87,254,64,83,82,82,77,76,254,76,77,82,254,68,77,83,76,66,254,67,71,82,70,67,80,10,254,69,71,84,71,76,69,254,83,78},34))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({53,63,71,82,71,76,69,254,68,77,80,254,33,77,76,68,71,80,75,63,82,71,77,76,46,80,77,75,78,82,12,48,67,75,77,82,67,35,84,67,76,82},34))
local remote = getReplayRemote()
if not remote then
debug(_d({33,77,76,68,71,80,75,63,82,71,77,76,46,80,77,75,78,82,13,48,67,75,77,82,67,35,84,67,76,82,254,76,77,82,254,68,77,83,76,66,254,85,71,82,70,71,76,254,82,71,75,67,77,83,82},34))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({36,71,80,71,76,69,254,48,67,78,74,63,87,254,84,71,63,254,33,77,76,68,71,80,75,63,82,71,77,76,46,80,77,75,78,82,12,48,67,75,77,82,67,35,84,67,76,82},34))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({36,71,80,67,49,67,80,84,67,80,254,67,80,80,77,80,24},34), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({46,74,63,87,67,80,37,83,71},34), 10)
if not playerGui then
debug(_d({85,63,71,82,36,77,80,45,64,72,67,65,82,71,84,67,81,37,83,71,24,254,76,77,254,46,74,63,87,67,80,37,83,71,254,85,71,82,70,71,76,254,82,71,75,67,77,83,82,10,254,78,80,77,65,67,67,66,71,76,69,254,63,76,87,85,63,87},34))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({45,64,72,67,65,82,71,84,67,81,254,37,51,39,254,68,77,83,76,66,254,11,254,81,82,63,69,67,254,74,77,63,66,67,66},34))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({45,64,72,67,65,82,71,84,67,81,254,37,51,39,254,76,77,82,254,68,77,83,76,66,254,85,71,82,70,71,76,254,82,71,75,67,77,83,82,10,254,78,80,77,65,67,67,66,71,76,69,254,63,76,87,85,63,87},34))
return
end
end
end)
if not ok then debug(_d({85,63,71,82,36,77,80,45,64,72,67,65,82,71,84,67,81,37,83,71,254,67,80,80,77,80,24},34), err) end
end
local function runPlan()
debug(_d({46,74,63,76,254,81,82,63,80,82,67,66},34))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({49,82,63,80,82,71,76,69,254,76,63,84,254,74,77,77,78},34))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = getRoot()
debug(_d({78,77,81,254,14,12,16,81,254,31,36,50,35,48,254,81,82,63,80,82,44,63,84,24},34), rootAfter and rootAfter.Position)
end)
debug(_d({53,63,71,82,71,76,69,254,19,81,254,64,67,68,77,80,67,254,75,77,84,71,76,69,254,82,77,254,49,82,63,69,67,15},34))
task.wait(5)
for _, stage in ipairs({_d({49,82,63,69,67,15},34), _d({49,82,63,69,67,16},34), _d({49,82,63,69,67,17},34), _d({49,82,63,69,67,17,32},34)}) do
if not enabled then return end
clearStage(stage)
end
if not enabled then return end
debug(_d({43,77,84,71,76,69,254,82,77,254,63,80,80,77,85,254,68,74,87,11,66,77,85,76,254,63,80,67,63},34))
local arrowBase   = COORDS.ArrowFlyDown + Vector3.new(0, ARROW_HOVER_OFFSET, 0)
local arrowAhead  = arrowBase + Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
local arrowBehind = arrowBase - Vector3.new(0, 0, ARROW_DODGE_DISTANCE)
navToPoint(arrowBase)
waitUntilArrived(30)
debug(_d({34,77,66,69,71,76,69,254,63,80,80,77,85,254,80,63,71,76},34))
local elapsed = 0
local aheadNext = true
while enabled and elapsed < ARROW_HOVER_WAIT do
setNavPoint(aheadNext and arrowAhead or arrowBehind)
aheadNext = not aheadNext
task.wait(ARROW_DODGE_INTERVAL)
elapsed += ARROW_DODGE_INTERVAL
end
if not enabled then return end
clearStage(_d({49,82,63,69,67,18},34))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({47,83,67,67,76,254,71,76,254,78,70,63,81,67,254,16,254,11,254,73,67,67,78,71,76,69,254,41,67,76,254,38,63,73,71,254,63,65,82,71,84,67,254,68,80,77,75,254,70,67,80,67,254,77,76},34))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({49,82,63,82,83,67,15},34))
if not enabled then return end
recheckStatue(_d({49,82,63,82,83,67,15},34))
destroyStatue(_d({49,82,63,82,83,67,16},34))
if not enabled then return end
recheckStatue(_d({49,82,63,82,83,67,15},34))
recheckStatue(_d({49,82,63,82,83,67,16},34))
destroyStatue(_d({49,82,63,82,83,67,17},34))
if not enabled then return end
recheckStatue(_d({49,82,63,82,83,67,17},34))
recheckStatue(_d({49,82,63,82,83,67,16},34))
recheckStatue(_d({49,82,63,82,83,67,15},34))
if not enabled then return end
debug(_d({53,63,71,82,71,76,69,254,68,77,80,254,78,70,63,81,67,254,16,254,82,77,254,67,76,66},34))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({46,70,63,81,67,254,16,254,67,76,66,254,85,63,71,82,254,82,71,75,67,77,83,82,10,254,78,80,77,65,67,67,66,71,76,69,254,63,76,87,85,63,87},34))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({43,77,84,71,76,69,254,64,63,65,73,254,82,77,254,47,83,67,67,76,254,81,82,63,69,67,254,78,77,81,71,82,71,77,76},34))
navToPointConfirmed(COORDS.Queen, 30, _d({47,83,67,67,76,254,81,82,63,69,67,254,78,77,81,71,82,71,77,76},34))
debug(_d({53,63,71,82,71,76,69,254,19,81,254,63,82,254,47,83,67,67,76,254,81,82,63,69,67,254,78,77,81,71,82,71,77,76},34))
task.wait(5)
if not enabled then return end
debug(_d({43,77,84,71,76,69,254,82,77,254,78,77,81,82,11,47,83,67,67,76,254,78,77,81,71,82,71,77,76},34))
navToPointConfirmed(COORDS.PostQueen, 30, _d({78,77,81,82,11,47,83,67,67,76,254,78,77,81,71,82,71,77,76},34))
if not enabled then return end
handleReplayPrompt()
enabled = false
stopNav()
end
local function enableBot()
if enabled then return end
enabled = true
local rootBefore = getRoot()
debug(_d({35,76,63,64,74,71,76,69,10,254,78,77,81,254,32,35,36,45,48,35,254,78,74,63,76,24},34), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({46,74,63,76,254,67,80,80,77,80,24},34), err2) end
end)
debug(_d({35,76,63,64,74,67,66,24},34), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({35,76,63,64,74,67,66,24},34), enabled)
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
if not ok then debug(_d({39,76,78,83,82,32,67,69,63,76,254,67,80,80,77,80,24},34), err) end
end)
task.spawn(function()
local ok, err = pcall(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
debug(_d({37,63,75,67,254,74,77,63,66,67,66,10,254,63,83,82,77,11,81,82,63,80,82,71,76,69,254,82,70,67,254,78,74,63,76},34))
enableBot()
end)
if not ok then debug(_d({31,83,82,77,81,82,63,80,82,254,67,80,80,77,80,24},34), err) end
end)
debug(_d({42,77,63,66,67,66,254,192,94,114,254,63,83,82,77,11,81,82,63,80,82,71,76,69,254,77,76,65,67,254,82,70,67,254,69,63,75,67,254,68,71,76,71,81,70,67,81,254,74,77,63,66,71,76,69,254,6,78,80,67,81,81,254,46,254,82,77,254,82,77,69,69,74,67,254,75,63,76,83,63,74,74,87,7},34))
end)()