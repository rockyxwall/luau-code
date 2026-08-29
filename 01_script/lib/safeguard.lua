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
PrivateServerCode = _d({35,68,11,35,36,45,26,36,28,63},39),
TeleportLocation = _d({10,76,77,44,62,58},39),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({31,66,75,76,77,249,44,62,58,249,33,72,70,62,76,60,75,62,62,71,249,8,249,38,58,66,71,249,38,62,71,78},39),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({76,77,75,66,71,64},39) and code ~= "" then
print(string.format(_d({52,44,58,63,62,64,78,58,75,61,54,249,35,72,66,71,66,71,64,249,41,75,66,79,58,77,62,249,44,62,75,79,62,75,249,0,254,76,0,7,7,7},39), code))
task.spawn(function()
local rs = game:GetService(_d({43,62,73,69,66,60,58,77,62,61,44,77,72,75,58,64,62},39))
local reservedRemote = rs:WaitForChild(_d({30,79,62,71,77,76},39)):WaitForChild(_d({75,62,76,62,75,79,62,61},39))
task.spawn(function()
pcall(function()
reservedRemote:InvokeServer(code)
end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _, v in next, getnilinstances() do
if
v:IsA(_d({43,62,70,72,77,62,30,79,62,71,77},39)) and (v.Name == _d({43,62,70,72,77,62,30,79,62,71,77},39) or v.Name == _d({77,62,69,62},39) or v.Name == _d({45,62,69,62,73,72,75,77},39))
then
teleRemote = v
break
end
end
if teleRemote then
break
end
end
if teleRemote then
print(_d({52,44,58,63,62,64,78,58,75,61,54,249,31,66,75,66,71,64,249,77,62,69,62,73,72,75,77,249,75,62,70,72,77,62,19,249},39) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,28,72,78,69,61,249,71,72,77,249,63,66,71,61,249,43,62,70,72,77,62,30,79,62,71,77,249,66,71,249,71,66,69,7,249,41,75,66,71,77,66,71,64,249,58,69,69,249,43,62,70,72,77,62,30,79,62,71,77,76,249,66,71,249,71,66,69,19},39))
for _, v in next, getnilinstances() do
if v:IsA(_d({43,62,70,72,77,62,30,79,62,71,77},39)) then
print(_d({249,6,249,39,58,70,62,19},39), v.Name)
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
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,48,75,72,71,64,249,64,58,70,62,249,78,71,66,79,62,75,76,62,250,249,44,60,75,66,73,77,249,66,76,249,72,71,69,82,249,63,72,75,249,32,41,40,7},39))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,44,60,75,66,73,77,249,62,81,62,60,78,77,66,72,71,249,59,69,72,60,68,62,61,249,72,71,19,249},39) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({52,44,58,63,62,64,78,58,75,61,54,249,45,62,69,62,73,72,75,77,66,71,64,249,77,72,249,41,75,66,79,58,77,62,249,44,62,75,79,62,75,7,7,7,249,41,69,62,58,76,62,249,80,58,66,77,7},39))
else
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,41,75,66,79,58,77,62,44,62,75,79,62,75,28,72,61,62,249,66,76,249,71,72,77,249,76,62,77,7,249,28,58,71,71,72,77,249,58,78,77,72,6,67,72,66,71,7},39))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,48,75,72,71,64,249,64,58,70,62,249,78,71,66,79,62,75,76,62,250,249,44,60,75,66,73,77,249,66,76,249,72,71,69,82,249,63,72,75,249,32,41,40,7},39))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({52,44,58,63,62,64,78,58,75,61,54,249,50,72,78,249,58,75,62,249,72,71,249,77,65,62,249,33,72,70,62,76,60,75,62,62,71,7,249,44,60,75,66,73,77,249,75,62,74,78,66,75,62,76,249,254,76,7},39), name or _d({58,249,76,73,62,60,66,63,66,60,249,73,69,58,60,62},39)))
if Safeguard.JoinPrivateServer() then
print(_d({52,44,58,63,62,64,78,58,75,61,54,249,45,62,69,62,73,72,75,77,66,71,64,249,77,72,249,41,75,66,79,58,77,62,249,44,62,75,79,62,75,7,7,7,249,41,69,62,58,76,62,249,80,58,66,77,7},39))
else
warn(_d({52,44,58,63,62,64,78,58,75,61,54,249,41,75,66,79,58,77,62,44,62,75,79,62,75,28,72,61,62,249,66,76,249,71,72,77,249,76,62,77,7,249,28,58,71,71,72,77,249,58,78,77,72,6,67,72,66,71,7},39))
end
return false
end
warn(
string.format(
_d({52,44,58,63,62,64,78,58,75,61,54,249,48,75,72,71,64,249,73,69,58,60,62,250,249,43,62,74,78,66,75,62,61,19,249,254,76,249,1,254,61,2,5,249,28,78,75,75,62,71,77,19,249,254,61},39),
name or _d({46,71,68,71,72,80,71},39),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()