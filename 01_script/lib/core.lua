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
local Players = game:GetService(_d({20,48,37,61,41,54,55},60))
local ReplicatedStorage = game:GetService(_d({22,41,52,48,45,39,37,56,41,40,23,56,51,54,37,43,41},60))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({23,56,37,56,55},60) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({20,41,48,45},60))
if not (peliValueObj and peliValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
peliValueObj = nested and nested:FindFirstChild(_d({20,41,48,45},60))
end
levelValueObj = statsFolder:FindFirstChild(_d({16,41,58,41,48},60))
if not (levelValueObj and levelValueObj:IsA(_d({26,37,48,57,41,6,37,55,41},60))) then
local nested = statsFolder:FindFirstChild(_d({23,56,37,56,55},60))
levelValueObj = nested and nested:FindFirstChild(_d({16,41,58,41,48},60))
end
staminaValueObj = statsFolder:FindFirstChild(_d({23,56,37,49,45,50,37},60))
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
local hum = char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40},60))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({25,55,41,54,13,50,52,57,56,23,41,54,58,45,39,41},60))
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
print("[" .. tostring(name) .. _d({33,228,23,56,37,50,40,37,48,51,50,41,228,17,51,40,41,254,228,20,54,41,55,55,228,235},60) .. toggleKey.Name .. _d({235,228,56,51,228,56,51,43,43,48,41,242},60))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({12,57,49,37,50,51,45,40,22,51,51,56,20,37,54,56},60))
end
function Core.GetSafeguard()
return Core.Import(_d({244,245,241,43,52,51,243,48,45,38,243,55,37,42,41,43,57,37,54,40,242,48,57,37},60), _d({44,56,56,52,55,254,243,243,54,37,59,242,43,45,56,44,57,38,57,55,41,54,39,51,50,56,41,50,56,242,39,51,49,243,54,51,39,47,61,60,59,37,48,48,243,48,57,37,57,241,39,51,40,41,243,49,37,45,50,243,244,245,35,55,39,54,45,52,56,243,48,45,38,243,55,37,42,41,43,57,37,54,40,242,48,57,37},60))
end
return Core
end)()