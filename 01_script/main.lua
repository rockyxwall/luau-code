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
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local Workspace = workspace
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local HOVER_OFFSET = 10.3
local HOVER_YVEL = 120
local XZ_SPEED = 5
local XZ_THRESHOLD = 3
local Y_THRESHOLD = 1.5
local TOGGLE_KEY = Enum.KeyCode.P
local MELEE_CLICK_INTERVAL = 0.2
local ARROW_HOVER_OFFSET = 10
local ARROW_HOVER_WAIT = 30
local ARROW_DODGE_DISTANCE = 40
local ARROW_DODGE_INTERVAL = 0.5
local LEO_PILLAR_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,0,0,253,0,253,255,254,3},52)
local LEO_ENTEI_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,0,0,253,255,4,254,3,4},52)
local LEO_HIKEN_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,254,252,5,253,3,0,252,3},52)
local LEO_FIREFLY_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,1,254,254,252,254,255,2,253,1,0},52)
local LEO_DODGE_ANIMS = { LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID }
local LEO_DODGE_DISTANCE = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY = 4
local BLOCK_KEY = Enum.KeyCode.F
local LOAD_WAIT = 15
local OBJECTIVES_GUI_NAME = _d({27,46,54,49,47,64,53,66,49,63},52)
local OBJECTIVES_WAIT_MAX = 60
local BUSO_CHECK_INTERVAL = 1
local KEN_CHECK_INTERVAL = 1
local GEPPO_CLIMB_THRESHOLD = 10
local GEPPO_HOLD_INTERVAL = 2
local COMBAT_LOCK_MAX_SNAP = 10
local UNSTUCK_CHECK_INTERVAL = 1
local UNSTUCK_MOVE_THRESHOLD = 5
local UNSTUCK_STUCK_TICKS = 10
local UNSTUCK_COOLDOWN = 8
local COORDS = {
Stage1 = Vector3.new(557.1764526367188, 310.18902587890625, -2282.130126953125),
Stage2 = Vector3.new(514.002197265625, 320.0939025878906, -2755.223876953125),
Stage3 = Vector3.new(-213.13096618652344, 376.07440185546875, -2699.046142578125),
Stage3B = Vector3.new(-915.4906616210938, 435.0939636230469, -2743.846923828125),
ArrowFlyDown = Vector3.new(-1071.06884765625, 444.2209167480469, -3205.72412109375),
Stage4 = Vector3.new(-1089.56494140625, 452.1291198730469, -3590.454833984375),
Leo = Vector3.new(-1092.56298828125, 506.0744462890625, -4248.216796875),
Queen = Vector3.new(-1098.1424560546875, 666.206787109375, -5066.43603515625),
Statue1 = Vector3.new(-902.9956665039062, 670.851867675757812, -5307.0703125),
Statue2 = Vector3.new(-1089.46533203125, 671.2554931640625, -5410.2470703125),
Statue3 = Vector3.new(-1304.9073486328125, 666.7710571289062, -5306.22705078125),
PostQueen = Vector3.new(-1096.88134765625, 672.9217529296875, -5380.06396484375),
}
local REPLAY_BUTTON_VALUE = _d({30,49,60,56,45,69},52)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE = 1
local enabled = false
local navConn = nil
local phase = _d({57,59,66,49},52)
local NavState = { mode = _d({53,48,56,49},52) }
local lastAim = nil
local lastFace = nil
local function debug(...)
print(_d({39,14,59,63,63,14,59,64,41},52), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end)
if ok then
return root
end
debug(_d({51,49,64,30,59,59,64,236,49,62,62,59,62,6},52), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
end)
if ok then
return hum
end
debug(_d({51,49,64,20,65,57,45,58,59,53,48,236,49,62,62,59,62,6},52), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({43,43,20,59,66,49,62,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,20,59,66,49,62,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,20,59,66,49,62,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,20,59,66,49,62,18,59,62,47,49},52)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then
return result
end
debug(_d({51,49,64,27,62,15,62,49,45,64,49,18,59,62,47,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then
return
end
local root = char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then
return
end
local force = root:FindFirstChild(_d({43,43,20,59,66,49,62,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,20,59,66,49,62,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end)
if not ok then
debug(_d({47,56,49,45,58,65,60,18,59,62,47,49,236,49,62,62,59,62,6},52), err)
end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({14,65,63,59,25,49,56,49,49},52)) ~= nil
end)
if ok then
return result
end
debug(_d({53,63,14,65,63,59,13,47,64,53,66,49,236,49,62,62,59,62,6},52), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({14,65,63,59},52))
end)
if not ok then
debug(_d({45,47,64,53,66,45,64,49,14,65,63,59,236,49,62,62,59,62,6},52), err)
end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({14,65,63,59,236,58,59,64,236,45,47,64,53,66,49,248,236,45,47,64,53,66,45,64,53,58,51},52))
activateBuso()
end
end)
if not ok then
debug(_d({14,65,63,59,23,49,49,60,49,62,236,49,62,62,59,62,6},52), err)
end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({14,65,63,59,236,55,49,49,60,49,62,236,63,64,59,60,60,49,48},52))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({23,49,58,20,45,55,53},52)) ~= nil
end)
if ok then
return result
end
debug(_d({53,63,23,49,58,13,47,64,53,66,49,236,49,62,62,59,62,6},52), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({23,49,58},52), true)
end)
if not ok then
debug(_d({45,47,64,53,66,45,64,49,23,49,58,236,49,62,62,59,62,6},52), err)
end
end
local kenKeeperStarted = false
local function startKenKeeper()
if kenKeeperStarted then
return
end
kenKeeperStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isKenActive() then
debug(_d({23,49,58,236,58,59,64,236,45,47,64,53,66,49,248,236,45,47,64,53,66,45,64,53,58,51},52))
activateKen()
end
end)
if not ok then
debug(_d({23,49,58,23,49,49,60,49,62,236,49,62,62,59,62,6},52), err)
end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({23,49,58,236,55,49,49,60,49,62,236,63,64,59,60,60,49,48},52))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function()
return Workspace:FindFirstChild(_d({26,28,15,63},52))
end)
if ok then
return folder
end
debug(_d({51,49,64,26,28,15,63,18,59,56,48,49,62,236,49,62,62,59,62,6},52), folder)
return nil
end
local function getNearestNPC(exclude)
local ok, result = pcall(function()
local root = Core.GetRoot(LocalPlayer)
local folder = getNPCsFolder()
if not root or not folder then
return nil
end
local nearest, nearestDist = nil, math.huge
local fallbackNearest, fallbackDist = nil, math.huge
for _, model in ipairs(folder:GetChildren()) do
local okp, info = pcall(function()
local r = model:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local h = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if r and h and h.Health > 0 then
return { root = r, humanoid = h, model = model }
end
return nil
end)
if okp and info then
local dist = (info.root.Position - root.Position).Magnitude
if dist < fallbackDist then
fallbackDist, fallbackNearest = dist, info
end
if dist < nearestDist and not (exclude and exclude[model]) then
nearestDist, nearest = dist, info
end
end
end
return nearest or fallbackNearest
end)
if ok then
return result
end
debug(_d({51,49,64,26,49,45,62,49,63,64,26,28,15,236,49,62,62,59,62,6},52), result)
return nil
end
local function getNPCByName(name)
local ok, result = pcall(function()
local folder = getNPCsFolder()
if not folder then
return nil
end
local model = folder:FindFirstChild(name)
if not model then
return nil
end
local root = model:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
return { root = root, humanoid = hum, model = model }
end
return nil
end)
if ok then
return result
end
debug(_d({51,49,64,26,28,15,14,69,26,45,57,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function npcsRemaining()
local ok, count = pcall(function()
local folder = getNPCsFolder()
if not folder then
return 0
end
local n = 0
for _, m in ipairs(folder:GetChildren()) do
local hum = m:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum and hum.Health > 0 then
n += 1
end
end
return n
end)
if ok then
return count
end
debug(_d({58,60,47,63,30,49,57,45,53,58,53,58,51,236,49,62,62,59,62,6},52), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({15,65,60,53,48,236,29,65,49,49,58},52))
return queen ~= nil and queen:FindFirstChild(_d({57,59,64,53,59,58,24,49,63,63},52)) ~= nil
end)
if ok then
return result
end
debug(_d({53,63,29,65,49,49,58,28,52,45,63,49,254,236,49,62,62,59,62,6},52), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,253,254,253,254,5,3,5,0,254,254,5,254,3,2,5},52)
local QUEEN_GRASP_ANIM_ID = _d({62,46,68,45,63,63,49,64,53,48,6,251,251,253,254,5,4,252,252,252,2,253,252,252,253,3,255,0},52)
local QUEEN_BLOCK_ANIMS = { QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID }
local QUEEN_BLOCK_TIMEOUT = 3
local QUEEN_DODGE_DISTANCE = 70
local QUEEN_DODGE_DURATION = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then
return false
end
local hum = npcModel:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if not hum then
return false
end
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
if ok then
return result, which
end
debug(_d({53,63,28,56,45,69,53,58,51,13,58,53,57,18,62,59,57,24,53,63,64,236,49,62,62,59,62,6},52), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({14,56,59,47,55,53,58,51},52)) ~= nil
end)
if ok then
return result
end
debug(_d({53,63,26,28,15,14,56,59,47,55,53,58,51,236,49,62,62,59,62,6},52), result)
return false
end
local NPC_PREDICT_LOOKAHEAD = 0.15
local NPC_PREDICT_MAX_LEAD = 12
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
if ok then
return result
end
debug(_d({60,62,49,48,53,47,64,26,28,15,28,59,63,53,64,53,59,58,236,49,62,62,59,62,6},52), result)
return info.root.Position
end
local NPC_STUCK_TIMEOUT = 10
local npcDamageTracker = setmetatable({}, { __mode = "k" })
local stuckNPCs = setmetatable({}, { __mode = "k" })
local function trackNPCDamage(info)
local ok, err = pcall(function()
local model = info.model
local hp = info.humanoid.Health
local tracked = npcDamageTracker[model]
if not tracked or tracked.lastHP ~= hp then
npcDamageTracker[model] = { lastHP = hp, since = tick() }
stuckNPCs[model] = nil
return
end
if not stuckNPCs[model] and tick() - tracked.since > NPC_STUCK_TIMEOUT then
debug(_d({26,59,236,48,45,57,45,51,49,236,59,58},52), model.Name, _d({50,59,62},52), NPC_STUCK_TIMEOUT, _d({63,236,249,236,63,67,53,64,47,52,53,58,51,236,64,45,62,51,49,64},52))
stuckNPCs[model] = true
end
end)
if not ok then
debug(_d({64,62,45,47,55,26,28,15,16,45,57,45,51,49,236,49,62,62,59,62,6},52), err)
end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({25,59,48,49,56},52)) then
if model.PrimaryPart then
return model.PrimaryPart.Position
end
return model:GetPivot().Position
elseif model:IsA(_d({14,45,63,49,28,45,62,64},52)) then
return model.Position
end
return nil
end)
if ok then
return pos
end
debug(_d({51,49,64,25,59,48,49,56,18,45,47,49,28,59,63,236,49,62,62,59,62,6},52), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({17,58,66},52))
local folder = env and env:FindFirstChild(_d({31,64,45,64,65,49,63},52))
if not folder then
return nil
end
local nearest, nearestDist = nil, math.huge
for _, m in ipairs(folder:GetChildren()) do
local okp, mpos = pcall(getModelFacePos, m)
if okp and mpos then
local dist = (mpos - coordPos).Magnitude
if dist < nearestDist then
nearestDist, nearest = dist, m
end
end
end
return nearest
end)
if ok then
return result
end
debug(_d({51,49,64,31,64,45,64,65,49,25,59,48,49,56,26,49,45,62,236,49,62,62,59,62,6},52), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({46,45,62,62,49,56,20,28},52))
return v and v.Value or 0
end)
if ok then
return hp
end
debug(_d({51,49,64,31,64,45,64,65,49,20,28,236,49,62,62,59,62,6},52), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({ char, bp }) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) then
local ok2, val = pcall(function()
return item:GetAttribute(attrName)
end)
if ok2 and val == true then
return item
end
end
end
end
end
return nil
end)
if ok then
return tool
end
debug(_d({50,53,58,48,32,59,59,56,14,69,13,64,64,62,53,46,65,64,49,236,49,62,62,59,62,6},52), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({ char, bp }) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({32,59,59,56},52)) then
return t
end
end
end
return nil
end)
if ok then
return tool
end
debug(_d({50,53,58,48,32,59,59,56,14,69,26,45,57,49,236,49,62,62,59,62,6},52), tool)
return nil
end
local function equipTool(tool)
if not tool then
return false
end
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if tool.Parent == char then
return
end
local hum = getHumanoid()
if not hum then
return
end
hum:EquipTool(tool)
end)
if not ok then
debug(_d({49,61,65,53,60,32,59,59,56,236,49,62,62,59,62,6},52), err)
end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
for _, pool in ipairs({ char, bp }) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({32,59,59,56},52)) and item:FindFirstChild(childName) then
return item
end
end
end
end
return nil
end)
if ok then
return tool
end
debug(_d({50,53,58,48,32,59,59,56,14,69,15,52,53,56,48,26,45,57,49,236,49,62,62,59,62,6},52), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({31,67,59,62,48,17,61,65,53,60},52))
if sword then
equipTool(sword)
return _d({63,67,59,62,48},52)
end
local melee = findToolByAttribute(_d({25,49,56,49,49,32,59,59,56},52))
if melee then
equipTool(melee)
return _d({57,49,56,49,49},52)
end
debug(_d({26,59,236,63,67,59,62,48,236,59,62,236,57,49,56,49,49,236,64,59,59,56,236,50,59,65,58,48},52))
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
if not ok then
debug(_d({47,56,53,47,55,25,253,236,49,62,62,59,62,6},52), err)
end
end
local lastGeppoTime = 0
local GEPPO_COOLDOWN = 2
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then
return
end
lastGeppoTime = now
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
local root = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then
return
end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. Players.LocalPlayer.Name)
if not statsFolder then
return
end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = { char = char, cf = cf }
if style == _d({30,59,55,65,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,49,60,60,59},52), args)
elseif style == _d({14,56,45,47,55,24,49,51},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55},52), args)
elseif style == _d({23,45,57,53,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,45,57,53,63,52,53,55,53,19,49,60,60,59},52), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55,254},52), args)
end
end)
if not ok then
debug(_d({53,58,66,59,55,49,19,49,60,60,59,236,49,62,62,59,62,6},52), err)
end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then
debug(_d({60,62,49,63,63,31,55,53,56,56,30,236,49,62,62,59,62,6},52), err)
end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then
debug(_d({52,59,56,48,14,56,59,47,55,236,49,62,62,59,62,6},52), err)
end
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
if not ok then
debug(_d({52,59,56,48,14,56,59,47,55,35,52,53,56,49,236,49,62,62,59,62,6},52), err)
end
end
local function getGameG()
local ok, result = pcall(function()
if getrenv then
local renv = getrenv()
return renv and renv._G
end
return nil
end)
if ok then
return result
end
debug(_d({51,49,64,19,45,57,49,19,236,49,62,62,59,62,6},52), result)
return nil
end
local function isRealM1Busy()
local ok, result = pcall(function()
local g = getGameG()
return g ~= nil and g.midM1 == true
end)
if ok then
return result
end
debug(_d({53,63,30,49,45,56,25,253,14,65,63,69,236,49,62,62,59,62,6},52), result)
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
if checkFn() then
return true
end
task.wait(step)
t += step
end
return checkFn()
end
local function isStunned()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({63,64,65,58},52)) ~= nil
end)
if ok then
return result
end
debug(_d({53,63,31,64,65,58,58,49,48,236,49,62,62,59,62,6},52), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then
debug(_d({60,62,49,63,63,31,64,65,58,14,62,49,45,55,236,49,62,62,59,62,6},52), err)
end
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
if not info then
return
end
local root = Core.GetRoot(LocalPlayer)
local myPos = root and root.Position or info.root.Position
local bossPos = info.root.Position
local flatDir = Vector3.new(myPos.X - bossPos.X, 0, myPos.Z - bossPos.Z)
if flatDir.Magnitude < 1 then
flatDir = Vector3.new(1, 0, 0)
end
local awayPoint = myPos + (flatDir.Unit * QUEEN_DODGE_DISTANCE)
awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)
navToPoint(awayPoint, true)
local t = 0
while enabled do
if isStunned() then
pressStunBreak()
end
info = getInfoFn()
if not info then
debug(_d({61,65,49,49,58,16,59,48,51,49,33,58,64,53,56,31,45,50,49,6,236,29,65,49,49,58,236,51,59,58,49,236,249,236,49,58,48,53,58,51,236,48,59,48,51,49,236,49,45,62,56,69},52))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({61,65,49,49,58,16,59,48,51,49,33,58,64,53,56,31,45,50,49,236,63,45,50,49,64,69,236,64,53,57,49,59,65,64},52))
break
end
end
end
local queenDodging = false
local queenWatcherStarted = false
local function startQueenDodgeWatcher()
if queenWatcherStarted then
return
end
queenWatcherStarted = true
task.spawn(function()
while enabled do
local ok, err = pcall(function()
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
if not info then
return
end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({29,65,49,49,58,236,47,45,63,64,53,58,51,236,48,49,64,49,47,64,49,48,236,249,236,48,59,48,51,53,58,51,236,244,67,45,64,47,52,49,62,245},52))
queenDodgeUntilSafe(function()
return getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
end)
if enabled and getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52)) then
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
end
queenDodging = false
end
end)
if not ok then
debug(_d({61,65,49,49,58,16,59,48,51,49,35,45,64,47,52,49,62,236,49,62,62,59,62,6},52), err)
end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({60,59,53,58,64},52) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({58,60,47},52) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({58,45,57,49,48},52) and NavState.name then
local info = getNPCByName(NavState.name)
if info then
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
end
return nil, nil
end)
if ok then
return aimR, faceR
end
debug(_d({51,49,64,26,45,66,32,45,62,51,49,64,63,236,49,62,62,59,62,6},52), aimR)
return nil, nil
end
local function computeLookDownCFrame(root, targetPos)
local horiz = Vector3.new(targetPos.X - root.Position.X, 0, targetPos.Z - root.Position.Z)
if horiz.Magnitude < 0.5 then
local fwd = root.CFrame.LookVector
local fwdFlat = Vector3.new(fwd.X, 0, fwd.Z)
if fwdFlat.Magnitude < 0.01 then
fwdFlat = Vector3.new(0, 0, 1)
end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local COMBAT_LOCK_MODES = { npc = true, named = true }
local function computeLockedCFrame(root, aimPos, facePos)
local ok, result = pcall(function()
return computeLookDownCFrame(root, facePos) + (aimPos - root.Position)
end)
if ok then
return result
end
debug(_d({47,59,57,60,65,64,49,24,59,47,55,49,48,15,18,62,45,57,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function setNavPoint(pos)
NavState = { mode = _d({60,59,53,58,64},52), point = pos }
phase = _d({57,59,66,49},52)
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
if not ok then
debug(_d({58,45,66,32,59,28,59,53,58,64,236,51,49,60,60,59,236,47,52,49,47,55,236,49,62,62,59,62,6},52), err)
end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = { mode = _d({58,60,47},52) }
phase = _d({57,59,66,49},52)
end
function setNavNamed(name)
NavState = { mode = _d({58,45,57,49,48},52), name = name }
phase = _d({57,59,66,49},52)
end
local function setNavIdle()
NavState = { mode = _d({53,48,56,49},52) }
phase = _d({57,59,66,49},52)
end
local function hasArrived()
return phase == _d({52,59,66,49,62},52)
end
local function startNav()
phase = _d({57,59,66,49},52)
debug(_d({26,45,66,236,56,59,59,60,236,27,26},52))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({28,56,45,69,49,62,236,48,53,49,48,237,236,31,64,59,60,60,53,58,51,236,46,59,64,250},52))
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
local pos = root.Position
local yErr = aim.Y - pos.Y
local xzDist = Vector3.new(pos.X - aim.X, 0, pos.Z - aim.Z).Magnitude
if (pos - aim).Magnitude > 2000 then
debug(_d({28,56,45,69,49,62,236,53,63,236,64,59,59,236,50,45,62,236,50,62,59,57,236,64,45,62,51,49,64,236,244,10,254,252,252,252,236,63,64,65,48,63,245,250,236,24,53,55,49,56,69,236,62,49,63,60,45,67,58,49,48,236,45,64,236,56,59,46,46,69,250,236,31,64,59,60,60,53,58,51,236,46,59,64,250},52))
disableBot()
return
end
local xzDir = Vector3.new(aim.X - pos.X, 0, aim.Z - pos.Z)
local xzVel = xzDir.Magnitude > 0 and (xzDir.Unit * math.min(xzDir.Magnitude * XZ_SPEED, 60))
or Vector3.zero
local force = getOrCreateForce(root)
if not force then
return
end
local prevPos = force:GetAttribute(_d({43,43,60,62,49,66,28,59,63},52))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({24,45,62,51,49,236,60,59,63,53,64,53,59,58,236,54,65,57,60,236,48,49,64,49,47,64,49,48,6},52), delta, _d({63,64,65,48,63,250,236,60,62,49,66,28,59,63,9},52), prevPos, _d({58,49,67,28,59,63,9},52), pos)
end
end
force:SetAttribute(_d({43,43,60,62,49,66,28,59,63},52), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({57,59,66,49},52) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({52,59,66,49,62},52)
debug(_d({28,52,45,63,49,6,236,52,59,66,49,62},52))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({237,237,237,236,30,17,18,33,31,21,26,19,236,32,27,236,13,28,28,24,37,236,13,14,26,27,30,25,13,24,236,34,17,24,27,15,21,32,37,6},52), finalVel, _d({45,53,57,9},52), aim, _d({60,59,63,9},52), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({52,59,66,49,62},52) then
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
debug(_d({15,59,57,46,45,64,236,56,59,47,55,236,63,55,53,60,60,49,48,248},52), snapDist, _d({63,64,65,48,63,236,50,62,59,57,236,64,45,62,51,49,64,236,174,76,96,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,57,59,66,49},52))
phase = _d({57,59,66,49},52)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then
debug(_d({20,49,45,62,64,46,49,45,64,236,49,62,62,59,62,6},52), err)
end
end)
end
local function stopNav()
debug(_d({26,45,66,236,56,59,59,60,236,27,18,18},52))
if navConn then
navConn:Disconnect()
navConn = nil
end
cleanupForce()
phase = _d({57,59,66,49},52)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({32,49,68,64,15,52,45,64,31,49,62,66,53,47,49},52))
local channels = TextChatService:FindFirstChild(_d({32,49,68,64,15,52,45,58,58,49,56,63},52))
local channel = channels and channels:FindFirstChild(_d({30,14,36,19,49,58,49,62,45,56},52))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({16,49,50,45,65,56,64,15,52,45,64,31,69,63,64,49,57,15,52,45,64,17,66,49,58,64,63},52))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({31,45,69,25,49,63,63,45,51,49,30,49,61,65,49,63,64},52))
if sayEvent then
sayEvent:FireServer(message, _d({13,56,56},52))
return
end
debug(_d({63,49,58,48,15,52,45,64,25,49,63,63,45,51,49,6,236,58,59,236,32,49,68,64,15,52,45,64,31,49,62,66,53,47,49,250,30,14,36,19,49,58,49,62,45,56,236,59,62,236,56,49,51,45,47,69,236,31,45,69,25,49,63,63,45,51,49,30,49,61,65,49,63,64,236,50,59,65,58,48,236,50,59,62},52), message)
end)
if not ok then
debug(_d({63,49,58,48,15,52,45,64,25,49,63,63,45,51,49,236,49,62,62,59,62,6},52), err)
end
end
local function waitUntilArrived(timeout)
local t = 0
local lastPos = nil
local stuckTicks = 0
local sinceStuckCheck = 0
local lastUnstuckSent = -math.huge
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
debug(
_d({26,59,64,236,57,45,55,53,58,51,236,60,62,59,51,62,49,63,63,236,64,59,67,45,62,48,236,58,45,66,236,64,45,62,51,49,64,236,50,59,62},52),
stuckTicks * UNSTUCK_CHECK_INTERVAL,
_d({63,236,249,236,63,49,58,48,53,58,51,236,251,65,58,63,64,65,47,55},52)
)
sendChatMessage(_d({251,65,58,63,64,65,47,55},52))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({67,45,53,64,33,58,64,53,56,13,62,62,53,66,49,48,236,64,53,57,49,59,65,64},52))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({58,45,66,32,59,28,59,53,58,64,15,59,58,50,53,62,57,49,48,6},52), label or _d({64,45,62,51,49,64},52), _d({249,236,48,53,48,236,58,59,64,236,45,62,62,53,66,49,236,67,53,64,52,53,58},52), timeout, _d({63,248,236,62,49,64,62,69,53,58,51,236,59,58,47,49},52))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({58,45,66,32,59,28,59,53,58,64,15,59,58,50,53,62,57,49,48,6},52), label or _d({64,45,62,51,49,64},52), _d({249,236,63,64,53,56,56,236,58,59,64,236,45,62,62,53,66,49,48,236,45,50,64,49,62,236,62,49,64,62,69,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
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
if not ok then
debug(_d({58,45,66,32,59,28,59,53,58,64,20,59,56,48,53,58,51,14,56,59,47,55,236,55,49,69,249,48,59,67,58,236,49,62,62,59,62,6},52), err)
end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then
debug(_d({58,45,66,32,59,28,59,53,58,64,20,59,56,48,53,58,51,14,56,59,47,55,236,55,49,69,249,65,60,236,49,62,62,59,62,6},52), err2)
end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
debug(_d({35,45,56,55,53,58,51,236,64,59,6},52), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then
stopNav()
end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then
debug(_d({67,45,56,55,32,59,28,59,53,58,64,236,35,236,48,59,67,58,236,49,62,62,59,62,6},52), err)
end
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
if not currentRoot then
break
end
local currentHum = getHumanoid()
if currentHum and currentHum.Health < startHP then
debug(_d({32,59,59,55,236,48,45,57,45,51,49,236,67,52,53,56,49,236,67,45,56,55,53,58,51,236,64,59,236,60,59,53,58,64,237,236,31,64,59,60,60,53,58,51,236,67,45,56,55,236,64,59,236,49,58,51,45,51,49,250},52))
break
end
if currentHum then
startHP = currentHum.Health
end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({13,62,62,53,66,49,48,236,45,64,6},52), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({31,64,65,47,55,236,48,65,62,53,58,51,236,67,45,56,55,248,236,54,65,57,60,53,58,51,237},52))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({31,64,53,56,56,236,63,64,65,47,55,248,236,64,62,53,51,51,49,62,53,58,51,236,19,49,60,60,59,237},52))
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
Workspace.CurrentCamera.CFrame = CFrame.lookAt(
Workspace.CurrentCamera.CFrame.Position,
currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
)
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
debug(_d({25,59,66,53,58,51,236,64,59},52), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,26,28,15,63,236,64,59,236,63,60,45,67,58,236,45,64},52), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(
_d({236,236,63,60,45,67,58,236,47,52,49,47,55,6,236,50,59,56,48,49,62,236,49,68,53,63,64,63,236,9},52),
folder ~= nil,
_d({248,236,47,52,53,56,48,62,49,58,236,9},52),
folder and #folder:GetChildren() or 0,
_d({248,236,45,56,53,66,49,236,9},52),
npcsRemaining()
)
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({26,59,236,26,28,15,63,236,45,60,60,49,45,62,49,48,236,45,64},52), stageName, _d({45,50,64,49,62,236,253,1,63,248,236,57,59,66,53,58,51,236,59,58,236,45,58,69,67,45,69},52))
break
end
end
debug(_d({23,53,56,56,53,58,51,236,26,28,15,63,236,45,64},52), stageName)
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
debug(_d({30,49,64,65,62,58,53,58,51,236,64,59},52), stageName, _d({60,59,63,53,64,53,59,58,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,59,58},52))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64},52), stageName, _d({60,59,63,53,64,53,59,58},52))
task.wait(5)
debug(_d({35,45,53,64,53,58,51,236,50,59,62},52), targetHP * 100, _d({241,236,20,28,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,64,59,236,58,49,68,64,236,63,64,45,51,49},52))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({47,56,49,45,62,49,48},52))
end
local function killNamedNPC(name, targetPos)
debug(_d({25,59,66,53,58,51,236,64,59},52), name)
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
debug(name, _d({48,49,50,49,45,64,49,48},52))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if not hum then
return
end
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(
_d({24,49,59,236,60,56,45,69,49,48,236,45,58,53,57,45,64,53,59,58,6},52),
track.Animation and track.Animation.Name,
"-",
track.Animation and track.Animation.AnimationId
)
end)
if not ok2 then
debug(_d({56,49,59,13,58,53,57,24,59,51,51,49,62,236,60,62,53,58,64,236,49,62,62,59,62,6},52), err2)
end
end)
end)
if not ok then
debug(_d({63,64,45,62,64,24,49,59,13,58,53,57,24,59,51,51,49,62,236,49,62,62,59,62,6},52), err)
end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({25,59,66,53,58,51,236,64,59,236,24,49,59},52))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({24,49,59},52))
if leoModel then
startLeoAnimLogger(leoModel.model)
end
equipSwordOrMelee()
setNavNamed(_d({24,49,59},52))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({24,49,59},52))
if not info then
break
end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({24,49,59,236,47,45,63,64,53,58,51},52), which, _d({249,236,48,59,48,51,53,58,51},52))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({24,49,59,236,63,64,45,62,64,49,48,236,46,56,59,47,55,249,46,62,49,45,55,49,62,236,57,53,48,249,46,56,59,47,55,237,236,17,66,45,48,53,58,51,250,250,250},52))
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
if flatDir.Magnitude < 1 then
flatDir = Vector3.new(1, 0, 0)
end
local awayPoint = myPos + (flatDir.Unit * LEO_DODGE_DISTANCE)
awayPoint = Vector3.new(awayPoint.X, bossPos.Y + HOVER_OFFSET, awayPoint.Z)
navToPoint(awayPoint, true)
if which == LEO_ENTEI_ANIM_ID then
local held = 0
while enabled and held < 6 do
task.wait(1)
held += 1
if not getNPCByName(_d({24,49,59},52)) then
debug(_d({24,49,59,236,51,59,58,49,236,57,53,48,249,48,59,48,51,49,236,249,236,49,58,48,53,58,51,236,17,58,64,49,53,236,52,59,56,48,236,49,45,62,56,69},52))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({24,49,59},52)) then
setNavNamed(_d({24,49,59},52))
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
debug(_d({24,49,59,236,48,49,50,49,45,64,49,48},52))
stopLeoAnimLogger()
debug(_d({30,49,64,65,62,58,53,58,51,236,64,59,236,24,49,59,236,60,59,63,53,64,53,59,58,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,59,58},52))
navToPointConfirmed(COORDS.Leo, 30, _d({24,49,59,236,60,59,63,53,64,53,59,58},52))
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64,236,24,49,59,236,60,59,63,53,64,53,59,58},52))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({25,59,66,53,58,51,236,64,59},52), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,63,64,45,64,65,49,236,57,59,48,49,56,236,58,49,45,62},52), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({13,64,64,45,47,55,53,58,51},52), coordKey, _d({67,53,64,52},52), weapon or _d({58,59,64,52,53,58,51,236,50,59,65,58,48},52))
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
debug(coordKey, _d({46,45,62,62,49,56,236,48,49,63,64,62,59,69,49,48},52))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({249,236,47,59,65,56,48,236,58,59,64,236,50,53,58,48,236,63,64,45,64,65,49,236,57,59,48,49,56,248,236,63,55,53,60,60,53,58,51},52))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({63,64,53,56,56,236,45,56,53,66,49,236,244,20,28},52), hp, _d({245,236,249,236,62,49,249,48,49,63,64,62,59,69,53,58,51},52))
destroyStatue(coordKey)
else
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,6},52), coordKey, _d({47,59,58,50,53,62,57,49,48,236,48,49,63,64,62,59,69,49,48},52))
end
end)
if not ok then
debug(_d({62,49,47,52,49,47,55,31,64,45,64,65,49,236,49,62,62,59,62,6},52), coordKey, err)
end
end
local function fightQueenUntilPhase2()
debug(_d({25,59,66,53,58,51,236,64,59,236,29,65,49,49,58},52))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
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
debug(_d({29,65,49,49,58,236,49,58,64,49,62,49,48,236,60,52,45,63,49,236,254},52))
end
local function finishQueen()
debug(_d({18,53,58,53,63,52,53,58,51,236,29,65,49,49,58},52))
equipSwordOrMelee()
setNavNamed(_d({15,65,60,53,48,236,29,65,49,49,58},52))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({15,65,60,53,48,236,29,65,49,49,58},52))
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
debug(_d({29,65,49,49,58,236,48,49,50,49,45,64,49,48,250,236,28,56,45,58,236,47,59,57,60,56,49,64,49,250},52))
end
local CONFIRMATION_PROMPT_NAME = _d({15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64},52)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then
return nil
end
return prompt:WaitForChild(_d({30,49,57,59,64,49,17,66,49,58,64},52), 5)
end)
if ok then
return result
end
debug(_d({51,49,64,30,49,60,56,45,69,30,49,57,59,64,49,236,49,62,62,59,62,6},52), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({28,56,45,69,49,62,19,65,53},52))
if not playerGui then
return nil
end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({21,57,45,51,49,14,65,64,64,59,58},52)) then
local ok2, val = pcall(function()
return obj:GetAttribute(_d({46,65,64,64,59,58,34,45,56,65,49},52))
end)
if ok2 and val == value then
return obj
end
end
end
return nil
end)
if ok then
return result
end
debug(_d({50,53,58,48,14,65,64,64,59,58,14,69,34,45,56,65,49,236,49,62,62,59,62,6},52), result)
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
if not ok then
debug(_d({47,56,53,47,55,19,65,53,14,65,64,64,59,58,236,49,62,62,59,62,6},52), err)
end
end
local function findAnswerConnector(button)
local ok, connector, isServer = pcall(function()
local inst = button
for _ = 1, 8 do
inst = inst.Parent
if not inst then
return nil, nil
end
local isServerAttr = inst:GetAttribute(_d({53,63,31,49,62,66,49,62},52))
if isServerAttr ~= nil then
local child = isServerAttr and inst:FindFirstChild(_d({30,49,57,59,64,49,17,66,49,58,64},52)) or inst:FindFirstChild(_d({47,56,53,49,58,64,17,66,49,58,64},52))
if child then
return child, isServerAttr
end
end
end
return nil, nil
end)
if ok then
return connector, isServer
end
debug(_d({50,53,58,48,13,58,63,67,49,62,15,59,58,58,49,47,64,59,62,236,49,62,62,59,62,6},52), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({15,59,65,56,48,236,58,59,64,236,56,59,47,45,64,49,236,30,49,57,59,64,49,17,66,49,58,64,251,47,56,53,49,58,64,17,66,49,58,64,236,58,49,45,62,236,30,49,60,56,45,69,236,46,65,64,64,59,58,248,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,47,56,53,47,55},52))
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
debug(_d({50,53,62,49,30,49,60,56,45,69,34,45,56,65,49,236,49,62,62,59,62,6},52), err, _d({249,236,50,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,47,56,53,47,55},52))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({18,45,56,56,53,58,51,236,46,45,47,55,236,64,59,236,46,65,64,64,59,58,34,45,56,65,49,236,63,49,45,62,47,52,236,50,59,62,236,30,49,60,56,45,69},52))
local waited = 0
local button = nil
while enabled and waited < REPLAY_PROMPT_TIMEOUT do
button = findButtonByValue(REPLAY_BUTTON_VALUE)
if button then
break
end
task.wait(0.5)
waited += 0.5
end
if not button then
debug(_d({30,49,60,56,45,69,236,46,65,64,64,59,58,236,58,59,64,236,50,59,65,58,48,236,49,53,64,52,49,62,248,236,51,53,66,53,58,51,236,65,60},52))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,250,30,49,57,59,64,49,17,66,49,58,64},52))
local remote = getReplayRemote()
if not remote then
debug(_d({15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,251,30,49,57,59,64,49,17,66,49,58,64,236,58,59,64,236,50,59,65,58,48,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64},52))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({18,53,62,53,58,51,236,30,49,60,56,45,69,236,66,53,45,236,15,59,58,50,53,62,57,45,64,53,59,58,28,62,59,57,60,64,250,30,49,57,59,64,49,17,66,49,58,64},52))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({18,53,62,49,31,49,62,66,49,62,236,49,62,62,59,62,6},52), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52), 10)
if not playerGui then
debug(_d({67,45,53,64,18,59,62,27,46,54,49,47,64,53,66,49,63,19,65,53,6,236,58,59,236,28,56,45,69,49,62,19,65,53,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({27,46,54,49,47,64,53,66,49,63,236,19,33,21,236,50,59,65,58,48,236,249,236,63,64,45,51,49,236,56,59,45,48,49,48},52))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({27,46,54,49,47,64,53,66,49,63,236,19,33,21,236,58,59,64,236,50,59,65,58,48,236,67,53,64,52,53,58,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
return
end
end
end)
if not ok then
debug(_d({67,45,53,64,18,59,62,27,46,54,49,47,64,53,66,49,63,19,65,53,236,49,62,62,59,62,6},52), err)
end
end
local function runPlan()
debug(_d({28,56,45,58,236,63,64,45,62,64,49,48},52))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({31,64,45,62,64,53,58,51,236,58,45,66,236,56,59,59,60},52))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({60,59,63,236,252,250,254,63,236,13,18,32,17,30,236,63,64,45,62,64,26,45,66,6},52), rootAfter and rootAfter.Position)
end)
debug(_d({35,45,53,64,53,58,51,236,1,63,236,46,49,50,59,62,49,236,57,59,66,53,58,51,236,64,59,236,31,64,45,51,49,253},52))
task.wait(5)
for _, stage in ipairs({ _d({31,64,45,51,49,253},52), _d({31,64,45,51,49,254},52), _d({31,64,45,51,49,255},52), _d({31,64,45,51,49,255,14},52) }) do
if not enabled then
return
end
local hpTarget = (stage == _d({31,64,45,51,49,255,14},52)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then
return
end
debug(_d({25,59,66,53,58,51,236,64,59,236,45,62,62,59,67,236,50,56,69,249,48,59,67,58,236,45,62,49,45,236,244,15,65,60,53,48,236,30,45,53,58,245},52))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({16,59,48,51,53,58,51,236,45,62,62,59,67,236,62,45,53,58,236,53,58,236,45,236,63,61,65,45,62,49},52))
local elapsed = 0
local d = ARROW_DODGE_DISTANCE
local corners = {
COORDS.ArrowFlyDown + Vector3.new(d, 0, d),
COORDS.ArrowFlyDown + Vector3.new(-d, 0, d),
COORDS.ArrowFlyDown + Vector3.new(-d, 0, -d),
COORDS.ArrowFlyDown + Vector3.new(d, 0, -d),
}
local startT = tick()
local cornerIdx = 1
while enabled and (tick() - startT) < ARROW_HOVER_WAIT do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if not enabled then
return
end
clearStage(_d({31,64,45,51,49,0},52))
if not enabled then
return
end
fightLeo()
if not enabled then
return
end
fightQueenUntilPhase2()
debug(_d({29,65,49,49,58,236,53,58,236,60,52,45,63,49,236,254,236,249,236,55,49,49,60,53,58,51,236,23,49,58,236,20,45,55,53,236,45,47,64,53,66,49,236,50,62,59,57,236,52,49,62,49,236,59,58},52))
startKenKeeper()
if not enabled then
return
end
destroyStatue(_d({31,64,45,64,65,49,253},52))
if not enabled then
return
end
recheckStatue(_d({31,64,45,64,65,49,253},52))
destroyStatue(_d({31,64,45,64,65,49,254},52))
if not enabled then
return
end
recheckStatue(_d({31,64,45,64,65,49,253},52))
recheckStatue(_d({31,64,45,64,65,49,254},52))
destroyStatue(_d({31,64,45,64,65,49,255},52))
if not enabled then
return
end
recheckStatue(_d({31,64,45,64,65,49,255},52))
recheckStatue(_d({31,64,45,64,65,49,254},52))
recheckStatue(_d({31,64,45,64,65,49,253},52))
if not enabled then
return
end
debug(_d({35,45,53,64,53,58,51,236,50,59,62,236,60,52,45,63,49,236,254,236,64,59,236,49,58,48},52))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({28,52,45,63,49,236,254,236,49,58,48,236,67,45,53,64,236,64,53,57,49,59,65,64,248,236,60,62,59,47,49,49,48,53,58,51,236,45,58,69,67,45,69},52))
break
end
end
if not enabled then
return
end
finishQueen()
if not enabled then
return
end
debug(_d({25,59,66,53,58,51,236,46,45,47,55,236,64,59,236,29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
navToPointConfirmed(COORDS.Queen, 30, _d({29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
debug(_d({35,45,53,64,53,58,51,236,1,63,236,45,64,236,29,65,49,49,58,236,63,64,45,51,49,236,60,59,63,53,64,53,59,58},52))
task.wait(5)
if not enabled then
return
end
debug(_d({25,59,66,53,58,51,236,64,59,236,60,59,63,64,249,29,65,49,49,58,236,60,59,63,53,64,53,59,58},52))
navToPointConfirmed(COORDS.PostQueen, 30, _d({60,59,63,64,249,29,65,49,49,58,236,60,59,63,53,64,53,59,58},52))
if not enabled then
return
end
handleReplayPrompt()
enabled = false
stopNav()
end
local CupidDungeon = {
Connections = {},
}
local function enableBot()
if enabled then
return
end
enabled = true
local rootBefore = Core.GetRoot(LocalPlayer)
debug(_d({17,58,45,46,56,53,58,51,248,236,60,59,63,236,14,17,18,27,30,17,236,60,56,45,58,6},52), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then
debug(_d({28,56,45,58,236,49,62,62,59,62,6},52), err2)
end
end)
debug(_d({17,58,45,46,56,49,48,6},52), enabled)
end
local function disableBot()
if not enabled then
return
end
enabled = false
stopNav()
debug(_d({17,58,45,46,56,49,48,6},52), enabled)
end
function CupidDungeon.Start()
if enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.RequirePlace(11424731604, _d({15,65,60,53,48,236,16,65,58,51,49,59,58},52)) then
return
end
enableBot()
end
function CupidDungeon.Stop()
if not enabled then
return
end
disableBot()
end
Core.SetupStandalone(CupidDungeon, _d({15,65,60,53,48,236,16,65,58,51,49,59,58},52), CupidDungeon.Start, CupidDungeon.Stop, function()
return enabled
end)
return CupidDungeon
end
local function loadHoroBossFarm()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({22,65,70,59,236,64,52,49,236,16,53,45,57,59,58,48,46,45,47,55},52),
UseE = true,
UseZ = true,
UseC = true,
UseR = true,
},
}
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local bp = LocalPlayer:FindFirstChild(_d({14,45,47,55,60,45,47,55},52))
local char = LocalPlayer.Character
if not char then
return nil
end
local tool = char:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)) or (bp and bp:FindFirstChild(_d({20,59,62,59,249,20,59,62,59},52)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if hum then
hum:EquipTool(tool)
end
end
return tool
end
local function getBossPart(name)
if not name or name == "" then
return nil
end
local npts = Workspace:FindFirstChild(_d({26,28,15,63},52))
if not npts then
return nil
end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hum = boss:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
if root and hum and hum.Health > 0 then
return root
end
end
return nil
end
local function setupHook()
if _G.HoroMouseHooked then
return
end
_G.HoroMouseHooked = true
local Mouse = LocalPlayer:GetMouse()
local successHook, err = pcall(function()
local mt = getrawmetatable(game)
local oldIndex = mt.__index
if setreadonly then
setreadonly(mt, false)
elseif make_writeable then
make_writeable(mt)
end
mt.__index = newcclosure(function(self, key)
if not checkcaller() and self == Mouse and HoroFarm.Running and HoroFarm.Config.SelectedBoss then
local target = getBossPart(HoroFarm.Config.SelectedBoss)
if target then
if key == _d({20,53,64},52) then
return target.CFrame
elseif key == _d({32,45,62,51,49,64},52) then
return target
end
end
end
return oldIndex(self, key)
end)
if setreadonly then
setreadonly(mt, true)
elseif make_readonly then
make_readonly(mt)
end
end)
if not successHook then
warn(_d({39,20,59,62,59,18,45,62,57,41,236,25,49,64,45,64,45,46,56,49,236,52,59,59,55,236,50,45,53,56,49,48,6,236},52) .. tostring(err))
end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do
conn:Disconnect()
end
HoroFarm.Connections = {}
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,59,60,60,49,48,250},52))
end
function HoroFarm.Start()
if HoroFarm.Running then
warn(_d({39,20,59,62,59,18,45,62,57,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237},52))
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
HoroFarm.Running = true
setupHook()
print(_d({39,20,59,62,59,18,45,62,57,41,236,31,64,45,62,64,49,48,236,64,45,62,51,49,64,53,58,51,6,236},52) .. HoroFarm.Config.SelectedBoss)
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
if HoroFarm.Config.UseE then
baseCD = 17
elseif HoroFarm.Config.UseZ then
baseCD = 10
end
local elapsed = tick() - comboStart
local finalSleep = math.max(baseCD - elapsed, 1)
task.wait(finalSleep)
end
end
end)
end
Core.SetupStandalone(HoroFarm, _d({20,59,62,59,18,45,62,57},52), HoroFarm.Start, HoroFarm.Stop, function()
return HoroFarm.Running
end)
return HoroFarm
end
local function loadLevelGrinder()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {},
}
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
for _, conn in ipairs(LevelGrinder.Connections) do
conn:Disconnect()
end
LevelGrinder.Connections = {}
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,31,64,59,60,60,49,48,250},52))
end
function LevelGrinder.Start()
if LevelGrinder.Running then
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,13,56,62,49,45,48,69,236,62,65,58,58,53,58,51,237},52))
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.RequirePlace(3978370137, _d({18,53,62,63,64,236,31,49,45},52)) then
return
end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52), 10)
local hum = char:WaitForChild(_d({20,65,57,45,58,59,53,48},52), 10)
local stats = ReplicatedStorage:WaitForChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({28,49,56,53},52), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52)) or (char and char:FindFirstChild(_d({30,53,50,56,49},52)))
if hasRifle then
break
end
local peli = Core.GetPeli()
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,15,65,62,62,49,58,64,236,28,49,56,53,236,47,52,49,47,55,6},52), peli)
local inTown = hrp
and hrp.Position.X >= -889
and hrp.Position.X <= -156
and hrp.Position.Z >= -3706
and hrp.Position.Z <= -3087
if not inTown then
warn(
_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,26,59,64,236,45,64,236,32,59,67,58,236,59,50,236,14,49,51,53,58,58,53,58,51,63,250,236,28,56,49,45,63,49,236,64,62,45,66,49,56,236,64,52,49,62,49,236,64,59,236,50,45,62,57,236,47,52,49,63,64,63,236,67,52,53,56,49,236,67,45,53,64,53,58,51,236,50,59,62,236,30,53,50,56,49,250},52)
)
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local LocalPlayer = Players.LocalPlayer
local ChestFarmer = {
Running = false,
Connections = {},
}
local ARRIVE_DIST = 6
local TRAVEL_HEIGHT = 4
local ISLAND_MIN_X = -889
local ISLAND_MAX_X = -156
local ISLAND_MIN_Z = -3706
local ISLAND_MAX_Z = -3087
local function isInsideTownOfBeginnings(pos)
return pos.X >= ISLAND_MIN_X and pos.X <= ISLAND_MAX_X and pos.Z >= ISLAND_MIN_Z and pos.Z <= ISLAND_MAX_Z
end
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
function ChestFarmer.CollectChests()
local chests = {}
local env = workspace:FindFirstChild(_d({17,58,66},52)) or workspace
for _, v in ipairs(env:GetDescendants()) do
if v:IsA(_d({28,62,59,68,53,57,53,64,69,28,62,59,57,60,64},52)) then
local action = v.ActionText or ""
if action:find(_d({28,49,56,53,236,15,52,49,63,64},52)) then
local part = v.Parent
if part and part:IsA(_d({14,45,63,49,28,45,62,64},52)) and isInsideTownOfBeginnings(part.Position) then
table.insert(chests, {
prompt = v,
position = part.Position,
label = string.format(_d({244,241,250,252,50,248,236,241,250,252,50,248,236,241,250,252,50,245},52), part.Position.X, part.Position.Y, part.Position.Z),
})
end
end
end
end
return chests
end
function ChestFarmer.Stop()
ChestFarmer.Running = false
for _, conn in ipairs(ChestFarmer.Connections) do
conn:Disconnect()
end
ChestFarmer.Connections = {}
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,31,64,59,60,60,49,48,250},52))
end
function ChestFarmer.FarmUntilPeli(targetPeli, getPeliCallback, isRunningCallback)
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,31,64,45,62,64,49,48,236,47,52,49,63,64,236,50,45,62,57,250,236,32,45,62,51,49,64,236,28,49,56,53,6,236},52) .. tostring(targetPeli))
local EasyTravel = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)), char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({18,53,63,52,57,45,58,236,15,45,66,49},52))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,49,58,45,46,56,49,48,250},52))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,48,53,63,45,46,56,49,48,250},52))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({17,45,63,69,236,32,62,45,66,49,56},52), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
while isRunningCallback() and getPeliCallback() < targetPeli do
local chests = ChestFarmer.CollectChests()
if #chests == 0 then
print(_d({39,15,52,49,63,64,18,45,62,57,49,62,41,236,26,59,236,47,52,49,63,64,63,236,50,59,65,58,48,250,236,35,45,53,64,53,58,51,236,254,252,236,63,49,47,59,58,48,63,236,50,59,62,236,63,60,45,67,58,250,250,250},52))
local waited = 0
while isRunningCallback() and waited < 20 do
task.wait(1)
waited = waited + 1
if getPeliCallback() >= targetPeli then
return true
end
end
else
local root = Core.GetRoot(LocalPlayer)
if root then
local startPos = root.Position
table.sort(chests, function(a, b)
return (a.position - startPos).Magnitude < (b.position - startPos).Magnitude
end)
end
for _, chest in ipairs(chests) do
if not isRunningCallback() or getPeliCallback() >= targetPeli then
break
end
if EasyTravel then
EasyTravel.TargetPosition = chest.position + Vector3.new(0, TRAVEL_HEIGHT, 0)
if not EasyTravel.Enabled then
pcall(EasyTravel.Start)
end
end
local elapsed = 0
local reached = false
while isRunningCallback() and elapsed < 20 do
task.wait(0.1)
elapsed = elapsed + 0.1
local myRoot = Core.GetRoot(LocalPlayer)
if myRoot then
local dist = (myRoot.Position - chest.position).Magnitude
if dist <= ARRIVE_DIST then
reached = true
break
end
else
task.wait(1)
end
end
if reached and isRunningCallback() then
if EasyTravel then
local myRoot = Core.GetRoot(LocalPlayer)
if myRoot then
EasyTravel.TargetPosition = myRoot.Position
end
end
if chest.prompt and chest.prompt.Parent then
local holdTime = chest.prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, chest.prompt)
else
pcall(function()
chest.prompt.Triggered:Fire(LocalPlayer)
end)
end
task.wait(2.5)
end
end
end
end
task.wait(0.2)
end
if EasyTravel then
EasyTravel.TargetPosition = nil
pcall(EasyTravel.Stop)
end
return getPeliCallback() >= targetPeli
end
function ChestFarmer.Start()
if ChestFarmer.Running then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
ChestFarmer.Running = true
task.spawn(function()
ChestFarmer.FarmUntilPeli(9999999, function()
return 0
end, function()
return ChestFarmer.Running
end)
end)
end
Core.SetupStandalone(ChestFarmer, _d({15,52,49,63,64,18,45,62,57,49,62},52), ChestFarmer.Start, ChestFarmer.Stop, function()
return ChestFarmer.Running
end)
return ChestFarmer
end)()
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,45,62,57,53,58,51,236,47,52,49,63,64,63,236,65,58,64,53,56,236,255,252,252,236,28,49,56,53,250,250,250,236,244,15,65,62,62,49,58,64,6,236},52) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({28,49,56,53},52))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running
and not (LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52)) or (c and c:FindFirstChild(_d({30,53,50,56,49},52))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)), char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({18,53,63,52,57,45,58,236,15,45,66,49},52))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,49,58,45,46,56,49,48,250},52))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,48,53,63,45,46,56,49,48,250},52))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({17,45,63,69,236,32,62,45,66,49,56},52), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({14,65,69,45,46,56,49,21,64,49,57,63},52))
local shopItem = buyables and buyables:FindFirstChild(_d({30,53,50,56,49},52))
local shopPart = shopItem and shopItem:FindFirstChild(_d({31,52,59,60,28,45,62,64},52))
if EasyTravel and shopPart and hrp then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,32,62,45,66,49,56,53,58,51,236,64,59,236,30,53,50,56,49,236,63,52,59,60,236,66,53,45,236,17,45,63,69,32,62,45,66,49,56,250,250,250},52))
local nocollide = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.TargetPosition = shopPart.Position
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then
break
end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
nocollide:Disconnect()
task.wait(0.5)
local shopEvent = ReplicatedStorage:FindFirstChild(_d({17,66,49,58,64,63},52))
and ReplicatedStorage.Events:FindFirstChild(_d({31,52,59,60},52))
if shopEvent and shopEvent:IsA(_d({30,49,57,59,64,49,18,65,58,47,64,53,59,58},52)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,17,61,65,53,60,60,53,58,51,236,30,53,50,56,49,250,250,250},52))
local args = {
[1] = _d({49,61,65,53,60},52),
[2] = _d({30,53,50,56,49},52),
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({17,66,49,58,64,63},52))
and ReplicatedStorage.Events:FindFirstChild(_d({32,59,59,56,63},52))
if toolsEvent and toolsEvent:IsA(_d({30,49,57,59,64,49,18,65,58,47,64,53,59,58},52)) then
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
if not LevelGrinder.Running then
return
end
local char = LocalPlayer.Character
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
local hrp = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({30,53,50,56,49},52))
if rifle and hum then
hum:EquipTool(rifle)
end
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,56,69,53,58,51,236,64,59,236,18,53,63,52,57,45,58,236,15,45,66,49,250,250,250},52))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)), char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({18,53,63,52,57,45,58,236,15,45,66,49},52))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,49,58,45,46,56,49,48,250},52))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,48,53,63,45,46,56,49,48,250},52))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({17,45,63,69,236,32,62,45,66,49,56},52), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
if EasyTravel and hrp then
local wasAtShop = hrp.Position.X >= -889
and hrp.Position.X <= -156
and hrp.Position.Z >= -3706
and hrp.Position.Z <= -3087
if wasAtShop then
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,17,63,47,45,60,53,58,51,236,63,52,59,60,236,53,58,64,49,62,53,59,62,236,46,69,236,50,56,69,53,58,51,236,63,64,62,45,53,51,52,64,236,65,60,250,250,250},52))
local nocollide = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
part.CanCollide = false
end
end
end
end)
local targetY = hrp.Position.Y + 15
EasyTravel.TargetPosition = Vector3.new(hrp.Position.X, targetY, hrp.Position.Z)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if hrp.Position.Y >= targetY - 2 then
break
end
task.wait(0.5)
end
nocollide:Disconnect()
end
local runService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local etMonitor = runService.Heartbeat:Connect(function()
if hrp then
local distPos = hrp.Position
local nearCave = distPos.X >= 1700
and distPos.X <= 1973
and distPos.Z >= -12403
and distPos.Z <= -12114
if nearCave then
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
else
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
end
end
end)
print(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,56,69,53,58,51,236,64,59,236,18,53,63,52,57,45,58,236,15,45,66,49,250,250,250},52))
EasyTravel.TargetPosition = Vector3.new(1837.4, 4.1, -12181.6)
pcall(EasyTravel.Start)
while LevelGrinder.Running and hrp do
if (hrp.Position - EasyTravel.TargetPosition).Magnitude < 8 then
break
end
task.wait(0.5)
end
pcall(EasyTravel.Stop)
etMonitor:Disconnect()
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
local pos = hrp.Position
local inCave = pos.X >= 1750 and pos.X <= 1923 and pos.Z >= -12353 and pos.Z <= -12164
if inCave then
local FishmanMaze = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local LocalPlayer = Players.LocalPlayer
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
return Safeguard
end
return Core
end)()
local FishmanMaze = {}
local mazePath = {
Vector3.new(1836.00, 4.1, -12190.00),
Vector3.new(1836.00, -86.0, -12190.00),
Vector3.new(1836.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12212.00),
Vector3.new(1770.00, -86.0, -12222.00),
Vector3.new(1767.20, -78.0, -12224.00),
Vector3.new(1767.20, -78.0, -12226.00),
Vector3.new(1767.20, -86.0, -12228.00),
Vector3.new(1790.00, -86.0, -12228.50),
Vector3.new(1791.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12243.50),
Vector3.new(1777.25, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12275.50),
Vector3.new(1802.00, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12280.00),
Vector3.new(1811.20, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12297.05),
Vector3.new(1846.00, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12305.55),
Vector3.new(1821.20, -86.0, -12320.00),
Vector3.new(1819.20, -78.0, -12322.00),
Vector3.new(1819.20, -78.0, -12324.00),
Vector3.new(1819.20, -86.0, -12326.00),
Vector3.new(1819.20, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12327.75),
Vector3.new(1793.70, -86.0, -12330.50),
}
function FishmanMaze.Travel(hrp, isRunning)
if not hrp or not Core then
return
end
local EasyTravel = (function()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)), char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({18,53,63,52,57,45,58,236,15,45,66,49},52))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,49,58,45,46,56,49,48,250},52))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,48,53,63,45,46,56,49,48,250},52))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({17,45,63,69,236,32,62,45,66,49,56},52), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end)()
if not EasyTravel then
warn(_d({39,18,53,63,52,57,45,58,236,25,45,70,49,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,236,17,45,63,69,32,62,45,66,49,56,237},52))
return
end
if EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
print(_d({39,18,53,63,52,57,45,58,236,25,45,70,49,41,236,31,64,45,62,64,53,58,51,236,17,45,63,69,32,62,45,66,49,56,249,46,45,63,49,48,236,57,45,70,49,236,64,62,45,66,49,62,63,45,56,250,250,250},52))
local nocollide = RunService.Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({14,45,63,49,28,45,62,64},52)) then
part.CanCollide = false
end
end
end
end)
EasyTravel.DisableRaycasting = true
EasyTravel.DisableWallTouch = true
EasyTravel.Speed = 25
for i, target in ipairs(mazePath) do
EasyTravel.TargetPosition = target
pcall(EasyTravel.Start)
while (hrp.Position - target).Magnitude > 4 do
if isRunning and not isRunning() then
break
end
RunService.Heartbeat:Wait()
end
if isRunning and not isRunning() then
break
end
end
pcall(EasyTravel.Stop)
EasyTravel.DisableRaycasting = false
EasyTravel.DisableWallTouch = false
nocollide:Disconnect()
print(_d({39,18,53,63,52,57,45,58,236,25,45,70,49,41,236,15,59,57,60,56,49,64,49,250},52))
end
return FishmanMaze
end)()
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function()
return LevelGrinder.Running
end)
end)
else
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,18,45,53,56,49,48,236,64,59,236,53,57,60,59,62,64,236,18,53,63,52,57,45,58,25,45,70,49,236,56,53,46,62,45,62,69,237},52))
end
else
warn(_d({39,24,49,66,49,56,236,19,62,53,58,48,49,62,41,236,27,65,64,63,53,48,49,236,18,53,63,52,57,45,58,236,15,45,66,49,236,46,59,65,58,48,63,248,236,63,55,53,60,60,53,58,51,236,57,45,70,49,250},52))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(LevelGrinder, _d({24,49,66,49,56,236,19,62,53,58,48,49,62},52), LevelGrinder.Start, LevelGrinder.Stop, function()
return LevelGrinder.Running
end)
return LevelGrinder
end
local function loadNavigationLab()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local Core = (function()
local Core = {}
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({28,49,56,53},52))
if not (peliValueObj and peliValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
peliValueObj = nested and nested:FindFirstChild(_d({28,49,56,53},52))
end
levelValueObj = statsFolder:FindFirstChild(_d({24,49,66,49,56},52))
if not (levelValueObj and levelValueObj:IsA(_d({34,45,56,65,49,14,45,63,49},52))) then
local nested = statsFolder:FindFirstChild(_d({31,64,45,64,63},52))
levelValueObj = nested and nested:FindFirstChild(_d({24,49,66,49,56},52))
end
staminaValueObj = statsFolder:FindFirstChild(_d({31,64,45,57,53,58,45},52))
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
local hum = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48},52))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then
return
end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local connection = UserInputService.InputBegan:Connect(function(input, processed)
if processed then
return
end
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
if not game:IsLoaded() then
game.Loaded:Wait()
end
startCallback()
end)
end
print("[" .. tostring(name) .. _d({41,236,31,64,45,58,48,45,56,59,58,49,236,25,59,48,49,6,236,28,62,49,63,63,236,243},52) .. toggleKey.Name .. _d({243,236,64,59,236,64,59,51,51,56,49,250},52))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({22,55,254,22,23,32,13,23,15,50},52),
TeleportLocation = _d({253,63,64,31,49,45},52),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({18,53,62,63,64,236,31,49,45,236,20,59,57,49,63,47,62,49,49,58,236,251,236,25,45,53,58,236,25,49,58,65},52),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({63,64,62,53,58,51},52) and code ~= "" then
print(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,22,59,53,58,53,58,51,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,236,243,241,63,243,250,250,250},52), code))
task.spawn(function()
local rs = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local reservedRemote = rs:WaitForChild(_d({17,66,49,58,64,63},52)):WaitForChild(_d({62,49,63,49,62,66,49,48},52))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) and (v.Name == _d({30,49,57,59,64,49,17,66,49,58,64},52) or v.Name == _d({64,49,56,49},52) or v.Name == _d({32,49,56,49,60,59,62,64},52))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,53,62,53,58,51,236,64,49,56,49,60,59,62,64,236,62,49,57,59,64,49,6,236},52) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,15,59,65,56,48,236,58,59,64,236,50,53,58,48,236,30,49,57,59,64,49,17,66,49,58,64,236,53,58,236,58,53,56,250,236,28,62,53,58,64,53,58,51,236,45,56,56,236,30,49,57,59,64,49,17,66,49,58,64,63,236,53,58,236,58,53,56,6},52))
for _, v in next, getnilinstances() do
if v:IsA(_d({30,49,57,59,64,49,17,66,49,58,64},52)) then
print(_d({236,249,236,26,45,57,49,6},52), v.Name)
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
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,31,47,62,53,60,64,236,49,68,49,47,65,64,53,59,58,236,46,56,59,47,55,49,48,236,59,58,6,236},52) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,51,45,57,49,236,65,58,53,66,49,62,63,49,237,236,31,47,62,53,60,64,236,53,63,236,59,58,56,69,236,50,59,62,236,19,28,27,250},52))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({39,31,45,50,49,51,65,45,62,48,41,236,37,59,65,236,45,62,49,236,59,58,236,64,52,49,236,20,59,57,49,63,47,62,49,49,58,250,236,31,47,62,53,60,64,236,62,49,61,65,53,62,49,63,236,241,63,250},52), name or _d({45,236,63,60,49,47,53,50,53,47,236,60,56,45,47,49},52)))
if Safeguard.JoinPrivateServer() then
print(_d({39,31,45,50,49,51,65,45,62,48,41,236,32,49,56,49,60,59,62,64,53,58,51,236,64,59,236,28,62,53,66,45,64,49,236,31,49,62,66,49,62,250,250,250,236,28,56,49,45,63,49,236,67,45,53,64,250},52))
else
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,28,62,53,66,45,64,49,31,49,62,66,49,62,15,59,48,49,236,53,63,236,58,59,64,236,63,49,64,250,236,15,45,58,58,59,64,236,45,65,64,59,249,54,59,53,58,250},52))
end
return false
end
warn(
string.format(
_d({39,31,45,50,49,51,65,45,62,48,41,236,35,62,59,58,51,236,60,56,45,47,49,237,236,30,49,61,65,53,62,49,48,6,236,241,63,236,244,241,48,245,248,236,15,65,62,62,49,58,64,6,236,241,48},52),
name or _d({33,58,55,58,59,67,58},52),
placeId,
game.PlaceId
)
)
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
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local EasyTravel = {
TargetPosition = nil,
DisableKeyboard = false,
Speed = 70.0,
Enabled = false,
DisableRaycasting = false,
DisableWallTouch = false,
Connections = {},
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
if not char then
return nil, nil, nil
end
return char, char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)), char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52)
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
local force = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,17,45,63,69,32,62,45,66,49,56,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end
end
function EasyTravel.GetSurfaceY(position, character)
local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = { character }
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
if not char or not root then
continue
end
local currentPos = root.Position
local inRoughWaters = currentPos.X >= 1002.01
and currentPos.X <= 3049.91
and currentPos.Z >= -11748.53
and currentPos.Z <= -9700.63
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
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local hitCave = false
local cave = Workspace.Islands:FindFirstChild(_d({18,53,63,52,57,45,58,236,15,45,66,49},52))
if cave and moveDir and moveDir.Magnitude > 0 then
local caveRayParams = RaycastParams.new()
caveRayParams.FilterType = Enum.RaycastFilterType.Include
caveRayParams.FilterDescendantsInstances = { cave }
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
raycastParams.FilterDescendantsInstances = { char }
raycastParams.IgnoreWater = true
if moveDir.Magnitude > 0 then
local moveUnit = moveDir.Unit
local perpUnit = Vector3.new(-moveUnit.Z, 0, moveUnit.X).Unit
local forwardHit = Workspace:Raycast(currentPos, moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos - (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
end
if not forwardHit then
forwardHit =
Workspace:Raycast(currentPos + (perpUnit * 2.5), moveUnit * FORWARD_SCAN_DISTANCE, raycastParams)
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
if EasyTravel.Enabled then
return
end
if not Safeguard then
warn(_d({39,31,45,50,49,51,65,45,62,48,41,236,18,45,53,56,49,48,236,64,59,236,56,59,45,48,237},52))
return
end
if not Safeguard.IsSafe() then
return
end
EasyTravel.Enabled = true
cleanupForce()
local char, hum, root = getCharacterComponents()
if not root or not hum then
return
end
EasyTravel.Enabled = true
currentTargetY = EasyTravel.GetSurfaceY(root.Position, char) + HEIGHT_OFFSET
isClimbing = false
task.spawn(runRaycastLoop)
loopConnection = RunService.Heartbeat:Connect(function(dt)
local char, _, currentRoot = getCharacterComponents()
if not currentRoot or not EasyTravel.Enabled then
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
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
if flatDiff.Magnitude > 2 then
moveDir = flatDiff.Unit
end
else
if not EasyTravel.DisableKeyboard then
if UserInputService:IsKeyDown(Enum.KeyCode.W) then
moveDir = moveDir + Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.S) then
moveDir = moveDir - Vector3.new(look.X, 0, look.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.D) then
moveDir = moveDir + Vector3.new(right.X, 0, right.Z).Unit
end
if UserInputService:IsKeyDown(Enum.KeyCode.A) then
moveDir = moveDir - Vector3.new(right.X, 0, right.Z).Unit
end
end
end
local yError = finalTargetY - currentRoot.Position.Y
local targetVelocity = Vector3.zero
if moveDir.Magnitude > 0 then
local speedMultiplier = 1
if not EasyTravel.DisableWallTouch and isClimbing and yError > 3 and distanceToWall < 6 then
speedMultiplier = 0
end
targetVelocity = moveDir.Unit * (EasyTravel.Speed * speedMultiplier)
end
local verticalVel = math.clamp(yError * HOVER_LIFT_GAIN, -50, 30)
force.VectorVelocity = Vector3.new(targetVelocity.X, verticalVel, targetVelocity.Z)
if moveDir.Magnitude > 0 then
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, currentRoot.Position + moveDir)
end
end)
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,49,58,45,46,56,49,48,250},52))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({39,17,45,63,69,236,32,62,45,66,49,56,41,236,18,56,53,51,52,64,236,48,53,63,45,46,56,49,48,250},52))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({17,45,63,69,236,32,62,45,66,49,56},52), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end
local function loadOverworldTester()
local Players = game:GetService(_d({28,56,45,69,49,62,63},52))
local RunService = game:GetService(_d({30,65,58,31,49,62,66,53,47,49},52))
local UserInputService = game:GetService(_d({33,63,49,62,21,58,60,65,64,31,49,62,66,53,47,49},52))
local ReplicatedStorage = game:GetService(_d({30,49,60,56,53,47,45,64,49,48,31,64,59,62,45,51,49},52))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({53,48,56,49},52)
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
print(_d({39,27,66,49,62,67,59,62,56,48,32,49,63,64,49,62,41},52), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then
return
end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then
return
end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({31,64,45,64,63},52) .. LocalPlayer.Name)
if not statsFolder then
return
end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = { char = char, cf = cf }
if style == _d({30,59,55,65,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({19,49,60,60,59},52), args)
elseif style == _d({14,56,45,47,55,24,49,51},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55},52), args)
elseif style == _d({23,45,57,53,63,52,53,55,53},52) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({23,45,57,53,63,52,53,55,53,19,49,60,60,59},52), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({31,55,69,236,35,45,56,55,254},52), args)
end
debug(_d({18,53,62,49,48,236,19,49,60,60,59,236,30,49,57,59,64,49},52))
end)
if not ok then
debug(_d({53,58,66,59,55,49,19,49,60,60,59,236,49,62,62,59,62,6},52), err)
end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({43,43,32,49,63,64,20,59,66,49,62,13,64,64},52)) or Instance.new(_d({13,64,64,45,47,52,57,49,58,64},52))
att.Name = _d({43,43,32,49,63,64,20,59,66,49,62,13,64,64},52)
att.Parent = root
local force = root:FindFirstChild(_d({43,43,32,49,63,64,20,59,66,49,62,18,59,62,47,49},52))
if not force then
force = Instance.new(_d({24,53,58,49,45,62,34,49,56,59,47,53,64,69},52))
force.Name = _d({43,43,32,49,63,64,20,59,66,49,62,18,59,62,47,49},52)
force.Attachment0 = att
force.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
force.RelativeTo = Enum.ActuatorRelativeTo.World
force.MaxForce = 1000000
force.VectorVelocity = Vector3.new(0, 0, 0)
force.Parent = root
end
return force
end)
if ok then
return result
end
return nil
end
local function cleanupForce()
pcall(function()
local char = LocalPlayer.Character
if not char then
return
end
local root = char:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
if not root then
return
end
local force = root:FindFirstChild(_d({43,43,32,49,63,64,20,59,66,49,62,18,59,62,47,49},52))
local att = root:FindFirstChild(_d({43,43,32,49,63,64,20,59,66,49,62,13,64,64},52))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end)
end
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
debug(_d({35,45,56,55,53,58,51,236,64,59,6},52), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then
debug(_d({67,45,56,55,32,59,28,59,53,58,64,236,35,236,48,59,67,58,236,49,62,62,59,62,6},52), err)
end
local startT = tick()
local lastDash = 0
local dashCooldown = 3
while enabled and (tick() - startT < timeout) do
local currentRoot = Core.GetRoot(LocalPlayer)
if not currentRoot then
break
end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({13,62,62,53,66,49,48,236,45,64,6},52), pos)
break
end
pcall(function()
local lookPos = Vector3.new(pos.X, currentRoot.Position.Y, pos.Z)
currentRoot.CFrame = CFrame.lookAt(currentRoot.Position, lookPos)
Workspace.CurrentCamera.CFrame = CFrame.lookAt(
Workspace.CurrentCamera.CFrame.Position,
currentRoot.Position + (lookPos - currentRoot.Position).Unit * 10
)
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
if not root then
return nil
end
local nearest, nearestDist = nil, math.huge
for _, item in ipairs(Workspace:GetDescendants()) do
if
item:IsA(_d({25,59,48,49,56},52))
and item:FindFirstChild(_d({20,65,57,45,58,59,53,48,30,59,59,64,28,45,62,64},52))
and item:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52))
then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({20,65,57,45,58,59,53,48},52)).Health > 0 then
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
if fwdFlat.Magnitude < 0.01 then
fwdFlat = Vector3.new(0, 0, 1)
end
horiz = fwdFlat.Unit * 5
end
local lookPoint = Vector3.new(root.Position.X + horiz.X, targetPos.Y, root.Position.Z + horiz.Z)
return CFrame.lookAt(root.Position, lookPoint)
end
local function disableBot()
if not enabled then
return
end
enabled = false
mode = _d({53,48,56,49},52)
if navConn then
navConn:Disconnect()
navConn = nil
end
cleanupForce()
debug(_d({32,49,63,64,49,62,236,16,53,63,45,46,56,49,48},52))
end
local function enableBot(targetMode)
if enabled then
disableBot()
end
enabled = true
mode = targetMode
debug(_d({32,49,63,64,49,62,236,17,58,45,46,56,49,48,250,236,25,59,48,49,6},52), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({28,56,45,69,49,62,236,48,53,49,48,237,236,16,53,63,45,46,56,53,58,51,236,46,59,64,250},52))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({52,59,66,49,62},52) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({48,59,48,51,49},52) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({63,61,65,45,62,49,43,48,59,48,51,49},52) then
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
local playerGui = LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52), 10)
if not playerGui then
return
end
local existingGui = playerGui:FindFirstChild(_d({27,66,49,62,67,59,62,56,48,32,49,63,64,19,65,53},52))
if existingGui then
existingGui:Destroy()
end
local screenGui = Instance.new(_d({31,47,62,49,49,58,19,65,53},52))
screenGui.Name = _d({27,66,49,62,67,59,62,56,48,32,49,63,64,19,65,53},52)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({18,62,45,57,49},52))
frame.Name = _d({25,45,53,58,18,62,45,57,49},52)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({33,21,15,59,62,58,49,62},52))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({32,49,68,64,24,45,46,49,56},52))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({188,107,103,109,187,132,91,236,15,65,60,53,48,236,17,58,51,53,58,49,236,27,66,49,62,67,59,62,56,48,236,32,49,63,64},52)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({32,49,68,64,24,45,46,49,56},52))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({31,64,45,64,65,63,6,236,21,48,56,49},52)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({32,49,68,64,14,65,64,64,59,58},52))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({33,21,15,59,62,58,49,62},52), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({32,49,68,64,14,59,68},52))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1, 1, 1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({33,21,15,59,62,58,49,62},52), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({20,59,66,49,62,236,13,46,59,66,49,236,32,45,62,51,49,64},52), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({52,59,66,49,62},52))
statusLabel.Text = _d({31,64,45,64,65,63,6,236,20,59,66,49,62,53,58,51,236},52) .. val .. _d({236,63,64,65,48,63,236,65,60},52)
end)
createInputBtn(_d({16,59,48,51,49,236,15,56,53,57,46},52), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({48,59,48,51,49},52))
statusLabel.Text = _d({31,64,45,64,65,63,6,236,16,59,48,51,49,249,52,59,56,48,53,58,51,236,244},52) .. val .. _d({236,63,64,65,48,63,245},52)
end)
createInputBtn(_d({32,49,63,64,236,31,61,65,45,62,49,236,16,59,48,51,49},52), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({63,61,65,45,62,49,43,48,59,48,51,49},52))
statusLabel.Text = _d({31,64,45,64,65,63,6,236,31,61,65,45,62,49,236,35,45,56,55,53,58,51,236,244},52) .. val .. _d({236,63,64,65,48,63,245},52)
task.spawn(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local center = root.Position
local d = val
local corners = {
center + Vector3.new(d, 0, d),
center + Vector3.new(-d, 0, d),
center + Vector3.new(-d, 0, -d),
center + Vector3.new(d, 0, -d),
}
local startT = tick()
local cornerIdx = 1
while enabled and mode == _d({63,61,65,45,62,49,43,48,59,48,51,49},52) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({63,61,65,45,62,49,43,48,59,48,51,49},52) then
disableBot()
statusLabel.Text = _d({31,64,45,64,65,63,6,236,21,48,56,49,236,244,31,61,65,45,62,49,236,48,59,48,51,49,236,48,59,58,49,245},52)
end
end)
end)
local stopBtn = Instance.new(_d({32,49,68,64,14,65,64,64,59,58},52))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({17,25,17,30,19,17,26,15,37,236,31,32,27,28},52)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({33,21,15,59,62,58,49,62},52), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({31,64,45,64,65,63,6,236,31,32,27,28,28,17,16,236,244,21,48,56,49,245},52)
local VIM = game:GetService(_d({34,53,62,64,65,45,56,21,58,60,65,64,25,45,58,45,51,49,62},52))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({39,27,66,49,62,67,59,62,56,48,32,49,63,64,49,62,41,236,24,59,45,48,49,48,236,63,65,47,47,49,63,63,50,65,56,56,69,250},52))
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({28,56,45,69,49,62,19,65,53},52), 10)
if not playerGui then
return
end
local oldUI = playerGui:FindFirstChild(_d({19,28,27,24,45,65,58,47,52,49,62,33,21},52))
if oldUI then
oldUI:Destroy()
end
local screenGui = Instance.new(_d({31,47,62,49,49,58,19,65,53},52))
screenGui.Name = _d({19,28,27,24,45,65,58,47,52,49,62,33,21},52)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({18,62,45,57,49},52))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({33,21,15,59,62,58,49,62},52))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({33,21,31,64,62,59,55,49},52))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({32,49,68,64,24,45,46,49,56},52))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({188,107,88,88,236,19,28,27,236,20,65,46,236,24,45,65,58,47,52,49,62},52)
title.Parent = main
local closeBtn = Instance.new(_d({32,49,68,64,14,65,64,64,59,58},52))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({33,21,15,59,62,58,49,62},52), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({32,49,68,64,24,45,46,49,56},52))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({15,52,59,59,63,49,236,45,236,46,59,64,236,59,62,236,65,64,53,56,53,64,69,236,64,59,236,62,65,58,6},52)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({32,49,68,64,14,65,64,64,59,58},52))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({236,236},52) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({33,21,15,59,62,58,49,62},52))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({33,21,31,64,62,59,55,49},52))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({32,49,68,64,24,45,46,49,56},52))
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
CreateLaunchButton(_d({15,65,60,53,48,236,16,65,58,51,49,59,58,236,18,45,62,57},52), _d({13,65,64,59,57,45,64,49,236,47,65,60,53,48,236,48,65,58,51,49,59,58,63,236,242,236,46,59,63,63,236,47,69,47,56,49,63},52), loadCupidDungeon)
CreateLaunchButton(_d({20,59,62,59,236,14,59,63,63,236,18,45,62,57,236,244,31,53,56,49,58,64,236,13,53,57,245},52), _d({13,65,64,59,50,45,62,57,236,59,66,49,62,67,59,62,56,48,236,46,59,63,63,49,63,236,65,63,53,58,51,236,20,59,62,59,236,50,62,65,53,64,63},52), loadHoroBossFarm)
CreateLaunchButton(_d({24,49,66,49,56,236,242,236,25,59,46,236,19,62,53,58,48,49,62},52), _d({13,65,64,59,249,56,49,66,49,56,236,45,58,48,236,50,45,62,57,236,56,59,47,45,56,236,26,28,15,236,57,59,46,63},52), loadLevelGrinder)
CreateLaunchButton(_d({17,45,63,69,236,32,62,45,66,49,56,236,244,28,236,32,59,51,51,56,49,245},52), _d({35,13,31,16,236,18,56,53,51,52,64,236,67,53,64,52,236,51,62,59,65,58,48,236,50,59,56,56,59,67,236,242,236,67,45,56,56,236,47,56,53,57,46,53,58,51},52), loadNavigationLab)
CreateLaunchButton(_d({28,52,69,63,53,47,63,236,27,66,49,62,67,59,62,56,48,236,32,49,63,64,49,62},52), _d({32,49,63,64,236,47,59,57,46,45,64,236,52,59,66,49,62,248,236,51,49,60,60,59,236,242,236,48,59,48,51,49,236,52,49,53,51,52,64,63},52), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({39,19,28,27,236,20,65,46,41,236,24,45,65,58,47,52,49,62,236,33,21,236,53,58,53,64,53,45,56,53,70,49,48,250},52))
end)()