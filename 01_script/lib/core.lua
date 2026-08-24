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
local Players = game:GetService(_d({54,82,71,95,75,88,89},26))
local ReplicatedStorage = game:GetService(_d({56,75,86,82,79,73,71,90,75,74,57,90,85,88,71,77,75},26))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({57,90,71,90,89},26) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({54,75,82,79},26))
if not (peliValueObj and peliValueObj:IsA(_d({60,71,82,91,75,40,71,89,75},26))) then
local nested = statsFolder:FindFirstChild(_d({57,90,71,90,89},26))
peliValueObj = nested and nested:FindFirstChild(_d({54,75,82,79},26))
end
levelValueObj = statsFolder:FindFirstChild(_d({50,75,92,75,82},26))
if not (levelValueObj and levelValueObj:IsA(_d({60,71,82,91,75,40,71,89,75},26))) then
local nested = statsFolder:FindFirstChild(_d({57,90,71,90,89},26))
levelValueObj = nested and nested:FindFirstChild(_d({50,75,92,75,82},26))
end
staminaValueObj = statsFolder:FindFirstChild(_d({57,90,71,83,79,84,71},26))
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
local hum = char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74},26))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({59,89,75,88,47,84,86,91,90,57,75,88,92,79,73,75},26))
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
print("[" .. tostring(name) .. _d({67,6,57,90,71,84,74,71,82,85,84,75,6,51,85,74,75,32,6,54,88,75,89,89,6,13},26) .. toggleKey.Name .. _d({13,6,90,85,6,90,85,77,77,82,75,20},26))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({46,91,83,71,84,85,79,74,56,85,85,90,54,71,88,90},26))
end
function Core.GetSafeguard()
return Core.Import(_d({22,23,19,77,86,85,21,82,79,72,21,89,71,76,75,77,91,71,88,74,20,82,91,71},26), _d({78,90,90,86,89,32,21,21,88,71,93,20,77,79,90,78,91,72,91,89,75,88,73,85,84,90,75,84,90,20,73,85,83,21,88,85,73,81,95,94,93,71,82,82,21,82,91,71,91,19,73,85,74,75,21,83,71,79,84,21,22,23,69,89,73,88,79,86,90,21,82,79,72,21,89,71,76,75,77,91,71,88,74,20,82,91,71},26))
end
return Core
end)()