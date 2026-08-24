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
PrivateServerCode = _d({34,67,10,34,35,44,25,35,27,62},40),
TeleportLocation = _d({9,75,76,43,61,57},40)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({30,65,74,75,76,248,43,61,57,248,32,71,69,61,75,59,74,61,61,70,248,7,248,37,57,65,70,248,37,61,70,77},40),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({75,76,74,65,70,63},40) and code ~= "" then
print(string.format(_d({51,43,57,62,61,63,77,57,74,60,53,248,34,71,65,70,65,70,63,248,40,74,65,78,57,76,61,248,43,61,74,78,61,74,248,255,253,75,255,6,6,6},40), code))
task.spawn(function()
local rs = game:GetService(_d({42,61,72,68,65,59,57,76,61,60,43,76,71,74,57,63,61},40))
local reservedRemote = rs:WaitForChild(_d({29,78,61,70,76,75},40)):WaitForChild(_d({74,61,75,61,74,78,61,60},40))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({42,61,69,71,76,61,29,78,61,70,76},40)) and (v.Name == _d({42,61,69,71,76,61,29,78,61,70,76},40) or v.Name == _d({76,61,68,61},40) or v.Name == _d({44,61,68,61,72,71,74,76},40)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({51,43,57,62,61,63,77,57,74,60,53,248,30,65,74,65,70,63,248,76,61,68,61,72,71,74,76,248,74,61,69,71,76,61,18,248},40) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,27,71,77,68,60,248,70,71,76,248,62,65,70,60,248,42,61,69,71,76,61,29,78,61,70,76,248,65,70,248,70,65,68,6,248,40,74,65,70,76,65,70,63,248,57,68,68,248,42,61,69,71,76,61,29,78,61,70,76,75,248,65,70,248,70,65,68,18},40))
for _,v in next, getnilinstances() do
if v:IsA(_d({42,61,69,71,76,61,29,78,61,70,76},40)) then
print(_d({248,5,248,38,57,69,61,18},40), v.Name)
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
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,47,74,71,70,63,248,63,57,69,61,248,77,70,65,78,61,74,75,61,249,248,43,59,74,65,72,76,248,65,75,248,71,70,68,81,248,62,71,74,248,31,40,39,6},40))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,43,59,74,65,72,76,248,61,80,61,59,77,76,65,71,70,248,58,68,71,59,67,61,60,248,71,70,18,248},40) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({51,43,57,62,61,63,77,57,74,60,53,248,44,61,68,61,72,71,74,76,65,70,63,248,76,71,248,40,74,65,78,57,76,61,248,43,61,74,78,61,74,6,6,6,248,40,68,61,57,75,61,248,79,57,65,76,6},40))
else
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,40,74,65,78,57,76,61,43,61,74,78,61,74,27,71,60,61,248,65,75,248,70,71,76,248,75,61,76,6,248,27,57,70,70,71,76,248,57,77,76,71,5,66,71,65,70,6},40))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,47,74,71,70,63,248,63,57,69,61,248,77,70,65,78,61,74,75,61,249,248,43,59,74,65,72,76,248,65,75,248,71,70,68,81,248,62,71,74,248,31,40,39,6},40))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({51,43,57,62,61,63,77,57,74,60,53,248,49,71,77,248,57,74,61,248,71,70,248,76,64,61,248,32,71,69,61,75,59,74,61,61,70,6,248,43,59,74,65,72,76,248,74,61,73,77,65,74,61,75,248,253,75,6},40), name or _d({57,248,75,72,61,59,65,62,65,59,248,72,68,57,59,61},40)))
if Safeguard.JoinPrivateServer() then
print(_d({51,43,57,62,61,63,77,57,74,60,53,248,44,61,68,61,72,71,74,76,65,70,63,248,76,71,248,40,74,65,78,57,76,61,248,43,61,74,78,61,74,6,6,6,248,40,68,61,57,75,61,248,79,57,65,76,6},40))
else
warn(_d({51,43,57,62,61,63,77,57,74,60,53,248,40,74,65,78,57,76,61,43,61,74,78,61,74,27,71,60,61,248,65,75,248,70,71,76,248,75,61,76,6,248,27,57,70,70,71,76,248,57,77,76,71,5,66,71,65,70,6},40))
end
return false
end
warn(string.format(_d({51,43,57,62,61,63,77,57,74,60,53,248,47,74,71,70,63,248,72,68,57,59,61,249,248,42,61,73,77,65,74,61,60,18,248,253,75,248,0,253,60,1,4,248,27,77,74,74,61,70,76,18,248,253,60},40), name or _d({45,70,67,70,71,79,70},40), placeId, game.PlaceId))
return false
end
return Safeguard
end)()