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
local Players = game:GetService(_d({56,84,73,97,77,90,91},24))
local ReplicatedStorage = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({59,92,73,92,91},24) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({56,77,84,81},24))
if not (peliValueObj and peliValueObj:IsA(_d({62,73,84,93,77,42,73,91,77},24))) then
local nested = statsFolder:FindFirstChild(_d({59,92,73,92,91},24))
peliValueObj = nested and nested:FindFirstChild(_d({56,77,84,81},24))
end
levelValueObj = statsFolder:FindFirstChild(_d({52,77,94,77,84},24))
if not (levelValueObj and levelValueObj:IsA(_d({62,73,84,93,77,42,73,91,77},24))) then
local nested = statsFolder:FindFirstChild(_d({59,92,73,92,91},24))
levelValueObj = nested and nested:FindFirstChild(_d({52,77,94,77,84},24))
end
staminaValueObj = statsFolder:FindFirstChild(_d({59,92,73,85,81,86,73},24))
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
local hum = char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76},24))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({61,91,77,90,49,86,88,93,92,59,77,90,94,81,75,77},24))
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
print("[" .. tostring(name) .. _d({69,8,59,92,73,86,76,73,84,87,86,77,8,53,87,76,77,34,8,56,90,77,91,91,8,15},24) .. toggleKey.Name .. _d({15,8,92,87,8,92,87,79,79,84,77,22},24))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({48,93,85,73,86,87,81,76,58,87,87,92,56,73,90,92},24))
end
function Core.GetSafeguard()
return Core.Import(_d({24,25,21,79,88,87,23,84,81,74,23,91,73,78,77,79,93,73,90,76,22,84,93,73},24), _d({80,92,92,88,91,34,23,23,90,73,95,22,79,81,92,80,93,74,93,91,77,90,75,87,86,92,77,86,92,22,75,87,85,23,90,87,75,83,97,96,95,73,84,84,23,84,93,73,93,21,75,87,76,77,23,85,73,81,86,23,24,25,71,91,75,90,81,88,92,23,84,81,74,23,91,73,78,77,79,93,73,90,76,22,84,93,73},24))
end
return Core
end)()