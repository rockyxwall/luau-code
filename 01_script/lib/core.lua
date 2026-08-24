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
function Core.GetSafeguard()
return Core.Import(_d({12,13,9,67,76,75,11,72,69,62,11,79,61,66,65,67,81,61,78,64,10,72,81,61},36), _d({68,80,80,76,79,22,11,11,78,61,83,10,67,69,80,68,81,62,81,79,65,78,63,75,74,80,65,74,80,10,63,75,73,11,78,75,63,71,85,84,83,61,72,72,11,72,81,61,81,9,63,75,64,65,11,73,61,69,74,11,12,13,59,79,63,78,69,76,80,11,72,69,62,11,79,61,66,65,67,81,61,78,64,10,72,81,61},36))
end
return Core
end)()