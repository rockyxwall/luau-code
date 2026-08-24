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
PrivateServerCode = _d({37,70,13,37,38,47,28,38,30,65},37),
TeleportLocation = _d({12,78,79,46,64,60},37)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({33,68,77,78,79,251,46,64,60,251,35,74,72,64,78,62,77,64,64,73,251,10,251,40,60,68,73,251,40,64,73,80},37),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({78,79,77,68,73,66},37) and code ~= "" then
print(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,37,74,68,73,68,73,66,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,251,2,0,78,2,9,9,9},37), code))
task.spawn(function()
local rs = game:GetService(_d({45,64,75,71,68,62,60,79,64,63,46,79,74,77,60,66,64},37))
local reservedRemote = rs:WaitForChild(_d({32,81,64,73,79,78},37)):WaitForChild(_d({77,64,78,64,77,81,64,63},37))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) and (v.Name == _d({45,64,72,74,79,64,32,81,64,73,79},37) or v.Name == _d({79,64,71,64},37) or v.Name == _d({47,64,71,64,75,74,77,79},37)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,33,68,77,68,73,66,251,79,64,71,64,75,74,77,79,251,77,64,72,74,79,64,21,251},37) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,30,74,80,71,63,251,73,74,79,251,65,68,73,63,251,45,64,72,74,79,64,32,81,64,73,79,251,68,73,251,73,68,71,9,251,43,77,68,73,79,68,73,66,251,60,71,71,251,45,64,72,74,79,64,32,81,64,73,79,78,251,68,73,251,73,68,71,21},37))
for _,v in next, getnilinstances() do
if v:IsA(_d({45,64,72,74,79,64,32,81,64,73,79},37)) then
print(_d({251,8,251,41,60,72,64,21},37), v.Name)
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
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,46,62,77,68,75,79,251,64,83,64,62,80,79,68,74,73,251,61,71,74,62,70,64,63,251,74,73,21,251},37) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,66,60,72,64,251,80,73,68,81,64,77,78,64,252,251,46,62,77,68,75,79,251,68,78,251,74,73,71,84,251,65,74,77,251,34,43,42,9},37))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,52,74,80,251,60,77,64,251,74,73,251,79,67,64,251,35,74,72,64,78,62,77,64,64,73,9,251,46,62,77,68,75,79,251,77,64,76,80,68,77,64,78,251,0,78,9},37), name or _d({60,251,78,75,64,62,68,65,68,62,251,75,71,60,62,64},37)))
if Safeguard.JoinPrivateServer() then
print(_d({54,46,60,65,64,66,80,60,77,63,56,251,47,64,71,64,75,74,77,79,68,73,66,251,79,74,251,43,77,68,81,60,79,64,251,46,64,77,81,64,77,9,9,9,251,43,71,64,60,78,64,251,82,60,68,79,9},37))
else
warn(_d({54,46,60,65,64,66,80,60,77,63,56,251,43,77,68,81,60,79,64,46,64,77,81,64,77,30,74,63,64,251,68,78,251,73,74,79,251,78,64,79,9,251,30,60,73,73,74,79,251,60,80,79,74,8,69,74,68,73,9},37))
end
return false
end
warn(string.format(_d({54,46,60,65,64,66,80,60,77,63,56,251,50,77,74,73,66,251,75,71,60,62,64,252,251,45,64,76,80,68,77,64,63,21,251,0,78,251,3,0,63,4,7,251,30,80,77,77,64,73,79,21,251,0,63},37), name or _d({48,73,70,73,74,82,73},37), placeId, game.PlaceId))
return false
end
return Safeguard
end)()