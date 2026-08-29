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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local Workspace = workspace
local LocalPlayer = Players.LocalPlayer
local QuestHandler = {
Connections = {},
Running = false,
TargetNPC = _d({32,77,75,71},34)
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
local Players = game:GetService(_d({46,74,63,87,67,80,81},34))
local ReplicatedStorage = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({49,82,63,82,81},34) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({46,67,74,71},34))
if not (peliValueObj and peliValueObj:IsA(_d({52,63,74,83,67,32,63,81,67},34))) then
local nested = statsFolder:FindFirstChild(_d({49,82,63,82,81},34))
peliValueObj = nested and nested:FindFirstChild(_d({46,67,74,71},34))
end
levelValueObj = statsFolder:FindFirstChild(_d({42,67,84,67,74},34))
if not (levelValueObj and levelValueObj:IsA(_d({52,63,74,83,67,32,63,81,67},34))) then
local nested = statsFolder:FindFirstChild(_d({49,82,63,82,81},34))
levelValueObj = nested and nested:FindFirstChild(_d({42,67,84,67,74},34))
end
staminaValueObj = statsFolder:FindFirstChild(_d({49,82,63,75,71,76,63},34))
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
local hum = char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66},34))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({51,81,67,80,39,76,78,83,82,49,67,80,84,71,65,67},34))
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
print("[" .. tostring(name) .. _d({59,254,49,82,63,76,66,63,74,77,76,67,254,43,77,66,67,24,254,46,80,67,81,81,254,5},34) .. toggleKey.Name .. _d({5,254,82,77,254,82,77,69,69,74,67,12},34))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
end
local Safeguard = (function()
local Safeguard = {
Config = {
PrivateServerCode = _d({40,73,16,40,41,50,31,41,33,68},34),
TeleportLocation = _d({15,81,82,49,67,63},34)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({36,71,80,81,82,254,49,67,63,254,38,77,75,67,81,65,80,67,67,76,254,13,254,43,63,71,76,254,43,67,76,83},34),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({81,82,80,71,76,69},34) and code ~= "" then
print(string.format(_d({57,49,63,68,67,69,83,63,80,66,59,254,40,77,71,76,71,76,69,254,46,80,71,84,63,82,67,254,49,67,80,84,67,80,254,5,3,81,5,12,12,12},34), code))
task.spawn(function()
local rs = game:GetService(_d({48,67,78,74,71,65,63,82,67,66,49,82,77,80,63,69,67},34))
local reservedRemote = rs:WaitForChild(_d({35,84,67,76,82,81},34)):WaitForChild(_d({80,67,81,67,80,84,67,66},34))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({48,67,75,77,82,67,35,84,67,76,82},34)) and (v.Name == _d({48,67,75,77,82,67,35,84,67,76,82},34) or v.Name == _d({82,67,74,67},34) or v.Name == _d({50,67,74,67,78,77,80,82},34)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({57,49,63,68,67,69,83,63,80,66,59,254,36,71,80,71,76,69,254,82,67,74,67,78,77,80,82,254,80,67,75,77,82,67,24,254},34) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,33,77,83,74,66,254,76,77,82,254,68,71,76,66,254,48,67,75,77,82,67,35,84,67,76,82,254,71,76,254,76,71,74,12,254,46,80,71,76,82,71,76,69,254,63,74,74,254,48,67,75,77,82,67,35,84,67,76,82,81,254,71,76,254,76,71,74,24},34))
for _,v in next, getnilinstances() do
if v:IsA(_d({48,67,75,77,82,67,35,84,67,76,82},34)) then
print(_d({254,11,254,44,63,75,67,24},34), v.Name)
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
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,53,80,77,76,69,254,69,63,75,67,254,83,76,71,84,67,80,81,67,255,254,49,65,80,71,78,82,254,71,81,254,77,76,74,87,254,68,77,80,254,37,46,45,12},34))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,49,65,80,71,78,82,254,67,86,67,65,83,82,71,77,76,254,64,74,77,65,73,67,66,254,77,76,24,254},34) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({57,49,63,68,67,69,83,63,80,66,59,254,50,67,74,67,78,77,80,82,71,76,69,254,82,77,254,46,80,71,84,63,82,67,254,49,67,80,84,67,80,12,12,12,254,46,74,67,63,81,67,254,85,63,71,82,12},34))
else
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,46,80,71,84,63,82,67,49,67,80,84,67,80,33,77,66,67,254,71,81,254,76,77,82,254,81,67,82,12,254,33,63,76,76,77,82,254,63,83,82,77,11,72,77,71,76,12},34))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,53,80,77,76,69,254,69,63,75,67,254,83,76,71,84,67,80,81,67,255,254,49,65,80,71,78,82,254,71,81,254,77,76,74,87,254,68,77,80,254,37,46,45,12},34))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({57,49,63,68,67,69,83,63,80,66,59,254,55,77,83,254,63,80,67,254,77,76,254,82,70,67,254,38,77,75,67,81,65,80,67,67,76,12,254,49,65,80,71,78,82,254,80,67,79,83,71,80,67,81,254,3,81,12},34), name or _d({63,254,81,78,67,65,71,68,71,65,254,78,74,63,65,67},34)))
if Safeguard.JoinPrivateServer() then
print(_d({57,49,63,68,67,69,83,63,80,66,59,254,50,67,74,67,78,77,80,82,71,76,69,254,82,77,254,46,80,71,84,63,82,67,254,49,67,80,84,67,80,12,12,12,254,46,74,67,63,81,67,254,85,63,71,82,12},34))
else
warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,46,80,71,84,63,82,67,49,67,80,84,67,80,33,77,66,67,254,71,81,254,76,77,82,254,81,67,82,12,254,33,63,76,76,77,82,254,63,83,82,77,11,72,77,71,76,12},34))
end
return false
end
warn(string.format(_d({57,49,63,68,67,69,83,63,80,66,59,254,53,80,77,76,69,254,78,74,63,65,67,255,254,48,67,79,83,71,80,67,66,24,254,3,81,254,6,3,66,7,10,254,33,83,80,80,67,76,82,24,254,3,66},34), name or _d({51,76,73,76,77,85,76},34), placeId, game.PlaceId))
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
local npcsFolder = Workspace:FindFirstChild(_d({44,46,33,81},34))
local npc = npcsFolder and npcsFolder:FindFirstChild(npcName)
local torso = npc and npc:FindFirstChild(_d({51,78,78,67,80,50,77,80,81,77},34))
local prompt = torso and torso:FindFirstChild(_d({46,80,77,75,78,82},34))
if not prompt then
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,44,77,254,78,80,77,75,78,82,254,68,77,83,76,66,254,68,77,80,254,44,46,33,24,254},34) .. tostring(npcName))
return false
end
local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(_d({38,83,75,63,76,77,71,66,48,77,77,82,46,63,80,82},34))
if not myRoot then return false end
local dist = (torso.Position - myRoot.Position).Magnitude
if dist > 12 then
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,46,74,63,87,67,80,254,82,77,77,254,68,63,80,254,68,80,77,75,254,44,46,33,24,254},34) .. tostring(npcName) .. _d({254,6,34,71,81,82,24,254},34) .. tostring(dist) .. ")")
return false
end
local playerGui = LocalPlayer:FindFirstChild(_d({46,74,63,87,67,80,37,83,71},34))
local chatGui = playerGui and playerGui:FindFirstChild(_d({44,46,33,33,38,31,50},34))
if not (chatGui and chatGui.Enabled) then
local holdTime = prompt.HoldDuration or 0
if holdTime > 0 then
task.wait(holdTime + 0.1)
end
if fireproximityprompt then
pcall(fireproximityprompt, prompt)
else
warn(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,68,71,80,67,78,80,77,86,71,75,71,82,87,78,80,77,75,78,82,254,76,77,82,254,81,83,78,78,77,80,82,67,66,254,64,87,254,67,86,67,65,83,82,77,80,255},34))
return false
end
task.wait(0.8)
end
chatGui = playerGui:FindFirstChild(_d({44,46,33,33,38,31,50},34))
if chatGui and chatGui.Enabled then
local tries = 0
while chatGui.Enabled and tries < 15 do
tries = tries + 1
local frame = chatGui:FindFirstChild(_d({36,80,63,75,67},34))
local goBtn = frame and frame:FindFirstChild(_d({69,77},34))
local endChatBtn = frame and frame:FindFirstChild(_d({67,76,66,33,70,63,82},34))
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
if not Safeguard then warn(_d({57,49,63,68,67,69,83,63,80,66,59,254,36,63,71,74,67,66,254,82,77,254,74,77,63,66,255},34)); return end
if not Safeguard.IsSafe() then return end
QuestHandler.Running = true
task.spawn(function()
print(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,31,82,82,67,75,78,82,71,76,69,254,82,77,254,82,63,74,73,254,82,77,254,82,67,81,82,254,44,46,33,24},34), QuestHandler.TargetNPC)
QuestHandler.AcceptQuest(QuestHandler.TargetNPC)
QuestHandler.Running = false
end)
end
function QuestHandler.Stop()
QuestHandler.Running = false
print(_d({57,47,83,67,81,82,254,38,63,76,66,74,67,80,59,254,49,82,77,78,78,67,66,12},34))
end
Core.SetupStandalone(
QuestHandler,
_d({47,83,67,81,82,254,38,63,76,66,74,67,80},34),
QuestHandler.Start,
QuestHandler.Stop,
function() return QuestHandler.Running end,
Enum.KeyCode.P,
true
)
_G.QuestHandler = QuestHandler
return QuestHandler
end)()