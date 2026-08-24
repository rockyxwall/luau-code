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
local Players = game:GetService(_d({41,69,58,82,62,75,76},39))
local ReplicatedStorage = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({44,77,58,77,76},39) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({41,62,69,66},39))
if not (peliValueObj and peliValueObj:IsA(_d({47,58,69,78,62,27,58,76,62},39))) then
local nested = statsFolder:FindFirstChild(_d({44,77,58,77,76},39))
peliValueObj = nested and nested:FindFirstChild(_d({41,62,69,66},39))
end
levelValueObj = statsFolder:FindFirstChild(_d({37,62,79,62,69},39))
if not (levelValueObj and levelValueObj:IsA(_d({47,58,69,78,62,27,58,76,62},39))) then
local nested = statsFolder:FindFirstChild(_d({44,77,58,77,76},39))
levelValueObj = nested and nested:FindFirstChild(_d({37,62,79,62,69},39))
end
staminaValueObj = statsFolder:FindFirstChild(_d({44,77,58,70,66,71,58},39))
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
local hum = char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61},39))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({46,76,62,75,34,71,73,78,77,44,62,75,79,66,60,62},39))
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
print("[" .. tostring(name) .. _d({54,249,44,77,58,71,61,58,69,72,71,62,249,38,72,61,62,19,249,41,75,62,76,76,249,0},39) .. toggleKey.Name .. _d({0,249,77,72,249,77,72,64,64,69,62,7},39))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({33,78,70,58,71,72,66,61,43,72,72,77,41,58,75,77},39))
end
function Core.GetSafeguard()
return Core.Import(_d({9,10,6,64,73,72,8,69,66,59,8,76,58,63,62,64,78,58,75,61,7,69,78,58},39), _d({65,77,77,73,76,19,8,8,75,58,80,7,64,66,77,65,78,59,78,76,62,75,60,72,71,77,62,71,77,7,60,72,70,8,75,72,60,68,82,81,80,58,69,69,8,69,78,58,78,6,60,72,61,62,8,70,58,66,71,8,9,10,56,76,60,75,66,73,77,8,69,66,59,8,76,58,63,62,64,78,58,75,61,7,69,78,58},39))
end
return Core
end)()