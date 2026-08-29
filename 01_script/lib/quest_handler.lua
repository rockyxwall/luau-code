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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({16,61,59,55},50),
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
local Players = game:GetService(_d({30,58,47,71,51,64,65},50))
local ReplicatedStorage = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({33,66,47,66,65},50) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({30,51,58,55},50))
if not (peliValueObj and peliValueObj:IsA(_d({36,47,58,67,51,16,47,65,51},50))) then
local nested = statsFolder:FindFirstChild(_d({33,66,47,66,65},50))
peliValueObj = nested and nested:FindFirstChild(_d({30,51,58,55},50))
end
levelValueObj = statsFolder:FindFirstChild(_d({26,51,68,51,58},50))
if not (levelValueObj and levelValueObj:IsA(_d({36,47,58,67,51,16,47,65,51},50))) then
local nested = statsFolder:FindFirstChild(_d({33,66,47,66,65},50))
levelValueObj = nested and nested:FindFirstChild(_d({26,51,68,51,58},50))
end
staminaValueObj = statsFolder:FindFirstChild(_d({33,66,47,59,55,60,47},50))
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
local hum = char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50},50))
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
local UserInputService = game:GetService(_d({35,65,51,64,23,60,62,67,66,33,51,64,68,55,49,51},50))
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
print("[" .. tostring(name) .. _d({43,238,33,66,47,60,50,47,58,61,60,51,238,27,61,50,51,8,238,30,64,51,65,65,238,245},50) .. toggleKey.Name .. _d({245,238,66,61,238,66,61,53,53,58,51,252},50))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({24,57,0,24,25,34,15,25,17,52},50),
TeleportLocation = _d({255,65,66,33,51,47},50),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({20,55,64,65,66,238,33,51,47,238,22,61,59,51,65,49,64,51,51,60,238,253,238,27,47,55,60,238,27,51,60,67},50),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({65,66,64,55,60,53},50) and code ~= "" then
print(string.format(_d({41,33,47,52,51,53,67,47,64,50,43,238,24,61,55,60,55,60,53,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,238,245,243,65,245,252,252,252},50), code))
task.spawn(function()
local rs = game:GetService(_d({32,51,62,58,55,49,47,66,51,50,33,66,61,64,47,53,51},50))
local reservedRemote = rs:WaitForChild(_d({19,68,51,60,66,65},50)):WaitForChild(_d({64,51,65,51,64,68,51,50},50))
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
v:IsA(_d({32,51,59,61,66,51,19,68,51,60,66},50)) and (v.Name == _d({32,51,59,61,66,51,19,68,51,60,66},50) or v.Name == _d({66,51,58,51},50) or v.Name == _d({34,51,58,51,62,61,64,66},50))
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
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,55,64,55,60,53,238,66,51,58,51,62,61,64,66,238,64,51,59,61,66,51,8,238},50) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,17,61,67,58,50,238,60,61,66,238,52,55,60,50,238,32,51,59,61,66,51,19,68,51,60,66,238,55,60,238,60,55,58,252,238,30,64,55,60,66,55,60,53,238,47,58,58,238,32,51,59,61,66,51,19,68,51,60,66,65,238,55,60,238,60,55,58,8},50))
for _, v in next, getnilinstances() do
if v:IsA(_d({32,51,59,61,66,51,19,68,51,60,66},50)) then
print(_d({238,251,238,28,47,59,51,8},50), v.Name)
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
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,53,47,59,51,238,67,60,55,68,51,64,65,51,239,238,33,49,64,55,62,66,238,55,65,238,61,60,58,71,238,52,61,64,238,21,30,29,252},50))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,33,49,64,55,62,66,238,51,70,51,49,67,66,55,61,60,238,48,58,61,49,57,51,50,238,61,60,8,238},50) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,34,51,58,51,62,61,64,66,55,60,53,238,66,61,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,252,252,252,238,30,58,51,47,65,51,238,69,47,55,66,252},50))
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,30,64,55,68,47,66,51,33,51,64,68,51,64,17,61,50,51,238,55,65,238,60,61,66,238,65,51,66,252,238,17,47,60,60,61,66,238,47,67,66,61,251,56,61,55,60,252},50))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,53,47,59,51,238,67,60,55,68,51,64,65,51,239,238,33,49,64,55,62,66,238,55,65,238,61,60,58,71,238,52,61,64,238,21,30,29,252},50))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({41,33,47,52,51,53,67,47,64,50,43,238,39,61,67,238,47,64,51,238,61,60,238,66,54,51,238,22,61,59,51,65,49,64,51,51,60,252,238,33,49,64,55,62,66,238,64,51,63,67,55,64,51,65,238,243,65,252},50), name or _d({47,238,65,62,51,49,55,52,55,49,238,62,58,47,49,51},50)))
if Safeguard.JoinPrivateServer() then
print(_d({41,33,47,52,51,53,67,47,64,50,43,238,34,51,58,51,62,61,64,66,55,60,53,238,66,61,238,30,64,55,68,47,66,51,238,33,51,64,68,51,64,252,252,252,238,30,58,51,47,65,51,238,69,47,55,66,252},50))
else
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,30,64,55,68,47,66,51,33,51,64,68,51,64,17,61,50,51,238,55,65,238,60,61,66,238,65,51,66,252,238,17,47,60,60,61,66,238,47,67,66,61,251,56,61,55,60,252},50))
end
return false
end
warn(
string.format(
_d({41,33,47,52,51,53,67,47,64,50,43,238,37,64,61,60,53,238,62,58,47,49,51,239,238,32,51,63,67,55,64,51,50,8,238,243,65,238,246,243,50,247,250,238,17,67,64,64,51,60,66,8,238,243,50},50),
name or _d({35,60,57,60,61,69,60},50),
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
local npcsFolder = Workspace:FindFirstChild(_d({28,30,17,65},50))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({35,62,62,51,64,34,61,64,65,61},50))
local prompt = torso and torso:FindFirstChild(_d({30,64,61,59,62,66},50))
if not prompt then
warn(_d({41,31,67,51,65,66,238,22,47,60,50,58,51,64,43,238,28,61,238,62,64,61,59,62,66,238,52,61,67,60,50,238,52,61,64,238,28,30,17,8,238},50) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({22,67,59,47,60,61,55,50,32,61,61,66,30,47,64,66},50))
if not myRoot then
return false
end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({41,31,67,51,65,66,238,22,47,60,50,58,51,64,43,238,30,58,47,71,51,64,238,66,61,61,238,52,47,64,238,52,64,61,59,238,28,30,17,8,238},50) .. tostring(npcName) .. _d({238,246,18,55,65,66,8,238},50) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({30,58,47,71,51,64,21,67,55},50))
local chatGui = playerGui and playerGui:FindFirstChild(_d({28,30,17,17,22,15,34},50))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({41,31,67,51,65,66,238,22,47,60,50,58,51,64,43,238,52,55,64,51,62,64,61,70,55,59,55,66,71,62,64,61,59,62,66,238,60,61,66,238,65,67,62,62,61,64,66,51,50,238,48,71,238,51,70,51,49,67,66,61,64,239},50))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({28,30,17,17,22,15,34},50))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({20,64,47,59,51},50))
local goBtn = frame and frame:FindFirstChild(_d({53,61},50))
local endChatBtn = frame and frame:FindFirstChild(_d({51,60,50,17,54,47,66},50))
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
warn(_d({41,33,47,52,51,53,67,47,64,50,43,238,20,47,55,58,51,50,238,66,61,238,58,61,47,50,239},50))
return
end
if not Safeguard.IsSafe() then
return
end
QuestHandler.Running = true
task.spawn(function()
print(_d({41,31,67,51,65,66,238,22,47,60,50,58,51,64,43,238,15,66,66,51,59,62,66,55,60,53,238,66,61,238,66,47,58,57,238,66,61,238,66,51,65,66,238,28,30,17,8},50), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({41,31,67,51,65,66,238,22,47,60,50,58,51,64,43,238,33,66,61,62,62,51,50,252},50))
end
Core.SetupStandalone(QuestHandler, _d({31,67,51,65,66,238,22,47,60,50,58,51,64},50), QuestHandler.Start, QuestHandler.Stop, function()
return QuestHandler.Running
end, Enum.KeyCode.P, true)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()