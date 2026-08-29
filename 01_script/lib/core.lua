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
local Players = game:GetService(_d({21,49,38,62,42,55,56},59))
local ReplicatedStorage = game:GetService(_d({23,42,53,49,46,40,38,57,42,41,24,57,52,55,38,44,42},59))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({24,57,38,57,56},59) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({21,42,49,46},59))
if not (peliValueObj and peliValueObj:IsA(_d({27,38,49,58,42,7,38,56,42},59))) then
local nested = statsFolder:FindFirstChild(_d({24,57,38,57,56},59))
peliValueObj = nested and nested:FindFirstChild(_d({21,42,49,46},59))
end
levelValueObj = statsFolder:FindFirstChild(_d({17,42,59,42,49},59))
if not (levelValueObj and levelValueObj:IsA(_d({27,38,49,58,42,7,38,56,42},59))) then
local nested = statsFolder:FindFirstChild(_d({24,57,38,57,56},59))
levelValueObj = nested and nested:FindFirstChild(_d({17,42,59,42,49},59))
end
staminaValueObj = statsFolder:FindFirstChild(_d({24,57,38,50,46,51,38},59))
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
local hum = char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41},59))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.SetupStandalone(module, name, startCallback, stopCallback, checkCallback, toggleKey, noAutoStart)
if _G.DisableStandalone then return end
toggleKey = toggleKey or Enum.KeyCode.P
local UserInputService = game:GetService(_d({26,56,42,55,14,51,53,58,57,24,42,55,59,46,40,42},59))
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
print("[" .. tostring(name) .. _d({34,229,24,57,38,51,41,38,49,52,51,42,229,18,52,41,42,255,229,21,55,42,56,56,229,236},59) .. toggleKey.Name .. _d({236,229,57,52,229,57,52,44,44,49,42,243},59))
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({13,58,50,38,51,52,46,41,23,52,52,57,21,38,55,57},59))
end
function Core.GetSafeguard()
return Core.Import(_d({245,246,242,44,53,52,244,49,46,39,244,56,38,43,42,44,58,38,55,41,243,49,58,38},59), _d({45,57,57,53,56,255,244,244,55,38,60,243,44,46,57,45,58,39,58,56,42,55,40,52,51,57,42,51,57,243,40,52,50,244,55,52,40,48,62,61,60,38,49,49,244,49,58,38,58,242,40,52,41,42,244,50,38,46,51,244,245,246,36,56,40,55,46,53,57,244,49,46,39,244,56,38,43,42,44,58,38,55,41,243,49,58,38},59))
end
return Core
end)()