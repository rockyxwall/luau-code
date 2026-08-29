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
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({35,80,78,74},31),
}
local Core = (function()
local Core = {}
local Players = game:GetService(_d({49,77,66,90,70,83,84},31))
local ReplicatedStorage = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({52,85,66,85,84},31) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({49,70,77,74},31))
if not (peliValueObj and peliValueObj:IsA(_d({55,66,77,86,70,35,66,84,70},31))) then
local nested = statsFolder:FindFirstChild(_d({52,85,66,85,84},31))
peliValueObj = nested and nested:FindFirstChild(_d({49,70,77,74},31))
end
levelValueObj = statsFolder:FindFirstChild(_d({45,70,87,70,77},31))
if not (levelValueObj and levelValueObj:IsA(_d({55,66,77,86,70,35,66,84,70},31))) then
local nested = statsFolder:FindFirstChild(_d({52,85,66,85,84},31))
levelValueObj = nested and nested:FindFirstChild(_d({45,70,87,70,77},31))
end
staminaValueObj = statsFolder:FindFirstChild(_d({52,85,66,78,74,79,66},31))
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
local hum = char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69},31))
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
local UserInputService = game:GetService(_d({54,84,70,83,42,79,81,86,85,52,70,83,87,74,68,70},31))
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
print("[" .. tostring(name) .. _d({62,1,52,85,66,79,69,66,77,80,79,70,1,46,80,69,70,27,1,49,83,70,84,84,1,8},31) .. toggleKey.Name .. _d({8,1,85,80,1,85,80,72,72,77,70,15},31))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({43,76,19,43,44,53,34,44,36,71},31),
TeleportLocation = _d({18,84,85,52,70,66},31),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({39,74,83,84,85,1,52,70,66,1,41,80,78,70,84,68,83,70,70,79,1,16,1,46,66,74,79,1,46,70,79,86},31),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({84,85,83,74,79,72},31) and code ~= "" then
print(string.format(_d({60,52,66,71,70,72,86,66,83,69,62,1,43,80,74,79,74,79,72,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,1,8,6,84,8,15,15,15},31), code))
task.spawn(function()
local rs = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local reservedRemote = rs:WaitForChild(_d({38,87,70,79,85,84},31)):WaitForChild(_d({83,70,84,70,83,87,70,69},31))
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
v:IsA(_d({51,70,78,80,85,70,38,87,70,79,85},31)) and (v.Name == _d({51,70,78,80,85,70,38,87,70,79,85},31) or v.Name == _d({85,70,77,70},31) or v.Name == _d({53,70,77,70,81,80,83,85},31))
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
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,74,83,74,79,72,1,85,70,77,70,81,80,83,85,1,83,70,78,80,85,70,27,1},31) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,36,80,86,77,69,1,79,80,85,1,71,74,79,69,1,51,70,78,80,85,70,38,87,70,79,85,1,74,79,1,79,74,77,15,1,49,83,74,79,85,74,79,72,1,66,77,77,1,51,70,78,80,85,70,38,87,70,79,85,84,1,74,79,1,79,74,77,27},31))
for _, v in next, getnilinstances() do
if v:IsA(_d({51,70,78,80,85,70,38,87,70,79,85},31)) then
print(_d({1,14,1,47,66,78,70,27},31), v.Name)
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
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,72,66,78,70,1,86,79,74,87,70,83,84,70,2,1,52,68,83,74,81,85,1,74,84,1,80,79,77,90,1,71,80,83,1,40,49,48,15},31))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,52,68,83,74,81,85,1,70,89,70,68,86,85,74,80,79,1,67,77,80,68,76,70,69,1,80,79,27,1},31) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,53,70,77,70,81,80,83,85,74,79,72,1,85,80,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,15,15,15,1,49,77,70,66,84,70,1,88,66,74,85,15},31))
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,49,83,74,87,66,85,70,52,70,83,87,70,83,36,80,69,70,1,74,84,1,79,80,85,1,84,70,85,15,1,36,66,79,79,80,85,1,66,86,85,80,14,75,80,74,79,15},31))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,72,66,78,70,1,86,79,74,87,70,83,84,70,2,1,52,68,83,74,81,85,1,74,84,1,80,79,77,90,1,71,80,83,1,40,49,48,15},31))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({60,52,66,71,70,72,86,66,83,69,62,1,58,80,86,1,66,83,70,1,80,79,1,85,73,70,1,41,80,78,70,84,68,83,70,70,79,15,1,52,68,83,74,81,85,1,83,70,82,86,74,83,70,84,1,6,84,15},31), name or _d({66,1,84,81,70,68,74,71,74,68,1,81,77,66,68,70},31)))
if Safeguard.JoinPrivateServer() then
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,53,70,77,70,81,80,83,85,74,79,72,1,85,80,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,15,15,15,1,49,77,70,66,84,70,1,88,66,74,85,15},31))
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,49,83,74,87,66,85,70,52,70,83,87,70,83,36,80,69,70,1,74,84,1,79,80,85,1,84,70,85,15,1,36,66,79,79,80,85,1,66,86,85,80,14,75,80,74,79,15},31))
end
return false
end
warn(
string.format(
_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,81,77,66,68,70,2,1,51,70,82,86,74,83,70,69,27,1,6,84,1,9,6,69,10,13,1,36,86,83,83,70,79,85,27,1,6,69},31),
name or _d({54,79,76,79,80,88,79},31),
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
local npcsFolder = Workspace:FindFirstChild(_d({47,49,36,84},31))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({54,81,81,70,83,53,80,83,84,80},31))
local prompt = torso and torso:FindFirstChild(_d({49,83,80,78,81,85},31))
if not prompt then
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,47,80,1,81,83,80,78,81,85,1,71,80,86,79,69,1,71,80,83,1,47,49,36,27,1},31) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({41,86,78,66,79,80,74,69,51,80,80,85,49,66,83,85},31))
if not myRoot then
return false
end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,49,77,66,90,70,83,1,85,80,80,1,71,66,83,1,71,83,80,78,1,47,49,36,27,1},31) .. tostring(npcName) .. _d({1,9,37,74,84,85,27,1},31) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({49,77,66,90,70,83,40,86,74},31))
local chatGui = playerGui and playerGui:FindFirstChild(_d({47,49,36,36,41,34,53},31))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,71,74,83,70,81,83,80,89,74,78,74,85,90,81,83,80,78,81,85,1,79,80,85,1,84,86,81,81,80,83,85,70,69,1,67,90,1,70,89,70,68,86,85,80,83,2},31))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({47,49,36,36,41,34,53},31))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({39,83,66,78,70},31))
local goBtn = frame and frame:FindFirstChild(_d({72,80},31))
local endChatBtn = frame and frame:FindFirstChild(_d({70,79,69,36,73,66,85},31))
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
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,66,74,77,70,69,1,85,80,1,77,80,66,69,2},31))
return
end
if not Safeguard.IsSafe() then
return
end
QuestHandler.Running = true
task.spawn(function()
print(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,34,85,85,70,78,81,85,74,79,72,1,85,80,1,85,66,77,76,1,85,80,1,85,70,84,85,1,47,49,36,27},31), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({60,50,86,70,84,85,1,41,66,79,69,77,70,83,62,1,52,85,80,81,81,70,69,15},31))
end
Core.SetupStandalone(QuestHandler, _d({50,86,70,84,85,1,41,66,79,69,77,70,83},31), QuestHandler.Start, QuestHandler.Stop, function()
return QuestHandler.Running
end, Enum.KeyCode.P, true)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()