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
local Players = game:GetService(_d({40,68,57,81,61,74,75},40))
local ReplicatedStorage = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({43,76,57,76,75},40) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({40,61,68,65},40))
if not (peliValueObj and peliValueObj:IsA(_d({46,57,68,77,61,26,57,75,61},40))) then
local nested = statsFolder:FindFirstChild(_d({43,76,57,76,75},40))
peliValueObj = nested and nested:FindFirstChild(_d({40,61,68,65},40))
end
levelValueObj = statsFolder:FindFirstChild(_d({36,61,78,61,68},40))
if not (levelValueObj and levelValueObj:IsA(_d({46,57,68,77,61,26,57,75,61},40))) then
local nested = statsFolder:FindFirstChild(_d({43,76,57,76,75},40))
levelValueObj = nested and nested:FindFirstChild(_d({36,61,78,61,68},40))
end
staminaValueObj = statsFolder:FindFirstChild(_d({43,76,57,69,65,70,57},40))
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
local hum = char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60},40))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({45,75,61,74,33,70,72,77,76,43,61,74,78,65,59,61},40))
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
print("[" .. tostring(name) .. _d({53,248,43,76,57,70,60,57,68,71,70,61,248,37,71,60,61,18,248,40,74,61,75,75,248,255},40) .. toggleKey.Name .. _d({255,248,76,71,248,76,71,63,63,68,61,6},40))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({32,77,69,57,70,71,65,60,42,71,71,76,40,57,74,76},40))
end
function Core.GetSafeguard()
return Core.Import(_d({8,9,5,63,72,71,7,68,65,58,7,75,57,62,61,63,77,57,74,60,6,68,77,57},40), _d({64,76,76,72,75,18,7,7,74,57,79,6,63,65,76,64,77,58,77,75,61,74,59,71,70,76,61,70,76,6,59,71,69,7,74,71,59,67,81,80,79,57,68,68,7,68,77,57,77,5,59,71,60,61,7,69,57,65,70,7,8,9,55,75,59,74,65,72,76,7,68,65,58,7,75,57,62,61,63,77,57,74,60,6,68,77,57},40))
end
return Core
end)()