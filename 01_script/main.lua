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
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local LocalPlayer = Players.LocalPlayer
local function loadCupidDungeon()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local Workspace = workspace
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
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({59,80,87,84},21))
if not (peliValueObj and peliValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
peliValueObj = nested and nested:FindFirstChild(_d({59,80,87,84},21))
end
levelValueObj = statsFolder:FindFirstChild(_d({55,80,97,80,87},21))
if not (levelValueObj and levelValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
levelValueObj = nested and nested:FindFirstChild(_d({55,80,97,80,87},21))
end
staminaValueObj = statsFolder:FindFirstChild(_d({62,95,76,88,84,89,76},21))
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
local hum = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79},21))
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
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
print("[" .. tostring(name) .. _d({72,11,62,95,76,89,79,76,87,90,89,80,11,56,90,79,80,37,11,59,93,80,94,94,11,18},21) .. toggleKey.Name .. _d({18,11,95,90,11,95,90,82,82,87,80,25},21))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({53,86,29,53,54,63,44,54,46,81},21),
TeleportLocation = _d({28,94,95,62,80,76},21),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({49,84,93,94,95,11,62,80,76,11,51,90,88,80,94,78,93,80,80,89,11,26,11,56,76,84,89,11,56,80,89,96},21),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({94,95,93,84,89,82},21) and code ~= "" then
print(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,53,90,84,89,84,89,82,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,11,18,16,94,18,25,25,25},21), code))
task.spawn(function()
local rs = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local reservedRemote = rs:WaitForChild(_d({48,97,80,89,95,94},21)):WaitForChild(_d({93,80,94,80,93,97,80,79},21))
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
v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) and (v.Name == _d({61,80,88,90,95,80,48,97,80,89,95},21) or v.Name == _d({95,80,87,80},21) or v.Name == _d({63,80,87,80,91,90,93,95},21))
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
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,84,93,84,89,82,11,95,80,87,80,91,90,93,95,11,93,80,88,90,95,80,37,11},21) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,61,80,88,90,95,80,48,97,80,89,95,11,84,89,11,89,84,87,25,11,59,93,84,89,95,84,89,82,11,76,87,87,11,61,80,88,90,95,80,48,97,80,89,95,94,11,84,89,11,89,84,87,37},21))
for _, v in next, getnilinstances() do
if v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
print(_d({11,24,11,57,76,88,80,37},21), v.Name)
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
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,62,78,93,84,91,95,11,80,99,80,78,96,95,84,90,89,11,77,87,90,78,86,80,79,11,90,89,37,11},21) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,68,90,96,11,76,93,80,11,90,89,11,95,83,80,11,51,90,88,80,94,78,93,80,80,89,25,11,62,78,93,84,91,95,11,93,80,92,96,84,93,80,94,11,16,94,25},21), name or _d({76,11,94,91,80,78,84,81,84,78,11,91,87,76,78,80},21)))
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
warn(
string.format(
_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,91,87,76,78,80,12,11,61,80,92,96,84,93,80,79,37,11,16,94,11,19,16,79,20,23,11,46,96,93,93,80,89,95,37,11,16,79},21),
name or _d({64,89,86,89,90,98,89},21),
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
local LEO_PILLAR_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,31,31,28,31,28,30,29,34},21)
local LEO_ENTEI_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,31,31,28,30,35,29,34,35},21)
local LEO_HIKEN_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,29,27,36,28,34,31,27,34},21)
local LEO_FIREFLY_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,32,29,29,27,29,30,33,28,32,31},21)
local LEO_DODGE_ANIMS = { LEO_PILLAR_ANIM_ID, LEO_ENTEI_ANIM_ID, LEO_HIKEN_ANIM_ID, LEO_FIREFLY_ANIM_ID }
local LEO_DODGE_DISTANCE = 100
local LEO_QUICK_BLOCK_DURATION = 1
local LEO_BLOCK_DELAY = 4
local BLOCK_KEY = Enum.KeyCode.F
local LOAD_WAIT = 15
local OBJECTIVES_GUI_NAME = _d({58,77,85,80,78,95,84,97,80,94},21)
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
local REPLAY_BUTTON_VALUE = _d({61,80,91,87,76,100},21)
local REPLAY_PROMPT_TIMEOUT = 15
local REPLAY_CLICK_SETTLE = 1
local enabled = false
local navConn = nil
local phase = _d({88,90,97,80},21)
local NavState = { mode = _d({84,79,87,80},21) }
local lastAim = nil
local lastFace = nil
local function debug(...)
print(_d({70,45,90,94,94,45,90,95,72},21), ...)
end
local function getRoot()
local ok, root = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end)
if ok then
return root
end
debug(_d({82,80,95,61,90,90,95,11,80,93,93,90,93,37},21), root)
return nil
end
local function getHumanoid()
local ok, hum = pcall(function()
local char = Players.LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
end)
if ok then
return hum
end
debug(_d({82,80,95,51,96,88,76,89,90,84,79,11,80,93,93,90,93,37},21), hum)
return nil
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({74,74,51,90,97,80,93,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,51,90,97,80,93,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,51,90,97,80,93,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,51,90,97,80,93,49,90,93,78,80},21)
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
debug(_d({82,80,95,58,93,46,93,80,76,95,80,49,90,93,78,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function cleanupForce()
local ok, err = pcall(function()
local char = Players.LocalPlayer.Character
if not char then
return
end
local root = char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then
return
end
local force = root:FindFirstChild(_d({74,74,51,90,97,80,93,49,90,93,78,80},21))
local att = root:FindFirstChild(_d({74,74,51,90,97,80,93,44,95,95},21))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end)
if not ok then
debug(_d({78,87,80,76,89,96,91,49,90,93,78,80,11,80,93,93,90,93,37},21), err)
end
end
local function isBusoActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({45,96,94,90,56,80,87,80,80},21)) ~= nil
end)
if ok then
return result
end
debug(_d({84,94,45,96,94,90,44,78,95,84,97,80,11,80,93,93,90,93,37},21), result)
return false
end
local function activateBuso()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({45,96,94,90},21))
end)
if not ok then
debug(_d({76,78,95,84,97,76,95,80,45,96,94,90,11,80,93,93,90,93,37},21), err)
end
end
local function startBusoKeeper()
task.spawn(function()
while enabled do
local ok, err = pcall(function()
if not isBusoActive() then
debug(_d({45,96,94,90,11,89,90,95,11,76,78,95,84,97,80,23,11,76,78,95,84,97,76,95,84,89,82},21))
activateBuso()
end
end)
if not ok then
debug(_d({45,96,94,90,54,80,80,91,80,93,11,80,93,93,90,93,37},21), err)
end
task.wait(BUSO_CHECK_INTERVAL)
end
debug(_d({45,96,94,90,11,86,80,80,91,80,93,11,94,95,90,91,91,80,79},21))
end)
end
local function isKenActive()
local ok, result = pcall(function()
local char = Players.LocalPlayer.Character
return char ~= nil and char:FindFirstChild(_d({54,80,89,51,76,86,84},21)) ~= nil
end)
if ok then
return result
end
debug(_d({84,94,54,80,89,44,78,95,84,97,80,11,80,93,93,90,93,37},21), result)
return false
end
local function activateKen()
local ok, err = pcall(function()
ReplicatedStorage.Events.Haki:FireServer(_d({54,80,89},21), true)
end)
if not ok then
debug(_d({76,78,95,84,97,76,95,80,54,80,89,11,80,93,93,90,93,37},21), err)
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
debug(_d({54,80,89,11,89,90,95,11,76,78,95,84,97,80,23,11,76,78,95,84,97,76,95,84,89,82},21))
activateKen()
end
end)
if not ok then
debug(_d({54,80,89,54,80,80,91,80,93,11,80,93,93,90,93,37},21), err)
end
task.wait(KEN_CHECK_INTERVAL)
end
debug(_d({54,80,89,11,86,80,80,91,80,93,11,94,95,90,91,91,80,79},21))
kenKeeperStarted = false
end)
end
local function getNPCsFolder()
local ok, folder = pcall(function()
return Workspace:FindFirstChild(_d({57,59,46,94},21))
end)
if ok then
return folder
end
debug(_d({82,80,95,57,59,46,94,49,90,87,79,80,93,11,80,93,93,90,93,37},21), folder)
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
local r = model:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local h = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
debug(_d({82,80,95,57,80,76,93,80,94,95,57,59,46,11,80,93,93,90,93,37},21), result)
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
local root = model:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hum = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if root and hum and hum.Health > 0 then
return { root = root, humanoid = hum, model = model }
end
return nil
end)
if ok then
return result
end
debug(_d({82,80,95,57,59,46,45,100,57,76,88,80,11,80,93,93,90,93,37},21), result)
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
local hum = m:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if hum and hum.Health > 0 then
n += 1
end
end
return n
end)
if ok then
return count
end
debug(_d({89,91,78,94,61,80,88,76,84,89,84,89,82,11,80,93,93,90,93,37},21), count)
return 0
end
local function isQueenPhase2()
local ok, result = pcall(function()
local folder = getNPCsFolder()
local queen = folder and folder:FindFirstChild(_d({46,96,91,84,79,11,60,96,80,80,89},21))
return queen ~= nil and queen:FindFirstChild(_d({88,90,95,84,90,89,55,80,94,94},21)) ~= nil
end)
if ok then
return result
end
debug(_d({84,94,60,96,80,80,89,59,83,76,94,80,29,11,80,93,93,90,93,37},21), result)
return false
end
local QUEEN_EMBRACE_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,28,29,28,29,36,34,36,31,29,29,36,29,34,33,36},21)
local QUEEN_GRASP_ANIM_ID = _d({93,77,99,76,94,94,80,95,84,79,37,26,26,28,29,36,35,27,27,27,33,28,27,27,28,34,30,31},21)
local QUEEN_BLOCK_ANIMS = { QUEEN_EMBRACE_ANIM_ID, QUEEN_GRASP_ANIM_ID }
local QUEEN_BLOCK_TIMEOUT = 3
local QUEEN_DODGE_DISTANCE = 70
local QUEEN_DODGE_DURATION = 3
local function isPlayingAnimFromList(npcModel, animList)
local ok, result, which = pcall(function()
if not npcModel then
return false
end
local hum = npcModel:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
debug(_d({84,94,59,87,76,100,84,89,82,44,89,84,88,49,93,90,88,55,84,94,95,11,80,93,93,90,93,37},21), result)
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
return npcModel ~= nil and npcModel:FindFirstChild(_d({45,87,90,78,86,84,89,82},21)) ~= nil
end)
if ok then
return result
end
debug(_d({84,94,57,59,46,45,87,90,78,86,84,89,82,11,80,93,93,90,93,37},21), result)
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
debug(_d({91,93,80,79,84,78,95,57,59,46,59,90,94,84,95,84,90,89,11,80,93,93,90,93,37},21), result)
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
debug(_d({57,90,11,79,76,88,76,82,80,11,90,89},21), model.Name, _d({81,90,93},21), NPC_STUCK_TIMEOUT, _d({94,11,24,11,94,98,84,95,78,83,84,89,82,11,95,76,93,82,80,95},21))
stuckNPCs[model] = true
end
end)
if not ok then
debug(_d({95,93,76,78,86,57,59,46,47,76,88,76,82,80,11,80,93,93,90,93,37},21), err)
end
end
local function getModelFacePos(model)
local ok, pos = pcall(function()
if model:IsA(_d({56,90,79,80,87},21)) then
if model.PrimaryPart then
return model.PrimaryPart.Position
end
return model:GetPivot().Position
elseif model:IsA(_d({45,76,94,80,59,76,93,95},21)) then
return model.Position
end
return nil
end)
if ok then
return pos
end
debug(_d({82,80,95,56,90,79,80,87,49,76,78,80,59,90,94,11,80,93,93,90,93,37},21), pos)
return nil
end
local function getStatueModelNear(coordPos)
local ok, result = pcall(function()
local env = Workspace:FindFirstChild(_d({48,89,97},21))
local folder = env and env:FindFirstChild(_d({62,95,76,95,96,80,94},21))
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
debug(_d({82,80,95,62,95,76,95,96,80,56,90,79,80,87,57,80,76,93,11,80,93,93,90,93,37},21), result)
return nil
end
local function getStatueHP(statueModel)
local ok, hp = pcall(function()
local v = statueModel:FindFirstChild(_d({77,76,93,93,80,87,51,59},21))
return v and v.Value or 0
end)
if ok then
return hp
end
debug(_d({82,80,95,62,95,76,95,96,80,51,59,11,80,93,93,90,93,37},21), hp)
return 0
end
local function findToolByAttribute(attrName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({ char, bp }) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({63,90,90,87},21)) then
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
debug(_d({81,84,89,79,63,90,90,87,45,100,44,95,95,93,84,77,96,95,80,11,80,93,93,90,93,37},21), tool)
return nil
end
local function findToolByName(toolName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({ char, bp }) do
if pool then
local t = pool:FindFirstChild(toolName)
if t and t:IsA(_d({63,90,90,87},21)) then
return t
end
end
end
return nil
end)
if ok then
return tool
end
debug(_d({81,84,89,79,63,90,90,87,45,100,57,76,88,80,11,80,93,93,90,93,37},21), tool)
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
debug(_d({80,92,96,84,91,63,90,90,87,11,80,93,93,90,93,37},21), err)
end
return ok
end
local function findToolByChildName(childName)
local ok, tool = pcall(function()
local char = Players.LocalPlayer.Character
local bp = Players.LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
for _, pool in ipairs({ char, bp }) do
if pool then
for _, item in ipairs(pool:GetChildren()) do
if item:IsA(_d({63,90,90,87},21)) and item:FindFirstChild(childName) then
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
debug(_d({81,84,89,79,63,90,90,87,45,100,46,83,84,87,79,57,76,88,80,11,80,93,93,90,93,37},21), tool)
return nil
end
local function equipSwordOrMelee()
local sword = findToolByChildName(_d({62,98,90,93,79,48,92,96,84,91},21))
if sword then
equipTool(sword)
return _d({94,98,90,93,79},21)
end
local melee = findToolByAttribute(_d({56,80,87,80,80,63,90,90,87},21))
if melee then
equipTool(melee)
return _d({88,80,87,80,80},21)
end
debug(_d({57,90,11,94,98,90,93,79,11,90,93,11,88,80,87,80,80,11,95,90,90,87,11,81,90,96,89,79},21))
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
debug(_d({78,87,84,78,86,56,28,11,80,93,93,90,93,37},21), err)
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
local root = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then
return
end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. Players.LocalPlayer.Name)
if not statsFolder then
return
end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = { char = char, cf = cf }
if style == _d({61,90,86,96,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,80,91,91,90},21), args)
elseif style == _d({45,87,76,78,86,55,80,82},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86},21), args)
elseif style == _d({54,76,88,84,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,76,88,84,94,83,84,86,84,50,80,91,91,90},21), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86,29},21), args)
end
end)
if not ok then
debug(_d({84,89,97,90,86,80,50,80,91,91,90,11,80,93,93,90,93,37},21), err)
end
end
local function pressSkillR()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.R, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.R, false, game)
end)
if not ok then
debug(_d({91,93,80,94,94,62,86,84,87,87,61,11,80,93,93,90,93,37},21), err)
end
end
local function holdBlock(duration)
local ok, err = pcall(function()
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
task.wait(duration)
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok then
debug(_d({83,90,87,79,45,87,90,78,86,11,80,93,93,90,93,37},21), err)
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
debug(_d({83,90,87,79,45,87,90,78,86,66,83,84,87,80,11,80,93,93,90,93,37},21), err)
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
debug(_d({82,80,95,50,76,88,80,50,11,80,93,93,90,93,37},21), result)
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
debug(_d({84,94,61,80,76,87,56,28,45,96,94,100,11,80,93,93,90,93,37},21), result)
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
return char ~= nil and char:FindFirstChild(_d({94,95,96,89},21)) ~= nil
end)
if ok then
return result
end
debug(_d({84,94,62,95,96,89,89,80,79,11,80,93,93,90,93,37},21), result)
return false
end
local function pressStunBreak()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)
if not ok then
debug(_d({91,93,80,94,94,62,95,96,89,45,93,80,76,86,11,80,93,93,90,93,37},21), err)
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
debug(_d({92,96,80,80,89,47,90,79,82,80,64,89,95,84,87,62,76,81,80,37,11,60,96,80,80,89,11,82,90,89,80,11,24,11,80,89,79,84,89,82,11,79,90,79,82,80,11,80,76,93,87,100},21))
break
end
local stillCasting = isQueenCastingBlockableSkill(info.model)
if not stillCasting and t >= QUEEN_DODGE_DURATION then
break
end
task.wait(0.1)
t += 0.1
if t > 15 then
debug(_d({92,96,80,80,89,47,90,79,82,80,64,89,95,84,87,62,76,81,80,11,94,76,81,80,95,100,11,95,84,88,80,90,96,95},21))
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
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
if not info then
return
end
if not queenDodging and isQueenCastingBlockableSkill(info.model) then
queenDodging = true
debug(_d({60,96,80,80,89,11,78,76,94,95,84,89,82,11,79,80,95,80,78,95,80,79,11,24,11,79,90,79,82,84,89,82,11,19,98,76,95,78,83,80,93,20},21))
queenDodgeUntilSafe(function()
return getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
end)
if enabled and getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21)) then
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
end
queenDodging = false
end
end)
if not ok then
debug(_d({92,96,80,80,89,47,90,79,82,80,66,76,95,78,83,80,93,11,80,93,93,90,93,37},21), err)
end
task.wait(0.03)
end
queenWatcherStarted = false
end)
end
local function getNavTargets()
local ok, aimR, faceR = pcall(function()
if NavState.mode == _d({91,90,84,89,95},21) and NavState.point then
return NavState.point, NavState.point
elseif NavState.mode == _d({89,91,78},21) then
local info = getNearestNPC(stuckNPCs)
if info then
trackNPCDamage(info)
local predicted = predictNPCPosition(info)
return predicted + Vector3.new(0, HOVER_OFFSET, 0), info.root.Position
end
elseif NavState.mode == _d({89,76,88,80,79},21) and NavState.name then
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
debug(_d({82,80,95,57,76,97,63,76,93,82,80,95,94,11,80,93,93,90,93,37},21), aimR)
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
debug(_d({78,90,88,91,96,95,80,55,90,78,86,80,79,46,49,93,76,88,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function setNavPoint(pos)
NavState = { mode = _d({91,90,84,89,95},21), point = pos }
phase = _d({88,90,97,80},21)
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
debug(_d({89,76,97,63,90,59,90,84,89,95,11,82,80,91,91,90,11,78,83,80,78,86,11,80,93,93,90,93,37},21), err)
end
setNavPoint(pos)
end
local function setNavNPCNearest()
NavState = { mode = _d({89,91,78},21) }
phase = _d({88,90,97,80},21)
end
function setNavNamed(name)
NavState = { mode = _d({89,76,88,80,79},21), name = name }
phase = _d({88,90,97,80},21)
end
local function setNavIdle()
NavState = { mode = _d({84,79,87,80},21) }
phase = _d({88,90,97,80},21)
end
local function hasArrived()
return phase == _d({83,90,97,80,93},21)
end
local function startNav()
phase = _d({88,90,97,80},21)
debug(_d({57,76,97,11,87,90,90,91,11,58,57},21))
navConn = RunService.Heartbeat:Connect(function(dt)
local ok, err = pcall(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({59,87,76,100,80,93,11,79,84,80,79,12,11,62,95,90,91,91,84,89,82,11,77,90,95,25},21))
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
debug(_d({59,87,76,100,80,93,11,84,94,11,95,90,90,11,81,76,93,11,81,93,90,88,11,95,76,93,82,80,95,11,19,41,29,27,27,27,11,94,95,96,79,94,20,25,11,55,84,86,80,87,100,11,93,80,94,91,76,98,89,80,79,11,76,95,11,87,90,77,77,100,25,11,62,95,90,91,91,84,89,82,11,77,90,95,25},21))
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
local prevPos = force:GetAttribute(_d({74,74,91,93,80,97,59,90,94},21))
if prevPos then
local delta = (pos - prevPos).Magnitude
if delta > 100 then
debug(_d({55,76,93,82,80,11,91,90,94,84,95,84,90,89,11,85,96,88,91,11,79,80,95,80,78,95,80,79,37},21), delta, _d({94,95,96,79,94,25,11,91,93,80,97,59,90,94,40},21), prevPos, _d({89,80,98,59,90,94,40},21), pos)
end
end
force:SetAttribute(_d({74,74,91,93,80,97,59,90,94},21), pos)
local yVel = math.clamp(yErr * 20, -HOVER_YVEL, HOVER_YVEL)
if phase == _d({88,90,97,80},21) and xzDist < XZ_THRESHOLD and math.abs(yErr) < Y_THRESHOLD then
phase = _d({83,90,97,80,93},21)
debug(_d({59,83,76,94,80,37,11,83,90,97,80,93},21))
end
local finalVel = Vector3.new(xzVel.X, yVel, xzVel.Z)
if finalVel.Magnitude > 200 then
debug(_d({12,12,12,11,61,48,49,64,62,52,57,50,11,63,58,11,44,59,59,55,68,11,44,45,57,58,61,56,44,55,11,65,48,55,58,46,52,63,68,37},21), finalVel, _d({76,84,88,40},21), aim, _d({91,90,94,40},21), pos)
finalVel = Vector3.zero
end
force.VectorVelocity = finalVel
if phase == _d({83,90,97,80,93},21) then
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
debug(_d({46,90,88,77,76,95,11,87,90,78,86,11,94,86,84,91,91,80,79,23},21), snapDist, _d({94,95,96,79,94,11,81,93,90,88,11,95,76,93,82,80,95,11,205,107,127,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,88,90,97,80},21))
phase = _d({88,90,97,80},21)
root.CFrame = computeLookDownCFrame(root, face)
end
else
root.CFrame = computeLookDownCFrame(root, face)
end
end)
end
end)
if not ok then
debug(_d({51,80,76,93,95,77,80,76,95,11,80,93,93,90,93,37},21), err)
end
end)
end
local function stopNav()
debug(_d({57,76,97,11,87,90,90,91,11,58,49,49},21))
if navConn then
navConn:Disconnect()
navConn = nil
end
cleanupForce()
phase = _d({88,90,97,80},21)
end
local function sendChatMessage(message)
local ok, err = pcall(function()
local TextChatService = game:GetService(_d({63,80,99,95,46,83,76,95,62,80,93,97,84,78,80},21))
local channels = TextChatService:FindFirstChild(_d({63,80,99,95,46,83,76,89,89,80,87,94},21))
local channel = channels and channels:FindFirstChild(_d({61,45,67,50,80,89,80,93,76,87},21))
if channel then
channel:SendAsync(message)
return
end
local chatEvents = ReplicatedStorage:FindFirstChild(_d({47,80,81,76,96,87,95,46,83,76,95,62,100,94,95,80,88,46,83,76,95,48,97,80,89,95,94},21))
local sayEvent = chatEvents and chatEvents:FindFirstChild(_d({62,76,100,56,80,94,94,76,82,80,61,80,92,96,80,94,95},21))
if sayEvent then
sayEvent:FireServer(message, _d({44,87,87},21))
return
end
debug(_d({94,80,89,79,46,83,76,95,56,80,94,94,76,82,80,37,11,89,90,11,63,80,99,95,46,83,76,95,62,80,93,97,84,78,80,25,61,45,67,50,80,89,80,93,76,87,11,90,93,11,87,80,82,76,78,100,11,62,76,100,56,80,94,94,76,82,80,61,80,92,96,80,94,95,11,81,90,96,89,79,11,81,90,93},21), message)
end)
if not ok then
debug(_d({94,80,89,79,46,83,76,95,56,80,94,94,76,82,80,11,80,93,93,90,93,37},21), err)
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
_d({57,90,95,11,88,76,86,84,89,82,11,91,93,90,82,93,80,94,94,11,95,90,98,76,93,79,11,89,76,97,11,95,76,93,82,80,95,11,81,90,93},21),
stuckTicks * UNSTUCK_CHECK_INTERVAL,
_d({94,11,24,11,94,80,89,79,84,89,82,11,26,96,89,94,95,96,78,86},21)
)
sendChatMessage(_d({26,96,89,94,95,96,78,86},21))
lastUnstuckSent = tick()
stuckTicks = 0
end
end
end
if timeout and t > timeout then
debug(_d({98,76,84,95,64,89,95,84,87,44,93,93,84,97,80,79,11,95,84,88,80,90,96,95},21))
break
end
end
end
local function navToPointConfirmed(pos, timeout, label)
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({89,76,97,63,90,59,90,84,89,95,46,90,89,81,84,93,88,80,79,37},21), label or _d({95,76,93,82,80,95},21), _d({24,11,79,84,79,11,89,90,95,11,76,93,93,84,97,80,11,98,84,95,83,84,89},21), timeout, _d({94,23,11,93,80,95,93,100,84,89,82,11,90,89,78,80},21))
navToPoint(pos)
waitUntilArrived(timeout)
if not hasArrived() then
debug(_d({89,76,97,63,90,59,90,84,89,95,46,90,89,81,84,93,88,80,79,37},21), label or _d({95,76,93,82,80,95},21), _d({24,11,94,95,84,87,87,11,89,90,95,11,76,93,93,84,97,80,79,11,76,81,95,80,93,11,93,80,95,93,100,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
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
debug(_d({89,76,97,63,90,59,90,84,89,95,51,90,87,79,84,89,82,45,87,90,78,86,11,86,80,100,24,79,90,98,89,11,80,93,93,90,93,37},21), err)
end
waitUntilArrived(timeout)
local ok2, err2 = pcall(function()
VIM:SendKeyEvent(false, BLOCK_KEY, false, game)
end)
if not ok2 then
debug(_d({89,76,97,63,90,59,90,84,89,95,51,90,87,79,84,89,82,45,87,90,78,86,11,86,80,100,24,96,91,11,80,93,93,90,93,37},21), err2)
end
end
local function walkToPoint(pos, timeout, useJumpUnstuck)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
debug(_d({66,76,87,86,84,89,82,11,95,90,37},21), pos)
local wasNavActive = (navConn ~= nil)
if wasNavActive then
stopNav()
end
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then
debug(_d({98,76,87,86,63,90,59,90,84,89,95,11,66,11,79,90,98,89,11,80,93,93,90,93,37},21), err)
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
debug(_d({63,90,90,86,11,79,76,88,76,82,80,11,98,83,84,87,80,11,98,76,87,86,84,89,82,11,95,90,11,91,90,84,89,95,12,11,62,95,90,91,91,84,89,82,11,98,76,87,86,11,95,90,11,80,89,82,76,82,80,25},21))
break
end
if currentHum then
startHP = currentHum.Health
end
local dist = (currentRoot.Position * Vector3.new(1, 0, 1) - pos * Vector3.new(1, 0, 1)).Magnitude
if dist < 5 then
debug(_d({44,93,93,84,97,80,79,11,76,95,37},21), pos)
break
end
if useJumpUnstuck then
if tick() - lastUnstuckCheck > 0.5 then
if lastPos and (currentRoot.Position - lastPos).Magnitude < 2 then
debug(_d({62,95,96,78,86,11,79,96,93,84,89,82,11,98,76,87,86,23,11,85,96,88,91,84,89,82,12},21))
stuckTicks += 1
VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
task.wait(0.05)
VIM:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
if stuckTicks > 1 then
debug(_d({62,95,84,87,87,11,94,95,96,78,86,23,11,95,93,84,82,82,80,93,84,89,82,11,50,80,91,91,90,12},21))
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
debug(_d({56,90,97,84,89,82,11,95,90},21), stageName)
walkToPoint(COORDS[stageName], 30)
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,57,59,46,94,11,95,90,11,94,91,76,98,89,11,76,95},21), stageName)
local waited = 0
while enabled and npcsRemaining() == 0 do
local folder = getNPCsFolder()
debug(
_d({11,11,94,91,76,98,89,11,78,83,80,78,86,37,11,81,90,87,79,80,93,11,80,99,84,94,95,94,11,40},21),
folder ~= nil,
_d({23,11,78,83,84,87,79,93,80,89,11,40},21),
folder and #folder:GetChildren() or 0,
_d({23,11,76,87,84,97,80,11,40},21),
npcsRemaining()
)
task.wait(1)
waited += 1
if waited > 15 then
debug(_d({57,90,11,57,59,46,94,11,76,91,91,80,76,93,80,79,11,76,95},21), stageName, _d({76,81,95,80,93,11,28,32,94,23,11,88,90,97,84,89,82,11,90,89,11,76,89,100,98,76,100},21))
break
end
end
debug(_d({54,84,87,87,84,89,82,11,57,59,46,94,11,76,95},21), stageName)
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
debug(_d({61,80,95,96,93,89,84,89,82,11,95,90},21), stageName, _d({91,90,94,84,95,84,90,89,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,90,89},21))
navToPoint(COORDS[stageName])
waitUntilArrived(30)
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95},21), stageName, _d({91,90,94,84,95,84,90,89},21))
task.wait(5)
debug(_d({66,76,84,95,84,89,82,11,81,90,93},21), targetHP * 100, _d({16,11,51,59,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,95,90,11,89,80,99,95,11,94,95,76,82,80},21))
local hum = getHumanoid()
if hum then
while enabled and hum.Health < hum.MaxHealth * targetHP do
task.wait(1)
end
end
debug(stageName, _d({78,87,80,76,93,80,79},21))
end
local function killNamedNPC(name, targetPos)
debug(_d({56,90,97,84,89,82,11,95,90},21), name)
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
debug(name, _d({79,80,81,80,76,95,80,79},21))
end
local leoAnimLoggerConn = nil
local function startLeoAnimLogger(model)
local ok, err = pcall(function()
local hum = model:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
if not hum then
return
end
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
end
leoAnimLoggerConn = hum.AnimationPlayed:Connect(function(track)
local ok2, err2 = pcall(function()
debug(
_d({55,80,90,11,91,87,76,100,80,79,11,76,89,84,88,76,95,84,90,89,37},21),
track.Animation and track.Animation.Name,
"-",
track.Animation and track.Animation.AnimationId
)
end)
if not ok2 then
debug(_d({87,80,90,44,89,84,88,55,90,82,82,80,93,11,91,93,84,89,95,11,80,93,93,90,93,37},21), err2)
end
end)
end)
if not ok then
debug(_d({94,95,76,93,95,55,80,90,44,89,84,88,55,90,82,82,80,93,11,80,93,93,90,93,37},21), err)
end
end
local function stopLeoAnimLogger()
if leoAnimLoggerConn then
leoAnimLoggerConn:Disconnect()
leoAnimLoggerConn = nil
end
end
local function fightLeo()
debug(_d({56,90,97,84,89,82,11,95,90,11,55,80,90},21))
equipSwordOrMelee()
walkToPoint(COORDS.Leo, 30)
local leoModel = getNPCByName(_d({55,80,90},21))
if leoModel then
startLeoAnimLogger(leoModel.model)
end
equipSwordOrMelee()
setNavNamed(_d({55,80,90},21))
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled do
local info = getNPCByName(_d({55,80,90},21))
if not info then
break
end
local casting, which = isCastingDodgeSkill(info.model)
if casting then
debug(_d({55,80,90,11,78,76,94,95,84,89,82},21), which, _d({24,11,79,90,79,82,84,89,82},21))
if which == LEO_HIKEN_ANIM_ID or which == LEO_FIREFLY_ANIM_ID then
VIM:SendKeyEvent(true, BLOCK_KEY, false, game)
local holdTime = 0
while enabled and holdTime < 3.5 do
local currentCasting, currentWhich = isCastingDodgeSkill(info.model)
if currentCasting and (currentWhich == LEO_ENTEI_ANIM_ID or currentWhich == LEO_PILLAR_ANIM_ID) then
debug(_d({55,80,90,11,94,95,76,93,95,80,79,11,77,87,90,78,86,24,77,93,80,76,86,80,93,11,88,84,79,24,77,87,90,78,86,12,11,48,97,76,79,84,89,82,25,25,25},21))
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
if not getNPCByName(_d({55,80,90},21)) then
debug(_d({55,80,90,11,82,90,89,80,11,88,84,79,24,79,90,79,82,80,11,24,11,80,89,79,84,89,82,11,48,89,95,80,84,11,83,90,87,79,11,80,76,93,87,100},21))
break
end
end
else
task.wait(4)
end
end
if enabled and getNPCByName(_d({55,80,90},21)) then
setNavNamed(_d({55,80,90},21))
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
debug(_d({55,80,90,11,79,80,81,80,76,95,80,79},21))
stopLeoAnimLogger()
debug(_d({61,80,95,96,93,89,84,89,82,11,95,90,11,55,80,90,11,91,90,94,84,95,84,90,89,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,90,89},21))
navToPointConfirmed(COORDS.Leo, 30, _d({55,80,90,11,91,90,94,84,95,84,90,89},21))
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95,11,55,80,90,11,91,90,94,84,95,84,90,89},21))
task.wait(5)
end
local function destroyStatue(coordKey)
local coordPos = COORDS[coordKey]
debug(_d({56,90,97,84,89,82,11,95,90},21), coordKey)
navToPoint(coordPos)
waitUntilArrived(30)
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,94,95,76,95,96,80,11,88,90,79,80,87,11,89,80,76,93},21), coordKey)
return
end
local weapon = equipSwordOrMelee()
debug(_d({44,95,95,76,78,86,84,89,82},21), coordKey, _d({98,84,95,83},21), weapon or _d({89,90,95,83,84,89,82,11,81,90,96,89,79},21))
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
debug(coordKey, _d({77,76,93,93,80,87,11,79,80,94,95,93,90,100,80,79},21))
end
local function recheckStatue(coordKey)
local ok, err = pcall(function()
local coordPos = COORDS[coordKey]
local statueModel = getStatueModelNear(coordPos)
if not statueModel then
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({24,11,78,90,96,87,79,11,89,90,95,11,81,84,89,79,11,94,95,76,95,96,80,11,88,90,79,80,87,23,11,94,86,84,91,91,84,89,82},21))
return
end
local hp = getStatueHP(statueModel)
if hp > 0 then
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({94,95,84,87,87,11,76,87,84,97,80,11,19,51,59},21), hp, _d({20,11,24,11,93,80,24,79,80,94,95,93,90,100,84,89,82},21))
destroyStatue(coordKey)
else
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,37},21), coordKey, _d({78,90,89,81,84,93,88,80,79,11,79,80,94,95,93,90,100,80,79},21))
end
end)
if not ok then
debug(_d({93,80,78,83,80,78,86,62,95,76,95,96,80,11,80,93,93,90,93,37},21), coordKey, err)
end
end
local function fightQueenUntilPhase2()
debug(_d({56,90,97,84,89,82,11,95,90,11,60,96,80,80,89},21))
walkToPoint(COORDS.Queen, 30)
equipSwordOrMelee()
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and not isQueenPhase2() do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
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
debug(_d({60,96,80,80,89,11,80,89,95,80,93,80,79,11,91,83,76,94,80,11,29},21))
end
local function finishQueen()
debug(_d({49,84,89,84,94,83,84,89,82,11,60,96,80,80,89},21))
equipSwordOrMelee()
setNavNamed(_d({46,96,91,84,79,11,60,96,80,80,89},21))
startQueenDodgeWatcher()
local m1Combo = 0
local m1Target = math.random(4, 5)
while enabled and getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21)) do
if queenDodging then
task.wait(0.05)
else
local info = getNPCByName(_d({46,96,91,84,79,11,60,96,80,80,89},21))
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
debug(_d({60,96,80,80,89,11,79,80,81,80,76,95,80,79,25,11,59,87,76,89,11,78,90,88,91,87,80,95,80,25},21))
end
local CONFIRMATION_PROMPT_NAME = _d({46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95},21)
local function getReplayRemote()
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21))
local prompt = playerGui:WaitForChild(CONFIRMATION_PROMPT_NAME, REPLAY_PROMPT_TIMEOUT)
if not prompt then
return nil
end
return prompt:WaitForChild(_d({61,80,88,90,95,80,48,97,80,89,95},21), 5)
end)
if ok then
return result
end
debug(_d({82,80,95,61,80,91,87,76,100,61,80,88,90,95,80,11,80,93,93,90,93,37},21), result)
return nil
end
local function findButtonByValue(value)
local ok, result = pcall(function()
local playerGui = Players.LocalPlayer:FindFirstChild(_d({59,87,76,100,80,93,50,96,84},21))
if not playerGui then
return nil
end
for _, obj in ipairs(playerGui:GetDescendants()) do
if obj:IsA(_d({52,88,76,82,80,45,96,95,95,90,89},21)) then
local ok2, val = pcall(function()
return obj:GetAttribute(_d({77,96,95,95,90,89,65,76,87,96,80},21))
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
debug(_d({81,84,89,79,45,96,95,95,90,89,45,100,65,76,87,96,80,11,80,93,93,90,93,37},21), result)
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
debug(_d({78,87,84,78,86,50,96,84,45,96,95,95,90,89,11,80,93,93,90,93,37},21), err)
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
local isServerAttr = inst:GetAttribute(_d({84,94,62,80,93,97,80,93},21))
if isServerAttr ~= nil then
local child = isServerAttr and inst:FindFirstChild(_d({61,80,88,90,95,80,48,97,80,89,95},21)) or inst:FindFirstChild(_d({78,87,84,80,89,95,48,97,80,89,95},21))
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
debug(_d({81,84,89,79,44,89,94,98,80,93,46,90,89,89,80,78,95,90,93,11,80,93,93,90,93,37},21), connector)
return nil, nil
end
local function fireReplayValue(button)
local connector, isServer = findAnswerConnector(button)
if not connector then
debug(_d({46,90,96,87,79,11,89,90,95,11,87,90,78,76,95,80,11,61,80,88,90,95,80,48,97,80,89,95,26,78,87,84,80,89,95,48,97,80,89,95,11,89,80,76,93,11,61,80,91,87,76,100,11,77,96,95,95,90,89,23,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,78,87,84,78,86},21))
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
debug(_d({81,84,93,80,61,80,91,87,76,100,65,76,87,96,80,11,80,93,93,90,93,37},21), err, _d({24,11,81,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,78,87,84,78,86},21))
clickGuiButton(button)
end
end
local function fallbackButtonSearch()
debug(_d({49,76,87,87,84,89,82,11,77,76,78,86,11,95,90,11,77,96,95,95,90,89,65,76,87,96,80,11,94,80,76,93,78,83,11,81,90,93,11,61,80,91,87,76,100},21))
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
debug(_d({61,80,91,87,76,100,11,77,96,95,95,90,89,11,89,90,95,11,81,90,96,89,79,11,80,84,95,83,80,93,23,11,82,84,97,84,89,82,11,96,91},21))
return
end
task.wait(REPLAY_CLICK_SETTLE)
fireReplayValue(button)
end
local function handleReplayPrompt()
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,25,61,80,88,90,95,80,48,97,80,89,95},21))
local remote = getReplayRemote()
if not remote then
debug(_d({46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,26,61,80,88,90,95,80,48,97,80,89,95,11,89,90,95,11,81,90,96,89,79,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95},21))
fallbackButtonSearch()
return
end
task.wait(REPLAY_CLICK_SETTLE)
debug(_d({49,84,93,84,89,82,11,61,80,91,87,76,100,11,97,84,76,11,46,90,89,81,84,93,88,76,95,84,90,89,59,93,90,88,91,95,25,61,80,88,90,95,80,48,97,80,89,95},21))
local ok, err = pcall(function()
remote:FireServer(REPLAY_BUTTON_VALUE)
end)
if not ok then
debug(_d({49,84,93,80,62,80,93,97,80,93,11,80,93,93,90,93,37},21), err)
fallbackButtonSearch()
end
end
local function waitForObjectivesGui()
local ok, err = pcall(function()
local player = Players.LocalPlayer
local playerGui = player:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21), 10)
if not playerGui then
debug(_d({98,76,84,95,49,90,93,58,77,85,80,78,95,84,97,80,94,50,96,84,37,11,89,90,11,59,87,76,100,80,93,50,96,84,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
return
end
local waited = 0
while enabled do
if playerGui:FindFirstChild(OBJECTIVES_GUI_NAME) then
debug(_d({58,77,85,80,78,95,84,97,80,94,11,50,64,52,11,81,90,96,89,79,11,24,11,94,95,76,82,80,11,87,90,76,79,80,79},21))
return
end
task.wait(0.2)
waited += 0.2
if waited > OBJECTIVES_WAIT_MAX then
debug(_d({58,77,85,80,78,95,84,97,80,94,11,50,64,52,11,89,90,95,11,81,90,96,89,79,11,98,84,95,83,84,89,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
return
end
end
end)
if not ok then
debug(_d({98,76,84,95,49,90,93,58,77,85,80,78,95,84,97,80,94,50,96,84,11,80,93,93,90,93,37},21), err)
end
end
local function runPlan()
debug(_d({59,87,76,89,11,94,95,76,93,95,80,79},21))
task.wait(LOAD_WAIT)
waitForObjectivesGui()
debug(_d({62,95,76,93,95,84,89,82,11,89,76,97,11,87,90,90,91},21))
startNav()
task.spawn(function()
task.wait(0.2)
local rootAfter = Core.GetRoot(LocalPlayer)
debug(_d({91,90,94,11,27,25,29,94,11,44,49,63,48,61,11,94,95,76,93,95,57,76,97,37},21), rootAfter and rootAfter.Position)
end)
debug(_d({66,76,84,95,84,89,82,11,32,94,11,77,80,81,90,93,80,11,88,90,97,84,89,82,11,95,90,11,62,95,76,82,80,28},21))
task.wait(5)
for _, stage in ipairs({ _d({62,95,76,82,80,28},21), _d({62,95,76,82,80,29},21), _d({62,95,76,82,80,30},21), _d({62,95,76,82,80,30,45},21) }) do
if not enabled then
return
end
local hpTarget = (stage == _d({62,95,76,82,80,30,45},21)) and 0.40 or 0.95
clearStage(stage, hpTarget)
end
if not enabled then
return
end
debug(_d({56,90,97,84,89,82,11,95,90,11,76,93,93,90,98,11,81,87,100,24,79,90,98,89,11,76,93,80,76,11,19,46,96,91,84,79,11,61,76,84,89,20},21))
walkToPoint(COORDS.ArrowFlyDown, 30, true)
debug(_d({47,90,79,82,84,89,82,11,76,93,93,90,98,11,93,76,84,89,11,84,89,11,76,11,94,92,96,76,93,80},21))
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
clearStage(_d({62,95,76,82,80,31},21))
if not enabled then
return
end
fightLeo()
if not enabled then
return
end
fightQueenUntilPhase2()
debug(_d({60,96,80,80,89,11,84,89,11,91,83,76,94,80,11,29,11,24,11,86,80,80,91,84,89,82,11,54,80,89,11,51,76,86,84,11,76,78,95,84,97,80,11,81,93,90,88,11,83,80,93,80,11,90,89},21))
startKenKeeper()
if not enabled then
return
end
destroyStatue(_d({62,95,76,95,96,80,28},21))
if not enabled then
return
end
recheckStatue(_d({62,95,76,95,96,80,28},21))
destroyStatue(_d({62,95,76,95,96,80,29},21))
if not enabled then
return
end
recheckStatue(_d({62,95,76,95,96,80,28},21))
recheckStatue(_d({62,95,76,95,96,80,29},21))
destroyStatue(_d({62,95,76,95,96,80,30},21))
if not enabled then
return
end
recheckStatue(_d({62,95,76,95,96,80,30},21))
recheckStatue(_d({62,95,76,95,96,80,29},21))
recheckStatue(_d({62,95,76,95,96,80,28},21))
if not enabled then
return
end
debug(_d({66,76,84,95,84,89,82,11,81,90,93,11,91,83,76,94,80,11,29,11,95,90,11,80,89,79},21))
local t2 = 0
while enabled and isQueenPhase2() do
task.wait(0.3)
t2 += 0.3
if t2 > 120 then
debug(_d({59,83,76,94,80,11,29,11,80,89,79,11,98,76,84,95,11,95,84,88,80,90,96,95,23,11,91,93,90,78,80,80,79,84,89,82,11,76,89,100,98,76,100},21))
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
debug(_d({56,90,97,84,89,82,11,77,76,78,86,11,95,90,11,60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
navToPointConfirmed(COORDS.Queen, 30, _d({60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
debug(_d({66,76,84,95,84,89,82,11,32,94,11,76,95,11,60,96,80,80,89,11,94,95,76,82,80,11,91,90,94,84,95,84,90,89},21))
task.wait(5)
if not enabled then
return
end
debug(_d({56,90,97,84,89,82,11,95,90,11,91,90,94,95,24,60,96,80,80,89,11,91,90,94,84,95,84,90,89},21))
navToPointConfirmed(COORDS.PostQueen, 30, _d({91,90,94,95,24,60,96,80,80,89,11,91,90,94,84,95,84,90,89},21))
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
debug(_d({48,89,76,77,87,84,89,82,23,11,91,90,94,11,45,48,49,58,61,48,11,91,87,76,89,37},21), rootBefore and rootBefore.Position)
startBusoKeeper()
task.spawn(function()
local ok2, err2 = pcall(runPlan)
if not ok2 then
debug(_d({59,87,76,89,11,80,93,93,90,93,37},21), err2)
end
end)
debug(_d({48,89,76,77,87,80,79,37},21), enabled)
end
local function disableBot()
if not enabled then
return
end
enabled = false
stopNav()
debug(_d({48,89,76,77,87,80,79,37},21), enabled)
end
function CupidDungeon.Start()
if enabled then
return
end
if not Safeguard then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21))
return
end
if not Safeguard.RequirePlace(11424731604, _d({46,96,91,84,79,11,47,96,89,82,80,90,89},21)) then
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
Core.SetupStandalone(CupidDungeon, _d({46,96,91,84,79,11,47,96,89,82,80,90,89},21), CupidDungeon.Start, CupidDungeon.Stop, function()
return enabled
end)
return CupidDungeon
end
local function loadHoroBossFarm()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local HoroFarm = {
Running = false,
Connections = {},
Config = {
SelectedBoss = _d({53,96,101,90,11,95,83,80,11,47,84,76,88,90,89,79,77,76,78,86},21),
UseE = true,
UseZ = true,
UseC = true,
UseR = true,
},
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
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({59,80,87,84},21))
if not (peliValueObj and peliValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
peliValueObj = nested and nested:FindFirstChild(_d({59,80,87,84},21))
end
levelValueObj = statsFolder:FindFirstChild(_d({55,80,97,80,87},21))
if not (levelValueObj and levelValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
levelValueObj = nested and nested:FindFirstChild(_d({55,80,97,80,87},21))
end
staminaValueObj = statsFolder:FindFirstChild(_d({62,95,76,88,84,89,76},21))
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
local hum = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79},21))
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
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
print("[" .. tostring(name) .. _d({72,11,62,95,76,89,79,76,87,90,89,80,11,56,90,79,80,37,11,59,93,80,94,94,11,18},21) .. toggleKey.Name .. _d({18,11,95,90,11,95,90,82,82,87,80,25},21))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({53,86,29,53,54,63,44,54,46,81},21),
TeleportLocation = _d({28,94,95,62,80,76},21),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({49,84,93,94,95,11,62,80,76,11,51,90,88,80,94,78,93,80,80,89,11,26,11,56,76,84,89,11,56,80,89,96},21),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({94,95,93,84,89,82},21) and code ~= "" then
print(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,53,90,84,89,84,89,82,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,11,18,16,94,18,25,25,25},21), code))
task.spawn(function()
local rs = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local reservedRemote = rs:WaitForChild(_d({48,97,80,89,95,94},21)):WaitForChild(_d({93,80,94,80,93,97,80,79},21))
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
v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) and (v.Name == _d({61,80,88,90,95,80,48,97,80,89,95},21) or v.Name == _d({95,80,87,80},21) or v.Name == _d({63,80,87,80,91,90,93,95},21))
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
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,84,93,84,89,82,11,95,80,87,80,91,90,93,95,11,93,80,88,90,95,80,37,11},21) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,61,80,88,90,95,80,48,97,80,89,95,11,84,89,11,89,84,87,25,11,59,93,84,89,95,84,89,82,11,76,87,87,11,61,80,88,90,95,80,48,97,80,89,95,94,11,84,89,11,89,84,87,37},21))
for _, v in next, getnilinstances() do
if v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
print(_d({11,24,11,57,76,88,80,37},21), v.Name)
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
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,62,78,93,84,91,95,11,80,99,80,78,96,95,84,90,89,11,77,87,90,78,86,80,79,11,90,89,37,11},21) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,68,90,96,11,76,93,80,11,90,89,11,95,83,80,11,51,90,88,80,94,78,93,80,80,89,25,11,62,78,93,84,91,95,11,93,80,92,96,84,93,80,94,11,16,94,25},21), name or _d({76,11,94,91,80,78,84,81,84,78,11,91,87,76,78,80},21)))
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
warn(
string.format(
_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,91,87,76,78,80,12,11,61,80,92,96,84,93,80,79,37,11,16,94,11,19,16,79,20,23,11,46,96,93,93,80,89,95,37,11,16,79},21),
name or _d({64,89,86,89,90,98,89},21),
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
local bp = LocalPlayer:FindFirstChild(_d({45,76,78,86,91,76,78,86},21))
local char = LocalPlayer.Character
if not char then
return nil
end
local tool = char:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)) or (bp and bp:FindFirstChild(_d({51,90,93,90,24,51,90,93,90},21)))
if tool and tool.Parent ~= char then
local hum = char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
local npts = Workspace:FindFirstChild(_d({57,59,46,94},21))
if not npts then
return nil
end
local boss = npts:FindFirstChild(name)
if boss then
local root = boss:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hum = boss:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
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
if key == _d({51,84,95},21) then
return target.CFrame
elseif key == _d({63,76,93,82,80,95},21) then
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
warn(_d({70,51,90,93,90,49,76,93,88,72,11,56,80,95,76,95,76,77,87,80,11,83,90,90,86,11,81,76,84,87,80,79,37,11},21) .. tostring(err))
end
end
function HoroFarm.Stop()
HoroFarm.Running = false
for _, conn in ipairs(HoroFarm.Connections) do
conn:Disconnect()
end
HoroFarm.Connections = {}
print(_d({70,51,90,93,90,49,76,93,88,72,11,62,95,90,91,91,80,79,25},21))
end
function HoroFarm.Start()
if HoroFarm.Running then
warn(_d({70,51,90,93,90,49,76,93,88,72,11,44,87,93,80,76,79,100,11,93,96,89,89,84,89,82,12},21))
return
end
if not Safeguard then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21))
return
end
if not Safeguard.IsSafe() then
return
end
HoroFarm.Running = true
setupHook()
print(_d({70,51,90,93,90,49,76,93,88,72,11,62,95,76,93,95,80,79,11,95,76,93,82,80,95,84,89,82,37,11},21) .. HoroFarm.Config.SelectedBoss)
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
Core.SetupStandalone(HoroFarm, _d({51,90,93,90,49,76,93,88},21), HoroFarm.Start, HoroFarm.Stop, function()
return HoroFarm.Running
end)
return HoroFarm
end
local function loadLevelGrinder()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local LocalPlayer = Players.LocalPlayer
local LevelGrinder = {
Running = false,
Connections = {},
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
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({59,80,87,84},21))
if not (peliValueObj and peliValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
peliValueObj = nested and nested:FindFirstChild(_d({59,80,87,84},21))
end
levelValueObj = statsFolder:FindFirstChild(_d({55,80,97,80,87},21))
if not (levelValueObj and levelValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
levelValueObj = nested and nested:FindFirstChild(_d({55,80,97,80,87},21))
end
staminaValueObj = statsFolder:FindFirstChild(_d({62,95,76,88,84,89,76},21))
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
local hum = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79},21))
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
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
print("[" .. tostring(name) .. _d({72,11,62,95,76,89,79,76,87,90,89,80,11,56,90,79,80,37,11,59,93,80,94,94,11,18},21) .. toggleKey.Name .. _d({18,11,95,90,11,95,90,82,82,87,80,25},21))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({53,86,29,53,54,63,44,54,46,81},21),
TeleportLocation = _d({28,94,95,62,80,76},21),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({49,84,93,94,95,11,62,80,76,11,51,90,88,80,94,78,93,80,80,89,11,26,11,56,76,84,89,11,56,80,89,96},21),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({94,95,93,84,89,82},21) and code ~= "" then
print(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,53,90,84,89,84,89,82,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,11,18,16,94,18,25,25,25},21), code))
task.spawn(function()
local rs = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local reservedRemote = rs:WaitForChild(_d({48,97,80,89,95,94},21)):WaitForChild(_d({93,80,94,80,93,97,80,79},21))
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
v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) and (v.Name == _d({61,80,88,90,95,80,48,97,80,89,95},21) or v.Name == _d({95,80,87,80},21) or v.Name == _d({63,80,87,80,91,90,93,95},21))
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
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,84,93,84,89,82,11,95,80,87,80,91,90,93,95,11,93,80,88,90,95,80,37,11},21) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,61,80,88,90,95,80,48,97,80,89,95,11,84,89,11,89,84,87,25,11,59,93,84,89,95,84,89,82,11,76,87,87,11,61,80,88,90,95,80,48,97,80,89,95,94,11,84,89,11,89,84,87,37},21))
for _, v in next, getnilinstances() do
if v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
print(_d({11,24,11,57,76,88,80,37},21), v.Name)
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
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,62,78,93,84,91,95,11,80,99,80,78,96,95,84,90,89,11,77,87,90,78,86,80,79,11,90,89,37,11},21) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,68,90,96,11,76,93,80,11,90,89,11,95,83,80,11,51,90,88,80,94,78,93,80,80,89,25,11,62,78,93,84,91,95,11,93,80,92,96,84,93,80,94,11,16,94,25},21), name or _d({76,11,94,91,80,78,84,81,84,78,11,91,87,76,78,80},21)))
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
warn(
string.format(
_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,91,87,76,78,80,12,11,61,80,92,96,84,93,80,79,37,11,16,94,11,19,16,79,20,23,11,46,96,93,93,80,89,95,37,11,16,79},21),
name or _d({64,89,86,89,90,98,89},21),
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
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,62,95,90,91,91,80,79,25},21))
end
function LevelGrinder.Start()
if LevelGrinder.Running then
warn(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,44,87,93,80,76,79,100,11,93,96,89,89,84,89,82,12},21))
return
end
if not Safeguard then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21))
return
end
if not Safeguard.RequirePlace(3978370137, _d({49,84,93,94,95,11,62,80,76},21)) then
return
end
LevelGrinder.Running = true
task.spawn(function()
if not game:IsLoaded() then
game.Loaded:Wait()
end
local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = char:WaitForChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21), 10)
local hum = char:WaitForChild(_d({51,96,88,76,89,90,84,79},21), 10)
local stats = ReplicatedStorage:WaitForChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name, 30)
if stats then
stats:WaitForChild(_d({59,80,87,84},21), 10)
end
local ChestFarmer = nil
local EasyTravel = nil
while LevelGrinder.Running do
local char = LocalPlayer.Character
local hrp = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local hasRifle = LocalPlayer.Backpack:FindFirstChild(_d({61,84,81,87,80},21)) or (char and char:FindFirstChild(_d({61,84,81,87,80},21)))
if hasRifle then
break
end
local peli = Core.GetPeli()
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,46,96,93,93,80,89,95,11,59,80,87,84,11,78,83,80,78,86,37},21), peli)
local inTown = hrp
and hrp.Position.X >= -889
and hrp.Position.X <= -156
and hrp.Position.Z >= -3706
and hrp.Position.Z <= -3087
if not inTown then
warn(
_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,57,90,95,11,76,95,11,63,90,98,89,11,90,81,11,45,80,82,84,89,89,84,89,82,94,25,11,59,87,80,76,94,80,11,95,93,76,97,80,87,11,95,83,80,93,80,11,95,90,11,81,76,93,88,11,78,83,80,94,95,94,11,98,83,84,87,80,11,98,76,84,95,84,89,82,11,81,90,93,11,61,84,81,87,80,25},21)
)
task.wait(2)
continue
end
if not ChestFarmer then
local old = _G.DisableStandalone
_G.DisableStandalone = true
ChestFarmer = Core.Import(
_d({27,28,24,82,91,90,26,87,84,77,26,78,83,80,94,95,74,81,76,93,88,80,93,25,87,96,76},21),
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,78,83,80,94,95,74,81,76,93,88,80,93,25,87,96,76},21)
)
_G.DisableStandalone = old
end
if ChestFarmer then
if peli < 300 then
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,49,76,93,88,84,89,82,11,78,83,80,94,95,94,11,96,89,95,84,87,11,30,27,27,11,59,80,87,84,25,25,25,11,19,46,96,93,93,80,89,95,37,11},21) .. tostring(peli) .. ")")
ChestFarmer.FarmUntilPeli(300, function()
local s = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
local pObj = s and s:FindFirstChild(_d({59,80,87,84},21))
return pObj and (tonumber(pObj.Value) or 0) or 0
end, function()
local c = LocalPlayer.Character
return LevelGrinder.Running
and not (LocalPlayer.Backpack:FindFirstChild(_d({61,84,81,87,80},21)) or (c and c:FindFirstChild(_d({61,84,81,87,80},21))))
end)
else
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(
_d({27,28,24,82,91,90,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21),
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21)
)
_G.DisableStandalone = old
if EasyTravel and EasyTravel.Cleanup then
pcall(EasyTravel.Cleanup)
end
end
local buyables = workspace:FindFirstChild(_d({45,96,100,76,77,87,80,52,95,80,88,94},21))
local shopItem = buyables and buyables:FindFirstChild(_d({61,84,81,87,80},21))
local shopPart = shopItem and shopItem:FindFirstChild(_d({62,83,90,91,59,76,93,95},21))
if EasyTravel and shopPart and hrp then
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,63,93,76,97,80,87,84,89,82,11,95,90,11,61,84,81,87,80,11,94,83,90,91,11,97,84,76,11,48,76,94,100,63,93,76,97,80,87,25,25,25},21))
local nocollide = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({45,76,94,80,59,76,93,95},21)) then
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
local shopEvent = ReplicatedStorage:FindFirstChild(_d({48,97,80,89,95,94},21))
and ReplicatedStorage.Events:FindFirstChild(_d({62,83,90,91},21))
if shopEvent and shopEvent:IsA(_d({61,80,88,90,95,80,49,96,89,78,95,84,90,89},21)) then
pcall(function()
shopEvent:InvokeServer(shopItem, 1)
end)
end
task.wait(1)
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,48,92,96,84,91,91,84,89,82,11,61,84,81,87,80,25,25,25},21))
local args = {
[1] = _d({80,92,96,84,91},21),
[2] = _d({61,84,81,87,80},21),
}
local toolsEvent = ReplicatedStorage:FindFirstChild(_d({48,97,80,89,95,94},21))
and ReplicatedStorage.Events:FindFirstChild(_d({63,90,90,87,94},21))
if toolsEvent and toolsEvent:IsA(_d({61,80,88,90,95,80,49,96,89,78,95,84,90,89},21)) then
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
local hum = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79},21))
local hrp = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
local rifle = LocalPlayer.Backpack:FindFirstChild(_d({61,84,81,87,80},21))
if rifle and hum then
hum:EquipTool(rifle)
end
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,49,87,100,84,89,82,11,95,90,11,49,84,94,83,88,76,89,11,46,76,97,80,25,25,25},21))
if not EasyTravel then
local old = _G.DisableStandalone
_G.DisableStandalone = true
EasyTravel = Core.Import(
_d({27,28,24,82,91,90,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21),
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,80,76,94,100,74,95,93,76,97,80,87,25,87,96,76},21)
)
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
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,48,94,78,76,91,84,89,82,11,94,83,90,91,11,84,89,95,80,93,84,90,93,11,77,100,11,81,87,100,84,89,82,11,94,95,93,76,84,82,83,95,11,96,91,25,25,25},21))
local nocollide = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21)).Stepped:Connect(function()
local c = LocalPlayer.Character
if c then
for _, part in ipairs(c:GetDescendants()) do
if part:IsA(_d({45,76,94,80,59,76,93,95},21)) then
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
local runService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
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
print(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,49,87,100,84,89,82,11,95,90,11,49,84,94,83,88,76,89,11,46,76,97,80,25,25,25},21))
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
local FishmanMaze = Core.Import(
_d({27,28,24,82,91,90,26,87,84,77,26,81,84,94,83,88,76,89,74,88,76,101,80,25,87,96,76},21),
_d({83,95,95,91,94,37,26,26,93,76,98,25,82,84,95,83,96,77,96,94,80,93,78,90,89,95,80,89,95,25,78,90,88,26,93,90,78,86,100,99,98,76,87,87,26,87,96,76,96,24,78,90,79,80,26,88,76,84,89,26,27,28,74,94,78,93,84,91,95,26,87,84,77,26,81,84,94,83,88,76,89,74,88,76,101,80,25,87,96,76},21)
)
if FishmanMaze then
pcall(function()
FishmanMaze.Travel(hrp, function()
return LevelGrinder.Running
end)
end)
else
warn(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,49,76,84,87,80,79,11,95,90,11,84,88,91,90,93,95,11,49,84,94,83,88,76,89,56,76,101,80,11,87,84,77,93,76,93,100,12},21))
end
else
warn(_d({70,55,80,97,80,87,11,50,93,84,89,79,80,93,72,11,58,96,95,94,84,79,80,11,49,84,94,83,88,76,89,11,46,76,97,80,11,77,90,96,89,79,94,23,11,94,86,84,91,91,84,89,82,11,88,76,101,80,25},21))
end
end
LevelGrinder.Stop()
end)
end
Core.SetupStandalone(LevelGrinder, _d({55,80,97,80,87,11,50,93,84,89,79,80,93},21), LevelGrinder.Start, LevelGrinder.Stop, function()
return LevelGrinder.Running
end)
return LevelGrinder
end
local function loadNavigationLab()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
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
pcall(function()
result = loadstring(game:HttpGet(publicUrl))()
end)
end
_G.DisableStandalone = oldState
return result
end
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({59,80,87,84},21))
if not (peliValueObj and peliValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
peliValueObj = nested and nested:FindFirstChild(_d({59,80,87,84},21))
end
levelValueObj = statsFolder:FindFirstChild(_d({55,80,97,80,87},21))
if not (levelValueObj and levelValueObj:IsA(_d({65,76,87,96,80,45,76,94,80},21))) then
local nested = statsFolder:FindFirstChild(_d({62,95,76,95,94},21))
levelValueObj = nested and nested:FindFirstChild(_d({55,80,97,80,87},21))
end
staminaValueObj = statsFolder:FindFirstChild(_d({62,95,76,88,84,89,76},21))
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
local hum = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79},21))
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
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
print("[" .. tostring(name) .. _d({72,11,62,95,76,89,79,76,87,90,89,80,11,56,90,79,80,37,11,59,93,80,94,94,11,18},21) .. toggleKey.Name .. _d({18,11,95,90,11,95,90,82,82,87,80,25},21))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({53,86,29,53,54,63,44,54,46,81},21),
TeleportLocation = _d({28,94,95,62,80,76},21),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({49,84,93,94,95,11,62,80,76,11,51,90,88,80,94,78,93,80,80,89,11,26,11,56,76,84,89,11,56,80,89,96},21),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({94,95,93,84,89,82},21) and code ~= "" then
print(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,53,90,84,89,84,89,82,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,11,18,16,94,18,25,25,25},21), code))
task.spawn(function()
local rs = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local reservedRemote = rs:WaitForChild(_d({48,97,80,89,95,94},21)):WaitForChild(_d({93,80,94,80,93,97,80,79},21))
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
v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) and (v.Name == _d({61,80,88,90,95,80,48,97,80,89,95},21) or v.Name == _d({95,80,87,80},21) or v.Name == _d({63,80,87,80,91,90,93,95},21))
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
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,84,93,84,89,82,11,95,80,87,80,91,90,93,95,11,93,80,88,90,95,80,37,11},21) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,46,90,96,87,79,11,89,90,95,11,81,84,89,79,11,61,80,88,90,95,80,48,97,80,89,95,11,84,89,11,89,84,87,25,11,59,93,84,89,95,84,89,82,11,76,87,87,11,61,80,88,90,95,80,48,97,80,89,95,94,11,84,89,11,89,84,87,37},21))
for _, v in next, getnilinstances() do
if v:IsA(_d({61,80,88,90,95,80,48,97,80,89,95},21)) then
print(_d({11,24,11,57,76,88,80,37},21), v.Name)
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
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,62,78,93,84,91,95,11,80,99,80,78,96,95,84,90,89,11,77,87,90,78,86,80,79,11,90,89,37,11},21) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,82,76,88,80,11,96,89,84,97,80,93,94,80,12,11,62,78,93,84,91,95,11,84,94,11,90,89,87,100,11,81,90,93,11,50,59,58,25},21))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({70,62,76,81,80,82,96,76,93,79,72,11,68,90,96,11,76,93,80,11,90,89,11,95,83,80,11,51,90,88,80,94,78,93,80,80,89,25,11,62,78,93,84,91,95,11,93,80,92,96,84,93,80,94,11,16,94,25},21), name or _d({76,11,94,91,80,78,84,81,84,78,11,91,87,76,78,80},21)))
if Safeguard.JoinPrivateServer() then
print(_d({70,62,76,81,80,82,96,76,93,79,72,11,63,80,87,80,91,90,93,95,84,89,82,11,95,90,11,59,93,84,97,76,95,80,11,62,80,93,97,80,93,25,25,25,11,59,87,80,76,94,80,11,98,76,84,95,25},21))
else
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,59,93,84,97,76,95,80,62,80,93,97,80,93,46,90,79,80,11,84,94,11,89,90,95,11,94,80,95,25,11,46,76,89,89,90,95,11,76,96,95,90,24,85,90,84,89,25},21))
end
return false
end
warn(
string.format(
_d({70,62,76,81,80,82,96,76,93,79,72,11,66,93,90,89,82,11,91,87,76,78,80,12,11,61,80,92,96,84,93,80,79,37,11,16,94,11,19,16,79,20,23,11,46,96,93,93,80,89,95,37,11,16,79},21),
name or _d({64,89,86,89,90,98,89},21),
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
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
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
return char, char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)), char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
end
local function getOrCreateForce(root)
local att = root:FindFirstChild(_d({74,74,48,76,94,100,63,93,76,97,80,87,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,48,76,94,100,63,93,76,97,80,87,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,48,76,94,100,63,93,76,97,80,87,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,48,76,94,100,63,93,76,97,80,87,49,90,93,78,80},21)
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
local force = root:FindFirstChild(_d({74,74,48,76,94,100,63,93,76,97,80,87,49,90,93,78,80},21))
local att = root:FindFirstChild(_d({74,74,48,76,94,100,63,93,76,97,80,87,44,95,95},21))
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
local cave = Workspace.Islands:FindFirstChild(_d({49,84,94,83,88,76,89,11,46,76,97,80},21))
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
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21))
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
print(_d({70,48,76,94,100,11,63,93,76,97,80,87,72,11,49,87,84,82,83,95,11,80,89,76,77,87,80,79,25},21))
end
function EasyTravel.Stop()
EasyTravel.Enabled = false
if loopConnection then
loopConnection:Disconnect()
loopConnection = nil
end
cleanupForce()
print(_d({70,48,76,94,100,11,63,93,76,97,80,87,72,11,49,87,84,82,83,95,11,79,84,94,76,77,87,80,79,25},21))
end
function EasyTravel.Cleanup()
EasyTravel.Stop()
for _, conn in ipairs(EasyTravel.Connections) do
conn:Disconnect()
end
EasyTravel.Connections = {}
end
Core.SetupStandalone(EasyTravel, _d({48,76,94,100,11,63,93,76,97,80,87},21), EasyTravel.Start, EasyTravel.Stop, function()
return EasyTravel.Enabled
end, Enum.KeyCode.P, true)
return EasyTravel
end
local function loadOverworldTester()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local RunService = game:GetService(_d({61,96,89,62,80,93,97,84,78,80},21))
local UserInputService = game:GetService(_d({64,94,80,93,52,89,91,96,95,62,80,93,97,84,78,80},21))
local ReplicatedStorage = game:GetService(_d({61,80,91,87,84,78,76,95,80,79,62,95,90,93,76,82,80},21))
local LocalPlayer = Players.LocalPlayer
local Workspace = workspace
local enabled = false
local navConn = nil
local lastAim = nil
local lastFace = nil
local mode = _d({84,79,87,80},21)
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
print(_d({70,58,97,80,93,98,90,93,87,79,63,80,94,95,80,93,72},21), ...)
end
local function getHumanoid()
local char = LocalPlayer.Character
return char and char:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
end
local function invokeGeppo()
local now = tick()
if now - lastGeppoTime < GEPPO_COOLDOWN then
return
end
lastGeppoTime = now
local ok, err = pcall(function()
local char = LocalPlayer.Character
local root = char and char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then
return
end
local statsFolder = ReplicatedStorage:FindFirstChild(_d({62,95,76,95,94},21) .. LocalPlayer.Name)
if not statsFolder then
return
end
local style = statsFolder.Stats.FightingStyle.Value
local cf = CFrame.lookAt(root.Position, root.Position + root.CFrame.LookVector)
local args = { char = char, cf = cf }
if style == _d({61,90,86,96,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({50,80,91,91,90},21), args)
elseif style == _d({45,87,76,78,86,55,80,82},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86},21), args)
elseif style == _d({54,76,88,84,94,83,84,86,84},21) then
ReplicatedStorage.Events.Skill:InvokeServer(_d({54,76,88,84,94,83,84,86,84,50,80,91,91,90},21), args)
else
ReplicatedStorage.Events.Skill:InvokeServer(_d({62,86,100,11,66,76,87,86,29},21), args)
end
debug(_d({49,84,93,80,79,11,50,80,91,91,90,11,61,80,88,90,95,80},21))
end)
if not ok then
debug(_d({84,89,97,90,86,80,50,80,91,91,90,11,80,93,93,90,93,37},21), err)
end
end
local function getOrCreateForce(root)
local ok, result = pcall(function()
local att = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21)) or Instance.new(_d({44,95,95,76,78,83,88,80,89,95},21))
att.Name = _d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21)
att.Parent = root
local force = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21))
if not force then
force = Instance.new(_d({55,84,89,80,76,93,65,80,87,90,78,84,95,100},21))
force.Name = _d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21)
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
local root = char:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not root then
return
end
local force = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,49,90,93,78,80},21))
local att = root:FindFirstChild(_d({74,74,63,80,94,95,51,90,97,80,93,44,95,95},21))
if force then
force:Destroy()
end
if att then
att:Destroy()
end
end)
end
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
local function walkToPoint(pos, timeout)
timeout = timeout or 30
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
debug(_d({66,76,87,86,84,89,82,11,95,90,37},21), pos)
cleanupForce()
local ok, err = pcall(function()
VIM:SendKeyEvent(true, Enum.KeyCode.W, false, game)
end)
if not ok then
debug(_d({98,76,87,86,63,90,59,90,84,89,95,11,66,11,79,90,98,89,11,80,93,93,90,93,37},21), err)
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
debug(_d({44,93,93,84,97,80,79,11,76,95,37},21), pos)
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
item:IsA(_d({56,90,79,80,87},21))
and item:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
and item:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21))
then
if item ~= LocalPlayer.Character and item:FindFirstChildWhichIsA(_d({51,96,88,76,89,90,84,79},21)).Health > 0 then
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
mode = _d({84,79,87,80},21)
if navConn then
navConn:Disconnect()
navConn = nil
end
cleanupForce()
debug(_d({63,80,94,95,80,93,11,47,84,94,76,77,87,80,79},21))
end
local function enableBot(targetMode)
if enabled then
disableBot()
end
enabled = true
mode = targetMode
debug(_d({63,80,94,95,80,93,11,48,89,76,77,87,80,79,25,11,56,90,79,80,37},21), mode)
local initialPos = Core.GetRoot(LocalPlayer) and Core.GetRoot(LocalPlayer).Position or Vector3.new(0, 50, 0)
local climbStart = tick()
navConn = RunService.Heartbeat:Connect(function()
local root = Core.GetRoot(LocalPlayer)
if not root then
return
end
local hum = getHumanoid()
if hum and hum.Health <= 0 then
debug(_d({59,87,76,100,80,93,11,79,84,80,79,12,11,47,84,94,76,77,87,84,89,82,11,77,90,95,25},21))
disableBot()
return
end
local aim, face = nil, nil
if mode == _d({83,90,97,80,93},21) then
local targetChar = getNearestTarget()
if targetChar then
aim = targetChar.HumanoidRootPart.Position + Vector3.new(0, currentHoverOffset, 0)
face = targetChar.HumanoidRootPart.Position
end
elseif mode == _d({79,90,79,82,80},21) then
aim = initialPos + Vector3.new(0, currentDodgeHeight, 0)
face = initialPos
invokeGeppo()
elseif mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) then
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
local playerGui = LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21), 10)
if not playerGui then
return
end
local existingGui = playerGui:FindFirstChild(_d({58,97,80,93,98,90,93,87,79,63,80,94,95,50,96,84},21))
if existingGui then
existingGui:Destroy()
end
local screenGui = Instance.new(_d({62,78,93,80,80,89,50,96,84},21))
screenGui.Name = _d({58,97,80,93,98,90,93,87,79,63,80,94,95,50,96,84},21)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new(_d({49,93,76,88,80},21))
frame.Name = _d({56,76,84,89,49,93,76,88,80},21)
frame.Size = UDim2.new(0, 240, 0, 230)
frame.Position = UDim2.new(0.05, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 32, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui
local uiCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = frame
local title = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
title.Size = UDim2.new(1, -20, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = _d({219,138,134,140,218,163,122,11,46,96,91,84,79,11,48,89,82,84,89,80,11,58,97,80,93,98,90,93,87,79,11,63,80,94,95},21)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = frame
local statusLabel = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = _d({62,95,76,95,96,94,37,11,52,79,87,80},21)
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextSize = 11
statusLabel.Parent = frame
local function createInputBtn(text, defaultVal, pos, callback, color)
local btn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
btn.Size = UDim2.new(0.65, -10, 0, 30)
btn.Position = pos
btn.BackgroundColor3 = color or Color3.fromRGB(50, 60, 80)
btn.Text = text
btn.TextColor3 = Color3.new(1, 1, 1)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 11
btn.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), btn).CornerRadius = UDim.new(0, 6)
local input = Instance.new(_d({63,80,99,95,45,90,99},21))
input.Size = UDim2.new(0.35, -10, 0, 30)
input.Position = UDim2.new(0.65, 0, 0, 0) + UDim2.new(0, pos.X.Offset, 0, pos.Y.Offset)
input.BackgroundColor3 = Color3.fromRGB(20, 22, 30)
input.TextColor3 = Color3.new(1, 1, 1)
input.Text = tostring(defaultVal)
input.Font = Enum.Font.GothamMedium
input.TextSize = 11
input.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), input).CornerRadius = UDim.new(0, 6)
btn.MouseButton1Click:Connect(function()
local val = tonumber(input.Text) or defaultVal
callback(val)
end)
end
createInputBtn(_d({51,90,97,80,93,11,44,77,90,97,80,11,63,76,93,82,80,95},21), 10.3, UDim2.new(0, 10, 0, 65), function(val)
currentHoverOffset = val
enableBot(_d({83,90,97,80,93},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,51,90,97,80,93,84,89,82,11},21) .. val .. _d({11,94,95,96,79,94,11,96,91},21)
end)
createInputBtn(_d({47,90,79,82,80,11,46,87,84,88,77},21), 70, UDim2.new(0, 10, 0, 105), function(val)
currentDodgeHeight = val
enableBot(_d({79,90,79,82,80},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,47,90,79,82,80,24,83,90,87,79,84,89,82,11,19},21) .. val .. _d({11,94,95,96,79,94,20},21)
end)
createInputBtn(_d({63,80,94,95,11,62,92,96,76,93,80,11,47,90,79,82,80},21), 40, UDim2.new(0, 10, 0, 145), function(val)
enableBot(_d({94,92,96,76,93,80,74,79,90,79,82,80},21))
statusLabel.Text = _d({62,95,76,95,96,94,37,11,62,92,96,76,93,80,11,66,76,87,86,84,89,82,11,19},21) .. val .. _d({11,94,95,96,79,94,20},21)
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
while enabled and mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) and (tick() - startT) < 30 do
walkToPoint(corners[cornerIdx], 5)
cornerIdx = (cornerIdx % 4) + 1
end
if mode == _d({94,92,96,76,93,80,74,79,90,79,82,80},21) then
disableBot()
statusLabel.Text = _d({62,95,76,95,96,94,37,11,52,79,87,80,11,19,62,92,96,76,93,80,11,79,90,79,82,80,11,79,90,89,80,20},21)
end
end)
end)
local stopBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
stopBtn.Size = UDim2.new(1, -20, 0, 30)
stopBtn.Position = UDim2.new(0, 10, 0, 185)
stopBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 60)
stopBtn.Text = _d({48,56,48,61,50,48,57,46,68,11,62,63,58,59},21)
stopBtn.TextColor3 = Color3.new(1, 1, 1)
stopBtn.Font = Enum.Font.GothamBlack
stopBtn.TextSize = 13
stopBtn.Parent = frame
Instance.new(_d({64,52,46,90,93,89,80,93},21), stopBtn).CornerRadius = UDim.new(0, 6)
stopBtn.MouseButton1Click:Connect(function()
disableBot()
statusLabel.Text = _d({62,95,76,95,96,94,37,11,62,63,58,59,59,48,47,11,19,52,79,87,80,20},21)
local VIM = game:GetService(_d({65,84,93,95,96,76,87,52,89,91,96,95,56,76,89,76,82,80,93},21))
VIM:SendKeyEvent(false, Enum.KeyCode.W, false, game)
VIM:SendKeyEvent(false, Enum.KeyCode.Q, false, game)
end)
end
CreateUI()
print(_d({70,58,97,80,93,98,90,93,87,79,63,80,94,95,80,93,72,11,55,90,76,79,80,79,11,94,96,78,78,80,94,94,81,96,87,87,100,25},21))
end
local function CreateLauncherUI()
local playerGui = LocalPlayer:WaitForChild(_d({59,87,76,100,80,93,50,96,84},21), 10)
if not playerGui then
return
end
local oldUI = playerGui:FindFirstChild(_d({50,59,58,55,76,96,89,78,83,80,93,64,52},21))
if oldUI then
oldUI:Destroy()
end
local screenGui = Instance.new(_d({62,78,93,80,80,89,50,96,84},21))
screenGui.Name = _d({50,59,58,55,76,96,89,78,83,80,93,64,52},21)
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local main = Instance.new(_d({49,93,76,88,80},21))
main.Size = UDim2.new(0, 300, 0, 340)
main.Position = UDim2.new(0.4, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(24, 26, 32)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui
local corner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main
local stroke = Instance.new(_d({64,52,62,95,93,90,86,80},21))
stroke.Color = Color3.fromRGB(60, 64, 78)
stroke.Thickness = 1.5
stroke.Parent = main
local title = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 15, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextColor3 = Color3.fromRGB(240, 242, 248)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = _d({219,138,119,119,11,50,59,58,11,51,96,77,11,55,76,96,89,78,83,80,93},21)
title.Parent = main
local closeBtn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
closeBtn.Size = UDim2.new(0, 24, 0, 24)
closeBtn.Position = UDim2.new(1, -34, 0, 13)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 11
closeBtn.Parent = main
Instance.new(_d({64,52,46,90,93,89,80,93},21), closeBtn).CornerRadius = UDim.new(0, 5)
closeBtn.MouseButton1Click:Connect(function()
screenGui:Destroy()
end)
local status = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
status.Size = UDim2.new(1, -30, 0, 20)
status.Position = UDim2.new(0, 15, 0, 45)
status.BackgroundTransparency = 1
status.Font = Enum.Font.GothamMedium
status.TextSize = 11
status.TextColor3 = Color3.fromRGB(150, 155, 170)
status.TextXAlignment = Enum.TextXAlignment.Left
status.Text = _d({46,83,90,90,94,80,11,76,11,77,90,95,11,90,93,11,96,95,84,87,84,95,100,11,95,90,11,93,96,89,37},21)
status.Parent = main
local buttonCount = 0
local function CreateLaunchButton(text, desc, onClick)
local btn = Instance.new(_d({63,80,99,95,45,96,95,95,90,89},21))
btn.Size = UDim2.new(1, -30, 0, 42)
btn.Position = UDim2.new(0, 15, 0, 75 + (buttonCount * 48))
btn.BackgroundColor3 = Color3.fromRGB(36, 39, 50)
btn.Font = Enum.Font.GothamBold
btn.TextSize = 12
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Text = _d({11,11},21) .. text
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.Parent = main
local btnCorner = Instance.new(_d({64,52,46,90,93,89,80,93},21))
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = btn
local btnStroke = Instance.new(_d({64,52,62,95,93,90,86,80},21))
btnStroke.Color = Color3.fromRGB(48, 52, 68)
btnStroke.Thickness = 1
btnStroke.Parent = btn
local descLabel = Instance.new(_d({63,80,99,95,55,76,77,80,87},21))
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
CreateLaunchButton(_d({46,96,91,84,79,11,47,96,89,82,80,90,89,11,49,76,93,88},21), _d({44,96,95,90,88,76,95,80,11,78,96,91,84,79,11,79,96,89,82,80,90,89,94,11,17,11,77,90,94,94,11,78,100,78,87,80,94},21), loadCupidDungeon)
CreateLaunchButton(_d({51,90,93,90,11,45,90,94,94,11,49,76,93,88,11,19,62,84,87,80,89,95,11,44,84,88,20},21), _d({44,96,95,90,81,76,93,88,11,90,97,80,93,98,90,93,87,79,11,77,90,94,94,80,94,11,96,94,84,89,82,11,51,90,93,90,11,81,93,96,84,95,94},21), loadHoroBossFarm)
CreateLaunchButton(_d({55,80,97,80,87,11,17,11,56,90,77,11,50,93,84,89,79,80,93},21), _d({44,96,95,90,24,87,80,97,80,87,11,76,89,79,11,81,76,93,88,11,87,90,78,76,87,11,57,59,46,11,88,90,77,94},21), loadLevelGrinder)
CreateLaunchButton(_d({48,76,94,100,11,63,93,76,97,80,87,11,19,59,11,63,90,82,82,87,80,20},21), _d({66,44,62,47,11,49,87,84,82,83,95,11,98,84,95,83,11,82,93,90,96,89,79,11,81,90,87,87,90,98,11,17,11,98,76,87,87,11,78,87,84,88,77,84,89,82},21), loadNavigationLab)
CreateLaunchButton(_d({59,83,100,94,84,78,94,11,58,97,80,93,98,90,93,87,79,11,63,80,94,95,80,93},21), _d({63,80,94,95,11,78,90,88,77,76,95,11,83,90,97,80,93,23,11,82,80,91,91,90,11,17,11,79,90,79,82,80,11,83,80,84,82,83,95,94},21), loadOverworldTester)
end
task.spawn(CreateLauncherUI)
print(_d({70,50,59,58,11,51,96,77,72,11,55,76,96,89,78,83,80,93,11,64,52,11,84,89,84,95,84,76,87,84,101,80,79,25},21))
end)()