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
PrivateServerCode = _d({50,83,26,50,51,60,41,51,43,78},24),
TeleportLocation = _d({25,91,92,59,77,73},24)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({46,81,90,91,92,8,59,77,73,8,48,87,85,77,91,75,90,77,77,86,8,23,8,53,73,81,86,8,53,77,86,93},24),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({91,92,90,81,86,79},24) and code ~= "" then
print(string.format(_d({67,59,73,78,77,79,93,73,90,76,69,8,50,87,81,86,81,86,79,8,56,90,81,94,73,92,77,8,59,77,90,94,77,90,8,15,13,91,15,22,22,22},24), code))
task.spawn(function()
local rs = game:GetService(_d({58,77,88,84,81,75,73,92,77,76,59,92,87,90,73,79,77},24))
local reservedRemote = rs:WaitForChild(_d({45,94,77,86,92,91},24)):WaitForChild(_d({90,77,91,77,90,94,77,76},24))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({58,77,85,87,92,77,45,94,77,86,92},24)) and (v.Name == _d({58,77,85,87,92,77,45,94,77,86,92},24) or v.Name == _d({92,77,84,77},24) or v.Name == _d({60,77,84,77,88,87,90,92},24)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({67,59,73,78,77,79,93,73,90,76,69,8,46,81,90,81,86,79,8,92,77,84,77,88,87,90,92,8,90,77,85,87,92,77,34,8},24) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,43,87,93,84,76,8,86,87,92,8,78,81,86,76,8,58,77,85,87,92,77,45,94,77,86,92,8,81,86,8,86,81,84,22,8,56,90,81,86,92,81,86,79,8,73,84,84,8,58,77,85,87,92,77,45,94,77,86,92,91,8,81,86,8,86,81,84,34},24))
for _,v in next, getnilinstances() do
if v:IsA(_d({58,77,85,87,92,77,45,94,77,86,92},24)) then
print(_d({8,21,8,54,73,85,77,34},24), v.Name)
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
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,63,90,87,86,79,8,79,73,85,77,8,93,86,81,94,77,90,91,77,9,8,59,75,90,81,88,92,8,81,91,8,87,86,84,97,8,78,87,90,8,47,56,55,22},24))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,59,75,90,81,88,92,8,77,96,77,75,93,92,81,87,86,8,74,84,87,75,83,77,76,8,87,86,34,8},24) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({67,59,73,78,77,79,93,73,90,76,69,8,60,77,84,77,88,87,90,92,81,86,79,8,92,87,8,56,90,81,94,73,92,77,8,59,77,90,94,77,90,22,22,22,8,56,84,77,73,91,77,8,95,73,81,92,22},24))
else
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,56,90,81,94,73,92,77,59,77,90,94,77,90,43,87,76,77,8,81,91,8,86,87,92,8,91,77,92,22,8,43,73,86,86,87,92,8,73,93,92,87,21,82,87,81,86,22},24))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,63,90,87,86,79,8,79,73,85,77,8,93,86,81,94,77,90,91,77,9,8,59,75,90,81,88,92,8,81,91,8,87,86,84,97,8,78,87,90,8,47,56,55,22},24))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({67,59,73,78,77,79,93,73,90,76,69,8,65,87,93,8,73,90,77,8,87,86,8,92,80,77,8,48,87,85,77,91,75,90,77,77,86,22,8,59,75,90,81,88,92,8,90,77,89,93,81,90,77,91,8,13,91,22},24), name or _d({73,8,91,88,77,75,81,78,81,75,8,88,84,73,75,77},24)))
if Safeguard.JoinPrivateServer() then
print(_d({67,59,73,78,77,79,93,73,90,76,69,8,60,77,84,77,88,87,90,92,81,86,79,8,92,87,8,56,90,81,94,73,92,77,8,59,77,90,94,77,90,22,22,22,8,56,84,77,73,91,77,8,95,73,81,92,22},24))
else
warn(_d({67,59,73,78,77,79,93,73,90,76,69,8,56,90,81,94,73,92,77,59,77,90,94,77,90,43,87,76,77,8,81,91,8,86,87,92,8,91,77,92,22,8,43,73,86,86,87,92,8,73,93,92,87,21,82,87,81,86,22},24))
end
return false
end
warn(string.format(_d({67,59,73,78,77,79,93,73,90,76,69,8,63,90,87,86,79,8,88,84,73,75,77,9,8,58,77,89,93,81,90,77,76,34,8,13,91,8,16,13,76,17,20,8,43,93,90,90,77,86,92,34,8,13,76},24), name or _d({61,86,83,86,87,95,86},24), placeId, game.PlaceId))
return false
end
return Safeguard
end)()