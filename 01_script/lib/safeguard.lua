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
PrivateServerCode = _d({51,84,27,51,52,61,42,52,44,79},23),
TeleportLocation = _d({26,92,93,60,78,74},23)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({47,82,91,92,93,9,60,78,74,9,49,88,86,78,92,76,91,78,78,87,9,24,9,54,74,82,87,9,54,78,87,94},23),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({92,93,91,82,87,80},23) and code ~= "" then
print(string.format(_d({68,60,74,79,78,80,94,74,91,77,70,9,51,88,82,87,82,87,80,9,57,91,82,95,74,93,78,9,60,78,91,95,78,91,9,16,14,92,16,23,23,23},23), code))
task.spawn(function()
local rs = game:GetService(_d({59,78,89,85,82,76,74,93,78,77,60,93,88,91,74,80,78},23))
local reservedRemote = rs:WaitForChild(_d({46,95,78,87,93,92},23)):WaitForChild(_d({91,78,92,78,91,95,78,77},23))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({59,78,86,88,93,78,46,95,78,87,93},23)) and (v.Name == _d({59,78,86,88,93,78,46,95,78,87,93},23) or v.Name == _d({93,78,85,78},23) or v.Name == _d({61,78,85,78,89,88,91,93},23)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({68,60,74,79,78,80,94,74,91,77,70,9,47,82,91,82,87,80,9,93,78,85,78,89,88,91,93,9,91,78,86,88,93,78,35,9},23) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,44,88,94,85,77,9,87,88,93,9,79,82,87,77,9,59,78,86,88,93,78,46,95,78,87,93,9,82,87,9,87,82,85,23,9,57,91,82,87,93,82,87,80,9,74,85,85,9,59,78,86,88,93,78,46,95,78,87,93,92,9,82,87,9,87,82,85,35},23))
for _,v in next, getnilinstances() do
if v:IsA(_d({59,78,86,88,93,78,46,95,78,87,93},23)) then
print(_d({9,22,9,55,74,86,78,35},23), v.Name)
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
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,64,91,88,87,80,9,80,74,86,78,9,94,87,82,95,78,91,92,78,10,9,60,76,91,82,89,93,9,82,92,9,88,87,85,98,9,79,88,91,9,48,57,56,23},23))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,60,76,91,82,89,93,9,78,97,78,76,94,93,82,88,87,9,75,85,88,76,84,78,77,9,88,87,35,9},23) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({68,60,74,79,78,80,94,74,91,77,70,9,61,78,85,78,89,88,91,93,82,87,80,9,93,88,9,57,91,82,95,74,93,78,9,60,78,91,95,78,91,23,23,23,9,57,85,78,74,92,78,9,96,74,82,93,23},23))
else
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,57,91,82,95,74,93,78,60,78,91,95,78,91,44,88,77,78,9,82,92,9,87,88,93,9,92,78,93,23,9,44,74,87,87,88,93,9,74,94,93,88,22,83,88,82,87,23},23))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,64,91,88,87,80,9,80,74,86,78,9,94,87,82,95,78,91,92,78,10,9,60,76,91,82,89,93,9,82,92,9,88,87,85,98,9,79,88,91,9,48,57,56,23},23))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({68,60,74,79,78,80,94,74,91,77,70,9,66,88,94,9,74,91,78,9,88,87,9,93,81,78,9,49,88,86,78,92,76,91,78,78,87,23,9,60,76,91,82,89,93,9,91,78,90,94,82,91,78,92,9,14,92,23},23), name or _d({74,9,92,89,78,76,82,79,82,76,9,89,85,74,76,78},23)))
if Safeguard.JoinPrivateServer() then
print(_d({68,60,74,79,78,80,94,74,91,77,70,9,61,78,85,78,89,88,91,93,82,87,80,9,93,88,9,57,91,82,95,74,93,78,9,60,78,91,95,78,91,23,23,23,9,57,85,78,74,92,78,9,96,74,82,93,23},23))
else
warn(_d({68,60,74,79,78,80,94,74,91,77,70,9,57,91,82,95,74,93,78,60,78,91,95,78,91,44,88,77,78,9,82,92,9,87,88,93,9,92,78,93,23,9,44,74,87,87,88,93,9,74,94,93,88,22,83,88,82,87,23},23))
end
return false
end
warn(string.format(_d({68,60,74,79,78,80,94,74,91,77,70,9,64,91,88,87,80,9,89,85,74,76,78,10,9,59,78,90,94,82,91,78,77,35,9,14,92,9,17,14,77,18,21,9,44,94,91,91,78,87,93,35,9,14,77},23), name or _d({62,87,84,87,88,96,87},23), placeId, game.PlaceId))
return false
end
return Safeguard
end)()