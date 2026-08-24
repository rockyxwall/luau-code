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
local Players = game:GetService(_d({23,51,40,64,44,57,58},57))
local ReplicatedStorage = game:GetService(_d({25,44,55,51,48,42,40,59,44,43,26,59,54,57,40,46,44},57))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({26,59,40,59,58},57) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({23,44,51,48},57))
if not (peliValueObj and peliValueObj:IsA(_d({29,40,51,60,44,9,40,58,44},57))) then
local nested = statsFolder:FindFirstChild(_d({26,59,40,59,58},57))
peliValueObj = nested and nested:FindFirstChild(_d({23,44,51,48},57))
end
levelValueObj = statsFolder:FindFirstChild(_d({19,44,61,44,51},57))
if not (levelValueObj and levelValueObj:IsA(_d({29,40,51,60,44,9,40,58,44},57))) then
local nested = statsFolder:FindFirstChild(_d({26,59,40,59,58},57))
levelValueObj = nested and nested:FindFirstChild(_d({19,44,61,44,51},57))
end
staminaValueObj = statsFolder:FindFirstChild(_d({26,59,40,52,48,53,40},57))
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
local hum = char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43},57))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({15,60,52,40,53,54,48,43,25,54,54,59,23,40,57,59},57))
end
function Core.GetSafeguard()
return Core.Import(_d({247,248,244,46,55,54,246,51,48,41,246,58,40,45,44,46,60,40,57,43,245,51,60,40},57), _d({47,59,59,55,58,1,246,246,57,40,62,245,46,48,59,47,60,41,60,58,44,57,42,54,53,59,44,53,59,245,42,54,52,246,57,54,42,50,64,63,62,40,51,51,246,51,60,40,60,244,42,54,43,44,246,52,40,48,53,246,247,248,38,58,42,57,48,55,59,246,51,48,41,246,58,40,45,44,46,60,40,57,43,245,51,60,40},57))
end
return Core
end)()