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
PrivateServerCode = _d({58,91,34,58,59,68,49,59,51,86},16),
TeleportLocation = _d({33,99,100,67,85,81},16)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({54,89,98,99,100,16,67,85,81,16,56,95,93,85,99,83,98,85,85,94,16,31,16,61,81,89,94,16,61,85,94,101},16),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({99,100,98,89,94,87},16) and code ~= "" then
print(string.format(_d({75,67,81,86,85,87,101,81,98,84,77,16,58,95,89,94,89,94,87,16,64,98,89,102,81,100,85,16,67,85,98,102,85,98,16,23,21,99,23,30,30,30},16), code))
task.spawn(function()
local rs = game:GetService(_d({66,85,96,92,89,83,81,100,85,84,67,100,95,98,81,87,85},16))
local reservedRemote = rs:WaitForChild(_d({53,102,85,94,100,99},16)):WaitForChild(_d({98,85,99,85,98,102,85,84},16))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({66,85,93,95,100,85,53,102,85,94,100},16)) and (v.Name == _d({66,85,93,95,100,85,53,102,85,94,100},16) or v.Name == _d({100,85,92,85},16) or v.Name == _d({68,85,92,85,96,95,98,100},16)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({75,67,81,86,85,87,101,81,98,84,77,16,54,89,98,89,94,87,16,100,85,92,85,96,95,98,100,16,98,85,93,95,100,85,42,16},16) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,51,95,101,92,84,16,94,95,100,16,86,89,94,84,16,66,85,93,95,100,85,53,102,85,94,100,16,89,94,16,94,89,92,30,16,64,98,89,94,100,89,94,87,16,81,92,92,16,66,85,93,95,100,85,53,102,85,94,100,99,16,89,94,16,94,89,92,42},16))
for _,v in next, getnilinstances() do
if v:IsA(_d({66,85,93,95,100,85,53,102,85,94,100},16)) then
print(_d({16,29,16,62,81,93,85,42},16), v.Name)
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
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,71,98,95,94,87,16,87,81,93,85,16,101,94,89,102,85,98,99,85,17,16,67,83,98,89,96,100,16,89,99,16,95,94,92,105,16,86,95,98,16,55,64,63,30},16))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,67,83,98,89,96,100,16,85,104,85,83,101,100,89,95,94,16,82,92,95,83,91,85,84,16,95,94,42,16},16) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({75,67,81,86,85,87,101,81,98,84,77,16,68,85,92,85,96,95,98,100,89,94,87,16,100,95,16,64,98,89,102,81,100,85,16,67,85,98,102,85,98,30,30,30,16,64,92,85,81,99,85,16,103,81,89,100,30},16))
else
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,64,98,89,102,81,100,85,67,85,98,102,85,98,51,95,84,85,16,89,99,16,94,95,100,16,99,85,100,30,16,51,81,94,94,95,100,16,81,101,100,95,29,90,95,89,94,30},16))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,71,98,95,94,87,16,87,81,93,85,16,101,94,89,102,85,98,99,85,17,16,67,83,98,89,96,100,16,89,99,16,95,94,92,105,16,86,95,98,16,55,64,63,30},16))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({75,67,81,86,85,87,101,81,98,84,77,16,73,95,101,16,81,98,85,16,95,94,16,100,88,85,16,56,95,93,85,99,83,98,85,85,94,30,16,67,83,98,89,96,100,16,98,85,97,101,89,98,85,99,16,21,99,30},16), name or _d({81,16,99,96,85,83,89,86,89,83,16,96,92,81,83,85},16)))
if Safeguard.JoinPrivateServer() then
print(_d({75,67,81,86,85,87,101,81,98,84,77,16,68,85,92,85,96,95,98,100,89,94,87,16,100,95,16,64,98,89,102,81,100,85,16,67,85,98,102,85,98,30,30,30,16,64,92,85,81,99,85,16,103,81,89,100,30},16))
else
warn(_d({75,67,81,86,85,87,101,81,98,84,77,16,64,98,89,102,81,100,85,67,85,98,102,85,98,51,95,84,85,16,89,99,16,94,95,100,16,99,85,100,30,16,51,81,94,94,95,100,16,81,101,100,95,29,90,95,89,94,30},16))
end
return false
end
warn(string.format(_d({75,67,81,86,85,87,101,81,98,84,77,16,71,98,95,94,87,16,96,92,81,83,85,17,16,66,85,97,101,89,98,85,84,42,16,21,99,16,24,21,84,25,28,16,51,101,98,98,85,94,100,42,16,21,84},16), name or _d({69,94,91,94,95,103,94},16), placeId, game.PlaceId))
return false
end
return Safeguard
end)()