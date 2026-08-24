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
local Players = game:GetService(_d({62,90,79,103,83,96,97},18))
local ReplicatedStorage = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({65,98,79,98,97},18) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({62,83,90,87},18))
if not (peliValueObj and peliValueObj:IsA(_d({68,79,90,99,83,48,79,97,83},18))) then
local nested = statsFolder:FindFirstChild(_d({65,98,79,98,97},18))
peliValueObj = nested and nested:FindFirstChild(_d({62,83,90,87},18))
end
levelValueObj = statsFolder:FindFirstChild(_d({58,83,100,83,90},18))
if not (levelValueObj and levelValueObj:IsA(_d({68,79,90,99,83,48,79,97,83},18))) then
local nested = statsFolder:FindFirstChild(_d({65,98,79,98,97},18))
levelValueObj = nested and nested:FindFirstChild(_d({58,83,100,83,90},18))
end
staminaValueObj = statsFolder:FindFirstChild(_d({65,98,79,91,87,92,79},18))
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
local hum = char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82},18))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({67,97,83,96,55,92,94,99,98,65,83,96,100,87,81,83},18))
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
print("[" .. tostring(name) .. _d({75,14,65,98,79,92,82,79,90,93,92,83,14,59,93,82,83,40,14,62,96,83,97,97,14,21},18) .. toggleKey.Name .. _d({21,14,98,93,14,98,93,85,85,90,83,28},18))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({54,99,91,79,92,93,87,82,64,93,93,98,62,79,96,98},18))
end
function Core.GetSafeguard()
return Core.Import(_d({30,31,27,85,94,93,29,90,87,80,29,97,79,84,83,85,99,79,96,82,28,90,99,79},18), _d({86,98,98,94,97,40,29,29,96,79,101,28,85,87,98,86,99,80,99,97,83,96,81,93,92,98,83,92,98,28,81,93,91,29,96,93,81,89,103,102,101,79,90,90,29,90,99,79,99,27,81,93,82,83,29,91,79,87,92,29,30,31,77,97,81,96,87,94,98,29,90,87,80,29,97,79,84,83,85,99,79,96,82,28,90,99,79},18))
end
return Core
end)()