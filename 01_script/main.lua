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
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
(function()
local Players            = game:GetService(_d({44,72,61,85,65,78,79},36))
local UserInputService    = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local RunService          = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM                 = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local ReplicatedStorage    = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local Workspace            = workspace
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({44,65,72,69},36))
if not (peliValueObj and peliValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
peliValueObj = nested and nested:FindFirstChild(_d({44,65,72,69},36))
end
levelValueObj = statsFolder:FindFirstChild(_d({40,65,82,65,72},36))
if not (levelValueObj and levelValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
levelValueObj = nested and nested:FindFirstChild(_d({40,65,82,65,72},36))
end
staminaValueObj = statsFolder:FindFirstChild(_d({47,80,61,73,69,74,61},36))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({57,252,47,80,61,74,64,61,72,75,74,65,252,41,75,64,65,22,252,44,78,65,79,79,252,3},36) .. toggleKey.Name .. _d({3,252,80,75,252,80,75,67,67,72,65,10},36))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
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
local LEO_PILLAR_ANIM_ID   = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,16,16,13,16,13,15,14,19},36)
local LEO_ENTEI_ANIM_ID    = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,16,16,13,15,20,14,19,20},36)
local LEO_HIKEN_ANIM_ID    = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,14,12,21,13,19,16,12,19},36)
local LEO_FIREFLY_ANIM_ID  = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,17,14,14,12,14,15,18,13,17,16},36)
local LEO_DODGE_ANIMS      = {LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID}
local LEO_DODGE_DISTANCE   = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY          = 4
local BLOCK_KEY                = Enum.KeyCode.F
local LOAD_WAIT             = 15
local OBJECTIVES_GUI_NAME   = _d({43,62,70,65,63,80,69,82,65,79},36)
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
local REPLAY_BUTTON_VALUE   = _d({46,65,76,72,61,85},36)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE   = 1
local enabled    = false
local navConn    = nil
local phase      = _d({73,75,82,65},36)
local NavState   = {mode = _d({69,64,72,65},36)}
local lastAim    = nil
local lastFace   = nil
local function debug(...)
print(_d({55,30,75,79,79,30,75,80,57},36), ...)
end
local function Core.GetRoot(LocalPlayer)
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end)
if ok then return root end
debug(_d({67,65,80,46,75,75,80,252,65,78,78,75,78,22},36), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end)
if ok then return hum end
debug(_d({67,65,80,36,81,73,61,74,75,69,64,252,65,78,78,75,78,22},36), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({59,59,36,75,82,65,78,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,36,75,82,65,78,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,36,75,82,65,78,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,36,75,82,65,78,34,75,78,63,65},36)
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
debug(_d({67,65,80,43,78,31,78,65,61,80,65,34,75,78,63,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then return end
local root = char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local force = root:FindFirstChild(_d({59,59,36,75,82,65,78,34,75,78,63,65},36))
local att   = root:FindFirstChild(_d({59,59,36,75,82,65,78,29,80,80},36))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
if not ok then debug(_d({63,72,65,61,74,81,76,34,75,78,63,65,252,65,78,78,75,78,22},36), err) end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({30,81,79,75,41,65,72,65,65},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,30,81,79,75,29,63,80,69,82,65,252,65,78,78,75,78,22},36), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({30,81,79,75},36))
end)
if not ok then debug(_d({61,63,80,69,82,61,80,65,30,81,79,75,252,65,78,78,75,78,22},36), err) end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({30,81,79,75,252,74,75,80,252,61,63,80,69,82,65,8,252,61,63,80,69,82,61,80,69,74,67},36))
activateBuso()
end
end)
if not ok then debug(_d({30,81,79,75,39,65,65,76,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({30,81,79,75,252,71,65,65,76,65,78,252,79,80,75,76,76,65,64},36))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({39,65,74,36,61,71,69},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,39,65,74,29,63,80,69,82,65,252,65,78,78,75,78,22},36), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({39,65,74},36), true)
end)
if not ok then debug(_d({61,63,80,69,82,61,80,65,39,65,74,252,65,78,78,75,78,22},36), err) end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then return end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({39,65,74,252,74,75,80,252,61,63,80,69,82,65,8,252,61,63,80,69,82,61,80,69,74,67},36))
activateKen()
end
end)
if not ok then debug(_d({39,65,74,39,65,65,76,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({39,65,74,252,71,65,65,76,65,78,252,79,80,75,76,76,65,64},36))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function() return Workspace:FindFirstChild(_d({42,44,31,79},36)) end)
if ok then return folder end
debug(_d({67,65,80,42,44,31,79,34,75,72,64,65,78,252,65,78,78,75,78,22},36), folder)
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
local r = model:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local h = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
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
debug(_d({67,65,80,42,65,61,78,65,79,80,42,44,31,252,65,78,78,75,78,22},36), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then return nil end
local model = folder:FindFirstChild(name)
if not model then return nil end
local root = model:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum  = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if root and hum and hum.Health > 0 then
return {root = root, humanoid = hum, model = model}
end
return nil
end)
if ok then return result end
debug(_d({67,65,80,42,44,31,30,85,42,61,73,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then return 0 end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if hum and hum.Health > 0 then n += 1 end
end
return n
end)
if ok then return count end
debug(_d({74,76,63,79,46,65,73,61,69,74,69,74,67,252,65,78,78,75,78,22},36), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({31,81,76,69,64,252,45,81,65,65,74},36))
return queen ~= nil and queen:FindFirstChild(_d({73,75,80,69,75,74,40,65,79,79},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,45,81,65,65,74,44,68,61,79,65,14,252,65,78,78,75,78,22},36), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,13,14,13,14,21,19,21,16,14,14,21,14,19,18,21},36)
local QUEEN_GRASP_ANIM_ID   = _d({78,62,84,61,79,79,65,80,69,64,22,11,11,13,14,21,20,12,12,12,18,13,12,12,13,19,15,16},36)
local QUEEN_BLOCK_ANIMS     = {QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID}
local QUEEN_BLOCK_TIMEOUT   = 3
local QUEEN_DODGE_DISTANCE  = 70
local QUEEN_DODGE_DURATION  = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then return false end
local hum = npcModel:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
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
debug(_d({69,79,44,72,61,85,69,74,67,29,74,69,73,34,78,75,73,40,69,79,80,252,65,78,78,75,78,22},36), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({30,72,75,63,71,69,74,67},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,42,44,31,30,72,75,63,71,69,74,67,252,65,78,78,75,78,22},36), result)
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
debug(_d({76,78,65,64,69,63,80,42,44,31,44,75,79,69,80,69,75,74,252,65,78,78,75,78,22},36), result)
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
debug(_d({42,75,252,64,61,73,61,67,65,252,75,74},36), model.Name, _d({66,75,78},36), NPC_STUCK_TIMEOUT, _d({79,252,9,252,79,83,69,80,63,68,69,74,67,252,80,61,78,67,65,80},36))
stuckNPCs[model] = true
end
end)
if not ok then debug(_d({80,78,61,63,71,42,44,31,32,61,73,61,67,65,252,65,78,78,75,78,22},36), err) end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({41,75,64,65,72},36)) then
if model.PrimaryPart then return model.PrimaryPart.Position end
return model:GetPivot().Position
elseif model:IsA(_d({30,61,79,65,44,61,78,80},36)) then
return model.Position
end
return nil
end)
if ok then return pos end
debug(_d({67,65,80,41,75,64,65,72,34,61,63,65,44,75,79,252,65,78,78,75,78,22},36), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({33,74,82},36))
local folder = env and env:FindFirstChild(_d({47,80,61,80,81,65,79},36))
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
debug(_d({67,65,80,47,80,61,80,81,65,41,75,64,65,72,42,65,61,78,252,65,78,78,75,78,22},36), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({62,61,78,78,65,72,36,44},36))
return v and v.Value or 0
end)
if ok then return hp end
debug(_d({67,65,80,47,80,61,80,81,65,36,44,252,65,78,78,75,78,22},36), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({48,75,75,72},36)) then
local ok2, val = pcall(function() return item:GetAttribute(attrName) end)
if ok2 and val == true then return item end
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,29,80,80,78,69,62,81,80,65,252,65,78,78,75,78,22},36), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({48,75,75,72},36)) then return t end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,42,61,73,65,252,65,78,78,75,78,22},36), tool)
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
if not ok then debug(_d({65,77,81,69,76,48,75,75,72,252,65,78,78,75,78,22},36), err) end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp   = Players.LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
for _, pool in ipairs({char, bp}) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({48,75,75,72},36)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then return tool end
debug(_d({66,69,74,64,48,75,75,72,30,85,31,68,69,72,64,42,61,73,65,252,65,78,78,75,78,22},36), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({47,83,75,78,64,33,77,81,69,76},36))
if sword then
equipTool(sword)
return _d({79,83,75,78,64},36)
end
local melee = findToolByAttribute(_d({41,65,72,65,65,48,75,75,72},36))
if melee then
equipTool(melee)
return _d({73,65,72,65,65},36)
end
debug(_d({42,75,252,79,83,75,78,64,252,75,78,252,73,65,72,65,65,252,80,75,75,72,252,66,75,81,74,64},36))
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
if not ok then debug(_d({63,72,69,63,71,41,13,252,65,78,78,75,78,22},36), err) end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. Players.LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
end
end)
if not ok then debug(_d({69,74,82,75,71,65,35,65,76,76,75,252,65,78,78,75,78,22},36), err) end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then debug(_d({76,78,65,79,79,47,71,69,72,72,46,252,65,78,78,75,78,22},36), err) end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then debug(_d({68,75,72,64,30,72,75,63,71,252,65,78,78,75,78,22},36), err) end
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
if not ok then debug(_d({68,75,72,64,30,72,75,63,71,51,68,69,72,65,252,65,78,78,75,78,22},36), err) end
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
debug(_d({67,65,80,35,61,73,65,35,252,65,78,78,75,78,22},36), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then return result end
debug(_d({69,79,46,65,61,72,41,13,30,81,79,85,252,65,78,78,75,78,22},36), result)
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
return char ~= nil and char:FindFirstChild(_d({79,80,81,74},36)) ~= nil
end)
if ok then return result end
debug(_d({69,79,47,80,81,74,74,65,64,252,65,78,78,75,78,22},36), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then debug(_d({76,78,65,79,79,47,80,81,74,30,78,65,61,71,252,65,78,78,75,78,22},36), err) end
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
debug(_d({77,81,65,65,74,32,75,64,67,65,49,74,80,69,72,47,61,66,65,22,252,45,81,65,65,74,252,67,75,74,65,252,9,252,65,74,64,69,74,67,252,64,75,64,67,65,252,65,61,78,72,85},36))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({77,81,65,65,74,32,75,64,67,65,49,74,80,69,72,47,61,66,65,252,79,61,66,65,80,85,252,80,69,73,65,75,81,80},36))
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
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
if not info then return end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({45,81,65,65,74,252,63,61,79,80,69,74,67,252,64,65,80,65,63,80,65,64,252,9,252,64,75,64,67,69,74,67,252,4,83,61,80,63,68,65,78,5},36))
queenDodgeUntilSafe(function() return getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) end)
if enabled and getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) then
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
end
queenDodging = false
end
end)
if not ok then debug(_d({77,81,65,65,74,32,75,64,67,65,51,61,80,63,68,65,78,252,65,78,78,75,78,22},36), err) end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({76,75,69,74,80},36) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({74,76,63},36) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({74,61,73,65,64},36) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then return aimR, faceR end
debug(_d({67,65,80,42,61,82,48,61,78,67,65,80,79,252,65,78,78,75,78,22},36), aimR)
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
debug(_d({63,75,73,76,81,80,65,40,75,63,71,65,64,31,34,78,61,73,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function setNavPoint(pos)
NavState = {mode = _d({76,75,69,74,80},36), point = pos}
phase = _d({73,75,82,65},36)
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
if not ok then debug(_d({74,61,82,48,75,44,75,69,74,80,252,67,65,76,76,75,252,63,68,65,63,71,252,65,78,78,75,78,22},36), err) end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = {mode = _d({74,76,63},36)}
phase = _d({73,75,82,65},36)
end
function setNavNamed(name)
NavState = {mode = _d({74,61,73,65,64},36), name = name}
phase = _d({73,75,82,65},36)
end
local function setNavIdle()
NavState = {mode = _d({69,64,72,65},36)}
phase = _d({73,75,82,65},36)
end
local function hasArrived()
return phase == _d({68,75,82,65,78},36)
end
local function startNav()
phase = _d({73,75,82,65},36)
debug(_d({42,61,82,252,72,75,75,76,252,43,42},36))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({44,72,61,85,65,78,252,64,69,65,64,253,252,47,80,75,76,76,69,74,67,252,62,75,80,10},36))
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
debug(_d({44,72,61,85,65,78,252,69,79,252,80,75,75,252,66,61,78,252,66,78,75,73,252,80,61,78,67,65,80,252,4,26,14,12,12,12,252,79,80,81,64,79,5,10,252,40,69,71,65,72,85,252,78,65,79,76,61,83,74,65,64,252,61,80,252,72,75,62,62,85,10,252,47,80,75,76,76,69,74,67,252,62,75,80,10},36))
disableBot()
return
end
local xzDir  = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel  = xzDir.Magnitude > 0
and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then return end
local prevPos = force:GetAttribute(_d({59,59,76,78,65,82,44,75,79},36))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({40,61,78,67,65,252,76,75,79,69,80,69,75,74,252,70,81,73,76,252,64,65,80,65,63,80,65,64,22},36), delta, _d({79,80,81,64,79,10,252,76,78,65,82,44,75,79,25},36), prevPos, _d({74,65,83,44,75,79,25},36), pos)
end
end
force:SetAttribute(_d({59,59,76,78,65,82,44,75,79},36), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({73,75,82,65},36) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({68,75,82,65,78},36)
debug(_d({44,68,61,79,65,22,252,68,75,82,65,78},36))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({253,253,253,252,46,33,34,49,47,37,42,35,252,48,43,252,29,44,44,40,53,252,29,30,42,43,46,41,29,40,252,50,33,40,43,31,37,48,53,22},36), finalVel, _d({61,69,73,25},36), aim, _d({76,75,79,25},36), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({68,75,82,65,78},36) then
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
debug(_d({31,75,73,62,61,80,252,72,75,63,71,252,79,71,69,76,76,65,64,8},36), snapDist, _d({79,80,81,64,79,252,66,78,75,73,252,80,61,78,67,65,80,252,190,92,112,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,73,75,82,65},36))
phase = _d({73,75,82,65},36)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then debug(_d({36,65,61,78,80,62,65,61,80,252,65,78,78,75,78,22},36), err) end
end)
end
local function stopNav()
debug(_d({42,61,82,252,72,75,75,76,252,43,34,34},36))
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
phase = _d({73,75,82,65},36)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({48,65,84,80,31,68,61,80,47,65,78,82,69,63,65},36))
local channels = TextChatService:FindFirstChild(_d({48,65,84,80,31,68,61,74,74,65,72,79},36))
local channel = channels and channels:FindFirstChild(_d({46,30,52,35,65,74,65,78,61,72},36))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({32,65,66,61,81,72,80,31,68,61,80,47,85,79,80,65,73,31,68,61,80,33,82,65,74,80,79},36))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({47,61,85,41,65,79,79,61,67,65,46,65,77,81,65,79,80},36))
if sayEvent then
sayEvent:FireServer(message, _d({29,72,72},36))
return
end
debug(_d({79,65,74,64,31,68,61,80,41,65,79,79,61,67,65,22,252,74,75,252,48,65,84,80,31,68,61,80,47,65,78,82,69,63,65,10,46,30,52,35,65,74,65,78,61,72,252,75,78,252,72,65,67,61,63,85,252,47,61,85,41,65,79,79,61,67,65,46,65,77,81,65,79,80,252,66,75,81,74,64,252,66,75,78},36), message)
end)
if not ok then debug(_d({79,65,74,64,31,68,61,80,41,65,79,79,61,67,65,252,65,78,78,75,78,22},36), err) end
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
debug(_d({42,75,80,252,73,61,71,69,74,67,252,76,78,75,67,78,65,79,79,252,80,75,83,61,78,64,252,74,61,82,252,80,61,78,67,65,80,252,66,75,78},36), stuckTicks * UNSTUCK_CHECK_INTERVAL, _d({79,252,9,252,79,65,74,64,69,74,67,252,11,81,74,79,80,81,63,71},36))
sendChatMessage(_d({11,81,74,79,80,81,63,71},36))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({83,61,69,80,49,74,80,69,72,29,78,78,69,82,65,64,252,80,69,73,65,75,81,80},36))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({74,61,82,48,75,44,75,69,74,80,31,75,74,66,69,78,73,65,64,22},36), label or _d({80,61,78,67,65,80},36), _d({9,252,64,69,64,252,74,75,80,252,61,78,78,69,82,65,252,83,69,80,68,69,74},36), timeout, _d({79,8,252,78,65,80,78,85,69,74,67,252,75,74,63,65},36))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({74,61,82,48,75,44,75,69,74,80,31,75,74,66,69,78,73,65,64,22},36), label or _d({80,61,78,67,65,80},36), _d({9,252,79,80,69,72,72,252,74,75,80,252,61,78,78,69,82,65,64,252,61,66,80,65,78,252,78,65,80,78,85,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
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
if not ok then debug(_d({74,61,82,48,75,44,75,69,74,80,36,75,72,64,69,74,67,30,72,75,63,71,252,71,65,85,9,64,75,83,74,252,65,78,78,75,78,22},36), err) end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then debug(_d({74,61,82,48,75,44,75,69,74,80,36,75,72,64,69,74,67,30,72,75,63,71,252,71,65,85,9,81,76,252,65,78,78,75,78,22},36), err2) end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({51,61,72,71,69,74,67,252,80,75,22},36), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then stopNav() end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({83,61,72,71,48,75,44,75,69,74,80,252,51,252,64,75,83,74,252,65,78,78,75,78,22},36), err) end
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
debug(_d({48,75,75,71,252,64,61,73,61,67,65,252,83,68,69,72,65,252,83,61,72,71,69,74,67,252,80,75,252,76,75,69,74,80,253,252,47,80,75,76,76,69,74,67,252,83,61,72,71,252,80,75,252,65,74,67,61,67,65,10},36))
break
end
if currentHum then startHP = currentHum.Health end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({29,78,78,69,82,65,64,252,61,80,22},36), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({47,80,81,63,71,252,64,81,78,69,74,67,252,83,61,72,71,8,252,70,81,73,76,69,74,67,253},36))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({47,80,69,72,72,252,79,80,81,63,71,8,252,80,78,69,67,67,65,78,69,74,67,252,35,65,76,76,75,253},36))
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
debug(_d({41,75,82,69,74,67,252,80,75},36), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,42,44,31,79,252,80,75,252,79,76,61,83,74,252,61,80},36), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(_d({252,252,79,76,61,83,74,252,63,68,65,63,71,22,252,66,75,72,64,65,78,252,65,84,69,79,80,79,252,25},36), folder ~= nil,
_d({8,252,63,68,69,72,64,78,65,74,252,25},36), folder and #folder:GetChildren() or 0,
_d({8,252,61,72,69,82,65,252,25},36), npcsRemaining())
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({42,75,252,42,44,31,79,252,61,76,76,65,61,78,65,64,252,61,80},36), stageName, _d({61,66,80,65,78,252,13,17,79,8,252,73,75,82,69,74,67,252,75,74,252,61,74,85,83,61,85},36))
break
end
end
debug(_d({39,69,72,72,69,74,67,252,42,44,31,79,252,61,80},36), stageName)
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
debug(_d({46,65,80,81,78,74,69,74,67,252,80,75},36), stageName, _d({76,75,79,69,80,69,75,74,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,75,74},36))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80},36), stageName, _d({76,75,79,69,80,69,75,74},36))
task.wait(5)
debug(_d({51,61,69,80,69,74,67,252,66,75,78},36), targetHP * 100, _d({1,252,36,44,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,80,75,252,74,65,84,80,252,79,80,61,67,65},36))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({63,72,65,61,78,65,64},36))
end
local function killNamedNPC(name, targetPos)
debug(_d({41,75,82,69,74,67,252,80,75},36), name)
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
debug(name, _d({64,65,66,65,61,80,65,64},36))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if not hum then return end
if leoAnimLoggerConn then leoAnimLoggerConn:Disconnect() end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(_d({40,65,75,252,76,72,61,85,65,64,252,61,74,69,73,61,80,69,75,74,22},36), track.Animation and track.Animation.Name, "-", track.Animation and track.Animation.AnimationId)
end)
if not ok2 then debug(_d({72,65,75,29,74,69,73,40,75,67,67,65,78,252,76,78,69,74,80,252,65,78,78,75,78,22},36), err2) end
end)
end)
if not ok then debug(_d({79,80,61,78,80,40,65,75,29,74,69,73,40,75,67,67,65,78,252,65,78,78,75,78,22},36), err) end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({41,75,82,69,74,67,252,80,75,252,40,65,75},36))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({40,65,75},36))
if leoModel then startLeoAnimLogger(leoModel.model) end
equipSwordOrMelee()
setNavNamed(_d({40,65,75},36))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({40,65,75},36))
if not info then break end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({40,65,75,252,63,61,79,80,69,74,67},36), which, _d({9,252,64,75,64,67,69,74,67},36))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({40,65,75,252,79,80,61,78,80,65,64,252,62,72,75,63,71,9,62,78,65,61,71,65,78,252,73,69,64,9,62,72,75,63,71,253,252,33,82,61,64,69,74,67,10,10,10},36))
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
if not getNPCByName(_d({40,65,75},36)) then
debug(_d({40,65,75,252,67,75,74,65,252,73,69,64,9,64,75,64,67,65,252,9,252,65,74,64,69,74,67,252,33,74,80,65,69,252,68,75,72,64,252,65,61,78,72,85},36))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({40,65,75},36)) then
setNavNamed(_d({40,65,75},36))
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
debug(_d({40,65,75,252,64,65,66,65,61,80,65,64},36))
stopLeoAnimLogger()
debug(_d({46,65,80,81,78,74,69,74,67,252,80,75,252,40,65,75,252,76,75,79,69,80,69,75,74,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,75,74},36))
navToPointConfirmed(COORDS.Leo, 30, _d({40,65,75,252,76,75,79,69,80,69,75,74},36))
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80,252,40,65,75,252,76,75,79,69,80,69,75,74},36))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({41,75,82,69,74,67,252,80,75},36), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,79,80,61,80,81,65,252,73,75,64,65,72,252,74,65,61,78},36), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({29,80,80,61,63,71,69,74,67},36), coordKey, _d({83,69,80,68},36), weapon or _d({74,75,80,68,69,74,67,252,66,75,81,74,64},36))
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
debug(coordKey, _d({62,61,78,78,65,72,252,64,65,79,80,78,75,85,65,64},36))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({9,252,63,75,81,72,64,252,74,75,80,252,66,69,74,64,252,79,80,61,80,81,65,252,73,75,64,65,72,8,252,79,71,69,76,76,69,74,67},36))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({79,80,69,72,72,252,61,72,69,82,65,252,4,36,44},36), hp, _d({5,252,9,252,78,65,9,64,65,79,80,78,75,85,69,74,67},36))
destroyStatue(coordKey)
else
debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,22},36), coordKey, _d({63,75,74,66,69,78,73,65,64,252,64,65,79,80,78,75,85,65,64},36))
end
end)
if not ok then debug(_d({78,65,63,68,65,63,71,47,80,61,80,81,65,252,65,78,78,75,78,22},36), coordKey, err) end
end
local function fightQueenUntilPhase2()
debug(_d({41,75,82,69,74,67,252,80,75,252,45,81,65,65,74},36))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
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
debug(_d({45,81,65,65,74,252,65,74,80,65,78,65,64,252,76,68,61,79,65,252,14},36))
end
local function finishQueen()
debug(_d({34,69,74,69,79,68,69,74,67,252,45,81,65,65,74},36))
equipSwordOrMelee()
setNavNamed(_d({31,81,76,69,64,252,45,81,65,65,74},36))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({31,81,76,69,64,252,45,81,65,65,74},36))
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
debug(_d({45,81,65,65,74,252,64,65,66,65,61,80,65,64,10,252,44,72,61,74,252,63,75,73,76,72,65,80,65,10},36))
end
local CONFIRMATION_PROMPT_NAME = _d({31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80},36)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then return nil end
return prompt:WaitForChild(_d({46,65,73,75,80,65,33,82,65,74,80},36), 5)
end)
if ok then return result end
debug(_d({67,65,80,46,65,76,72,61,85,46,65,73,75,80,65,252,65,78,78,75,78,22},36), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({44,72,61,85,65,78,35,81,69},36))
if not playerGui then return nil end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({37,73,61,67,65,30,81,80,80,75,74},36)) then
local ok2, val = pcall(function() return obj:GetAttribute(_d({62,81,80,80,75,74,50,61,72,81,65},36)) end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then return result end
debug(_d({66,69,74,64,30,81,80,80,75,74,30,85,50,61,72,81,65,252,65,78,78,75,78,22},36), result)
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
if not ok then debug(_d({63,72,69,63,71,35,81,69,30,81,80,80,75,74,252,65,78,78,75,78,22},36), err) end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then return nil, nil end
local isServerAttr = inst:GetAttribute(_d({69,79,47,65,78,82,65,78},36))
if isServerAttr ~= nil then
local child = isServerAttr
and inst:FindFirstChild(_d({46,65,73,75,80,65,33,82,65,74,80},36))
or inst:FindFirstChild(_d({63,72,69,65,74,80,33,82,65,74,80},36))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then return connector, isServer end
debug(_d({66,69,74,64,29,74,79,83,65,78,31,75,74,74,65,63,80,75,78,252,65,78,78,75,78,22},36), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({31,75,81,72,64,252,74,75,80,252,72,75,63,61,80,65,252,46,65,73,75,80,65,33,82,65,74,80,11,63,72,69,65,74,80,33,82,65,74,80,252,74,65,61,78,252,46,65,76,72,61,85,252,62,81,80,80,75,74,8,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,63,72,69,63,71},36))
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
debug(_d({66,69,78,65,46,65,76,72,61,85,50,61,72,81,65,252,65,78,78,75,78,22},36), err, _d({9,252,66,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,63,72,69,63,71},36))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({34,61,72,72,69,74,67,252,62,61,63,71,252,80,75,252,62,81,80,80,75,74,50,61,72,81,65,252,79,65,61,78,63,68,252,66,75,78,252,46,65,76,72,61,85},36))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then break end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({46,65,76,72,61,85,252,62,81,80,80,75,74,252,74,75,80,252,66,75,81,74,64,252,65,69,80,68,65,78,8,252,67,69,82,69,74,67,252,81,76},36))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,10,46,65,73,75,80,65,33,82,65,74,80},36))
local remote = getReplayRemote()
if not remote then
debug(_d({31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,11,46,65,73,75,80,65,33,82,65,74,80,252,74,75,80,252,66,75,81,74,64,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80},36))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({34,69,78,69,74,67,252,46,65,76,72,61,85,252,82,69,61,252,31,75,74,66,69,78,73,61,80,69,75,74,44,78,75,73,76,80,10,46,65,73,75,80,65,33,82,65,74,80},36))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({34,69,78,65,47,65,78,82,65,78,252,65,78,78,75,78,22},36), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then
debug(_d({83,61,69,80,34,75,78,43,62,70,65,63,80,69,82,65,79,35,81,69,22,252,74,75,252,44,72,61,85,65,78,35,81,69,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({43,62,70,65,63,80,69,82,65,79,252,35,49,37,252,66,75,81,74,64,252,9,252,79,80,61,67,65,252,72,75,61,64,65,64},36))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({43,62,70,65,63,80,69,82,65,79,252,35,49,37,252,74,75,80,252,66,75,81,74,64,252,83,69,80,68,69,74,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
return
end
end
end)
if not ok then debug(_d({83,61,69,80,34,75,78,43,62,70,65,63,80,69,82,65,79,35,81,69,252,65,78,78,75,78,22},36), err) end
end
local function runPlan()
debug(_d({44,72,61,74,252,79,80,61,78,80,65,64},36))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({47,80,61,78,80,69,74,67,252,74,61,82,252,72,75,75,76},36))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({76,75,79,252,12,10,14,79,252,29,34,48,33,46,252,79,80,61,78,80,42,61,82,22},36), rootAfter and rootAfter.Position)
end)
debug(_d({51,61,69,80,69,74,67,252,17,79,252,62,65,66,75,78,65,252,73,75,82,69,74,67,252,80,75,252,47,80,61,67,65,13},36))
task.wait(5)
for _, stage in ipairs({_d({47,80,61,67,65,13},36), _d({47,80,61,67,65,14},36), _d({47,80,61,67,65,15},36), _d({47,80,61,67,65,15,30},36)}) do
if not enabled then return end
local hpTarget = (stage == _d({47,80,61,67,65,15,30},36)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,80,75,252,61,78,78,75,83,252,66,72,85,9,64,75,83,74,252,61,78,65,61,252,4,31,81,76,69,64,252,46,61,69,74,5},36))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({32,75,64,67,69,74,67,252,61,78,78,75,83,252,78,61,69,74,252,69,74,252,61,252,79,77,81,61,78,65},36))
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
clearStage(_d({47,80,61,67,65,16},36))
if not enabled then return end
fightLeo()
if not enabled then return end
fightQueenUntilPhase2()
debug(_d({45,81,65,65,74,252,69,74,252,76,68,61,79,65,252,14,252,9,252,71,65,65,76,69,74,67,252,39,65,74,252,36,61,71,69,252,61,63,80,69,82,65,252,66,78,75,73,252,68,65,78,65,252,75,74},36))
startKenKeeper()
if not enabled then return end
destroyStatue(_d({47,80,61,80,81,65,13},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,13},36))
destroyStatue(_d({47,80,61,80,81,65,14},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,13},36))
recheckStatue(_d({47,80,61,80,81,65,14},36))
destroyStatue(_d({47,80,61,80,81,65,15},36))
if not enabled then return end
recheckStatue(_d({47,80,61,80,81,65,15},36))
recheckStatue(_d({47,80,61,80,81,65,14},36))
recheckStatue(_d({47,80,61,80,81,65,13},36))
if not enabled then return end
debug(_d({51,61,69,80,69,74,67,252,66,75,78,252,76,68,61,79,65,252,14,252,80,75,252,65,74,64},36))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({44,68,61,79,65,252,14,252,65,74,64,252,83,61,69,80,252,80,69,73,65,75,81,80,8,252,76,78,75,63,65,65,64,69,74,67,252,61,74,85,83,61,85},36))
break
end
end
if not enabled then return end
finishQueen()
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,62,61,63,71,252,80,75,252,45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
navToPointConfirmed(COORDS.Queen, 30, _d({45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
debug(_d({51,61,69,80,69,74,67,252,17,79,252,61,80,252,45,81,65,65,74,252,79,80,61,67,65,252,76,75,79,69,80,69,75,74},36))
task.wait(5)
if not enabled then return end
debug(_d({41,75,82,69,74,67,252,80,75,252,76,75,79,80,9,45,81,65,65,74,252,76,75,79,69,80,69,75,74},36))
navToPointConfirmed(COORDS.PostQueen, 30, _d({76,75,79,80,9,45,81,65,65,74,252,76,75,79,69,80,69,75,74},36))
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
debug(_d({33,74,61,62,72,69,74,67,8,252,76,75,79,252,30,33,34,43,46,33,252,76,72,61,74,22},36), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then debug(_d({44,72,61,74,252,65,78,78,75,78,22},36), err2) end
end)
debug(_d({33,74,61,62,72,65,64,22},36), enabled)
end
local function disableBot()
if not enabled then return end
enabled = false
stopNav()
debug(_d({33,74,61,62,72,65,64,22},36), enabled)
end
function CupidDungeon.Start()
if enabled then return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.RequirePlace(11424731604, _d({31,81,76,69,64,252,32,81,74,67,65,75,74},36)) then
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
_d({31,81,76,69,64,252,32,81,74,67,65,75,74},36),
CupidDungeon.Start,
CupidDungeon.Stop,
function() return enabled end
)
return CupidDungeon
end)()
end
local function loadHoroBossFarm()
(function()
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({38,81,86,75,252,80,68,65,252,32,69,61,73,75,74,64,62,61,63,71},36),
UseE = true,
UseZ = true,
UseC = true,
UseR = true
}
}
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({44,65,72,69},36))
if not (peliValueObj and peliValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
peliValueObj = nested and nested:FindFirstChild(_d({44,65,72,69},36))
end
levelValueObj = statsFolder:FindFirstChild(_d({40,65,82,65,72},36))
if not (levelValueObj and levelValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
levelValueObj = nested and nested:FindFirstChild(_d({40,65,82,65,72},36))
end
staminaValueObj = statsFolder:FindFirstChild(_d({47,80,61,73,69,74,61},36))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({57,252,47,80,61,74,64,61,72,75,74,65,252,41,75,64,65,22,252,44,78,65,79,79,252,3},36) .. toggleKey.Name .. _d({3,252,80,75,252,80,75,67,67,72,65,10},36))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
local lastE, lastZ, lastC, lastR = 0, 0, 0, 0
local function equipHoroTool()
local bp = LocalPlayer:FindFirstChild(_d({30,61,63,71,76,61,63,71},36))
local char = LocalPlayer.Character
if not char then return nil end
local tool = char:FindFirstChild(_d({36,75,78,75,9,36,75,78,75},36)) or (bp and bp:FindFirstChild(_d({36,75,78,75,9,36,75,78,75},36)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
if hum then hum:EquipTool(tool) end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then return nil end
local npts = Workspace:FindFirstChild(_d({42,44,31,79},36))
if not npts then return nil end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hum = boss:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
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
if key == _d({36,69,80},36) then return target.CFrame
elseif key == _d({48,61,78,67,65,80},36) then return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then setreadonly(mt, true) elseif make_readonly then make_readonly(mt) end
end)
if not successHook then warn(_d({55,36,75,78,75,34,61,78,73,57,252,41,65,80,61,80,61,62,72,65,252,68,75,75,71,252,66,61,69,72,65,64,22,252},36) .. tostring(err)) end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do conn:Disconnect() end
HoroFarm.Connections = {}
print(_d({55,36,75,78,75,34,61,78,73,57,252,47,80,75,76,76,65,64,10},36))
end
function HoroFarm.Start()
if HoroFarm.Running then warn(_d({55,36,75,78,75,34,61,78,73,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253},36)); return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.IsSafe() then return end
HoroFarm.Running = true
setupHook()
print(_d({55,36,75,78,75,34,61,78,73,57,252,47,80,61,78,80,65,64,252,80,61,78,67,65,80,69,74,67,22,252},36) .. HoroFarm.Config.SelectedBoss)
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
_d({36,75,78,75,34,61,78,73},36),
HoroFarm.Start,
HoroFarm.Stop,
function() return HoroFarm.Running end
)
return HoroFarm
end)()
end
local function loadLevelGrinder()
(function()
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {}
}
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({44,65,72,69},36))
if not (peliValueObj and peliValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
peliValueObj = nested and nested:FindFirstChild(_d({44,65,72,69},36))
end
levelValueObj = statsFolder:FindFirstChild(_d({40,65,82,65,72},36))
if not (levelValueObj and levelValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
levelValueObj = nested and nested:FindFirstChild(_d({40,65,82,65,72},36))
end
staminaValueObj = statsFolder:FindFirstChild(_d({47,80,61,73,69,74,61},36))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({57,252,47,80,61,74,64,61,72,75,74,65,252,41,75,64,65,22,252,44,78,65,79,79,252,3},36) .. toggleKey.Name .. _d({3,252,80,75,252,80,75,67,67,72,65,10},36))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
function LevelGrinder.Stop()
LevelGrinder.Running = false
for _, conn in ipairs(LevelGrinder.Connections) do conn:Disconnect() end
LevelGrinder.Connections = {}
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,47,80,75,76,76,65,64,10},36))
end
function LevelGrinder.Start()
if LevelGrinder.Running then warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,29,72,78,65,61,64,85,252,78,81,74,74,69,74,67,253},36)); return end
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
if not Safeguard.RequirePlace(3978370137, _d({34,69,78,79,80,252,47,65,61},36)) then return end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36), 10)
local hum = char:WaitForChild(_d({36,81,73,61,74,75,69,64},36), 10)
local stats = ReplicatedStorage:WaitForChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({44,65,72,69},36), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (char and char:FindFirstChild(_d({46,69,66,72,65},36)))
if hasRifle then break end
local peli = Core.GetPeli()
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,31,81,78,78,65,74,80,252,44,65,72,69,252,63,68,65,63,71,22},36), peli)
local inTown = hrp and hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if not inTown then
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,42,75,80,252,61,80,252,48,75,83,74,252,75,66,252,30,65,67,69,74,74,69,74,67,79,10,252,44,72,65,61,79,65,252,80,78,61,82,65,72,252,80,68,65,78,65,252,80,75,252,66,61,78,73,252,63,68,65,79,80,79,252,83,68,69,72,65,252,83,61,69,80,69,74,67,252,66,75,78,252,46,69,66,72,65,10},36))
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,63,68,65,79,80,59,66,61,78,73,65,78,10,72,81,61},36))
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,61,78,73,69,74,67,252,63,68,65,79,80,79,252,81,74,80,69,72,252,15,12,12,252,44,65,72,69,10,10,10,252,4,31,81,78,78,65,74,80,22,252},36) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({44,65,72,69},36))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running and not (LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36)) or (c and c:FindFirstChild(_d({46,69,66,72,65},36))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({30,81,85,61,62,72,65,37,80,65,73,79},36))
local shopItem = buyables and buyables:FindFirstChild(_d({46,69,66,72,65},36))
local shopPart = shopItem and shopItem:FindFirstChild(_d({47,68,75,76,44,61,78,80},36))
if EasyTravel and shopPart and hrp then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,48,78,61,82,65,72,69,74,67,252,80,75,252,46,69,66,72,65,252,79,68,75,76,252,82,69,61,252,33,61,79,85,48,78,61,82,65,72,10,10,10},36))
local nocollide = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({33,82,65,74,80,79},36)) and ReplicatedStorage.Events:FindFirstChild(_d({47,68,75,76},36))
if shopEvent and shopEvent:IsA(_d({46,65,73,75,80,65,34,81,74,63,80,69,75,74},36)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,33,77,81,69,76,76,69,74,67,252,46,69,66,72,65,10,10,10},36))
local args = {
[1] = _d({65,77,81,69,76},36),
[2] = _d({46,69,66,72,65},36)
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({33,82,65,74,80,79},36)) and ReplicatedStorage.Events:FindFirstChild(_d({48,75,75,72,79},36))
if toolsEvent and toolsEvent:IsA(_d({46,65,73,75,80,65,34,81,74,63,80,69,75,74},36)) then
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
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
local hrp = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({46,69,66,72,65},36))
if rifle and hum then hum:EquipTool(rifle) end
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,72,85,69,74,67,252,80,75,252,34,69,79,68,73,61,74,252,31,61,82,65,10,10,10},36))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,65,61,79,85,59,80,78,61,82,65,72,10,72,81,61},36))
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889 and hrp.Position.X <= -156 and hrp.Position.Z >= -3706 and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,33,79,63,61,76,69,74,67,252,79,68,75,76,252,69,74,80,65,78,69,75,78,252,62,85,252,66,72,85,69,74,67,252,79,80,78,61,69,67,68,80,252,81,76,10,10,10},36))
local nocollide = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({30,61,79,65,44,61,78,80},36)) then
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
local runService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
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
print(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,72,85,69,74,67,252,80,75,252,34,69,79,68,73,61,74,252,31,61,82,65,10,10,10},36))
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
local FishmanMaze = Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,66,69,79,68,73,61,74,59,73,61,86,65,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,66,69,79,68,73,61,74,59,73,61,86,65,10,72,81,61},36))
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function() return LevelGrinder.Running end)
end)
else
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,34,61,69,72,65,64,252,80,75,252,69,73,76,75,78,80,252,34,69,79,68,73,61,74,41,61,86,65,252,72,69,62,78,61,78,85,253},36))
end
else
warn(_d({55,40,65,82,65,72,252,35,78,69,74,64,65,78,57,252,43,81,80,79,69,64,65,252,34,69,79,68,73,61,74,252,31,61,82,65,252,62,75,81,74,64,79,8,252,79,71,69,76,76,69,74,67,252,73,61,86,65,10},36))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(
LevelGrinder,
_d({40,65,82,65,72,252,35,78,69,74,64,65,78},36),
LevelGrinder.Start,
LevelGrinder.Stop,
function() return LevelGrinder.Running end
)
return LevelGrinder
end)()
end
local function loadNavigationLab()
(function()
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local RunService       = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local Core = (function()
local Core = {}
function Core.Import(localPath, publicUrl)
local loaded = false
local result = nil
local oldState = _G.DisableStandalone
_G.DisableStandalone = true
if isfile and readfile then
pcall(function()
local content = readfile(localPath)
if content and content ~= "" then
result = loadstring(content)()
loaded = true
end
end)
end
if not loaded then
pcall(function() result = loadstring(game:HttpGet(publicUrl))() end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({44,65,72,69},36))
if not (peliValueObj and peliValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
peliValueObj = nested and nested:FindFirstChild(_d({44,65,72,69},36))
end
levelValueObj = statsFolder:FindFirstChild(_d({40,65,82,65,72},36))
if not (levelValueObj and levelValueObj:IsA(_d({50,61,72,81,65,30,61,79,65},36))) then
local nested = statsFolder:FindFirstChild(_d({47,80,61,80,79},36))
levelValueObj = nested and nested:FindFirstChild(_d({40,65,82,65,72},36))
end
staminaValueObj = statsFolder:FindFirstChild(_d({47,80,61,73,69,74,61},36))
else
peliValueObj = nil
levelValueObj = nil
staminaValueObj = nil
end
return statsFolder
end
function Core.GetPeli()
getStats()
return peliValueObj and peliValueObj.Value or 0
end
function Core.GetLevel()
getStats()
return levelValueObj and levelValueObj.Value or 1
end
function Core.GetStamina()
getStats()
if staminaValueObj then
return staminaValueObj.Value, staminaValueObj.MaxValue
end
return 0, 0
end
function Core.GetHealth()
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64},36))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then return end
if input.KeyCode == toggleKey then
if checkCallback() then
stopCallback()
else
startCallback()
end
end
end)
if module and module.Connections then
table.insert(module.Connections, connection)
end
if not noAutoStart then
task.spawn(function()
if not game:IsLoaded() then game.Loaded:Wait() end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({57,252,47,80,61,74,64,61,72,75,74,65,252,41,75,64,65,22,252,44,78,65,79,79,252,3},36) .. toggleKey.Name .. _d({3,252,80,75,252,80,75,67,67,72,65,10},36))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local Safeguard = Core.GetSafeguard()
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
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
return char, char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)), char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({59,59,33,61,79,85,48,78,61,82,65,72,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,33,61,79,85,48,78,61,82,65,72,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,33,61,79,85,48,78,61,82,65,72,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,33,61,79,85,48,78,61,82,65,72,34,75,78,63,65},36)
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
local force = root:FindFirstChild(_d({59,59,33,61,79,85,48,78,61,82,65,72,34,75,78,63,65},36))
local att = root:FindFirstChild(_d({59,59,33,61,79,85,48,78,61,82,65,72,29,80,80},36))
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
local cave = Workspace.Islands:FindFirstChild(_d({34,69,79,68,73,61,74,252,31,61,82,65},36))
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
if not Safeguard then warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,61,69,72,65,64,252,80,75,252,72,75,61,64,253},36)); return end
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
print(_d({55,33,61,79,85,252,48,78,61,82,65,72,57,252,34,72,69,67,68,80,252,65,74,61,62,72,65,64,10},36))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then loopConnection:Disconnect(); loopConnection = nil end
cleanupForce()
print(_d({55,33,61,79,85,252,48,78,61,82,65,72,57,252,34,72,69,67,68,80,252,64,69,79,61,62,72,65,64,10},36))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do conn:Disconnect() end
EasyTravel.Connections = {}
end
Core.SetupStandalone(
EasyTravel,
_d({33,61,79,85,252,48,78,61,82,65,72},36),
EasyTravel.Start,
EasyTravel.Stop,
function() return EasyTravel.Enabled end,
Enum.KeyCode.P,
true
)
return EasyTravel
end)()
end
local function loadOverworldTester()
(function()
local Players = game:GetService(_d({44,72,61,85,65,78,79},36))
local RunService = game:GetService(_d({46,81,74,47,65,78,82,69,63,65},36))
local UserInputService = game:GetService(_d({49,79,65,78,37,74,76,81,80,47,65,78,82,69,63,65},36))
local ReplicatedStorage = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({69,64,72,65},36)
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
print(_d({55,43,82,65,78,83,75,78,72,64,48,65,79,80,65,78,57},36), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then return end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({47,80,61,80,79},36) .. LocalPlayer.Name)
if not statsFolder then return end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = {char = char, cf = cf}
if style == _d({46,75,71,81,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({35,65,76,76,75},36), args)
elseif style == _d({30,72,61,63,71,40,65,67},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71},36), args)
elseif style == _d({39,61,73,69,79,68,69,71,69},36) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({39,61,73,69,79,68,69,71,69,35,65,76,76,75},36), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({47,71,85,252,51,61,72,71,14},36), args)
end
debug(_d({34,69,78,65,64,252,35,65,76,76,75,252,46,65,73,75,80,65},36))
end)
if not ok then debug(_d({69,74,82,75,71,65,35,65,76,76,75,252,65,78,78,75,78,22},36), err) end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36)) or Instance.new(_d({29,80,80,61,63,68,73,65,74,80},36))
att.Name = _d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36)
att.Parent = root
local force = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36))
if not force then
force = Instance.new(_d({40,69,74,65,61,78,50,65,72,75,63,69,80,85},36))
force.Name = _d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36)
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
local root = char:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36))
if not root then return end
local force = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,34,75,78,63,65},36))
local att   = root:FindFirstChild(_d({59,59,48,65,79,80,36,75,82,65,78,29,80,80},36))
if force then force:Destroy() end
if att   then att:Destroy()   end
end)
end
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then return end
debug(_d({51,61,72,71,69,74,67,252,80,75,22},36), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then debug(_d({83,61,72,71,48,75,44,75,69,74,80,252,51,252,64,75,83,74,252,65,78,78,75,78,22},36), err) end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then break end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({29,78,78,69,82,65,64,252,61,80,22},36), pos)
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
if item:IsA(_d({41,75,64,65,72},36)) and item:FindFirstChild(_d({36,81,73,61,74,75,69,64,46,75,75,80,44,61,78,80},36)) and item:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)) then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({36,81,73,61,74,75,69,64},36)).Health > 0 then
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
mode = _d({69,64,72,65},36)
if navConn then navConn:Disconnect() navConn = nil end
cleanupForce()
debug(_d({48,65,79,80,65,78,252,32,69,79,61,62,72,65,64},36))
end
local function enableBot(targetMode)
if enabled then disableBot() end
enabled = true
mode = targetMode
debug(_d({48,65,79,80,65,78,252,33,74,61,62,72,65,64,10,252,41,75,64,65,22},36), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then return end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({44,72,61,85,65,78,252,64,69,65,64,253,252,32,69,79,61,62,72,69,74,67,252,62,75,80,10},36))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({68,75,82,65,78},36) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({64,75,64,67,65},36) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) then
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
local playerGui = LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then return end
local existingGui = playerGui:FindFirstChild(_d({43,82,65,78,83,75,78,72,64,48,65,79,80,35,81,69},36))
if existingGui then existingGui:Destroy() end
local screenGui = Instance.new(_d({47,63,78,65,65,74,35,81,69},36))
screenGui.Name = _d({43,82,65,78,83,75,78,72,64,48,65,79,80,35,81,69},36)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({34,78,61,73,65},36))
frame.Name = _d({41,61,69,74,34,78,61,73,65},36)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({49,37,31,75,78,74,65,78},36))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({204,123,119,125,203,148,107,252,31,81,76,69,64,252,33,74,67,69,74,65,252,43,82,65,78,83,75,78,72,64,252,48,65,79,80},36)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({47,80,61,80,81,79,22,252,37,64,72,65},36)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1,1,1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({48,65,84,80,30,75,84},36))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1,1,1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({36,75,82,65,78,252,29,62,75,82,65,252,48,61,78,67,65,80},36), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({68,75,82,65,78},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,36,75,82,65,78,69,74,67,252},36) .. val .. _d({252,79,80,81,64,79,252,81,76},36)
end)
createInputBtn(_d({32,75,64,67,65,252,31,72,69,73,62},36), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({64,75,64,67,65},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,32,75,64,67,65,9,68,75,72,64,69,74,67,252,4},36) .. val .. _d({252,79,80,81,64,79,5},36)
end)
createInputBtn(_d({48,65,79,80,252,47,77,81,61,78,65,252,32,75,64,67,65},36), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({79,77,81,61,78,65,59,64,75,64,67,65},36))
statusLabel.Text = _d({47,80,61,80,81,79,22,252,47,77,81,61,78,65,252,51,61,72,71,69,74,67,252,4},36) .. val .. _d({252,79,80,81,64,79,5},36)
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
while enabled and mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({79,77,81,61,78,65,59,64,75,64,67,65},36) then
disableBot()
statusLabel.Text = _d({47,80,61,80,81,79,22,252,37,64,72,65,252,4,47,77,81,61,78,65,252,64,75,64,67,65,252,64,75,74,65,5},36)
end
end)
end)
local stopBtn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({33,41,33,46,35,33,42,31,53,252,47,48,43,44},36)
stopBtn.TextColor3 = Color3.new(1,1,1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({49,37,31,75,78,74,65,78},36), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({47,80,61,80,81,79,22,252,47,48,43,44,44,33,32,252,4,37,64,72,65,5},36)
local VIM = game:GetService(_d({50,69,78,80,81,61,72,37,74,76,81,80,41,61,74,61,67,65,78},36))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({55,43,82,65,78,83,75,78,72,64,48,65,79,80,65,78,57,252,40,75,61,64,65,64,252,79,81,63,63,65,79,79,66,81,72,72,85,10},36))
end)()
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({44,72,61,85,65,78,35,81,69},36), 10)
if not playerGui then return end
local oldUI = playerGui:FindFirstChild(_d({35,44,43,40,61,81,74,63,68,65,78,49,37},36))
if oldUI then oldUI:Destroy() end
local screenGui = Instance.new(_d({47,63,78,65,65,74,35,81,69},36))
screenGui.Name = _d({35,44,43,40,61,81,74,63,68,65,78,49,37},36)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({34,78,61,73,65},36))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({49,37,31,75,78,74,65,78},36))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({49,37,47,80,78,75,71,65},36))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({204,123,104,104,252,35,44,43,252,36,81,62,252,40,61,81,74,63,68,65,78},36)
title.Parent = main
local closeBtn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({49,37,31,75,78,74,65,78},36), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({31,68,75,75,79,65,252,61,252,62,75,80,252,75,78,252,81,80,69,72,69,80,85,252,80,75,252,78,81,74,22},36)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({48,65,84,80,30,81,80,80,75,74},36))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({252,252},36) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({49,37,31,75,78,74,65,78},36))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({49,37,47,80,78,75,71,65},36))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({48,65,84,80,40,61,62,65,72},36))
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
CreateLaunchButton(_d({31,81,76,69,64,252,32,81,74,67,65,75,74,252,34,61,78,73},36), _d({29,81,80,75,73,61,80,65,252,63,81,76,69,64,252,64,81,74,67,65,75,74,79,252,2,252,62,75,79,79,252,63,85,63,72,65,79},36), loadCupidDungeon)
CreateLaunchButton(_d({36,75,78,75,252,30,75,79,79,252,34,61,78,73,252,4,47,69,72,65,74,80,252,29,69,73,5},36), _d({29,81,80,75,66,61,78,73,252,75,82,65,78,83,75,78,72,64,252,62,75,79,79,65,79,252,81,79,69,74,67,252,36,75,78,75,252,66,78,81,69,80,79},36), loadHoroBossFarm)
CreateLaunchButton(_d({40,65,82,65,72,252,2,252,41,75,62,252,35,78,69,74,64,65,78},36), _d({29,81,80,75,9,72,65,82,65,72,252,61,74,64,252,66,61,78,73,252,72,75,63,61,72,252,42,44,31,252,73,75,62,79},36), loadLevelGrinder)
CreateLaunchButton(_d({33,61,79,85,252,48,78,61,82,65,72,252,4,44,252,48,75,67,67,72,65,5},36), _d({51,29,47,32,252,34,72,69,67,68,80,252,83,69,80,68,252,67,78,75,81,74,64,252,66,75,72,72,75,83,252,2,252,83,61,72,72,252,63,72,69,73,62,69,74,67},36), loadNavigationLab)
CreateLaunchButton(_d({44,68,85,79,69,63,79,252,43,82,65,78,83,75,78,72,64,252,48,65,79,80,65,78},36), _d({48,65,79,80,252,63,75,73,62,61,80,252,68,75,82,65,78,8,252,67,65,76,76,75,252,2,252,64,75,64,67,65,252,68,65,69,67,68,80,79},36), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({55,35,44,43,252,36,81,62,57,252,40,61,81,74,63,68,65,78,252,49,37,252,69,74,69,80,69,61,72,69,86,65,64,10},36))
end)()