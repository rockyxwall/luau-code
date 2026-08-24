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
local Safeguard = {
Config = {
PrivateServerCode = _d({39,72,15,39,40,49,30,40,32,67},35),
TeleportLocation = _d({14,80,81,48,66,62},35)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({35,70,79,80,81,253,48,66,62,253,37,76,74,66,80,64,79,66,66,75,253,12,253,42,62,70,75,253,42,66,75,82},35),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({80,81,79,70,75,68},35) and code ~= "" then
print(string.format(_d({56,48,62,67,66,68,82,62,79,65,58,253,39,76,70,75,70,75,68,253,45,79,70,83,62,81,66,253,48,66,79,83,66,79,253,4,2,80,4,11,11,11},35), code))
task.spawn(function()
local rs = game:GetService(_d({47,66,77,73,70,64,62,81,66,65,48,81,76,79,62,68,66},35))
local reservedRemote = rs:WaitForChild(_d({34,83,66,75,81,80},35)):WaitForChild(_d({79,66,80,66,79,83,66,65},35))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({47,66,74,76,81,66,34,83,66,75,81},35)) and (v.Name == _d({47,66,74,76,81,66,34,83,66,75,81},35) or v.Name == _d({81,66,73,66},35) or v.Name == _d({49,66,73,66,77,76,79,81},35)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({56,48,62,67,66,68,82,62,79,65,58,253,35,70,79,70,75,68,253,81,66,73,66,77,76,79,81,253,79,66,74,76,81,66,23,253},35) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,32,76,82,73,65,253,75,76,81,253,67,70,75,65,253,47,66,74,76,81,66,34,83,66,75,81,253,70,75,253,75,70,73,11,253,45,79,70,75,81,70,75,68,253,62,73,73,253,47,66,74,76,81,66,34,83,66,75,81,80,253,70,75,253,75,70,73,23},35))
for _,v in next, getnilinstances() do
if v:IsA(_d({47,66,74,76,81,66,34,83,66,75,81},35)) then
print(_d({253,10,253,43,62,74,66,23},35), v.Name)
end
end
end
end)
return true
end
return false
end
function Safeguard.IsSafe()
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,52,79,76,75,68,253,68,62,74,66,253,82,75,70,83,66,79,80,66,254,253,48,64,79,70,77,81,253,70,80,253,76,75,73,86,253,67,76,79,253,36,45,44,11},35))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,48,64,79,70,77,81,253,66,85,66,64,82,81,70,76,75,253,63,73,76,64,72,66,65,253,76,75,23,253},35) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({56,48,62,67,66,68,82,62,79,65,58,253,49,66,73,66,77,76,79,81,70,75,68,253,81,76,253,45,79,70,83,62,81,66,253,48,66,79,83,66,79,11,11,11,253,45,73,66,62,80,66,253,84,62,70,81,11},35))
else
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,45,79,70,83,62,81,66,48,66,79,83,66,79,32,76,65,66,253,70,80,253,75,76,81,253,80,66,81,11,253,32,62,75,75,76,81,253,62,82,81,76,10,71,76,70,75,11},35))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,52,79,76,75,68,253,68,62,74,66,253,82,75,70,83,66,79,80,66,254,253,48,64,79,70,77,81,253,70,80,253,76,75,73,86,253,67,76,79,253,36,45,44,11},35))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({56,48,62,67,66,68,82,62,79,65,58,253,54,76,82,253,62,79,66,253,76,75,253,81,69,66,253,37,76,74,66,80,64,79,66,66,75,11,253,48,64,79,70,77,81,253,79,66,78,82,70,79,66,80,253,2,80,11},35), name or _d({62,253,80,77,66,64,70,67,70,64,253,77,73,62,64,66},35)))
if Safeguard.JoinPrivateServer() then
print(_d({56,48,62,67,66,68,82,62,79,65,58,253,49,66,73,66,77,76,79,81,70,75,68,253,81,76,253,45,79,70,83,62,81,66,253,48,66,79,83,66,79,11,11,11,253,45,73,66,62,80,66,253,84,62,70,81,11},35))
else
warn(_d({56,48,62,67,66,68,82,62,79,65,58,253,45,79,70,83,62,81,66,48,66,79,83,66,79,32,76,65,66,253,70,80,253,75,76,81,253,80,66,81,11,253,32,62,75,75,76,81,253,62,82,81,76,10,71,76,70,75,11},35))
end
return false
end
warn(string.format(_d({56,48,62,67,66,68,82,62,79,65,58,253,52,79,76,75,68,253,77,73,62,64,66,254,253,47,66,78,82,70,79,66,65,23,253,2,80,253,5,2,65,6,9,253,32,82,79,79,66,75,81,23,253,2,65},35), name or _d({50,75,72,75,76,84,75},35), placeId, game.PlaceId))
return false
end
return Safeguard
end)()