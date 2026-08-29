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
PrivateServerCode = _d({16,49,248,16,17,26,7,17,9,44},58),
TeleportLocation = _d({247,57,58,25,43,39},58),
},
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({12,47,56,57,58,230,25,43,39,230,14,53,51,43,57,41,56,43,43,52,230,245,230,19,39,47,52,230,19,43,52,59},58),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({57,58,56,47,52,45},58) and code ~= "" then
print(string.format(_d({33,25,39,44,43,45,59,39,56,42,35,230,16,53,47,52,47,52,45,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,230,237,235,57,237,244,244,244},58), code))
task.spawn(function()
local rs = game:GetService(_d({24,43,54,50,47,41,39,58,43,42,25,58,53,56,39,45,43},58))
local reservedRemote = rs:WaitForChild(_d({11,60,43,52,58,57},58)):WaitForChild(_d({56,43,57,43,56,60,43,42},58))
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
v:IsA(_d({24,43,51,53,58,43,11,60,43,52,58},58)) and (v.Name == _d({24,43,51,53,58,43,11,60,43,52,58},58) or v.Name == _d({58,43,50,43},58) or v.Name == _d({26,43,50,43,54,53,56,58},58))
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
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,12,47,56,47,52,45,230,58,43,50,43,54,53,56,58,230,56,43,51,53,58,43,0,230},58) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,9,53,59,50,42,230,52,53,58,230,44,47,52,42,230,24,43,51,53,58,43,11,60,43,52,58,230,47,52,230,52,47,50,244,230,22,56,47,52,58,47,52,45,230,39,50,50,230,24,43,51,53,58,43,11,60,43,52,58,57,230,47,52,230,52,47,50,0},58))
for _, v in next, getnilinstances() do
if v:IsA(_d({24,43,51,53,58,43,11,60,43,52,58},58)) then
print(_d({230,243,230,20,39,51,43,0},58), v.Name)
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
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,45,39,51,43,230,59,52,47,60,43,56,57,43,231,230,25,41,56,47,54,58,230,47,57,230,53,52,50,63,230,44,53,56,230,13,22,21,244},58))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,25,41,56,47,54,58,230,43,62,43,41,59,58,47,53,52,230,40,50,53,41,49,43,42,230,53,52,0,230},58) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,26,43,50,43,54,53,56,58,47,52,45,230,58,53,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,244,244,244,230,22,50,43,39,57,43,230,61,39,47,58,244},58))
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,22,56,47,60,39,58,43,25,43,56,60,43,56,9,53,42,43,230,47,57,230,52,53,58,230,57,43,58,244,230,9,39,52,52,53,58,230,39,59,58,53,243,48,53,47,52,244},58))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,45,39,51,43,230,59,52,47,60,43,56,57,43,231,230,25,41,56,47,54,58,230,47,57,230,53,52,50,63,230,44,53,56,230,13,22,21,244},58))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({33,25,39,44,43,45,59,39,56,42,35,230,31,53,59,230,39,56,43,230,53,52,230,58,46,43,230,14,53,51,43,57,41,56,43,43,52,244,230,25,41,56,47,54,58,230,56,43,55,59,47,56,43,57,230,235,57,244},58), name or _d({39,230,57,54,43,41,47,44,47,41,230,54,50,39,41,43},58)))
if Safeguard.JoinPrivateServer() then
print(_d({33,25,39,44,43,45,59,39,56,42,35,230,26,43,50,43,54,53,56,58,47,52,45,230,58,53,230,22,56,47,60,39,58,43,230,25,43,56,60,43,56,244,244,244,230,22,50,43,39,57,43,230,61,39,47,58,244},58))
else
warn(_d({33,25,39,44,43,45,59,39,56,42,35,230,22,56,47,60,39,58,43,25,43,56,60,43,56,9,53,42,43,230,47,57,230,52,53,58,230,57,43,58,244,230,9,39,52,52,53,58,230,39,59,58,53,243,48,53,47,52,244},58))
end
return false
end
warn(
string.format(
_d({33,25,39,44,43,45,59,39,56,42,35,230,29,56,53,52,45,230,54,50,39,41,43,231,230,24,43,55,59,47,56,43,42,0,230,235,57,230,238,235,42,239,242,230,9,59,56,56,43,52,58,0,230,235,42},58),
name or _d({27,52,49,52,53,61,52},58),
placeId,
game.PlaceId
)
)
return false
end
return Safeguard
end)()