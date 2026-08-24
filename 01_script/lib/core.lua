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
local Players = game:GetService(_d({47,75,64,88,68,81,82},33))
local ReplicatedStorage = game:GetService(_d({49,68,79,75,72,66,64,83,68,67,50,83,78,81,64,70,68},33))
local LocalPlayer = Players.LocalPlayer
local statsFolder = nil
local peliValueObj = nil
local levelValueObj = nil
local staminaValueObj = nil
local function getStats()
if statsFolder and statsFolder.Parent then
return statsFolder
end
statsFolder = ReplicatedStorage:FindFirstChild(_d({50,83,64,83,82},33) .. LocalPlayer.Name)
if statsFolder then
peliValueObj = statsFolder:FindFirstChild(_d({47,68,75,72},33))
if not (peliValueObj and peliValueObj:IsA(_d({53,64,75,84,68,33,64,82,68},33))) then
local nested = statsFolder:FindFirstChild(_d({50,83,64,83,82},33))
peliValueObj = nested and nested:FindFirstChild(_d({47,68,75,72},33))
end
levelValueObj = statsFolder:FindFirstChild(_d({43,68,85,68,75},33))
if not (levelValueObj and levelValueObj:IsA(_d({53,64,75,84,68,33,64,82,68},33))) then
local nested = statsFolder:FindFirstChild(_d({50,83,64,83,82},33))
levelValueObj = nested and nested:FindFirstChild(_d({43,68,85,68,75},33))
end
staminaValueObj = statsFolder:FindFirstChild(_d({50,83,64,76,72,77,64},33))
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
local hum = char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67},33))
if hum then
return hum.Health, hum.MaxHealth
end
return 0, 0
end
function Core.GetRoot(player)
local char = player and player.Character
return char and char:FindFirstChild(_d({39,84,76,64,77,78,72,67,49,78,78,83,47,64,81,83},33))
end
function Core.GetSafeguard()
return Core.Import(_d({15,16,12,70,79,78,14,75,72,65,14,82,64,69,68,70,84,64,81,67,13,75,84,64},33), _d({71,83,83,79,82,25,14,14,81,64,86,13,70,72,83,71,84,65,84,82,68,81,66,78,77,83,68,77,83,13,66,78,76,14,81,78,66,74,88,87,86,64,75,75,14,75,84,64,84,12,66,78,67,68,14,76,64,72,77,14,15,16,62,82,66,81,72,79,83,14,75,72,65,14,82,64,69,68,70,84,64,81,67,13,75,84,64},33))
end
return Core
end)()