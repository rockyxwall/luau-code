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
local Players = game:GetService(_d({61,89,78,102,82,95,96},19))
local ReplicatedStorage = game:GetService(_d({63,82,93,89,86,80,78,97,82,81,64,97,92,95,78,84,82},19))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({64,97,78,97,96},19) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({61,82,89,86},19))
if not (peliValueObj and peliValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
peliValueObj = nested and nested:FindFirstChild(_d({61,82,89,86},19))
end
levelValueObj = statsFolder:FindFirstChild(_d({57,82,99,82,89},19))
if not (levelValueObj and levelValueObj:IsA(_d({67,78,89,98,82,47,78,96,82},19))) then
local nested = statsFolder:FindFirstChild(_d({64,97,78,97,96},19))
levelValueObj = nested and nested:FindFirstChild(_d({57,82,99,82,89},19))
end
staminaValueObj = statsFolder:FindFirstChild(_d({64,97,78,90,86,91,78},19))
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
local hum = char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81},19))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({66,96,82,95,54,91,93,98,97,64,82,95,99,86,80,82},19))
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
print("[" .. tostring(name) .. _d({74,13,64,97,78,91,81,78,89,92,91,82,13,58,92,81,82,39,13,61,95,82,96,96,13,20},19) .. toggleKey.Name .. _d({20,13,97,92,13,97,92,84,84,89,82,27},19))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({53,98,90,78,91,92,86,81,63,92,92,97,61,78,95,97},19))
end
function Core.GetSafeguard()
return Core.Import(_d({29,30,26,84,93,92,28,89,86,79,28,96,78,83,82,84,98,78,95,81,27,89,98,78},19), _d({85,97,97,93,96,39,28,28,95,78,100,27,84,86,97,85,98,79,98,96,82,95,80,92,91,97,82,91,97,27,80,92,90,28,95,92,80,88,102,101,100,78,89,89,28,89,98,78,98,26,80,92,81,82,28,90,78,86,91,28,29,30,76,96,80,95,86,93,97,28,89,86,79,28,96,78,83,82,84,98,78,95,81,27,89,98,78},19))
end
return Core
end)()