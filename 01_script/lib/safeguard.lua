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
PrivateServerCode = _d({56,89,32,56,57,66,47,57,49,84},18),
TeleportLocation = _d({31,97,98,65,83,79},18)
}
}
local GPO_UNIVERSE_ID = 648454481
local BANNED_PLACES = {
[1730877806] = _d({52,87,96,97,98,14,65,83,79,14,54,93,91,83,97,81,96,83,83,92,14,29,14,59,79,87,92,14,59,83,92,99},18),
}
function Safeguard.JoinPrivateServer()
local code = Safeguard.Config.PrivateServerCode
if type(code) == _d({97,98,96,87,92,85},18) and code ~= "" then
print(string.format(_d({73,65,79,84,83,85,99,79,96,82,75,14,56,93,87,92,87,92,85,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,14,21,19,97,21,28,28,28},18), code))
task.spawn(function()
local rs = game:GetService(_d({64,83,94,90,87,81,79,98,83,82,65,98,93,96,79,85,83},18))
local reservedRemote = rs:WaitForChild(_d({51,100,83,92,98,97},18)):WaitForChild(_d({96,83,97,83,96,100,83,82},18))
task.spawn(function()
pcall(function() reservedRemote:InvokeServer(code) end)
end)
local teleRemote = nil
for i = 1, 20 do
task.wait(0.5)
for _,v in next, getnilinstances() do
if v:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) and (v.Name == _d({64,83,91,93,98,83,51,100,83,92,98},18) or v.Name == _d({98,83,90,83},18) or v.Name == _d({66,83,90,83,94,93,96,98},18)) then
teleRemote = v
break
end
end
if teleRemote then break end
end
if teleRemote then
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,52,87,96,87,92,85,14,98,83,90,83,94,93,96,98,14,96,83,91,93,98,83,40,14},18) .. teleRemote.Name)
teleRemote:FireServer(true)
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,49,93,99,90,82,14,92,93,98,14,84,87,92,82,14,64,83,91,93,98,83,51,100,83,92,98,14,87,92,14,92,87,90,28,14,62,96,87,92,98,87,92,85,14,79,90,90,14,64,83,91,93,98,83,51,100,83,92,98,97,14,87,92,14,92,87,90,40},18))
for _,v in next, getnilinstances() do
if v:IsA(_d({64,83,91,93,98,83,51,100,83,92,98},18)) then
print(_d({14,27,14,60,79,91,83,40},18), v.Name)
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
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,85,79,91,83,14,99,92,87,100,83,96,97,83,15,14,65,81,96,87,94,98,14,87,97,14,93,92,90,103,14,84,93,96,14,53,62,61,28},18))
return false
end
if BANNED_PLACES[game.PlaceId] then
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,65,81,96,87,94,98,14,83,102,83,81,99,98,87,93,92,14,80,90,93,81,89,83,82,14,93,92,40,14},18) .. BANNED_PLACES[game.PlaceId])
if Safeguard.JoinPrivateServer() then
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,66,83,90,83,94,93,96,98,87,92,85,14,98,93,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,28,28,28,14,62,90,83,79,97,83,14,101,79,87,98,28},18))
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,62,96,87,100,79,98,83,65,83,96,100,83,96,49,93,82,83,14,87,97,14,92,93,98,14,97,83,98,28,14,49,79,92,92,93,98,14,79,99,98,93,27,88,93,87,92,28},18))
end
return false
end
return true
end
function Safeguard.RequirePlace(placeId, name)
if game.GameId ~= GPO_UNIVERSE_ID then
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,85,79,91,83,14,99,92,87,100,83,96,97,83,15,14,65,81,96,87,94,98,14,87,97,14,93,92,90,103,14,84,93,96,14,53,62,61,28},18))
return false
end
if game.PlaceId == placeId then
return true
end
if BANNED_PLACES[game.PlaceId] then
warn(string.format(_d({73,65,79,84,83,85,99,79,96,82,75,14,71,93,99,14,79,96,83,14,93,92,14,98,86,83,14,54,93,91,83,97,81,96,83,83,92,28,14,65,81,96,87,94,98,14,96,83,95,99,87,96,83,97,14,19,97,28},18), name or _d({79,14,97,94,83,81,87,84,87,81,14,94,90,79,81,83},18)))
if Safeguard.JoinPrivateServer() then
print(_d({73,65,79,84,83,85,99,79,96,82,75,14,66,83,90,83,94,93,96,98,87,92,85,14,98,93,14,62,96,87,100,79,98,83,14,65,83,96,100,83,96,28,28,28,14,62,90,83,79,97,83,14,101,79,87,98,28},18))
else
warn(_d({73,65,79,84,83,85,99,79,96,82,75,14,62,96,87,100,79,98,83,65,83,96,100,83,96,49,93,82,83,14,87,97,14,92,93,98,14,97,83,98,28,14,49,79,92,92,93,98,14,79,99,98,93,27,88,93,87,92,28},18))
end
return false
end
warn(string.format(_d({73,65,79,84,83,85,99,79,96,82,75,14,69,96,93,92,85,14,94,90,79,81,83,15,14,64,83,95,99,87,96,83,82,40,14,19,97,14,22,19,82,23,26,14,49,99,96,96,83,92,98,40,14,19,82},18), name or _d({67,92,89,92,93,101,92},18), placeId, game.PlaceId))
return false
end
return Safeguard
end)()