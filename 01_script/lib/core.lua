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
local Players = game:GetService(_d({43,71,60,84,64,77,78},37))
local ReplicatedStorage = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({46,79,60,79,78},37) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({43,64,71,68},37))
if not (peliValueObj and peliValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
peliValueObj = nested and nested:FindFirstChild(_d({43,64,71,68},37))
end
levelValueObj = statsFolder:FindFirstChild(_d({39,64,81,64,71},37))
if not (levelValueObj and levelValueObj:IsA(_d({49,60,71,80,64,29,60,78,64},37))) then
local nested = statsFolder:FindFirstChild(_d({46,79,60,79,78},37))
levelValueObj = nested and nested:FindFirstChild(_d({39,64,81,64,71},37))
end
staminaValueObj = statsFolder:FindFirstChild(_d({46,79,60,72,68,73,60},37))
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
local hum = char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63},37))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({35,80,72,60,73,74,68,63,45,74,74,79,43,60,77,79},37))
end
function Core.GetSafeguard()
return Core.Import(_d({11,12,8,66,75,74,10,71,68,61,10,78,60,65,64,66,80,60,77,63,9,71,80,60},37), _d({67,79,79,75,78,21,10,10,77,60,82,9,66,68,79,67,80,61,80,78,64,77,62,74,73,79,64,73,79,9,62,74,72,10,77,74,62,70,84,83,82,60,71,71,10,71,80,60,80,8,62,74,63,64,10,72,60,68,73,10,11,12,58,78,62,77,68,75,79,10,71,68,61,10,78,60,65,64,66,80,60,77,63,9,71,80,60},37))
end
return Core
end)()