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
PrivateServerCode = _d({38,71,14,38,39,48,29,39,31,66},36),
TeleportLocation = _d({13,79,80,47,65,61},36)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({34,69,78,79,80,252,47,65,61,252,36,75,73,65,79,63,78,65,65,74,252,11,252,41,61,69,74,252,41,65,74,81},36),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({79,80,78,69,74,67},36) and code ~= "" then
print(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,38,75,69,74,69,74,67,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,252,3,1,79,3,10,10,10},36), code))
task.spawn(function()
local rs = game:GetService(_d({46,65,76,72,69,63,61,80,65,64,47,80,75,78,61,67,65},36))
local reservedRemote = rs:WaitForChild(_d({33,82,65,74,80,79},36)):WaitForChild(_d({78,65,79,65,78,82,65,64},36))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) and (v.Name == _d({46,65,73,75,80,65,33,82,65,74,80},36) or v.Name == _d({80,65,72,65},36) or v.Name == _d({48,65,72,65,76,75,78,80},36)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,34,69,78,69,74,67,252,80,65,72,65,76,75,78,80,252,78,65,73,75,80,65,22,252},36) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,31,75,81,72,64,252,74,75,80,252,66,69,74,64,252,46,65,73,75,80,65,33,82,65,74,80,252,69,74,252,74,69,72,10,252,44,78,69,74,80,69,74,67,252,61,72,72,252,46,65,73,75,80,65,33,82,65,74,80,79,252,69,74,252,74,69,72,22},36))
for _,v in next, getnilinstances() do
if v:IsA(_d({46,65,73,75,80,65,33,82,65,74,80},36)) then
print(_d({252,9,252,42,61,73,65,22},36), v.Name)
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
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,47,63,78,69,76,80,252,65,84,65,63,81,80,69,75,74,252,62,72,75,63,71,65,64,252,75,74,22,252},36) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,67,61,73,65,252,81,74,69,82,65,78,79,65,253,252,47,63,78,69,76,80,252,69,79,252,75,74,72,85,252,66,75,78,252,35,44,43,10},36))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,53,75,81,252,61,78,65,252,75,74,252,80,68,65,252,36,75,73,65,79,63,78,65,65,74,10,252,47,63,78,69,76,80,252,78,65,77,81,69,78,65,79,252,1,79,10},36), name or _d({61,252,79,76,65,63,69,66,69,63,252,76,72,61,63,65},36)))
if Safeguard.JoinPrivateServer() then
print(_d({55,47,61,66,65,67,81,61,78,64,57,252,48,65,72,65,76,75,78,80,69,74,67,252,80,75,252,44,78,69,82,61,80,65,252,47,65,78,82,65,78,10,10,10,252,44,72,65,61,79,65,252,83,61,69,80,10},36))
else
warn(_d({55,47,61,66,65,67,81,61,78,64,57,252,44,78,69,82,61,80,65,47,65,78,82,65,78,31,75,64,65,252,69,79,252,74,75,80,252,79,65,80,10,252,31,61,74,74,75,80,252,61,81,80,75,9,70,75,69,74,10},36))
end
return false
end
warn(string.format(_d({55,47,61,66,65,67,81,61,78,64,57,252,51,78,75,74,67,252,76,72,61,63,65,253,252,46,65,77,81,69,78,65,64,22,252,1,79,252,4,1,64,5,8,252,31,81,78,78,65,74,80,22,252,1,64},36), name or _d({49,74,71,74,75,83,74},36), placeId, game.PlaceId))
return false
end
return Safeguard
end)()