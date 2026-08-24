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
PrivateServerCode = _d({43,76,19,43,44,53,34,44,36,71},31),
TeleportLocation = _d({18,84,85,52,70,66},31)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({39,74,83,84,85,1,52,70,66,1,41,80,78,70,84,68,83,70,70,79,1,16,1,46,66,74,79,1,46,70,79,86},31),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({84,85,83,74,79,72},31) and code ~= "" then
print(string.format(_d({60,52,66,71,70,72,86,66,83,69,62,1,43,80,74,79,74,79,72,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,1,8,6,84,8,15,15,15},31), code))
task.spawn(function()
local rs = game:GetService(_d({51,70,81,77,74,68,66,85,70,69,52,85,80,83,66,72,70},31))
local reservedRemote = rs:WaitForChild(_d({38,87,70,79,85,84},31)):WaitForChild(_d({83,70,84,70,83,87,70,69},31))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({51,70,78,80,85,70,38,87,70,79,85},31)) and (v.Name == _d({51,70,78,80,85,70,38,87,70,79,85},31) or v.Name == _d({85,70,77,70},31) or v.Name == _d({53,70,77,70,81,80,83,85},31)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,39,74,83,74,79,72,1,85,70,77,70,81,80,83,85,1,83,70,78,80,85,70,27,1},31) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,36,80,86,77,69,1,79,80,85,1,71,74,79,69,1,51,70,78,80,85,70,38,87,70,79,85,1,74,79,1,79,74,77,15,1,49,83,74,79,85,74,79,72,1,66,77,77,1,51,70,78,80,85,70,38,87,70,79,85,84,1,74,79,1,79,74,77,27},31))
for _,v in next, getnilinstances() do
if v:IsA(_d({51,70,78,80,85,70,38,87,70,79,85},31)) then
print(_d({1,14,1,47,66,78,70,27},31), v.Name)
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
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,72,66,78,70,1,86,79,74,87,70,83,84,70,2,1,52,68,83,74,81,85,1,74,84,1,80,79,77,90,1,71,80,83,1,40,49,48,15},31))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,52,68,83,74,81,85,1,70,89,70,68,86,85,74,80,79,1,67,77,80,68,76,70,69,1,80,79,27,1},31) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,53,70,77,70,81,80,83,85,74,79,72,1,85,80,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,15,15,15,1,49,77,70,66,84,70,1,88,66,74,85,15},31))
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,49,83,74,87,66,85,70,52,70,83,87,70,83,36,80,69,70,1,74,84,1,79,80,85,1,84,70,85,15,1,36,66,79,79,80,85,1,66,86,85,80,14,75,80,74,79,15},31))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,72,66,78,70,1,86,79,74,87,70,83,84,70,2,1,52,68,83,74,81,85,1,74,84,1,80,79,77,90,1,71,80,83,1,40,49,48,15},31))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({60,52,66,71,70,72,86,66,83,69,62,1,58,80,86,1,66,83,70,1,80,79,1,85,73,70,1,41,80,78,70,84,68,83,70,70,79,15,1,52,68,83,74,81,85,1,83,70,82,86,74,83,70,84,1,6,84,15},31), name or _d({66,1,84,81,70,68,74,71,74,68,1,81,77,66,68,70},31)))
if Safeguard.JoinPrivateServer() then
print(_d({60,52,66,71,70,72,86,66,83,69,62,1,53,70,77,70,81,80,83,85,74,79,72,1,85,80,1,49,83,74,87,66,85,70,1,52,70,83,87,70,83,15,15,15,1,49,77,70,66,84,70,1,88,66,74,85,15},31))
else
warn(_d({60,52,66,71,70,72,86,66,83,69,62,1,49,83,74,87,66,85,70,52,70,83,87,70,83,36,80,69,70,1,74,84,1,79,80,85,1,84,70,85,15,1,36,66,79,79,80,85,1,66,86,85,80,14,75,80,74,79,15},31))
end
return false
end
warn(string.format(_d({60,52,66,71,70,72,86,66,83,69,62,1,56,83,80,79,72,1,81,77,66,68,70,2,1,51,70,82,86,74,83,70,69,27,1,6,84,1,9,6,69,10,13,1,36,86,83,83,70,79,85,27,1,6,69},31), name or _d({54,79,76,79,80,88,79},31), placeId, game.PlaceId))
return false
end
return Safeguard
end)()