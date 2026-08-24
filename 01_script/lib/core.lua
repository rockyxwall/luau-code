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
local Players = game:GetService(_d({31,59,48,72,52,65,66},49))
local ReplicatedStorage = game:GetService(_d({33,52,63,59,56,50,48,67,52,51,34,67,62,65,48,54,52},49))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({34,67,48,67,66},49) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({31,52,59,56},49))
if not (peliValueObj and peliValueObj:IsA(_d({37,48,59,68,52,17,48,66,52},49))) then
local nested = statsFolder:FindFirstChild(_d({34,67,48,67,66},49))
peliValueObj = nested and nested:FindFirstChild(_d({31,52,59,56},49))
end
levelValueObj = statsFolder:FindFirstChild(_d({27,52,69,52,59},49))
if not (levelValueObj and levelValueObj:IsA(_d({37,48,59,68,52,17,48,66,52},49))) then
local nested = statsFolder:FindFirstChild(_d({34,67,48,67,66},49))
levelValueObj = nested and nested:FindFirstChild(_d({27,52,69,52,59},49))
end
staminaValueObj = statsFolder:FindFirstChild(_d({34,67,48,60,56,61,48},49))
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
local hum = char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51},49))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({36,66,52,65,24,61,63,68,67,34,52,65,69,56,50,52},49))
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
print("[" .. tostring(name) .. _d({44,239,34,67,48,61,51,48,59,62,61,52,239,28,62,51,52,9,239,31,65,52,66,66,239,246},49) .. toggleKey.Name .. _d({246,239,67,62,239,67,62,54,54,59,52,253},49))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({23,68,60,48,61,62,56,51,33,62,62,67,31,48,65,67},49))
end
function Core.GetSafeguard()
return Core.Import(_d({255,0,252,54,63,62,254,59,56,49,254,66,48,53,52,54,68,48,65,51,253,59,68,48},49), _d({55,67,67,63,66,9,254,254,65,48,70,253,54,56,67,55,68,49,68,66,52,65,50,62,61,67,52,61,67,253,50,62,60,254,65,62,50,58,72,71,70,48,59,59,254,59,68,48,68,252,50,62,51,52,254,60,48,56,61,254,255,0,46,66,50,65,56,63,67,254,59,56,49,254,66,48,53,52,54,68,48,65,51,253,59,68,48},49))
end
return Core
end)()