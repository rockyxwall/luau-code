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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({3,48,46,42},63)
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
local Players = game:GetService(_d({17,45,34,58,38,51,52},63))
local ReplicatedStorage = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({20,53,34,53,52},63) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({17,38,45,42},63))
if not (peliValueObj and peliValueObj:IsA(_d({23,34,45,54,38,3,34,52,38},63))) then
local nested = statsFolder:FindFirstChild(_d({20,53,34,53,52},63))
peliValueObj = nested and nested:FindFirstChild(_d({17,38,45,42},63))
end
levelValueObj = statsFolder:FindFirstChild(_d({13,38,55,38,45},63))
if not (levelValueObj and levelValueObj:IsA(_d({23,34,45,54,38,3,34,52,38},63))) then
local nested = statsFolder:FindFirstChild(_d({20,53,34,53,52},63))
levelValueObj = nested and nested:FindFirstChild(_d({13,38,55,38,45},63))
end
staminaValueObj = statsFolder:FindFirstChild(_d({20,53,34,46,42,47,34},63))
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
local hum = char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37},63))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({22,52,38,51,10,47,49,54,53,20,38,51,55,42,36,38},63))
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
print("[" .. tostring(name) .. _d({30,225,20,53,34,47,37,34,45,48,47,38,225,14,48,37,38,251,225,17,51,38,52,52,225,232},63) .. toggleKey.Name .. _d({232,225,53,48,225,53,48,40,40,45,38,239},63))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({11,44,243,11,12,21,2,12,4,39},63),
TeleportLocation = _d({242,52,53,20,38,34},63)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({7,42,51,52,53,225,20,38,34,225,9,48,46,38,52,36,51,38,38,47,225,240,225,14,34,42,47,225,14,38,47,54},63),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({52,53,51,42,47,40},63) and code ~= "" then
print(string.format(_d({28,20,34,39,38,40,54,34,51,37,30,225,11,48,42,47,42,47,40,225,17,51,42,55,34,53,38,225,20,38,51,55,38,51,225,232,230,52,232,239,239,239},63), code))
task.spawn(function()
local rs = game:GetService(_d({19,38,49,45,42,36,34,53,38,37,20,53,48,51,34,40,38},63))
local reservedRemote = rs:WaitForChild(_d({6,55,38,47,53,52},63)):WaitForChild(_d({51,38,52,38,51,55,38,37},63))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({19,38,46,48,53,38,6,55,38,47,53},63)) and (v.Name == _d({19,38,46,48,53,38,6,55,38,47,53},63) or v.Name == _d({53,38,45,38},63) or v.Name == _d({21,38,45,38,49,48,51,53},63)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({28,20,34,39,38,40,54,34,51,37,30,225,7,42,51,42,47,40,225,53,38,45,38,49,48,51,53,225,51,38,46,48,53,38,251,225},63) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,4,48,54,45,37,225,47,48,53,225,39,42,47,37,225,19,38,46,48,53,38,6,55,38,47,53,225,42,47,225,47,42,45,239,225,17,51,42,47,53,42,47,40,225,34,45,45,225,19,38,46,48,53,38,6,55,38,47,53,52,225,42,47,225,47,42,45,251},63))
for _,v in next, getnilinstances() do
if v:IsA(_d({19,38,46,48,53,38,6,55,38,47,53},63)) then
print(_d({225,238,225,15,34,46,38,251},63), v.Name)
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
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,24,51,48,47,40,225,40,34,46,38,225,54,47,42,55,38,51,52,38,226,225,20,36,51,42,49,53,225,42,52,225,48,47,45,58,225,39,48,51,225,8,17,16,239},63))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,20,36,51,42,49,53,225,38,57,38,36,54,53,42,48,47,225,35,45,48,36,44,38,37,225,48,47,251,225},63) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({28,20,34,39,38,40,54,34,51,37,30,225,21,38,45,38,49,48,51,53,42,47,40,225,53,48,225,17,51,42,55,34,53,38,225,20,38,51,55,38,51,239,239,239,225,17,45,38,34,52,38,225,56,34,42,53,239},63))
else
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,17,51,42,55,34,53,38,20,38,51,55,38,51,4,48,37,38,225,42,52,225,47,48,53,225,52,38,53,239,225,4,34,47,47,48,53,225,34,54,53,48,238,43,48,42,47,239},63))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,24,51,48,47,40,225,40,34,46,38,225,54,47,42,55,38,51,52,38,226,225,20,36,51,42,49,53,225,42,52,225,48,47,45,58,225,39,48,51,225,8,17,16,239},63))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({28,20,34,39,38,40,54,34,51,37,30,225,26,48,54,225,34,51,38,225,48,47,225,53,41,38,225,9,48,46,38,52,36,51,38,38,47,239,225,20,36,51,42,49,53,225,51,38,50,54,42,51,38,52,225,230,52,239},63), name or _d({34,225,52,49,38,36,42,39,42,36,225,49,45,34,36,38},63)))
if Safeguard.JoinPrivateServer() then
print(_d({28,20,34,39,38,40,54,34,51,37,30,225,21,38,45,38,49,48,51,53,42,47,40,225,53,48,225,17,51,42,55,34,53,38,225,20,38,51,55,38,51,239,239,239,225,17,45,38,34,52,38,225,56,34,42,53,239},63))
else
warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,17,51,42,55,34,53,38,20,38,51,55,38,51,4,48,37,38,225,42,52,225,47,48,53,225,52,38,53,239,225,4,34,47,47,48,53,225,34,54,53,48,238,43,48,42,47,239},63))
end
return false
end
warn(string.format(_d({28,20,34,39,38,40,54,34,51,37,30,225,24,51,48,47,40,225,49,45,34,36,38,226,225,19,38,50,54,42,51,38,37,251,225,230,52,225,233,230,37,234,237,225,4,54,51,51,38,47,53,251,225,230,37},63), name or _d({22,47,44,47,48,56,47},63), placeId, game.PlaceId))
return false
end
return Safeguard
end)()
function Core.GetSafeguard()
if Safeguard then return Safeguard end
return Core.Import(_d({241,242,238,40,49,48,240,45,42,35,240,52,34,39,38,40,54,34,51,37,239,45,54,34},63), _d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,45,54,34,54,238,36,48,37,38,240,46,34,42,47,240,241,242,32,52,36,51,42,49,53,240,45,42,35,240,52,34,39,38,40,54,34,51,37,239,45,54,34},63))
end
return Core
end)()
if not Core then
pcall(function()
Core = loadstring(game:HttpGet(_d({41,53,53,49,52,251,240,240,51,34,56,239,40,42,53,41,54,35,54,52,38,51,36,48,47,53,38,47,53,239,36,48,46,240,51,48,36,44,58,57,56,34,45,45,240,45,54,34,54,238,36,48,37,38,240,46,34,42,47,240,241,242,32,52,36,51,42,49,53,240,45,42,35,240,36,48,51,38,239,45,54,34},63)))()
end)
end
if not Core then warn(_d({28,4,48,51,38,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,226},63)); return end
local Safeguard = Core.GetSafeguard()
function QuestHandler.AcceptQuest(npcName)
local npcsFolder = Workspace:FindFirstChild(_d({15,17,4,52},63))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({22,49,49,38,51,21,48,51,52,48},63))
local prompt = torso and torso:FindFirstChild(_d({17,51,48,46,49,53},63))
if not prompt then
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,15,48,225,49,51,48,46,49,53,225,39,48,54,47,37,225,39,48,51,225,15,17,4,251,225},63) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({9,54,46,34,47,48,42,37,19,48,48,53,17,34,51,53},63))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,17,45,34,58,38,51,225,53,48,48,225,39,34,51,225,39,51,48,46,225,15,17,4,251,225},63) .. tostring(npcName) .. _d({225,233,5,42,52,53,251,225},63) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({17,45,34,58,38,51,8,54,42},63))
local chatGui = playerGui and playerGui:FindFirstChild(_d({15,17,4,4,9,2,21},63))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,39,42,51,38,49,51,48,57,42,46,42,53,58,49,51,48,46,49,53,225,47,48,53,225,52,54,49,49,48,51,53,38,37,225,35,58,225,38,57,38,36,54,53,48,51,226},63))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({15,17,4,4,9,2,21},63))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({7,51,34,46,38},63))
local goBtn = frame and frame:FindFirstChild(_d({40,48},63))
local endChatBtn = frame and frame:FindFirstChild(_d({38,47,37,4,41,34,53},63))
if goBtn and goBtn.Visible and goBtn.Text ~= "" then
if getconnections then
for _, conn in ipairs(getconnections(goBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(goBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
elseif endChatBtn and endChatBtn.Visible then
if getconnections then
for _, conn in ipairs(getconnections(endChatBtn.Activated)) do
pcall(function() conn:Fire() end)
end
for _, conn in ipairs(getconnections(endChatBtn.MouseButton1Click)) do
pcall(function() conn:Fire() end)
end
end
end
task.wait(0.8)
end
end
return true
end
function QuestHandler.Start()
if QuestHandler.Running then return end
if not Safeguard then warn(_d({28,20,34,39,38,40,54,34,51,37,30,225,7,34,42,45,38,37,225,53,48,225,45,48,34,37,226},63)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,2,53,53,38,46,49,53,42,47,40,225,53,48,225,53,34,45,44,225,53,48,225,53,38,52,53,225,15,17,4,251},63), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({28,18,54,38,52,53,225,9,34,47,37,45,38,51,30,225,20,53,48,49,49,38,37,239},63))
end
Core.SetupStandalone(
QuestHandler,
_d({18,54,38,52,53,225,9,34,47,37,45,38,51},63),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()