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
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = (function()
local Players = game:GetService(_d({59,87,76,100,80,93,94},21))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({45,90,88,84},21),
}
local Core = (function()
local Core = {}
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
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({57,59,46,94},21))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({64,91,91,80,93,63,90,93,94,90},21))
local prompt = torso and torso:FindFirstChild(_d({59,93,90,88,91,95},21))
if not prompt then
warn(_d({70,60,96,80,94,95,11,51,76,89,79,87,80,93,72,11,57,90,11,91,93,90,88,91,95,11,81,90,96,89,79,11,81,90,93,11,57,59,46,37,11},21) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not myRoot then
return false
end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({70,60,96,80,94,95,11,51,76,89,79,87,80,93,72,11,59,87,76,100,80,93,11,95,90,90,11,81,76,93,11,81,93,90,88,11,57,59,46,37,11},21) .. tostring(npcName) .. _d({11,19,47,84,94,95,37,11},21) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({59,87,76,100,80,93,50,96,84},21))
local chatGui = playerGui and playerGui:FindFirstChild(_d({57,59,46,46,51,44,63},21))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({70,60,96,80,94,95,11,51,76,89,79,87,80,93,72,11,81,84,93,80,91,93,90,99,84,88,84,95,100,91,93,90,88,91,95,11,89,90,95,11,94,96,91,91,90,93,95,80,79,11,77,100,11,80,99,80,78,96,95,90,93,12},21))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({57,59,46,46,51,44,63},21))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({49,93,76,88,80},21))
local goBtn = frame and frame:FindFirstChild(_d({82,90},21))
local endChatBtn = frame and frame:FindFirstChild(_d({80,89,79,46,83,76,95},21))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
pcall(function()
conn:Fire()
end)
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function()
conn:Fire()
end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
pcall(function()
conn:Fire()
end)
end
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
pcall(function()
conn:Fire()
end)
end
end
end
task.wait(0.8)
end
end
return true
end
function QuestHandler.Start()
if QuestHandler.Running then
return
end
if not Safeguard then
warn(_d({70,62,76,81,80,82,96,76,93,79,72,11,49,76,84,87,80,79,11,95,90,11,87,90,76,79,12},21))
return
end
if not Safeguard.IsSafe() then
return
end
QuestHandler.Running = true
task.spawn(function()
print(_d({70,60,96,80,94,95,11,51,76,89,79,87,80,93,72,11,44,95,95,80,88,91,95,84,89,82,11,95,90,11,95,76,87,86,11,95,90,11,95,80,94,95,11,57,59,46,37},21), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({70,60,96,80,94,95,11,51,76,89,79,87,80,93,72,11,62,95,90,91,91,80,79,25},21))
end
Core.SetupStandalone(QuestHandler, _d({60,96,80,94,95,11,51,76,89,79,87,80,93},21), QuestHandler.Start, QuestHandler.Stop, function()
return QuestHandler.Running
end, Enum.KeyCode.P, true)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()
local function getNearestNPC()
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({51,96,88,76,89,90,84,79,61,90,90,95,59,76,93,95},21))
if not myRoot then
return nil
end
local npcsFolder = Workspace:FindFirstChild(_d({57,59,46,94},21))
if not npcsFolder then
return nil
end
local nearest, minDist = nil, 12
for _, npc in ipairs(npcsFolder:GetChildren()) do
local torso = npc:FindFirstChild(_d({64,91,91,80,93,63,90,93,94,90},21))
local prompt = torso and torso:FindFirstChild(_d({59,93,90,88,91,95},21))
if prompt then
local dist = (torso.Position - myRoot.Position).Magnitude
if dist < minDist then
minDist = dist
nearest = npc
end
end
end
return nearest
end
local npc = getNearestNPC()
if npc then
if QuestHandler then
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,52,89,97,90,86,84,89,82,11,94,83,76,93,80,79,11,60,96,80,94,95,51,76,89,79,87,80,93,11,81,90,93,11,57,59,46,37,11},21) .. npc.Name)
local success = QuestHandler.AcceptQuest(npc.Name)
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,49,84,89,84,94,83,80,79,11,94,80,92,96,80,89,78,80,25,11,61,80,94,96,87,95,37,11},21) .. tostring(success))
else
warn(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,48,61,61,58,61,37,11,60,96,80,94,95,51,76,89,79,87,80,93,11,87,84,77,93,76,93,100,11,78,90,96,87,79,11,89,90,95,11,77,80,11,87,90,76,79,80,79,12},21))
end
else
print(_d({70,60,96,80,94,95,11,63,80,94,95,80,93,72,11,57,90,11,92,96,80,94,95,11,57,59,46,11,81,90,96,89,79,11,98,84,95,83,84,89,11,28,29,11,94,95,96,79,94,25},21))
end
end)()