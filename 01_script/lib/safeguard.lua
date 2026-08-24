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
PrivateServerCode = _d({12,45,244,12,13,22,3,13,5,40},62),
TeleportLocation = _d({243,53,54,21,39,35},62)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({8,43,52,53,54,226,21,39,35,226,10,49,47,39,53,37,52,39,39,48,226,241,226,15,35,43,48,226,15,39,48,55},62),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({53,54,52,43,48,41},62) and code ~= "" then
print(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,12,49,43,48,43,48,41,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,226,233,231,53,233,240,240,240},62), code))
task.spawn(function()
local rs = game:GetService(_d({20,39,50,46,43,37,35,54,39,38,21,54,49,52,35,41,39},62))
local reservedRemote = rs:WaitForChild(_d({7,56,39,48,54,53},62)):WaitForChild(_d({52,39,53,39,52,56,39,38},62))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({20,39,47,49,54,39,7,56,39,48,54},62)) and (v.Name == _d({20,39,47,49,54,39,7,56,39,48,54},62) or v.Name == _d({54,39,46,39},62) or v.Name == _d({22,39,46,39,50,49,52,54},62)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,8,43,52,43,48,41,226,54,39,46,39,50,49,52,54,226,52,39,47,49,54,39,252,226},62) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,5,49,55,46,38,226,48,49,54,226,40,43,48,38,226,20,39,47,49,54,39,7,56,39,48,54,226,43,48,226,48,43,46,240,226,18,52,43,48,54,43,48,41,226,35,46,46,226,20,39,47,49,54,39,7,56,39,48,54,53,226,43,48,226,48,43,46,252},62))
for _,v in next, getnilinstances() do
if v:IsA(_d({20,39,47,49,54,39,7,56,39,48,54},62)) then
print(_d({226,239,226,16,35,47,39,252},62), v.Name)
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
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,41,35,47,39,226,55,48,43,56,39,52,53,39,227,226,21,37,52,43,50,54,226,43,53,226,49,48,46,59,226,40,49,52,226,9,18,17,240},62))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,21,37,52,43,50,54,226,39,58,39,37,55,54,43,49,48,226,36,46,49,37,45,39,38,226,49,48,252,226},62) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,22,39,46,39,50,49,52,54,43,48,41,226,54,49,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,240,240,240,226,18,46,39,35,53,39,226,57,35,43,54,240},62))
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,18,52,43,56,35,54,39,21,39,52,56,39,52,5,49,38,39,226,43,53,226,48,49,54,226,53,39,54,240,226,5,35,48,48,49,54,226,35,55,54,49,239,44,49,43,48,240},62))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,41,35,47,39,226,55,48,43,56,39,52,53,39,227,226,21,37,52,43,50,54,226,43,53,226,49,48,46,59,226,40,49,52,226,9,18,17,240},62))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,27,49,55,226,35,52,39,226,49,48,226,54,42,39,226,10,49,47,39,53,37,52,39,39,48,240,226,21,37,52,43,50,54,226,52,39,51,55,43,52,39,53,226,231,53,240},62), name or _d({35,226,53,50,39,37,43,40,43,37,226,50,46,35,37,39},62)))
if Safeguard.JoinPrivateServer() then
print(_d({29,21,35,40,39,41,55,35,52,38,31,226,22,39,46,39,50,49,52,54,43,48,41,226,54,49,226,18,52,43,56,35,54,39,226,21,39,52,56,39,52,240,240,240,226,18,46,39,35,53,39,226,57,35,43,54,240},62))
else
warn(_d({29,21,35,40,39,41,55,35,52,38,31,226,18,52,43,56,35,54,39,21,39,52,56,39,52,5,49,38,39,226,43,53,226,48,49,54,226,53,39,54,240,226,5,35,48,48,49,54,226,35,55,54,49,239,44,49,43,48,240},62))
end
return false
end
warn(string.format(_d({29,21,35,40,39,41,55,35,52,38,31,226,25,52,49,48,41,226,50,46,35,37,39,227,226,20,39,51,55,43,52,39,38,252,226,231,53,226,234,231,38,235,238,226,5,55,52,52,39,48,54,252,226,231,38},62), name or _d({23,48,45,48,49,57,48},62), placeId, game.PlaceId))
return false
end
return Safeguard
end)()