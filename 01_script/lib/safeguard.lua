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
PrivateServerCode = _d({49,82,25,49,50,59,40,50,42,77},25),
TeleportLocation = _d({24,90,91,58,76,72},25)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({45,80,89,90,91,7,58,76,72,7,47,86,84,76,90,74,89,76,76,85,7,22,7,52,72,80,85,7,52,76,85,92},25),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({90,91,89,80,85,78},25) and code ~= "" then
print(string.format(_d({66,58,72,77,76,78,92,72,89,75,68,7,49,86,80,85,80,85,78,7,55,89,80,93,72,91,76,7,58,76,89,93,76,89,7,14,12,90,14,21,21,21},25), code))
task.spawn(function()
local rs = game:GetService(_d({57,76,87,83,80,74,72,91,76,75,58,91,86,89,72,78,76},25))
local reservedRemote = rs:WaitForChild(_d({44,93,76,85,91,90},25)):WaitForChild(_d({89,76,90,76,89,93,76,75},25))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({57,76,84,86,91,76,44,93,76,85,91},25)) and (v.Name == _d({57,76,84,86,91,76,44,93,76,85,91},25) or v.Name == _d({91,76,83,76},25) or v.Name == _d({59,76,83,76,87,86,89,91},25)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({66,58,72,77,76,78,92,72,89,75,68,7,45,80,89,80,85,78,7,91,76,83,76,87,86,89,91,7,89,76,84,86,91,76,33,7},25) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,42,86,92,83,75,7,85,86,91,7,77,80,85,75,7,57,76,84,86,91,76,44,93,76,85,91,7,80,85,7,85,80,83,21,7,55,89,80,85,91,80,85,78,7,72,83,83,7,57,76,84,86,91,76,44,93,76,85,91,90,7,80,85,7,85,80,83,33},25))
for _,v in next, getnilinstances() do
if v:IsA(_d({57,76,84,86,91,76,44,93,76,85,91},25)) then
print(_d({7,20,7,53,72,84,76,33},25), v.Name)
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
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,62,89,86,85,78,7,78,72,84,76,7,92,85,80,93,76,89,90,76,8,7,58,74,89,80,87,91,7,80,90,7,86,85,83,96,7,77,86,89,7,46,55,54,21},25))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,58,74,89,80,87,91,7,76,95,76,74,92,91,80,86,85,7,73,83,86,74,82,76,75,7,86,85,33,7},25) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({66,58,72,77,76,78,92,72,89,75,68,7,59,76,83,76,87,86,89,91,80,85,78,7,91,86,7,55,89,80,93,72,91,76,7,58,76,89,93,76,89,21,21,21,7,55,83,76,72,90,76,7,94,72,80,91,21},25))
else
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,55,89,80,93,72,91,76,58,76,89,93,76,89,42,86,75,76,7,80,90,7,85,86,91,7,90,76,91,21,7,42,72,85,85,86,91,7,72,92,91,86,20,81,86,80,85,21},25))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,62,89,86,85,78,7,78,72,84,76,7,92,85,80,93,76,89,90,76,8,7,58,74,89,80,87,91,7,80,90,7,86,85,83,96,7,77,86,89,7,46,55,54,21},25))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({66,58,72,77,76,78,92,72,89,75,68,7,64,86,92,7,72,89,76,7,86,85,7,91,79,76,7,47,86,84,76,90,74,89,76,76,85,21,7,58,74,89,80,87,91,7,89,76,88,92,80,89,76,90,7,12,90,21},25), name or _d({72,7,90,87,76,74,80,77,80,74,7,87,83,72,74,76},25)))
if Safeguard.JoinPrivateServer() then
print(_d({66,58,72,77,76,78,92,72,89,75,68,7,59,76,83,76,87,86,89,91,80,85,78,7,91,86,7,55,89,80,93,72,91,76,7,58,76,89,93,76,89,21,21,21,7,55,83,76,72,90,76,7,94,72,80,91,21},25))
else
warn(_d({66,58,72,77,76,78,92,72,89,75,68,7,55,89,80,93,72,91,76,58,76,89,93,76,89,42,86,75,76,7,80,90,7,85,86,91,7,90,76,91,21,7,42,72,85,85,86,91,7,72,92,91,86,20,81,86,80,85,21},25))
end
return false
end
warn(string.format(_d({66,58,72,77,76,78,92,72,89,75,68,7,62,89,86,85,78,7,87,83,72,74,76,8,7,57,76,88,92,80,89,76,75,33,7,12,90,7,15,12,75,16,19,7,42,92,89,89,76,85,91,33,7,12,75},25), name or _d({60,85,82,85,86,94,85},25), placeId, game.PlaceId))
return false
end
return Safeguard
end)()