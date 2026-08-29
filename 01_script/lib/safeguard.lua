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
PrivateServerCode = _d({46,79,22,46,47,56,37,47,39,74},28),
TeleportLocation = _d({21,87,88,55,73,69},28)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({42,77,86,87,88,4,55,73,69,4,44,83,81,73,87,71,86,73,73,82,4,19,4,49,69,77,82,4,49,73,82,89},28),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({87,88,86,77,82,75},28) and code ~= "" then
print(string.format(_d({63,55,69,74,73,75,89,69,86,72,65,4,46,83,77,82,77,82,75,4,52,86,77,90,69,88,73,4,55,73,86,90,73,86,4,11,9,87,11,18,18,18},28), code))
task.spawn(function()
local rs = game:GetService(_d({54,73,84,80,77,71,69,88,73,72,55,88,83,86,69,75,73},28))
local reservedRemote = rs:WaitForChild(_d({41,90,73,82,88,87},28)):WaitForChild(_d({86,73,87,73,86,90,73,72},28))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({54,73,81,83,88,73,41,90,73,82,88},28)) and (v.Name == _d({54,73,81,83,88,73,41,90,73,82,88},28) or v.Name == _d({88,73,80,73},28) or v.Name == _d({56,73,80,73,84,83,86,88},28)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({63,55,69,74,73,75,89,69,86,72,65,4,42,77,86,77,82,75,4,88,73,80,73,84,83,86,88,4,86,73,81,83,88,73,30,4},28) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,39,83,89,80,72,4,82,83,88,4,74,77,82,72,4,54,73,81,83,88,73,41,90,73,82,88,4,77,82,4,82,77,80,18,4,52,86,77,82,88,77,82,75,4,69,80,80,4,54,73,81,83,88,73,41,90,73,82,88,87,4,77,82,4,82,77,80,30},28))
for _,v in next, getnilinstances() do
if v:IsA(_d({54,73,81,83,88,73,41,90,73,82,88},28)) then
print(_d({4,17,4,50,69,81,73,30},28), v.Name)
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
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,59,86,83,82,75,4,75,69,81,73,4,89,82,77,90,73,86,87,73,5,4,55,71,86,77,84,88,4,77,87,4,83,82,80,93,4,74,83,86,4,43,52,51,18},28))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,55,71,86,77,84,88,4,73,92,73,71,89,88,77,83,82,4,70,80,83,71,79,73,72,4,83,82,30,4},28) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({63,55,69,74,73,75,89,69,86,72,65,4,56,73,80,73,84,83,86,88,77,82,75,4,88,83,4,52,86,77,90,69,88,73,4,55,73,86,90,73,86,18,18,18,4,52,80,73,69,87,73,4,91,69,77,88,18},28))
else
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,52,86,77,90,69,88,73,55,73,86,90,73,86,39,83,72,73,4,77,87,4,82,83,88,4,87,73,88,18,4,39,69,82,82,83,88,4,69,89,88,83,17,78,83,77,82,18},28))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,59,86,83,82,75,4,75,69,81,73,4,89,82,77,90,73,86,87,73,5,4,55,71,86,77,84,88,4,77,87,4,83,82,80,93,4,74,83,86,4,43,52,51,18},28))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({63,55,69,74,73,75,89,69,86,72,65,4,61,83,89,4,69,86,73,4,83,82,4,88,76,73,4,44,83,81,73,87,71,86,73,73,82,18,4,55,71,86,77,84,88,4,86,73,85,89,77,86,73,87,4,9,87,18},28), name or _d({69,4,87,84,73,71,77,74,77,71,4,84,80,69,71,73},28)))
if Safeguard.JoinPrivateServer() then
print(_d({63,55,69,74,73,75,89,69,86,72,65,4,56,73,80,73,84,83,86,88,77,82,75,4,88,83,4,52,86,77,90,69,88,73,4,55,73,86,90,73,86,18,18,18,4,52,80,73,69,87,73,4,91,69,77,88,18},28))
else
warn(_d({63,55,69,74,73,75,89,69,86,72,65,4,52,86,77,90,69,88,73,55,73,86,90,73,86,39,83,72,73,4,77,87,4,82,83,88,4,87,73,88,18,4,39,69,82,82,83,88,4,69,89,88,83,17,78,83,77,82,18},28))
end
return false
end
warn(string.format(_d({63,55,69,74,73,75,89,69,86,72,65,4,59,86,83,82,75,4,84,80,69,71,73,5,4,54,73,85,89,77,86,73,72,30,4,9,87,4,12,9,72,13,16,4,39,89,86,86,73,82,88,30,4,9,72},28), name or _d({57,82,79,82,83,91,82},28), placeId, game.PlaceId))
return false
end
return Safeguard
end)()