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
PrivateServerCode = _d({33,66,9,33,34,43,24,34,26,61},41),
TeleportLocation = _d({8,74,75,42,60,56},41)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({29,64,73,74,75,247,42,60,56,247,31,70,68,60,74,58,73,60,60,69,247,6,247,36,56,64,69,247,36,60,69,76},41),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({74,75,73,64,69,62},41) and code ~= "" then
print(string.format(_d({50,42,56,61,60,62,76,56,73,59,52,247,33,70,64,69,64,69,62,247,39,73,64,77,56,75,60,247,42,60,73,77,60,73,247,254,252,74,254,5,5,5},41), code))
task.spawn(function()
local rs = game:GetService(_d({41,60,71,67,64,58,56,75,60,59,42,75,70,73,56,62,60},41))
local reservedRemote = rs:WaitForChild(_d({28,77,60,69,75,74},41)):WaitForChild(_d({73,60,74,60,73,77,60,59},41))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({41,60,68,70,75,60,28,77,60,69,75},41)) and (v.Name == _d({41,60,68,70,75,60,28,77,60,69,75},41) or v.Name == _d({75,60,67,60},41) or v.Name == _d({43,60,67,60,71,70,73,75},41)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({50,42,56,61,60,62,76,56,73,59,52,247,29,64,73,64,69,62,247,75,60,67,60,71,70,73,75,247,73,60,68,70,75,60,17,247},41) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,26,70,76,67,59,247,69,70,75,247,61,64,69,59,247,41,60,68,70,75,60,28,77,60,69,75,247,64,69,247,69,64,67,5,247,39,73,64,69,75,64,69,62,247,56,67,67,247,41,60,68,70,75,60,28,77,60,69,75,74,247,64,69,247,69,64,67,17},41))
for _,v in next, getnilinstances() do
if v:IsA(_d({41,60,68,70,75,60,28,77,60,69,75},41)) then
print(_d({247,4,247,37,56,68,60,17},41), v.Name)
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
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,46,73,70,69,62,247,62,56,68,60,247,76,69,64,77,60,73,74,60,248,247,42,58,73,64,71,75,247,64,74,247,70,69,67,80,247,61,70,73,247,30,39,38,5},41))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,42,58,73,64,71,75,247,60,79,60,58,76,75,64,70,69,247,57,67,70,58,66,60,59,247,70,69,17,247},41) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({50,42,56,61,60,62,76,56,73,59,52,247,43,60,67,60,71,70,73,75,64,69,62,247,75,70,247,39,73,64,77,56,75,60,247,42,60,73,77,60,73,5,5,5,247,39,67,60,56,74,60,247,78,56,64,75,5},41))
else
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,39,73,64,77,56,75,60,42,60,73,77,60,73,26,70,59,60,247,64,74,247,69,70,75,247,74,60,75,5,247,26,56,69,69,70,75,247,56,76,75,70,4,65,70,64,69,5},41))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,46,73,70,69,62,247,62,56,68,60,247,76,69,64,77,60,73,74,60,248,247,42,58,73,64,71,75,247,64,74,247,70,69,67,80,247,61,70,73,247,30,39,38,5},41))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({50,42,56,61,60,62,76,56,73,59,52,247,48,70,76,247,56,73,60,247,70,69,247,75,63,60,247,31,70,68,60,74,58,73,60,60,69,5,247,42,58,73,64,71,75,247,73,60,72,76,64,73,60,74,247,252,74,5},41), name or _d({56,247,74,71,60,58,64,61,64,58,247,71,67,56,58,60},41)))
if Safeguard.JoinPrivateServer() then
print(_d({50,42,56,61,60,62,76,56,73,59,52,247,43,60,67,60,71,70,73,75,64,69,62,247,75,70,247,39,73,64,77,56,75,60,247,42,60,73,77,60,73,5,5,5,247,39,67,60,56,74,60,247,78,56,64,75,5},41))
else
warn(_d({50,42,56,61,60,62,76,56,73,59,52,247,39,73,64,77,56,75,60,42,60,73,77,60,73,26,70,59,60,247,64,74,247,69,70,75,247,74,60,75,5,247,26,56,69,69,70,75,247,56,76,75,70,4,65,70,64,69,5},41))
end
return false
end
warn(string.format(_d({50,42,56,61,60,62,76,56,73,59,52,247,46,73,70,69,62,247,71,67,56,58,60,248,247,41,60,72,76,64,73,60,59,17,247,252,74,247,255,252,59,0,3,247,26,76,73,73,60,69,75,17,247,252,59},41), name or _d({44,69,66,69,70,78,69},41), placeId, game.PlaceId))
return false
end
return Safeguard
end)()